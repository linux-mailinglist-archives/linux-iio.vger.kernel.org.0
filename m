Return-Path: <linux-iio+bounces-16859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB05A61C02
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 21:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A42117EF94
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 20:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7FD205E20;
	Fri, 14 Mar 2025 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p6vCjM5P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FE204C3E
	for <linux-iio@vger.kernel.org>; Fri, 14 Mar 2025 20:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982629; cv=none; b=J4AFR0ux+wDAbtN1GYHuHSRwPcl0CrQylfh17clIwloM4XRLL4Xsj8eSCgQ+8UDXQofsKMwtBuHRr5iaoknE+4l5foukMyEkk3Qw2x0e6rvbqF9F8U0QPH9K9PCnFpRsnqglQcwRs7FwTTA4dC3ruEaaGm/Gt6UXgE5RArar7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982629; c=relaxed/simple;
	bh=NBh1ib8TOp9yV+GZ8BCBjXKYANmqvBc+qIjMQrykCt0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DTd+yPlxZsnPtnuc0isY7c/03zjVa3jFwSr3GwgxrRo6GgJWTAZWnn7o5muKWUavq3sjhWcWkFALXhBmsAsRVPtjcjGP5BaoFio9s43IwQFH3V5ADybxr0RXHk6RrPCEzIxFtJC07Ji2/n/P/JTGu1DO96pNAtZQqjHf1cEq/XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p6vCjM5P; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2adc2b6837eso746094fac.1
        for <linux-iio@vger.kernel.org>; Fri, 14 Mar 2025 13:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741982625; x=1742587425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/t8DGEkQgF9HsFcbNry4sid1C4GD98meoHnJLzxyotQ=;
        b=p6vCjM5PH9L2oX6E2UYzwchfFPUuj894SxrVOU7xZEEjJ6cbeJngyt+PzKc01SzjAG
         /lzOLir0vy8G3uZk2/td5Nt7+eMgXFSUKY74CEQXUxKh/dD2DlOwyAWehEZw9Y8dKxu/
         QVt9vArEBhDwdd/BvrvB8VBuhxsRk6WoLTYHI4Bu8Ln4efIlH/rFlSYwUS52cMzgjZci
         Q33U0N3RTQId/6maB5tl10QjYs9DW02yo+W7uamjDyjAPALXorjBF/GHiP/Pm7gW4q/q
         45Qnxni7sFWhiRc6bQ4uoMTGu+H5K+EW+4tiMvy5/REd1K6HHez0dZKnO6PlN53yS7zo
         WbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741982625; x=1742587425;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/t8DGEkQgF9HsFcbNry4sid1C4GD98meoHnJLzxyotQ=;
        b=PTpEtV6PiQ1s6KakQVnrRsV35DEELUEur1SG5FLlUsO5EwZJ4jcELfxFyHwHTR4PQa
         m6XnthzeJwRBpqS3ZyGtCaf58xiEcaDPJ7ILsxsD/M97evdNzdtqzYI52JuQmTmvlpbx
         0Ugllv+BgmULy/uWvz72573YzEvQMs2NeEYXVJ3coqjmmTnDgnsWnap9nvWmKUEyxZMm
         qJhs5pXoS+fHAgdzl1hYCnnxgKZj9ql/4PcrsZ9bwbazUHPptWsEc1RwTLyWxQP3AhXB
         FBNaDInFtgh0peBxsgQ9K3YwSPxbH4dyyHMMeOD+xxTxkG49vlX3WU0HIW6P+Ug6UbyM
         tdsA==
X-Gm-Message-State: AOJu0Yzyn6Dvrf+8i+ssRGzix6dYtoUHOFwPvVNXZAA/Vy1Ukzbj9GWx
	4g4Wk/xxKZ5tmbl8LJzn1P23FmjJPPScx5s46ugGaC8kftgx5zwmW0B6aotDmc0=
X-Gm-Gg: ASbGnctQ4UwvDaHD1ozXeA0I6x9gO2YTeBbF472K98enROyUBbT02g/HL8rFuGGt7IC
	qxmzHNjB+6aQju3PwQTqW/8V3lopptGx4h3PgVQ2W7lVPWKKF7CqyDhHjauEUdOkYzV2NACfpFy
	iRBif55GWrRIPAyUoA7NKoMfY/lqsFGdqMUHYtESGMUx1Fd+mTe2GOv8SGGwxPJ36jiiqt59yVi
	+8Y4wkXbHUoNrBXZAS4SxPEG9wzlrW5V1ZdQBp24/CsCFOuJvCXOdBEI7CEPqCCRJHkoUgv4lgN
	lwMg0YGuMB82nxTnqgRHA0KKzN8x3j36tOt/nCorE4uSNCfce5LrV/9Z3bZdhQMR5RvmYC4tnci
	2LwLE2w==
