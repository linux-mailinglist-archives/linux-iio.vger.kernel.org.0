Return-Path: <linux-iio+bounces-2661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4E085848D
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645FB1F22309
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAA613329A;
	Fri, 16 Feb 2024 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOUu2QNx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E8413328F;
	Fri, 16 Feb 2024 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105985; cv=none; b=FoaPWPLjzX7UTYTWFPmnbb4K4BBZH57f7zu4/ZuuUY2haxdxdHzlTC0aUWPRWDoxNnjvgy7SF5f1EJYaydVaafzHkU/gSCBcz1yN3FJVyoAFLVWaf6vkALL35yBC7yozATFVCbKOwBDFXHKDZPuqygECud/rsDNIgdwEwooPJag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105985; c=relaxed/simple;
	bh=xoqaZeH+L6kiORxJxGHcYCa8+Q9swQYNI0S2PeIKwY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTWmDx1OKAf62/k+q0tsNAcPDsL7gqsZhijIjuZmSOP5dW5okHTKfc8z3jOpT4e1pFSQBR1d+5xDwLanUcLH2d1RhZ7l2px89vUtt0RvwrQQcE+BnBbVktjCL7HSOR1dcmGcpt/WhX9cRvgM3JWweOmWUJsrKDF4Xmb56oKDdqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOUu2QNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33D4C433F1;
	Fri, 16 Feb 2024 17:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708105985;
	bh=xoqaZeH+L6kiORxJxGHcYCa8+Q9swQYNI0S2PeIKwY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOUu2QNx2TiY6AAFUXPBZj6/SCh15x/Clyi5xZ3EGSYIv5Zk7wH3Gsg8g4yUdVX4j
	 LJSzBQiN59XK7CC6v7GfGfb+Bwq31Sa5dSIt2WxcLOQk4jOpZSIXWuLJCVOOnDnD7l
	 zHFYo05vvVKs43tYYayoICPrn6t9xG1Sj5sEf6F9X5kBfGOqWPZQJ/4I35DYcHXBnU
	 Gisg/I2Hm+Ux2Tm8aRcDgtWDJkwLzt0DxcXeCg95aOma77K+Nx/D9dEGmxjuPGfa48
	 SdhikAfweaKkCKtde2VDdQjYkkyDKhDgNMiZIvAT204++y2LYKiLtpxF9MCORl1Ua9
	 sIj3ue2TZDYcA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 04/15] device property: Introduce device_for_each_child_node_scoped()
Date: Fri, 16 Feb 2024 17:52:10 +0000
Message-ID: <20240216175221.900565-5-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216175221.900565-1-jic23@kernel.org>
References: <20240216175221.900565-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Similar to recently propose for_each_child_of_node_scoped() this
new version of the loop macro instantiates a new local
struct fwnode_handle * that uses the __free(fwnode_handle) auto
cleanup handling so that if a reference to a node is held on early
exit from the loop the reference will be released. If the loop
runs to completion, the child pointer will be NULL and no action will
be taken.

The reason this is useful is that it removes the need for
fwnode_handle_put() on early loop exits.  If there is a need
to retain the reference, then return_ptr(child) or no_free_ptr(child)
may be used to safely disable the auto cleanup.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/property.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 9e67c3c4df6e..421ccfd43fb1 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -182,6 +182,11 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 	for (child = device_get_next_child_node(dev, NULL); child;	\
 	     child = device_get_next_child_node(dev, child))
 
+#define device_for_each_child_node_scoped(dev, child)\
+	for (struct fwnode_handle *child __free(fwnode_handle) = \
+	     device_get_next_child_node(dev, NULL); child; \
+	     child = device_get_next_child_node(dev, child))
+
 struct fwnode_handle *fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 						  const char *childname);
 struct fwnode_handle *device_get_named_child_node(const struct device *dev,
-- 
2.43.2


