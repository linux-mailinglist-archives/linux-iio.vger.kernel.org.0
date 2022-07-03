Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09E2564A2A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 00:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiGCWDQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Jul 2022 18:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiGCWDP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2022 18:03:15 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F1460CB
        for <linux-iio@vger.kernel.org>; Sun,  3 Jul 2022 15:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1656885792; bh=F7BpDzS7greEJoS/tBb1EI2GHOq6sKTMQeOG/t4ARZY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=l8dkI/TfMWmEa0I7KlCM0I7L578SVHgGPiZ8SPElLJHrwSHbsmGJxbZrzVfIZhO8hp5hakNfMEwS+ZqhAybHiE9xxr9pLJwuoY5VNFl5MpWO30am4cMLAhMJZ/FclVES4lcv/m8thuFBit3VJZFf0mqZAC4eejE5IoxETJyaBIUnZ5tDl6zVTvuRNl2nmCtFDQP9DswTpSvykmrkQW61qXiQij6OVikOT08fzfNgQ3KjTN9p5EI809g63UIRtLcj0Pvi42T6rBVIzsdP+l7l5eCz7WaPEP+jGBGHlzXUeC5SnrVnKuq5dk7ovTUtw88CwtjI6jX5NIHWbSLnFxjU/w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656885792; bh=GkGt8PIVaSnG/jRWiPnzaS4fMTR82/sLYV3ykjonLVp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Rh1HmCGmOiOKeSqjWGDPmm0iXXfY2DiE5W5wFnngt9vH6RDthZUpXvJyP00nbFmge3xFVuxg+ZGwOoXDPwcrnC/dPtxSDDxCCBW4qCJAefY6+cSpjC1mH90eKCgWRK57UBQ9X8LCdAQZl80eT42OfBz0nrAI44GG9tHxy96IecgH8TX+abFSXtvISsTsCVk9ABd0XPMl1kk8853uZ2x00G1/nV6GXqyrS4dJeTFpQnSvTiMxW3WrRtMASkxvkizM+19OIDgihrkbg0HFG+FTfNlaTsBCgKqsqGM1imZ71IfHhLvaXQDWUhpC4Bzfn+zr/uWEPEaEQWTK340Z7cafqQ==
