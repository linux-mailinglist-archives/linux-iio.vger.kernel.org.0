Return-Path: <linux-iio+bounces-27480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF63CF2BB4
	for <lists+linux-iio@lfdr.de>; Mon, 05 Jan 2026 10:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 311A7300876F
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jan 2026 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDE932ED43;
	Mon,  5 Jan 2026 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EFMrWkWv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6D32E6BC;
	Mon,  5 Jan 2026 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767604679; cv=none; b=Q9/NW/nBI5sXo7ch7JMHX16auUHknY781ZVhljge1XUABTxgJTLhqsoS3v3u/GwOMaYcKFMZXvf3XRDmhuZRf421vXwdZUfgNraQkLhYoQWsnvGjNg2fM82U5aiXSUSz+55dVtccuMhd6uYvoVdwWEKzp1tlOabMWCgpC/xiUMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767604679; c=relaxed/simple;
	bh=6ykOa+xb1GhM+5QHERy/hBs2W8wwASApjH1/PuJz65g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmxw5u6WC5EBtEGMDFyESHb+cYsvjhLAZimWv2A3aaYY5EKbpXG4li0neG2o1jCpSSnWob6czFKWYHfiXqa7sKlIJ6iS+c/Eyobd8Obee6NMA6OU7hjrlaw+m1psi/OqjHYHEO3xN8yqU+944ez71wJyLzKsUm58rdLSM8Fhk/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EFMrWkWv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4F28B1A264A;
	Mon,  5 Jan 2026 09:17:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1BC4460726;
	Mon,  5 Jan 2026 09:17:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 590D8103C8475;
	Mon,  5 Jan 2026 10:17:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767604666; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=W9ayyFGLkXRbUavp+Vx6JiRizon1AphnblBQ3d58HHI=;
	b=EFMrWkWvfB0VUEyJjabFP5YIvm8XPGiaTZWKGo2ev+FQyEu9J+E4C9LhRqvKhR1EmVAqG6
	tvVTCrq4hJWg4Ow0geuRhPtJ/fURuwBlPA+3sR4jJnRKK1JwYLGKFT2s+rQdOURVXMjlXl
	3G0TWJaq5lNGWd3XQL6i6VKOkOmzNH7OYyXO/LPL2hWApPVgIzIOf+AAdV8j/gakblwXVv
	6NE/65eoleVL5gCSNQb9tBc160HgDIP13CXhG19MOgfUQFq5RZzA+y0UWHcUdR6tqoT5G3
	NfuepJvq2EN655vhdM6ZTCJLv4PGS0/1tz5GjIhG3nDzP/hSOuokuY+kgI0/pg==
Message-ID: <8c4999f6-48bf-45d5-9c5b-8103758bac05@bootlin.com>
Date: Mon, 5 Jan 2026 10:17:39 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add Texas Instruments TLA 2528
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, nuno.sa@analog.com, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
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
 <20251223155534.220504-2-maxime.chevallier@bootlin.com>
 <56c03c7f-1e5b-4586-beb0-47a1fa3bc86c@baylibre.com>
 <c386a4bd-9c7d-4b4d-b614-fdec424d57a0@gmail.com>
 <CAHp75VfDnuyqRyHpVK40qRR59XB3RHV-aDO72UDNhjLDbJHDPg@mail.gmail.com>
 <323d7c6d-3082-4775-b5eb-4bcb3ee9b1ea@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <323d7c6d-3082-4775-b5eb-4bcb3ee9b1ea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi David, Matti, Andy,

On 29/12/2025 14:23, Matti Vaittinen wrote:
> On 29/12/2025 11:31, Andy Shevchenko wrote:
>> On Mon, Dec 29, 2025 at 10:04 AM Matti Vaittinen
>> <mazziesaccount@gmail.com> wrote:
>>> On 23/12/2025 20:26, David Lechner wrote:
>>>> On 12/23/25 9:55 AM, Maxime Chevallier wrote:
>>
>> ...
>>
>>>> It looks like inputs can also be used as GPIOs, so
>>>>
>>>> gpio-controller: true
>>>> #gpio-cells:
>>>>     const: 2
>>>>
>>>> would be appropriate (it doesn't matter if the driver doesn't
>>>> implement it, we know what the correct bindings are).
>>>>
>>>>> +
>>>>> +  "#io-channel-cells":
>>>>> +    const: 1
>>>
>>> I didn't check the data-sheet, but if the pins can be set to be GPIOs or
>>> ADC inputs, then I would require channels to be specified. It's only 8
>>> channels, so always listing channels that are present shouldn't be that
>>> big of a problem - and it should avoid one to add extra properties to
>>> denote channels used for GPIO if GPIOs need to be supported.
>>>
>>> Well, I am not insisting this, there are folks that know this stuff
>>> better than I :)
>>
>> Why would we need an extra property for that? GPIO controller has a
>> property for valid_mask, should be enough to handle this case, no?
>>
> Ah. You're right. The "valid_mask" should be perfectly usable.
> 
> I might still require the channel information to make it explicit - but 
> as I said, I leave this for others to decide :)

Thanks a lot for these suggestions, I'll add all of that in the next
iteration :)

Thanks everyone,

Maxime



