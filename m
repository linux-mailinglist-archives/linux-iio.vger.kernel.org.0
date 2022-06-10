Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE15546948
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 17:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbiFJPUU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 11:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiFJPUT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 11:20:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7A536B69;
        Fri, 10 Jun 2022 08:20:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i29so26618658lfp.3;
        Fri, 10 Jun 2022 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3VGwLHfvMVJaon3UPprtUELHfGAcZPNdQ7DflWhwmt0=;
        b=P/Ka9zWOeDu6HUDB0Eg/b1uUjfyBCHZlNz2JbsuAVzY37LsgbYZTlU9CP7WjeX0rgO
         0xyS8f7u8RwFeckIVBE12JZyfROcgHkGmdHWjq3uXB0xPL9MVdnUMZ1dMsIGoKXww8cX
         s+cPr285Fp5JSvbix+6hHIPAgxAXVtg88NGtRIu2Wfw1BcRga5f+Dknh3vOZZo4+TJvR
         OkK5oz8H7/UfEqyyPjAfvAjMl8/zzcW23X4tce2R7YBWcvAbjv5c9GMccgjJZWALa+dh
         Xu7hbfj38XRZxVh9ATWJk5v10wnbnP9Nls6Prg9YUhCELEOG7bY9KQ2piNthv71iveJH
         VFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3VGwLHfvMVJaon3UPprtUELHfGAcZPNdQ7DflWhwmt0=;
        b=y8lsYaRtKsjl5TKPn0nx1i9FyAVRJmlR7FcfctJNPBftWHN1g+8fn3dwey9hIn/HUD
         a1f05PKYm86aC0oRUK1J02plis9cjDR4h/BkYppSumAZLfV0N6kiBb0LLZ7fyEGnh/5X
         Qq3qkKA3NieKhnujHB41bjqRPxWmwAVYYA1qqDqlSaEGeI+KH0uymjkMvoXHBfnxRuSO
         wr7LBosmBWpI0ibynNln1VRZGMKVNdTLHnsX4pLmKM+YkxTv1G7O+f1G6ObrCh7YUl8J
         53pzLl+vzmJx+tyOJC9Y6r9jD0W+pO8zfhuHY3cYpKa/L0dtqcz+d9ym9K0WsT8cqMV5
         kfjw==
X-Gm-Message-State: AOAM530kp13VwHfQ2ywA7B0Z1HzWV6JAHuFf1tdjN08vsqwHs6yxH762
        7K/m5+769ETvXQY5FswPVDlbC5IcqtF4yXQD5Ug=
X-Google-Smtp-Source: ABdhPJywhZ2seelC5ikDyiprjiJZBSJkzhhjoe5lG2avatAtoJAI9PIkgcbzm57zOCR5jYl47QmB34X2BeJEKTlVBeE=
X-Received: by 2002:ac2:4c04:0:b0:479:6ee1:8992 with SMTP id
 t4-20020ac24c04000000b004796ee18992mr10144647lfq.35.1654874413690; Fri, 10
 Jun 2022 08:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084545.547700-1-nuno.sa@analog.com> <20220610084545.547700-25-nuno.sa@analog.com>
In-Reply-To: <20220610084545.547700-25-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 17:19:33 +0200
Message-ID: <CAHp75Vf6dYFR8TESk6oj=SFiXmw-tBAa9Fz-jhRk57ARumxzhA@mail.gmail.com>
Subject: Re: [PATCH 24/34] iio: inkern: move to fwnode properties
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        chrome-platform@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Benjamin Fair <benjaminfair@google.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Nancy Yuen <yuenn@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 10, 2022 at 10:48 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> This moves the IIO in kernel interface to use fwnode properties and thus
> be firmware agnostic.
>
> Note that the interface is still not firmware agnostic. At this point we
> have both OF and fwnode interfaces so that we don't break any user. On
> top of this we also want to have a per driver conversion and that is the
> main reason we have both of_xlate() and fwnode_xlate() support.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

