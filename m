Return-Path: <linux-iio+bounces-27865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C24D37AEE
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 18:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C68FA30428E1
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE8239A80D;
	Fri, 16 Jan 2026 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMDtoj38"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338533A6F1;
	Fri, 16 Jan 2026 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768586274; cv=none; b=ko0lgCY6B9e5Vf6MDEiYfALyDIxG/sa5GrvgAwJqv3NbylHvziBlWzdKFKdNhe3WFEM0YINbctD3QWKSh3pLDDTJHqu2ITtsweg0O2UOq5J/rBL1ZrZS0G6DjhZgCRLeN9DFtPrjEdsMgd0J+M0fyby4kMQ3xltv7hIlGo8Wzf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768586274; c=relaxed/simple;
	bh=XqunudCl9Yvc1DeKM9bABVhHXft+ilsELM6HcW+FYRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=te11EEXGyuxDYdRiPfjwA0Jgssr9yhMlxdSKMTsQDUIY6alx7aW+ZLuqPONRwOVShc+UrVfjySwMJSTNPIp+N3Lkt5+giXgqpxl39s9gaVQ64xwGVoGBr/xgo1jQYjUwAQ7c+DCLvGxIjmrqrDiwOPJ7xR7MqJp7FPQbVdBUZhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMDtoj38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4DDC116C6;
	Fri, 16 Jan 2026 17:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768586274;
	bh=XqunudCl9Yvc1DeKM9bABVhHXft+ilsELM6HcW+FYRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OMDtoj38avTpgt2NJnW6re8HrxRt5tl5JYgaQTCAh4NcPmF5GPHQ3hRQtns4n+c+9
	 k84GI7ahZGSWVEYCFxM+4L5uncB5e6zxm+ex47TEqouJY2BxbeRaaBeVv5WGViyD8X
	 6BGS8oHokdK7rghMkspeK/qYI6IwI18mOlpUKuF/KhMx0sTopNvIJkHzmt85eAOIdX
	 O7iTNHpEa70nEKKGFzqSXajgRRWMwbAE5KBQXnwp8M21KWaKGhDM/uQkrfiU5PDEqv
	 +4t2/BgL+/iyuW4IBk77Jx5ttf+fyNKUccOQLRiCQtwbsYLydczIMCUN1KI1O31dIK
	 uKyBb0DotdMhA==
Date: Fri, 16 Jan 2026 17:57:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 4/6] iio: frequency: adf41513: features on frequency
 change
Message-ID: <20260116175743.169eb595@jic23-huawei>
In-Reply-To: <aWTS-npPY6yPARZH@smile.fi.intel.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
	<20260108-adf41513-iio-driver-v3-4-23d1371aef48@analog.com>
	<aWFR2wTSWLydGN5O@smile.fi.intel.com>
	<ptyn5x7qkmbakkompmijo6xeego2xrhjoeyomkgrytwgwcsaid@heiq3ilnx5ky>
	<aWTS-npPY6yPARZH@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 12:54:50 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jan 12, 2026 at 09:45:49AM +0000, Rodrigo Alencar wrote:
> > On 26/01/09 09:07PM, Andy Shevchenko wrote:  
> > > On Thu, Jan 08, 2026 at 12:14:53PM +0000, Rodrigo Alencar via B4 Relay wrote:  
> 
> First of all, remove the things you are agree with.
> 
> ...
> 
> A side note: based on this discussion one may want to add a clarification
> on how to use the unit-based multipliers to the documentation (top comment
> on units.h also will work).
> 
> ...
> 
> > > > +	bleed_value = div64_u64(st->settings.pfd_frequency_uhz * bleed_value,
> > > > +				1600ULL * HZ_PER_MHZ * MICROHZ_PER_HZ);  
> 
> You multiply Hz * Hz. One of them should be simply SI multiplier.
> To me it sounds like one of
> 
> 				1600ULL * MEGA * MICROHZ_PER_HZ);
> 				1600ULL * HZ_PER_MHZ * MICRO);
> 
> will be the correct one (and I lean towards the first one as you want units
> to match).

I don't really care, but... They are Hz * Hz / Hz * Hz / Hz = HZ
if we assume the first number is in Hz.  The others are all ratios.
 
So original is fine as far as I can tell.

Jonathan

