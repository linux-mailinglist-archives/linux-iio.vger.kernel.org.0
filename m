Return-Path: <linux-iio+bounces-12617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B552E9D77EE
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 20:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9BDB2295E
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BB214A088;
	Sun, 24 Nov 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeJ/ALGp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237312C697;
	Sun, 24 Nov 2024 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732476383; cv=none; b=I4PSwIYF/TCD00OgCrvqnisrwsH1wrxlQoisgGwtbXdZpe9ZG1gjCKg/qe30DuUbOviZsangjDkYkiwmURZda1TTVS3wUeaS5rqvqpZNnKQjKSwZC3Zkz3tDU9RQ3fvy2LOnZjPT4ktxHz1hPn0LL2/9Cx0CmkMrI7K6vikfDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732476383; c=relaxed/simple;
	bh=Hs7mwef/vM8phP0Ra+JZ/7GqKz2z11EjIq7Ka5WggQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQWpY20KJhnAd65kWepl53tjNaLySguMW/lTQI6YNGXIB+GkHfHEWcB1eO4yUHSjAhMxNj69HWlVSdtklUdtWg8VAXT2apf47sIvX6xSNR0tDSgpWwLbSDnArA6jEnWLITwvu8RuwnP4pSH5EDozT2ZmkOkaHojUGmtZbQOU3Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeJ/ALGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D13C4CECC;
	Sun, 24 Nov 2024 19:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732476382;
	bh=Hs7mwef/vM8phP0Ra+JZ/7GqKz2z11EjIq7Ka5WggQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IeJ/ALGpe0ZJVAiV7wQ70r8KJ8NA884ngw5wX3BMW3xhdDoO22P1MVSmu8G3+Hq8m
	 E0kk8WH2hgalNBXtgpTz3VllRLtqn7hr1KWWCjPEcccHTx2UNK7q8il5bu6P80kyMf
	 zIMyAH0f8BDetlEq01cZwZv+pG9i0rydj9D0YpwQX2TgGLI3pQncGO2R/T73ZQ+JiW
	 JRXFOS0kWAL+p6RHR6boislmAoPpkP7wLdMsF9wOLN/OfT6ZN/osbWqZMOpzK4Mvdk
	 2Y1lkKl79PBWtAreUor81UtRnFcn0sJn0ZuCDW6Tz4zFGP9vtDcKzxOrycHrIklIZ5
	 LVhSxm49gzW/g==
Date: Sun, 24 Nov 2024 19:26:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mgonellabolduc@dimonoff.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Mikael Gonella-Bolduc
 <m.gonella.bolduc@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <20241124192611.3b74915b@jic23-huawei>
In-Reply-To: <63e8c591-023d-4f50-abe1-d6a85fd3044b@kernel.org>
References: <20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com>
	<20241119-apds9160-driver-v1-1-fa00675b4ea4@dimonoff.com>
	<63e8c591-023d-4f50-abe1-d6a85fd3044b@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 18:22:43 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 19/11/2024 21:36, Mikael Gonella-Bolduc via B4 Relay wrote:
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +
> > +additionalProperties: false  
> 
> This goes after required:
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg  
> 
> Supply not required?

Just for background on this.  Linux will happily provide
you a stub regulator if the supply is not in dt, but we decided a while ago
that it was more accurate to have the supplies as required properties as that
would allow us to distinguish between those that are needed for operation
and those that are actually optional like reference voltages where there
is the option of an on chip reference if the external one isn't connected.

So almost certainly just make it required here.

Jonathan

> 
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        apds9160@53 {  
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
> > +          compatible = "broadmobi,apds9160";  
> 
> Use 4 spaces for example indentation. Or at least something consistent.
> 
> 
> Best regards,
> Krzysztof
> 


