Return-Path: <linux-iio+bounces-1647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA2182D17F
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E6E1F214E8
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C535255;
	Sun, 14 Jan 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYyzReS4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F22E5231;
	Sun, 14 Jan 2024 16:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724F2C43390;
	Sun, 14 Jan 2024 16:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705251257;
	bh=3W1qHEpkEEvNPT0uRw4qBpEp9CwZhHXPWsBb4ES3aiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYyzReS4uoTuzJYfBvbtzCM9fU52/WE5RmYMrtt96OEQHyPlvG6lbnEaL3vIJ3iyd
	 wBdAFAj/hxtTBb5cCqDxsn7b6Dxk7hJNnWLFe9RUPOPDG22m6LvQ0wtmwAhTUN9Rla
	 ZSDmiXRC/aikBlYohcR1TyQRB9ElQ/yz6Vb3QXJoe01vOJlR287X5/HwuewxAKFZTW
	 Gk2a8DGsUvAfNQ9ik/92atDSpo/QEOu+GAUKmWe7KuJFR2kFm7fBsML7Bou0vEvPpG
	 x0uiwBUmBpmyq2ECpt8H+5KW3Cnu09k45VP7tsmL+EOxFkOyEA7V3z+YVxKPQuu2bL
	 U0n0YsyEJEv0w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/4] of: Add cleanup.h based auto release via __free(device_node) markings.
Date: Sun, 14 Jan 2024 16:53:55 +0000
Message-ID: <20240114165358.119916-2-jic23@kernel.org>
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

The recent addition of scope based cleanup support to the kernel
provides a convenient tool to reduce the chances of leaking reference
counts where of_node_put() should have been called in an error path.

This enables
	struct device_node *child __free(device_node) = NULL;

	for_each_child_of_node(np, child) {
		if (test)
			return test;
	}

with no need for a manual call of of_node_put()

In this simple example the gains are small but there are some very
complex error handling cases buried in these loops that will be
greatly simplified by enabling early returns with out the need
for this manual of_node_put() call.

Note that there are coccinelle checks in
scripts/coccinelle/iterators/for_each_child.cocci to detect a failure
to call of_node_put(). This new approach does not cause false positives.
Longer term we may want to add scripting to check this new approach is
done correctly with no double of_node_put() calls being introduced due
to the auto cleanup. It may also be useful to script finding places
this new approach is useful.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/of.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 6a9ddf20e79a..50e882ee91da 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -13,6 +13,7 @@
  */
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/kobject.h>
 #include <linux/mod_devicetable.h>
@@ -134,6 +135,7 @@ static inline struct device_node *of_node_get(struct device_node *node)
 }
 static inline void of_node_put(struct device_node *node) { }
 #endif /* !CONFIG_OF_DYNAMIC */
+DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
 
 /* Pointer for first entry in chain of all nodes. */
 extern struct device_node *of_root;
-- 
2.43.0


