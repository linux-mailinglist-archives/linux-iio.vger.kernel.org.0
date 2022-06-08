Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89A543FEF
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 01:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiFHXil (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jun 2022 19:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiFHXik (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2022 19:38:40 -0400
Received: from sonic307-7.consmr.mail.ir2.yahoo.com (sonic307-7.consmr.mail.ir2.yahoo.com [87.248.110.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DB620F6A
        for <linux-iio@vger.kernel.org>; Wed,  8 Jun 2022 16:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1654731515; bh=FZ2XVHiu6e8paz+eRBGqbuWeizAOJKpmd6KRMQDTcLg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=TUJkK+J7+vVxagZi52vuFT5vgUBvjDYUyq/npWkX/eZ86eCqeR2g0bedgLEXUpVA5Yov4bFzTZzTTqrU/9phZQN8amdyqpDYUthb0zYAsyL5pqVMfdtTArkDJ2iCznUYxAKt9yaX4Dixdxut+ycUC1EwlV5V5Hsxtul3lsrA1xNhYf9DvpjvynpLMVCbHNAtGDpjSPfXhcl1eAB0I7OOgwsqztDMkS9qc3Mfwo2/YI4btgs3KCv5XUEiEmtjcgznDUqIGW/7wcGHd1fFeHZa+HR2RlD9FzqsNz7K6wwnwRf+fFpybN9f/FSlYrq8p3hjejH7ubqIpqUUAkezDpHakg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654731515; bh=/Tpgm6BjEC9I+OXl0W8SP3NSUcqx/0tdL+0uRtJbjQf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=k5ipKG4vngoGU3Nag9iz6owErecKE5UO5h+FSmkXckzF6nUJxcNfO5whFQJgMmwU/GzZ5TQGhzN7S5xqB/q9G0s8dg0vviGbLP6Kz//JEyT9s8GYpoDTNDhH3X7FtPcnuebvBe4+xD3ZTN9KhnddaOUMbo4hEhpq8Uxb5mRd/I7IVeaOL9ml5gOsx36Q4QnlTJPcCPOGo/wgKw2W2N+PBFd4E49pVERPnQTUN78vxbTCB4rhvyfKa5GaLkawdkoKWzotncaMniQsmClfw8UgcgkP4wAmy6J/WlIffBRbStKjz5sR1PlblVAwJjkrdXTPa+ygTlQ359q/8/6i7yoT4g==
X-YMail-OSG: PdcEPJcVM1mXPshpX6JCvw7bi2Znl7LLn8IiErVkVdvTGqWt9av2E9lEr8QDSEp
 wxJ0Can.BSXLLv0abI2gIrIVBI7jsUpvl2g0dY5f5RQhtXY8848OiWqh.vxA8c3hiTwTWZO46z2o
 z9PnmjkpHinElT1Zh2adW3qs3Cer61Ewl.UKGDqrsjVRljH6HonKTy4roxdTD4d6TTf8Kj8srU1m
 XN3kL9MefAPg0yA4S5NPqI4WmUx4hD.n0JmUUBx.Pqk6qbA83SRQdrS4Ek2XUMmu7qIciJHbtXyc
 _ANUVt_7sOYNBbfykBRbMnwE2wiYB.BuyHRXGw2NbblX1Qwj0hfqoO3mnbTsuosZhQvBIHhP6sZq
 C7jW3wyyv8v8Fzek9vnJt5AvwviaGjXlSjW79lETivix7xUF9P.kGkSBqBepaq7qoM5QNFWIgR0b
 aDHP3o7FHA8w8U.VsxmRl4nLQD.uPdwg6VfU7wIWSHRg78xPbHyzjuRZGHBLLp7a2Khyzdrxz8YH
 .CkvR7j5DQ5XNnt_HCuhmY9bEaZzJdr2ZrL7FSX82WAP9ohhWDQe6fM6iDvZi0AeUSOx9zvekkTD
 K5C3CW1s3yI7tqNelB9ltzwFX1871WKMflMaHT1BU9DpNKsk7CE5Ve_sS8N3onulaK.mTtieZXtc
 aCf75JoALqjDE4YQiK.qOTUDvTZL41Jk.y4zcAqSFOi77xJpqns_YBSk33HbhPtZv.IBaSATKYxc
 C35QBQ0nYIyd_DWmnR0__LBRvaKJSgr5LfnvuJpRL8ZU_jr8Ci2tgxFSyrNTw2gzIT.lFaFTHeY5
 AbRKATu8skrpvu.WEcof23nN1NumGrESC7ZXomz8fyHmw.2LpqgS3GrzPz1cAnHkwFlfxI65pyhi
 3CVp6qGF8IeS_MBHgGrRixxjrk2wVd8xmc5hFq_FnScgPULYbCQ2A3Dhje4YjQAl2bP4i3KN22FW
 CAV.qdTxQnroug3O8siM45J9xbS9gYfdRCDa0UkQtJY77.wZ2HrfElRfoOqM9RdZcpz.jioHKCvC
 cpCjbvpChr0KUjiYc3Qk4M35oChcXHiOcX_3Z7w2.9yGNm_BMGDaDhJ2ND834ifLVtsBwvvIdx4O
 jApOARdvEYGUsX4tY.yjWZnTSzLKIl1y876Ph2lX2pL3_BS0EnhqExHZlV0DZ0uy7ooUVDYI6ySS
 z1YKjnvv4xbo.XuCmMEejJS.h8VlfOSp3xdZXDAqRu6arqtGQDGKpHMK29brzxa3cPTqPzMRswz4
 J_yKofwHstRh1jFayLWtyQ0fgT9bYIslmHxCXrBK83elxUv9UGS67n8XWTC3qM1DEDDqariAMctx
 ofn7Jw0xy0f0LO.J5zp1g_nC8mQTwHQmxhYQSG66KZhMXC1HgCJlezEMjyYVu2a3pHbIpYtwZHoU
 4SYAKMKoUBoPujxe7gA4EbQJA9X64ZywMXs2Eez5doYRuPUKevhHAt.2JB4fGgaU760MMRiRBE77
 MHzraXs2pyTUgtT6SUCNv50ufS0yGNCtM1FxDR.0Cczyca_sfx5kUoTEQst1uBsgaz4hVaItz.k0
 _xXQm06PwvHqGl6sZdQIz38GjzgOEBP_CRk1pRLN0XANA5H75YxwNLcZLrjO8Y3GmkqJeCQbqaGE
 v1OOooxULKAsr7HfnypjEhswroaAf0YEqUWFyOF4ao7Zof2MuXF4suPZIuNNsvmFYGky89Cn4dyA
 0rwuM7rdD.VTYb_HsjEV5JOtltzH6J7FtUzZJvsvCOGxbf43uQAhhjKaNJuCXhTz5uO2h1c7mMpy
 m68d5xxgrLln.9LsRNdQxHUKnYvGzjywT6rQ3XRMzAkLE_cCdi9KgDqeF2Yqgb_ChjCf0LD7_Xab
 VJFGELTemffToouFiPJqEJW3F5W.Wi8lqq5Yj3bhYx7WhZZA8pbmRzbGqhQiOvVtMrSCJFGNs8SG
 GSTVfExVor6iE87U4jlshzt8EmMff9rJ4y4gwFBGHdOKHt8ywkHIrsoDrNFcsgy_ksiIP3599D5.
 NHv7q3M8fnCpSK2qted5wKhFeqZJaNeELOah8NTSKl4L3a3ZHmVDlsyyuk2r6mf.GuwXwz4LPx.b
 3zuagTF8vL3vBUG34tV_C9V83j.AKMe.mbBUb43mhzn_5JR0x3thmh6B7eQQUGl3QqjBTNo3Syiz
 nVlyVY1i59qA99m_uSBzloDbG8Noxgfig7h4M4l71JCFTde7VEKiagSgFBrOO1Iha6.nn6Nq9K8u
 cqr_UpbjP0X9NqypwsAPn9TYgVHkvKEVW5Y0OpdNx8XLjjy9djMOaJ3hXs2k2v1jUKYr832u_Qmn
 .e5TwLcl3pjQIkEGs
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Wed, 8 Jun 2022 23:38:35 +0000
Received: by hermes--canary-production-ir2-6c7595c778-tcd7b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f9021a74071b88f5034921531ba09f62;
          Wed, 08 Jun 2022 23:38:32 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH 1/7] iio: magnetometer: yas530: Change range of data in volatile register
Date:   Thu,  9 Jun 2022 01:38:00 +0200
Message-Id: <719fc290550c40ccb75b1444917b91f69619806b.1654727058.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1654727058.git.jahau@rocketmail.com>
References: <cover.1654727058.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 9ff7b0e56cf6..425281401324 100644
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

