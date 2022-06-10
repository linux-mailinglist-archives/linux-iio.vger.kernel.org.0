Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4A5546DE7
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 22:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347281AbiFJUBR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 16:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiFJUBQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 16:01:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED503F5D;
        Fri, 10 Jun 2022 13:01:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n185so12014wmn.4;
        Fri, 10 Jun 2022 13:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=2YSKLRduvMh8Ck87NHw9tHP5D4LoKiAtBQhGBpQbX8A=;
        b=gR/G++1jfOEzvcHno81WYhGhDWujpMOrzQlWbw/Zh0c4i+KvoB9JLQId+negoXp1Sz
         aE9pnEjstwJwLA+hUxghqK35hRoOz62QkKF3gPxwQJ60YGwM5CxqUnt1LDlocalf80LM
         Lt/8BGddQB/CE21IkndMVeeGO3iH/lidVOjbX4poHomqAlHJ4nH3NxqUTdDBddZfDhCC
         SlXmbuGQDroEt9jmN0YFLC+p03mrdwZkyN6nxyTJ9h2uatv+H0aGATDgtomzZF32cEBO
         VOokeMPK16kt8DgGexcZvcyj7N0HXeDMWjw8ktki3yHnomdbYiXQeByD1BFfHepypTzz
         qrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2YSKLRduvMh8Ck87NHw9tHP5D4LoKiAtBQhGBpQbX8A=;
        b=XOtTgSPxrCao0vcnDMG/eHLOOb+EeoF4O2UQp3Nxg7EPoAeJBo2JGQafy8tkF86Ovy
         OLXPmGA0Y2DNlD+/763gs+iABhul9pxjjpfPLs3uXZ/GcgEtZxx3e/CfHC6Yb2k/r54m
         cc/S55n/ZV24Z0F6dw+VQPL9j3tRfM0n6rn8Qt0mL/xIrs8i3TscYbI8CU5wdvubP+9m
         jnS9b0rJbqbd0ya+8MQdvz4ecvB1X9IV3Msw03o1YHRi1lm3MXbJ0I6dXUlPjQszBNYJ
         3CrTJNmooO+z4Q3QhdkcmgcQQsjfK4lv6ym5yOCO3tmJy9X5lFYJLy8Xs0ckp6Z2jXqB
         mM+w==
X-Gm-Message-State: AOAM530izxWhBq8McyA6m/h7/qPLXE3tK6/k3AZVtiXudIIgGyIoabH2
        VDVQqDIhcB+mk1QjdFNMaoI=
X-Google-Smtp-Source: ABdhPJzrLLwHku4oE77pzyt+7olow27HPFl66zU7rgD6BG8IagfgMHfQBTHa/t06C9XmSrKuzPqjlQ==
X-Received: by 2002:a05:600c:2105:b0:39c:381c:1e13 with SMTP id u5-20020a05600c210500b0039c381c1e13mr1303579wml.189.1654891272383;
        Fri, 10 Jun 2022 13:01:12 -0700 (PDT)
Received: from ?IPv6:2001:a61:136e:3c01:8bd4:cf6f:76f1:a861? ([2001:a61:136e:3c01:8bd4:cf6f:76f1:a861])
        by smtp.gmail.com with ESMTPSA id a4-20020adff7c4000000b0021033caa332sm338933wrq.42.2022.06.10.13.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 13:01:11 -0700 (PDT)
Message-ID: <97b9278953d923008a4c1230ca9bd354117e7213.camel@gmail.com>
Subject: Re: [PATCH 24/34] iio: inkern: move to fwnode properties
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
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
Date:   Fri, 10 Jun 2022 22:01:09 +0200
In-Reply-To: <CAHp75Vf6dYFR8TESk6oj=SFiXmw-tBAa9Fz-jhRk57ARumxzhA@mail.gmail.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
         <20220610084545.547700-25-nuno.sa@analog.com>
         <CAHp75Vf6dYFR8TESk6oj=SFiXmw-tBAa9Fz-jhRk57ARumxzhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2022-06-10 at 17:19 +0200, Andy Shevchenko wrote:
