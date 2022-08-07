Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8083158BE2F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiHGXDs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiHGXDp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:03:45 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0DE2AFE
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913422; bh=F7BpDzS7greEJoS/tBb1EI2GHOq6sKTMQeOG/t4ARZY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=a6SNXd5cbkg/zmKadLwnfdwBQy0/zb4GnF9v8nkiJFDHozeHzfxRuaifX4+MXPGDfIskrvuB9kclMD5Q/LnGhgHSoyU8IG1orSrVBLNcmRpBi5yDNQLjD467Aj/0zBlpUUb9SO8Cm4zVwxTWY4+xpWJy8k1zB3pePE5QeH1+Jx5vpxwsd9LTVsm/WC7aw+MWNL7nbMUSvKW97s1Pz4dvCexQY/K4ie1oHFrf3rrZu2ScW5174AAvVJq1LaUQ8lMBKtgaW+wLtIkeVq6OnQnlZb9pUUTJfD7LJe0+viQJ6nkJYtnNirxTvrkGgrDrzmaUr8GiVhYVGfrTojH2FgZloQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913422; bh=tSmXNV+CCu/AUEvsXrh/E2rysl2C5CY8xOeHK/jZAwo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gIvffvO/g1E+izNTGWCZW+5xwn8JghP0W1uLOnLjPj4iUN4IL9pgt4cCkagWhBk0B5Y5+JMUHkkb10UnP/ItIPLFm1D3NmXEsle6zVCMGMp3zSk1EL3AzADTtzN06VKZdlGslel3WbmmfF+5vMDDeYmr4tEKYMZHktcgzFfLkfxucrb75FZJMVYG5eQHd00SXGGZ2hJLAd4+uhftHJa3rLB3g30CZVE59b4J2TwhVBohxDQuZ283PAtgEN75FJGTmQyXaTsNTftr5eK9mnJxdjzRuHoPQ3wfjrYTDkhDo+wuavRGJ64xcxO5JKf/tWMxcLVH8z7dCxr5KDNuJRIAbg==
X-YMail-OSG: V3xXU90VM1kHEN2NepkiLEaouPojKe7J6HeZXcHNziQD9wVocovrRLXbmCLPs.H
 Ypmw0YBM6hbZBCuY.v4NOwIkryaGnmOUY6iYMXNeakSpdeqXDOCU2V1Mh9TZQHrR39iHGpQ1VK4y
 zQeOoMz8EW2bUinzwp5bW2_JEi0br0PNiLwYxJaJfIswqOJnadbBY4Nixl8hRDkqxel6b_EWRSkB
 vPtD8_QFKNHl383nU1eQQJxkg9a5wfIqgxCXsH0dHF1RCT7UvUU9DVTHJvkyBJ3GdsTHeP70O8FX
 QujxvNDG6wKpJ9x3le2RLY7yf0R6oDxW6RLlo68Fy0QHvg0WnQi6DX9unMB5Li84xja9Iyw6FkY4
 lbgrGbMmUDW1CBBoaj14.nXanuPRSMyCskbpSaChKDEfTN3CjmRd1Wh7_5A4GJKZW.3RIzjQGflw
 UCelaZXKpkdxOS87cb1Pa.WlYwTPuQMQgl2RAvHoZwXGnzdakzJtIslQp2F72sKrNQprU.cq86a6
 4sojyZ8SJ3QHhTe4skEmqiZs1o.PsRp4uX48XvmyELNbb.V.wRSm94JNWpsi6cfvYyKIuDXs6gex
 NBYgjPoqu.O.GEiaQcwTEmYgLSQ6qSCnar7LVCg6pAhR.jd1ig1WmhAHJXoAISZePm3yzOTJYO5v
 WahfCMxQy9o.AWbDTo3BY58Jo.5hekqisDOqKoR8DTl3Ggoem7M8wYwMqauwHOt2mJKqqRZrjo2x
 45UdTHiyGV4cqP954ic9NjdwEA7.H7MD3pZtpod5EtTSVqlH37HVEdp45kONjerS1ufHTft8o96O
 HpZyT7rAQPUaU0DiPsziEV4Drrh4FZV5jS3TdvWDil.xNvrshZQQ23fIGjM701d3So9YVtnmrxs8
 VIYIL.gpecUvgLr6VjrMNTIIO449TWBbsEcj4Xh2Ve6vZROpPT62eaAGf2Qw.3xagJr6RlQhjNbZ
 YWtxLbpLhXE2BwxMJvM10_c5OU6bLav1NFelsUzkYzx0swIcoS6_hL.ULoNOmoCKKSYsinU8NOp9
 Wtfv6O_dXm6FGXFxfT5Ao_Vx7EJgZ6VBeyTnVUuVieX3AZCeP8_S1tNlqqtDF8NyLGvuvPlL1.Gn
 upCqVVisNqPyesnNgliHbNWc1U2sM8prfL5ciAT6TglB8Wb3GOm8wrADfKEGat_b_fEQdZjFFZ3n
 Q35YJcQQIdkXaoido3bpPqDASpe3NWi6PUXKKERXQD78Nu_GMDo2yxeYVege5fxhmiJ_3jkx7dil
 DdxLfRjsUyx3vd_T.lodjMh8_L1ceKaDf5engDfCtAoj6PQ6ReXt9HbI8Pwp7sa72UgyOZ0xbKQE
 4h27B1RaS5I_Xq_tSwqeV3deBnFD3AaLGSRQQkO0VxuJOGNkjTiy5enV2DcASm0IMT4FphEq6FQj
 LA6bkeGpj1SgOF5b2DRqLZXvHjGi9n0MAIFMtUrPVC6IAgGyLXudyLRCB1gxIQ0ylvHVNcxQfnqn
 xD8kXb89P_.FmcSAjrTcTh.wDvFanzyB.tF_pUMOe5U1yOhkFHFjJFZlfN6kVKb3MoBTGsTxwP6T
 _V722jLhKAn.UlMDzl__CHgzRjLZSyHp19jKn.7p3RZ3mV4xbGsto7rkQMxladAOi56_1972KUAY
 J4OqqYtg6tjCOKWRwcRs.DRsmI5LRXvjCOBpHmKE2A2Fi6VCXW2SnG5dVeW4njaF0kpN5.6ZzdoW
 cCfO5oV53wb36NRM08nLcTPd0C0vSsGujBxUU48ppVpif6FPU4rjWm3SnD90xUI9AHFb_vCJ46g1
 31sGaOQWB64u5z_YgS69GUm5GwSVZB.6uxIC6UE4dSfHXrAak_O_ibGfPW_wYKfdgcpuObDy30Tx
 yXotxl4dIyNDnodbsRnVU5EbX1hyit27m3np30CtZ_uD9y3cgs0cvcXEFhKKcipMq.hnB7bXOgpO
 kKveuWA..RoVG5GmLA7nvMc1pYTngRKoyGIB2CP2bJNLWz08P_T6JRivcl72d.yUWDdz.MP.3wpK
 t7QYwrlUrvnpwr.YMrfOYA87KcqSJwXyXo22bswnsBJ3erFmyqypU2globvdRLkDlktZI52XhEYg
 7y77X90TwUTV9Gpwy1tJ6E1k7ur_QUxYrcDFap5cpUmEQXyIX5H_facTdUUQloWrVOPoGQQk9me4
 FzyKOQImqzCGbwYHP1le5JB.WWhoJr8IiqxIYzZgga8URC8eSp1r9G4kNqQim3oiz09BOlizvNao
 9ATPoyh7AjiCTpAMeZWzFoGb0ac.1rukxn402EsbescU3vvBLlCgoLW67dpXQgwBBTjvBSxIs8di
 JGxVmEpy62QYigA--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:03:42 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-r76pr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12b0bfa600682cb6edf92800aaf76d46;
          Sun, 07 Aug 2022 23:03:39 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 02/14] iio: magnetometer: yas530: Change range of data in volatile register
Date:   Mon,  8 Aug 2022 01:02:07 +0200
Message-Id: <1977ed81c06684cd08d90bce272c0256bed93cc6.1659909060.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659909060.git.jahau@rocketmail.com>
References: <cover.1659909060.git.jahau@rocketmail.com>
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

