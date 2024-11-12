Return-Path: <linux-iio+bounces-12175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277AD9C5212
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 10:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F99B255B5
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 09:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20E820DD56;
	Tue, 12 Nov 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QViwrG8G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BF204921;
	Tue, 12 Nov 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403817; cv=none; b=gQhMADPDyPnjpXQGGqNpKX8HD8tDoLCjyb8xZKp03B0QdTzdUTJ88/FSJEKAsr6OGNYRGZ+P9dxkKil+onGEj18QcBCybEBRZsc7yxYLx/gRkT/k+ZtpgrfY91JUDyB9PVg8RzYIIYNnFvO+FbHOaI4N459QmHa0rDMtDDukHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403817; c=relaxed/simple;
	bh=aSZ3eNKeq1xOUIZFdGsrWXMqelkfiGX6RRdMZz+fLyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s4RlaxCm1hqXC7vgMiPCa2jde9UC+t5eBRMPnlyxJFHU+svwmfbL5YBjhkHLokqtpBY1klvUoWhQX+/8xmC3nqPvfpai0C7VMv4KMunE1Iw1WZzIgLAZlPuq9pyxUKK8EbMGED2qtbhARL2iAkfO1EVa7M56hXs06/jHaYPGosk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QViwrG8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE4ACC4CECD;
	Tue, 12 Nov 2024 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731403816;
	bh=aSZ3eNKeq1xOUIZFdGsrWXMqelkfiGX6RRdMZz+fLyE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=QViwrG8G+KH5bALFXMyZa3ecubAwFYyaEohO/FjmyVVb2VI5guyIL0r2F0xqbzti7
	 wBgJKetJkSckaF73TLDg/NXlHJsmnIPTzd4BtkefrAJb8J10QsRmINv8KOJM1PK0NA
	 SuDQbJxu1R17yjovoKXZGpeoDRE6TcdZacBvfmKlQ3OPtgxQtOd013g63daf/Gposa
	 UnET4aJWZ7iz7P9CEYX5uyom3xAc99zUsSHAb9qLZNA4j5ycVTlcvVNu7cjPK9s1TE
	 jpKT/OW2yNPKyovQrzH3zm+VQLH1K2ZipjLW4gnbv91dwKJW+5TOIVgIucdnrh910m
	 X0j25bGaChVGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E78D32D78;
	Tue, 12 Nov 2024 09:30:16 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Tue, 12 Nov 2024 10:30:10 +0100
Subject: [PATCH v2] iio: imu: inv_icm42600: fix spi burst write not
 supported
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-inv-icm42600-fix-spi-burst-write-not-supported-v2-1-97690dc03607@tdk.com>
X-B4-Tracking: v=1; b=H4sIACEgM2cC/52NQQ7CIBBFr9KwdgxgK9WV9zBdtGVqJ6ZAgKKm4
 e5ij+Dy/eS/t7GAnjCwa7Uxj4kCWVNAHio2zr15IJAuzCSXtRBcAZkENC61PHMOE70hOIJh9SH
 Cy1NEMDZCWJ2zPqIGnFC1Wp3UpW9YkTqP5bQH713hmUK0/rP3k/itf6eSAAEt54OUjao1F7eon
 8fRLqzLOX8BnHrTQOoAAAA=
X-Change-ID: 20241107-inv-icm42600-fix-spi-burst-write-not-supported-efe78d7379a5
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731403815; l=3521;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=7v9hwAsLUpLcVbsTisYNf2ERfbiuJIYiXvYRPsz8tx0=;
 b=hlq8yXvk4Oc+vucDWRJ3i3I3OlJVXjHjKmsaAEgYaeD6i/+m9S2RotslVeST0sV1EnSRxVOPW
 Z1uRlrfd9VzAGHoTHeQNUK4RLC3zng+++9EXla5uVWddL2S+VWS7BbF
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Burst write with SPI is not working for all icm42600 chips. It was
only used for setting user offsets with regmap_bulk_write.

Add specific SPI regmap config for using only single write with SPI.

Fixes: 9f9ff91b775b ("iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Changes in v2:
- Add new spi specific regmap config instead of editing existing one.
- Link to v1: https://lore.kernel.org/r/20241107-inv-icm42600-fix-spi-burst-write-not-supported-v1-1-800b22574d01@tdk.com
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 15 +++++++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 3a07e43e4cf154f3107c015c30248330d8e677f8..18787a43477b89db12caee597ab040af5c8f52d5 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -403,6 +403,7 @@ struct inv_icm42600_sensor_state {
 typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
 
 extern const struct regmap_config inv_icm42600_regmap_config;
+extern const struct regmap_config inv_icm42600_spi_regmap_config;
 extern const struct dev_pm_ops inv_icm42600_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 93b5d7a3339ccff16b21bf6c40ed7b2311317cf4..834c32cb07f354ab52e69bfeea8f00b6443e8dd9 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -87,6 +87,21 @@ const struct regmap_config inv_icm42600_regmap_config = {
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_regmap_config, IIO_ICM42600);
 
+/* define specific regmap for SPI not supporting burst write */
+const struct regmap_config inv_icm42600_spi_regmap_config = {
+	.name = "inv_icm42600",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x4FFF,
+	.ranges = inv_icm42600_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
+	.volatile_table = inv_icm42600_regmap_volatile_accesses,
+	.rd_noinc_table = inv_icm42600_regmap_rd_noinc_accesses,
+	.cache_type = REGCACHE_RBTREE,
+	.use_single_write = true,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, IIO_ICM42600);
+
 struct inv_icm42600_hw {
 	uint8_t whoami;
 	const char *name;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 3b6d05fce65d544524b25299c6d342af92cfd1e0..deb0cbd8b7fe6fcb562067afaca931c148f6fca6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -59,7 +59,8 @@ static int inv_icm42600_probe(struct spi_device *spi)
 		return -EINVAL;
 	chip = (uintptr_t)match;
 
-	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
+	/* use SPI specific regmap */
+	regmap = devm_regmap_init_spi(spi, &inv_icm42600_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 

---
base-commit: c9f8285ec18c08fae0de08835eb8e5953339e664
change-id: 20241107-inv-icm42600-fix-spi-burst-write-not-supported-efe78d7379a5

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



