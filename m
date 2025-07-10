Return-Path: <linux-iio+bounces-21528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EA6AFFF8E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 12:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E0BE7B9C14
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 10:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D282DEA7B;
	Thu, 10 Jul 2025 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="QjZIn98c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B842245005
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144437; cv=none; b=jSssPICBEoD1Oa+Ab2N5L8a0051vfTulPD9gOaet4y0wxwda9P93YJHkT8DeWNciJvobcm8x3brUBJgwfZavXsn0MqCQS0jq5WnmgBrA956YuRbATiC2tx0irB0myoYl+NjYK3nSLl8hhFLlLA4M0AF+ABZHmwwPvYqv0oYsJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144437; c=relaxed/simple;
	bh=Pxc2d27x3MrAeWmf0v1fLKK96sAJbVihdsCjp3qU1/I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yq64fWf8AbOrRlm1kjvdJduzK4xZEr4XjKNW5DCfvyw8e1aSCbfO+ZMkvhwEbnfBwxZnDVTbWndDdDC6dmOHrL+7gTMHldoT1vN5ZhsE40n/juYTh5Vxj00yMQki0IGWJ/SiA2smMFk9RU/1fM1ta/NxQ+yDjB+myARFhKSQuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=QjZIn98c; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752144433; x=1752403633;
	bh=Pxc2d27x3MrAeWmf0v1fLKK96sAJbVihdsCjp3qU1/I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QjZIn98cuY9RrJFocwdrJXQbY8zRdfNT0/PNv94xuuektyO8Xo8YPrmBeZ/S5RXUI
	 ZkaaceE6OaUiu6p4fTWoTMoH4S1WiV3Ya+fYE8v1jHnFUyU8uelQuRowYocCPKpy6k
	 VZBpN0hjrksGA0gsmNdJ8TE+i2AvrCfltHDn5awKJbCZHkn/frMDMiUO4rHFBDorPn
	 4OyRJ8xT5SUf0S6kNWZQFNJKsOBczSJCSQvLJjLFYj9EcW9RYQUV/As3w4RcEPA3DL
	 3f1UyH9GugmVP6xw5/Jv5a7FJuZt3Nma9uwEROnyUWn3pA71BfIwWgjApeJsLEA9GS
	 1REhtlS4W/yow==
Date: Thu, 10 Jul 2025 10:47:08 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: imu: inv_icm42600: Remove redundant error msg on regulator_disable()
Message-ID: <pt3qh3xaxvbaf7ojib474d7cpgpcehuhzfj6qfg6qv2ivcbb7z@iyen7qvzd7zo>
In-Reply-To: <aG-B3uv6SsP1Ap0U@smile.fi.intel.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com> <20250709-icm42pmreg-v1-3-3d0e793c99b2@geanix.com> <aG-B3uv6SsP1Ap0U@smile.fi.intel.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: ec132c56582d17ae3dad5882a554ce4dbe05c18f
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:03:26PM +0100, Andy Shevchenko wrote:
> On Wed, Jul 09, 2025 at 02:35:11PM +0200, Sean Nyekjaer wrote:
> > The regulator framework already emits an error message when
> > regulator_disable() fails, making the local dev_err() redundant.
> > Remove the duplicate message to avoid cluttering the kernel log
> > with the same error twice.
>=20
> To me this sounds like a potential backporting material as it might full
> the logs (in case the module probed-removed zillion of time. Hence,
> I would put it to be the first patch in the series (yes, it will involve
> to fix something that you are removing in the following change, but still=
).

I have never seen this printed, so I don't think it's a huge issue.
But it's quite easy to add a Fixes tag if prefered.

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
>=20

/Sean


