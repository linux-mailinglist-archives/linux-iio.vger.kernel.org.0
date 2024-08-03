Return-Path: <linux-iio+bounces-8207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E9C946A37
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 17:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8995B1F21751
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6645A15381C;
	Sat,  3 Aug 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5kd2Uak"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AA1DFF7;
	Sat,  3 Aug 2024 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697438; cv=none; b=ArnRnkbVPDgCp+yzdorMOa9yIv9JL7k7XSye5Dx+qE5HWiAkxj6olD9Y8a891hE/hTnP4lT6U+lTdpltDWz+GLvCzy6z2sfljJeaDxenyDWRIv5L+mk4xLh0xtYIGWaBMHX1abgqazIr0NK1r48nZeUKhNqEuZzMvBbJAHF6NrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697438; c=relaxed/simple;
	bh=90EWRpnR3CUSmUgd6f1RpvP27Z00hJmKlF1ncQKyD1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfAw87t26Ic231YYDUGn1U6RuVDGqAkg7yz01fP0WuNeVUMYueeAy1fgu1ZaicXmyri1FUCmoXPJqIRnNy8yYrFfD7xwBslYs9wzgmAC7wxjMSR+f8sAS5kRx+BZ2oZ9T6ks95bLVIrThzeA6h019HkdY5vyZQBuXlAH52Pz2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5kd2Uak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F52BC116B1;
	Sat,  3 Aug 2024 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722697437;
	bh=90EWRpnR3CUSmUgd6f1RpvP27Z00hJmKlF1ncQKyD1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n5kd2Uak9JCBBWBYAlR/Hx2cr7+f4dSj4uZ7RJr+P9dfRmghNPgx+0jf5Zbo0iv+V
	 ADMeBN+UEkon945GvkkfaNz2PL6x1Na65tjUOfZeff/Yr40TqyJCoDoubvnHmZRpZo
	 tNjFZGg1m3H2szZHfTs+mlG3MTB3v94v6gbMWHinSdXY3hH/E1jIlXMRbxe++O/k3Z
	 Qe+YM7LbNwzLtQDVI5Hl8jM5M9rIMo8wh5UIjX/I5V+iYLv9qbLijQBXLvPTGcfPcv
	 aw5Ht7lvAKKUdVgDN/kAEq6xGUmYenW0r3RGG0XY3OXgaFUJ+iielBFrfFRyHHR6Zo
	 dhBUyi8bwmnxg==
Date: Sat, 3 Aug 2024 16:03:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Stefan Popa <stefan.popa@analog.com>, Alexandru Tachici
 <alexandru.tachici@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <dumitru.ceclan@analog.com>
Subject: Re: [PATCH 1/4] iio: adc: ad7124: fix chip ID mismatch
Message-ID: <20240803160350.28b7a25d@jic23-huawei>
In-Reply-To: <20240731-ad7124-fix-v1-1-46a76aa4b9be@analog.com>
References: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
	<20240731-ad7124-fix-v1-1-46a76aa4b9be@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 15:37:22 +0300
Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

> The ad7124_soft_reset() function has the assumption that the chip will
> assert the "power-on reset" bit in the STATUS register after a software
> reset without any delay. The POR bit =0 is used to check if the chip
> initialization is done.
> 
> A chip ID mismatch probe error appears intermittently when the probe
> continues too soon and the ID register does not contain the expected
> value.
> 
> Fix by adding a 200us delay after the software reset command is issued.
> 
> Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

J
> ---
>  drivers/iio/adc/ad7124.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index e7b1d517d3de..54d4c5597696 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -762,6 +762,7 @@ static int ad7124_soft_reset(struct ad7124_state *st)
>  	if (ret < 0)
>  		return ret;
>  
> +	fsleep(200);
>  	timeout = 100;
>  	do {
>  		ret = ad_sd_read_reg(&st->sd, AD7124_STATUS, 1, &readval);
> 


