Return-Path: <linux-iio+bounces-9399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC09971D29
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6731C22D15
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4401BBBD5;
	Mon,  9 Sep 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="29zmF7uO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9141B5831
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893499; cv=none; b=TysXamAbOs8OCAxOr5++r9ijKzwd4n+1aAH+XUlg56PEy70SxtUUwwLi8BwKPCZrbJkFZqxgdz3jkq1oio6wR9YSkvAPH+ePLbkCfwUpyTZ8YXSAL4StVc7n4pQgwPLCMZJ5WbFxbn/5YP19q6xR27p0QbrtDSB0sWjLAElF+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893499; c=relaxed/simple;
	bh=j3mU4tdYMjore0QesUlmdrdfeB9a5NRZXezpUWw/1S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iaSnTz3MgrwLpRVX69vH392AMScxB3E7tgMg0NeO1sdBHkR90d2pnP4JnZ5fqsU/RIxgUwWIx2owyRoQfPIm2XI/9ZhupFBwqyEfdiAFTpOd0gygrXBmou6ziT9+zr4B4Rrh58B7RyBb3+EoUyEu6Hcg69ZLBkWg/X6npB5ue18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=29zmF7uO; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-277fdd7d468so2247165fac.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Sep 2024 07:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725893497; x=1726498297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=swFPKNWcihOAPLCaadZWgBeKWWqmVdaOKmCZlZL0YBM=;
        b=29zmF7uOe2CIyo3IbhxZf5Cg8pPMLRmTHpRYUcOFKls4XlhIG97O657ttV44Em+7CP
         k6MjOZT6tlLTqDdULUEK5LpjqzyI2blPmVWLkzlAYKCeSM71O1BM7Q72cOmZd14yY6cj
         zb3mgiLhlk892Dh+tzpBZQwWtQoiHJ9i0Pqb/QW9ONS1zHZSx8A1AlCsDP6EVgkJb0bg
         MSTjo5BeVByrnu895EDBLIUHu8t95tdRjEYxLDldNzLB97Ga2o9JVS8c4JZS3sb2kfow
         wO/z0syS2CdOyJiJkH/wMEFhDUdKtY5YkMglF0CPN7s3KchUn8JzXUYUIMHMM4zmvkzP
         XhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725893497; x=1726498297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swFPKNWcihOAPLCaadZWgBeKWWqmVdaOKmCZlZL0YBM=;
        b=aOcIz6PhhIqgjwf2AmN7pgnddqXtpeJQxaktFazvQXQfEtknEJzaThTFJGZus/O4Jw
         Rjj/sl6Ln2p2S+DCNdHbUslgqZNQeIKYIGz9P5hGaiTFqj3aVzHFVd6hK+cZphoVd+yf
         AdRLFvVUp/o3MtkUJSVTql1CkphpY2lHRqCj5oxTNF7EHBOhuEraJ6AZCcNlmzi4rnUL
         2Nx5LumUlJb0OishwFe5TAeB/LSnsSBGmhD80pmTuE/x2rE7I5tdoyL8E43VBbD/fK3J
         SVvPk7QxWawBKO0rnQCID7YNHfKkwAbB79AYgPn7S2bYZkANSI9zrSixBfWoenyvXVpK
         Inkw==
X-Forwarded-Encrypted: i=1; AJvYcCWlyyVgN4OLn4j+J7IU2R0b9XQlIzbIZXISHjRt89tq7o1mX0EFr91+wpy6jXmT3is5CvU4dSSvWr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnragwcvWJiDv7pW0kJVnYorgwcJaEvFqKW7e9i1AVg/fyJlqK
	p0SI++jWlru5kJ6lKt3/7AVE3Lx0pJsWX36cJIMNLLU54RUKEG+ctXOCl71lU9g=
X-Google-Smtp-Source: AGHT+IEt6QDwV/OUh2lyrwdisyycf8g9ISbqpcdccx0X/yFxV6vLSXcEdvFd7y9wKe2JQPx/Vc6hUw==
X-Received: by 2002:a05:6870:b025:b0:260:eae3:5ec2 with SMTP id 586e51a60fabf-27b82e8794fmr8226728fac.26.1725893496839;
        Mon, 09 Sep 2024 07:51:36 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27ba41057a9sm1471743fac.49.2024.09.09.07.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 07:51:36 -0700 (PDT)
Message-ID: <b1584871-9a9d-4042-98c3-00581bdb5499@baylibre.com>
Date: Mon, 9 Sep 2024 09:51:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: dac: support the ad8460 Waveform DAC
To: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
 <20240904023040.23352-3-Mariel.Tinaco@analog.com>
 <e9cbcd85-062c-47ad-861c-229cb2fd6c2c@baylibre.com>
 <PH0PR03MB6218D70A20E93C46C186441E91992@PH0PR03MB6218.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <PH0PR03MB6218D70A20E93C46C186441E91992@PH0PR03MB6218.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/24 4:47 AM, Tinaco, Mariel wrote:
> 
> 

...

>>> +	*val = get_unaligned_le16(state->spi_tx_buf);
>>
>> With spi_tx_buf changed to __le16, this can use le16_to_cpu() instead of
>> get_unaligned_le16().
>>
> 
> I suppose we use the cpu_to_le16 for the set_hvdac_word function?
> 
> static int ad8460_set_hvdac_word(struct ad8460_state *state, int index, int val)
> {
> 	state->spi_tx_buf = cpu_to_le16(FIELD_PREP(AD8460_DATA_BYTE_FULL_MSK, val));
> 
> 	return regmap_bulk_write(state->regmap, AD8460_HVDAC_DATA_WORD(index),
> 				 &state->spi_tx_buf, AD8460_DATA_BYTE_WORD_LENGTH);
> }
> 

Yes, that looks correct.


>>> +static ssize_t ad8460_write_toggle_en(struct iio_dev *indio_dev, uintptr_t
>> private,
>>> +				      const struct iio_chan_spec *chan,
>>> +				      const char *buf, size_t len) {
>>> +	struct ad8460_state *state = iio_priv(indio_dev);
>>> +	bool toggle_en;
>>> +	int ret;
>>> +
>>> +	ret = kstrtobool(buf, &toggle_en);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
>>> +		return ad8460_enable_apg_mode(state, toggle_en);
>>> +	unreachable();
>>> +}
>>
>> Hmm... do we need to make an unscoped version of
>> iio_device_claim_direct_scoped()?
>>
> 
> So iio_device_claim_direct_scoped is used here because the buffer enable/disable
> accesses this enable_apg_mode function. Is it also a standard practice to put the
> kstrobool() util inside the scope?
> 

Since this is at the end of a function with nothing after it, it
would be nice if we could avoid the indent and unreachable();

The idea would be to write the last 3 lines like this instead:

	guard_cond(iio_device_claim_direct, return -EBUSY, indio_dev);

But I didn't see a `guard_cond()` analog of `guard()` in
linux/cleanup.h. So this is probably fine for now and adding
`guard_cond()` (if it is actually a good idea in the first
place) can be a job for another time.

