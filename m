Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAB46B6C7C
	for <lists+linux-iio@lfdr.de>; Mon, 13 Mar 2023 00:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCLXQ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 19:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCLXQR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 19:16:17 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2906C26C26
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 16:16:16 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r16so11543348qtx.9
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 16:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678662975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+Xk38KToa9bLZ6GwBjSbY6igY/qtneGnbAW3uwQlQw=;
        b=U5pJuR0FMiFRS8bVo2GOsYZw6KlCjiOm64xYJ7EsPXNq4+kW1OSzlnkR5T2G0Qsn/c
         uCdqbxAR/2G+glvS2laXxoATTfUFu99/ftiKM7EwNMC0O9rJmgrRF7TZJHJ/FlY7feQy
         zi5xRusoeLoh+QfohFaHWKPJ2eJ4d9+xA2Gr8/6Cvzn2QM1EBkWn/lPUuYToW/w0bwy6
         xXibemPInuK1hSIBio8IVyMMglu6S47xBIRttlIY7pKXT3JlFxgSAG0zI1Zn6Y+ahngw
         2aAlFcP/0SpbdOESBiv60hJKFrhgrBmQZ2CM+3A0XAehlwtkQDrVNuo3prN5uYvsJKM6
         uP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678662975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+Xk38KToa9bLZ6GwBjSbY6igY/qtneGnbAW3uwQlQw=;
        b=EQqwjW5J5ZYQjTaRha3gfmlIm7b65rCjgmYMUsfxUfp4uw6PpImI45RKcAfzPH00AV
         OFnyzjUf0cvU4OOYkLH9tQhEV+ADNdRU0JwBmyybfD9GYnc7hxVu1anSz/ABk4Kg3v3T
         ek+NcSHetQ/6zvZXO++nfSXtAiNkVeB+Ih6NOSZL10Ly5Rr+ThW4ahijHImQ4lw2h2eP
         B1pcoXnxacb7ZjCgq70vUVl13Talr1hpChTylbm0eJwZyjVjfFfCd9b2XjjBItrJgkDd
         k95/tg1hUVYDm+ophjDlUB5IEKXH/koEeDYhSxLiEdPz49BDw12CgBkGihXZrbJ7bpDd
         7UxA==
X-Gm-Message-State: AO0yUKUL8xXy8yYA3YkxhoCCmJLTpeBVtA7Ge/ui4I4h5sBEw8SynYNv
        Y9SflVC+flGm8R7tlHU6eJCINhHrTSP/iOT/7Fo=
X-Google-Smtp-Source: AK7set+DQDcxYPBVfh26QNjQ2U371RDTw0iJxDP2a1+zVcV+3ohD/VhgvBXJMFtgNJ5hxSr7lMepMw==
X-Received: by 2002:a05:622a:1650:b0:3bf:c5a3:6143 with SMTP id y16-20020a05622a165000b003bfc5a36143mr58195499qtj.27.1678662975154;
        Sun, 12 Mar 2023 16:16:15 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id dm21-20020a05620a1d5500b00742f250ebc0sm4307091qkb.9.2023.03.12.16.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 16:16:14 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        William Breathitt Gray <william.gray@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.14 v3 6/6] iio: counter: 104-quad-8: Fix race condition between FLAG and CNTR reads
Date:   Sun, 12 Mar 2023 19:15:54 -0400
Message-Id: <20230312231554.134858-6-william.gray@linaro.org>
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
Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/counter/104-quad-8.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index 181585ae..bdb07694 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -64,9 +64,6 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 {
 	struct quad8_iio *const priv = iio_priv(indio_dev);
 	const int base_offset = priv->base + 2 * chan->channel;
-	unsigned int flags;
-	unsigned int borrow;
-	unsigned int carry;
 	int i;
 
 	switch (mask) {
@@ -76,12 +73,7 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT;
 		}
 
-		flags = inb(base_offset + 1);
-		borrow = flags & BIT(0);
-		carry = !!(flags & BIT(1));
-
-		/* Borrow XOR Carry effectively doubles count range */
-		*val = (borrow ^ carry) << 24;
+		*val = 0;
 
 		/* Reset Byte Pointer; transfer Counter to Output Latch */
 		outb(0x11, base_offset + 1);

base-commit: 373c2a0d721acdbed9f45bf9816c04edad3704ca
-- 
2.39.2

