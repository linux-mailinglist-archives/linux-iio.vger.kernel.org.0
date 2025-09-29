Return-Path: <linux-iio+bounces-24568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D02CBAA02B
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 18:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF1B188D4A9
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9178C30B509;
	Mon, 29 Sep 2025 16:25:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A72144CF;
	Mon, 29 Sep 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163116; cv=none; b=NRYTawP9XkV5grz+dBm1Cz2mLl8gZZQMNqTwbhUfo5OZ7u7FFxiOEIIM8Tex7q3sPf369ijeBvX0mEQot/ft1KHpXRQ6LFHs6fn4deI+cREhMrTRPrOAw7pPQVO7eaBiRCgTSRhwnesPqKsYchEg3hDb0XlMWFunn0xP8lu6LrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163116; c=relaxed/simple;
	bh=QjHNJBNkPqQNINK+fdAh2UYmY1cG0XyouPMxXme8GhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPrc9LWGjvrX2QRwgbuM9Kfjr9jT9q6PD81eyQiChIl4TdYqefB/arL9dI43/oaKHN1oLWDzxSNtb3zxajamyNxUqEWmg7ayDMLzY0JmBgz1jMbkU4DDv2O0JdcOW0ie1miyj+uKWs1NjNaugpr4QgmD5Tsty0nKqfCRjdu+apc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [114.245.39.210])
	by APP-01 (Coremail) with SMTP id qwCowAD3UKPXstpoT7XhCA--.29927S2;
	Tue, 30 Sep 2025 00:24:57 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH v2] iio: adc: mt6360: Handle error in cleanup path correctly
Date: Tue, 30 Sep 2025 00:24:53 +0800
Message-ID: <20250929162453.1203-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20250929025358.2064-1-vulab@iscas.ac.cn>
References: <20250929025358.2064-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3UKPXstpoT7XhCA--.29927S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWxKryxuFW8ZrW3uF48WFg_yoW8uryfpr
	1YkFyqkFy8KFySka1xt3WUZFWFya17Kw4Fk34kCanFv3s8Ar1IgFyrGa4q934v9rZYyan0
	v3yUuFWUuw18ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRAAA2jan9oN4wABsC

The return value of a regmap_raw_write() and regmap_update_bits()
in the cleanup path was being ignored.

Fix this by checking the return value and warn on error.

Fixes: 1f4877218f7e ("iio: adc: mt6360: Add ADC driver for MT6360")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

---
Changes in v2:
 - Do not propagate cleanup path errors.
 - Log a warning on failure instead of overwriting the return value, as
   suggested by the maintainer.
 - Also check the return value of regmap_update_bits() for consistency.
---
 drivers/iio/adc/mt6360-adc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index 69b3569c90e5..9ee7247aacbe 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -70,6 +70,7 @@ static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int channel, int
 	ktime_t predict_end_t, timeout;
 	unsigned int pre_wait_time;
 	int ret;
+	int cleanup_ret;
 
 	mutex_lock(&mad->adc_lock);
 
@@ -130,11 +131,16 @@ static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int channel, int
 out_adc_conv:
 	/* Only keep ADC enable */
 	adc_enable = cpu_to_be16(MT6360_ADCEN_MASK);
-	regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, &adc_enable, sizeof(adc_enable));
+	cleanup_ret = regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG,
+				&adc_enable, sizeof(adc_enable));
+	if (cleanup_ret)
+		dev_warn(mad->dev, "Failed to reset ADC config: %d\n", cleanup_ret);
 	mad->last_off_timestamps[channel] = ktime_get();
 	/* Config prefer channel to NO_PREFER */
-	regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
+	cleanup_ret = regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
 			   MT6360_NO_PREFER << MT6360_PREFERCH_SHFT);
+	if (cleanup_ret)
+		dev_warn(mad->dev, "Failed to reset prefer channel: %d\n", cleanup_ret);
 out_adc_lock:
 	mutex_unlock(&mad->adc_lock);
 
-- 
2.50.1.windows.1


