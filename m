Return-Path: <linux-iio+bounces-2167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2397848FCB
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 18:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9608F1F234AB
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 17:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21A622EF4;
	Sun,  4 Feb 2024 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2p+e9bT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230824B29
	for <linux-iio@vger.kernel.org>; Sun,  4 Feb 2024 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707068541; cv=none; b=hI4eECOgYQWcnLKKcy5iigUduO7lf9cnBYxU9/vOtJJHmz2bK7DK6jTCZAbJjq+cfutzeOfvCKuIP5R+r4EFI7Ae4ARw+Dgolnc2w14UJ3+0m9QNMwf7/pYZCa+Qp4r2XDYhsOhDxh5HuVX/Nr7hRJx32yVO3MrApXRXX4NZrlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707068541; c=relaxed/simple;
	bh=HwMFGgErka52n/PMXqCRx46uvcA1pBb9fAYZXkGLxFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVa2K75LvdrpVBQiXMX08U4l24ko0W2eohgbwJ96WPvw2007fyHFsOGKFWsNVTU818CEwcTMdP58SZEn/hknkc1SS0KMJgbGrY1psMWJDayaPWz9C4MwJvsHRBWoJxC64m4eALmosFi8mknlYnX+5WTvT4YYbcl1/x+nOlhAAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2p+e9bT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4B4C433C7;
	Sun,  4 Feb 2024 17:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707068541;
	bh=HwMFGgErka52n/PMXqCRx46uvcA1pBb9fAYZXkGLxFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j2p+e9bT95F5pxgz4ikmJEZUK1vR/VTw5FJ/vJtUpXWTld2aV07wfaxeVPLKnmYK9
	 V8z4yw8cgN0IEHMjWxx9kUsFVoTWRwHPw/whJOTpu9pa1fsBjClFTV0cDrGMtuYufG
	 BfQumjxuGEo9DsGpi+TC/zXsVZF5zR2bQP4IFvY/tT+0KW0qkaVbLcHB3pRFSV0CA2
	 ZFMc21fM682qcp0Ef8H6jQ09mcZFMmnFGfBZL9kvpBWhPM/H/FkzgXZeKJveS8rmQX
	 w43iazmqEBmjN8V6u5qbnkWY43ju3wPNPhw2KSBqQb4kEeQaAOs2ziEu4ZWiQoEnBD
	 8lgp1Vy/DDIRQ==
Date: Sun, 4 Feb 2024 17:42:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: andy.shevchenko@gmail.com
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Peter
 Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/10] iio: locking: introduce __cleanup() based direct
 mode claiming infrastructure
Message-ID: <20240204174208.7b55b658@jic23-huawei>
In-Reply-To: <Zb-6qPf66YJFqerk@surfacebook.localdomain>
References: <20240128150537.44592-1-jic23@kernel.org>
	<20240128150537.44592-2-jic23@kernel.org>
	<Zb-6qPf66YJFqerk@surfacebook.localdomain>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 Feb 2024 18:26:16 +0200
andy.shevchenko@gmail.com wrote:

> Sun, Jan 28, 2024 at 03:05:28PM +0000, Jonathan Cameron kirjoitti:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Allows use of:
> > 
> >        iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> >        }
> > 
> > to automatically call iio_device_release_direct_mode() based on scope.
> > Typically seen in combination with local device specific locks which
> > are already have automated cleanup options via guard(mutex)(&st->lock)
> > and scoped_guard(). Using both together allows most error handling to
> > be automated.  
> 
> ...
> 
> > +/* This autocleanup logic is normally used via iio_claim_direct_scoped */  
> 
> Wrong name? And missing parentheses.
> 
Oops. I renamed it and missed the comment. Will fix up.

