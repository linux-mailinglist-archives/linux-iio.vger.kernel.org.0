Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E657F35AF02
	for <lists+linux-iio@lfdr.de>; Sat, 10 Apr 2021 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhDJQQF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Apr 2021 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhDJQQF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Apr 2021 12:16:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0170FC06138A;
        Sat, 10 Apr 2021 09:15:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y2so4193922plg.5;
        Sat, 10 Apr 2021 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6AzED3WX9uZhznt9Toi/RF3r18Jze+otjqZ77388uaE=;
        b=ofcSZxrICvNJf0Gcs3Zr3b9sNjTh/K5jK2d+PS3tTdJmS8TqSzif0iO4X5qfhpLy8c
         KAM++uUbGzfzl4dno4Ll5msj8oHpGaTTEx0TlIwrUl0pplOasUPCK+/47qSoH7QsRo7s
         00tfC+sJ1AkPvuKRPDspxeBGtGXS9PHmI/lT69aq0tBJqzhN9NhEBVZOTKTx73JDFlaE
         8kF5Cgww6l6rS7Y2/j/5syrotzTbCkG6VgponBJn5AELFv9O//tjT4vTKLnpZyBUp/lu
         pG14BIkA4j1rIetLUiGFQ/rtoVEyWyxEGg5oyPOzhok2ulnFVLq9XIVB8SZWWFYLK0/e
         EutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6AzED3WX9uZhznt9Toi/RF3r18Jze+otjqZ77388uaE=;
        b=B4EDuCyO8j040R8NyXBOUSM99Rg/9aPTj6jaQw0qew+dfT3Ug4a0zxTdPqnGD4UNtF
         GKWYKICM2KwDYKzqvv2e6GGU6yaWjEKwB7xvFBhqHxm/rbFI2p8oXTNegcvfACXwHsH5
         5tWzWvyWeaa21nMow5EMxiqAMR1EJgITJe6u4EM5k5lbcJ6XaPy+U4oPIWc8XwWXETpJ
         DXdJL6TOxGYJ715W294CLL6qaQ421IWcyLTBU6FrM0mBgW4WacMGFKujfQC/9DP/ZZZ7
         E0nK9Ipk4vBcPA7nXm2J/OCnnWXECo55PBnL1S0uC+88z+GU+v1YoBUaS2RDI3ZPAnRH
         9WQg==
X-Gm-Message-State: AOAM533L4mnjjbQyd97xOMBgtpmYWh53590RZlH3m4ascwgouueUXLWZ
        k+vc2iYIsE9/239Ida6iydJEGpNuT8lOKzIJFEo=
X-Google-Smtp-Source: ABdhPJzmpsDfHZ2eDvbkQmWePBfWblFvMNvkabSPe67K1ZxH/zIhLJCrfDH6kAkbvW+nTFG8IBx6wnd9a6zpNYwMKMw=
X-Received: by 2002:a17:902:c641:b029:e9:4226:beca with SMTP id
 s1-20020a170902c641b02900e94226becamr18555646pls.38.1618071350405; Sat, 10
 Apr 2021 09:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617993776.git.lucas.p.stankus@gmail.com>
 <39486895e4e985d0220342f3accfd98a1e149ea7.1617993776.git.lucas.p.stankus@gmail.com>
 <CA+U=Dsot+p76kaCAecN+ORdhZ_u+Bw1J8oVKZYAjoexHgiazVg@mail.gmail.com>
