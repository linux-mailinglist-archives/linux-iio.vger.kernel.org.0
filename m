Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFCD6367B9
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 18:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbiKWRyt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 12:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiKWRys (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 12:54:48 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3E36AEDA;
        Wed, 23 Nov 2022 09:54:48 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 136so17420820pga.1;
        Wed, 23 Nov 2022 09:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZH0Qc9jkq5rdx+9MsswFw6fY0Pcj+rHLWBfTQ1gC3xE=;
        b=bSzfkZ91RRT95GKDEsYr040rfLq3/tNhJGmUkALs3tqr6/PUBUelP8T2iI3eRBXXRS
         W5CmmUzi02a6tBqR0Vl0LEq15kFsBNajis8R4U07kmaXyziOnEA0N0Eh1VGYYWgLju2Y
         NSer/a9rNnK4zC3NWAWIfDifeMoTBKR7ahbJVmnLll7AL7j/Umr+4OBeiDPNBiDHKp7B
         fkbMdcytezSkSYI7HHptXLYquVd5GcIDpCg3W7NKOoxRcTfZ8M8AClji2dFAUP4THzEN
         vEbYSdgBgDWd2hTxBPclb2xuci6fhclly4gsmz3ROVDcfitJ9dZVevo3whkhp3r8uKTu
         KBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZH0Qc9jkq5rdx+9MsswFw6fY0Pcj+rHLWBfTQ1gC3xE=;
        b=POdA2cR1jSq1SNgaZGfTWtylgWYSH7DfJyNzZ05DE7DCK3UOrxb+PBcaX/Kk7CTemL
         L7LZxmfZ9oiS3I/ZZuDjut3O0pe6/TRDbEDD/09DqKbQUoVZ1/QinsV4r4+QEYU0gksY
         zq5M+wSR8oCI1hOKgO9D6NQrrkUxgzSt0aCl8EK62gYRccgmAMrWnoUhVKETS0mHKvU2
         RfpZ86A+dPP0RWnP5VgPSRVnUxoeAoDWZ+UBiAHmGrbZGIEQIVhfUaKom9kWXnR2tZMU
         RMXtzavHsHPbtZNFqLZfvx6pZOZVlBuEy5v7XWo4D8H81r36xTOLPFfDcPW4Jb0aNZMq
         5ekA==
X-Gm-Message-State: ANoB5pm+c9AF6QwZZ6P7NRF5UjnbGq5tDGHe21B6NTm42J3cYHuItZWA
        46n5fRhTc3IJWPRDCmrB6ew=
X-Google-Smtp-Source: AA0mqf7YdadYIfWlr1MiOMG6p2VQbPoO7jqU51ydgFvs+e5KuEdOFD1kyrlLDjl2/YzZ+KUO+baytQ==
X-Received: by 2002:a63:c65:0:b0:476:db6f:d436 with SMTP id 37-20020a630c65000000b00476db6fd436mr27393231pgm.394.1669226087686;
        Wed, 23 Nov 2022 09:54:47 -0800 (PST)
Received: from discovery.. ([2401:4900:483b:e422:60e:77bf:baa2:9d8b])
        by smtp.gmail.com with ESMTPSA id y76-20020a62644f000000b0057470a06694sm837503pfb.40.2022.11.23.09.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:54:47 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v6 2/7] power: supply: fix wrong interpretation of register value
Date:   Wed, 23 Nov 2022 18:54:20 +0100
Message-Id: <20221123175425.564042-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123175425.564042-1-sravanhome@gmail.com>
References: <20221123175425.564042-1-sravanhome@gmail.com>
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

Fix the switch cases to match the register value.

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
2.34.1

