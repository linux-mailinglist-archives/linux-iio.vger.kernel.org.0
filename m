Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E446BFB14
	for <lists+linux-iio@lfdr.de>; Sat, 18 Mar 2023 16:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCRPAT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Mar 2023 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCRPAL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2023 11:00:11 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA59D1732
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 08:00:07 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id x8so5228958qvr.9
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679151607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXfM00mo0HtvYmARgZGGmzedJH8cTX6iteEFQYzBrCw=;
        b=WNREniN2ojUGOYozJxFtJjRuS8Z9IqJ5NzmUmf9PmhfTImeoBHK38AZ8SN+8pEFsGn
         BoHDnQRAapOjZeYZ44IXeE1hO3+PC7ueblRfzZ507A7GvQBh8A31GJoSD62qFlzhbTCW
         hvuOJnqcZhLCYCyg/bav+76IIXY3YzlttYG1gzv9HBZ0f6XlAB7TPvlvud+1YUHuI1Fl
         dlDSocx32UCvcdOzlUj2JjbS2T59oth7ByZEsCeGDqbONBjG1wm9SkqRZYRpJOjksQ+8
         Mtf5zn09KQ2HOIa4ly69E485YiE45WSrjBUpJJeCsA+FiQjgw1/4HLw6eGynLJuql7jM
         DoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679151607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXfM00mo0HtvYmARgZGGmzedJH8cTX6iteEFQYzBrCw=;
        b=yJP0rWuD4r0btDtFIbyd248kAFQhpw0cctnY21Eac4staEKVnuef2iS3+u/eoKvs9W
         lXyH/gLOoZEv4XkuiAWL7nTJx8O+FrqH5g5alDoENWtklso07YWgBYmQFILyQ16deQsw
         h+ysr+qIxrZiVbKeWEuUxPfk2hBUgHf12UizpBgqezgE45JDnBDE6EgR2Oi5URWQ/3LQ
         Gm5SZN4qdXwnVooIu9agt12gfojzuwKCGUsz+hyAwGrXFK+hHkM1/maeP1eg5jrDmQXl
         VjAF/1Kbwf253PkH7v1D4Ts538JKo4wIZC553G74OD+rn/DkG1FhY4lOKHlOd8eaVste
         6gzw==
X-Gm-Message-State: AO0yUKX246Pcz7nSYilS34cGwe05O+UyLS+ffnkqRHzq22+Tgr7g2XPz
        n/XWZK6KfVo1XKjcgNbAa3pjXPwlGZ+SQm1HPpw=
X-Google-Smtp-Source: AK7set906xVFgX9ACPX1zAMSAhZxsUlLEHHBJ6Wduf/YakrC/S+qCsm4JHTliVb5UEOJ1Im7zrHtgw==
X-Received: by 2002:ad4:5c81:0:b0:5ab:df2b:6474 with SMTP id o1-20020ad45c81000000b005abdf2b6474mr33473054qvh.5.1679151606637;
        Sat, 18 Mar 2023 08:00:06 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id f67-20020a37d246000000b00745daadd210sm3709162qkj.71.2023.03.18.08.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:00:06 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 4/4] counter: 104-quad-8: Utilize helper functions to handle PR, FLAG and PSC
Date:   Sat, 18 Mar 2023 10:59:51 -0400
Message-Id: <71496f9295e68388ce07f3051bf5882177be83c5.1679149543.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679149542.git.william.gray@linaro.org>
References: <cover.1679149542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/counter/104-quad-8.c | 103 +++++++++++++++--------------------
 1 file changed, 45 insertions(+), 58 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 796f02fc53b8..27ec905ebe85 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -241,41 +241,49 @@ static int quad8_count_read(struct counter_device *counter,
 	return 0;
 }
 
