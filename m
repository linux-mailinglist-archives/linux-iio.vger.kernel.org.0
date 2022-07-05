Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F48E567727
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jul 2022 21:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiGETEK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jul 2022 15:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiGETEJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2022 15:04:09 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3525E1F2FA;
        Tue,  5 Jul 2022 12:04:06 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id k15so12033052iok.5;
        Tue, 05 Jul 2022 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5mR8xFqGjjP4W/nW8ZmW82KHWo8ArnxMdtQdz/0Xv58=;
        b=Akho+oNYYzMJsQJYNCLDZUNWuBvocCA1oS7XupTuS1pc35+87NcySHqmXO9+XNxTX6
         oz/RWdwuOY38bAeOjJvDMrPLA6ipJzoSzd4ol0fZCY6uOhhuDCOwuVaUIwmTD+/Nnej2
         x73aq3HFAY0SnHG5s5FIQ44uBBy5o1v/1ipf/+Z6wuLTsRUMjLGSi3WvyRhB4Nu+1nBt
         xItD7w/rlj/2+uV5Zql99j6ENcL7FjswUujGHHW5hNLsRS9wccwY/FzUZan7wRYZJn3I
         e8lBFosav1lDhynlwfnRsjqgcKd78H+m2WRrDqUhPgg78W6pnbHi5tctDaD+wV1/ZVep
         inVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5mR8xFqGjjP4W/nW8ZmW82KHWo8ArnxMdtQdz/0Xv58=;
        b=VcOzQFRSoJXJO2Yj+F5ooSZAUefdkxjHdmU3BHHhHWZO9n+HreMIJ+9G/WfvsA7foJ
         ygfQBgQx4sOt15Pu3seepN2A88kePJWRTjo7Y2BUCsvREdUlpV+8kZO2BtdrIvrjRtAm
         Fj7wv0l8sjBbsTkIcWHtFPWdevt+iWhZRLFUXt4E/UlrnyJQkf4sx8MGGcd79vg2wcXc
         nz5b4v8XDzn7pq3R/ziEoYs6iR2ribtY7AzpdupUbEzZBbjsVALokXbmFIf49Xh7eaxo
         xAo+1Co9caSDgPGK+VzZpe/q6ePGVi6I47QnMDbEj+AJI92oovzd0oIJHYsRj6fiVBav
         wvXA==
X-Gm-Message-State: AJIora/ODfyFHpcKG2i7QzjJpkBLitFP0G9D6SZeXV3oyhKeaPrAHNfx
        mcdnTPMuuDhPaJWTXxs7LB0BGR7Ki64=
X-Google-Smtp-Source: AGRyM1tdnWKKjsE+zYzNvWtHrhePWJ7yVdxYfibU12etrCbr8d/XSsRDrfFr3f0GBMQITni6Dx9B2Q==
X-Received: by 2002:a02:caa9:0:b0:339:e1a6:387e with SMTP id e9-20020a02caa9000000b00339e1a6387emr23086464jap.97.1657047845295;
        Tue, 05 Jul 2022 12:04:05 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:a8dc:16da:96d1:2d19])
        by smtp.gmail.com with ESMTPSA id d93-20020a0285e6000000b0033efe01c20esm397762jai.42.2022.07.05.12.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:04:04 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
X-Google-Original-From: Chris Morgan <macromorgan@hotmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v7 3/3] arm64: dts: rockchip: Update joystick to polled for OG2
Date:   Tue,  5 Jul 2022 14:03:54 -0500
Message-Id: <20220705190354.69263-4-macromorgan@hotmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705190354.69263-1-macromorgan@hotmail.com>
References: <20220705190354.69263-1-macromorgan@hotmail.com>
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

From: Chris Morgan <macroalpha82@gmail.com>

Update the Odroid Go Advance to use "poll-interval" from the
adc-joystick driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index ea0695b51ecd..61583c3f24e6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -26,6 +26,7 @@ adc-joystick {
 		compatible = "adc-joystick";
 		io-channels = <&saradc 1>,
 			      <&saradc 2>;
+		poll-interval = <60>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
2.34.1

