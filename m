Return-Path: <linux-iio+bounces-27088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A1DCBEDD4
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 17:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 068FA306DCAA
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30F832C326;
	Mon, 15 Dec 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUULvy7a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D7632D440
	for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815225; cv=none; b=tdt1TzDBhb4Qd1Glsdx/drCCC9ErIuqC2HkwenzMbR1QxbdkmCKDBzfN184ORi1u7bUa9HNSl59xmBHcLT5qV7OAnBqzvw0ZaBCfI94x6xxpRjucog6Ug5JgSufD80q0928tiBX+1I3WtwiAVJcyO+WNXxCtqHFvBz4rZD6ClZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815225; c=relaxed/simple;
	bh=dyJh6jTCycHSpnVG6c2byQ9jBR4rd4vVjHaJTGmI4rE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fzz0ajSajz2JiQBbnqIyUiQuXTjHlihNhlai/r8TZVZEPQ9ev8o2d/Lzcp29w78mKmSV0kRP2MXs/5WSXRqWBuWJxLRfw8dAUxdmbxaaih1z2tWeYuO+0wuce69jj0LVpw+BvkPn+xmnWU7U745FvVBTFndgGfig+hrwQA9RWII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUULvy7a; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d0788adaso12914965ad.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Dec 2025 08:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765815220; x=1766420020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fId0lhvm1S81P4bIACdgw9yr/FbrBNvla1Qa1ypUcM=;
        b=JUULvy7ac8WaEALwHcHtimQa4fI38qepLcqZ8FQaAw3H28HNAcKz1as2osjsyVRIeo
         a9s3Etl4OnKzq+ahq7NrTOh5pEbFAAkI9/XO/hZB7tnV2y3aM6LM0zbEXnrRWfKlO1ku
         Q0aVVRdgsKz+ucZoN+UVgJlNfbC2IOel8W5gMgKjhrNyB4ZoFy1EVzWEysbZEzi8oJjv
         FbIgXGKPgKCmIYwu1zld1Jo9rwd7JFkuJrZsRbc6Q2FFV/lwl6rsYCFPePEvb4iRDVTq
         42ut2iPcdznKNSUcG4xlMb0ANhctsQaTH/xWVBR1VuEGz4oIPFjykcP8FznD2o0g4Qz9
         Zt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815220; x=1766420020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fId0lhvm1S81P4bIACdgw9yr/FbrBNvla1Qa1ypUcM=;
        b=AovnATiKuhkrBShx28eTUga/MTEdRpdnI/Z80siC8p8vLifiOB6vvTY408o15DwXZY
         xjUASYkF6Zv30zeJxTngtr7Jx1dDOY5RdL4O4HGwDSsegi7JxjFJXl9BDSXCupggprBL
         75VmYkJL5/eUtCxAeh9WY2fuqTsfXxYzug1zF5Fs81ssdPXX/a38NmnfzurmUe15nAXk
         UO096VHYC2b4uJTTMP3vDrHUkLoTFwZwPF6FJ5W0fh/PZOtW8eCfeUcU/UTbylfsCQeN
         iVBw+7OrjCRfCM5SXJGc8vm0CgGFK9AOZqXLj5JjbE2h88PP1+vF0mRN6UoA9Ao498By
         4JIA==
X-Forwarded-Encrypted: i=1; AJvYcCXCfgCYHAtDdZF/4rP6hP5W1Txz3Mjl1k9c9ezna4QD+P/F81r8dOHKdat1QBWGVpbiJvw9OXkFTFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkost2sQVvP7uCfetKZruzJ9Rbo5lTlAtZPiwwqU673xO2DIJB
	WLW87Uo2EFfz+tClGoB6C1Tp1fcWJFi3rDCudmX7ghosawswR8vVz4Lt
