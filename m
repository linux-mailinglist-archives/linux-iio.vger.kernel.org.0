Return-Path: <linux-iio+bounces-12921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE539DF5D0
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 14:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7554A162F2F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47D21CF5DB;
	Sun,  1 Dec 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQZUT1Gd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941F61CEEAD;
	Sun,  1 Dec 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733059992; cv=none; b=HXSJ5D/uVKemzIhp0JasC+G1JRu6iSyPg1/NFFg7YtNG/ZshC5tvGSD5zK5R3ahiqJZKbQ98eqLRFSXFbWuY/ZTUiTVZdbCp6n+VbHf2q2ZEQODh1+Rf7kjpRLFOB9l3ECkgrQZ+U83bDzIB2oNQ6YPZcHZi/pGiwJT7hznp+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733059992; c=relaxed/simple;
	bh=nNskjfP3HTUO0q+xM778uzQKMG5EwFIqDXWEOhI91uo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjEZ+yfEvFd5eLqkdPdQWdnmB7BonHsF3/rZI4jgD+klMDuodc/yMeUFhZlZcGUvukAqzt3I+b3XCDaG3XIw/LUnPT+2yR2o/6NfBGIY/RvLwtjl7ZLlLkxWKnj3Q2fMHGONaFXB5s6KOoIH1FK97ZTk8cbOYyX7pHLjUPEkIIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQZUT1Gd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D83C4CECF;
	Sun,  1 Dec 2024 13:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733059992;
	bh=nNskjfP3HTUO0q+xM778uzQKMG5EwFIqDXWEOhI91uo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rQZUT1GdppSM32v/vVOikEy6zRYCdOZJzQk10fO2MIOeoMfm57BkfV5eNtGFg9T0B
	 A4QMowdZZWynBJ744ctnQYszSoYlrl1VKi2u53rAW2orPbgX3IVEZ67Gu/sYY8YRvG
	 pascCr8db/pzDkezwzIVYB0yhxMah+u2E9w1nDOwgIkrBGECwc4Xp59NwClbsXOA0g
	 ptLhxZSSezo+Y+GnHQf82L9Psor1Gyht5zh5Cb1YSoK6SwXlxb0R2IHc5BIkhNSxbD
	 rOm5qUC7cx50IdQ2/kdBuSTSiwZgV3xpMNkpPUCxZoyummVxABTs0KNr+5SsHkl6M9
	 QD3sSYCuQEVgQ==
Date: Sun, 1 Dec 2024 13:33:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Michael Walle
 <michael@walle.cc>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Guillaume
 Ranquet <granquet@baylibre.com>
Subject: Re: [PATCH v2 0/3] iio: adc: ad7173: fix non-const info struct
Message-ID: <20241201133301.34163b29@jic23-huawei>
In-Reply-To: <2c6a435e-23aa-446c-bec6-6fc4d24e2d66@baylibre.com>
References: <20241127-iio-adc-ad7313-fix-non-const-info-struct-v2-0-b6d7022b7466@baylibre.com>
	<20241130184306.51e5bb8c@jic23-huawei>
	<2c6a435e-23aa-446c-bec6-6fc4d24e2d66@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 12:50:39 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 11/30/24 12:43 PM, Jonathan Cameron wrote:
> > On Wed, 27 Nov 2024 14:01:52 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> While working ad7124, Uwe pointed out a bug in the ad7173 driver.
> >> static struct ad_sigma_delta_info ad7173_sigma_delta_info was not const
> >> and was being modified during driver probe, which could lead to race
> >> conditions if two instances of the driver were probed at the same time.
> >>
> >> The actual fix part is fairly trivial but I have only compile tested it.
> >> Guillaume has access to ad4111 hardware, so it would be good to get a
> >> Tested-by from him to make sure this doesn't break anything.
> >>  
> > This is very big for a backport.  So I replied to previous version to suggest
> > instead duplicating the data before modifying.  That has much less code
> > movement and maybe a cleaner fix.  Perhaps we then cycle back to avoiding
> > that copy later.
> >   
> That is exactly what I did in v2. "iio: adc: ad7173: fix using shared
> static info struct" copies the struct before modifying it and is the
> only patch with a Fixes: tag.
> 

Oops - brain fart. Applied patch 1 for now to the fixes-togreg branch of iio.git
and marked it for stable.  I'll get the others once that's upstream.

Thanks,

Jonathan


