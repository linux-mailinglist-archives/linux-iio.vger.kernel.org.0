Return-Path: <linux-iio+bounces-24885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32935BCAD48
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 22:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2331D4F31C1
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 20:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC39274659;
	Thu,  9 Oct 2025 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkikKNAc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78FF273D8A;
	Thu,  9 Oct 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042847; cv=none; b=DAM5Z4YgsPTBr38cINVVirOepxf/SZDVVajj6yelv4ppK0EFyHJulkOkeAbiNldCP6PCY0PyzEAYA2sTlHkPQtR8Tue4X28DbI9G1eBpLtRJJNFRsQPSkeNt/OSoRrT7feZbdvgJ+nPcyxBVlt0hFIElcieFC26WahRQxL6cbkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042847; c=relaxed/simple;
	bh=1QFw5FB4WUAydpBY2LpclQV0+qSk9QX1MYOURVxXJZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prnEP/BFq2HXf9BuQEV3ii2KW0a0TBXbbm38cMx+dyZ19m/hk6OCpU3OtjOK8XigBAOeqrtp7I0NU47jMLYZzf2vb0ekUK+gehoisPgl80Ktail7HY2d4aFV6IGXn0Oz3zWmlkAhgCnc7D7RiKOckvLuj+WFgD9s/MdayetsRjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkikKNAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6DEC4CEE7;
	Thu,  9 Oct 2025 20:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760042847;
	bh=1QFw5FB4WUAydpBY2LpclQV0+qSk9QX1MYOURVxXJZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkikKNAcwLZIT4JQZ2ICfhR4cacCWwrqeiIRS9/psJCIQbHQNiyblmRfspAaLD3sC
	 KGb3IfTAtWkHUbufmuEKPzSs8BniXglLwV8yH1CHMjD0G74ymXaOaf+EbeIoskwrrI
	 h8xj1S1VP3dO4Hzkn+Vbg9b58wXoZ+GS8tK2h5Q1HGdHgklFWwAa6+pxaYRWp24sAe
	 pFn+1AYxe5B1T1TEYXesLJXYU+RxLxH3C+bqwG8OWYDmvrgsfXBWPrbT4QraxeGtqy
	 YBK5R83KzdqWjXDU19IAuItDxTyGL3M6w2jgtSebzvFN9mG3yXaEr6RSrKuC0gl1bQ
	 6hEjIOfIuiusw==
Date: Thu, 9 Oct 2025 15:47:26 -0500
From: Rob Herring <robh@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: iio: accel: adxl345: document
 second interrupt
Message-ID: <20251009204726.GA3306624-robh@kernel.org>
References: <20251006172119.2888-1-wsa+renesas@sang-engineering.com>
 <20251006172119.2888-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006172119.2888-2-wsa+renesas@sang-engineering.com>

On Mon, Oct 06, 2025 at 07:21:17PM +0200, Wolfram Sang wrote:
> The pinout of all the supported chips in this binding have two interrupt
> pins. Document the second one, too, even though the Linux driver
> currently does not support the second interrupt. Boards may have it
> wired nonetheless.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Passes dt_binding_check. But uncovers another issue. See coverletter.
> 
>  .../bindings/iio/accel/adi,adxl345.yaml          | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> index a23a626bfab6..806b0250ec07 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
> @@ -35,11 +35,16 @@ properties:
>    spi-3wire: true
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>  
>    interrupt-names:
> -    items:
> -      - enum: [INT1, INT2]
> +    oneOf:
> +      - items:
> +          - enum: [INT1, INT2]
> +      - items:
> +          - const: INT1
> +          - const: INT2

This is better written as:

minItems: 1
items:
  - enum: [INT1, INT2]
  - const: INT2

It is mainly better because using 'oneOf' results in poor error 
messages.

Rob

