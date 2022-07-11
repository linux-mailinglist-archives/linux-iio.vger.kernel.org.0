Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB163570511
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 16:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGKOGl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 10:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGKOGk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 10:06:40 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F921BC17;
        Mon, 11 Jul 2022 07:06:36 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BDaxni006196;
        Mon, 11 Jul 2022 16:04:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=A9YWILxZfR2mw0MsvEQKGqTDoI7S5KJFQUk8w0kMLuw=;
 b=2ldmoC9YjSINrm5Mv9nnSpxK7UisephCP8OWSsa6YIc9f0aD6RrMtkCf5CDxrmRPkxTg
 oJtAavShU7IFPJ0eJ0esokW3OWcxsP1ACvV18ZOxOlK0SOVJR3AdQ6LVY5UVj/XGewPt
 lg5Gyz2CLsvMplg/367BCjsXYSaQsZfbSii3FvE/B+g9PGRa0bU5jckruWpoUTKdMHGT
 sfb1n/tFFS6BozkeeDxv8vYfNVISewtrYag06n7lhSoUz2oxQE/O/3SbseWYQcdcnnAB
 0kElww3nF7DNdlsKVsxQ2/0+UnUCzaZ5Ar95DoRQk//mBQa/UTpqyy4osDnKFlF3nXIG rA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h6xtakuf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 16:04:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E3E3A100034;
        Mon, 11 Jul 2022 16:04:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CD5402248DE;
        Mon, 11 Jul 2022 16:04:50 +0200 (CEST)
Received: from [10.48.1.102] (10.75.127.48) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 11 Jul
 2022 16:04:45 +0200
Message-ID: <f0f150cf-586f-9f13-81b0-cb95bd0d8f23@foss.st.com>
Date:   Mon, 11 Jul 2022 16:04:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 13/15] iio: adc: stm32-adc: convert to device
 properties
Content-Language: en-US
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        <linux-arm-msm@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-mips@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-iio@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC:     Andy Gross <agross@kernel.org>,
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
References: <20220711123835.811358-1-nuno.sa@analog.com>
 <20220711123835.811358-14-nuno.sa@analog.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20220711123835.811358-14-nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_18,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/11/22 14:38, Nuno Sá wrote:
