Return-Path: <linux-iio+bounces-7129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7001C923DE4
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 14:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BA21C24A4F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FC61448E1;
	Tue,  2 Jul 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVKLj4VQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E01D823DE;
	Tue,  2 Jul 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923452; cv=none; b=m4uf6C7QIRW35J+IO/FQ0sjcCCIVCw3fWVVXpKGVnkTStRYsULcnzowE6bYM+PUO5QRx4E7DgGO7WCPBX2kZwEiUHBfQPYSfr4E9sR1kM0gfuZCVgA2uy1d6zXG/Mcnb9PK0GXQ6rckF/r0cPiMml17env7QgCnb1KPHdOahgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923452; c=relaxed/simple;
	bh=tZZmdPtZa7o8s+dgyjbj+fo+ry5pkzlsXO2DbaNWqAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwjl1CY4OVQGH1WqMuavoI01fgwZzMIjBlou4JpgCjJWbRUiUP7ovFFNLfy9DqVJ22WdABhUO2s3hB+P+OijBYGHsZAA+ElvhAhRGCi09UXAApiTUTsRbHLBp9X+Mqxp08/tPTRpPNAQwDrspJA54mbL+e5q5KXWMO7bf50qT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVKLj4VQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb0d88fd25so121095ad.0;
        Tue, 02 Jul 2024 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719923450; x=1720528250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6JTFR+8sSGfzBmAKFiUqZIl2Gfl8BPeTwXrzS0eek04=;
        b=SVKLj4VQ4loq6cl5qIyFTBTr7iTNsJ2BSbbdPDNadM1gMXXzwWOkp4B730Y7nZbhmU
         l86Jp7YROvH+D+vNs60Q9Q+vDBIuLLiLr7wkBPgoGPDxsXj0waS6i4sbeurvhTtneGL8
         rEcMpYLymFFIQVfSqUk1tLbRhWltqur9pwlcJ8FtNMBT94TLT9nGLrOFL96rIHXO7+Ah
         QKrSu/US7RJ4s13ScNUgK3yzmXUVGOAiKGPgMqBAoyFlUq62gP2VA9Vurs2NF9Gb/nUK
         XlMZKtPGMHWfJ5OJ0FXJurdO2XwGWDPEBoS0VmYw2VzptYKbqbjKQhT3wA5jjS29K4Na
         Jffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923450; x=1720528250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JTFR+8sSGfzBmAKFiUqZIl2Gfl8BPeTwXrzS0eek04=;
        b=D1uaKuiVJ4Akh5peVlOzdNaFmwKQJWJ1owzb35bwXcOTTl+uo2tL695BiY3a4z2yEo
         4SE2ZGQU7HlUnACCrtjkYBkr6PBUZl/7Y1n0cmCW7bdteLzd9ixYsiPiDOkOTPXFgr7J
         Cs8CyRu6YXPEFvtAinAVIyvuV2BfXh0B1Lhkev2WLs5Vij/og0WZL8fi6LUJji//Vky1
         yIoI9BTC4QCs3LFSCw+c2D6fs9jViHry/u6rv0AjR6IZ324PtARHTOd4zWdHfmCy/CsR
         ZC1XqPDrmFGw4G0ZjAYLy84JmHL6y8qJZR6mDWG4qE8yD5h4pYWeSUxO0rCBocUnr+p3
         h08w==
X-Forwarded-Encrypted: i=1; AJvYcCURoEBA2EO5Uc51zEiobRnhB0ZB3/dggP0c+cVM2BwkXowatpMTizTMt8sMsJpnoOQQRMpeB7ItcTc7ll2LMRwPZIV3p0TD7qnzp75jeuTkmbGlOA4sJLD8aabvXKQIbJ9ZAHVZs1MJ+NpruaXSy+jtIxUVfjcze/yBOA2re/OiXwVU5w==
X-Gm-Message-State: AOJu0YybX0PoJ0JrEgpgeGN6uLRlENBXO1ldyck6FN/tUPSDy1Ycp9l1
	vSkvpfDgzFSRU7FqjEnamCMehf90gLpu8EszPlDeQ+uFM9T79ZMwtEOrCwPSWr/Pdfrm
