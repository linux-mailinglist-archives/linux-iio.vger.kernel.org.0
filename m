Return-Path: <linux-iio+bounces-8477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FDC952261
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 20:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC071F223AD
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 18:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92991BD50A;
	Wed, 14 Aug 2024 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqvPkbXu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0183BBCB
	for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2024 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661931; cv=none; b=uBawnA6RQT+IOKm1TiR1/3LmqrOMmd9YGJZjqp8MwVqVJA8WxAuUfp6RZJD89BdcjUR2lC1bedhRZ7I63WHm7Px0n+pTqbCkw/A+JL+3WVpz9lYkZO3aSUjLj+lcd358PJ+gtBpQpH7DDFMbV4+964MQ/dq8KiibneOvvSrIdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661931; c=relaxed/simple;
	bh=tZ9YlNP5AjLZ5Aw0sOVDui8QTKFfd/kxVNQijb0b1T0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owH8D2Dy0VS4h8mx45NSQlYutfA64V3G+3zZ9zafTAK548ENso/X5bVCUcPMEG+RDidnMS4q8NMWfpp1fvqGPtfx2hsmOZrE50jVVbejTGx1q/P4TOIS8D214pJid3MKgzfDvi8jFfmbsX/6JGtlbmsOMAX57Rj+6pjxrTqP2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqvPkbXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4CAC116B1;
	Wed, 14 Aug 2024 18:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723661931;
	bh=tZ9YlNP5AjLZ5Aw0sOVDui8QTKFfd/kxVNQijb0b1T0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kqvPkbXuJZ9q484Y0KA72YYdpAGfJOYp63QWUmQ6fcUD0SRdUYLvYZUlominlnDSq
	 LaYY1z6d8quZR2TsF2pJRhWC0PNeXrNOkx3k3Tz2YUy1FCgeyHnb4Th4cUakNeXtha
	 hG94vth5AQJFNuhXQJ/VchfaKgwzskdtpDfriLaB2ZpjcpdmS88hHbxO/1pWgrLPAu
	 1pMwnh2PB3iBLMdfUSVGkovoF0EQg2WLRtQAN7o2RMCOt6rzwLCbsLcRE12e8p6Vht
	 QQ5dBcpI9y7oV3Xuo/SUfiLR3+ZsiwZfoaXkXus9EpMog7MSjuQqc13r8E+3lmS2Ja
	 0zFmv767r6PVQ==
Date: Wed, 14 Aug 2024 19:58:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: light: noa1305: Make integration time
 configurable
Message-ID: <20240814195844.71f6ba35@jic23-huawei>
In-Reply-To: <fb9734ff-5029-4855-971a-3dc734881b4e@stanley.mountain>
References: <fb9734ff-5029-4855-971a-3dc734881b4e@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 10:12:12 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hello Marek Vasut,
> 
> Commit 025f23cfebad ("iio: light: noa1305: Make integration time
> configurable") from Jul 15, 2024 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	drivers/iio/light/noa1305.c:201 noa1305_write_raw()
> 	error: buffer overflow 'noa1305_int_time_available' 16 <= 31
> 
> drivers/iio/light/noa1305.c
>     183 static int noa1305_write_raw(struct iio_dev *indio_dev,
>     184                              struct iio_chan_spec const *chan,
>     185                              int val, int val2, long mask)
>     186 {
>     187         struct noa1305_priv *priv = iio_priv(indio_dev);
>     188         int i;
>     189 
>     190         if (chan->type != IIO_LIGHT)
>     191                 return -EINVAL;
>     192 
>     193         if (mask != IIO_CHAN_INFO_INT_TIME)
>     194                 return -EINVAL;
>     195 
>     196         if (val)        /* >= 1s integration time not supported */
>     197                 return -EINVAL;
>     198 
>     199         /* Look up integration time register settings and write it if found. */
>     200         for (i = 0; i < ARRAY_SIZE(noa1305_int_time_available); i++)
>                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^
Good find. Should be ARRAY_SIZE() / 2 I think.

Marek, spin a patch?  If not I'll get to it soonish.
> 
> --> 201                 if (noa1305_int_time_available[2 * i + 1] == val2)  
>                                                        ^^^^^^^^^
> Buffer overflow
> 
>     202                         return regmap_write(priv->regmap, NOA1305_REG_INTEGRATION_TIME, i);
>     203 
>     204         return -EINVAL;
>     205 }
> 
> regards,
> dan carpenter
> 


