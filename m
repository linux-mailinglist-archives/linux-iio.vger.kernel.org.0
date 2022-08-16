Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02CF596426
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 23:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiHPVEz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 17:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiHPVEy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 17:04:54 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06FA78BFE;
        Tue, 16 Aug 2022 14:04:52 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w197so13401462oie.5;
        Tue, 16 Aug 2022 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yrhBL50UTTJaHzMh461WNNj8NIR2DIRZ1vY8GGWYUG8=;
        b=iSTH85RRCQPb0TqUxqm6gRr2OPfhosNC5566I58X1fgNmFpQ/cMeA9K7KseOdeyQuN
         DobAxA7q5v8Ku5gtFjWldU92c7KFMzcvRL0VMKCSNHvrRg8NBa/cgVj7rPaGPHi2eXOf
         tkO4eXTDf5qkFj0/Ea9EJ41fm4nloRVARZdaEo7hlykS3QT5iHu415qOjF0dHPHMsweN
         zwKIO0VOviXK5iNRiP4bVzN3V1R5fpjkkEaljFw66387Kn4oFRrnDi3+P2NiqQO0h5pI
         7lAC8z6QwpzGgvLSkOP8lLJDyY1OxxPnJdLNcCKRyk1DD4n4Cmo/8AjgX4pr8QZ/aSCM
         6Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yrhBL50UTTJaHzMh461WNNj8NIR2DIRZ1vY8GGWYUG8=;
        b=11pIwJhUSuvI55PLYtNCJUaqLmQg5Q3Pv5rJ+vK7hwKpeeR3DhVurPWRBoBFLe+jVZ
         YjyrkKK9WeNFU6z6dD4w1Xg0d+P1sPS+rkqxScYEm/S8pQbd62+qt8tanDkcMbI9AgXT
         Ncxz4LZ5vLksD+aBiqeEJtaxPlCO94CKik4IO93bG6L7v/ZbKJuzfi92XWwYGhbXf28T
         +sapUr6zy6ALCHfvmLE1KfdIHovklro0a8iMKMoxJcsxtEV4vzQQkU3l6BCg+4HLiP/O
         JRZGJElELRL3PqzixeXWo7cOj5DKZyqdFVdd3vZYOLf19AsC1fqdDL8RHDfPHVtDUxHx
         hfYQ==
X-Gm-Message-State: ACgBeo3ftzvyfBpXSN7GI/+RRZ/3HZyZrZiOFLH8R+7+OT0I1DSRj/oG
        iS+6w4Lru0/3bvDeoZtQNm3geGViKiE=
X-Google-Smtp-Source: AA6agR6Wg+5A18uPszIxrKEMO49o3cZj9pspbXmrojqlTHGC/FnTbgaFVMMmwi0InDU1rTDIzd7PDA==
X-Received: by 2002:a05:6808:d1:b0:343:221a:c35a with SMTP id t17-20020a05680800d100b00343221ac35amr175136oic.95.1660683891262;
        Tue, 16 Aug 2022 14:04:51 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id m24-20020a4ae3d8000000b00425678b9c4bsm2599653oov.0.2022.08.16.14.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:04:50 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v13 3/3] arm64: dts: rockchip: Update joystick to polled for OG2
Date:   Tue, 16 Aug 2022 16:04:40 -0500
Message-Id: <20220816210440.14260-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816210440.14260-1-macroalpha82@gmail.com>
References: <20220816210440.14260-1-macroalpha82@gmail.com>
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

