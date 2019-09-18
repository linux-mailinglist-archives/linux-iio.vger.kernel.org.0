Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A174DB5E57
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 09:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfIRHxe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 03:53:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33358 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfIRHxe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 03:53:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so3544935pgn.0;
        Wed, 18 Sep 2019 00:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LsvbpETHylsMeIUTajAZCGUDIJ8fG7jkQ6/Zagal4f4=;
        b=IumcRAkxy5pZylIcDk2kk11lt/Kamjn4u4KN9e1isPm+S+UCnm3JlxVbOiZ46oXK4n
         BB/x+oxrFpErhPzc1KQOp/7hsPIzjCj/wZ9g0IE9FwXQwCxkd9IsjMPwGghqdxSVLkI/
         xOlbhDFJw5DSqaELCOyrE5u39asaHlXLvDVIzpsnCaHzCTJMVGIHvCMgqw1wL5t/fomj
         N//ewlufhfCWiM4m/DmfdTnc0pZWJxAl5iHcvmOSjJ4iFd2k8cHhHdJL0B6IwZdRDkkI
         1uGPxbb3wOTm2bQHBAV494FE66uu9zVh1aSrZpUf3oPKPpSuUQmj6hELuVVdHwEBWPGq
         db8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LsvbpETHylsMeIUTajAZCGUDIJ8fG7jkQ6/Zagal4f4=;
        b=MP4tSi3mfhJL3fwAH2B9QocOuvpt6iqiI6saJ40eTg3JDdFHMZn/SDZFJcV+LK+34d
         hnNO0CZvIznDH1pEf1V/20WCBQiC+uCqoBhA4EM2zQH/hlS5cm5CA9dDxjutxFaHH5rS
         RoQ9HP4zPfs+BOfL8A2tzBQNOeS26CG12yGDzFvp76mSEWKmRYEZ7A31Fap+y5cBf6JF
         bBurua2GUSblw6FtzN87kYn3K8XwbZbgEF/z4KEoD3+efvxy6bBGD65G7cUbJXSNUFjq
         HdAaXqOsCJDTVC3mC85JrpA30YRJYYHO56lorNNiHWbHqYnMjkP8NU/odZWlIpTQ+XoO
         2EqA==
X-Gm-Message-State: APjAAAXvitshNEFU672hlNF2HC2vWywt+L5ODByOHeuzFozeesZHtWh8
        mx2/FgK6ayMaf4XQ0DdpYOk=
X-Google-Smtp-Source: APXvYqz6bKFysyOYIsBhtp2Nnv9ivWYTyp7k2Sqz3xxBjGsrTUv0j48RIsG6BIg+26QoSnC9TG7lyQ==
X-Received: by 2002:a17:90a:e57:: with SMTP id p23mr2314170pja.126.1568793212976;
        Wed, 18 Sep 2019 00:53:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c147:d9df:f819:e399:825f:f2dc])
        by smtp.gmail.com with ESMTPSA id h8sm5580715pfo.64.2019.09.18.00.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 00:53:32 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 4/7] counter: 104-quad-8: Update count_read/count_write/signal_read callbacks
Date:   Wed, 18 Sep 2019 16:52:45 +0900
Message-Id: <44531823f947fffb12ceac17861a391a025dd229.1568792697.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568792697.git.vilhelm.gray@gmail.com>
References: <cover.1568792697.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The count_read and count_write callbacks pass unsigned long now, while
the signal_read callback passes an enum counter_signal_value.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 00b113f4b958..17e67a84777d 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -562,11 +562,10 @@ static const struct iio_chan_spec quad8_channels[] = {
 };
 
 static int quad8_signal_read(struct counter_device *counter,
-	struct counter_signal *signal, struct counter_signal_read_value *val)
+	struct counter_signal *signal, enum counter_signal_value *val)
 {
 	const struct quad8_iio *const priv = counter->priv;
 	unsigned int state;
-	enum counter_signal_level level;
 
 	/* Only Index signal levels can be read */
 	if (signal->id < 16)
@@ -575,22 +574,19 @@ static int quad8_signal_read(struct counter_device *counter,
 	state = inb(priv->base + QUAD8_REG_INDEX_INPUT_LEVELS)
 		& BIT(signal->id - 16);
 
-	level = (state) ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
-
-	counter_signal_read_value_set(val, COUNTER_SIGNAL_LEVEL, &level);
+	*val = (state) ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
 
 	return 0;
 }
 
 static int quad8_count_read(struct counter_device *counter,
-	struct counter_count *count, struct counter_count_read_value *val)
+	struct counter_count *count, unsigned long *val)
 {
 	const struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned int flags;
 	unsigned int borrow;
 	unsigned int carry;
-	unsigned long position;
 	int i;
 
 	flags = inb(base_offset + 1);
@@ -598,36 +594,27 @@ static int quad8_count_read(struct counter_device *counter,
 	carry = !!(flags & QUAD8_FLAG_CT);
 
 	/* Borrow XOR Carry effectively doubles count range */
-	position = (unsigned long)(borrow ^ carry) << 24;
+	*val = (unsigned long)(borrow ^ carry) << 24;
 
 	/* Reset Byte Pointer; transfer Counter to Output Latch */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
 	     base_offset + 1);
 
 	for (i = 0; i < 3; i++)
-		position |= (unsigned long)inb(base_offset) << (8 * i);
-
-	counter_count_read_value_set(val, COUNTER_COUNT_POSITION, &position);
+		*val |= (unsigned long)inb(base_offset) << (8 * i);
 
 	return 0;
 }
 
 static int quad8_count_write(struct counter_device *counter,
-	struct counter_count *count, struct counter_count_write_value *val)
+	struct counter_count *count, unsigned long val)
 {
 	const struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
-	int err;
-	unsigned long position;
 	int i;
 
-	err = counter_count_write_value_get(&position, COUNTER_COUNT_POSITION,
-					    val);
-	if (err)
-		return err;
-
 	/* Only 24-bit values are supported */
-	if (position > 0xFFFFFF)
+	if (val > 0xFFFFFF)
 		return -EINVAL;
 
 	/* Reset Byte Pointer */
@@ -635,7 +622,7 @@ static int quad8_count_write(struct counter_device *counter,
 
 	/* Counter can only be set via Preset Register */
 	for (i = 0; i < 3; i++)
-		outb(position >> (8 * i), base_offset);
+		outb(val >> (8 * i), base_offset);
 
 	/* Transfer Preset Register to Counter */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_PRESET_CNTR, base_offset + 1);
@@ -644,9 +631,9 @@ static int quad8_count_write(struct counter_device *counter,
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
 
 	/* Set Preset Register back to original value */
-	position = priv->preset[count->id];
+	val = priv->preset[count->id];
 	for (i = 0; i < 3; i++)
-		outb(position >> (8 * i), base_offset);
+		outb(val >> (8 * i), base_offset);
 
 	/* Reset Borrow, Carry, Compare, and Sign flags */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_FLAGS, base_offset + 1);
-- 
2.23.0

