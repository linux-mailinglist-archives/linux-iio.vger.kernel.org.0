Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1862547D47
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 03:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiFMBRr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jun 2022 21:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiFMBRq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2022 21:17:46 -0400
Received: from sonic310-12.consmr.mail.ir2.yahoo.com (sonic310-12.consmr.mail.ir2.yahoo.com [77.238.177.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866C92FFE5
        for <linux-iio@vger.kernel.org>; Sun, 12 Jun 2022 18:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655083063; bh=3HqEe7mLC0Oar+1I9oaYhBQWHlwZ68u3/FFRkU44PfY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=SgMcrHpYjuqCgF0xYoPyp8PBFTOAedS1G4+cSXFOciTSI/99YvyLz33aDY/m3Xt7f3LfaU05BpQd+4X0RSof5HRfOda1B8CAlY+e1MtOhuanFvTchwPMaPUp35H+9ESPwgxefxAcDpvvYgUEHnppRmZbb+0uqolBuwwEyvvYmbvBI+edcxKZYIp7IZS1sN0Kf+WIG4hHA/9Wz8ZavuN+2mXrQSANnh05RQgYBDHPmLT6Ux/cy6fS4+uuzVeuypGiyQHvfaYAunyUFt9oQx956c2q5ziGimzOE9d3dsotTe6layN1nse6iwFl76r636QtNq9ngToedQaoCGN8YwpC0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655083063; bh=wHVpexSUiBsklAMgiKQlRUDfZmMh7KevurCX6tN7JFT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=BNjNPk9rQyosJrYhgST9bQMCpOP0TH6FsCXBYeUg5yVJCpmxGbHFaupNgumKXs9axYEboHw9kkNp+Elr9OeVAgsBuDy8IQ8II3F80nCMxIYs61yzX+O3xlehZjQwEsu6jextPQvt3XSQmII9fSmtzqyxINkF7ayVHyREB/V040SBixP7xruaJVqyJyizDmA0d6QnmvuMFIBG1iE+t/+HTh9feAfiOdSMxk1p5fEdCbX9HV2I0RHRW7M45FQI537oE8WhgnC5Ire1dLReLUIi4SLb3Cvf5vG9p24GLqLFyYoGRVb4M4FgFQ1XNjDyfD/InJ70Y2EWAizkz5h2DCXe4g==
X-YMail-OSG: Ku_QcNEVM1m1ZM1jrlelZ8unGNz3gm5MgczgjhrrOrvqPE1TLrGR7Bx9HOuiLWh
 08JY8FzkUPTDT18JgmOOeensWyb4G7jeWeuNSg.vaBQ_QTjVpSTCq4rkPB1.uLQdi42njMtCMtpp
 HBlW8POtxGYANEK1kztSBuDNZvihEnEYgqMrm96hl41svr_NXfizirkOokdIpp1iGGaej8jZouA_
 tCHDKRWRTWFnjKmTEbWqZQ2rGbBoZjp3r5nb38CsJDitY0r9IWl.B6fSByNopKHgYfrb7s8M4.LC
 CqCTk_D.AHToGhbtdMc92Z3yLnlboJe.Yoenl16JzyO_51fDStr5h5AFpeKoveCa_mXtNPJ014yd
 FTbeOIqjxo_nxYiK9KUuqSJ_CD1WoiPM8oifsqfXDFO6Z4hkPskyCdr2xKt0Tmbdhlb1Pf3ejlLK
 2Y.daj0Cf5pXaeQc0OapGubrv69JanMB2N6nmIFy0j4O.G6pVP6gqQ4TxqVgeilbZN3WKp6rGBvo
 RYt14hrSx6u990E5KaB_peLFT2j_3jFlK0ktbBSyFH_mPEk8YzKFrppZOdao62pPqfp.0ElIjmEk
 Ofx0YU28etJ.banPuvar69w7UYSKvlA.MQQlkp329e4jsGLNoi.SLrPzGcXZ763qGT.Gaxf8esQ4
 XyUMWCveOkenn9RnpkvBGGJfIFK1J6CMD51Bx.8MeIEWXkuYSkLc_3VJmwCDnjs2t37pFl1CfQgV
 lHRiQ5AIHM_BoNQH6JFnOAOqhXh1sefY545HRQz59xBsXKTMHED5vuT9zHa9CgxrYLOnN7oVpQT9
 mkfV_LA8h3pZ0CF9qm01i633IQsGfTsWRnMiOh4U7KWZlGHIbb4pOSRdLN1qt5muI5wqi1pq9Q4A
 dWJYcTe95gEBwgb0VcLCpCTnrgWK5flEcNOTHzKs2lr91SPRRHCg9oXs0Pe7xQhm9w6vy4zeRnnM
 c2K.Jvz9Ga8P9O9MJygN4DSkOhWjnPGFMC3g.ZEvWgQT4F2e3JYc9gvniDtGhLIx6uacCs8g00pG
 DA_riDqp8L6RJU_9JE1DfNCniGjZnvG.ynKFVxDcxXBEyXfIKvE7V7bUGr.6zi6QHN2XvZcM.mf1
 HIV5z7OP3qGwul_2G2t1C65Uetx3TM.JgA2wZbNxuARDJHKLoasF0NFfqV8o9WBAWcDEywnYu_AL
 78UF43bU42FD64b265hf_eWKVK69JGgnNb5RPuzpnYngnIp5Ai9eQPeLvuPMn5M7du6Dw6MYuVRN
 K6tjJmShcXUsJwSb_B1w7MU5MBryX0_NCv0bwAUz1EZz2raEWA8fuV9Atim3KTDXckhf1N.dn_to
 nh0JkPE2j8ytb4R9pAU7PFumd_9wsuO57RyNTlYcXfakpdjjjKpdQXc3Wx9AtAGgGo_E3Xsh_TS1
 e41wK.inXVKGfqFtS88p9ogifCKlV_ojsOrIGUYlmJ2SXV.FcwquXY_JdW6ZYf8Sp4y7ltdXPsez
 X78nU2H0WEkp3Ee7UBdg2pD2rOioHY_y0aBl.zm5szUhe.NalHRaP_R0IEiJ2.OJWhbKky5fUaHL
 sXDt33QOa9PsCo9Ys3_gESeHfXzqe_jbRE1on9IHrWXSGJ8uIjCX42xd9nTlFviCUZqaOc1F1G9F
 HOetrxThYaPhzKOTm.Qm7jFxKUNhJJ6H5YOKn3DSdIt4AERprXNqIQYp8vfUngT744jefRcD5bRi
 NnmzwvRER6L9Ee4HHkMPa3OSLbSZpIj4yZdg1KUOb4NrsFMBujDEw56frDW9ELKxKoQDJmD.22yK
 Dl3QymeMqmLGjE.gPOueRh.HyfQ9rrNzqMDIByRGRdO375Tja03NbaQuz1NGb458sAyC25Nv5GdT
 fGbMklZt.C4NKGZdgjGmsiYiLajCCiX7DnnliPXtFN_hKwOe6EIzeFbz7JXLRu4Bn2uI3.PK8fl_
 j_NVbUVe.o9ACoUB5B2.IMmKIYtFzPz88WMvrJkbus1O3EjmFeGUZJNSdhWhuPNLEpHNTMArAaqM
 kGUeZfGw9lFQ94gfCqzYnt8GxdjzUNfH1kc0GgTTYOgpsCNZTsPBJ82ubeNvM6bXIYAF3pol7zAW
 v0Poyi01eyKauU8Q0gDiGedaHBnN6ys7N_xLN28VUZDwYF9zc8by_PrZdQBLor6bDQKl0sLGConu
 8JNlw5GSmM5zM6lomzOron7ZBMH46JDXUTcVJnqv8DMEEqVBLLe3x2Lsjud92iV0Zilx6rlw3Rx_
 MlADRptV4fIdUO.GgNn6qOPbS6SsJKMVvmUaU_dfpY2PSF3GL7FXSO6DR7dga5BuKbegM5VefGsI
 zUIHqLob2JA.b4mk-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Mon, 13 Jun 2022 01:17:43 +0000
Received: by hermes--canary-production-ir2-6c7595c778-c54g9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4419c1e75f73c3038b6a16962b132f56;
          Mon, 13 Jun 2022 01:17:39 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 2/7] iio: magnetometer: yas530: Change range of data in volatile register
Date:   Mon, 13 Jun 2022 03:17:09 +0200
Message-Id: <02ece5db210dcee7511a3c322ca81041c6ebf8d1.1655081082.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655081082.git.jahau@rocketmail.com>
References: <cover.1655081082.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In function yas5xx_volatile_reg(), the range for measure data should end at
"YAS5XX_MEASURE_DATA + 7" instead of "+ 8" as we count from 0 to 7 here.

This change is of low importance as the "+ 8" register isn't called.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index b58a9c51e9ff..2d71ae837bf5 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -527,7 +527,7 @@ static bool yas5xx_volatile_reg(struct device *dev, unsigned int reg)
 {
 	return reg == YAS5XX_ACTUATE_INIT_COIL ||
 		reg == YAS5XX_MEASURE ||
-		(reg >= YAS5XX_MEASURE_DATA && reg <= YAS5XX_MEASURE_DATA + 8);
+		(reg >= YAS5XX_MEASURE_DATA && reg <= YAS5XX_MEASURE_DATA + 7);
 }
 
 /* TODO: enable regmap cache, using mark dirty and sync at runtime resume */
-- 
2.35.1

