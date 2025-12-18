Return-Path: <linux-iio+bounces-27159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E63CCB6B7
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 232BF303D9F6
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3EC331231;
	Thu, 18 Dec 2025 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZw9W97h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8AD30F947;
	Thu, 18 Dec 2025 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766053873; cv=none; b=QfLN9pTnxRTbX29pnA2kFVgBXvqXohBnRjtdupNeYcU+bVVPD2p8mFmvcNJmbH4FDwbsn1KfqqVEGA4umEjh/oPkh0QaR9o54r15+DC3FubrbGALPEwLA7/hslM+DbgAGiWEnXOeFi8TE1iJp95xxIM+y5AnNLft9/nODv5H+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766053873; c=relaxed/simple;
	bh=6PQoCtg5eP3Kd27EWqZAvTdnh8jlXwyPej5/4mwGK10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OO6dxtWnmooSf/ilZFoE+D8yPPCu8Ubk/kt1rPKu9mUQW4oWyOCpDuws22siN54s3uLqp8h0STTYb/RbyBKKdVtDBpDW3HiHjIFJDkqdCj23cxEB9rpLIm8y3TqX21vAj/AJkUbxPAh273W5hC0IVxaDf/7vPMzUwi9t5bS1GmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZw9W97h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98DD3C4CEFB;
	Thu, 18 Dec 2025 10:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766053872;
	bh=6PQoCtg5eP3Kd27EWqZAvTdnh8jlXwyPej5/4mwGK10=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=LZw9W97hj0V5+0wuz4GDwsTJJcVh2/DWcM756Kss8RarwsiTWET2HBkGg//2TYhsX
	 EgsZj1niar3OHCkGhjstYFzBm9GKiJ6fmzthWJah3xgfY2JAZUBnnWm/sSI7j3QQCO
	 fGt/ZsXujIL17YYalHvzzHry3+zMexPjMbbW+cp9RJlqORkRPvz7C2r1pdCaeHdVgo
	 ZJKu2z5gv6Oz39YtTgzQYtuQiia5QEZHvBIMsamgNAbgbA4aVizf4L7zCc73ixwu4n
	 3nMSODRy/yDnOX8DKacGeNBiz7018BvBgI5RSG+Nkn5Z/Tdqw/sHFO8UK3tkrXLbRQ
	 HoFLvw6dk5nXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851E6D6ACD5;
	Thu, 18 Dec 2025 10:31:12 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 18 Dec 2025 11:30:59 +0100
Subject: [PATCH] iio: imu: inv_icm45600: fix temperature offset reporting
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251218-inv-icm45600-fix-temperature-offset-reporting-v1-1-4872f381cbc2@tdk.com>
X-B4-Tracking: v=1; b=H4sIAOLXQ2kC/x2NMQrDMAwAvxI0VyCbpjT9SukgYjnVENvIbiiE/
 D0m4w13t0MVU6nwGnYw2bRqTh3cbYD5y2kR1NAZPPnRefdETRvqvN7HBxFG/WOTtYhx+5lgjrF
 KQ5OSrWla0E3ENHGIgQP0ZjHpzvV7f47jBCY3kld/AAAA
X-Change-ID: 20251218-inv-icm45600-fix-temperature-offset-reporting-190a09adfdad
To: Remi Buisson <remi.buisson@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766053871; l=1672;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=xHzUisfu0BLrHdPVA8yrhePvVSwj6H9ilNUk2ycuOgo=;
 b=cn6pEMLtqaKZPYTByBvhgKorl9JZG4k5oW3iwONW+ePPrOxspibxVVJIMVkTAawnI4r0KenX1
 b6F7sJdob0iAYzA6SYBW5r3SjjxlU31UjA9+UFEhkCiNYNyFNuN6rvb
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Correct temperature computation is (raw + offset) * scale and not
apply scale and offset afterward.
Fix temperature offset reporting to the correct value and update
commentaries for the new computation.

Fixes: 27e072bc34d1 ("iio: imu: inv_icm45600: add IMU IIO gyroscope device")

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
index ab1cb7b9dba435a3280e50ab77cd16e903c7816c..25bd9757a594d0180d7f53b49f959a49a50c64a9 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
@@ -960,16 +960,17 @@ int inv_icm45600_temp_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	/*
 	 * T°C = (temp / 128) + 25
-	 * Tm°C = 1000 * ((temp * 100 / 12800) + 25)
-	 * scale: 100000 / 13248 = 7.8125
-	 * offset: 25000
+	 * Tm°C = ((temp + 25 * 128) / 128)) * 1000
+	 * Tm°C = (temp + 3200) * (1000 / 128)
+	 * scale: 1000 / 128 = 7.8125
+	 * offset: 3200
 	 */
 	case IIO_CHAN_INFO_SCALE:
 		*val = 7;
 		*val2 = 812500;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 25000;
+		*val = 3200;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;

---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251218-inv-icm45600-fix-temperature-offset-reporting-190a09adfdad

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



