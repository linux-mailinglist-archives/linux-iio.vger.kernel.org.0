Return-Path: <linux-iio+bounces-21505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 981EAAFFBBA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 10:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F753A6AE5
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 08:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B028BA98;
	Thu, 10 Jul 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ/2Kcpq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DA228B50A;
	Thu, 10 Jul 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134791; cv=none; b=LOJOhLnODekMVWjpeLPtTNsLaKgRrMkx9APZDx10QQuMQrOdL3KGKm6IS4YMDz5GE0uI5EKixjCaB4duzWa+i814+0Dajbc8xwX94cOgLsclOGDttB/4AzFmCJuyngA+2HNA9kQYeK1vCUofEQV7d74bDBX2ZoFeLqdWGFQcfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134791; c=relaxed/simple;
	bh=tyuq3hwCRSgt2JKMB5Ao+hcQq+13/0Loc0oxGsCOY0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cyKTKOS2lA+v8SSjFdtl+9P2WtNqnPkXcgv8NrYCsYtg/Qo0z//r8rKCA7gK16pV/HgCpRxvR1uWKZIIMuGnNvfuP3H7SOnazcr14TQT+33PJt7XWFw0MMz9gjtN4ERCDCO+vmAkE8OqfFfdo/fHjy4f2Hqka3b0hks83N0oM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ/2Kcpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE32AC4CEF5;
	Thu, 10 Jul 2025 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134790;
	bh=tyuq3hwCRSgt2JKMB5Ao+hcQq+13/0Loc0oxGsCOY0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UZ/2KcpqalDxdI8hG6ROVnnlKOt2KFNDUzvFVZDXeOrqnHv7mChslNyYE1Kd8IKCQ
	 KQY5rtmfYhi0JZyik8BXYgTctqRh0iQqlnOq9sYWvR3R1QLGPdpM50l4SLUgU6Cr93
	 ykqfGWuhC88QJ0U4lOTQ+H5fSYoG2UPFCeDwE1LQv60+eMKby1mmWe3ZGKVjUOfq72
	 n/kAuaFUwRVZFphHPdtq9FwGCkhc4cGssmVk12qcEOMB307A3QytBPxHFRtG48JHQZ
	 yo9v/6drcaQX2Wr7D4rFL5CwMqj6EkNl+waYRlRMndfn8AasNjRouTwmzdsm06WEgs
	 J3NvGOsWRXTMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7ABC83F09;
	Thu, 10 Jul 2025 08:06:30 +0000 (UTC)
From: Yassine Oudjana via B4 Relay <devnull+y.oudjana.protonmail.com@kernel.org>
Date: Thu, 10 Jul 2025 09:06:27 +0100
Subject: [PATCH v2 1/4] net: qrtr: smd: Rename qdev to qsdev
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-qcom-smgr-v2-1-f6e198b7aa8e@protonmail.com>
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
In-Reply-To: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yassine Oudjana <y.oudjana@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752134788; l=3304;
 i=y.oudjana@protonmail.com; s=20250710; h=from:subject:message-id;
 bh=NBj3Fu0MTFrWqXINim9NdBsnVOSNt9LjsMdF6y3k4Cg=;
 b=xjYXoOZOKB6m4nE87FAlppiLSPFtZkvYgwYdCoQH+m5AJ/1bfveSL4L0Z07eUL5vjOoa+Qies
 wG+oJ4uUrevDs5nCbxZ/VuWESwQ3SwRzIiOSpRB3YD5IYnEwwo4/j4W
X-Developer-Key: i=y.oudjana@protonmail.com; a=ed25519;
 pk=kZKEHR1e5QKCbhElU9LF/T1SbfTr8xzy2cO8fN70QgY=
X-Endpoint-Received: by B4 Relay for y.oudjana@protonmail.com/20250710 with
 auth_id=455
X-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
Reply-To: y.oudjana@protonmail.com

From: Yassine Oudjana <y.oudjana@protonmail.com>

