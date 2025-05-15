Return-Path: <linux-iio+bounces-19547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9E8AB8C2B
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 18:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5B3A06DDB
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC3E21B910;
	Thu, 15 May 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAU/zj6I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA43145323;
	Thu, 15 May 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747325879; cv=none; b=OCWV9SoY3hM1kN1d/UIZVFKg9G9yTAiSDMjCaeZu4JdijSdi8aFNZrmiVeTSDedwPK69u+jFk4m075a56qPg1Pf2xNO0jj/GkrsJCBr2qQJq7P22BxZLtovVhHeOJJ+1n9ZfZLLaqi3o10NqA+UysbjLmzpFDd7B0ONMimXYDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747325879; c=relaxed/simple;
	bh=kzHBF662pqxhsGGLZh7BrRVc0QDWCjDBYBSl6PTpfvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glYXYdG7+xeJX3BWoZPoGSLxGk+83547I6kV1xhYRSEnIpsfK6Zyi/q9GWgJC/IJkklBVojcaqSLy3QrgVeFaKGkF0aF7CJwLqhE+wTmW5u4jhpxNJh5snm1dtkGeUS50DOogW56GDabKC89SLYN7lkU0VxRjiK27IQa2MP1eYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAU/zj6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236C9C4CEE7;
	Thu, 15 May 2025 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747325879;
	bh=kzHBF662pqxhsGGLZh7BrRVc0QDWCjDBYBSl6PTpfvU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PAU/zj6IlrWsqfb2SsnaYNtPsn/moM1Ulix937tis2ax4a3E5/ptqkVdomKeo8aAr
	 sxBZJ+IBIGb1fw5xM0YgKoKXbGvsSdXqCbE39X2hCrOgFesPt+ZGTgdRorEL9eO7jP
	 4CYn5hfoKpPqACIlY/2roe9Imxnw2Xx0Kx/oXRPVB3UkOY8cZgTZHQw9FL3mbMExti
	 F9b/okD1Wtq6WOXhAVJJf0NGn2gmBMuquF2wy8qGR8KFZ4x5WbPdkNNQm2USRt68UJ
	 NTmY0Ev3uypj+5g8Y2Ta2N7Qfxmf6owzGHPbBb0C5VQkoyGRny2/ktY0oYWBuu53S0
	 L7gVxYTpJvjCg==
Date: Thu, 15 May 2025 17:17:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: accel: fxls8962af: Fix temperature readings
Message-ID: <20250515171752.06f2e617@jic23-huawei>
In-Reply-To: <20250505-fxls-v4-0-a38652e21738@geanix.com>
References: <20250505-fxls-v4-0-a38652e21738@geanix.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 05 May 2025 21:20:06 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Add the correct scale to get temperature in mili degree Celcius.
> Add sign component to temperature scan element.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Applied.

Thanks,

> ---
> Changes in v4:
> - Blindly Copy/Pasted  Andy's comment. Use the correct MILLIDEGREE_PER_DEGREE
> - Link to v3: https://lore.kernel.org/r/20250505-fxls-v3-0-8c541bf0205c@geanix.com
> 
> Changes in v3:
> - Dropping define infavor of inline scale value
> - Added using constants from units.h
> - Tweaked commit msg to make it more assertive
> - Link to v2: https://lore.kernel.org/r/20250502-fxls-v2-0-e1af65f1aa6c@geanix.com
> 
> Changes in v2:
> - Correct offset is applied before scaling component 
> - Added sign component to temperature scan element
> - Link to v1: https://lore.kernel.org/r/20250501-fxls-v1-1-f54061a07099@geanix.com
> 
> ---
> Sean Nyekjaer (2):
>       iio: accel: fxls8962af: Fix temperature calculation
>       iio: accel: fxls8962af: Fix temperature scan element sign
> 
>  drivers/iio/accel/fxls8962af-core.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> ---
> base-commit: 609bc31eca06c7408e6860d8b46311ebe45c1fef
> change-id: 20250501-fxls-307ef3d6d065
> 
> Best regards,


