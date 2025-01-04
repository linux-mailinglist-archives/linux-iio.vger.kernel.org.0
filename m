Return-Path: <linux-iio+bounces-13884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5CBA0144E
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 13:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB0F163962
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828D2190077;
	Sat,  4 Jan 2025 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBy8ZalD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2672481728;
	Sat,  4 Jan 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735993838; cv=none; b=D/ibPK8u/4fBI4oLdAbT5aQG3lDImudC5blo5wzjZmamomWt5/50d6m8QfVTxmgC1e1nitCkwg3RjGR05M8iDzYJApSFDoELRdND9mN1RZh5Ol04gIHudEUjsXJbcU8RKo9yq7ubyMJtDZejVDmDeD15rnjI8zw0ajhbJe7aeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735993838; c=relaxed/simple;
	bh=+1hSY2Ft7Oj3UkOvHVLbK+L/8bwp/5OQyQuJA4B+uSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMPjQ8qosE8yi8St91yc9Zu5xKFmZ8IT3uaFvPAVtgDw2m1sb3wj7MMbJg8kTpBZjvvkxG15DLKjJ1Gttwu54c2LxA7g5Udd7i/nxD+HkDqUwD6BojFO6YDzlKWComsdI3/oWLdRtaDIGEkEgVvR1OY/o6TgCfkvlmaswqgh7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBy8ZalD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B86C4CED1;
	Sat,  4 Jan 2025 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735993837;
	bh=+1hSY2Ft7Oj3UkOvHVLbK+L/8bwp/5OQyQuJA4B+uSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JBy8ZalDb/HE9s7tLLo2XDGM0e38CGwlUErR/8RGFFn1fOWT2wTcQ0KkcHig5+r6d
	 nW0D3RBFRzqTmIrOVk9UFMlrFs9zhu1nku+L+7V+9kIMEQj0hSCZN/xdZbagt9B5zK
	 UFu7aLQuCj6R8yu6MXKQvTr2gF5escAVMzE5iqbOKqz5En+JUJvpftfc3PEhO8Me5e
	 l1We5HyLsXfwb8su7JSkBhj1vzCHYOMx6XjQwmV3r/ey1eW5tN/nAeUkdU9kztdvcy
	 uUO+kAw9M7xIyZ+ZO9VzRHPmx5baeT7bI7g4F/adHjO1506x6cpJrX8RGUa+BoxbsT
	 D/c1zKIUdxj5Q==
Date: Sat, 4 Jan 2025 12:30:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad4695: add offload-based oversampling
 support