X-Google-Smtp-Source: AGHT+IGWzbKBKvyWYvOUE+ZR+SxhDi5+un4Oel8Tex8bd3y9uIHjAMegfEc6WGFF30FDc5O6HxR7Tg==
X-Received: by 2002:a17:902:e744:b0:1f9:ad91:f8d0 with SMTP id d9443c01a7336-1fac7e4b700mr180240345ad.8.1719923449356;
        Tue, 02 Jul 2024 05:30:49 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596915sm82833945ad.245.2024.07.02.05.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 05:30:48 -0700 (PDT)
Message-ID: <202d3ded-df65-4b91-bd53-045136ea4346@gmail.com>
Date: Tue, 2 Jul 2024 20:30:40 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] iio: proximity: Add driver support for TYHX's
 HX9023S capacitive proximity sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 yasin.lee.x@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20240625-add-tyhx-hx9023s-sensor-driver-v8-0-0c224e3bddbc@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v8-3-0c224e3bddbc@gmail.com>
 <20240629194122.1f4b7b3b@jic23-huawei>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <20240629194122.1f4b7b3b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/6/30 02:41, Jonathan Cameron wrote:
> On Tue, 25 Jun 2024 23:58:54 +0800
> Yasin Lee <yasin.lee.x@gmail.com> wrote:
>
>> A SAR sensor from NanjingTianyihexin Electronics Ltd.
>>
>> The device has the following entry points:
>>
>> Usual frequency:
>> - sampling_frequency
>>
>> Instant reading of current values for different sensors:
>> - in_proximity0_raw
>> - in_proximity1_raw
>> - in_proximity2_raw
>> - in_proximity3_raw
>> - in_proximity4_raw
>> and associated events in events/
>>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> Hi Yasin
>
> Definitely getting close to ready to merge.
> A few bits of review feedback inline to resolve.
>
> Jonathan
>

Hi Jonathan,


Thank you very much for your patient guidance and encouragement. I have 
made modifications and responses to each comment. Please review version V9.

Best regards,

Yasin


>> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
>> new file mode 100644
>> index 000000000000..c455f20d784f
>> --- /dev/null
>> +++ b/drivers/iio/proximity/hx9023s.c
>> @@ -0,0 +1,1131 @@
>> +
>> +#define HX9023S_CHIP_ID 0x1D
>> +#define HX9023S_CH_NUM 5
>> +#define HX9023S_2BYTES 2
>> +#define HX9023S_3BYTES 3
> Don't use defines where the number is actually more meaningful
> when seen in the code.
>
>> +#define HX9023S_BYTES_MAX HX9023S_3BYTES
> This define is useful but just make it 3.
>

These three macro definitions will be deleted in version V9.


>> +struct hx9023s_ch_data {
>> +	int raw; /* Raw Data*/
>> +	int lp; /* Low Pass Filter Data*/
>> +	int bl; /* Base Line Data */
>> +	int diff; /* difference of Low Pass Data and Base Line Data */
> Difference
>
> for consistency of capitalizaton.
>

Fixed in v9.


>> +static int hx9023s_ch_cfg(struct hx9023s_data *data)
>> +{
>> +	unsigned int i;
>> +	u16 reg;
>> +	u8 reg_list[HX9023S_CH_NUM * 2];
>> +	u8 ch_pos[HX9023S_CH_NUM];
>> +	u8 ch_neg[HX9023S_CH_NUM];
>> +	/* Bit positions corresponding to input pin connections */
>> +	u8 conn_cs[HX9023S_CH_NUM] = {0, 2, 4, 6, 8};
> Space after { and before }


Fixed in v9.


>> +
>> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +		ch_pos[i] = data->ch_data[i].channel_positive == HX9023S_NOT_CONNECTED ?
>> +			HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_positive];
>> +		ch_neg[i] = data->ch_data[i].channel_negative == HX9023S_NOT_CONNECTED ?
>> +			HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_negative];
>> +
>> +		reg = (HX9023S_POS << ch_pos[i]) | (HX9023S_NEG << ch_neg[i]);
>> +		put_unaligned_le16(reg, &reg_list[i * 2]);
>> +	}
>> +
>> +	return regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
>> +}
>> +
>> +static int hx9023s_sample(struct hx9023s_data *data)
>> +{
>> +	int ret, value;
>> +	unsigned int i;
>> +	u8 data_size, offset_data_size, *p, size, rx_buf[HX9023S_CH_NUM * HX9023S_BYTES_MAX];
> Long line combining different data types. Break them up to improve readability.
>
> 	u8 rx_buf[HX9023S_CH_NUM * HX9023S_BYTES_MAX];
> 	u8 data_size, offset_data_size, size;
> 	u8 *p;


Delete: data_size, offset_data_size, *p, size.


>> +
>> +	ret = hx9023s_data_lock(data, true);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = hx9023s_data_select(data);
>> +	if (ret)
>> +		goto err;
>> +
>> +	data_size = HX9023S_3BYTES;
> This local variable hurts readabilty.


Deleted.


>> +
>> +	/* ch0~ch3 */
>> +	p = rx_buf;
> Why local variable?


Deleted.


>> +	size = (HX9023S_CH_NUM - 1) * data_size;
> This is non obvious sizing.  Here a comment is appropriate.
>
> /* 3 bytes for each of channels 0 to 3 which have contiguous registers */
>
>> +	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, p, size);
> Combining above comments.
>
> 	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, &rx_buf, size);
>
>> +	if (ret)
>> +		goto err;
>> +
>> +	/* ch4 */
>> +	p = rx_buf + size;
>> +	size = data_size;
> Here as well provide a comment on the fact the channel is 3 contiguous registers.
>

