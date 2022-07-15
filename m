Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A31576597
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jul 2022 19:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiGOQ6p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jul 2022 12:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiGOQ6n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2022 12:58:43 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A232DE0;
        Fri, 15 Jul 2022 09:58:41 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r3so9407735ybr.6;
        Fri, 15 Jul 2022 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6TdTlfwy3VaOHhzh3w0gNaUggIvchfGZQp8YCLWV7oY=;
        b=BeFoKvyI8i2XygR6nvzh7zbxCtLGryeU7dNvVGH7jDZ1PJIBE83e3+PSNvY6ICgEUU
         q58JAMYx/pm5PMQl4T8enDXIFWvqkymuoPwDcRRpW+OKwyxDlvr3n55AMW3xIbVHVKoC
         8NanGry13JZTTag8itRIZr767/KfR//ctoGU3qzM7oTXayebuoVcPUn7s3Sp577DPiz6
         qi48Fa7d6TVSPC8kxFPnxxN8uP5eK/jzPHexK8fxuMloHOSpedJqLcFd2agQd1WYL7Ik
         DK0FLWqVYDZZb4lwlzcpy9kPNGX7EqvUn99mW8HHZv4YREmATxb/iaO1SXUUPYKdtszu
         Pghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6TdTlfwy3VaOHhzh3w0gNaUggIvchfGZQp8YCLWV7oY=;
        b=xrqQKWR6v9L07VP6ohjBsuLvIJsu8XGc/U9S4Avq0DG9ICYdp2XCD37D+A4iVio1bF
         cU8GdBn85zH/UNysCC1MGi7ssWw63iBGwfmE7taqGUi9ggQFweMX7tM7+AV6zhOry++N
         3vBz7lPX/QQLQV1eOemWMkH6SmWow4wWxs6rYyKhCh2JtJRZhxClp/3vpIpTj5+qoz8K
         T34ow275YP8H59C1IV2KLwb4Elqa6W3nFmBn/Qk8/AArwIgFClZ0hae/fBoQVvUpB5Ij
         gCm5Vn/xvgjY2r1qFdWwA4Qg2bn4wCiApNbrFVQ+PQTt+uvkejFaTB1ebf6swCgDGhp9
         E6aQ==
X-Gm-Message-State: AJIora/AMjaT7HLRfbXg5FYXgcZdFc58UvNbDFBzbViyBhvyM1OaGe5I
        IGpf5oUnSpc+LMMkNmAMTaYVdZXlVJmfXww2sxI=
X-Google-Smtp-Source: AGRyM1vz/6TKfh7SokVQwLtVlkAQ04xf3jyr6vlrHNLFud++94euqeWrbXjYuq+FWKtOVT/MHqSlYgTvyTdVSt/zQ4w=
X-Received: by 2002:a5b:44d:0:b0:66f:ad5a:9d0b with SMTP id
 s13-20020a5b044d000000b0066fad5a9d0bmr13586144ybp.79.1657904320602; Fri, 15
 Jul 2022 09:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220715122903.332535-1-nuno.sa@analog.com> <20220715122903.332535-16-nuno.sa@analog.com>
In-Reply-To: <20220715122903.332535-16-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Jul 2022 18:58:04 +0200
Message-ID: <CAHp75Vdxa1MvzQ07abNL1LHB8e88tpBW0qmGx7_gY=CxvVxqkA@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] iio: inkern: fix coding style warnings
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        chrome-platform@lists.linux.dev,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Fair <benjaminfair@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Patrick Venture <venture@google.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Nancy Yuen <yuenn@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Avi Fishman <avifishman70@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Guenter Roeck <groeck@chromium.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
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

On Fri, Jul 15, 2022 at 2:30 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> Just cosmetics. No functional change intended...

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/inkern.c | 64 ++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index fab951546086..0c9b1561af31 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -45,13 +45,13 @@ int iio_map_array_register(struct iio_dev *indio_dev,=
 struct iio_map *maps)
