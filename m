Return-Path: <linux-iio+bounces-10787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAD49A4E92
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945061F26ADA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C4C12EBEA;
	Sat, 19 Oct 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzomkAnX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C915C3;
	Sat, 19 Oct 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729347425; cv=none; b=DIKz12dEa1WW57bVsZPwwNrJcpdifTo/fuwtcBURZ2EE9jjLXl+9l5ju0YksHw9QlF5c4HkvRMnT+NIwnrqpU9dS0fUEaQ0/jyVnU8e8Sckn4nV3S0RRZbBKEmsexZp/zfv6EttBj/OY7rVHc+ueUbDNexoDGp6WIEw6NT4fw+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729347425; c=relaxed/simple;
	bh=9ZBGfZdLPG2dOgxZEu6wPgkmAHTntw+usd99xmNtw/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q32hzfGlXEuLYL9JzAGzApQg2KqYLWdTP4wkKZaUF3Dp+sZu6iakuG7KaqCBvusc+wbgF3KL3E3eIsthWgF8fxRvqTUOfy/8zCH5hEF9afZr7ZDIq2/qoeU97trkZ5VHckYw/YKLIg+F2qWRLIIuQmfpT7naQP9iw44PD+LWNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzomkAnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FBEC4CEC5;
	Sat, 19 Oct 2024 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729347425;
	bh=9ZBGfZdLPG2dOgxZEu6wPgkmAHTntw+usd99xmNtw/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SzomkAnXpFIbvsd/71sSCHctzdy+eAjFWBvYEv/XDoVHhlgRRDDQWMoQ/vTm2G33r
	 TFzhZ8T0ANnX4Ce7bCkh5dWOya6oYwwObgFSWYakIjGe3TuWrgeL5M2Q2DXJsW/zrh
	 lXx5hE17uYddu95deq47TV+JByjcJMR2fRsdhOTlYzubdy7JRUZ51Qj9e7tEocwIfA
	 LpcbFP02LHWWwCorsbN4hg/Y5kVOvbP/tRINEoYeaB7qPTEaltzoPjTfE/Cf9HqmRq
	 Z+Lm2KHV9sMWCg9TC/nahaNCBMVNICyNa9yqDed6B6qjkGvj8tyEIdWyBgtR3attaI
	 C+FrsbIH4N2mA==
Date: Sat, 19 Oct 2024 15:16:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: iio: light: veml6075: document
 rset-kohms
Message-ID: <20241019151630.22f2c0c9@jic23-huawei>
In-Reply-To: <20241017-veml6070-integration-time-v1-3-3507d17d562a@gmail.com>
References: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
	<20241017-veml6070-integration-time-v1-3-3507d17d562a@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Oct 2024 23:39:27 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The veml6070 provides a configurable integration time by means of an
> extertnal resistor (Rset in the datasheet) with values between 75 and
Spell check descriptions.  external

> 1200 kohms.
> 
> Document rset-kohms to select the integration time.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/vishay,veml6075.yaml   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> index 96c1317541fa..3d3ffeaa22df 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> @@ -29,6 +29,22 @@ required:
>    - reg
>    - vdd-supply
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - vishay,veml6070
> +    then:
> +      properties:
> +        rset-kohms:
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description: |
> +            Value in kilo Ohms of the Rset resistor used to select
> +            the integration time.
> +          minimum: 75
> +          maximum: 1200
> +
>  additionalProperties: false
>  
>  examples:
> 


