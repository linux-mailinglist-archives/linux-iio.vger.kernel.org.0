Return-Path: <linux-iio+bounces-13728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD749F9A61
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 20:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7CD189518A
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 19:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCDF2288FC;
	Fri, 20 Dec 2024 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxbFOOak"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87993221DA3;
	Fri, 20 Dec 2024 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722487; cv=none; b=M3g5R+qO8J7xltmG8xGbER1PUClXn0uOZngE8oJsyYvBrf9kvSU/B8WCGEltXMdKVODqiAYyAEyB8zjyXakxmy3gc91sIy6OEbTMY7pIahZiKBFYUqb+hg5mtRqL0Faj7WKAWw9lPtsn2yL6tiKtXDSXxba/eliWFaFV77rbLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722487; c=relaxed/simple;
	bh=YtvRMl62/mSOytLriWJ4eVw3mKa3puFY9bXuEt1ozyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3Nb6tlgNhKF+yOWJlK+JK3Ia4ts+x2lZ5MMJMhKa5Yocea1qyI6YIyk2AKJK6+4UKBClmYrrNKAqZzhP8SicFngiQtIlIRmEFAo8h8mwWsnYFzl8SHEwXwvFuRFJnbM9BqjqNgYmkwZhJqpYlxEpuMKsp9b0VMtndCNFLbEwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxbFOOak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1543EC4CED4;
	Fri, 20 Dec 2024 19:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734722487;
	bh=YtvRMl62/mSOytLriWJ4eVw3mKa3puFY9bXuEt1ozyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DxbFOOakF7Ob8n2udoGXQ+grZOuvEU553rMu0wcoxUhmsW31fT2Tp7Cr+EXhmR2ED
	 4ERMbyzHNzXLNK2S8+Lk9Saei0wBkryOxY4d4LjWmq6GAOydDLQtv5Y0QoYjzGcCFE
	 btfztJJFCEUcZDuMhadYDqA+fiMCfIaUTnCoLmw5977cg9IaUv8y403w6Jf2oZhZ3N
	 BGbWAdr+xtWNQ2C9ld4ZCjdTFv0rEGI3n5NBK7eUf6dFAvGEjrXdoHrQfhdXLI4v1b
	 oMhjo1ntYmjjiMaLVXwHcSwyg3neiH9ZuoIaHk99Q9SgOhv2TTpd7Rl1udcr5TXdOX
	 iMnVLmpPN+qZA==
Date: Fri, 20 Dec 2024 19:21:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, Mudit
 Sharma <muditsharma.info@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: gts: Simplify available scale table build
Message-ID: <20241220192118.3e9ba7f9@jic23-huawei>
In-Reply-To: <Z1_rRXqdhxhL6wBw@mva-rohm>
References: <Z1_rRXqdhxhL6wBw@mva-rohm>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 10:56:37 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Make available scale building more clear. This hurts the performance
> quite a bit by looping throgh the scales many times instead of doing
> everything in one loop. It however simplifies logic by:
>  - decoupling the gain and scale allocations & computations
>  - keeping the temporary 'per_time_gains' table inside the
>    per_time_scales computation function.
>  - separating building the 'all scales' table in own function and doing
>    it based on the already computed per-time scales.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Looks good to me, but I want to leave it on list a while before applying.
Ideal if it gets some tested-by or other tags before I pick it up.
As always, this is fiddly code, so the more eyes the better!

Jonathan

