Return-Path: <linux-iio+bounces-8287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9321894954F
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD1A1C2171B
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73877182C5;
	Tue,  6 Aug 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKOJPj/b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B918D63A;
	Tue,  6 Aug 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960679; cv=none; b=poYvQa4nwFwrWOBkB3SUljuyAz0qGEG47fqNc452Vlsq5KhL8Yx64R3P2EbF8eq8+/QfMTS20VaCF8xaksruHxai64P0xO8dZlo9Jx7RalLYVxQFNmudl/2KJDEnije4MHX+CYPWqfgS2BH82BZE2tlZJyGSdyez4ObhjA/mHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960679; c=relaxed/simple;
	bh=JAFmR3nl8VUWUNjO8vWOcsKijHP8TGLwK1qPQMVyPOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2TLJ1C0K+9bN99OUASz5QFvITG168+69ESNu/pV5VEyRnYsTGzMZ38F9X4iFxO3KNvJ6gT16TQqUEtZO09FV8J1OPTAe/TMNlSVo88Sv04O8o1A62tUU7hFhF39w9VnFN3kGlrS+sLhQHSD4Q7ogdjqsJzClKYoeqXL8nlMIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKOJPj/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C946C4AF0C;
	Tue,  6 Aug 2024 16:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960678;
	bh=JAFmR3nl8VUWUNjO8vWOcsKijHP8TGLwK1qPQMVyPOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eKOJPj/bpbQWlevZiGRo7JDyV9e+D4bMcQJOvwDubUfPWwkm3CAHzrkJXMMbYkymM
	 zg5EUT9Pc91EPfIm/aaKBzXfSIJRu517iKHfbtT8W/8zz+thb058iGIrSbNsUwGSdh
	 dMW+zbEtmcFlcCJiEFEJlq97WPIthkhN77y0k2x9WNdHv1Z4xa8JidcHK92e7xXV1z
	 6MDkLlWLl1Y82sV+lmwpCneQkbEqZEZ+QeJJoq9MlPfVMDnp8h7mCfCGp2x+KbrvDE
	 97pEHptoZpjaL0ujIgmj4Zf3jNWKsfipSt7AwoSkfBsgMMYrPmRvSv36vD1A6GL7Rv
	 +JFziTTPOfpyw==
Date: Tue, 6 Aug 2024 17:11:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Albrieux
 <jonathan.albrieux@gmail.com>, Matt Ranostay <matt@ranostay.sg>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: asahi-kasei,ak8975: drop
 incorrect AK09116 compatible
Message-ID: <20240806171113.0cf9b992@jic23-huawei>
In-Reply-To: <20240806-unlocked-womankind-f9e5e1d19055@spud>
References: <20240806053016.6401-1-krzysztof.kozlowski@linaro.org>
	<20240806053016.6401-2-krzysztof.kozlowski@linaro.org>
	<20240806-unlocked-womankind-f9e5e1d19055@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Aug 2024 17:02:49 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Aug 06, 2024 at 07:30:16AM +0200, Krzysztof Kozlowski wrote:
> > All compatibles in this binding without prefixes were deprecated, so
> > adding a new deprecated one after some time is not allowed, because it
> > defies the core logic of deprecating things.
> > 
> > Drop the AK09916 vendorless compatible.
> > 
> > Fixes: 76e28aa97fa0 ("iio: magnetometer: ak8975: add AK09116 support")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > Offending commit did not even bother to Cc devicetree mailing list and
> > DT maintainers... Lovely. Let's ignore submitting patches and
> > maintainers just to sneak my important patch into the kernel.
> 
> :/
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Let's assume mistake rather than malicious.
I should have noticed this :(

Anyhow, applied both patches to the togreg branch of iio.git.
Initially pushed out as testing for 0-day to take a look at other
stuff that's queued up.

Jonathan

> 
> Thanks,
> Conor.
> 
> > ---
> >  .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> > index 9790f75fc669..fe5145d3b73c 100644
> > --- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
> > @@ -23,7 +23,6 @@ properties:
> >            - ak8963
> >            - ak09911
> >            - ak09912
> > -          - ak09916
> >          deprecated: true
> >  
> >    reg:
> > -- 
> > 2.43.0
> > 


