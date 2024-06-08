Return-Path: <linux-iio+bounces-6068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56279012DF
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A41B1F22013
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C9B335C0;
	Sat,  8 Jun 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjsorjkY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5501E4A6;
	Sat,  8 Jun 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717866120; cv=none; b=YrsIZZnuCZlGCafVqVnD3RkejxP22cRfWDNQvmYvq2KRWsy4bzB+bhE2SIgTLq05D8sbAoFxY1/nWyUnEYy4jz2oiXQv5PwcJUAdzjSR3/7k/bpIDaLAAZHMGN4CvAz5pqh2h1v2Q81NSJiFRueaehBN07/UnF34ONXFjJzzJiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717866120; c=relaxed/simple;
	bh=A3r29e7wb30cc4dRwLJF3YtUmAvgUID2/+yok408rUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7GBLuxBZWZRqqBR2jbPP97g4lvuTezEvaHtPQkiPTD14ddkvmwxISmw71AYag+dDL4Rj5rt6pAQ4RGsnNjbnt8fBH/2y38cpjCg9PUqBpDUmc3ylYJmbpNBMFGaKfhnGEogWdjs1deqjXpXBhh+cvXDGeZjKpGrI369ca+Lbq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjsorjkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74050C2BD11;
	Sat,  8 Jun 2024 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717866119;
	bh=A3r29e7wb30cc4dRwLJF3YtUmAvgUID2/+yok408rUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QjsorjkYeR5ot/2nx3YQdJ33Ltg7bo9ynIyZ0yy2tLEkL6WevQY/ox4rhbzKIuNL0
	 c4PnPynRch6bF7EhS431Yh7+23/1SCWMUxrScswPag2sVt30ceU55C5QgGJeVhweW9
	 0d2061sm+bLRZ5lhW4J/SSomJKUPG3ayYhr4lYfi09X7NiPaefdxSyMjOk/9fbCo3g
	 XSthg/0ScJ92zFZDO6RcKgLZuAwiNOx38r2rhCnn+Ir50cEoLpuLIY6IptQiTVGq9W
	 NOfNX8tP/gaO33ix+mMHJny9npkfZvbamHxNJh+C3x1ZcTi1kyxzQIHahEpmKPp8uF
	 9Ir41p0yUlElQ==
Date: Sat, 8 Jun 2024 18:01:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: andy.shevchenko@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
Subject: Re: [PATCH v4 1/2] dt-bindings:iio:proximity: Add hx9023s binding
Message-ID: <20240608180152.386db8a2@jic23-huawei>
In-Reply-To: <20240608175758.73396584@jic23-huawei>
References: <20240607114138.390272-1-yasin.lee.x@outlook.com>
	<SN7PR12MB810129D8180B1C9593A8E078A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
	<20240608175758.73396584@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Jun 2024 17:57:58 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri,  7 Jun 2024 19:41:37 +0800
> Yasin Lee <yasin.lee.x@outlook.com> wrote:
> 
> > From: Yasin Lee <yasin.lee.x@gmail.com>
> > 
> > A capacitive proximity sensor
> > 
> > Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>  
> Hi Yasin
> 
> Some improvements but seems you missed some of the feedback on v3.
> 
> See inline.
> 
> Jonathan
> 
> > ---
> >  .../bindings/iio/proximity/tyhx,hx9023s.yaml  | 103 ++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> >  2 files changed, 105 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> > new file mode 100644
> > index 000000000000..50bf2849d823
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> > @@ -0,0 +1,103 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TYHX HX9023S capacitive proximity sensor
> > +
> > +maintainers:
> > +  - Yasin Lee <yasin.lee.x@gmail.com>
> > +
> > +description: |
> > +  TYHX HX9023S proximity sensor
> > +
> > +allOf:
> > +  - $ref: /schemas/iio/iio.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: tyhx,hx9023s
> > +
> > +  reg:
> > +    maxItems: 1  
> 
> A device like this needs at least one power supply.  Make sure to document
> all such supplies and make the ones that are required for functionality part of
> your required properties.  Note that you should do this even if on your
> board they are always turned on.

Ignore this for obvious reasons given you have just below!  However should be
required.

> 
> > +
> > +  interrupts:
> > +    description: |
> > +      Generated by device to announce preceding read request has finished
> > +      and data is available or that a close/far proximity event has happened.
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    true  
>   vdd-supply: true
> 
> on single line is commonly done for these.
> 
> > +
> > +  channel-in-use:
> > +    description: |
> > +      Bit flag indicating which channels are used,
> > +      depends on the hardware circuit design.
> > +    $ref: /schemas/types.yaml#/definitions/uint32  
> 
> Presence of the channel nodes below should make this clear
> without a separate element.
> 
> 
> > +
> > +patternProperties:
> > +  "^channel@[0-9]+$":
> > +    type: object
> > +    properties:
> > +      reg:
> > +        description: Channel register address
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +      channel-positive:
> > +        description: Positive channel assignments
> > +        $ref: /schemas/types.yaml#/definitions/uint32  
> 
> That size seems implausible.  What are the limits. What does
> 255 mean?
> 
> In review of previous version I pointed you at the differential
> channel bindings for ADCs.  If they cannot be applied here
> explain why in your patch description.
> 
> > +      channel-negative:
> > +        description: Negative channel assignments
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +    required:
> > +      - reg
> > +      - channel-positive
> > +      - channel-negative
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      hx9023s@2a {
> > +        compatible = "tyhx,hx9023s";
> > +        reg = <0x2a>;
> > +        interrupt-parent = <&pio>;
> > +        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
> > +        vdd-supply = <&pp1800_prox>;
> > +        channel-in-use = <0x1F>;
> > +        channel@0 {
> > +          reg = <0>;
> > +          channel-positive = <0>;
> > +          channel-negative = <255>;
> > +        };
> > +        channel@1 {
> > +          reg = <1>;
> > +          channel-positive = <1>;
> > +          channel-negative = <255>;
> > +        };
> > +        channel@2 {
> > +          reg = <2>;
> > +          channel-positive = <2>;
> > +          channel-negative = <255>;
> > +        };
> > +        channel@3 {
> > +          reg = <3>;
> > +          channel-positive = <3>;
> > +          channel-negative = <255>;
> > +        };
> > +        channel@4 {
> > +          reg = <4>;
> > +          channel-positive = <4>;
> > +          channel-negative = <255>;
> > +        };
> > +      };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index b97d298b3eb6..e2224eea9ab9 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -1507,6 +1507,8 @@ patternProperties:
> >      description: Turing Machines, Inc.
> >    "^tyan,.*":
> >      description: Tyan Computer Corporation
> > +  "^tyhx,.*":
> > +    description: NanjingTianyihexin Electronics Ltd.  
> 
> Use a separate patch for the new vendor prefix.  Makes it easier for people to cherrypick that
> if they are backporting some other tyhx dt binding.
> 
> >    "^u-blox,.*":
> >      description: u-blox
> >    "^u-boot,.*":  
> 
> 


