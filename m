Return-Path: <linux-iio+bounces-5404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4938D1F02
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C35D1C22668
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5616E16FF37;
	Tue, 28 May 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCOWIxZL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18C16F90B;
	Tue, 28 May 2024 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907156; cv=none; b=dDT9WszCW6PG2Vr1aY+E3XXTs/shX1YBt2PV55UdvQxdNBDc5dAhlXm9ouAqQ86t13mvaBL1JP1Vpx3v0Bin6lrXBiNag6tcnwi96NLpEHZWWcI4aecgBhCAigXv/nfAUvpR9CxHFqbIzWYA6v//yaSyDnSnlKZ6iuY1jr/9K0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907156; c=relaxed/simple;
	bh=BiAwdmmi1ES+ggntiOhZUCQzZ3ZPOkkX5GoiWqc7GMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beLcXZQ1ZbCqpVhUc5WEWbSajwOAPbIfq9yn7fOBhvvckVywJ8jfgmfKjaAiWF35xw7AxLOSEluwI7AlX83Mhi277ACMuuR1VuYWxC0fFBedScbZGfnUUqcHyHA2GRIrqVT0nzUrdI8AUWCPQBtXjGwObl82oFUxnHLSdPQy028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCOWIxZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624BAC3277B;
	Tue, 28 May 2024 14:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716907155;
	bh=BiAwdmmi1ES+ggntiOhZUCQzZ3ZPOkkX5GoiWqc7GMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCOWIxZLGZN5Ke4/ZZd3Vhw6KkP1ZYz3OSfD2Aq6qYyGeWBEsg9ubAz8aMQVSUQAk
	 5Ej5YVSfVl7UWYqNb6mqNHN/PIvKXjrsFIT+GiXDOzSVV8YszDns6HbozmwDHkeCHV
	 mIIb0IcO7cXGaXPNiDTVwNfrRN54vWwHofNYePHFGdynKnhU5ZUFb2kXhU/DHadqdf
	 eohmAY+T/xWMWsENUJjhRJnFMI3Q9p0cDjwq7axFSt2IcCLNdKESiiCwCeC+yhz9Bp
	 ue99dju5CXHRjLlbF6SDG+anphtMg8B+rCTNLTmGNn+IiA2yesPTiwZD6959gGUts7
	 Sc+loxeKwni1Q==
Date: Tue, 28 May 2024 09:39:14 -0500
From: Rob Herring <robh@kernel.org>
To: Arthur Becker <arthur.becker@sentec.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Message-ID: <20240528143914.GA139191-robh@kernel.org>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
 <20240527-veml6040-v3-2-6f3bbfd42960@sentec.com>
 <e47de936-8cb4-4cef-a346-74835767e203@kernel.org>
 <ZR1P278MB111779FE0C84DB465C54EEFF81F12@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR1P278MB111779FE0C84DB465C54EEFF81F12@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>

On Tue, May 28, 2024 at 07:23:03AM +0000, Arthur Becker wrote:
> Thanks for the Review!
> Right, I wasn't sure if and how to add the veml6040 to the veml6075 dt-binding file.
> I'll modify that the next time I make adjustments to the driver.

Please don't top post, quote replies correctly, and fix your mail setup 
to not add 'EXTERNAL' to the subject.

Rob

> 
> Kind regards,
> Arthur
> 
> ________________________________________
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 27 May 2024 18:31
> To: Arthur Becker; Jonathan Cameron; Lars-Peter Clausen; Rob Herring; Krzysztof Kozlowski; Conor Dooley
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; devicetree@vger.kernel.org
> Subject: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add VEML6040 RGBW-LS bindings


> 
> On 27/05/2024 17:12, Arthur Becker via B4 Relay wrote:
> > From: Arthur Becker <arthur.becker@sentec.com>
> >
> > Device tree bindings for the vishay VEML6040 RGBW light sensor iio
> > driver
> >
> > Signed-off-by: Arthur Becker <arthur.becker@sentec.com>
> > ---
> > V1 -> V3: Addressed review comments (v1 of the dt-bindings was sent
> > along with v2 of the driver but not in a set)
> 
> It's basically the same as veml6075, so should be put there...
> 
> Eh,
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

