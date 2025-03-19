Return-Path: <linux-iio+bounces-17109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D049DA695A4
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 17:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EC6188D4D0
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 16:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4651E7C3F;
	Wed, 19 Mar 2025 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoqV266z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AB1E5B6E;
	Wed, 19 Mar 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403567; cv=none; b=MS1tDrBeqG/1zCCPK7MPbwUt2n3EY/BmRPar1UF/neMcYgBqN+yGDFqsmUz3EkIHeo/HYj+R20OCmX1vS05TmfcenMnGxyHkkHfnwUrJhCOUf/DOVTunu4HySuiK8L2WsQzWiIpyit93DB27Eif+1ydkFF3MNQjrMGWhxn7G1DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403567; c=relaxed/simple;
	bh=QKmIRilHU60ov9N6EEa6cmlu5Xga9Vf12qAWMCmpesE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZVQpMXl4ONlkUFOyfm31H8O8yqWLRDSHI32+AJPjGpUV3El4bnOtUSz2VMPI4GNaqdJYlCubnDiir0yWDLMzbRWx2IsO+7FjL0L17ncGvv+rpZIA1SJ3hSJFEDK/MQQkxlI0FVvSANEKEprUBq7Fhw2fIQziCsXPDndzADJTYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoqV266z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso51504775e9.1;
        Wed, 19 Mar 2025 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742403563; x=1743008363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nC3dL9SkBQeRU2Gx1sHTLVo9d/ZsLBQE4BpxWA3gbaU=;
        b=YoqV266zyQcCgBT0uNDiKUF1BIhHK2Rm8Q0A+c7LzfjCRZ7E5bmYDtrgW5T+DALkcQ
         +9ukx9KaMBYEWxjR7AfKqoam1QiFEdBkaVM2A75K0mmfPdjo3cpA2NY9Dj1PRPwIcVyR
         X/t3YPLca+tAB+zMOi9pQ0hJ75huBLMbLagh2qy7Z5Rm+HQnBsGtpQIoa8FKCoh6RxTi
         j22ZIR15LhmD2wdLnODOGeW3ND/o0H63Bx+4GLwPljkpUE4rM+48pdbJS8KtFtQP4wll
         UiD2TaaGLtp0kX51YHQayMX/8qVVOtF1rr6aXh2SuamPa60ZAuy21ylnCePx3uZHqUYi
         p1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403563; x=1743008363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nC3dL9SkBQeRU2Gx1sHTLVo9d/ZsLBQE4BpxWA3gbaU=;
        b=g0p6fJvY+9QRMldeLPWO+GJ+tmP+CTecTJg8OLqtzoTfvszXVXznDIVqIS5EkSIvIU
         VOAvqfUqB4biJeKN7HQGbJB7dh7DYKBZw57JrAvjQJrnx4Cw6NC9ZGICWn0ZelPoQHk6
         R8+pb5zbHyWHKTgGfufiLkLsokazOu/lZgq8f5T/iNtS0uYQoXh0BpfLPNCqq2QbLxXE
         geBudlEoHtPojghEWEcztYQJEt5q5jKKZixSQzMWu0Yqkb0CVOlF2Fd7hU4juYw7t0q7
         L6SIH4Q0dGBkEvnMI7m5rTaLQLkcjbORCcaWEXCagY+aGHzE0v2c24rbvMbY26Yh0+db
         I8Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUt4fA+REQGf84k3/Bwg7+rlEiZPIHVyyeExWtqCyqfWhEXXu+Ns3hPeH9uf/ZfHZiwDFnGMuQ0cMf8@vger.kernel.org, AJvYcCWHmKX4y33WcSl1ZitISvW2e5rKhrUQ0UMzkBq8EzFvPF9s/FBe/U7MdHD9IV7IhSk4a02w/DFwiKoy@vger.kernel.org, AJvYcCXMAX8gAjUCVUckyBwPyYgbQnPzKHUuS2krL5b4qBSj/EU3fZqH9il7P4K1DfhNbyJVbyHTpAUJMtv/@vger.kernel.org, AJvYcCXP0WDo/35z8aZk/u3SyLkmqBynjjZeWEPlP739EJ2KsKRM3dMrbLGoKhybV3DTwn4vPCrQKFPucpjkCklb@vger.kernel.org
