Return-Path: <linux-iio+bounces-9013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54926968B8E
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1701A280FD1
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEC21A3035;
	Mon,  2 Sep 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dv9FpBfZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F6F42AB7
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293165; cv=none; b=GdFJuvPfb1qsZdEuV7WJoms47DwP6SXEseXxUmtG22baEG1yt84hYgMcYSY7/hXgX8kAFNZrBcenkLx9KnNHA55uUZrq+bAjINOeDx4jEBcjjO8Q+HDeA4jCq6NnQYoJB1bHm3kxzV6tlihr2swhLp/VvSHq4vJIN/ltdvpiFWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293165; c=relaxed/simple;
	bh=e688r4Ns447mVc0q4D+3KuigCizQrygfxtlWAPasc1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJya/FVzYagfPJ0SD+B3K6V3p2lEwkAzXfzDBr84yXAWqNf1FxEoVGcC/ekMDFK5WE7zSZZOlXsCIlNVaTB4gmONoXkXcV2s0tb6IcLf3ay4eQ8GVDqh05VBREEJkHX+McFy5kFpiIslQAFGnwuc8jozQwKBHuv0VN6F90s5rDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dv9FpBfZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-371941bbfb0so2828606f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2024 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725293161; x=1725897961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gWwempmrlKyg0ktcBiad3mGoxdc78SQKDpbgB1kqK4=;
        b=Dv9FpBfZ1WuscKoauU0RY6sAlgEZZH1nz+fylf4PjKCzphH/iCGpM9pJ8sixV9DGcv
         LhCh2q955+Jx1ph6xX6NfeMfIjK6l2IOwkIVpEIQeN25MvA4UT7NHzJ4c69rFpDq52mD
         D+bOljMvRdQuOeYJB5wCtteIoHrZqoAgrORsH9OO4GGViszBP3uWhedLA0P5iKvcWW0l
         RRu0E5quvokjQ8qjSX7BKlScUqsdErv7U+xcM7wsmkJUZLzHh/BGesV+k0dd7mzfGD8G
         rJcoLwDCltRYMJTogKAkBhfvtjXffDMqezKr/rbU5VIzDS1flpvllAIZKXKjB1Z+yWZI
         44BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725293161; x=1725897961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gWwempmrlKyg0ktcBiad3mGoxdc78SQKDpbgB1kqK4=;
        b=mI7w9cGqla4NJpzL3aepO8mNqJciwNAusfc6x2xkMzNSwbih0sCXSTZDTG3vEUyzSW
         SgmXwXR4erPfPe986lPi692i8AjlxlQMIFQKx5dWNfHeQaR+c6VRo4ysxrs4EagAjMUP
         hV9ZZy3dRLKLIWB08PWjrlyNwfSeFGZrW+6Wybw6hA/5nC2kgko2w3v1PyL49p1Hcx56
         bjUZsCsTUVyrBnhn3PT1EVt7zNLtzinECnEOmvAwXZqOPgGyZYHucnOnwhce/RpF7YkV
         0HNg2M73n+xQX0u/nMi1tZMTjW/5bgVX6P9zq/FBBfgivc5VfvgbUN2rVW21Jhp4Ryun
         m1EA==
X-Forwarded-Encrypted: i=1; AJvYcCU4njFTbBwWYdIhR+nLCa3nnDt+PT3Tj6sDuPF4TqP7V6uvaU9tWxc44YjbcNqL7ieAKEzShvFizDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+4tjoUNuZHXOrTLZC83jgU9refO8iHD+d9lRviXJC+vBhC+Ya
	Wcx+jnP+QUkMYFWgCOCfKp7iZzzZaRijVuHBXk9AaBE7jkLeadnBPk0uqMxsFWg=
X-Google-Smtp-Source: AGHT+IHiU9zG2G5pVHxRRYp7j1A5h8iIktTUeGCoeQ5aZHb76r8edxM+DW/1xcxx09/W301clxlk7A==
X-Received: by 2002:a5d:634b:0:b0:374:c8d3:5f2f with SMTP id ffacd0b85a97d-374c8d360f2mr3183556f8f.31.1725293160559;
        Mon, 02 Sep 2024 09:06:00 -0700 (PDT)
Received: from [192.168.0.2] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0f36sm142834145e9.16.2024.09.02.09.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:05:59 -0700 (PDT)
Message-ID: <fd68cda2-f523-49fd-943b-c07dbb461799@baylibre.com>
Date: Mon, 2 Sep 2024 18:04:51 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/8] iio: backend adi-axi-dac: backend features
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-3-b6da6015327a@baylibre.com>
 <20240831123418.6bef6039@jic23-huawei>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20240831123418.6bef6039@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 31/08/24 1:34 PM, Jonathan Cameron wrote:
