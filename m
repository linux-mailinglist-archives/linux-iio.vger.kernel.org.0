Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF0660B6BD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 21:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiJXTJx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 15:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiJXTJW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 15:09:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B9B580B0;
        Mon, 24 Oct 2022 10:48:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r14so32876739edc.7;
        Mon, 24 Oct 2022 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLLFhdOjQdZVRi4+dO3LV4A0SKwug3EMMGQt1+QKLJM=;
        b=ARxc6MtH2mx0X8Zz04iqbFY7gSCEE8pZ1qcWgY+bfnOASKVlGMS45z2/V8Sax4EHId
         K3k6exT3goUntttLvMxaBlZ8eJDnahocz0V+Shq16ED7zrIL3/taap1SKM23rgkoSSUc
         qA3w0Ko77XIG3QAnrU/tagZrSydiNnESWOSMmNcgGjPqWKWQ4x3NZ/QU8kQsvG7rCs8z
         PGC8Rhs7uVaHm4F60B1HPzxc3Ijvy+2+gBztS42FcjL9P6AArJryR3RAL0N5uPqIi23p
         Pw/I9mbF2nPXh+ry9PTsQzK3FqFBLb2h6oNc45Ip/yK3116ofyqtzRe/ct4XYXjDklLI
         ia7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLLFhdOjQdZVRi4+dO3LV4A0SKwug3EMMGQt1+QKLJM=;
        b=FmMmrdQX9uulR/yhhfeHI8nh+kNistG/Zjx4XTN6Jcqkaa+rTVEDZBKgTzRVH2AzHq
         2BALA3Lux8kyRN4Li57A5ERkgsLBplMXJnDoHAJHfgZSzFUQ3sSO0lrSaI7yGT7+7vYM
         FZGRf0bxCgr8EIKqsaUO7t1ppZ9TB5cFikJOexp/rUT5B82LvLsHE0TkUap7Jk8GmXhY
         6BE8Uxwa944O+bNJyLpTZzplCAaVH5gnKHHjg2LsFIZVBun7x5sfVBRlrgA8VMFtOr3E
         O1Vq9nvuzljowZt6mlzfIG2IKR3u8kWsUgmhozgjItk4zlY4+uM7DFVt4NaXQZEJTZIb
         2+2Q==
X-Gm-Message-State: ACrzQf037Tss8HRHfkGNy/Znj9Vz+GMUvFLpHGaYr2XUOxLgQ4HvXojh
        D/AZBLqnTxXaeuWWVzAxQTOIetgy4s0=
X-Google-Smtp-Source: AMsMyM5OZgGw0Zl5UJYWJ3Xrn6tNdg5QKfk1JM9oi8g1+WlLZjjnT0KJx1sRGwhdHIavjPlodQ/gQQ==
X-Received: by 2002:a17:907:9717:b0:78d:9fb4:16dd with SMTP id jg23-20020a170907971700b0078d9fb416ddmr28304599ejc.720.1666618088834;
        Mon, 24 Oct 2022 06:28:08 -0700 (PDT)
Received: from discovery.. (p5dcfeede.dip0.t-ipconnect.de. [93.207.238.222])
        by smtp.gmail.com with ESMTPSA id l20-20020a056402231400b00457c5637578sm18243818eda.63.2022.10.24.06.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:28:08 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 8/8] power: supply: fix wrong interpretation of register value
Date:   Mon, 24 Oct 2022 15:27:57 +0200
Message-Id: <20221024132757.3345400-9-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221024132757.3345400-1-sravanhome@gmail.com>
References: <20221024132757.3345400-1-sravanhome@gmail.com>
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

fix wrong interpretation of bitwise as hex

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/power/supply/mp2629_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply/mp2629_charger.c
index 9e4111aace4b..2ff3729afc48 100644
--- a/drivers/power/supply/mp2629_charger.c
+++ b/drivers/power/supply/mp2629_charger.c
@@ -328,10 +328,10 @@ static int mp2629_charger_battery_get_prop(struct power_supply *psy,
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
@@ -349,7 +349,7 @@ static int mp2629_charger_battery_get_prop(struct power_supply *psy,
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

