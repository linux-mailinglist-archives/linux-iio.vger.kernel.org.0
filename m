Return-Path: <linux-iio+bounces-20047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B938AC940C
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 18:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181871894F41
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF04235068;
	Fri, 30 May 2025 16:56:57 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655034431;
	Fri, 30 May 2025 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624217; cv=none; b=NJEc+25ZeIiAapOjpPT0wL75cufyeDzxbHb5EPD6yasWwOnWFMF4872GuHn1e5+QLhr8Il+i1aBE3IPz9jmZsiR846yVgLrAhZi4Dkp7AUtaue3R/T3Kqzr+8APB7h7q8kGZ/ZfaPDwCCgLWbXyoA+8JfUywDFtYyxsayJd/y/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624217; c=relaxed/simple;
	bh=X7cpegp2UbpSBxXPF/B2OYNV11nvguV8s1OAoSDsrFk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azDLDQEWxDpBawf+jBQBCuo56xcVD/GmYdAo4XByb2FwvLRAlaDEM2MDCy9kCsqsS908naxkj0YzF2h4j1DS9QF1O9WdpXmtS83BSAoVJYeuX3/Cqjzgp3wXxfFczrfALxVEiXAmwLUVTp8t2oAq28bUjJjkg9/NSFnHcZG0HD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b88W90j2dz6K5lR;
	Sat, 31 May 2025 00:55:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EC4431402E9;
	Sat, 31 May 2025 00:56:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 18:56:51 +0200
Date: Fri, 30 May 2025 17:56:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
CC: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <manuel.stahl@iis.fraunhofer.de>,
	<~lkcamp/patches@lists.sr.ht>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: gyroscope: invensense,itg3200: add
 binding
Message-ID: <20250530175649.000005d0@huawei.com>
In-Reply-To: <20250527210308.4693-1-rodrigo.gobbi.7@gmail.com>
References: <20250527210308.4693-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 27 May 2025 17:55:28 -0300
Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:

> There is no txt file for it, add yaml for invensense,itg3200 gyroscope.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Originally I`ve added @Jonathan as the binding maintainer due another thread
> but @Krzysztof mentioned at v1: "...this should be someone interested in the hardware".
> I`m not sure who might be this person in this case, a reasonable choice would be
> the original author of the driver, but looks like his last patch is from a
> long time ago [2] but I`ll ping here.
> 
> Dear @Manuel Stahl, I`ve noticed that since the driver was added,
> there was no binding doc for it and this is what this patch is addressing.
> In this case, a maintainer ref is required inside the .yaml file and I would
> like to ask if I can add you in this case. 
> I would appreciate your comment or suggestion over this topic.

Manuel has not been active for quite a while. You never know though!

Fall back to me if needed given I end up seeing all these changes anyway.

I can make that change whilst applying.

Jonathan

> 
> Tks all and regards.
> 
> Changelog:
> v2: 
>     - removed the register map link; there is no datasheet available at public ref. At [1],
>     it is just a product overview, so we can`t use it;
>     - add supplies and external clocks (I`ve used as ref iio/gyroscope/invensense,mpu3050.yaml);
>     - add the author of the driver as the maintainer of this file but I`m CC him in
>     order to get his opinion about it;
>     - adding some CC missing at v1;
> 
> v1: https://lore.kernel.org/linux-devicetree/20250515002817.81863-1-rodrigo.gobbi.7@gmail.com/
> 
> [1] https://invensense.tdk.com/products/motion-tracking/3-axis/itg-3200/
> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=author&q=Manuel+Stahl
> ---
>  .../iio/gyroscope/invensense,itg3200.yaml     | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml b/Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml
> new file mode 100644
> index 000000000000..4b2f9a57c6ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/invensense,itg3200.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/gyroscope/invensense,itg3200.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Invensense ITG-3200 Gyroscope
> +
> +maintainers:
> +  - Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> +
> +description: |
> +  Triple-axis, digital output gyroscope with a three 16-bit analog-to-digital
> +  converters (ADCs) for digitizing the gyro outputs, a user-selectable internal
> +  low-pass filter bandwidth, and a Fast-Mode I2C.
> +
> +properties:
> +  compatible:
> +    const: invensense,itg3200
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  vlogic-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix.
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ext_clock
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        gyroscope@68 {
> +            compatible = "invensense,itg3200";
> +            reg = <0x68>;
> +            interrupt-parent = <&gpio2>;
> +            interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };


