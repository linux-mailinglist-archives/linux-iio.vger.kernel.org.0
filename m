Return-Path: <linux-iio+bounces-13750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA58B9FA78D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 19:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CA9165A36
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 18:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7426E18C32C;
	Sun, 22 Dec 2024 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng0fQ7wg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7B768FD;
	Sun, 22 Dec 2024 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734891548; cv=none; b=Xi9UqXDcOZgxw0UCSk+Qvnl9WZ5Xh975xTbhNDCdpAlfo3WQzYd4Fla0LXv319Hkwms0IMWIjdmWKs7QLJa6XtMCx0AdEMP8cixR96bTWsJRPOgyvbfENkCWUG+kHPmOd1X5fPyzE0HnGMtIEhR0/JxIt6bJnW6PFxn/lh2ceAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734891548; c=relaxed/simple;
	bh=nPShwzNLb0XGqp9ehI2fIBZPA/HNeo/pEvvLHwKOXIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f70QUujHdZUzoXjmj03Uheeqe0O64WO55JFbs7QNMfqFMacSiiz5WW9Bl4m4TrdvHXlbRuM6nBnJ5yGVotap/nE5Pwo4dF8YaRjZ9dCeAIrrpMpPpTrBPEqVp6Z8Tva7dSlyqspbC8nxGksPdxbu08kUxMm49O52nm145vMcEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng0fQ7wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579A0C4CECD;
	Sun, 22 Dec 2024 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734891547;
	bh=nPShwzNLb0XGqp9ehI2fIBZPA/HNeo/pEvvLHwKOXIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ng0fQ7wgj0dv8NeWWaEhy7c2dufQR/yA6d52CLxO0JOGkHYLJ1PVSRrqJ6ZOar/ry
	 716H2JqPIKfpcD/l/FkPVtzomC7UfukBQHIXRtatg2gmEUfm3z9a/WCjdPFBom3Zz4
	 6h3BOZEQKt3svo6FCcMfw4IN4qlix//ujJFRc9zGpx+gqAGK2IRdYMzmOQUOq8ni/p
	 dpKFLSC3xyghrEherHC9zT8ReqYAZrFSZY/tQOXVVBFnGa7ULWNQJGCQYvyxNnnI3H
	 6J0bxm77QhRII6T7mMMKKbdZmSqlzL0loKuiiAoYVqENqxgcwBKyOjZpVqJKmpiu3E
	 cg3JWNQ5itNmQ==
Date: Sun, 22 Dec 2024 18:18:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 David Lechner <dlechner@baylibre.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: adc: add AD7191
Message-ID: <20241222181857.00b38e57@jic23-huawei>
In-Reply-To: <20241222-sequester-mounted-42c0db97611f@spud>
References: <20241221155926.81954-1-alisa.roman@analog.com>
	<20241221155926.81954-3-alisa.roman@analog.com>
	<20241222-sequester-mounted-42c0db97611f@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Dec 2024 14:48:08 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Sat, Dec 21, 2024 at 05:56:01PM +0200, Alisa-Dariana Roman wrote:
> > AD7191 is a pin-programmable, ultralow noise 24-bit sigma-delta ADC
> > designed for precision bridge sensor measurements. It features two
> > differential analog input channels, selectable output rates,
> > programmable gain, internal temperature sensor and simultaneous
> > 50Hz/60Hz rejection.
> > 
> > Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Maybe I'm over thinking things, but comments inline about possibility of
pinstrapping holding this device in a particular configuration, without
the GPIOS connected.

> > ---
> >  .../bindings/iio/adc/adi,ad7191.yaml          | 128 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 135 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> > new file mode 100644
> > index 000000000000..f3e596918c22
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> > @@ -0,0 +1,128 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2025 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7191.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD7191 ADC device driver
> > +
> > +maintainers:
> > +  - Alisa-Dariana Roman <alisa.roman@analog.com>
> > +
> > +description: |
> > +  Bindings for the Analog Devices AD7191 ADC device. Datasheet can be
> > +  found here:
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad7191
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-cpol: true
> > +
> > +  spi-cpha: true
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      Optionally, either a crystal can be attached externally between MCLK1 and
> > +      MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> > +      pin. If absent, internal 4.92MHz clock is used.  
> 
> Without clock-names, how do you tell the difference between driven ctal and
> the cmos-compatible clock? That CLKSEL's job?

Seems it's an unusual part and there is no config associated with whether we
have a clock or an xtal, so we probably don't need the name.

Related to that, in many cases I'd expect clksel to be tied to always
use the external clock or not (depending on whether one is connected)
not to be a gpio.  So you probably need to take that configuration into
account as well.

Similar may apply for the odr, and pga pins.  Sometimes people
hardwire those things.  There are examples in tree (I can't point at one
right now though) that deal with this. Fairly sure at least 1 ADI part
has a binding to handle that.  (the ad7606 does a bit of this as it needs
a particular pinstrap for sw-mode).

You should be fine with chan and temp always being GPIOs as it would be weird
to buy a part with the extra channels + temperature sensor and not wire it
to be useable.

> 
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  avdd-supply:
> > +    description: AVdd voltage supply
> > +
> > +  dvdd-supply:
> > +    description: DVdd voltage supply
> > +
> > +  vref-supply:
> > +    description: Vref voltage supply
> > +
> > +  odr1-gpios:
> > +    description: GPIO connected to ODR1 pin for output data rate selection
> > +    maxItems: 1
> > +
> > +  odr2-gpios:
> > +    description: GPIO connected to ODR2 pin for output data rate selection
> > +    maxItems: 1
> > +
> > +  pga1-gpios:
> > +    description: GPIO connected to PGA1 pin for gain selection
> > +    maxItems: 1
> > +
> > +  pga2-gpios:
> > +    description: GPIO connected to PGA2 pin for gain selection
> > +    maxItems: 1
> > +
> > +  temp-gpios:
> > +    description: GPIO connected to TEMP pin for temperature sensor enable
> > +    maxItems: 1
> > +
> > +  chan-gpios:
> > +    description: GPIO connected to CHAN pin for input channel selection
> > +    maxItems: 1
> > +
> > +  clksel-gpios:
> > +    description: GPIO connected to CLKSEL pin for clock source selection
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - avdd-supply
> > +  - dvdd-supply
> > +  - vref-supply
> > +  - spi-cpol
> > +  - spi-cpha  
> 
> > +  - odr1-gpios
> > +  - odr2-gpios
> > +  - pga1-gpios
> > +  - pga2-gpios  
> 
> For these 4, since all are required, seems like grouping as odr-pgios
> and pga-gpios would be a good idea?
Agreed except for the annoying option of pin strapping.  Maybe we ignore that
for now.  If it becomes a problem, we can add it safely as a driver predating
that will try to grab the gpios and fail if it sees a DT not providing them.
So will fail safe before we add pinstrapping.  Maybe we will never need to.

Jonathan