X-Gm-Gg: AY/fxX5jWVaW2tyiGObV3EL1PdFMycgMWUiHBw4QOq8nuegPgRvdfyNsCJ1VbkGS7mQ
	LCUltIPyr8kXr6SwAV1dLTLmGxqdobU6ivou6FXqyo2v7Zn8rwgvFYvEw8xfAR0qyuy/zmmeJqZ
	piECMFd6diL9njUdbzZIYTejqRPVemC6rWrZF7uXCuFoJRdy1OFqxVFH45JGi2ZaM0mzwH6qHOR
	dprvt2/GqSwB5HJNa+D09UVUTiZX99O0Hh293sipJaBO68m7teXqZGaGeWKyeeR6OwcT72K1pmk
	ZN1VHWdVJW3xe77kkd9yYaCu+784RZga688u1rZ3b2pUs8qa0QCW7ytpYptLL16Y7/nfvuGQUbQ
	TJFuEAJUEdW1FPIv8d4zhCDRCyaevRMouRk1nysRP69bTf/q9cpAbRTZH3y3nXlw606ZsKjCEDP
	LfxIFmFTnCFjDLkrytkmoUdQM2t0eBfm751BjpEVIHkUqjhzeJOEv1oGHc0s61HE0=
X-Google-Smtp-Source: AGHT+IGKVI2uUcG84ntZ6HPHY0u123NhKguBup5/oVCmIgvlmMaHwQXFhwE+EQgWKzMVswfc8ArD7Q==
X-Received: by 2002:a17:903:38c7:b0:2a0:d629:9032 with SMTP id d9443c01a7336-2a0d629942fmr53752535ad.3.1765815219978;
        Mon, 15 Dec 2025 08:13:39 -0800 (PST)
