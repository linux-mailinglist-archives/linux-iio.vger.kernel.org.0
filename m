Return-Path: <linux-iio+bounces-16100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC44EA467B8
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 18:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50EF173BA0
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 17:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF400224893;
	Wed, 26 Feb 2025 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="WlEkZEIM"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-14.pe-b.jellyfish.systems (out-14.pe-b.jellyfish.systems [198.54.127.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC121CFFB;
	Wed, 26 Feb 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589834; cv=none; b=WG9tG3QaWonW1n/nYmrm6+mqKEryXMmAN86InNK+62+5Lgcw/fTjvB2jNYZ0540/z1kPYss9y3LJ+1D+RTiuiDmCyLCMWZGZuRWt9j6igep72KCt1a1hPPIGCyB2MUF+SzsJB1OBUoeivIXGcRXOBjeUoi8XvNGnVZx5Vdxj10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589834; c=relaxed/simple;
	bh=ET6MnGOAw+tmFtDYLv/Ch2D8SAlnx0O5Qbh8oHJdoso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCjlrcUsllZoOuyB/0XDc2TxzgC6dDoK4rF24rxo3R0URGFC2wTBKFTxD0E2F8PAGTgC1leF9TuLBUfc186CaGHpYzaIDfrr+qKkh+LstRSo1+xE3y/22gO1bMq6buHTaLkSZen/PofObRvTTKoFAuZO6ncBTTSzfVoHrU0kH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=WlEkZEIM; arc=none smtp.client-ip=198.54.127.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z31F85lf1zDqfN;
	Wed, 26 Feb 2025 17:10:20 +0000 (UTC)
Received: from MTA-05.privateemail.com (unknown [10.50.14.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z31F85FvZz3hhVj;
	Wed, 26 Feb 2025 12:10:20 -0500 (EST)
Received: from mta-05.privateemail.com (localhost [127.0.0.1])
	by mta-05.privateemail.com (Postfix) with ESMTP id 4Z31F83yDwz3hhVF;
	Wed, 26 Feb 2025 12:10:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1740589820;
	bh=ET6MnGOAw+tmFtDYLv/Ch2D8SAlnx0O5Qbh8oHJdoso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlEkZEIMW+KffMjCPDH6+idMT3DAJuMMkd3eaQoKDW3VvaRGO0J3tOIXHGGlqJxv1
	 JisZa8byIBamvcutb6I+rXFqevtlxyFBrmvtPYks7GylmOBh8GGIFN01rUPGrQD5x/
	 0FuTTdr4OIt5exSvZNGJptZ+tlQD+3pGQw84YnilKTN3hcQH63wzYHR4CulQ4WcemX
	 Qm9CW9fyg6Rng3J2fBAL+Y9yqLx4Ibi0/dfSh8WsqQztA6FF7n9kAopBo4ZfSZciWj
	 FlYP2fNjmDH2TBMjX9/ceKw+rFv9fNgHKvji1NBvU7D8D6rAO0qxWEA+qgzZif4TxF
	 svfud/0j7u+vA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-05.privateemail.com (Postfix) with ESMTPA;
	Wed, 26 Feb 2025 12:10:08 -0500 (EST)
Date: Wed, 26 Feb 2025 12:10:08 -0500
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: filter: Add lpf/hpf freq margins
Message-ID: <Z79K8Ag4SJYtJTtM@65YTFL3.secure.tethers.com>
References: <20250225134612.577022-1-sam.winchenbach@framepointer.org>
 <20250225134612.577022-2-sam.winchenbach@framepointer.org>
 <20250226-sparkling-caped-saluki-b1cbad@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226-sparkling-caped-saluki-b1cbad@krzk-bin>
X-Virus-Scanned: ClamAV using ClamSMTP

On Wed, Feb 26, 2025 at 09:03:13AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Feb 25, 2025 at 08:46:12AM -0500, Sam Winchenbach wrote:
> > Adds two properties to add a margin when automatically finding the
> > corner frequencies.
> > 
> > Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
> > ---
> >  .../bindings/iio/filter/adi,admv8818.yaml          | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> 
> Bindings are before users (see DT submitting patches), so this should be
> re-ordered.
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > index b77e855bd594..2acdbd8d84cb 100644
> > --- a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > +++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> > @@ -44,6 +44,18 @@ properties:
> >    '#clock-cells':
> >      const: 0
> >  
> > +  adi,lpf-margin-hz:
> > +    description:
> > +      Sets minimum low-pass corner frequency to the frequency of rf_in plus
> > +      this value when in auto mode.
> > +    default: 0
> > +
> > +  adi,hpf-margin-hz:
> > +    description:
> > +      Sets maximum high-pass corner frequency to the frequency of rf_in minus
> > +      this value when in auto mode.
> 
> IIUC, these are two bounds - lower and upper - in relation to something
> else (like rf_in frequency)? If so, make it an array (naming to be
> discuss, I assume you know better what's that):

It is true that these are both related to rf_in but both the low and high pass
filters can operate independently. Logically, IMO, it makes more sense to have
them as separate controls but I am happy to put them into an array if that is
the idiomatic approach to situations like this. That said, I am having a
difficult time getting dt_binding_check to pass when I have an array of uint64.

When listing two items, as in your example below, I get the following:
adi,admv8818.example.dtb: admv8818@0: adi,filter-margins-hz: [[0, 30000000], [0, 30000000]] is too long

I have tried specifying the scheme for each item, setting minItems/maxItems.

Any advice on this would be appreciated.
Thanks.

> 
> adi,filter-margin-hz:
>   items:
>     - description: low-pass corner frequency to the freq.....
>       minimum: xxxx?
>       maximum: xxxx?
>       default: 0
>     - description: high-pass ....
>       minimum: xxxx?
>       maximum: xxxx?
>       default: 0
> 
> Best regards,
> Krzysztof
> 