X-Gm-Message-State: AOJu0YweUa0a4B24dvUgwNS4l68pScYZmz6zRhC/ccmdrT/7SRDa1eZ5
	aG2Sh9eAiE+BpOiftHXdntDUB4kj9ZDdsOIiXEAoP3S+foDYUzzmutxwKjXMKYdOuA==
X-Gm-Gg: ASbGncv7usBN3i+FoFGJcDRMNmGlot1JVmU2+0sHM+2KxOlTTkps0Opta+LKSq5487A
	UciHXPP8sJ0zKPdumx7e8s7GV8uDInD9xn53ZlMeIsHmfGdeWTQkB5be/HXNEAoqruHXEk2bp5r
	wd/P+7klhJctt6FsrYMWWfDXcNS0B4TiI168eA85UFp3qVqGcTJ/kscC7tfxnKrLmvzdMeA74Pf
	L6fFcELKYR4w+wAaD/Ig0wJfErLJOmV7grzKa7krzrAdLLIYg9TE53OMvrmav7CXJOKRgY+Hrvm
	46QPuwgTJUPYdsvDVJjcoZokdEyNzZ1fFc+LKYvT9kjKyGTgxhBgPxRigEpu173DHg==
X-Google-Smtp-Source: AGHT+IEZ/kUcnH1EyGgg8d1Rq3AK+KO65DxA23UU7pL/5xhziSQclVpXH0h/mFIW3GkWn8i289ly4Q==
X-Received: by 2002:a05:600c:384d:b0:43c:fdbe:439b with SMTP id 5b1f17b1804b1-43d4378158fmr38728865e9.4.1742403562890;
        Wed, 19 Mar 2025 09:59:22 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f47ba7sm23612295e9.16.2025.03.19.09.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:59:22 -0700 (PDT)
Date: Wed, 19 Mar 2025 17:59:19 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: iio: new docs for ad4052 driver
Message-ID: <yfw2zhdymhta57xr6x6dphqggtlpgbs35yzudwlxghbdi4hlnj@spicau723uai>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
 <20250306-iio-driver-ad4052-v1-3-2badad30116c@analog.com>
 <CAMknhBFiZZUtCkTjQ=AVSgwqe=wCkMnqAmaTqvW_X6fm1OKuYA@mail.gmail.com>
 <e3p2r2fet2spkrxv7x76gunlivrp3vng22wktz4fkww5nkckt7@jpgne4uerr3c>
 <20250310195416.6d8c64f2@jic23-huawei>
 <c62l6jv5vgsxnbipw7jar6tikjavwybdxaurz7hkdowbamc7ic@ak2rva3ujmaa>
 <05b83988-b7aa-453a-bef7-8e7eda77f53a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05b83988-b7aa-453a-bef7-8e7eda77f53a@baylibre.com>

