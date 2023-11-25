Return-Path: <linux-iio+bounces-369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC12A7F8DE6
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 20:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5211C20C06
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 19:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091992F848;
	Sat, 25 Nov 2023 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb6FVtOk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094ECA69;
	Sat, 25 Nov 2023 19:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6713C433C8;
	Sat, 25 Nov 2023 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700940092;
	bh=1WVqsLzDFggpUKiGezfN49UcPqnUKcOjEe2mjRbMP68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sb6FVtOkCPaRpLPtg39IxHFpRR+ZGljFDCKQdlnhkgIeNSWBwB8bJiHn/DNCTCLL3
	 Vvpv8lcYUzPEN/+Ng0TTHMD2H73NK7lTGl0ULecuSORNkbRfSxaWcrieVlh+JbM/W9
	 ZdrXI/JuVoXZj7bwqR0aFJhKm1UuL9IZma45ZcosTtpLwkDrdQ8QGHYWLqYFHv8VxK
	 H8VO6ytzhzA4YaAcZKB4k9fdulwhI3qMqCe+KKiQFpKfbp0uydnFmZzl8jspqFFQPc
	 sA/CP+YskZm8IzezzUj894fdmqenyp66/QYTPogPFsQV1f0U0mUwM+4qGrTcjswtfs
	 xB6F4ROhy8hvA==
Date: Sat, 25 Nov 2023 19:21:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <20231125192126.55cda541@jic23-huawei>
In-Reply-To: <ZVukhMcY8A3Crxc_@sunspire>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
	<20231117192305.17612-1-petre.rodan@subdimension.ro>
	<5b2e4b05-9408-48ea-92ac-15883e102013@linaro.org>
	<ZVtiVM2Gm1x1j_G1@sunspire>
	<8aa11758-5eee-427b-adcb-c3578a521daf@linaro.org>
	<ZVtv8x8LqGMhCisw@sunspire>
	<20231120173929.00006a6d@Huawei.com>
	<ZVukhMcY8A3Crxc_@sunspire>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 20:25:08 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hello!
> 
> On Mon, Nov 20, 2023 at 05:39:29PM +0000, Jonathan Cameron wrote:
> > On Mon, 20 Nov 2023 16:40:51 +0200
> > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> >   
> > > Hello!
> > > 
> > > On Mon, Nov 20, 2023 at 03:04:07PM +0100, Krzysztof Kozlowski wrote:  
> > > > On 20/11/2023 14:42, Petre Rodan wrote:
> > > >     
> > > > >>> +properties:
> > > > >>> +  compatible:
> > > > >>> +    enum:
> > > > >>> +      - honeywell,hsc    
> > > > >>
> > > > >> Way too generic    
> > > > > 
> > > > > I'm new to this, please excuse my ignorance.
> > > > > my driver covers all Honeywell pressure sensors under the "TruStability board mount HSC/SSC" moniker.    
> > > > 
> > > > We talk here about bindings, not driver. For the driver you can use
> > > > whatever name is approved by reviewers of your driver.
> > > >     
> > > > > that is why my intention was to provide a rather generic name for the driver itself.
> > > > > are you afraid that they will come up with a different device that they will call "hsc" in the future?
> > > > > in this case honeywell,trustability-hsc would be fine?
> > > > > 
> > > > > as I see you prefer to target a particular chip, but I am a bit afraid that the end-user will be confused by needing to set up something like
> > > > > 
> > > > > pressure@28 {
> > > > > 	compatible = "honeywell,hsc030pa";    
> > > > 
> > > > The compatible should be specific, thus for example match exact model
> > > > number.    
> > > 
> > > there are an infinite number of combinations of 4 transfer functions and 118 ranges + one custom range, so providing an array with all specific chips that could end up as compatible is out of the question.
> > > I was aiming at providing a generic name for the binding and get the transfer function and the pressure range as required parameters.
> > >   
> > > > If you can guarantee that all devices from given family are the same in
> > > > respect of programming model and hardware requirements (e.g. supplies),
> > > > then you could go with family name. However such guarantees are rarely
> > > > given.    
> > > 
> > > I see your point.
> > >   
> > > > Therefore for mprls0025pa I agreed for using one specific model
> > > > for entire family.
> > > > 
> > > > https://lore.kernel.org/all/d577bc44-780f-f25d-29c6-ed1d353b540c@linaro.org/
> > > > 
> > > >     
> > > > > 	reg = <0x28>;
> > > > > 	honeywell,transfer-function = <0>;
> > > > > 	honeywell,pressure-range = "250MD";
> > > > > };
> > > > > 
> > > > > ie. specifying "hsc030pa" as driver while his chip is not in the 030PA range, but 250MD.
> > > > > 
> > > > > so do you prefer
> > > > >  honeywell,trustability-hsc  OR
> > > > >  honeywell,hsc030pa    
> > > > 
> > > > I think the latter, just like we did for mprls0025pa. How many devices
> > > > do you have there?    
> > > 
> > > both hsc and ssc have 118 ranges, 4 transfer functions and both can be requested from the manufacturer with custom measurement ranges.
> > > 
> > > ok,I will rename hsc->hsc030pa in the code as you requested.  
> > 
> > Where does pa come from?   
> 
> honeywell,hsc030pa was provided as an equivalent to honeywell,mprls0025pa (which is already in the repo).
> 
> '030PA' and '0025PA' define the pressure range (0-30, 0-25), the unit of measure (Psi) and the measurement type (Absolute) for a particular chip in the honeywell catalog. (please ignore the psi part, we convert everything to pascals).
> but both my driver and Andreas Klinger's mprls0025pa actually provide a generic abstraction layer for entire series of sensors.

ah ok. That's fine then - searching the datasheet I found didn't include that particular
string, so I was rather confused.

I'm fine with specific now you've explained where it came from!

Jonathan

> 
> > If we are going generic, feels like trustability-ssc etc are more representative
> > and matches the datasheet cover page.  
> 
> Krzysztof voted for non-generic, honeywell,mprls0025pa is already set up non-generic, my intent was to go generic.
> 
> I'll rewrite the code to whatever you guys feel is best.
> 
> peter
> 
> 


