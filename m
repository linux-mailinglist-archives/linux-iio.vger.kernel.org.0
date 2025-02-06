Return-Path: <linux-iio+bounces-15078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C94A2AD9F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 17:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DED7169637
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F06B1EDA34;
	Thu,  6 Feb 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qSAURHyB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEA322FE02
	for <linux-iio@vger.kernel.org>; Thu,  6 Feb 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858984; cv=none; b=nrF0vv0g1T25ixQIb3ffLMkFPFAL2dfwhuDqqE5wQFWjErNpFnARZTSJsBmZ0wyKM7KBLRcxlSzAxroHm56pYH1h22rd0ECLcmK+1z/mGcrZE/FqoqtwEMepd23w4qYtcbRBTTUsj6udkPfcvxC24We9zPZlAHVmgtUqaqMt8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858984; c=relaxed/simple;
	bh=yQ/cMahOawtP4PxuyH9DWGJ4UyQFQnjW962HmXPyWh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ipxVLj1sRpIg9DFtQWQCO08RW1psoska3QO4ugIFhkGyt1qtn7xB+DNZHJ0kJcaG4OPqxYT/o1JAvAZU7b9QHDNpnobYVqt+soaQP/ldQavGOVEVsk80h567xA6XqxUTj1xAxPEMttqgY4FaLw/puLn1KOnrvJKgovzLIopMgFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qSAURHyB; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2b806ee0fd1so488119fac.2
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2025 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738858981; x=1739463781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cnC7VSfBG0ihPKxEu9pr9kDMCXHaSfGWdCeIs/YUaPw=;
        b=qSAURHyB0MucZBOyEyuVQmqRltfrCih2RlPxOwn+Ccknf2jFEAE58Ngyb0outSC9Xc
         gxYs5jitYNLO3Y62/z7/jEs2KgAEnlkm8yixp3TLREuWkvLO2xdeWxZ1WY2oOsHxzfsk
         9nqq5v60hQNzykMqZTpAVkY2SZnEJzw0uuWnz+UFxSYOCPW4KAm7sMoCgLkSSI9TVZFJ
         +CQMwBSNeEVeeF6H1/sYqsVkxaCzqR4s4fgiuK4jRY+3dA/VGgovuYOWSY+qnESOxFla
         +l+MdyA1YQGlYJDrWEUmb4IHqoR7irDNIYDNRXIcwXxIDBQ3cr1NwGakxMUgxrx7ae5e
         HzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858981; x=1739463781;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnC7VSfBG0ihPKxEu9pr9kDMCXHaSfGWdCeIs/YUaPw=;
        b=AYJaOTAU6oYX8CX2GXzjMX0P9Sj63RMG/XhqQ3lOJoCisO6YCEO6eG6mRc6p2ZP7XZ
         q9ZvM1sAj8J1UDWvjNmMASFyhQYPRQqBKfh/CvQ0dAZVqNDjAziPORmhTwhz5U+izNrD
         YOtuBs78adMcmcht8B5n53/inw5GPWXzGNCJB6mIt7gkDe2F0d+UuHVbPJrNTcYt+yfP
         TPwMRcFtZIS/uusf0WEXZDYxp80xaoO0Ljtz23mcv1Z60XsucI97hWSTXhkCItQUcnE3
         JK2V4seyFpro1lwWKlHD85qiy4GDC5oZ01ffLcJ+vm7iibrMuLSy1ehssksZfTkBAlUN
         4t8w==
X-Forwarded-Encrypted: i=1; AJvYcCUnaX/w3c2vs4VoEUSh6f5bTd4XWCEX15IQk/ZHO6c+aom0G4379hHyaZCBakOX6U0rdOb4TEN2JOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjS8zqZlPmQUZQbn8Kb/rhdZn48lCcKhUlGjsvKyAV4jh+S3e
	FNjIYJEXVgnV9e91rKchhyJuYZDliOO6JBLvLMKKxtovtVLeQJsIHa3azC/r+TE=
X-Gm-Gg: ASbGncuiElDHhoduSHZMWlyEyIkT69vUYmKEUmKnEcADA53iVXufIqZ8H3MHuORx15J
	+6zp+349IIvHrsCbfLxWHGQVbEGwWrEe4pnhXrWZJQ5Q6VpMQZrqwIMc01Aa2oUbFyOcA0ZER0h
	o3qD2xbPsrlk9pd8VD4EYS5hyH8HdECD0hbXb8SJwKwI7siPyckVYIu0J2nxW8M+bfUw2ddvXBX
	DPGuxeEZ5eiI22ZXyuUWUPZc3i3GLS3GdtVgt7c4HTHPJUhW3WubuHcpp5owI3rhomxmlyk7OGz
	u/jwvP53i8dsd2sYpH8Kcbs2fBMw0ak9db8DdopquI14DhsK6hOo
X-Google-Smtp-Source: AGHT+IGrVh/v5vcStALrqpNGUOb3jAVtv3FbIdsyoVlK6kALxIyavVWIb5C4oJiOS9AS6CkGcYPmgw==
X-Received: by 2002:a05:6870:7e07:b0:2a3:8331:717c with SMTP id 586e51a60fabf-2b804f44ca7mr5095585fac.10.1738858981173;
        Thu, 06 Feb 2025 08:23:01 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b8262622cesm348477fac.33.2025.02.06.08.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 08:23:00 -0800 (PST)
Message-ID: <b06f6457-4be3-4404-8c41-618bad0c7099@baylibre.com>
Date: Thu, 6 Feb 2025 10:22:58 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] iio: adc: ad4851: add ad485x driver
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20250127105726.6314-1-antoniu.miclaus@analog.com>
 <20250127105726.6314-9-antoniu.miclaus@analog.com>
 <c5722215-b720-49ab-9f0e-00b01eb4679d@baylibre.com>
 <CY4PR03MB3399B389972E92742EA3060D9BF62@CY4PR03MB3399.namprd03.prod.outlook.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CY4PR03MB3399B389972E92742EA3060D9BF62@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 4:00 AM, Miclaus, Antoniu wrote:
>> On 1/27/25 4:57 AM, Antoniu Miclaus wrote:
>>> Add support for the AD485X a fully buffered, 8-channel simultaneous
>>> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
>>> differential, wide common-mode range inputs.
>>>
>>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>>> ---
>>
>> I think we have the important bits sorted now (i.e. userspace-facing stuff).
>> Just noticed a few minor things in the latest revision.
>>
>>
>>> +static int ad4851_setup(struct ad4851_state *st)
>>> +{
>>> +	unsigned int product_id;
>>> +	int ret;
>>> +
>>> +	if (st->pd_gpio) {
>>> +		/* To initiate a global reset, bring the PD pin high twice */
>>> +		gpiod_set_value(st->pd_gpio, 1);
>>> +		fsleep(1);
>>> +		gpiod_set_value(st->pd_gpio, 0);
>>> +		fsleep(1);
>>> +		gpiod_set_value(st->pd_gpio, 1);
>>> +		fsleep(1);
>>> +		gpiod_set_value(st->pd_gpio, 0);
>>> +		fsleep(1000);
>>> +	} else {
>>> +		ret = regmap_set_bits(st->regmap,
>> AD4851_REG_INTERFACE_CONFIG_A,
>>> +				      AD4851_SW_RESET);
>>> +		if (ret)
>>> +			return ret;
>>
>> Do we also need fsleep() after software reset?
> The datasheet doesn't mention any delay required after performing Software Reset.
> Should I add something just as a safety measure?

I guess it is probably OK if the datasheet doesn't say it needs a delay.

