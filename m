Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2277A578BB8
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 22:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiGRU1N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbiGRU1M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 16:27:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5F326AD8
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 13:27:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id os14so23454916ejb.4
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gb5M7E2hMfhDGbL38oqRZIEBc0pL7CQAi76x3Tkn+9E=;
        b=GL1WagfENemxrBwEiDDr3iUqQ65NAafgmdKWNIj97CJ67C0w8rNSYaVbQ2oCfjZFt/
         33caDSCWXXkpyCzsC4ylWnmUIj7Cv3mSpjb0bo3rbVOVXBNTFErMdo8l1E4DqDgxztDA
         jrqzc9g05SqFxaV0L+JVjkg0iFMzGe0uuqSAXhSVhY5BMFLhnw9hHPEaXiZjyC3MtPST
         UOoP0GM6FIDhtmdCOrCbB4Tax0e8Ia2KOoCEiKZWrTlwa0JeJbAH3XJGexBGJaHSkOvH
         rAHg2E/GGHiEuj8+vLsR1cxl+Bo83p9CNNQZcsss+QgaiVzQC1ncj8zLFp8tMqQ7B7Ee
         Rs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gb5M7E2hMfhDGbL38oqRZIEBc0pL7CQAi76x3Tkn+9E=;
        b=Uf1KsPPAduEJlLrrBi4FKVw/l1rZAZjc2i7H/L8Nwu3nUlEzF3YLxUN9BylYEPiMF7
         riieV/kK9kU/oowTF0CBCk0tiqMgdjCXIp6uAk3vzM+Prp1DmyqFxl9Fae1rjSDPNRgo
         ASrSuOMlMF8K/OkVNrcLEQLTWciE+OdKBp7f2LoT1rz/N0imYhgrF6ksxsKMiNIs9UVZ
         QxFNXa9vGdPQFV9XdQTBJxieXES5DUaySmb7AAGotTqSCsu60f5s9d5r8sOUMq4m9Fzc
         GtVtGRinzxdqM56Behr2xKA1iAbT61MNyfvNr18YlHXd2wBSCCXANCTO0MWugpgpEmcV
         /cFQ==
X-Gm-Message-State: AJIora+YIBIQSZwAyxV64/6sDhe3MECvoXF6TE3auu1D2LHM9J50c0LA
        m4q0HwX5P8AHxgBmdgPt2DzCas4mPuUQRHCD6ds=
X-Google-Smtp-Source: AGRyM1ulP227Ro1SM+iVavej5iWQdarUCIDTJa2SW06NtBaBqKAgk6aJ8k0DBpZE7sgEcHmafpH+vP//eer9Nj6YsW4=
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id
 nb13-20020a1709071c8d00b006f20eb21cd6mr26167657ejc.568.1658176030681; Mon, 18
 Jul 2022 13:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220718194258.181738-1-ukleinek@debian.org>
In-Reply-To: <20220718194258.181738-1-ukleinek@debian.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jul 2022 22:26:34 +0200
Message-ID: <CAHp75VcBxdaPbDi0ttOce+uKvwhZRDHvBgMiWrxBgTupyeDqWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: humidity: dht11: Don't warn on memory
 allocation failure
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@debian.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Yves-Alexis Perez <corsac@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 18, 2022 at 9:50 PM Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>=
 wrote:
>
> The kernel is already quite noisy if a memory allocation fails. So it's
> the usual policy to not add another message on the driver level.
>
> Drop the error message accordingly.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>
> ---
> Unchanged since (implicit) v1
>
>  drivers/iio/humidity/dht11.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index c97e25448772..891b6bf0b4ca 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -295,10 +295,8 @@ static int dht11_probe(struct platform_device *pdev)
>         struct iio_dev *iio;
>
>         iio =3D devm_iio_device_alloc(dev, sizeof(*dht11));
> -       if (!iio) {
> -               dev_err(dev, "Failed to allocate IIO device\n");
> +       if (!iio)
>                 return -ENOMEM;
> -       }
>
>         dht11 =3D iio_priv(iio);
>         dht11->dev =3D dev;
>
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> --
> 2.36.1
>


--=20
With Best Regards,
Andy Shevchenko
