Return-Path: <linux-iio+bounces-19037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F0AA86FE
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF55D1897B64
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EDF1B0F19;
	Sun,  4 May 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8tPR5+c"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511301FAA;
	Sun,  4 May 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746370477; cv=none; b=N33cfCPpCAMeJ0+oOKSyesUVz8XAGJ57wFIPHY4lNRk0++PJLLaW2XWWluJDXnqW5KYpgyMCfQJc1kL2pYXxNosr2x4HDls4P+WTCOMm/JgWBGVSiqgyuAy6UkxI/vBSUlFwKNM1r2a2E8jYHaerc1VzkEbbLOHQ7n83Uq5JHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746370477; c=relaxed/simple;
	bh=03VttfEWeGe35chk5/HC5sBSqIIG9xRh8q2rdbX8LjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQsmfPfe5U4ZIUuYxH4ajX40s5g1FIMzpHCnhckK8U84SiYyqgJ/5f9D80UfRfkeex+50h2b35mjIBae3bqSGHjpCkjQov4UNPr1B6l+3IXoCXDl8pVlHGbunXFZfJP0zC7XC9OY9oey89LyOJRk6thyHO4OD6W1oR8KtO4EzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8tPR5+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048B2C4CEE7;
	Sun,  4 May 2025 14:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746370476;
	bh=03VttfEWeGe35chk5/HC5sBSqIIG9xRh8q2rdbX8LjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r8tPR5+cXdHQ8IeoBRQXLo+7RB6KbdCuEHzr66CG9B8L6PaeknL9DSrJrUrAcEHvt
	 8gVaGBIfDzaWzbxCU5KGgqGApCqmqKmG4qKM0xjVrVMg79dRy7Q0H2KjKDHpgoDJVP
	 VkF5anpe4X/ksNGXnwR3E2PTiit7lfq6rdE+mE0c7eI0/o8UQrkG02+MqzK9mT08Kn
	 lfkf33JV/JpO7f4WlQKIakvHlGzuSBfHJjj7aWHz9MO9TgeO4ZDD8xrpJLncYFTEuc
	 XCF4ymw29GP8O89wafkOrmYdO+bSExBZojuceULnl99wCGUihvb31HSDjmyEfzzAVK
	 cHE6Dv7NW7nIA==
Date: Sun, 4 May 2025 15:54:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Beniamin Bia <beniamin.bia@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606_spi: fix reg write value mask
Message-ID: <20250504155428.5056519d@jic23-huawei>
In-Reply-To: <upz2umlx6qjnfiw5wvheukvfvolvea4anq7hky2vz5yi2w5wea@ormxyycioexv>
References: <20250428-iio-adc-ad7606_spi-fix-write-value-mask-v1-1-a2d5e85a809f@baylibre.com>
	<upz2umlx6qjnfiw5wvheukvfvolvea4anq7hky2vz5yi2w5wea@ormxyycioexv>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 10:34:14 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> On 28.04.2025 20:55, David Lechner wrote:
> > Fix incorrect value mask for register write. Register values are 8-bit,
> > not 9. If this function was called with a value > 0xFF and an even addr,
> > it would cause writing to the next register.
> > 
> > Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied and marked for stable.
> > ---
> >  drivers/iio/adc/ad7606_spi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> > index bd05357a542cf7234d5bb6b718829d6b720262cd..6c1228c7b1b11058cb5186513f032f7c8c8aa8f4 100644
> > --- a/drivers/iio/adc/ad7606_spi.c
> > +++ b/drivers/iio/adc/ad7606_spi.c
> > @@ -127,7 +127,7 @@ static int ad7606_spi_reg_write(struct ad7606_state *st,
> >  	struct spi_device *spi = to_spi_device(st->dev);
> >  
> >  	st->d16[0] = cpu_to_be16((st->bops->rd_wr_cmd(addr, 1) << 8) |
> > -				  (val & 0x1FF));
> > +				  (val & 0xFF));
> >  
> >  	return spi_write(spi, &st->d16[0], sizeof(st->d16[0]));
> >  }
> > 
> > ---
> > base-commit: aa1bd0b0ad048855d9efbee4ee8b9a6eee536256
> > change-id: 20250428-iio-adc-ad7606_spi-fix-write-value-mask-7acdcca46227  
> 
> Reviewed-by: Angelo Dureghello <adureghello@baylibre.com>
> 
> > 
> > Best regards,
> > -- 
> > David Lechner <dlechner@baylibre.com>
> >   
> 