Added concise comments as suggested, deleted excessive macro 
definitions, and used direct numbers for clarity.


>> +	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH4_0, p, size);
>> +	if (ret)
>> +		goto err;
>> +
>> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +		value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
> This seems odd.  From the datasheet I found seems there are some bits in
> the ch0_0 register as well. Why just pull out 16 bits?
>
> I would use a get_unaligned_le24() call to get the rest and then rely on
> shift for userspace to drop bits 3:0
>
> It it makes sense to just provide the top 16 bits thats fine.


Based on the chip designer's explanation, the lower 8-bit data is almost 
meaningless, and users are advised to use only the upper 16-bit data. 
Therefore, I kept get_unaligned_le16().


>> +		value = sign_extend32(value, 15);
> Why use int to store an s16?  If you just use an s16 for value then no
> need to sign extend and then store that into an s16 .raw in the channel
> data structure.
>

Using int is incorrect. I will take your advice, delete sign_extend32, 
and directly store the data in s16.


>> +		data->ch_data[i].raw = 0;
>> +		data->ch_data[i].bl = 0;
>> +		if (data->ch_data[i].sel_raw)
>> +			data->ch_data[i].raw = value;
>> +		if (data->ch_data[i].sel_bl)
>> +			data->ch_data[i].bl = value;
>> +	}
>> +
>> +	/* ch0~ch3 */
>> +	p = rx_buf;
>> +	size = (HX9023S_CH_NUM - 1) * data_size;
> As above - use a comment to explain why this is 12 then just use 12.
> Current form is far form obvious.


I will take this suggestion and update it in V9.


