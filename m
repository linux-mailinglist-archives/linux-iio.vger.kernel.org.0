Return-Path: <linux-iio+bounces-26843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E96CAABEF
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 19:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742203058E6F
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83592C029A;
	Sat,  6 Dec 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTagsQWu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920ED248896;
	Sat,  6 Dec 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765044693; cv=none; b=MAmN9+t8AxwxPInAxS0rTAl/782GfE/CuuslDe4vS2r0pXFmHr9XUW7/IuJ43d1GZf6gzlAxnh0/KRms1vfbZGKE0m9APwohp76OtGQPBPle8XTenMc5rglYwGPlMwPzeI4uxR+VSnikZjMdaslgMe50rdL9Z/9PxF5M/onoDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765044693; c=relaxed/simple;
	bh=6hdZyZ6p6LFkB5A4sui+WueYenWlLXyVxU8cJIGAPH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0JfRiR/gGh7D81KMu1zzHSppx35mTGQ9ysN7mcTp6VKCavEywLyv4S+V7G/fKuTDhArUrgGMHPqldwGyD9UZ8rzRBKIiLFMbi82qnRBQd3hw4mVxRLz8debcqrvA9R6nZh+u0YIJlooig70z0BdgWNAx3XPmLHVZQCDx35P7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTagsQWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F36C4CEF5;
	Sat,  6 Dec 2025 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765044693;
	bh=6hdZyZ6p6LFkB5A4sui+WueYenWlLXyVxU8cJIGAPH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uTagsQWuvzQ91Gxy2NfavJ3V4Rpv28/RtVibgfIcNCy4Vy3pH2/MCIwSeik6sYNP6
	 Fy0x0p2SfR7MvuPGNgMN3LstmUKnFQk6ChGWVxAJpCHvLJiWu2kFEYl7/XDjfv02fq
	 qReq4uRvIT/rJggOVF+1AxRGDOLGkhRNd9sVyUW9h8s4SYag5boRKY9wd2zb0AWCFL
	 uZlUpXYincvG4SkDBiHVcoYgPPNI0O/BLLD19ZBWUs3rgOx9hcvfPRJws26tQVfADj
	 q08drWJ0R2x4WkmoT6crQVRM4mM7K29bMoW+yu4iFhAAIF93HUeny+7eCbEPe5Bjhw
	 IGlXENy7aMxdA==
Date: Sat, 6 Dec 2025 18:11:21 +0000
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
Subject: Re: [PATCH RFC 2/6] iio: core: Match iio_device_claim_*() naming
Message-ID: <20251206181121.3bf01809@jic23-huawei>
In-Reply-To: <DEPM3WWMT76K.P5E00DKJ73UO@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
	<20251203-lock-impr-v1-2-b4a1fd639423@gmail.com>
	<40cd9574-ac26-45c9-91a4-b08ad799ca99@baylibre.com>
	<DEPM3WWMT76K.P5E00DKJ73UO@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Dec 2025 12:35:38 -0500
"Kurt Borja" <kuurtb@gmail.com> wrote:

> On Wed Dec 3, 2025 at 4:50 PM -05, David Lechner wrote:
> > On 12/3/25 1:18 PM, Kurt Borja wrote:  
> >> Rename iio_device_claim_buffer_mode() -> iio_device_claim_buffer() to
> >> match iio_device_claim_direct().
> >> 
> >> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> >> ---  
> > If we decide to do this, I would squash this with the previous patch
> > to make a clean break of it. Although it is helpful to have "mode"
> > in the name if we can keep that without breaking things.  
> 
> Agree, but If rename iio_device_claim_direct() that would be too big and
> I think it should be separate patches.
> 
For the iio_device_claim() there were far to many drivers to do
the conversions in a single patch hence I needed a different name
and took the view the _mode() wasn't that important.

We already had precedence in the _scoped() variant that I was ripping
out (the revert David refers to in the cover letter discussion).

As you say it is probably not worth the effort of putting the _mode()
prefix back and things are inconsistent.

So I think this is on balance the most practical way to get to a
consistent ABI again.  However as suggested, if we agree to go this
way squash with previous patch.

Jonathan