Message-ID: <20250104123029.12a4e19e@jic23-huawei>
In-Reply-To: <1c641b37-475a-4153-bcfc-e0e72d79fa76@baylibre.com>
References: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
	<20241217-ad4695-oversampling-v1-1-0b045d835dac@baylibre.com>
	<20241219161301.3f708302@jic23-huawei>
	<1c641b37-475a-4153-bcfc-e0e72d79fa76@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 13:19:19 -0500
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> On 2024-12-19 11:13, Jonathan Cameron wrote:
> > On Tue, 17 Dec 2024 16:47:28 -0500
> > Trevor Gamblin <tgamblin@baylibre.com> wrote:
> >  
> >> Add support for the ad4695's oversampling feature when SPI offload is
> >> available. This allows the ad4695 to set oversampling ratios on a
> >> per-channel basis, raising the effective-number-of-bits from 16
> >> (OSR == 1) to 17 (4), 18 (16), or 19 (64) for a given sample (i.e. one
> >> full cycle through the auto-sequencer). The logic for reading and
> >> writing sampling frequency for a given channel is also adjusted based on
> >> the current oversampling ratio.
> >>
> >> The non-offload case isn't supported as there isn't a good way to
> >> trigger the CNV pin in this mode. Support could be added in the future
> >> if a use-case arises.
> >>
> >> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>  
> > Hi Trevor,
> >
> > The clamping fun of get_calibbias seems overkill. If this isn't going to ever
> > overflow an s64 maybe just use the high precision to do it the easy way.
> > I'm not sure you can't just fit it in an s32 for that matter. I've just
> > not done the maths to check.
> >
> > Jonathan
> >
> >  
> >> +static unsigned int ad4695_get_calibbias(int val, int val2, int osr)
> >> +{
> >> +	unsigned int reg_val;
> >> +
> >> +	switch (osr) {
> >> +	case 4:
> >> +		if (val2 >= 0 && val > S16_MAX / 2)
> >> +			reg_val = S16_MAX;
> >> +		else if ((val2 < 0 ? -val : val) < S16_MIN / 2)  
> > It has been a while, but IIRC if val2 < 0 then val == 0 as otherwise
> > we carry the sign in the val part.  Sometimes we generalize that to
> > make life easier for driver writers but I think you can use that here
> > to simplify things.
> >
> > (for background look at __iio_str_to_fixpoint() - it's a bit of a hack
> > to deal with integers have no negative 0)
> >
> > 		if (val > S16_MAX / 2)
> > 			...
> > 		else if (val < S16_MIN / 2)
> > 			...	
> > 		else if (val2 < 0) etc
> >
> > You may feel it is better to keep the code considering the val2 < 0 when
> > val != 0 case and I don't mind that as it's not wrong, just overly complex!
> >
> > If you can easily clamp the overall range you can just do some maths
> > with enough precision to get one number (probably a s64) and clamp that.
> > Easy to sanity check for overflow based on val to ensure no overflows.  
> 
> Hi Jonathan,
> 
> I'm reviewing this again but I'm not entirely clear what you mean.
> 
> Are you suggesting that the entire switch block could be simplified 
> (i.e. eliminating the previous simplification for the val2 < 0 case in 
> the process), or that the calls to clamp_t can be combined?
> 
> I've tested out simplifying the val2 < 0 case locally and driver 
> functionality still seems OK. Maybe I'm missing a third option.
The extra info we can use is that val2 is always positive
if val != 0 and it never takes a value beyond +- MICRO because
otherwise val would be non 0 instead.


Taking original code and ruling out cases.
+	case 4:
+		if (val2 >= 0 && val > S16_MAX / 2)
// If val is non 0 then val2 is postive, so
//		if (val > S16_MAX / 2)
//			reg_val = S16_MAX;

+			reg_val = S16_MAX;
+		else if ((val2 < 0 ? -val : val) < S16_MIN / 2)

// If val2 < 0 then val == 0 which is never less than S16_MIN / 2
// So this condition never happens.

+			reg_val = S16_MIN;
+		else if (val2 < 0)
// likewise, this is actually clamping val2 * 2 / MICRO which 
// is never going to be anywhere near S16_MIN or S16_MAX as I think
// it is always between +1 and -1 as val2 itself is limited to -MICRO to MICRO

+			reg_val = clamp_t(int,
+				-(val * 2 + -val2 * 2 / MICRO),
+				S16_MIN, S16_MAX);
+		else if (val < 0)
//This one is fine.
+			reg_val = clamp_t(int,
+				val * 2 - val2 * 2 / MICRO,
+				S16_MIN, S16_MAX);
+		else
//As is this one
+			reg_val = clamp_t(int,
+				val * 2 + val2 * 2 / MICRO,
+				S16_MIN, S16_MAX);
+		return reg_val;

Maybe trick is to reorder into 3 conditions and set the value in a temporary integer.
	int val_calc;
	if (val > 0)
		val_calc = val * 2 + val2 * 2 / MICRO;
	else if (val < 0)
		val_calc = -(val * 2 - val2 * 2 / MICRO);
	else /* Only now does val2 sign matter as val == 0 */
		val_calc = val2 * 2 / MICRO;

Which can simplify because we know val is 0 for last case.
Whether this is worth doing depends on trade off between
docs needed to explain the code and shorter code.

	/* Note that val2 > 0 if val != 0 and val2 range +- MICRO */
	if (val < 0)
		val_calc = val * 2 - val2 * 2 / MICRO;
	else
		val_calc = val * 2 + val2 * 2 / MICRO;

	reg_val = clamp_t(int, val_calc, S16_MIN, S16_MAX);
	
One trivial additional simplication below.

You might also be able to scale temporary up by 2 and ust
have the switch statement set a scaling value.

In this case scale == 4 in other cases below, 2, 1, and 8 for the default


	if (val < 0)
		val_calc = val * scale - val2 * scale / MICRO;
	else
		val_calc = val * scale + val2 * scale / MICRO;

	val_calc /= 2; /* to remove the factor of 2 */

	reg_val = clamp_t (int, val_calc, S16_MIN, S16_MAX);
after the switch statement with comments when setting scale on the * 2
multiplier to avoid the / 2 for case 64.

> 
> - Trevor
> 
> >
> > 		
> >
> >  
> >> +			reg_val = S16_MIN;
> >> +		else if (val2 < 0)
> >> +			reg_val = clamp_t(int,
> >> +				-(val * 2 + -val2 * 2 / MICRO),
> >> +				S16_MIN, S16_MAX);
> >> +		else if (val < 0)
> >> +			reg_val = clamp_t(int,
> >> +				val * 2 - val2 * 2 / MICRO,
> >> +				S16_MIN, S16_MAX);
> >> +		else
> >> +			reg_val = clamp_t(int,
> >> +				val * 2 + val2 * 2 / MICRO,
> >> +				S16_MIN, S16_MAX);
> >> +		return reg_val;
> >> +	case 16:
> >> +		if (val2 >= 0 && val > S16_MAX)
> >> +			reg_val = S16_MAX;
> >> +		else if ((val2 < 0 ? -val : val) < S16_MIN)
> >> +			reg_val = S16_MIN;
> >> +		else if (val2 < 0)
> >> +			reg_val = clamp_t(int,
> >> +				-(val + -val2 / MICRO),
> >> +				S16_MIN, S16_MAX);
> >> +		else if (val < 0)
> >> +			reg_val = clamp_t(int,
> >> +				val - val2 / MICRO,
> >> +				S16_MIN, S16_MAX);
> >> +		else
> >> +			reg_val = clamp_t(int,
> >> +				val + val2 / MICRO,
> >> +				S16_MIN, S16_MAX);
> >> +		return reg_val;
> >> +	case 64:
> >> +		if (val2 >= 0 && val > S16_MAX * 2)
> >> +			reg_val = S16_MAX;
> >> +		else if ((val2 < 0 ? -val : val) < S16_MIN * 2)
> >> +			reg_val = S16_MIN;
> >> +		else if (val2 < 0)
> >> +			reg_val = clamp_t(int,
> >> +				-(val / 2 + -val2 / 2 / MICRO),
> >> +				S16_MIN, S16_MAX);
> >> +		else if (val < 0)
> >> +			reg_val = clamp_t(int,
> >> +				val / 2 - val2 / 2 / MICRO,

For these val2 / 2 / MICRO always 0 so value of val2 never matters.

> >> +				S16_MIN, S16_MAX);
> >> +		else
> >> +			reg_val = clamp_t(int,
> >> +				val / 2 + val2 / 2 / MICRO,
> >> +				S16_MIN, S16_MAX);
> >> +		return reg_val;
> >> +	default:
> >> +		if (val2 >= 0 && val > S16_MAX / 4)
> >> +			reg_val = S16_MAX;
> >> +		else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
> >> +			reg_val = S16_MIN;
> >> +		else if (val2 < 0)
> >> +			reg_val = clamp_t(int,
> >> +				-(val * 4 + -val2 * 4 / MICRO),
> >> +				S16_MIN, S16_MAX);
> >> +		else if (val < 0)
> >> +			reg_val = clamp_t(int,
> >> +				val * 4 - val2 * 4 / MICRO,
> >> +				S16_MIN, S16_MAX);
> >> +		else
> >> +			reg_val = clamp_t(int,
> >> +				val * 4 + val2 * 4 / MICRO,
> >> +				S16_MIN, S16_MAX);
> >> +		return reg_val;
> >> +	}
> >> +}
> >> +  


