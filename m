Return-Path: <linux-iio+bounces-16182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CE8A495E7
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 10:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5541665B0
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31948258CEC;
	Fri, 28 Feb 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="KyOmbAUS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3362586EE
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736314; cv=none; b=pRyADEUKKzZlzbHvh0O9hv3FiEuHzBrN21kSCr7SyCqLTBiMFNVmnZjoJx9WBahWNHWvqV5nyFY5cvgKShg6Ks/Oh9MklkPkTuDcSgUupRJH9A6NcS5pU4TbZyKcHTZdhEiC7H+7g4oIMI/GoDGxQD6EDSMg8FekWpLHP8w3tlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736314; c=relaxed/simple;
	bh=1POxM+YNos0rQ18B+S0WoanQBby0ss5pdHhSNwVN8og=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nY44vOghFJhG4cQiu3wFlKnAx07pJqXjUEyBH2DpDQWEX12EwumlQ4NUFcwurYIsro0qkKnecrCYBWULJ6NFslz69wLH9T8v7cZn9rMv9616Ua/wrD8zqwM7LwxWVcf1UOm6wZZTKzydDkjjAaAR6rOTYzjGFwixllUC+O6mVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=KyOmbAUS; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=VJRidcZcWpHj1I/U4Mrb0EwgP+6UlUZKRuBucRBAGyA=;
	b=KyOmbAUSef64n+MHafejkId+g2ivBrnLBzaDlWzX/1XHWmZMLt/AgGpEYmypxrOkO3fDqkm1SlBgT
	 bYz0tqly2CpzylTLtZriargHceUM5gzNsSTaUhj+as1KXpgd4HGOOWK8yQLBdanQ6bNYvpg9IAdl4j
	 CmodIXDsC4FLkC0kPOujqm8IfBDIz8/bEx89MSG3hMBcO12M8G8FJ7fzjvYdj2+6C5ok/qZU96hdt8
	 xNitj8nZVrfWURyqShPb1V2NtkGB/6DnfrlokR4eWDROaThVH0hvxbCy5l85pyEm3LeZ5xAp5nSKmt
	 AzqjphEbqYGgmqfJlcy2uAPaAEOPN0A==
X-MSG-ID: a11260a2-f5b9-11ef-a39b-00505681446f
Date: Fri, 28 Feb 2025 10:51:48 +0100
From: David Jander <david@protonic.nl>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, david@protonic.nl
Subject: Re: [RFC PATCH 6/7] dt-bindings: motion: Add adi,tmc5240 bindings
Message-ID: <20250228105148.5f465aa3@erd003.prtnl>
In-Reply-To: <99c437db-6341-4d56-b99e-3ed3f2b8219d@kernel.org>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-7-david@protonic.nl>
	<20250228-groovy-lyrical-skunk-751ee3@krzk-bin>
	<20250228094818.0aad5491@erd003.prtnl>
	<99c437db-6341-4d56-b99e-3ed3f2b8219d@kernel.org>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 10:35:38 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 28/02/2025 09:48, David Jander wrote:
> > 
> > Dear Krzysztof,
> > 
> > Thanks for reviewing...
> > 
> > On Fri, 28 Feb 2025 08:11:04 +0100
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >   
> >> On Thu, Feb 27, 2025 at 05:28:22PM +0100, David Jander wrote:
> >> [...]  
> >>> +
> >>> +  enable-supply:
> >>> +    description: Optional external enable supply to control SLEEPn pin. Can    
> >>
> >> That's odd. regular pins are not supplies. This must be named after
> >> physical supplies. There is vdd18, vcc, vcp but nothing about enable
> >> supply in datasheet.
> >>  
> >>> +      be shared between several controllers.    
> >>
> >> Second sentence is both redundant and really not relevant to this
> >> binding. It's not this binding which decides about sharing.  
> > 
> > Good point. I think I should drop the whole property, since it is indeed
> > irrelevant. If extra supplies need to be specified, they always can be, right?  
> 
> You should specify all supplies now, because hardware should be fully
> described by binding and DTS.

In the case of the hardware I use for testing all of this, there are several
tmc5240 chips which have their "SLEEPN" pin tied together controlled by a
single GPIO pin that needs to be pulled high before any of these chips can be
talked to. The usual way I know of solving this is by specifying a common
"virtual" supply of type "regulator-fixed" with an enable gpio.
But this isn't strictly a supply that has to do with this chip or driver, so I
don't think it should be specified in the schema. I do need to use it in my
particular case though. Is there a better way of doing this?

> What's more, the necessary supplies (according to datasheet) should be
> required, not optional.

Do you mean that they should be in the binding definition as well? I.e. add
all of Vs, Vdd1v8 and Vcc_io here?

Best regards,

-- 
David Jander

