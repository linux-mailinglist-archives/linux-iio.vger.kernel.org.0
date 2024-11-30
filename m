Return-Path: <linux-iio+bounces-12875-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDCC9DF26C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 19:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C683B20E76
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B811A072A;
	Sat, 30 Nov 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQeuvl0/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E0192D6E;
	Sat, 30 Nov 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989685; cv=none; b=sCVPkESYEiV8jz3fBEtFd9RYiwku/gSlJJMsi3DzdW3Nbjb9FWS1BF+xyGcKyWoFgspPPuZ8x7wDe9siSOH81RmWMN25s1hc9jH3CEGzJ4oy1LhbYFrf1uf0EN675VTZEBCVnB6/6dIn0zkDQgNfghFZEuwWmiZmOgBz8Ipp+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989685; c=relaxed/simple;
	bh=MK9TfLeWISJA+7KJl6jJJ7/NmaphMBufNbyqpX/RkdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sP+i30tpCytYgexKyyqTA0XCJEprf9yOYZhk44kkXW47+3uJ6HmfIoFsJTDVGJ0OH1TLw77626yjDl32ZUxd4kVjlDXOh1r5MaRqmtxic2Be7DbopizdYoebiLO2QncsG8iAsdUPYNXBJ48SFnhIsBx+nF+BGod0THTttAbcDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQeuvl0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F81CC4CECC;
	Sat, 30 Nov 2024 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732989685;
	bh=MK9TfLeWISJA+7KJl6jJJ7/NmaphMBufNbyqpX/RkdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EQeuvl0/2vsMks9ijTy1TDNHYBopgnY9j/H+vdmH7uHQY8C16BqZ6x5yIE7NWZ7mR
	 M0r7+kveBGpGBaUPzwYLO5ErdYI/9UHNasHfnwOrTDVoRk497oAb0MBWwi8fOAdTs9
	 OviPvS2hwn9xQF7w4b4mnAUO8Vd0zFQmu5ljluySMXcdj6Vx4AlKUHFm25EZBMygOR
	 Ye+I2jO2hKLcry1sRW86F2B/WpVef881HbfUDZQ66/UxzFmC2RI8Cdv0kZlThvXi4B
	 53IEE+L+VUqyyRVaykhr3DfHLoQvhk9DiNiaUjq5FQ8gVLJ3mO7UcU9zHQxudeeJ04
	 KjjwvV+8Kz1sA==
Date: Sat, 30 Nov 2024 18:01:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: gts: simplify scale table build
Message-ID: <20241130180117.088352ce@jic23-huawei>
In-Reply-To: <4b05448b65969f9f433f7ac3aa234c33025ad262.1732811829.git.mazziesaccount@gmail.com>
References: <cover.1732811829.git.mazziesaccount@gmail.com>
	<4b05448b65969f9f433f7ac3aa234c33025ad262.1732811829.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 18:51:00 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The GTS helpers offer two different set of "available scales" -tables.
> Drivers can choose to advertice the scales which are available on a
> currently selected integration time (by just changing the hwgain).
> Another option is to list all scales which can be supported using any of
> the integration times. This is useful for drivers which allow scale
> setting to also change the integration time to meet the scale user
> prefers.
> 
> The helper function which build these tables for the GTS did firstbuild
The helper function which builds these tables for the GTS first builds the "time specific" ..

> the "time specific" scale arrays for all the times. This is done by
> calculating the scales based on the integration time specific "total
> gain" arrays (gain contributed by both the integration time and hw-gain).
> 
> After this the helper code calculates an array for all available scales.
> This is done combining all the time specific total-gains into one sorted
> array, removing dublicate gains and finally converting the gains to
> scales as above.
> 
> This can be somewhat simplified by changing the logic for calculating
> the 'all available scales' -array to directly use the time specific
> scale arrays instead of time specific total-gain arrays. Code can
> directly just add all the already computed time specific scales to one
> big 'all scales'-array, keep it sorted and remove duplicates.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
Minor comments inline.

Thanks,

Jonathan

