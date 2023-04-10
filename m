Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61076DC79A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Apr 2023 16:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDJODm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Apr 2023 10:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDJODi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2023 10:03:38 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925183E8
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 07:03:22 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54ee9ad5eb3so95883727b3.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681135401; x=1683727401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdQnl5qfmdrfczumTIya8UGLjCsmRaV4klr0sIRkZJ8=;
        b=CCWSQ0PmElkcyprTIF4+bLV0N0ZsPTwQjZnrRV6+QZNaL55VikC4peBCWQENFJuhm7
         Tg8SA5XeF/LZ8C/w3ZtBBQET/DzWctxVye8h4c07IDETilmKPSLuojgt70M2FovZ/dTi
         t2KHks/DJgGRH3+KC9JxqnILuyQ1Bl4m5Sb5DwLD2JNdgddoSt6EpiguG9bY+krVovg3
         LACyXvx4NpJD8m7AtjwlEE7rrB/k+Z1VQe7AyXEEuAEMnzrzCCCYhNU1npEYfoCXqQW/
         j2wC4LLVht/XERoQYIGDHH3s8QwNoDQUHmFVquzRfxoDxcxAYNp2j+gfInpC/ADiECDY
         aTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681135401; x=1683727401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdQnl5qfmdrfczumTIya8UGLjCsmRaV4klr0sIRkZJ8=;
        b=dHwoedad7A6TaOs0jyLGk4HwNNueTgO0ooq//RxEViI8X9id+PI5A5trfUjz0FZ961
         nQh6hq376W/APa2bMO3CUuqsxiZNcWROktnqXZSoMIpi/WCl+eI6eQi0g5tESAqRK3TX
         71hecSNRo36U/F1Z9DyWjAff3XRHnKu3T3h6tl26tba7DSeU8RtQ/woDh18AGNI79jf8
         wcvZAjBxct2DPmwZTj+C6V4awIvrky3orHheBNrUHkzCuRi5m0SrnCQ6NVPH/wKWc2s4
         NvKONoo4qa5h3xk0Jm6+uZXR74JVlWf1ZWYFmjPOGbTngIhDFwNo0pJvBu3AVopIcJEF
         Q+og==
X-Gm-Message-State: AAQBX9eZQKW+5M4v3ox1Q4cNIkxNLmEzDW+/XFGsglcZw4Auf8+zkNqf
        Czq9wySJG/I2lmJ16WHLaRENSjSDMlDWcEqJ6kHZ8Q==
X-Google-Smtp-Source: AKy350ZXQzu0NNBRVe7E82/H/DPmANFnzQxVyeaXAWfN/6op4Gl0CvtK3w2LO97Pmw+EjFBXiP3mjQ==
X-Received: by 2002:a81:5b89:0:b0:543:1dc1:828b with SMTP id p131-20020a815b89000000b005431dc1828bmr8091878ywb.33.1681135401568;
        Mon, 10 Apr 2023 07:03:21 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cm24-20020a05690c0c9800b00545a08184c8sm2821000ywb.88.2023.04.10.07.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 07:03:21 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 3/3] counter: 104-quad-8: Utilize helper functions to handle PR, FLAG and PSC
Date:   Mon, 10 Apr 2023 10:03:13 -0400
Message-Id: <669c8f782f11fe27c4568e4fc3ba459c4f954874.1681134558.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681134558.git.william.gray@linaro.org>
References: <cover.1681134558.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Preset Register (PR), Flag Register (FLAG), and Filter Clock
Prescaler (PSC) have common usage patterns. Wrap up such usage into
dedicated functions to improve code clarity.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v3: none
Changes in v2:
 - Utilize ioread8_rep() and iowrite8_rep() to read and write counter
   data

 drivers/counter/104-quad-8.c | 87 +++++++++++++++---------------------
 1 file changed, 37 insertions(+), 50 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 0188c9c4e4cb..c171d0a80ef9 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -232,52 +232,56 @@ static int quad8_count_read(struct counter_device *counter,
 	struct quad8 *const priv = counter_priv(counter);
 	struct channel_reg __iomem *const chan = priv->reg->channel + count->id;
 	unsigned long irqflags;
-	int i;
 
 	*val = 0;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_CNTR_TO_OL, &chan->control);
-
-	for (i = 0; i < 3; i++)
-		*val |= (unsigned long)ioread8(&chan->data) << (8 * i);
+	ioread8_rep(&chan->data, val, 3);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
 	return 0;
 }
 
