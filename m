Return-Path: <linux-iio+bounces-16679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A70BEA5979C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 15:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FF33AAC40
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B445322A4FD;
	Mon, 10 Mar 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zjZDxRjw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37419D8A0
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617110; cv=none; b=J4RZWgP5oEh9v1G6DluyahS6bB/n5aUSVR8r0zD6cJEBTTwwjNu7b4PFWQMXU3cIdv2bwnfrzgZtdGsPonp9/NV/1OVukAvT0h1Fpp1PIXBhT2L49aNMhXIzcTvicBpNHGGg+OMj19a/GR7NmkkPUO8ItRgeuq7aZ7GlHYE84cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617110; c=relaxed/simple;
	bh=Ps//DGpFqXWp3GsLNV4yd8lxmyS5d53siUwV+54hi8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVuwoNbMJKr9LtH1A6exuzVU7R3xMxOMqXQrVKKAoCyXF/UgI9YRFGchSRvNmlRnEXMWJ3E38/jddF/VF9PClPH0pw+y/wXa0Xpr9M+3bC16OyVr+Qz2+iH2Xeuj1ONxFBF0jS8z0vvmLDbCS/J/nOhHUsGiBtdR6HB9che2dqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zjZDxRjw; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72a4793d4e2so1285840a34.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741617107; x=1742221907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QnKDL7IGSLQdY1Ps1imHuBBiZbH4iwSQV6FmwECIlQg=;
        b=zjZDxRjwQKuwZjY/0xjdZUUGpRd3s6FJgyUWIGiXdAV+d9gW/VmDFDdghG5sEG4a8t
         0WePsyHb+4ZDP0MruABVypM8kWu2hB4E+1mWIaOeDuv+2fTBIqd7UhXZvr1NpU8hGP0Q
         nCmbC9AU+LButRlxHyVJX9ucMPz61jUM+GEp0UDOiQYAjda/HLL+FYE1uP0fmByXBI/V
         MT3cD4ZqQiBEhtyqf7Q3PFyZhYPR0AREZ3E60GsqMRcIt59hxBRwBj/92oeVm+FgwmHc
         9B2Eu6bIGZkQu6Vbq2VdIfL4+6WrWlVlQok0fiermsFzXcmFDpqt+Wot0cXgWSC1Ebbh
         oDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617107; x=1742221907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QnKDL7IGSLQdY1Ps1imHuBBiZbH4iwSQV6FmwECIlQg=;
        b=hWsJV6GcJWptQ2gShUBRBzingBrXMBc5trkUUpj9MCJzoDup7wlZ4jY4OVj15b7DTo
         scqJHfIhHNwSr1vbSxs4RqPYTQlCtLyrvHQJTz2kEDukIrlHgkwZi5glmDXyEIJK+TM3
         psMCNEp/v1uXDiNHjsvBN29Pr8fPMHk6TUMcaK+7ebFJNalc64dyKHI+CbSl5FDwZpi5
         PSnuICm8aRftQe9m0A5B5MlsbVI3tM/62I3n4JrsedJWZwScsmDFC9TfB1XJRg8XYT1H
         ujeOqu2Ctu3TYUrzB34Pg9qDcz0h73VCfkE0gUp9OpL/O/+SEr6MhwhygWxWJId5OykF
         DOzA==
X-Forwarded-Encrypted: i=1; AJvYcCULgkWMkWhSspiuNYfN+Ssc3mwgnVkOllPBU8OfZCQrFfqO2I0NkjmzluwuLw+AC8wb+fpIWzrbqPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCyglHpz5x3qqkHaHW6obHnhuba4Zm4uignryvW55v/suZ1BF7
	YLpZu+rjVExPyXGmB9vPYAgBq5evPf65GNRX3EWR0r4H3ssS6AB0+mxYeSnNQAM=
X-Gm-Gg: ASbGnctNTs8l5QWlwJ4V0YNdXpw9TQ8Tif35bvEtNfi59zyhWkauutp6mCJgUkGMB5s
	fZjkW8RavqsMi9WhCzO+DjiEMFaPWWap3oor4Mxf6On1Q8u49n+I7wGXj2cWvY3qLSSOWXrcICv
	JOayj/bcWO1YpEr/pFokN2rapCZo/eiGFAeXvyCH58xpB9oTR9NKXI6M18y/9IQGTu7wGb2l3Pj
	jS5zEnF0FJ0tQBzi8DPOrGBHc76E9l1jRxidHluq/iunbkQUt/CeC4n8SUMShST3Te+utKg8yc7
	2tiQbg8f5wDWwb+WB8yqmh3Kqzir9nEYVRUsR4dKpxBjqrICr1dOx+V4rUkLsCnQrJg5GJ9ZIrT
	3UpVhzA==
