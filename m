Return-Path: <linux-iio+bounces-17397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63901A75ED9
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 08:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C991167999
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2233B158DAC;
	Mon, 31 Mar 2025 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKzYlxg3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D52C190;
	Mon, 31 Mar 2025 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743402800; cv=none; b=NBm6rvpxM/dlU94FD8rmrnnbTqvsXxh7s1iXckG+RbT80fiOdkQpXtGlWXeoSNbh3urlbqdbfzqOTioS/oJDSnizIUJFy3VevKVqwVbcdps1zRTKh/VAZQiQqf5O5Skxgs6LfmZUMAvXQ/pFVkZ6UHtMOoeAyoZ4I06gK3cDAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743402800; c=relaxed/simple;
	bh=4NnAUAHh4SQBN5bZMa3zy/EsBd3xBQ3NCNjqNDn22Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXoOpHHEDlpxYdZpeiqM4R9hxburzOYHQPBsvNFYCLMw9raQTLSNHfgTL3Apmq+dRZ0tJLB/kKXmdcUm6FtzjaRp027CQaZ1YfPFBT4m1G6AulNT9jAs/5gJXL9vkRRBsVdeVQbaVg0kN/6uiyzJ+TKEvqT7armai+knpS0PbL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKzYlxg3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so3100541e87.1;
        Sun, 30 Mar 2025 23:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743402797; x=1744007597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3BN4S9BGk3MzK6oLk/K+BbptIILiBKGzFpM2o4Ops8=;
        b=dKzYlxg3GUjHA1LnagX3/XkZqJc3fhg0jINN26VG+BGqyj9dya4lCXuQfqgF3xlYg6
         O5yUmkuCawI0iZ+yxDqoFziUYfyooYKGV2XcOHiiPQ5jBF4QxJYqS2F9/Ab5gEOTlnhp
         TcbiiERgt0OemRzmMHIWMuwWb3qEUaE05m1CHRWwmA4Q9HBZlE3jljapHpGxC0rCGPOi
         Z0J6d2N01h0juTnDp5PRxGqV5BvlOiavsinLWaIhYdXf6yrLZ/XXAsWS2enlF4sKXN+2
         YlCbCfbRJu/DCKSMe6H3cxIhEY14k0LUbSCZgqwEoiQc/yy7evsLwucNSpZ+aeO28+x6
         8Zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743402797; x=1744007597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3BN4S9BGk3MzK6oLk/K+BbptIILiBKGzFpM2o4Ops8=;
        b=FS3lAX2+etPf+CPUdE5fYgy4QFRVIAfSwz9wIhfX46dq+ciX3Gpp3MEQfzZRe++ohv
         Km16furvbBitr6RA1nF3yEOEysrMFjlzzf7mw9qCS+a+m0tSRBO9RhQpZ9IkGn9VGix0
         OK4aNGDeWSFNr4qMSfJ34zhjUiUlvag/BmbjhLckn+ga3145WpXQ3PIIC/6PJGL9wRCc
         QKhCb4ZsixO3usoYF7KCk5tabW72qjSO2T3I3b90ForBiGK53uOztgVwZjQHK0OXAsoR
         Fm+x0OIhZgn3i8IZFyfnA48ykc6GVSkkM0yZbKqVPpOJwIc/RocFsOO3TzyM2j3M152I
         dZxg==
X-Forwarded-Encrypted: i=1; AJvYcCV3HQyTiOxzjhYsOLGImH/yryqLAlWDM0fLHXqkhLgOn3DEk18gSdC+0tLth4zsn3XU93lrwUgtkhE=@vger.kernel.org, AJvYcCXOhoXBSk8Nor0w7KZ3Le/GPmXe+gSaTzcatZkw9TgYjPdib4KH1Y2yHk62fTKk5ID7ZyamtmS+mrcN6dkM@vger.kernel.org
X-Gm-Message-State: AOJu0YxmxVu8/KX95ewgmq3rY1DN9gJXbUcxOJ9cAnnA/nj3l1oOPicJ
	db6ex/BJVzYJ5AY2AmqMmLFtmvg2CUlstNTFjTr2AdWlUT6tJeGw
