Return-Path: <linux-iio+bounces-27720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D80CD1D625
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3294430090C7
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA6C3806B3;
	Wed, 14 Jan 2026 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvd9BtOQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FFE354AEC;
	Wed, 14 Jan 2026 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381834; cv=none; b=JG8oyxACr5V1/foSKWB8JBtoTZHWNtd1ushn4C+ngMEUf44m4AiZweEtohKYFIclwoGlidrJ4aixnp9IEJrvhrv+uwssnJpDnelA71b1rh5ZBxCAq5J+Bp52DefDc0OcPs2c+7yPtOm+L8+ZEhjXL7OyAF0Dokvvx/92xpvOmyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381834; c=relaxed/simple;
	bh=FqQYIhi1gEHPr0Al0KQJ5kpiMUVkj4Z6T+IkvCgJlHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0ML+KdPehcE//g+e0RIci+0S/30LaBC2TguMzIFQGgZYxZgLjrjfwc7i7A2XBzkMS/hAirTYQ50QCs/l8hzLU2tKUkFlCAjp7qC/Q+FzTIMW8FyIdFeAXCi7vD1gxYAzuG/JJRBuc6zMg3JvEorIEXTY73NUfOrNwEKzXUGj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvd9BtOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E25C19423;
	Wed, 14 Jan 2026 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768381833;
	bh=FqQYIhi1gEHPr0Al0KQJ5kpiMUVkj4Z6T+IkvCgJlHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xvd9BtOQib5sDzf5hysV51eR5b9p045kAeSvXaz0VhtzXejh63hWNwqib9O4wo2xh
	 kIJmGiqkH5/eg0n7CgK/7c0dgq3ijCeF7KtrLE5SSZCyUsgtfV1oWaQIOeS/jAchGM
	 mBBRNz2afbtlUED3p1aOIix5jUsrR+i7gY9zCrqyw6x5DXJ53BWbJ4oSq/t0W2bK7/
	 ykiZw2ihAeje/aNTaKj1mAsgrc/auMuoeEXNY34Tnxf+pq8Ma/KxLHx2KAs9Bn1kE0
	 gZj6TNxqGbmRHRQsyEGCSuN4kNPm7CzdUNgcr3uEaXgfYKoiQJTg6Zrdadp8cvnVnL
	 jDE4F6C5YnZ/Q==
Date: Wed, 14 Jan 2026 09:10:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Sean Anderson
 <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 5/9] spi: Documentation: add page on multi-lane
 support
Message-ID: <20260114091024.390432c0@jic23-huawei>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-5-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
	<20260112-spi-add-multi-bus-support-v5-5-295f4f09f6ba@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 11:45:23 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add a new page to Documentation/spi/ describing how multi-lane SPI
> support works. This is uncommon functionality so it deserves its own
> documentation page.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Hi David,

A few things inline.

> diff --git a/Documentation/spi/multiple-data-lanes.rst b/Documentation/spi/multiple-data-lanes.rst
> new file mode 100644
> index 000000000000..96d6997ecf77
> --- /dev/null
> +++ b/Documentation/spi/multiple-data-lanes.rst

...

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

Wrong properties.  They are those sizes but spi-tx-lane-map and spi-rx-lane-map

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

Whilst simple I'd kind of expect a multi lane case as the example, or this and
the multilane one? For me the comment that follows is sufficient for the 1 lane
offset case you have here.

> +            ...
> +        };
> +    };
> +
> +
> +The default values of ``spi-rx-bus-width`` and ``spi-tx-bus-width`` are ``<1>``,
> +so these properties can still be omitted even when ``spi-rx-lane-map`` and
> +``spi-tx-lane-map`` are used.




