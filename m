Return-Path: <linux-iio+bounces-21003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE67AEBE5D
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 19:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D9D16513C
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0034D299AB3;
	Fri, 27 Jun 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vPute5QG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3492E8E08
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751044799; cv=none; b=djXYRIsNgX/5Iz8FE+U+Bde0gCrtoUZENR3KMVujCqkY6c64kT6T7PR6AGGALYOCtwv8mNbH0ss1/nNaWW2VWnZre/nz4D0b/IJEkQ+KJ7lo2wLkZNuWRqKFrsjEF+opX6+qdpfgIEbgXux/SAgdvVeg5n/KPhv/ggxz9OgW1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751044799; c=relaxed/simple;
	bh=tEgg4yLq8nCzAwv3QHxo1pvvJEaNwghf7L7c/Jfil0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juVrlX5mtfvzTAqjR6rMFVrm+MMvFHgiOCKWIHbHWU/WuUAvUlnEWb62k5Rxn0KtbH1t8FOQGr38raPJKHpBFqj0rPV4JHb1VGzeVQQAtUNddG1NRhqQYMfuoy593AX3pDCHEpmVYTfwhEAx/bH3IqhHV2wc17n1R1fz2aepTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vPute5QG; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso73557fac.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 10:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751044796; x=1751649596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJvljz9Tnw+ULEBiMWy1DRf4iuiUFI2ZolKXoPlMGY8=;
        b=vPute5QGwAg9NLuWrbR+nMo2G/v9pU0AUduABDNXzx9W1vlU8A8cz6KeT4Y4JQmoNB
         48RFyA4RB3LQ2lW5LMbZJeQSWYqDIyNv7BrRYiuR1Zi6+GQ0GD/9eGzrWNQYeuM5HqAJ
         SeCTlR8ANzyk6OAHQRnvUxb01B1hzxghH8fsSZnagaBqbzmMInHsAtdW9qL/YoVIUnYi
         gZ1mbHsIonmJQleafG0LJUXxMfeTUvc4Bx/S2/TK7znXyo7DR0RCAI68uYQSVh/xhwU5
         d/KJ3JBd7f1PAldQseSF5OInaZKELctPWj42UEzutHX0TpbnksI2Aa8a5LbxblSuXTdK
         3M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751044796; x=1751649596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJvljz9Tnw+ULEBiMWy1DRf4iuiUFI2ZolKXoPlMGY8=;
        b=WMczUuky+Tz/a4geI1EvBjJ7rMru0AznLdv3quVCSs98bSjVUbKOsnSClb0OyuDRA1
         whxXXvZfIPCL79JFo5dpj1R6AXhBd5GXHurIYjkAI4I3s7dulTMU93FEXrp0IFRjZfmC
         GQrVpAwXh6pvNILY2Ij9mqT6I6HKwzZQ6Q9/zw9FsA2lGd1uvlrvApwY+Ro6UoO1uQJo
         2j08eIzW8DUakXguOrGk3VXTWH62fyHOf0zWgj63/knOaap3YhQ0Q/s+Kq3OWdawLz0i
         t94qc2x0ir8CzXrkZhjXwVVwSfsYmMrvWgk63Aj2iMFcOyjVFFHKYOROR+TB4KPpUDsq
         Dg5A==
X-Forwarded-Encrypted: i=1; AJvYcCVnu1SSPA/hJckZ0vf0BHdw7Kn1SukrUsIpJRbVV/kmbzMJOCbovzArDDPSHZTGV99deA8K92VYBsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRSZK7mwX4CACeNbb8miXg2RC/O+n9W9vwkve1CysJmKRXWa7h
	7URsBm7JaAnx4qD99h6QNcM0Lse5wWeGSmUfgrdqM3Qgb3JXXdTJwXjJ0+uiCQmmEG0=
X-Gm-Gg: ASbGncs1n/A+AiCKi2kpVuRkdFuYI2CfE6jscjlV5WYgvz0HmyxlJSLChY572Swjd6D
	kTj6sAehF/c2BzFYHG6XFr4UQV3Op1vcclyTl2AUlmaLv6+6dK9CQmJTQDVabiG3FZXVKfC6jJf
	KhIRBbqVBaTvUCWSrK5Y1ypOkn2Oa7Gohzgow5ObsAiLW1ijV/Y0YixbuoijH48Dvo7Txe4ENlk
	5fZEzSL9VCEVdY/CT/eydFceyiqMmjrsM5BR1NbTh+hkYgdGcBTDHf5kHz4aIIfzJ/9bc5BXvms
	o67YO/MWOTmSSkyjdZHA8hQz+OxUPoQLaGjwu0JhBexDDGCQpdCxLb/RIod+5O1GwDmR9bdZt+n
	AxwnYnzmBQjvF8bcv8o4515c2YmcR2G2xgIO+
