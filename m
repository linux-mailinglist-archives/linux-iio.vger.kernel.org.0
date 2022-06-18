Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF0A55011F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 02:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbiFRAPB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 20:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiFRAPA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 20:15:00 -0400
Received: from sonic303-21.consmr.mail.ir2.yahoo.com (sonic303-21.consmr.mail.ir2.yahoo.com [77.238.178.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B6F15732
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 17:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655511297; bh=HUA420pLmyXbBKlHXL/2plBKjp8N9OY9zJWWnglHYrg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JJFJb6LsgMg6E4qV7SCMDvNJt8VGY55NJqtntTrmhAbZU1LtOIi7S9JQ7ZDk4LpmyPlbGlAz8MgTks35SZBqPG1Np9awZqz1EoT9pxQjeBDbv/5mbYNhebV5nq6bK3ETWY59KTJjSubhWwOPdR+jV5ngsXXWPy4ks/ip2GG84c7NlwPNJdgJX+C/SoV98z67jPYXatT+tbTY1jL9gXrCZklJBK66+qe0w4+lBuL/scymFh83XRcC9NazC39MGt917ks6yJYjgZgwmCU84R1sMOVNf/SnWSu0YgJiWrCCHEM7Vw+TXnW8k4bR5QrJ/YU5j1bLVP6ZIcy1GHuECmeUiQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655511297; bh=YaGF0cIQKihlDoH6A3DcT9BuQOWhEK++9dOOYbKsocJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GiszIubgovp0Wd0sj7b531X6IYyHVUi1KYDRxFM720hMLOefK4zvXS1J6ba+NoRYdijbpGKvVhiR9jUGgU6jEd6WOkv6cLJVUG4usDzyMEnIoKmGm/tGuxlduVUruDE893z4UB+mTiSzA/NCf56ydlcsri3YtG3PJd5lEoW7L1VVRZDOfYTDKy7JaQ2cr8iMGD6LW+KGT3/yJoGdYBazWpjZz6bSyPxKwROdxepWe9UVY7gZfnLhtpRBYAZgus6h2fBYY+1SEp94PgUZ/6RMLXHF2yNK36rCtQDZpAg7G6RUPlas/mBvHyWxeJNfoRa2Ah8mjMewEw+jxSQcGSsVlA==
X-YMail-OSG: i0zzkXEVM1ksFyYU5557uhMKYCmKiVMr.2BB8NOnPTHmF0l781u9pmy8XvLgyJG
 ua7.4sesKczrTmc.JK59NWuu_V09juZmmGkUFwgflx3BJfKG96luzvsypjEnqk9iPC3mM_jcm2kW
 Om4e4z4W2b6XEJKmxQELlf1D_uCMXnDBQaePAq1QZhEOjH9HtFSIeFxlv5mp4KBpq3UQ0Cs1FuhF
 Cha_UIAWmujy9hBOA2BsDf_l0MTWn13RvYshmAoHwBVrOSw.q7UlyVrgRFo_wq58rGCO4H6q5Gx_
 tl.CKyberFEpX8EKurtr82aGo4fAg8n87a_D2dH8rhtXWRPbJv0JIWmNEeY3RzRMMwZjZIjSNym1
 pL5yoHIRHxuKrBviJ_tMlKzacqcEFLzQJE0cAAiLPVnyyMcVobHuWLrEBWdm4dTMEMuJn1p68O5.
 Xf4HOGlxxzhGWOR14YpTMTP9YUE2rvXfiC012ifqx.NpIL2oFyOo385d.V2PcczWMfZXhzJW.Nac
 S3JPB97a0K.V5HsW6n5AQf6y.3lCldMnFxSysyWLeourEIKxtf5ePhM5tkPXYwuKl85MkMbtPDgl
 zLpzOPWxyrmXFalRV1NFSvUcuxKr68hl6_qEk0sxvUgLCpzIO6E.dc.H9wbfSSzx81SG0fnlXUtx
 Kw154hgwQkYozp9piqZuaZb2rrDvX_zRSoRGT_B3AHu4sAjHcjujw0bOEYpvJOPHYPJiUv06_NTB
 3gcOaMVYCT6dZlT4eu2.YY4iNDY.iNBAZtMyIiD1TBYAtdvZp8PSJsojYkjI923nH.Jc5HLETihl
 eMj_QXrTMrus4awlS_2rvCvC4rInrZ0e8nsqusLf.OFHiR22L7WBLMjglIQXu_KluoHTGmMtkWkR
 fzPXhjth47iqXVWxI2XGCsfCfD8GQ_IySXYpkoSl1MjS_aeT4HT1e5t1w1K.C03lTk8ArpTdDUIV
 5BJwuwomyEE7rr5nJfdZhGYzcER1n9cXx5V8eGDMr2KCTj8bmapto3lYgb3nPB8HZZpSuCjkVWS7
 4CWjIq77_6ngcGd3pVvasIZnikTk4OP6LESR70KjTfb6bnUkTscYYwThvE6KFpCsCka0HhXk.aaY
 6zaGgRVbod.ZEPHt4C51YhqtL9l8cJPyBGMwp79WjpbKxALNwkZItNu44TUIRbOUoVYg2HrcopCQ
 Jm3DfvHuRdmn_VojHYxTdf8mPv4Se.uncLVGQLY9Cy4SvzGoFPugir9E0CUI_zhhgSkVzSOaWwRE
 Gp4AJbrgsfJdRn4je_vsUZK6hcckjtjdtXZvtZseXSE95kIJ1fLJk.1TFpywtqYL0q7cycM9Cv2u
 ZzYuA0ICFxUhbOwJV2mo_Xd1ptRvqzftFArnKNnxS2cL4y.BYyMXvUOi.JA0Shpv9z98u6fD06qu
 r3YsBm3CELxRJ3e6s4kycYiE_qgCT4upGaWoIysC5wAJSGlKEuaZ0TGa2RjDgOpUn_lsY_lxhFhS
 Qy.pl_DloQFkCSXtX_W17xRgpx4vd5V3mESw9T72Q39cj8NLtsJDnibYaj1hKUPl5c3Cq9S8hvVF
 YHyem7leaDNhpYVhtOFEz4gUiAL7zlp44D_xClCSOIPrxCN.dLRAfw6Roc.r6_ZilEuXcKenzDpI
 I5iQuTsxR52s8W9K2mnR51FGCEbHT4b0Dlb4.jd66PDzKJkEGpJWZe9Y5aGXlpRRIhLvv7peEVOa
 Yataee2oGIDr6.4N7a7tnbBl9QQ69iZVywCpco6YSEgLtKp1u1djbmrEPP5QTHShiqnNs7b0brlE
 8gv2u0c.1aLSiEUL7gFJFh0YnSfnJemb1332nf4o.BSBHrdRcJ.O0e0zBo_oO_4Sx7BFbxCg1iBs
 VJgG9EKlat7LoGDySI3uewhok9GJnJcS9lhnPwnuz9m9n0PzDgTARqD5XCilWt3DG0NDD7SYvmrt
 fgV2jS9qpJ7tI0elL4TMb5m10novM4MyM0EeMwUdfwdDZrPoKMGhwYIrkYzFEFil.HJlGPyw2zIi
 5CnHdi4ifcuV0qbHgQUL02rji4LOUiGtQ6sY.qGNVMU_8iMIP0.9Ek8tWnt_YLiUD9zTOsIjkQS_
 WI5JBxTJLxY.GYKYBVr1mgAksK6pwiYDc5tIRICGg930rYVTTNJRQUHfm2f7q6DfmseSqshp9ajl
 AFWr1wlIj1fO0kEVnf.g0WuBPeJG.fh2dtl.8POxmo9Dnk_U42ePoRmLMwaByiRLtWU_uk2yB45B
 saYapEaG2Stl0Ung_YavZdmcaofZhP37ulTPekI7giaLp9J98ZBBC2KO_Zqe3UnvyzxNasrMiP6p
 XmU17uMOJTvUqkLnZlQ--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Sat, 18 Jun 2022 00:14:57 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-74fwm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b08f14069c990c2ed22165f3e3da032;
          Sat, 18 Jun 2022 00:14:54 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 2/8] iio: magnetometer: yas530: Change range of data in volatile register
Date:   Sat, 18 Jun 2022 02:13:10 +0200
Message-Id: <bd9cd1d425afc07cd9939e4b41ada39a9ca350b4.1655509425.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
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

In function yas5xx_volatile_reg(), the range for measure data should end at
"YAS5XX_MEASURE_DATA + 7" instead of "+ 8" as we count from 0 to 7 here.

This change is of low importance as the "+ 8" register isn't called.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 40192aa46b04..2799ae0784fd 100644
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

