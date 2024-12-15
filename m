Return-Path: <linux-iio+bounces-13494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41449F23F5
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 13:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2677A164F1E
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 12:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2850C1865E9;
	Sun, 15 Dec 2024 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3T4j481"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721A1E871;
	Sun, 15 Dec 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734267307; cv=none; b=GvEJLzaK+8KB5ob0rmarLkXpd8xqsO0eA3h7TEFhtd4GuGp8QUaeZhW8UbneKkFvPZY/kcjFNqRig/ZMvdFpVGyqhhl/NBAuIXV+2K22VEgtHIWK/neoMIyhY+kurohhOY0/haesH7uo6LzUO0Hxa0R+Uz5M7kVuhBQi+9htetg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734267307; c=relaxed/simple;
	bh=laEdmlnO8YelwMkJPTCgcme7iL/L8q+9BFo0/Xa5spw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHFY/sK2pQcLsEdXLaRmONUOAipZ2WSi72yI+PTVUbqivQNkQTnDbz76qWmxBJ7H+sbFdmox1kUhJX1XI15MdcW1cYEoTmbXjYuk9eY1Jx+C9nls0DIuhFDfvKzT6pzquw7oAV/WL5+4k/lgSW/EnnhKqHfpWKNSWTN/HW/A9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3T4j481; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372B7C4CECE;
	Sun, 15 Dec 2024 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734267307;
	bh=laEdmlnO8YelwMkJPTCgcme7iL/L8q+9BFo0/Xa5spw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D3T4j481C3fuy2kMRU+ob6UxFJ6Ils8Io+E2yy8uIt7ciqafaMIa1k6Cln9v05qi4
	 xusUaPmSs4BGlydVukNaYJoHcr7Ay+MyOkpDHlgMHnMZk0u/ulsDG4OwxjNNaKVkGe
	 UJX5+NONBnhnPrFBpCT7UE/qHJ7TP8BU2vf0uyeG4Fwbx40eG80OPUiI8cnhit9VOV
	 AXZ5SY2J29eJwg9ZJBnQINwQ+3QvEITDN+7zZ8gvx8CHKjn68K1Onq+an1fHSfwfME
	 XCaOXSqrjv6pDvi63LMDmVwCSoIMCemJTAnUrxvD1x3iXkkrNbZ49ILYZ46VFVEpMk
	 bFm2pgJ4KgNtA==
Date: Sun, 15 Dec 2024 12:54:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, Mudit
 Sharma <muditsharma.info@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iio: gts: Simplify available scale table build
Message-ID: <20241215125459.40e50028@jic23-huawei>
In-Reply-To: <Z1ajMXzvlgU0Smdf@mva-rohm>
References: <Z1ajMXzvlgU0Smdf@mva-rohm>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 09:58:41 +0200
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
Hi Matti,

I'm definitely keen to see easier to follow code and agree that the
cost doesn't matter (Within reason).

I think a few more comments and rethinks of function names would
make it clearer still.  If each subfunction called has a clear
statement of what it's inputs and outputs are that would help
a lot as sort functions in particular tend to be tricky to figure out
by eyeballing them.

Jonathan
> 
> ---
> In my (not always) humble (enough) opinion:
>  - Building the available scales tables was confusing.
>  - The result of this patch looks much clearer and is simpler to follow.
>  - Handles memory allocations and freeing in somehow easyish to follow
>    manner while still:
>      - Avoids introducing mid-function variables
>      - Avoids mixing and matching 'scoped' allocs with regular ones
> 
> I however send this as an RFC because it hurts the performance quite a
> bit. (No measurements done, I doubt exact numbers matter. I'd just say
> it more than doubles the time, prbably triples or quadruples). Well, it
> is not really on a hot path though, tables are computed once at
> start-up, and with a sane amount of gains/times this is likely not a
> real problem.
> 
> This has been tested only by running the kunit tests for the gts-helpers
> in a beaglebone black. Further testing and eyeing is appreciated :)
> ---
>  drivers/iio/industrialio-gts-helper.c | 250 +++++++++++++++-----------
>  1 file changed, 149 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 291c0fc332c9..01206bc3e48e 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -160,16 +160,108 @@ static void iio_gts_purge_avail_scale_table(struct iio_gts *gts)
>  	gts->num_avail_all_scales = 0;
>  }

> +
> +static int do_combined_scaletable(struct iio_gts *gts, size_t scale_bytes)

Probably name this to indicate what it is doing to the combined scaletable.
Maybe make it clear that scale_bytes is of the whole scale table (i think!)
scale_table_bytes.


A few comments might also be useful.


> +{
> +	int t_idx, i, new_idx;
> +	int **scales = gts->per_time_avail_scale_tables;
> +	int *all_scales = kcalloc(gts->num_itime, scale_bytes, GFP_KERNEL);
> +
> +	if (!all_scales)
> +		return -ENOMEM;
> +
> +	t_idx = gts->num_itime - 1;
> +	memcpy(all_scales, scales[t_idx], scale_bytes);

I'm not 100% sure what that is copying in, so maybe a comment.
Is it just filling the final integration time with the unadjusted
scale table?  If so, maybe say why.

> +	new_idx = gts->num_hwgain * 2;

Comment on where you are starting the index. One row into a matrix?

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


> -	/*
> -	 * We assume all the gains for same integration time were unique.
> -	 * It is likely the first time table had greatest time multiplier as
> -	 * the times are in the order of preference and greater times are
> -	 * usually preferred. Hence we start from the last table which is likely
> -	 * to have the smallest total gains.
> -	 */
ah. This is one of the comments I'd like to see up above.

> -	time_idx = gts->num_itime - 1;
> -	memcpy(all_gains, gains[time_idx], gain_bytes);
> -	new_idx = gts->num_hwgain;
> +static void compute_per_time_gains(struct iio_gts *gts, int **gains)
> +{
> +	int i, j;
>  


