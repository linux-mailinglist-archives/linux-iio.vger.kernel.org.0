Return-Path: <linux-iio+bounces-1942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8859783EDC5
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 16:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55ECD1C214A4
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9668F28DBD;
	Sat, 27 Jan 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdHXySpW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB2D51B;
	Sat, 27 Jan 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706367881; cv=none; b=YU9tefuTbHKyFD8MPZNcVwImTrYCiL6Ldd97nmqRPFG4hCKK2LswNnP5idHnbviLPaHe/OdFRZEqUNXTatbHp5ZcE+pKj5mYJseLNkbJu8Yq5hLX2H++iRZtKPifA7YWbLQSKiVLqLABDZe0+0+9Ci2Cx2fCYoJ/FG1EjZrWFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706367881; c=relaxed/simple;
	bh=IX+xV0rufehHklpXKgHlLQM98C9J4Gzqs8YrwKQryVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gf/TSZTfHjms/kVhPrcfCbvzZHw0TyvVjP2f1UzqD+8fWYaw6GmYMLaLJ1RT6Ny5fRMwT9RojaSU182efe2ziXm1m6KJHPGEpVgVTvCheWdIkkSb87By/yng0t24+hCeQCUuwaCX4z9QGN1gLAgfojO3JTFqjYhAb0PeDvdrPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdHXySpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2101C433C7;
	Sat, 27 Jan 2024 15:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706367880;
	bh=IX+xV0rufehHklpXKgHlLQM98C9J4Gzqs8YrwKQryVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fdHXySpW+NQ19nggSRjs6y9zOAtloorOYIStWCciFgJZhQpqbgp7TySkT3gWKXlok
	 SvpFXu7JwjvRO7vItum5gYlql04SzIzSPWqbGe0Tx7Y7VOuvCyPFQBHS+BJJXkynZ9
	 pj4IODUSX7c77+RxuSJIc2G4SafsEr8aIP9/3P7EaxnV2FQCazWXf4BlLhmsOvO16/
	 yuW3o3fpI4H8SVJbI+OCFYWhDn7MpTSeWc+dxOcHrhTPR4As+6E/9DyC3g4sH1NMt2
	 hy+qWqowJaMF4jY4qUqWDSfvGMYco2hPP+RUu6oAJNo+GbpOV3rTJ5otEZRhCPmmyN
	 +cXWaQDFrEkLg==
Date: Sat, 27 Jan 2024 15:04:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1
Message-ID: <20240127150426.4994a6a0@jic23-huawei>
In-Reply-To: <90d675537e58c9c339545a895e8164a843821682.1706093274.git.lorenzo@kernel.org>
References: <cover.1706093274.git.lorenzo@kernel.org>
	<90d675537e58c9c339545a895e8164a843821682.1706093274.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 11:52:34 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add device bindings for asm330lhhxg1 IMU sensor.
> Use asm330lhhx as fallback device for asm330lhhxg1 since it implements
> all the features currently supported by asm330lhhxg1.

Can we clarify if the hardware of the asm330lhhxg1 supports
1) Exactly the same features as the asm330lhhx
   (Valid use for a fallback compatible, because we might find
    bugs etc in future).
2) More features, but the asm330lhhx features set is a subset.
   (Most valid use for a fallback compatible)
3) Different features from the asm330llhhx but driver only supports
   a set both support? (this is a problem)

I 'think' it is 2 from your text, but I'm not 100% sure I've understood
correctly.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> index 28b667a9cb76..7ba3de66a2e1 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> @@ -49,6 +49,9 @@ properties:
>        - items:
>            - const: st,asm330lhb
>            - const: st,asm330lhh
> +      - items:
> +          - const: st,asm330lhhxg1
> +          - const: st,asm330lhhx
>  
>    reg:
>      maxItems: 1


