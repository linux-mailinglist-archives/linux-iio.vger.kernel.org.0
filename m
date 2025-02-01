Return-Path: <linux-iio+bounces-14818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94B0A249A0
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E3C165FDA
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474581BEF6F;
	Sat,  1 Feb 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOJ/i8Vd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02910E0;
	Sat,  1 Feb 2025 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738422060; cv=none; b=tGkDFTL3mQIcXtm0jolRnHiDjtw4zvnj9fFNyc3VOfZ7f/tjTYPWtt4SZg6VsRr9cDH3AlREQfnLiA2Wbc0hAeNCEWfuIDVkgbqtrVcASezcaOVNPv3cke0rzEXE10QKR3yCCBlhr4SJ221N8BcHksPCAstYFAM2PzoSmbkvOJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738422060; c=relaxed/simple;
	bh=+lZqbCxkWke635XqavrkZMlw/Rnvka0GW+o4jhgxnV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txDHV6pM5RCRjvspkGm9WGBsluHIEGs3zPEHMuL/hu9/Na/PFJ7sWPmAXjHoxDlXIwVbJUXD5NyMQcEgTuWc0TMl7M3a39qqghRGER8UlGuvI1My6jcRCFjjtT1xiSNM4pxzriEXikIQFU1ODYXti3X9IqvRYijUDkNa9HIl5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOJ/i8Vd; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so31010861fa.1;
        Sat, 01 Feb 2025 07:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738422056; x=1739026856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=duwl8rJVSi2r0WT/BOYdGT25dza0Yk8q97PWBB1CxxQ=;
        b=FOJ/i8VdonlpBTlYlHH4vIpf/+3ruOBmpLxYZuHlvx6nFIwkHY3ZsXA/UDEAtQ+Jey
         jfR9OA6RF2X5t78Ys9C3ZBO0x2FTcJY52dARICHNx3DLNti38r5SJ/IyPhKgD9T/dUYg
         q1Lii1RVwATyM3XFEWWX+aUun8/SRsB/i6AjyJ/cRSv5ICnqI0HnH/FShrDnc1N2jHBq
         WyITluQe7E1HdpE8uZ+yU7zMBXi6YNCa5bN1+2eFhm2UxFytmsOtEHTF7/erqEmrtYoQ
         VUTQ5oU97GhzqxYchCE7n4Nk5E6ynTDuEnZSzPSWZZWuXICy5/eMZxxlKC3Y9eYdclU6
         WUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738422056; x=1739026856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duwl8rJVSi2r0WT/BOYdGT25dza0Yk8q97PWBB1CxxQ=;
        b=cnWjMMVtxg3hEhBsODYZxv7GkldPw6ioDWRZylBZmiiWSQy4OicO7o5lshpuGy+oXF
         Nj2enjqxCb8594zND7028nK7xpD/zirYHDlii71Obj5Sf3nr1AJ8s/gJbkTyKRPiGi5M
         PIzCZ5l2AHDpan3bqyThD3i5eXV6Tk3/jMR3uXVEuNe9mVJVmFgguaDhHJORT40Rdqxp
         TGVvUvuSdTXrx6WNi6bUaoH7q4PDExhZ7FD0LwW5tXEkUU+CTe+BiN3IEeCZKvmFvg97
         pr9S4eM7GSpNOEC38nagfSqdYHCUOulQUsiIkEVBl7njzMRrGmyu6rN5IJ4rHKlAM/hR
         MOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCULBDMQU9c7R/O82Yblfsqq6WEvBc0iBIEOlURG9mYB9kEv0Kv+/vG9/Xxe+UAlxmpGUNBXHHT9HeTa@vger.kernel.org, AJvYcCV90QFX2VwUTAnq9WqJGEu9Vz3oclCIl54UVWCR79B3F7Be4E8uoOmYYNnON34VDqR057o5pYBlsQFrZvzv@vger.kernel.org, AJvYcCXZWfvKNF5Lawk0WAmzcnmmfNSTxiAvp5JSDqoSKh4Yt1/eLFz65DoEY2qkPfNvvQ5tg4YtsD9iSQjB@vger.kernel.org, AJvYcCXaiQllAsm18DfropJpwfRG+zly1yySzCF5Us+HjrWSlhr73RI76nZZ+4xHSFv8je+A4qq7qytEBh35bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyURz1nMu9TMFDbSMQ4tEgmS6u2PAn0uoB+MDbEczQ9x2Bdg5WX
	L6kmZeQnbH6jZm2+IqkpaGKl8f1H2z0+o6muo5CShWHSFlXNY4SJ
X-Gm-Gg: ASbGncvGAe0JBncZOQh2bOum7ErE9WbZj2qIY9QaMzlSMg8/XtB4wKuTLJsl3i2UoKp
	ZCoyoDtJGF4GZtdDCpjB3mKxVImU+U6PW+wpbrhkET4H0gA4+rFWi0f+nXTfLb8Kll7+ACuqEcu
	U1cUVLWrOK7nl1BGcJSzHHqCw6z/CJKKmCcrc/NMGZmb7Ir/tJ66sUgkn6mVVBJpL5yBEp1Iqrn
	9cNDqakPmfYlbtdrC1EbQFHFSUKKosuqa7f/Dpz6hCxEAQXBLwx6I/lcFXDTsJHLhKyp8cII89J
	wodaMxzqbctVe1zJjrxlF2jMBnbXhK57HX/0UMHWxvvjvGO4TmEKiOdQ
