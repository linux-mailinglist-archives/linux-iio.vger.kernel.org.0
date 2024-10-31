Return-Path: <linux-iio+bounces-11728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED159B85B7
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 22:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118A31C21C44
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 21:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804F11CB32B;
	Thu, 31 Oct 2024 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sC4Zyj+q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C319DF4C;
	Thu, 31 Oct 2024 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411406; cv=none; b=dv1ZQH9uOLBV8E0lG6VD9sQW/8mJ5WbgmQsDOW6488RX6Ia+MU4QQZNVWhkn1nwe3tmN11Zo98XQBGyFbBmGWmAaUWDmathJ1CckHWLGuCnQw/uKpgYAXJNEWuwfb9+w3d1q3HEJzkbPAZ0VLgme+gKODlCm9wXgghBwuA2wP6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411406; c=relaxed/simple;
	bh=L/HbupDxsZ4Xi2SAYCY3SZneM1GHtRw9NHcBu+eZO5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/ojoe/mf5YrU67dBSUPSV6xyutLg6lnvqBQSU0EHX4n5rraKk2Jj4L/NBKL+cOuXG9h4NBD5mHd08I8Lm2O+jnOG6KhU5sXpn9vTrORU7I2BTt2bC0Ca+LOixFQw+1w2MCthWGbBrGGvQJQ8TYS0cCeBdHnDeHWG2ctQ4aP8bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sC4Zyj+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E6BC4CEC3;
	Thu, 31 Oct 2024 21:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730411405;
	bh=L/HbupDxsZ4Xi2SAYCY3SZneM1GHtRw9NHcBu+eZO5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sC4Zyj+qQvN8cpB1aMD3J/DtSNaUwHSsWKvDQnANCH1lhu7NIJAFyk1cW/NYPn8CY
	 TLw8qRlIvwE2+j9Xo7+r9OmBD+fcLgpGuX5nLlOrdN1g1YcwHIC8ascauWCcrf5HQX
	 W4VO7EP/8y62kOiZq4z5jFRYUPiSFHkKFUrLc56krKEo8CiZ260tKSbcgNWALhs0u3
	 hign8xafCXe4aZQK7kZPab88UyVEEF1U7fZUDqE/XlpolzLnj8UDyQm4qk/l9iiUUy
	 Y/WoKFvSgdmFPF7xzJFL6+Vf+eIvQTYs/vO7lptB0XRlUCi6P1+QGZaUNLPMujzqjo
	 LFClrpR/U943w==
Date: Thu, 31 Oct 2024 21:49:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Zicheng Qu <quzicheng@huawei.com>, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
Subject: Re: [PATCH] iio: fix infinite loop for gain_to_scaletables()
Message-ID: <20241031214957.609e21c0@jic23-huawei>
In-Reply-To: <5dae4924-5c07-48b6-a818-809cd4dd1c80@gmail.com>
References: <20241031014626.2313077-1-quzicheng@huawei.com>
	<5dae4924-5c07-48b6-a818-809cd4dd1c80@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 09:25:16 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Thanks again Zicheng!
> 
> On 31/10/2024 03:46, Zicheng Qu wrote:
> > In iio_gts_build_avail_time_table(), it is checked that gts->num_itime is
> > non-zero, but gts->num_itime is not checked in gain_to_scaletables(). The
> > variable time_idx is initialized as gts->num_itime - 1. This implies that
> > time_idx might initially be set to -1 (0 - 1 = -1). Consequently, using
> > while (time_idx--) could lead to an infinite loop.
> > 
> > Cc: stable@vger.kernel.org # v6.6+
> > Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> > Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> > ---
> >   drivers/iio/industrialio-gts-helper.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> > index 59d7615c0f56..f3acd392f4fc 100644
> > --- a/drivers/iio/industrialio-gts-helper.c
> > +++ b/drivers/iio/industrialio-gts-helper.c
> > @@ -205,7 +205,7 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
> >   	memcpy(all_gains, gains[time_idx], gain_bytes);
> >   	new_idx = gts->num_hwgain;
> >   
> > -	while (time_idx--) {
> > +	while (time_idx-- > 0) {
> >   		for (j = 0; j < gts->num_hwgain; j++) {
> >   			int candidate = gains[time_idx][j];
> >   			int chk;  
> 
> This, too, brings the question if supporting 0 times is worth.
> 
> At least this shows that it'd be nice to cover the "only times, no 
> hw-gains" and "no times, only hw-gains" cases in the Kunit tests...
> 
> Anyways - Thanks!
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied

> 
> Yours,
> 	-- Matti
> 
> 


