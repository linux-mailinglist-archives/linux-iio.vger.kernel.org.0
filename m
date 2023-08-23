Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F47778529E
	for <lists+linux-iio@lfdr.de>; Wed, 23 Aug 2023 10:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjHWIY7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Aug 2023 04:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjHWIWF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Aug 2023 04:22:05 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9710FC
        for <linux-iio@vger.kernel.org>; Wed, 23 Aug 2023 01:21:40 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d74a012e613so4463897276.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Aug 2023 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692778900; x=1693383700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y222BThDVSxyqkoGfji35At4mqYeveBf4/raWzmbcc8=;
        b=v2n6Ms6P++6QbUOA/76+zOpL07UxZ6ZCnB5fIjdcXHBr0UMFVDE6/Ueo6P0QMByXiL
         9+wDjWgwsQLR+QcwWK/5Mh0Atwuqjc9OtFMNynu3pFjFq+qhyx6tl7AOZL2hgCgOkzGl
         hJ2WtJer1o83BxoNX+JJTo7dMfNG3SKfkdqmYZDmVnR4K2cIBKZn/EBjdXSGrG9Ab53v
         NPZA3Wvn977BowLWMGV4f5PsuJu8vDnjhhS//uEdbIs4q93XgVHrI/VCZe9w0ax0Uqdx
         yrVixHzVUj2XAx7thXubHTbXoTouHO4pPh7PcPGG2BXQyq8a/2pyIlQpzmSSLWzIR2lR
         YKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778900; x=1693383700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y222BThDVSxyqkoGfji35At4mqYeveBf4/raWzmbcc8=;
        b=XD3tHXwQfD9vVXUdDY6bNExbesDoHAOKjjPlP/rrUzy3oWM3DftaoCGmuITNbpdNng
         C1kNbZJIlGKzp6O7CXhND8PpLyIg0MgSzZxGuiTZglEdTBHYq92nsZjhMvsRxJFlXkPy
         Je/icvrR3kR+me4Fyehf7pEKihxlTM2tAPwwkK+ElMiUiv44PmJSnXbQ0uK7Yqqxdb7y
         N46YXfSA7VaheHf2J6YEQ+odFQktD37skaNeXSVQ3FqIfGdMM/BcT3uhpfRIIa/74FS/
         0h/ZwBEtcdDXQEvII3hya4KI3eWhV70C2nwJ7AZK5WDazHF2T74G4RxfEdB75z9gfTn6
         /jpg==
X-Gm-Message-State: AOJu0Yw1MAXYWplwlCIPpm2qggvzEnEtf58nGyySw6L46GzeVpPeMlYH
        iTHW0WqNlWqlPgugRQn42xvCY1j03Ps9tG8D072wbg==
X-Google-Smtp-Source: AGHT+IFDodyVNIJNslU9P09zAg46Uy7BmDyBYA2BSlASenUz+xhthPKPXOROiZL7YNSTM75xV4cH7PX6AWiMgLtRtu4=
X-Received: by 2002:a25:ad4f:0:b0:d72:8ebc:6497 with SMTP id
 l15-20020a25ad4f000000b00d728ebc6497mr11354257ybe.14.1692778899807; Wed, 23
 Aug 2023 01:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdah22hgM6VruErJedWM7apAuO7BGdFeSz4Hz0c2Nx3kjg@mail.gmail.com>
 <20230821164509.45-1-bavishimithil@gmail.com>
In-Reply-To: <20230821164509.45-1-bavishimithil@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 10:21:28 +0200
Message-ID: <CACRpkdZn3MePSohFU7AzVtzdaKW=edsw14Y42xbScXNBVZDOjA@mail.gmail.com>
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
To:     Mighty <bavishimithil@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, liambeguin@gmail.com,
        linux-iio@vger.kernel.org, peda@axentia.se, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 21, 2023 at 6:45=E2=80=AFPM Mighty <bavishimithil@gmail.com> wr=
ote:
>
> > How does it break it?
> >
> > It's a change to the AFE rescaler driver so it can't really "break"
> > twl6030-gpadc.
>
> Not necessarily the gpadc, but it breaks my current-sense-shunt which req=
uires an
> adc channel for it to work, since the iio-rescale driver wont recognise t=
he channel
> (as it only is IIO_CHAN_INFO_RAW, so the && breaks)

OK so twl6030 is providing some channels with IIO_CHAN_INFO_RAW
without IIO_CHAN_INFO_SCALE.

How is the rescaler supposed to rescale the raw value without any
scale?

Say the raw value is 100, then 100 what? Microvolts? Certainly the
twl6030 has to provide a scale or a processed channel to be used
with the rescaler. If the rescaler would assume "no scale means
scale 1:1" then that is equivalent to a processed channel, and you
can just patch the twl6030 driver to convert all
IIO_CHAN_INFO_RAW to IIO_CHAN_INFO_PROCESSED.

Either the datasheet has the right scale for the channels, or it is
something design (board) specific and then it should be a parameter
to the driver e.g. through the device tree or similar mechanism.

Yours,
Linus Walleij
