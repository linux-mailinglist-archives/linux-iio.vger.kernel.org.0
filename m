Return-Path: <linux-iio+bounces-8376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB894D41B
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 18:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9172285404
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 16:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF011990A1;
	Fri,  9 Aug 2024 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k/8DvqZE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22C1922DB
	for <linux-iio@vger.kernel.org>; Fri,  9 Aug 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219296; cv=none; b=GRrdT12npUHNXTVZbddCGbIbA6EhVf9tO/SALk/1nRalzQDvganoA5cC3mwBlVMuGzAGtTcbkfyMwEJDj+AlQ46NGhWGyOfES4mWEwGCDRJprsLd4VyrnZKrpHgWDTaKuj60G/x0JC11oPE7gyTndBnzqK2YNdRgM+jcbxed+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219296; c=relaxed/simple;
	bh=paKDUZfAMnT9p4c9PEEcxRCBnyjhCPshVDMBespFmZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGtQRxdCOYPPOfvQcc/avA+lO4FFH47IYZXK1yw8RKVhn4vlzLonPofaCs0zjJIa/sSG/T/AiWwjb8eeKNF3Ru1oUJOJRNdXew69lX+VZrREAHQYbksaHaSfjubfw3OsgTfn6H8zEnKU73mp90LrKSPmbHOc7MC35q24gubOglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k/8DvqZE; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5c7f23f22so1197337eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Aug 2024 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723219293; x=1723824093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRHkMeyOghMMPrSX3/7w5ue7vx+CNaxKKfqAReZDd9I=;
        b=k/8DvqZEUE4Vu2v0ZVPZktsaZjJXwhhUVmZNSku/0egFDL8gbXfaliaXweyRlpuBil
         4O3oNMH32fVpeWn82d4QiUkfO0UqchFpaEFXRGj5YeLDP8066hM5cxAtGVZPNYyySruV
         zdTg8wHAb/fgJJanmKqPJwXSb01DuFFE2kCNIcKk0uOGGvKiiKHhm9n4Z476XLC8tvWs
         avirw6VZ69KR4HktTex8IS3J46kCfdDzUvQdraN/q8KgKZz5W574sCDEt6Z3rqRFQj6G
         hSSwNQYd5gVL/hSayBfvJy5OaO2gWDEm63bMQkljy/GeMTjheMXkUGYMZGesjw7oTSuF
         cfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219293; x=1723824093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRHkMeyOghMMPrSX3/7w5ue7vx+CNaxKKfqAReZDd9I=;
        b=tRXsya1NeIM6v+CzD3WO2XtUDyeKn9VztS6mTmGi38tY46/a5l/rzmDNZhCytvWjgy
         YON65RwrKIohyr2jfxDn9eBRZ4Oa9CvsoOC40FK2nDlQEqbIeIRO09JpVlLlTLFPyXuV
         lAsLKjIP5MyTzmwJ9im5Qyu6qCNo/KS42s7ykqpDnTGg72GpyBXDZXYCR61ZVbyt+EuR
         zGpUWAwwEfU7+ii7BW/nwco/bhWSe7TrTtdfz3IM5Htcoeu5fIq6yZjPxLcpGcGimkpD
         1anX3P/T/6OhnK7h6TdL1IZ0MLERB5LavKvMgrnzCHMh2SlUfmt+G7NPEgdipXSLpFTu
         B2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCX8nhhWow+TO29ugb9Ye/34Ao+ZDPT9vsJI2yBXRqMq4V/A4pumNgAxUc0tLU5qz/IfKG6pXXQIQ5ap815PzqZ3TtKYXpMqw76s
X-Gm-Message-State: AOJu0YwU4jQd8NGsy9MpLc7mpruxBfYkWLJv4s1NtuO1HyxpehVQ0tgQ
	mpunIVIYN8ULMernEBCuGoG0ywDcDhBbn9quM1fqUGNtJTa/bf8lqCw6jBxNsyU=
X-Google-Smtp-Source: AGHT+IH9cyUlesTG85P8+AooQGiR7emhvTR2YwnxoSVddeAKsx77skaLFRBiuQBnXteKmSR5RIAFsg==
X-Received: by 2002:a05:6820:821:b0:5c6:61b9:20ba with SMTP id 006d021491bc7-5d867c8185amr2330284eaf.1.1723219292772;
        Fri, 09 Aug 2024 09:01:32 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d757178a0dsm4280141eaf.7.2024.08.09.09.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 09:01:32 -0700 (PDT)
Message-ID: <4c62baf4-fcb0-474f-87cf-9689aa41966a@baylibre.com>
Date: Fri, 9 Aug 2024 11:01:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad4695: implement triggered buffer
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com>
 <20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>
 <8bb01a8946aaa5855b5ac15d79c0292a668eee59.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <8bb01a8946aaa5855b5ac15d79c0292a668eee59.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/9/24 9:24 AM, Nuno Sá wrote:
