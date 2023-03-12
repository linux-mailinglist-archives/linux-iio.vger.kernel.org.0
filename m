Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0E26B6C7A
	for <lists+linux-iio@lfdr.de>; Mon, 13 Mar 2023 00:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCLXQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 19:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLXQR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 19:16:17 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3104327D72
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 16:16:15 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id cz13so464047qvb.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678662974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8b35TlVLwc8Sn7ZUBoVNCvt/IPK58Jissfx4Uxljug=;
        b=Q3UJgXN8SqUOOQzmoWlEYuWnWxqDpR2YRmndObkq0k6jeii7ykhFyA0VXlq1Hv9B/d
         H7srsVf7k+f1Y65foBIOs9MtLJApq1XFVNtoXGRfdyhm+BP5GXH7oEERJ378p2HsDELf
         VZ2nW4s6A4rp8PVKTVrOPUxAxSIL2Gwj0PV4aw1VD+2MVqROmVuZh/ZT069wyz9EE4Z3
         OmaZP2AYprOQ1Szy9sg4g6bG2Pa4kGSdyYn9GuboJeK9cqnZZyYsWYV+L9KdbqvydQmk
         aq6V1eUpIci+hkQYskMG9GvzIRAvJSOVDq8h91jwNpsAJJIOsYUwuxpnV8uwoNlRgtKb
         lcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678662974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8b35TlVLwc8Sn7ZUBoVNCvt/IPK58Jissfx4Uxljug=;
        b=l2CltQIO0vwcBPoCXgb3nFGshqLlX2lJwluD23Rj7Ai35I3gLx5yPB5U4l2lWN6rlH
         NGq8NAoztIegSMoejz7SRWW9HyrcumE8J6WX5+fcvkvRg9iRhp+qVEx+n5f7ZVKGpW7V
         a9t2HLFofbjSej14cnKPtftCJplr+1rlsWtrsPv4h4vZfN0Nt9XhUEHo2z2h6IR0ci9x
         aBJ2Q9M33sXlc9BA3RigGVsZc0XaF3A3mVHOJUTWsUyCZuV44turxBUtGb6wtlITlo8s
         CAeI/Jo0CtgiUCneLgh9+d2ZNt0oj+Y10bt5nKWNx6nCo0F/14P2wnpgy4NMczSIDUDe
         FKKA==
X-Gm-Message-State: AO0yUKWko06WWmlYmX7AzJGon2BJAYOg73S9nrQzbEmbMboINr4g9Qyj
        XzW6i+1XoQUJgpAFhYvkcWoYhb/Qaeo1WIfrNOU=
X-Google-Smtp-Source: AK7set8qhhF7wHcTTBx/iWbo8fMfYcdSC9CXEpBiNnKBI9VNL+8RJcl/KQ7f/lK6iUda5pkecOme0Q==
X-Received: by 2002:a05:6214:1cc9:b0:5a3:fd18:e734 with SMTP id g9-20020a0562141cc900b005a3fd18e734mr5302463qvd.35.1678662974109;
        Sun, 12 Mar 2023 16:16:14 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id dm21-20020a05620a1d5500b00742f250ebc0sm4307091qkb.9.2023.03.12.16.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 16:16:13 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        William Breathitt Gray <william.gray@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.19 v3 5/6] iio: counter: 104-quad-8: Fix race condition between FLAG and CNTR reads
Date:   Sun, 12 Mar 2023 19:15:53 -0400
Message-Id: <20230312231554.134858-5-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312231554.134858-1-william.gray@linaro.org>
References: <20230312231554.134858-1-william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Counter (CNTR) register is 24 bits wide, but we can have an
effective 25-bit count value by setting bit 24 to the XOR of the Borrow
flag and Carry flag. The flags can be read from the FLAG register, but a
race condition exists: the Borrow flag and Carry flag are instantaneous
and could change by the time the count value is read from the CNTR
register.

Since the race condition could result in an incorrect 25-bit count
value, remove support for 25-bit count values from this driver.

Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
Cc: <stable@vger.kernel.org> # 4.19.x
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/counter/104-quad-8.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index 92be8d0f7..92e68cada 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -61,10 +61,6 @@ struct quad8_iio {
 
 #define QUAD8_REG_CHAN_OP 0x11
 #define QUAD8_REG_INDEX_INPUT_LEVELS 0x16
-/* Borrow Toggle flip-flop */
-#define QUAD8_FLAG_BT BIT(0)
-/* Carry Toggle flip-flop */
-#define QUAD8_FLAG_CT BIT(1)
 /* Error flag */
 #define QUAD8_FLAG_E BIT(4)
 /* Up/Down flag */
@@ -97,9 +93,6 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 {
 	struct quad8_iio *const priv = iio_priv(indio_dev);
 	const int base_offset = priv->base + 2 * chan->channel;
-	unsigned int flags;
-	unsigned int borrow;
-	unsigned int carry;
 	int i;
 
 	switch (mask) {
@@ -110,12 +103,7 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT;
 		}
 
-		flags = inb(base_offset + 1);
-		borrow = flags & QUAD8_FLAG_BT;
-		carry = !!(flags & QUAD8_FLAG_CT);
-
-		/* Borrow XOR Carry effectively doubles count range */
-		*val = (borrow ^ carry) << 24;
+		*val = 0;
 
 		/* Reset Byte Pointer; transfer Counter to Output Latch */
 		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,

base-commit: 6a98afd74b4c2016fb87f5c3b7ce1c53ac215c13
-- 
2.39.2