> Make the conversion to firmware agnostic device properties. As part of
> the conversion the IIO inkern interface 'of_xlate()' is also converted to
> 'fwnode_xlate()'. The goal is to completely drop 'of_xlate' and hence OF
> dependencies from IIO.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/stm32-adc.c | 121 ++++++++++++++++++++----------------
>  1 file changed, 67 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 3985fe972892..e55859113df8 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -21,11 +21,11 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/property.h>
>  
>  #include "stm32-adc-core.h"
>  
> @@ -1530,8 +1530,8 @@ static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int stm32_adc_of_xlate(struct iio_dev *indio_dev,
> -			      const struct of_phandle_args *iiospec)
> +static int stm32_adc_fwnode_xlate(struct iio_dev *indio_dev,
> +				  const struct fwnode_reference_args *iiospec)
>  {
>  	int i;
>  
> @@ -1585,7 +1585,7 @@ static const struct iio_info stm32_adc_iio_info = {
>  	.hwfifo_set_watermark = stm32_adc_set_watermark,
>  	.update_scan_mode = stm32_adc_update_scan_mode,
>  	.debugfs_reg_access = stm32_adc_debugfs_reg_access,
> -	.of_xlate = stm32_adc_of_xlate,
> +	.fwnode_xlate = stm32_adc_fwnode_xlate,
>  };
>  
>  static unsigned int stm32_adc_dma_residue(struct stm32_adc *adc)
> @@ -1782,14 +1782,14 @@ static const struct iio_chan_spec_ext_info stm32_adc_ext_info[] = {
>  	{},
>  };
>  
> -static int stm32_adc_of_get_resolution(struct iio_dev *indio_dev)
> +static int stm32_adc_fw_get_resolution(struct iio_dev *indio_dev)
>  {
> -	struct device_node *node = indio_dev->dev.of_node;
> +	struct device *dev = &indio_dev->dev;
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	unsigned int i;
>  	u32 res;
>  
> -	if (of_property_read_u32(node, "assigned-resolution-bits", &res))
> +	if (device_property_read_u32(dev, "assigned-resolution-bits", &res))
>  		res = adc->cfg->adc_info->resolutions[0];
>  
>  	for (i = 0; i < adc->cfg->adc_info->num_res; i++)
> @@ -1873,11 +1873,11 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
>  
>  static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm32_adc *adc)
>  {
> -	struct device_node *node = indio_dev->dev.of_node;
> +	struct device *dev = &indio_dev->dev;
>  	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
>  	int num_channels = 0, ret;
>  
> -	ret = of_property_count_u32_elems(node, "st,adc-channels");
> +	ret = device_property_count_u32(dev, "st,adc-channels");
>  	if (ret > adc_info->max_channels) {
>  		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
>  		return -EINVAL;
> @@ -1885,8 +1885,8 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
>  		num_channels += ret;
>  	}
>  
> -	ret = of_property_count_elems_of_size(node, "st,adc-diff-channels",
> -					      sizeof(struct stm32_adc_diff_channel));
> +	/* each st,adc-diff-channels is a group of 2 u32 */
> +	ret = device_property_count_u64(dev, "st,adc-diff-channels");
>  	if (ret > adc_info->max_channels) {
>  		dev_err(&indio_dev->dev, "Bad st,adc-diff-channels?\n");
>  		return -EINVAL;
> @@ -1896,7 +1896,7 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
>  	}
>  
>  	/* Optional sample time is provided either for each, or all channels */
> -	ret = of_property_count_u32_elems(node, "st,min-sample-time-nsecs");
> +	ret = device_property_count_u32(dev, "st,min-sample-time-nsecs");
>  	if (ret > 1 && ret != num_channels) {
>  		dev_err(&indio_dev->dev, "Invalid st,min-sample-time-nsecs\n");
>  		return -EINVAL;
> @@ -1907,21 +1907,20 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
>  
>  static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
>  				      struct stm32_adc *adc,
> -				      struct iio_chan_spec *channels)
> +				      struct iio_chan_spec *channels,
> +				      int nchans)
>  {
> -	struct device_node *node = indio_dev->dev.of_node;
>  	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
>  	struct stm32_adc_diff_channel diff[STM32_ADC_CH_MAX];
> +	struct device *dev = &indio_dev->dev;
>  	u32 num_diff = adc->num_diff;
>  	int size = num_diff * sizeof(*diff) / sizeof(u32);
> -	int scan_index = 0, val, ret, i;
> -	struct property *prop;
> -	const __be32 *cur;
> -	u32 smp = 0;
> +	int scan_index = 0, ret, i;
> +	u32 smp = 0, nsmps, smps[STM32_ADC_CH_MAX], chans[STM32_ADC_CH_MAX];
>  
>  	if (num_diff) {
> -		ret = of_property_read_u32_array(node, "st,adc-diff-channels",
> -						 (u32 *)diff, size);
> +		ret = device_property_read_u32_array(dev, "st,adc-diff-channels",
> +						     (u32 *)diff, size);
>  		if (ret) {
>  			dev_err(&indio_dev->dev, "Failed to get diff channels %d\n", ret);
>  			return ret;
> @@ -1942,32 +1941,51 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
>  		}
>  	}
>  
> -	of_property_for_each_u32(node, "st,adc-channels", prop, cur, val) {
> -		if (val >= adc_info->max_channels) {
> -			dev_err(&indio_dev->dev, "Invalid channel %d\n", val);
> +	ret = device_property_read_u32_array(dev, "st,adc-channels", chans,
> +					     nchans);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < nchans; i++) {

Hi Nuno,

There's an endless loop issue here due to the two for loops are using
the same index 'i'. (Please look at my earlier comments in v1)

for (i = 0; i < nchans; i++) {
	...
	// Here i gets cleared, num_diff may vary (example with 0 here)
	for (i = 0; i < num_diff; i++) {
		...
	}

	stm32_adc_chan_init_one(.. &channels[scan_index].. scan_index..)

	scan_index++; // Still, scan index gets incremented indefinitly
}

There's an out of boudary situation with scan_index above, wich ends-up
in crashing in stm32_adc_chan_init_one().

> +		if (chans[i] >= adc_info->max_channels) {
> +			dev_err(&indio_dev->dev, "Invalid channel %d\n",
> +				chans[i]);
>  			return -EINVAL;
>  		}
>  
>  		/* Channel can't be configured both as single-ended & diff */
>  		for (i = 0; i < num_diff; i++) {
> -			if (val == diff[i].vinp) {
> -				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	val);
> +			if (chans[i] == diff[i].vinp) {
> +				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	chans[i]);
>  				return -EINVAL;
>  			}
>  		}
> -		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
> -					0, scan_index, false);
> +		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
> +					chans[i], 0, scan_index, false);
>  		scan_index++;
>  	}
>  
> +	nsmps = device_property_count_u32(dev, "st,min-sample-time-nsecs");
> +	if (nsmps) {
> +		if (nsmps >= nchans)

nit: if (nsmps > nchans)

> +			nsmps = nchans;
> +

There's a bit of redundancy in checking nsmps,
"st,min-sample-time-nsecs" is already sanitized in
stm32_adc_get_legacy_chan_count():

/* Optional sample time is provided either for each, or all channels */
ret = device_property_count_u32(dev, "st,min-sample-time-nsecs");
if (ret > 1 && ret != num_channels) {
	dev_err(...

So just sharing my thoughts here:
- Maybe this could be dropped ?
  (Thinking loudly) The earliest this gets sanitized, the less un-needed
initialisations happen before failing?
- Or the earlier check could be moved here ?

I've no strong opinion.

Best Regards,
Fabrice

> +		ret = device_property_read_u32_array(dev, "st,min-sample-time-nsecs",
> +						     smps, nsmps);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	for (i = 0; i < scan_index; i++) {
>  		/*
> -		 * Using of_property_read_u32_index(), smp value will only be
> -		 * modified if valid u32 value can be decoded. This allows to
> -		 * get either no value, 1 shared value for all indexes, or one
> -		 * value per channel.
> +		 * This check is used with the above logic so that smp value
> +		 * will only be modified if valid u32 value can be decoded. This
> +		 * allows to get either no value, 1 shared value for all indexes,
> +		 * or one value per channel. The point is to have the same
> +		 * behavior as 'of_property_read_u32_index()'.
>  		 */
> -		of_property_read_u32_index(node, "st,min-sample-time-nsecs", i, &smp);
> +		if (i < nsmps)
> +			smp = smps[i];
>  
>  		/* Prepare sampling time settings */
>  		stm32_adc_smpr_init(adc, channels[i].channel, smp);
> @@ -2010,22 +2028,21 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  				       struct stm32_adc *adc,
>  				       struct iio_chan_spec *channels)
>  {
> -	struct device_node *node = indio_dev->dev.of_node;
>  	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
> -	struct device_node *child;
> +	struct fwnode_handle *child;
>  	const char *name;
>  	int val, scan_index = 0, ret;
>  	bool differential;
>  	u32 vin[2];
>  
> -	for_each_available_child_of_node(node, child) {
> -		ret = of_property_read_u32(child, "reg", &val);
> +	device_for_each_child_node(&indio_dev->dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &val);
>  		if (ret) {
>  			dev_err(&indio_dev->dev, "Missing channel index %d\n", ret);
>  			goto err;
>  		}
>  
> -		ret = of_property_read_string(child, "label", &name);
> +		ret = fwnode_property_read_string(child, "label", &name);
>  		/* label is optional */
>  		if (!ret) {
>  			if (strlen(name) >= STM32_ADC_CH_SZ) {
> @@ -2050,7 +2067,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  		}
>  
>  		differential = false;
> -		ret = of_property_read_u32_array(child, "diff-channels", vin, 2);
> +		ret = fwnode_property_read_u32_array(child, "diff-channels", vin, 2);
>  		/* diff-channels is optional */
>  		if (!ret) {
>  			differential = true;
> @@ -2067,7 +2084,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  		stm32_adc_chan_init_one(indio_dev, &channels[scan_index], val,
>  					vin[1], scan_index, differential);
>  
> -		ret = of_property_read_u32(child, "st,min-sample-time-ns", &val);
> +		ret = fwnode_property_read_u32(child, "st,min-sample-time-ns", &val);
>  		/* st,min-sample-time-ns is optional */
>  		if (!ret) {
>  			stm32_adc_smpr_init(adc, channels[scan_index].channel, val);
> @@ -2085,14 +2102,13 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  	return scan_index;
>  
>  err:
> -	of_node_put(child);
> +	fwnode_handle_put(child);
>  
>  	return ret;
>  }
>  
> -static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
> +static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)
>  {
> -	struct device_node *node = indio_dev->dev.of_node;
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
>  	struct iio_chan_spec *channels;
> @@ -2102,7 +2118,7 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
>  	for (i = 0; i < STM32_ADC_INT_CH_NB; i++)
>  		adc->int_ch[i] = STM32_ADC_INT_CH_NONE;
>  
> -	num_channels = of_get_available_child_count(node);
> +	num_channels = device_get_child_node_count(&indio_dev->dev);
>  	/* If no channels have been found, fallback to channels legacy properties. */
>  	if (!num_channels) {
>  		legacy = true;
> @@ -2133,7 +2149,8 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
>  		return -ENOMEM;
>  
>  	if (legacy)
> -		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels);
> +		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels,
> +						 num_channels);
>  	else
>  		ret = stm32_adc_generic_chan_init(indio_dev, adc, channels);
>  	if (ret < 0)
> @@ -2215,9 +2232,6 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	bool timestamping = false;
>  	int ret;
>  
> -	if (!pdev->dev.of_node)
> -		return -ENODEV;
> -
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -2226,17 +2240,16 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	adc->common = dev_get_drvdata(pdev->dev.parent);
>  	spin_lock_init(&adc->lock);
>  	init_completion(&adc->completion);
> -	adc->cfg = (const struct stm32_adc_cfg *)
> -		of_match_device(dev->driver->of_match_table, dev)->data;
> +	adc->cfg = device_get_match_data(dev);
>  
>  	indio_dev->name = dev_name(&pdev->dev);
> -	indio_dev->dev.of_node = pdev->dev.of_node;
> +	device_set_node(&indio_dev->dev, dev_fwnode(&pdev->dev));
>  	indio_dev->info = &stm32_adc_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> -	ret = of_property_read_u32(pdev->dev.of_node, "reg", &adc->offset);
> +	ret = device_property_read_u32(dev, "reg", &adc->offset);
>  	if (ret != 0) {
>  		dev_err(&pdev->dev, "missing reg property\n");
>  		return -EINVAL;
> @@ -2265,7 +2278,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	ret = stm32_adc_of_get_resolution(indio_dev);
> +	ret = stm32_adc_fw_get_resolution(indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -2282,7 +2295,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  		timestamping = true;
>  	}
>  
> -	ret = stm32_adc_chan_of_init(indio_dev, timestamping);
> +	ret = stm32_adc_chan_fw_init(indio_dev, timestamping);
>  	if (ret < 0)
>  		goto err_dma_disable;
>  
