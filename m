Return-Path: <linux-iio+bounces-13447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566EB9F1E62
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 12:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60E31887AA2
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 11:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BF118FC8F;
	Sat, 14 Dec 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULJdJwd9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC2154C00;
	Sat, 14 Dec 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734177578; cv=none; b=Ie2SHHrqxVHACSsw+H6TAPsdWaai5AgVRoOglPjrhE6Aqi7F5eYgGsdhPQL6MDQEuJuWcVhNaLvYHw1rcM5rzDLjb4vI3d36Fvma2cXHgZOzHWgcgKU1s592ZSSsu95bb9k81FFXQnPTEOfRrPPRkHzyQ0MWFIg+EArhZZXP/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734177578; c=relaxed/simple;
	bh=6EOYphW80j7GijCUJxnpYmc4WSQwKXLzVy6bUbT3V1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGm2klM1XTGTgpx+KFNDOw6LMsQXNeIpXBj0Ne8JqOCiT3G5R91EB3LkhSAi7BYV2rIpH9t5ziStj23Te5uh0f+PHN1wGTVjrtA8DskEMXEQ2w3DXIB7QrkkIwADy4seFdRXwy5ly2Q7ItjBorsSNDCXddXJZdKZdiD60WtWxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULJdJwd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730EFC4CED6;
	Sat, 14 Dec 2024 11:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734177578;
	bh=6EOYphW80j7GijCUJxnpYmc4WSQwKXLzVy6bUbT3V1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ULJdJwd9CnLbTe4TGPAAl5h6HJNSU0VMT2vx8HpGH3QajAF9iENYkp8imAtZYFvdh
	 +ls9cTwYijQXWLnZkvYNpA1zM+Dd8Ac/cwKEeW6nq21mM4/cRU8B8khrTEuE5dOdf4
	 KsBtmVHMkOdAlvP4G6ogRxp1rK+FMFJdKGh2bH4Hb7rWigvnz8LO52+pQe0SuSI3/E
	 diaiHd2Ao0Plh4uWQvCGV+I90Sn2jhDviYSorTyLYxRYKu8EZq4ID9gpFH6KuP6YKU
	 Mlur+6UUu7NiuR3kHusbX9FdfF6tl+O0Pl6urFQ9YXvueQmFLwP5haLTxCp83wiZ8r
	 h/LbQi4bRVlbg==
Date: Sat, 14 Dec 2024 11:59:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v6 3/7] dt-bindings: iio: accel: adxl345: add
 interrupt-names
Message-ID: <20241214115929.1e98fd21@jic23-huawei>
In-Reply-To: <20241211230648.205806-4-l.rubusch@gmail.com>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
	<20241211230648.205806-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 23:06:44 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> sensor. Only one line will be connected for incoming events. The driver
> needs to be configured accordingly. If no interrupt line is set up, the
> sensor will fall back to FIFO bypass mode and still measure, but no
> interrupt based events are possible.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Given discussion in mostly here rather than next version...

> ---
>  .../devicetree/bindings/iio/accel/adi,adxl345.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> index 280ed479e..0fe878473 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -37,6 +37,10 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  interrupt-names:
> +    items:
> +      - enum: [INT1, INT2]

Can we add a default for INT1 only?
That would the incorporate a single provided interrupt and 'probably'
not break any existing DT that is out there.

> +
>  required:
>    - compatible
>    - reg
> @@ -61,6 +65,7 @@ examples:
>              reg = <0x2a>;
>              interrupt-parent = <&gpio0>;
>              interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "INT1";
>          };
>      };
>    - |
> @@ -79,5 +84,6 @@ examples:
>              spi-cpha;
>              interrupt-parent = <&gpio0>;
>              interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "INT2";
>          };
>      };


