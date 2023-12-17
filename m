Return-Path: <linux-iio+bounces-1035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139678161A7
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 19:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9CA282F6C
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF6647F61;
	Sun, 17 Dec 2023 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srB8aVP2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143B46445;
	Sun, 17 Dec 2023 18:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F37C433CA;
	Sun, 17 Dec 2023 18:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702838840;
	bh=ByQ1wz0BzDgc8cWxsG6CqiN3dkI10323kafU/vw5Pe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srB8aVP2ws1RSho00PZuKnJ0Ubo9fue7bBBqE6D/LGB7BJiOUFea0HEPVIjUpWFdq
	 bTkCF3ybatJ2yTi5YzCTrjO5rQ7hnq/iSunZ2U6gExxDxKNTKfjj9fcFXWkda7s05a
	 XYoC6tRGT98ZtfuszWZ3H24kw+mUpadaiDhOdJUpR2mUwOgy4jbDHhL2yaduGFbmO8
	 fdx37Z/EQvF9lrJ53lqWaDc0HuYvm5RhG0vPCnPq+yQB5R4yj/3vFzrpNWwfrmXKZH
	 Zw9Wtm/mOF8JD482rnYfNwE/AqjniJVfHMcFnPL+9yqRpmF29oK0faSC+d0qiXWRJ5
	 l8BFhPtX3QG/Q==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 2/4] of: unittest: Use __free(device_node)
Date: Sun, 17 Dec 2023 18:46:46 +0000
Message-ID: <20231217184648.185236-3-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217184648.185236-1-jic23@kernel.org>
References: <20231217184648.185236-1-jic23@kernel.org>
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


