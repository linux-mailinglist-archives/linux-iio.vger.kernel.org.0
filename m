Return-Path: <linux-iio+bounces-26288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC08C69D8E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 15:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEDAA4F81C1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F63446A3;
	Tue, 18 Nov 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="djZpCd/V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A24325716
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474705; cv=none; b=aTfw1wJweiYlL2lRI8pOpUTSDmLJaZMEWRTKWKSp1wdeWP7eZVjZFQFhY5Y1M3kKBBBGkW54Sh2Qurl1H4ul6NIZ8x7VHpmzMOqg0yQkC89t2U954R3yxbO4fA7dqRwAeWHSfaLX2HptcZ7F2G6AAyxQlUkJm9PG1FjmAP0mj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474705; c=relaxed/simple;
	bh=12ZVpvDKpnCzm5A23mgPrXdhifDhxAFrBJxrXg8WVRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhVu5yonLwZ+MnrJM8zCmKGKognGNd4mzlW5Z1aT8KoEp4RXcXTKZatgP8whG/c202GAb/EDAfi1dQ0YBRnerBRKDiGj/oKHss0INHk5ZFH3Z1RB+8tWH3sr1og6Hk5B6Lze/U3p22Th3eG3pNH5bLb6OV0vSvK6XRStr+Lq6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=djZpCd/V; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso3272147fac.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 06:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763474702; x=1764079502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WjJCwybPy4e03hpnri7xmwes6PuHOy22Wtq70rSjzcA=;
        b=djZpCd/VBIAAKk0ZWa9sRGDpHqYj4ndwHbaGhBwt/Uwew9b/2sHbFWmTPeCpV56E9e
         cQL5suRV+YutOPKZ7k1zMXnZpgEwIe4O9YVmonN2SY3fH6Ao9w+8Q978zLVE1wi18Rhe
         XfN+ZTCyHcoHKl+4bFxPhTKuthIo72Cxhpyaq0ws/+bJryLy0iqcEieqazP3kQCv8yWO
         3+9ChoVi0kfTdjEziqZOHqt+0U2iqA7FN1AtB0NPTqVNKPkJI8Qp32dusxqfAH4jFCW5
         Ik/jc6ms11egWSeIpk4LmToiZxveiwYhmPB+0OCjoK+2e8Ost3KvhX1h8LXnkMZA+Gm7
         IPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763474702; x=1764079502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjJCwybPy4e03hpnri7xmwes6PuHOy22Wtq70rSjzcA=;
        b=ZGA4maw6HEiFVnFfJgl6YBSqJDXWX1JkBpqdjkn9BMLc1+KIW9mRlpXmwzJzsbh0PD
         /HyFgCy+pl9nK79WOZCIswJWP9qDWirJpivbTaGM2ZJbKg9fuW0LeifPmivArnX1/nd4
         GRopRZuewdKWo1Gjlt/Pe0vmfnJTp+4hUuH5/JdsQ7urfVxwDK3MhrfnqV+bPg0PS5WV
         lRJ8k37j0z4wSjDowE3mHKrIowbB+dvhBq33IVFxSweACn38yoE5EGNYUpluiPur11X1
         68MCAzr6Z/YjQTTKfp/hWT/G/mgGCNYmHTdKxsZ7wofmxq39K5MD5V7F1D810f4bqT67
         e5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWyv1EeI83eyub7M93zICVLFNAJvwC/O43lQSYnHIO4KR+aDn5Qitp+TFCZrxTIqtcsOz4GuiZup+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdTjL4W6Scz5pA7BfiAS2e+q6d5fdAJ1+1UgVSmwPToKJfq0b
	fuI8UAveIYRJmEW3XwGAz1tE8UdjhhZnPh7QPAThFjozdusytKbVdyehk69ENL5I/5Q=
