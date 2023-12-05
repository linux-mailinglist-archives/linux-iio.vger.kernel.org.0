Return-Path: <linux-iio+bounces-619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD1B804406
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 02:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22771C20C4A
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 01:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D951375;
	Tue,  5 Dec 2023 01:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="v0hLpr6z"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF570A4;
	Mon,  4 Dec 2023 17:26:39 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 531D887635;
	Tue,  5 Dec 2023 02:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701739598;
	bh=MWoAn7LKbYyoeakQZGbI2/26BW38s5h85WiTRMPe2Ko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=v0hLpr6zk91oh4EH+pYSdlh1MGEb6oqRazHS/prMi8SDQT+iRzWYX28p2Iv/2unPD
	 Y42P9eSKVdSjqc5WvbdMVfYM2ALqk7PT8Jxx3b98VFNCB+3WQvPv02oxKv789JcklL
	 /B/o1Dpb0ehBhX5A8klhy+kqtIWPJV4bqGH1qxq7Uc2oGKz+NuhJHZp3+bNDKs44BZ
	 ion0ZkPTtk9fHoqr7qgswuqH6reyt32p06DMv0c6jYwEchYBzMWf6BqMC8goYgD2Xh
	 AGhxKGG6dMJ+Wbs/5nsOXhQ4mvDBTvbSheg0vVQco5nbrBoycjk7+h2G6TuG/9W8u3
	 OCCoDE5C3zZcw==
Message-ID: <8df89527-cd9e-4a70-8681-2b347f7c9d84@denx.de>
Date: Tue, 5 Dec 2023 02:26:36 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: light: isl76682: Add ISL76682 driver
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Andre Werner <andre.werner@systec-electronic.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rob Herring <robh+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 Vincent Tremblay <vincent@vtremblay.dev>, devicetree@vger.kernel.org
References: <20231127212726.77707-1-marex@denx.de>
 <20231127212726.77707-2-marex@denx.de> <20231204112001.7dff7066@jic23-huawei>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231204112001.7dff7066@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/4/23 12:20, Jonathan Cameron wrote:
> On Mon, 27 Nov 2023 22:26:53 +0100
> Marek Vasut <marex@denx.de> wrote:
> 
>> The ISL76682 is very basic ALS which only supports ALS or IR mode
>> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
>> other fancy functionality.
>>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> Hi Marek,
> 
> Discussion around available on v5 made me look closer at that aspect.
> You are providing all the available entries in the callback but they
> shouldn't be exposed to actually read unless the *_available bitmap
> bits corresponding to them are set.
> 
> If you like I can just rip the unused code out whilst applying?
> Or if you'd prefer to send a v7 that's great too.
> 
> Otherwise everything looks good to me.
> 
> Jonathan
> 
>> +static int integration_time_available[] = { 0, ISL76682_INT_TIME_US };
>> +
>> +static int isl76682_read_avail(struct iio_dev *indio_dev,
>> +			       struct iio_chan_spec const *chan,
>> +			       const int **vals, int *type,
>> +			       int *length, long mask)
>> +{
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_LIGHT:
>> +			*vals = illuminance_scale_available;
>> +			*length = ARRAY_SIZE(illuminance_scale_available);
>> +			*type = IIO_VAL_INT_PLUS_MICRO;
>> +			return IIO_AVAIL_LIST;
>> +		case IIO_INTENSITY:
>> +			*vals = intensity_scale_available;
>> +			*length = ARRAY_SIZE(intensity_scale_available);
>> +			*type = IIO_VAL_INT_PLUS_MICRO;
>> +			return IIO_AVAIL_LIST;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_INT_TIME:
> 
> Never used.  So can just drop this case which tidies up the question
> I h ad earlier on what the single entry array was conveying.

Seeing the diff, that now totally makes sense, thanks !

>> +		*vals = integration_time_available;
>> +		*length = ARRAY_SIZE(integration_time_available);
>> +		*type = IIO_VAL_INT_PLUS_MICRO;
>> +		return IIO_AVAIL_LIST;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static const struct iio_chan_spec isl76682_channels[] = {
>> +	{
>> +		.type = IIO_LIGHT,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> 
> Without setting	.info_mask_shared_by_all_available (unless we have a bug)
> you won't see the available attributes for INT_TIME.
> 
>> +	}, {
>> +		.type = IIO_INTENSITY,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
>> +	}
>> +};
>> +
>> +static const struct iio_info isl76682_info = {
>> +	.read_avail	= isl76682_read_avail,
>> +	.read_raw	= isl76682_read_raw,
>> +	.write_raw	= isl76682_write_raw,
>> +};
> 
> 
>> +static const struct i2c_device_id isl76682_id[] = {
>> +	{ "isl76682" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, isl76682_id);
>> +
>> +static const struct of_device_id isl76682_of_match[] = {
>> +	{ .compatible = "isil,isl76682" },
>> +	{ }
> 
> Completely trivial but why { } here and {} in the similar
> case above?  Pick one!

I sent a one-liner for this , it might make sense to squash it if possible .

