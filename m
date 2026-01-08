Return-Path: <linux-iio+bounces-27547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EE8D03464
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 15:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 726593179170
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB932378D77;
	Thu,  8 Jan 2026 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2c8qMWI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E11347BB8
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875942; cv=none; b=TNtb4W85FdmrOgQSL8lOjbFCpTIIVgPpaKNtBCNwSJ0AOBh+miNHyiDXlWKEeeLdf41V395aXMRPVRzWyUXzt9JvY5fpFvqZXcTP+PpZSsA4xKIOOvLvq3+vw76T1NsBuZMB9w8eeqxA94niIThBrVXHWLisi9fTvWPblQAx/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875942; c=relaxed/simple;
	bh=+Hxr4ZiZBnsK37sucsF9sUC3x17Hr3pQoHDvwweLQw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOr8zdypZeL25NOgSrNSMKlpe8D4qltIUB1zoSv45APJM4yg5BiLRw6SkbKG/LvGMu9QfpYZSEauWPBAB3hJkHU7xT79GENZyMUaInm330pXzf5PHMvVuWaxVCCdazrAeIh/Pt/H2MpUAbDZ39krFEX6z3Z8E5r35rPOTIBRlDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2c8qMWI; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-55b0af02ddeso521017e0c.3
        for <linux-iio@vger.kernel.org>; Thu, 08 Jan 2026 04:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767875939; x=1768480739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+iEE6Un0IiGnjVPgG1bXjl9grqm8623VhHGBXWZZQ/w=;
        b=L2c8qMWIpZ4YE9Uq4klevuqCYYMfApJCbw8qwf2RQT4FooUGjAsSfWOOZ+f5KlZZfn
         qM9rRl64ZFQkWgS8TDE4A8quMslcv7RarAtxJYwevRn3EOt4g19cI4Cvq8Myn98BQVlC
         5xnssOV8wbRDyuBfZT1ASDCnrD1Yk5uD4gtCoGFd1gpyJMbczdcHUoYaszAGejRG2+TZ
         STXfswc2y/kOgTgJYtqasKRko5mDIfF3jTnl+H6/gWLUTiEkQlaFgMBRK4osD+QLtUeh
         g7+nTqhv4aD6CDEoeZ2ONL7T7ke9y7580AY3Y4EM/8uvgkwkQfYj0ktzNjYNISwPvXy2
         tDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767875939; x=1768480739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iEE6Un0IiGnjVPgG1bXjl9grqm8623VhHGBXWZZQ/w=;
        b=f5/+cMJg6X8K3j6rUjzweJH86Qld+faT4zy0ml6hxtjQ9rippg+vtKC9kO8ACj7Rqy
         mPyHpQgr+j9lnVnzP+gna7YWwDznKi2kY+puu1VGqLGDQmDJ0XVooWldzNZX+3JAKpLm
         qlEXG65KgtF26wlCcxn5Sae7vxae4S7U/C7K49PcKEmf7MMbCpjQ6KHDoYtkcnEW3F4v
         J0232oVxh+TDnPCXMhPd50X+AdXYHAwzXbDRQc0PRl0k2vQUP+Cx3CgHzZvXzEbApQJi
         ihf4a+cWqFDDLhSsqHIJvtpNQSBarljpccMzHFgAkHbOOmzJB/nP6h7aCqroqSNSyL/U
         1c5g==
X-Forwarded-Encrypted: i=1; AJvYcCX0lH5yV4XYiDPxyZpj2JoeGyeUvAXOvC80n8irim8mb0N4IVagHMCJGADNnmpRJHzFhgiLxkde/vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAxan9obMESHP/Zb1OOAURN3hPUbQ9FGP4dCrz6wt+ujAxLK6
	6WDcWJJJmeT1N5oXSGIgGK9mEqlZxpKALGOXivVCpTYihIqPbJQWhU/M
X-Gm-Gg: AY/fxX7TcgWxDdKx0yctfxOGjbA+zL5d/CArav0tidd29PTSYtePjic+fBUE6Hi++WU
	6O8xudWbsB+TBFnXB/dr8hChs0LAA78ENztPXTRw0MA8Y7ZUad2Nh0+BwjcT91Y3aW1IBVFkGa8
	8tQi5DDc5eqHFkb+io31E3GE2yF0popxSjlQ2mdxdWQ5RZT7M4ns8pfk9Kv44ZP1S3K7K0YWLUb
	BgEcVkUmfWDtmnng+fX70vn/bxNb7em88smPoyzVKr0Y/T3SR8egCaQVh3CBa7PSrfZrCY9pErr
	e95O38bgNqRKWjj/0ZuF+nAR3uXFDdQjKlvYTE2F3alJ6m0TP6uYMzLjjz1qgIiai/rRlkSDEP8
	so16VwHTPZ3X1lAjOdCiOBPPD6mhemjRtTS/o6S55rrNZwpBxoN/+pHmq3aNIrGMc0Z+nu69FJA
	UtsL/pS02qJObKDwn2kV4=
X-Google-Smtp-Source: AGHT+IEJZWHmh83mvzjHNX9jMW2jbT1DkYtWCUqXUYAhY01+DHpkl4E6/Inn6+oVCICuzwZk7UrX/w==
X-Received: by 2002:a05:6102:6f07:b0:5ed:c98:37f1 with SMTP id ada2fe7eead31-5ed0c983b52mr1285108137.1.1767875939450;
        Thu, 08 Jan 2026 04:38:59 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124a3386sm5633984241.11.2026.01.08.04.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 04:38:58 -0800 (PST)
Date: Thu, 8 Jan 2026 09:40:44 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 5/9] spi: Documentation: add page on multi-lane support
Message-ID: <aV-lzD1BEVSkGjba@debian-BULLSEYE-live-builder-AMD64>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-5-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-5-145dc5204cd8@baylibre.com>

