Return-Path: <linux-iio+bounces-12556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D11119D6A39
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 17:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4EAB20EAB
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C9C55887;
	Sat, 23 Nov 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9wRfaeE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696DB17C2;
	Sat, 23 Nov 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732379842; cv=none; b=AzWPnlC/+Wv0DCX/pbDIg4hn5bzA8d+L6USLe145XgBw0l5v6MkG2CMrB/tqG9bT8q97sRk38yVAglikox5kg3kAnKTpywj95Umn36I+2C/EHy6ZCrevUVAU8xXIBR7YQ6enrf4EMlL34leASMi//6H3bwnEbw/dZGiFDUiNaBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732379842; c=relaxed/simple;
	bh=kqH1w9Z8UduwiuIpADpEHdaVEmAdD805XjHs5FU9NaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=civpOxEK4nDPUVTCenSkxlrckpzCdUnqmDYsxFm13qZOSsArnETfujBDhjL0baen7jLun87yBA0Wbo4t8BIYGjD0o6kNAh6ituteoiCLG5s6GeaEzxLKjdVWegzXZgpyKRoytkJwliWlmQE2bcKKwNBGyWID+5BIYDkBFMNjNX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9wRfaeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F215C4CECD;
	Sat, 23 Nov 2024 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732379841;
	bh=kqH1w9Z8UduwiuIpADpEHdaVEmAdD805XjHs5FU9NaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m9wRfaeE70vgISBrAllJAY+9XEF/fzB+HC+QeB65cO9E+ZOxBE4mmvjG3IiiB4P1W
	 zLkLqLajo5MwtEJMdeBLg6ISLO0832b14DkAFwH9VUneZVsdmgduN/yq/jIRfpcImN
	 Gbqyrj7xtr9HNt1CwKDBRmV9WU8CNNpcyagjopDv0iBWMvRhgPckKrvv6XT4XPq+li
	 G+Lb4hdMSm+ehvCCD+pCPKvBXg+yuUrXNfSlsWwCx3TYt0uVcJVZSnSwMhOWEIqf6e
	 d4Qie96zoWn5pTcJUlBnWubVathEvsPWsuv2t9E+9xzX7lJb//1M+GT2E1imkguVGv
	 bRKuMRVZkHlVA==
Date: Sat, 23 Nov 2024 16:37:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] iio: gts: Simplify using __free
Message-ID: <20241123163713.2ec03a37@jic23-huawei>
In-Reply-To: <5efc30d832275778d1f48d7e2c75b1ecc63511d5.1732105157.git.mazziesaccount@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
	<5efc30d832275778d1f48d7e2c75b1ecc63511d5.1732105157.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 10:20:07 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The error path in the gain_to_scaletables() uses goto for unwinding an
> allocation on failure. This can be slightly simplified by using the
> automated free when exiting the scope.
> 
> Use __free(kfree) and drop the goto based error handling.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> 
> Revision history:
>   v1 => v2:
>   - patch number changed because a change was added to the series.
>   - rebased on iio/testing to avoid conflicts with queued fixes
> ---
>  drivers/iio/industrialio-gts-helper.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 291c0fc332c9..602d3d338e66 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> @@ -167,8 +168,8 @@ static int iio_gts_gain_cmp(const void *a, const void *b)
>  
>  static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>  {
> -	int i, j, new_idx, time_idx, ret = 0;
> -	int *all_gains;
> +	int ret, i, j, new_idx, time_idx;
> +	int *all_gains __free(kfree) = NULL;
See the docs in cleanup.h (added recently).

Constructor and destructor should go together.   Dan wrote good docs on this
(which are now in cleanup.h) so I'll not go into why!

Upshot is this goes where you do the kcalloc, not up here.

>  	size_t gain_bytes;
>  
>  	for (i = 0; i < gts->num_itime; i++) {
> @@ -232,10 +233,9 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>  
>  	gts->avail_all_scales_table = kcalloc(new_idx, 2 * sizeof(int),
>  					      GFP_KERNEL);
> -	if (!gts->avail_all_scales_table) {
> -		ret = -ENOMEM;
> -		goto free_out;
> -	}
> +	if (!gts->avail_all_scales_table)
> +		return -ENOMEM;
> +
>  	gts->num_avail_all_scales = new_idx;
>  
>  	for (i = 0; i < gts->num_avail_all_scales; i++) {
> @@ -246,14 +246,11 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>  		if (ret) {
>  			kfree(gts->avail_all_scales_table);
>  			gts->num_avail_all_scales = 0;
> -			goto free_out;
> +			return ret;
>  		}
>  	}
>  
> -free_out:
> -	kfree(all_gains);
> -
> -	return ret;
> +	return 0;
>  }
>  
>  /**


