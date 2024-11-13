Return-Path: <linux-iio+bounces-12224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E99C7CE9
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 21:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C4AB27D56
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 20:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67818204F7D;
	Wed, 13 Nov 2024 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb/eI7hF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87A189BB3;
	Wed, 13 Nov 2024 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529559; cv=none; b=RbLF4seJXvzwAUTY5gSjzNulMVhh+1xez7xeTzcZ7hxIGB3dc51HKWG+bey2gPoIEUFCHwUFQCrCfGYXtFViViCjlNGx5Dg88cI831jCYhsviM/pDaVvpVfl8QaMC3y3NcykMXjhN1jiO5cpSRLyBmc6h+4q7teRSfS/Hz2irtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529559; c=relaxed/simple;
	bh=XVkEg4LZukzwzA4wK7AA/2hvowHA2b6JWNl3VzbY1qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eo3g5XOzWXwIn55/mjXuzRBZB8e08dgteM+EP5ywg8xeC0ReOfSdiCHCxWXSXlvz/+EAqDbK2dcxWqOAIED9kXj7OfVqa8XBa4TwSvetMmuV1hmvq+lAlBHMSgaFCaMZiGU0jisGJkgVlY6+RsqRwVFaIESCa8v+AHEh9BAc5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mb/eI7hF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AD8CC4CEC3;
	Wed, 13 Nov 2024 20:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731529558;
	bh=XVkEg4LZukzwzA4wK7AA/2hvowHA2b6JWNl3VzbY1qs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=mb/eI7hF4frCePhnWSmoFVP76+4bKvi7WxqrF2I8bNJ2DUXPMAmaCD6hb2MYmThxH
	 k05g55jBWXnzxkCq8I0rl00TThqp3JMgla8zqae8+1QzytRktjOPQ8Fx+yUydbHYEz
	 OEC6cQ7Xoe8TfwxJPUjwVe95l8q3THbeb5u0yX0vBVRRNMukSdKFyQcsMIvJsX3iFm
	 3e8FYoyFwAl5r8zvWcadI8e0YIDn2nUdsm0Tnta10wA8Sm2r/PaUjkBQu/QYQVI1po
	 kbheCwYyOduEDRaerLkn5iRGgYK33BcfT1nXNYs3ZL7PD8PtisuVd6pz+pWXadWuIi
	 P+2ttcoqSoEQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91889D637AE;
	Wed, 13 Nov 2024 20:25:58 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Wed, 13 Nov 2024 21:25:45 +0100
Subject: [PATCH] iio: imu: inv_icm42600: fix timestamps after suspend if
 sensor is on
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-inv_icm42600-fix-timestamps-after-suspend-v1-1-dfc77c394173@tdk.com>
X-B4-Tracking: v=1; b=H4sIAEgLNWcC/x2NwQrCMBAFf6Xs2YVsDAr+iojE9FX3kBiysQil/
 27wODDMbGRoCqPLtFHDqqbvMkAOE6VXLE+wzoPJOx9E5Mha1rumHPzJOV70y10zrMdcjePS0dg
 +VlFmfpwRvCDG4BKNXm0Y/v91ve37DznTSuJ7AAAA
X-Change-ID: 20241113-inv_icm42600-fix-timestamps-after-suspend-b7e421eaa40c
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731529557; l=1842;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=+tQ9OPlXVb/U7JJzG2A5nQchXayPHGyAcIorXGviVAg=;
 b=sCmRsr4/cO+NzGKXwiE8HMetOoSImgvJtQSIr0Y8XXQZQtaxiApETbdK79AE/3j00YdWcFZjs
 L7nEs9l63s4ChzCaC6wkyTOFE31hgw3QrQR59S+P18fmf0medsGmlo4
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Currently suspending while sensors are one will result in timestamping
continuing without gap at resume. It can work with monotonic clock but
not with other clocks. Fix that by resetting timestamping.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 93b5d7a3339ccff16b21bf6c40ed7b2311317cf4..03139e2e4eddbf37e154de2eb486549bc3bdb284 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -814,6 +814,8 @@ static int inv_icm42600_suspend(struct device *dev)
 static int inv_icm42600_resume(struct device *dev)
 {
 	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
+	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -834,9 +836,12 @@ static int inv_icm42600_resume(struct device *dev)
 		goto out_unlock;
 
 	/* restore FIFO data streaming */
-	if (st->fifo.on)
+	if (st->fifo.on) {
+		inv_sensors_timestamp_reset(&gyro_st->ts);
+		inv_sensors_timestamp_reset(&accel_st->ts);
 		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
 				   INV_ICM42600_FIFO_CONFIG_STREAM);
+	}
 
 out_unlock:
 	mutex_unlock(&st->lock);

---
base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
change-id: 20241113-inv_icm42600-fix-timestamps-after-suspend-b7e421eaa40c

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