X-Gm-Gg: ASbGncsLtN2ij9QkORG5vF39Cktlzy6N5ln9rkKlXoB6G3LuH0KaQqP0pVvMIYLwyQA
	3R4/WHM2a+7HQJTCzhsccd8Jk01yQ1oyyzuZ/E3jFLvCmvuk+BnYCdr4gmuAevFuIDr1Uraw5L5
	cTX3mPYYSTh5+Sd1GpCai83Q6NAq671H2px3Dx5ThiCVRa11ZA2VEG+wwyGZEHUO4mhYMemH6qL
	KNT0L+GrXlY5d92jcdY6V1ZndXmnNKEkjlkvH7rN2NFvr3OomDQU4w0oO0xXdZaZe6pWsj41m8K
	bpVTkVgZTlgsNWO6znR2dZzcSbFV/35rzQE41ozqmc9EonUezgPveaAFdbyqijVrupIxL05SfW9
	q57K/RpAH0PtzsbVdCtuHSdVCbexjhDdOLI0wFhxy/vsG+0MoyUATcPF5KSiiEsGzB7XfZthe3P
	QPyvsSnzz8/lXK8d3qR0jeviy0OprULm3ZPmPFNAvNUsmfU7A2kQ==
X-Google-Smtp-Source: AGHT+IEcqG4n/wScJZOQXO9crrLs/Xt8cBG9w1GfNp2YfhNAMWu80zBccJoj3g7V5JGdaWuzDZlyzw==
X-Received: by 2002:a05:6871:d691:b0:3d4:94ef:d05c with SMTP id 586e51a60fabf-3e868fbfab8mr7158580fac.21.1763474700403;
        Tue, 18 Nov 2025 06:05:00 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8e86:179b:44b8:cc2b? ([2600:8803:e7e4:500:8e86:179b:44b8:cc2b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec5962e508sm1452279fac.4.2025.11.18.06.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 06:04:59 -0800 (PST)
Message-ID: <5f15284b-159b-4860-b58b-35c624e2539f@baylibre.com>
Date: Tue, 18 Nov 2025 08:04:58 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for TI ADS1120
To: Ajith Anandhan <ajithanandhan0406@gmail.com>, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
 <20251109141119.561756-3-ajithanandhan0406@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251109141119.561756-3-ajithanandhan0406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/25 8:11 AM, Ajith Anandhan wrote:
> Add driver for the Texas Instruments ADS1120, a precision 16-bit
> analog-to-digital converter with an SPI interface.
> 

...

> +#define ADS1120_CFG0_GAIN_MASK		GENMASK(3, 1)
> +#define ADS1120_CFG0_GAIN_1		0
> +#define ADS1120_CFG0_GAIN_2		1
> +#define ADS1120_CFG0_GAIN_4		2
> +#define ADS1120_CFG0_GAIN_8		3
> +#define ADS1120_CFG0_GAIN_16		4
> +#define ADS1120_CFG0_GAIN_32		5
> +#define ADS1120_CFG0_GAIN_64		6
> +#define ADS1120_CFG0_GAIN_128		7

We could avoid these macros by just doing ilog2(gain).

> +
> +#define ADS1120_CFG0_PGA_BYPASS		BIT(0)
> +
> +/* Config Register 1 bit definitions */
> +#define ADS1120_CFG1_DR_MASK		GENMASK(7, 5)
> +#define ADS1120_CFG1_DR_20SPS		0
> +#define ADS1120_CFG1_DR_45SPS		1
> +#define ADS1120_CFG1_DR_90SPS		2
> +#define ADS1120_CFG1_DR_175SPS		3
> +#define ADS1120_CFG1_DR_330SPS		4
> +#define ADS1120_CFG1_DR_600SPS		5
> +#define ADS1120_CFG1_DR_1000SPS		6

I would avoid writing macros for values we don't use yet. For example,
it may make more sense to have a lookup table when it comes to actually
implementing something that uses this.

Same applies to the rest below.

> +
> +#define ADS1120_CFG1_MODE_MASK		GENMASK(4, 3)
> +#define ADS1120_CFG1_MODE_NORMAL	0
> +#define ADS1120_CFG1_MODE_DUTY		1
> +#define ADS1120_CFG1_MODE_TURBO		2
> +
> +#define ADS1120_CFG1_CM_MASK		BIT(2)
> +#define ADS1120_CFG1_CM_SINGLE		0
> +#define ADS1120_CFG1_CM_CONTINUOUS	1
> +
> +#define ADS1120_CFG1_TS_EN		BIT(1)
> +#define ADS1120_CFG1_BCS_EN		BIT(0)
> +
> +/* Config Register 2 bit definitions */
> +#define ADS1120_CFG2_VREF_MASK		GENMASK(7, 6)
> +#define ADS1120_CFG2_VREF_INTERNAL	0
> +#define ADS1120_CFG2_VREF_EXT_REFP0	1
> +#define ADS1120_CFG2_VREF_EXT_AIN0	2
> +#define ADS1120_CFG2_VREF_AVDD		3
> +
> +#define ADS1120_CFG2_REJECT_MASK	GENMASK(5, 4)
> +#define ADS1120_CFG2_REJECT_OFF		0
> +#define ADS1120_CFG2_REJECT_50_60	1
> +#define ADS1120_CFG2_REJECT_50		2
> +#define ADS1120_CFG2_REJECT_60		3
> +
> +#define ADS1120_CFG2_PSW_EN		BIT(3)
> +
> +#define ADS1120_CFG2_IDAC_MASK		GENMASK(2, 0)
> +#define ADS1120_CFG2_IDAC_OFF		0
> +#define ADS1120_CFG2_IDAC_10UA		1
> +#define ADS1120_CFG2_IDAC_50UA		2
> +#define ADS1120_CFG2_IDAC_100UA		3
> +#define ADS1120_CFG2_IDAC_250UA		4
> +#define ADS1120_CFG2_IDAC_500UA		5
> +#define ADS1120_CFG2_IDAC_1000UA	6
> +#define ADS1120_CFG2_IDAC_1500UA	7
> +
> +/* Config Register 3 bit definitions */
> +#define ADS1120_CFG3_IDAC1_MASK		GENMASK(7, 5)
> +#define ADS1120_CFG3_IDAC1_DISABLED	0
> +#define ADS1120_CFG3_IDAC1_AIN0		1
> +#define ADS1120_CFG3_IDAC1_AIN1		2
> +#define ADS1120_CFG3_IDAC1_AIN2		3
> +#define ADS1120_CFG3_IDAC1_AIN3		4
> +#define ADS1120_CFG3_IDAC1_REFP0	5
> +#define ADS1120_CFG3_IDAC1_REFN0	6
> +
> +#define ADS1120_CFG3_IDAC2_MASK		GENMASK(4, 2)
> +#define ADS1120_CFG3_IDAC2_DISABLED	0
> +#define ADS1120_CFG3_IDAC2_AIN0		1
> +#define ADS1120_CFG3_IDAC2_AIN1		2
> +#define ADS1120_CFG3_IDAC2_AIN2		3
> +#define ADS1120_CFG3_IDAC2_AIN3		4
> +#define ADS1120_CFG3_IDAC2_REFP0	5
> +#define ADS1120_CFG3_IDAC2_REFN0	6
> +
> +#define ADS1120_CFG3_DRDYM_MASK		BIT(1)
> +#define ADS1120_CFG3_DRDYM_DRDY_ONLY	0
> +#define ADS1120_CFG3_DRDYM_BOTH		1
> +
> +/* Conversion time for 20 SPS */
> +#define ADS1120_CONV_TIME_MS		51
> +
> +/* Internal reference voltage in millivolts */
> +#define ADS1120_VREF_INTERNAL_MV	2048
> +
> +
> +struct ads1120_state {
> +	struct spi_device	*spi;
> +	struct regmap		*regmap;
> +	/*
> +	 * Protects chip configuration and ADC reads to ensure
> +	 * consistent channel/gain settings during conversions.
> +	 */
> +	struct mutex		lock;
> +
> +	int vref_mv;
> +
> +	/* DMA-safe buffer for SPI transfers */
> +	u8 data[4] __aligned(IIO_DMA_MINALIGN);
> +};
> +
> +
> +static const int ads1120_gain_values[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> +static const int ads1120_low_gain_values[] = { 1, 2, 4 };
> +
> +/* Differential channel macro */
> +#define ADS1120_DIFF_CHANNEL(index, chan1, chan2)		\
> +{								\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = chan1,					\
> +	.channel2 = chan2,					\
> +	.differential = 1,					\
> +	.address = index,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
> +}
> +
> +/* Single-ended channel macro */
> +#define ADS1120_SINGLE_CHANNEL(index, chan)			\
> +{								\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = chan,					\
> +	.address = index,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
> +}
> +
> +/* Diagnostic channel macro */
> +#define ADS1120_DIAG_CHANNEL(index, label)			\
> +{								\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = index,					\
> +	.address = index,					\
> +	.extend_name = label,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
> +}
> +
> +static const struct iio_chan_spec ads1120_channels[] = {
> +	/* Differential inputs */
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN0_AIN1, 0, 1),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN0_AIN2, 0, 2),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN0_AIN3, 0, 3),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN1_AIN2, 1, 2),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN1_AIN3, 1, 3),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN2_AIN3, 2, 3),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN1_AIN0, 1, 0),
> +	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN3_AIN2, 3, 2),
> +	/* Single-ended inputs */
> +	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN0_AVSS, 0),
> +	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN1_AVSS, 1),
> +	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN2_AVSS, 2),
> +	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN3_AVSS, 3),
> +	/* Diagnostic inputs */
> +	ADS1120_DIAG_CHANNEL(ADS1120_CFG0_MUX_REFP_REFN_4, "ref_div4"),
> +	ADS1120_DIAG_CHANNEL(ADS1120_CFG0_MUX_AVDD_AVSS_4, "avdd_div4"),
> +	ADS1120_DIAG_CHANNEL(ADS1120_CFG0_MUX_SHORTED, "shorted"),
> +};

