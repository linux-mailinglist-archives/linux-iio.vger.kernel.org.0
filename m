Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37347CE8F0
	for <lists+linux-iio@lfdr.de>; Wed, 18 Oct 2023 22:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjJRUaV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 18 Oct 2023 16:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344682AbjJRUaA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 16:30:00 -0400
X-Greylist: delayed 572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 13:29:28 PDT
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de [80.67.31.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583561BD;
        Wed, 18 Oct 2023 13:29:27 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <git@apitzsch.eu>)
        id 1qtD1D-00040X-0p;
        Wed, 18 Oct 2023 22:19:51 +0200
Message-ID: <82b99e17f45b09623eeaed12e4fac12609c15426.camel@apitzsch.eu>
Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
From:   =?ISO-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
To:     Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Date:   Wed, 18 Oct 2023 22:19:49 +0200
In-Reply-To: <20231018204533.39399b0b@jic23-huawei>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
         <20230818075600.24277-2-biju.das.jz@bp.renesas.com>
         <5e0d2716fb757d408ebe77cb132ae242ef3aa470.camel@apitzsch.eu>
         <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com>
         <20231018204533.39399b0b@jic23-huawei>
Autocrypt: addr=git@apitzsch.eu; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Am Mittwoch, dem 18.10.2023 um 20:45 +0100 schrieb Jonathan Cameron:
> On Wed, 18 Oct 2023 09:04:44 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > Hi André,
> > 
> > On Tue, Oct 17, 2023 at 11:12 PM André Apitzsch <git@apitzsch.eu>
> > wrote:
> > > Am Freitag, dem 18.08.2023 um 08:55 +0100 schrieb Biju Das:  
> > > > Convert enum->pointer for data in the match tables to simplify
> > > > the
> > > > probe()
> > > > by replacing device_get_match_data() and
> > > > i2c_client_get_device_id by
> > > > i2c_get_match_data() as we have similar I2C, ACPI and DT
> > > > matching
> > > > table.
> > > > 
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>  
> > 
> > > > --- a/drivers/iio/magnetometer/ak8975.c
> > > > +++ b/drivers/iio/magnetometer/ak8975.c
> > > > @@ -883,10 +883,7 @@ static int ak8975_probe(struct i2c_client
> > > > *client)
> > > >       struct iio_dev *indio_dev;
> > > >       struct gpio_desc *eoc_gpiod;
> > > >       struct gpio_desc *reset_gpiod;
> > > > -     const void *match;
> > > > -     unsigned int i;
> > > >       int err;
> > > > -     enum asahi_compass_chipset chipset;
> > > >       const char *name = NULL;
> > > > 
> > > >       /*
> > > > @@ -928,27 +925,15 @@ static int ak8975_probe(struct i2c_client
> > > > *client)
> > > >               return err;
> > > > 
> > > >       /* id will be NULL when enumerated via ACPI */
> > > > -     match = device_get_match_data(&client->dev);
> > > > -     if (match) {
> > > > -             chipset = (uintptr_t)match;
> > > > -             name = dev_name(&client->dev);
> > > > -     } else if (id) {
> > > > -             chipset = (enum asahi_compass_chipset)(id-  
> > > > > driver_data);  
> > > > -             name = id->name;
> > > > -     } else
> > > > -             return -ENOSYS;
> > > > -
> > > > -     for (i = 0; i < ARRAY_SIZE(ak_def_array); i++)
> > > > -             if (ak_def_array[i].type == chipset)
> > > > -                     break;
> > > > -
> > > > -     if (i == ARRAY_SIZE(ak_def_array)) {
> > > > -             dev_err(&client->dev, "AKM device type
> > > > unsupported:
> > > > %d\n",
> > > > -                     chipset);
> > > > +     data->def = i2c_get_match_data(client);
> > > > +     if (!data->def)
> > > >               return -ENODEV;
> > > > -     }
> > > > 
> > > > -     data->def = &ak_def_array[i];
> > > > +     /* If enumerated via firmware node, fix the ABI */
> > > > +     if (dev_fwnode(&client->dev))
> > > > +             name = dev_name(&client->dev);
> > > > +     else
> > > > +             name = id->name;
> > > >  
> > > 
> > > I just noticed, that with the above change '0-000d' instead of
> > > the previous and expected 'ak09911' is shown now as name for the
> > > magnetometer in longcheer l9100 [1].  
> > 
> > While this doesn't help much, note that the old name would break
> > the case of having two instances of the same device.
> 
> Why? In IIO ABI, this is the part number - it's absolutely fine to
> have two device with same name. There are lots of other ways of
> figuring out which is which (parent device being the easiest).
> 
> This is indeed a bug but it isn't a new one and it's been there long
> enough that there may be userspace code relying on it...  
> 
At least for the longcheer l9100 it is a new bug that was introduced by
this patch. But as my only use for this name is via hwtest[1], which
uses the name as "pretty model name", it's fine with me if it cannot be
fixed.

André

[1] https://gitlab.com/MartijnBraam/hwtest

> There are some of these from a time when I was being unobservant in
> catching them in review (this one was approx 2014 I think)
> We've never fixed them because of possibility of breaking usersapce.
> 
> 
> > 
> > > 
> > > id->name contains the expected string ('ak09911'), but because of
> > > dev_fwnode(&client->dev) being true, it is not used.
> > > 
> > > André
> > > 
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts?h=next-20231017#n127
> > >  
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> 

