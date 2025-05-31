Return-Path: <linux-iio+bounces-20085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BD5AC9C07
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 19:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E26189161C
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F1E18785D;
	Sat, 31 May 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rStIi3o5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC13B19A;
	Sat, 31 May 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748712415; cv=none; b=Lj0x2YJ4mMisB7hragDnjfGquMcv/ymS/2JE+BM+qqeLBolzS5UXrJyxZRk92hsfTBQSRar0K8ETK/ilOuuPbv3MgGoAneCbfLtjhJ13AXVotZdcmNWVvBLFuqr+85IygKTw7YyjIXklO7hx1O++vLRwp2U9+2TOt5DE+kzeH24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748712415; c=relaxed/simple;
	bh=WHsi1ccAgcNzO9ODFLpSz1YM367cGiZ7LVA7rEgY1II=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcdjcR3jR1+VX+c9rlxJWGu6Mqq2K61BgfPF1fl2tdKqhalyE/9E5RJVzX5Sa9IR1QA7ZcGEePETSbnv8omvCuX97VuTDHTyJWZ5zmIKLFw3g1YnLXwhnpAjZJ/4uzkGVwCId5cHNZn2CkJRg/0NFQ6UtcnpzwQxJ/fWcm5FqeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rStIi3o5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E975C4CEE3;
	Sat, 31 May 2025 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748712414;
	bh=WHsi1ccAgcNzO9ODFLpSz1YM367cGiZ7LVA7rEgY1II=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rStIi3o5dKFpDvK0+IpnTBAPpOWXeT/I2GuXvSF0XaFk5/0dHmGTVWlXKXtiSF0Gn
	 +qOrmk1q9RnZMN3ONT6xzn+KDaRJgq8Ux/TYiu8YEfFxWX4D8ilSrnCKuGoyuhCo7X
	 pUQRReVui4v1vTnPXNkV0mz8LFx9m2VBuzJWB6trtW7rI4/9e3A8PrFDKyWHvkXJzQ
	 RTC+SEwPOgA/CeRboUYzsBKr7hxbKI2LufNzuj33bKQHatuNp/LVSOlvc21uUpbIV/
	 Wli19bMAi3jyXZAbO2ZhttcN0/86SjEEwWMDA6FlLvrpjlrFMa5q32OpyOT5wQksmg
	 UpDCoYAvZGBcg==
Date: Sat, 31 May 2025 18:26:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <manuel.stahl@iis.fraunhofer.de>,
 <~lkcamp/patches@lists.sr.ht>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: gyroscope: invensense,itg3200: add
 binding
Message-ID: <20250531182643.78a54688@jic23-huawei>
In-Reply-To: <20250530175649.000005d0@huawei.com>
References: <20250527210308.4693-1-rodrigo.gobbi.7@gmail.com>
	<20250530175649.000005d0@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 May 2025 17:56:49 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Tue, 27 May 2025 17:55:28 -0300
> Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:
> 
> > There is no txt file for it, add yaml for invensense,itg3200 gyroscope.
> > 
> > Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> > ---
> > Originally I`ve added @Jonathan as the binding maintainer due another thread
> > but @Krzysztof mentioned at v1: "...this should be someone interested in the hardware".
> > I`m not sure who might be this person in this case, a reasonable choice would be
> > the original author of the driver, but looks like his last patch is from a
> > long time ago [2] but I`ll ping here.
> > 
> > Dear @Manuel Stahl, I`ve noticed that since the driver was added,
> > there was no binding doc for it and this is what this patch is addressing.
> > In this case, a maintainer ref is required inside the .yaml file and I would
> > like to ask if I can add you in this case. 
> > I would appreciate your comment or suggestion over this topic.  
> 
> Manuel has not been active for quite a while. You never know though!
> 
> Fall back to me if needed given I end up seeing all these changes anyway.
> 
> I can make that change whilst applying.
> 
Tweaked to change this and add the note from Krzysztof to the commit
message. Applied

Thanks,

Jonathan

> Jonathan
> 
> > 
> > Tks all and regards.
> > 
> > Changelog:
> > v2: 
> >     - removed the register map link; there is no datasheet available at public ref. At [1],
> >     it is just a product overview, so we can`t use it;
> >     - add supplies and external clocks (I`ve used as ref iio/gyroscope/invensense,mpu3050.yaml);
> >     - add the author of the driver as the maintainer of this file but I`m CC him in
> >     order to get his opinion about it;
> >     - adding some CC missing at v1;
> > 
> > v1: https://lore.kernel.org/linux-devicetree/20250515002817.81863-1-rodrigo.gobbi.7@gmail.com/
> > 
> > [1] https://invensense.tdk.com/products/motion-tracking/3-axis/itg-3200/
> > [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=author&q=Manuel+Stahl
> > ---
> >  .../iio/gyroscope/invensense,itg3200.yaml     | 59 +++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml b/Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml
> > new file mode 100644
> > index 000000000000..4b2f9a57c6ea
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/gyroscope/invensense,itg3200.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Invensense ITG-3200 Gyroscope
> > +
> > +maintainers:
> > +  - Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> > +
> > +description: |
> > +  Triple-axis, digital output gyroscope with a three 16-bit analog-to-digital
> > +  converters (ADCs) for digitizing the gyro outputs, a user-selectable internal
> > +  low-pass filter bandwidth, and a Fast-Mode I2C.
> > +
> > +properties:
> > +  compatible:
> > +    const: invensense,itg3200
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +
> > +  vlogic-supply: true
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  mount-matrix:
> > +    description: an optional 3x3 mounting rotation matrix.
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ext_clock
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        gyroscope@68 {
> > +            compatible = "invensense,itg3200";
> > +            reg = <0x68>;
> > +            interrupt-parent = <&gpio2>;
> > +            interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
> > +        };
> > +    };  
> 


