Return-Path: <linux-iio+bounces-7738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2BF938179
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02320B214DA
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A13312E1C7;
	Sat, 20 Jul 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd87TWsK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89A26AF1;
	Sat, 20 Jul 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721482359; cv=none; b=Bqe4qoFIuqebU1FJprVeiQ9LtFxIgxioGUh9nea0b+GEHuG9Rn6/w25fmSIxJ2LXblQMxHaAH69XzaY7UiIdBJRiY0WswqLQX8ny3KX3F1xfcPF2sZpDa7YGw0Z7P8yo46ufojwTVbZhBOY0Cs8tDAWZGYZ9lkPSWivLcur27M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721482359; c=relaxed/simple;
	bh=zmNBTCuNuLrON/oUWAlQ+nrE9N0XVGs1DZh1HAqPGQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtBD+AydD2PzQ3Md9Us3aJYVg5uFG+wF6sdfpCwnshKuCG9LWLaeSMNRDgOwQldqwEEAnPSRAz7ppybq2xa7u8wSJP4nWVwstPj/VfQd9/svTt6u9E8V6OjBXYuIUVK4lGh+j2DhASYVjOtCLUwxPazAizWLQqY9NMvCLjaX8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd87TWsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E641C2BD10;
	Sat, 20 Jul 2024 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721482359;
	bh=zmNBTCuNuLrON/oUWAlQ+nrE9N0XVGs1DZh1HAqPGQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nd87TWsKX14WML06zsRBFv1gR2tAT5Pt6K1Cx9tm/ZdrQMCkEy2RKCEI3HZUbPRaJ
	 gAoiHbLBp2pgFfR+xYtmWaTNOGr5m7OwV2e+asSm6ybZS4AJgYGtoJCYtJmRk2LY1C
	 Q3CScNttuNOz/kjaBPXhAiFIZZMn3vaquOxQlBMIYjEXOYxTfO3Skt2HrrSFIg1rf9
	 HGYg+J/WOtyoWKwJNE6xQpvUmM/gXAMf8gc7Io69KHYynrqx7zETEBkTEU/jGhFacm
	 3sgdPh4qubHNDZDw6Ej4YOmmB15jXZLUlKAoARDTg8tbtg6r+NCpFLqsxhFp3u1ohQ
	 sDMgY8YdEB8tw==
Date: Sat, 20 Jul 2024 14:32:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dragos
 Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adf4377: add adf4378 link
Message-ID: <20240720143230.5bff06d0@jic23-huawei>
In-Reply-To: <20240717093034.9221-1-antoniu.miclaus@analog.com>
References: <20240717093034.9221-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 12:30:31 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add product link for the adf4378 part.
This should state why it doesn't need a new compatible (I think it does,
see next patch review).
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> index aa6a3193b4e0..902081b83447 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
> @@ -17,6 +17,7 @@ description: |
>     applications.
>  
>     https://www.analog.com/en/products/adf4377.html
> +   https://www.analog.com/en/products/adf4378.html
>  
>  properties:
>    compatible:


