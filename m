Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A14C560C51
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jun 2022 00:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiF2W3v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jun 2022 18:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiF2W3v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2022 18:29:51 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAC311445;
        Wed, 29 Jun 2022 15:29:50 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z191so17426545iof.6;
        Wed, 29 Jun 2022 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8oHayPC4C21GwTuqNIRSpYwzaW9xbbGy2tBzWRNTi0=;
        b=bxcr/9oI2ms0V3MJbjc+RmrHuuY+gw53i6lUlfk1x+4wM8qIxLhu9s3f6m8THf6Ive
         KSNk5EMtBzTWdLo3L8pX7FenGAf2nmv3rXPdpS8XNdTByVGUdmoK/UQroqAAvtL5mjsy
         fKshAQmheFp1n6xwcBLAqroRbWTLGce7bxWWX5/lBLo86g0c25wNVLXd+94pvuYC6tHE
         AFBor0j8hD7awptqtBpvzu928nOEVdUSPGonYYToN7ucgPgb4ivaYe5R7nF28IjQRqRZ
         YDNovFmsjS7n1o5TvErT2P3Hlarp/f/3M3A4LYdoGW+RizQUC0lfQK2TuNcv0d3oN0G8
         OiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8oHayPC4C21GwTuqNIRSpYwzaW9xbbGy2tBzWRNTi0=;
        b=uKoK3eN8zbYGp5lgJoKsx9AVNUUMXNZXgSvfVG3AK4QNhmq6YLAe5RnV6pq3F7uYOG
         uL8hGg3TF7NeAsdEMeMXS+61yjwvvm/Uc6ieoQkvYKWHtnf+VWqD7q7Labmc4OJsJVff
         7MmjiBE/gPYM9ibTB+7DhQDsFECWQf/MprwUNCi9p9TImsKIhfL9EvVuW10jXN0SSMYT
         pBq1SWQY8ltdrK409ITzQGuP9vW8SX30Z5BwNeyfNim/wtRFNyKSsXM+fnywxp8XPCPb
         BdFSjvZ715yrNVKKX8Lxc3iE7AJa5SH5JsgSifbdnVaeAN6vQsEpVUqJAtBmK6SebRqM
         wyBg==
X-Gm-Message-State: AJIora9JJi30x+e1PGuGcKQhF1LzD1Val328DaukZFWJKE5VbZh9v4zB
        olo5uvuc+zQgSlxNyD49N2PAGFHG5Ek=
X-Google-Smtp-Source: AGRyM1uAcFxQchmC9Hsey2b3E1qiT3/BFfWCMALO+0ThlJ/e8EykSPpfetn0jvdS5Cfk7wBr8GqAdg==
X-Received: by 2002:a05:6638:1691:b0:333:f345:ef6c with SMTP id f17-20020a056638169100b00333f345ef6cmr3317153jat.7.1656541789958;
        Wed, 29 Jun 2022 15:29:49 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:2d4b:b7b2:944:3519])
        by smtp.gmail.com with ESMTPSA id ca19-20020a0566381c1300b0033158c4a312sm7845597jab.55.2022.06.29.15.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:29:49 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v6 3/3] arm64: dts: rockchip: Update joystick to polled for OG2
Date:   Wed, 29 Jun 2022 17:29:30 -0500
Message-Id: <20220629222931.30599-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629222931.30599-1-macroalpha82@gmail.com>
References: <20220629222931.30599-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update the Odroid Go Advance to use "poll-interval-ms" from the
adc-joystick driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index ea0695b51ecd..5a4f81861e07 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -26,6 +26,7 @@ adc-joystick {
 		compatible = "adc-joystick";
 		io-channels = <&saradc 1>,
 			      <&saradc 2>;
+		poll-interval-ms = <60>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
2.34.1

