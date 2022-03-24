Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583824E619E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Mar 2022 11:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiCXKU6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Mar 2022 06:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbiCXKU4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Mar 2022 06:20:56 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581471BEB2
        for <linux-iio@vger.kernel.org>; Thu, 24 Mar 2022 03:19:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b24so5021482edu.10
        for <linux-iio@vger.kernel.org>; Thu, 24 Mar 2022 03:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lMmNofLsEddxcXVqpOsyFaFuaoqPFnAdYBfE2k8mmFM=;
        b=VFSwK/+K8RTIViJycBw0kg3M482QLRhwId33ojXS7m2JbtrjsQxwg/SGGCcUebVYOo
         zTApb+FnIqK+zqprOnNJqle17PIkIGKPG0Mn+Sg6bK8GbXxq+9bczBevWQVWfcOhSqUF
         NlGFP2DOOPT5pFJxu/1v9Y944m30bdsH8vqP5a4LtG8P7lZHf5osAt9JaXTbwjsQEl4r
         lNnRho0mmSykL2TjtKfkxxQps0cjZvbPprO3uDBuGtrqtzsqRScc0trJub6z0pCfXxMk
         nM1zwPfjCQGad4TYB41aMOH3QvbhPJ5p5oJQyuVbg7cN2vUpgGsb0USjoYdG3XChnGF8
         oOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lMmNofLsEddxcXVqpOsyFaFuaoqPFnAdYBfE2k8mmFM=;
        b=FXX1hWhQIauCY2qWibd42x0iug4IIRm/CuHhG9pinSBkp3dHPJGIdZs9NCik4bi601
         9V66FUUzyED1zENpYZOOF3CBPBpdRojmD52hh7jZAuK7SuIqsClxXqgCmIYYk49yj2U2
         aFJri7MxciZ1hpKCM7MXV/qNTNy0O/aaDBGxRjjEREvGRbHTT+keXr/410Dw+pkvgXyD
         6NwB7HsZUinC490UBIRtBgymMDxR5RSu5PrH0T6w64OHWE5dfB4NQUSgtno2ctTqqneo
         tfoiLISNbajVTxPcyLYI7Q8iwEQMDNM6JwcjsdtQVQwaSpKJNuv8t60Ay5YbbaFUkK5A
         H8xw==
X-Gm-Message-State: AOAM530Gv/gKWOCy6e0vAFipgrDbQPEJzEQGl3WDUgLLiDryOyT1Bfsf
        bgqxNeDIW1wgmSVL4H2TYrqkyU5LSbmbAN98OXk=
X-Google-Smtp-Source: ABdhPJyq5RSyg6baWqX8gNXQwDsgv8Ayu8C8nEuir7biUwlCoeLKe6aOS00jrTibVnahZOavTtPmrNpIvZxbKr9m8ak=
X-Received: by 2002:aa7:d390:0:b0:416:16ad:2483 with SMTP id
 x16-20020aa7d390000000b0041616ad2483mr5888609edq.122.1648117163693; Thu, 24
 Mar 2022 03:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220324055821.3184872-1-liu.yun@linux.dev>
In-Reply-To: <20220324055821.3184872-1-liu.yun@linux.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Mar 2022 12:18:14 +0200
Message-ID: <CAHp75VfEyhB92iP8sRyGn+2WLzazFtok=47xzewhCt=bo=a7Zw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: da9150-gpadc: fix build on mips CONFIG_MIKROTIK_RB532=y
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 24, 2022 at 7:58 AM Jackie Liu <liu.yun@linux.dev> wrote:
>
> From: Jackie Liu <liuyun01@kylinos.cn>
>
> kernel robot report build fail by randconfig:
>
> [...]
> drivers/iio/adc/da9150-gpadc.c:254:13: error: =E2=80=98DA9150_GPADC_CHAN_=
0x08=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98DA=
9150_GPADC_CHAN_TBAT=E2=80=99?
>   254 |  .channel =3D DA9150_GPADC_CHAN_##_id,   \
>       |             ^~~~~~~~~~~~~~~~~~
> drivers/iio/adc/da9150-gpadc.c:273:2: note: in expansion of macro =E2=80=
=98DA9150_GPADC_CHANNEL=E2=80=99
>   273 |  DA9150_GPADC_CHANNEL(_id, _hw_id, _type,   \
>       |  ^~~~~~~~~~~~~~~~~~~~
> drivers/iio/adc/da9150-gpadc.c:281:2: note: in expansion of macro =E2=80=
=98DA9150_GPADC_CHANNEL_PROCESSED=E2=80=99
>   281 |  DA9150_GPADC_CHANNEL_PROCESSED(GPIOD, GPIOD_6V, IIO_VOLTAGE, NUL=
L),
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> make[4]: *** [../scripts/Makefile.build:288: drivers/iio/adc/da9150-gpadc=
.o] Error 1
> make[3]: *** [../scripts/Makefile.build:550: drivers/iio/adc] Error 2
> make[3]: *** Waiting for unfinished jobs....
> [...]

These lines are noise and no need to be in the commit message.

> +/*
> + * Workaround for arch/mips/include/asm/mach-rc32434/rb.h
> + *   #define GPIOD 0x08
> + */
> +#undef GPIOD

Looking at the bottom here the better approach seems to be namespacing
of GPIO registers in the above mentioned header and corresponding
users.

>  /* Supported channels */
>  static const struct iio_chan_spec da9150_gpadc_channels[] =3D {
>         DA9150_GPADC_CHANNEL_PROCESSED(GPIOA, GPIOA_6V, IIO_VOLTAGE, NULL=
),

--=20
With Best Regards,
Andy Shevchenko
