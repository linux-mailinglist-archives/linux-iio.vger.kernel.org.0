Return-Path: <linux-iio+bounces-26605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C59FC99444
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 22:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271553A2E51
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 21:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8660286409;
	Mon,  1 Dec 2025 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XRK5sdeB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26727AC57
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626004; cv=none; b=LrtFTh0Tr9uN3oLclBReEtHHrWC98I9fCjE+qWGGyEXbnwyPiFiswnjPcHOlhlmKoDCyoz0e6lwwZWsoQJ2J36yprRcEXs/LCuXZiHKy0QwdAv5Fc6AaJdIJnqaRyD9BKLcBMXMsL9R37zOPD2DY5lTDl9w++fSbECJ0X4ISpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626004; c=relaxed/simple;
	bh=5q9Iv//mIpypUaynw8++s+lccd4+l1jE8IYnVDYU7vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huLdS4sapOKG8MLTi6rcF9JbDPKIg1ZCiywRCK+P5IGH/SC0VeSPJPQlRGPex3XdZqtOtdwVm98h9eRz6sJCAskDHD3zI9hrd5MqbEKWmNzMfeqVIrkP2iAX+pV6k/8qrHXCiA1L4647Z3c+opm3wrQ1zbaniNMbxfwzqA+ny0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XRK5sdeB; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3e898ba2a03so3168560fac.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 13:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764626001; x=1765230801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFhnDBg0kXeD51glLwE29J4X5kSMJanTCsRTgbxRyOo=;
        b=XRK5sdeBGipUVk9GL2VDNJRXpH6y+lixsSeXsVf0z3fkYYbW3mjLwcVmiSa3cu8W1g
         kMpD5YcCSicygQ4JALuLnonzEW9irJMmfgMZM/YwGBWAsS8+WCQXbUpLFLFj5TXZmtgq
         wYQbE6b5XwZXVg4uWBMXT7ypzV/tqki9bgjVJzSXYV3+AKt47AfynXPK0OMiX5SnDN/g
         vr4IA3MBLaH9bJKqttnTjRwm+jZTWt1MkMnfFV8TvJf55pwObWR+lavOzGJyZvmGHDOm
         iAGn7XUJ6CFVsHRo+qi+5BXMTOSfeQh/M5K5a2gbTpzI4G2bpVllYX38/YwTfC7oy8Zb
         6DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764626001; x=1765230801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFhnDBg0kXeD51glLwE29J4X5kSMJanTCsRTgbxRyOo=;
        b=T5F5v856TfKcSNEMChYPpcAUCU1vdAFSwxTH0vLKhtcnbnHO1h1uBkIl4PF71vw7ZB
         s60kG2/3oZwiDqn9WAFvlu90Tu+4u1SKd4Ms1OCN7VzChRbzO+1VYbTjYIGoO8KqtBE7
         qKw97l+PY0qAm4lf/6azWFnjxrm1vhVbyHruGfiD37GPqC0RKj20vE79nK03WQtGOvLM
         7WTS3B0doFsIWF1u9dpnbpRkA6rZMjuGELjh8TBsmJ/Hwy8QruXwHLJniWqi+zMQS4S5
         aD7bsnvicGBru/Zsa1fYyh4Hy6XQV+/NSnCaJpXT90fYuRpdVLgJ1nnObECNw1O4JrNM
         AlaA==
X-Forwarded-Encrypted: i=1; AJvYcCU0xoYL3LFdROnjzaOGydHkzxXM0418kOGIw5oSf299VU4ArRkTgdHdgVaeUdZiE3w4/Ww3ubCJ0rY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/OX4UF/+taEQmmWQavStYXVZyuYSt7AE5AP85g5lcU7BhHH4C
	eeJNQE5pN0haS4fpJV4rx9SglOedN5lr7C9Y9YKbyxRz74t6nhTt/DNuYGlEytmeqo4=
X-Gm-Gg: ASbGncsUiFGyM8F8eCYnsd/k0CCK/LyE1j/JnPHTLYx/pHkO2sgREw5pm79vV0100C6
	a5OSurFZAyQ/pd/4VUKOcot9ipmKe+9ZeVaQ/4jDEE4xyihnFMkE0KX5V3bhJOnFj2TGXpiir/n
	yQVBeXMjoY3MyW+L0OMWS/Uz197o0SCMcLetjmK7+E/G+JxPp8cnctFuWwGLrrY1FaaY0QyJs9d
	MUzmyZLKvzKl47pGTUJlO5/eRwVC3nCXDtA0OnWb2WvUoOXkVADboJP+P5kjBDPXHP8xJcifp3C
	tVrXrpYal3tGwJueW95Jp3zc7eD6xXuT3CzqB1xP/KAR3VM+vZkoC6CevQ85Rq34LW7Epr2Lghy
	LIBnkP5Y+MqG+0xsnpSN7baX7b1eS2bxIKiR/znxAmOHBiQa5s/MvcxIGXRPQ4VpMmeAImCCEgA
	60ZZa7x4c3+tzHEnMJcfXfi2fu7Dm5LoU5lqSFISODC+aYksVXDrXj130gGw==
