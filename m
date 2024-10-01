Return-Path: <linux-iio+bounces-9966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF82498C3CB
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 18:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BED5B22614
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D1A1C9EDE;
	Tue,  1 Oct 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l45rJcKq"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC11B6525;
	Tue,  1 Oct 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801169; cv=none; b=HDGYwROJ/wTL7c6TCnCPHYnpJs7XtSgGHpDSK5ipXRjlQunx7jOvKTIRr7prNptjQCeiI2n9gorYl2xMNAr8MqpJZOL1uZa6YnpkF3J3l/vZLwkSjZnzvpzHbZ3LK4HlkA8P/IHEMEE4Ol2834TkOS3jmtT/XNC0Pg8R+F4eoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801169; c=relaxed/simple;
	bh=SZASKN+5xsOV3b8ktUbRtvJXG9BOAXsvWWNDzwbNBJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxpIra7IjXOQUv8U08dRXO+NOL1LGv7Nzxny14cKeKRwHIlbX8oIoubLLLT0rJJ/pln22vsC6QU5Ni+Rf+P5NbZ9KpEoctqW8HHaKL0U1cg5cR22nUxN0WM1cAAcEZe58/Ym1ZaQI4y1aWmgnyGtUgiSC+H+H6xh14KeKqD24Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l45rJcKq; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C3041C0004;
	Tue,  1 Oct 2024 16:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727801164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPxHZTnimw7YmqoE2OoW9CkXC2C4BqOT23LGHHhxA4Q=;
	b=l45rJcKqdqwj8LQD8L5hlC3YPpDfjZbZyeoe36Q85DqI5tTKosvZF+3CythqSFpJ+MItCL
	JE9NCiKUu9rTm6MmZEvVbdytWoFNRAaV6iGpTmxDHOeivTh1BKu92qLrlOFuwOIDnkRbxL
	A1gKSdXIKGF4NsIBee09OxiD2BplnFdsF1B5FG17lhmqg8MPUGbLhZJnquiqqLCcNLYR0h
	Zu3w1IQnPnY+q1uN7FVEOzGW5XbqrkXE6fvYZ02zDQblgDlGZm0q49I4/zSZmeMVWl5XCx
	+IvG+BMmwCptGIWc1qIVVR3x9XDQ9gDOmLPSOp4EemcZav6nZiLKJYkgeoXk2Q==
Date: Tue, 1 Oct 2024 18:46:02 +0200
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
Message-ID: <20241001184602.7912c10d@bootlin.com>
In-Reply-To: <20241001-corrode-preteen-546c98d45976@spud>
References: <20241001074618.350785-1-herve.codina@bootlin.com>
	<20241001074618.350785-3-herve.codina@bootlin.com>
	<20241001-corrode-preteen-546c98d45976@spud>
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

On Tue, 1 Oct 2024 17:18:30 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Oct 01, 2024 at 09:46:16AM +0200, Herve Codina wrote:
> > The GE HealthCare PMC Analog to Digital Converter (ADC) is a 16-Channel
> > (voltage and current), 16-Bit ADC with an I2C Interface.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../bindings/iio/adc/gehc,pmc-adc.yaml        | 82 +++++++++++++++++++
> >  include/dt-bindings/iio/adc/gehc,pmc-adc.h    | 10 +++
...
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: osc  
> 
> Since there's no datasheet for me to look up, why is the clock optional?

The component uses an external oscillator (osc) if an external oscillator is
connected to its clock pins. Otherwise, it uses an internal reference clock.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

