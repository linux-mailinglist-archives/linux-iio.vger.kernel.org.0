Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347057CE839
	for <lists+linux-iio@lfdr.de>; Wed, 18 Oct 2023 21:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjJRTx0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 18 Oct 2023 15:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjJRTxZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 15:53:25 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9099AB;
        Wed, 18 Oct 2023 12:53:23 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a7af20c488so89490997b3.1;
        Wed, 18 Oct 2023 12:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658803; x=1698263603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCRnEoTI1eSIJITo4ivmBe2YSegYGSxAYz7zUmyT2lk=;
        b=p3mBC6XonPxwnnHioS61Fceut7LAMDwRTv/9ovkS1VOK//jO64ntuMBN0U2SyOhQZm
         6AtDL2+qiUvhoIRSWCjCPD9NQGEj+UXXl/7f5Rkddm/ocrrbcHDPtRS/v1k4L5c7xX9A
         RMYTKm2rOV5gJ6NhHBMcYp/jVs3DQeqpwmHS8xPtV36YFp4wvbQUY6onNkGDPXDtUr+k
         muQ0kgEJPHdTSbibkP4D+s1P9GeRK2DpElhTmKV5CEEwYIAunrsrZFkUINt4sgUmaaaG
         7HpLLI7/MLqRllZT3DdVFHsHj4J4iOqS8f2No5aLLUAOdCVMZxFJzvIyMJ5NG/LhXBJb
         sldw==
X-Gm-Message-State: AOJu0YypKwg4qlsAcCTfKkBbLScOTQi3/tm/e/CWF2fsXZD6bUjDTbcS
        0SAaRPB4Z5/D2XBBfMzfpwVvQtNxay9PBQ==
X-Google-Smtp-Source: AGHT+IHURgA5eCF3fO56pgpF6oGP2RnCE7OrXr3fJ5TVNcIPeppmSLjMgIBr51VeHdsKOCL4vKpf1Q==
X-Received: by 2002:a0d:cec2:0:b0:5a7:af86:8d3b with SMTP id q185-20020a0dcec2000000b005a7af868d3bmr275317ywd.37.1697658802699;
        Wed, 18 Oct 2023 12:53:22 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id n69-20020a0dcb48000000b0059f8120ee4dsm1799697ywd.30.2023.10.18.12.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:53:22 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7af20c488so89490777b3.1;
        Wed, 18 Oct 2023 12:53:22 -0700 (PDT)
X-Received: by 2002:a0d:ead7:0:b0:5a7:d86c:988 with SMTP id
 t206-20020a0dead7000000b005a7d86c0988mr284237ywe.28.1697658801950; Wed, 18
 Oct 2023 12:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-2-biju.das.jz@bp.renesas.com> <5e0d2716fb757d408ebe77cb132ae242ef3aa470.camel@apitzsch.eu>
 <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com> <20231018204533.39399b0b@jic23-huawei>
In-Reply-To: <20231018204533.39399b0b@jic23-huawei>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 21:53:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWVqcg=z9xoEGZ3mB4AUsZfzMc0kn3i+2wuY+r8VdJd0g@mail.gmail.com>
Message-ID: <CAMuHMdWVqcg=z9xoEGZ3mB4AUsZfzMc0kn3i+2wuY+r8VdJd0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     git@apitzsch.eu, Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Wed, Oct 18, 2023 at 9:45 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 18 Oct 2023 09:04:44 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Oct 17, 2023 at 11:12 PM André Apitzsch <git@apitzsch.eu> wrote:
> > > Am Freitag, dem 18.08.2023 um 08:55 +0100 schrieb Biju Das:
> > > > Convert enum->pointer for data in the match tables to simplify the
> > > > probe()
> > > > by replacing device_get_match_data() and i2c_client_get_device_id by
> > > > i2c_get_match_data() as we have similar I2C, ACPI and DT matching
> > > > table.
> > > >
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > > > --- a/drivers/iio/magnetometer/ak8975.c
> > > > +++ b/drivers/iio/magnetometer/ak8975.c
> > > > @@ -883,10 +883,7 @@ static int ak8975_probe(struct i2c_client
> > > > *client)
> > > >       struct iio_dev *indio_dev;
> > > >       struct gpio_desc *eoc_gpiod;
> > > >       struct gpio_desc *reset_gpiod;
> > > > -     const void *match;
> > > > -     unsigned int i;
> > > >       int err;
> > > > -     enum asahi_compass_chipset chipset;
> > > >       const char *name = NULL;
> > > >
> > > >       /*
> > > > @@ -928,27 +925,15 @@ static int ak8975_probe(struct i2c_client
> > > > *client)
> > > >               return err;
> > > >
> > > >       /* id will be NULL when enumerated via ACPI */
> > > > -     match = device_get_match_data(&client->dev);
> > > > -     if (match) {
> > > > -             chipset = (uintptr_t)match;
> > > > -             name = dev_name(&client->dev);
> > > > -     } else if (id) {
> > > > -             chipset = (enum asahi_compass_chipset)(id-
> > > > >driver_data);
> > > > -             name = id->name;
> > > > -     } else
> > > > -             return -ENOSYS;
> > > > -
> > > > -     for (i = 0; i < ARRAY_SIZE(ak_def_array); i++)
> > > > -             if (ak_def_array[i].type == chipset)
> > > > -                     break;
> > > > -
> > > > -     if (i == ARRAY_SIZE(ak_def_array)) {
> > > > -             dev_err(&client->dev, "AKM device type unsupported:
> > > > %d\n",
> > > > -                     chipset);
> > > > +     data->def = i2c_get_match_data(client);
> > > > +     if (!data->def)
> > > >               return -ENODEV;
> > > > -     }
> > > >
> > > > -     data->def = &ak_def_array[i];
> > > > +     /* If enumerated via firmware node, fix the ABI */
> > > > +     if (dev_fwnode(&client->dev))
> > > > +             name = dev_name(&client->dev);
> > > > +     else
> > > > +             name = id->name;
> > > >
> > >
> > > I just noticed, that with the above change '0-000d' instead of the
> > > previous and expected 'ak09911' is shown now as name for the
> > > magnetometer in longcheer l9100 [1].
> >
> > While this doesn't help much, note that the old name would break
> > the case of having two instances of the same device.
>
> Why? In IIO ABI, this is the part number - it's absolutely fine to have
> two device with same name. There are lots of other ways of figuring out
> which is which (parent device being the easiest).

Oops, I had missed this is used (only) for the iio_dev, and thus cannot
cause duplicates in sysfs, I assume.
So please ignore my comment.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
