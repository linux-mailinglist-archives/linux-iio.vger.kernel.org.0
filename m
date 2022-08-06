Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D98458B7C0
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 20:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiHFSjb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiHFSja (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 14:39:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1659ADE89;
        Sat,  6 Aug 2022 11:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97A7CB80686;
        Sat,  6 Aug 2022 18:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898C9C433D6;
        Sat,  6 Aug 2022 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659811166;
        bh=1nxy2+EMukkR2gSWYRMBlAV6EjYfDMI0H3oB1FQKqrA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gRWZNgj60+7OibFgqj+1KPSlYeza9zTyo8nruOuXXGmGW9nIOaTKRx7LJgrdc7CuC
         4V8DhTOBYnFKm7cWzWwJmKsbWBIdQBMmdJ6GV4QkcXnuiMztTspZ9Y/opP8SqIRilp
         oyV9+f6Ro9z+pFQsyKFD5FV2dv5prL3CZEbcN9MZBpQDmeKowigZEq4bPA3208Uy4u
         qXs9x6i1qXNk60c55e+73yFZNnbwApMOVRoBIkK/uPmw6mGUd7+S3NAuDR+UOKOTiu
         cBnN24w7Voxfdzlo8GsE0dacm9/IQmb9UYdKNL/UxwX7WzxHocD8ySj/Y8lUnI9twD
         nF8xnw8HDl+rg==
Date:   Sat, 6 Aug 2022 19:49:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Claudiu.Beznea@microchip.com>
Cc:     <nuno.sa@analog.com>, <openbmc@lists.ozlabs.org>,
        <linux-imx@nxp.com>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-iio@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-arm-msm@vger.kernel.org>, <gwendal@chromium.org>,
        <sravanhome@gmail.com>, <tmaimon77@gmail.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <lorenzo@kernel.org>, <festevam@gmail.com>, <shawnguo@kernel.org>,
        <olivier.moysan@foss.st.com>, <tali.perry1@gmail.com>,
        <thara.gopinath@linaro.org>, <bjorn.andersson@linaro.org>,
        <arnd@arndb.de>, <benjaminfair@google.com>,
        <Nicolas.Ferre@microchip.com>, <rafael@kernel.org>,
        <venture@google.com>, <kernel@pengutronix.de>,
        <fabrice.gasnier@foss.st.com>, <daniel.lezcano@linaro.org>,
        <bleung@chromium.org>, <yuenn@google.com>,
        <miquel.raynal@bootlin.com>, <alexandre.belloni@bootlin.com>,
        <rui.zhang@intel.com>, <linus.walleij@linaro.org>,
        <cbranchereau@gmail.com>, <cai.huoqing@linux.dev>,
        <avifishman70@gmail.com>, <Eugen.Hristev@microchip.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <lars@metafoo.de>, <andy.shevchenko@gmail.com>,
        <groeck@chromium.org>, <paul@crapouillou.net>, <agross@kernel.org>,
        <amitk@kernel.org>, <Michael.Hennerich@analog.com>,
        <haibo.chen@nxp.com>, <quic_jprakash@quicinc.com>
Subject: Re: [PATCH v3 09/15] iio: adc: at91-sama5d2_adc: convert to device
 properties
Message-ID: <20220806194935.383bf393@jic23-huawei>
In-Reply-To: <ada4c2a2-e13d-77aa-f489-7cc0a063adbd@microchip.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
        <20220715122903.332535-10-nuno.sa@analog.com>
        <ada4c2a2-e13d-77aa-f489-7cc0a063adbd@microchip.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Jul 2022 05:21:47 +0000
<Claudiu.Beznea@microchip.com> wrote:

> On 15.07.2022 15:28, Nuno S=C3=A1 wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > Make the conversion to firmware agnostic device properties. As part of
> > the conversion the IIO inkern interface 'of_xlate()' is also converted =
to
> > 'fwnode_xlate()'. The goal is to completely drop 'of_xlate' and hence OF
> > dependencies from IIO.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com> =20
>=20
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20

Hi Nuno / Claudiu

Lots of fuzz on this one because of Claudiu's series that I took whilst thi=
s was under review
I haven't really checked the result of forcing it in but please take a look=
 at the
testing branch of iio.git for anything silly that happened.

Jonathan

>=20
> > ---
> >  drivers/iio/adc/at91-sama5d2_adc.c | 30 +++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-=
sama5d2_adc.c
> > index fe3131c9593c..df716584c117 100644
> > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > @@ -16,8 +16,9 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > -#include <linux/of_device.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/sched.h>
> >  #include <linux/wait.h>
> >  #include <linux/iio/iio.h>
> > @@ -650,8 +651,8 @@ at91_adc_chan_get(struct iio_dev *indio_dev, int ch=
an)
> >         return indio_dev->channels + index;
> >  }
> >=20
> > -static inline int at91_adc_of_xlate(struct iio_dev *indio_dev,
> > -                                   const struct of_phandle_args *iiosp=
ec)
> > +static inline int at91_adc_fwnode_xlate(struct iio_dev *indio_dev,
> > +                                       const struct fwnode_reference_a=
rgs *iiospec)
> >  {
> >         return at91_adc_chan_xlate(indio_dev, iiospec->args[0]);
> >  }
> > @@ -1876,7 +1877,7 @@ static const struct iio_info at91_adc_info =3D {
> >         .read_raw =3D &at91_adc_read_raw,
> >         .write_raw =3D &at91_adc_write_raw,
> >         .update_scan_mode =3D &at91_adc_update_scan_mode,
> > -       .of_xlate =3D &at91_adc_of_xlate,
> > +       .fwnode_xlate =3D &at91_adc_fwnode_xlate,
> >         .hwfifo_set_watermark =3D &at91_adc_set_watermark,
> >  };
> >=20
> > @@ -1920,6 +1921,7 @@ static int at91_adc_buffer_and_trigger_init(struc=
t device *dev,
> >=20
> >  static int at91_adc_probe(struct platform_device *pdev)
> >  {
> > +       struct device *dev =3D &pdev->dev;
> >         struct iio_dev *indio_dev;
> >         struct at91_adc_state *st;
> >         struct resource *res;
> > @@ -1933,7 +1935,7 @@ static int at91_adc_probe(struct platform_device =
*pdev)
> >         st =3D iio_priv(indio_dev);
> >         st->indio_dev =3D indio_dev;
> >=20
> > -       st->soc_info.platform =3D of_device_get_match_data(&pdev->dev);
> > +       st->soc_info.platform =3D device_get_match_data(dev);
> >=20
> >         indio_dev->name =3D dev_name(&pdev->dev);
> >         indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> > @@ -1950,34 +1952,32 @@ static int at91_adc_probe(struct platform_devic=
e *pdev)
> >=20
> >         st->oversampling_ratio =3D AT91_OSR_1SAMPLES;
> >=20
> > -       ret =3D of_property_read_u32(pdev->dev.of_node,
> > -                                  "atmel,min-sample-rate-hz",
> > -                                  &st->soc_info.min_sample_rate);
> > +       ret =3D device_property_read_u32(dev, "atmel,min-sample-rate-hz=
",
> > +                                      &st->soc_info.min_sample_rate);
> >         if (ret) {
> >                 dev_err(&pdev->dev,
> >                         "invalid or missing value for atmel,min-sample-=
rate-hz\n");
> >                 return ret;
> >         }
> >=20
> > -       ret =3D of_property_read_u32(pdev->dev.of_node,
> > -                                  "atmel,max-sample-rate-hz",
> > -                                  &st->soc_info.max_sample_rate);
> > +       ret =3D device_property_read_u32(dev, "atmel,max-sample-rate-hz=
",
> > +                                      &st->soc_info.max_sample_rate);
> >         if (ret) {
> >                 dev_err(&pdev->dev,
> >                         "invalid or missing value for atmel,max-sample-=
rate-hz\n");
> >                 return ret;
> >         }
> >=20
> > -       ret =3D of_property_read_u32(pdev->dev.of_node, "atmel,startup-=
time-ms",
> > -                                  &st->soc_info.startup_time);
> > +       ret =3D device_property_read_u32(dev, "atmel,startup-time-ms",
> > +                                      &st->soc_info.startup_time);
> >         if (ret) {
> >                 dev_err(&pdev->dev,
> >                         "invalid or missing value for atmel,startup-tim=
e-ms\n");
> >                 return ret;
> >         }
> >=20
> > -       ret =3D of_property_read_u32(pdev->dev.of_node,
> > -                                  "atmel,trigger-edge-type", &edge_typ=
e);
> > +       ret =3D device_property_read_u32(dev, "atmel,trigger-edge-type",
> > +                                      &edge_type);
> >         if (ret) {
> >                 dev_dbg(&pdev->dev,
> >                         "atmel,trigger-edge-type not specified, only so=
ftware trigger available\n");
> > --
> > 2.37.1
> >  =20
>=20

