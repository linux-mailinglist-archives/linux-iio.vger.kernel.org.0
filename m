Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27AA575FEB
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jul 2022 13:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiGOLV0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jul 2022 07:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGOLVZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2022 07:21:25 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2267B87C1C;
        Fri, 15 Jul 2022 04:21:24 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r17so3490944qtx.6;
        Fri, 15 Jul 2022 04:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=7aAwPpbyNhMgBtXYplVX7e+e1ZXjzCZEFZQ0/Qp+rZs=;
        b=XdinAxILUx5V4/TMUwVnHjrF2YH64IZZFeCyINRd3Uc2T7zK5jdlBkPARxgAUQPknQ
         jCfx0227x6mZ/nJvyEdEOP0X2HcETQpjzcvpoVctcPe8hpu24084l6+Zfq6C9Yp+Pe19
         LGKjBB+xZcEbyihQC5Jva22iuE9RvoR1T1A0aT5gZbbl2uX8Yfn+4VkAcRNJ2oRqIyBp
         hvqhsHzhzq2ZXGWh4u48/NdYzataIRkzPk7S3WkMEcPz42YtmZsCcrQ4fU8zYMkCmEb3
         CBLLe2wOl7idYi+SWFz4xCdXZ1vxsiFpcZo/yuvmbHWMT7smdxKunQKgJNVUdlfCfqdO
         L3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=7aAwPpbyNhMgBtXYplVX7e+e1ZXjzCZEFZQ0/Qp+rZs=;
        b=C32l/yvn3gn5zO6KUh/FKMf6/PfjQKJcyyG1FRiIjYeMrRB/pPLfLYrogpaKzZs6hz
         F9Kop2gErdrdSGoX78NlIMSEsORVBVOuu6FfJHTzYuGY+e3UDLoHNx5J48Ssm/A5SuO+
         K76YvZv/VGaXzXJLBUwAVmOMmyFmy4c+gCKp0loZZC1tPw9a+9R2y86DCepmFW7UYU1V
         YMmcHwsrgck1CUhc53UERSb3YtE1VE/3O1BAQ5FK53xdXqeqSsUxtgCLEdk2tFQmNXhq
         ri/Q/oRJe2Gh+pi5BC36yQVwoyyo3G9Ei/lCaXHnVtBoqSbRyadHrr0pYqYKLr0JxykK
         4O3g==
X-Gm-Message-State: AJIora8PeeNWzLKO/6GHVfsZX4CW1T2u3HxtYjIX48xMB38wkPD9+O+k
        qeqssOuRx6oYALiUUgbr7Yk=
X-Google-Smtp-Source: AGRyM1uAV6CcmfwBUiFodYja+YAI93swdvRkjmOrj/G87DJHG1tvUago8AS2lP01zuUI+2pKWO0gZQ==
X-Received: by 2002:a05:622a:20f:b0:31e:de95:3cd3 with SMTP id b15-20020a05622a020f00b0031ede953cd3mr944896qtx.458.1657884082996;
        Fri, 15 Jul 2022 04:21:22 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id ay7-20020a05620a178700b006b578ff5dfasm3767112qkb.41.2022.07.15.04.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 04:21:22 -0700 (PDT)
Message-ID: <83d816f52b3d4194b51b20f31b875055f63cd718.camel@gmail.com>
Subject: Re: [PATCH v2 13/15] iio: adc: stm32-adc: convert to device
 properties
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-arm-msm@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-imx@nxp.com,
        linux-mips@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Andy Gross <agross@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Patrick Venture <venture@google.com>,
        Amit Kucheria <amitk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Jul 2022 13:22:18 +0200
In-Reply-To: <c4385216-1d9e-34b3-58ea-edf8d9ed4cd8@foss.st.com>
References: <20220711123835.811358-1-nuno.sa@analog.com>
         <20220711123835.811358-14-nuno.sa@analog.com>
         <f0f150cf-586f-9f13-81b0-cb95bd0d8f23@foss.st.com>
         <ca7dc3801e29ddaa59f868c20d491d15541522d8.camel@gmail.com>
         <c4385216-1d9e-34b3-58ea-edf8d9ed4cd8@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2022-07-13 at 17:48 +0200, Fabrice Gasnier wrote:
