Return-Path: <linux-iio+bounces-6877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D1E91614F
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 10:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBD5B214CE
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26866149C41;
	Tue, 25 Jun 2024 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vOqFRB9/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B1148849
	for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304315; cv=none; b=cSkSzb2s0D8eiXF+DQ5KgFLJWDL8uxZMSJY+xsjGMYe1ZY1x4FS6TFC+SV3A6WdTBl5pYa0N1i72MMZJIX72+QAjZAgK5XZGBTXTrEhrkkVhMakdL5BM4ftAip95qoMxlmZreGBZ5rG29WtgSseqltZiZvWZbbEv4XgFke/dcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304315; c=relaxed/simple;
	bh=1bUJ/s7vvwTZ73NCTa5DTXqVHc8wDMkrvmx1x4B0xZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JQpDknQHUbqGiN0pxkXnvsZwnGfVO/cclohn22VYlX66hnsK56DCvccjU3ZHP9FewcnmQNdaXrjbmJWR6i6f+Xc0ezY57gKKTz/Fczi9+a4mJCw4s47vTMjhCi3DkEPwiWXq9vXJVTtdbQ/14D/SNStBG5DQ6GJ200rFOiKo4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vOqFRB9/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3621ac606e1so3699516f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719304312; x=1719909112; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6MGiV5QhyBIwfF0R22KIxg/x70JWWD4uGuZLiiLVcCo=;
        b=vOqFRB9/PzYL1IM+qLYv8QSghjaflpCLS8cZ/b9f2KeY4t3MlQyadUCTHIfi3vAeoU
         FttaeIDeDJ4fYLPJtNO5RhZJ2XxF+6NMjKvocB3DrvFyRfI/uM+qKQd7psHrJvowEvai
         /o/YdjYgI/BNLTt4oWTnwHfiP6E6whKLf6+Ju0+r2ceFRMBPQRwXreeoDuNm7gKbhAXX
         gSyCZmcoivNFnHnDU59eyTh9xfktjEX7tkAjsh86mTIctlu8OKdSVpFGJj+n8ZYTLH0P
         UDKr9DKDj10fn2hMtbrKuvdAvIwIdMkcp2XlOkWwQorM/77y7sBMQKIMO4SoE58qDNnU
         gZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304312; x=1719909112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MGiV5QhyBIwfF0R22KIxg/x70JWWD4uGuZLiiLVcCo=;
        b=Jskf0Rx5zy4pepP0+cptyBF50K0+aDUwi8ufVHKVZJSpaj/gjCTdKT54NMsUmSdQtX
         Pf2NNj8eR0pG8ULJKEqYRIToy93x4ii2Q297Hat9LYeEqlswdIxdHX2iJ7gfQoVLc6QG
         zmRw8YGWEagR24TxGrul0u/CE44RY0VAJs52oiO8YJyQxSuZ7Ow/IvjV7sOTv6abnU1h
         Y/cemfcL9Er4aOHZeIlzDtdqqltz1fG+xvzXfiiJ/xtWTP8NJXhBl3VRIG9fnqsxbyIE
         7FvXwb4IYeI7xJj99HF4nWbhrabvsn9jCZJYiUllOwX7W66NBFKdA+jQqOJhD5JPVoka
         nyBA==
X-Forwarded-Encrypted: i=1; AJvYcCVbg2iglRu4FbBKjddcmWO1mwwFoTxjuDJerSd6hujGfNPEVuLC56qs3tFsFXzG9jwE5SPolvYf5bWbEx2xLyiaBjNkNWij/5To
X-Gm-Message-State: AOJu0Yzm5wvpIEnLz7b6bi/AE2yidJiVi1VlADcGfLIXSGbmhOo3QKDX
	5ueSFe2UeKowC0rqKApsJ68oqmQTxNg1NmIWKh/YSrQfHb8WwWWmTZHmMYWt5x8=
X-Google-Smtp-Source: AGHT+IHXVO0K6EtgWIdnjCpVKEK7FGGlTzFiwp9mjcV6PfHRnKrDwThJVhKUFKQBIxHO02PjXcqiXg==
X-Received: by 2002:a05:6000:1241:b0:366:e09c:56be with SMTP id ffacd0b85a97d-366e325c00amr6885391f8f.6.1719304312228;
        Tue, 25 Jun 2024 01:31:52 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1b57:b4a1:3d50:32a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366388c401asm12286172f8f.45.2024.06.25.01.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:31:51 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin
 Hilman <khilman@baylibre.com>,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-iio@vger.kernel.org,  Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: frequency: add amlogic clock measure support
In-Reply-To: <04254d15-2f6e-435d-ba4c-8e2e87766b9b@baylibre.com> (David
	Lechner's message of "Mon, 24 Jun 2024 17:51:05 -0500")
References: <20240624173105.909554-1-jbrunet@baylibre.com>
	<20240624173105.909554-3-jbrunet@baylibre.com>
	<04254d15-2f6e-435d-ba4c-8e2e87766b9b@baylibre.com>
Date: Tue, 25 Jun 2024 10:31:51 +0200
Message-ID: <1j4j9hift4.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 24 Jun 2024 at 17:51, David Lechner <dlechner@baylibre.com> wrote:

> On 6/24/24 12:31 PM, Jerome Brunet wrote:
>> Add support for the HW found in most Amlogic SoC dedicated to measure
>> system clocks.
>> 
>
>
>
>> +static int cmsr_read_raw(struct iio_dev *indio_dev,
>> +			 struct iio_chan_spec const *chan,
>> +			 int *val, int *val2, long mask)
>> +{
>> +	struct amlogic_cmsr *cm = iio_priv(indio_dev);
>> +
>> +	guard(mutex)(&cm->lock);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		*val = cmsr_measure_unlocked(cm, chan->channel);
>
> Is this actually returning an alternating voltage magnitutde?
> Most frequency drivers don't have a raw value, only frequency.

No it is not the magnitude, it is the clock rate (frequency) indeed.
Maybe altvoltage was not the right pick for that but nothing obvious
stands out for Hz measurements

>
>> +		if (*val < 0)
>> +			return *val;
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_PROCESSED: /* Result in Hz */
>
> Shouldn't this be IIO_CHAN_INFO_FREQUENCY?

How would I get raw / processed / scale with IIO_CHAN_INFO_FREQUENCY ?

>
> Processed is just (raw + offset) * scale which would be a voltage
> in this case since the channel type is IIO_ALTVOLTAGE.

This is was Processed does here, along with selecting the most
appropriate scale to perform the measurement.

>
>> +		*val = cmsr_measure_processed_unlocked(cm, chan->channel, val2);
>> +		if (*val < 0)
>> +			return *val;
>> +		return IIO_VAL_INT_64;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>
> What is this attribute being used for?

Hz

>
> (clearly not used to convert the raw value to millivolts :-) )
>
> Maybe IIO_CHAN_INFO_INT_TIME is the right one for this? Although
> so far, that has only been used with light sensors.

I think you are mixing up channel info and type here.
I do want the info
 * IIO_CHAN_INFO_RAW
 * IIO_CHAN_INFO_PROCESSED
 * IIO_CHAN_INFO_SCALE

I want those info to represent an alternate voltage frequency in Hz.
I thought type 'IIO_ALTVOLTAGE' was the right pick for that. Apparently
it is not. What is the appropriate type then ? Should I add a new one ?

>
>> +		*val2 = cmsr_get_time_unlocked(cm);
>> +		*val = 1000000;
>> +		return IIO_VAL_FRACTIONAL;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +

-- 
Jerome

