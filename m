Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC50B577EE1
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 11:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiGRJo1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 05:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiGRJo0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 05:44:26 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5B6DEE5
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 02:44:24 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e69so19826231ybh.2
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 02:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wBUnOf/PDET8AmlCX8OvyjBFXuqlGhDmogYFmZCAB8=;
        b=u3TBNUuRGe4osn54l9zQKp0+DfA+1BvW6W3W5ValZ/lQMBpBtRiZ0My+V7Vdp4nlus
         Qr0ovsCrLdOezRtIcEEk6TRti4RNGoEKc0EvzCd9upCPnia4QIZGkOpAatAMH8rcHB6G
         EP6710HoempEUxSoNK6sgJNjk0g+4buD3AEAoU0jX3tlNK8k4idq8uTAY6zxoPoVo9YC
         edqQ4TvkaQKKg2nAWVCms3e1rX28PhE41/2pjGNRP7+vjyYQbDWKkKN9TFD7WPF/izcM
         tRo0ikOri50rHLVyCCiuIc7b/1t2n4myIX78AmgR4g8zShf6WrhPxDApE2iL4a7KkDsh
         1emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wBUnOf/PDET8AmlCX8OvyjBFXuqlGhDmogYFmZCAB8=;
        b=mskZfwXNcuA5X6t3u1B1d82S8Aq3Qh7AXETX7hcUgxiX2dqplBxRqaU3izwe3AUD/B
         93HtYYvwiEeykeXPYoRuMaSPeQkPdf5nA3LiqUA+wiROBSYk5GWkLOrOyijmTTt9PyYE
         QZW7QONG1SzpWpW9rj/PYHRfOFQdggyIAOyrz2xtob49B7KeyZwyCBguG73StyimiJPS
         uhSQRLy8iDX+L9grSs0ghwl5fjIA2zdDUnFmzmjZjfbm7CovNdmTI0ijjmSG8+UhS2Cg
         PeXmQ1TEcRwm9egPckSl1otaGNPeXoxDda7J287OssCWT657WuT60yhZMkfJauyq4851
         qGRQ==
X-Gm-Message-State: AJIora8y7o/KRCsThWkC49mUZk1CBWEmAfCUa/F0BvvJDLFv3EJf6wJI
        ZUQuayOP0JkY9Nkelsx6e7YaFf+CJuenPYJ9Yhm58A==
X-Google-Smtp-Source: AGRyM1sn+IOhz2GaMI0qahc2BOoqiLGlQX+/66qO44EGm0YsFMPIGOPvL8uJKGEiUBaeQT2YmKDP2xNG3hEwveFuS/0=
X-Received: by 2002:a5b:9c5:0:b0:66e:cbbf:2904 with SMTP id
 y5-20020a5b09c5000000b0066ecbbf2904mr24718556ybq.220.1658137463785; Mon, 18
 Jul 2022 02:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220712110232.329164-1-francesco.dolcini@toradex.com> <20220712110232.329164-3-francesco.dolcini@toradex.com>
In-Reply-To: <20220712110232.329164-3-francesco.dolcini@toradex.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:44:12 +0200
Message-ID: <CACRpkdZDRjadHc4TBHouWPSYhLoCAynXzKejKi+H98C5ioCW6A@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] dt-bindings: gpio: stmpe: Remove node name requirement
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 12, 2022 at 1:02 PM Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:

> STMPE driver does not require a specific node name anymore, only the
> compatible is checked, update binding according to this.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Another leftover from the early days of device tree. (This was one
of the first ARM drivers converted to DT).
Thanks for fixing!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
