Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3A66BFC31
	for <lists+linux-iio@lfdr.de>; Sat, 18 Mar 2023 19:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCRS5T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Mar 2023 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCRS5S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2023 14:57:18 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B9922A3F
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 11:57:17 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s12so9031252qtq.11
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679165836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U9p5+zyAgFkAG9dLgSgddG8iFTTXioCt2wTTeMFMwUg=;
        b=t0SOCfi0456bxlx3kT/HT8yKzIJApxgDGUSYN6gQfZyMOj4+CCYTWhZAhYOygiEY97
         cFB6YH6HtPzMBk9ER2ngbZnq+UdVQGdGAciRiAbItO2o4+yOay1myrPl6Atnnnv1dSBQ
         KxCg+mNlrIRh811blVFO31gr6bOHpiVUXPImuK3dZYnBRmJswIeLAxwFAuZn/GkRclOZ
         oIVCvL3FS3h52SHjd4PEYkKGa2GDUgEkfVwBs5tnplD6SO2ClZgwsfMwMcGILpWcfd/I
         f6bgEKTx51pjhEmMHWWaY3Di0BtlnjKCra7JpdWMrtoMGuB7oTWUGJkDYGZRRkMXccgp
         AD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679165836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9p5+zyAgFkAG9dLgSgddG8iFTTXioCt2wTTeMFMwUg=;
        b=1JZ1r+mLO+Dw++LXACOquZZBkcGcs+IFUSo3l3A5/96Pf9f8O2VDDsVRFP65SadK/b
         tNCKs3AHA58xJaMZi/unNapGA/hVYPCc1TtI3rehM7nXpY7QikrNs5QGDFUDQv5mUuhq
         vEAYFeo23ngwCrmlQyfLuThrvHS25psbAV6eENjHw4Y9NImkbaNNVUKLWpfFBFTOh+Sm
         tRiEGphlPopaELv7ruJt9XA0Pv8YVz0ITGx7TiPBB+gjTZNW3c4jktrHAOTn5ogGyRV6
         DOk+XUX39qNNRSQMNDwHfMpsz1qnEclS5nykBrf8FoECC9CPu4ANN1MWHeadzms6f7Lt
         AlXQ==
X-Gm-Message-State: AO0yUKVU+ZNOKLD3YjWikrvkc/hLKp4rNmt82ejlhBswZMLvAIABdPk8
        FzBjRDJ1PrTa87CpUN0IytIT3ZaLDtojJBvp4e8=
X-Google-Smtp-Source: AK7set8lMPpQsoSkBEqN7HNixlYuyN13IE9XbUy7MesLMTnWbXDcj/+5F69DglHkHGHUqvVO3mj/zg==
X-Received: by 2002:a05:622a:c4:b0:3bf:e2d8:28d4 with SMTP id p4-20020a05622a00c400b003bfe2d828d4mr19537496qtw.14.1679165836561;
        Sat, 18 Mar 2023 11:57:16 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b6-20020ac87546000000b003d29e23e214sm3388046qtr.82.2023.03.18.11.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 11:57:16 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] iio: addac: stx104: Replace bitops.h header inclusion with bits.h
Date:   Sat, 18 Mar 2023 14:55:03 -0400
Message-Id: <20230318185503.341914-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The <linux/bitops.h> header is included in the stx104 driver so that we
can use the BIT() macro. This macro is actually defined in the
<linux/bits.h> header, so replace the <linux/bitops.h> header inclusion
with <linux/bits.h>.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/addac/stx104.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index 48a91a95e597..e45b70aa5bb7 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -3,7 +3,7 @@
  * IIO driver for the Apex Embedded Systems STX104
  * Copyright (C) 2016 William Breathitt Gray
  */
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>

base-commit: 87a1ff66a0e57d9022665d24793f31fc54de182d
-- 
2.39.2

