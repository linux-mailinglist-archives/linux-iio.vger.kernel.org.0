Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65158B74E
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiHFRfD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiHFRfC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 13:35:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C452D8;
        Sat,  6 Aug 2022 10:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E4608CE010D;
        Sat,  6 Aug 2022 17:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2D9C433C1;
        Sat,  6 Aug 2022 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659807297;
        bh=9V47ZcJgmG3gxd6TEyTt7TnP9+dBJRDESW0GnB21IA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a5tQcy+DFx7uHdSBRZBe8UBYx8KBXqwzs/nW7D4FRgNkM8Q2+IRwkC5jBNJGnodVU
         /pktq2S6mhhiDE3BaPMJAcUwJJFPCoPEUZnD3tV8cUalTyOfigbqEpZ1mX/jOpO/kN
         KBejr9O/cI4JZSmGYMbb7V82Q+3vIulT7QlTNblzsJEn8uxBcFMv3qH95InXcB2fpO
         4t3Lpbqm2UzZtcnYr2PAchvHTmy4CkcopHS8xQZAiIl/wmE221mjHJCYCHbznTGDEV
         AF5NBgsQlOJ75mJsseG/ctSCNqmKQ2kUjay4hRBaN1uWrrjLn9nHxK0n+p65HQQx6v
         Kam7rqGtXsT+A==
Date:   Sat, 6 Aug 2022 18:45:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <openbmc@lists.ozlabs.org>, <linux-imx@nxp.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-iio@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-arm-msm@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH v3 03/15] iio: inkern: only return error codes in
 iio_channel_get_*() APIs
Message-ID: <20220806184504.58960bd0@jic23-huawei>
In-Reply-To: <20220715122903.332535-4-nuno.sa@analog.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
        <20220715122903.332535-4-nuno.sa@analog.com>
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

On Fri, 15 Jul 2022 14:28:51 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> APIs like of_iio_channel_get_by_name() and of_iio_channel_get_all() were
> returning a mix of NULL and pointers with NULL being the way to
> "notify" that we should do a "system" lookup for channels. This make
> it very confusing and prone to errors as commit 9f63cc0921ec
> ("iio: inkern: fix return value in devm_of_iio_channel_get_by_name()")
> proves. On top of this, patterns like 'if (channel !=3D NULL) return
> channel' were being used where channel could actually be an error code
> which makes the code hard to read.
>=20
> This change also makes some functional changes on how errors were being
> handled. In the original behavior, even if we get an error like '-ENOMEM',
> we still continue with the search. We should only continue to lookup for
> the channel when it makes sense to do so. Hence, the main error handling
> in 'of_iio_channel_get_by_name()' is changed to the following logic:
>=20
>  * If a channel 'name' is provided and we do find it via
> 'io-channel-names', we should be able to get it. If we get any error,
> we should not proceed with the lookup. Moreover, we should return an error
> so that callers won't proceed with a system lookup.
>  * If a channel 'name' is provided and we cannot find it ('index < 0'),
> 'of_parse_phandle_with_args()' is expected to fail with '-EINVAL'. Hence,
> we should only continue if we get that error.
>  * If a channel 'name' is not provided we should only carry on with the
> search if 'of_parse_phandle_with_args()' returns '-ENOENT'.
>=20
> Also note that a system channel lookup is only done if the returned
> error code (from 'of_iio_channel_get_by_name()' or
> 'of_iio_channel_get_all()' is -ENODEV.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Hi Nuno,

Sorry for delay on getting to this.  Sometimes the most useful work
on the core gets queued up at the back of my review queue because it's hard=
er
than the average driver :)

Anyhow, only totally trivial stuff in here from me.
If you don't respin because of other comments, I can clean these up
whilst applying.

Thanks,

Jonathan

