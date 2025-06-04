Return-Path: <linux-iio+bounces-20228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 143DDACE585
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 22:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D60189B753
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 20:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1FB200BA1;
	Wed,  4 Jun 2025 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RDhnPcVb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CA81940A1
	for <linux-iio@vger.kernel.org>; Wed,  4 Jun 2025 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749067702; cv=none; b=gA58ttjqv9ofWQ+Z7WnKdub6mV7NsycNmeQnLOdwTOPgqppE3TuZo+R+01NmLnZN+SPq88hZkc8bi5teGT0owwvDop+usaDFe5hx4bcEqOffqoS1FRI5l4PHPV9Fa610UeLzmFAyJ7eRC6z8M2HBHQyEtGGc3SmkWlUIeySURGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749067702; c=relaxed/simple;
	bh=U1OnM+wDx42RJMhEFhzFdLnhJjVXk9QUKvgzs6hObX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t4IKwy7EIG7MUtg/araxE+gZ56g7/xIVZXEunjf4CO6MtNp1M8gdflGmbmk51AxJ3wDB9UroI0ouLWPgwwBxJSKBQl1njJlojevPaTXRoswjyFO9EOTOWdpHafpHQCMaK1IKC8YPxzq8FROGZuErqj9xaJmJPjIy0EImRUevs3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RDhnPcVb; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72ecb4d9a10so136487a34.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Jun 2025 13:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749067698; x=1749672498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0GflgBwk2Erquo5jED04z907LZDLKiN9eNZQrfhMtwM=;
        b=RDhnPcVb1xg72o/62ONhztNJPBp6BJg7unzdMVzRaSQl40SVsclJ+OPt2w0y/rAotk
         HEmTEmzILQXVL4nTjmLV9s+jjuIOxNsxj0YMtXL6XgKJkfblHc5oXDWO0PoijZTyKerO
         GeasyaQ+xERBXfTG/u+ihg/+G/7I2XbsnHGyaYTIlzd1XjnlvyTijrYqFKrTfZnRZKRU
         I+ajrlQUumP2kDH9XbcTBqLRlqeCj2XWsz89LlT1jkBrvtPir67lwNmea82lRgAzWrgN
         /YJbpzIv5SioY3ltvSzH34srKL6EZlerVQ/IUKrGcH5XaXaOboI5D9PRwjpU2oQ7tSKS
         Kvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749067698; x=1749672498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GflgBwk2Erquo5jED04z907LZDLKiN9eNZQrfhMtwM=;
        b=mKxGB/M1gaqS25+13/c7XPeb1cotk39NYeOysKAxVbSpztJx7pTEVZ5kx1QsapY+UC
         iHQKIhLv0JU7tVjJ7VVltoziAhIzox0mb7uHzOP3JqdYOzePxyS/Q/rBmyuPW9Pz+PA6
         iWaz71hgmmaMlAU8GBo4EqrMuHYmZAj+snN39UAIX/dL7SetXI/X5Q1exXz4tU+tZnzx
         ZXi4GcOGZCV+3BIRJmnU/pmZNEPzzKEZECxBjxIy6zWd0Ohxzn0hXOLky5RPx0PSMrWM
         RaqrilMOwlNrSWiAC/5ztcMK9kX0y+YVpdcF82rRrWLAmT1qVM4zG1NQCmML1PpIJdVM
         r/8A==
X-Forwarded-Encrypted: i=1; AJvYcCV7i+B1gx8A+/y3p7CkQRNnL1QepIH/F7syeoJaMmFpn7NjhRIKOGBd8g33Axd4ugRl+9GrDCgEfwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEcNFfhVRXQ5zklSE5850wWVEQ68D/QEOHn2/WF7ExLIDO9whp
	gRNxLs5svLQB3BWqnuQP4Yo/BrwsxKHn2EKYPmSX1cYgjht5NCbN2eVIA3jG2PRWjt4=
X-Gm-Gg: ASbGncuBI1jBSoT2kuvPq1A1rgvRwocmFFzkI6qp+KXmJo9eOq2JDJI/EVboSDPN6K8
	EqQefIUSW7NxxMvhkCildqoQrhs+ktuVL9FX28EIY09T3WgNhwGYavMcEqTfJm0moYtzULsBNIu
	7TfxcBlscfYoK84hIlITP/oZhvpgZPBTBvqqpdvmIqqmurcAYT9/8lMn0rkv3eaj5x0ckTtmEcp
	1Ue0KGreTaIRkvE6nuk2cccpOfXa07lhCyrpn0QXgBAobjxxcda64WyLyIJfyi01+tnawfR6Grj
	XOXImD6EjyWrDwtHZKflxzzQLDNTR1y5mL1pB+GVsuIlIyy8JLG3mvTrwM6Gqy5wASfy0s4rVoI
	x71A3TdSH51NH9+cJ2x6n458geA==
X-Google-Smtp-Source: AGHT+IF0A9E9JcoP0NaXp+49IGKBNN/o1YoH+RW3ZA4P/jSh9TsURsmLa7tjhJk/OQ0OgontXEwQfA==
X-Received: by 2002:a05:6808:11d1:b0:404:e2fe:ee91 with SMTP id 5614622812f47-408f0eadd95mr3375166b6e.8.1749067698218;
        Wed, 04 Jun 2025 13:08:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:829:fdd0:311c:c481? ([2600:8803:e7e4:1d00:829:fdd0:311c:c481])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af82d2dbsm2363213a34.7.2025.06.04.13.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 13:08:17 -0700 (PDT)
Message-ID: <eeef8217-f6d1-40ad-839e-2e0efe3b7d01@baylibre.com>
Date: Wed, 4 Jun 2025 15:08:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] dt-bindings: iio: adc: add ad7405
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
 <20250604133413.1528693-5-pop.ioan-daniel@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250604133413.1528693-5-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/25 8:34 AM, Pop Ioan Daniel wrote:
> Add devicetree bindings for ad7405/adum770x family.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> no changes in v6.

In previous reviews, it was requested to keep the full changelog
of all versions here. This advice applies to all patches in
all series. It makes it easier for reviewers so that we don't
have to go looking at 5 different revisions on lore to remind
us what the history was.

...

> +examples:
> +  - |
> +    adc {
> +        compatible = "adi,ad7405";
> +        clocks = <&axi_clk_gen 0>;
> +        vdd1-supply = <&vdd1>;
> +        vdd2-supply = <&vdd2>;
> +        io-backends = <&axi_adc>;

Changing this one line from :

        io-backends = <&iio_backend>;

is not really a significant change, so Krzysztof's review tag should
have been kept and would have saved him some time in making additional
reviews.

> +    };
> +...


