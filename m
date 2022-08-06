Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49A858B782
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 20:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiHFSKp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 14:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiHFSKo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 14:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0103DFB5;
        Sat,  6 Aug 2022 11:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B6C461216;
        Sat,  6 Aug 2022 18:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F72C433D6;
        Sat,  6 Aug 2022 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809441;
        bh=lVKDHL6nifdg0VLVhM1MC1VYGdeoEDIVzY/AjMF7ZL8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pjCnK65PNFpeA6AxZx8b5u8PZ5bhzCfpLoIc/0xo4LZ8R7Mg1JpqOlG/UZNsDj4Zq
         75g6TtbT/aj9weiRyeXR8qyCeUKnMfSgZCAnuZ5au7SHOyZCRnMIfKDiRVKbkduFsl
         OOhHuDOGKCSkSQ2uMJltFbbtU6mEN+dp1Uv1dlrNbuu1SgO4JizRbLds3ktZEFkG92
         rE2OdnekNuDEQA5lrXKIC+AMVxT0TZkzcj7XJh6U6mX/OW8+hOw//OJRtvpvHCfdzR
         MfoQRvjWRfDMFXsDi3jqpF5WLwGlNVaGp7BNBFVRb5jb4121GWtmw5kIwAe8JMLQFZ
         OEF4XzdLWn9aQ==
Date:   Sat, 6 Aug 2022 19:20:48 +0100
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
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v3 12/15] iio: adc: qcom-spmi-adc5: convert to device
 properties
Message-ID: <20220806192048.0ca41cc5@jic23-huawei>
In-Reply-To: <20220715122903.332535-13-nuno.sa@analog.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
        <20220715122903.332535-13-nuno.sa@analog.com>
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

On Fri, 15 Jul 2022 14:29:00 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Make the conversion to firmware agnostic device properties. As part of
> the conversion the IIO inkern interface 'of_xlate()' is also converted to
> 'fwnode_xlate()'. The goal is to completely drop 'of_xlate' and hence OF
> dependencies from IIO.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
+CC Marijin who happend to post a patch for this driver that I just accepted
and hence probably has hardware access.  Any chance of a test for this seri=
es?

If not, no problem as this is fairly mechanical and we have testing on some=
 of
the other drivers using the new code.

