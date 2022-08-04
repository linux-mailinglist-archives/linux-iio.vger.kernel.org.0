Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C658358A0B8
	for <lists+linux-iio@lfdr.de>; Thu,  4 Aug 2022 20:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiHDSq6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Aug 2022 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiHDSq4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2022 14:46:56 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB896D561;
        Thu,  4 Aug 2022 11:46:55 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u9so339182oiv.12;
        Thu, 04 Aug 2022 11:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yrhBL50UTTJaHzMh461WNNj8NIR2DIRZ1vY8GGWYUG8=;
        b=kPgwJwi8cH3nQMG8047Ci4ChTjm/z/z4X9S5omCPPRH9+8MlV3YSgwZgCP36/fDNcn
         OBNz4TSZw8lvI7HDKEjz5g8NkuCCMU8gutxgimyGs8NrCTvOykFDVXcFZG5Tzo5mCCBY
         XnMNkpTLOwWQbBZ2A6hssJfwp34FZN/YKavrZi5g02sTYE0gMBvapMpcPvjMFY02jCYU
         UWsWRqRY8GtEZQ7AX2yXsVUSNGaZfe4u/SEv1aLCDp0GrK8gR2zhnrsI83qwxDlMQNvP
         u8OI9xZ/Ecdf+adNVLSLeWZbZP6ttfxScZBchDU2QQ5w+WyeiVzA9LdX06vWF7RWUnS/
         6AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yrhBL50UTTJaHzMh461WNNj8NIR2DIRZ1vY8GGWYUG8=;
        b=nZFv7ZZPDl/aPduu1P2Dk3Vnn0IwnbBQmw4LGxKPjJ2BUErWjbgasmo10dE1ek0G3z
         5AtaXFJYiVGsJow3gj3EIV19KGYZjP+6UEktw2d6lMyy9Lce01NYDKTdp7Zy8qY1/jCf
         uALIXUHlYFlau1ats0bB6n5b5jZ6t0nUytZr+Jlatv2vL5/68yzCVn2I8HJVnIGsSPF7
         3C/QvxshAdNyX83iDLfCed+fdP/2yOdd886YqK4bD4JRa553gh8/YQ0Q4gaWXmolYzx6
         9Iue2zX1KI4RE10GiYkoOSX+pSi/mGIRui6RGteFRpmoA4yVzkWC8OEWmmwBRYsExLCW
         2pyQ==
X-Gm-Message-State: ACgBeo1f3ThzYIlScK7NbHKnZDt0/l6JLBNiiPIDhFD1DuKMmP/lKYlE
        lyWPlUiBe1KTIYmtXX+g1Ftu5y3POsc=
X-Google-Smtp-Source: AA6agR7qEcF+xFl8S0+7b0/FI7+zGh11rJ/0mFnE8PfpUAJaRHKdR/MwgfasJqdrsV32vqgiSkxO+Q==
X-Received: by 2002:a05:6808:300f:b0:2f9:81c1:7691 with SMTP id ay15-20020a056808300f00b002f981c17691mr4618142oib.208.1659638814350;
        Thu, 04 Aug 2022 11:46:54 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id p17-20020a9d76d1000000b00636a8dafdc9sm87945otl.2.2022.08.04.11.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:46:53 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v11 3/3] arm64: dts: rockchip: Update joystick to polled for OG2
Date:   Thu,  4 Aug 2022 13:46:44 -0500
Message-Id: <20220804184644.20710-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804184644.20710-1-macroalpha82@gmail.com>
References: <20220804184644.20710-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Update the Odroid Go Advance to use "poll-interval" from the
adc-joystick driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index 415aa9ff8bd4..3389755dbdc8 100644
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
2.25.1

