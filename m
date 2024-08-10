Return-Path: <linux-iio+bounces-8397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0772C94DC41
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 12:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A041C21081
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8F3156F5F;
	Sat, 10 Aug 2024 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1gQvThu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B672F2A;
	Sat, 10 Aug 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723285372; cv=none; b=T8B8SO8rUR2C/a/o/FYys4vfc48Vwcpn93HhUb1Lxkhffj4DJzteqOvk2oQBLTNbygjf6jiDhzhh30NQ80tJMMCz7ywhZW9pEKoZmOdr64oQiqAm8X0razv6PUyppctb//MajNkpLgn/aRhb3hDJZoXIOgpU9hR8Po39R2pB94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723285372; c=relaxed/simple;
	bh=T4Gu1nHXg8cLOaE2llbx0vvdyZ1eMEW29Hu/IJv7EG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwISWvh51DaaNlWQ16YYOUwo3VAWF0KU9rd7UlxUDAKdCqP911jHSFfWTbTGBPlYYnt3LrNIVunZ6uq5bs/r/uLs5ZdHB6NKVqUcvhT8Kd2EBlryzqeBTCO/FDuHp0/XXKQU8s6QcGGddTHg1hPXCwtJ80nCsJfe5KumO7fLBbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1gQvThu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7108AC32781;
	Sat, 10 Aug 2024 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723285372;
	bh=T4Gu1nHXg8cLOaE2llbx0vvdyZ1eMEW29Hu/IJv7EG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R1gQvThusJ5NX8S9PRuYHx3U4CWPBxPKUbEQP0gHJkvZAngcNdngr4kVS+CbeEZIG
	 EIqCC2TUDXY/LNVpd6MgiaeG0+tQSE4hdVRbXRlrGQFlZkzkN8ihiEMdM/4XISktWW
	 B4Jiye/HnObK88uF+uRpMS7O+F5ihsCGH/WQeBYuLRP5szAOFnb7xpI4C/EB10HHnt
	 XIKhljMG9oz71vOPbpoqERS+GLWG7dZ6sMPv99+WoTS2uZ2Zl8OV9Kjv9yIDvk5MGX
	 dQxyvdUyJcPoDiy1Ep8yMCn+QPb44e3AUI7G13ZlbREh1NmJZfIHy3GvurW+yCmJn+
	 pY1poS5AhW1PA==
Date: Sat, 10 Aug 2024 11:22:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Conor
 Dooley <conor.dooley@microchip.com>, Nuno Sa <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ltc2664: Fix off by one in
 ltc2664_channel_config()
Message-ID: <20240810112245.29823516@jic23-huawei>
In-Reply-To: <5727ab54-6280-466e-b107-1b6006e5ab29@stanley.mountain>
References: <5727ab54-6280-466e-b107-1b6006e5ab29@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 15:28:30 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> This comparison should be >= ARRAY_SIZE() instead of >.  The "mspan"
> variable is later used as an array index into ltc2664_mspan_lut[] so
> this is an off by one bug.
> 
> Fixes: 4cc2fc445d2e ("iio: dac: ltc2664: Add driver for LTC2664 and LTC2672")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Applied.
Thanks,

> ---
>  drivers/iio/dac/ltc2664.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
> index 666ecdeb5f96..5be5345ac5c8 100644
> --- a/drivers/iio/dac/ltc2664.c
> +++ b/drivers/iio/dac/ltc2664.c
> @@ -526,7 +526,7 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
>  			return dev_err_probe(dev, -EINVAL,
>  			       "adi,manual-span-operation-config not supported\n");
>  
> -		if (mspan > ARRAY_SIZE(ltc2664_mspan_lut))
> +		if (mspan >= ARRAY_SIZE(ltc2664_mspan_lut))
>  			return dev_err_probe(dev, -EINVAL,
>  			       "adi,manual-span-operation-config not in range\n");
>  	}


