Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BC772C425
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jun 2023 14:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjFLMaa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jun 2023 08:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjFLMaW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jun 2023 08:30:22 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92E4E4E;
        Mon, 12 Jun 2023 05:30:10 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686573009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b7GpRi53x4asj1T+mG5YB9K5F5kbtkPlrvMMs/bfkeM=;
        b=Rz+Ii9wfAJ84Hru5tWVZ2BHscLeDldbI7wxcUWvnboDxxaqAepsmlmzMDX9eCAB2TVZerH
        vMam8AYocthmCfwmrQ5zzf/Y93M02RvKwhMsqypIx2AbNP2HGdaMCxVnlZ444fWwbIQEQE
        /0corWxCLXrXGWmdJIQJRpTLjRtnkqRNuu143YDtSO4by62DLn4EhwHjh46lW7pdz21EUO
        eisZ/tCTUrLPnY4dkmB116U0m3ruME+grhCRDdh0uHhfDnStL+8WwaudxayplAr5HRyChX
        eF9a14vvZJSlCmiLVI+oJnJpAziN/1vjPf5Qt3/kgs0AN3BfNlPzjewLGrkRIQ==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B5C65240008;
        Mon, 12 Jun 2023 12:30:00 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 04/12] iio: consumer.h: Fix raw values documentation notes
Date:   Mon, 12 Jun 2023 14:29:18 +0200
Message-Id: <20230612122926.107333-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612122926.107333-1-herve.codina@bootlin.com>
References: <20230612122926.107333-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The raw values notes mention 'ADC counts' and are not fully accurate.

Reword the notes in order to remove the 'ADC counts' and describe the
conversion needed between a raw value and a value in the standard units.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/consumer.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 6802596b017c..f536820b9cf2 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -201,8 +201,9 @@ struct iio_dev
  * @chan:		The channel being queried.
  * @val:		Value read back.
  *
- * Note raw reads from iio channels are in adc counts and hence
- * scale will need to be applied if standard units required.
+ * Note, if standard units are required, raw reads from iio channels
+ * need the offset (default 0) and scale (default 1) to be applied
+ * as (raw + offset) * scale.
  */
 int iio_read_channel_raw(struct iio_channel *chan,
 			 int *val);
@@ -212,8 +213,9 @@ int iio_read_channel_raw(struct iio_channel *chan,
  * @chan:		The channel being queried.
  * @val:		Value read back.
  *
- * Note raw reads from iio channels are in adc counts and hence
- * scale will need to be applied if standard units required.
+ * Note, if standard units are required, raw reads from iio channels
+ * need the offset (default 0) and scale (default 1) to be applied
+ * as (raw + offset) * scale.
  *
  * In opposit to the normal iio_read_channel_raw this function
  * returns the average of multiple reads.
@@ -281,8 +283,9 @@ int iio_read_channel_attribute(struct iio_channel *chan, int *val,
  * @chan:		The channel being queried.
  * @val:		Value being written.
  *
- * Note raw writes to iio channels are in dac counts and hence
- * scale will need to be applied if standard units required.
+ * Note that for raw writes to iio channels, if the value provided is
+ * in standard units, the affect of the scale and offset must be removed
+ * as (value / scale) - offset.
  */
 int iio_write_channel_raw(struct iio_channel *chan, int val);
 
@@ -292,8 +295,9 @@ int iio_write_channel_raw(struct iio_channel *chan, int val);
  * @chan:		The channel being queried.
  * @val:		Value read back.
  *
- * Note raw reads from iio channels are in adc counts and hence
- * scale will need to be applied if standard units are required.
+ * Note, if standard units are required, raw reads from iio channels
+ * need the offset (default 0) and scale (default 1) to be applied
+ * as (raw + offset) * scale.
  */
 int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
 
@@ -308,8 +312,9 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
  * For ranges, three vals are always returned; min, step and max.
  * For lists, all the possible values are enumerated.
  *
- * Note raw available values from iio channels are in adc counts and
- * hence scale will need to be applied if standard units are required.
+ * Note, if standard units are required, raw available values from iio
+ * channels need the offset (default 0) and scale (default 1) to be applied
+ * as (raw + offset) * scale.
  */
 int iio_read_avail_channel_raw(struct iio_channel *chan,
 			       const int **vals, int *length);
-- 
2.40.1

