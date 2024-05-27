Return-Path: <linux-iio+bounces-5347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A08D05FB
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004EE1F227D5
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B7B73465;
	Mon, 27 May 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHYJIEpH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB461FF8;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823216; cv=none; b=cAeEDnhIyaOqoHRcp1eb5NUtk6mlkhYcsbHIe+KfcESECVcKQ3HjTngNix6MbmBWBLwQFdwebMiFdEnp+3EHa1fPNv6VZgYa+Q2MsNovree1MiUmJ/kMesuw4QSy0LASOmj0sVR4WDrwPrvTjP3kT1E7vF2TxlCPLYlaMM1Cac0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823216; c=relaxed/simple;
	bh=mZR6WGjhBRIUp1DvjTSkTj6PBfk83HjEYD3dZJuI26A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tW2Tt7cUkIC7K4BcG/USjoag/YO8+ssuvLMjwAh+Iflr9eH+BkLX8jro047tS0HM7AUc8lTc+4B6xFyXH0OMTdk9DUtpNv4O2sn2H31eHmuEDBBtSVkFOpPtHuhGxaKqgd5ZUxe4+crJDBSrv/B9x8Ca43Cpfc5SdYvxSUul8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHYJIEpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 506EEC4AF0D;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716823216;
	bh=mZR6WGjhBRIUp1DvjTSkTj6PBfk83HjEYD3dZJuI26A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EHYJIEpHL9/OS7TpqIGL2FxGYrTF2vS0D3WQ3bxVTERqeuTY2gbLocbZp1y8ZBKOn
	 vYdi22cSzu6QTBe5IlKJFeKisgrdWGUBNkXuWublMwSeBh4uo3J3p5R1hAbPeo4QX9
	 7QZJMTUuST7FXcnnn6Y2JX8Pr/0JJf7zQFtM3IxBKbaxZ44D/uR4y7CkXtWCOuFWsm
	 MjSMk3Q+5GRGuFRraOODpmnEhm+vFDb2dRlCNpG0WwH//rRBqlfsjCd01HI6ob/dEi
	 NKS4orJzbrufTybXcN5XljFdD22BmMDN4H+OWj4iz7pQkV+gZ+rJaREVjsea3Ez4Ka
	 7tHVDek/OXwkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4361FC27C44;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 27 May 2024 18:19:53 +0300
Subject: [PATCH v2 5/5] iio: adc: ad7173: Fix sampling frequency setting
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-ad7173-fixes-v2-5-8501b66adb1f@analog.com>
References: <20240527-ad7173-fixes-v2-0-8501b66adb1f@analog.com>
In-Reply-To: <20240527-ad7173-fixes-v2-0-8501b66adb1f@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716823214; l=2927;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=dDdO/qAAabV229bpLivTobOOzjAvKF9w+JcEWlTFL1A=;
 b=Zw+lJaM6gZoTMI1/Op0Dk7w4FE9AeHkL1i4oQWUL3o5t+R9U1ne7LfEQH4kpwYJexmE2EyO0A
 EPwv+MDC4d5B1cRV7azZWwQgG9JO+LVQadmgeChUvsbiJPvi+bv604o
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
 drivers/iio/adc/ad7173.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index e66a137a76be..ebacdacf64b9 100644
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
@@ -804,7 +795,7 @@ static const struct iio_chan_spec ad7173_channel_template = {
 	.type = IIO_VOLTAGE,
 	.indexed = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_SCALE),
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	.scan_type = {
 		.sign = 'u',
@@ -819,7 +810,8 @@ static const struct iio_chan_spec ad7173_temp_iio_channel_template = {
 	.channel = AD7173_AIN_TEMP_POS,
 	.channel2 = AD7173_AIN_TEMP_NEG,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	.scan_type = {
 		.sign = 'u',

-- 
2.43.0



