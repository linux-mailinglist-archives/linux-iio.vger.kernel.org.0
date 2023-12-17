Return-Path: <linux-iio+bounces-1034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5D48161A5
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 19:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5861F21E8C
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76C47F46;
	Sun, 17 Dec 2023 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbSTLCst"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1450546445;
	Sun, 17 Dec 2023 18:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC7DC433C9;
	Sun, 17 Dec 2023 18:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702838837;
	bh=z1xPfR7/0kHIRzEl8mhO13M6/rlHEk5SIFKF0NnTEYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbSTLCstSannBhZthV/FWeAOsJMgcrvhBTvNPlksJIwl7QNAZZFVu091p3ppk3wsK
	 fUYKqHwNrXKy+rUxa5zNzg1VPsNGAhD9tIeovrs8tk9pqVMRlogV1VhC7W6bNO9ADu
	 TS6txyZFgOHZseiygE5cExVZKGrr/epWpYcL6iHuMRwCzkiBePGxPvwQC97JIUR4oU
	 lQsxasd1L2Lc4Lg+EwSsEnITDopkw6woa4q5kNR/Fikw/CjduDXZKtUU9N6SjGdVBb
	 q/fmvWaRH6vE0D6tGsmFcxKNpIEaPCwiZaeDpZjRwnsarU/gHm3KKqaUXE16hU8Tso
	 ALMu+LyrC4kNg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 1/4] of: Add cleanup.h based autorelease via __free(device_node) markings.
Date: Sun, 17 Dec 2023 18:46:45 +0000
Message-ID: <20231217184648.185236-2-jic23@kernel.org>
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

In this simile example the gains are small but there are some very
complex error handling cases burried in these loops that wil be
greatly simplified by enabling early returns with out the need
for this manual of_node_put() call.

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


