Return-Path: <linux-iio+bounces-18438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E61A5A95172
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76C9189184E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D01326561E;
	Mon, 21 Apr 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L7V0nO0o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60CA1E487;
	Mon, 21 Apr 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745241392; cv=none; b=MhQegdPBuL+4pl9cdIfYOfop/4ugSSjFkrE1S1sJCZImKBvPQzW1dhIxvH0KZarw9VEd0nvKt9M8AK7FGmij1fIsLWlT9oY84VoenN+CbXa/32RdCUiNEtt8g1ZbD2SPyzyMBBwXMrWkZEUCcbS8YSNe6b4IVLap0I9r1zDeOos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745241392; c=relaxed/simple;
	bh=IOiOls9jiIIyxhsCE518O1bqOU77w9+3+gZDs+HvBOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un1kiLjrDBzddxKGhgp7wSU/cF1ccRuR2NTMScfpuRA06VKm2flxfO8AXw4VRqbtlONi4ASpdP+P3o65grfUA8t1Vzs4HwW5QLHaFk9RFYIPQogtpK9RdS6by2mvb71Zp66hI5dT62KkxCBwTaX8iKJ25kfb4dvPuYPWVOENyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L7V0nO0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D2CC4CEE4;
	Mon, 21 Apr 2025 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745241391;
	bh=IOiOls9jiIIyxhsCE518O1bqOU77w9+3+gZDs+HvBOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7V0nO0oruxco9cAOKFvWfMHl+zhbrNBSqkpmqbkBICou6ROQPQTDekp+dofinIQu
	 HxLoToHRqXSnlVn0FQknsw0XdJl7b/cXOqsMipr28W5xADo6kTH80h8nOaY+Pe2TZ3
	 G1aiWmvo0ZB2H6nD52P41zheiZASy7/yD65fH9sg=
Date: Mon, 21 Apr 2025 15:16:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adis16201: Use IIO_VAL_INT for temperature
 scale
Message-ID: <2025042153-rearrange-shakable-e404@gregkh>
References: <20250421122819.907735-1-gshahrouzi@gmail.com>
 <CAKUZ0zKgvwhzgq8+_HG845QDze2SGN2fPwdXuN=UkATea6Nuag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUZ0zKgvwhzgq8+_HG845QDze2SGN2fPwdXuN=UkATea6Nuag@mail.gmail.com>

On Mon, Apr 21, 2025 at 08:33:00AM -0400, Gabriel Shahrouzi wrote:
> Not sure this is worth mentioning but one of the emails from using
> get_maintainer.pl on the patch listed a deprecated email:
> gregkh@suse.de.

How?  Doesn't do that for me:

> >  drivers/iio/accel/adis16201.c | 2 +-

$ ./scripts/get_maintainer.pl drivers/iio/accel/adis16201.c
Lars-Peter Clausen <lars@metafoo.de> (maintainer:ANALOG DEVICES INC IIO DRIVERS)
Michael Hennerich <Michael.Hennerich@analog.com> (maintainer:ANALOG DEVICES INC IIO DRIVERS)
Jonathan Cameron <jic23@kernel.org> (maintainer:IIO SUBSYSTEM AND DRIVERS)
linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
linux-kernel@vger.kernel.org (open list)
ANALOG DEVICES INC IIO DRIVERS status: Supported

How did you run this?

thanks,

greg k-h