A few nit-picks below, though.

> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/inkern.c         | 145 +++++++++++++++++++----------------
>  include/linux/iio/consumer.h |  36 +++++----
>  include/linux/iio/iio.h      |   5 ++
>  3 files changed, 105 insertions(+), 81 deletions(-)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index dde47324b826..1d519b0cacea 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/err.h>
>  #include <linux/export.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> @@ -117,15 +118,13 @@ static const struct iio_chan_spec
>         return chan;
>  }
>
> -#ifdef CONFIG_OF
> -
>  static int iio_dev_node_match(struct device *dev, const void *data)
>  {
> -       return dev->of_node =3D=3D data && dev->type =3D=3D &iio_device_t=
ype;
> +       return device_match_fwnode(dev, data) && dev->type =3D=3D &iio_de=
vice_type;
>  }
>
>  /**
> - * __of_iio_simple_xlate - translate iiospec to the IIO channel index
> + * __fwnode_iio_simple_xlate - translate iiospec to the IIO channel inde=
x
>   * @indio_dev: pointer to the iio_dev structure
>   * @iiospec:   IIO specifier as found in the device tree
>   *
> @@ -134,14 +133,14 @@ static int iio_dev_node_match(struct device *dev, c=
onst void *data)
>   * whether IIO index is less than num_channels (that is specified in the
>   * iio_dev).
>   */
> -static int __of_iio_simple_xlate(struct iio_dev *indio_dev,
> -                               const struct of_phandle_args *iiospec)
> +static int __fwnode_iio_simple_xlate(struct iio_dev *indio_dev,
> +                                    const struct fwnode_reference_args *=
iiospec)
>  {
> -       if (!iiospec->args_count)
> +       if (!iiospec->nargs)
>                 return 0;
>
>         if (iiospec->args[0] >=3D indio_dev->num_channels) {
> -               dev_err(&indio_dev->dev, "invalid channel index %u\n",
> +               dev_err(&indio_dev->dev, "invalid channel index %llu\n",
>                         iiospec->args[0]);
>                 return -EINVAL;
>         }
> @@ -149,34 +148,56 @@ static int __of_iio_simple_xlate(struct iio_dev *in=
dio_dev,
>         return iiospec->args[0];
>  }
>
> -static int __of_iio_channel_get(struct iio_channel *channel,
> -                               struct device_node *np, int index)
> +/*
> + * Simple helper to copy fwnode_reference_args into of_phandle_args so w=
e
> + * can pass it to of_xlate(). Ultimate goal is to drop this together wit=
h
> + * of_xlate().
> + */
> +static int __fwnode_to_of_xlate(struct iio_dev *indio_dev,
> +                               const struct fwnode_reference_args *iiosp=
ec)
> +{
> +       struct of_phandle_args of_args;
> +       unsigned int i;
> +
> +       of_args.args_count =3D iiospec->nargs;
> +       of_args.np =3D to_of_node(iiospec->fwnode);
> +
> +       for (i =3D 0; i < MAX_PHANDLE_ARGS; i++)
> +               of_args.args[i] =3D i < iiospec->nargs ? iiospec->args[i]=
 : 0;
> +
> +       return indio_dev->info->of_xlate(indio_dev, &of_args);
> +}

Ah, now I realized that it's a bit more complicated than just to_of_node() =
:-)

> +static int __fwnode_iio_channel_get(struct iio_channel *channel,
> +                                   struct fwnode_handle *fwnode, int ind=
ex)
>  {
>         struct device *idev;
>         struct iio_dev *indio_dev;
>         int err;
> -       struct of_phandle_args iiospec;
> +       struct fwnode_reference_args iiospec;

At the same point you can move it up in the block to make a long line first=
.

> -       err =3D of_parse_phandle_with_args(np, "io-channels",
> -                                        "#io-channel-cells",
> -                                        index, &iiospec);
> +       err =3D fwnode_property_get_reference_args(fwnode, "io-channels",
> +                                                "#io-channel-cells", 0,
> +                                                index, &iiospec);
>         if (err)
>                 return err;
>
> -       idev =3D bus_find_device(&iio_bus_type, NULL, iiospec.np,
> +       idev =3D bus_find_device(&iio_bus_type, NULL, iiospec.fwnode,
>                                iio_dev_node_match);

Wondering if this
https://elixir.bootlin.com/linux/v5.19-rc1/C/ident/bus_find_device_by_fwnod=
e
can be utilized (yes, I noticed iio_device_type above).

>         if (idev =3D=3D NULL) {
> -               of_node_put(iiospec.np);
> +               fwnode_handle_put(iiospec.fwnode);
>                 return -EPROBE_DEFER;
>         }
>
>         indio_dev =3D dev_to_iio_dev(idev);
>         channel->indio_dev =3D indio_dev;
>         if (indio_dev->info->of_xlate)
> -               index =3D indio_dev->info->of_xlate(indio_dev, &iiospec);
> +               index =3D __fwnode_to_of_xlate(indio_dev, &iiospec);
> +       else if (indio_dev->info->fwnode_xlate)
> +               index =3D indio_dev->info->fwnode_xlate(indio_dev, &iiosp=
ec);
>         else
> -               index =3D __of_iio_simple_xlate(indio_dev, &iiospec);
> -       of_node_put(iiospec.np);
> +               index =3D __fwnode_iio_simple_xlate(indio_dev, &iiospec);
> +       fwnode_handle_put(iiospec.fwnode);
>         if (index < 0)
>                 goto err_put;
>         channel->channel =3D &indio_dev->channels[index];
> @@ -188,7 +209,8 @@ static int __of_iio_channel_get(struct iio_channel *c=
hannel,
>         return index;
>  }
>
> -static struct iio_channel *of_iio_channel_get(struct device_node *np, in=
t index)
> +static struct iio_channel *fwnode_iio_channel_get(struct fwnode_handle *=
fwnode,
> +                                                 int index)
>  {
>         struct iio_channel *channel;
>         int err;
> @@ -200,7 +222,7 @@ static struct iio_channel *of_iio_channel_get(struct =
device_node *np, int index)
>         if (channel =3D=3D NULL)
>                 return ERR_PTR(-ENOMEM);
>
> -       err =3D __of_iio_channel_get(channel, np, index);
> +       err =3D __fwnode_iio_channel_get(channel, fwnode, index);
>         if (err)
>                 goto err_free_channel;
>
> @@ -211,9 +233,9 @@ static struct iio_channel *of_iio_channel_get(struct =
device_node *np, int index)
>         return ERR_PTR(err);
>  }
>
> -struct iio_channel *__of_iio_channel_get_by_name(struct device_node *np,
> -                                                const char *name,
> -                                                bool *parent_lookup)
> +struct iio_channel *
> +__fwnode_iio_channel_get_by_name(struct fwnode_handle *fwnode, const cha=
r *name,
> +                                bool *parent_lookup)
>  {
>         struct iio_channel *chan;
>         int index =3D 0;
> @@ -221,32 +243,34 @@ struct iio_channel *__of_iio_channel_get_by_name(st=
ruct device_node *np,
>         /*
>          * For named iio channels, first look up the name in the
>          * "io-channel-names" property.  If it cannot be found, the
> -        * index will be an error code, and of_iio_channel_get()
> +        * index will be an error code, and fwnode_iio_channel_get()
>          * will fail.
>          */
>         if (name)
> -               index =3D of_property_match_string(np, "io-channel-names"=
, name);
> +               index =3D fwnode_property_match_string(fwnode, "io-channe=
l-names",
> +                                                    name);
>
> -       chan =3D of_iio_channel_get(np, index);
> +       chan =3D fwnode_iio_channel_get(fwnode, index);
>         if (!IS_ERR(chan) || PTR_ERR(chan) =3D=3D -EPROBE_DEFER) {
>                 *parent_lookup =3D false;
>         } else if (name && index >=3D 0) {
> -               pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
> -                      np, name ? name : "", index);
> +               pr_err("ERROR: could not get IIO channel %pfw:%s(%i)\n",
> +                      fwnode, name ? name : "", index);

Since you are touching this line can you switch to name ?: "" and
possibly move some parameters to the above line?

>                 *parent_lookup =3D false;
>         }
>
>         return chan;
>  }
>
> -struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
> -                                              const char *name)
> +struct iio_channel *fwnode_iio_channel_get_by_name(struct fwnode_handle =
*fwnode,
> +                                                  const char *name)
>  {
>         struct iio_channel *chan;
> +       struct fwnode_handle *parent;
>         bool parent_lookup =3D true;
>
>         /* Walk up the tree of devices looking for a matching iio channel=
 */
> -       chan =3D __of_iio_channel_get_by_name(np, name, &parent_lookup);
> +       chan =3D __fwnode_iio_channel_get_by_name(fwnode, name, &parent_l=
ookup);
>         if (!parent_lookup)
>                 return chan;
>
> @@ -255,33 +279,34 @@ struct iio_channel *of_iio_channel_get_by_name(stru=
ct device_node *np,
>          * If the parent node has a "io-channel-ranges" property,
>          * then we can try one of its channels.
>          */
> -       np =3D np->parent;
> -       while (np) {
> -               if (!of_get_property(np, "io-channel-ranges", NULL))
> +       fwnode_for_each_parent_node(fwnode, parent) {
> +               if (!fwnode_property_present(parent, "io-channel-ranges")=
) {
> +                       fwnode_handle_put(parent);
>                         return chan;

break; ?

(Yes, I understand pros and cons of each variant, up to you)

> +               }
>
> -               chan =3D __of_iio_channel_get_by_name(np, name, &parent_l=
ookup);
> -               if (!parent_lookup)
> +               chan =3D __fwnode_iio_channel_get_by_name(parent, name, &=
parent_lookup);
> +               if (!parent_lookup) {
> +                       fwnode_handle_put(parent);
>                         return chan;

Ditto.

> -               np =3D np->parent;
> +               }
>         }
>
>         return chan;
>  }
> -EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name);
> +EXPORT_SYMBOL_GPL(fwnode_iio_channel_get_by_name);

Wondering if we may move this to the IIO namespace.

> -static struct iio_channel *of_iio_channel_get_all(struct device *dev)
> +static struct iio_channel *fwnode_iio_channel_get_all(struct device *dev=
)
>  {
> +       struct fwnode_handle *fwnode =3D dev_fwnode(dev);
>         struct iio_channel *chans;
>         int i, mapind, nummaps =3D 0;
>         int ret;
>
>         do {
> -               ret =3D of_parse_phandle_with_args(dev->of_node,
> -                                                "io-channels",
> -                                                "#io-channel-cells",
> -                                                nummaps, NULL);
> +               ret =3D fwnode_property_get_reference_args(fwnode, "io-ch=
annels",
> +                                                        "#io-channel-cel=
ls", 0,
> +                                                        nummaps, NULL);
>                 if (ret < 0)
>                         break;
>         } while (++nummaps);
> @@ -294,10 +319,9 @@ static struct iio_channel *of_iio_channel_get_all(st=
ruct device *dev)
>         if (chans =3D=3D NULL)
>                 return ERR_PTR(-ENOMEM);
>
> -       /* Search for OF matches */
> +       /* Search for FW matches */
>         for (mapind =3D 0; mapind < nummaps; mapind++) {
> -               ret =3D __of_iio_channel_get(&chans[mapind], dev->of_node=
,
> -                                          mapind);
> +               ret =3D __fwnode_iio_channel_get(&chans[mapind], fwnode, =
mapind);
>                 if (ret)
>                         goto error_free_chans;
>         }
> @@ -310,15 +334,6 @@ static struct iio_channel *of_iio_channel_get_all(st=
ruct device *dev)
>         return ERR_PTR(ret);
>  }
>
> -#else /* CONFIG_OF */
> -
> -static inline struct iio_channel *of_iio_channel_get_all(struct device *=
dev)
> -{
> -       return ERR_PTR(-ENODEV);
> -}
> -
> -#endif /* CONFIG_OF */
> -
>  static struct iio_channel *iio_channel_get_sys(const char *name,
>                                                const char *channel_name)
>  {
> @@ -379,8 +394,8 @@ struct iio_channel *iio_channel_get(struct device *de=
v,
>         struct iio_channel *channel;
>
>         if (dev) {
> -               channel =3D of_iio_channel_get_by_name(dev->of_node,
> -                                                    channel_name);
> +               channel =3D fwnode_iio_channel_get_by_name(dev_fwnode(dev=
),
> +                                                        channel_name);
>                 if (!IS_ERR(channel) || PTR_ERR(channel) =3D=3D -EPROBE_D=
EFER)
>                         return channel;
>         }
> @@ -421,14 +436,14 @@ struct iio_channel *devm_iio_channel_get(struct dev=
ice *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_channel_get);
>
> -struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
> -                                                   struct device_node *n=
p,
> -                                                   const char *channel_n=
ame)
> +struct iio_channel *devm_fwnode_iio_channel_get_by_name(struct device *d=
ev,
> +                                                       struct fwnode_han=
dle *fwnode,
> +                                                       const char *chann=
el_name)
>  {
>         struct iio_channel *channel;
>         int ret;
>
> -       channel =3D of_iio_channel_get_by_name(np, channel_name);
> +       channel =3D fwnode_iio_channel_get_by_name(fwnode, channel_name);
>         if (IS_ERR(channel))
>                 return channel;
>
> @@ -438,7 +453,7 @@ struct iio_channel *devm_of_iio_channel_get_by_name(s=
truct device *dev,
>
>         return channel;
>  }
> -EXPORT_SYMBOL_GPL(devm_of_iio_channel_get_by_name);
> +EXPORT_SYMBOL_GPL(devm_fwnode_iio_channel_get_by_name);
>
>  struct iio_channel *iio_channel_get_all(struct device *dev)
>  {
> @@ -452,7 +467,7 @@ struct iio_channel *iio_channel_get_all(struct device=
 *dev)
>         if (dev =3D=3D NULL)
>                 return ERR_PTR(-EINVAL);
>
> -       chans =3D of_iio_channel_get_all(dev);
> +       chans =3D fwnode_iio_channel_get_all(dev);
>         if (!IS_ERR(chans) || PTR_ERR(chans) =3D=3D -EPROBE_DEFER)
>                 return chans;
>
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 5fa5957586cf..a96a714b5fdc 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -9,11 +9,13 @@
>
>  #include <linux/types.h>
>  #include <linux/iio/types.h>

> +#include <linux/of.h>

Ordering. IIO has special meaning here, that's why it's last.

>  struct iio_dev;
>  struct iio_chan_spec;
>  struct device;
>  struct device_node;
> +struct fwnode_handle;
>
>  /**
>   * struct iio_channel - everything needed for a consumer to use a channe=
l
> @@ -99,26 +101,20 @@ void iio_channel_release_all(struct iio_channel *cha=
n);
>  struct iio_channel *devm_iio_channel_get_all(struct device *dev);
>
>  /**
> - * of_iio_channel_get_by_name() - get description of all that is needed =
to access channel.
> - * @np:                        Pointer to consumer device tree node
> + * fwnode_iio_channel_get_by_name() - get description of all that is nee=
ded to access channel.
> + * @fwnode:            Pointer to consumer Firmware node
>   * @consumer_channel:  Unique name to identify the channel on the consum=
er
>   *                     side. This typically describes the channels use w=
ithin
>   *                     the consumer. E.g. 'battery_voltage'
>   */
> -#ifdef CONFIG_OF
> -struct iio_channel *of_iio_channel_get_by_name(struct device_node *np, c=
onst char *name);
> -#else
> -static inline struct iio_channel *
> -of_iio_channel_get_by_name(struct device_node *np, const char *name)
> -{
> -       return NULL;
> -}
> -#endif
> +struct iio_channel *fwnode_iio_channel_get_by_name(struct fwnode_handle =
*fwnode,
> +                                                  const char *name);
>
>  /**
> - * devm_of_iio_channel_get_by_name() - Resource managed version of of_ii=
o_channel_get_by_name().
> + * devm_fwnode_iio_channel_get_by_name() - Resource managed version of
> + *                                        fwnode_iio_channel_get_by_name=
().
>   * @dev:               Pointer to consumer device.
> - * @np:                        Pointer to consumer device tree node
> + * @fwnode:            Pointer to consumer Firmware node
>   * @consumer_channel:  Unique name to identify the channel on the consum=
er
>   *                     side. This typically describes the channels use w=
ithin
>   *                     the consumer. E.g. 'battery_voltage'
> @@ -129,9 +125,17 @@ of_iio_channel_get_by_name(struct device_node *np, c=
onst char *name)
>   * The allocated iio channel is automatically released when the device i=
s
>   * unbound.
>   */
> -struct iio_channel *devm_of_iio_channel_get_by_name(struct device *dev,
> -                                                   struct device_node *n=
p,
> -                                                   const char *consumer_=
channel);
> +struct iio_channel *devm_fwnode_iio_channel_get_by_name(struct device *d=
ev,
> +                                                       struct fwnode_han=
dle *fwnode,
> +                                                       const char *consu=
mer_channel);
> +
> +static inline struct iio_channel
> +*devm_of_iio_channel_get_by_name(struct device *dev, struct device_node =
*np,
> +                                const char *consumer_channel)
> +{
> +       return devm_fwnode_iio_channel_get_by_name(dev, of_fwnode_handle(=
np),
> +                                                  consumer_channel);
> +}
>
>  struct iio_cb_buffer;
>  /**
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index d9b4a9ca9a0f..494abb63406e 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -18,6 +18,7 @@
>   */
>
>  struct of_phandle_args;
> +struct fwnode_reference_args;
>
>  enum iio_shared_by {
>         IIO_SEPARATE,
> @@ -429,6 +430,8 @@ struct iio_trigger; /* forward declaration */
>   *                     provide a custom of_xlate function that reads the
>   *                     *args* and returns the appropriate index in regis=
tered
>   *                     IIO channels array.
> + * @fwnode_xlate:      fwnode based function pointer to obtain channel s=
pecifier index.
> + *                     Functionally the same as @of_xlate.
>   * @hwfifo_set_watermark: function pointer to set the current hardware
>   *                     fifo watermark level; see hwfifo_* entries in
>   *                     Documentation/ABI/testing/sysfs-bus-iio for detai=
ls on
> @@ -510,6 +513,8 @@ struct iio_info {
>                                   unsigned *readval);
>         int (*of_xlate)(struct iio_dev *indio_dev,
>                         const struct of_phandle_args *iiospec);
> +       int (*fwnode_xlate)(struct iio_dev *indio_dev,
> +                           const struct fwnode_reference_args *iiospec);
>         int (*hwfifo_set_watermark)(struct iio_dev *indio_dev, unsigned v=
al);
>         int (*hwfifo_flush_to_buffer)(struct iio_dev *indio_dev,
>                                       unsigned count);

--=20
With Best Regards,
Andy Shevchenko
