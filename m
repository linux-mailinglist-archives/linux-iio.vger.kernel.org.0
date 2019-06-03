Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB3D33922
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2019 21:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfFCTf2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jun 2019 15:35:28 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46657 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCTf2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2019 15:35:28 -0400
Received: by mail-qk1-f194.google.com with SMTP id a132so1211673qkb.13
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2019 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gobfI5uVdjQDqkRfAakOgqno2MeUhFjJEmPYnWDl1pg=;
        b=Nh99qMJO3Vz7VQLY5S35sx/9J17Ipb6+7L1LwQlU+g+lp6c1vGlwQTQ+kTnPocnxU3
         iI35PqrJxhJ0FsmI2iQ+SzMSZkXdsyvOvWMUkAxYEt8Dz30JzInQnpVjUIf/2mA9K29a
         CXkgTOrIcRPjMDhvoU1I7yE0b3Jccng9fUvV8QtRLi9091fKWivZX3ruf0jhsasLTQRO
         r3H4sAGkMr33PK8y+wZADmr1GsPKUbX0jeaBvwz92Q9pHB6iVACE2i9VlXRv9kIOC8pW
         KPdh62G+CFoS90yU7sXojNQmcQDKquwGGHf5T+2ZnCPRWyEqQ+jwJpqyHNskMU/Uis/u
         jmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gobfI5uVdjQDqkRfAakOgqno2MeUhFjJEmPYnWDl1pg=;
        b=jm/g8TLQNlC6600iaeJzNgpL1wUzcoi3cbAmsMVsdxw8UfHTiefS7MOHWv7qyOjf5a
         IOHDpvBxsifHI6DO+z9DLMf3nzdKWLWFFgaKvZQn+wbInnGsRALE/bWUN5lJDS1vxPG4
         z8taVRGWewmqg+5aqdgNyPZ/+5pYQWTMSpPci8oCw4RT+E1+qFZ49cMdlmVGAgB41RJ+
         ndR8FWZO6HgVaNIDmn3+jmwfLQKXomQxtJFFKQhErw8ust4BC1ntWS3s8gV8OZxHef7R
         RAypovUJW4XSO+sHoaP3wpKtyAb8zB+NcLJbA53jK4WGXxcCzlK+RoL+8sECHYbuyzN4
         29Jw==
X-Gm-Message-State: APjAAAXjnBdcFZE80J3UNeC/g/BYM5ULVEuWi7ZjcWftTMQb3yymhihH
        wOUrrFyTK1CDkpMFfFSgRZ8=
X-Google-Smtp-Source: APXvYqwwkMPUHHv9xCtDr/uj2Dg935hrZgmMATqN1WLaHva64BAdhNf1mLqNm0tHc1jYmTmdfewLhw==
X-Received: by 2002:a37:bd86:: with SMTP id n128mr23249902qkf.318.1559590527391;
        Mon, 03 Jun 2019 12:35:27 -0700 (PDT)
Received: from fabio-Latitude-E5450.am.freescale.net ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id t80sm7539231qka.87.2019.06.03.12.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:35:26 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     jic23@kernel.org
Cc:     andrew.smirnov@gmail.com, linux-iio@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/4] iio: imx7d_adc: Introduce a definition for the input clock
Date:   Mon,  3 Jun 2019 16:34:31 -0300
Message-Id: <20190603193433.6394-2-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603193433.6394-1-festevam@gmail.com>
References: <20190603193433.6394-1-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since the input clock is always 24MHz, there is no need for storing
this value into a variable.

Use a definition instead, which is more appropriate in this case.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/iio/adc/imx7d_adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 23c7b0ee945f..bffc172e7635 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -78,6 +78,7 @@
 #define IMX7D_REG_ADC_INT_STATUS_CHANNEL_CONV_TIME_OUT		0xf0000
 
 #define IMX7D_ADC_TIMEOUT		msecs_to_jiffies(100)
+#define IMX7D_ADC_INPUT_CLK		24000000
 
 enum imx7d_adc_clk_pre_div {
 	IMX7D_ADC_ANALOG_CLK_PRE_DIV_4,
@@ -272,13 +273,11 @@ static void imx7d_adc_channel_set(struct imx7d_adc *info)
 
 static u32 imx7d_adc_get_sample_rate(struct imx7d_adc *info)
 {
-	/* input clock is always 24MHz */
-	u32 input_clk = 24000000;
 	u32 analogue_core_clk;
 	u32 core_time_unit = info->adc_feature.core_time_unit;
 	u32 tmp;
 
-	analogue_core_clk = input_clk / info->pre_div_num;
+	analogue_core_clk = IMX7D_ADC_INPUT_CLK / info->pre_div_num;
 	tmp = (core_time_unit + 1) * 6;
 
 	return analogue_core_clk / tmp;
-- 
2.17.1

