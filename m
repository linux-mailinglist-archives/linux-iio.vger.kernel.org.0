Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848BA572F6B
	for <lists+linux-iio@lfdr.de>; Wed, 13 Jul 2022 09:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiGMHnS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Jul 2022 03:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiGMHnS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jul 2022 03:43:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C777E5859
        for <linux-iio@vger.kernel.org>; Wed, 13 Jul 2022 00:43:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ez10so18342441ejc.13
        for <linux-iio@vger.kernel.org>; Wed, 13 Jul 2022 00:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VlnmlHCQfW3p97UCy5YcE83IQ1M7mTcSHN9rJn92L0=;
        b=DMmVsyTnzW/ZzHy/WNEhXKuJ/wvbeUmmgXu5noAA5OBSdWDoQXacYqh811HBuPUcB2
         1704vMKky0r/XykIbgErzhYfAUaQwcS9in9Iyv7UDr89rtWYHrjgAoS4/ftDM13e6zET
         6Zq3W/iDUAstij4E96pl6A4dFBehNRT4BC9T4B+TDbUnPluj2ffkyJngYthP+RTyypoS
         8Ngpxqp4L5W5uQXKECMiWjztav+0/GDWvhzTqjfXmJSqE4LeJbCOxop9s0KYRQHCvYwi
         E53Ud0ve7qzEcCxNGVvfN7QIMwZ7/wVNGUlwjNS+1AxhR4BSF0jl8P02UdhUEjzq2usI
         6Yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VlnmlHCQfW3p97UCy5YcE83IQ1M7mTcSHN9rJn92L0=;
        b=Y+zkPXD7884erU919Vm9BPYS7HECpZhwP43vrURWXuW7LKiBhNqAjAjNtbV+/pazIt
         5WFRaPpho/qrm8yfyQ8T6lEpIb+O68Ejq0oly/V14j/uE0tB2hQMXpilQr5WEc0+OCo8
         cjr1r/syt0ETDMJgyuAZljSITPmdaSJcOSTZZsHfJ7IG45uLUdejAIrcTp7HAOleW47V
         o7zFN9h8dRVWx+a/AxjbEDRAFckhF8e/2ksiCWxrOrAQLUAgZgS2EjVMHtFTE4NZxPOu
         mxP4M6ozuRfWkFyW/7GExIddwVMpgBYI+tVSBMRMEwAah9NfbO9A3/oNqwNugjnYuqwB
         S0Gg==
X-Gm-Message-State: AJIora+HMzovBgZxDqxt9LCExLPADV9nzLb/EXkbMlh5KwOSw1yd4lFu
        /2ymbVZzQCEUyhdnnv1V5bsU3dXlMw80pcwaN68hWw==
X-Google-Smtp-Source: AGRyM1sqqwrs67V0xYX+vIkQzt1SsBz/eWMrr7ikKraa6psgwLTFp/02ZOU5oQQud0MALSLXgtkrRGzhBoT1X0IdY9c=
X-Received: by 2002:a17:907:87b0:b0:72b:9f0d:3f89 with SMTP id
 qv48-20020a17090787b000b0072b9f0d3f89mr1053322ejc.734.1657698194579; Wed, 13
 Jul 2022 00:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220712163345.445811-1-francesco.dolcini@toradex.com> <20220712163345.445811-4-francesco.dolcini@toradex.com>
In-Reply-To: <20220712163345.445811-4-francesco.dolcini@toradex.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Jul 2022 09:43:04 +0200
Message-ID: <CAMRc=McUdeXSNwE9WBVh_ZrsL+-WusEQjqcuE2v=m1exHS6_eA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: gpio: stmpe: Remove node name requirement
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 12, 2022 at 6:33 PM Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:
>
> STMPE driver does not require a specific node name anymore, only the
> compatible is checked, update binding according to this.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-stmpe.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt b/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
> index a0e4cf885213..b33f8f02c0d7 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
> @@ -8,8 +8,7 @@ Optional properties:
>   - st,norequest-mask: bitmask specifying which GPIOs should _not_ be requestable
>     due to different usage (e.g. touch, keypad)
>
> -Node name must be stmpe_gpio and should be child node of stmpe node to which it
> -belongs.
> +Node should be child node of stmpe node to which it belongs.
>
>  Example:
>         stmpe_gpio {
> --
> 2.25.1
>

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
