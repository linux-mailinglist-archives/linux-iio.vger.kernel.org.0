Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A83222485
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgGPN7h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 09:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbgGPN7e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DF0C061755
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so7194345wrm.4
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=orBUHy/BGmffZA4LA+ipGScBGUJn7fYfkbVAM8m+aww=;
        b=lIgBjCArdEpGcSjo1Rtyqs2OSMZAreCnZeJRzKDgcP3CvY/5Xd0NYDupYFjKFwfWM5
         8NTez5a0+GP2x5yjemlpLB+aTTjQ8S/dqgLBGoRHH1TirXWad94K54nYcZY5/E/HogpY
         Pa0szhtyvxV7eswEIeRtZGLcXBcTnM8d098PbdOkekwkzEqrrpOPEjcBBsk9PQdq8x7l
         vN7XrcDk9k5slv9pZz8JLLhKPWH5mgn37I/ifQZjH20DkFWId3KtsmI853Spb2u3OD/8
         XZthh5TsJnei/DNdFfuLF9sII/FWEpg4Ddo+zhujsBMvEcNZa1ReZeoKjd8zy3mQP0kk
         KhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=orBUHy/BGmffZA4LA+ipGScBGUJn7fYfkbVAM8m+aww=;
        b=EK7yAnu18+LR+tAEs4HUs+Pbn3X2ZZS3XXK8w3vFGpIDDUlXMI4GLUzw5a7U1tgrVl
         YtmCFny4c73XjiiT9cuIRaUiRl3bDi6f7iDG8SmLEQvsddvHXpINPdqUEDy1iEXao9vB
         ZFTZf37WK32VTwHdj1+Zp5BgivtaFMTHetBWy2RKnwoIIVrGFNuZZefRAtqggrYQOpe9
         ENKR7Onf2YBiFmpogFu6lBS00+cvcVFguuywthMT8rlC594ZE8z11kxgU1zvplyMuiOn
         Gu7bu2IlInKx967T/n3TgISqtNMUw/9SjVYdN5LVhn/sYndT/+kKThcpdOKZFzhRwdPC
         iJGg==
X-Gm-Message-State: AOAM530s+q3K5paM2uomjsJ0zUOY8fffr8E98hUQMLLOejgv6HYaR+0a
        Xw+gJEctvYRWaS9LaWZB3vGDyA==
X-Google-Smtp-Source: ABdhPJy1JSTu3kbsgYP/loEirhUW8pkWOd//jLIarF1XbEoVeVUlgCgFHlYhgElHekzZ+SrfxtpWig==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr5162237wrw.244.1594907973157;
        Thu, 16 Jul 2020 06:59:33 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 01/30] iio: adc: ad_sigma_delta: Remove unused variable 'ret'
Date:   Thu, 16 Jul 2020 14:58:59 +0100
Message-Id: <20200716135928.1456727-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/ad_sigma_delta.c: In function ‘ad_sd_trigger_handler’:
 drivers/iio/adc/ad_sigma_delta.c:405:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 405 | int ret;
 | ^~~

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/ad_sigma_delta.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index dd3d54b3bc8bb..f269b926440da 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -402,7 +402,6 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	unsigned int reg_size;
 	unsigned int data_reg;
 	uint8_t data[16];
-	int ret;
 
 	memset(data, 0x00, 16);
 
@@ -419,14 +418,12 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	case 4:
 	case 2:
 	case 1:
-		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
-			&data[0]);
+		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[0]);
 		break;
 	case 3:
 		/* We store 24 bit samples in a 32 bit word. Keep the upper
 		 * byte set to zero. */
-		ret = ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size,
-			&data[1]);
+		ad_sd_read_reg_raw(sigma_delta, data_reg, reg_size, &data[1]);
 		break;
 	}
 
-- 
2.25.1

