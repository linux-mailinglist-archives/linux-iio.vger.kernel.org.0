Return-Path: <linux-iio+bounces-919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E27E813029
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 13:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34759B2189F
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 12:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988434AF94;
	Thu, 14 Dec 2023 12:30:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29463125;
	Thu, 14 Dec 2023 04:30:34 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SrWrx5dZRz67G9n;
	Thu, 14 Dec 2023 20:30:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C1031400DD;
	Thu, 14 Dec 2023 20:30:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 12:30:31 +0000
Date: Thu, 14 Dec 2023 12:30:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
CC: <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <andy@kernel.org>,
	<linux-gpio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Jonathan
 Cameron" <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Michael Walle <michael@walle.cc>, Andy Shevchenko
	<andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
	<chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>, Mike Looijmans
	<mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
	<hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20231214123029.000002f1@Huawei.com>
In-Reply-To: <20231212104451.22522-2-mitrutzceclan@gmail.com>
References: <20231212104451.22522-1-mitrutzceclan@gmail.com>
	<20231212104451.22522-2-mitrutzceclan@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 12 Dec 2023 12:44:36 +0200
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
> 
> Reviewed-by: Michael Walle <michael@walle.cc> # for gpio-regmap
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
Hi

Given it seems like you'll be doing a v9, one quick comment from me below.

Jonathan

> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> new file mode 100644
> index 000000000000..96918b24a10a
> --- /dev/null
> +++ b/drivers/iio/adc/ad7173.c
> @@ -0,0 +1,964 @@
...

> +static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
> +{

...

> +
> +	if (st->info->has_temp) {
> +		chan_arr[chan_index] = ad7173_temp_iio_channel_template;
> +		chan_st_priv = &channels_st_priv_arr[chan_index];
> +		chan_st_priv->ain =
> +			AD7173_CH_ADDRESS(chan_arr[chan_index].channel, chan_arr[chan_index].channel2);
> +		chan_st_priv->cfg.bipolar = false;
> +		chan_st_priv->cfg.input_buf = true;
> +		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> +		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
> +
> +		chan_index++;
> +	}
> +
> +	device_for_each_child_node(dev, child) {
> +		chan = &chan_arr[chan_index];
> +		chan_st_priv = &channels_st_priv_arr[chan_index];
> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> +						     ain, ARRAY_SIZE(ain));
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			return ret;
> +		}
> +
> +		if (ain[0] >= st->info->num_inputs ||
> +		    ain[1] >= st->info->num_inputs) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Input pin number out of range for pair (%d %d).\n",
> +					     ain[0], ain[1]);
> +		}
> +
> +		ret = fwnode_property_match_property_string(child,
> +							    "adi,reference-select",
> +							    ad7173_ref_sel_str,
> +							    ARRAY_SIZE(ad7173_ref_sel_str));
> +
> +		if (ret < 0)
> +			ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> +		else
> +			ref_sel = ret;
Simpler pattern for properties with a default is not to check the error code.

		ref_sel = AD7173_SETUP_REF_SEL_INT_REF;

		fwnode_property_match_property_String(child, ...

so only if it succeeds is the value overridden.