Hi David,

Thanks for adding a doc for the multi-lane stuff.
Two minor comments inline.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

On 12/19, David Lechner wrote:
> Add a new page to Documentation/spi/ describing how multi-lane SPI
> support works. This is uncommon functionality so it deserves its own
> documentation page.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> v4 changes:
> * New patch in v4.
> ---
>  Documentation/spi/index.rst               |   1 +
>  Documentation/spi/multiple-data-lanes.rst | 217 ++++++++++++++++++++++++++++++
>  2 files changed, 218 insertions(+)
> 
> diff --git a/Documentation/spi/index.rst b/Documentation/spi/index.rst
> index 824ce42ed4f0..2c89b1ee39e2 100644
> --- a/Documentation/spi/index.rst
> +++ b/Documentation/spi/index.rst
> @@ -9,6 +9,7 @@ Serial Peripheral Interface (SPI)
>  
>     spi-summary
>     spidev
> +   multiple-data-lanes
>     butterfly
>     spi-lm70llp
>     spi-sc18is602
> diff --git a/Documentation/spi/multiple-data-lanes.rst b/Documentation/spi/multiple-data-lanes.rst
> new file mode 100644
> index 000000000000..b267f31f0bc8
> --- /dev/null
> +++ b/Documentation/spi/multiple-data-lanes.rst
> @@ -0,0 +1,217 @@
> +====================================
> +SPI devices with multiple data lanes
> +====================================
> +
> +Some specialized SPI controllers and peripherals support multiple data lanes
> +that allow reading more than one word at a time in parallel. This is different
> +from dual/quad/octal SPI where multiple bits of a single word are transferred
> +simultaneously.
> +
> +For example, controllers that support parallel flash memories have this feature
> +as do some simultaneous-sampling ADCs where each channel has its own data lane.
> +
> +---------------------
> +Describing the wiring
> +---------------------
> +
> +The ``spi-tx-bus-width`` and ``spi-rx-bus-width`` properties in the devicetree
> +are used to describe how many data lanes are connected between the controller
> +and how wide each lane is. The number of items in the array indicates how many
> +lanes there are, and the value of each item indicates how many bits wide that
> +lane is.
> +
> +For example, a dual-simultaneous-sampling ADC with two 4-bit lanes might be
> +wired up like this::
At first, I thought calling these '4-bit lanes' was a bit confusing. I was
thinking about suggesting '4-wire lanes' but I guess 4-bit is more generic in
case we ever see a setup where data navigates through something besides wires.

> +
> +    +--------------+    +----------+
> +    | SPI          |    | AD4630   |
> +    | Controller   |    | ADC      |
> +    |              |    |          |
> +    |          CS0 |--->| CS       |
> +    |          SCK |--->| SCK      |
> +    |          SDO |--->| SDI      |
> +    |              |    |          |
> +    |        SDIA0 |<---| SDOA0    |
> +    |        SDIA1 |<---| SDOA1    |
> +    |        SDIA2 |<---| SDOA2    |
> +    |        SDIA3 |<---| SDOA3    |
> +    |              |    |          |
> +    |        SDIB0 |<---| SDOB0    |
> +    |        SDIB1 |<---| SDOB1    |
> +    |        SDIB2 |<---| SDOB2    |
> +    |        SDIB3 |<---| SDOB3    |
> +    |              |    |          |
> +    +--------------+    +----------+
> +
> +It is described in a devicetree like this::
> +
> +    spi {
> +        compatible = "my,spi-controller";
> +
> +        ...
> +
> +        adc@0 {
> +            compatible = "adi,ad4630";
> +            reg = <0>;
> +            ...
> +            spi-rx-bus-width = <4>, <4>; /* 2 lanes of 4 bits each */
> +            ...
> +        };
> +    };
> +
> +In most cases, lanes will be wired up symmetrically (A to A, B to B, etc). If
> +this isn't the case, extra ``spi-rx-bus-width`` and ``spi-tx-bus-width``
> +properties are needed to provide a mapping between controller lanes and the
> +physical lane wires.
> +
> +Here is an example where a multi-lane SPI controller has each lane wired to
> +separate single-lane peripherals::
> +
> +    +--------------+    +----------+
> +    | SPI          |    | Thing 1  |
> +    | Controller   |    |          |
> +    |              |    |          |
> +    |          CS0 |--->| CS       |
> +    |         SDO0 |--->| SDI      |
> +    |         SDI0 |<---| SDO      |
> +    |        SCLK0 |--->| SCLK     |
> +    |              |    |          |
> +    |              |    +----------+
> +    |              |
> +    |              |    +----------+
> +    |              |    | Thing 2  |
> +    |              |    |          |
> +    |          CS1 |--->| CS       |
> +    |         SDO1 |--->| SDI      |
> +    |         SDI1 |<---| SDO      |
> +    |        SCLK1 |--->| SCLK     |
> +    |              |    |          |
> +    +--------------+    +----------+
> +
> +This is described in a devicetree like this::
> +
> +    spi {
> +        compatible = "my,spi-controller";
> +
> +        ...
> +
> +        thing1@0 {
> +            compatible = "my,thing1";
> +            reg = <0>;
> +            ...
> +        };
> +
> +        thing2@1 {
> +            compatible = "my,thing2";
> +            reg = <1>;
> +            ...
> +            spi-tx-lane-map = <1>; /* lane 0 is not used, lane 1 is used for tx wire */
> +            spi-rx-lane-map = <1>; /* lane 0 is not used, lane 1 is used for rx wire */
In this example, even though lane 0 is not used by thing2, it is being used by
thing1, right?
Just checking I understand it correctly.

> +            ...
> +        };
> +    };
> +

