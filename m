Return-Path: <linux-iio+bounces-189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C87F7F15E6
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 15:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3441C216EC
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4B714A8C;
	Mon, 20 Nov 2023 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="OE1vLD/7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A46A4;
	Mon, 20 Nov 2023 06:40:54 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 4CF5B28EE6F;
	Mon, 20 Nov 2023 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1700491253;
	bh=LZcQN0TV9+lj9l4R7rlzQvmMSI32m2CgUuGmtP41lVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OE1vLD/7KzBE8RbeLZZpdiYT7ke6zXjS4+9zU+J7Leev6ut2AAyXMbTRCHEtkTRtv
	 21ZbzmEGQhJgni3+H3bs1xIL6A8WjRqH4O5n3EYbWu+4KZ2j4838rmccWyNyO6DFQk
	 Pne+WpkNO0jdeaQg62tLstSC/fzMQZaXTx01oelY=
Date: Mon, 20 Nov 2023 16:40:51 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <ZVtv8x8LqGMhCisw@sunspire>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
 <5b2e4b05-9408-48ea-92ac-15883e102013@linaro.org>
 <ZVtiVM2Gm1x1j_G1@sunspire>
 <8aa11758-5eee-427b-adcb-c3578a521daf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa11758-5eee-427b-adcb-c3578a521daf@linaro.org>


Hello!

On Mon, Nov 20, 2023 at 03:04:07PM +0100, Krzysztof Kozlowski wrote:
> On 20/11/2023 14:42, Petre Rodan wrote:
> 
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - honeywell,hsc
> >>
> >> Way too generic
> > 
> > I'm new to this, please excuse my ignorance.
> > my driver covers all Honeywell pressure sensors under the "TruStability board mount HSC/SSC" moniker.
> 
> We talk here about bindings, not driver. For the driver you can use
> whatever name is approved by reviewers of your driver.
> 
> > that is why my intention was to provide a rather generic name for the driver itself.
> > are you afraid that they will come up with a different device that they will call "hsc" in the future?
> > in this case honeywell,trustability-hsc would be fine?
> > 
> > as I see you prefer to target a particular chip, but I am a bit afraid that the end-user will be confused by needing to set up something like
> > 
> > pressure@28 {
> > 	compatible = "honeywell,hsc030pa";
> 
> The compatible should be specific, thus for example match exact model
> number.

there are an infinite number of combinations of 4 transfer functions and 118 ranges + one custom range, so providing an array with all specific chips that could end up as compatible is out of the question.
I was aiming at providing a generic name for the binding and get the transfer function and the pressure range as required parameters.

> If you can guarantee that all devices from given family are the same in
> respect of programming model and hardware requirements (e.g. supplies),
> then you could go with family name. However such guarantees are rarely
> given.

I see your point.

> Therefore for mprls0025pa I agreed for using one specific model
> for entire family.
> 
> https://lore.kernel.org/all/d577bc44-780f-f25d-29c6-ed1d353b540c@linaro.org/
> 
> 
> > 	reg = <0x28>;
> > 	honeywell,transfer-function = <0>;
> > 	honeywell,pressure-range = "250MD";
> > };
> > 
> > ie. specifying "hsc030pa" as driver while his chip is not in the 030PA range, but 250MD.
> > 
> > so do you prefer
> >  honeywell,trustability-hsc  OR
> >  honeywell,hsc030pa
> 
> I think the latter, just like we did for mprls0025pa. How many devices
> do you have there?

both hsc and ssc have 118 ranges, 4 transfer functions and both can be requested from the manufacturer with custom measurement ranges.

ok,I will rename hsc->hsc030pa in the code as you requested.

> >>> +  honeywell,pmin-pascal:
> >>> +    description: |
> >>> +      Minimum pressure value the sensor can measure in pascal.
> >>> +      To be specified only if honeywell,range_str is set to "NA".
> >>> +    $ref: /schemas/types.yaml#/definitions/int32
> >>
> >> That's uint32. Why do you need negative values?
> > 
> > signed int32 is intentional. some chips have two physical input ports and measure a pressure differential in which case pmin is negative.
> > see either of the pdfs at page 14, table 8, column 2, row 7+
> 
> Then the best would be to change the type in other bindings to have
> int32 everywhere... but dtschema also requires unt32:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

yeah, and also '-kpascal' might be too coarse of a unit when we talk about sensors that have a -125 .. 125 pascal measurement range as '0.5ND' has.

cheers,
peter

-- 
petre rodan

