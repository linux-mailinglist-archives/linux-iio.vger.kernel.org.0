Return-Path: <linux-iio+bounces-5499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FF48D4B4D
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 14:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B341C22389
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 12:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA0183A96;
	Thu, 30 May 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ik3hzkB+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B94183A84;
	Thu, 30 May 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070884; cv=none; b=joYqLWpmJ4TtRvjIUdNvmQ2KnLEC83A65v8dB9YS0s5ZQorZK0Y5PJ01yvrInGGpyIK31YhAZbzKEgmlIy9N3JzD/abQ7JKk2vNBH9d3j9mIOwjEE0lf9IT1BuNKk3X7vRXhWASsqBsDXIaoMhOBUyL+YfkNZO+lG8NQ0fvqq/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070884; c=relaxed/simple;
	bh=NGupSVFAf3w4i+B0v6O8ZHgy6jsWt10FDsN0sCp/Jv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XEN4YzYyK8kacxtIPLfemilqwiFNxed6r5l3GQxyc40yofwz6hP8HC1o/LgAYlYMhhvHCSHDE4fWENhTRMiaFsYsLafPZ6Rn6VxrpYWF93yV4i/oW7E8J2cKYwqiJaAKYx+Jc6Vi4HFv0AwtjONJziV7I6ToOGHq9LuDSvkMoWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ik3hzkB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25E15C4AF0A;
	Thu, 30 May 2024 12:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717070884;
	bh=NGupSVFAf3w4i+B0v6O8ZHgy6jsWt10FDsN0sCp/Jv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ik3hzkB+9mYBamTB93UN+zjnXx+a/wgxzF7Mm8b9vQBS+pc4Me5N8QrLbcsnoceho
	 vrrPfHMUMDgfiPhbxVOQ+kKO/fwtPlojRlErrhCU1reQfXg9RwlDtgoLh7d7tVtfm1
	 vIM9xZCPVrr2LhbZPXMmOMcvFBYOWdgemwTKLqU0wsb6W11QAaLLM3dfWHic6v/eGd
	 uQmWMKhhAXCm5R7a4cfFcdy++ahXmcOBu5QtFIk0m2FN3la/vmTxzAL81+K4VsW3c4
	 m/sGa8ajWbjfufjofU+CAFHcTLxyjMnYrMRX6g39POlhaQ+B0WWp2GUuO2aZuBpPha
	 tgeUXAPuh6hcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEF3C25B74;
	Thu, 30 May 2024 12:08:04 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Thu, 30 May 2024 15:07:53 +0300
Subject: [PATCH v3 5/5] iio: adc: ad7173: Fix sampling frequency setting
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-ad7173-fixes-v3-5-b85f33079e18@analog.com>
References: <20240530-ad7173-fixes-v3-0-b85f33079e18@analog.com>
In-Reply-To: <20240530-ad7173-fixes-v3-0-b85f33079e18@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717070881; l=2969;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=SBPCEDIHiCkBTrkchaltcj60L2/HmJ7NW2rt8H7uZxM=;
 b=1yI8EuMNC1kGPCv+tv4qpgt9g1y7ShB+N4rgprlmp+0NraSAwqk4cxA7tfpVxGYlbztHEub0w
 3gVkgAXonMJAdtMh4xcWYt0oz0VLNdOjvpi2DvO9z3NmxYa60LMCN+Z
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

This patch fixes two issues regarding the sampling frequency setting:
-The attribute was set as per device, not per channel. As such, when
 setting the sampling frequency, the configuration was always done for
 the slot 0, and the correct configuration was applied on the next
 channel configuration call by the LRU mechanism.
-The LRU implementation does not take into account external settings of
 the slot registers. When setting the sampling frequency directly to a
 slot register in write_raw(), there is no guarantee that other channels
 were not also using that slot and now incorrectly retain their config
 as live.

Set the sampling frequency attribute as separate in the channel templates.
Do not set the sampling directly to the slot register in write_raw(),
just mark the config as not live and let the LRU mechanism handle it.
As the reg variable is no longer used, remove it.

Fixes: 8eb903272f75 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index e66a137a76be..ebf248741b34 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -717,7 +717,7 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
 	struct ad7173_channel_config *cfg;
-	unsigned int freq, i, reg;
+	unsigned int freq, i;
 	int ret;
 
 	ret = iio_device_claim_direct_mode(indio_dev);
@@ -733,16 +733,7 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 
 		cfg = &st->channels[chan->address].cfg;
 		cfg->odr = i;
-
-		if (!cfg->live)
-			break;
-
-		ret = ad_sd_read_reg(&st->sd, AD7173_REG_FILTER(cfg->cfg_slot), 2, &reg);
-		if (ret)
-			break;
-		reg &= ~AD7173_FILTER_ODR0_MASK;
-		reg |= FIELD_PREP(AD7173_FILTER_ODR0_MASK, i);
-		ret = ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(cfg->cfg_slot), 2, reg);
+		cfg->live = false;
 		break;
 
 	default:
@@ -804,8 +795,7 @@ static const struct iio_chan_spec ad7173_channel_template = {
 	.type = IIO_VOLTAGE,
 	.indexed = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_SCALE),
-	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	.scan_type = {
 		.sign = 'u',
 		.realbits = 24,
@@ -819,8 +809,8 @@ static const struct iio_chan_spec ad7173_temp_iio_channel_template = {
 	.channel = AD7173_AIN_TEMP_POS,
 	.channel2 = AD7173_AIN_TEMP_NEG,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
-	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	.scan_type = {
 		.sign = 'u',
 		.realbits = 24,

-- 
2.43.0



