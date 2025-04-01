Return-Path: <linux-iio+bounces-17509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F04DA77B0D
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 14:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998D6188DF4C
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 12:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7B1F03C4;
	Tue,  1 Apr 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqaPXkmV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6562E336A;
	Tue,  1 Apr 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510802; cv=none; b=Ry0InUBKgLjbNRw7FgKTHjDbbK/aMW2exJigM6lqs5aIbx2QZTAwPK3MxJV3UpFmmpG9dOZIHWmBPnQUziWUB4bapUzqd2spb6cLE6uZ9thw3MV130L0fwYZqxOjyFWt/7+afaa3IppuxlvoPvxawyBQ+dwvFkPSaYhx1YxeH+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510802; c=relaxed/simple;
	bh=mCL2D5ZQbX8eJxeWFbv5Mf1XaQDcN1jPSUKzB5wrAz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aulurj+JHLVt/XSuVyh8o/u2cZSsRK6/h20HDQ058ATfbzBxRZGMceAZoQ2zidqcnr/rEdLtjYYoQkOtD6B3maXUH0sQFpyTpwSagItVLjSWmCM8K0MnaJY6rhm9zWVP36Ds3A2NlqaIZjh5U12mPIp0rKxs7jdEs+1Z9ZFIZ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqaPXkmV; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54b10594812so3962896e87.1;
        Tue, 01 Apr 2025 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743510798; x=1744115598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ui9eG3jSJBD4Kl91xnmQdM2hThhlJg4JZbHy3VVA6Dk=;
        b=BqaPXkmVt4n/ruobCgrVfkeVkOXb6UQr9fUAKFcmqjNh9UgW2FBhAkUCgdIuK6miQ1
         ObrGfbOUv5iLVFg04yeMUisHjODIorl1tYb96Uwqkof6IxiBJWv1rYqvJP0g4hQiFNWk
         HJvFv3PqPvFs3RFCq7i9qmxxp99voY0PjcILa1jJpyg/3Kpy79KgKclYuXM5kYPoLX4p
         io5ZscvfRtHaLGl9mmVSDGkFVnYJcNEM5vGosJTj/byPRxWzxAdTvTYhCBAy2nkm1xKD
         +jUalUHpGDCmaOENOvsfn4eHWA9WvxgoOGorweuzix6TWlFsC1zmNi9WZ2/PmffFINDk
         HRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743510798; x=1744115598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui9eG3jSJBD4Kl91xnmQdM2hThhlJg4JZbHy3VVA6Dk=;
        b=WIz+yeEl+VlC6DdmtdLxtlzg1YWbl4VydjGw/sW6y1FJCTqOloLBYz0zgnIPjhfXj1
         xhzOFqAMtvdbLz1dtnki8t+5FPn6rY8U7fXQHdO8ahmF42xJvjYXWJj9hYS8vTwfNbRn
         Q4IiPgKRK1qJ8ZiOHMWCce08M9LIf+2jS24I3ICTx6VwHF91ZrHgL9V0cIhAeNh9W83y
         OEhMU35vFe0BhmqIakKpBp6hv200eFel+gcmNk+D8EanPLDPWexeAhIm6LdXbs+7Pi9o
         vsX3CZI1PB7xouRkxN0IZfWmf6uO/0h59DWQLfk3+pLzSob0zsd69pbdtfXVU3NHQpSP
         wIgA==
X-Forwarded-Encrypted: i=1; AJvYcCWL517eaXuZVVXbCNlwpdf6uFoK5Dpi+b4fCS9sSKag2yirwA1H91q3jw/Ymq5LqFUGPSiOhqApGcyD@vger.kernel.org, AJvYcCWhYFx0nW9Lw56iMxbLRfsxDVPJJIjsFc+9lRJF7kqQtzDC7bgq/w+s7JTaEQQprlsm5uOfIQAEV/81aGfm@vger.kernel.org, AJvYcCX+pEFCOwxmpc958QAZroK5X/k9UMtuz0GObz+RXOuaB+6Iy2LMvftx0OOennrVukYYNN6e0FF/etsC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30iCgX56ZIWg7Crk6nGTyJfsjO+rBfQes/Ox3HU8zk4Ebke12
	qHjBXHSo7iHc01A9u24RfBfpYVGdd3oqv/AVhKSKrZ0Ag6EBW12P