Received: from ?IPV6:2402:e280:21d3:2:50bc:8636:2ee8:5158? ([2402:e280:21d3:2:50bc:8636:2ee8:5158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0ad49454csm62079025ad.10.2025.12.15.08.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 08:13:39 -0800 (PST)
Message-ID: <8e2c73ca-3746-4b2a-9d85-c12b51a69059@gmail.com>
Date: Mon, 15 Dec 2025 21:43:33 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for TI ADS1120
To: David Lechner <dlechner@baylibre.com>, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
 <20251109141119.561756-3-ajithanandhan0406@gmail.com>
 <5f15284b-159b-4860-b58b-35c624e2539f@baylibre.com>
Content-Language: en-US
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
In-Reply-To: <5f15284b-159b-4860-b58b-35c624e2539f@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/25 7:34 PM, David Lechner wrote:
> On 11/9/25 8:11 AM, Ajith Anandhan wrote:
>> Add driver for the Texas Instruments ADS1120, a precision 16-bit
>> analog-to-digital converter with an SPI interface.
>>
> ...
>
>> +#define ADS1120_CFG0_GAIN_MASK		GENMASK(3, 1)
>> +#define ADS1120_CFG0_GAIN_1		0
>> +#define ADS1120_CFG0_GAIN_2		1
>> +#define ADS1120_CFG0_GAIN_4		2
>> +#define ADS1120_CFG0_GAIN_8		3
>> +#define ADS1120_CFG0_GAIN_16		4
>> +#define ADS1120_CFG0_GAIN_32		5
>> +#define ADS1120_CFG0_GAIN_64		6
>> +#define ADS1120_CFG0_GAIN_128		7
> We could avoid these macros by just doing ilog2(gain).


I understand your concern about unused macros. I've kept them for 
documentation purposes as they map directly to the datasheet register 
definitions, which makes it easier to verify correctness against 
hardware specs also I'd prefer to keep it like this since it give more 
readability Shall i keep this as it is for this initial version?

>> +
>> +#define ADS1120_CFG0_PGA_BYPASS		BIT(0)
>> +
>> +/* Config Register 1 bit definitions */
>> +#define ADS1120_CFG1_DR_MASK		GENMASK(7, 5)
>> +#define ADS1120_CFG1_DR_20SPS		0
>> +#define ADS1120_CFG1_DR_45SPS		1
>> +#define ADS1120_CFG1_DR_90SPS		2
>> +#define ADS1120_CFG1_DR_175SPS		3
>> +#define ADS1120_CFG1_DR_330SPS		4
>> +#define ADS1120_CFG1_DR_600SPS		5
>> +#define ADS1120_CFG1_DR_1000SPS		6
> I would avoid writing macros for values we don't use yet. For example,
> it may make more sense to have a lookup table when it comes to actually
> implementing something that uses this.
>
> Same applies to the rest below.
>
>> +
>> +#define ADS1120_CFG1_MODE_MASK		GENMASK(4, 3)
>> +#define ADS1120_CFG1_MODE_NORMAL	0
>> +#define ADS1120_CFG1_MODE_DUTY		1
>> +#define ADS1120_CFG1_MODE_TURBO		2
>> +
>> +#define ADS1120_CFG1_CM_MASK		BIT(2)
>> +#define ADS1120_CFG1_CM_SINGLE		0
>> +#define ADS1120_CFG1_CM_CONTINUOUS	1
>> +
>> +#define ADS1120_CFG1_TS_EN		BIT(1)
>> +#define ADS1120_CFG1_BCS_EN		BIT(0)
>> +
>> +/* Config Register 2 bit definitions */
>> +#define ADS1120_CFG2_VREF_MASK		GENMASK(7, 6)
>> +#define ADS1120_CFG2_VREF_INTERNAL	0
>> +#define ADS1120_CFG2_VREF_EXT_REFP0	1
>> +#define ADS1120_CFG2_VREF_EXT_AIN0	2
>> +#define ADS1120_CFG2_VREF_AVDD		3
>> +
>> +#define ADS1120_CFG2_REJECT_MASK	GENMASK(5, 4)
>> +#define ADS1120_CFG2_REJECT_OFF		0
>> +#define ADS1120_CFG2_REJECT_50_60	1
>> +#define ADS1120_CFG2_REJECT_50		2
>> +#define ADS1120_CFG2_REJECT_60		3
>> +
>> +#define ADS1120_CFG2_PSW_EN		BIT(3)
>> +
>> +#define ADS1120_CFG2_IDAC_MASK		GENMASK(2, 0)
>> +#define ADS1120_CFG2_IDAC_OFF		0
>> +#define ADS1120_CFG2_IDAC_10UA		1
>> +#define ADS1120_CFG2_IDAC_50UA		2
>> +#define ADS1120_CFG2_IDAC_100UA		3
>> +#define ADS1120_CFG2_IDAC_250UA		4
>> +#define ADS1120_CFG2_IDAC_500UA		5
>> +#define ADS1120_CFG2_IDAC_1000UA	6
>> +#define ADS1120_CFG2_IDAC_1500UA	7
>> +
>> +/* Config Register 3 bit definitions */
>> +#define ADS1120_CFG3_IDAC1_MASK		GENMASK(7, 5)
>> +#define ADS1120_CFG3_IDAC1_DISABLED	0
>> +#define ADS1120_CFG3_IDAC1_AIN0		1
>> +#define ADS1120_CFG3_IDAC1_AIN1		2
>> +#define ADS1120_CFG3_IDAC1_AIN2		3
>> +#define ADS1120_CFG3_IDAC1_AIN3		4
>> +#define ADS1120_CFG3_IDAC1_REFP0	5
>> +#define ADS1120_CFG3_IDAC1_REFN0	6
>> +
>> +#define ADS1120_CFG3_IDAC2_MASK		GENMASK(4, 2)
>> +#define ADS1120_CFG3_IDAC2_DISABLED	0
>> +#define ADS1120_CFG3_IDAC2_AIN0		1
>> +#define ADS1120_CFG3_IDAC2_AIN1		2
>> +#define ADS1120_CFG3_IDAC2_AIN2		3
>> +#define ADS1120_CFG3_IDAC2_AIN3		4
>> +#define ADS1120_CFG3_IDAC2_REFP0	5
>> +#define ADS1120_CFG3_IDAC2_REFN0	6
>> +
>> +#define ADS1120_CFG3_DRDYM_MASK		BIT(1)
>> +#define ADS1120_CFG3_DRDYM_DRDY_ONLY	0
>> +#define ADS1120_CFG3_DRDYM_BOTH		1
>> +
>> +/* Conversion time for 20 SPS */
>> +#define ADS1120_CONV_TIME_MS		51
>> +
>> +/* Internal reference voltage in millivolts */
>> +#define ADS1120_VREF_INTERNAL_MV	2048
>> +
>> +
>> +struct ads1120_state {
>> +	struct spi_device	*spi;
>> +	struct regmap		*regmap;
>> +	/*
>> +	 * Protects chip configuration and ADC reads to ensure
>> +	 * consistent channel/gain settings during conversions.
>> +	 */
>> +	struct mutex		lock;
>> +
>> +	int vref_mv;
>> +
>> +	/* DMA-safe buffer for SPI transfers */
>> +	u8 data[4] __aligned(IIO_DMA_MINALIGN);
>> +};
>> +
>> +
>> +static const int ads1120_gain_values[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
>> +static const int ads1120_low_gain_values[] = { 1, 2, 4 };
>> +
>> +/* Differential channel macro */
>> +#define ADS1120_DIFF_CHANNEL(index, chan1, chan2)		\
>> +{								\
>> +	.type = IIO_VOLTAGE,					\
>> +	.indexed = 1,						\
>> +	.channel = chan1,					\
>> +	.channel2 = chan2,					\
>> +	.differential = 1,					\
>> +	.address = index,					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
>> +			      BIT(IIO_CHAN_INFO_SCALE),		\
>> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
>> +}
>> +
>> +/* Single-ended channel macro */
>> +#define ADS1120_SINGLE_CHANNEL(index, chan)			\
>> +{								\
>> +	.type = IIO_VOLTAGE,					\
>> +	.indexed = 1,						\
>> +	.channel = chan,					\
>> +	.address = index,					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
>> +			      BIT(IIO_CHAN_INFO_SCALE),		\
>> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
>> +}
>> +
>> +/* Diagnostic channel macro */
>> +#define ADS1120_DIAG_CHANNEL(index, label)			\
>> +{								\
>> +	.type = IIO_VOLTAGE,					\
>> +	.indexed = 1,						\
>> +	.channel = index,					\
>> +	.address = index,					\
>> +	.extend_name = label,					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
>> +			      BIT(IIO_CHAN_INFO_SCALE),		\
>> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
>> +}
>> +
>> +static const struct iio_chan_spec ads1120_channels[] = {
>> +	/* Differential inputs */
>> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN0_AIN1, 0, 1),
>> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN0_AIN2, 0, 2),
>> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN0_AIN3, 0, 3),
>> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN1_AIN2, 1, 2),
>> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN1_AIN3, 1, 3),
>> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN2_AIN3, 2, 3),
>> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN1_AIN0, 1, 0),
>> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN3_AIN2, 3, 2),
>> +	/* Single-ended inputs */
>> +	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN0_AVSS, 0),
>> +	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN1_AVSS, 1),
>> +	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN2_AVSS, 2),
>> +	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN3_AVSS, 3),
>> +	/* Diagnostic inputs */
>> +	ADS1120_DIAG_CHANNEL(ADS1120_CFG0_MUX_REFP_REFN_4, "ref_div4"),
>> +	ADS1120_DIAG_CHANNEL(ADS1120_CFG0_MUX_AVDD_AVSS_4, "avdd_div4"),
>> +	ADS1120_DIAG_CHANNEL(ADS1120_CFG0_MUX_SHORTED, "shorted"),
>> +};
> Usually we don't make macros for the index. When it comes to adding
> buffer support, having the macros makes it harder to see which scan_index
> belongs to which channel. And if buffer support is planned for later,
> it would make sense to use .scan_index instead of .address to avoid
> duplicating that info later.
>
>
>> +static int ads1120_set_gain(struct ads1120_state *st, int gain_val)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ads1120_gain_values); i++) {
>> +		if (ads1120_gain_values[i] == gain_val)
>> +			break;
>> +	}
>> +
>> +	if (i == ARRAY_SIZE(ads1120_gain_values))
>> +		return -EINVAL;
> Since there is only one gain register, we should store this in a
> per-channel variable, then set the gain in the register in
> ads1120_set_mux() instead (and it would make sense to rename
> that function as well to something like ads1120_configure_channel()).


