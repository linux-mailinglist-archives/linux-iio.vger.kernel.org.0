Return-Path: <linux-iio+bounces-21039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A13AEC843
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFF417F4CC
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAF02192F1;
	Sat, 28 Jun 2025 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+xsXDh7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329271747;
	Sat, 28 Jun 2025 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751124225; cv=none; b=GzjwwE6wrP1XJPNV6rhF8Pcv9fx8rqFp2JObV7SGf712vEwFEoCnYkhqjzA8oRHT4CX/B7PGPOpoF9QODMU+i4qSP5KgsIpdr/OnyvQ5zlFO8ya2AqH3AqLVSbwz17x81u2BGKz4OMKyd1d8VmyppKu2KIsGsLxyyNxKyA2yzTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751124225; c=relaxed/simple;
	bh=zkUB9FEEwz5gzjfhnoERP0IXv4N2edG3iKd96FdT6MI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6kJrBTcSwiKvrnq/Ore8BEd58EqSycibBLpVPeUJYG2j8nGtGUlL9Xa6GYQaWt/wlilJeBTglbLWKkMaCNU74ZdTGxG3INuLOFloqtJexitVH7tJWQcBwWIvE7e1U19lmRoga6MNa2UiO5E3mQChOa9nh6HTWLf7aI8LOQAppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+xsXDh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776C0C4CEED;
	Sat, 28 Jun 2025 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751124224;
	bh=zkUB9FEEwz5gzjfhnoERP0IXv4N2edG3iKd96FdT6MI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X+xsXDh72stFKixw15YnLdKPsXPj9AB1x9xmR5zA8I292xmyZpV2jCsurc+j/TMKX
	 A8lMZhE+C5QsRSFHK8o06tvgMrDlpe2J7GSOECvJP0dOy69UVHNm4obcURxgGl1q5O
	 rZOskMAebOZV8zvy3ivy9ENn4zTRIBhBm4I72X3E/mP/v36OVXCvGca7SWPlJQggl2
	 90bKwPihvcKilYnGfsPx0M8KvegQCrJfayaTUWG/krX5/tSZB/1QZOhsouwZjGL7iX
	 VU6YzWkWKANfkHfBk5Ke9MCbcBeIlsHNInHCLJQ9maezkxnz7BrV37mLuHFSAy0JF7
	 7KEhgI5OlTZIQ==
Date: Sat, 28 Jun 2025 16:23:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ad4851: add spi-3wire
Message-ID: <20250628162340.721b7462@jic23-huawei>
In-Reply-To: <20250626104024.8645-1-antoniu.miclaus@analog.com>
References: <20250626104024.8645-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 13:40:23 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add devicetree support for spi 3-wire configuration.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Series applied.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
> index c6676d91b4e6..b107322e0ea3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
> @@ -69,6 +69,8 @@ properties:
>    spi-max-frequency:
>      maximum: 25000000
>  
> +  spi-3wire: true
> +
>    '#address-cells':
>      const: 1
>  


