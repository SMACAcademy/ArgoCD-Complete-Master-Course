
# Setting Up a Sample Helm Repository on GitHub

## 1. Create a New GitHub Repository
- Go to [GitHub](https://github.com/) and create a new repository named `my-helm-repo`.
- Initialize it with a README for documentation.

## 2. Package Your Helm Chart
- Use the Helm CLI to package your chart:
  ```shell
  helm package my-chart/
  ```

## 3. Clone Your GitHub Repository
- Clone the repository to your local machine:
  ```shell
  git clone https://github.com/your-username/my-helm-repo.git
  ```

## 4. Add Your Chart to the Repository
- Move the packaged chart to the repository directory:
  ```shell
  mv my-chart-0.1.0.tgz my-helm-repo/
  ```

## 5. Create an Index File
- Generate an `index.yaml` file:
  ```shell
  helm repo index . --url https://github.com/SMACAcademy/sample_helm_repo
  ```

## 6. Push Changes to GitHub
- Commit and push the changes:
  ```shell
  cd my-helm-repo/
  git add .
  git commit -m "Add my-chart"
  git push origin main
  ```

## 7. Enable GitHub Pages
- Set up GitHub Pages in your repository settings to publish from the `main` branch.

## 8. Add Your Helm Repository
- Add the repository to Helm:
  ```shell
  helm repo add sample_helm_repo https://github.com/SMACAcademy/sample_helm_repo
  ```

## 9. Install Chart from Your Repository
- Install charts using Helm:
  ```shell
  helm install my-release my-helm-repo/my-chart
  ```

## Notes
- Replace placeholders like `my-chart`, `my-helm-repo`, and `your-username` accordingly.
- This setup is ideal for small-scale or personal projects.

**Disclaimer**: This is a basic guide, and additional configurations may be required based on specific needs.
