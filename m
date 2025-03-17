Return-Path: <linux-iio+bounces-16953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 462ADA64C61
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0F9162A81
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2BA236436;
	Mon, 17 Mar 2025 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf2CI9VX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032721A436;
	Mon, 17 Mar 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210654; cv=none; b=Ry5OokO6RdBAAEAlclpjr+YmCvXfk9FTyN83YfTOzb67+LVfgu291UMmZjrm57R9Lu0OQq2S8VY6eArzrVY9cKZjvzpommBvmUQvnZQz9SCNGX/fj3x80JAjjIY9sigH/+AaR3FXo3lB2+HlBfXTbH/RpfwM6Z+lCi+P7Y0OpzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210654; c=relaxed/simple;
	bh=9VSRDsn8cQ+3Lx01AnMve2V7BPIE0b3DP9zDsnTIZFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUq3eiNkwZ/wEtFru4tSZ8CoC4UiyOHOrqGtuYNe9BDxtu4CvTqxtjM2bRGZ1LMRt/WJxJxPZuebWIWVziGZyOyMfbJh9aLYTgq4tLS3l0GLa8wjwgNqgHVUsG9E3/Za8RSOaX9GDBhs38nDAEVBx3lZUxjsqr6YH2IH705kniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf2CI9VX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549b159c84cso4225290e87.3;
        Mon, 17 Mar 2025 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742210651; x=1742815451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VS+HrgkTs6Sh4C1IWxQ7u0UxOMPmKfPtcnR+6rXGaR4=;
        b=Xf2CI9VXJcBNip+x9tSwWIezWxzt/e7uXmBQxta6V70yM/MDW0qvDiQsV31EeMLCFW
         V76qECd+p1n8qGKnC0ouOWFYJ6RF/PbONeeTTaidkfzF/oVyYrD9y27nkRyvk2oa9DXL
         TD1s2Xlh8B5aCiffVbRvTArKuxL6uHjRhHTpwrFLrumxdguBtkXINku4boQ3zwpN/3cw
         9znxS+H0+VbMOOy34cJFu8U6QkvowSp1OFgnloVlK2UxD52Lr2D0vdtHzycTgYNJ++G4
         aHau+KSL3sj+ICc4eCY9ESG8RyMwDI4TQALJcCZTTkciWJcWGGTfKxBGH62wsCy21LRj
         TxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210651; x=1742815451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VS+HrgkTs6Sh4C1IWxQ7u0UxOMPmKfPtcnR+6rXGaR4=;
        b=t2KYTCE1knUpTmk7BAaKGoD2XOWG8NHZtrbkepSlB9jVyNJFC2AVASWTk1MMpjMt6B
         HszpBmCYoXwPfbGbw4ZCYtIrPoNIxnTsoLdAIIX+SnNejo+yfbfqUAK+0Y0sMsgd2ZOj
         uJK/x1ev3nL4od85hmlABHRIE8RalpHCUbNXVxsbi5/QurevyEFPMabKeLEkPoypXALx
         GouMIl52So0DqAYwdAa+9XJbdqXacp/YSu4MRjCLFisk/B+Pt9QRJwkay7HLgZdIK6Li
         OMUbbK7kUyC9A+K17nkfWJxCBHqIIoG773TceDWT22lmbDFSwcEWiQgjuftmPFtvJZuQ
         atUg==
X-Forwarded-Encrypted: i=1; AJvYcCUI56Ntzvlq4UO2bpnZUrp/r71LoDo+IczSGs3DChoTN3XWHqxXfjGhUizCEb7ls3GY5enn77bZA5U=@vger.kernel.org, AJvYcCUfxdCERQzzc5N+Xi5rmFms2k9x8XTOEOnqQGofTnGcEDJFR0y+aEHFrMvaGLWing8pM/4ceruTQVETVwdc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3KAI5euEFTvNRaelq66glrCTa+JjZEJUUE1M3P15EkO9O3/oa
	DMFoW4XGQ5li3GblbcKZqf7eFqPGknz2W7/M8BP0Z9mkNRDJ8hXh15pSzw==
X-Gm-Gg: ASbGnct4PgHZhDQM/N2fd5uv65vJne+rOxk/tz3Au8wmwYenQwcB16VrITcxXm9rvdZ
	kMA6gockz2eVfWlWuHOr7jrdIInIVPuxwZoZr8zUz5f5qh47Q5gqIHtnuTgs5uPdLZs96EiZEDt
	JkhAMCnsvBxpIbpLkXxvAWzVPsXyx9CwdAXqLD9Fw8BKwRUsPprmvh4AqNpWp9rDVntoWOkHeiw
	G3b6bYBIeM8JhU8TJpkHYdIBjYkCcnFWZcVpBEjUKaJ32Gyi+wnSJZC2cY+kCCo9ciEsZoK+T5e
	lx1rh2586dPxsdKeLQZAwu2fjpgxS+RojbsLDf+TXFD8B9ipa3a4+HhawWfDMJoktnWdLHZShES
	6Un7j0qXJ7/hz303h4slUB7MPTw==
X-Google-Smtp-Source: AGHT+IHcZ4qec5A0UCew71hjkOe/BS/LuzF4QMnIyfrkrT3VtIDRI6c0w8aCpffjUu4FDPtSAhlIdQ==
X-Received: by 2002:a05:6512:2245:b0:545:cc5:be90 with SMTP id 2adb3069b0e04-549c398cf85mr6049930e87.35.1742210650469;
        Mon, 17 Mar 2025 04:24:10 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8821f6sm1261140e87.176.2025.03.17.04.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 04:24:09 -0700 (PDT)
Message-ID: <222c5fa7-283b-48ce-9d01-34ca633674eb@gmail.com>
Date: Mon, 17 Mar 2025 13:24:07 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
To: Jonathan Cameron <jic23@kernel.org>
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
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
 <20250316110237.0b558248@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250316110237.0b558248@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/03/2025 13:02, Jonathan Cameron wrote:
> On Thu, 13 Mar 2025 09:19:03 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:

...

>> +static int bd79124_write_int_to_reg(struct bd79124_data *data, int reg,
>> +				    unsigned int val)
> ..
>> +static int bd79124_read_event_config(struct iio_dev *iio_dev,
>> +				     const struct iio_chan_spec *chan,
>> +				     enum iio_event_type type,
>> +				     enum iio_event_direction dir)
>> +{
>> +	struct bd79124_data *data = iio_priv(iio_dev);
>> +
>> +	if (chan->channel >= BD79124_MAX_NUM_CHANNELS)
>> +		return -EINVAL;
>> +
>> +	return (data->alarm_monitored[chan->channel] & BIT(dir));
> 
> Drop the outer brackets as not adding anything.

I just noticed that the integer returned from here is directly provided 
to the user-space. I don't know the history, but it feels a bit off to 
me. I mean, I would expect the read from sysfs file "*_en" to return '1' 
or '0' - not 0x04.

Oh well, I suppose it's too late to change this in the IIO core - but 
I'll do:
	return !!(data->alarm_monitored[chan->channel] & BIT(dir));

in v8.


Yours,
	-- Matti

