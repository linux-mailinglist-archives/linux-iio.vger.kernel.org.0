Return-Path: <linux-iio+bounces-12092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA1F9C2E35
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 16:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4F51C20D0B
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B9F1991A1;
	Sat,  9 Nov 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTx/n/v6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A36E2BE;
	Sat,  9 Nov 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731166093; cv=none; b=W8tAnS/9JwrF2kWdfWUrQ44WXZZN6ns4cBLe78xAAu34Ei3JlUZLMFni8ZsvPEI0RkKCqBdLYoNNH8yMnod3+RCQgIS1sUf7umo7tyl7IEpT3llgj/OQOd6YaRCaeVolBlakrorpCGDYMylUSCCa+2hTaNbXXWQV5+Hq8Vey1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731166093; c=relaxed/simple;
	bh=Uq6vY0dbCp9RgX1YA2IjE3NYO4XlxEGj+eUY/dGBndA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3WkWUSElTKr+fl+FsfodRWzd6sOx49HghkhVIZJF8+g6eJ5CMlRxXjT66F9Y9O/bgfDSqAiWBWoDjlPxf7u/7YygRruZdO1kKC8itR23tMUMA2iFQbsqHX087ULvwFpbUYetbgUzq9YBTGnt9L4TLw/JsL/KHM2chG/4Gqih6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTx/n/v6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73FEC4CECE;
	Sat,  9 Nov 2024 15:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731166092;
	bh=Uq6vY0dbCp9RgX1YA2IjE3NYO4XlxEGj+eUY/dGBndA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NTx/n/v600QGU5Zm0yvpFBrFpFoZA+QOpC2vbom++Kb3tNiY6u2Ix/+6IExOdgGt6
	 /xhenocAFAyNLyVrOvhwuj+8d/4Xh66XMws0DmKabYGseJRxTw1oIke8qerRB3J4/z
	 bR63lmlttZ0zat3yiNMk7p0xrHzmsHGXt/w0B0hej6EJ+60X6h+TKEq0kJK6DkhJpe
	 n056KsQtk1wMxvJd0OEHP3nV/NxRTm2umVYso4WIBf0r+qHf76EA9qtLwKDwhTDsix
	 rkBHrl9UFS7gtTaowephydX5LfqaHsQcp3tZt6zKu1P9J29quqce9AF412h3Y5Tfnt
	 GMWZTIqb5aDxg==
Date: Sat, 9 Nov 2024 15:28:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, Anup
 <anupnewsmail@gmail.com>
Subject: Re: [PATCH] iio: invensense: fix integer overflow while
 multiplication
Message-ID: <20241109152804.22f20170@jic23-huawei>
In-Reply-To: <clo3nj5fokr47vheikv7nozr2exzha3rwkyfqq7n3s6vqyglzr@g6eu2ycy6gzo>
References: <20241103-coverity1586045integeroverflow-v1-1-43ea37a3f3cd@gmail.com>
	<20241103111827.0894a40a@jic23-huawei>
	<clo3nj5fokr47vheikv7nozr2exzha3rwkyfqq7n3s6vqyglzr@g6eu2ycy6gzo>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 16:26:31 +0000
Karan Sanghavi <karansanghvi98@gmail.com> wrote:

> On Sun, Nov 03, 2024 at 11:18:27AM +0000, Jonathan Cameron wrote:
> > On Sun, 03 Nov 2024 08:43:14 +0000
> > Karan Sanghavi <karansanghvi98@gmail.com> wrote:
> > 
> > Hi Karan,
> >   
> > > Typecast a variable to int64_t for 64-bit arithmetic multiplication  
> > 
> > The path to actually triggering this is non obvious as these
> > inputs are the result of rather complex code paths and per chip
> > constraints.  Have you identified a particular combination that overflows
> > or is this just based on the type?  I have no problem with applying this
> > as hardening against future uses but unless we have a path to trigger
> > it today it isn't a fix.
> > 
> > If you do have a path, this description should state what it is.
> >  
> 
> The above issue is discovered by Coverity with CID 1586045 and 1586044.
> Link: https://scan7.scan.coverity.com/#/project-view/51946/11354?selectedIssue=1586045
> 
> Should I mention this path in the commit short message?

That wasn't what I meant.  I was after what combination of possible
inputs actually trigger this rather than (I suspect) local analysis coverity has
done.

> 
> > > 
> > > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>  
> > If it's a real bug, needs a Fixes tag so we know how far to backport it.
> >   
> 
> What kind of Fixes tag should I provide here. 
The patch that introduced the bug in the first place.  See submitting patches
docs for the format.

However, I suspect this is coverity firing a false positive be it a reasonable
one that we should tidy up. As such I'll queue this patch up, but not
as a fix that I'm rushing in, but just as general cleanup for next cycle.

If you find a path to trigger the overflow via userspace inputs etc
then I'm happy to move it over to being handled as an urgent fix.

Jonathan

> 
> > > ---
> > >  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > > index f44458c380d9..d1d11d0b2458 100644
> > > --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > > +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > > @@ -105,8 +105,8 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
> > >  
> > >  static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
> > >  {
> > > -	const int64_t period_min = ts->min_period * ts->mult;
> > > -	const int64_t period_max = ts->max_period * ts->mult;
> > > +	const int64_t period_min = (int64_t)ts->min_period * ts->mult;
> > > +	const int64_t period_max = (int64_t)ts->max_period * ts->mult;
> > >  	int64_t add_max, sub_max;
> > >  	int64_t delta, jitter;
> > >  	int64_t adjust;
> > > 
> > > ---
> > > base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> > > change-id: 20241102-coverity1586045integeroverflow-cbbf357475d9
> > > 
> > > Best regards,  
> >  
> 
> Thank you,
> Karan.


