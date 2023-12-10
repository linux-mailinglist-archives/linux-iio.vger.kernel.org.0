Return-Path: <linux-iio+bounces-805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E3D80BB99
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 15:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896D51C20930
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3528813FFD;
	Sun, 10 Dec 2023 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUh+fVk1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B2C12F;
	Sun, 10 Dec 2023 14:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA2BC433C7;
	Sun, 10 Dec 2023 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702218163;
	bh=jN6uzRWmmGFEhpJKZKXMmzG8V3dn+Y/d+3+tfSvJJ/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QUh+fVk1P2ElqVFYtDZiqwJL4NTbgvdlY1t69x6/T1s6zKSbT1t65F4M9xQhx0YVB
	 Ry57wn5pA0QlVjaTes6RiMMMlUVxyNcE/ZJcWDWu525Q99mvhuvLqg+hCS38ZFFo1V
	 2WyWVUL7wP4rN5BpQCjCT3LdFBvRdR9+Ob6YeAv2UUc1VgMItaE21e/7Rib5sAkD+3
	 CfcI7XmvuHm9QmHqjDVTQpXx6QUQ8IQjrR4cFbiViyfhEsyTkbx7Gs7o3XNz3c3U7N
	 T2/e0lQ0iD/0SJiziyQeVin09aH5bk0Np0ll9/aRA1ArElsvr2u0HWbqCEyw5Xavay
	 nd1OWgDrZ3utQ==
Date: Sun, 10 Dec 2023 14:22:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH v2 3/8] driver: core: allow modifying device_links flags
Message-ID: <20231210142236.4bbc6db4@jic23-huawei>
In-Reply-To: <20231208-dev-iio-backend-v2-3-5450951895e1@analog.com>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
	<20231208-dev-iio-backend-v2-3-5450951895e1@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 Dec 2023 16:14:10 +0100
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

Trivial but this blank line seems unwanted variation in formatting.

> +		} else if (flags & DL_FLAG_AUTOREMOVE_CONSUMER) {
> +			link->flags &= ~DL_FLAG_AUTOREMOVE_SUPPLIER;
> +			link->flags &= ~DL_FLAG_AUTOPROBE_CONSUMER;
> +			link->flags |= DL_FLAG_AUTOREMOVE_CONSUMER;
> +		} else {
>  			link->flags &= ~(DL_FLAG_AUTOREMOVE_CONSUMER |
>  					 DL_FLAG_AUTOREMOVE_SUPPLIER);
>  		}
> 


