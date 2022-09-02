Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC75AAE26
	for <lists+linux-iio@lfdr.de>; Fri,  2 Sep 2022 14:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiIBMKg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Sep 2022 08:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbiIBMKb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2022 08:10:31 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F972A73F
        for <linux-iio@vger.kernel.org>; Fri,  2 Sep 2022 05:10:28 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id cb8so1308719qtb.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Sep 2022 05:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qJ+5rTllUEXndIRwC16RHfyczOD9RZjJHDBMLq4xn4E=;
        b=XaF2OHSYSjd/Fqxdc4+3zeMhvsBqz15UidzNsC5nH/007NQpqThnifZOoVqbq6t29E
         dSyWf4f1nyv+THgFu/+cz8aC7+9AbbpiRx3hz6ombHwsAxsCuix8DP53TanwVExanCKv
         cKnHm0NUeis4XIOC8CVuVjX3H9JRgSN+SySnTinHOMutnm1RDxRQQvFBZdqDo2TpVOAh
         Fh8dogbj3GRfv8ax5yVDWY44RLv4qbiuEB0BHEWkjMogudEfDBT/KlOaVC86Jqnw2zCF
         aNvAs9YZFjCxP6PLT3Mi8ZVQy8sFuwSwARI+6qGmT0J4kfRti5VlReZgWrKHZFZ9qUCC
         adgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qJ+5rTllUEXndIRwC16RHfyczOD9RZjJHDBMLq4xn4E=;
        b=2AIT+p8d45nCzSpO/+E3ECiNoUr/TXd6oxBOGM763+NHMe2aelZiFuuPIbCSa/ygMO
         1OltBz6OlEn+VMAj0IS+IlEO7hBDEMwOBVdu5Y4rEWQixRDTYHZFRHZgiW6KJedQDSRF
         /ixfdPss5Pmc5EpNBwSTKyRIpHwO+mRwy8Wwe4J02LnGGUoVaFXB06gaaBIT9ZCkfCZ4
         qltsS5D5RZJ2t8NpWHZv0waHU9ImGVG5Sz/C8Skr/fr+nqydBTVZNRcT1nUC4+r2XxUN
         433ZbWz955YqBAb5vnnDc0gpfCoR217pRBoK52cUFZ+wvmmRbuNE7aZIaqeCYck50lCT
         bN8g==
X-Gm-Message-State: ACgBeo3/sV5G5nAtmJ8iksm8gdi9xFqIAYIB5HK+KCCWaPApHTmi5HNw
        uGzGR9PZjcfqcEEr72Agw7rtGmptVfvAag==
X-Google-Smtp-Source: AA6agR6UYujj0TrldztrCNZ0SxUDA5y4BY/uqML7IvPjp2zmQ/NTSUnCZBHGB1Yzieck2yayQmSsuA==
X-Received: by 2002:a05:622a:1485:b0:343:781b:d1b with SMTP id t5-20020a05622a148500b00343781b0d1bmr27951187qtx.536.1662120627781;
        Fri, 02 Sep 2022 05:10:27 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id l5-20020ac81485000000b0031f41ea94easm915395qtj.28.2022.09.02.05.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 05:10:26 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: [PATCH] counter: Realign counter_comp comment block to 80 characters
Date:   Fri,  2 Sep 2022 08:08:39 -0400
Message-Id: <20220902120839.4260-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The member documentation comment lines for struct counter_comp extend
past the 80-characters column boundary due to extra identation at the
start of each section. This patch realigns the comment block within the
80-characters boundary by removing these superfluous indents.

