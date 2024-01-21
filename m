Return-Path: <linux-iio+bounces-1805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D568C835713
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 18:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118A51C20AD6
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 17:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2453381BF;
	Sun, 21 Jan 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5sN1fWe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD504FBFA;
	Sun, 21 Jan 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705857661; cv=none; b=fIuz9TzM4xQY8yxCZ1PNqQvP94Ind3rgqTOZ/w3qdy99fhZGOA1dMXdfPuUD6QBr//YDD3w3pLckHDPYIybjlkjAC1LgfK9jxm2LqSYlaiNJCK4zp8wotgxPJwjdtsNudunw+9/9YZifwfCEpjVI/wSS01Bd0VYl6NCLi8vkUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705857661; c=relaxed/simple;
	bh=UE2zBBIEQEnrIlIyEVcaouPk0IJlvT21BR3gdxJo4es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WB+fjqRlgukq7OGlvg5icaoU2V8gIUW3AoLo3jCU8noQ+BQfQWWKYBB99lUvTuzfXkd6ZGCzpIOjliHkl5xaORl3KARToUO1lwUP8SaZRYWUU4O+cupBUaQWe9SxMrVm+enTTnJlSxUc1vhAQy6htny3Yr8SmrNmgYCa/K5c0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5sN1fWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A3DC433C7;
	Sun, 21 Jan 2024 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705857661;
	bh=UE2zBBIEQEnrIlIyEVcaouPk0IJlvT21BR3gdxJo4es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J5sN1fWePx5Wuv6bIAmB0OjbAGxSEc8jzkeT/gBDxROEw9gEt+KPgNjH2Va0IkeuM
	 hqt5NanKRDtTKCDH2BHiNFEqhNggdxQVzxPkApOQKtkrhAzTyD6cDBCpFYlwyvwOHO
	 Z1zJSYs71v4KThn8+6enz0bMKgy1hpXywL/zhRnWiBqHJu2+FjcY6KTyOS+4OSFyYW
	 0/12QR9dBdMu4wcb/Espoo33RVuPoW9hzTqjyH91+98KiJaRxzKZ73/OfIwomxa4T0
	 rGpY6ovc+uTRsPaT63raq2x3sKYC1AWG2y9+7bdASeTcrVJZh9BsWx1MFCO130CWRR
	 zFw2hd/VeLY2w==
Date: Sun, 21 Jan 2024 17:20:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v6 3/8] driver: core: allow modifying device_links flags
Message-ID: <20240121172046.450296bc@jic23-huawei>
In-Reply-To: <20240119-iio-backend-v6-3-189536c35a05@analog.com>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
	<20240119-iio-backend-v6-3-189536c35a05@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 17:00:49 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> If a device_link is previously created (eg: via
> fw_devlink_create_devlink()) before the supplier + consumer are both
> present and bound to their respective drivers, there's no way to set
> DL_FLAG_AUTOREMOVE_CONSUMER anymore while one can still set
> DL_FLAG_AUTOREMOVE_SUPPLIER. Hence, rework the flags checks to allow
> for DL_FLAG_AUTOREMOVE_CONSUMER in the same way
> DL_FLAG_AUTOREMOVE_SUPPLIER is done.
> 
> While at it, make sure that we are never left with
> DL_FLAG_AUTOPROBE_CONSUMER set together with one of
> DL_FLAG_AUTOREMOVE_CONSUMER or DL_FLAG_AUTOREMOVE_SUPPLIER.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

Looking for an Ack or RB from someone more familiar with device links
than I am.

Greg / Rafael?  

thanks

Jonathan

> ---
>  drivers/base/core.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67ba592afc77..fdbb5abc75d5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -807,11 +807,15 @@ struct device_link *device_link_add(struct device *consumer,
>  		 * update the existing link to stay around longer.
>  		 */
>  		if (flags & DL_FLAG_AUTOREMOVE_SUPPLIER) {
> -			if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER) {
> -				link->flags &= ~DL_FLAG_AUTOREMOVE_CONSUMER;
> -				link->flags |= DL_FLAG_AUTOREMOVE_SUPPLIER;
> -			}
> -		} else if (!(flags & DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +			link->flags &= ~DL_FLAG_AUTOREMOVE_CONSUMER;
> +			link->flags &= ~DL_FLAG_AUTOPROBE_CONSUMER;
> +			link->flags |= DL_FLAG_AUTOREMOVE_SUPPLIER;
> +
> +		} else if (flags & DL_FLAG_AUTOREMOVE_CONSUMER) {
> +			link->flags &= ~DL_FLAG_AUTOREMOVE_SUPPLIER;
> +			link->flags &= ~DL_FLAG_AUTOPROBE_CONSUMER;
> +			link->flags |= DL_FLAG_AUTOREMOVE_CONSUMER;
> +		} else {
>  			link->flags &= ~(DL_FLAG_AUTOREMOVE_CONSUMER |
>  					 DL_FLAG_AUTOREMOVE_SUPPLIER);
>  		}
> 


