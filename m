Return-Path: <linux-iio+bounces-27894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DB1D38923
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 23:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B58343030220
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 22:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8812D310627;
	Fri, 16 Jan 2026 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EYLdByTj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667B42FE595
	for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602027; cv=none; b=F5/IQCEezHuwEdGZ1Rr4oA9ExLdqfK4hIdMA3zEmiG3ZqekVIa0qJsk5fagFh19Xd+DMgOZYDt6d3mO2WHzHmmOkW3LxyC9HDmmpIgkde6NWSk0vGOouotVys4A2jI18WMJzADsxBeTJ5xdDUkjpsq8UrumTsbyz6DPzsqS+JKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602027; c=relaxed/simple;
	bh=OEmqdhIPmzTwDWvFd9exgmD7UHB1XnTXMIlYEG3XThc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVpWBdtA+1JOCpRVNkJPjoGl7fIAEHmzTZHvx+i0NJ5KuteXDAtwLw6/7AoxCi+FPX5F0WuJomAGDcwDaM03y0BuxNaOL2x8TbKmA8IkmmO2krgRLxqD7z/HnGHheu84KpMs2Wr2Q07m2mboNxgao8L5sIm6aWyzYSUK985Qcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EYLdByTj; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7cfda2de4efso1935322a34.3
        for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 14:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768602023; x=1769206823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdrCCG3otINbumAXLhBWtOU7pMD6Zf4l8oy3F367IpY=;
        b=EYLdByTjWCBw6v8kh3Q+3FUt6xRwEOxLb+AktzLskCtxVud1v9GX82ebySZBXgXMjm
         wgxAcoietvbL3K3GwddXamCF0KbOAAG1rist05JrOYcuWGI3u4HDzGVhm6aXBZa6HVmr
         MREXc7AI2mgRfu3Z3jOwgBdxrwRD4s59w2RLJdVSBgITFTHbL0ZftNJDzRa9AHwrnA2K
         PvcSa9IsoU84FYTaaVfCWMSObgC9o6zJmDLgI1JvCLsatP1ypxPRNWlhLlGgI8ywzSS2
         EZ3/2iaZJCDWBTG7rFl7ilzLzHR6ZjQon/EkNH+YUzrar8rSNEW9iLeNXXaMIA8ghagC
         lwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602023; x=1769206823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdrCCG3otINbumAXLhBWtOU7pMD6Zf4l8oy3F367IpY=;
        b=Snn/7CFYVhzAnQctY3UIs58OKFUksAQyZvkn1UovV5q/rCVF2NAWf9zjInbTQtXck0
         J30yXexq/45FKF21symQdMcemd13IX8VYGnj9vBqqg+9T0UAws7/qgZDW8PJYiTu21CC
         Zq/9HEnpzs8kSgxpyG9uC1ybxJYG0TOkDWFiMevuj1F+Tqa+IOV0JNDN8F+ACALnDVHN
         mFzqO1v7UjQgmCpCuxKsMsaXW4kHZq/K5USDq9F+glU6kQUharVFIjY7HvTH4qwPX8pn
         NR9/YuvmUM0z3VnxDspHHOS91rbZ0sP/d/32zcO56ToPNdlI6CUW/TSRpemnNNRgrRj7
         8g+w==
X-Forwarded-Encrypted: i=1; AJvYcCVri2SXC43w52dipMtSuy0nc46S28nUFViaoVp9ci0GQDJRM3kqjgTclFbRXVhyW0laS0jArY3lUY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4PYIAkB1KtXmPTubJNZMD2ovvAbz3/aowyszWXo6FT+2GIsV8
	EBJU4FxMdbGRA1CIRJQk0UdCjPpcKQTkrxNX23i/rPlRTRQsfmUqAXqHv8Mt+nddnwk=
X-Gm-Gg: AY/fxX7QppTznRU1W/9rqDOHlRMNu5zP5DpKwZvXHDLZ0DVNbd/lIrKS/0zp3qQkp7O
	YawY33YHqZyFg7DC83wHg651nrRG7UnR5ZzcsZZzl92aL/hSS2PWv7RZOu+hIHinBSESrJlPmBI
	CgSwoGq6RIpW2xF9sab8RM7Zmieexo9VC9hKqFp9Rplut1L99Y9+Y3jkTCNXtC9WlqEHmk6I/nF
	9NfpQbcfh0vZoDKQT3v1mb6ZzcJk/7n/+smk/He3+JBG2s8V+lBGj/DKAymUVYBkuSaE1mSOrzT
	tGxE2lHfRYOJ+JcPY2vTJbgIXMVSiZ5+2qQmwnxl9qz63j+Ff50yt3zdF1/w6mko6DJ74i2NE9r
	PZvTEQ8aqEvOSVyutKisMsBdeeb6seEwVdI+AvMPq8ZTWK2nAHS80qDpB5//VCPFQfU1GrKhLrI
	AjDjvtCsOCqFRf3vD+3F7jjEtzcrepHZelQxIbrlgO/vTEIfRJb/2vY2oYqun6