Cc: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 include/linux/counter.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/linux/counter.h b/include/linux/counter.h
index 1fe17f5adb09..a81234bc8ea8 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -38,64 +38,64 @@ enum counter_comp_type {
  * @type:		Counter component data type
  * @name:		device-specific component name
  * @priv:		component-relevant data
- * @action_read:		Synapse action mode read callback. The read value of the
+ * @action_read:	Synapse action mode read callback. The read value of the
  *			respective Synapse action mode should be passed back via
  *			the action parameter.
- * @device_u8_read:		Device u8 component read callback. The read value of the
+ * @device_u8_read:	Device u8 component read callback. The read value of the
  *			respective Device u8 component should be passed back via
  *			the val parameter.
- * @count_u8_read:		Count u8 component read callback. The read value of the
+ * @count_u8_read:	Count u8 component read callback. The read value of the
  *			respective Count u8 component should be passed back via
  *			the val parameter.
- * @signal_u8_read:		Signal u8 component read callback. The read value of the
+ * @signal_u8_read:	Signal u8 component read callback. The read value of the
  *			respective Signal u8 component should be passed back via
  *			the val parameter.
- * @device_u32_read:		Device u32 component read callback. The read value of
+ * @device_u32_read:	Device u32 component read callback. The read value of
  *			the respective Device u32 component should be passed
  *			back via the val parameter.
- * @count_u32_read:		Count u32 component read callback. The read value of the
+ * @count_u32_read:	Count u32 component read callback. The read value of the
  *			respective Count u32 component should be passed back via
  *			the val parameter.
- * @signal_u32_read:		Signal u32 component read callback. The read value of
+ * @signal_u32_read:	Signal u32 component read callback. The read value of
  *			the respective Signal u32 component should be passed
  *			back via the val parameter.
- * @device_u64_read:		Device u64 component read callback. The read value of
+ * @device_u64_read:	Device u64 component read callback. The read value of
  *			the respective Device u64 component should be passed
  *			back via the val parameter.
- * @count_u64_read:		Count u64 component read callback. The read value of the
+ * @count_u64_read:	Count u64 component read callback. The read value of the
  *			respective Count u64 component should be passed back via
  *			the val parameter.
- * @signal_u64_read:		Signal u64 component read callback. The read value of
+ * @signal_u64_read:	Signal u64 component read callback. The read value of
  *			the respective Signal u64 component should be passed
  *			back via the val parameter.
- * @action_write:		Synapse action mode write callback. The write value of
+ * @action_write:	Synapse action mode write callback. The write value of
  *			the respective Synapse action mode is passed via the
  *			action parameter.
- * @device_u8_write:		Device u8 component write callback. The write value of
+ * @device_u8_write:	Device u8 component write callback. The write value of
  *			the respective Device u8 component is passed via the val
  *			parameter.
- * @count_u8_write:		Count u8 component write callback. The write value of
+ * @count_u8_write:	Count u8 component write callback. The write value of
  *			the respective Count u8 component is passed via the val
  *			parameter.
- * @signal_u8_write:		Signal u8 component write callback. The write value of
+ * @signal_u8_write:	Signal u8 component write callback. The write value of
  *			the respective Signal u8 component is passed via the val
  *			parameter.
- * @device_u32_write:		Device u32 component write callback. The write value of
+ * @device_u32_write:	Device u32 component write callback. The write value of
  *			the respective Device u32 component is passed via the
  *			val parameter.
- * @count_u32_write:		Count u32 component write callback. The write value of
+ * @count_u32_write:	Count u32 component write callback. The write value of
  *			the respective Count u32 component is passed via the val
  *			parameter.
- * @signal_u32_write:		Signal u32 component write callback. The write value of
+ * @signal_u32_write:	Signal u32 component write callback. The write value of
  *			the respective Signal u32 component is passed via the
  *			val parameter.
- * @device_u64_write:		Device u64 component write callback. The write value of
+ * @device_u64_write:	Device u64 component write callback. The write value of
  *			the respective Device u64 component is passed via the
  *			val parameter.
- * @count_u64_write:		Count u64 component write callback. The write value of
+ * @count_u64_write:	Count u64 component write callback. The write value of
  *			the respective Count u64 component is passed via the val
  *			parameter.
- * @signal_u64_write:		Signal u64 component write callback. The write value of
+ * @signal_u64_write:	Signal u64 component write callback. The write value of
  *			the respective Signal u64 component is passed via the
  *			val parameter.
  */

base-commit: a12224997bec72d231a8dd642876e6364decdc45
-- 
2.37.2

