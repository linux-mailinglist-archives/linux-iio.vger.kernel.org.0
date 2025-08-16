Return-Path: <linux-iio+bounces-22780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386ECB28C99
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 11:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210D15E054A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E438D28A40C;
	Sat, 16 Aug 2025 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhWCRGYf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95712DDA1;
	Sat, 16 Aug 2025 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755338313; cv=none; b=Q9IhFWjc0S9p/ls045iF/WQj1ceMDQsPbxiiEVHcDidWAEFiAeJdadTpk7pqFN/iWKzIR39DllL60VjPobYLVYsz1z14sALOOqz1FGu8pLQ6h90odL1TuYnrdY3TUVIy24Z1mX2sKjb1yG98gIaiSXFjhBZFpZOeNpTnhoK0n6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755338313; c=relaxed/simple;
	bh=A6xhkDoqh/p5IPvE0iFDdQ2CqbMjCAgnmgHx9uL/1nU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+1aFWW1i8gXYGSitL8dY43yndMwF1ofKQTGawMmBRwby2+9kj9ngiSCm/U1d6S4kLGxlJS08/S7TMtyEIW/8G788Q6puAak0sndq67c8BndqRTeafHh1vUzypoN6xsoL5SS/LVDu3PBtmLTBNrx4bkBbpmg77ijaHtSRHoEKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhWCRGYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D133C4CEEF;
	Sat, 16 Aug 2025 09:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755338313;
	bh=A6xhkDoqh/p5IPvE0iFDdQ2CqbMjCAgnmgHx9uL/1nU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hhWCRGYfhXsFPU7p3fvXGllz3f3H4yZ66juw/dJrjIG8zbys1S5cODQIqQzVuca8Y
	 BD6tcI5rqNmzm4keqc+tmcjBiTj08Bi4U6oEojpWKpFBaL6LlPDYu/7+cLSm2JyUNU
	 XeWamJmJY6gdgI1yigdiM4iL4ZcxA8IxFJsnC4Hi/C5xv5M57x5icwQUb+SLKx1sYp
	 F6wVPr1iQGRdh42BzCZV8ttWT7CWBj08uWR2NIhRHJDy17XA52VxfB1WOn2RbC5FKF
	 enee0vMjNmmdsURz9VPC3xUVzV4AMGEbMwqF2eKqxRC9o2u95j+fOXc+JBfpN6JunL
	 HqhY6szbHn+BQ==
Date: Sat, 16 Aug 2025 10:58:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Collins <bcollins@watter.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
Message-ID: <20250816105825.35e69652@jic23-huawei>
In-Reply-To: <20250815164627.22002-2-bcollins@watter.com>
References: <20250815164627.22002-1-bcollins@watter.com>
	<20250815164627.22002-2-bcollins@watter.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 16:46:03 +0000
Ben Collins <bcollins@watter.com> wrote:

> The mcp9600 driver supports the mcp9601 chip, but complains about not
> recognizing the device id on probe. A separate patch...
> 
> 	iio: mcp9600: Recognize chip id for mcp9601
> 
> ...addresses this. This patch updates the dt-bindings for this chip to
> reflect the change to allow explicitly setting microchip,mcp9601 as
> the expected chip type.
> 
> The mcp9601 also supports features not found on the mcp9600, so this
> will also allow the driver to differentiate the support of these
> features.

If it's additional features only then you can still use a fallback
compatible.  Intent being that a new DT vs old kernel still 'works'.

Then for the driver on new kernels we match on the new compatible and
support those new features.  Old kernel users get to keep the ID
mismatch warning - they can upgrade if they want that to go away ;)

Krzysztof raised the same point on v2 but I'm not seeing it addressed
in that discussion.

Jonathan

> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
>  .../bindings/iio/temperature/microchip,mcp9600.yaml         | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> index d2cafa38a5442..d8af0912ce886 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Microchip MCP9600 thermocouple EMF converter
> +title: Microchip MCP9600 and similar thermocouple EMF converters
>  
>  maintainers:
>    - Andrew Hepp <andrew.hepp@ahepp.dev>
> @@ -14,7 +14,9 @@ description:
>  
>  properties:
>    compatible:
> -    const: microchip,mcp9600
> +    enum:
> +      - microchip,mcp9600
> +      - microchip,mcp9601
>  
>    reg:
>      maxItems: 1


