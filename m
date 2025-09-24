Return-Path: <linux-iio+bounces-24387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F46B9815F
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 04:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE0F7A8C46
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 02:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD9221723;
	Wed, 24 Sep 2025 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C979Wyey"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE3921E087
	for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 02:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758681665; cv=none; b=lG8Y6o3Qq8TZGOs9I7Dy0FXNRWhzttBd2KkUnySWxjuw9gc00+49rXUPOwwxm7wvTMOylYoqBeNy3pdpLQZOtCaFjEoYwLJ+JfI9smIeVQVdGKe2zoUo4uV16buFSmJpY0S7bbEeGC8fJJ3HrGd9lccq6CDb/5ox5YbFlvihFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758681665; c=relaxed/simple;
	bh=Uha/InzQTMU2XSWRXEyQ5VSO3HoUfrMeKudmNEUQGUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfu+IDb3vDQhUudZOgf4NcMjeR1PkTd3WgGtBGT8pb4TNMHR5w3vhgd2wv++n2gtQIhTo1mktSaiAjpzMIhWDfcs/ZJKDOus+zP40ekV9mCfbdMFOgO0js8+OkYQZQncIV81/ZXt9304aBDqfFPSkcTdK5Dt5YcatNe/q38i258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C979Wyey; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f605f22easo962737b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 19:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758681663; x=1759286463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uoZZYfcg1eDQ+SJZ5L9LQV2KxrPo1OhoDjYQOppmFGk=;
        b=C979WyeyIk49+gDTxmmpWDTS2Chki33BatjBnjIRgwsng9LbXjDe4jBnTn1mKj1nLE
         V8VL+smAD1U05tEQWzWwKruf9nzRjjvcqMYxbtm7z+rTaosd8oYuergBsMN7jVe8c8vT
         fl1lbbCGYvlPFG4a/ifqIZp65tz5c14AKEHIGR7Z3jryi1jYqIH+FWYbUAw+MH/ZTjxt
         nc6VNHIg0gi20VYPmVubyq5Ei2QamOt5gM9ptR0x65Akfnl1pyeO/4sj2+qVNABo0ru8
         PzWaPTPp1YxI7lrFfFSH0KVxoGYN+HBqpT+JF3lXrXCOmmsHmDhjB/nsQYRIYqcp7jF8
         P3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758681663; x=1759286463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoZZYfcg1eDQ+SJZ5L9LQV2KxrPo1OhoDjYQOppmFGk=;
        b=xVKTCoMnL+iSRCWfLy9JISnu7qXT8oJrdX22rQmFZm/g8VpjqXBhO1CISLq3O7TImI
         c5+2Hvf0CJgktSB2NRfcAon8CuRJELnxW5iE+zDpXYgVHYV4chrdCtQ2f6FfROh/abVy
         ELVVDMAIergDC9o6tO8tZXGUrBR9X6X1tg6Xsp2BpcvpoJu743F9cTZKE9oucQx920Cn
         CBt/JzkShyR31w83QmX7rsjocN3p9ZEfd1MnY9hf3v8Dr24HaL3IvEZ2u+3BUROCC/oF
         tJ1as3V15fMUiktgjJOBx2rwPc8QgZSwqmboKT8ZDCOC/73Cc381oC/+eouCA2n3/osH
         QhsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgX729n5a2Pqy/jG3tiuFi/WBsnTrbRfxjJXVLZqAkcg7AinjV4N7q0rxA4Rd0P1xhekRWv7AVQsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/aGYz9PDWHX4xBkVd02qML2QyBp5/W3BnNo6WnjR62/HXtGUA
	M3ENMYZojpq9wBs3xNBdI4n+7PG20ws4KFDKEMpAianFvIx9xaPGho84
X-Gm-Gg: ASbGnctBmj2pQE0NkmRIvRun4w5mM4imee8N2wKaE5E/InCv3YwuskSyH828CirXNzs
	suXriArh3wOtMFnwVPGGtZVhK4eE59o+mDa9nbbP2sz3jySwaOG+67d4rl/TwPsU4KWlEdf+DaP
	+His6PHCsUIQ+l/r8BNPVPsbPfHdu9YF72e8AgN1qWFg804a0oDIU1d0R3w/T+xhPzgxZ8yUaUy
	Ma2UmAmtdN2+kLvQwdM6kW0mjoAZPiXM2O6LT49PDcqMqvCnsXftic4Zs20RPT1FbCEUgPxpfgq
	Eb/Onbmvkuc4JeoOYvciriOXwcZ4ZkUCR4/Si7Wq3HfmGn/J84i6aRu87YDnaMl87Il+zWz9y6t
	z9IQ7ULVJ9dwg8f+ArweE3hRnDOoLrn8NvjnU+FkC8lqjqHWN/s4PREhqIrFBHV56gCVRPcXdGa
	V6sNgCdGlpjggx
