Return-Path: <linux-iio+bounces-10583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5E099D754
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 21:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CAAB282FFF
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 19:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2BB1CC8AE;
	Mon, 14 Oct 2024 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iSUxXAwi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7C1C761F
	for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933968; cv=none; b=oj5KSJ7LKZwlUXRY8oB5cj0RnSOtexb656qvfQCw99VCqNV5KrV1PhrU3FKWopPSJ1r7zVttaZ1jjqE6OLxLwX02J/osulsCdFUtBXJdggc143qFGz4xTxd7338w9T7CADAGQ6T0TzErYTjym+utRj+xQJj6c41zQqU5dQdKHlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933968; c=relaxed/simple;
	bh=wgw2OAlJK7DqhjidmbliVOj9gQrHL8j/AKhNMHV1EAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg3GVBl6U3ZmMoSZ61MxSp3yTUT0EWgpyMTHoMQzBc5RTWErx3HqhNgb6/OxJL0J91uqtzt/bO8Y9iQ+qaAcVTsKA/q1NKC4CbCHP7AvVQ2eB5SU7mBPn6mU+4TBXGjxJmg+D4jkhdpWlbE8gdVH/+Cpk/oDOwMEQsajVxaxC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iSUxXAwi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4305413aec9so44595625e9.2
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728933962; x=1729538762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQFel9daBpAI8WojLFq466cXumXh/MVmFONQmu9MWy8=;
        b=iSUxXAwijifzwNeyafUVgBPtThlmDQKieX1AIJlUdxCSkN3HCeHOyiA8A8fSlMo0q9
         tbFZCCJMQJwxDRHq9ls3aWbJNIIesjLBycWraOSAlEYvSvpLC6Dg7fXSmtNKcwTSFAGl
         a9Pi1DI1DH84M0Fdws4vpQyg/7ZplvzpaMi+GxecP/jQoYTqFiPLxJUSFxie6LLvX0Db
         37uxuRXKpLrwhlPQ58AE5JgxrQo8wJ4DafT+6URkOEDtXy+tNGCuf/8uQAP/N6Xg8rdv
         d5WG7C/aGc17g0hKBtMLet1VK+Bu+HuByWi69KBLysqn813lYJyzkghURkBHxmB3Tltg
         quIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728933962; x=1729538762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQFel9daBpAI8WojLFq466cXumXh/MVmFONQmu9MWy8=;
        b=M17fk3UXifhmcBkrSkToAIrsC/ntcwyHlTLDKwtbIXs6BVxMyqs54BClOqIfnv0Mgr
         Xf4/VMk+N4cwiZpVQVeckHcabHuQldPNwiDdjti7XO+F2hLIqWWIFWKQKrOk/t3ZWtWa
         tF5CpQm79LArp30DAr6ufOjqfNZRpLsarflVAT+WgaqdxfRBevtVzXztLRkLllwymaEx
         Nd3Wa6ag44jKs5FOMWQQUrQmchiSg2rAQqP3BBB5ACU7wAoQYVO9Y5V9ifkUaElAcoy9
         bawi8+BD0fjKXuJytYFxVOg5xmuXaM4Ub1HzXPVFJJba5S35DIeMCwxr0q8JA5gZSnIf
         nGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmP+rcp2cH9Ae82WXMtmuoAfZSm/swRZ2szTvB2NqkMmaDUAvA2zR9nA5OO4gioDDBNUGGEbjFR8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1peA8QUUdIErRtwPutniyreguY22rbJ7gLinhV5CRWiZFj9y
	irRsIbGNUlf1AQ6C/KBP5GN+QN51vCJqRLf29zIWjf8Bg9cJubJnAjzQlYezgAI=
X-Google-Smtp-Source: AGHT+IFtTfS2MqMy7w7oJkFD5tNAiEp1UeXze3wU6Ex0A/U2U9ZMVwxrjNvixtUDNrFKoMP3T/B+Sg==
X-Received: by 2002:a5d:564d:0:b0:37d:5405:817b with SMTP id ffacd0b85a97d-37d5518e69fmr7766570f8f.7.1728933962209;
        Mon, 14 Oct 2024 12:26:02 -0700 (PDT)
Received: from dfj (host-79-45-239-138.retail.telecomitalia.it. [79.45.239.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b9190f7sm12115554f8f.114.2024.10.14.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:26:01 -0700 (PDT)
Date: Mon, 14 Oct 2024 21:24:34 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlechner@baylibre.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v6 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Message-ID: <hcf5nrotmvvoknehnf2nvje4stnoodam34wgmhnddbavcyybj6@ogq33ss66pnx>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-2-eeef0c1e0e56@baylibre.com>
 <172890486251.793259.16216468875581353928.robh@kernel.org>
 <20241014133823.GA1018400-robh@kernel.org>
 <r2gmorclmtcrykws4sd7l3hkjzg6f72vbh7ulh3ml2jsnev35z@on2stvxr36qm>
 <20241014202000.0654a1bd@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014202000.0654a1bd@jic23-huawei>

On 14.10.2024 20:20, Jonathan Cameron wrote:
> On Mon, 14 Oct 2024 16:04:35 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > Hi Rob,
> > 
> > On 14.10.2024 08:38, Rob Herring wrote:
> > > On Mon, Oct 14, 2024 at 06:21:02AM -0500, Rob Herring (Arm) wrote:  
> > > > 
> > > > On Mon, 14 Oct 2024 12:08:08 +0200, Angelo Dureghello wrote:  
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > 
> > > > > Add a new compatible and related bindigns for the fpga-based
> > > > > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > > > > 
> > > > > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > > > > generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> > > > > mainly to reach high speed transfer rates using a QSPI DDR
> > > > > (dobule-data-rate) interface.
> > > > > 
> > > > > The ad3552r device is defined as a child of the AXI DAC, that in
> > > > > this case is acting as an SPI controller.
> > > > > 
> > > > > Note, #io-backend is present because it is possible (in theory anyway)
> > > > > to use a separate controller for the control path than that used
> > > > > for the datapath.
> > > > > 
> > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > ---
> > > > >  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 56 ++++++++++++++++++++--
> > > > >  1 file changed, 53 insertions(+), 3 deletions(-)
> > > > >   
> > > > 
> > > > My bot found errors running 'make dt_binding_check' on your patch:
> > > > 
> > > > yamllint warnings/errors:
> > > > 
> > > > dtschema/dtc warnings/errors:
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.example.dtb: dac@0: spi-max-frequency: 66000000 is greater than the maximum of 30000000
> > > > 	from schema $id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#  
> > > 
> > > This is at least the third time this issue has been reported. Don't send 
> > > more versions until you fix it.
> > >   
> > 
> > as stated in the patch message, this patch applies to linux-iio testing,
> > where there are no errors, from my tests.
> > 
> > Error is due to the spi-max-frequency fix already applied in iio testing,
> > but still not where your bot is testing, proably in mainline.
> 
> Whilst it's a fix, given the fix broadens the accepted range and doesn't matter
> until this patch (which will behind it) I currently have no intention
> of sending that fix until next merge window.
> 
> Cynic in me says just change the example to a value under the old limit
> and bot will be happy. Example is just that, so doesn't have to reflect
> the maximum possible or even what people commonly run.
> 
> Or include that patch again in this series with a note to say it's
> just here to ensure the base is correct for the bots.
> 
> Jonathan

ack, if a next version is necessry, will do that.

Regards,
angelo

> 
> > 
> > Regards,
> > angelo
> > 
> > > Rob  
> 

