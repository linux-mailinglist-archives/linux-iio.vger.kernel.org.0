Return-Path: <linux-iio+bounces-394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808DC7F93AB
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 17:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD58B20E13
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3B7DDB3;
	Sun, 26 Nov 2023 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/6ayRWy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A03A4C;
	Sun, 26 Nov 2023 16:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19376C433C8;
	Sun, 26 Nov 2023 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701015070;
	bh=EIes0QYBLWnyo1edFguhHHx1rQ6YIR+TiuiW4pxPYnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N/6ayRWyob1tyiGTI7X1ERqWCz7P683fLVrM6QIGFACkbgTPObInODiFLKrbU5Dbp
	 IEwccSGD/o0YDGU+GeaaYk5w43C8OMf2ElBTAhRDdtv/xo1/vYEZWVqEP8W/QEtEJF
	 YJ66lR+Vi2Ns93iCyeyS6CvjYRiV02mwo8LM81COi6Uv56aVZ1bOquBOkOElrphURJ
	 0K3IfNpD//GjaT3NAzCdQT3pJSu3M5aJP1IwjE1A6eq+XKve/6/5ntyjvZ8fgdO8ly
	 +Jv+9vTeIYNtoDHg0Xni/6fYXDhCRRTNVah0/2r6SFtNZhmD7pkjb8LxNfMBoRD0uq
	 HwpoSCG5oagKg==
Date: Sun, 26 Nov 2023 16:11:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Alexandru Tachici <alexandru.tachici@analog.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: ad7192: Add properties
Message-ID: <20231126161102.3906316a@jic23-huawei>
In-Reply-To: <c6ca5a25-2d41-4a46-95a5-eb994c4cf529@linaro.org>
References: <20231114200533.137995-1-alisa.roman@analog.com>
	<20231114200533.137995-2-alisa.roman@analog.com>
	<c6ca5a25-2d41-4a46-95a5-eb994c4cf529@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 21:29:58 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 14/11/2023 21:05, Alisa-Dariana Roman wrote:
> > Document properties used for clock configuration.  
> 
> Some background here is missing - otherwise it looks like you are adding
> new properties...
> 
> > 
> > Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7192.yaml        | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> > index 16def2985ab4..9b59d6eea368 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> > @@ -80,6 +80,16 @@ properties:
> >        and when chop is disabled.
> >      type: boolean
> >  
> > +  adi,clock-xtal:
> > +    description: |
> > +      External crystal connected from MCLK1 to MCLK2.  
> 
> And this should be input clock.

Fair enough. We've been doing this wrong for a while then, but good not
to do it in new bindings.

It's a bit of an oddity as arguably it's just putting an analog component
in as part of an internally generated clock signal.
A clock binding provides info that the crystal is present though I guess,
even though if you actually connected a conventional clock there it
wouldn't work.

> 
> > +    type: boolean
> > +
> > +  adi,int-clock-output-enable:
> > +    description: |
> > +      Internal 4.92 MHz clock available on MCLK2 pin.
> > +    type: boolean  
> 
> This should be clock-cells and clock provider.
> 
> Unless you are just documenting already used interface which you do not
> want to break...
> 
> > +
> >    bipolar:
> >      description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
> >      type: boolean  
> 
> Best regards,
> Krzysztof
> 


