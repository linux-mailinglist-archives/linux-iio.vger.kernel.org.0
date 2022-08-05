Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE958AEAD
	for <lists+linux-iio@lfdr.de>; Fri,  5 Aug 2022 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240921AbiHERKa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Aug 2022 13:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240754AbiHERK3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Aug 2022 13:10:29 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A73DF585;
        Fri,  5 Aug 2022 10:10:28 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q184so3326665oif.1;
        Fri, 05 Aug 2022 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yrhBL50UTTJaHzMh461WNNj8NIR2DIRZ1vY8GGWYUG8=;
        b=mIGjGFg02sqAPbhUSNTDaS3/qe+y4bTX1TzDIb+Et33IvTDUPkrlCnPrS4yd7IHRHS
         t01d7Z7s+fZQGgfWPpZl/PafjNjLNyyvXZUhqLdgeifW9w32p1Gfuwxnj9vC/bmr3fOC
         +obdjyeDxGBBmShNA2vrOdKPAui0a+kmlXiY9CF9Ej4zZe184rIs3QQ8x5VYec/aSBxY
         kzYHKdPuoIaTq3Pe2isEMfWLSZ0z4umpkxUCOCcSWDL1FmlX8slSBD4iD1ScTNJeuJM6
         4l+C34RoDhDzN5aQM+eFjmC7Vjpdog/BNRtzwZLaEWjWXin+XVjhSSoV0NhVTe93Rhss
         6ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yrhBL50UTTJaHzMh461WNNj8NIR2DIRZ1vY8GGWYUG8=;
        b=GTGjz4c+s4IAPoiFVo8BwxA9PVc1IYr6Ojd6zcm64eHmthNedup0Vu4rmbzYsfgqUw
         m79yO56u6dJmBmDVGOkwQrxxnYkX+4St245nniUnSY42OQwpQX0fNYyv3I13EbB/l/FR
         tflshddz/iijbe0AqnSpA52gWehJgo0zgg3ZM75Fu27xwH4oIM0rTWwStGZY7lAKd3Pw
         7u0hAT3V3qyoLjH4Qj6dHo6o9UyWsNVRglqozZ2RYOhIozfp1TbDNRN4U3TFlW+qJxZE
         duvSjynj43vSJKDxleuuS0c/FNeDkQVDoOxkUNoITGGqD8V/dctehQwYviXGx+itsEvx
         wYmQ==
X-Gm-Message-State: ACgBeo0U+tC7YVABhRbj/wWFe8iWyIdUxAJreZmtBY5oip727xN5e7yN
        apBKuLjWKqmJbXtUpbpg/0wEVW3g4FM=
X-Google-Smtp-Source: AA6agR5XPEWVJrEpt91ff0jdaKGEJFkP25ScqpyRE4I/WTkKJJ0d3sfqEmRaVjA0KXVwK515koIbFQ==
X-Received: by 2002:aca:ab8c:0:b0:342:a1ad:cbef with SMTP id u134-20020acaab8c000000b00342a1adcbefmr3406341oie.97.1659719427604;
        Fri, 05 Aug 2022 10:10:27 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id r32-20020a056870e9a000b0010e046491f8sm794126oao.57.2022.08.05.10.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:10:26 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        contact@artur-rojek.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v12 3/3] arm64: dts: rockchip: Update joystick to polled for OG2
Date:   Fri,  5 Aug 2022 12:10:16 -0500
Message-Id: <20220805171016.21217-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805171016.21217-1-macroalpha82@gmail.com>
References: <20220805171016.21217-1-macroalpha82@gmail.com>
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

