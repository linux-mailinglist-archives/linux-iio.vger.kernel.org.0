Return-Path: <linux-iio+bounces-21105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C29AECE98
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDB83B33F9
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64A3236A73;
	Sun, 29 Jun 2025 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd1rG5Dy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94E12E7E;
	Sun, 29 Jun 2025 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751213957; cv=none; b=Xc9BTnOnupsF8ObcKJxsblxcPRb//X5OrqrNG4WnMUnsI01dGP3e4fFRICGGteOBCP71KoIC759p7OrTeMQpcVLhok/TkssJkctoaX5P/gWaR3UEZv7bUoaaMTWPbYtkemjIqiUesCLeOjiCpmJ6k7cBmfA/2JYLNytAvA4UGIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751213957; c=relaxed/simple;
	bh=dfc2UmLU1h6Dal91XHcK9i4fYJvAqTfnSZWEZUl/yM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Om2DAHpjHhxJA9r4kSK7Fv7MtL9TtAAhoQHl/ISdx/9qcHsWO0HLs31uJVsWug2UrxOMTEqgN5Dsv81vYe9WkV9uq83JGMGuW9kRvYUcHv/xt//XQB6Vub7RU0hvxMLAI/NLgbzUBkHBb6AtQIu8ptaPQXScy9YL8xSjmkTdgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd1rG5Dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0612DC4CEEE;
	Sun, 29 Jun 2025 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751213957;
	bh=dfc2UmLU1h6Dal91XHcK9i4fYJvAqTfnSZWEZUl/yM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fd1rG5DySf0P5aQ0LyySnA/ib//MnvMos9hC+Ek8GBeoV8pw+EUqVYbkjaBmpU13z
	 +z67CuLdWLcjzxkMOu2a9y6HNWqViGs3UcPiuls5QhSh2HNdymIG3e8Y/Wm39ICPTM
	 QSFxgfH9kyMscTyYiUGJ9Ua+Y+pbs92p1g9+BguPsXrQWa1laYGS6bc567kWAh8QKR
	 9XE1DSKsLTRFvUS3ynI2yZvXm+yUM2sZZcWZ5EntDyDQn8pGxaErC7Atpe9gBlv4XO
	 m9ERSVVSCy+imjsZfh0MuGGZALkV+CzSKgisrX0cVUlR3qCKUKBFBRlaYjA+zKegsv
	 PiTSJWhi2tAog==
Date: Sun, 29 Jun 2025 17:19:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: adi,ad7606: fix dt_schema
 validation warning
Message-ID: <20250629171908.122a5163@jic23-huawei>
In-Reply-To: <20250531170448.2be25330@jic23-huawei>
References: <20250526-wip-bl-ad7606-dtschema-fixes-v2-1-9bd56d039489@baylibre.com>
	<20250531170448.2be25330@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 May 2025 17:04:48 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 26 May 2025 15:19:08 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Fix following dt_schema warning when offload is used:
> > 
> >   DTC [C] arch/arm/boot/dts/xilinx/zynq-zed-adv7511-ad7606.dtb
> > /home/angelo/dev-baylibre/linux-iio/arch/arm/boot/dts/xilinx/zynq-zed-adv7511-ad7606.dtb: adc@0: 'oneOf' conditional failed, one must be fixed:
> > 	'interrupts' is a required property
> > 	'io-backends' is a required property
> > 	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#
> > 
> > There isn't any reason that we couldn't have interrupts wired up at the
> > same time we are using io-backends or SPI offload, so dropping off the
> > related "oneOf" block entirely.
> > 
> > Fixes: ccf8c3f106a2 ("dt-bindings: iio: adc: adi,ad7606: add SPI offload properties")  
> That ID seems to be wrong.   Probably down to the messy rebase I had to do pre pull
> request.  Fixed up to be 81fe5529e812
> 
> Applied to the fixes-togreg-for-6.16 branch that will become fixes-togreg after rc1
> is available to rebase on.
I guess something related to the rebase I had to do just before the last
merge window caused it, but that Fixes sha is wrong.


> 
> Thanks,
> 
> Jonathan
> 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> > Fix dt_schema validation warning.
> > 
> > Link: https://lore.kernel.org/linux-iio/20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com
> > ---
> > Changes in v2:
> > - Change removing the related oneOf block. 
> > - Link to v1: https://lore.kernel.org/r/20250523-wip-bl-ad7606-dtschema-fixes-v1-1-d9147fb2a199@baylibre.com
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > index 29f12d650442b8ff2eb455306ce59a0e87867ddd..1a5209139e1338f803c66ad2b4d63ad53cc11d96 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> > @@ -223,12 +223,6 @@ allOf:
> >        - required:
> >            - pwms
> >  
> > -  - oneOf:
> > -      - required:
> > -          - interrupts
> > -      - required:
> > -          - io-backends
> > -
> >    - if:
> >        properties:
> >          compatible:
> > 
> > ---
> > base-commit: 3964c6e5877f054497ffccc7d00f8f7add307d0d
> > change-id: 20250523-wip-bl-ad7606-dtschema-fixes-5e6ab342e043
> > 
> > Best regards,  
> 
> 


