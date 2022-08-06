Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB2E58B75B
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 19:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiHFRtS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 13:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiHFRtR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 13:49:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48F9A18E;
        Sat,  6 Aug 2022 10:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54DEDB807E6;
        Sat,  6 Aug 2022 17:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94307C433C1;
        Sat,  6 Aug 2022 17:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659808153;
        bh=RxtmZYHD6JQiPd7rS8xjgpE021L9DBW6BkED3sLEQ5U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RF2gYgcNME2BDUT/1+mqsxrhQCkUILJS8tLZqHtq6KCxhiRKt4/GPP4FrdFCYMitm
         dPZTuB4DA/5YoQUJQDbkFPUK/352na6Eg3Gl2oGp6OHjjhuB5IDCvn/R9U4K0ppVAH
         qGTTMhsGd9dNZ1aTZXATJm1xUAiuQBnJjuCu00F44RwNNBuiXt4aCjpxDs/plkUZ55
         TYcXcHd1W5L8mUIBAl9tSixVQrbEzWRvhPwHygVIaHWGhfoU+V0qnlHvE/nid9ZKCm
         KSn0gunoi3xQ76hV6GUvKsM6O5eFbsfA8uPzCK7QCKLmezy6f9M+EKKLl52DX1bdaY
         VgVq4b3oNJ4ng==
Date:   Sat, 6 Aug 2022 18:59:19 +0100
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
Subject: Re: [PATCH v3 05/15] iio: inkern: move to fwnode properties
Message-ID: <20220806185919.3ec5b8e6@jic23-huawei>
In-Reply-To: <20220715122903.332535-6-nuno.sa@analog.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
        <20220715122903.332535-6-nuno.sa@analog.com>
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

On Fri, 15 Jul 2022 14:28:53 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> This moves the IIO in kernel interface to use fwnode properties and thus
> be firmware agnostic.
>=20
> Note that the interface is still not firmware agnostic. At this point we
> have both OF and fwnode interfaces so that we don't break any user. On
> top of this we also want to have a per driver conversion and that is the
> main reason we have both of_xlate() and fwnode_xlate() support.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Nice. One trivial follow through of wrong comment syntax. I'll fix up
if I pick the series up before you do a respin for other reasons.
> ---
>  drivers/iio/inkern.c         | 159 ++++++++++++++++++-----------------
>  include/linux/iio/consumer.h |  36 ++++----
>  include/linux/iio/iio.h      |   5 ++
>  3 files changed, 108 insertions(+), 92 deletions(-)
>=20
> -struct iio_channel *__of_iio_channel_get_by_name(struct device_node *np,
> -						 const char *name)
> +struct iio_channel *
> +__fwnode_iio_channel_get_by_name(struct fwnode_handle *fwnode, const cha=
r *name)
>  {
>  	struct iio_channel *chan;
>  	int index =3D 0;
> @@ -220,19 +236,20 @@ struct iio_channel *__of_iio_channel_get_by_name(st=
ruct device_node *np,
>  	/*
>  	 * For named iio channels, first look up the name in the
>  	 * "io-channel-names" property.  If it cannot be found, the
> -	 * index will be an error code, and of_iio_channel_get()
> +	 * index will be an error code, and fwnode_iio_channel_get()
>  	 * will fail.
>  	 */
>  	if (name)
> -		index =3D of_property_match_string(np, "io-channel-names", name);
> +		index =3D fwnode_property_match_string(fwnode, "io-channel-names",
> +						     name);
> =20
> -	chan =3D of_iio_channel_get(np, index);
> +	chan =3D fwnode_iio_channel_get(fwnode, index);
>  	if (!IS_ERR(chan) || PTR_ERR(chan) =3D=3D -EPROBE_DEFER)
>  		return chan;
>  	if (name) {
>  		if (index >=3D 0) {
> -			pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
> -			       np, name, index);
> +			pr_err("ERROR: could not get IIO channel %pfw:%s(%i)\n",
> +			       fwnode, name, index);
>  			/*
>  			 * In this case, we found 'name' in 'io-channel-names'
>  			 * but somehow we still fail so that we should not proceed
> @@ -242,16 +259,16 @@ struct iio_channel *__of_iio_channel_get_by_name(st=
ruct device_node *np,
>  			 */
>  			return ERR_PTR(-EINVAL);
>  		}
> -		/* If index < 0, then of_parse_phandle_with_args() fails
> -		 * with -EINVAL which is expected. We should not proceed
> -		 * if we get any other error.

Wrong comment syntax. I guess I can fix this one as well if nothing else co=
mes up.
Or I might be lazy and only fix this one as it replaces the previous wrong =
one.

> +		/* If index < 0, then fwnode_property_get_reference_args() fails
> +		 * with -EINVAL or -ENOENT (ACPI case) which is expected. We
> +		 * should not proceed if we get any other error.
>  		 */
> -		if (PTR_ERR(chan) !=3D -EINVAL)
> +		if (PTR_ERR(chan) !=3D -EINVAL && PTR_ERR(chan) !=3D -ENOENT)
>  			return chan;
>  	} else if (PTR_ERR(chan) !=3D -ENOENT) {
>  		/*
>  		 * if !name, then we should only proceed the lookup if
> -		 * of_parse_phandle_with_args() returns -ENOENT.
> +		 * fwnode_property_get_reference_args() returns -ENOENT.
>  		 */
>  		return chan;
>  	}
> @@ -260,13 +277,14 @@ struct iio_channel *__of_iio_channel_get_by_name(st=
ruct device_node *np,
>  	return ERR_PTR(-ENODEV);
>  }