In-Reply-To: <CA+U=Dsot+p76kaCAecN+ORdhZ_u+Bw1J8oVKZYAjoexHgiazVg@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 10 Apr 2021 19:15:39 +0300
Message-ID: <CA+U=DsqGG=NA9yHimRYuoSuBxupiqZ8JH-7FKThXj9J7D__U=A@mail.gmail.com>
Subject: Re: [PATCH 2/3] staging: iio: cdc: ad7746: use dt bindings to set the
 EXCx pins output
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 10, 2021 at 7:12 PM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Fri, Apr 9, 2021 at 9:51 PM Lucas Stankus <lucas.p.stankus@gmail.com> wrote:
> >
> > Ditch platform_data fields in favor of device tree properties for
> > configuring EXCA and EXCB output.
> > This also removes the fields from the platform_data struct, since they're
> > not used anymore.
> >
> > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> > ---
> >  drivers/staging/iio/cdc/ad7746.c | 33 +++++++++++++++++---------------
> >  drivers/staging/iio/cdc/ad7746.h |  4 ----
> >  2 files changed, 18 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> > index dfd71e99e872..63041b164dbe 100644
> > --- a/drivers/staging/iio/cdc/ad7746.c
> > +++ b/drivers/staging/iio/cdc/ad7746.c
> > @@ -677,8 +677,10 @@ static int ad7746_probe(struct i2c_client *client,
> >                         const struct i2c_device_id *id)
> >  {
> >         struct ad7746_platform_data *pdata = client->dev.platform_data;
> > +       struct device_node *np = client->dev.of_node;
> >         struct ad7746_chip_info *chip;
> >         struct iio_dev *indio_dev;
> > +       unsigned int exca_en, excb_en;
> >         unsigned char regval = 0;
> >         int ret = 0;
> >
> > @@ -703,26 +705,27 @@ static int ad7746_probe(struct i2c_client *client,
> >         indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
> >         indio_dev->modes = INDIO_DIRECT_MODE;
> >
>
> [1]
>
> > -       if (pdata) {
> > -               if (pdata->exca_en) {
> > -                       if (pdata->exca_inv_en)
> > -                               regval |= AD7746_EXCSETUP_NEXCA;
> > -                       else
> > -                               regval |= AD7746_EXCSETUP_EXCA;
> > -               }
> > +       ret = of_property_read_u32(np, "adi,exca-output", &exca_en);
>
> maybe a better idea would be to use:
>
> device_property_read_u32(dev, .... )
> where:
> dev = client->dev.;
>
> this would make the driver a bit more friendly with both OF and ACPI
>
> > +       if (!ret && exca_en) {
> > +               if (exca_en == 1)
> > +                       regval |= AD7746_EXCSETUP_EXCA;
> > +               else
> > +                       regval |= AD7746_EXCSETUP_NEXCA;
> > +       }
> >
> > -               if (pdata->excb_en) {
> > -                       if (pdata->excb_inv_en)
> > -                               regval |= AD7746_EXCSETUP_NEXCB;
> > -                       else
> > -                               regval |= AD7746_EXCSETUP_EXCB;
> > -               }
> > +       ret = of_property_read_u32(np, "adi,excb-output", &excb_en);
> > +       if (!ret && excb_en) {
> > +               if (excb_en == 1)
> > +                       regval |= AD7746_EXCSETUP_EXCB;
> > +               else
> > +                       regval |= AD7746_EXCSETUP_NEXCB;
> > +       }
> >
> > +       if (pdata) {
> >                 regval |= AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
> >         } else {
> >                 dev_warn(&client->dev, "No platform data? using default\n");
> > -               regval = AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
> > -                       AD7746_EXCSETUP_EXCLVL(3);
>
> This logic is problematic now.
> Because no matter what you're setting in the DT, it always gets
> overridden here because there is no platform data.
>
> Maybe a better idea is to do something like:
> if (!pdata)
>      regval = AD7746_EXCSETUP_EXCLVL(3);
>
> but this should be placed somewhere around [1]

[ i can see that this logic will get corrected in the next patch]
to add here a bit: the idea of a patch is that it should try to not
introduce any [even temporary] breakage, even when it's in a series;
if a driver was already broken, then it should get fixed via it's own patch;
but no patch should introduce any breakages [if possible]

>
>
> > +               regval = AD7746_EXCSETUP_EXCLVL(3);
> >         }
> >
> >         ret = i2c_smbus_write_byte_data(chip->client,
> > diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
> > index 8bdbd732dbbd..6cae4ecf779e 100644
> > --- a/drivers/staging/iio/cdc/ad7746.h
> > +++ b/drivers/staging/iio/cdc/ad7746.h
> > @@ -19,10 +19,6 @@
> >
> >  struct ad7746_platform_data {
> >         unsigned char exclvl;   /*Excitation Voltage Level */
> > -       bool exca_en;           /* enables EXCA pin as the excitation output */
> > -       bool exca_inv_en;       /* enables /EXCA pin as the excitation output */
> > -       bool excb_en;           /* enables EXCB pin as the excitation output */
> > -       bool excb_inv_en;       /* enables /EXCB pin as the excitation output */
> >  };
> >
> >  #endif /* IIO_CDC_AD7746_H_ */
> > --
> > 2.31.1
> >