On Fri, Mar 14, 2025 at 01:56:32PM -0500, David Lechner wrote:
> On 3/14/25 1:13 PM, Jorge Marques wrote:
> > On Mon, Mar 10, 2025 at 07:54:16PM +0000, Jonathan Cameron wrote:
> >> On Sun, 9 Mar 2025 21:49:24 +0100
> >> Jorge Marques <gastmaier@gmail.com> wrote:
> >>
> >>>>> +.. list-table:: Driver attributes
> >>>>> +   :header-rows: 1
> >>>>> +
> >>>>> +   * - Attribute
> >>>>> +     - Description
> >>>>> +   * - ``in_voltage0_raw``
> >>>>> +     - Raw ADC voltage value
> >>>>> +   * - ``in_voltage0_oversampling_ratio``
> >>>>> +     - Enable the device's burst averaging mode to over sample using
> >>>>> +       the internal sample rate.
> >>>>> +   * - ``in_voltage0_oversampling_ratio_available``
> >>>>> +     - List of available oversampling values. Value 0 disable the burst
> >>>>> +       averaging mode.
> >>>>> +   * - ``sample_rate``
> >>>>> +     - Device internal sample rate used in the burst averaging mode.
> >>>>> +   * - ``sample_rate_available``
> >>>>> +     - List of available sample rates.  
> >>>>
> >>>> Why not using the standard sampling_frequency[_available] attributes?  
> >>> Because sampling_frequency is the sampling frequency for the pwm trigger
> >>> during buffer readings.
> >>> sample_rate is the internal device clock used during monitor and burst
> >>> averaging modes.
> >>
> >> For an ABI that is very vague and the two use cases seem to be logically
> >> quite different.
> >>
> >> Seems that for each trigger we have an oversampling ratio controlled number
> >> of samples at this rate. It is unusual to be able to control oversampling
> >> rate separately from the trigger clock, hence the lack of ABI.  If
> >> we add something new for this it should something relating to oversampling.
> >> oversampling_frequency perhaps.
> >>
> >> For monitor mode, it is tied to the sampling frequency for most devices.
> >> But there are exceptions.  E.g. the max1363. Trick is to make it an event
> >> ABI property and hence under events/ rather than in the root directory.
> >>
> >> In this case you'll have to store two values and write the appropriate
> >> one into the register to suit a given operating mode.
> >>
> > 
> > If doing buffer captures with oversampling enabled, both sampling
> > frequencies have an impact:
> > 
> > e.g.,
> > oversampling: 4
> > sample_rate: 2MHz
> > PWM sampling frequency: 500KHz
> > 
> > PWM trigger out (CNV)   |       |       |       |       |
> > ADC conversion          ++++    ++++    ++++    ++++    ++++
> > ADC data ready  (GP)       *       *       *       *       *
> > 
> > For monitor mode, it will constantly be doing conversion to check for
> > threshold crossings, at the defined sample_rate.
> > 
> > I like the idea of having the device's sample_rate as
> > conversion_frequency.
> 
> In addition to what makes sense for this chip, we should also consider what
> makes sense other chips with similar features. For example, I am working on
> ad7606c which has control for the oversampling burst frequency (frequency of
> "+" in the diagram above). So it would make sense to have a standard attribute
> that would work for both chips.
> 
> On ad4052, just because we have a single register that controls two different
> functions doesn't mean we have to be limited to a single attribute that controls
> that register.
> 

I looked into the ad7606c driver and summarized below to organize our
ideas:

  PADDING OVERSAMPLING
  --------------------
  Delay between conversions:

  OS_CLOCK(Hz) = 1 / (1+OS_PAD/16)
  
  OS_CLOCK: internal clock, reg

  0x08 OVERSAMPLING
    OS_PAD[7:4]: Extends the internal oversampling period allowing
                 evenly spaced sampling between CONVST rising edges,
                 from 0 to 15
    OS_RATIO[3:0]: from off(1) to 256
    
  Therefore, OS_CLOCK range is therefore 1Hz .. 0.516Hz
  (1) from previous discussion, iio oversampling 1 equals off.

  EXTERNAL OVERSAMPLING CLOCK
  ---------------------------
  Use CONVST as the external trigger for
  each conversion

On AD4052 family:

  BURST AVERAGING MODE
  --------------------

  Delay between conversions

  Total latency:
  (AVG_WIN_LEN-1)/FS_BURST_AUTO + t_CONV

  0x23 AVG_CONFIG
    AVG_WIN_LEN[3:0]: Averaging ratio/number of samples
  0x27 TIMER_CONFIG
    FS_BURST_AUTO[7:4]: from 111Hz to 2 MHz, internal sample rate

  AVERAGING MODE
  --------------
  Use CONVST as the external trigger for
  each conversion

So, we can say that
PADDING OVERSAMPLING == BURST AVERAGING MODE, and
EXTERNAL OVERSAMPLING CLOCK == AVERAGING MODE

> So I would create the events/sampling_frequency{,_available} attributes like
> Jonathan suggested for controlling the sampling frequency in monitor mode and
> introduce new oversampling_burst_frequency{,_available} attributes for
> controlling the conversion frequency when oversampling. When an attribute is
> written, we can cache the requested value in the state struct instead of
> writing it directly to the register on the ADC if we want the attributes to be
> independent. Then only write the register when we enable monitor mode or when
> we start reading samples with oversampling enabled.
> 
> Sure, it is more work to implement it in the driver this way, but that shouldn't
> be an an excuse to do things in a way that isn't compatible with other ADCs.
> 

I am alright with that and will follow the suggestion of having the
values independent through cache.

So, two new attributes will be implemented:

* oversampling_[burst_]frequency{,_available} (new ABI required)
* events/sampling_frequency{,_available}

And I will drop conversion_frequency (early sample_rate) attribute.


