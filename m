Return-Path: <linux-iio+bounces-14826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE04A249FA
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A693A291A
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F81C3BEB;
	Sat,  1 Feb 2025 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXQB4MMP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC84D10E0;
	Sat,  1 Feb 2025 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738424308; cv=none; b=Mrr9uhXKjC0QRJuI1sPpr/RypEOp1F/mK6Ui83V0WlY6zSDL+8yFfPtYpKNAOiLcvrHQ5cTsg9mysjhJ2Q5EBNooVuA6IghpRNNr6WoXLS0WpxukH8wXqwIr7dIlZCNKcgdvaqqp28g0unsNmx5PNyeacPS7LNHLEsGUvYHlEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738424308; c=relaxed/simple;
	bh=6+YqugB3vmMM7dXGp3kW50YfVzv5C2TudQME5klJel0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4PRxUoi5Xyak1dlzJlao2XpdtdhfJ6SCC4lqp9pzR7N2WJDwqMx3xWO8SPf3oKSuMoYSYT3viC9k+fxlKoqjIM2MmzIFIl2jCHP/0k8ElgwxeATyz28OWsf8B3dOoX3MlfmZi6jY2ZNrF/BbD6CBEuHkJcmLrrglPEdsW0jsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXQB4MMP; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53f22fd6887so3071306e87.2;
        Sat, 01 Feb 2025 07:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738424305; x=1739029105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hl1qmmUm0lswNBXxrSaCqGMbG3k3q1JNiizWUxh5hII=;
        b=BXQB4MMPNlz9YBCMB72SszYcJmMaNFh2U1NLfJi6gj2OwBvabr+XMdN2tFS2DRi1tX
         MrsdCQ7hTjtcTMWiqgavr7a70pyCiSGEHfeGnj3axUhug4Soi2JjhHGZu2h6+DkCt1ru
         IjA/QgOZkLWnOgTPuZOCZKVvPpLJAapUzFj/Qrw5JW3/MdEbQwH+kefQMFLuJvUxKzeE
         rCeyGkvRIn8n0Us2rZeDbg1N2r281R7OLTVkoy9LcZ4QMwHu4df/lfGcAyMrWCyMKqML
         G7H7MxxS5GSvHga4EdM//VehCGQsAQzwXA32YLEaPcplrU9NkMx3e35NNR0wpPlSNvJe
         Kf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738424305; x=1739029105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl1qmmUm0lswNBXxrSaCqGMbG3k3q1JNiizWUxh5hII=;
        b=brfvfnsjmLtYHaz/+jPgL6wLZF/+MptnN5RnJPNtP+A2WZDTd4EuCzGizP/ilZWUpD
         NGp0n5NTgHGislq7wT3tqrGK2ADL3fuD8pGlc76n/e5Znx1UUF+iTro7BnjwFZ6weDOw
         dWJoLmoB3O1cvZISSKZDVShqsFP5BdPLAsBIYSYNZ7ebo+3oHpFwXOb1f9y4BvLulebx
         8+9eMTVNSq4/c9cYjAFED5eHr3IT3HWF6X3P5EEzSG5Jaq6xnl7W4eDzbYk2bX4q0+NQ
         99TRR3LPLMtzt5HUZr27mv7R/zqxLrdvvrjEfXt0Zt0VorAoR/XVqutmqkCEjwlGvn5t
         qrcg==
X-Forwarded-Encrypted: i=1; AJvYcCUIdwDQG6XsQpltT0cdJ/P8Nletro71fAS0h4shPKICcEpqDAznfQOdMES3bDoDSm2eNr8BabcKpfTKHzda@vger.kernel.org, AJvYcCUZHCIyhi/Axt/UCSxX3yxQglD/a7kIJ4wQTyUSVJs/cVrNU3bb1D4vZZmfs05Nug0esyLhTBhuoY6j@vger.kernel.org, AJvYcCVV0/M2ReBw0IsRGe4pfXYW7U4WvtutAl9D6bEyQU8g3znLEvVh7w/aYwlrHlQB1aHjurR1z8JsFEdp@vger.kernel.org, AJvYcCX8xlt7+WnZyAyD2LclSMhRDSntHqtAFfRioYeKm1Or2v7L0SmxY/op63p52EtLKJW7VTRiFe6By9Qanw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL+zYKoXK+HHqGzYndbTV4eC6cHoKZIwShh+chmeeUstuRDuRx
	EPiWPZQXstzEM+Xj+qtfk2pF0i8lPmc7Hi88JWfSTDdzbo10cgpn0jiJHA==
X-Gm-Gg: ASbGnctxuDNZVQwi7IzsHMo0JaSGIDUIIwVUCwRPQ6WxRbtCkrbnt7KFOIh1bMdazaY
	akfVHooTRid9FhlMTL6rSYAKw3lb1FLMkKZjNs0Zz1bWFErs1fCSg1Nph2R0Dlznti95QUrpiIh
	pJFBOvlHCViRduLqd/DjM2Tj9VOUSwxo4lNsFyt7npaRszZ5M80Gf/OAveSt5aaojKEsI8NSLLs
	wyReeXn4Hf65RKbnM8WYZ6kO0XzPNo5TUyao6U7EtGlUrGvYPeHqkRxx31rUQz0eSY2j/mZwHG+
	BHJ/OILlZuqa4ww82aFZsWNlK7atW78Nqplkg7yl3KzIIoKwGu8bLrEr