In preparation to turn QRTR into a bus, rename replace all current
occurences of qdev in smd.c with qsdev in order to distinguish between the
to-be-added QRTR device which represents a QRTR service with the existing
QRTR SMD device which represents the endpoint through which services are
provided.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 net/qrtr/smd.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/qrtr/smd.c b/net/qrtr/smd.c
index c91bf030fbc7d973a90a1f88e90e66df42ab2bdd..940ee9349a9ce7438a01dd193c5c1d61c7b82ffd 100644
--- a/net/qrtr/smd.c
+++ b/net/qrtr/smd.c
@@ -20,15 +20,15 @@ struct qrtr_smd_dev {
 static int qcom_smd_qrtr_callback(struct rpmsg_device *rpdev,
 				  void *data, int len, void *priv, u32 addr)
 {
-	struct qrtr_smd_dev *qdev = dev_get_drvdata(&rpdev->dev);
+	struct qrtr_smd_dev *qsdev = dev_get_drvdata(&rpdev->dev);
 	int rc;
 
-	if (!qdev)
+	if (!qsdev)
 		return -EAGAIN;
 
-	rc = qrtr_endpoint_post(&qdev->ep, data, len);
+	rc = qrtr_endpoint_post(&qsdev->ep, data, len);
 	if (rc == -EINVAL) {
-		dev_err(qdev->dev, "invalid ipcrouter packet\n");
+		dev_err(qsdev->dev, "invalid ipcrouter packet\n");
 		/* return 0 to let smd drop the packet */
 		rc = 0;
 	}
@@ -39,14 +39,14 @@ static int qcom_smd_qrtr_callback(struct rpmsg_device *rpdev,
 /* from qrtr to smd */
 static int qcom_smd_qrtr_send(struct qrtr_endpoint *ep, struct sk_buff *skb)
 {
-	struct qrtr_smd_dev *qdev = container_of(ep, struct qrtr_smd_dev, ep);
+	struct qrtr_smd_dev *qsdev = container_of(ep, struct qrtr_smd_dev, ep);
 	int rc;
 
 	rc = skb_linearize(skb);
 	if (rc)
 		goto out;
 
-	rc = rpmsg_send(qdev->channel, skb->data, skb->len);
+	rc = rpmsg_send(qsdev->channel, skb->data, skb->len);
 
 out:
 	if (rc)
@@ -58,22 +58,24 @@ static int qcom_smd_qrtr_send(struct qrtr_endpoint *ep, struct sk_buff *skb)
 
 static int qcom_smd_qrtr_probe(struct rpmsg_device *rpdev)
 {
-	struct qrtr_smd_dev *qdev;
+	struct qrtr_smd_dev *qsdev;
 	int rc;
 
-	qdev = devm_kzalloc(&rpdev->dev, sizeof(*qdev), GFP_KERNEL);
-	if (!qdev)
+	qsdev = devm_kzalloc(&rpdev->dev, sizeof(*qsdev), GFP_KERNEL);
+	if (!qsdev)
 		return -ENOMEM;
 
-	qdev->channel = rpdev->ept;
-	qdev->dev = &rpdev->dev;
-	qdev->ep.xmit = qcom_smd_qrtr_send;
+	qsdev->channel = rpdev->ept;
+	qsdev->dev = &rpdev->dev;
+	qsdev->ep.xmit = qcom_smd_qrtr_send;
+	qsdev->ep.add_device = qcom_smd_qrtr_add_device;
+	qsdev->ep.del_device = qcom_smd_qrtr_del_device;
 
-	rc = qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
+	rc = qrtr_endpoint_register(&qsdev->ep, QRTR_EP_NID_AUTO);
 	if (rc)
 		return rc;
 
-	dev_set_drvdata(&rpdev->dev, qdev);
+	dev_set_drvdata(&rpdev->dev, qsdev);
 
 	dev_dbg(&rpdev->dev, "Qualcomm SMD QRTR driver probed\n");
 
@@ -82,9 +84,9 @@ static int qcom_smd_qrtr_probe(struct rpmsg_device *rpdev)
 
 static void qcom_smd_qrtr_remove(struct rpmsg_device *rpdev)
 {
-	struct qrtr_smd_dev *qdev = dev_get_drvdata(&rpdev->dev);
+	struct qrtr_smd_dev *qsdev = dev_get_drvdata(&rpdev->dev);
 
-	qrtr_endpoint_unregister(&qdev->ep);
+	qrtr_endpoint_unregister(&qsdev->ep);
 
 	dev_set_drvdata(&rpdev->dev, NULL);
 }

-- 
2.50.0



