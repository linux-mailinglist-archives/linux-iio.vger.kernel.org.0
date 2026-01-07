Return-Path: <linux-iio+bounces-27529-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3485DCFEC32
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 17:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940813114B0D
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB0E329E64;
	Wed,  7 Jan 2026 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnmVUJPR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C881DE89A;
	Wed,  7 Jan 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799947; cv=none; b=fujATQOBm7akHbRzN1OOO6kT75P4iUR/VrxCXslXrH06U9kQppVjkFuPTNdabB7O3ZeP1T3W3N4lpIsyVdyhBRu56mJnsaoqShq7JKC1m67ojy1mzWrSU29iODeZAMISbgMVXf4Aii1BYIxcemP1t71nsVpayUdXVGl5VW7so0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799947; c=relaxed/simple;
	bh=x5n/90gUKUblZQ/ehor4vaJG6mlf9FsoxTXe1dMXEBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bEYqgDmubbWlbRQJ2tDYydPW5PGgj6OtuA6+CbyXPw3mx/8sUtI+HY3pGClKO5Bc6Hq363vfqYQPzouawTYgNnyoelr2O85j2mp16JpLPl9U+IYGTLizaGevwYeDpg0VY6RNC/5Vdbsb3V86uC8J/7rXnsKO5lain/hR7CIeUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnmVUJPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD301C4CEF1;
	Wed,  7 Jan 2026 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767799946;
	bh=x5n/90gUKUblZQ/ehor4vaJG6mlf9FsoxTXe1dMXEBU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=EnmVUJPRrirBC74BkvcZzMJ8CRESVHXm1AC+ITq3jNLskMMMznvicAzBxmo0G65J1
	 4StO1V5FwqFdWTn5BDczPWbqXV913ntT/kdK6a/WMzaVEmyTZoEc8huimnzlOvQel6
	 8Fylf9Y6XdWFco+fhV4JSJ3ntwXSzgVGSHb1jDsXAz8a6nm2syyLXnLDeaH2/X3j9q
	 QVz41GNdfG7b/WM4Wq5j51+UolTJCd5yn57a8WGWUwBk+3kouDQIaeFjTpU77KFi3X
	 cG7VZQspGJlMap2rk/+bGbEEcGOdQb8rWRxn0JG2DjrY/ioZnKNatVq8d4+AAZQ7ql
	 FzOX6Bze9p1Iw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A936ACFD649;
	Wed,  7 Jan 2026 15:32:26 +0000 (UTC)
From: Markus Koeniger via B4 Relay <devnull+markus.koeniger.liebherr.com@kernel.org>
Date: Wed, 07 Jan 2026 16:32:18 +0100
Subject: [PATCH v2] iio: accel: iis328dq: fix gain values
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-iio-accel-iis328dq-fix-gains-v2-1-10737cf8336a@liebherr.com>
X-B4-Tracking: v=1; b=H4sIAIF8XmkC/42NQQ6CQAxFr0K6toZ2ooAr72FYwFCgCTI6Y4iGc
 HcrJ3D33//J+yskiSoJLtkKURZNGmYDPmTgx2YeBLUzBs75RMyMqgEb72WylByX3RN7fePQ6Jz
 Qc0l9VZ2pZQZTPKLYuOtvtfGo6RXiZ39b6Nf+KV4Iyey9c0WRO6noOqm0o8R49OEO9bZtXwQ4W
 ETLAAAA
X-Change-ID: 20251222-iio-accel-iis328dq-fix-gains-c281f9961b22
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Markus Koeniger <markus.koeniger87@gmail.com>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Markus Koeniger <markus.koeniger@liebherr.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767799945; l=3440;
 i=markus.koeniger@liebherr.com; s=20251222; h=from:subject:message-id;
 bh=Ax6zH3GESUNqAk8XCn4TD0l5VRhxFPVc++gdkSVnh5U=;
 b=K4Fxg8j8lakqSHDzv1XIhGbFCnhxO6udwBSB0/QaF47dI3m6H8+Wdn7i5hizuSYmS6pDzp2Gz
 HCKeJXquP0bC4jS9bxUh6XiYFylrZlZdyBiShL+8xkVcd2nsLs4LtQd
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
parameter "Sensitivity".

Datasheet: https://www.st.com/resource/en/datasheet/iis328dq.pdf
Datasheet: https://www.st.com/resource/en/datasheet/h3lis331dl.pdf
Fixes: 46e33707fe95 ("iio: accel: add support for IIS328DQ variant")
Reviewed-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Signed-off-by: Markus Koeniger <markus.koeniger@liebherr.com>
---
Changes in v2:
- use datasheet tags
- fix duplicate description
- Link to v1: https://lore.kernel.org/r/20251222-iio-accel-iis328dq-fix-gains-v1-1-c2f337703e91@liebherr.com
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



