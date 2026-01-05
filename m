Return-Path: <linux-iio+bounces-27485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2EDCF2FCE
	for <lists+linux-iio@lfdr.de>; Mon, 05 Jan 2026 11:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D6393021075
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jan 2026 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8C22F5A10;
	Mon,  5 Jan 2026 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PmE8dF+u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EA2F25FD;
	Mon,  5 Jan 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608834; cv=none; b=bmYNtReY15jocI1NQMW7YDe1WssaUvbVDVVUfLj5gH5HLhQ3pWJSWoHB1n8nnVQ35tPsaan1Jnvk/NZP9bfJXleWCz3/iTCGohy4mGCW7FOMaO9v+62SdygKWNYM+oYhryyLZgBz7vLOjgPRsJBccD39Xt/rxe/3tkHKTnWBDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608834; c=relaxed/simple;
	bh=vVtbdZer29Nu2XoUfAZUVed8YXwgEuk/RZ7iUyEo8n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6LDV7YX41rG0PpoC0ciEoe5Bphf8PI1SB+ky3MVLaWVVWQ1O+722rwtgMciTQWxCO//ykQTJfGjFv5RbDYZcbjmBpyEwGFsHLXKcghflTr8XhZzUYalItI0RBZMiImklJ6x3psUl0gHENq0ttObsrPjq9CGFZLE9SQwO+zK/5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PmE8dF+u; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E8A571A2657;
	Mon,  5 Jan 2026 10:27:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BACCF60726;
	Mon,  5 Jan 2026 10:27:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 42A04103C84DB;
	Mon,  5 Jan 2026 11:27:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767608827; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=oaZntv32SwPguMrDKxe4G++jbeSYrFXSzYxw3xzMSkE=;
	b=PmE8dF+uM8V+nQ0ixVi2iteYeCW2AnLwRvRcVADyejLKSP2Os2fGtB4HFjStZvACgB4kcS
	rCv5ngSDPrgDvYSDhghE/4lnV+elpFDjnPw5LbrJacvy0gRHx5LB8JjLK8Yf9uuxDRrAQ9
	0xJ5XKbKQEQGuVw4rdwlYZoX33YMe9O2+XdABBTUZ1Waj2/LY4BmYohXnefle4B7VUQqWY
	IR0eup73q52mmfiCWm3zd7vS8oZuR8qlVVO/TClY1DW1ORlTHEGDWvtW5wP17uMi8MG54B
	VTdnUhIQ9a7ZIx/uJXkEzWdll1bwUFOKbgEWnkbWulZjiWgn8RLRRxbwkQfFtA==
Message-ID: <51ab7e73-c973-4348-84c1-f5122808ce94@bootlin.com>
Date: Mon, 5 Jan 2026 11:27:02 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, nuno.sa@analog.com,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 duje@dujemihanovic.xyz, herve.codina@bootlin.com,
 Rodolfo Giometti <giometti@enneenne.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
 <20251223155534.220504-3-maxime.chevallier@bootlin.com>
 <CAHp75VdtPnDABykge4z2=74zPhGQbfZkiQR30QPvyam4eYE83Q@mail.gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <CAHp75VdtPnDABykge4z2=74zPhGQbfZkiQR30QPvyam4eYE83Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andy,

On 29/12/2025 10:39, Andy Shevchenko wrote:
> On Tue, Dec 23, 2025 at 5:55 PM Maxime Chevallier
> <maxime.chevallier@bootlin.com> wrote:
>>
>> This adds a new driver for the TI TLA2528 ADC chip. It ha 8 12-bit
>> channels, that can also be configured as 16-bit averaging channels.
>>
>> Add a very simple driver for it, allowing reading raw values for each
>> channel.
> 
> ...
> 
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/regulator/consumer.h>
> 
> Follow IWYU. Here are missing headers, such as bits.h, mutex.h, types.h.
> 
> ...
> 
>> +       case IIO_CHAN_INFO_SCALE:
>> +               *val = tla2528->vref_uv / 1000;
> 
> (MICRO/MILLI) ?

Absolutely

> 
>> +               *val2 = 12;
>> +
>> +               return IIO_VAL_FRACTIONAL_LOG2;
> 
> 
> 
>> +       tla2528->vref_uv = devm_regulator_get_enable_read_voltage(&client->dev,
>> +                                                                 "vref");
> 
> With
> 
>   struct device *dev = &client->dev;
> 
> at the top of the function this will be one line and others also can
> be shortened.

Ah yes indeed !

> 
>> +       if (tla2528->vref_uv < 0)
>> +               return tla2528->vref_uv;
> 
> ...
> 
>> +       /* Set all inputs as analog */
>> +       ret = tla2528_write_reg(tla2528->client, TLA2528_PIN_CFG_ADR, 0x00);
> 
> Why not simply use the "client"?

Good point

> 
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       ret = tla2528_write_reg(tla2528->client, TLA2528_DATA_CFG_ADR,
>> +                               TLA2528_DATA_CFG_APPEND_STATUS);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       /* Set manual mode */
>> +       ret = tla2528_write_reg(tla2528->client, TLA2528_SEQUENCE_CFG_ADR, 0x00);
>> +       if (ret < 0)
>> +               return ret;
> 
> Ditto.
> 
> ...
> 
>> +static const struct i2c_device_id tla2528_id[] = {
>> +       { "tla2528", 0 },
> 
> No ', 0' part.
> 
>> +       { }
>> +};
> 
> ...
> 
>> +static const struct of_device_id tla2528_of_match[] = {
>> +       { .compatible = "ti,tla2528", },
> 
> No inner comma.
> 
>> +       {  },
> 
> No trailing comma.
> 
>> +};
> 

I'll address these formatting comments as well, thank you for taking a
look :)

Maxime