X-Google-Smtp-Source: AGHT+IEG9uoHCw9dQX9tnWLEPlVN6igI5NvBDX4j1okMsWLkf0rxcatw94D+p/TGVWL+XFpFr/Vvjg==
X-Received: by 2002:a05:6870:65a2:b0:2d5:336f:1b5c with SMTP id 586e51a60fabf-2efed7782ecmr2779602fac.34.1751044796466;
        Fri, 27 Jun 2025 10:19:56 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1715:453e:e133:7d6? ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50f7d89sm972808fac.34.2025.06.27.10.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 10:19:56 -0700 (PDT)
Message-ID: <6152da6f-84a1-40e0-9fe8-248a2835de6e@baylibre.com>
Date: Fri, 27 Jun 2025 12:19:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] iio: imu: inv_icm42600: move structure DMA buffers
 at the end
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250623-losd-3-inv-icm42600-add-wom-support-v5-0-4b3b33e028fe@tdk.com>
 <20250623-losd-3-inv-icm42600-add-wom-support-v5-1-4b3b33e028fe@tdk.com>
 <CAMknhBEpkWrZdWSrhQS6E1GnENCipf+LxNNSNUyZrm8Gme2f_Q@mail.gmail.com>
 <FR3P281MB175703F651131703019D7295CE78A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <20250626194838.55c5eca4@jic23-huawei>
 <FR3P281MB175744F24BDD93870BB32ED0CE45A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <FR3P281MB175744F24BDD93870BB32ED0CE45A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 10:27 AM, Jean-Baptiste Maneyrol wrote:

...

>>>>> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
>>>>> index 55ed1ddaa8cb5dd410d17db3866fa0f22f18e9d2..9b2cce172670c5513f18d5979a5ff563e9af4cb3 100644
>>>>> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
>>>>> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
>>>>> @@ -148,9 +148,9 @@ struct inv_icm42600_suspended {
>>>>>   *  @suspended:                suspended sensors configuration.
>>>>>   *  @indio_gyro:       gyroscope IIO device.
>>>>>   *  @indio_accel:      accelerometer IIO device.
>>>>> - *  @buffer:           data transfer buffer aligned for DMA.
>>>>> - *  @fifo:             FIFO management structure.
>>>>>   *  @timestamp:                interrupt timestamps.
>>>>> + *  @fifo:             FIFO management structure.
>>>>> + *  @buffer:           data transfer buffer aligned for DMA.
>>>>>   */
>>>>>  struct inv_icm42600_state {
>>>>>         struct mutex lock;
>>>>> @@ -164,12 +164,12 @@ struct inv_icm42600_state {
>>>>>         struct inv_icm42600_suspended suspended;
>>>>>         struct iio_dev *indio_gyro;
>>>>>         struct iio_dev *indio_accel;
>>>>> -       u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
>>>>> -       struct inv_icm42600_fifo fifo;
>>>>>         struct {
>>>>>                 s64 gyro;
>>>>>                 s64 accel;
>>>>>         } timestamp;
>>>>> +       struct inv_icm42600_fifo fifo;  
>>>>
>>>> I didn't look at how the drivers use timestamp and fifo, but if they
>>>> are passed as a buffer to SPI, then they need to stay in the DMA
>>>> aligned area of the struct.  
>>>
>>> struct inv_icm42600_fifo has a buffer at its end that is passed to SPI.
>>> Same things for buffer below. That's why both buffers are DMA
>>> aligned.
>>
>> It's a tiny bit esoteric that this is relying on structure alignment rules
>> that says (iirc) the structure element will be aligned to maximum of it's
>> elements and there is tail padding to that size as well.  Thus the whole
>> struct inv_icm42600 is __aligned(IIO_DMA_MINALIGN) and the buffer in there
>> is itself after padding to ensure that it is __aligned(IIO_DMA_MINALIGN)
>>
>>
>> Anyhow, all I think this actually does is avoid one lot of padding
>> (as well as making it slightly easier to reason about!)
>>
>> outer struct {
>> stuff
>> padding to align #1
>> fifo {
>> 	stuff
>> 	padding to align
>> 	buffer
>> 	padding to fill up align
>> }
>> struct timestamp;
>> ///this bit will go away as it can fit in the padding #1 (probably)
>> Padding to align
>> ////
>> u8 buffer[2] __ailgned(IIO_DMA_MINALIGN)
>>
>>
> 
> Hello David and Jonathan,
> 
> what should I changed for this patch? Rewrite the commit message?
> 

I had to go digging through the source code to understand any of this, but
now I finally do.

What would have made this clear to me in the commit message would be to say
that:

1. The timestamp <anonymous> struct is not used with DMA so it doesn't
   belong after __aligned(IIO_DMA_MINALIGN).
2. struct inv_icm42600_fifo contains it's own __aligned(IIO_DMA_MINALIGN)
   within it so it should not be after __ailgned(IIO_DMA_MINALIGN) in
   the outer struct either.
3. Normally 1 would have been considered a bug, but because of the extra
   alignment from 2, it actually was OK, but we shouldn't be relying on
   such quirks.