+static void quad8_preset_register_set(struct quad8 *const priv, const size_t id,
+				      const unsigned long preset)
+{
+	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+	int i;
+
+	/* Reset Byte Pointer */
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
+
+	/* Set Preset Register */
+	for (i = 0; i < 3; i++)
+		iowrite8(preset >> (8 * i), &chan->data);
+}
+
+static void quad8_flag_register_reset(struct quad8 *const priv, const size_t id)
+{
+	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+
+	/* Reset Borrow, Carry, Compare, and Sign flags */
+	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
+	/* Reset Error flag */
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
 
-	/* Reset Byte Pointer */
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-
 	/* Counter can only be set via Preset Register */
-	for (i = 0; i < 3; i++)
-		iowrite8(val >> (8 * i), &chan->data);
-
+	quad8_preset_register_set(priv, count->id, val);
 	/* Transfer Preset Register to Counter */
 	iowrite8(SELECT_RLD | TRANSFER_PR_TO_CNTR, &chan->control);
-
-	/* Reset Byte Pointer */
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-
+	quad8_flag_register_reset(priv, count->id);
 	/* Set Preset Register back to original value */
-	val = priv->preset[count->id];
-	for (i = 0; i < 3; i++)
-		iowrite8(val >> (8 * i), &chan->data);
-
-	/* Reset Borrow, Carry, Compare, and Sign flags */
-	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
-	/* Reset Error flag */
-	iowrite8(SELECT_RLD | RESET_E, &chan->control);
+	quad8_preset_register_set(priv, count->id, priv->preset[count->id]);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -791,22 +799,6 @@ static int quad8_count_preset_read(struct counter_device *counter,
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
-	/* Reset Byte Pointer */
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
@@ -818,6 +810,7 @@ static int quad8_count_preset_write(struct counter_device *counter,
 
 	spin_lock_irqsave(&priv->lock, irqflags);
 
+	priv->preset[count->id] = preset;
 	quad8_preset_register_set(priv, count->id, preset);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
@@ -864,6 +857,7 @@ static int quad8_count_ceiling_write(struct counter_device *counter,
 	switch (FIELD_GET(COUNT_MODE, priv->cmr[count->id])) {
 	case RANGE_LIMIT:
 	case MODULO_N:
+		priv->preset[count->id] = ceiling;
 		quad8_preset_register_set(priv, count->id, ceiling);
 		spin_unlock_irqrestore(&priv->lock, irqflags);
 		return 0;
@@ -985,25 +979,30 @@ static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
 	return 0;
 }
 
+static void quad8_filter_clock_prescaler_set(struct quad8 *const priv, const size_t id,
+					     const u8 prescaler)
+{
+	struct channel_reg __iomem *const chan = priv->reg->channel + id;
+
+	/* Reset Byte Pointer */
+	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
+	/* Reset filter clock factor */
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
-	/* Reset Byte Pointer */
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-
-	/* Set filter clock factor */
-	iowrite8(prescaler, &chan->data);
-	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_PR0_TO_PSC, &chan->control);
+	quad8_filter_clock_prescaler_set(priv, channel_id, prescaler);
 
 	spin_unlock_irqrestore(&priv->lock, irqflags);
 
@@ -1203,22 +1202,10 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
 static void quad8_init_counter(struct quad8 *const priv, const size_t channel)
 {
 	struct channel_reg __iomem *const chan = priv->reg->channel + channel;
-	unsigned long i;
 
-	/* Reset Byte Pointer */
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-	/* Reset filter clock factor */
-	iowrite8(0, &chan->data);
-	iowrite8(SELECT_RLD | RESET_BP | TRANSFER_PR0_TO_PSC, &chan->control);
-	/* Reset Byte Pointer */
-	iowrite8(SELECT_RLD | RESET_BP, &chan->control);
-	/* Reset Preset Register */
-	for (i = 0; i < 3; i++)
-		iowrite8(0x00, &chan->data);
-	/* Reset Borrow, Carry, Compare, and Sign flags */
-	iowrite8(SELECT_RLD | RESET_BT_CT_CPT_S_IDX, &chan->control);
-	/* Reset Error flag */
-	iowrite8(SELECT_RLD | RESET_E, &chan->control);
+	quad8_filter_clock_prescaler_set(priv, channel, 0);
+	quad8_preset_register_set(priv, channel, 0);
+	quad8_flag_register_reset(priv, channel);
 
 	/* Binary encoding; Normal count; non-quadrature mode */
 	priv->cmr[channel] = SELECT_CMR | BINARY | FIELD_PREP(COUNT_MODE, NORMAL_COUNT) |
-- 
2.39.2

