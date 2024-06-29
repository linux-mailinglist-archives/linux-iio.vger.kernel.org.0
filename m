Return-Path: <linux-iio+bounces-7037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B9C91CDD6
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 17:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF292816F7
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA76283CDE;
	Sat, 29 Jun 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpgjWrZ2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF22101F7;
	Sat, 29 Jun 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719674553; cv=none; b=INlX19PBMUXDBxl+jRrh5Nw+R5QU/EXYJjsYqfFMxpRTZKEMMGnNJS3oo3WpoFPrMzwLN1lbGLhGe7cBJso3WZ1w8tf3x8P+01fHnJc1qSSfqM2Ya3yJ8RC0oOqk0rhcj2YZNSfVv32rR3wF4tVSith/ZQfAKFXxV+08DMq3vBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719674553; c=relaxed/simple;
	bh=ekv059wC7oOT+ovzlNIPd7fDAmdC4mRiXKT0Ut5k4OU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILRHsmWuM7wnoQCaAbO1x+rmMd7Bc3lEVhf4sATzhL+EvSyrEherG4XiE7691chlNvOxnoguoF8BexKRlcOYPtEm5tpLzKarmR37v8HG6BgwmDvPVw5QQ7MHvCLHYAS7/KxOsWclYdV14eAeFXpgwf+hsRXgrE4eDOmIa38TR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpgjWrZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C232C2BBFC;
	Sat, 29 Jun 2024 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719674553;
	bh=ekv059wC7oOT+ovzlNIPd7fDAmdC4mRiXKT0Ut5k4OU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EpgjWrZ2tpkJlWZ8pLVshqn7w79+ALaUcO3T3QaYtHwbyW6+ZV2Sxt5LbdYdpQJ7U
	 q66d/ZLbvoyal/Kx7v7oMUUJNv8ORXvGx5dUcbFcMiUh3Iu6EiCwlOCsMczP/l07Ya
	 hivtnCH/wQKwgMfTYyRHss+I8QFXZgDib56WQJt3vbuoo43uhgohEtKFg/yP/azb2Y
	 q0FQv3tXInCbVa+i7cTDPiBRAS2QK5s15vXE7zmXbOGvDPvFR562IjUDQYwzdRbVNe
	 CChvrBxSUPvkEa+0XK3Jz0bCXW0UYLWGstd7OpE1Dtw100dveoYj5TjgPrYiW3QUQS
	 bT831v3uN20GA==
Date: Sat, 29 Jun 2024 16:22:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: adc: adi,ad7606: comment and
 sort the compatible names
Message-ID: <20240629162223.5b8d35b8@jic23-huawei>
In-Reply-To: <20240628-cleanup-ad7606-v2-2-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
	<20240628-cleanup-ad7606-v2-2-96e02f90256d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 14:48:20 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> AD7606-8 is referred to as AD7606 by Analog Devices. This comment aims
> to avoid confusion. Also the compatible names were not sorted by
> alphabetical order.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>

So b4 interestingly picked up both acks from Rob and Conor on this
one but I can't figure out where Conor's one came from so I've dropped
it.

Applied.

> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index d55c58400df5..00fdaed11cbd 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -20,9 +20,9 @@ properties:
>    compatible:
>      enum:
>        - adi,ad7605-4
> -      - adi,ad7606-8
> -      - adi,ad7606-6
>        - adi,ad7606-4
> +      - adi,ad7606-6
> +      - adi,ad7606-8  # Referred to as AD7606 (without -8) in the datasheet
>        - adi,ad7606b
>        - adi,ad7616
>  
> 


