Return-Path: <linux-iio+bounces-7964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7690193DF4A
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 14:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F7E1C21059
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565935FB8A;
	Sat, 27 Jul 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo4o49cw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7694A15;
	Sat, 27 Jul 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722083432; cv=none; b=bHcZvgbgBZFJQOpFyU+K4+4hZiMVPOfAox4PjQT+agP+jmHOr23T5r9illfcNuATvMVZVFekqp3CqlLqukYeLv2bfa3P+CR29ivvECjZ4L7PVEmPMefCBdjBCXVG/He+ijYziWNMx7tgkxBl42TNqAdrZhm2YQ7Whn82K4jueUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722083432; c=relaxed/simple;
	bh=FqBiBOl7Q53oVju+s4sVXZtFbMswCe+PP/aJi56w4l0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hb7/Xx9K6+eYizgTFMfMLR0pqYVcwwM8ZlaSPO6GErV9KLzUnSoOS7BLyM8Sx1vPMFL98Tcz/SbaDaWpq2X2IuEK4sahbK7pGEZoZp6XAgNZTisxMrVlFTiXfq0qs3NE6WshwmjYGfWGjLoyY+qwrZEMq0IwO5Cxjzqu5shZ50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo4o49cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA460C32781;
	Sat, 27 Jul 2024 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722083431;
	bh=FqBiBOl7Q53oVju+s4sVXZtFbMswCe+PP/aJi56w4l0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xo4o49cw9RaDQWFY94aK3GPbicQ6qK0/R9o0acI/M/i4ZfNhtVqt4LBMp9iA4I8jW
	 dgbLpRbY6BjMCxt7DP6CisxR6gQSMJpkGd60eNe8WVd/911F2VRlD8fLew7KfPa29t
	 JzIuzRLAtK/NTROse1ha18LEHZwU0gCrK7pOcF4bN5cyG68z0Y2Kr6fi7KOalqLNr+
	 J/bSy2C+ZUAOnPg9mvv1HOaq9xgNdE060V8qiiRJ21IglLIsQu6VujWE/vblBayB8q
	 JHO4xEr5Wa1ys80PuOGomTMEwSrWjSXLrUGU28QYIeGHbNROqrUy36Frwc5Ej1g4lm
	 J3A2hCebBTraw==
Date: Sat, 27 Jul 2024 13:30:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Dragos Bogdan <dragos.bogdan@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adf4377: add adf4378 support
Message-ID: <20240727133024.4cf167ef@jic23-huawei>
In-Reply-To: <20240722-legibly-senator-db5651fb279b@spud>
References: <20240722134508.25234-1-antoniu.miclaus@analog.com>
	<20240722-legibly-senator-db5651fb279b@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 17:26:37 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Jul 22, 2024 at 04:45:05PM +0300, Antoniu Miclaus wrote:
> > Add porperty conditions for the adf4378.

property

> > Add product link for the adf4378.  
> 
> I can see this from the diff. You need to explain /why/ this gpio is not
> valid for use on this device.
> 
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > changes in v2:
> >  - use property conditions for clk2 gpio
> > Note: the compatible is already available from the firs iteration of the driver
> > where these particularities weren't available for adf4378
> >  .../devicetree/bindings/iio/frequency/adi,adf4377.yaml | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> > index aa6a3193b4e0..5f950ee9aec7 100644
> > --- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> > +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> > @@ -17,6 +17,7 @@ description: |
> >     applications.
> >  
> >     https://www.analog.com/en/products/adf4377.html
> > +   https://www.analog.com/en/products/adf4378.html
> >  
> >  properties:
> >    compatible:
> > @@ -73,6 +74,15 @@ required:
> >  
> >  allOf:
> >    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - adi,adf4378
> > +    then:
> > +      properties:
> > +        clk2-enable-gpios: false
> >  
> >  unevaluatedProperties: false
> >  
> > -- 
> > 2.45.2
> >   


