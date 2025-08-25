Return-Path: <linux-iio+bounces-23201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB1B33C1B
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A81C44E0547
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0562D9EC8;
	Mon, 25 Aug 2025 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1aQsC9I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95CD2D3ECC;
	Mon, 25 Aug 2025 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116292; cv=none; b=dPp0pLM/Cuay4lHfKGb12zCBnFvGi+v1sMRWAjju52Aiux/3ivk62Sps+eE5Ntn/DUnnuvpQKQ3mCT3xu6lMTgkY5xx9vrmlloM1vwwQDsHTxelVYq4Urs0YJUFiijFx1MiClUdW7qKrCGVoknddodmQV7Fi2TZ9NWbSdAe5t44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116292; c=relaxed/simple;
	bh=DuY+u8DvkBY4wvmqsXABPJ2FIxL0+/NOnDCIm2kANDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isBHPMUCtiMYXuI2hsICpkgP5I3jMezahKygADcW3aI6mgCXU5zv6h09WxygSw73F9rTpvvFR65cTM3AkLbv0mlKJWQHIKzMFUocg29xrP/DlyUdYq3a1nowODhWwiPhPEWEv9kp6kpCApJi1wvyyc3XlHxl0zKaALU13sraMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1aQsC9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC842C4CEED;
	Mon, 25 Aug 2025 10:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756116291;
	bh=DuY+u8DvkBY4wvmqsXABPJ2FIxL0+/NOnDCIm2kANDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X1aQsC9IVnNEPd1rNOYpGwyToeqgmIAtNcbKr1L1sVuXdbDdVW613rkUkVxDh4z5E
	 DPu7wvFVCiCd9A4AUz5B7MmvKaA0EQoCSDOgoXv0isJI9eQcLXfWmUiFoy8wqUhGyD
	 hl3/qVg5uGarWYFzpxOTLx58Kkuo5kvzUNr4erYKVchYub/P+xSwKgwOx2y1qDQ/2o
	 oEvPjp9UdlDQcb0aN9DqEYGrwtaVCHj+ejiNXiVcdbK9cPDVJZz7G6Kmovgaya7dQG
	 fja/qqO34mJ0RZ3A/0WjBM1JJsfp7TqLujmRTAHVZXMYMbZ227x2b3v6Jk4NUDXIp9
	 bsXwgSrzCvJQw==
Date: Mon, 25 Aug 2025 11:04:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: iio: adc: max1238: Add
 #io-channel-cells property
Message-ID: <20250825110441.5b8df18a@jic23-huawei>
In-Reply-To: <20250819-astronomy-gladiator-21823768723a@spud>
References: <20250818200014.3700738-1-Frank.Li@nxp.com>
	<20250819-astronomy-gladiator-21823768723a@spud>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 19:12:10 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Aug 18, 2025 at 04:00:13PM -0400, Frank Li wrote:
> > Add #io-channel-cells property because it is multi-channel ADC.  
> 
> As far as I understand it, that's not a correct statement. A single
> channel ADC can have the property, but it would be set to 0 just as a
> single clock provider has #clock-cells of 0.
> 
> I did check the devices and they do all appear to be multichannel (not
> just the 1238) so the change you're making here looks correct, unless
> some of them would actually require 2 cells for some reason - but you
> should really state that in your commit message when there's about 30
> compatibles so that I don't have to check them.
> 
> With an accurate commit message,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Maybe Jonathan is willing to do that since it's just adding "of 1" to
> the first sentence.
> 
I changed it to say 'with a constant value of 1' to leave the gap
for other values on other devices that you are pointing out.

Applied, thanks.
> > 
> > Fix below CHECK_DTBS warnings:
> >   arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: adc@35 (maxim,max1239): '#io-channel-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
> > 	from schema $id: http://devicetree.org/schemas/iio/adc/maxim,max1238.yaml#
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
> > index 60d7b34e3286f..ae3c89393f1a3 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1238.yaml
> > @@ -53,6 +53,9 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> >    vcc-supply: true
> >    vref-supply:
> >      description: Optional external reference.  If not supplied, internal
> > -- 
> > 2.34.1
> >   


