Return-Path: <linux-iio+bounces-26845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA39DCAAC11
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 19:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90066300939C
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 18:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABCB2BE64A;
	Sat,  6 Dec 2025 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4DtKOSt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67DA23A9BE;
	Sat,  6 Dec 2025 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765045090; cv=none; b=qHNzFzkVgEaof1vSSZglnDeJ7k2DEigrGtBsiuQKvT8cprHCoU1ILBS3+Dyae7blYdk8dln/5dJGl+6C4jzy6fiJPDjblgGPWkC9zyQfSNLqZm5+7D+oUHBSGS+6uzwbEkPZQ8PkZoos+xWfKgNOiE4XZ4+dnyk2Ko2srdkF9pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765045090; c=relaxed/simple;
	bh=nzszqVqx7CXJdiOecW//DQ7sr/FRyt+OLILOsXPzAWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4WJTk7dwaXIZ28dpjNqDlVudalFBpzlXqZehycXLrqSsU+bKE8ajdTW6yIQUsgte44cLlYyg2Z10pIifzvTRIXhy/hYywZF+D49gCWpFmu/dMQ10QZ2J1N6XzEoh6jNXI81rv3R366w/7ogHV9va/iVSju8ktmdtRt2Oikv/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4DtKOSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533ADC4CEF5;
	Sat,  6 Dec 2025 18:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765045090;
	bh=nzszqVqx7CXJdiOecW//DQ7sr/FRyt+OLILOsXPzAWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n4DtKOSt8VtsZiLWWyT+lqsXfKiheeNwGLVqidF4iwicQdvxH3t1ejcFNs7cRdFNW
	 5yICNNDDmqI+XEZ+KHaE4//NqStZWLt9NehS++V68IyE7JaKVEaz2LOfGMUZ11t7ly
	 VXpnVHUi/6ggY4r4vBO9bXgUPebio0/iQmlxRk1DEM7Hne8h9TGnKAaPGQcLIZq0Km
	 SYGo6XDDQQJIwgaWT/5qId/dUczKqPpaVuBqeEoTxKLAvMrFgxuFI+YmbWF3rb0sYf
	 aOW2kG1aX5gS9uYbyNBpTNFNPGICAQMdSg5wuCNDlOhdlFXJHTBTTodV1T/iC8Hw6l
	 MOLnhxe8fFbNg==
Date: Sat, 6 Dec 2025 18:17:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Kurt Borja" <kuurtb@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, "Lars-Peter Clausen" <lars@metafoo.de>,
 "Michael Hennerich" <Michael.Hennerich@analog.com>, "Benson Leung"
 <bleung@chromium.org>, "Antoniu Miclaus" <antoniu.miclaus@analog.com>,
 "Gwendal Grignou" <gwendal@chromium.org>, "Shrikant Raskar"
 <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH RFC 5/6] iio: health: max30102: Use cleanup.h for IIO
 locks
Message-ID: <20251206181758.2bfefde1@jic23-huawei>
In-Reply-To: <DEPMCPWLO4FO.2B2OXMF2CZ1G@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
	<20251203-lock-impr-v1-5-b4a1fd639423@gmail.com>
	<f96694db-2ad5-46d3-a380-cba3eaa2de2f@baylibre.com>
	<DEPLIJFBZQ36.20XX5DCMCJVB3@gmail.com>
	<c9efd563-9d52-4761-a5f1-be0df0222dff@baylibre.com>
	<DEPMCPWLO4FO.2B2OXMF2CZ1G@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Dec 2025 12:47:08 -0500
"Kurt Borja" <kuurtb@gmail.com> wrote:

> On Thu Dec 4, 2025 at 12:35 PM -05, David Lechner wrote:
> > On 12/4/25 11:07 AM, Kurt Borja wrote:  
> >> On Wed Dec 3, 2025 at 4:52 PM -05, David Lechner wrote:  
> >>> On 12/3/25 1:18 PM, Kurt Borja wrote:  
> >
> > ...
> >  
> >>> I would write the whole function like this:
> >>>
> >>> static int max30102_read_raw(struct iio_dev *indio_dev,
> >>> 			     struct iio_chan_spec const *chan,
> >>> 			     int *val, int *val2, long mask)
> >>> {
> >>> 	struct max30102_data *data = iio_priv(indio_dev);
> >>> 	int ret;
> >>>
> >>> 	switch (mask) {
> >>> 	case IIO_CHAN_INFO_RAW: {
> >>> 		/*
> >>> 		 * Temperature reading can only be acquired when not in
> >>> 		 * shutdown; leave shutdown briefly when buffer not running
> >>> 		 */
> >>> 		guard(iio_device_claim)(indio_dev);  
> >> 
> >> AFAIK you can't guard() inside switch-case blocks. I don't know the
> >> exact reason, but it has to be scoped_guard().  
> >
> > You can. You just need the braces like I showed in my suggestion.
> >
> > The reason is that guard() is declaring local variables and some
> > compilers like LLVM don't like declaring local variables in a
> > switch case. By adding the { } scope, the variables are limited
> > to that scope and the issue goes away.  
> 
> Ah - You're right. I dind't see the braces.
> 
> Now it is overly complicated. In this case I see why guard() isn't
> really an improvement.

This bit of guard() usage is fairly well known and I think people are
getting familiar with it.

So I'd prefer the form David suggested. It is nice to get rid
of the mode claiming dance in here.

Jonathan

> 
> 