+static void quad8_preset_register_set(struct quad8 *const priv, const size_t id,
+				      const unsigned long preset)
+{
+	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
+	iowrite8_rep(&chan->data, &preset, 3);
+}
+
+static void quad8_flag_register_reset(struct quad8 *const priv, const size_t id)
+{
+	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+
+	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
+	iowrite8(SELECT_RLD | RESET_E, &chan->control);
+}
+
 static int quad8_count_write(struct counter_device *counter,
 			     struct counter_count *count, u64 val)
 {
 	struct quad8 *const priv = counter_priv(counter);
 	struct channel_reg __iomem *const chan = priv->reg->channel + count->id;
 	unsigned long irqflags;
-	int i;
 
 	if (val > LS7267_CNTR_MAX)
 		return -ERANGE;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-
 	/* Counter can only be set via Preset Register */
-	for (i = 0; i < 3; i++)
-		iowrite8(val >> (8 * i), &chan->data);
-
+	quad8_preset_register_set(priv, count->id, val);
 	iowrite8(SELECT_RLD | TRANSFER_PR_TO_CNTR, &chan->control);
 
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
+	quad8_flag_register_reset(priv, count->id);
 
 	/* Set Preset Register back to original value */
-	val = priv->preset[count->id];
-	for (i = 0; i < 3; i++)
-		iowrite8(val >> (8 * i), &chan->data);
-
-	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
-	iowrite8(SELECT_RLD | RESET_E, &chan->control);
+	quad8_preset_register_set(priv, count->id, priv->preset[count->id]);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -771,21 +775,6 @@ static int quad8_count_preset_read(struct counter_device *counter,
 	return 0;
 }
 
-static void quad8_preset_register_set(struct quad8 *const priv, const int id,
-				      const unsigned int preset)
-{
-	struct channel_reg __iomem *const chan = priv->reg->channel + id;
-	int i;
-
-	priv->preset[id] = preset;
-
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-
-	/* Set Preset Register */
-	for (i = 0; i < 3; i++)
-		iowrite8(preset >> (8 * i), &chan->data);
-}
-
 static int quad8_count_preset_write(struct counter_device *counter,
 				    struct counter_count *count, u64 preset)
 {
@@ -797,6 +786,7 @@ static int quad8_count_preset_write(struct counter_device *counter,
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
+	priv->preset[count->id] = preset;
 	quad8_preset_register_set(priv, count->id, preset);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
@@ -843,6 +833,7 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 	switch (u8_get_bits(priv->cmr[count->id], COUNT_MODE)) {
 	case RANGE_LIMIT:
 	case MODULO_N:
+		priv->preset[count->id] = ceiling;
 		quad8_preset_register_set(priv, count->id, ceiling);
 		spin_unlock_irqrestore(&priv->lock, irqflags);
 		return 0;
@@ -961,24 +952,28 @@ static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
 	return 0;
 }
 
+static void quad8_filter_clock_prescaler_set(struct quad8 *const priv, const size_t id,
+					     const u8 prescaler)
+{
+	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
+	iowrite8(prescaler, &chan->data);
+	iowrite8(SELECT_RLD | TRANSFER_PR0_TO_PSC, &chan->control);
+}
+
 static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
 					    struct counter_signal *signal,
 					    u8 prescaler)
 {
 	struct quad8 *const priv = counter_priv(counter);
 	const size_t channel_id = signal->id / 2;
-	struct channel_reg __iomem *const chan = priv->reg->channel + channel_id;
 	unsigned long irqflags;
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
 	priv->fck_prescaler[channel_id] = prescaler;
-
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-
-	/* Set filter clock factor */
-	iowrite8(prescaler, &chan->data);
-	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_PR0_TO_PSC, &chan->control);
+	quad8_filter_clock_prescaler_set(priv, channel_id, prescaler);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -1178,18 +1173,10 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 static void quad8_init_counter(struct quad8 *const priv, const size_t channel)
 {
 	struct channel_reg __iomem *const chan = priv->reg->channel + channel;
-	unsigned long i;
 
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-	/* Reset filter clock factor */
-	iowrite8(0, &chan->data);
-	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_PR0_TO_PSC, &chan->control);
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-	/* Reset Preset Register */
-	for (i = 0; i < 3; i++)
-		iowrite8(0x00, &chan->data);
-	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
-	iowrite8(SELECT_RLD | RESET_E, &chan->control);
+	quad8_filter_clock_prescaler_set(priv, channel, 0);
+	quad8_preset_register_set(priv, channel, 0);
+	quad8_flag_register_reset(priv, channel);
 
 	/* Binary encoding; Normal count; non-quadrature mode */
 	priv->cmr[channel] = SELECT_CMR | BINARY | u8_encode_bits(NORMAL_COUNT, COUNT_MODE) |
-- 
2.39.2

