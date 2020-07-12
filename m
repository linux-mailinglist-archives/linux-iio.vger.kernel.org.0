Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5821CB31
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jul 2020 21:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgGLTyC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jul 2020 15:54:02 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:45725 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgGLTyC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jul 2020 15:54:02 -0400
Received: from webmail.gandi.net (webmail15.sd4.0x35.net [10.200.201.15])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay11.mail.gandi.net (Postfix) with ESMTPA id C3302100005;
        Sun, 12 Jul 2020 19:53:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 Jul 2020 21:53:57 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/6] iio/adc: ingenic: Retrieve channels list from soc
 data struct
In-Reply-To: <20200712131130.350fd3c7@archlinux>
References: <20200709152200.10039-1-contact@artur-rojek.eu>
 <20200709152200.10039-5-contact@artur-rojek.eu>
 <20200712130713.64cd2bac@archlinux> <20200712131130.350fd3c7@archlinux>
Message-ID: <3f9ced8ead2f13bc73c4345f7751b3d0@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
User-Agent: Roundcube Webmail/1.3.13
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-07-12 14:11, Jonathan Cameron wrote:
> On Sun, 12 Jul 2020 13:07:13 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Thu,  9 Jul 2020 17:21:58 +0200
>> Artur Rojek <contact@artur-rojek.eu> wrote:
>> 
>> > From: Paul Cercueil <paul@crapouillou.net>
>> >
>> > Instead of having one array of struct iio_chan_spec for all SoCs, and
>> > have some SoCs remove the last item of the array as they can't use it,
>> > have each SoC define its array of supported channels.
>> >
>> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> > Tested-by: Artur Rojek <contact@artur-rojek.eu>
>> Applied to the togreg branch of iio.git and pushed out as testing for
>> autobuilders to play with it.
> Actually removed from tree again.
> 
> Artur, as you sent this patch on to me, you need to sign-off on it
> so we maintain the DCO related records of how this got to the kernel.
> You can just reply here to give it.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

Thanks,
Artur