X-Google-Smtp-Source: AGHT+IGQhBGrCzcmK6hv9moOx8ggT0aDNbcu/Pe0LQUZCBDVl4Fibpr1kyaVHD04dtyoEjoOsTg6CA==
X-Received: by 2002:a05:6a20:b90f:b0:2dc:40f5:3c6c with SMTP id adf61e73a8af0-2dc40f57e34mr1601675637.54.1758681662762;
        Tue, 23 Sep 2025 19:41:02 -0700 (PDT)
Received: from ?IPV6:2804:7f5:b08b:e4a8:158e:d41f:a482:c1c9? ([2804:7f5:b08b:e4a8:158e:d41f:a482:c1c9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55199e08f1sm12736678a12.24.2025.09.23.19.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 19:41:01 -0700 (PDT)
Message-ID: <1b269e4f-5a2d-4de9-8757-cd4218d36bac@gmail.com>
Date: Tue, 23 Sep 2025 23:40:55 -0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] iio: adc: max14001: New driver
To: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <c257f7feb92dcf33bf7a55810fe69d13890374d5.1757971454.git.marilene.agarcia@gmail.com>
 <2d5ef36b-ae37-453d-a19b-76fc97b7f14f@baylibre.com>
 <83018b80-b939-4e2f-a9ee-7fbf07648181@gmail.com>
 <c19fdb3a-e537-4f32-9b69-db819c04f447@baylibre.com>
Content-Language: en-US
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
In-Reply-To: <c19fdb3a-e537-4f32-9b69-db819c04f447@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/09/2025 11:27, David Lechner wrote:
> On 9/22/25 7:56 PM, Marilene Andrade Garcia wrote:
>> On 16/09/2025 15:04, David Lechner wrote:
>>> On 9/15/25 5:16 PM, Marilene Andrade Garcia wrote:
> 
> ...
> 
> 
> In general, please trim out extra stuff like I've done here when you
> reply. It makes it easier to find the important parts. I hope I didn't
> miss any of your questions.
> 
>>>> +    /*
>>>> +     * The following buffers will be bit-reversed during device
>>>> +     * communication, because the device transmits and receives data
>>>> +     * LSB-first.
>>>> +     * DMA (thus cache coherency maintenance) requires the transfer
>>>> +     * buffers to live in their own cache lines.
>>>> +     */
>>>> +    __be16 spi_tx_buffer __aligned(IIO_DMA_MINALIGN);
>>>> +    __be16 spi_rx_buffer;
>>>
>>> These would no longer be strictly big-endian, so we could
>>> just make them u16 with a note in the comments.
>>
>> Hello David, I have some doubts that I would like to clarify before sending v12. Since I am not able to test the case using SPI_LSB_FIRST, I noticed that you suggest saving the data as __le in this case. Just out of curiosity, if I use SPI_LSB_FIRST, would saving the data as __be lead to errors?
> 
> My thinking is that since we are sending things out 1 byte at a time, in order
> for the least significant bit of 16 bits to be sent first, the least significant
> byte has to be sent first. So will little-endian, the byte containing the least
> significant bit of the 16 bits will be first in memory.
> 
> __be is just a naming convention and doesn't actually cause any bytes to
> be swapped in memory. It just lets readers of the code know that the
> value stored there has to be handled carefully because it may not be
> cpu-endian. It would be confusing to readers to store a little-endian
> value in a __be16 variable, but technically, no, it would not cause any
> errors.
> 
> This is why I suggested to make it u16. It is still wrong but it is
> equally wrong in both cases. If you still want to use __be16 though,
> you could make a union instead.
> 
> union {
> 	__be16 be;
> 	__le16 le;
> } spi_tx_buffer;
> union {
> 	__be16 be;
> 	__le16 le;
> } spi_rx_buffer;
> 
>>>
>>> The scoped_guard() looks a bit odd with the extra indent. I would write
>>> it like this instead:
>>>
>>>
>>>
>>>      case IIO_CHAN_INFO_RAW: {
>>>          guard(mutex)(&st->lock);
>>>
>>>          ret = regmap_read(st->regmap, MAX14001_REG_ADC, val);
>>>          if (ret)
>>>              return ret;
>>>
>>>          return IIO_VAL_INT;
>>>      }
>>>
>>
>> Ok, thank you. But since I removed the mutex, as it was mentioned in the first comments, I should not use the guard, right? At least not for now.
>>
> 
> Correct. The regmap_read() has something similar internally already.
> 
Ok, Thank you for the answers.

Best Regards,
Marilene

