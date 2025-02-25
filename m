Return-Path: <linux-iio+bounces-16060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E75A44149
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 14:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB0817A1267
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A71268FFE;
	Tue, 25 Feb 2025 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="BTtOajFC"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-15.pe-b.jellyfish.systems (out-15.pe-b.jellyfish.systems [198.54.127.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95C2571D3;
	Tue, 25 Feb 2025 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491357; cv=none; b=aa9JkKoVv3zDJKDK1YoHxaXnjQpUg+SR73rBBwclJZAdfMpmIzluEdh5kmXPOuF2c5WrdZ403E6/XdUfAqzI1PWC4hoJSpLapAiWlmww25JAWVhtRE8olXhcnNkAjRQkbsxVNapuolK2Hyd//pWzbhRzcoAPa4z3LloxCvVe4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491357; c=relaxed/simple;
	bh=7iRM7JhVAanpAM8Erx1B2TRdCjAkY/Jr6hAaZ2qnOms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of70lZaRhyVX+Xr0QwIWa5jsExuVS/tqwxzUi7RAY4USs/x6PvIstbXDXZtl79ofbtYz96q6AgGw7wHlZViqS/msgv+gc+30zqFE+65EODb8yRGMFfGtvdYHHFKDI8PSUeT1IcQnHiuHfz4W2I+wDW/K1Tm0SefsCGv/7UOyjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=BTtOajFC; arc=none smtp.client-ip=198.54.127.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z2JqZ3B7HzDqsH;
	Tue, 25 Feb 2025 13:49:14 +0000 (UTC)
Received: from MTA-12.privateemail.com (unknown [10.50.14.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z2JqZ2mlvz3hhVd;
	Tue, 25 Feb 2025 08:49:14 -0500 (EST)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id 4Z2JqZ1TxPz3hhV3;
	Tue, 25 Feb 2025 08:49:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1740491354;
	bh=7iRM7JhVAanpAM8Erx1B2TRdCjAkY/Jr6hAaZ2qnOms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTtOajFCPudrrEyWGiRznR1WG4R//XffntLUDhFye1qza3YyCQlvgJCQKHzPkFYNX
	 pAm87haT/1uqPWENfxbaeCFongTUvai6xU4e6eR818LV9n+yey5FZtLy/vAGZi+uyx
	 i8ayXALMlQw+TjiNAilRIWK+/YJxeUPERu/szAeK8bCO4WGfr5jvwwzgfW1R2Xjeot
	 eoa2MDKPiFYB/m9NpWCCNuJqF4Zyi89g8PkfqAawEA2mMgVzGxp4iRqiFjTCH5MyQA
	 T/nLtuq6mdzfCp7aRDJCVj/1x5wjsO+n3Jjl6jbfsGlTeehfJamW+t3VuLwCZbM4+H
	 wrr8i1xIwmH3g==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Tue, 25 Feb 2025 08:49:06 -0500 (EST)
Date: Tue, 25 Feb 2025 08:49:07 -0500
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: filter: Add lpf/hpf freq margins
Message-ID: <Z73KUzqe5VmITJVB@65YTFL3.secure.tethers.com>
References: <20250224175056.560111-1-sam.winchenbach@framepointer.org>
 <20250224175056.560111-2-sam.winchenbach@framepointer.org>
 <fe1b0dde-f899-4303-bd2a-b19098edcae8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1b0dde-f899-4303-bd2a-b19098edcae8@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP

On Tue, Feb 25, 2025 at 08:42:04AM +0100, Krzysztof Kozlowski wrote:
> On 24/02/2025 18:50, Sam Winchenbach wrote:
> > Adds two properties to add a margin when automatically finding the
> > corner frequencies.
> > 
> > Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
> 
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
> 
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>

Updated the maintainers list per your instruction and resubmitted as v4.
Thank you for your assistance.

> 
> > ---
> >  .../devicetree/bindings/iio/filter/adi,admv8818.yaml | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > index b77e855bd594..1be6f1fe4bfc 100644
> > --- a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > +++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > @@ -44,6 +44,16 @@ properties:
> >    '#clock-cells':
> >      const: 0
> >  
> > +  adi,lpf-margin-hz:
> > +    description:
> > +      Sets minimum low-pass corner frequency to the frequency of rf_in plus this value when in auto mode.
> 
> Wrap according to coding style.

Updated in the v4 patch.

> 
> 
> 
> Best regards,
> Krzysztof

