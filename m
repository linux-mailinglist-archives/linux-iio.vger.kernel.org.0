Return-Path: <linux-iio+bounces-1648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80FB82D182
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E4E1F2150F
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5DF5384;
	Sun, 14 Jan 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onqKFgYS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32106538B;
	Sun, 14 Jan 2024 16:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47095C433F1;
	Sun, 14 Jan 2024 16:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705251260;
	bh=ByQ1wz0BzDgc8cWxsG6CqiN3dkI10323kafU/vw5Pe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=onqKFgYScJYLG51yCoQ6f6ILOH3pZqqDKusTv8aGyaxzFmQYha2Xslnc30ww950D8
	 4cZKeJwB8KwmlvSafMYSDNd+fqrahm6NbukaKI/bRsiMQYm/AWAjEd+ML+sI1z9u7V
	 Svy0ZDGIdhsVSUzlGainBHL/JPOs/2AHLzT8AESeZ4HKqpQVcxmSFsdPM4Onf1AdlO
	 LS18ei/23hvOrl3Ca/QE61P3aiHcbx1psZ/Cbsu7i9R/L0VOSsY30owKqRCMIzyrVk
	 XpzbVpKg82taOj4CGIWdwV6uBw0OJpAKKRIrRhtuiURZBb/6Knhm1Nm2NNAf8uC7Oj
	 /V4rJz9JTDAyg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/4] of: unittest: Use __free(device_node)
Date: Sun, 14 Jan 2024 16:53:56 +0000
Message-ID: <20240114165358.119916-3-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114165358.119916-1-jic23@kernel.org>
References: <20240114165358.119916-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A simple example of the utility of this autocleanup approach to
handling of_node_put()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/of/unittest.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e9e90e96600e..b6d9edb831f0 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -233,27 +233,23 @@ static void __init of_unittest_dynamic(void)
 
 static int __init of_unittest_check_node_linkage(struct device_node *np)
 {
-	struct device_node *child;
+	struct device_node *child __free(device_node) = NULL;
 	int count = 0, rc;
 
 	for_each_child_of_node(np, child) {
 		if (child->parent != np) {
 			pr_err("Child node %pOFn links to wrong parent %pOFn\n",
 				 child, np);
-			rc = -EINVAL;
-			goto put_child;
+			return -EINVAL;
 		}
 
 		rc = of_unittest_check_node_linkage(child);
 		if (rc < 0)
-			goto put_child;
+			return rc;
 		count += rc;
 	}
 
 	return count + 1;
-put_child:
-	of_node_put(child);
-	return rc;
 }
 
 static void __init of_unittest_check_tree_linkage(void)
-- 
2.43.0