X-Google-Smtp-Source: AGHT+IHkQhbCbr5tEQHM5PgoUcAYVVLVKKXP4thp4rJGiHPtHTJRGgiHkIs124SWGjZIG2J1tZ5H7w==
X-Received: by 2002:a05:6871:153:b0:297:2376:9b17 with SMTP id 586e51a60fabf-2c690fe92bcmr2006147fac.19.1741982624833;
        Fri, 14 Mar 2025 13:03:44 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb26bbe2esm773443a34.31.2025.03.14.13.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 13:03:44 -0700 (PDT)
Message-ID: <177eb738-fe13-43ae-a02a-7c6b026536ef@baylibre.com>
Date: Fri, 14 Mar 2025 15:03:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: ad7380: add support for SPI offload
From: David Lechner <dlechner@baylibre.com>
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com>
 <7b64c6a9-0606-45ba-be45-7ae11c4fdf39@baylibre.com>
Content-Language: en-US
In-Reply-To: <7b64c6a9-0606-45ba-be45-7ae11c4fdf39@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/25 11:31 AM, David Lechner wrote:
> On 2/20/25 12:03 PM, Angelo Dureghello wrote:
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Add support for SPI offload to the ad7380 driver. SPI offload allows
>> sampling data at the max sample rate (2MSPS with one SDO line).
>>
>> This is developed and tested against the ADI example FPGA design for
>> this family of ADCs [1].
>>
>> [1]: http://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
>>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>> ---
> 

...

>> +#define _AD7380_OFFLOAD_CHANNEL(index, bits, diff, sign, gain) {		\
>> +	.type = IIO_VOLTAGE,							\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                          \
>> +		((gain) ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
>> +		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),			\
>> +	.info_mask_shared_by_type = ((gain) ? 0 : BIT(IIO_CHAN_INFO_SCALE)) |   \
>> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
> 
> Not sure if this is worth troubling with, but it might make more sense to make
> IIO_CHAN_INFO_SAMP_FREQ info_mask_separate instead of info_mask_shared_by_type,
> at least in the case of the single-ended chips.
> 
> This family of chips does simultaneous conversions so shared_by_type (or shared_by_all)
> would typically be the right thing to do here. However, the single-ended versions
> of these chips also have a multiplexer, so there are 2 banks of simultaneously
> sampled inputs. So the effective sample rate as far as IIO is concerned would
> actually be 1/2 of the sampling_frequency attribute value.
> 
> Since we have a channel mask restriction where we force all channels in a bank
> to be enabled at once, I think it would work to make IIO_CHAN_INFO_SAMP_FREQ
> info_mask_separate where the reported sampling frequency is the conversion rate
> divided by the number of channels in a bank.
> 

Hi Jonathan,

You might have missed this since v2 was sent before you had a chance to review
v1. I am testing the chip with the mux now, so I was curious if you had any
wisdom to add here. The way we implemented it feels a little odd to me with
sampling_frequency as info_mask_shared_by_type instead of info_mask_separate
or info_mask_shared_by_all like on most other chips I've worked with so far.

I found a bug in this series that I need to send a fix for, so if we decide
there is a better way here, now would be a good time to do it.

>> +	.info_mask_shared_by_type_available =					\
>> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
>> +	.indexed = 1,                                                           \
>> +	.differential = (diff),                                                 \
>> +	.channel = (diff) ? (2 * (index)) : (index),                            \
>> +	.channel2 = (diff) ? (2 * (index) + 1) : 0,                             \
>> +	.scan_index = (index),                                                  \
>> +	.has_ext_scan_type = 1,                                                 \
>> +	.ext_scan_type = ad7380_scan_type_##bits##_##sign##_offload,            \
>> +	.num_ext_scan_type =                                                    \
>> +		ARRAY_SIZE(ad7380_scan_type_##bits##_##sign##_offload),		\
>> +	.event_spec = ad7380_events,                                            \
>> +	.num_event_specs = ARRAY_SIZE(ad7380_events),                           \
>> +}
>> +


