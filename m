Return-Path: <linux-iio+bounces-5710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFE38D8A3E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 21:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE6C28E086
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 19:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ED23FE2A;
	Mon,  3 Jun 2024 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8A992Fi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3223374EA;
	Mon,  3 Jun 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717443239; cv=none; b=pSjh/hdWS2TOvDl/z34txmmxRU6sAzWR8i/pHOfC+E4qHcb0OwIHS0/BEfAa62Tr3NTXoJsFV49tYocYPTyAM5YBIvZDK+DEvUruY99NXbR3yVKoJNo8lIVDIP5AvUJDddEKb6sqQlDa4qaixYZJwHUkTpuHtAbB5xF9NLo4gso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717443239; c=relaxed/simple;
	bh=haGlENCzcFeEXC5BXPb/UFco0FCHDxQhg1Se5YhH8qE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3/1MJ0EK0K9QN8/jl/KAvzx3QKh5z2/4AQH3iNjVRZP9XnavBLCerJnF4FF2XJIhmeXAgCSGfYhUZ2sj6q2yoxshtIOUHYPBm9kMdAQNxmo89drB3xi+IFVyfFQbg0crBiE+3Mt/mVWTu/nGvXIjAuH5aVu/AtSuhQnxcodzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8A992Fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DC7C2BD10;
	Mon,  3 Jun 2024 19:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717443239;
	bh=haGlENCzcFeEXC5BXPb/UFco0FCHDxQhg1Se5YhH8qE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q8A992FibBYI/zwb/sU6+7SmTf3NUsSL0fhlEw+0WRb73i5bNOzn8ay2tT/zzHAa1
	 ngW4j2IEQW1b0bo5ZtE27BQtILZ8F9TkgANV8GS+YIrlH9yukecLDsoIntYk/7Wvc4
	 BeGYdi1mManqWYbuazFX0Ga1kHBnWCHvRcSbqI8nlGiJ/Opsl1+AIPZNqdpcb5QCzO
	 SDPBXHt5sWkAYvYqtQV1nplQ0DDbmbouIh4h/PJfKpHOGzlCtiHCzuRl+C7TmLCsQb
	 ouTw/G2BY6/xuQyD6tO+gXJaKUHJn5DN1dAIL/7dgDBdgZ5o1RlrbbUo3LV68sAmqO
	 v1i8moNnZW9pQ==
Date: Mon, 3 Jun 2024 20:33:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: inkern: fix channel read regression
Message-ID: <20240603203347.46500fb4@jic23-huawei>
In-Reply-To: <Zl1vttlXz3FRVyYS@hovoldconsulting.com>
References: <20240530074416.13697-1-johan+linaro@kernel.org>
	<20240601142147.3ac40207@jic23-huawei>
	<Zl1vttlXz3FRVyYS@hovoldconsulting.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 09:24:38 +0200
Johan Hovold <johan@kernel.org> wrote:

> Hi Jonathan,
> 
> On Sat, Jun 01, 2024 at 02:21:47PM +0100, Jonathan Cameron wrote:
> > On Thu, 30 May 2024 09:44:16 +0200
> > Johan Hovold <johan+linaro@kernel.org> wrote:
> >   
> > > A recent "cleanup" broke IIO channel read outs and thereby thermal
> > > mitigation on the Lenovo ThinkPad X13s by returning zero instead of the
> > > expected IIO value type in iio_read_channel_processed_scale():
> > > 
> > > 	thermal thermal_zone12: failed to read out thermal zone (-22)
> > > 
> > > Fixes: 3092bde731ca ("iio: inkern: move to the cleanup.h magic")
> > > Cc: Nuno Sa <nuno.sa@analog.com>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>  
> 
> > In meantime, Nuno please take another look at these and see if
> > we have additional problem cases like this.  Given the patch
> > queue I have and a busy few days it will be a while before I
> > get to it but I'll try and take a close look soon as well.  
> 
> Please consider getting this one into mainline as soon as possible as it
> breaks thermal mitigation, which can cause literal skin burns, on all
> Qualcomm platforms (and probably other platforms too).

I'll queue this fix and we can follow with any others that surface
from reviews.

Need it to sit in linux-next for a day or two before a pull request though
as I've just pushed some other fixes out that needs some build coverage.

> 
> > Longer term, in my view the readability and chance of bugs
> > is reduced, but churn always introduces the possibility of
> > issues like this in the short term :(  
> 
> I just worry about some of the cleanup.h conversion I've seen where
> inexperienced developers potentially break tested and reviewed code for
> something which is often not very readable and for very little gain.
> 

Fair comment. There have been some 'interesting' patches.
On the plus side this one highlighted that our docs are wrong.

Applied to the fixes-togreg branch of iio.git

Jonathan


> Johan


