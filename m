Return-Path: <linux-iio+bounces-9556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E1979138
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 15:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED48E1F22BF6
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B781CF7B6;
	Sat, 14 Sep 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ/+DIW5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFBA4C83;
	Sat, 14 Sep 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726322342; cv=none; b=UOmOq0BdxDTCc52KzcRnCUuCm7LSg8gMgVcIA4ca68c+ti3yyjNTsr/wPLKDFPN0Mnb+rhbApc1AP+Eq9oVEOkrAgSU1poM2EOj82/M115thjB9SMU5oYJ3l8NzUrIMr3/6DU3bUukkD2LJdhoGoP2gonsAQZkw7FurHdKMYU4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726322342; c=relaxed/simple;
	bh=JJmCLgSlEQdFPGZ/XJL2+wLA1WbdDjWdX0DRTpMH6uM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcRNuZCpjzw6kYANGTi0c4Qiejj3qpiCb+1OAArXQjj8s6YuZlgv3xKtx5oEvNf/DlOekNoAaAywOmzKUhEXBE5G4ahJoP2zSkVtmibFUzP4DTYm7OuT6uFs76bxy0aQR6PgoPqxrU06PXIEcqvlClSTceQYn2LytpPx0k/2Mz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ/+DIW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9BBC4CEC0;
	Sat, 14 Sep 2024 13:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726322342;
	bh=JJmCLgSlEQdFPGZ/XJL2+wLA1WbdDjWdX0DRTpMH6uM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eZ/+DIW5TFcB/oOC25xVaohsSe3B5cJUaBr0bnD8YG1gcP0eaInoM+8uA/09dcXyy
	 /P5JR0HZ/VogXd+821bTeowJVpaVDBYhTpL9wQqa6ZVn1JsGVyiVtE579qZu8VCdS/
	 OYkdmgeeUZu+8TtoJy0m6VwoDKLYKPPIxq5WV41g2ZAt6iNk9a9Pfz16uJ8d16/r5c
	 l24MjSFRTeiZinm48SsR07ssKKSumszEG0pxrzDt4wCkQ4WpYqd6rMOkUg5wWWnWB1
	 aHcEhJUb9TTxV2fVSXy+xPb264yilrKIjpA85K3ElnyTWFYl7mVp0/icK7lgY28rxU
	 HXjjoe5kGpp1Q==
Date: Sat, 14 Sep 2024 14:58:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: Dan Robertson <dan@dlrobertson.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Jagath Jog J <jagathjog1996@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] iio: accel: bma400: Fix uninitialized variable
 field_value in tap event handling.
Message-ID: <20240914145854.21569134@jic23-huawei>
In-Reply-To: <20240910083624.27224-1-m.lobanov@rosalinux.ru>
References: <20240910083624.27224-1-m.lobanov@rosalinux.ru>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 04:36:20 -0400
Mikhail Lobanov <m.lobanov@rosalinux.ru> wrote:

> In the current implementation, the local variable field_value is used
> without prior initialization, which may lead to reading uninitialized
> memory. Specifically, in the macro set_mask_bits, the initial
> (potentially uninitialized) value of the buffer is copied into old__,
> and a mask is applied to calculate new__. A similar issue was resolved in
> commit 6ee2a7058fea ("iio: accel: bma400: Fix smatch warning based on use
> of unintialized value.").
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 961db2da159d ("iio: accel: bma400: Add support for single and double tap events")
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Ok. It's not a bug as such because ultimately the bits that aren't set are masked out
but it is non obvious.  So applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bma400_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index e90e2f01550a..04083b7395ab 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -1219,7 +1219,8 @@ static int bma400_activity_event_en(struct bma400_data *data,
>  static int bma400_tap_event_en(struct bma400_data *data,
>  			       enum iio_event_direction dir, int state)
>  {
> -	unsigned int mask, field_value;
> +	unsigned int mask;
> +	unsigned int field_value = 0;
>  	int ret;
>  
>  	/*


