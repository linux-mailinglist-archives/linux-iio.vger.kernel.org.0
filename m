Return-Path: <linux-iio+bounces-20070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4919AC9B96
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15527ACC86
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972B81531E1;
	Sat, 31 May 2025 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBtwwE+k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B6117BB6;
	Sat, 31 May 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748706642; cv=none; b=mLdTn/ZzlMhH4ZpdJ8XzvdS2sGXyO8woQk8glUZD21DDWR5VK90UeRprL/C8QAjMnrVZ0DW8o61lgwTcfX3i2L5JQV0UFA5ocD82ATExVXQfIWxNC2+LY09C7bH+Xen5kCn4DGQB1GlZU2ewrmiHefklNmqKbJUpkj9o/c9FijA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748706642; c=relaxed/simple;
	bh=eI19CTNEOdH781i8gsxlfOonT+Lz1KC/cydNhSmDoFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQuOWl/m/W8uo2qcAgC4TOcWd02kqbJFcOBaNpzLmDTos1JwnqJMsREiJTiH78XShfwHHeRLO/Y0zIr5OShflRVdJ5GQL5+KFqFm9auyqeWgVURmClawiuserw6RxREyygVHtoIDXZ7Ce+BlcivjeeujY3d5x3a7Pf/GmLI64RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBtwwE+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08393C4CEE3;
	Sat, 31 May 2025 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748706641;
	bh=eI19CTNEOdH781i8gsxlfOonT+Lz1KC/cydNhSmDoFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DBtwwE+kYQHknxs+X6DNnCMF+j+ncLJtzpvuJWAAGXZ1XfEPud4DLMdf4tWt2o28X
	 mHxAfnw90M/hJGeQDdXn2FVilxn+0wBl9y3ldetLAhBkSto0py+16kdlXtoLECMDer
	 sQ6T5rCVjrhZSAoJAZLlcSbyK/tKXCD62N9t0WpabWAZVUc0NNcYUNtvbTz6dOOtcu
	 EO4cEsX5U9Qwk6BmbT/WXUq1h9nAHiz4BdeJlovgEHJ7UQns23rAIsJHRBSGO3QkeU
	 lv0fvDO7gMz4Ehq/BqUw15NlLVa0rO4aZQ7Yyd29AYKs9u8JgXlSqhNyS28hsG8mOf
	 3zQu2uN41H5IQ==
Date: Sat, 31 May 2025 16:50:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250531165030.17916667@jic23-huawei>
In-Reply-To: <aDTkVFDNYeyIldBs@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
	<5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
	<20250525111148.4ca96a55@jic23-huawei>
	<aDTkVFDNYeyIldBs@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 18:59:48 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Jonathan,
> 
> I'm still working on the changes suggested for this set.
> Just to mention, I've updated the dt-binding to declare only channel nodes under
> the ADC node.
> 
> ... 
> > > +      adi,sensor-type:
> > > +        description: |
> > > +          Type of sensor connected to the device. Depending on the sensor type
> > > +          (weigh scale, RTD, or thermocouple) the values of sensor-node
> > > +          properties have slightly different constraints. This property
> > > +          specifies which particular external sensor is connected to the ADC so
> > > +          the sensor-node properties can be properly parsed and verified. The
> > > +          possible sensor types are:
> > > +          0: weigh scale;
> > > +          1: RTD;
> > > +          2: thermocouple.
> > > +        $ref: /schemas/types.yaml#/definitions/uint8  
> > 
> > I think this should be an enum of strings.  That will give us a clean
> > way to extend it for other sensor types in future.  
> Ack
> 
> ...
> > > +
> > > +  interrupts:
> > > +    maxItems: 1  
> > 
> > What if they are both wired?  At that point shouldn't software
> > make up it's mind which to use?  
> 
> Not sure I understand the concern here. Is 'interrupt-names' property expected
> to precede 'interrupts' in dt-doc? For AD4170 and similar parts, the data
> ready signal (/RDY) is by default provided on the SDO line after the completion
> of a conversion. Alternatively, it can be provided on the DIG_AUX1 pin in
> which case the chip disables the RDY function on SDO. So, there can only be one
> data ready interrupt enabled at a time. Guess I'll add some description to make
> clear only one interrupt can be enabled.

DT is describing the wiring, not what should be enabled by the driver.

There is no need for it to restrict to 1 interrupt if someone has wired them
both that I can think of.  In that circumstance the driver gets to decide
between the mess of shared SDO / dataready handling vs a nice
separate signal on dig_aux1

If both are wired to the host on appropriate pins, up to the driver to
decide what it wants.  A driver may also only supports the
dig_aux1 combination or only the sdo combination and so just fail to load
if it isn't happy with the one the DT author thought mattered.
Providing both if that is what is wired, gives the flexibility to find
the right one. 

> 
> > > +
> > > +  interrupt-names:
> > > +    description:
> > > +      Specify which pin should be configured as Data Ready interrupt.
> > > +    enum:
> > > +      - sdo
> > > +      - dig_aux1
> > > +    default: sdo
> > > +  
> 
> Thanks,
> Marcelo
> 