> ---
>  drivers/iio/inkern.c | 54 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 38 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 87fd2a0d44f2..c6f1cfe09bd3 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -214,7 +214,7 @@ static struct iio_channel *of_iio_channel_get(struct =
device_node *np, int index)
>  struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
>  					       const char *name)
>  {
> -	struct iio_channel *chan =3D NULL;
> +	struct iio_channel *chan;
> =20
>  	/* Walk up the tree of devices looking for a matching iio channel */
>  	while (np) {
> @@ -231,13 +231,33 @@ struct iio_channel *of_iio_channel_get_by_name(stru=
ct device_node *np,
>  							 name);
>  		chan =3D of_iio_channel_get(np, index);
>  		if (!IS_ERR(chan) || PTR_ERR(chan) =3D=3D -EPROBE_DEFER)
> -			break;
> -		else if (name && index >=3D 0) {
> -			pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
> -				np, name ? name : "", index);
> -			return NULL;
> +			return chan;
> +		if (name) {
> +			if (index >=3D 0) {
> +				pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
> +				       np, name, index);
> +				/*
> +				 * In this case, we found 'name' in 'io-channel-names'
> +				 * but somehow we still fail so that we should not proceed
> +				 * with any other lookup. Hence, explicitly return -EINVAL
> +				 * (maybe not the better error code) so that the caller
> +				 * won't do a system lookup.
> +				 */
> +				return ERR_PTR(-EINVAL);
> +			}

Trivial, but wrong comment syntax for IIO + inconsistent with surrounding c=
omments.

> +			/* If index < 0, then of_parse_phandle_with_args() fails
> +			 * with -EINVAL which is expected. We should not proceed
> +			 * if we get any other error.
> +			 */
> +			if (PTR_ERR(chan) !=3D -EINVAL)
> +				return chan;
> +		} else if (PTR_ERR(chan) !=3D -ENOENT) {
> +			/*
> +			 * if !name, then we should only proceed the lookup if
> +			 * of_parse_phandle_with_args() returns -ENOENT.
> +			 */
> +			return chan;
>  		}
> -

Try to avoid noise like this + I like this whitespace :)

>  		/*
>  		 * No matching IIO channel found on this node.
>  		 * If the parent node has a "io-channel-ranges" property,
> @@ -245,10 +265,10 @@ struct iio_channel *of_iio_channel_get_by_name(stru=
ct device_node *np,
>  		 */
>  		np =3D np->parent;
>  		if (np && !of_get_property(np, "io-channel-ranges", NULL))
> -			return NULL;
> +			return ERR_PTR(-ENODEV);
>  	}
> =20
> -	return chan;
> +	return ERR_PTR(-ENODEV);
>  }
>  EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name);
> =20
> @@ -267,8 +287,8 @@ static struct iio_channel *of_iio_channel_get_all(str=
uct device *dev)
>  			break;
>  	} while (++nummaps);
> =20
> -	if (nummaps =3D=3D 0)	/* no error, return NULL to search map table */
> -		return NULL;
> +	if (nummaps =3D=3D 0)
> +		return ERR_PTR(-ENODEV);
> =20
>  	/* NULL terminated array to save passing size */
>  	chans =3D kcalloc(nummaps + 1, sizeof(*chans), GFP_KERNEL);
> @@ -295,7 +315,7 @@ static struct iio_channel *of_iio_channel_get_all(str=
uct device *dev)
> =20
>  static inline struct iio_channel *of_iio_channel_get_all(struct device *=
dev)
>  {
> -	return NULL;
> +	return ERR_PTR(-ENODEV);
>  }
> =20
>  #endif /* CONFIG_OF */
> @@ -362,7 +382,7 @@ struct iio_channel *iio_channel_get(struct device *de=
v,
>  	if (dev) {
>  		channel =3D of_iio_channel_get_by_name(dev->of_node,
>  						     channel_name);
> -		if (channel !=3D NULL)
> +		if (!IS_ERR(channel) || PTR_ERR(channel) !=3D -ENODEV)
>  			return channel;
>  	}
> =20
> @@ -412,8 +432,6 @@ struct iio_channel *devm_of_iio_channel_get_by_name(s=
truct device *dev,
>  	channel =3D of_iio_channel_get_by_name(np, channel_name);
>  	if (IS_ERR(channel))
>  		return channel;
> -	if (!channel)
> -		return ERR_PTR(-ENODEV);
> =20
>  	ret =3D devm_add_action_or_reset(dev, devm_iio_channel_free, channel);
>  	if (ret)
> @@ -436,7 +454,11 @@ struct iio_channel *iio_channel_get_all(struct devic=
e *dev)
>  		return ERR_PTR(-EINVAL);
> =20
>  	chans =3D of_iio_channel_get_all(dev);
> -	if (chans)
> +	/*
> +	 * We only want to carry on if the error is -ENODEV.  Anything else
> +	 * should be reported up the stack.
> +	 */
> +	if (!IS_ERR(chans) || PTR_ERR(chans) !=3D -ENODEV)
>  		return chans;
> =20
>  	name =3D dev_name(dev);