> ---
> Revision history:
>  v2:
>     - Add a few comments
>     - Use more descriptive variable name
> 
> This is still only tested using the kunit tests. All further testing is
> still highly appreciated!
> ---
>  drivers/iio/industrialio-gts-helper.c | 272 ++++++++++++++++----------
>  1 file changed, 174 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 291c0fc332c9..65697be58a10 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -160,16 +160,123 @@ static void iio_gts_purge_avail_scale_table(struct iio_gts *gts)
>  	gts->num_avail_all_scales = 0;
>  }
>  
> +static int scale_eq(int *sc1, int *sc2)
> +{
> +	return sc1[0] == sc2[0] && sc1[1] == sc2[1];
> +}
> +
> +static int scale_smaller(int *sc1, int *sc2)
> +{
> +	if (sc1[0] != sc2[0])
> +		return sc1[0] < sc2[0];
> +
> +	/* If integer parts are equal, fixp parts */
> +	return sc1[1] < sc2[1];
> +}
> +
> +/*
> + * Do a single table listing all the unique scales that any combination of
> + * supported gains and times can provide.
> + */
> +static int do_combined_scaletable(struct iio_gts *gts,
> +				  size_t all_scales_tbl_bytes)
> +{
> +	int t_idx, i, new_idx;
> +	int **scales = gts->per_time_avail_scale_tables;
> +	int *all_scales = kcalloc(gts->num_itime, all_scales_tbl_bytes,
> +				  GFP_KERNEL);
> +
> +	if (!all_scales)
> +		return -ENOMEM;
> +	/*
> +	 * Create table containing all of the supported scales by looping
> +	 * through all of the per-time scales and copying the unique scales
> +	 * into one sorted table.
> +	 *
> +	 * We assume all the gains for same integration time were unique.
> +	 * It is likely the first time table had greatest time multiplier as
> +	 * the times are in the order of preference and greater times are
> +	 * usually preferred. Hence we start from the last table which is likely
> +	 * to have the smallest total gains.
> +	 */
> +	t_idx = gts->num_itime - 1;
> +	memcpy(all_scales, scales[t_idx], all_scales_tbl_bytes);
> +	new_idx = gts->num_hwgain * 2;
> +
> +	while (t_idx-- > 0) {
> +		for (i = 0; i < gts->num_hwgain ; i++) {
> +			int *candidate = &scales[t_idx][i * 2];
> +			int chk;
> +
> +			if (scale_smaller(candidate, &all_scales[new_idx - 2])) {
> +				all_scales[new_idx] = candidate[0];
> +				all_scales[new_idx + 1] = candidate[1];
> +				new_idx += 2;
> +
> +				continue;
> +			}
> +			for (chk = 0; chk < new_idx; chk += 2)
> +				if (!scale_smaller(candidate, &all_scales[chk]))
> +					break;
> +
> +			if (scale_eq(candidate, &all_scales[chk]))
> +				continue;
> +
> +			memmove(&all_scales[chk + 2], &all_scales[chk],
> +				(new_idx - chk) * sizeof(int));
> +			all_scales[chk] = candidate[0];
> +			all_scales[chk + 1] = candidate[1];
> +			new_idx += 2;
> +		}
> +	}
> +
> +	gts->num_avail_all_scales = new_idx / 2;
> +	gts->avail_all_scales_table = all_scales;
> +
> +	return 0;
> +}
> +
> +static void iio_gts_free_int_table_array(int **arr, int num_tables)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_tables; i++)
> +		kfree(arr[i]);
> +
> +	kfree(arr);
> +}
> +
> +static int iio_gts_alloc_int_table_array(int ***arr, int num_tables, int num_table_items)
> +{
> +	int i, **tmp;
> +
> +	tmp = kcalloc(num_tables, sizeof(**arr), GFP_KERNEL);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_tables; i++) {
> +		tmp[i] = kcalloc(num_table_items, sizeof(int), GFP_KERNEL);
> +		if (!tmp[i])
> +			goto err_free;
> +	}
> +
> +	*arr = tmp;
> +
> +	return 0;
> +err_free:
> +	iio_gts_free_int_table_array(tmp, i);
> +
> +	return -ENOMEM;
> +}
> +
>  static int iio_gts_gain_cmp(const void *a, const void *b)
>  {
>  	return *(int *)a - *(int *)b;
>  }
>  
> -static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
> +static int fill_and_sort_scaletables(struct iio_gts *gts, int **gains, int **scales)
>  {
> -	int i, j, new_idx, time_idx, ret = 0;
> -	int *all_gains;
> -	size_t gain_bytes;
> +	int i, j, ret;
>  
>  	for (i = 0; i < gts->num_itime; i++) {
>  		/*
> @@ -189,71 +296,69 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>  		}
>  	}
>  
> -	gain_bytes = array_size(gts->num_hwgain, sizeof(int));
> -	all_gains = kcalloc(gts->num_itime, gain_bytes, GFP_KERNEL);
> -	if (!all_gains)
> -		return -ENOMEM;
> +	return 0;
> +}
> +
> +static void compute_per_time_gains(struct iio_gts *gts, int **gains)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < gts->num_itime; i++) {
> +		for (j = 0; j < gts->num_hwgain; j++)
> +			gains[i][j] = gts->hwgain_table[j].gain *
> +				      gts->itime_table[i].mul;
> +	}
> +}
> +
> +static int compute_per_time_tables(struct iio_gts *gts, int **scales)
> +{
> +	int **per_time_gains;
> +	int ret;
>  
>  	/*
> -	 * We assume all the gains for same integration time were unique.
> -	 * It is likely the first time table had greatest time multiplier as
> -	 * the times are in the order of preference and greater times are
> -	 * usually preferred. Hence we start from the last table which is likely
> -	 * to have the smallest total gains.
> +	 * Create a temporary array of the 'total gains' for each integration
> +	 * time.
>  	 */
> -	time_idx = gts->num_itime - 1;
> -	memcpy(all_gains, gains[time_idx], gain_bytes);
> -	new_idx = gts->num_hwgain;
> +	ret = iio_gts_alloc_int_table_array(&per_time_gains, gts->num_itime,
> +					    gts->num_hwgain);
> +	if (ret)
> +		return ret;
>  
> -	while (time_idx-- > 0) {
> -		for (j = 0; j < gts->num_hwgain; j++) {
> -			int candidate = gains[time_idx][j];
> -			int chk;
> +	compute_per_time_gains(gts, per_time_gains);
>  
> -			if (candidate > all_gains[new_idx - 1]) {
> -				all_gains[new_idx] = candidate;
> -				new_idx++;
> +	/* Convert the gains to scales and populate the scale tables */
> +	ret = fill_and_sort_scaletables(gts, per_time_gains, scales);
>  
> -				continue;
> -			}
> -			for (chk = 0; chk < new_idx; chk++)
> -				if (candidate <= all_gains[chk])
> -					break;
> +	iio_gts_free_int_table_array(per_time_gains, gts->num_itime);
>  
> -			if (candidate == all_gains[chk])
> -				continue;
> +	return ret;
> +}
>  
> -			memmove(&all_gains[chk + 1], &all_gains[chk],
> -				(new_idx - chk) * sizeof(int));
> -			all_gains[chk] = candidate;
> -			new_idx++;
> -		}
> -	}
> +/*
> + * Create a table of supported scales for each supported integration time.
> + * This can be used as available_scales by drivers which don't allow scale
> + * setting to change the integration time to display correct set of scales
> + * depending on the used integration time.
> + */
> +static int **create_per_time_scales(struct iio_gts *gts)
> +{
> +	int **per_time_scales, ret;
>  
> -	gts->avail_all_scales_table = kcalloc(new_idx, 2 * sizeof(int),
> -					      GFP_KERNEL);
> -	if (!gts->avail_all_scales_table) {
> -		ret = -ENOMEM;
> -		goto free_out;
> -	}
> -	gts->num_avail_all_scales = new_idx;
> +	ret = iio_gts_alloc_int_table_array(&per_time_scales, gts->num_itime,
> +					    gts->num_hwgain * 2);
> +	if (ret)
> +		return ERR_PTR(ret);
>  
> -	for (i = 0; i < gts->num_avail_all_scales; i++) {
> -		ret = iio_gts_total_gain_to_scale(gts, all_gains[i],
> -					&gts->avail_all_scales_table[i * 2],
> -					&gts->avail_all_scales_table[i * 2 + 1]);
> +	ret = compute_per_time_tables(gts, per_time_scales);
> +	if (ret)
> +		goto err_out;
>  
> -		if (ret) {
> -			kfree(gts->avail_all_scales_table);
> -			gts->num_avail_all_scales = 0;
> -			goto free_out;
> -		}
> -	}
> +	return per_time_scales;
>  
> -free_out:
> -	kfree(all_gains);
> +err_out:
> +	iio_gts_free_int_table_array(per_time_scales, gts->num_itime);
>  
> -	return ret;
> +	return ERR_PTR(ret);
>  }
>  
>  /**
> @@ -275,55 +380,26 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>   */
>  static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
>  {
> -	int **per_time_gains, **per_time_scales, i, j, ret = -ENOMEM;
> -
> -	per_time_gains = kcalloc(gts->num_itime, sizeof(*per_time_gains), GFP_KERNEL);
> -	if (!per_time_gains)
> -		return ret;
> -
> -	per_time_scales = kcalloc(gts->num_itime, sizeof(*per_time_scales), GFP_KERNEL);
> -	if (!per_time_scales)
> -		goto free_gains;
> +	int ret, all_scales_tbl_bytes;
> +	int **per_time_scales;
>  
> -	for (i = 0; i < gts->num_itime; i++) {
> -		per_time_scales[i] = kcalloc(gts->num_hwgain, 2 * sizeof(int),
> -					     GFP_KERNEL);
> -		if (!per_time_scales[i])
> -			goto err_free_out;
> -
> -		per_time_gains[i] = kcalloc(gts->num_hwgain, sizeof(int),
> -					    GFP_KERNEL);
> -		if (!per_time_gains[i]) {
> -			kfree(per_time_scales[i]);
> -			goto err_free_out;
> -		}
> -
> -		for (j = 0; j < gts->num_hwgain; j++)
> -			per_time_gains[i][j] = gts->hwgain_table[j].gain *
> -					       gts->itime_table[i].mul;
> -	}
> +	if (unlikely(check_mul_overflow(gts->num_hwgain, 2 * sizeof(int),
> +					&all_scales_tbl_bytes)))
> +		return -EOVERFLOW;
>  
> -	ret = gain_to_scaletables(gts, per_time_gains, per_time_scales);
> -	if (ret)
> -		goto err_free_out;
> +	per_time_scales = create_per_time_scales(gts);
> +	if (IS_ERR(per_time_scales))
> +		return PTR_ERR(per_time_scales);
>  
> -	for (i = 0; i < gts->num_itime; i++)
> -		kfree(per_time_gains[i]);
> -	kfree(per_time_gains);
>  	gts->per_time_avail_scale_tables = per_time_scales;
>  
> -	return 0;
> -
> -err_free_out:
> -	for (i--; i >= 0; i--) {
> -		kfree(per_time_scales[i]);
> -		kfree(per_time_gains[i]);
> +	ret = do_combined_scaletable(gts, all_scales_tbl_bytes);
> +	if (ret) {
> +		iio_gts_free_int_table_array(per_time_scales, gts->num_itime);
> +		return ret;
>  	}
> -	kfree(per_time_scales);
> -free_gains:
> -	kfree(per_time_gains);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static void iio_gts_us_to_int_micro(int *time_us, int *int_micro_times,