X-Google-Smtp-Source: AGHT+IGwjsayJLnDJxH5AwpF9t8KSRh+v6rolaVhrQlXeaCIlau6+z77XJKfcH/dMjk2d7nunAUwoQ==
X-Received: by 2002:a05:651c:b2a:b0:2ff:c86b:5b4f with SMTP id 38308e7fff4ca-307968ef606mr57303421fa.21.1738422055682;
        Sat, 01 Feb 2025 07:00:55 -0800 (PST)
Received: from [192.168.1.110] (85-23-190-22.bb.dnainternet.fi. [85.23.190.22])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a3097f27sm8847811fa.45.2025.02.01.07.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 07:00:54 -0800 (PST)
Message-ID: <5cc01bc7-95b7-4a58-86d7-d4293e0e9966@gmail.com>
Date: Sat, 1 Feb 2025 17:00:51 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] Support ROHM BD79124 ADC/GPO
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
 <20250131170840.00002dc8@huawei.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250131170840.00002dc8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

Thanks a ton for the help! :)

On 31/01/2025 19:08, Jonathan Cameron wrote:
> On Fri, 31 Jan 2025 15:34:43 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Support ROHM BD79124 ADC.
>>
>> Quite usual stuff. 12-bit, 8-channel ADC with threshold monitoring.
>>
>> Except that:
>>   - each ADC input pin can be configured as a general purpose output.
>>   - manually starting an ADC conversion and reading the result would
>>     require the I2C _master_ to do clock stretching(!) for the duration
>>     of the conversion... Let's just say this is not well supported.
>>   - IC supports 'autonomous measurement mode' and storing latest results
>>     to the result registers. This mode is used by the driver due to the
>>     "peculiar" I2C when doing manual reads.
>>
>> I sent this as an RFC because I implemented the pin purposing (GPO/ADC)
>> using pinmux - which I've never done for upstream stuff before. Hence
>> it's better to ask if this makes sense, or if there is better way to go.
>> Anyways, resulted drivers spread to 3 subsystems (MFD, pinctrl and IIO)
> In principle nothing against pin mux for this.
> There are other options though if pin mux ends up being too complex.
> 
> - provide ADC channels in the binding channel@x etc.
> Anything else is freely available as a GPIO.
> Normal GPIO bindings etc for those.
> 
> The channel bit is common on SoC ADC anyway where we don't want to
> expose channels that aren't wired out.

Thanks for the insight on how things are usually done :)

I think the only reason for having all the channels visible in IIO, 
could be, if there was a need to provide a runtime configuration.

> For combined ADC GPIO chips we normally don't bother with an MFD.
> Just host the gpio driver in the ADC one unless there is a strong
> reasons someone will put this down for GPIO usage only.

I don't really know about that. I don't like arguing, yet I seem to do 
that all the time XD

I personally like using MFD and having smaller drivers in relevant 
subsystems, because it tends to keep the drivers leaner - and allows 
re-use of drivers when some of the hardware blocks are re-used. In some 
cases this results (much) cleaner drivers.

(Let's assume they did "new" ADC, and just dropped the GPO from it. With 
the MFD the deal is to add new compatible, and have an MFD cell array 
without the pinctrl/GPO matching this new device. And lets imagine they 
later add this ADC to a PMIC. We add yet another MFD cell array for this 
new device, with a cell for the regulators, power-supply and the ADC... 
The same platform subdevice can be re-used to drive ADC (well, with 
added register offsets)).

Allright. I believe you have more experience on this area than I do, but 
I definitely think MFD has it's merits also for ADCs - they do tend to 
put ADCs to all kinds of devices (like in PMICs after all, although 
maybe not with 8 channels and less often without an accumulator).

>> Furthermore, the GPO functionality has not been (properly) tested. I'll
>> do more testing for v2 if this pinmux approach is appropriate.

I took a better look at the pinctrl docs while listening the FOSDEM 
talks :) (Which inevitably means I missed a few things from some of the 
presentations, and also didn't really properly understand what I was 
reading. "Multipasking..." like some rude Finns might say.)

Anyways, I think the pinctrl should have some out-of-the-box support for 
use-cases where pin(s) can be used for GPIO, and for an another 
function. (I think, I saw functions which take care of the pins having 
right state for GPIO use). I don't think I properly used those features.

>> Furthermore, because the ADC uses this continuous autonomous measuring,
>> and because the IC keeps producing new 'out of window' IRQs if
>> measurements are out of window - the driver disables the event when
>> sending one. This prevents generating storm of events, but it also
>> requires users to reconfigure / re-enable an event if they wish to
>> continue monitoring after receiving one. Again I am not sure if this is
>> the best way to handle such HW - so better to ask for an opinion than a
>> nose bleed, right? Maybe the next version will no longer be a RFC :)
> 
> Oddly I thought we had ABI for this but not finding it.
> We basically want a thing that lets us say don't allow a repeat event
> for X seconds. Then we set a timer and reenable the interrupt after that
> time.  I think there are drivers doing this but can't find one right
> now :(  It's close to _timeout used for gesture detection.

So, a good old timer for doing unmasking. I think this makes sense if 
the existing users of ADCs aren't prepared for the events to get 
disabled by driver. Thanks! I'll follow this suggestion :)

Yours,
   -- Matti