X-Google-Smtp-Source: AGHT+IEUi4HQD4MeWgmtjcJxdxnSWi94Lov5ZIkoWcpAPeNP+EfY38zUZPLeRZvSH7fA6B55qw8ZqA==
X-Received: by 2002:a05:6870:e0c6:b0:3d4:b76:5080 with SMTP id 586e51a60fabf-3ed1fd9424emr12729233fac.28.1764626001435;
        Mon, 01 Dec 2025 13:53:21 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:b67b:16c:f7ae:4908? ([2600:8803:e7e4:500:b67b:16c:f7ae:4908])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dd05bc9asm6083995fac.22.2025.12.01.13.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 13:53:20 -0800 (PST)
Message-ID: <248b009e-0401-4531-b9f0-56771e16bdef@baylibre.com>
Date: Mon, 1 Dec 2025 15:53:19 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
To: Kurt Borja <kuurtb@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Tobias Sperling <tobias.sperling@softing.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <aSsBdJZDWcadxEHC@smile.fi.intel.com> <DELPNLNPGQSM.1YDTB81AG0RAY@gmail.com>
 <18fbf486-c1cc-4cd2-af12-ffa093fa9ce7@baylibre.com>
 <DEN50VFOIB5O.1ENBKI6JQ0ZC@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DEN50VFOIB5O.1ENBKI6JQ0ZC@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 1:47 PM, Kurt Borja wrote:
> On Mon Dec 1, 2025 at 11:07 AM -05, David Lechner wrote:
> 
> ...
> 
>>>>> +	if (iio_device_claim_buffer_mode(indio_dev))
>>>>> +		goto out_notify_done;
>>>>> +
>>>>> +	if (iio_trigger_using_own(indio_dev)) {
>>>>> +		disable_irq(ads1018->drdy_irq);
>>>>> +		ret = ads1018_read_unlocked(ads1018, &scan.conv, true);
>>>>> +		enable_irq(ads1018->drdy_irq);
>>>>> +	} else {
>>>>> +		ret = spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_buf));
>>>>> +		scan.conv = ads1018->rx_buf[0];
>>>>> +	}
>>>>> +
>>>>> +	iio_device_release_buffer_mode(indio_dev);
>>>>> +
>>>>> +	if (ret)
>>>>> +		goto out_notify_done;
>>>>> +
>>>>> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
>>>>> +
>>>>> +out_notify_done:
>>>>> +	iio_trigger_notify_done(ads1018->indio_trig);
>>>>
>>>> Jonathan et al., maybe we need an ACQUIRE() class for this? It will solve
>>>> the conditional scoped guard case, no?
>>
>> No, ACQUIRE() is not scoped, just conditional. I don't think it
>> will improve anything here.
> 
> Maybe I'm not understanding the problem fully?
> 
> I interpreted "ACQUIRE() class" as a general GUARD class, i.e.
> 	
> 	guard(iio_trigger_notify)(indio_dev->trig);
> 
> This way drivers may use other cleanup.h helpers cleaner, because of the
> goto problem?
> 
> I do think it's a good idea, like a `defer` keyword. But it is a bit
> unorthodox using guard for non locks.
> 
> 

To take a simple example first:

static int
ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
		 int *val, int *val2, long mask)
{
	int ret;

	if (!iio_device_claim_direct(indio_dev))
		return -EBUSY;

	ret = ads1018_read_raw_unlocked(indio_dev, chan, val, val2, mask);

	iio_device_release_direct(indio_dev);

	return ret;
}

using ACQUIRE would look like:

static int
ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
		 int *val, int *val2, long mask)
{
	int ret;

	ACQUIRE(iio_device_claim_direct_mode, claim)(indio_dev);
	if ((ret = ACQUIRE_ERR(iio_device_claim_direct_mode, &claim)))
		return ret;

	return ads1018_read_raw_unlocked(indio_dev, chan, val, val2, mask);
}

It makes it quite more verbose IMHO with little benefit (the direct
return is nice, but comes at at an expense of the rest being less
readable).



And when we need it to be scoped, it adds indent and we have to do
some unusual things still to avoid using goto.

static irqreturn_t ads1018_trigger_handler(int irq, void *p)
{
	struct iio_poll_func *pf = p;
	struct iio_dev *indio_dev = pf->indio_dev;
	struct ads1018 *ads1018 = iio_priv(indio_dev);
	struct {
		__be16 conv;
		aligned_s64 ts;
	} scan = {};
	int ret;

	do {
		ACQUIRE(iio_device_claim_direct_mode, claim)(indio_dev);
		if ((ret = ACQUIRE_ERR(iio_device_claim_direct_mode, &claim)))
			break;

		if (iio_trigger_using_own(indio_dev)) {
			disable_irq(ads1018->drdy_irq);
			ret = ads1018_read_unlocked(ads1018, &scan.conv, true);
			enable_irq(ads1018->drdy_irq);
		} else {
			ret = spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_buf));
			scan.conv = ads1018->rx_buf[0];
		}
	} while (0);

	if (!ret)
		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);

	iio_trigger_notify_done(ads1018->indio_trig);

	return IRQ_HANDLED;
}

So unless Jonathan says this is what he wants, I would avoid it.


