Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6991858B765
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 19:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiHFRxc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 13:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiHFRxb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 13:53:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9695E11C19;
        Sat,  6 Aug 2022 10:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3011BB80025;
        Sat,  6 Aug 2022 17:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94870C433C1;
        Sat,  6 Aug 2022 17:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659808407;
        bh=N4R6bAIgXf+qR39Qf/icSXDtbAcXLXJGvEsDtUbR9K8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RDKmkPqLK9JBNONow6WuECuYOe71VLiYyxMRujjqpc3fiZ5H1YG8ki07yccB2m/uU
         BR/EVwIyFTQALbGMMItSqlLF72BZt951zzF2yhRcB9bvcUqFyys61w77nn0J3NyXvu
         9QEP9BBw1lG78sCp+DHTGYA+bIExSwKvRzhV+ng62G3KIvUr5W9NXn/vKoMvzHDz6J
         TdxnKGhhJphslZ+ozkKxIibsIbj0KhW1OCrhnEgYwFoUw7+V44ScBM0ANOX8xtEh2e
         LJHDYSa5Iy4AevyL9LNtrdBM1TtuoDK+Jgh0S6tmo5FZMyrw7rO0IBr7eVNT2lkOmX
         EHsYtlpSnMYDA==
Date:   Sat, 6 Aug 2022 19:03:37 +0100
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
Subject: Re: [PATCH v3 08/15] iio: adc: ab8500-gpadc: convert to device
 properties
Message-ID: <20220806190337.5f3086c9@jic23-huawei>
In-Reply-To: <20220715122903.332535-9-nuno.sa@analog.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
        <20220715122903.332535-9-nuno.sa@analog.com>
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

On Fri, 15 Jul 2022 14:28:56 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Make the conversion to firmware agnostic device properties. As part of
> the conversion the IIO inkern interface 'of_xlate()' is also converted to
> 'fwnode_xlate()'. The goal is to completely drop 'of_xlate' and hence OF
> dependencies from IIO.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Nitpick, but ideally this would have been two patches.=20
1) Drop parameter to *_parse_channels()=20
2) the rest.

As that little corner was hardert o check than the rest :)

meh.  It's trivial as I said, otherwise looks good to me.

Jonathan


