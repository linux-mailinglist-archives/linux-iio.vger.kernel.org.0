Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0916121CD
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 11:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJ2JaM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 05:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJ2JaK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 05:30:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57CC58E93;
        Sat, 29 Oct 2022 02:30:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j15so9439266wrq.3;
        Sat, 29 Oct 2022 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRio8WmNPVIhI4AkJ7r8lq4Jznf7XL46j1qcLi92j54=;
        b=ioJ+TlykrU215ZM0MuzVa/D1SbosAfdtgAHWjyBwARVCv5zLlSI/GH9MfeHXnIVsna
         3vD0nAVKPtJRU8Z7OI712Xi6fj0jo3/7+lc77eUN8D0n+SjhrC8bwOzvsa8E0LXIK/iK
         dnz462Qq0cMh/PLY8s5MEKOIrRKs21fhFgQAalrRCOVXcG66YUe1y5RgRiriMyAYKDjO
         k85p0TKVTm4+UXw1pjSLibeHfiii/8EJJnq4JkMCrXqRYNA0alqZa2xeoLbEK0W1FNi5
         PvA8flqgFOq+Ol6xTdaKakHIWoOFsS/jYfSIzSxi7ZrR9BLuB0t8LCVV6uKzNN5n+hq5
         Kejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRio8WmNPVIhI4AkJ7r8lq4Jznf7XL46j1qcLi92j54=;
        b=sIPCKhyY0qsTmdwU0YTM545CzXtNCuD5vYjwQ0bVvNRvKSbvHJ+erNvnZRZ0s+TXAH
         o02dMhJBGkFW3P77KA1hKXImRoHxt25kfA8HugLXsVBqATw2aTClSZiwJw1eexCvYFhV
         +oAR+JX6jkrk6k808YBTjxDGBuD7Wm7IXoVaUxLAz3mNiYy9PADQ8lB8TuRKNYu2PPQd
         jxdJZrTGTcL9vrLKxoPtIt2MwIzvV3M5U4ZZhzsy0Jk0ypCiCUqrRdC5H9tYFTqo3k7j
         WBV5xnf322uS7Ooaveouw7ZjZBRTNstc+EtGaNfyPST4oCOcoE/LKjN+GYeTH/iDDNB/
         zh6A==
X-Gm-Message-State: ACrzQf0i6xUqpIMc8L7m28xF1Zqzmy1yFjFbl+87pVyUlISv2gu/TjtB
        QDKJ55UHj54d1Ivs2TJ+GpI=
X-Google-Smtp-Source: AMsMyM6AO0fVfZ6Jve8NFte/cLX83aqhO0uCVCSTqEADjoeKr8BE2fj35W8F4VXSJqTiKNnIii1+cw==
X-Received: by 2002:a5d:40d1:0:b0:236:786d:611e with SMTP id b17-20020a5d40d1000000b00236786d611emr1931557wrq.355.1667035807418;
        Sat, 29 Oct 2022 02:30:07 -0700 (PDT)
Received: from discovery.. (p5b3f76b5.dip0.t-ipconnect.de. [91.63.118.181])
        by smtp.gmail.com with ESMTPSA id f7-20020adff987000000b0022e6178bd84sm1068187wrr.8.2022.10.29.02.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:30:07 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 4/8] power: supply: fix wrong interpretation of register value
Date:   Sat, 29 Oct 2022 11:29:56 +0200
Message-Id: <20221029093000.45451-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221029093000.45451-1-sravanhome@gmail.com>
References: <20221029093000.45451-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

fix the switch cases to match the register value.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/power/supply/mp2629_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply/mp2629_charger.c
index bf9c27b463a8..46d620bd23b9 100644
--- a/drivers/power/supply/mp2629_charger.c
+++ b/drivers/power/supply/mp2629_charger.c
@@ -284,10 +284,10 @@ static int mp2629_charger_battery_get_prop(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 			break;
 		case 0x01:
-		case 0x10:
+		case 0x02:
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 			break;
-		case 0x11:
+		case 0x03:
 			val->intval = POWER_SUPPLY_STATUS_FULL;
 		}
 		break;
@@ -305,7 +305,7 @@ static int mp2629_charger_battery_get_prop(struct power_supply *psy,
 		case 0x01:
 			val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
 			break;
-		case 0x10:
+		case 0x02:
 			val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
 			break;
 		default:
-- 
2.32.0

