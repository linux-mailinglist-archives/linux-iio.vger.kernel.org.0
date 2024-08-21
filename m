Return-Path: <linux-iio+bounces-8655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4B795A5A0
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 22:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C24C1F22DA8
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 20:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8839D16EC1A;
	Wed, 21 Aug 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfZvrrYl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C11D12F4;
	Wed, 21 Aug 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270801; cv=none; b=eoMz8a76DgSfqHq60NaNTYLNcBJtnAmlpG9Y7+J0JPdnv++IqpDd550foV0BHKaTfDCIfu+ljniscmOSUSd10KqYXowRSvw7yvPJRPuLJ4gWweBAkDsEb/2WAx5bTf6y6XkJgscAmkpVY2LRdrETy1XBF7eKbxKPmtJcYOX52f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270801; c=relaxed/simple;
	bh=vq4i41ddTv1QbpXx1GaVqVWySCl8p9LHMx5IMZcoRA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzlZqTF597TaNuaTZMVK3QH6HjTIRR7fAfGyRgBLAf2u1ze1Guw77LxsUUHKDAgez5B5EAALpef4SUBz4rdAiyKxeOWRoZh5t88zsQbJMlqU3QyVlqzm2QTU0EttZ+ghM5LywwgzuhJC+jxflS7gLRi7/5DRTSqfeHLAszUjGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfZvrrYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEC7C32781;
	Wed, 21 Aug 2024 20:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724270801;
	bh=vq4i41ddTv1QbpXx1GaVqVWySCl8p9LHMx5IMZcoRA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NfZvrrYluhBrsNSyj1NmLmqNgSKWZZojn8EyfObCElZtGO/IYitPjFE3VlwZxNjoa
	 KwmEnU/ibMt7cA84u3Kg3NGsz+flkPv9PHU1dF2tuJ2diL+Ln2KAVrAUr5HEPSm5Sp
	 27qURFqAMTgpvXrIs47qBl5ee0CRAoNfZh1zgcvC6mNDVmwGKHyL7SYsJiKWJl4Au5
	 bHvumvdpW6eM0u7RIeu8w7R6jrmxoF8UWY9uBgajCKlx/01oXUSOMP88GaHu3HZ+FE
	 foxUYl+1wTLMXXQz6dPIhejZ46sNGyj0ERg69wSvPmd/hN2A0cseqhg9HAnRZmEdJy
	 iI+2HkX5zkxOQ==
Date: Wed, 21 Aug 2024 21:06:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: st,stm32-adc: add top-level
 constraints
Message-ID: <20240821210633.3741bf8f@jic23-huawei>
In-Reply-To: <20240819-outflank-variety-3fcb7ca0338a@spud>
References: <20240818172951.121983-1-krzysztof.kozlowski@linaro.org>
	<20240819-outflank-variety-3fcb7ca0338a@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 18:13:22 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sun, Aug 18, 2024 at 07:29:51PM +0200, Krzysztof Kozlowski wrote:
> > Properties with variable number of items per each device are expected to
> > have widest constraints in top-level "properties:" block and further
> > customized (narrowed) in "if:then:".  Add missing top-level constraints
> > for clock-names.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
Applied,

Thanks,

Jonathan

> 
> >  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> > index ec34c48d4878..ef9dcc365eab 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
> > @@ -54,7 +54,9 @@ properties:
> >            It's not present on stm32f4.
> >            It's required on stm32h7 and stm32mp1.
> >  
> > -  clock-names: true
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 2
> >  
> >    st,max-clk-rate-hz:
> >      description:
> > -- 
> > 2.43.0
> >   