> On 7/12/22 12:33, Nuno S=C3=A1 wrote:
> > Hi Fabrice,
> >=20
> > Nice that someone in ST is looking at this one :)
>=20
> Hi Nuno,
>=20
> Thank you for taking care of converting all these drivers to device
> properties, including this one :-).
>=20
> >=20
> > On Mon, 2022-07-11 at 16:04 +0200, Fabrice Gasnier wrote:
> > > On 7/11/22 14:38, Nuno S=C3=A1 wrote:
> > > > Make the conversion to firmware agnostic device properties. As
> > > > part
> > > > of
> > > > the conversion the IIO inkern interface 'of_xlate()' is also
> > > > converted to
> > > > 'fwnode_xlate()'. The goal is to completely drop 'of_xlate' and
> > > > hence OF
> > > > dependencies from IIO.
> > > >=20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0drivers/iio/adc/stm32-adc.c | 121 ++++++++++++++++++++-------=
-
> > > > ----
> > > > ----
> > > > =C2=A01 file changed, 67 insertions(+), 54 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/adc/stm32-adc.c
> > > > b/drivers/iio/adc/stm32-
> > > > adc.c
> > > > index 3985fe972892..e55859113df8 100644
> > > > --- a/drivers/iio/adc/stm32-adc.c
> > > > +++ b/drivers/iio/adc/stm32-adc.c
> > > > @@ -21,11 +21,11 @@
> > > > =C2=A0#include <linux/io.h>
> > > > =C2=A0#include <linux/iopoll.h>
> > > > =C2=A0#include <linux/module.h>
> > > > +#include <linux/mod_devicetable.h>
> > > > =C2=A0#include <linux/nvmem-consumer.h>
> > > > =C2=A0#include <linux/platform_device.h>
> > > > =C2=A0#include <linux/pm_runtime.h>
> > > > -#include <linux/of.h>
> > > > -#include <linux/of_device.h>
> > > > +#include <linux/property.h>
> > > > =C2=A0
> > > > =C2=A0#include "stm32-adc-core.h"
> > > > =C2=A0
> > > > @@ -1530,8 +1530,8 @@ static int
> > > > stm32_adc_update_scan_mode(struct
> > > > iio_dev *indio_dev,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > > =C2=A0}
> > > > =C2=A0
> > > > -static int stm32_adc_of_xlate(struct iio_dev *indio_dev,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct of_phandle_args
> > > > *iiospec)
> > > > +static int stm32_adc_fwnode_xlate(struct iio_dev *indio_dev,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct
> > > > fwnode_reference_args *iiospec)
> > > > =C2=A0{
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> > > > =C2=A0
> > > > @@ -1585,7 +1585,7 @@ static const struct iio_info
> > > > stm32_adc_iio_info =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.hwfifo_set_waterma=
rk =3D stm32_adc_set_watermark,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.update_scan_mode =
=3D stm32_adc_update_scan_mode,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.debugfs_reg_access=
 =3D stm32_adc_debugfs_reg_access,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.of_xlate =3D stm32_adc_=
of_xlate,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.fwnode_xlate =3D stm32_=
adc_fwnode_xlate,
> > > > =C2=A0};
> > > > =C2=A0
> > > > =C2=A0static unsigned int stm32_adc_dma_residue(struct stm32_adc
> > > > *adc)
> > > > @@ -1782,14 +1782,14 @@ static const struct
> > > > iio_chan_spec_ext_info
> > > > stm32_adc_ext_info[] =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{},
> > > > =C2=A0};
> > > > =C2=A0
> > > > -static int stm32_adc_of_get_resolution(struct iio_dev
> > > > *indio_dev)
> > > > +static int stm32_adc_fw_get_resolution(struct iio_dev
> > > > *indio_dev)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_node *node=
 =3D indio_dev->dev.of_node;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device *dev =3D &=
indio_dev->dev;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct stm32_adc *a=
dc =3D iio_priv(indio_dev);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int i;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 res;
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (of_property_read_u32=
(node, "assigned-resolution-
> > > > bits",
> > > > &res))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (device_property_read=
_u32(dev, "assigned-resolution-
> > > > bits", &res))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D adc->cfg->adc_info->resolutions[0];
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < a=
dc->cfg->adc_info->num_res; i++)
> > > > @@ -1873,11 +1873,11 @@ static void
> > > > stm32_adc_chan_init_one(struct
> > > > iio_dev *indio_dev,
> > > > =C2=A0
> > > > =C2=A0static int stm32_adc_get_legacy_chan_count(struct iio_dev
> > > > *indio_dev, struct stm32_adc *adc)
> > > > =C2=A0{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device_node *node=
 =3D indio_dev->dev.of_node;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device *dev =3D &=
indio_dev->dev;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct stm32_=
adc_info *adc_info =3D adc->cfg-
> > > > >adc_info;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int num_channels =
=3D 0, ret;
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D of_property_coun=
t_u32_elems(node, "st,adc-
> > > > channels");
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D device_property_=
count_u32(dev, "st,adc-
> > > > channels");
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret > adc_info-=
>max_channels) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_err(&indio_dev->dev, "Bad st,adc-
> > > > channels?\n");
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > > @@ -1885,8 +1885,8 @@ static int
> > > > stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev,
> > > > struct
> > > > stm
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0num_channels +=3D ret;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D of_property_coun=
t_elems_of_size(node, "st,adc-
> > > > diff-
> > > > channels",
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct
> > > > stm32_adc_diff_channel));
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* each st,adc-diff-chan=
nels is a group of 2 u32 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D device_property_=
count_u64(dev, "st,adc-diff-
> > > > channels");
> >=20
> > Are you fine with this change (still does not have any reference to
> > the
> > target struct but the comment might be helpful and there's no magic
> > 2)?
>=20
>=20
> Since you added that comment, this sounds better. IMHO, This still
> looks
> a bit weird. I'd feel more comfortable by using u32 API for a
> 'uint32-matrix' as defined in dt-bindings.
> Strictly speaking, something like
> sizeof(struct stm32_adc_diff_channel) / sizeof(u32) could be used,
> along
> with this comment and device_property_count_u32() to make it clear ?
>=20

No strong option so I can do as you prefer:

	ret =3D device_property_count_u32();
	if (ret /=C2=A0
(sizeof(struct stm32_adc_diff_channel) / sizeof(u32)) > max_chan) {
		...
	}
	...

Probably it's a good idea to store that sizeof() division in a local
variable :)

- Nuno S=C3=A1

> > >=20
>=20