I'll probably queue this up in the meantime but it won't end up upstream
for a few weeks yet.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 63 +++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi=
-adc5.c
> index 87438d1e5c0b..a23f9293d6c1 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -14,9 +14,9 @@
>  #include <linux/log2.h>
>  #include <linux/math64.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> =20
> @@ -403,8 +403,8 @@ static irqreturn_t adc5_isr(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
> =20
> -static int adc5_of_xlate(struct iio_dev *indio_dev,
> -				const struct of_phandle_args *iiospec)
> +static int adc5_fwnode_xlate(struct iio_dev *indio_dev,
> +			     const struct fwnode_reference_args *iiospec)
>  {
>  	struct adc5_chip *adc =3D iio_priv(indio_dev);
>  	int i;
> @@ -416,8 +416,8 @@ static int adc5_of_xlate(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
> =20
> -static int adc7_of_xlate(struct iio_dev *indio_dev,
> -				const struct of_phandle_args *iiospec)
> +static int adc7_fwnode_xlate(struct iio_dev *indio_dev,
> +			     const struct fwnode_reference_args *iiospec)
>  {
>  	struct adc5_chip *adc =3D iio_priv(indio_dev);
>  	int i, v_channel;
> @@ -481,12 +481,12 @@ static int adc7_read_raw(struct iio_dev *indio_dev,
> =20
>  static const struct iio_info adc5_info =3D {
>  	.read_raw =3D adc5_read_raw,
> -	.of_xlate =3D adc5_of_xlate,
> +	.fwnode_xlate =3D adc5_fwnode_xlate,
>  };
> =20
>  static const struct iio_info adc7_info =3D {
>  	.read_raw =3D adc7_read_raw,
> -	.of_xlate =3D adc7_of_xlate,
> +	.fwnode_xlate =3D adc7_fwnode_xlate,
>  };
> =20
>  struct adc5_channels {
> @@ -611,18 +611,18 @@ static const struct adc5_channels adc5_chans_rev2[A=
DC5_MAX_CHANNEL] =3D {
>  					SCALE_HW_CALIB_THERM_100K_PULLUP)
>  };
> =20
> -static int adc5_get_dt_channel_data(struct adc5_chip *adc,
> +static int adc5_get_fw_channel_data(struct adc5_chip *adc,
>  				    struct adc5_channel_prop *prop,
> -				    struct device_node *node,
> +				    struct fwnode_handle *fwnode,
>  				    const struct adc5_data *data)
>  {
> -	const char *name =3D node->name, *channel_name;
> +	const char *name =3D fwnode_get_name(fwnode), *channel_name;
>  	u32 chan, value, varr[2];
>  	u32 sid =3D 0;
>  	int ret;
>  	struct device *dev =3D adc->dev;
> =20
> -	ret =3D of_property_read_u32(node, "reg", &chan);
> +	ret =3D fwnode_property_read_u32(fwnode, "reg", &chan);
>  	if (ret) {
>  		dev_err(dev, "invalid channel number %s\n", name);
>  		return ret;
> @@ -647,15 +647,13 @@ static int adc5_get_dt_channel_data(struct adc5_chi=
p *adc,
>  	prop->channel =3D chan;
>  	prop->sid =3D sid;
> =20
> -	channel_name =3D of_get_property(node,
> -				"label", NULL) ? : node->name;
> -	if (!channel_name) {
> -		dev_err(dev, "Invalid channel name\n");
> -		return -EINVAL;
> -	}
> +	ret =3D fwnode_property_read_string(fwnode, "label", &channel_name);
> +	if (ret)
> +		channel_name =3D name;
> +
>  	prop->datasheet_name =3D channel_name;
> =20
> -	ret =3D of_property_read_u32(node, "qcom,decimation", &value);
> +	ret =3D fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
>  	if (!ret) {
>  		ret =3D qcom_adc5_decimation_from_dt(value, data->decimation);
>  		if (ret < 0) {
> @@ -668,7 +666,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip =
*adc,
>  		prop->decimation =3D ADC5_DECIMATION_DEFAULT;
>  	}
> =20
> -	ret =3D of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
> +	ret =3D fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr=
, 2);
>  	if (!ret) {
>  		ret =3D qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
>  		if (ret < 0) {
> @@ -682,7 +680,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip =
*adc,
>  			adc->data->adc_chans[prop->channel].prescale_index;
>  	}
> =20
> -	ret =3D of_property_read_u32(node, "qcom,hw-settle-time", &value);
> +	ret =3D fwnode_property_read_u32(fwnode, "qcom,hw-settle-time", &value);
>  	if (!ret) {
>  		u8 dig_version[2];
> =20
> @@ -713,7 +711,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip =
*adc,
>  		prop->hw_settle_time =3D VADC_DEF_HW_SETTLE_TIME;
>  	}
> =20
> -	ret =3D of_property_read_u32(node, "qcom,avg-samples", &value);
> +	ret =3D fwnode_property_read_u32(fwnode, "qcom,avg-samples", &value);
>  	if (!ret) {
>  		ret =3D qcom_adc5_avg_samples_from_dt(value);
>  		if (ret < 0) {
> @@ -726,7 +724,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip =
*adc,
>  		prop->avg_samples =3D VADC_DEF_AVG_SAMPLES;
>  	}
> =20
> -	if (of_property_read_bool(node, "qcom,ratiometric"))
> +	if (fwnode_property_read_bool(fwnode, "qcom,ratiometric"))
>  		prop->cal_method =3D ADC5_RATIOMETRIC_CAL;
>  	else
>  		prop->cal_method =3D ADC5_ABSOLUTE_CAL;
> @@ -801,16 +799,16 @@ static const struct of_device_id adc5_match_table[]=
 =3D {
>  };
>  MODULE_DEVICE_TABLE(of, adc5_match_table);
> =20
> -static int adc5_get_dt_data(struct adc5_chip *adc, struct device_node *n=
ode)
> +static int adc5_get_fw_data(struct adc5_chip *adc)
>  {
>  	const struct adc5_channels *adc_chan;
>  	struct iio_chan_spec *iio_chan;
>  	struct adc5_channel_prop prop, *chan_props;
> -	struct device_node *child;
> +	struct fwnode_handle *child;
>  	unsigned int index =3D 0;
>  	int ret;
> =20
> -	adc->nchannels =3D of_get_available_child_count(node);
> +	adc->nchannels =3D device_get_child_node_count(adc->dev);
>  	if (!adc->nchannels)
>  		return -EINVAL;
> =20
> @@ -826,14 +824,14 @@ static int adc5_get_dt_data(struct adc5_chip *adc, =
struct device_node *node)
> =20
>  	chan_props =3D adc->chan_props;
>  	iio_chan =3D adc->iio_chans;
> -	adc->data =3D of_device_get_match_data(adc->dev);
> +	adc->data =3D device_get_match_data(adc->dev);
>  	if (!adc->data)
>  		adc->data =3D &adc5_data_pmic;
> =20
> -	for_each_available_child_of_node(node, child) {
> -		ret =3D adc5_get_dt_channel_data(adc, &prop, child, adc->data);
> +	device_for_each_child_node(adc->dev, child) {
> +		ret =3D adc5_get_fw_channel_data(adc, &prop, child, adc->data);
>  		if (ret) {
> -			of_node_put(child);
> +			fwnode_handle_put(child);
>  			return ret;
>  		}
> =20
> @@ -858,7 +856,6 @@ static int adc5_get_dt_data(struct adc5_chip *adc, st=
ruct device_node *node)
> =20
>  static int adc5_probe(struct platform_device *pdev)
>  {
> -	struct device_node *node =3D pdev->dev.of_node;
>  	struct device *dev =3D &pdev->dev;
>  	struct iio_dev *indio_dev;
>  	struct adc5_chip *adc;
> @@ -870,7 +867,7 @@ static int adc5_probe(struct platform_device *pdev)
>  	if (!regmap)
>  		return -ENODEV;
> =20
> -	ret =3D of_property_read_u32(node, "reg", &reg);
> +	ret =3D device_property_read_u32(dev, "reg", &reg);
>  	if (ret < 0)
>  		return ret;
> =20
> @@ -886,7 +883,7 @@ static int adc5_probe(struct platform_device *pdev)
>  	init_completion(&adc->complete);
>  	mutex_init(&adc->lock);
> =20
> -	ret =3D adc5_get_dt_data(adc, node);
> +	ret =3D adc5_get_fw_data(adc);
>  	if (ret) {
>  		dev_err(dev, "adc get dt data failed\n");
>  		return ret;