X-Google-Smtp-Source: AGHT+IFBW4Zgtlrqa9nazIfabbiNg+jyRCtT+yNUD0PlCskZ3/ni1PajHRQnr85exXraq9rQrLiPqA==
X-Received: by 2002:a05:6512:3b07:b0:540:1fd6:4e4f with SMTP id 2adb3069b0e04-543e4beb22dmr4630101e87.22.1738424304452;
        Sat, 01 Feb 2025 07:38:24 -0800 (PST)
Received: from [192.168.1.110] (85-23-190-22.bb.dnainternet.fi. [85.23.190.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebe219c4sm777293e87.105.2025.02.01.07.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 07:38:22 -0800 (PST)
Message-ID: <566f15dc-8901-4377-8407-8eac8a54bfe4@gmail.com>
Date: Sat, 1 Feb 2025 17:38:20 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] iio: adc: Support ROHM BD79124 ADC
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Linus Walleij <linus.walleij@linaro.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
References: <cover.1738328714.git.mazziesaccount@gmail.com>
 <e44851669ce7e91d1295ab7352535c93b89d35bf.1738328714.git.mazziesaccount@gmail.com>
 <20250131174118.0000209a@huawei.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250131174118.0000209a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2025 19:41, Jonathan Cameron wrote:
> On Fri, 31 Jan 2025 15:37:48 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
>> an automatic measurement mode, with an alarm interrupt for out-of-window
>> measurements. The window is configurable for each channel.
>>
>> The I2C protocol for manual start of the measurement and data reading is
>> somewhat peculiar. It requires the master to do clock stretching after
>> sending the I2C slave-address until the slave has captured the data.
>> Needless to say this is not well suopported by the I2C controllers.
> 
>  From what I recall that is in the I2C spec, so in theory should be supported.
> Ah well.

Could be I am mistaken then. Or, maybe I just misused the term "master 
to do clock stretching".

I know that it is not rare the slave device is keeping the clock down 
for extended period (in this case so that the measurement would be 
completed) - but at least I am not aware of any APIs which could be used 
to cause the _master_ side to keep the SCL low for an extended period 
after receiving the ACK (after sending the slave address). In this case 
it would require this driver to be able to set a time for how long the 
master would keep SCL low after sensing the slave address, before 
sending the "command" bytes.

|S|ADDRESS+R|a|STRETCH|8-bit-i2c-frame|A|8-bit-i2c-frame|A|STRETCH|8-bit-i2c...

Above denotes this "master stretching". CAPITALs are initiated by 
master, lowercase by slave. S, is start, a is ack and R is read-bit.

If there is a standard way to implement this in Linux side, then I might 
consider using it as it'd allowed much higher capture rates.

>> It is worth noting that the ADC input pins can be also configured as
>> general purpose outputs. The pin mode should be configured using pincmux
>> driver.
> 
> We shouldn't be presenting channels that are configure for GPIOs as
> ADC channels.  It is very rare that there is a usecase for any
> dynamic switching.

Thanks :) If the dynamic switching is rare, then you're definitely 
right. I need to see if using the pinmux still makes sense, and if we 
can implement this while using (separate) pinmux driver.

> Normally it's a case of what is wired and
> so static.

I should implement a device which can be controlled via it's analog 
output line :) If nothing else then a device shutting down when it's 
output is pulled low ;)

...Well, I have no real use-case for dynamic config either.

>  Hence build the iio_chan_spec array for just the
> channels you want, not the the lot.  Channel sub nodes in the
> DT are how we most commonly specify what is wired.

Hmm. That'd mean the ADC channels _must_ be defined in DT in order to be 
usable(?) Well, if this is the usual way, then it should be well known 
by users. Thanks.

...

>> +		if (BIT(i) & i_lo) {
>> +			ecode = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
>> +					IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING);
>> +
>> +			iio_push_event(idev, ecode, d->timestamp);
> The same interrupt thing doesn't apply to falling? That's odd.
> 

It does. So, not odd, just a regular bug :) Thanks!

>> +		}
>> +	}
>> +

...

>> +
>> +	irq = platform_get_irq_byname_optional(pdev, "thresh-alert");
> 
> Is there more than one?  If not why do we need to do it by name?

I kind of like doing it by name when the IRQs come from a MFD device - 
which can name them. It is no real extra cost (well, maybe bytes of the 
added string in kernel, but I guess it's not relevant with only few 
interrupts) - but it makes it very hard to get it wrong, and it 
documents the purpose of the IRQ.

>> +	if (irq < 0) {
>> +		if (irq == -EPROBE_DEFER)
>> +			return irq;

...

I do thank you for, and agree with, all the rest of the comments!

Yours,
	-- Matti