> ---
> 
> This has been tested by IIO-gts kunit tests only. All testing is
> appreciated.
> 
> Comparing the scales is not as pretty as comparing the gains was, as
> scales are in two ints where the gains were in one. This makes the code
> slightly more hairy. I however believe that the logic is now more
> obvious. This might be more important for one reading this later...
> ---
>  drivers/iio/industrialio-gts-helper.c | 109 ++++++++++----------------
>  1 file changed, 42 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 7f900f578f1d..31101848b194 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -191,86 +191,61 @@ static int fill_and_sort_scaletables(struct iio_gts *gts, int **gains, int **sca
>  	return 0;
>  }
>  
> -static int combine_gain_tables(struct iio_gts *gts, int **gains,
> -			       int *all_gains, size_t gain_bytes)
> +static int scale_eq(int *sc1, int *sc2)
>  {
> -	int i, new_idx, time_idx;
> +	return *sc1 == *sc2 && *(sc1 + 1) == *(sc2 + 1);
	return sc1[0] == sc2[0] && sc1[1] == sc2[1];

Would be easier to read in my opinion.

> +}
>  
> -	/*
> -	 * We assume all the gains for same integration time were unique.
> -	 * It is likely the first time table had greatest time multiplier as
> -	 * the times are in the order of preference and greater times are
> -	 * usually preferred. Hence we start from the last table which is likely
> -	 * to have the smallest total gains.
> -	 */
> -	time_idx = gts->num_itime - 1;
> -	memcpy(all_gains, gains[time_idx], gain_bytes);
> -	new_idx = gts->num_hwgain;
> +static int scale_smaller(int *sc1, int *sc2)
> +{
> +	if (*sc1 != *sc2)
> +		return *sc1 < *sc2;
> +
> +	/* If integer parts are equal, fixp parts */
> +	return *(sc1 + 1) < *(sc2 + 1);
> +}
> +
> +static int do_combined_scaletable(struct iio_gts *gts, int **scales, size_t scale_bytes)
> +{
> +	int t_idx, i, new_idx;
> +	int *all_scales = kcalloc(gts->num_itime, scale_bytes, GFP_KERNEL);
>  
> -	while (time_idx-- > 0) {
> -		for (i = 0; i < gts->num_hwgain; i++) {
> -			int candidate = gains[time_idx][i];
> +	if (!all_scales)
> +		return -ENOMEM;
> +
> +	t_idx = gts->num_itime - 1;
> +	memcpy(all_scales, scales[t_idx], scale_bytes);
> +	new_idx = gts->num_hwgain * 2;
> +
> +	while (t_idx-- > 0) {
maybe a reverse for loop is clearer

	for (tidx = t_idx; tidx; tidx--)
For me a for loop indicates bounds are known and we change the index
one per loop. While loop indicates either unknown bounds, or that we are
modifying the index other than than in the loop controls.


> +		for (i = 0; i < gts->num_hwgain ; i++) {

Extra space after hwgain

> +			int *candidate = &scales[t_idx][i * 2];
>  			int chk;
>  
> -			if (candidate > all_gains[new_idx - 1]) {
> -				all_gains[new_idx] = candidate;
> -				new_idx++;
> +			if (scale_smaller(candidate, &all_scales[new_idx - 2])) {
> +				all_scales[new_idx] = *candidate;

Maybe candidate[0] and candidate[1] will be more readable as it's effectively a row of
of 2D matrix.

> +				all_scales[new_idx + 1] = *(candidate + 1);
> +				new_idx += 2;
>  
>  				continue;
>  			}
> -			for (chk = 0; chk < new_idx; chk++)
> -				if (candidate <= all_gains[chk])
> +			for (chk = 0; chk < new_idx; chk += 2)
> +				if (!scale_smaller(candidate, &all_scales[chk]))
>  					break;
>  
> -			if (candidate == all_gains[chk])
> +
> +			if (scale_eq(candidate, &all_scales[chk]))
>  				continue;
>  
> -			memmove(&all_gains[chk + 1], &all_gains[chk],
> +			memmove(&all_scales[chk + 2], &all_scales[chk],
>  				(new_idx - chk) * sizeof(int));
> -			all_gains[chk] = candidate;
> -			new_idx++;
> +			all_scales[chk] = *candidate;
As above. Maybe treat as a 2 element array.

> +			all_scales[chk + 1] = *(candidate + 1);
> +			new_idx += 2;
>  		}
>  	}