>         int i =3D 0, ret =3D 0;
>         struct iio_map_internal *mapi;
>
> -       if (maps =3D=3D NULL)
> +       if (!maps)
>                 return 0;
>
>         mutex_lock(&iio_map_list_lock);
> -       while (maps[i].consumer_dev_name !=3D NULL) {
> +       while (maps[i].consumer_dev_name) {
>                 mapi =3D kzalloc(sizeof(*mapi), GFP_KERNEL);
> -               if (mapi =3D=3D NULL) {
> +               if (!mapi) {
>                         ret =3D -ENOMEM;
>                         goto error_ret;
>                 }
> @@ -69,7 +69,6 @@ int iio_map_array_register(struct iio_dev *indio_dev, s=
truct iio_map *maps)
>  }
>  EXPORT_SYMBOL_GPL(iio_map_array_register);
>
> -
>  /*
>   * Remove all map entries associated with the given iio device
>   */
> @@ -157,7 +156,7 @@ static int __fwnode_iio_channel_get(struct iio_channe=
l *channel,
>                 return err;
>
>         idev =3D bus_find_device_by_fwnode(&iio_bus_type, iiospec.fwnode)=
;
> -       if (idev =3D=3D NULL) {
> +       if (!idev) {
>                 fwnode_handle_put(iiospec.fwnode);
>                 return -EPROBE_DEFER;
>         }
> @@ -190,7 +189,7 @@ static struct iio_channel *fwnode_iio_channel_get(str=
uct fwnode_handle *fwnode,
>                 return ERR_PTR(-EINVAL);
>
>         channel =3D kzalloc(sizeof(*channel), GFP_KERNEL);
> -       if (channel =3D=3D NULL)
> +       if (!channel)
>                 return ERR_PTR(-ENOMEM);
>
>         err =3D __fwnode_iio_channel_get(channel, fwnode, index);
> @@ -307,7 +306,7 @@ static struct iio_channel *fwnode_iio_channel_get_all=
(struct device *dev)
>
>         /* NULL terminated array to save passing size */
>         chans =3D kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
> -       if (chans =3D=3D NULL)
> +       if (!chans)
>                 return ERR_PTR(-ENOMEM);
>
>         /* Search for FW matches */
> @@ -332,7 +331,7 @@ static struct iio_channel *iio_channel_get_sys(const =
char *name,
>         struct iio_channel *channel;
>         int err;
>
> -       if (name =3D=3D NULL && channel_name =3D=3D NULL)
> +       if (!(name || channel_name))
>                 return ERR_PTR(-ENODEV);
>
>         /* first find matching entry the channel map */
> @@ -347,11 +346,11 @@ static struct iio_channel *iio_channel_get_sys(cons=
t char *name,
>                 break;
>         }
>         mutex_unlock(&iio_map_list_lock);
> -       if (c =3D=3D NULL)
> +       if (!c)
>                 return ERR_PTR(-ENODEV);
>
>         channel =3D kzalloc(sizeof(*channel), GFP_KERNEL);
> -       if (channel =3D=3D NULL) {
> +       if (!channel) {
>                 err =3D -ENOMEM;
>                 goto error_no_mem;
>         }
> @@ -363,7 +362,7 @@ static struct iio_channel *iio_channel_get_sys(const =
char *name,
>                         iio_chan_spec_from_name(channel->indio_dev,
>                                                 c->map->adc_channel_label=
);
>
> -               if (channel->channel =3D=3D NULL) {
> +               if (!channel->channel) {
>                         err =3D -EINVAL;
>                         goto error_no_chan;
>                 }
> @@ -455,7 +454,7 @@ struct iio_channel *iio_channel_get_all(struct device=
 *dev)
>         int mapind =3D 0;
>         int i, ret;
>
> -       if (dev =3D=3D NULL)
> +       if (!dev)
>                 return ERR_PTR(-EINVAL);
>
>         chans =3D fwnode_iio_channel_get_all(dev);
> @@ -483,7 +482,7 @@ struct iio_channel *iio_channel_get_all(struct device=
 *dev)
>
>         /* NULL terminated array to save passing size */
>         chans =3D kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
> -       if (chans =3D=3D NULL) {
> +       if (!chans) {
>                 ret =3D -ENOMEM;
>                 goto error_ret;
>         }
> @@ -497,7 +496,7 @@ struct iio_channel *iio_channel_get_all(struct device=
 *dev)
>                 chans[mapind].channel =3D
>                         iio_chan_spec_from_name(chans[mapind].indio_dev,
>                                                 c->map->adc_channel_label=
);
> -               if (chans[mapind].channel =3D=3D NULL) {
> +               if (!chans[mapind].channel) {
>                         ret =3D -EINVAL;
>                         goto error_free_chans;
>                 }
> @@ -559,14 +558,14 @@ struct iio_channel *devm_iio_channel_get_all(struct=
 device *dev)
>  EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
>
>  static int iio_channel_read(struct iio_channel *chan, int *val, int *val=
2,
> -       enum iio_chan_info_enum info)
> +                           enum iio_chan_info_enum info)
>  {
>         int unused;
>         int vals[INDIO_MAX_RAW_ELEMENTS];
>         int ret;
>         int val_len =3D 2;
>
> -       if (val2 =3D=3D NULL)
> +       if (!val2)
>                 val2 =3D &unused;
>
>         if (!iio_channel_has_info(chan->channel, info))
> @@ -578,9 +577,10 @@ static int iio_channel_read(struct iio_channel *chan=
, int *val, int *val2,
>                                         vals, &val_len, info);
>                 *val =3D vals[0];
>                 *val2 =3D vals[1];
> -       } else
> +       } else {
>                 ret =3D chan->indio_dev->info->read_raw(chan->indio_dev,
>                                         chan->channel, val, val2, info);
> +       }
>
>         return ret;
>  }
> @@ -591,7 +591,7 @@ int iio_read_channel_raw(struct iio_channel *chan, in=
t *val)
>         int ret;
>
>         mutex_lock(&iio_dev_opaque->info_exist_lock);
> -       if (chan->indio_dev->info =3D=3D NULL) {
> +       if (!chan->indio_dev->info) {
>                 ret =3D -ENODEV;
>                 goto err_unlock;
>         }
> @@ -610,7 +610,7 @@ int iio_read_channel_average_raw(struct iio_channel *=
chan, int *val)
>         int ret;
>
>         mutex_lock(&iio_dev_opaque->info_exist_lock);
> -       if (chan->indio_dev->info =3D=3D NULL) {
> +       if (!chan->indio_dev->info) {
>                 ret =3D -ENODEV;
>                 goto err_unlock;
>         }
> @@ -624,7 +624,8 @@ int iio_read_channel_average_raw(struct iio_channel *=
chan, int *val)
>  EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
>
>  static int iio_convert_raw_to_processed_unlocked(struct iio_channel *cha=
n,
> -       int raw, int *processed, unsigned int scale)
> +                                                int raw, int *processed,
> +                                                unsigned int scale)
>  {
>         int scale_type, scale_val, scale_val2;
>         int offset_type, offset_val, offset_val2;
> @@ -657,7 +658,7 @@ static int iio_convert_raw_to_processed_unlocked(stru=
ct iio_channel *chan,
>         }
>
>         scale_type =3D iio_channel_read(chan, &scale_val, &scale_val2,
> -                                       IIO_CHAN_INFO_SCALE);
> +                                     IIO_CHAN_INFO_SCALE);
>         if (scale_type < 0) {
>                 /*
>                  * If no channel scaling is available apply consumer scal=
e to
> @@ -702,19 +703,19 @@ static int iio_convert_raw_to_processed_unlocked(st=
ruct iio_channel *chan,
>  }
>
>  int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
> -       int *processed, unsigned int scale)
> +                                int *processed, unsigned int scale)
>  {
>         struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(chan-=
>indio_dev);
>         int ret;
>
>         mutex_lock(&iio_dev_opaque->info_exist_lock);
> -       if (chan->indio_dev->info =3D=3D NULL) {
> +       if (!chan->indio_dev->info) {
>                 ret =3D -ENODEV;
>                 goto err_unlock;
>         }
>
>         ret =3D iio_convert_raw_to_processed_unlocked(chan, raw, processe=
d,
> -                                                       scale);
> +                                                   scale);
>  err_unlock:
>         mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
> @@ -729,7 +730,7 @@ int iio_read_channel_attribute(struct iio_channel *ch=
an, int *val, int *val2,
>         int ret;
>
>         mutex_lock(&iio_dev_opaque->info_exist_lock);
> -       if (chan->indio_dev->info =3D=3D NULL) {
> +       if (!chan->indio_dev->info) {
>                 ret =3D -ENODEV;
>                 goto err_unlock;
>         }
> @@ -755,7 +756,7 @@ int iio_read_channel_processed_scale(struct iio_chann=
el *chan, int *val,
>         int ret;
>
>         mutex_lock(&iio_dev_opaque->info_exist_lock);
> -       if (chan->indio_dev->info =3D=3D NULL) {
> +       if (!chan->indio_dev->info) {
>                 ret =3D -ENODEV;
>                 goto err_unlock;
>         }
> @@ -833,7 +834,7 @@ int iio_read_avail_channel_raw(struct iio_channel *ch=
an,
>         int type;
>
>         ret =3D iio_read_avail_channel_attribute(chan, vals, &type, lengt=
h,
> -                                        IIO_CHAN_INFO_RAW);
> +                                              IIO_CHAN_INFO_RAW);
>
>         if (ret >=3D 0 && type !=3D IIO_VAL_INT)
>                 /* raw values are assumed to be IIO_VAL_INT */
> @@ -917,7 +918,7 @@ int iio_get_channel_type(struct iio_channel *chan, en=
um iio_chan_type *type)
>         /* Need to verify underlying driver has not gone away */
>
>         mutex_lock(&iio_dev_opaque->info_exist_lock);
> -       if (chan->indio_dev->info =3D=3D NULL) {
> +       if (!chan->indio_dev->info) {
>                 ret =3D -ENODEV;
>                 goto err_unlock;
>         }
> @@ -944,7 +945,7 @@ int iio_write_channel_attribute(struct iio_channel *c=
han, int val, int val2,
>         int ret;
>
>         mutex_lock(&iio_dev_opaque->info_exist_lock);
> -       if (chan->indio_dev->info =3D=3D NULL) {
> +       if (!chan->indio_dev->info) {
>                 ret =3D -ENODEV;
>                 goto err_unlock;
>         }
> @@ -978,9 +979,8 @@ unsigned int iio_get_channel_ext_info_count(struct ii=
o_channel *chan)
>  }
>  EXPORT_SYMBOL_GPL(iio_get_channel_ext_info_count);
>
> -static const struct iio_chan_spec_ext_info *iio_lookup_ext_info(
> -                                               const struct iio_channel =
*chan,
> -                                               const char *attr)
> +static const struct iio_chan_spec_ext_info *
> +iio_lookup_ext_info(const struct iio_channel *chan, const char *attr)
>  {
>         const struct iio_chan_spec_ext_info *ext_info;
>
> --
> 2.37.1
>


--=20
With Best Regards,
Andy Shevchenko