X-Gm-Gg: ASbGncuxYhjrfUDYNb0yO6H0Ok1Y5YVZsEgyqVNYQj8LYw/cNxcuxTJOuECmZcNNNVW
	zZqS1BdCO0a656gLUPRiTtYYzNMDDc0Gn1eqyK2U4uumYMMOScXCan0EeItULUxPCxYLTDOefXj
	qS0R/qtWTMI+DHReB7547xhlZcTQTHUIDML9ew9X2HJiC6QPqdNWLBa7FTOIWtG0lChF9Al/x+G
	3hRLGeVg7V0rpNXh2OqA4COt1K7P192o6tu0tSiJ0SGiBcPN6mlcHrKtIXRWbpAIMPz7iejXeXe
	ZEhtRFPIf2JXLg1NhzQQdsvxzakp31Ip660nrk7itmhcG+5SK3i9UfliDUJwcYYKleGu/OyGJyr
	7bVKCOIlHaZqsQUEHMbqvcfG59qsrOuRx6ViT
X-Google-Smtp-Source: AGHT+IEw0QVUl1K06muVSHUKs6EbBPkwd75jQZnDGb13MH0A+Eq1NYGcsvurFL26aqQVF+isbh9lZg==
X-Received: by 2002:a05:6512:398a:b0:545:d27:e367 with SMTP id 2adb3069b0e04-54b1110e012mr2176119e87.42.1743402796928;
        Sun, 30 Mar 2025 23:33:16 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b094bb3c3sm1068357e87.2.2025.03.30.23.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 23:33:16 -0700 (PDT)
Message-ID: <591e09b5-f446-497d-ba3b-c235dba87e6a@gmail.com>
Date: Mon, 31 Mar 2025 09:33:14 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/8] iio: adc: Support ROHM BD79124 ADC
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1742560649.git.mazziesaccount@gmail.com>
 <ca3886c9abcb268ca976e62cd7da28bf5d6e6382.1742560649.git.mazziesaccount@gmail.com>
 <Z-EWmK2r6VgmPAqa@smile.fi.intel.com> <20250330173511.16ea9ebc@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250330173511.16ea9ebc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/03/2025 19:35, Jonathan Cameron wrote:
> On Mon, 24 Mar 2025 10:23:52 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> On Mon, Mar 24, 2025 at 09:13:42AM +0200, Matti Vaittinen wrote:
>>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
>>> an automatic measurement mode, with an alarm interrupt for out-of-window
>>> measurements. The window is configurable for each channel.
>>>
>>> The I2C protocol for manual start of the measurement and data reading is
>>> somewhat peculiar. It requires the master to do clock stretching after
>>> sending the I2C slave-address until the slave has captured the data.
>>> Needless to say this is not well suopported by the I2C controllers.
>>>
>>> Thus do not support the BD79124's manual measurement mode but implement
>>> the measurements using automatic measurement mode, relying on the
>>> BD79124's ability of storing latest measurements into register.
>>>
>>> Support also configuring the threshold events for detecting the
>>> out-of-window events.
>>>
>>> The BD79124 keeps asserting IRQ for as long as the measured voltage is
>>> out of the configured window. Thus, prevent the user-space from choking
>>> on the events and mask the received event for a fixed duration (1 second)
>>> when an event is handled.
>>>
>>> The ADC input pins can be also configured as general purpose outputs.
>>> Make those pins which don't have corresponding ADC channel node in the
>>> device-tree controllable as GPO.
>>
>> Thank you for the nicely written driver!
>> However, I have one big issue with it (see below).
>>
>> ...
>>
>>> +static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int value)
>>> +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>>> +				    unsigned long *bits)
>>
>> These will be _rv variants anyway as there is no chance this series goes before that.
> 
> I don't mind seeing this as a follow up series, but I would like that
> to hit this cycle if possible.

Should be possible :) I think the use of _rv will nicely tidy-up the 
set_multiple. I'll cook a patch when rc1 is out - or when IIO has the 
_rv variants in a branch where I can base the changes.

Yours,
	-- Matti