Usually we don't make macros for the index. When it comes to adding
buffer support, having the macros makes it harder to see which scan_index
belongs to which channel. And if buffer support is planned for later,
it would make sense to use .scan_index instead of .address to avoid
duplicating that info later.


> +static int ads1120_set_gain(struct ads1120_state *st, int gain_val)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ads1120_gain_values); i++) {
> +		if (ads1120_gain_values[i] == gain_val)
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(ads1120_gain_values))
> +		return -EINVAL;

Since there is only one gain register, we should store this in a
per-channel variable, then set the gain in the register in
ads1120_set_mux() instead (and it would make sense to rename
that function as well to something like ads1120_configure_channel()).

> +
> +	return regmap_update_bits(st->regmap, ADS1120_REG_CONFIG0,
> +				  ADS1120_CFG0_GAIN_MASK,
> +				  FIELD_PREP(ADS1120_CFG0_GAIN_MASK, i));
> +}
> +

...

> +static int ads1120_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ads1120_state *st = iio_priv(indio_dev);
> +	int ret, gain;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		guard(mutex)(&st->lock);
> +		ret = ads1120_read_measurement(st, chan, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Scale = Vref / (gain * 2^15)
> +		 * Return in format: val / 2^val2
> +		 */
> +		gain = ads1120_get_gain(st);
> +		if (gain < 0)
> +			return gain;
> +
> +		*val = st->vref_mv;
> +		*val2 = gain * 15;

I think this would need to be `*val2 = ilog2(gain) + 15`.

> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +



> +
> +/* Regmap read function for ADS1120 */
> +static int ads1120_regmap_read(void *context, const void *reg_buf,
> +			       size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct ads1120_state *st = context;
> +	u8 reg = *(u8 *)reg_buf;
> +	u8 *val = val_buf;
> +	int ret;
> +	struct spi_transfer xfer[2] = {
> +		{
> +			.tx_buf = st->data,
> +			.len = 1,
> +		}, {
> +			.rx_buf = val,
> +			.len = val_size,
> +		}
> +	};
> +
> +	if (reg > ADS1120_REG_CONFIG3)
> +		return -EINVAL;

This check should not be needed because of .maxregister.

> +
> +	/* RREG command: 0010rr00 where rr is register address */
> +	st->data[0] = ADS1120_CMD_RREG | (reg << 2);
> +
> +	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/* Regmap write function for ADS1120 */
> +static int ads1120_regmap_write(void *context, const void *data, size_t count)
> +{
> +	struct ads1120_state *st = context;
> +	const u8 *buf = data;
> +
> +	if (count != 2)
> +		return -EINVAL;
> +
> +	/* WREG command: 0100rr00 where rr is register address */
> +	st->data[0] = ADS1120_CMD_WREG | (buf[0] << 2);
> +	st->data[1] = buf[1];
> +
> +	return spi_write(st->spi, st->data, 2);
> +}

I don't see anyting unusal about these read/write functions. We should
be able to use the existing spi_regmap with the proper configuration
instead of making a custom regmap_bus.

> +
> +static const struct regmap_bus ads1120_regmap_bus = {
> +	.read = ads1120_regmap_read,
> +	.write = ads1120_regmap_write,
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> +};
> +
> +static const struct regmap_config ads1120_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = ADS1120_REG_CONFIG3,
> +	.cache_type = REGCACHE_FLAT,
> +};
> +
> +static int ads1120_init(struct ads1120_state *st)
> +{
> +	int ret;

It's just a few extra lines to turn on the avdd supply here before
resettting.

> +
> +	ret = ads1120_reset(st);
> +	if (ret)
> +		return dev_err_probe(&st->spi->dev, ret,
> +					"Failed to reset device\n");
> +
> +	/*
> +	 * Configure Register 0:
> +	 * - Input MUX: AIN0/AVSS
> +	 * - Gain: 1
> +	 * - PGA bypass enabled. When gain is set > 4, this bit is
> +	 *   automatically ignored by the hardware and PGA is enabled,
> +	 *   so it's safe to leave it set.
> +	 */
> +	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG0,
> +			   FIELD_PREP(ADS1120_CFG0_MUX_MASK,
> +				      ADS1120_CFG0_MUX_AIN0_AVSS) |
> +			   FIELD_PREP(ADS1120_CFG0_GAIN_MASK,
> +				      ADS1120_CFG0_GAIN_1) |
> +			   ADS1120_CFG0_PGA_BYPASS);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure Register 1:
> +	 * - Data rate: 20 SPS (for single-shot mode)
> +	 * - Operating mode: Normal
> +	 * - Conversion mode: Single-shot
> +	 * - Temperature sensor: Disabled
> +	 * - Burnout current: Disabled
> +	 */
> +	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG1,
> +			   FIELD_PREP(ADS1120_CFG1_DR_MASK,
> +				      ADS1120_CFG1_DR_20SPS) |
> +			   FIELD_PREP(ADS1120_CFG1_MODE_MASK,
> +				      ADS1120_CFG1_MODE_NORMAL) |
> +			   FIELD_PREP(ADS1120_CFG1_CM_MASK,
> +				      ADS1120_CFG1_CM_SINGLE) |
> +			   FIELD_PREP(ADS1120_CFG1_TS_EN, 0) |
> +			   FIELD_PREP(ADS1120_CFG1_BCS_EN, 0));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure Register 2:
> +	 * - Voltage reference: Internal 2.048V
> +	 * - 50/60Hz rejection: Off
> +	 * - Power switch: Disabled
> +	 * - IDAC current: Off
> +	 */
> +	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG2,
> +			   FIELD_PREP(ADS1120_CFG2_VREF_MASK,
> +				      ADS1120_CFG2_VREF_INTERNAL) |
> +			   FIELD_PREP(ADS1120_CFG2_REJECT_MASK,
> +				      ADS1120_CFG2_REJECT_OFF) |
> +			   FIELD_PREP(ADS1120_CFG2_PSW_EN, 0) |
> +			   FIELD_PREP(ADS1120_CFG2_IDAC_MASK,
> +				      ADS1120_CFG2_IDAC_OFF));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure Register 3:
> +	 * - IDAC1: Disabled
> +	 * - IDAC2: Disabled
> +	 * - DRDY mode: Only reflects data ready status
> +	 */
> +	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG3,
> +			   FIELD_PREP(ADS1120_CFG3_IDAC1_MASK,
> +				      ADS1120_CFG3_IDAC1_DISABLED) |
> +			   FIELD_PREP(ADS1120_CFG3_IDAC2_MASK,
> +				      ADS1120_CFG3_IDAC2_DISABLED) |
> +			   FIELD_PREP(ADS1120_CFG3_DRDYM_MASK,
> +				      ADS1120_CFG3_DRDYM_DRDY_ONLY));
> +	if (ret)
> +		return ret;
> +

If we want to wait for a later patch to support external reference,
I would consider to check for the devicetree properties here and
print a warning that they aren't supported if present. Maybe others
think that is too much noise though? Especially if you plan to add
it soon.

> +	st->vref_mv = ADS1120_VREF_INTERNAL_MV;
> +
> +	return 0;
> +}
> +

