Return-Path: <linux-iio+bounces-2658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA92B858488
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80AB5283909
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5832D132C3B;
	Fri, 16 Feb 2024 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qF6oc5ct"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1346612F38D;
	Fri, 16 Feb 2024 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105964; cv=none; b=WhRa6cTIqoFRbvooPBnbOtqqbsrvkcRF4GA/Ay+pXF9RKWfOlsPLnVhdl1g5MYTFf1wiJaVWXtpR4IPkh0UE2QqbT5c0EO8FHQ6QNIYEoee+Tn0wsRTGSfWR5UnmQgFcVakM2RdePnE9BjeESi0GJB2pDQjwgCiRzJTuRh2D6Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105964; c=relaxed/simple;
	bh=gZcNKYyfXotLlrZugPfjZu+r2vzoJfxqVIW/Zvhx97Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMTbpkgjHjB3sohuYaO7K1Jr6hb4bexEI0A0PVAwdMtJdPoeRUKHcIutsdpryMyGVEXSUYR2n3WIZzkaZ12zPNprLTL/cRadaVUHv9lkFW5ToM+cbIiJhifNt5mfa6K7CSPm/C1k6w/gWPAvEFYKUPMSHTAnjy7SFkZ9lUQPzn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qF6oc5ct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AA1C43394;
	Fri, 16 Feb 2024 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708105963;
	bh=gZcNKYyfXotLlrZugPfjZu+r2vzoJfxqVIW/Zvhx97Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qF6oc5ctgliN//gOGRPP/Pmos7Z0LvcwsRNTds/TniRVMqS5t5jtHurxxQa0gZ3zV
	 Wv2pJx9U1brdKepTOZ07JzjShn+Panido7fHLAJFiO6zitjEMGdIjrTDnvqXAL5aUx
	 41oQnNCx/v8jrXY8xuPiIpoAaVpCSqcE6JZTc947hU0i9PlgiDOu2ws0chs6d1APCa
	 2niY0FQLPCNHQ4u+N6H7ObPt8T8Ctlc7i0dFSW7TKsc0Qfw0Hbyq/TnnbLEgNIxZzc
	 pHkVfulPayTtGnkOwwIrOHAuRTVHs3WwEkRA2ojWPbxyBBRdKK1+WtSiiZMdztCjfB
	 i2oSkd3mhiA2Q==
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
Subject: [PATCH v3 01/15] device property: Move fwnode_handle_put() into property.h
Date: Fri, 16 Feb 2024 17:52:07 +0000
Message-ID: <20240216175221.900565-2-jic23@kernel.org>
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

By having this function as static inline in the header, the compiler
is able to see if can optimize the call out if (IS_ERR_OR_NULL(fwnode))
This will allow a simpler DEFINE_FREE() call in the following patch.

Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/base/property.c  | 14 --------------
 include/linux/property.h | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index a1b01ab42052..53e42031c646 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -923,20 +923,6 @@ struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_handle_get);
 
-/**
- * fwnode_handle_put - Drop reference to a device node
- * @fwnode: Pointer to the device node to drop the reference to.
- *
- * This has to be used when terminating device_for_each_child_node() iteration
- * with break or return to prevent stale device node references from being left
- * behind.
- */
-void fwnode_handle_put(struct fwnode_handle *fwnode)
-{
-	fwnode_call_void_op(fwnode, put);
-}
-EXPORT_SYMBOL_GPL(fwnode_handle_put);
-
 /**
  * fwnode_device_is_available - check if a device is available for use
  * @fwnode: Pointer to the fwnode of the device.
diff --git a/include/linux/property.h b/include/linux/property.h
index e6516d0b7d52..151bcab4f92a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -187,7 +187,19 @@ struct fwnode_handle *device_get_named_child_node(const struct device *dev,
 						  const char *childname);
 
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
-void fwnode_handle_put(struct fwnode_handle *fwnode);
+
+/**
+ * fwnode_handle_put - Drop reference to a device node
+ * @fwnode: Pointer to the device node to drop the reference to.
+ *
+ * This has to be used when terminating device_for_each_child_node() iteration
+ * with break or return to prevent stale device node references from being left
+ * behind.
+ */
+static inline void fwnode_handle_put(struct fwnode_handle *fwnode)
+{
+	fwnode_call_void_op(fwnode, put);
+}
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);
-- 
2.43.2


