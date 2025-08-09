Return-Path: <linux-iio+bounces-22506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D03AB1F61F
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 22:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B70A189C423
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 20:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99427264630;
	Sat,  9 Aug 2025 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNHOnjGS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF66201276;
	Sat,  9 Aug 2025 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754769889; cv=none; b=DckQ3zIT6etbGCzVszbpYSBnEf3LiOeN4m3ZolAFYj9RRO5bRbJlxebQvmdlMvWtU1Ify3yvMT1ZbsH70lbIJn968a/NotR7+9SVTSVhQMwcMNRwcGrikogPHVtg+jxueVoiQ1Nu2R4c3YW4Oy4/VUKIrE4vtLRVZf89GXSLLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754769889; c=relaxed/simple;
	bh=q/5GUlOQTr3fIoGisjpYnV9hJAJvnNOPyRfBFJT/tI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbzmsbvdGWoI2DBt17Bjp3KAiw20gyKeCnHQjE8n0WRNYpAinI9iNzbyj5xAPsWaX2hcvOw27ji6K7nyvDWIJMwCRs/SiRdejFit1isMMYTj+KwecBuhBkrCG9LFb+2lLV+3kYadzOJNeevrqPP8U5n7iJbiuxuNPu2M9zVgSyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNHOnjGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3567C4CEE7;
	Sat,  9 Aug 2025 20:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754769888;
	bh=q/5GUlOQTr3fIoGisjpYnV9hJAJvnNOPyRfBFJT/tI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LNHOnjGSYFKTneIKoyjKE6Foh0RdoJKu7teJX+7SSrPMmTYlP0samtCL/dbRg4jda
	 ddktL6CQbZkcEDUDuSizAEYcWl6XQ8wNHBN0fXkb3thhC+hK3dffaDN1AXIWycS1nN
	 8SDTMtUSqW/uUveqzT+Gd7o3ucQGdGXUf0qk7PAVSoPPCHXhhRmvfPdHgBKSCNqe/e
	 gpL8h8OM6KFuVWNjtX9hIFjn1ZzX0FtfyAU56SfvNB9ke0E2PCnW1qfR4oGFEsbHrX
	 r0xhWWsjezGtLn/+mdu5c0yTDo8xt9bsdSkFxSak9ytDpTdgfswuxZ8N7Fhj2hdFe+
	 cCuPbyoMkhC6w==
Date: Sat, 9 Aug 2025 21:04:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Replace bouncing Analog emails
Message-ID: <20250809210438.23fb5fd0@jic23-huawei>
In-Reply-To: <20250728144901.3f646a4c@jic23-huawei>
References: <20250724113826.61998-2-krzysztof.kozlowski@linaro.org>
	<20250728144901.3f646a4c@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 14:49:01 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 24 Jul 2025 13:38:27 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > Emails to stefan.popa@analog.com and alexandru.tachici@analog.com bounce
> > permanently:
> > 
> >   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'
> > 
> > so replace them with Marcelo Schmitt from Analog where appropriate.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > I don't know who from Analog should maintain these devices, so I chosen
> > author from Analog of one of last commits.
> > 
> > Marcelo Schmitt, could you confirm that you are okay (or not) with this?  
> 
> Nuno, Michael, other ADI folk.  Can someone confirm if we are making these Marcelo's
> problem?
> 

As amusing as it would be for me, I definitely can't pick this up without
some tags from ADI folk and Marcelo in particular!!

Jonathan

> Jonathan
> 
> > ---
> >  Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml | 2 +-
> >  Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml   | 2 +-
> >  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml      | 2 +-
> >  Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml    | 1 -
> >  Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 2 +-
> >  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml   | 2 +-
> >  Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml   | 2 +-
> >  7 files changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > index 3dc973b98f81..40e9a40a7a60 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: ADIS16240 Programmable Impact Sensor and Recorder driver
> >  
> >  maintainers:
> > -  - Alexandru Tachici <alexandru.tachici@analog.com>
> > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> >  
> >  description: |
> >    ADIS16240 Programmable Impact Sensor and Recorder driver that supports
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > index 88aa67bf2280..55e44c9292cf 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
> >  
> >  maintainers:
> > -  - Stefan Popa <stefan.popa@analog.com>
> > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> >  
> >  description: |
> >    Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer that supports
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> > index 7146a654ae38..958a37def56c 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> > @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Analog Devices AD7124 ADC device driver
> >  
> >  maintainers:
> > -  - Stefan Popa <stefan.popa@analog.com>
> > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> >  
> >  description: |
> >    Bindings for the Analog Devices AD7124 ADC device. Datasheet can be
> > diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> > index 5207c919abe0..eac48166fe72 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> > @@ -9,7 +9,6 @@ title: Linear Technology / Analog Devices LTC2496 ADC
> >  maintainers:
> >    - Lars-Peter Clausen <lars@metafoo.de>
> >    - Michael Hennerich <Michael.Hennerich@analog.com>
> > -  - Stefan Popa <stefan.popa@analog.com>
> >  
> >  properties:
> >    compatible:
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> > index 82b0eed6a7b7..058df4c8ddf8 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> > @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Analog Devices AD5770R DAC device driver
> >  
> >  maintainers:
> > -  - Alexandru Tachici <alexandru.tachici@analog.com>
> > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> >  
> >  description: |
> >    Bindings for the Analog Devices AD5770R current DAC device. Datasheet can be
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > index 53d607441612..031b1657cde1 100644
> > --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Analog Devices ADF4371/ADF4372 Wideband Synthesizers
> >  
> >  maintainers:
> > -  - Popa Stefan <stefan.popa@analog.com>
> > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> >  
> >  description: |
> >    Analog Devices ADF4371/ADF4372 SPI Wideband Synthesizers
> > diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> > index 7a1a74fec281..e49d5e6fab61 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Analog Devices ADIS16480 and similar IMUs
> >  
> >  maintainers:
> > -  - Alexandru Tachici <alexandru.tachici@analog.com>
> > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> >  
> >  properties:
> >    compatible:  
> 
> 


