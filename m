Return-Path: <linux-iio+bounces-6255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5538F907CDA
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 21:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F38B26C66
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A59A14D2B7;
	Thu, 13 Jun 2024 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3HiMHlO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817814C583;
	Thu, 13 Jun 2024 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307806; cv=none; b=L8PfqO7Jw8WWJj2ComnHeIRbn0Hp7POQLjgXWbLUU37ibyxsdpA1hJG/1PHQg2gHo74qZOFLzCIjZftOy2fRty+wkhj3jdd07DXV09hZFXF/7mUQntw7V/XODn2obNXhH1iWdvTSTrvRGkL6aT6NUGCVtldobns6Vsy6L6+Zx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307806; c=relaxed/simple;
	bh=3qzuHXwUXJC4kkCUpeSCcm2xbDApMYoDwGK0LWJk20E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8J/T4BPSt1CzvAk3J8YXMT3AkyL5qT25VjLJh932eiC6JRXbYd8/7BXbeYo6Y2yIKh8afnVTTvwnefzPIavUU627fc9wWBLCpyPb6Cb2nu82Cbqb6YYjq8Hw5GGkwIVrlrRRnN1MphxslwWA3aw0NF9Oi+1a1mEmkS9klkSmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3HiMHlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF99C2BBFC;
	Thu, 13 Jun 2024 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718307805;
	bh=3qzuHXwUXJC4kkCUpeSCcm2xbDApMYoDwGK0LWJk20E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3HiMHlOXnYU2dP9n7a5VV3QwL33dfCFvq8F5qed1A0yQ0wCsuNDwTPHTPsnluh1b
	 pYKFSG5MTvUuqHvib2wAw+VOgRO398l/34dMk0SzbPAGmxN5K/qmeIBldxvoIeuz6t
	 AQU+rZBFAuksis+xsm/9mOu+NZSFd6Nxfwb2dHFT9mK448l4f79UlMn8bjKVJS0i27
	 6dfqM18+vgpUmfsh1MxuvPB9t7lLNNEp0CrKlxpiE1SpDG9fUblOmD74AS2e3gdwxX
	 ieI7j3MWHhUUB+QdUal6Vc6vTtDEeuze30Z71qF7ZzeD2bUVYiBGyDwdRKwLmCZNit
	 yx1NZK8jbAJUA==
Date: Thu, 13 Jun 2024 13:43:24 -0600
From: Rob Herring <robh@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add AD4695 and similar ADCs
Message-ID: <20240613194324.GA2352022-robh@kernel.org>
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
 <20240612-iio-adc-ad4695-v1-1-6a4ed251fc86@baylibre.com>
 <94448c2c-e7b2-4191-858c-529b254994f1@kernel.org>
 <f765ef30-a777-4dfc-8f93-0f15b46f91ae@baylibre.com>
 <e09fecf4-bde2-4feb-8312-22c530c6a960@kernel.org>
 <b6b52b1e-847b-44ca-87f9-095a78164771@baylibre.com>
 <5f0776ba5163578453e26352763ff1b4687bcf87.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f0776ba5163578453e26352763ff1b4687bcf87.camel@gmail.com>

On Thu, Jun 13, 2024 at 05:11:48PM +0200, Nuno Sá wrote:
> On Thu, 2024-06-13 at 09:39 -0500, David Lechner wrote:
> > On 6/13/24 9:18 AM, Krzysztof Kozlowski wrote:
> > > On 13/06/2024 15:57, David Lechner wrote:
> > > > 
> > > > > 
> > > > > > +          - const: adi,ad4695
> > > > > > +      - items:
> > > > > > +          - const: adi,ad4697-wlcsp
> > > > > > +          - const: adi,ad4697
> > > > > > +      # same chips with higher max sample rate
> > > > 
> > > > I suppose one could make the argument that the programming model is
> > > > the same on these too, but the maximum sampling frequency does seem
> > > > like an important bit of information so that you don't try to set
> > > > the conversion trigger rate too high.
> > > > 
> > > 
> > > which property is that? I don't see differences in the driver, so I
> > > don't get how these wlcsp compatibles allow you to control value of
> > > conversion trigger.
> > 
> > This comment is unrelated to the package type (WLCSP or LFCSP).
> > 
> > What I mean is that e.g. AD4695 and AD4696 are virtually identical
> > other than the maximum allowable sample rate (500 kSPS or 1 MSPS).
> > 
> > So my thinking was that it would make sense to have:
> > 
> > 	compatible = "ad4695";
> > 
> > for the lower sample rate chip and
> > 
> > 	compatible = "ad4696", "ad4695";
> > 
> > for the higher sample rate chip since ad4696 can do everything
> > that ad4695 does plus a bit more.
> > 
> 
> IMO, that would make sense yes. If the higher sample rate chip fallsback, it will
> still work but not at full speed. The other way around is the one that we can't allow
> naturally.
> 
> But possibly dumb question now... since both devices will be supported at the same
> time, do we actually care about having the fallback compatible? My understanding of
> the fallback story is that we may load a DTS in an older kernel where chip A is
> supported but chip B is not and it is ok for chip B to fallback to chip A. Since
> these devices will be supported at the same time, do we need to care? Unless out of
> tree stuff enters the equation?

Yeah, it doesn't really matter much in that case.

> Or is there another usecase that I'm not aware about (or maybe it just makes sense to
> document properly...)?

Somewhat I guess. Perhaps if there's a 3rd chip with higher rate, then 
it will be more obvious what to do and we don't have to have this 
discussion again for it. :)

Rob