>> +	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH0_0, p, size);
>> +	if (ret)
>> +		goto err;
>> +
>> +	/* ch4 */
>> +	p = rx_buf + size;
>> +	size = data_size;
>> +	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH4_0, p, size);
>> +	if (ret)
>> +		goto err;
>> +
>> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +		value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
>> +		value = sign_extend32(value, 15);
>> +		data->ch_data[i].lp = 0;
>> +		data->ch_data[i].diff = 0;
>> +		if (data->ch_data[i].sel_lp)
>> +			data->ch_data[i].lp = value;
>> +		if (data->ch_data[i].sel_diff)
>> +			data->ch_data[i].diff = value;
>> +	}
>> +
>> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +		if (data->ch_data[i].sel_lp && data->ch_data[i].sel_bl)
>> +			data->ch_data[i].diff = data->ch_data[i].lp - data->ch_data[i].bl;
>> +	}
>> +
>> +	/* offset DAC */
>> +	offset_data_size = HX9023S_2BYTES;
>> +	p = rx_buf;
>> +	size = HX9023S_CH_NUM * offset_data_size;
>> +	ret = regmap_bulk_read(data->regmap, HX9023S_OFFSET_DAC0_7_0, p, size);
>> +	if (ret)
>> +		goto err;
>> +
>> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +		value = get_unaligned_le16(&rx_buf[i * offset_data_size]);
>> +		value = FIELD_GET(GENMASK(11, 0), value);
>> +		data->ch_data[i].dac = value;
>> +	}
>> +
>> +err:
>> +	return hx9023s_data_lock(data, false);
>> +}
>
>> +
>> +static int hx9023s_property_get(struct hx9023s_data *data)
>> +{
>> +	struct fwnode_handle *child;
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +	u32 i, reg, temp, array[2];
>> +
>> +	data->chan_in_use = 0;
>> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +		data->ch_data[i].channel_positive = HX9023S_NOT_CONNECTED;
>> +		data->ch_data[i].channel_negative = HX9023S_NOT_CONNECTED;
>> +	}
>> +
>> +	device_for_each_child_node(dev, child) {
> Use
> 	device_for_each_child_node_scoped(dev, child) {
> As then no need to call fwnode_handle_put() in error paths.


I will take this suggestion and update it in V9.


>> +		ret = fwnode_property_read_u32(child, "reg", &reg);
>> +		if (ret || reg >= HX9023S_CH_NUM) {
>> +			fwnode_handle_put(child);
>> +			return dev_err_probe(dev, ret, "Failed to read reg\n");
>> +		}
>> +		__set_bit(reg, &data->chan_in_use);
>> +
>> +		if (fwnode_property_read_u32(child, "input-channel", &temp) == 0) {
>> +			data->ch_data[reg].channel_positive = temp;
>> +			data->ch_data[reg].channel_negative = HX9023S_NOT_CONNECTED;
>> +		} else if (fwnode_property_read_u32_array(child, "diff-channels",
>> +							array, sizeof(array)) == 0) {
>> +			data->ch_data[reg].channel_positive = array[0];
>> +			data->ch_data[reg].channel_negative = array[1];
>> +		} else {
>> +			fwnode_handle_put(child);
>> +			return dev_err_probe(dev, ret,
>> +				"Failed to read channel input for channel %d\n", reg);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>
>> +
>> +static void hx9023s_push_events(struct iio_dev *indio_dev)
>> +{
>> +	struct hx9023s_data *data = iio_priv(indio_dev);
>> +	s64 timestamp = iio_get_time_ns(indio_dev);
>> +	unsigned long prox_changed;
>> +	unsigned int chan;
>> +
>> +	hx9023s_sample(data);
> check the return codes for these calls that involve bus transactions.
> If they fail, just return form this function having not pushed an event.
>
> Otherwise we may push stale data.


Fixed in v9


>> +	hx9023s_get_prox_state(data);
>> +
>> +	prox_changed = (data->chan_prox_stat ^ data->prox_state_reg) & data->chan_event;
>> +	for_each_set_bit(chan, &prox_changed, HX9023S_CH_NUM) {
>> +		unsigned int dir;
>> +
>> +		dir = (data->prox_state_reg & BIT(chan)) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
>> +
>> +		iio_push_event(indio_dev,
>> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan, IIO_EV_TYPE_THRESH, dir),
>> +			       timestamp);
>> +	}
>> +	data->chan_prox_stat = data->prox_state_reg;
>> +}
>
>
>
>
>
>> +static int hx9023s_id_check(struct iio_dev *indio_dev)
>> +{
>> +	struct hx9023s_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +	unsigned int id;
>> +
>> +	ret = regmap_read(data->regmap, HX9023S_DEVICE_ID, &id);
>> +	if (ret || id != HX9023S_CHIP_ID)
>> +		return -ENODEV;
> This breaks the use of callback compatible IDs in future. It is only
> appropriate to print a warning on an unknown ID .
> Also don't eat the error value returned - it may provide a useful hint
> of a problem.
>
> 	if (ret)
> 		return ret;
>
> 	if (id != HX9023S_CHIP_ID)
> 		dev_warn(&indio_dev->dev.parent,
> 			 "Unexpected chip ID, assuming compatible\n");
>
> 	return 0;
>
> there are lots of older drivers where we did this wrong. We tend to
> repair this when otherwise working on a driver, so it will take a
> while before they are all fixed.
>

I will take this suggestion and update it in V9.


>> +
>> +	return 0;
>> +}
>> +
>> +static int hx9023s_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct hx9023s_data *data;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	mutex_init(&data->mutex);
>> +
>> +	data->regmap = devm_regmap_init_i2c(client, &hx9023s_regmap_config);
>> +	if (IS_ERR(data->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap init failed\n");
>> +
>> +	ret = hx9023s_property_get(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "dts phase failed\n");
>> +
>> +	ret = devm_regulator_get_enable(dev, "vdd");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "regulator get failed\n");
>> +
>> +	ret = hx9023s_id_check(indio_dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "id check failed\n");
> As commented on above, this should not fail on a missmatch ont he ID, just
> on a failure to read it at all.  That enables future devices that haven't
> been made yet and happen to be compatible to be able to work with older
> linux kernels that predate them.
>

Understood, thank you very much for your detailed explanation.


>> +}