X-Gm-Gg: ASbGncvdZRNuovXFCBSleQE2zclfu9GXvd5szGPa+xPNdukQjRBCqDJ3Gsijy9L7pcj
	Hfouj5OOl4fFhFVctMROEd8tBD3mVjS9ZjwSMh2mz+n/dSbzRRivoIDG0QI2rIZo37IUCDyHtDl
	xwOElQMUJTHMbcEgLca+/rszteHtlbmryyR/oxr4yZe8O9Ge3gDrHL983Vqj9JthQwIZmpw7C+s
	6/mfpPeVmmZuf+bl+TJjpPrfFelATKxpEXo8wlWi5J1TrxMotyWbvDn9Cbf+5xu1xDtZ2hSxRLI
	y7AnT7ISmfSbHZXZDYuHf/95PahmceJLAIALk2xjEOysTEqQlF+JRy8gEjdxWRUkJybwXYPgkOS
	ZABmmTCkgDGWqeEOBQL2HyZeZvQ==
X-Google-Smtp-Source: AGHT+IH/bg+YvSbyMLD/XjNhrZ+kT0hhEpeQjZilHkBh/AzZ9IdF+3LWG5MjG/O3xsRC1OjJi2OD0A==
X-Received: by 2002:a05:6512:108d:b0:549:893a:1eff with SMTP id 2adb3069b0e04-54b10ecb759mr3764389e87.24.1743510798165;
        Tue, 01 Apr 2025 05:33:18 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b0e703fa4sm1146717e87.169.2025.04.01.05.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 05:33:16 -0700 (PDT)
Message-ID: <a35ab4b1-4d6a-4b95-963a-96b2ab4c05e9@gmail.com>
Date: Tue, 1 Apr 2025 15:33:15 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: adc: ti-adc128s052: Support ROHM BD79104
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1742474322.git.mazziesaccount@gmail.com>
 <8e10f2d82362ca7c207324a5a97bb1759581acea.1742474322.git.mazziesaccount@gmail.com>
 <20250331122247.05c6b09d@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250331122247.05c6b09d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/03/2025 14:22, Jonathan Cameron wrote:
> On Mon, 31 Mar 2025 11:03:58 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BD79104 ADC has identical SPI communication logic as the
>> ti-adc128s052. Eg, SPI transfer should be 16 clk cycles, conversion is
>> started when the CS is pulled low, and channel selection is done by
>> writing the channel ID after two zero bits. Data is contained in
>> big-endian format in the last 12 bits.
> 
> Nicely found match.  Sometimes these are tricky to spot.
> 
>>
>> The BD79104 has two input voltage pins. Data sheet uses terms "vdd" and
>> "iovdd". The "vdd" is used also as an analog reference voltage. Hence
>> the driver expects finding these from the device-tree, instead of having
>> the "vref" only as TI's driver.
>>
>> NOTE: The TI's data sheet[1] does show that the TI's IC does actually
>> have two voltage inputs as well. Pins are called Va (analog reference)
>> and Vd (digital supply pin) - but I keep the existing driver behaviour
>> for the TI's IC "as is", because I have no HW to test changes, and
>> because I have no real need to touch it.
>>
>> NOTE II: The BD79104 requires SPI MODE 3.
>>
>> NOTE III: I used evaluation board "BD79104FV-EVK-001" made by ROHM. With
>> this board I had to drop the SPI speed below the 20M which is mentioned
>> in the data-sheet [2]. This, however, may be a limitation of the EVK
>> board, not the component itself.
>>
>> [1]: https://www.ti.com/lit/ds/symlink/adc128s052.pdf
>>
>> [2]:
>> https://fscdn.rohm.com/en/products/databook/datasheet/ic/data_converter/dac/bd79104fv-la-e.pdf
>>
> Prefer Datasheet tags with # [1]
> after them for the cross references.
> 
> Those belong here in the tag block (no blank lines)
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> One request for an additional cleanup precursor patch given you are
> touching the relevant code anyway.   It's a small one that you can
> test so hope you don't mind doing that whilst here.
> 
> I'm relying on the incredibly small chance anyone has a variable
> regulator wired up to the reference that they are modifying at runtime.
> I have seen that done (once long ago on a crazy dev board for a really
> noisy humidity sensor) when the reference was VDD but not on a separate
> reference pin.  That means we almost certainly won't break the existing
> parts and can't have a regression on your new one so we should be fine
> to make the change.

The change you ask for is indeed small. I have no real objections 
against implementing it (and I actually wrote it already) - but I am 
still somewhat hesitant. As you say, (it seems like) the idea of the 
original code is to allow changing the vref at runtime. It looks to me 
this might've been intentional choice. I am not terribly happy about 
dropping the working functionality, when the gained simplification isn't 
particularly massive.

Because of this, I am thinking of adding the patch dropping the 
functionality as an RFC. Leaving that floating on the list for a while 
would at least have my ass partially covered ;)

I'd rather not delayed the support for the BD79104 though. So - would it 
be okay if I didn't implement the clean-up as a precursory patch, but 
did it as a last patch of the series? That will make it a tad more 
complex to review, but it'd allow taking the BD79104 changes in while 
leaving the RFC to float on a list. (Also, I'm not sure if you can push 
an RFC in next without taking it in for the cycle?)

Yours,
	-- Matti