X-YMail-OSG: 6au0zi0VM1nf_k2FUdwY4qiGGcXP9IaMGeUL.v549RqfGxd_ZGoZkI2.RW9k1jM
 A8oEGL13qC.3Dx38mJD5skhhvMHf2vwiasUx60hx5ZRulqvvi2928RXscSKyD0T9_StKjsp9gF1O
 8uK_9idKgjFj8ZHm5bEo0Us10q6aYIQnmyhTVDgUhS6e15l6PHNgSpl.sLRgehAeU6Duu_Z0LcN6
 Iqk5M_7UBdwfF8VTmng1MZtjvp9QG3nfIwp3umCkeI1MkVDLFZHDyv5Sz5.fDm3_9tETNkBE40ZM
 p5TAAeWFoqyhcH59M4M30llg4KFxxlitufv5u1RMEIZFgohIfVEzp3IHt6W8YDWw3RnGp5GdpWes
 pGEKiJJa0EkJUxpi07rlHIXjk9KFt9ew8HSzQKg4uqn4UEv0FntWMempeYt12XrKFYrlhm69mZVt
 Sd368UYMO_ZEDTOtQrXlGP6qqw5gLKF8PrFbnC9dIl_8fGZT8cMF9ZoVDac9KpM2cpFfu9yeWa1z
 C58EFSfa6JPwEJght00LKN4axCYd.E0dNJIGs6mwG8MJYQfbaoSWdOXCQrVv0kzggchC4Q35He38
 K7HBdXho_BkjbniwaNFUZwXUigROPgW3T1Px8AaG0a.1aGQzAHQeQhUAFa9n8eyrzJBtlADHRG6h
 PikQqMdgZhqYqJR5OfLME.nyVkMfRLCbZwCA6Uf4vNI54mfiBf0IdSre80emtIeEjb_kf3WrKuLS
 fW2ykZkRKAZ29tiKoJqvM6hOwBpiy4oz9COa7x44BdXhOIvzExIXU1m6CyFUW2PI6tZYQoYT9l1X
 uVT1GHqZLmMV3IAGHnUlUyUSRx.KT0hxexBt0G3ZO6rPWNw5oiwA.2Li_CKVxH9Bg2HOPEXS4NLv
 QVWWf1y6xPwYhinejiGhOYqldsnqFm.EP.LOrFjUF7zGzDihYVHVqJ2qdWbOj8HIozgZ.h1eaYRU
 2MX1vOETIhLN3s.pL401dyTIURTukMPbOJDW8oNhDxjAV16JbYp1WVFY9d5NbsBnvidWkuZm9AgX
 eBtcU0P_bUVC4K3Dfql1ubTE8sNeHh0ceQ.uBu7N4aAMZD_jsxkq4r4m8ff92v7_76O03r6uIGR1
 QkpWM07jLTPgdvkOLvCs4mczgFEr1SpOpUkSQpwMEQeGy0Nbd56PTpci0MdefaMCbcT.nPy2SiO7
 h_SjtlvLViblK4TIrJVgUfWPNgTuRl7hj6PIN5Ak7.ExFF15PsY6yk2tLOLB.GY6f5oq3uL0rNVB
 LAD4jUuWciJUfJrqRdlu53mMGgGKIyWsJWg1h9sn.dW6Sv1XYx4MTVLcLByGfN15xbEo6xeppbaO
 HSYF6vkc8ANgmayg1skz4_7qxFCQGcLjrBt3GXWYh0mMGlUdf0SaYagPaMu0ZJThnEqL3fMvz.aH
 3Ej22ihooUhts_jh4ikfPhjUm_N5Hun5Hw_38bTsV69_u6VVBxFcA_zjdyndJ431RmZ2ogDtfUlI
 k9OVq.mdZE2OW5WHFu8cgpt.1tlp.qtUjIcP6SgyNSqre1tD2UasoqpQUgNtxnEw4gHaY_DB1VDb
 uy3PW8sopzaK4BZ9tyS_OwPRrKfwf5NKLm0b_QejW5LbpXcazQffelidXJnFn335h8Ja8VBKlj7n
 gDlcJ0XXEekZ.frLLEt6G2TOWN6cvmnFNO_lCaAqQl_2JNL39mdJNEcCSKjiDhp3TDVZ2c7zxxnQ
 J.jkWTuEWRNBkkMVtUDdZUmC_fkIjGgs937Ol0V2KBkphd3ItF7LEffSCj7DYggyJ3Qs7_7Zg8jI
 NiuIHF4lzDJx8SOWjMplB0KZLs22tn98MwtOCnlBEGe3XAi9ZChDe5sG8fMCPCbpJNsp12FIE4h4
 GEJ6JcD_2Kxl7R1ftWWmUPDJabZDHCfFlPhozPwixAK_nENLzfl2PuwiruqnHCQXrO1QOvaxH9TX
 z9RYsCVwjLGTHCyFlyqvgeVnsXDD6ZbL1iuWjK5cEER_OmxE31eTrEzIazFYg8Y1rOcEhvuUEwvt
 Okx8nXZi7Mm.dv4PCDzE4guC2qQQ8Ml6R7rpDSVJYlpkb1jkEFFYt4LKkCHKQgHySJoQi2pwIwHA
 DeGHeWOQ5cM1WDH5cfLnPxxcrGbSbEGBEGsZlNsTQ8b792VHdD_Zg2kbx3lB5GKM_ggSinDLRkHQ
 Ky1NZzzHD2AQwfajM5KDhNY.zEE.uC6L4TXqv.fpCr7zNpgrITHM73jmYCMmbL7Z.g01.vSdQ4Ob
 lFOlIrbLBnTMw94sj3SGRDHvVgH5ApVJKQQjMllw629LtRkRerTMP_qjr3DMpCcipRUGJhrc5N2D
 LVU.xuzweyg50laV1Bg--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 Jul 2022 22:03:12 +0000
Received: by hermes--canary-production-ir2-74b4d6d794-tv8mb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0849bd8970b52a790a5a1bb96f2e336c;
          Sun, 03 Jul 2022 22:03:09 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v4 02/10] iio: magnetometer: yas530: Change range of data in volatile register
Date:   Mon,  4 Jul 2022 00:02:36 +0200
Message-Id: <5fbc8e114e4940569559edec3a85a1044c823f52.1656883851.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656883851.git.jahau@rocketmail.com>
References: <cover.1656883851.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In function yas5xx_volatile_reg(), register "YAS5XX_MEASURE_DATA + 8" shouldn't
be volatile as we count from 0 to 7 here.

Instead of lowering the number from 8 to 7, the operator "<=" is replaced by
"<". The size of the measure data array is 8, therefore it's more natural to
use 8 as a constant.

This change is of low importance as the "+ 8" register isn't called.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 40192aa46b04..6fa29b96c013 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -527,7 +527,7 @@ static bool yas5xx_volatile_reg(struct device *dev, unsigned int reg)
 {
 	return reg == YAS5XX_ACTUATE_INIT_COIL ||
 		reg == YAS5XX_MEASURE ||
-		(reg >= YAS5XX_MEASURE_DATA && reg <= YAS5XX_MEASURE_DATA + 8);
+		(reg >= YAS5XX_MEASURE_DATA && reg < YAS5XX_MEASURE_DATA + 8);
 }
 
 /* TODO: enable regmap cache, using mark dirty and sync at runtime resume */
-- 
2.35.1

