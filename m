Return-Path: <linux-iio+bounces-28021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD7FD3BA1F
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C3503089FE7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 21:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658512FB630;
	Mon, 19 Jan 2026 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPl7die5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295332FB08C
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768858587; cv=none; b=OL0n4GogAMp6PqgNzTsrrfGzE9oUFu2uSrVph/JtEG0xe0dqLMr7owM2RkC/GPYtXPPQwowGLyr0WnIq/uboMZBwPCGEvn7lEA6TfeDFrRTti0cuPbq/VaExVGU/o2cxrzrbISsx8bC5It0Aj6SPfRFTON5L8UpnVP3DKqKr29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768858587; c=relaxed/simple;
	bh=H2jxAfeHTW+lbFGugdx7midKIdV7OFVO28lkfB77HE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLQ/RSW00tAdPyjrUVV9ysfRucbXmiDdMpwUOqPQrzjMbE0EtjlTsS7OQlk64WjmnJt2nH/LpTOk0RHtzC6Ue+7K7SJANgEPjSd5kH9bFw1LbVpkS2thQCDzVsBni4HYp0vk4k/S6vlUOTOvUP0RpAFinuM9+cRXRFzPcVi8GbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPl7die5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F925C19422;
	Mon, 19 Jan 2026 21:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768858586;
	bh=H2jxAfeHTW+lbFGugdx7midKIdV7OFVO28lkfB77HE0=;
	h=From:To:Cc:Subject:Date:From;
	b=uPl7die5ioyOBgT+jxi8G604+NTWaVmw2n8AwlBxKav4DQMvQPU7aY6+FMbhlHhUC
	 uanX4nNKPhDVVI7TUBh89w4vfPH39IGYKtEd4Q6hT7JWmTYg3Z1JBd2P8Z5cgz1nqU
	 vYwz+C/8uybGFEKdMUUqV5lyevmsO4iQjtYTHLCaHqpahIHnMWM6OcHddbtVu0Gyp6
	 eiz9Oip7ZiplLrAgF5U2ZYXgxS9vfL368W97xBxe88XU+A0sRID0+32GYxBPjzze7f
	 yPXvHO43mc7txBWM1+TeOmZMKI9BAtHeEXNL54rtEzXnvUmSljNOnZMQCX6uPSyiqc
	 YXYpf+SQbJ7Mg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	jorge.marques@analog.com,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: adc: ad4062: Switch from struct i3c_priv_xfer to struct i3c_xfer
Date: Mon, 19 Jan 2026 21:36:17 +0000
Message-ID: <20260119213617.745603-1-jic23@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

commit 9904232ae30bc ("i3c: drop i3c_priv_xfer and i3c_device_do_priv_xfers()")
currently in the i3c/for-next tree removes the deprecated
struct i3c_priv_xfer and i3c_device_do_priv_xfers().

Switch to struct i3c_xfer and i3c_device_do_xfers(..., I3C_SDR)
now rather causing a build issue when both trees are merged.

