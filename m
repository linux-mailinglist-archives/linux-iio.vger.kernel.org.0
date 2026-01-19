Return-Path: <linux-iio+bounces-28025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E5CD3BAAC
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 23:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 972D830275A1
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0772FBE02;
	Mon, 19 Jan 2026 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kjc+wEar"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518132F9D85
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768861074; cv=none; b=NxZAlROXvvA+jJQqNcSct9ZiAYW8e752AlRayUKJdBD0xvL/6wUYz4Dv+WgBhUJM7UWvDShlOJl1dQ17cA+Ns3pVVehoSM7UQ9Gl3lKjwTEohJ63pOXxGQ+X6RMF7EEljNeGgzsaSOCSK0oK4T9kpK6E2ptda+Si23ax1PkhrtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768861074; c=relaxed/simple;
	bh=CgTpMtpJKIePfkimHRCMzQctkTwZX4NOFvwboRl9zTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0D71Y8rjL7kqvcSZ3/J6oAavnSAUefVt/+6B5QToEMOW5xvpkU75GuAtbfp5Oz8xI6kwTM44rMsAXJVxPczlzYw6Wdnkz0GYlHH7Fp1mNZWiW35m4xXyQRWwltl+kIi/2gTwV6P2bz3AmI+QgtdAWmrVx1XuGat5LBe9llB8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kjc+wEar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF19DC19422;
	Mon, 19 Jan 2026 22:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768861073;
	bh=CgTpMtpJKIePfkimHRCMzQctkTwZX4NOFvwboRl9zTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kjc+wEaruy8bo7+YkKz7wksI/TksDrpffdcsqeH7czsQlQCTuEcvKohAzLgxFgSgA
	 nvX+svVWKQ552g12hRKwWDEpI4Tg47TCXAvsPTdwnzD/qtE1Wxi6bgkhLjIYqYGr15
	 ruyfMg1XeWBYgaoC67ul5wgdmhSTw/FzN8FxyPdOMsnk0QYw4P7iEUefPLDVY1HKAu
	 MKheJARrm4hAnT6PnapPx47Q+yA7BzyW5keHmJb1r2Qzcn8eKn7fYFgOrEcrJCaSeT
	 Usu31Eqfjd48J2+nkhA5iBRcFpIVn0vLkOCCsQ/HiFPPWM35G7L/yb29Zfmz4IjXLi
	 tX6u9r2UdD+9g==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] iio: magn: mmc5633: Add some ifdef / __maybe_unused until stubs available
Date: Mon, 19 Jan 2026 22:17:36 +0000
Message-ID: <20260119221736.804825-3-jic23@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119221736.804825-1-jic23@kernel.org>
References: <20260119221736.804825-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The I3C tree has Frank Li's fix for the case of I3C not being built
https://lore.kernel.org/all/20251230145718.4088694-1-Frank.Li@nxp.com/
Given those will only be available upstream at the next merge window
and the ordering of merge of I3C vs IIO is uncertain, apply some temporary
stubs in the driver to avoid build issues.

This can be reverted next cycle.

Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512280443.lOhY75Df-lkp@intel.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/mmc5633.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
index 9d8e27486963..37f46fe5e9e4 100644
--- a/drivers/iio/magnetometer/mmc5633.c
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -190,32 +190,37 @@ static bool mmc5633_is_support_hdr(struct mmc5633_data *data)
 	if (!data->i3cdev)
 		return false;
 
+#ifdef CONFIG_I3C
 	return i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR);
+#else
+	return false;
+#endif
 }
 
 static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void *buf, size_t sz)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	u8 data_cmd[2], status[2];
-	unsigned int val, ready;
+	unsigned int val;
+	unsigned int ready __maybe_unused;
 	int ret;
 
 	if (mmc5633_is_support_hdr(data)) {
-		struct i3c_xfer xfers_wr_cmd[] = {
+		struct i3c_xfer xfers_wr_cmd[] __maybe_unused = {
 			{
 				.cmd = 0x3b,
 				.len = 2,
 				.data.out = data_cmd,
 			}
 		};
-		struct i3c_xfer xfers_rd_sta_cmd[] = {
+		struct i3c_xfer xfers_rd_sta_cmd[] __maybe_unused = {
 			{
 				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
 				.len = 2,
 				.data.in = status,
 			},
 		};
-		struct i3c_xfer xfers_rd_data_cmd[] = {
+		struct i3c_xfer xfers_rd_data_cmd[] __maybe_unused = {
 			{
 				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
 				.len = sz,
@@ -227,19 +232,27 @@ static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void
 		data_cmd[1] = (address == MMC5633_TEMPERATURE) ?
 			      MMC5633_HDR_CTRL0_MEAS_T : MMC5633_HDR_CTRL0_MEAS_M;
 
+#ifdef CONFIG_I3C
 		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd,
 					  ARRAY_SIZE(xfers_wr_cmd), I3C_HDR_DDR);
+#else
+		return -EOPNOTSUPP;
+#endif
 		if (ret < 0)
 			return ret;
 
 		ready = (address == MMC5633_TEMPERATURE) ?
 			MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
+#ifdef CONFIG_I3C
 		ret = read_poll_timeout(i3c_device_do_xfers, val,
 					val || (status[0] & ready),
 					10 * USEC_PER_MSEC,
 					100 * 10 * USEC_PER_MSEC, 0,
 					data->i3cdev, xfers_rd_sta_cmd,
 					ARRAY_SIZE(xfers_rd_sta_cmd), I3C_HDR_DDR);
+#else
+		ret = -EOPNOTSUPP;
+#endif
 		if (ret) {
 			dev_err(dev, "data not ready\n");
 			return ret;
@@ -248,8 +261,12 @@ static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void
 			dev_err(dev, "i3c transfer error\n");
 			return val;
 		}
+#ifdef CONFIG_I3C
 		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd,
 					   ARRAY_SIZE(xfers_rd_data_cmd), I3C_HDR_DDR);
+#else
+		return -EOPNOTSUPP;
+#endif
 	}
 
 	/* Fallback to use SDR/I2C mode */
-- 
2.52.0


