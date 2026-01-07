Return-Path: <linux-iio+bounces-27523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DDDCFF186
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D0C23392E73
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FA434846E;
	Wed,  7 Jan 2026 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2uAo2Vi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406B347FFB
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798831; cv=none; b=KJNzaAnUDfQTHX2zELCkrnkH55fDjDBdki/MvVVlCbysb2URJIPFoRJenDpCP5jbBIK+5Y7IsberhxYVO11xOK0O3XD5X+d0wo31Jy8y1OCekLXSCgu+bJuhxCqhVdsfLE2JKYk+EDpDDGK8YDMtME2uC+oiKxMeTcoqS2ed3uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798831; c=relaxed/simple;
	bh=8W3cviQ5GbInToBhBoY7C9vmqNIvn2QZQdxWo3XW2/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5kdiG++D19ZhK2jyZcO5TLX42JhwT+CjaAZR2XPZcPTT6bTSFlcGoUc8gFCUqL+mHpkgTf9lq4zlXFYBJcrG775d8ysL0NyzGnsM9pbSz8vVUHa0O0WCFHyDG2/A0HgBVltGaeWlstQCB86/WefjlWjfVS48fGwUKJfr7YyMEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2uAo2Vi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so19461275e9.3
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 07:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767798828; x=1768403628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Ereg+lemriroCRpjwkDWgDnQDqYfpC800QB/08JPJM=;
        b=H2uAo2Vi7HDA+JaG3BZ23dN6BQ4d6kE27XLtJqrbleeBukrWUS88/hYo+GnpOe+z/D
         8WKHf70YpwOcri6FRMhvYE7ieyOsWvnxDNMoEdQ4t6GDjPJPqKfAgNRD/hcqE/l4J11g
         cGwrHq1gsBXbfHVn6VaC7ZsHmbg6xCHQ/7vOu6fuq8eAadIDv86BEzvVYpSgqtXquX8M
         vBq8g8mYMVHgeVasZz99HpgonsJU4dclU3FembZ1IRt5h1Mr/zD04FWv0TIa6i1FAmr7
         1L5a8AZtj47KbU0uj6+Z0weRwAsK4C+71kh7+w/zYufpAiVd3DTxEvr13ogJ8C1dbUwo
         XZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798828; x=1768403628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ereg+lemriroCRpjwkDWgDnQDqYfpC800QB/08JPJM=;
        b=Y7p0E9+XhEJoplRnnRHxbxDPfdHag+dT0Ws4oaUIptm2wK/GLHfCIlgVHkHY/4wFE2
         hJ6b+0iB+6Ex8zWRnvhj1aLm1PB+4faB4cP+mW00SR+k73iA24ViV+FZ1VjShTTG67lm
         vTyYGARbmTlzM/QWWRHNi1cWnRtAymviBEkzEM8HQNgaDqqh8GsxlrKskYOL4uRxwEbI
         jAAGTVPSKYp7G2DspTRIslsJKo0g6Ku8YcWVpZAudo3XZWpILOiHokqLCTKYj4Qt0ig9
         PDxgpGTVF3kVTb43Jh3bNYNY7Pxz3YZ8hyjEBWcsmNZwogesObI48JVx2KKC7+TZyCZS
         i2Wg==
X-Gm-Message-State: AOJu0YwNHoDK1C3F2ITWd5k61FEazRgJl/fAX4qrbRcC+yna7Xi4TtOv
	DgIRlJLPqZ1qvVHEPgBX5K3RXI2DXsLK0F9W1CvQI7A/fWTB40NICYZc
X-Gm-Gg: AY/fxX4SNkXse7C0YTLOtQfjZKOOU39P1ofhlHtYO00CvAF35qQRQYdiRQy2N/+XOQQ
	HD8yBizarH0JpIrAM1S9HzgT4NIwr4blnyHfGDvAyMY82Bk9oiRKQkqx3V8A854+UTaKViVz0AQ
	udhsRQ547CXDI9x7zKREksW8T8uCTM60iWXGI19acVNBx7ZtrL6P0Vj8fHxRUknBOdXNUUubqvd
	3b2frSB+QNcWg9ut5QVkmCcc5bJBcylJqBVK7FA6J7n+ekr0xAScw1NHiiLD+efQE3bH0rqU0Aq
	1Pn3NygYX+5RcfS7k4mBxFeekthChRP3f4ZKxzZBpmeupzH7dCxoGQU9E5JDcJh5QkBqd3h0ZBn
	Wj19rnZ2ZnuEKfDO7+WjZY0NeAWKXXQjxXIiZIfZKeBx+5wYv3NUte42k1y6LBaaHCVgKubG6O2
	i2zmXGfW+yQNF1cr/kiVkU1TD4Og==
