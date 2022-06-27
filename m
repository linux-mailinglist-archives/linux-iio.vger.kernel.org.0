Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0202B55D34F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbiF0WPB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 18:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242481AbiF0WO6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 18:14:58 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9C4F8;
        Mon, 27 Jun 2022 15:14:57 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id p9so6688772ilj.7;
        Mon, 27 Jun 2022 15:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pV2xTgdlxdd1ooYEnYbOQKVwbFMX8hVbxWQ2hIe3+xs=;
        b=RcsQhNjF7KK48nc/jdZpKDrn3PkpNF1Vp/D0KYuAbR/ThnCcKdtSOS/iZheghJNA/I
         BZ6/HIVLue3SZeKbjTUXPKaAXud0ihMjBDdAEIF//1ych74DYGKTejOsPluKYDW7upmy
         5Pwm1gIPnp/zCN4BMyP8ec0q1kofbW3Y3PiMxyDQMusD9PtidpAK9CBsa6Tl2SXBCwf2
         f+h9EsjWs8utxuB3OQRbgKfbR5a5g+/yFBaDqcg3bH27JJ3ZBPujaNysB4izspw6aTMu
         bJx8pg17jStg7JjqH9O1aEio/7Bnv35TnVXdvdN4e6SkMMz8TqLuCGB4pzEzZS8Cr2Vp
         QxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pV2xTgdlxdd1ooYEnYbOQKVwbFMX8hVbxWQ2hIe3+xs=;
        b=4RSsyFNCSZ2UTgEkzkOE8Vv6xmGOsQ1BRJKUNVIREnsStSotRRo6yeiEONEUZyTNst
         w1yUvoBMEFh3aqv7RyOP2o+Dbi9MwKBQaqk8usFpzGnbtiJyx2WaVNHK+Tn9bnbZ8Dj2
         tXk3P8NwnFmRCGmbK2K1APSDJ61Fl5hYBRnLP4DvsECH5Qt506D991dkl//97165GqDK
         rIHgRCMqIU3Z+RcAiB585UhF1FQeWuKfEiBPnGTxMnvrUppOttY8iZOa2h9VdgxGnt3T
         7vS0fVnvoyv30C79jBD7Fg8vL3iZNE+DW6ei6uJd3O9L8BSFKZ81/+oDGczE0Yhh9pM5
         stnA==
X-Gm-Message-State: AJIora8ytlai07F3rOVIG5HmP29yW5KHNDD+RjX9Oyneu/o4mkmYPz8f
        RFXdCPS1aYF/bVmpSpNWaAn+KR8Vxvc=
X-Google-Smtp-Source: AGRyM1sSYIygi5wqOxH0x/IcNyKAoeaN31dn0MrnKdLCpIL/Ttpyh63NcKCmhDOPUhpalw4VzNoTPw==
X-Received: by 2002:a05:6e02:1608:b0:2d9:3f3e:f0c4 with SMTP id t8-20020a056e02160800b002d93f3ef0c4mr8918971ilu.249.1656368096528;
        Mon, 27 Jun 2022 15:14:56 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:7a85:cf35:f4b3:542f])
        by smtp.gmail.com with ESMTPSA id p7-20020a02b007000000b00339dd3976absm5255589jah.110.2022.06.27.15.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:14:56 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v4 3/3] arm64: dts: rockchip: Update joystick to polled for Odroid-Go2
Date:   Mon, 27 Jun 2022 17:14:44 -0500
Message-Id: <20220627221444.3638-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220627221444.3638-1-macroalpha82@gmail.com>
References: <20220627221444.3638-1-macroalpha82@gmail.com>
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

