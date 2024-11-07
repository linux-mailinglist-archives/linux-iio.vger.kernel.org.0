Return-Path: <linux-iio+bounces-12010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A89C10D8
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 22:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C13D284320
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 21:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C449D217F5F;
	Thu,  7 Nov 2024 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWuMjLjl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE46194C92;
	Thu,  7 Nov 2024 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014417; cv=none; b=VDO42k5g1gNFp+tEwKNdKn9khFB592pSB6hnHKrUzx/ZNTzOPtKm7Cxo7Sx+gVQfc9OacdFnLxEykHMQJgX1IdOdPOqSf+c9c9TuDMJmbWrjDkeYwMg66Fb3ovWCfxuNQGki40fOrOyEtJ1NBXvSHgYRbdduzPZJCEuQpg+coWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014417; c=relaxed/simple;
	bh=VCt/pcm7n80NySooeazyHzSqGEiYNbdJgAkOBvhyJmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ux21k8UkZMm/tCWV4Ug6iC9CCd6LlCdWjLalX/2pBjyNtl2sbARFPJUvYskFpTvj8DQHBTLf/sqzfeakbZW+zPKZAXLP4H+DfDImHEbUPS0AKW3JlXROFv0rT1RXyBFlzoLRCAXet9JFd/Hpyfvg+y0hRPetBpmXnoZkJLUvbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWuMjLjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15737C4CECC;
	Thu,  7 Nov 2024 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731014417;
	bh=VCt/pcm7n80NySooeazyHzSqGEiYNbdJgAkOBvhyJmY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kWuMjLjlBVsyvpNxrBfL6iXB6yAkpzkQLODBfn6iIBVTMR7UIf2AYqnxJmmiefujy
	 ms+VMydsXpJVSXZwhZxtIQRThZZp5oemlDY8mpDblXx4/Rkjb+TnN4SWNBo/NsnYAU
	 MF8v5FsA6vxTuloAXL1ay+EgiWOWaK0OL/0Rh5IIVQEpFTozj0vzCefFgY8kTCuwHg
	 oyZkBK41LgeU3C4i7IQOkwfULDj8swnCoXMcB7zLQo39BzXHVpi77fSfj/Air1e1GR
	 726YYrpOI+KUwB6xS90DMAQ4BLKBwAg/hQVxjTrwxrm2+kdMaSJpZHOnj36vsBK1o0
	 oNmIKhLsZFh8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05977D5D68A;
	Thu,  7 Nov 2024 21:20:17 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 07 Nov 2024 22:20:06 +0100
Subject: [PATCH] iio: imu: inv_icm42600: fix spi burst write not supported
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-inv-icm42600-fix-spi-burst-write-not-supported-v1-1-800b22574d01@tdk.com>
X-B4-Tracking: v=1; b=H4sIAAUvLWcC/x2NQQ6CMBAAv0L27CZtQap+hXBAuuAebJvdgiaEv
 9t4nMPMHKAkTAqP5gChnZVTrGAvDcyvKa6EHCqDM66z1njkuCPP7871xuDCX9TM+NxEC36EC2F
 MBXXLOUmhgLSQvwXf+vt0hRrNQlX6D4fxPH9mAghhgAAAAA==
X-Change-ID: 20241107-inv-icm42600-fix-spi-burst-write-not-supported-efe78d7379a5
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731014416; l=2772;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=eEsvkfouCdMgwkJJdk752XAqwbz3MkUlI7SGBMxVUEA=;
 b=rGRs/voApe1d3FHAtobH1O1wnVlfw8ltZ85xR27K9NB5sP2Y6y0Ko+FLzwKAKK1tSmud64sjq
 8rH/UkcvuMHBG90IpziZBixkIu53Rx/IjT5HG3d7/SkMxXT7fmT59R5
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Burst write with SPI is not working for all icm42600 chips. It was
only used for setting user offsets with regmap_bulk_write.

Allow tweak of common regmap_config for using only single write for
spi.

Fixes: 9f9ff91b775b ("iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      | 2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 3a07e43e4cf154f3107c015c30248330d8e677f8..36a3b0795fb7d6cb0c178fadd93896fbc346ba0d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -402,7 +402,7 @@ struct inv_icm42600_sensor_state {
 
 typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
 
-extern const struct regmap_config inv_icm42600_regmap_config;
+extern struct regmap_config inv_icm42600_regmap_config;
 extern const struct dev_pm_ops inv_icm42600_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 93b5d7a3339ccff16b21bf6c40ed7b2311317cf4..680373f6267b37d386e4e7bda543ba4efe97e66b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -74,7 +74,7 @@ static const struct regmap_access_table inv_icm42600_regmap_rd_noinc_accesses[]
 	},
 };
 
-const struct regmap_config inv_icm42600_regmap_config = {
+struct regmap_config inv_icm42600_regmap_config = {
 	.name = "inv_icm42600",
 	.reg_bits = 8,
 	.val_bits = 8,
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 3b6d05fce65d544524b25299c6d342af92cfd1e0..73cacfd157a4538ae8c9d1c8d97157afa28aa672 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -59,6 +59,9 @@ static int inv_icm42600_probe(struct spi_device *spi)
 		return -EINVAL;
 	chip = (uintptr_t)match;
 
+	/* spi doesn't support burst write */
+	inv_icm42600_regmap_config.use_single_write = true;
+
 	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);

---
base-commit: c9f8285ec18c08fae0de08835eb8e5953339e664
change-id: 20241107-inv-icm42600-fix-spi-burst-write-not-supported-efe78d7379a5

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



