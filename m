Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEFC72F6BE
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jun 2023 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjFNHtm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jun 2023 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243335AbjFNHth (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jun 2023 03:49:37 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD379170E;
        Wed, 14 Jun 2023 00:49:35 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686728974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rgrvFu84ZrZIMRnZAFcmpkUkbG8qISQlNfLp/T/UU5I=;
        b=oLJh22A5HuMXJQbcnfPT/Xol6viKiHPqVmtZge5Z0fe7d4zquT9pB8unrK400DQ1I+nyK7
        JD/t9ZiFEUbaYdZWgdPvmRUYW3B88gBtBCnMnPhY1K9M3NDQ5iKZyp8g6eFD7UdIVzAwuF
        9taeIDgJCoD7dw/g8YGHYC6zj6acJCjBhkBOAfw4gBqXgMybvOSSgIKjx3L1/D9FclY+3E
        1bc7EUIOwzK3Ow6TCaOSfLdhtMOUmvy0WPhirIUazKY3PKPbe6YKB6c3C8ELPb6vsp/TPH
        wYstIbvp1stsk3UYySWsafTQhiwskrbRdeUs5RaxZE56+j+GG2XWOKJEkqNM1w==
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
Received: by mail.gandi.net (Postfix) with ESMTPA id 29D061C0016;
        Wed, 14 Jun 2023 07:49:33 +0000 (UTC)
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
Subject: [PATCH v4 04/13] iio: consumer.h: Fix raw values documentation notes
Date:   Wed, 14 Jun 2023 09:48:55 +0200
Message-Id: <20230614074904.29085-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614074904.29085-1-herve.codina@bootlin.com>
References: <20230614074904.29085-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