> On Fri, Jun 10, 2022 at 10:48 AM Nuno Sá <nuno.sa@analog.com> wrote:
> > 
> > This moves the IIO in kernel interface to use fwnode properties and
> > thus
> > be firmware agnostic.
> > 
> > Note that the interface is still not firmware agnostic. At this
> > point we
> > have both OF and fwnode interfaces so that we don't break any user.
> > On
> > top of this we also want to have a per driver conversion and that
> > is the
> > main reason we have both of_xlate() and fwnode_xlate() support.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Thanks!
> 
> A few nit-picks below, though.
> 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  drivers/iio/inkern.c         | 145 +++++++++++++++++++------------
> > ----
> >  include/linux/iio/consumer.h |  36 +++++----
> >  include/linux/iio/iio.h      |   5 ++
> >  3 files changed, 105 insertions(+), 81 deletions(-)
> > 
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index dde47324b826..1d519b0cacea 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -5,6 +5,7 @@
> >   */
> >  #include <linux/err.h>
> >  #include <linux/export.h>
> > +#include <linux/property.h>
> >  #include <linux/slab.h>
> >  #include <linux/mutex.h>
> >  #include <linux/of.h>
> > @@ -117,15 +118,13 @@ static const struct iio_chan_spec
> >         return chan;
> >  }
> > 
> > -#ifdef CONFIG_OF
> > -
> >  static int iio_dev_node_match(struct device *dev, const void
> > *data)
> >  {
> > -       return dev->of_node == data && dev->type ==
> > &iio_device_type;
> > +       return device_match_fwnode(dev, data) && dev->type ==
> > &iio_device_type;
> >  }
> > 
> >  /**
> > - * __of_iio_simple_xlate - translate iiospec to the IIO channel
> > index
> > + * __fwnode_iio_simple_xlate - translate iiospec to the IIO
> > channel index
> >   * @indio_dev: pointer to the iio_dev structure
> >   * @iiospec:   IIO specifier as found in the device tree
> >   *
> > @@ -134,14 +133,14 @@ static int iio_dev_node_match(struct device
> > *dev, const void *data)
> >   * whether IIO index is less than num_channels (that is specified
> > in the
> >   * iio_dev).
> >   */
> > -static int __of_iio_simple_xlate(struct iio_dev *indio_dev,
> > -                               const struct of_phandle_args
> > *iiospec)
> > +static int __fwnode_iio_simple_xlate(struct iio_dev *indio_dev,
> > +                                    const struct
> > fwnode_reference_args *iiospec)
> >  {
> > -       if (!iiospec->args_count)
> > +       if (!iiospec->nargs)
> >                 return 0;
> > 
> >         if (iiospec->args[0] >= indio_dev->num_channels) {
> > -               dev_err(&indio_dev->dev, "invalid channel index
> > %u\n",
> > +               dev_err(&indio_dev->dev, "invalid channel index
> > %llu\n",
> >                         iiospec->args[0]);
> >                 return -EINVAL;
> >         }
> > @@ -149,34 +148,56 @@ static int __of_iio_simple_xlate(struct
> > iio_dev *indio_dev,
> >         return iiospec->args[0];
> >  }
> > 
> > -static int __of_iio_channel_get(struct iio_channel *channel,
> > -                               struct device_node *np, int index)
> > +/*
> > + * Simple helper to copy fwnode_reference_args into
> > of_phandle_args so we
> > + * can pass it to of_xlate(). Ultimate goal is to drop this
> > together with
> > + * of_xlate().
> > + */
> > +static int __fwnode_to_of_xlate(struct iio_dev *indio_dev,
> > +                               const struct fwnode_reference_args
> > *iiospec)
> > +{
> > +       struct of_phandle_args of_args;
> > +       unsigned int i;
> > +
> > +       of_args.args_count = iiospec->nargs;
> > +       of_args.np = to_of_node(iiospec->fwnode);
> > +
> > +       for (i = 0; i < MAX_PHANDLE_ARGS; i++)
> > +               of_args.args[i] = i < iiospec->nargs ? iiospec-
> > >args[i] : 0;
> > +
> > +       return indio_dev->info->of_xlate(indio_dev, &of_args);
> > +}
> 
> Ah, now I realized that it's a bit more complicated than just
> to_of_node() :-)
> 

Yeah, of_fwnode_get_reference_args() was helpfull. But I based myself
too much on it. On a second look, I guess ARRAY_SIZE(of_args.args)
would be better than MAX_PHANDLE_ARGS.

> > +static int __fwnode_iio_channel_get(struct iio_channel *channel,
> > +                                   struct fwnode_handle *fwnode,
> > int index)
> >  {
> >         struct device *idev;
> >         struct iio_dev *indio_dev;
> >         int err;
> > -       struct of_phandle_args iiospec;
> > +       struct fwnode_reference_args iiospec;
> 
> At the same point you can move it up in the block to make a long line
> first.

Can do that...

> 
> > -       err = of_parse_phandle_with_args(np, "io-channels",
> > -                                        "#io-channel-cells",
> > -                                        index, &iiospec);
> > +       err = fwnode_property_get_reference_args(fwnode, "io-
> > channels",
> > +                                                "#io-channel-
> > cells", 0,
> > +                                                index, &iiospec);
> >         if (err)
> >                 return err;
> > 
> > -       idev = bus_find_device(&iio_bus_type, NULL, iiospec.np,
> > +       idev = bus_find_device(&iio_bus_type, NULL, iiospec.fwnode,
> >                                iio_dev_node_match);
> 
> Wondering if this
> https://elixir.bootlin.com/linux/v5.19-rc1/C/ident/bus_find_device_by_fwnode
> can be utilized (yes, I noticed iio_device_type above).

Hmm, at first glance I would say we can use it. AFAICT, we are already
grabbing a node which contains "#io-channel-cells" which is very
indicative that is an IIO device. I also find it very unlikely to have
two IIO devices with the same fwnode (I guess it would be an issue even
in the old code) and even more unlikely two devices of diferent types
with the same fwnode?

Anyways, I guess Jonathan can help in here...


> 
> >         if (idev == NULL) {
> > -               of_node_put(iiospec.np);
> > +               fwnode_handle_put(iiospec.fwnode);
> >                 return -EPROBE_DEFER;
> >         }
> > 
> >         indio_dev = dev_to_iio_dev(idev);
> >         channel->indio_dev = indio_dev;
> >         if (indio_dev->info->of_xlate)
> > -               index = indio_dev->info->of_xlate(indio_dev,
> > &iiospec);
> > +               index = __fwnode_to_of_xlate(indio_dev, &iiospec);
> > +       else if (indio_dev->info->fwnode_xlate)
> > +               index = indio_dev->info->fwnode_xlate(indio_dev,
> > &iiospec);
> >         else
> > -               index = __of_iio_simple_xlate(indio_dev, &iiospec);
> > -       of_node_put(iiospec.np);
> > +               index = __fwnode_iio_simple_xlate(indio_dev,
> > &iiospec);
> > +       fwnode_handle_put(iiospec.fwnode);
> >         if (index < 0)
> >                 goto err_put;
> >         channel->channel = &indio_dev->channels[index];
> > @@ -188,7 +209,8 @@ static int __of_iio_channel_get(struct
> > iio_channel *channel,
> >         return index;
> >  }
> > 
> > -static struct iio_channel *of_iio_channel_get(struct device_node
> > *np, int index)
> > +static struct iio_channel *fwnode_iio_channel_get(struct
> > fwnode_handle *fwnode,
> > +                                                 int index)
> >  {
> >         struct iio_channel *channel;
> >         int err;
> > @@ -200,7 +222,7 @@ static struct iio_channel
> > *of_iio_channel_get(struct device_node *np, int index)
> >         if (channel == NULL)
> >                 return ERR_PTR(-ENOMEM);
> > 
> > -       err = __of_iio_channel_get(channel, np, index);
> > +       err = __fwnode_iio_channel_get(channel, fwnode, index);
> >         if (err)
> >                 goto err_free_channel;
> > 
> > @@ -211,9 +233,9 @@ static struct iio_channel
> > *of_iio_channel_get(struct device_node *np, int index)
> >         return ERR_PTR(err);
> >  }
> > 
> > -struct iio_channel *__of_iio_channel_get_by_name(struct
> > device_node *np,
> > -                                                const char *name,
> > -                                                bool
> > *parent_lookup)
> > +struct iio_channel *
> > +__fwnode_iio_channel_get_by_name(struct fwnode_handle *fwnode,
> > const char *name,
> > +                                bool *parent_lookup)
> >  {
> >         struct iio_channel *chan;
> >         int index = 0;
> > @@ -221,32 +243,34 @@ struct iio_channel
> > *__of_iio_channel_get_by_name(struct device_node *np,
> >         /*
> >          * For named iio channels, first look up the name in the
> >          * "io-channel-names" property.  If it cannot be found, the
> > -        * index will be an error code, and of_iio_channel_get()
> > +        * index will be an error code, and
> > fwnode_iio_channel_get()
> >          * will fail.
> >          */
> >         if (name)
> > -               index = of_property_match_string(np, "io-channel-
> > names", name);
> > +               index = fwnode_property_match_string(fwnode, "io-
> > channel-names",
> > +                                                    name);
> > 
> > -       chan = of_iio_channel_get(np, index);
> > +       chan = fwnode_iio_channel_get(fwnode, index);
> >         if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER) {
> >                 *parent_lookup = false;
> >         } else if (name && index >= 0) {
> > -               pr_err("ERROR: could not get IIO channel
> > %pOF:%s(%i)\n",
> > -                      np, name ? name : "", index);
> > +               pr_err("ERROR: could not get IIO channel
> > %pfw:%s(%i)\n",
> > +                      fwnode, name ? name : "", index);
> 
> Since you are touching this line can you switch to name ?: "" and
> possibly move some parameters to the above line?

If it does not cross the 80limit col, sure. 
> 
> >                 *parent_lookup = false;
> >         }
> > 
> >         return chan;
> >  }
> > 
> > -struct iio_channel *of_iio_channel_get_by_name(struct device_node
> > *np,
> > -                                              const char *name)
> > +struct iio_channel *fwnode_iio_channel_get_by_name(struct
> > fwnode_handle *fwnode,
> > +                                                  const char
> > *name)
> >  {
> >         struct iio_channel *chan;
> > +       struct fwnode_handle *parent;
> >         bool parent_lookup = true;
> > 
> >         /* Walk up the tree of devices looking for a matching iio
> > channel */
> > -       chan = __of_iio_channel_get_by_name(np, name,
> > &parent_lookup);
> > +       chan = __fwnode_iio_channel_get_by_name(fwnode, name,
> > &parent_lookup);
> >         if (!parent_lookup)
> >                 return chan;
> > 
> > @@ -255,33 +279,34 @@ struct iio_channel
> > *of_iio_channel_get_by_name(struct device_node *np,
> >          * If the parent node has a "io-channel-ranges" property,
> >          * then we can try one of its channels.
> >          */
> > -       np = np->parent;
> > -       while (np) {
> > -               if (!of_get_property(np, "io-channel-ranges",
> > NULL))
> > +       fwnode_for_each_parent_node(fwnode, parent) {
> > +               if (!fwnode_property_present(parent, "io-channel-
> > ranges")) {
> > +                       fwnode_handle_put(parent);
> >                         return chan;
> 
> break; ?

The return in place was a request from Jonathan in the RFC...

> 
> (Yes, I understand pros and cons of each variant, up to you)
> 
> > +               }
> > 
> > -               chan = __of_iio_channel_get_by_name(np, name,
> > &parent_lookup);
> > -               if (!parent_lookup)
> > +               chan = __fwnode_iio_channel_get_by_name(parent,
> > name, &parent_lookup);
> > +               if (!parent_lookup) {
> > +                       fwnode_handle_put(parent);
> >                         return chan;
> 
> Ditto.
> 
> > -               np = np->parent;
> > +               }
> >         }
> > 
> >         return chan;
> >  }
> > -EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name);
> > +EXPORT_SYMBOL_GPL(fwnode_iio_channel_get_by_name);
> 
> Wondering if we may move this to the IIO namespace.

I guess it makes sense but surely on a different patch...

> 
> > -static struct iio_channel *of_iio_channel_get_all(struct device
> > *dev)
> > +static struct iio_channel *fwnode_iio_channel_get_all(struct
> > device *dev)
> >  {
> > +       struct fwnode_handle *fwnode = dev_fwnode(dev);
> >         struct iio_channel *chans;
> >         int i, mapind, nummaps = 0;
> >         int ret;
> > 
> >         do {
> > -               ret = of_parse_phandle_with_args(dev->of_node,
> > -                                                "io-channels",
> > -                                                "#io-channel-
> > cells",
> > -                                                nummaps, NULL);
> > +               ret = fwnode_property_get_reference_args(fwnode,
> > "io-channels",
> > +                                                        "#io-
> > channel-cells", 0,
> > +                                                        nummaps,
> > NULL);
> >                 if (ret < 0)
> >                         break;
> >         } while (++nummaps);
> > @@ -294,10 +319,9 @@ static struct iio_channel
> > *of_iio_channel_get_all(struct device *dev)
> >         if (chans == NULL)
> >                 return ERR_PTR(-ENOMEM);
> > 
> > -       /* Search for OF matches */
> > +       /* Search for FW matches */
> >         for (mapind = 0; mapind < nummaps; mapind++) {
> > -               ret = __of_iio_channel_get(&chans[mapind], dev-
> > >of_node,
> > -                                          mapind);
> > +               ret = __fwnode_iio_channel_get(&chans[mapind],
> > fwnode, mapind);
> >                 if (ret)
> >                         goto error_free_chans;
> >         }
> > @@ -310,15 +334,6 @@ static struct iio_channel
> > *of_iio_channel_get_all(struct device *dev)
> >         return ERR_PTR(ret);
> >  }
> > 
> > -#else /* CONFIG_OF */
> > -
> > -static inline struct iio_channel *of_iio_channel_get_all(struct
> > device *dev)
> > -{
> > -       return ERR_PTR(-ENODEV);
> > -}
> > -
> > -#endif /* CONFIG_OF */
> > -
> >  static struct iio_channel *iio_channel_get_sys(const char *name,
> >                                                const char
> > *channel_name)
> >  {
> > @@ -379,8 +394,8 @@ struct iio_channel *iio_channel_get(struct
> > device *dev,
> >         struct iio_channel *channel;
> > 
> >         if (dev) {
> > -               channel = of_iio_channel_get_by_name(dev->of_node,
> > -                                                    channel_name);
> > +               channel =
> > fwnode_iio_channel_get_by_name(dev_fwnode(dev),
> > +                                                       
> > channel_name);
> >                 if (!IS_ERR(channel) || PTR_ERR(channel) == -
> > EPROBE_DEFER)
> >                         return channel;
> >         }
> > @@ -421,14 +436,14 @@ struct iio_channel
> > *devm_iio_channel_get(struct device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_iio_channel_get);
> > 
> > -struct iio_channel *devm_of_iio_channel_get_by_name(struct device
> > *dev,
> > -                                                   struct
> > device_node *np,
> > -                                                   const char
> > *channel_name)
> > +struct iio_channel *devm_fwnode_iio_channel_get_by_name(struct
> > device *dev,
> > +                                                       struct
> > fwnode_handle *fwnode,
> > +                                                       const char
> > *channel_name)
> >  {
> >         struct iio_channel *channel;
> >         int ret;
> > 
> > -       channel = of_iio_channel_get_by_name(np, channel_name);
> > +       channel = fwnode_iio_channel_get_by_name(fwnode,
> > channel_name);
> >         if (IS_ERR(channel))
> >                 return channel;
> > 
> > @@ -438,7 +453,7 @@ struct iio_channel
> > *devm_of_iio_channel_get_by_name(struct device *dev,
> > 
> >         return channel;
> >  }
> > -EXPORT_SYMBOL_GPL(devm_of_iio_channel_get_by_name);
> > +EXPORT_SYMBOL_GPL(devm_fwnode_iio_channel_get_by_name);
> > 
> >  struct iio_channel *iio_channel_get_all(struct device *dev)
> >  {
> > @@ -452,7 +467,7 @@ struct iio_channel *iio_channel_get_all(struct
> > device *dev)
> >         if (dev == NULL)
> >                 return ERR_PTR(-EINVAL);
> > 
> > -       chans = of_iio_channel_get_all(dev);
> > +       chans = fwnode_iio_channel_get_all(dev);
> >         if (!IS_ERR(chans) || PTR_ERR(chans) == -EPROBE_DEFER)
> >                 return chans;
> > 
> > diff --git a/include/linux/iio/consumer.h
> > b/include/linux/iio/consumer.h
> > index 5fa5957586cf..a96a714b5fdc 100644
> > --- a/include/linux/iio/consumer.h
> > +++ b/include/linux/iio/consumer.h
> > @@ -9,11 +9,13 @@
> > 
> >  #include <linux/types.h>
> >  #include <linux/iio/types.h>
> 
> > +#include <linux/of.h>
> 
> Ordering. IIO has special meaning here, that's why it's last.

ok...

- Nuno Sá


