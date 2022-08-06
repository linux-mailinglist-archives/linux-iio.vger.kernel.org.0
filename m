Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF89558B7A3
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 20:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbiHFSUz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 14:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242031AbiHFSUg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 14:20:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF3113D33;
        Sat,  6 Aug 2022 11:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30DD361222;
        Sat,  6 Aug 2022 18:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC14EC4314B;
        Sat,  6 Aug 2022 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659810007;
        bh=cKFxoC7vA/Y8JVtO5ZGbKu05Jmpcm3DGgzXHEExY9Ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uehdPVFVEZhduXOFzIYYcUoxMxhuGoYzIFsS82t+e+i1tgP9Rz4m9dp3fw9tNBtEW
         x1Wqqzem9nReSeo1fjzHqy80uMQqPZJcqfqk9vMmauwpA257qsJIboy9YR0rJlZRqX
         8LFhLvv3zQWj2ZR0FRFe97tjnyU3GPDmJqgVynK/59y+acYs3db0We84k+CrsGXZ66
         R4tvIV5DLSK5X1htaxET4Hb0YaPGEeK/8mj/8IP2rUFW0lPW6UOxPqi+ScPlXwVu82
         bzUcNHYVdk+wTj0oHaGuO/PMKSlDUbGGI9IsoG5d/Gcv5NDtAtJ43HC218JEVPLkRl
         PvshjCQRasvsA==
Date:   Sat, 6 Aug 2022 19:30:16 +0100
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
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Olivier Moysan" <olivier.moysan@foss.st.com>,
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
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Avi Fishman <avifishman70@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Haibo Chen" <haibo.chen@nxp.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH v3 04/15] iio: inkern: split
 of_iio_channel_get_by_name()
Message-ID: <20220806193016.7ecf8857@jic23-huawei>
In-Reply-To: <20220715122903.332535-5-nuno.sa@analog.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
        <20220715122903.332535-5-nuno.sa@analog.com>
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

On Fri, 15 Jul 2022 14:28:52 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> This change splits of_iio_channel_get_by_name() so that it decouples
> looking for channels in the current node from looking in it's parents
> nodes. This will be helpful when moving to fwnode properties where we
> need to release the handles when looking for channels in parent's nodes.
>=20
> No functional change intended...
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
A few things from a build test (after hand applying this because of
issues with the comment thing following through the series).

Seem obvious so I fixed them up.

> ---
>  drivers/iio/inkern.c | 109 ++++++++++++++++++++++++++-----------------
>  1 file changed, 65 insertions(+), 44 deletions(-)
>=20
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index c6f1cfe09bd3..f97b7967d3d9 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -211,61 +211,82 @@ static struct iio_channel *of_iio_channel_get(struc=
t device_node *np, int index)
>  	return ERR_PTR(err);
>  }
> =20
> +struct iio_channel *__of_iio_channel_get_by_name(struct device_node *np,
static=20
> +						 const char *name)
> +{
> +	struct iio_channel *chan;
> +	int index =3D 0;
> +
> +	/*
> +	 * For named iio channels, first look up the name in the
> +	 * "io-channel-names" property.  If it cannot be found, the
> +	 * index will be an error code, and of_iio_channel_get()
> +	 * will fail.
> +	 */
> +	if (name)
> +		index =3D of_property_match_string(np, "io-channel-names", name);
> +
> +	chan =3D of_iio_channel_get(np, index);
> +	if (!IS_ERR(chan) || PTR_ERR(chan) =3D=3D -EPROBE_DEFER)
> +		return chan;
> +	if (name) {
> +		if (index >=3D 0) {
> +			pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
> +			       np, name, index);
> +			/*
> +			 * In this case, we found 'name' in 'io-channel-names'
> +			 * but somehow we still fail so that we should not proceed
> +			 * with any other lookup. Hence, explicitly return -EINVAL
> +			 * (maybe not the better error code) so that the caller
> +			 * won't do a system lookup.
> +			 */
> +			return ERR_PTR(-EINVAL);
> +		}
> +		/* If index < 0, then of_parse_phandle_with_args() fails
> +		 * with -EINVAL which is expected. We should not proceed
> +		 * if we get any other error.
> +		 */
> +		if (PTR_ERR(chan) !=3D -EINVAL)
> +			return chan;
> +	} else if (PTR_ERR(chan) !=3D -ENOENT) {
> +		/*
> +		 * if !name, then we should only proceed the lookup if
> +		 * of_parse_phandle_with_args() returns -ENOENT.
> +		 */
> +		return chan;
> +	}
> +
> +	/* so we continue the lookup */
> +	return ERR_PTR(-ENODEV);
> +}
> +
>  struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
>  					       const char *name)
>  {
>  	struct iio_channel *chan;
> =20
>  	/* Walk up the tree of devices looking for a matching iio channel */
> +	chan =3D __of_iio_channel_get_by_name(np, name);
> +	if (!IS_ERR(chan) || PTR_ERR(chan) !=3D -ENODEV)
> +		return chan;
> +
> +	/*
> +	 * No matching IIO channel found on this node.
> +	 * If the parent node has a "io-channel-ranges" property,
> +	 * then we can try one of its channels.
> +	 */
> +	np =3D np->parent;
>  	while (np) {
>  		int index =3D 0;
Not used.

> =20
> -		/*
> -		 * For named iio channels, first look up the name in the
> -		 * "io-channel-names" property.  If it cannot be found, the
> -		 * index will be an error code, and of_iio_channel_get()
> -		 * will fail.
> -		 */
> -		if (name)
> -			index =3D of_property_match_string(np, "io-channel-names",
> -							 name);
> -		chan =3D of_iio_channel_get(np, index);
> -		if (!IS_ERR(chan) || PTR_ERR(chan) =3D=3D -EPROBE_DEFER)
> -			return chan;
> -		if (name) {
> -			if (index >=3D 0) {
> -				pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
> -				       np, name, index);
> -				/*
> -				 * In this case, we found 'name' in 'io-channel-names'
> -				 * but somehow we still fail so that we should not proceed
> -				 * with any other lookup. Hence, explicitly return -EINVAL
> -				 * (maybe not the better error code) so that the caller
> -				 * won't do a system lookup.
> -				 */
> -				return ERR_PTR(-EINVAL);
> -			}
> -			/* If index < 0, then of_parse_phandle_with_args() fails
> -			 * with -EINVAL which is expected. We should not proceed
> -			 * if we get any other error.
> -			 */
> -			if (PTR_ERR(chan) !=3D -EINVAL)
> -				return chan;
> -		} else if (PTR_ERR(chan) !=3D -ENOENT) {
> -			/*
> -			 * if !name, then we should only proceed the lookup if
> -			 * of_parse_phandle_with_args() returns -ENOENT.
> -			 */
> +		if (!of_get_property(np, "io-channel-ranges", NULL))
> +			return ERR_PTR(-ENODEV);
> +
> +		chan =3D __of_iio_channel_get_by_name(np, name);
> +		if (!IS_ERR(chan) || PTR_ERR(chan) !=3D -ENODEV)
>  			return chan;
> -		}
> -		/*
> -		 * No matching IIO channel found on this node.
> -		 * If the parent node has a "io-channel-ranges" property,
> -		 * then we can try one of its channels.
> -		 */
> +
>  		np =3D np->parent;
> -		if (np && !of_get_property(np, "io-channel-ranges", NULL))
> -			return ERR_PTR(-ENODEV);
>  	}
> =20
>  	return ERR_PTR(-ENODEV);

