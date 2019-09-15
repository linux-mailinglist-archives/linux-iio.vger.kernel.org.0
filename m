Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECE3B2E89
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 07:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfIOF6v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 01:58:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33159 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfIOF6s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2019 01:58:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id t11so15088262plo.0;
        Sat, 14 Sep 2019 22:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LsvbpETHylsMeIUTajAZCGUDIJ8fG7jkQ6/Zagal4f4=;
        b=g23mLma/2a6TaARGhUpC7gc6bpoYubqK0V9iy2PkfkRtOXM1F5gvrxfIiXhJBme5NI
         WV0cMLB3tZCevcXhcGXgFfhCz19PeWIau37uiY1B0OEEAyvnn+uVAmCuVZid9Uqqe+A1
         2MU8ASRmN8yamgq9wotT2olJRnlhRMtwQTl2TyyM79EP0ioLdj3EXiOtlx98xhN2m8H3
         ICvvZuF6lEhpVZ3b52ZBoBbOe8QeaJR0iws23FIumQKGOqIhznsh+H0K3jxbIVt7AvKd
         542a81zArZr3+QeGwmOsAGeL8FtdVAHI8iWzT4lzNMJPeIpySFm1aM6EXt5c7q3irRsQ
         f+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LsvbpETHylsMeIUTajAZCGUDIJ8fG7jkQ6/Zagal4f4=;
        b=QEpzJHc6C4R75VrsMqrONnvU37jE8By4XE2+WiSDxA2X1qjHF5HSKLa8ihBL9kcaiA
         kmSmiMHUnIcltzHP8n88q306hX24LfJuEytzDxw5hWCL5R4v+Hi9Bm63T2tO8l5vqYCB
         MMA6MP13Kz55gpomYVwA87EPYLVeFAqqW8rWab2VjfMRDQyteMVy/ztwCNCexMPZpdXE
         5KtBuU7jOY3/4gtnhQrUXosjn9Fp42FApulEprRa21UuuP9ahoBD6SmQ9gTzjamm0LiK
         wQ8nUpUGW03gyrrQL8F95J45FuS6e/QjnmmAfUunK1s59bg/TC6wN4kGnE/nsmhg6rnF
         4xzA==
X-Gm-Message-State: APjAAAXoe6WpOLJxqtYyycvHgl/OyHCsZoEP1MFrHoX2MqYBAdLh7Xj0
        /we98TBANEg5Q/GKoBMqk44=
X-Google-Smtp-Source: APXvYqwE0q5NRJrimFW4H90K69yTDrGNMv6VHcHSbTnWP2cDMJiiW65zcneGUxGeO/WAa8Oh297njQ==
X-Received: by 2002:a17:902:b607:: with SMTP id b7mr54622951pls.38.1568527127485;
        Sat, 14 Sep 2019 22:58:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c144:8b8a:e7a2:82ca:6689:77bb])
        by smtp.gmail.com with ESMTPSA id 22sm3696658pfj.139.2019.09.14.22.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 22:58:46 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RFC 4/4] counter: 104-quad-8: Update count_read/count_write/signal_read callbacks
Date:   Sun, 15 Sep 2019 14:57:59 +0900
Message-Id: <20190915055759.408690-5-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190915055759.408690-1-vilhelm.gray@gmail.com>
References: <20190915055759.408690-1-vilhelm.gray@gmail.com>
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