> On Wed, 2024-08-07 at 15:02 -0500, David Lechner wrote:
>> This implements buffered reads for the ad4695 driver using the typical
>> triggered buffer implementation, including adding a soft timestamp
>> channel.
>>
>> The chip has 4 different modes for doing conversions. The driver is
>> using the advanced sequencer mode since that is the only mode that
>> allows individual configuration of all aspects each channel (e.g.
>> bipolar config currently and oversampling to be added in the future).
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
> 
> Hi David,
> 
> Just two nit comments...
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> 
>>  drivers/iio/adc/ad4695.c | 233 ++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 230 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
>> index 007ecb951bc3..a3bd5be36134 100644
>> --- a/drivers/iio/adc/ad4695.c
>> +++ b/drivers/iio/adc/ad4695.c
> 
> ...
> 
>>
>>  
>> +static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
>> +{
>> +	struct ad4695_state *st = iio_priv(indio_dev);
>> +	struct spi_transfer *xfer;
>> +	u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
>> +	bool temp_chan_en = false;
>> +	u32 reg, mask, val, bit, num_xfer, num_slots;
>> +	int ret;
>> +
>> +	/*
>> +	 * We are using the advanced sequencer since it is the only way to read
>> +	 * multiple channels that allows individual configuration of each
>> +	 * voltage input channel. Slot 0 in the advanced sequencer is used to
>> +	 * account for the gap between trigger polls - we don't read data from
>> +	 * this slot. Each enabled voltage channel is assigned a slot starting
>> +	 * with slot 1.
>> +	 */
>> +	num_slots = 1;
>> +
>> +	memset(st->buf_read_xfer, 0, sizeof(st->buf_read_xfer));
>> +
>> +	/* First xfer is only to trigger conversion of slot 1, so no rx. */
>> +	xfer = &st->buf_read_xfer[0];
>> +	xfer->cs_change = 1;
>> +	xfer->delay.value = AD4695_T_CNVL_NS;
>> +	xfer->delay.unit = SPI_DELAY_UNIT_NSECS;
>> +	xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
>> +	xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
>> +	num_xfer = 1;
>> +
>> +	iio_for_each_active_channel(indio_dev, bit) {
>> +		xfer = &st->buf_read_xfer[num_xfer];
>> +		xfer->bits_per_word = 16;
>> +		xfer->rx_buf = &st->buf[(num_xfer - 1) * 2];
>> +		xfer->len = 2;
>> +		xfer->cs_change = 1;
>> +		xfer->cs_change_delay.value = AD4695_T_CONVERT_NS;
>> +		xfer->cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
>> +
>> +		if (bit == temp_chan_bit) {
>> +			temp_chan_en = true;
>> +		} else {
>> +			reg = AD4695_REG_AS_SLOT(num_slots);
>> +			val = FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit);
>> +
>> +			ret = regmap_write(st->regmap, reg, val);
>> +			if (ret)
>> +				return ret;
>> +
>> +			num_slots++;
>> +		}
>> +
>> +		num_xfer++;
>> +	}
>> +
>> +	/*
>> +	 * Don't keep CS asserted after last xfer. Also triggers conversion of
>> +	 * slot 0.
>> +	 */
>> +	xfer->cs_change = 0;
>> +
>> +	/**
>> +	 * The advanced sequencer requires that at least 2 slots are enabled.
>> +	 * Since slot 0 is always used for other purposes, we need only 1
>> +	 * enabled voltage channel to meet this requirement. This error will
>> +	 * only happen if only the temperature channel is enabled.
>> +	 */
>> +	if (num_slots < 2) {
>> +		dev_err_ratelimited(&indio_dev->dev,
>> +			"Buffered read requires at least 1 voltage channel
>> enabled\n");
> 
> This one is intriguing... Why the ratelimited variant? Normally you'd use that in IRQ
> routines where the log could be flooded.

IIO Oscilloscope does a lot of retries of buffered reads very quickly,
so was getting a minor flood (10-20 repeats). I'm not sure that
ratelimited actually helped in this case though.

I suppose we could just drop this and expect people to read the docs
if they get an EINVAL when attempting to enable the buffer. Or just
make it dev_err() since it isn't 100s of repeats.

>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Temperature channel isn't included in the sequence, but rather
>> +	 * controlled by setting a bit in the TEMP_CTRL register.
>> +	 */
>> +
>> +	reg = AD4695_REG_TEMP_CTRL;
>> +	mask = AD4695_REG_TEMP_CTRL_TEMP_EN;
>> +	val = FIELD_PREP(mask, temp_chan_en ? 1 : 0);
>> +
>> +	ret = regmap_update_bits(st->regmap, reg, mask, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	spi_message_init_with_transfers(&st->buf_read_msg, st->buf_read_xfer,
>> +					num_xfer);
>> +
>> +	ret = spi_optimize_message(st->spi, &st->buf_read_msg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* This triggers conversion of slot 0. */
>> +	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
>> +	if (ret) {
>> +		spi_unoptimize_message(&st->buf_read_msg);
>> +		return ret;
>> +	}
> 
> Could save one line with (unless ad4695_enter_advanced_sequencer_mode() does not
> return 0 on success)

sure

> 
> ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
> if (ret)
> 	spi_unoptimize_message(&st->buf_read_msg);
> 
> return ret;
> 
> - Nuno Sá
> 