X-Google-Smtp-Source: AGHT+IHXEer8ATdFHJ3hctOBJ1LLmHpzbXID1qbtLy4x8gGW16EIKN6E9TqiON2GnaulMGyPUWYlDA==
X-Received: by 2002:a05:600c:8485:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-47d84b182c3mr31029125e9.14.1767798828047;
        Wed, 07 Jan 2026 07:13:48 -0800 (PST)
Received: from [172.24.138.145] ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86c6ff40sm31996415e9.2.2026.01.07.07.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 07:13:46 -0800 (PST)
Message-ID: <f2537281-f2e0-4194-bc05-cea41ceeba7d@gmail.com>
Date: Wed, 7 Jan 2026 16:13:43 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: dac: Add max22007
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 jan.sun97@gmail.com, gastmaier@gmail.com
References: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
 <20251219-max22007-dev-v1-1-242da2c2b868@analog.com>
 <7ea6cb11-b9a7-4944-bfa1-63c063eb421e@kernel.org>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <7ea6cb11-b9a7-4944-bfa1-63c063eb421e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

Thank you for reviewing the patch.

On 12/19/25 16:50, Krzysztof Kozlowski wrote:
> On 19/12/2025 16:31, Janani Sunil wrote:
>> Devicetree bindings for MAX22007 4-channel
>> 12-bit DAC that drives a voltage or current
>> output on each channel
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Noted on the coding guidelines. Shall update the commit message.

>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>> ---
>>   .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 116 +++++++++++++++++++++
>>   MAINTAINERS                                        |   7 ++
>>   2 files changed, 123 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
>> new file mode 100644
>> index 000000000000..c2f65d9e42d4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
>> @@ -0,0 +1,116 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/dac/adi,max22007.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Analog Devices MAX22007 DAC device driver
> Bindings are for hardware, drop all device driver references.

Right. Shall remove the references.

>> +
>> +maintainers:
>> +  - Janani Sunil <janani.sunil@analog.com>
>> +
>> +description:
>> +  The MAX22007 is a quad-channel, 12-bit digital-to-analog converter (DAC)
>> +  with integrated precision output amplifiers and current output capability.
>> +  Each channel can be independently configured for voltage or current output.
>> +  Datasheet available at https://www.analog.com/en/products/max22007.html
>> +
>> +$ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: adi,max22007
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  spi-max-frequency:
>> +    maximum: 500000
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  vdd-supply:
>> +    description: Low-Voltage Power Supply from +2.7V to +5.5V.
>> +
>> +  hvdd-supply:
>> +    description:
>> +      Positive High-Voltage Power Supply from +8V to (HVSS +24V) for
>> +      the Output Channels.
>> +
>> +  hvss-supply:
>> +    description:
>> +      Negative High-Voltage Power Supply from -2V to 0V for the Output Channels.
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO used for hardware reset of the device.
> Drop description, redundant, because not saying anything other than
> schema already said. You could say whether it is active low for example
> if you wanted to add something useful.

Agreed. Will add some information about the GPIO.

>> +
>> +patternProperties:
>> +  "^channel@[0-3]$":
>> +    allOf:
>> +      - $ref: /schemas/iio/dac/dac.yaml#
>> +      - type: object
> Drop allOf. I don't get where did you get this syntax, it's not needed.

Shall remove it.

>> +        description:
>> +          Represents the external channels which are connected to the DAC.
>> +          Channels not specified in the device tree will be powered off.
>> +
>> +        properties:
>> +          reg:
>> +            description: Channel number
>> +            maxItems: 1
>> +
>> +          adi,type:
>> +            description: Channel output type.
>> +            $ref: /schemas/types.yaml#/definitions/string
>> +            enum: [voltage, current]
> Why would it matter if this is voltage or current? That's the first time
> this property appears. Why none of existing fit?

The DAC allows configuring the outputs to be a current/voltage type. The IIO channel names need to change depending on that.
But as per Johnathan's suggestions, I shall reuse the adi,ch-func instead of introducing a new property here.

>> +
>> +        required:
>> +          - reg
>> +          - adi,type
>> +
>> +        unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +anyOf:
>> +  - required: [channel@0]
>> +  - required: [channel@1]
>> +  - required: [channel@2]
>> +  - required: [channel@3]
>> +
>> +unevaluatedProperties: false
>
> Best regards,
> Krzysztof


> Best regards,
> Janani Sunil

