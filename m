Return-Path: <linux-iio+bounces-27721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2313D1D685
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFB4D30090CC
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8238735C;
	Wed, 14 Jan 2026 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo96mmx4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25E37E2E3;
	Wed, 14 Jan 2026 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381925; cv=none; b=HeeZJPciz/nyzsb9wIg2XJbXa1BaegA+o0V5kdWC0IYLy0MfV2Z+EvmL1SZhcq+ctANaoZZ8XX8UeXeKDmDf1IZsWNlLYUQPTrFyeeN9N05r1TcjeErBa82ZFAkRaHEy/55+rbZcwmYLwHY8CTfPnHGQpapKLTSAkk7PQgf2AHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381925; c=relaxed/simple;
	bh=0WzfsEJnGftiWIncn3ejD3A5GXQv4ftL3r6fn178h2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNdzj5TWHWyjadJathiP9e7tGwKWnA0sn8PT4u73kpawm70V8OXdKoJiv2lL+0KLYBA/FN3v8hyS69iQvKsapFO4/My3jo7+hJYXuyUcotM18GDXF1I65wbKr39X1qh37RHUKGda0If5iD6eLOrRPKpHJ7FWzMB4iDHqw4CWjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo96mmx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940ADC4CEF7;
	Wed, 14 Jan 2026 09:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768381924;
	bh=0WzfsEJnGftiWIncn3ejD3A5GXQv4ftL3r6fn178h2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qo96mmx4vv6JY+eYzyZSkrHbiLaERR3jaymA1ngbPCUsGhWAIWs1uqQwk3tCzN3f7
	 LXhHk0tM/DvOq0TfBbu1qRb+FuI00IjkrXFIMRzphAKe53amweaGKcxGrbf1AIY0VE
	 Vp/Ulc7QS22eV03zcc18O0/gQ9TIo8IijKc+uOmEQDIxNJkPE6imRTFIROojD626aF
	 ksH5bGNx5N35OEVFHDjxC8ZedZ8c3B5VRPEH7SQPeouJ41DkLZh8nYB8EJMXTbpQcH
	 3UHkJJtTtBcFy3DciVZFgg0hsnCgyL+88GD7yTCo+BIUcQHf1v3ppjSRAvU6eeXUi6
	 zlMXY6KuBYnOQ==
Date: Wed, 14 Jan 2026 09:11:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Sean Anderson
 <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 6/9] spi: dt-bindings: adi,axi-spi-engine: add
 multi-lane support
Message-ID: <20260114091154.268d7c1e@jic23-huawei>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-6-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
	<20260112-spi-add-multi-bus-support-v5-6-295f4f09f6ba@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 11:45:24 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Extend the ADI AXI SPI engine binding for multiple data lanes. This SPI
> controller has a capability to read multiple data words at the same
> time (e.g. for use with simultaneous sampling ADCs). The current FPGA
> implementation can support up to 8 data lanes at a time (depending on a
> compile-time configuration option).
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
> v4 changes:
> - Update to use spi-{tx,rx}-bus-width properties.
> ---
>  .../devicetree/bindings/spi/adi,axi-spi-engine.yaml       | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> index 4b3828eda6cb..0f2448371f17 100644
> --- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> +++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> @@ -70,6 +70,21 @@ required:
>  
>  unevaluatedProperties: false
>  
> +patternProperties:
> +  "^.*@[0-9a-f]+":
> +    type: object
> +
> +    properties:
> +      spi-rx-bus-width:
> +        maxItems: 8
> +        items:
> +          enum: [0, 1]
> +
> +      spi-tx-bus-width:
> +        maxItems: 8
> +        items:
> +          enum: [0, 1]
> +
>  examples:
>    - |
>      spi@44a00000 {
> 


