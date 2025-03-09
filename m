Return-Path: <linux-iio+bounces-16649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519F0A58866
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 22:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD0E188DE87
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 21:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68D821D59A;
	Sun,  9 Mar 2025 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="26vDq9Fq"
X-Original-To: linux-iio@vger.kernel.org
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E09312C499;
	Sun,  9 Mar 2025 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741554731; cv=none; b=p4FJFJR8sJTXh3b1pC4tCjty0crGn4Gah2Bi0RmPZ+070Op4pUR9lL6ir7z4vPFmV+PoOoy5N5Qwd6Wr2XHPUhRTDX2JW7eCHOQLRczBOpSbfuHOjUqDLVMCbKFyDdyDPrVxswWlkFYyIBPTCk26PaRv4jfVxM2k/c7sYpRBboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741554731; c=relaxed/simple;
	bh=9ioF40ZbVEJzkQXSEpKhNLoEqVeajoONLrgMecK02fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFl5k2tM8bAX8RKsece9Gwqcj9fKZY1rv2RYU87hSFp5NZAXmC5n4PU790y5DhtArFmJu1mKgHiXkG2/vRbPqOMvKs5pksTm35ZnX2k46dxwdFrlsvKUnaxo5kKtgV6SLrhDRv4u/9BnAbKYTCFDV7ceyopbbzJcd5sguYJiQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=26vDq9Fq; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [10.0.0.200] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 45235166961;
	Sun,  9 Mar 2025 22:11:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1741554718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aCJCzTtENbSqGSRiIuxdwMNGfmCr+IAB0CvV591fdjg=;
	b=26vDq9FqUk+iuV8HQuqEDugH9jyWwQZivonxYwU8hlHiNcmVWtohylXCxoPlaktKclm6eh
	yyWJ9C96I2Ucz8OU1aps+aiDZOs04+hxy6yzKyW/CRVbExPgKacY8nrv+SaC9Pot0486yI
	Cj4AYTXYGU7Yo7KIyBDSxt0AfuSbaSA=
