Return-Path: <linux-iio+bounces-27321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BCDCD66B2
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 15:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 338EC301FC10
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7EF3321A0;
	Mon, 22 Dec 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmVzvL1y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6F32C922;
	Mon, 22 Dec 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766415023; cv=none; b=V9FKF6jL5+YgN0RLHVdPiJf/+wwS648XnzvpnEdaJe0Ro2cQLL1ozSevvJpq+KeKnNRFzI0hBxRgP+meVJov0xlCw6VOeznQ4nCmlIQ8CyzRlosn+x5FWroTB5xwZ3zX3h9p7iiJrJ3BPw1r49WRsP83ikSEzF4vFdZEG6Z3smg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766415023; c=relaxed/simple;
	bh=8HNpcRauLCXzn67aNs8ZWcBZ2H+uRo0lS4mMUG0PyUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O2xv+YA8IV4RQrNUAE9JSnrEPivN3eSv2eAnnJoCiF6GXB8ZaepIbfAHWVlcAD8+HcRySxZ3pKvseDsqqcuhvie8y+lNi69ALCzlqguO7z/d2fjeHnpHvCQ+bxA7NNGI24fnxqp9nk9XwTTnatUUdYNNank7ySMWYwtlugDJGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmVzvL1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 559CEC116C6;
	Mon, 22 Dec 2025 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766415023;
	bh=8HNpcRauLCXzn67aNs8ZWcBZ2H+uRo0lS4mMUG0PyUY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=OmVzvL1yL+Vi2iQFBUnru5ZMVBW6p9LvTiL0VfVivI65LzGA0C98H1YAbDON0Gh89
	 EusrHg2ev3OlPLuhz4zPZxEvXDoJ72UetMEgA7SM4K8fzeKSjOoW4rq1mxv6QyDr66
	 9PmqeCyggPFqOMJAKixeksmBQGcMOKcyyF0z4yCLihVC4BNmgA/OvP1lW/3ueOsS3n
	 gG5G4QHAo7/kKI6IfL9ufKfjlg1UfvZZ3FpMqr8VWh8npd/uDx6eDjYfegJLdJ6mbC
	 OTpqEtJNeX/nr7Yk+dtJIl/TxeKf5IYT+mm0UkotqkzL4HtzTapN+TKkzdaQIxgNCR
	 WXQXkypwn5Cjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CA3E674B7;
	Mon, 22 Dec 2025 14:50:23 +0000 (UTC)
From: Markus Koeniger via B4 Relay <devnull+markus.koeniger.liebherr.com@kernel.org>
Date: Mon, 22 Dec 2025 15:50:04 +0100
Subject: [PATCH] iio: accel: iis328dq: fix gain values
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-iio-accel-iis328dq-fix-gains-v1-1-c2f337703e91@liebherr.com>
X-B4-Tracking: v=1; b=H4sIAJtaSWkC/x2MwQqDQAwFf0VybsB9paL9FelhXaMGZK0bEEH89
 4beZhiYi0yKitG7uqjIoaZbdgmPitIS8yysozuhxisAYNWNY0qyOtkT7bjzpCfPUbNxQhumrmv
 CAJAvvkU8/vf9575/L+y9UG4AAAA=
X-Change-ID: 20251222-iio-accel-iis328dq-fix-gains-c281f9961b22
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Markus Koeniger <markus.koeniger@liebherr.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766415022; l=3546;
 i=markus.koeniger@liebherr.com; s=20251222; h=from:subject:message-id;
 bh=wdugeHElWqIVhDug3MqNblDVssp1zP7JHfNEZkrVJVg=;
 b=phZfpOMPnViHuDnukeNdRgQap90KPTDiZjxV6lJ8s5X3BDGHGxHIs/YgqKEyZGPFeUPNSrjog
 gwsVe4uCsltA1IuicUguRcoxJPAWk+Rj/E3CvEB2PBqFXS+5VGTdPfu
X-Developer-Key: i=markus.koeniger@liebherr.com; a=ed25519;
 pk=3fL7nhId6Sb17FYMBAevOva1I1fwHyykC4jdDKiRGpI=
X-Endpoint-Received: by B4 Relay for markus.koeniger@liebherr.com/20251222
 with auth_id=583
X-Original-From: Markus Koeniger <markus.koeniger@liebherr.com>
Reply-To: markus.koeniger@liebherr.com

From: Markus Koeniger <markus.koeniger@liebherr.com>

The sensors IIS328DQ and H3LIS331DL share one configuration but
H3LIS331DL has different gain parameters, configs therefore
need to be split up.
The gain parameters for the IIS328DQ are 0.98, 1.95 and 3.91,
depending on the selected measurement range.

See sensor manuals, chapter 2.1 "mechanical characteristics",
parameter "Sensitivity":
IIS328DQ https://www.st.com/resource/en/datasheet/iis328dq.pdf
H3LIS331DL https://www.st.com/resource/en/datasheet/h3lis331dl.pdf

Fixes: 46e33707fe95 ("iio: accel: add support for IIS328DQ variant")
Reviewed-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Signed-off-by: Markus Koeniger <markus.koeniger@liebherr.com>
---
Fix gain value of IIS328DQ accelerometer. The typical gain parameters for 
the IIS328DQ are 0.98, 1.95 and 3.91, depending on the selected 
measurement range. The configuration for IIS328DQ and H3LIS331DL needs 
to be split up as H3LIS331DL has different gains of 49, 98 and 195. 
---
 drivers/iio/accel/st_accel_core.c | 72 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 99cb661fabb2..afd97216d8ae 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -517,7 +517,6 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = H3LIS331DL_ACCEL_DEV_NAME,
-			[1] = IIS328DQ_ACCEL_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
 		.odr = {
@@ -584,6 +583,77 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
+	{
+		.wai = 0x32,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = IIS328DQ_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
+		.odr = {
+			.addr = 0x20,
+			.mask = 0x18,
+			.odr_avl = {
+				{ .hz = 50, .value = 0x00, },
+				{ .hz = 100, .value = 0x01, },
+				{ .hz = 400, .value = 0x02, },
+				{ .hz = 1000, .value = 0x03, },
+			},
+		},
+		.pw = {
+			.addr = 0x20,
+			.mask = 0x20,
+			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = 0x23,
+			.mask = 0x30,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_100G,
+					.value = 0x00,
+					.gain = IIO_G_TO_M_S_2(980),
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_200G,
+					.value = 0x01,
+					.gain = IIO_G_TO_M_S_2(1950),
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_400G,
+					.value = 0x03,
+					.gain = IIO_G_TO_M_S_2(3910),
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x23,
+			.mask = 0x80,
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x02,
+			},
+			.int2 = {
+				.addr = 0x22,
+				.mask = 0x10,
+			},
+			.addr_ihl = 0x22,
+			.mask_ihl = 0x80,
+		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
+		.multi_read_bit = true,
+		.bootime = 2,
+	},
 	{
 		/* No WAI register present */
 		.sensors_supported = {

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20251222-iio-accel-iis328dq-fix-gains-c281f9961b22

Best regards,
-- 
Markus Koeniger <markus.koeniger@liebherr.com>



