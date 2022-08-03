Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8335891B1
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 19:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbiHCRpV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 13:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbiHCRpU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 13:45:20 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31FF6318;
        Wed,  3 Aug 2022 10:45:19 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id r16-20020a4abf10000000b0044100d984ddso247085oop.12;
        Wed, 03 Aug 2022 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yrhBL50UTTJaHzMh461WNNj8NIR2DIRZ1vY8GGWYUG8=;
        b=nOzo/z0DXRuzNrvvDkrdSTnZXSaXa94couCp2tepWOB9I2HhxtxMV6pqtdsX6lry7k
         V6qNXWFevzNprHO/Hm0KSSF01coR33VKLWhmxAVv8AFji+1dyWf8RYWV87deEOBbE0DW
         DPAU/4kw8mLJEIIpnJIzULXatmSYeeIeexoNBGIPxpcwTpzyFlh1Bf2X74+/FWUJSS9i
         2MHAQsUsxT/pFNTwQPWJhpJRjZgfbJbS5AlHfp3hkFIxnu803MrpskbVh+tlkYwMhErq
         u6xs41ijM7h0RQ7q7WzP0+yfIK7rmpddZqktPqYD0eGDJYgVlTdca3qiKZ9dUp5fTlGL
         ks0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yrhBL50UTTJaHzMh461WNNj8NIR2DIRZ1vY8GGWYUG8=;
        b=NAbhhalVuIiWz5NdlvfxdZdKSzwnhPUKBNj3ib4BHEF+hwOsefuo4Eoc9xG9t2e1Sq
         RR9W7WEva3XLjaScNmql1b0m0yjUN0obm6M2/FCzyfiRXsbLQbVd8sdFLLXNWzeulQCH
         kGVRU4RelKb0EnKObNpkhj36AO7SesdSvkwIRvO9EW5YeChQ2/AdDjNesHSRHP4raTwN
         WcSIZ85VPsnib/Vgt9iJjcL4h2TEnNcwETou1c4BCOPniRpAFthI0kMrkoP7gzmSyUG9
         IYtLntXyZb8+u6gv777aA8ymjpvCAZKHuvfVKgoUaGb0TORyGsOKNxTSCiZQT48KaH+p
         csKg==
X-Gm-Message-State: AJIora8ZdzLY/ve+wCFMm2cDvbJSUQhu4rSFvmSqDwa/y5ii0V4sXZmC
        TTs6gB3FvKIKl/WEBRxDUyzuzQXtK1M=
X-Google-Smtp-Source: AGRyM1uxZTzGZSjXseoVZADNgo8eDvvshYrIsUDh7iHnk+88MNDGO7icvdnCLMVxuEShgkFbYjnDZw==
X-Received: by 2002:a4a:dccc:0:b0:435:9890:a10 with SMTP id h12-20020a4adccc000000b0043598900a10mr8670943oou.63.1659548718955;
        Wed, 03 Aug 2022 10:45:18 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id bx6-20020a0568081b0600b0033a6bfdc5adsm3551893oib.36.2022.08.03.10.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:45:18 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v10 3/3] arm64: dts: rockchip: Update joystick to polled for OG2
Date:   Wed,  3 Aug 2022 12:45:05 -0500
Message-Id: <20220803174505.21420-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803174505.21420-1-macroalpha82@gmail.com>
References: <20220803174505.21420-1-macroalpha82@gmail.com>
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