> On Thu, 29 Aug 2024 14:32:01 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Extend DAC backend with new features required for the AXI driver
>> version for the a3552r DAC.
>>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> Hi Angelo
> Minor comments inline.
>>   
>>   static int axi_dac_enable(struct iio_backend *back)
>> @@ -460,7 +493,13 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
>>   	case IIO_BACKEND_EXTERNAL:
>>   		return regmap_update_bits(st->regmap,
>>   					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
>> -					  AXI_DAC_DATA_SEL, AXI_DAC_DATA_DMA);
>> +					  AXI_DAC_DATA_SEL,
>> +					  AXI_DAC_DATA_DMA);
> Unrelated change.   If you want to change this, separate patch.
Thanks, fixed.
>
>> +	case IIO_BACKEND_INTERNAL_RAMP_16:
>> +		return regmap_update_bits(st->regmap,
>> +					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
>> +					  AXI_DAC_DATA_SEL,
>> +					  AXI_DAC_DATA_INTERNAL_RAMP_16);
>>   	default:
>>   		return -EINVAL;
>>   	}
>> @@ -518,9 +557,204 @@ static int axi_dac_reg_access(struct iio_backend *back, unsigned int reg,
>>   	return regmap_write(st->regmap, reg, writeval);
>>   }
>>   
>> +
>> +static int axi_dac_bus_reg_write(struct iio_backend *back,
>> +				 u32 reg, void *val, size_t size)
> Maybe just pass an unsigned int for val?
> So follow what regmap does? You will still need the size, but it
> will just be configuration related rather than affecting the type
> of val.
>
void * was used since data size in the future may vary depending
on the bus physical interface.

Actually, a reg bus write involves several AXI regmap operations.
>
>> +{
>> +	struct axi_dac_state *st = iio_backend_get_priv(back);
>> +
>> +	if (!st->bus_type)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (st->bus_type == AXI_DAC_BUS_TYPE_QSPI) {
> As below, I'd use a switch and factor out this block as a separate
> bus specific function.
Ok, changed.
>
>> +		int ret;
>> +		u32 ival;
>> +
>> +		if (size != 1 && size != 2)
>> +			return -EINVAL;
>> +
>> +		switch (size) {
>> +		case 1:
>> +			ival = FIELD_PREP(AXI_DAC_DATA_WR_8, *(u8 *)val);
>> +			break;
>> +		case 2:
>> +			ival =  FIELD_PREP(AXI_DAC_DATA_WR_16, *(u16 *)val);
>> +			break;
>> +		default:
>> +			return  -EINVAL;
> Hopefully compiler won't need this and the above. I'd drop the size != 1..
> check in favour of just doing it in this switch.
>
sure, done.


>> +		}
>> +
>> +		ret = regmap_write(st->regmap, AXI_DAC_CNTRL_DATA_WR, ival);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/*
>> +		 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
>> +		 * the data size. So keeping data size control here only,
>> +		 * since data size is mandatory for to the current transfer.
>> +		 * DDR state handled separately by specific backend calls,
>> +		 * generally all raw register writes are SDR.
>> +		 */
>> +		if (size == 1)
>> +			ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
>> +					      AXI_DAC_SYMB_8B);
>> +		else
>> +			ret = regmap_clear_bits(st->regmap, AXI_DAC_REG_CNTRL_2,
>> +						AXI_DAC_SYMB_8B);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
>> +					 AXI_DAC_ADDRESS,
>> +					 FIELD_PREP(AXI_DAC_ADDRESS, reg));
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_update_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
>> +					 AXI_DAC_TRANSFER_DATA,
>> +					 AXI_DAC_TRANSFER_DATA);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_read_poll_timeout(st->regmap,
>> +					       AXI_DAC_REG_CUSTOM_CTRL, ival,
>> +					       ival & AXI_DAC_TRANSFER_DATA,
>> +					       10, 100 * KILO);
>> +		if (ret)
>> +			return ret;
>> +
>> +		return regmap_clear_bits(st->regmap, AXI_DAC_REG_CUSTOM_CTRL,
>> +					  AXI_DAC_TRANSFER_DATA);
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int axi_dac_bus_reg_read(struct iio_backend *back,
>> +				u32 reg, void *val, size_t size)
> As for write, I'd just use an unsigned int * for val like
> regmap does.

Ok, so initial choice was unsigned int, further thinking of
possible future busses drive the choice to void *.

Let me know, i can switch to unsigned int in case.


>
>
>> +{
>> +	struct axi_dac_state *st = iio_backend_get_priv(back);
>> +
>> +	if (!st->bus_type)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (st->bus_type == AXI_DAC_BUS_TYPE_QSPI) {
> It got mentioned in binding review but if this isn't QSPI, even
> if similar don't call it that.

It's a bit difficult to find a different name, physically,
it is a QSPI, 4 lanes + clock + cs, and datasheet is naming it Quad SPI.
But looking the data protocol, it's a bit different.

QSPI has instruction, address and data.
Here we have just ADDR and DATA.

What about ADI_QSPI ?


> Maybe use a switch from the start give it will make sense
> anyway the moment there is a second bus type.

ok, used a switch in the write too.

> I'd be tempted to factor the rest of this block out.
> I guess expectation is we'll see more bus types so that factoring
> out will be needed soon anyway.
>
>
>> +		int ret;
>> +		u32 bval;
> 		u32 bval = 0;
>> +
>> +		if (size != 1 && size != 2)
>> +			return -EINVAL;
>> +
>> +		bval = 0;
>> +		ret = axi_dac_bus_reg_write(back,
>> +					    AXI_DAC_RD_ADDR(reg), &bval, size);
> Ugly wrap.   Move more stuff on to first line.
ok done.
>
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS,
>> +					       bval, bval != AXI_DAC_BUSY,
>> +					       10, 100);
>> +		if (ret)
>> +			return ret;
>> +
>> +		return regmap_read(st->regmap, AXI_DAC_CNTRL_DATA_RD, val);
>> +	}
>> +
>> +	return -EINVAL;
>> +}

Thanks,

regards,
Angelo

-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


