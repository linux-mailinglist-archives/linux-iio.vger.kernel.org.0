Return-Path: <linux-iio+bounces-20857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529F4AE303A
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A96167C5D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B2F1E5713;
	Sun, 22 Jun 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN8V4yeE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CFF1C5D72;
	Sun, 22 Jun 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750599907; cv=none; b=XYn5npqm6IQK5LchxgD22PwaEMPWSTdnaTPFp0o5Ub33uLdAexxmdoqFXXdwU47+YEtmnKOSSrNZbf16GMiKHRR4iFaZ6BfUqGqNV5Y26cI/Tmkw3dcgjHFR16NL+CIQGbEiNsjxjC5oHH3uMD9NNWKoEnZkmeJlfg5TKnN2GHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750599907; c=relaxed/simple;
	bh=ilWn7XOeuXoC5juMb98+zBTI8Ka9Yofz9iKQirS48FM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbPsr0xC4OTBJ0roujnZPZzjEhRn51leendd2EUSZqYWFDwBMJ6IBh/ilnRVjXeJuo3KGmaQ7Cc4Yh8O4qrh0hPTQTuB9+SWCmQzpyPDvwZoWF4+9eE5zFeHlr/kyZFbNzuA7tVpy2R/36DSYxB35+FgmJOqu0NuJgvOZPuwU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN8V4yeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42E8C4CEE3;
	Sun, 22 Jun 2025 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750599906;
	bh=ilWn7XOeuXoC5juMb98+zBTI8Ka9Yofz9iKQirS48FM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IN8V4yeEMylfbYbyYA8FLNbgYoY1BfApbZ5g0TcohHGDBdlMh37EUk0ArfrbBaahu
	 dJvvnQvpb/iknUC35OeXduRnT+evU6FeRmx5UuQgBElNwojkWwUBHdrS3vOzgV7sCs
	 Bmw+/V6omWi5HsR+rGuph0ikcXO5xTGol0gS2jX1Et0yCEdv5pTN292WzeMlbKNevi
	 omeKCixrwDS77vRjcV0ai57Y9Y0gN0+Uif2ctRqQj2umvkpTKwiotsfVrfueYAvezF
	 4y2k37vLg2rzuvZvFOG44+g7dUh6SFWR58M/uKyKj44YXoQ+R0MCz+b5ARqSD49JZ8
	 t7kwtZALsNuZA==
Date: Sun, 22 Jun 2025 14:44:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl, broonie@kernel.org,
 lgirdwood@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v6 01/12] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250622144455.6723be23@jic23-huawei>
In-Reply-To: <20250619-sitter-uranium-e7298befd733@spud>
References: <cover.1750258776.git.marcelo.schmitt@analog.com>
	<6399c1eb6d8e1bbdf720f189a7244b1d75a90ed2.1750258776.git.marcelo.schmitt@analog.com>
	<20250619-sitter-uranium-e7298befd733@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 16:35:48 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Jun 18, 2025 at 02:34:57PM -0300, Marcelo Schmitt wrote:
> > Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> > The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Change log v5 -> v6
> > - Made reference-buffer string type.
> > - Moved required section before patternProperties.
> > - Made avss, refin1n, refin2n documentation open to accepting positive and
> >   negative voltage specifications where appropriate.
> > 
> > The point of making avss-supply, refin1n-supply and refin2n-supply documentation
> > open to negative voltage values is to allow device tree to specify the regulator
> > true voltage level so the drivers won't need to workaround negative supplies in
> > the future.
> > 
> >  .../bindings/iio/adc/adi,ad4170.yaml          | 558 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 565 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> > new file mode 100644
> > index 000000000000..b7fe664bb87d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> > @@ -0,0 +1,558 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad4170.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD4170 and similar Analog to Digital Converters
> > +
> > +maintainers:
> > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > +
> > +description: |
> > +  Analog Devices AD4170 series of Sigma-delta Analog to Digital Converters.
> > +  Specifications can be found at:
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4170-4.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4190-4.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4195-4.pdf
> > +
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +$defs:
> > +  reference-buffer:
> > +    description: |
> > +      Enable precharge buffer, full buffer, or skip reference buffering of
> > +      the positive/negative voltage reference. Because the output impedance
> > +      of the source driving the voltage reference inputs may be dynamic,
> > +      resistive/capacitive combinations of those inputs can cause DC gain
> > +      errors if the reference inputs go unbuffered into the ADC. Enable
> > +      reference buffering if the provided reference source has dynamic high
> > +      impedance output. Note the absolute voltage allowed on REFINn+ and REFINn-
> > +      inputs is from AVSS - 50 mV to AVDD + 50 mV when the reference buffers are
> > +      disabled but narrows to AVSS to AVDD when reference buffering is enabled
> > +      or in precharge mode.  
> 
> > The valid options for this property are:
> > +      0: Reference precharge buffer.
> > +      1: Full reference buffering.
> > +      2: Bypass reference buffers (buffering disabled).  
> 
> You forgot to remove this text. With that gone, I think this is
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> and that's explicitly an ack not an r-b cos I would like to see the lads
> being happy with what you've done.
Hi Conor, All,

I'm fine with it (late reply to earlier version) but I'm definitely keen to
get other opinions on this as we are setting a new standard for how to cleanly
handle excitation voltages etc in this binding.

Thanks

Jonathan



