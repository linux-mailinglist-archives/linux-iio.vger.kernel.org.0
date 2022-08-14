Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098DB592615
	for <lists+linux-iio@lfdr.de>; Sun, 14 Aug 2022 21:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiHNTFY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Aug 2022 15:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiHNTFX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Aug 2022 15:05:23 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E01D1E3F7
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 12:05:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id cb8so4289974qtb.0
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=BFAW2MwLVeguePUNy9UjAn731Itve3yGXDuc563clIQ=;
        b=V+Qy5z48YBeKoJ95QQTf+2ljLdtU6JSW3oI9Y9bwifI9MzGqZygy/QxMUgIuv94SSC
         Zi+1dU4e3AbF9Nwfr5vWg0vqaO4uNfqWT5PqdMfHLK2UoCMyY7FdXDYq7RlXYQHgFoWF
         CY5A4FSlZxb34oBUI7ohnW2MM9OW0DQcjT/RR06yH2YgLDtkNy5O6pj83pye6uOQctO5
         6ullCzjM1OXmc6VIC4OfYALVQ/rSB7WJFF+guAOFgDgo8rpBaiO8GcKkpz5ojegPF7CT
         4q81TfodhB0FL6HJVu0nIEFztwKkGmLbmM3lDAxe/NZXY/fNSL+CbNIjE15+Ke+xS3OQ
         LBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=BFAW2MwLVeguePUNy9UjAn731Itve3yGXDuc563clIQ=;
        b=IgiExG1hhncGpmTQnnyngKqRnG9wgiNPGlAF73K9l8jNT1yX2AC7+2xwnjEaxrPwz+
         gTfU7puS9CRafbzWhgzXCY9f6NPG+bRPaogUNC0AzfWL8CEWf2YmgC85nY9PonkIH1rR
         GCmDB9pMffWoqPykyQoG2/cT6oGs0NZn8HRlWE7SXnDdpziNseYFaFHgfASZXtG2rjc4
         9AVK3i9R7K06PYguVJZWxkJAsqS3hHER698obbw2FopVMAAW3CmXt4kR2+9ylNFrn33o
         MCvUEZdyfzk454xAOXAdhBumkzUdDGHjy/OC+B7TaRbmmDX/mm0ugob0olDGHMT3fcqv
         1aWA==
X-Gm-Message-State: ACgBeo29AyceMrYIsQHrYPY8yw1OZWYf2flsiXf2qhRnEkBIC5qYLaf6
        kNgfmndOwHFh7v/oe0QAyF8AUz7vowMWsErnrWY=
X-Google-Smtp-Source: AA6agR5aFejDlLVxu9XNHh0hqVSWxHAXku6LRL/mi5tdBopccuVyt/6farVhs6GuR01ssPa8c376U0/U4Gshgkh2N6U=
X-Received: by 2002:a05:622a:14cf:b0:343:5b6:68ca with SMTP id
 u15-20020a05622a14cf00b0034305b668camr11070115qtx.195.1660503911185; Sun, 14
 Aug 2022 12:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
 <20220808204740.307667-11-u.kleine-koenig@pengutronix.de> <20220813173706.1cb77958@jic23-huawei>
In-Reply-To: <20220813173706.1cb77958@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Aug 2022 22:04:35 +0300
Message-ID: <CAHp75VdkeckbaoLj7kyDdiy=BLo6WAaRsPCc+Ue2hwwBHCbNug@mail.gmail.com>
Subject: Re: [PATCH 11/13] iio: frequency: admv1013: Benefit from
 devm_clk_get_enabled() to simplify
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>
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

On Sat, Aug 13, 2022 at 7:26 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon,  8 Aug 2022 22:47:38 +0200
> Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:
>
> > Make use of devm_clk_get_enabled() to replace some code that effectivel=
y
> > open codes this new function.
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Looks fine to me, but there is a subtle reordering + it does even more
> non parsing stuff in a function called _parse.
>
> Anyhow, would like Antoniu or someone else from ADI to take a quick look =
if
> possible before I pick this one up.

...

> > -     st->clkin =3D devm_clk_get(&spi->dev, "lo_in");
> > +     st->clkin =3D devm_clk_get_enabled(&spi->dev, "lo_in");
> >       if (IS_ERR(st->clkin))
> >               return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> >                                    "failed to get the LO input clock\n"=
);

So it seems better to drop above and...

> > -     ret =3D clk_prepare_enable(st->clkin);
> > -     if (ret)
> > -             return ret;
> > -
> > -     ret =3D devm_add_action_or_reset(&spi->dev, admv1013_clk_disable,=
 st->clkin);
> > -     if (ret)
> > -             return ret;

...put a call here. This will make parse() look more parse.

--=20
With Best Regards,
Andy Shevchenko
