Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151B755B447
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jun 2022 00:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiFZWER (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 18:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiFZWEQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 18:04:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63132DC8
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 15:04:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g26so15312710ejb.5
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+YFyxWK5iYpmZnQrbCY6q4hLns8N3TsIsBlH+Gz2Bw=;
        b=nTXXf+fCQ7vrc7gwivrEX5kb8XAetRbNfK1SbxgTMbAeRpRmY2gp128iEokWyujoND
         tYYv1AeHqvbsrC95WY293G6swF+Xd1fraenitzpgxgggJ9CJmWnCBsamSicCE3nnWYjw
         Ip4TY9b0p2m22O/23L2rd//NNDsL3LGcM1gIcMsj8NAtYlhXv47lKXondFlX/y19PdIr
         27PfD7XjXpXtf4PzpAt7wTbPRRTKGZ5fxazNAqnP0LtD7VBnEOAJ5qTI/fUhdDa12r8U
         igYjDhf0XzOyDgVJknCUf5x8/E3pH6zKW5N9oe0wEkBNJnN+Upb0lWKuxv9cLDD7c0o9
         fLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+YFyxWK5iYpmZnQrbCY6q4hLns8N3TsIsBlH+Gz2Bw=;
        b=K3rZA5nP5yd4u/Wj3yhDi6Cl9sdWjWguPlkEbSFtVVJN50F4rFtnvD7WmymHc8qXei
         DfRgIZOGk9+7GDcXojggpT/a2jQhsASstd9Wk6J+DZFjhJDQzQsluV/GkSk1cvfUH9ic
         Ul7jvE6/iBCVVkNQG74bm76xOv89erfG85rjN+8wjjSmH3HLkF/1nayIFoE1d+Bg5tpl
         czaXdz+pZ/+zp5RSOvKv0irtIDe5poo0x4jEUfmjHrcEUwSaJAffXb+j+jYre+1kQcuE
         5950QGxd5gmOluwX22SdtEt/2nB9JyBLbs31lW0X8ieRRMJ+gZfyMA6JnIsQbhhxVh+s
         NKNA==
X-Gm-Message-State: AJIora9ABcG7XnGCf2tTjYGkqFc33hrVy2z1x1YP8pjuGZmf5nIIAiVb
        UI4zDcTEFs0oU/6O07xWx+hJUJPx6oy01PJjoH0=
X-Google-Smtp-Source: AGRyM1sMcX+XXiUh8AD041fRgSI1MfDLiZatt8S2VfNVSXWEl+I3z4M1paE6zpLq44NID7VTgvvQmCWGmyCxULMDdN4=
X-Received: by 2002:a17:906:28d6:b0:726:41df:d9cc with SMTP id
 p22-20020a17090628d600b0072641dfd9ccmr9306526ejd.649.1656281054210; Sun, 26
 Jun 2022 15:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220621202719.13644-1-jic23@kernel.org> <20220621202719.13644-6-jic23@kernel.org>
In-Reply-To: <20220621202719.13644-6-jic23@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Jun 2022 00:04:03 +0200
Message-ID: <CAFBinCDHuaz0DtyCWm4UTyhiA_d87+fwKas_YxFRc_Mv3En+7Q@mail.gmail.com>
Subject: Re: [PATCH 05/36] iio: adc: meson_saradc: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christian Eggers <ceggers@arri.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        "Ismail H . Kose" <ihkose@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 21, 2022 at 10:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Using these newer macros allows the compiler to remove the unused
> structure and functions when !CONFIG_PM_SLEEP + removes the need to
> mark pm functions __maybe_unused.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
