Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F1E5916E8
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 23:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiHLVzB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiHLVyq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 17:54:46 -0400
Received: from sonic305-21.consmr.mail.ir2.yahoo.com (sonic305-21.consmr.mail.ir2.yahoo.com [77.238.177.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD4BB443D
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341281; bh=TOc5+fd/W86tPI2FR+KwSdGnTCcDbKSyaiaUexNx5+8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=RB1mTijGMA+9zR1SMeH7s4VoC/ZAFCceKi8VAyfI5oeaQaRiQWbTGrZLhcN7Z4ZMctxp1nozTHhVdMmqNJ1UFEK/9YB5jIoF9QAQdeMkUMJFCCU0Z6dpmPbDYGQYf0mVCXTsAxREXOKeG0cAi9qzYq+gk8BDd5yc6QvNMW6qWT4Wd3NlflpL4CyPNu64A+aGtTP8jzc1U/+xcemWr0VZv5gaWdufwbvRY1KAJbMTLZRmgZQD75sHCVjkC2jOBFRGUaIlY+7NXGwZkDeDhFPmN+Yvv+kknkioJZ9mLc1AcxZJ9bJ6c0HHuGkgQ18PvLq+g01mbuxI9pIcjuS+HvSCOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341282; bh=ugsI39zsbx5BdDFhwpHIOaB+pVmfXqIByIA1dXljgnS=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=W5idWDL1qt9vPTyr4QaKr+qSBA3/D6ZPqMyljiMkJEzXNK1hC+FFIchMIYmBKbFDBgnPgQS1UZ5SzekjtUQe5hOV11sbIWLYQoeZZ1GG36B43XacCH+9LF9n6XKwI1r/u6Z8qZfBPTG6TYjE9DmLUZmg+CzDo8roOX0hpT4ReKKRhlphqYjNL1wtvIvOaLKOy5vqd5K45CGOn5A2bKbwGhwvFcGN3N8uPGdNJm5AB2Au23qNu00/6rY3pOk70yNmCHfQY6z/7yhwtFM3/MqiPEQDVG3l10T9k9qXP/kJI2Up6xWMztsLyBNME0ZqBG0c3R4zl5qD+T0LtmMvPzHeHQ==
X-YMail-OSG: cayUMGsVM1lKEiEFpcBqSSr3pTKnLUc816Ul5bT0130t3_LP11CUaD__OUAO8aF
 AJc2nOEvsfB64rBENBEscsjN5p2Reqrc1eaqdOfw_rYRa4xbT9gxwZnCUe8BSbSBSW1cJtNfPAXt
 JySsbuNzT5bYWjBV0P5TvHh2M.P0cEEk9o83LoZBenrdedoTbyL5znvCoDNQdQK78dJ6IfN0HHXm
 rhbE.U.7yT556WD2oWOinrla3Eq_MPPf1Ua_P8HugYhmcVJrv94xfSR1C3B0hO7yz2t6iBOFaImO
 .HfJODdypeXTck3mAabg4LTq1IQJBsehlJYua6EfPy1.UOZHuCHsP6_nFi0y6XAIJo_MEloNGGBI
 OizVQu468g.GJNhqnVqvOtXzXJC_ODCulPAMTE4Hdj2sPdqBsLdJ1fCetHrHEvcqRMa8jnNJOlgh
 44pM8SHuLdjbBk0axQkEasxkIBeHg9CTI117JpOetRmbIvWvYyUPyu_qZKVBwfFoqPSbFU0SkUtZ
 5F7NC0zDpMQBYhZXIM_FSkUdcqzDUKxL8F5DU7qN2UrLkS9N1AQaD3IwFP3GgvLhXV9czdtJRk0Z
 ndRRKypDkp3pkEXQDYb3VIptcBVq78b6eXZh9GbEM_aAfk76T8QXJ9R4q_T0ZZVWJyFVpnHZ9pIE
 tYtmTTqX7paSYKpKZ6Y3a9elFfLm75HhsjN0pMCZNtBWg_8zGm4LRg2UQHdfKNVTu0MFyNl7HjwM
 d9HmMONH6gmqxkNj6H3q7ssxmE2msQVSpbqzAyQLfBy0C2tgNa5IHhZO_kxMaLe_ck6ZIp1mxsZ.
 y0aBPLXC3OmAQsNQsqaFfvRr5ZWQhDQ58pBV2KGwvyeeZSnJMza7DsHuGztrW19.urQH5rMG6GsG
 GLqt7cdE5NQyWDE9q5EnTatsiVsLs_MwElZqGew81YOr_778CA8Eb0gbqukxDA6g_WZU3iqMjuoW
 e5LDvmPsVE7WUsHcTlkKG2YFNEkjjItztN04U7EwjNSpg34BRcniiqZ9PAUYrwMFPOgLj8WZ1SMT
 f8Td.v4syY_7FCAfXvTUFl3fp00MuNBzxulS2V4NTga9QjbduMpipeCy6YcfeBNNzmEDNIF7mZph
 VkgcYNqo_zIhBfjMfIs9ZszUxzqVlmoIcxTanJt3uaT90Tq6t086EPb9fZ3KqjT3kxFLeQdeq6dL
 Aq6YvNgU3jQUHquRptW5Uux1UWqZ84KT26dM4dXo14gTJEk63Ll84tFcNDJ7PfDVaMBrDncuzSvm
 n3Y1FwQ4WXUOKYmNKeFYSbCfkKLZpmTVhfrMsf2qeQ_1QKQsqcRNfSoanrY5JAEpZi0LnMioXg.M
 PO61.5Va8X99ijRnN35.y3nw.89mJ_kfJ.OYvHUfAt2WWHjf4Nc2rRylSW_SysZ4IZpcZhj2ckxG
 CcghovPb3z9LP9M0_.5TnL_MoVZujZNiOGZTPoPg3paK2GVQwcX0f6UOpMhEh7NkoOgA1r3zTLq6
 P6bGzkrGtJZZA_rc_9SqDp73cKMXLhoEejUSWColSFHp4ZbSbkfKan3HZqJZoO1ECgtljgo34r70
 p5g9kaPPyA6t0bdcdLT1VEXDTMzi23t9FTHXlxBU3GDS23HN2SCEXFwHgXAGBC6QRXzAbSL85nTY
 MItN2WbC3R2_xfW90QkHpY8Bf4OovvtUaqYZAdGMAnlmGl8t9iiYvBC7C4FqZiH8xRTiC_Q1rcxB
 X1TIIRJRUuERPmzvqgUd.vuYY8_mjUFjkKjLYn8OCueR.d34jZua6zVO_kMWCo6hOs8D.VgrWdxY
 CHe533avsIk8xGYWi1efSjAPhd8rBM460yhNzU7jWQHyCgDroJjtLv2xRfmahGilgQ8lPH_f5fAs
 42NJtIrWHDqYqn99RzXa2Kna0O4YsH_6ApL.Q2B.4SwHDDfCc8QJJ_mOemejCbMJajXFHMM98_vq
 6RJJtQaD60HMm7IzlfjPxfmPMViEiU14IEBAeSdxnqcyzBZs73tY9NEJ0e2s7PQEFoUyAwKK47.9
 v7tuWX6dO5JI5tJ.UUZBzng5JVxjsG6et_L5XYTNmFk_gIsXoqbsipBUPL6XQNgTyIFmLFLeFFbN
 e3LXKzzuASL9U4h8S02tdtDgmBrf9fzvm3xGodvHoZGJm3TZ.s.htQkpem.vqCxztivDH6q.YuEA
 mEFO3AE_MyypJzljp2BINS6GYM.by_m2DncS75HdgJo.EXwlwUHBzqhnJAUbT8fyQQh2M9xiE6qz
 0CJPuMJ070bUDKC2mifsopkV4xzXYk.2.5LUzYxHb8F0VJ4x3ery2dyTpm85kp5wf4x6oAqqeD9Z
 r0hM38CBtQnmYv1k-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 21:54:41 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-sqjll (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4374eb8c565a32f837f1ffd0e5de4e7d;
          Fri, 12 Aug 2022 21:54:39 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 02/14] iio: magnetometer: yas530: Change range of data in volatile register
Date:   Fri, 12 Aug 2022 23:54:07 +0200
Message-Id: <dabba10feb80171350525ac874f944076c46e084.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index d1f16729c60e..76bff4818461 100644
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

