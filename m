Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2EA7CD504
	for <lists+linux-iio@lfdr.de>; Wed, 18 Oct 2023 09:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344591AbjJRHFD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 18 Oct 2023 03:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344581AbjJRHFC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 03:05:02 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D11B0;
        Wed, 18 Oct 2023 00:04:59 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a2536adaf3so87836327b3.2;
        Wed, 18 Oct 2023 00:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697612698; x=1698217498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ehq7lt09mwOzTppGLck+YyAM10dg6P1xZomRPZqI724=;
        b=HjPf/v4kfJMOEAb6YAiEuFvS8GPxZ0b0IR3pIsVtQW8lXwT1WboJ8KJrHSe2Z/3fs8
         dtcowqfMKf4lmSCSwRqsRvx68VFr+VdeWs+TZwY9HTrs3ZKJz8+RKWHFNXeyrxwl4rB7
         AQDwzqw+nMLTSMTHXG9Rv4nJwKBDdN1RYTqVkhUrpo3/ZGizdscbJss02O9wAoRi1/13
         jS4LE+ocPcOrpQgkZsggGw+TRri4AxyEfIT2teKj9soBynWVgkdI2e8OOiIjZ4lMnitn
         4v+vmSSCYVK09WYZtTgOALu9e1maOuCJdAc+vaXTuQujxz1jAz8n0tQS9lyFghwjdqwS
         cUmw==
X-Gm-Message-State: AOJu0YwLg9pZt3LazMF5xVhYrzT8ORY4rpmjUMO4YwY8YH0S5rYMBDOs
        LlgbMdo+5Zg6hF2R06nkDqjjLzv7nIDjRQ==
X-Google-Smtp-Source: AGHT+IF6u8W8Oksz2vO6EhNr4pbMKHdcWbQZBvtnHLYHWwv0nz3X6t1YGbHsPg6SN7NBaZ27P8TY4A==
X-Received: by 2002:a81:8407:0:b0:5a7:a81d:e410 with SMTP id u7-20020a818407000000b005a7a81de410mr5004991ywf.18.1697612698487;
        Wed, 18 Oct 2023 00:04:58 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id i20-20020a81d514000000b00583b144fe51sm1262906ywj.118.2023.10.18.00.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 00:04:57 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d9a64ca9cedso6629977276.1;
        Wed, 18 Oct 2023 00:04:57 -0700 (PDT)
X-Received: by 2002:a25:19d7:0:b0:d9a:618a:d727 with SMTP id
 206-20020a2519d7000000b00d9a618ad727mr3996335ybz.41.1697612697358; Wed, 18
 Oct 2023 00:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-2-biju.das.jz@bp.renesas.com> <5e0d2716fb757d408ebe77cb132ae242ef3aa470.camel@apitzsch.eu>
In-Reply-To: <5e0d2716fb757d408ebe77cb132ae242ef3aa470.camel@apitzsch.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 09:04:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com>
Message-ID: <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
To:     git@apitzsch.eu
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
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

Hi André,

On Tue, Oct 17, 2023 at 11:12 PM André Apitzsch <git@apitzsch.eu> wrote:
> Am Freitag, dem 18.08.2023 um 08:55 +0100 schrieb Biju Das:
> > Convert enum->pointer for data in the match tables to simplify the
> > probe()
> > by replacing device_get_match_data() and i2c_client_get_device_id by
> > i2c_get_match_data() as we have similar I2C, ACPI and DT matching
> > table.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c
> > @@ -883,10 +883,7 @@ static int ak8975_probe(struct i2c_client
> > *client)
> >       struct iio_dev *indio_dev;
> >       struct gpio_desc *eoc_gpiod;
> >       struct gpio_desc *reset_gpiod;
> > -     const void *match;
> > -     unsigned int i;
> >       int err;
> > -     enum asahi_compass_chipset chipset;
> >       const char *name = NULL;
> >
> >       /*
> > @@ -928,27 +925,15 @@ static int ak8975_probe(struct i2c_client
> > *client)
> >               return err;
> >
> >       /* id will be NULL when enumerated via ACPI */
> > -     match = device_get_match_data(&client->dev);
> > -     if (match) {
> > -             chipset = (uintptr_t)match;
> > -             name = dev_name(&client->dev);
> > -     } else if (id) {
> > -             chipset = (enum asahi_compass_chipset)(id-
> > >driver_data);
> > -             name = id->name;
> > -     } else
> > -             return -ENOSYS;
> > -
> > -     for (i = 0; i < ARRAY_SIZE(ak_def_array); i++)
> > -             if (ak_def_array[i].type == chipset)
> > -                     break;
> > -
> > -     if (i == ARRAY_SIZE(ak_def_array)) {
> > -             dev_err(&client->dev, "AKM device type unsupported:
> > %d\n",
> > -                     chipset);
> > +     data->def = i2c_get_match_data(client);
> > +     if (!data->def)
> >               return -ENODEV;
> > -     }
> >
> > -     data->def = &ak_def_array[i];
> > +     /* If enumerated via firmware node, fix the ABI */
> > +     if (dev_fwnode(&client->dev))
> > +             name = dev_name(&client->dev);
> > +     else
> > +             name = id->name;
> >
>
> I just noticed, that with the above change '0-000d' instead of the
> previous and expected 'ak09911' is shown now as name for the
> magnetometer in longcheer l9100 [1].

While this doesn't help much, note that the old name would break
the case of having two instances of the same device.

>
> id->name contains the expected string ('ak09911'), but because of
> dev_fwnode(&client->dev) being true, it is not used.
>
> André
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts?h=next-20231017#n127

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
