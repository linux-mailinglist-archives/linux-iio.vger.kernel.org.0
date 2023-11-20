Return-Path: <linux-iio+bounces-201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876A27F1C50
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 19:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0BC1C214A0
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 18:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21C230675;
	Mon, 20 Nov 2023 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="morhvBQT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8E1C8;
	Mon, 20 Nov 2023 10:25:11 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 2E5CC28EE6F;
	Mon, 20 Nov 2023 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1700504710;
	bh=TqPCYi/lfIqtwCO6M0vvyzzQcnlSevyzaWBJMKt67zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=morhvBQTAbQh5MbTCeiLvnMOThf9SrBu76IjYpU/VGqvGd24SDnqdEqtQQaQ2hFa/
	 1WdwaPW+9Yu7PczCiWz9tozCinhRSKceEkYghEO3wtCSk7fc/RtVnhLVAUiIFG8uh1
	 F/irdTFARvvIzQ0nuW/UY/DlQAbrnMdzKlXufW5s=
Date: Mon, 20 Nov 2023 20:25:08 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <ZVukhMcY8A3Crxc_@sunspire>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
 <5b2e4b05-9408-48ea-92ac-15883e102013@linaro.org>
 <ZVtiVM2Gm1x1j_G1@sunspire>
 <8aa11758-5eee-427b-adcb-c3578a521daf@linaro.org>
 <ZVtv8x8LqGMhCisw@sunspire>
 <20231120173929.00006a6d@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120173929.00006a6d@Huawei.com>


Hello!

On Mon, Nov 20, 2023 at 05:39:29PM +0000, Jonathan Cameron wrote:
> On Mon, 20 Nov 2023 16:40:51 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
> 
> > Hello!
> > 
> > On Mon, Nov 20, 2023 at 03:04:07PM +0100, Krzysztof Kozlowski wrote:
> > > On 20/11/2023 14:42, Petre Rodan wrote:
> > >   
> > > >>> +properties:
> > > >>> +  compatible:
> > > >>> +    enum:
> > > >>> +      - honeywell,hsc  
> > > >>
> > > >> Way too generic  
> > > > 
> > > > I'm new to this, please excuse my ignorance.
> > > > my driver covers all Honeywell pressure sensors under the "TruStability board mount HSC/SSC" moniker.  
> > > 
> > > We talk here about bindings, not driver. For the driver you can use
> > > whatever name is approved by reviewers of your driver.
> > >   
> > > > that is why my intention was to provide a rather generic name for the driver itself.
> > > > are you afraid that they will come up with a different device that they will call "hsc" in the future?
> > > > in this case honeywell,trustability-hsc would be fine?
> > > > 
> > > > as I see you prefer to target a particular chip, but I am a bit afraid that the end-user will be confused by needing to set up something like
> > > > 
> > > > pressure@28 {
> > > > 	compatible = "honeywell,hsc030pa";  
> > > 
> > > The compatible should be specific, thus for example match exact model
> > > number.  
> > 
> > there are an infinite number of combinations of 4 transfer functions and 118 ranges + one custom range, so providing an array with all specific chips that could end up as compatible is out of the question.
> > I was aiming at providing a generic name for the binding and get the transfer function and the pressure range as required parameters.
> > 
> > > If you can guarantee that all devices from given family are the same in
> > > respect of programming model and hardware requirements (e.g. supplies),
> > > then you could go with family name. However such guarantees are rarely
> > > given.  
> > 
> > I see your point.
> > 
> > > Therefore for mprls0025pa I agreed for using one specific model
> > > for entire family.
> > > 
> > > https://lore.kernel.org/all/d577bc44-780f-f25d-29c6-ed1d353b540c@linaro.org/
> > > 
> > >   
> > > > 	reg = <0x28>;
> > > > 	honeywell,transfer-function = <0>;
> > > > 	honeywell,pressure-range = "250MD";
> > > > };
> > > > 
> > > > ie. specifying "hsc030pa" as driver while his chip is not in the 030PA range, but 250MD.
> > > > 
> > > > so do you prefer
> > > >  honeywell,trustability-hsc  OR
> > > >  honeywell,hsc030pa  
> > > 
> > > I think the latter, just like we did for mprls0025pa. How many devices
> > > do you have there?  
> > 
> > both hsc and ssc have 118 ranges, 4 transfer functions and both can be requested from the manufacturer with custom measurement ranges.
> > 
> > ok,I will rename hsc->hsc030pa in the code as you requested.
> 
> Where does pa come from? 

honeywell,hsc030pa was provided as an equivalent to honeywell,mprls0025pa (which is already in the repo).

'030PA' and '0025PA' define the pressure range (0-30, 0-25), the unit of measure (Psi) and the measurement type (Absolute) for a particular chip in the honeywell catalog. (please ignore the psi part, we convert everything to pascals).
but both my driver and Andreas Klinger's mprls0025pa actually provide a generic abstraction layer for entire series of sensors.

> If we are going generic, feels like trustability-ssc etc are more representative
> and matches the datasheet cover page.

Krzysztof voted for non-generic, honeywell,mprls0025pa is already set up non-generic, my intent was to go generic.

I'll rewrite the code to whatever you guys feel is best.

peter


-- 
petre rodan