Suggested-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jorge.marques@analog.com
---
I'm already carrying this on my tree to resolve the issue in next
but feedback still welcome!
---
 drivers/iio/adc/ad4062.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index a6b3ccc98acf..dd4ad32aa6f5 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -468,13 +468,13 @@ static int ad4062_set_operation_mode(struct ad4062_state *st,
 
 	if (mode == AD4062_MONITOR_MODE) {
 		/* Change address pointer to enter monitor mode */
-		struct i3c_priv_xfer xfer_trigger = {
+		struct i3c_xfer xfer_trigger = {
 			.data.out = &st->conv_addr,
 			.len = sizeof(st->conv_addr),
 			.rnw = false,
 		};
 		st->conv_addr = AD4062_REG_CONV_TRIGGER_32BITS;
-		return i3c_device_do_priv_xfers(st->i3cdev, &xfer_trigger, 1);
+		return i3c_device_do_xfers(st->i3cdev, &xfer_trigger, 1, I3C_SDR);
 	}
 
 	return regmap_write(st->regmap, AD4062_REG_MODE_SET,
@@ -607,18 +607,18 @@ static void ad4062_trigger_work(struct work_struct *work)
 	 * Read current conversion, if at reg CONV_READ, stop bit triggers
 	 * next sample and does not need writing the address.
 	 */
-	struct i3c_priv_xfer xfer_sample = {
+	struct i3c_xfer xfer_sample = {
 		.data.in = &st->buf.be32,
 		.len = st->conv_sizeof,
 		.rnw = true,
 	};
-	struct i3c_priv_xfer xfer_trigger = {
+	struct i3c_xfer xfer_trigger = {
 		.data.out = &st->conv_addr,
 		.len = sizeof(st->conv_addr),
 		.rnw = false,
 	};
 
-	ret = i3c_device_do_priv_xfers(st->i3cdev, &xfer_sample, 1);
+	ret = i3c_device_do_xfers(st->i3cdev, &xfer_sample, 1, I3C_SDR);
 	if (ret)
 		return;
 
@@ -627,7 +627,7 @@ static void ad4062_trigger_work(struct work_struct *work)
 	if (st->gpo_irq[1])
 		return;
 
-	i3c_device_do_priv_xfers(st->i3cdev, &xfer_trigger, 1);
+	i3c_device_do_xfers(st->i3cdev, &xfer_trigger, 1, I3C_SDR);
 }
 
 static irqreturn_t ad4062_poll_handler(int irq, void *p)
@@ -852,12 +852,12 @@ static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_int,
 static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
 {
 	struct i3c_device *i3cdev = st->i3cdev;
-	struct i3c_priv_xfer xfer_trigger = {
+	struct i3c_xfer xfer_trigger = {
 		.data.out = &st->conv_addr,
 		.len = sizeof(st->conv_addr),
 		.rnw = false,
 	};
-	struct i3c_priv_xfer xfer_sample = {
+	struct i3c_xfer xfer_sample = {
 		.data.in = &st->buf.be32,
 		.len = sizeof(st->buf.be32),
 		.rnw = true,
@@ -876,7 +876,7 @@ static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
 	reinit_completion(&st->completion);
 	/* Change address pointer to trigger conversion */
 	st->conv_addr = AD4062_REG_CONV_TRIGGER_32BITS;
-	ret = i3c_device_do_priv_xfers(i3cdev, &xfer_trigger, 1);
+	ret = i3c_device_do_xfers(i3cdev, &xfer_trigger, 1, I3C_SDR);
 	if (ret)
 		return ret;
 	/*
@@ -888,7 +888,7 @@ static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
 	if (!ret)
 		return -ETIMEDOUT;
 
-	ret = i3c_device_do_priv_xfers(i3cdev, &xfer_sample, 1);
+	ret = i3c_device_do_xfers(i3cdev, &xfer_sample, 1, I3C_SDR);
 	if (ret)
 		return ret;
 	*val = be32_to_cpu(st->buf.be32);
@@ -1236,7 +1236,7 @@ static int pm_ad4062_triggered_buffer_postenable(struct ad4062_state *st)
 	st->conv_sizeof = ad4062_sizeof_storagebits(st);
 	st->conv_addr = ad4062_get_conv_addr(st, st->conv_sizeof);
 	/* CONV_READ requires read to trigger first sample. */
-	struct i3c_priv_xfer xfer_sample[2] = {
+	struct i3c_xfer xfer_sample[2] = {
 		{
 			.data.out = &st->conv_addr,
 			.len = sizeof(st->conv_addr),
@@ -1249,8 +1249,8 @@ static int pm_ad4062_triggered_buffer_postenable(struct ad4062_state *st)
 		}
 	};
 
-	return i3c_device_do_priv_xfers(st->i3cdev, xfer_sample,
-					st->gpo_irq[1] ? 2 : 1);
+	return i3c_device_do_xfers(st->i3cdev, xfer_sample,
+				   st->gpo_irq[1] ? 2 : 1, I3C_SDR);
 }
 
 static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
-- 
2.52.0


