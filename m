Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F008057D1DF
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jul 2022 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiGUQqS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jul 2022 12:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiGUQqO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2022 12:46:14 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A771A053;
        Thu, 21 Jul 2022 09:46:14 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10d83692d5aso3174453fac.1;
        Thu, 21 Jul 2022 09:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6KSnMu0007NUX3n6VG0MmgWubuiJ/ZN6YblN0CfQJME=;
        b=H10ibcbgHEISxcCf5ZrlhXrz/41lGJ/Xw7l1FUk7tl3FFBsdczPR0YEGBKi7T7xNt0
         +T8fHBfGuCjgckA/HrKJGmdPdNjpdH9oFuMkLgOHpuLpLISer2jBKEyvNDVxOpFZzeys
         B4e1Uj8f9HvhEt37RpeJ6kJb/Zm97LrfwUo1PWfArlFYbtZME9NxkZM0DNa6cxO9gjwQ
         Veyo0nwTXlP4YKH2qd6TLer3V16a244t4iOmWLZDEFZEvwl9T51nRk9QFrGcEbmve3Rt
         OlSit2R7wUL5jVFQpx+d8MwAV/6idsHz3ijfKXIkEUwFIa7yWauM2OEBMUqfp2knjJsY
         f16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KSnMu0007NUX3n6VG0MmgWubuiJ/ZN6YblN0CfQJME=;
        b=EQdujh8r+pgtcOYyjOV2Y4/efe1d77ew/NsqpeSPYVSXutrc/WubpkkMtEHRnam5HS
         9FJ7ZfpBCM2SFpzPAuufug3TdlnTvXqRwDsKUpUrDu0FpuaQYNp53pYteOVGqbUDWebu
         4RdnxwzPeRYP0pahvwSNYW0F3XEN56fXLilIwnylMfN3Z1sH8tggTNtg2fgMrvOiM4C1
         6Wl5MRxB/BJuGo+qvXOOdeOyObuk6KvkUZQSS9jxUPz+r7XTGO/ZfxQCqSAGKnSyjX7D
         +bVTti6G7jJXi9j0NAuxrqPHmUDnfxjNti1OqTxy2IrXOO5jPnJesiXb5DyfJjXAiYwE
         Efcw==
X-Gm-Message-State: AJIora/JUxKRKfjLewq/3dNl4PLAk1pRfc0AX4B/B41IapEboz4bqpEX
        4FpdoZ6BwMdKYmU2oIpm/XodZT+iNKI=
X-Google-Smtp-Source: AGRyM1vuY1J0I3qYchHhOXPwCiBeigMHOP+C2hRExkM+3m5nLB73AAKM+GNYjYzvi3BlwWsJkGOYTQ==
X-Received: by 2002:a05:6870:6195:b0:100:ee8a:ce6d with SMTP id a21-20020a056870619500b00100ee8ace6dmr5632240oah.155.1658421973065;
        Thu, 21 Jul 2022 09:46:13 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id f189-20020aca38c6000000b0033a45705cb2sm831512oia.8.2022.07.21.09.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:46:12 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        contact@artur-rojek.eu, jic23@kernel.org, paul@crapouillou.net,
        linux-iio@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH v8 3/3] arm64: dts: rockchip: Update joystick to polled for OG2
Date:   Thu, 21 Jul 2022 11:46:03 -0500
Message-Id: <20220721164603.13534-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721164603.13534-1-macroalpha82@gmail.com>
References: <20220721164603.13534-1-macroalpha82@gmail.com>
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
2.25.1

