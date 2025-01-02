Return-Path: <linux-iio+bounces-13878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B722A000B8
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2025 22:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8ED21882BC0
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2025 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1281B415A;
	Thu,  2 Jan 2025 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dud4uyCw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8F713AA2A;
	Thu,  2 Jan 2025 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853680; cv=none; b=Q059qZgDRkUrwnoBkqbr2rlFPz8Tfn0dgur0G7Oo5MAF4aMbMSXVz3SZ7Y4B8su6zEg45gM38yL6lfqxuEDTewBxQ/aXyIbfm2JeWVIfIhZIgvTsSnTaQmdRpQaXmLD4X9orFtsFAA2RN6TOVgjvn22sk64SoDJ6JkGABCD5F9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853680; c=relaxed/simple;
	bh=3t49K6dc09HYQTbG/D+IZZo7V3U7nhGevTZen16XX7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKhEhk8B7KKGXOig19xfE+d/sJhLFiIFJz5TS1W6HMuN46CuM0bAD2NjPXb75ZzPmc/4OEZZtX/bX11w649B7t1pveZdlZO1YetTHsKPvII8BSlONt4800EusdMy9VnV+rTDJNOc7LUyAcxU40upGk38LnGiYhxhFrSX7YD2LvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dud4uyCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02813C4CED0;
	Thu,  2 Jan 2025 21:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735853678;
	bh=3t49K6dc09HYQTbG/D+IZZo7V3U7nhGevTZen16XX7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dud4uyCwevuFwIG/33iSUErORQHcSuewU97OnuWHz2QDfS4Ph3GxJA4bE+gKW3Ls6
	 sLXIz+UUam4QmeGYu9yEXoe709Rj0bdep3jPtmLQOGV8TLdwagStDeASoHmd2T/6DT
	 G7Yo2pXu2Fsew8qPvk53OOMN5A183AODninDHrZ1scxYW0VqUfQ0acADwAZ9ywDVrP
	 HOgQnWKjWNzjIJA5Lj0G5MOnkNUUEDuxJBtxYLAso7iuPbTOkeJko/BhJz/BrDI633
	 R3SjJC7AHXODplB8HNJFrvnbHYr8LqtgV++wYEbQ/99bC3pMfSL4POS65uy2X9SoBR
	 RotPPZk9Eb+dQ==
Date: Thu, 2 Jan 2025 15:34:36 -0600
From: Rob Herring <robh@kernel.org>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Andreas Dannenberg <dannenberg@ti.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iio: light: opt3001: add compatible for
 opt3004
Message-ID: <20250102213436.GA602988-robh@kernel.org>
References: <20241227131134.10810-1-hardevsinh.palaniya@siliconsignals.io>
 <qgottqtq5lvp6fifi37xzq7supalvm7leue755yjatyun6k5um@pju4v3kqoizq>
 <PN0P287MB2843E7005997F1728B0F9B2CFF0F2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
 <20241228131929.49e4a90d@jic23-huawei>
 <PN0P287MB284355F3DD7DCF6BFC6D071FFF092@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN0P287MB284355F3DD7DCF6BFC6D071FFF092@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>

On Mon, Dec 30, 2024 at 07:34:27AM +0000, Hardevsinh Palaniya wrote:
> Hi Jonathan, Krzysztof
>  
> Thanks for your input.
>  
> > On Sat, 28 Dec 2024 10:54:33 +0000
> > Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io> wrote:
> > 
> > > Hi Krzysztof,
> > >
> > > > On Fri, Dec 27, 2024 at 06:41:32PM +0530, Hardevsinh Palaniya wrote:
> > > > > Add Support for OPT3004 Digital ambient light sensor (ALS) with
> > > > > increased angular IR rejection.
> > > > >
> > > > > The OPT3004 sensor shares the same functionality and scale range as
> > > > > the OPT3001. The compatible string is added with fallback support to
> > > > > ensure compatibility.
> > > > >
> > > > > Datasheet: https://www.ti.com/lit/gpn/opt3004
> > > > > Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> > > > > ---
> > > > >
> > > > > v2 -> v3:
> > > > >
> > > > > - Reverse the order of compatible string
> > > > >
> > > > > v1 -> v2:
> > > > >
> > > > > - Use fallback mechanism for the OPT3004.
> > > > > - Drop 2/2 patch from the patch series[1] as per feedback.
> > > > >
> > > > > Link[1]: https://lore.kernel.org/linux-iio/20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io/T/#t
> > > > 
> > > >
> > > > And where is any user of this, the DTS? We don't take bindings just
> > > > because there is such device out there.
> > > >
> > > > I looked and nothing:
> > > > https://lore.kernel.org/all/?q=ti%2Copt3004
> > > >
> > > I added compatibility for the OPT3004 into the driver. However,
> > > based on Andy's feedback, it seems there might not be a need
> > > to include this directly in the driver.
> > > (Refer to Link [1] from the changelog.)
> > >
> > > we could follow a similar approach to how we handled the ADXL346,
> > > by just adding it to the bindings, since the ADXL346 is similar to the
> > > ADXL345.
> > >
> > > If I misunderstood then please let me know.
> >
> > Perhaps give some more information on the device in which this is found?
> > If that's a board that you plan to support upstream in the longer term
> > then that would provide more justification for this patch.
> > 
> > The note on the opt3001 page does give a hint as to how the parts are different
> > but saying the opt3004 has better IR rejection.  They also have a somewhat different
> > sensitivity curves. However, those are details we don't expose in the ABI and the
> > devices unhelpfully report the same ID register value, so it is not obvious that
> > we need to treat them differently.
>  
> In our customer project, this sensor is utilized in the product. However, 
> I acknowledge that, at present, there is no upstream user of this binding
> in the mainline.
>  
> Additionally, it is unlikely that the custom board using this sensor will be 
> upstreamed in the future. The primary motivation for this patch is the 
> absence of existing support for the OPT3004 in the mainline kernel.
>  
> I fully understand your concerns regarding the addition of bindings without 
> an immediate upstream use case. I leave the decision to you regarding whether
> it would be appropriate to include this binding. I am open to your guidance and
> will respect the outcome either way.

I'm confused. Jonathan seems to say the OPT3004 needs different 
handling. The binding says it doesn't at least for some subset of 
functionality matching OPT3001.

If you need driver changes, then submit this with the driver changes. If 
you don't, then make it clear the device works with the existing driver.

Rob