> ---
>  drivers/iio/adc/ab8500-gpadc.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpad=
c.c
> index 930ce96e6ff5..4fa2126a354b 100644
> --- a/drivers/iio/adc/ab8500-gpadc.c
> +++ b/drivers/iio/adc/ab8500-gpadc.c
> @@ -925,8 +925,8 @@ static int ab8500_gpadc_read_raw(struct iio_dev *indi=
o_dev,
>  	return -EINVAL;
>  }
> =20
> -static int ab8500_gpadc_of_xlate(struct iio_dev *indio_dev,
> -				 const struct of_phandle_args *iiospec)
> +static int ab8500_gpadc_fwnode_xlate(struct iio_dev *indio_dev,
> +				     const struct fwnode_reference_args *iiospec)
>  {
>  	int i;
> =20
> @@ -938,7 +938,7 @@ static int ab8500_gpadc_of_xlate(struct iio_dev *indi=
o_dev,
>  }
> =20
>  static const struct iio_info ab8500_gpadc_info =3D {
> -	.of_xlate =3D ab8500_gpadc_of_xlate,
> +	.fwnode_xlate =3D ab8500_gpadc_fwnode_xlate,
>  	.read_raw =3D ab8500_gpadc_read_raw,
>  };
> =20
> @@ -968,7 +968,7 @@ static int ab8500_gpadc_runtime_resume(struct device =
*dev)
>  /**
>   * ab8500_gpadc_parse_channel() - process devicetree channel configurati=
on
>   * @dev: pointer to containing device
> - * @np: device tree node for the channel to configure
> + * @fwnode: fw node for the channel to configure
>   * @ch: channel info to fill in
>   * @iio_chan: IIO channel specification to fill in
>   *
> @@ -976,15 +976,15 @@ static int ab8500_gpadc_runtime_resume(struct devic=
e *dev)
>   * and define usage for things like AUX GPADC inputs more precisely.
>   */
>  static int ab8500_gpadc_parse_channel(struct device *dev,
> -				      struct device_node *np,
> +				      struct fwnode_handle *fwnode,
>  				      struct ab8500_gpadc_chan_info *ch,
>  				      struct iio_chan_spec *iio_chan)
>  {
> -	const char *name =3D np->name;
> +	const char *name =3D fwnode_get_name(fwnode);
>  	u32 chan;
>  	int ret;
> =20
> -	ret =3D of_property_read_u32(np, "reg", &chan);
> +	ret =3D fwnode_property_read_u32(fwnode, "reg", &chan);
>  	if (ret) {
>  		dev_err(dev, "invalid channel number %s\n", name);
>  		return ret;
> @@ -1021,22 +1021,20 @@ static int ab8500_gpadc_parse_channel(struct devi=
ce *dev,
>  /**
>   * ab8500_gpadc_parse_channels() - Parse the GPADC channels from DT
>   * @gpadc: the GPADC to configure the channels for
> - * @np: device tree node containing the channel configurations
>   * @chans: the IIO channels we parsed
>   * @nchans: the number of IIO channels we parsed
>   */
>  static int ab8500_gpadc_parse_channels(struct ab8500_gpadc *gpadc,
> -				       struct device_node *np,
>  				       struct iio_chan_spec **chans_parsed,
>  				       unsigned int *nchans_parsed)
>  {
> -	struct device_node *child;
> +	struct fwnode_handle *child;
>  	struct ab8500_gpadc_chan_info *ch;
>  	struct iio_chan_spec *iio_chans;
>  	unsigned int nchans;
>  	int i;
> =20
> -	nchans =3D of_get_available_child_count(np);
> +	nchans =3D device_get_child_node_count(gpadc->dev);
>  	if (!nchans) {
>  		dev_err(gpadc->dev, "no channel children\n");
>  		return -ENODEV;
> @@ -1054,7 +1052,7 @@ static int ab8500_gpadc_parse_channels(struct ab850=
0_gpadc *gpadc,
>  		return -ENOMEM;
> =20
>  	i =3D 0;
> -	for_each_available_child_of_node(np, child) {
> +	device_for_each_child_node(gpadc->dev, child) {
>  		struct iio_chan_spec *iio_chan;
>  		int ret;
> =20
> @@ -1064,7 +1062,7 @@ static int ab8500_gpadc_parse_channels(struct ab850=
0_gpadc *gpadc,
>  		ret =3D ab8500_gpadc_parse_channel(gpadc->dev, child, ch,
>  						 iio_chan);
>  		if (ret) {
> -			of_node_put(child);
> +			fwnode_handle_put(child);
>  			return ret;
>  		}
>  		i++;
> @@ -1081,7 +1079,6 @@ static int ab8500_gpadc_probe(struct platform_devic=
e *pdev)
>  	struct ab8500_gpadc *gpadc;
>  	struct iio_dev *indio_dev;
>  	struct device *dev =3D &pdev->dev;
> -	struct device_node *np =3D pdev->dev.of_node;
>  	struct iio_chan_spec *iio_chans;
>  	unsigned int n_iio_chans;
>  	int ret;
> @@ -1096,7 +1093,7 @@ static int ab8500_gpadc_probe(struct platform_devic=
e *pdev)
>  	gpadc->dev =3D dev;
>  	gpadc->ab8500 =3D dev_get_drvdata(dev->parent);
> =20
> -	ret =3D ab8500_gpadc_parse_channels(gpadc, np, &iio_chans, &n_iio_chans=
);
> +	ret =3D ab8500_gpadc_parse_channels(gpadc, &iio_chans, &n_iio_chans);
>  	if (ret)
>  		return ret;
> =20