X-Received: by 2002:a05:6830:6c0d:b0:7cf:d187:f278 with SMTP id 46e09a7af769-7cfdee0b021mr2785720a34.17.1768602023221;
        Fri, 16 Jan 2026 14:20:23 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:bd39:740e:f70f:5f7d? ([2600:8803:e7e4:500:bd39:740e:f70f:5f7d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0d8e05sm2440876a34.6.2026.01.16.14.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 14:20:22 -0800 (PST)
Message-ID: <cd0d6cb6-c025-4fab-9f40-300507b73f43@baylibre.com>
Date: Fri, 16 Jan 2026 16:20:21 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] spi: support controllers with multiple data lanes
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
 <20260112-spi-add-multi-bus-support-v5-3-295f4f09f6ba@baylibre.com>
 <20260114090508.3ebef716@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260114090508.3ebef716@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 3:05 AM, Jonathan Cameron wrote:
> On Mon, 12 Jan 2026 11:45:21 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add support for SPI controllers with multiple physical SPI data lanes.
>> (A data lane in this context means lines connected to a serializer, so a
>> controller with two data lanes would have two serializers in a single
>> controller).
>>
>> This is common in the type of controller that can be used with parallel
>> flash memories, but can be used for general purpose SPI as well.
>>
>> To indicate support, a controller just needs to set ctlr->num_data_lanes
>> to something greater than 1. Peripherals indicate which lane they are
>> connected to via device tree (ACPI support can be added if needed).
>>
>> The spi-{tx,rx}-bus-width DT properties can now be arrays. The length of
>> the array indicates the number of data lanes, and each element indicates
>> the bus width of that lane. For now, we restrict all lanes to have the
>> same bus width to keep things simple. Support for an optional controller
>> lane mapping property is also implemented.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> v5 changes:
>> - Use of_property_read_variable_u32_array() for lane maps.
> For this, I think you need to check for short maps.
>>
>> v4 changes:
>> - Update for changes in devicetree bindings.
>> - Don't put new fields in the middle of CS fields.
>> - Dropped acks since this was a significant rework.
>>
>> v3 changes:
>> * Renamed "buses" to "lanes" to reflect devicetree property name change.
>>
>> This patch has been seen in a different series [1] by Sean before:
>>
>> [1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-4-sean.anderson@linux.dev/
>>
>> Changes:
>> * Use u8 array instead of bitfield so that the order of the mapping is
>>   preserved. (Now looks very much like chip select mapping.)
>> * Added doc strings for added fields.
>> * Tweaked the comments.
>> ---
>>  drivers/spi/spi.c       | 116 +++++++++++++++++++++++++++++++++++++++++++++++-
>>  include/linux/spi/spi.h |  22 +++++++++
>>  2 files changed, 136 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index e25df9990f82..5c3f9ba3f606 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -2370,7 +2370,53 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>  		spi->mode |= SPI_CS_HIGH;
>>  
>>  	/* Device DUAL/QUAD mode */
>> -	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
>> +
>> +	rc = of_property_read_variable_u32_array(nc, "spi-tx-lane-map",
>> +						 spi->tx_lane_map, 1,
>> +						 ARRAY_SIZE(spi->tx_lane_map));
> 
> This reads 'up to' the ARRAY_SIZE(spi->tx_lane_map)
> If it is short, what is the right thing to do?  I'd either expect a check
> for that or for rc to be stashed somewhere if positive for later use.
> If the intent is for short the default of 0 is fine, then if it's a lot
> short we'll end up with repeated mappings to 0 which makes little sense.

The right thing would be to make sure that spi-tx-lane-map and
spi-tx-bus-width are the same size. I suppose we could reorder it
and call of_property_count_u32_elems(nc, "spi-tx-bus-width") first
to avoid needing to do the variable read.

> 
> 
>> +	if (rc == -EINVAL) {
>> +		/* Default lane map */
>> +		for (idx = 0; idx < ARRAY_SIZE(spi->tx_lane_map); idx++)
>> +			spi->tx_lane_map[idx] = idx;
>> +	} else if (rc < 0) {
>> +		dev_err(&ctlr->dev,
>> +			"failed to read spi-tx-lane-map property: %d\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	rc = of_property_count_u32_elems(nc, "spi-tx-bus-width");
>> +	if (rc < 0 && rc != -EINVAL) {
>> +		dev_err(&ctlr->dev,
>> +			"failed to read spi-tx-bus-width property: %d\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	if (rc == -EINVAL) {
>> +		/* Default when property is not present. */
>> +		spi->num_tx_lanes = 1;
>> +	} else {
>> +		u32 first_value;
>> +
>> +		spi->num_tx_lanes = rc;
>> +
>> +		for (idx = 0; idx < spi->num_tx_lanes; idx++) {
>> +			of_property_read_u32_index(nc, "spi-tx-bus-width", idx,
>> +						   &value);
> 
> Probably want a sanity check on return value of that even though we are fairly sure
> it won't fail.

I figured that if of_property_count_u32_elems() succeeded then this could not
possibly fail. But OK, why not be extra careful.

> 
>> +
>> +			/*
>> +			 * For now, we only support all lanes having the same
>> +			 * width so we can keep using the existing mode flags.
>> +			 */
>> +			if (!idx)
>> +				first_value = value;
>> +			else if (first_value != value) {
>> +				dev_err(&ctlr->dev,
>> +					"spi-tx-bus-width has inconsistent values: first %d vs later %d\n",
>> +					first_value, value);
>> +				return -EINVAL;
>> +			}
>> +		}
> 


