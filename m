Return-Path: <linux-iio+bounces-16525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C96A5699C
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 14:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E099D175284
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569B821B182;
	Fri,  7 Mar 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="UXygEk/l"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-10.pe-a.jellyfish.systems (out-10.pe-a.jellyfish.systems [198.54.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8121ABB5;
	Fri,  7 Mar 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355704; cv=none; b=QPabEJwBQY81NoA1zNxLSFwCHJVHaoqD2PSb8wwAp5oxpw+g4YnTcRgJjRDhV38XUs+Q6IJ1Pp4gaM4K6OhEvZ4u9x6iFgc7o2ZufEq9qkEuiWEb0iWT0EiYGtNnMZ0zZWeWCGlJGmF+RmWuA0BQ6V7UPgeOkveqiQ3Z0rRdEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355704; c=relaxed/simple;
	bh=uc4J9BqTYETHvuZVd/sGNbIUbnh5AJ3E2j0C33V4z/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsHbDIoSIQKbv+UJ2n/VgEhpzLQAkfFlBWQN1dI8OUUha8CEG0m2O4d8yJsBtn1BM3GAGOQUO3thvEubPs8++eutr/ul4M+JHrczoLWzMvEE5i1AofMijM7PcAvgSpjjKMkE29ZXFfHjcjGh6js82yYn7Y6s1md04ueTvoodnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=UXygEk/l; arc=none smtp.client-ip=198.54.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4Z8SJz2jJdz9tnp;
	Fri, 07 Mar 2025 13:47:31 +0000 (UTC)
Received: from MTA-08.privateemail.com (unknown [10.50.14.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4Z8SJz2DVWz2Sd0Q;
	Fri,  7 Mar 2025 08:47:31 -0500 (EST)
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
	by mta-08.privateemail.com (Postfix) with ESMTP id 4Z8SJz0bSmz3hhV2;
	Fri,  7 Mar 2025 08:47:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741355251;
	bh=uc4J9BqTYETHvuZVd/sGNbIUbnh5AJ3E2j0C33V4z/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXygEk/lmB4eI0JQGkG/tdu6xOk8cNUAP6GJx9mou8qte0P44wX/L2yQMHXTLsWZ7
	 +VcDT5W+fvIHCjn/w+7V8/TYlyNPiCTCcssgbO/NeNlcJm8IkFWNKc2D6yR5MEA6mA
	 l9bibJ8q5X0hDtLjGuam4p8X8bitNe99r6HkiJuJDQG79X4mTFMzfArxCKuIDhyPm+
	 4egeQmjF/JSXE0iK3PelL9pNpEJAGsrDSU99GEJVlDgWeFDBQ5D4C1I68bM05Xu1jK
	 Vpw0YcfGEfrBjVcrzMLLOOT0OhE0ybg3I/jFzDQlRi9fX1VXXli9IcrChwBNrdEURm
	 k4fDr/q48aVPg==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-08.privateemail.com (Postfix) with ESMTPA;
	Fri,  7 Mar 2025 08:47:17 -0500 (EST)
Date: Fri, 7 Mar 2025 08:47:18 -0500
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, bpellegrino@arka.org
Subject: Re: [PATCH v5 1/6] dt-bindings: iio: filter: Add lpf/hpf freq margins
Message-ID: <Z8r45sR7uy0b4UEQ@65YTFL3.secure.tethers.com>
References: <20250306183314.150253-1-sam.winchenbach@framepointer.org>
 <20250307-handsome-merry-alpaca-17da9f@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-handsome-merry-alpaca-17da9f@krzk-bin>
X-Virus-Scanned: ClamAV using ClamSMTP

On Fri, Mar 07, 2025 at 09:34:24AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Mar 06, 2025 at 01:33:09PM -0500, Sam Winchenbach wrote:
> > Adds two properties to add a margin when automatically finding the
> > corner frequencies.
> > 
> > Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
> > ---
> >  .../bindings/iio/filter/adi,admv8818.yaml     | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > index b77e855bd594..3f9c61547a78 100644
> > --- a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > +++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > @@ -44,6 +44,27 @@ properties:
> >    '#clock-cells':
> >      const: 0
> >  
> > +
> 
> Unnecessary blank line
> 

Noted for v6.

> > +  adi,lpf-margin-hz:
> > +    description:
> > +      Sets the minimum distance (in Hz) between the fundamental
> > +      frequency of `rf_in` and the corner frequency of the low-pass, output
> > +      filter when operatred in 'auto' mode. The selected low-pass corner
> > +      frequency will be greater than, or equal to, `rf_in` + `lpf-margin-hz`. If
> > +      not setting is found that satisfies this relationship the filter will be
> > +      put into 'bypass'.
> > +    default: 0
> 
> hz are 32-bit, not 64-bit, so I think you need:
> 
>   default: [0, 0]
>   minItems: 2
>   maxItems: 2
>

I think I finally understand - "-hz" is a schema type defined as a uint32. Is that correct? I am really surprised that `dt_binding_check` did not complain about it being 64-bits.  I will update these to `-mhz` and make them uint32 in v6.

Thanks,
-Sam

> Best regards,
> Krzysztof
> 

