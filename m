Return-Path: <linux-iio+bounces-8572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9852C955D58
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 18:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5921C1C2090F
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A6813C8F4;
	Sun, 18 Aug 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0MzJRyF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1B145B0C;
	Sun, 18 Aug 2024 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723997143; cv=none; b=LYz0JSpbtvIuczzpo+58HQyhk/Hjw6hvaizbqg/Y8g2EOV+0EiTVY9sXfyF72g5CXaPU0b39eqRS33IgCjvFaszBjlKp4Lxs5ivjEfX6IUu0cgiHbPgQn+AEkTfZxAgTwxq3uJ67iUz9IH+dqIWCr38RS4C2uXJ5dzYz0/yBmOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723997143; c=relaxed/simple;
	bh=4RpES87diZd5X42Za+Zib9TolNlTl0ajnivXRuYSUcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vd1SieYcZtdPnAiM4rmscgviPSKqipDYS1fNB6wdF3sFNnz+8VPJSL6wSliIsqqANc6nn94qk9FbwadNAh0PyPSj1Vd636kOJtWg3Gfj+PqJSUwr5QE4IGcAhYom77eJGKJ1leSwZ4/za6DEr4Eappe7LYFLzj9MuufmAVxVghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0MzJRyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FE7C32786;
	Sun, 18 Aug 2024 16:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723997143;
	bh=4RpES87diZd5X42Za+Zib9TolNlTl0ajnivXRuYSUcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F0MzJRyFy3SCLO2Y5DZv6AKKc5wLiCP7mCc4XwjkVN7zWJ8Ud4hjtbazeJO+WHm5y
	 s+dH4+kncEJYqqglDPKZKCZsChLaE2FR/UgHMQeSSt99U5gSUei85/FDBta/9NxvIy
	 wM4vMm0pahoCEMnMmIoMqY4G6zGo+ryEUNH7XQPmSI5movTZ4GYc2M8/Xxalt/ON0u
	 OuKesCOhKpoEOgGUz+Lp7DXeSUhuUSoNq8/Uv/XQ9tn4bj3dMvsrAssM4CrLX+T89Y
	 d0gqmm+Gc7X1zTyEMv+3uGOUiTdXcFGraSLRZlRSEFVOrjui3sZlQagfNlJdfQlNRe
	 OpDVr0MCynK7w==
Date: Sun, 18 Aug 2024 17:05:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] Add light channel for LTR390
Message-ID: <20240818170535.7a1aa6b5@jic23-huawei>
In-Reply-To: <CAG=0RqJN=M5+w4CDXggDnoyOrW5qxTejJy=UkzMQX36emFT5fw@mail.gmail.com>
References: <20240814113135.14575-1-abhashkumarjha123@gmail.com>
	<20240817153953.1743e020@jic23-huawei>
	<CAG=0RqLaigoVLN2D9LEfC0_1ctJO6OzwEgpeOx8NQavB4mZxoA@mail.gmail.com>
	<20240817174919.5583f28a@jic23-huawei>
	<CAG=0RqJN=M5+w4CDXggDnoyOrW5qxTejJy=UkzMQX36emFT5fw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Aug 2024 23:07:37 +0530
Abhash jha <abhashkumarjha123@gmail.com> wrote:

> > I think I have.  But with two versions of v7 I'm not 100% sure which one got picked
> > up. I've pushed out now as testing, so take a look.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing  
> > >  
> The two versions v7 patches are the same. I had sent the same thing
> again because
> I thought it might have gotten lost in your mail.
> My apologies for getting you confused.
Ah. Never bother doing that.  Just send a 'ping' to the original
thread.  

Most maintainers now use a lot of automation so tend not to drop messages
any more (it used to happen occasionally). 

Also convention is to wait at least 2 weeks before pinging.

Jonathan

> 
> Thanks,
> Abhash


