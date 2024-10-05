Return-Path: <linux-iio+bounces-10177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EE6991852
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D951C2110B
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D85244C86;
	Sat,  5 Oct 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njuestIz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905A211C;
	Sat,  5 Oct 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146117; cv=none; b=bQT7l62u1utp/fK6kXiw5AqPCxKY9fT0iO4+g0BsOclOKYB5GPr+kf+ZwRI+EUK2EL1F+Yn+DgUq6nCd0O3oAVdi3ss2iD3WeXxH2brJt4QldgLnnFeUhEDmqyxiwj/UxuhIkUQ7f0p5BYa0WevySJWVVCZXBWkMSAYRKxiAmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146117; c=relaxed/simple;
	bh=9LbJuX2MUDJUOPN5HPaDxB1YJ4by/eJMpqQkvy6egqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4NGD5v48UGoAYiAleiAqKb0evXtjM1TUN0wO6QDBEfAMElc6HHW8aW3DT1MG9xJpZYaiWPRRaQIzWJqvLUUjNqnQ4rGCoDX0bUA3D52h3deazUGypPhd+2BdrudIqiRRKAhwlSdeWSHI+0vuKqlIL932051ptDe6Y6RTb1DzJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njuestIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907B5C4CEC2;
	Sat,  5 Oct 2024 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728146116;
	bh=9LbJuX2MUDJUOPN5HPaDxB1YJ4by/eJMpqQkvy6egqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=njuestIzaCf7jvdOUIEEp9AEJbqcn7faerj7fuq5FT/DBZXCQ+EgPZzOWfg3xYYGX
	 fYDt9iDLOA5WYObtK0DN/2LJ5szpvtLADwI8eUTPBVFMVL7ChSWZMKoDhpADAC9C6u
	 RoFNyCPe8fCTN0K0db1uOWhxque4kVUF0pa2ZJKCuSPODREckDZ30VI20wMglC+4CY
	 JmU8dpcOUIU/Fws/akN9TyHIPj1c0sRucrO9t667PRki5CoDYQLYR13eyeoSDBl+oF
	 PctrNkkQ/TdeknvdHXkjKDCA1XuFmGx5GsPhjo7yjDIu8O+T0bLgYXvNpMfpGnDP0H
	 o5xV+LBL3eTvA==
Date: Sat, 5 Oct 2024 17:34:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Michael
 Hennerich <michael.hennerich@analog.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iioc: dac: ltc2664: Fix span variable usage in
 ltc2664_channel_config function
Message-ID: <20241005173443.4a34fb73@jic23-huawei>
In-Reply-To: <20241004135454.5784-1-pvmohammedanees2003@gmail.com>
References: <20241004135454.5784-1-pvmohammedanees2003@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 19:24:54 +0530
Mohammed Anees <pvmohammedanees2003@gmail.com> wrote:

> In the current implementation of the ltc2664_channel_config function,
> a variable named span is declared and initialized to 0, intended to
> capture the return value of the ltc2664_set_span function. However,
> the output of ltc2664_set_span is directly assigned to chan->span,
> leaving span unchanged. As a result, when the function later checks
> if (span < 0), this condition will never trigger an error since
> span remains 0, this flaw leads to ineffective error handling. The
> current patch resolves this issue by checking chan->span rather than
> span and also effectively removing span variable.
> 
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
Good catch, but needs a Fixes tag.

Also, slight preference for using ret and assigning on success.
Ideal is not to have side effects when an error occurs,
though I'd imagine in this case we fail the probe so it doesn't
matter and in such cases it's not a hard requirement.

> ---
>  drivers/iio/dac/ltc2664.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
> index 5be5345ac5c8..64c8a51aad81 100644
> --- a/drivers/iio/dac/ltc2664.c
> +++ b/drivers/iio/dac/ltc2664.c
> @@ -516,7 +516,7 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
>  	const struct ltc2664_chip_info *chip_info = st->chip_info;
>  	struct device *dev = &st->spi->dev;
>  	u32 reg, tmp[2], mspan;
> -	int ret, span = 0;
> +	int ret;
>  
>  	mspan = LTC2664_MSPAN_SOFTSPAN;
>  	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
> @@ -581,8 +581,8 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
>  		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
>  			chan->span = ltc2664_set_span(st, tmp[0] / 1000,
>  						      tmp[1] / 1000, reg);
I'd slightly prefer
			ret =....
			if (ret < 0)
				...
			chan->span = ret;

etc

> -			if (span < 0)
> -				return dev_err_probe(dev, span,
> +			if (chan->span < 0)
> +				return dev_err_probe(dev, chan->span,
>  						     "Failed to set span\n");
>  		}
>  
> @@ -590,8 +590,8 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
>  						     tmp, ARRAY_SIZE(tmp));
>  		if (!ret) {
>  			chan->span = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
> -			if (span < 0)
> -				return dev_err_probe(dev, span,
similar down here.
> +			if (chan->span < 0)
> +				return dev_err_probe(dev, chan->span,
>  						     "Failed to set span\n");
>  		}
>  	}


