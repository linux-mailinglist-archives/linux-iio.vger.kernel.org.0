Return-Path: <linux-iio+bounces-2946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720708611D8
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 13:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0571C20F9A
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 12:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94007EEEF;
	Fri, 23 Feb 2024 12:46:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E217BAF8
	for <linux-iio@vger.kernel.org>; Fri, 23 Feb 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692373; cv=none; b=bbqULgRi7717uxZ8/RS0gS1W/N228EddWI4izZHtxURjsJKL2RoHSw7r1kSRUO5ctFn3yD1hMkY1fZ3m6KYDXqaOAnMkcOidrfCCtHSigHR/GCxZoQ3hAr26tWyu1/KX8Icn2Ts4VcHRTbjWrMKRA2ej1hOaxV5lzCUhp0v3j+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692373; c=relaxed/simple;
	bh=K5SKHZ8edZFBOjaMQ5a+FjeaN0WmRn9O5VzcpKzw93w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=syQtoPOR4KS47U6su0lu2lzuggJWBuPcT7NbzZ3l6iVIu0IFeDlkhnOPzaF/TbiwqpBMvh9zgo6tqo958p9VSL0XZfh494cd93mIAvoxq/E5a58dz3aiZn1TIwGVvcErkLdSw0A4bMUbtCGGJwOlsbZ/ahY66C8H+nJzuRXjf3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Th8rV3Qr6zGMT;
	Fri, 23 Feb 2024 13:46:02 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Th8rT5JLQzv7F;
	Fri, 23 Feb 2024 13:46:01 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 23 Feb 2024 13:45:22 +0100
Subject: [PATCH 2/3] iio: adc: rockchip_saradc: use mask for write_enable
 bitfield
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-saradcv2-chan-mask-v1-2-84b06a0f623a@theobroma-systems.com>
References: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
In-Reply-To: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Heiko Stuebner <heiko@sntech.de>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Shreeya Patel <shreeya.patel@collabora.com>, Simon Xue <xxm@rock-chips.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+kernel@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Some of the registers on the SARADCv2 have bits write protected except
if another bit is set. This is usually done by having the lowest 16 bits
store the data to write and the highest 16 bits specify which of the 16
lowest bits should have their value written to the hardware block.

The write_enable mask for the channel selection was incorrect because it
was just the value shifted by 16 bits, which means it would only ever
write bits and never clear them. So e.g. if someone starts a conversion
on channel 5, the lowest 4 bits would be 0x5, then starts a conversion
on channel 0, it would still be 5.

Instead of shifting the value by 16 as the mask, let's use the OR'ing of
the appropriate masks shifted by 16.

Note that this is not an issue currently because the only SARADCv2
currently supported has a reset defined in its Device Tree, that reset
resets the SARADC controller before starting a conversion on a channel.
However, this reset is handled as optional by the probe function and
thus proper masking should be used in the event an SARADCv2 without a
reset ever makes it upstream.

Fixes: 757953f8ec69 ("iio: adc: rockchip_saradc: Add support for RK3588")
Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/iio/adc/rockchip_saradc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 2da8d6f3241a..1c0042fbbb54 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -102,12 +102,12 @@ static void rockchip_saradc_start_v2(struct rockchip_saradc *info, int chn)
 	writel_relaxed(0xc, info->regs + SARADC_T_DAS_SOC);
 	writel_relaxed(0x20, info->regs + SARADC_T_PD_SOC);
 	val = FIELD_PREP(SARADC2_EN_END_INT, 1);
-	val |= val << 16;
+	val |= SARADC2_EN_END_INT << 16;
 	writel_relaxed(val, info->regs + SARADC2_END_INT_EN);
 	val = FIELD_PREP(SARADC2_START, 1) |
 	      FIELD_PREP(SARADC2_SINGLE_MODE, 1) |
 	      FIELD_PREP(SARADC2_CONV_CHANNELS, chn);
-	val |= val << 16;
+	val |= (SARADC2_START | SARADC2_SINGLE_MODE | SARADC2_CONV_CHANNELS) << 16;
 	writel(val, info->regs + SARADC2_CONV_CON);
 }
 

-- 
2.43.2


