Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEFC5890EA
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 19:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbiHCRB7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 13:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiHCRB6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 13:01:58 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133C34C613;
        Wed,  3 Aug 2022 10:01:58 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id h188so20157950oia.13;
        Wed, 03 Aug 2022 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yrhBL50UTTJaHzMh461WNNj8NIR2DIRZ1vY8GGWYUG8=;
        b=aU3w8ALENo2xlgqpxs0x+l/rLIX910gH25zzMAzY2Prf0x4jaEGrahJxBiQD+fsmHc
         Wrdka6W/3Q0BLY/b3ox0wGlNQTfwpRTWdDC5ajmP5Bl2Bogb1bhWtj0mzPM2gW0cm4rh
         mFrQ1Rv/DeFaYUT45oJCKM+eVOfKPjNrixab9uD4fO/MpEtxJdG09jtFytRmU1+Yr36Q
         nx+b48Znv67ooJVLPQr/kcnYLIDDkFbc7DWSve4wfGeZ7tV8gYTHRZUOHVRuMiNQeIOs
         dE9dOztdM/L8c406umaLSeqFs15UGGHKc+0xwgZQ7k4v6TKHUqYMR52ogayEsHmAoVyg
         +2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yrhBL50UTTJaHzMh461WNNj8NIR2DIRZ1vY8GGWYUG8=;
        b=A1yijy1aryrfwMgJeDtvprEJ+fB93k/IRsCQBwlVt0jRmNzL4cCXKEuQOyN6gsH/7G
         etbZ0In2AxAcqJV3RSGerQODKtya+hlJFlbHryIajBducM/umoAzEr1Xk7WvjNpwyONH
         oUlMEs3QasPF/zNtwLAOfja+mgt6ouxSo/OR1yelcaBdaJEEhbDifVWlL+5rY5/mQRT5
         BDc/PLnqOIHtkkD5UOz4fVLTIZhsHKAin+9WvwZunic8LNXLIVfSEUMAFOMY6SdLD/BU
         4Wunit5OmhXEt7a+XnlOYJECnUFmnuT3eN5EiH93VNhkluRecUqcn5AdC4seUV5Kfc9C
         M3Nw==
X-Gm-Message-State: ACgBeo0hDX8gGQjz8+yQNW4rDwKtBoQ6xVFneaFeMtJUVX7Rg06omzDH
        wy7ECY2Wj+Ezh54WDxHU0aHEEUsMd1s=
X-Google-Smtp-Source: AA6agR5XNmgDgiGwQCYn6097Bc5RezOQOHmDm972sQgHjxAhncQYYba15pE58ueR8Ed/GAxLB0JUSA==
X-Received: by 2002:a05:6808:1391:b0:33a:a61a:bd1a with SMTP id c17-20020a056808139100b0033aa61abd1amr2122720oiw.169.1659546116930;
        Wed, 03 Aug 2022 10:01:56 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id q16-20020a05683033d000b0061c29a38b3bsm4088453ott.33.2022.08.03.10.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:01:56 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v9 3/3] arm64: dts: rockchip: Update joystick to polled for OG2
Date:   Wed,  3 Aug 2022 12:01:45 -0500
Message-Id: <20220803170145.16186-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803170145.16186-1-macroalpha82@gmail.com>
References: <20220803170145.16186-1-macroalpha82@gmail.com>
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

