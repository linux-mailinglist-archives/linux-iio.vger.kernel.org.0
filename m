Return-Path: <linux-iio+bounces-18700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4D8A9DBB6
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 17:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4FE3B9A9D
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAF825CC5A;
	Sat, 26 Apr 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZvCrrmB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B771FF1A0;
	Sat, 26 Apr 2025 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745680187; cv=none; b=XJrcPt9rSNNyyV8Ctk3MKkTJSUpqy2g96Dn32nSGURaIiEe1eeBJOuDHbYiYkafz7ticPIp9ZDAp4ezac8NqiD37Kb576NFVJzouAsjmlxnTrvwo609Y3DcHAUPp+giMzx5glWfLc7pUOuW7OQ26Lyxs7ZjWYMFcyE8mEM3x6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745680187; c=relaxed/simple;
	bh=GhYnFVouIIE+ko6ieTM9NhwAnDwzhHVa+LrMlsy+vO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKFzM2bfQAn0Vdm8+WKp67kSxCmtkeZ6nIkkJot5jNq/+dNQx1ZKvxWHwByXt67XbrWoWs/ata7ZZBvYSdeDvEJwk/14Xh2b9o/K3lx2xCkZPFcsecZczIqLY8J+oZhl1YzBz1azvtnnHvD9VUnxEMSArRbFaP1cNc886ym24VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZvCrrmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7CDC4CEE2;
	Sat, 26 Apr 2025 15:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745680185;
	bh=GhYnFVouIIE+ko6ieTM9NhwAnDwzhHVa+LrMlsy+vO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hZvCrrmBz1+Iv6Ce3icbmSFGg85MdsFOhclwuMNchybcZavfMH/bD3xTAoYSwu1vu
	 gf6vFB/Koc6fjxbVMy2c2HKmLnSN/O3T/c5VML6WputbfMZLTxs27mZz2dGS+BuOuC
	 SH2ZyNzJ6GyYtYFG5X0yrJyAorxmU1rDWDBKEPvUpauHLUbfmOFHmRhfBwIfoayKLj
	 QaB9cxrXl4Rf0li7BW87epUwDPWZQfFyFnt3YnLfUiknW40QSkBUIsbJSI1AxEag4d
	 38deGDk5Zgzs/eRKjPgqUdhNxD7OEvobWQ4aYCfFVxlGpallF+T+iWR4YTTliUMdbo
	 WjKY49HnfcoOQ==
Date: Sat, 26 Apr 2025 16:09:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, ~lkcamp/patches@lists.sr.ht,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings:iio:adc:st,spear600-adc: txt to yaml format
 conversion.
Message-ID: <20250426160938.50296f12@jic23-huawei>
In-Reply-To: <20250423201201.GA983074-robh@kernel.org>
References: <20250423022956.31218-1-rodrigo.gobbi.7@gmail.com>
	<20250423201201.GA983074-robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 15:12:01 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, Apr 22, 2025 at 11:14:23PM -0300, Rodrigo Gobbi wrote:
> > Straight forward conversion from spear-adc.txt into yaml format.
> > 
> > Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> > ---
> > After the conversion to yaml file, I was not sure about the
> > maintainers yaml field. It looks like the original driver author,
> > Stefan Roese, is not active contributing.
> > @Jonathan, I was not sure about it and I've added you on that field
> > as I've noticed at other yaml`s, but feel free to give any suggestions on that
> > or how to proceed in this case.  
> 
> That's fine I think, or you can add the spear platform maintainers.

Yeah. I'm fine with this as I get all the emails anyway  :)

Huh. I never knew or had long forgotten this file existed. Thanks for cleaning it up!

If anyone actually cares about this driver beyond for legacy support,
the binding and driver are a long way from meeting modern standards!

E.g. sampling frequency shouldn't be in DT, and the vref should be a supply.
The averaging thing is a userspace problem not DT.

Ah well. At this stage I guess indeed makes sense to document in yaml what is out there.


Jonathan

> 
> > 
> > Also noticed that the driver was moved out of staging, but the .txt was not
> > in that time. Added the yaml in the proper path (out of staging as the driver).
> > Tks and best regards.
> > ---
> >  .../bindings/iio/adc/st,spear600-adc.yaml     | 61 +++++++++++++++++++
> >  .../bindings/staging/iio/adc/spear-adc.txt    | 24 --------
> >  2 files changed, 61 insertions(+), 24 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
> > new file mode 100644
> > index 000000000000..a858b3f3c494
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/st,spear600-adc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ST SPEAr ADC device driver
> > +
> > +maintainers:
> > +  - Jonathan Cameron <jic23@kernel.org>
> > +
> > +description: |
> > +  Integrated ADC inside the ST SPEAr SoC, SPEAr600, supporting
> > +  10-bit resolution. Datasheet can be found here:
> > +  https://www.st.com/resource/en/datasheet/spear600.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - st,spear600-adc  
> 
> blank line
> 
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  sampling-frequency:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Default sampling frequency of the ADC  
> 
> Constraints?
> 
> > +
> > +  vref-external:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      External voltage reference in milli-volts. If omitted
> > +      the internal voltage reference will be used.  
> 
> Constraints?

> 
> > +
> > +  average-samples:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Number of samples to generate an average value. If
> > +      omitted, single data conversion will be used.  
> 
> Constraints?
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - sampling-frequency
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    adc: adc@d8200000 {
> > +        compatible = "st,spear600-adc";
> > +        reg = <0xd8200000 0x1000>;
> > +        interrupt-parent = <&vic1>;
> > +        interrupts = <6>;
> > +        sampling-frequency = <5000000>;
> > +        vref-external = <2500>;	/* 2.5V VRef */
> > +    };
> > diff --git a/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt b/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
> > deleted file mode 100644
> > index 88bc94fe1f6d..000000000000
> > --- a/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
> > +++ /dev/null
> > @@ -1,24 +0,0 @@
> > -* ST SPEAr ADC device driver
> > -
> > -Required properties:
> > -- compatible: Should be "st,spear600-adc"
> > -- reg: Address and length of the register set for the device
> > -- interrupts: Should contain the ADC interrupt
> > -- sampling-frequency: Default sampling frequency
> > -
> > -Optional properties:
> > -- vref-external: External voltage reference in milli-volts. If omitted
> > -  the internal voltage reference will be used.
> > -- average-samples: Number of samples to generate an average value. If
> > -  omitted, single data conversion will be used.
> > -
> > -Examples:
> > -
> > -	adc: adc@d8200000 {
> > -		compatible = "st,spear600-adc";
> > -		reg = <0xd8200000 0x1000>;
> > -		interrupt-parent = <&vic1>;
> > -		interrupts = <6>;
> > -		sampling-frequency = <5000000>;
> > -		vref-external = <2500>;	/* 2.5V VRef */
> > -	};
> > -- 
> > 2.47.0
> >   