> 
> Thanks,
> 
> Jonathan
> 
>> 
>> Thanks,
>> 
>> Jonathan
>> 
>> > ---
>> >
>> >  Changes:
>> >
>> >  v8: new patch
>> >
>> >  drivers/iio/adc/ingenic-adc.c | 99 +++++++++++++++++++++++------------
>> >  1 file changed, 65 insertions(+), 34 deletions(-)
>> >
>> > diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
>> > index 89019fb59d48..0233a9055c86 100644
>> > --- a/drivers/iio/adc/ingenic-adc.c
>> > +++ b/drivers/iio/adc/ingenic-adc.c
>> > @@ -55,6 +55,8 @@ struct ingenic_adc_soc_data {
>> >  	size_t battery_scale_avail_size;
>> >  	unsigned int battery_vref_mode: 1;
>> >  	unsigned int has_aux2: 1;
>> > +	const struct iio_chan_spec *channels;
>> > +	unsigned int num_channels;
>> >  	int (*init_clk_div)(struct device *dev, struct ingenic_adc *adc);
>> >  };
>> >
>> > @@ -262,6 +264,61 @@ static int jz4770_adc_init_clk_div(struct device *dev, struct ingenic_adc *adc)
>> >  	return 0;
>> >  }
>> >
>> > +static const struct iio_chan_spec jz4740_channels[] = {
>> > +	{
>> > +		.extend_name = "aux",
>> > +		.type = IIO_VOLTAGE,
>> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> > +				      BIT(IIO_CHAN_INFO_SCALE),
>> > +		.indexed = 1,
>> > +		.channel = INGENIC_ADC_AUX,
>> > +		.scan_index = -1,
>> > +	},
>> > +	{
>> > +		.extend_name = "battery",
>> > +		.type = IIO_VOLTAGE,
>> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> > +				      BIT(IIO_CHAN_INFO_SCALE),
>> > +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW) |
>> > +						BIT(IIO_CHAN_INFO_SCALE),
>> > +		.indexed = 1,
>> > +		.channel = INGENIC_ADC_BATTERY,
>> > +		.scan_index = -1,
>> > +	},
>> > +};
>> > +
>> > +static const struct iio_chan_spec jz4770_channels[] = {
>> > +	{
>> > +		.extend_name = "aux",
>> > +		.type = IIO_VOLTAGE,
>> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> > +				      BIT(IIO_CHAN_INFO_SCALE),
>> > +		.indexed = 1,
>> > +		.channel = INGENIC_ADC_AUX,
>> > +		.scan_index = -1,
>> > +	},
>> > +	{
>> > +		.extend_name = "battery",
>> > +		.type = IIO_VOLTAGE,
>> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> > +				      BIT(IIO_CHAN_INFO_SCALE),
>> > +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW) |
>> > +						BIT(IIO_CHAN_INFO_SCALE),
>> > +		.indexed = 1,
>> > +		.channel = INGENIC_ADC_BATTERY,
>> > +		.scan_index = -1,
>> > +	},
>> > +	{
>> > +		.extend_name = "aux2",
>> > +		.type = IIO_VOLTAGE,
>> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> > +				      BIT(IIO_CHAN_INFO_SCALE),
>> > +		.indexed = 1,
>> > +		.channel = INGENIC_ADC_AUX2,
>> > +		.scan_index = -1,
>> > +	},
>> > +};
>> > +
>> >  static const struct ingenic_adc_soc_data jz4725b_adc_soc_data = {
>> >  	.battery_high_vref = JZ4725B_ADC_BATTERY_HIGH_VREF,
>> >  	.battery_high_vref_bits = JZ4725B_ADC_BATTERY_HIGH_VREF_BITS,
>> > @@ -271,6 +328,8 @@ static const struct ingenic_adc_soc_data jz4725b_adc_soc_data = {
>> >  	.battery_scale_avail_size = ARRAY_SIZE(jz4725b_adc_battery_scale_avail),
>> >  	.battery_vref_mode = true,
>> >  	.has_aux2 = false,
>> > +	.channels = jz4740_channels,
>> > +	.num_channels = ARRAY_SIZE(jz4740_channels),
>> >  	.init_clk_div = jz4725b_adc_init_clk_div,
>> >  };
>> >
>> > @@ -283,6 +342,8 @@ static const struct ingenic_adc_soc_data jz4740_adc_soc_data = {
>> >  	.battery_scale_avail_size = ARRAY_SIZE(jz4740_adc_battery_scale_avail),
>> >  	.battery_vref_mode = true,
>> >  	.has_aux2 = false,
>> > +	.channels = jz4740_channels,
>> > +	.num_channels = ARRAY_SIZE(jz4740_channels),
>> >  	.init_clk_div = NULL, /* no ADCLK register on JZ4740 */
>> >  };
>> >
>> > @@ -295,6 +356,8 @@ static const struct ingenic_adc_soc_data jz4770_adc_soc_data = {
>> >  	.battery_scale_avail_size = ARRAY_SIZE(jz4770_adc_battery_scale_avail),
>> >  	.battery_vref_mode = false,
>> >  	.has_aux2 = true,
>> > +	.channels = jz4770_channels,
>> > +	.num_channels = ARRAY_SIZE(jz4770_channels),
>> >  	.init_clk_div = jz4770_adc_init_clk_div,
>> >  };
>> >
>> > @@ -427,35 +490,6 @@ static const struct iio_info ingenic_adc_info = {
>> >  	.of_xlate = ingenic_adc_of_xlate,
>> >  };
>> >
>> > -static const struct iio_chan_spec ingenic_channels[] = {
>> > -	{
>> > -		.extend_name = "aux",
>> > -		.type = IIO_VOLTAGE,
>> > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> > -				      BIT(IIO_CHAN_INFO_SCALE),
>> > -		.indexed = 1,
>> > -		.channel = INGENIC_ADC_AUX,
>> > -	},
>> > -	{
>> > -		.extend_name = "battery",
>> > -		.type = IIO_VOLTAGE,
>> > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> > -				      BIT(IIO_CHAN_INFO_SCALE),
>> > -		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW) |
>> > -						BIT(IIO_CHAN_INFO_SCALE),
>> > -		.indexed = 1,
>> > -		.channel = INGENIC_ADC_BATTERY,
>> > -	},
>> > -	{ /* Must always be last in the array. */
>> > -		.extend_name = "aux2",
>> > -		.type = IIO_VOLTAGE,
>> > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> > -				      BIT(IIO_CHAN_INFO_SCALE),
>> > -		.indexed = 1,
>> > -		.channel = INGENIC_ADC_AUX2,
>> > -	},
>> > -};
>> > -
>> >  static int ingenic_adc_probe(struct platform_device *pdev)
>> >  {
>> >  	struct device *dev = &pdev->dev;
>> > @@ -517,11 +551,8 @@ static int ingenic_adc_probe(struct platform_device *pdev)
>> >  	iio_dev->dev.parent = dev;
>> >  	iio_dev->name = "jz-adc";
>> >  	iio_dev->modes = INDIO_DIRECT_MODE;
>> > -	iio_dev->channels = ingenic_channels;
>> > -	iio_dev->num_channels = ARRAY_SIZE(ingenic_channels);
>> > -	/* Remove AUX2 from the list of supported channels. */
>> > -	if (!adc->soc_data->has_aux2)
>> > -		iio_dev->num_channels -= 1;
>> > +	iio_dev->channels = soc_data->channels;
>> > +	iio_dev->num_channels = soc_data->num_channels;
>> >  	iio_dev->info = &ingenic_adc_info;
>> >
>> >  	ret = devm_iio_device_register(dev, iio_dev);
>> 