I've implemented a global gain that applies to all channels 
forsimplicity. I planed to add

  per-channel gain storage in the later patches.

>
>> +
>> +	return regmap_update_bits(st->regmap, ADS1120_REG_CONFIG0,
>> +				  ADS1120_CFG0_GAIN_MASK,
>> +				  FIELD_PREP(ADS1120_CFG0_GAIN_MASK, i));
>> +}
>> +
> ...
>
>> +static int ads1120_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val, int *val2, long mask)
>> +{
>> +	struct ads1120_state *st = iio_priv(indio_dev);
>> +	int ret, gain;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		guard(mutex)(&st->lock);
>> +		ret = ads1120_read_measurement(st, chan, val);
>> +		if (ret)
>> +			return ret;
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		/*
>> +		 * Scale = Vref / (gain * 2^15)
>> +		 * Return in format: val / 2^val2
>> +		 */
>> +		gain = ads1120_get_gain(st);
>> +		if (gain < 0)
>> +			return gain;
>> +
>> +		*val = st->vref_mv;
>> +		*val2 = gain * 15;
> I think this would need to be `*val2 = ilog2(gain) + 15`.
>
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>
>
>> +
>> +/* Regmap read function for ADS1120 */
>> +static int ads1120_regmap_read(void *context, const void *reg_buf,
>> +			       size_t reg_size, void *val_buf, size_t val_size)
>> +{
>> +	struct ads1120_state *st = context;
>> +	u8 reg = *(u8 *)reg_buf;
>> +	u8 *val = val_buf;
>> +	int ret;
>> +	struct spi_transfer xfer[2] = {
>> +		{
>> +			.tx_buf = st->data,
>> +			.len = 1,
>> +		}, {
>> +			.rx_buf = val,
>> +			.len = val_size,
>> +		}
>> +	};
>> +
>> +	if (reg > ADS1120_REG_CONFIG3)
>> +		return -EINVAL;
> This check should not be needed because of .maxregister.
>
>> +
>> +	/* RREG command: 0010rr00 where rr is register address */
>> +	st->data[0] = ADS1120_CMD_RREG | (reg << 2);
>> +
>> +	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +/* Regmap write function for ADS1120 */
>> +static int ads1120_regmap_write(void *context, const void *data, size_t count)
>> +{
>> +	struct ads1120_state *st = context;
>> +	const u8 *buf = data;
>> +
>> +	if (count != 2)
>> +		return -EINVAL;
>> +
>> +	/* WREG command: 0100rr00 where rr is register address */
>> +	st->data[0] = ADS1120_CMD_WREG | (buf[0] << 2);
>> +	st->data[1] = buf[1];
>> +
>> +	return spi_write(st->spi, st->data, 2);
>> +}
> I don't see anyting unusal about these read/write functions. We should
> be able to use the existing spi_regmap with the proper configuration
> instead of making a custom regmap_bus.


    The ADS1120 needs register address shifted by 2 bits
    in command byte (reg << 2). I couldn't find a way to do this with 
standard
    SPI regmap. If there's a configuration I'm missing, please point me 
to it and I'll gladly simplify.


>> +
>> +static const struct regmap_bus ads1120_regmap_bus = {
>> +	.read = ads1120_regmap_read,
>> +	.write = ads1120_regmap_write,
>> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
>> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
>> +};
>> +
>> +static const struct regmap_config ads1120_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.max_register = ADS1120_REG_CONFIG3,
>> +	.cache_type = REGCACHE_FLAT,
>> +};
>> +
>> +static int ads1120_init(struct ads1120_state *st)
>> +{
>> +	int ret;
> It's just a few extra lines to turn on the avdd supply here before
> resettting.
>
>> +
>> +	ret = ads1120_reset(st);
>> +	if (ret)
>> +		return dev_err_probe(&st->spi->dev, ret,
>> +					"Failed to reset device\n");
>> +
>> +	/*
>> +	 * Configure Register 0:
>> +	 * - Input MUX: AIN0/AVSS
>> +	 * - Gain: 1
>> +	 * - PGA bypass enabled. When gain is set > 4, this bit is
>> +	 *   automatically ignored by the hardware and PGA is enabled,
>> +	 *   so it's safe to leave it set.
>> +	 */
>> +	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG0,
>> +			   FIELD_PREP(ADS1120_CFG0_MUX_MASK,
>> +				      ADS1120_CFG0_MUX_AIN0_AVSS) |
>> +			   FIELD_PREP(ADS1120_CFG0_GAIN_MASK,
>> +				      ADS1120_CFG0_GAIN_1) |
>> +			   ADS1120_CFG0_PGA_BYPASS);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Configure Register 1:
>> +	 * - Data rate: 20 SPS (for single-shot mode)
>> +	 * - Operating mode: Normal
>> +	 * - Conversion mode: Single-shot
>> +	 * - Temperature sensor: Disabled
>> +	 * - Burnout current: Disabled
>> +	 */
>> +	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG1,
>> +			   FIELD_PREP(ADS1120_CFG1_DR_MASK,
>> +				      ADS1120_CFG1_DR_20SPS) |
>> +			   FIELD_PREP(ADS1120_CFG1_MODE_MASK,
>> +				      ADS1120_CFG1_MODE_NORMAL) |
>> +			   FIELD_PREP(ADS1120_CFG1_CM_MASK,
>> +				      ADS1120_CFG1_CM_SINGLE) |
>> +			   FIELD_PREP(ADS1120_CFG1_TS_EN, 0) |
>> +			   FIELD_PREP(ADS1120_CFG1_BCS_EN, 0));
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Configure Register 2:
>> +	 * - Voltage reference: Internal 2.048V
>> +	 * - 50/60Hz rejection: Off
>> +	 * - Power switch: Disabled
>> +	 * - IDAC current: Off
>> +	 */
>> +	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG2,
>> +			   FIELD_PREP(ADS1120_CFG2_VREF_MASK,
>> +				      ADS1120_CFG2_VREF_INTERNAL) |
>> +			   FIELD_PREP(ADS1120_CFG2_REJECT_MASK,
>> +				      ADS1120_CFG2_REJECT_OFF) |
>> +			   FIELD_PREP(ADS1120_CFG2_PSW_EN, 0) |
>> +			   FIELD_PREP(ADS1120_CFG2_IDAC_MASK,
>> +				      ADS1120_CFG2_IDAC_OFF));
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Configure Register 3:
>> +	 * - IDAC1: Disabled
>> +	 * - IDAC2: Disabled
>> +	 * - DRDY mode: Only reflects data ready status
>> +	 */
>> +	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG3,
>> +			   FIELD_PREP(ADS1120_CFG3_IDAC1_MASK,
>> +				      ADS1120_CFG3_IDAC1_DISABLED) |
>> +			   FIELD_PREP(ADS1120_CFG3_IDAC2_MASK,
>> +				      ADS1120_CFG3_IDAC2_DISABLED) |
>> +			   FIELD_PREP(ADS1120_CFG3_DRDYM_MASK,
>> +				      ADS1120_CFG3_DRDYM_DRDY_ONLY));
>> +	if (ret)
>> +		return ret;
>> +
> If we want to wait for a later patch to support external reference,
> I would consider to check for the devicetree properties here and
> print a warning that they aren't supported if present. Maybe others
> think that is too much noise though? Especially if you plan to add
> it soon.
>
>> +	st->vref_mv = ADS1120_VREF_INTERNAL_MV;
>> +
>> +	return 0;
>> +}
>> +