Message-ID: <49dfbb2e-5caf-42c0-8917-baf59b6533dd@ixit.cz>
Date: Sun, 9 Mar 2025 22:11:57 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 3/4] iio: light: al3010: Implement regmap support
To: Jonathan Cameron <jic23@kernel.org>,
 David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
 <20250308-al3010-iio-regmap-v1-3-b672535e8213@ixit.cz>
 <20250309164549.26d4cdfc@jic23-huawei>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 xsFNBF5v1x4BEADS3EddwsNsvVAI1XF8uQKbdYPY/GhjaSLziwVnbwv5BGwqB1tfXoHnccoA
 9kTgKAbiXG/CiZFhD6l4WCIskQDKzyQN3JhCUIxh16Xyw0lECI7iqoW9LmMoN1dNKcUmCO9g
 lZxQaOl+1bY/7ttd7DapLh9rmBXJ2lKiMEaIpUwb/Nw0d7Enp4Jy2TpkhPywIpUn8CoJCv3/
 61qbvI9y5utB/UhfMAUXsaAgwEJyGPAqHlC0YZjaTwOu+YQUE3AFzhCbksq95CwDz4U4gdls
 dmv9tkATfu2OmzERZQ6vJTehK0Pu4l5KmCAzYg42I9Dy4E6b17x6NncKbcByQFOXMtG0qVUk
 F1yeeOQUHwu+8t3ZDMBUhCkRL/juuoqLmyDWKMc0hKNNeZ9BNXgB8fXkRLWEUfgDXsFyEkKp
 NxUy5bDRlivf6XfExnikk5kj9l2gGlNQwqROti/46bfbmlmc/a2GM4k8ZyalHNEAdwtXYSpP
 8JJmlbQ7hNTLkc3HQLRsIocN5th/ur7pPMz1Beyp0gbE9GcOceqmdZQB80vJ01XDyCAihf6l
 AMnzwpXZsjqIqH9r7T7tM6tVEVbPSwPt4eZYXSoJijEBC/43TBbmxDX+5+3txRaSCRQrG9dY
 k3mMGM3xJLCps2KnaqMcgUnvb1KdTgEFUZQaItw7HyRd6RppewARAQABzSBEYXZpZCBIZWlk
 ZWxiZXJnIDxkYXZpZEBpeGl0LmN6PsLBlAQTAQgAPgIbAwULCQgHAgYVCgkICwIEFgIDAQIe
 AQIXgBYhBNd6Cc/u3Cu9U6cEdGACP8TTSSByBQJl+KksBQkPDaAOAAoJEGACP8TTSSBy6IAQ
 AMqFqVi9LLxCEcUWBn82ssQGiVSDniKpFE/tp7lMXflwhjD5xoftoWOmMYkiWE86t5x5Fsp7
 afALx7SEDz599F1K1bLnaga+budu55JEAYGudD2WwpLJ0kPzRhqBwGFIx8k6F+goZJzxPDsf
 loAtXQE62UvEKa4KRRcZmF0GGoRsgA7vE7OnV8LMeocdD3eb2CuXLzauHAfdvqF50IfPH/sE
 jbzROiAZU+WgrwU946aOzrN8jVU+Cy8XAccGAZxsmPBfhTY5f2VN1IqvfaRdkKKlmWVJWGw+
 ycFpAEJKFRdfcc5PSjUJcALn5C+hxzL2hBpIZJdfdfStn+DWHXNgBeRDiZj1x6vvyaC43RAb
 VXvRzOQfG4EaMVMIOvBjBA/FtIpb1gtXA42ewhvPnd5RVCqD9YYUxsVpJ9d+XsAy7uib3BsV
 W2idAEsPtoqhVhq8bCUs/G4sC2DdyGZK8MRFDJqciJSUbqA+5z1ZCuE8UOPDpZKiW6H/OuOM
 zDcjh0lOzr4p+/1TSg1PbUh7fQ+nbMuiT044sC1lLtJK0+Zyn0GwhR82oNM4fldNsaHRW42w
 QGD35+eNo5Pvb3We5XRMlBdhFnj7Siggp4J8/PJ6MJvRyC+RIJPGtbdMB2/RxWunFLn87e5w
 UgwR9jPMHAstuTR1yR23c4SIYoQ2fzkrRzuazsFNBF5v1x4BEADnlrbta2WL87BlEOotZUh0
 zXANMrNV15WxexsirLetfqbs0AGCaTRNj+uWlTUDJRXOVIwzmF76Us3I2796+Od2ocNpLheZ
 7EIkq8budtLVd1c06qJ+GMraz51zfgSIazVInNMPk9T6fz0lembji5yEcNPNNBA4sHiFmXfo
 IhepHFOBApjS0CiOPqowYxSTPe/DLcJ/LDwWpTi37doKPhBwlHev1BwVCbrLEIFjY0MLM0aT
 jiBBlyLJaTqvE48gblonu2SGaNmGtkC3VoQUQFcVYDXtlL9CVbNo7BAt5gwPcNqEqkUL60Jh
 FtvVSKyQh6gn7HHsyMtgltjZ3NKjv8S3yQd7zxvCn79tCKwoeNevsvoMq/bzlKxc9QiKaRPO
 aDj3FtW7R/3XoKJBY8Hckyug6uc2qYWRpnuXc0as6S0wfek6gauExUttBKrtSbPPHiuTeNHt
 NsT4+dyvaJtQKPBTbPHkXpTO8e1+YAg7kPj3aKFToE/dakIh8iqUHLNxywDAamRVn8Ha67WO
 AEAA3iklJ49QQk2ZyS1RJ2Ul28ePFDZ3QSr9LoJiOBZv9XkbhXS164iRB7rBZk6ZRVgCz3V6
 hhhjkipYvpJ/fpjXNsVL8jvel1mYNf0a46T4QQDQx4KQj0zXJbC2fFikAtu1AULktF4iEXEI
 rSjFoqhd4euZ+QARAQABwsF8BBgBCAAmAhsMFiEE13oJz+7cK71TpwR0YAI/xNNJIHIFAmX4
 qVAFCQ8NoDIACgkQYAI/xNNJIHKN4A/+Ine2Ii7JiuGITjJkcV6pgKlfwYdEs4eFD1pTRb/K
 5dprUz3QSLP41u9OJQ23HnESMvn31UENk9ffebNoW7WxZ/8cTQY0JY/cgTTrlNXtyAlGbR3/
 3Q/VBJptf04Er7I6TaKAmqWzdVeKTw33LljpkHp02vrbOdylb4JQG/SginLV9purGAFptYRO
 8JNa2J4FAQtQTrfOUjulOWMxy7XRkqK3QqLcPW79/CFn7q1yxamPkpoXUJq9/fVjlhk7P+da
 NYQpe4WQQnktBY29SkFnvfIAwqIVU8ix5Oz8rghuCcAdR7lEJ7hCX9bR0EE05FOXdZy5FWL9
 GHvFa/Opkq3DPmFl/0nt4HJqq1Nwrr+WR6d0414oo1n2hPEllge/6iD3ZYwptTvOFKEw/v0A
 yqOoYSiKX9F7Ko7QO+VnYeVDsDDevKic2T/4GDpcSVd9ipiKxCQvUAzKUH7RUpqDTa+rYurm
 zRKcgRumz2Tc1ouHj6qINlzEe3a5ldctIn/dvR1l2Ko7GBTG+VGp9U5NOAEkGpxHG9yg6eeY
 fFYnMme51H/HKiyUlFiE3yd5LSmv8Dhbf+vsI4x6BOOOq4Iyop/Exavj1owGxW0hpdUGcCl1
 ovlwVPO/6l/XLAmSGwdnGqok5eGZQzSst0tj9RC9O0dXO1TZocOsf0tJ8dR2egX4kxM=
