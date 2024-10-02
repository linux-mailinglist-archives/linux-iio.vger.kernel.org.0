Return-Path: <linux-iio+bounces-9998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EAC98CD97
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 09:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C0D1C215AB
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923814A08D;
	Wed,  2 Oct 2024 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NuUDsuGe"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91911FBA;
	Wed,  2 Oct 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727852698; cv=none; b=X1IKLPJOdXtXUJhEYQsUahNauDlh9mn6vOzOuy/l2LXZPDN8+JNWGkJuRgZuOxIVeE63UpmlG18kdwe+2KecsVxOR4u5UUAOybFJnp8rwbbOU7+d49A7vx2zZYMja2M7MQ+iB47+6W57KGagJbJg0whhJGIXPmCBZfZUg6vwFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727852698; c=relaxed/simple;
	bh=AFjJRt6m9eU8KZfNTKbNzUefzc0+BcxGjnILHXjrYWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKqzUsSfDD+rvNLGzNY0viN76XZKsZL05WKEvQO+SGA5GfOwal27SkZKbIVXETK3dvCuapHewv7NxnDAuuogTRnKWDidZNUnN8Dst1ZY5E2Df0PexgpQiEzCoHxocCWcDAeu8HCOJiXVIT3Rptq+7VQt8jjuzCcKpshzcuYaTgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NuUDsuGe; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDE4DFF80D;
	Wed,  2 Oct 2024 07:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727852694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjrnonK4tWVQHRAo83PBuo98dJM/hoah/cwh0KZacg0=;
	b=NuUDsuGe8gJx4NyR66IrKE/w66FAcIfa8AGx5xjDuyoZL0v8kkw1oWch0EhSUWd09Wyr+q
	YcUyv1CymK7DSS6xhnlMNxaUpqYIkxcrItV5o8sDrDmcNJoqsVpEgUwl1ZQBOVawmb9q8A
	6KPfhzQs/qpUvCc876MdeaOtr2glQsbP/QyZV12d3NOzjkCLNkury+MZmwTde4M6iQwNQv
	c/BXZGnyi1EaaQaPSao0Qc3oDxbURKnYJelEq2YnhxQlCRCBfeHf1aQG9GMx/l1x0fndjS
	FP6OzoqEcVpR7UGg5lq7NEAj44c6+sfwX13jZOfpQUIibPlNcu/F2Ex7yFLLiA==
Date: Wed, 2 Oct 2024 09:04:53 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: Add the GE HealthCare PMC
 ADC
Message-ID: <20241002090453.0849b668@bootlin.com>
In-Reply-To: <20241001-gruffly-cruelness-b8aed444c36e@spud>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
	<20241001074618.350785-3-herve.codina@bootlin.com>
	<20241001-corrode-preteen-546c98d45976@spud>
	<20241001184602.7912c10d@bootlin.com>
	<20241001-gruffly-cruelness-b8aed444c36e@spud>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Conor,

On Tue, 1 Oct 2024 18:03:37 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Oct 01, 2024 at 06:46:02PM +0200, Herve Codina wrote:
> > On Tue, 1 Oct 2024 17:18:30 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> > > On Tue, Oct 01, 2024 at 09:46:16AM +0200, Herve Codina wrote:  
> > > > The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
> > > > (voltage and current), 16-Bit ADC with an I2C Interface.
> > > > 
> > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > ---
> > > >  .../bindings/iio/adc/gehc,pmc-adc.yaml        | 82 +++++++++++++++++++
> > > >  include/dt-bindings/iio/adc/gehc,pmc-adc.h    | 10 +++  
> > ...  
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: osc    
> > > 
> > > Since there's no datasheet for me to look up, why is the clock optional?  
> > 
> > The component uses an external oscillator (osc) if an external oscillator is
> > connected to its clock pins. Otherwise, it uses an internal reference clock.  
> 
> Could you please add a description of the clock with this statement,
> given there's no datasheet or w/e linked here?

Sure, I will add a description in the next iteration.

There is no datasheet or any similar document available for this component.
This is reason why I cannot add a link to this kind of dos.

Best regards,
Hervé

