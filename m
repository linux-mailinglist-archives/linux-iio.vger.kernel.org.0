Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D4F55EDBA
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiF1TP3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbiF1TPJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 15:15:09 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE63AB70;
        Tue, 28 Jun 2022 12:15:08 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id w10so8822700ilj.4;
        Tue, 28 Jun 2022 12:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O8oHayPC4C21GwTuqNIRSpYwzaW9xbbGy2tBzWRNTi0=;
        b=f/C5Lq3rXiFfjdyJhtf/aKXekBMizvPbGJRee/3Ow4A+CBcFEBdMDX8kMcRC36C4L2
         D8OfptHIsh7JibPBuxL9Nu7BI/kJqI7b6XvUNNWADk2Xsk4RvyyRof6vxyzJBRlejlR1
         melId5+WMeOyZK4S6TUXyVDnSkDfE/s3WiZIo8TzInphtQT5CtZZho2/J6Z9E2V/ZzK0
         4tX8pv4SdL980rm5r46Jf9BAo+qkXMl41MIjL0h/aDDObZ8hVxL8DHo5jcM+BHbBxMSO
         aWnSCYDTFgbXwRXlM6nZ6wLyq7A7/jc2XysWmvHx8voWjQ6j0ALn83THDVHBNxRAMq5o
         /MhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8oHayPC4C21GwTuqNIRSpYwzaW9xbbGy2tBzWRNTi0=;
        b=A5cdK8o7Jk6E55Dc8JY03Fm1IynPWycE77RYejs1C3FcdgxudwaXhfXwqVmY+7QVtC
         DH9AwYGYXuBwTUgn7aNzyTH8aGw/WYDO/rGzpIT7/95Eysdo20kR0VMkGWtJQ3p3+aTV
         LYIpUfLYXocOeojjOh8XJ/Zd1t0ixiXMdPMOEx/NqZ9QouFRS8zektT+DNF5SshA5a+2
         sVilW5jnAdHZgmrGbP44MKyooD5NicW3OPgaPbXdt86o1uKbEAqLvYZrk9kpIgO+PBR7
         6k4KmSQ9bNEE9raLCiwKfi1bmBnqUDwwqROYWvbx4Zc5iWO5D572VbOXnCyvZRIs688T
         enGQ==
X-Gm-Message-State: AJIora9O61IJpdwvsdFiWpMWJG63135T50wUXGYidrO+EaPFQ0JCwM1Y
        RCI9e+zo/u0hDrf/NreSNs29UEhnUbE=
X-Google-Smtp-Source: AGRyM1s34UtjOt/L6zJK43lP2yb8JESjRKuvugNJzxDCMyYEXOn7J+2oI58ymx8nfgOcfXp6W0nwnQ==
X-Received: by 2002:a92:d10a:0:b0:2d9:1332:d339 with SMTP id a10-20020a92d10a000000b002d91332d339mr11893345ilb.110.1656443707878;
        Tue, 28 Jun 2022 12:15:07 -0700 (PDT)
Received: from Dixie.. ([2604:2d80:a188:fd00:5448:c223:9fa4:5f87])
        by smtp.gmail.com with ESMTPSA id c97-20020a02966a000000b0032b74686763sm6396009jai.76.2022.06.28.12.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 12:15:07 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     devicetree@vger.kernel.org, contact@artur-rojek.eu,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v5 3/3] arm64: dts: rockchip: Update joystick to polled for OG2
Date:   Tue, 28 Jun 2022 14:15:00 -0500
Message-Id: <20220628191500.69831-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220628191500.69831-1-macroalpha82@gmail.com>
References: <20220628191500.69831-1-macroalpha82@gmail.com>
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