In-Reply-To: <20250309164549.26d4cdfc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/03/2025 17:45, Jonathan Cameron wrote:
> On Sat, 08 Mar 2025 21:01:00 +0100
> David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:
> 
>> From: David Heidelberg <david@ixit.cz>
>>
>> Modernize and make driver a bit cleaner.
>>
>> Incorporate most of the feedback given on new AL3000A.
> Hi David,
> 
> Why does regmap bring benefits here?  This seems to be a like for like
> change (no use of additional helpers / caching etc) so I'm not immediately
> seeing the advantage.

As I mentioned in the summary, the change is smaller binary size and 
being in sync with al3000a. Since al3xxx series drivers are pretty close 
to each other, I believe for future maintenance having them in pair, 
where it's possible is beneficial.
> 
> Various comments inline. Main one is this is doing several not particularly
> closely related changes that belong in separate patches.

I'm aware I should likely address the changes in smaller chunks, but as 
I get this patch tested, it's fairly small patch, so I would believe 
it's still bearable size of the change? If not, I'll split changes into 
separate patches.
> 
> Jonathan
> 
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>   drivers/iio/light/al3010.c | 95 ++++++++++++++++++++++++++--------------------
>>   1 file changed, 53 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
>> index 7cbb8b203300907a88f4a0ab87da89cabdd087f3..f6ed7246864a777fdb7d3861b74f5834e8af4105 100644
>> --- a/drivers/iio/light/al3010.c
>> +++ b/drivers/iio/light/al3010.c
>> @@ -4,7 +4,7 @@
>>    *
>>    * Copyright (c) 2014, Intel Corporation.
>>    * Copyright (c) 2016, Dyna-Image Corp.
>> - * Copyright (c) 2020, David Heidelberg, Michał Mirosław, Dmitry Osipenko
>> + * Copyright (c) 2020 - 2025, David Heidelberg, Michał Mirosław, Dmitry Osipenko
> 
> This implies all 3 of you were involved in this update. If that's not
> the case perhaps just add a new copyright line for this change.
> 
>>    *
>>    * IIO driver for AL3010 (7-bit I2C slave address 0x1C).
>>    *
> 
>>   
>>   static const struct iio_chan_spec al3010_channels[] = {
>> @@ -69,40 +76,32 @@ static const struct attribute_group al3010_attribute_group = {
>>   	.attrs = al3010_attributes,
>>   };
>>   
>> -static int al3010_set_pwr(struct i2c_client *client, bool pwr)
>> +static int al3010_set_pwr_on(struct al3010_data *data)
>>   {
>> -	u8 val = pwr ? AL3010_CONFIG_ENABLE : AL3010_CONFIG_DISABLE;
>> -	return i2c_smbus_write_byte_data(client, AL3010_REG_SYSTEM, val);
>> +	return regmap_write(data->regmap, AL3010_REG_SYSTEM, AL3010_CONFIG_ENABLE);
> Splitting this write into the on and off cases is a change that is
> not closely related to regmap change, so probably wants to be in a separate
> patch.

Sure, I can do.

> 
>>   }
>>   
>>   static void al3010_set_pwr_off(void *_data)
>>   {
>>   	struct al3010_data *data = _data;
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>>   
>> -	al3010_set_pwr(data->client, false);
>> +	ret = regmap_write(data->regmap, AL3010_REG_SYSTEM, AL3010_CONFIG_DISABLE);
>> +	if (ret)
>> +		dev_err(dev, "failed to write system register\n");
>>   }
>>   
>>   static int al3010_init(struct al3010_data *data)
>>   {
>>   	int ret;
>>   
>> -	ret = al3010_set_pwr(data->client, true);
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	ret = devm_add_action_or_reset(&data->client->dev,
>> -				       al3010_set_pwr_off,
>> -				       data);
> 
> As below. Not obvious to me why we'd want to move this.
> 
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
>> -					FIELD_PREP(AL3010_GAIN_MASK,
>> -						   AL3XXX_RANGE_3));
>> -	if (ret < 0)
>> +	ret = al3010_set_pwr_on(data);
>> +	if (ret)
>>   		return ret;
>>   
>> -	return 0;
>> +	return regmap_write(data->regmap, AL3010_REG_CONFIG,
>> +			    FIELD_PREP(AL3010_GAIN_MASK, AL3XXX_RANGE_3));
>>   }
>>   
>>   static int al3010_read_raw(struct iio_dev *indio_dev,
>> @@ -110,7 +109,7 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
>>   			   int *val2, long mask)
>>   {
>>   	struct al3010_data *data = iio_priv(indio_dev);
>> -	int ret;
>> +	int ret, value;
>>   
>>   	switch (mask) {
>>   	case IIO_CHAN_INFO_RAW:
>> @@ -119,21 +118,21 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
>>   		 * - low byte of output is stored at AL3010_REG_DATA_LOW
>>   		 * - high byte of output is stored at AL3010_REG_DATA_LOW + 1
>>   		 */
>> -		ret = i2c_smbus_read_word_data(data->client,
>> -					       AL3010_REG_DATA_LOW);
>> -		if (ret < 0)
>> +		ret = regmap_read(data->regmap, AL3010_REG_DATA_LOW, &value);
>> +		if (ret)
>>   			return ret;
>> -		*val = ret;
>> +
>> +		*val = value;
>> +
>>   		return IIO_VAL_INT;
>>   	case IIO_CHAN_INFO_SCALE:
>> -		ret = i2c_smbus_read_byte_data(data->client,
>> -					       AL3010_REG_CONFIG);
>> -		if (ret < 0)
>> +		ret = regmap_read(data->regmap, AL3010_REG_CONFIG, &value);
>> +		if (ret)
>>   			return ret;
>>   
>> -		ret = FIELD_GET(AL3010_GAIN_MASK, ret);
>> -		*val = al3010_scales[ret][0];
>> -		*val2 = al3010_scales[ret][1];
>> +		value = FIELD_GET(AL3010_GAIN_MASK, value);
> I'm never a big fan of conflating use of one variable for the register value
> (where value is a reasonable name) and the field extract from it where
> it's not really. scale_idx or something like that would make more sense for
> this second case.

I originally had name gain for this one, but decided to go with generic 
value to cover all cases. If you want, I can go back to custom name per 
case.
> 
>> +		*val = al3010_scales[value][0];
>> +		*val2 = al3010_scales[value][1];
>>   
>>   		return IIO_VAL_INT_PLUS_MICRO;
>>   	}
>> @@ -145,7 +144,7 @@ static int al3010_write_raw(struct iio_dev *indio_dev,
>>   			    int val2, long mask)
>>   {
>>   	struct al3010_data *data = iio_priv(indio_dev);
>> -	int i;
>> +	unsigned int i;
> 
> Looks like an unrelated change.  Possibly even one that isn't worth making.

Well, I was at editing and as i is used within array id, it cannot be 
signed integer, second it's also compared against u8, so IMHO it make 
sense here.

> 
>>   
>>   	switch (mask) {
>>   	case IIO_CHAN_INFO_SCALE:
>> @@ -154,9 +153,8 @@ static int al3010_write_raw(struct iio_dev *indio_dev,
>>   			    val2 != al3010_scales[i][1])
>>   				continue;
>>   
>> -			return i2c_smbus_write_byte_data(data->client,
>> -					AL3010_REG_CONFIG,
>> -					FIELD_PREP(AL3010_GAIN_MASK, i));
>> +			return regmap_write(data->regmap, AL3010_REG_CONFIG,
>> +					    FIELD_PREP(AL3010_GAIN_MASK, i));
>>   		}
>>   		break;
>>   	}
>> @@ -172,16 +170,20 @@ static const struct iio_info al3010_info = {
>>   static int al3010_probe(struct i2c_client *client)
>>   {
>>   	struct al3010_data *data;
>> +	struct device *dev = &client->dev;
> 
> This is confusing two things.  I'd prefer a precursor patch that
> adds the local variable followed by one that adds the regmap stuff.

Sure, I can split it into additional patch.

> 
>>   	struct iio_dev *indio_dev;
>>   	int ret;
>>   
>> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>>   	if (!indio_dev)
>>   		return -ENOMEM;
>>   
>>   	data = iio_priv(indio_dev);
>>   	i2c_set_clientdata(client, indio_dev);
>> -	data->client = client;
>> +	data->regmap = devm_regmap_init_i2c(client, &al3010_regmap_config);
>> +	if (IS_ERR(data->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
>> +				     "cannot allocate regmap\n");
>>   
>>   	indio_dev->info = &al3010_info;
>>   	indio_dev->name = AL3010_DRV_NAME;
>> @@ -191,21 +193,30 @@ static int al3010_probe(struct i2c_client *client)
>>   
>>   	ret = al3010_init(data);
>>   	if (ret < 0) {
>> -		dev_err(&client->dev, "al3010 chip init failed\n");
>> +		dev_err(dev, "failed to init ALS\n");
>>   		return ret;
>>   	}
>>   
>> -	return devm_iio_device_register(&client->dev, indio_dev);
>> +	ret = devm_add_action_or_reset(dev, al3010_set_pwr_off, data);
> 
> Moving this out here doesn't look like a change related to regmap.
> Generally I'd prefer that stayed next to where the power on is as this
> is not obviously undoing the al3010_init() given naming etc.

Sure, I'll move it back.

Thank you for the feedback,
> 
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>>   }

-- 
David Heidelberg


