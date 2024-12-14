Return-Path: <linux-iio+bounces-13450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F639F1E7B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 13:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4BE1889DFE
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 12:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D3C18FDDB;
	Sat, 14 Dec 2024 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAprubGf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3416F0E8;
	Sat, 14 Dec 2024 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734178267; cv=none; b=VKE00fwc1a2He8+f2GO4WYCVO/ykOgrz+hD7lNFySg6OOAgqOMPdAEaBSTBnFxBptYB0JQlIYbROEb4+sXIIKET4AP0lE6a6Z4NfO5jdZGakuXI2tHYNEdH5bNO/umpxfKoQBmhQc6grl57cfaUhhlV7/Tp+QXbXuqKFL2hRGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734178267; c=relaxed/simple;
	bh=r6ygkZZ7ZKrhyII6vaxYNDsWAKhqlkABXmPDFLsCQik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RENU0C8M/Xvzt49y7i7nFvfB8Rv0Z8vTIVfrgTqmRu61Qx5zav/4SxX6wIp7h3sXm0hB39wzJsnL0UyRtu2+LUOU5c+b2vbcyYCPg8V9GQquGujJBuSz8Dz8ksGyK0UWIsJxRkS69ht42xHh+kFDdi/XC2Nk0iHP9yy4Xsj92Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAprubGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D42C4CED1;
	Sat, 14 Dec 2024 12:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734178266;
	bh=r6ygkZZ7ZKrhyII6vaxYNDsWAKhqlkABXmPDFLsCQik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oAprubGfdR5R4npKXItm/RzysAG0K+TIjo0/ULH8VZCxUbfaeCEzz3GkVCS2Bnonf
	 8PC+v7WAvfpntulXj5XVGnBePT9giDFLwwDTtbLZ8Yjc38b9XFPg3F6GWqssfyNKE5
	 gWWXBBCgIPoQLv19zsI/dEmBOohNf2L4RoGR1P8+RJ60TQCLpR5CFrJUlnDL4WOb/b
	 OpciZEoDOW/T1Q7LwFR2T8J8byxyA5dLoSjQRrGMyPKJOdWpsPfSat/hCPaNMk/vEN
	 zu7x+xczfQNlHsg6y43r9b+sVriINgfcxJ8IhFrkxQewBXWAiKsywQujG3yu9MttF1
	 GsXxngq7RPguA==
Date: Sat, 14 Dec 2024 12:10:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 3/7] dt-bindings: iio: accel: adxl345: add
 interrupt-names
Message-ID: <20241214121057.5b12a236@jic23-huawei>
In-Reply-To: <20241213211909.40896-4-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
	<20241213211909.40896-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 21:19:05 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> sensor.
> 
> When one of the two interrupt lines is connected, the interrupt as its
> interrupt-name, need to be declared in the devicetree. The driver then
> configures the sensor to indicate its events on either INT1 or INT2.
> 
> If no interrupt is configured, then no interrupt-name should be
> configured, and vice versa. In this case the sensor runs in FIFO BYPASS
> mode. This allows sensor measurements, but none of the sensor events.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Just to repeat what I sent in reply to v6 (well after you'd posted this).
Maybe we can maintain compatibility with the binding before this by adding
a default of INT1.

Then you'd need to drop the dependency on interrupt-names.

I'm not sure though if the checking of number of entries will work against
a default. Give it a go and see what happens :)

We are lucky that we can't have bindings in the wild assuming ordering
of the two interrupts due to the maxItems being set for interrupts.

It's a messy corner, perhaps we should just not bother in the binding,
but keep that default handling in the driver?

DT binding folk, what do you think the best way of handling this is?

Jonathan

> ---
>  .../devicetree/bindings/iio/accel/adi,adxl345.yaml     | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> index bc46ed00f..4f971035b 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -37,6 +37,14 @@ properties:
>    interrupts:
>      maxItems: 1

That is not going to work if we have two interrupts specified.
It does at least mean we only need 

>  
> +  interrupt-names:
> +    items:
> +      - enum: [INT1, INT2]
> +
> +dependencies:
> +  interrupts: [ 'interrupt-names' ]
> +  interrupt-names: [ 'interrupts' ]
> +
>  required:
>    - compatible
>    - reg
> @@ -60,6 +68,7 @@ examples:
>              reg = <0x2a>;
>              interrupt-parent = <&gpio0>;
>              interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "INT1";
>          };
>      };
>    - |
> @@ -78,5 +87,6 @@ examples:
>              spi-cpha;
>              interrupt-parent = <&gpio0>;
>              interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "INT2";
>          };
>      };


