Return-Path: <linux-iio+bounces-6290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AFC9097DC
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 13:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2631F22000
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 11:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC87F3A27E;
	Sat, 15 Jun 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgkEHvpO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B6321A3;
	Sat, 15 Jun 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718449549; cv=none; b=HSTEQy0FdJHCzuctGyDoaHdu5s5bgE50u85PJW9h6XYvTb5TKaJPJX6LwuC434RQD5vJQMXg4FnEnRTap3NX0KkS2pgmRVwwtMtmEDiognyNUoM4Wv97QjXxwluNLNb8xUN4XzRYtp23LPn7HfdwO/WE+zPlLdXHcs00FaK3fMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718449549; c=relaxed/simple;
	bh=0LpWgpG86C91czNegUVAgchoLh1pUrCspvDDnRblZKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8KFP+p+qk6PIGFPMzqHy9/0P/J3n+5BgiH9LyFx4yN0zBReCUm6uv9W16i2wtnW7l0yyk7RLHQlqSW3HVNuGUWALxBdaiZjR9XHvLUqoJ7RwhlfqUkI9SSuR93riTSPA0+0HfOYbpAbK0I/EL0YdsIkzWI125BEZrtgsTg+hzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgkEHvpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C826AC32786;
	Sat, 15 Jun 2024 11:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718449549;
	bh=0LpWgpG86C91czNegUVAgchoLh1pUrCspvDDnRblZKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TgkEHvpOaTzD6Y6h4yDbzzLVnkigxCBmBLDWtApx37O6/fDobDC3znuh+I/iL2ZcK
	 5RYaFDmNKmvfuDa3HVaARyNDRycgL7Ljgh8sM13X//xvjj6Zj6GUkIqiIBubEof1m3
	 lsVBmIQkjAOllinjoRN0tgfWdlUh4e4mie9D5kNEppBG6MW7TuxhFaZ0Mzsj9jW52F
	 bkr/WLQYcIhORkwV7HVyhEVCjpKk6pLTZ3+Su0OnFH3OH9k9udIJbfRsPC8N++kTJm
	 /kScPuDgR3ojXi1zl7u9rIC2so3llcRhbtMf4R32xr2sUyfw7/onT3bHEwKujfHz29
	 fViSY3UjbHhIg==
Date: Sat, 15 Jun 2024 12:05:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexandru Tachici
 <alexandru.tachici@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: iio: adc: ad7192: Update clock
 config
Message-ID: <20240615120538.16e44f7b@jic23-huawei>
In-Reply-To: <20240613-vineyard-doing-87ada1b7a8ed@spud>
References: <20240613114001.270233-1-alisa.roman@analog.com>
	<20240613114001.270233-3-alisa.roman@analog.com>
	<20240613-vineyard-doing-87ada1b7a8ed@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 17:41:52 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Jun 13, 2024 at 02:39:58PM +0300, Alisa-Dariana Roman wrote:
> > There are actually 4 configuration modes of clock source for AD719X
> > devices. Either a crystal can be attached externally between MCLK1 and
> > MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> > pin. The other 2 modes make use of the 4.92MHz internal clock.
> > 
> > Add clock name xtal alongside mclk. When an external crystal is
> > attached, xtal should be chosen. When an external clock is used, mclk
> > should be chosen.  
> 
> This is still missing an explanation of why a new name is needed.
> Hint: do you need to change register settings to use one versus the
> other?

Absolutely - dt reviewer shouldn't need to look at the code to find this
out as it wastes their over subscribed time!

> 
> > 
> > The presence of an external clock source is optional, not required. When
> > absent, internal clock is used. Modify required property accordingly and
> > modify second example to showcase this.
> > 
> > Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7192.yaml    | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> > index a03da9489ed9..3ae2f860d24c 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> > @@ -39,11 +39,15 @@ properties:
> >  
> >    clocks:
> >      maxItems: 1
> > -    description: phandle to the master clock (mclk)
> > +    description: |
> > +      Optionally, either a crystal can be attached externally between MCLK1 and
> > +      MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> > +      pin. If absent, internal 4.92MHz clock is used.

Trivial but doesn't need to be formatted, so don't think the | matters.

> >  
> >    clock-names:
> > -    items:
> > -      - const: mclk
> > +    enum:
> > +      - xtal
> > +      - mclk
> >  
> >    interrupts:
> >      maxItems: 1
> > @@ -135,8 +139,6 @@ patternProperties:
> >  required:
> >    - compatible
> >    - reg
> > -  - clocks
> > -  - clock-names
> >    - interrupts
> >    - dvdd-supply
> >    - avdd-supply
> > @@ -202,8 +204,6 @@ examples:
> >              spi-max-frequency = <1000000>;
> >              spi-cpol;
> >              spi-cpha;
> > -            clocks = <&ad7192_mclk>;
> > -            clock-names = "mclk";

Why drop it from the example?  It's a valid setting to have one after all.

> >              interrupts = <25 0x2>;
> >              interrupt-parent = <&gpio>;
> >              aincom-supply = <&aincom>;
> > -- 
> > 2.34.1
> >   


