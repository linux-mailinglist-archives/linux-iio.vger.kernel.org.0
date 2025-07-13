Return-Path: <linux-iio+bounces-21618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7CEB031A9
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 17:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92691178FC5
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41472777F3;
	Sun, 13 Jul 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRu/mA34"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664901D52B;
	Sun, 13 Jul 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752418980; cv=none; b=OHz8A0oe1MINMNk3j5Ruus069Rb8EbviLpO32c9/+T9wQ1UndDsTMkQR8zwBD3oCaSrxYPtIuA3yOINCoVssp1Qf1rBfV+9h5m2mwx5zZ0GhcjTp9RWRSQfqix7Dh+1sA7V8IG3Fn+Sqzt+VJo5MW4HxBHsiTma9M7SecgvLql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752418980; c=relaxed/simple;
	bh=j/0dmZ5J6FfiPtzDxVic7+L+BjaVfzjdrObrU3kASsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CW3fVfB4SooLc41PfP6WJqf3MiR63iHWns/eeH0v1w+C9dO8OtwrWlCJaw3gE3NZjIT5dFnuHosuMQ3Z0u/YMnntUdH6s/9PRHw2jURxQq22p2FmBknJcp4UaxGJ4GMceO4PThAxkXdyydSAvG8KlicWEZNnGjKxzc5j2cEw56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRu/mA34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D22C4CEE3;
	Sun, 13 Jul 2025 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752418978;
	bh=j/0dmZ5J6FfiPtzDxVic7+L+BjaVfzjdrObrU3kASsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XRu/mA34eHN+f2azJjwRmOiDaO9ZEnXvbFqybf7em3oBrHOwbYMSn0e0Kd3+NCif/
	 VThzq94RuGyI07eh0N+JQHVszh7pEXnAyP+zaEB2AO3wdwkvYn6LdNT7wFo54L7QGv
	 naagZcPV40gl90P/8f0zLu6TWYWN0ZQYCZcPXMvA7Caz0NbLoitpDNMpy+xPWHPg+0
	 0kzaQNuH7775QSrL6DmiOoYcA0ciC+STsKck7bbtWtk4GEShcqPdnD8/6NOQJgLeqd
	 Gc/hLiwqVfkuiljn9QyaYUDh/XCXV80+DAeex8urQtgEd94G3cel8YIvbvol8NAe4H
	 Qnejh6/EoTNWA==
Date: Sun, 13 Jul 2025 16:02:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Primoz Fiser <primoz.fiser@norik.com>, Haibo Chen <haibo.chen@nxp.com>,
 Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 upstream@lists.phytec.de, andrej.picej@norik.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration
 properties
Message-ID: <20250713160247.0f22bbfe@jic23-huawei>
In-Reply-To: <2bcd758b-c2d0-488a-8ead-ec7fb39f93e2@baylibre.com>
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
	<20250710073905.1105417-2-primoz.fiser@norik.com>
	<2bcd758b-c2d0-488a-8ead-ec7fb39f93e2@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 10:46:44 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/10/25 2:39 AM, Primoz Fiser wrote:
> > From: Andrej Picej <andrej.picej@norik.com>
> > 
> > Document i.MX93 ADC calibration properties and how to set them.
> > 
> > Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> > Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> > ---
> >  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > index c2e5ff418920..d1c04cf85fe6 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > @@ -52,6 +52,27 @@ properties:
> >    "#io-channel-cells":
> >      const: 1
> >  
> > +  nxp,calib-avg-en:
> > +    default: 1
> > +    description:
> > +      Enable or disable calibration averaging function (AVGEN).
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 0, 1 ]
> > +
> > +  nxp,calib-nr-samples:
> > +    default: 512
> > +    description:
> > +      Selects number of samples (NRSMPL) to be used during calibration.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 16, 32, 128, 512 ]

Allow 1 as a value and drop the enabled above.   Averaging over 1 sample
is same as no averaging and gives simpler binding.

> > +
> > +  nxp,calib-t-sample:
> > +    default: 22
> > +    description:
> > +      Selects sample time (TSAMP) of calibration conversions in ADC clock cycles
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [ 8, 16, 22, 32 ]
> > +
> >  required:
> >    - compatible
> >    - reg  
> 
> This seem like things that should be set at runtime rather than
> in the devicetree. Unless there is some justification on why
> these values depend on how the chip is wired up?

Further to that, I'd like to see some explanation of why we care
to change it at all. Is it ever a bad idea to enable averaging and
pick a large number of samples for calibration?

> 
> 


