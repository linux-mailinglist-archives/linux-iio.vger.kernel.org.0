Return-Path: <linux-iio+bounces-9301-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20653970347
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 19:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A42B21A97
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE715F330;
	Sat,  7 Sep 2024 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3uACKrh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B00134B1;
	Sat,  7 Sep 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725728562; cv=none; b=nqpnmYxu8UErcjCt5yl3GFe05sbfDMSKwh1TMdgvr/v9ZNf//kRb9dbvZYYUzgTX8hMTCafptCfqzhQYnYEdVKhQdv+9zUyBZgD09/CbyPbhGSFBc0Pg7WhmHrAK2tZz3bT2wK9tOd8PpFyyMKpq4eIoxJ0sssH6MM+SQPnNncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725728562; c=relaxed/simple;
	bh=u6Mcf2G/UtDhfG9F19/02cvhzAL2moivAo5JbQWdUjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cC+JIekE61rXXDWikKT7i8YM6jWfSMvYlEPYYILYaUKc97//C3/RGDKtsUjkrbmNWFpfnKvBfRNMyC9sA5veFpWfPs0/sZvNtCCzQ7+qp5g4fPXAjo3PCcobSpnjkTvOXtqSVypCvbi8Hr6CM2gcD3JaFzCB6tX6qQP5IEx+H3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3uACKrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FC4C4CEC2;
	Sat,  7 Sep 2024 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725728561;
	bh=u6Mcf2G/UtDhfG9F19/02cvhzAL2moivAo5JbQWdUjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F3uACKrhN9GA5HX9E40MrYEd924Ekodalev4mok5di1o7m5+DRaoO6D/+J/hV4JkN
	 tRQUI8ZYvNHma2fRx+xXksjV/WSS99VmX1+eib2P5TRwXJenDOOeYz1kbp42v07F05
	 dhFsa1kEx3KNbjJTIjKh7ifKOUGI5zrBGHeDBE7CLVgEpfeDzuRRBvegn4ZMqlhZ2Q
	 ZUt2r7Dpr3ZVtpPDv3yRDDpFq8h2b8lM6LEjQdN1+mSQgcsjdXhziVpChE5xeRthSA
	 x1NUUrm7+1mt1R43PvB/W41DPcLE8e6zgvxOQVLQEHzmUcURXIyssM3mVWVOU0Aco2
	 eyCtVpc7kBuMQ==
Date: Sat, 7 Sep 2024 18:01:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mariel Tinaco <Mariel.Tinaco@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Conor Dooley <conor+dt@kernel.org>, Marcelo
 Schmitt <marcelo.schmitt1@gmail.com>, Dimitri Fedrau
 <dima.fedrau@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add docs for ad8460
Message-ID: <20240907180149.67fdc636@jic23-huawei>
In-Reply-To: <pp3r4ygrialun2x6vtghp27ianggjzs3g3436b6mi6mttfy57a@q7kcwolkkn27>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
	<20240904023040.23352-2-Mariel.Tinaco@analog.com>
	<pp3r4ygrialun2x6vtghp27ianggjzs3g3436b6mi6mttfy57a@q7kcwolkkn27>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 08:20:53 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Wed, Sep 04, 2024 at 10:30:39AM +0800, Mariel Tinaco wrote:
> > This adds the bindings documentation for the 14-bit  
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
> > High Voltage, High Current, Waveform Generator
> > Digital-to-Analog converter.
> > 
> > Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
> > ---
> >  .../bindings/iio/dac/adi,ad8460.yaml          | 154 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 161 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml  
> 
> > +  adi,range-microvolt:
> > +    description: Voltage output range specified as <minimum, maximum>
> > +    oneOf:  
> 
> This oneOf does not make sense. There is only one condition. Drop.
> 
> > +      - items:
> > +          - enum: [0, -10000000, -20000000, -30000000, -40000000, -55000000]
> > +          - enum: [10000000, 20000000, 30000000, 40000000, 55000000]  
> 
> What's the default? It's not a required property.
> 
> > +
> > +  adi,range-microamp:
> > +    description: Current output range specified as <minimum, maximum>
> > +    oneOf:
> > +      - items:
> > +          - enum: [-50000, -100000, -300000, -500000, -1000000]  
> 
> I don't understand why 0 is not listed here.

I'm not sure why it is a list at all. Seems like the hardware
allows a continuous value so this should just specify max and min.

> 
> > +          - enum: [50000, 100000, 300000, 500000, 1000000]
> > +      - items:
> > +          - const: 0
> > +          - enum: [50000, 100000, 300000, 500000, 1000000]
> > +  
> 
> What's the default? It's not a required property.
> 
> > +  adi,max-millicelsius:
> > +    description: Overtemperature threshold
> > +    default: 50000
> > +    minimum: 20000
> > +    maximum: 150000
> > +
> > +  shutdown-reset-gpios:
> > +    description: Corresponds to SDN_RESET pin. To exit shutdown
> > +      or sleep mode, pulse SDN_RESET HIGH, then leave LOW.
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description: Manual Power On Reset (POR). Pull this GPIO pin
> > +      LOW and then HIGH to reset all digital registers to default
> > +    maxItems: 1
> > +
> > +  shutdown-gpios:
> > +    description: Corresponds to SDN_IO pin. Shutdown may be
> > +      initiated by the user, by pulsing SDN_IO high. To exit shutdown,
> > +      pulse SDN_IO low, then float.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks  
> 
> Some supplies are for sure required. Devices rarely can operate without
> power provided.
> 
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +additionalProperties: false  
> 
> unevaluatedProperties instead.
> 
> Best regards,
> Krzysztof
> 