X-Google-Smtp-Source: AGHT+IFc5FQqx7D/Eko7oVMCmMY7qbffM3dUKH8YN9GD9Mq5nGldBPuykkjjjWS+hnzU6NmCsbTHdw==
X-Received: by 2002:a05:6830:6e05:b0:72b:81a8:dea5 with SMTP id 46e09a7af769-72b81a8e17bmr2820014a34.17.1741617107592;
        Mon, 10 Mar 2025 07:31:47 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72b7a3a2385sm1014002a34.57.2025.03.10.07.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 07:31:47 -0700 (PDT)
Message-ID: <6ca1eafd-276d-421b-8d35-bd3e363803d1@baylibre.com>
Date: Mon, 10 Mar 2025 09:31:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] docs: iio: new docs for ad4052 driver
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
 <20250306-iio-driver-ad4052-v1-3-2badad30116c@analog.com>
 <CAMknhBFiZZUtCkTjQ=AVSgwqe=wCkMnqAmaTqvW_X6fm1OKuYA@mail.gmail.com>
 <e3p2r2fet2spkrxv7x76gunlivrp3vng22wktz4fkww5nkckt7@jpgne4uerr3c>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <e3p2r2fet2spkrxv7x76gunlivrp3vng22wktz4fkww5nkckt7@jpgne4uerr3c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 3:49 PM, Jorge Marques wrote:
>>> +.. list-table:: Driver attributes
>>> +   :header-rows: 1
>>> +
>>> +   * - Attribute
>>> +     - Description
>>> +   * - ``in_voltage0_raw``
>>> +     - Raw ADC voltage value
>>> +   * - ``in_voltage0_oversampling_ratio``
>>> +     - Enable the device's burst averaging mode to over sample using
>>> +       the internal sample rate.
>>> +   * - ``in_voltage0_oversampling_ratio_available``
>>> +     - List of available oversampling values. Value 0 disable the burst
>>> +       averaging mode.
>>> +   * - ``sample_rate``
>>> +     - Device internal sample rate used in the burst averaging mode.
>>> +   * - ``sample_rate_available``
>>> +     - List of available sample rates.
>>
>> Why not using the standard sampling_frequency[_available] attributes?
> Because sampling_frequency is the sampling frequency for the pwm trigger
> during buffer readings.
> sample_rate is the internal device clock used during monitor and burst
> averaging modes.

I haven't done a chips with a monitor mode yet where we aren't reading
the samples, so hopefully Jonathan will chime in here on the usual way
to handle that.

For the burst averaging mode, I understand the need for a separate attribute
now. I would suggest to call this the conversion_frequency rather than
sampling_rate since IIO already defines "sampling" to be the data read
from the chip to Linux even if it is an averaged value, it still counts
as one sample.

> 
>>> +
>>> +Threshold events
>>> +================
>>> +
>>> +The ADC supports a monitoring mode to raise threshold events.
>>> +The driver supports a single interrupt for both rising and falling
>>> +readings.
>>> +
>>> +During monitor mode, the device is busy since other transactions
>>> +require to put the device in configuration mode first.
>>
>> This isn't so clear to me. Is this saying that events do not work
>> while doing a buffered read? Do you need to do need to read the
>> in_voltage0_raw input to trigger an event?
>>
> No, the device monitor mode and trigger mode autonomously samples using the
> internal clock set with the sample rate property.
> I rephrased that to:
> 
>  The feature is enabled/disabled by setting ``thresh_either_en``.
>  During monitor mode, the device continuously operate in autonomous mode until
>  put back in configuration mode, due to this, the device returns busy until the
>  feature is disabled.

This is better, thanks.

> 
> The reasoning is that during configuration mode no ADC
> conversion is done, including if the previous mode was autonomous.
> If instead of return busy the driver hided this and resumed monitor mode
> after the access, a hidden (to the user) monitoring down-time would and
> thresholds crossings could be lost, undermining the feature.
> 
>>> +SPI offload support
>>> +===================
>>> +
>>> +To be able to achieve the maximum sample rate, the driver can be used with the
>>> +`AXI SPI Engine`_ to provide SPI offload support.
>>> +
>>> +.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad4052_ardz/index.html
>>
>> This diagram show a PWM connected to the CNV pin on the ADC, but I
>> didn't see a pwms property in the DT bindings to describe this.
>>
> It is not clear to me where the pwm property should be in the DT
> bindings, since the PWM node now belongs to the offload-capable SPI controller.

If the PWM output is connected to the CNV pin of the ADC, then the PWM
consumer property belongs in the ADC devicetree node.

If the PWM output is connected directly to the SPI offload trigger input
then then it should use the trigger-sources bindings in the SPI controller.

From the diagram in the link you gave, it seems clear to me that the
PWM is connected to the CNV pin on the ADC and GP1 is connected to the
SPI offload trigger input on the SPI controller.

So the ADC node gets pwms and #trigger-source-cells properties and the
SPI controller gets a trigger-sources property that is a phandle to the
ADC node.

> 
>> I didn't have time to read the full datasheet or look at the driver
>> code yet, but can do that next week.
> Ok, thank you for the review
> 
> Jorge


