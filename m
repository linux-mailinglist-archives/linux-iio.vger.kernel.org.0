Return-Path: <linux-iio+bounces-10402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EEA998EF3
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 19:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72361C23B40
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AEF19D082;
	Thu, 10 Oct 2024 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unjGvcNR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F219CD07;
	Thu, 10 Oct 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582853; cv=none; b=Qdk3OM1s76eEfQyUVxvWEggYl27Wb96eofTaAxZqE1lndOM2xuGVE4LL2gjIaivIXlNqUnmjRraPmajr3axJWrgPZNhJnS7X1UQQ98fDoqt3SOD8W6+RkhbroWjKIy+4zBG566lks0QH6gL7AxqtF4dGc/iQDllFaalONiBZX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582853; c=relaxed/simple;
	bh=TBFW+kcCJRJ472H9fKhEw8thT8OSqJ6lGJ9DfQiqAdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWlLouznN/NR29aJ9Nb+U3gdVC8b7lSbgQVDzTtpIbgQbbGOwUCNNLZLCOvJTFbbsUMCDAjuccccNUcNUgNkl0OVV09q2nzz4c8i8UENXDEzzOa1zVv9M3UtsmIiKBg9wcqAwi79s6fErwuERGFlPCvMfv848DxxYZafCarwMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unjGvcNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4BDC4CEC5;
	Thu, 10 Oct 2024 17:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728582853;
	bh=TBFW+kcCJRJ472H9fKhEw8thT8OSqJ6lGJ9DfQiqAdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=unjGvcNR2jVy5zpsg5LMuZlZxGiRx3pOtLXUnQZr4kTUftafUC2uXSA2R342Y189M
	 F3C11kvcDM5ALyVo5FGEE55ElHE7J+PtpbhEUIAgqaYtLNa7/UyIX2rroy7QFXhPUY
	 OEtVQiBAndTJ2LEjHKZWxCWubDHpdB5CeKnGzaCYg/HmXVu3ZGdzXLMDzl6qTgVjsd
	 P5Y/dXDnDScZgN75XX2cdaDtqjzO29e9yNe3zXNXgrO7+LqMFQgiuXIEGXzPznMnWL
	 NzYTwHCH6ufV4FkyhaEaqBli9vueZY2egh0YSce1FJx3Na6rCpMEkWsGgnJsNT7y2d
	 Ym1E92YwyZXlg==
Date: Thu, 10 Oct 2024 18:54:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Matti Vaittinen <mazziesaccount@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Dan Murphy
 <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>, Leonard =?UTF-8?B?R8O2?=
 =?UTF-8?B?aHJz?= <l.goehrs@pengutronix.de>, Mihail Chindris
 <mihail.chindris@analog.com>, Alexandru Ardelean <ardeleanalex@gmail.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Shoji Keita <awaittrot@shjk.jp>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, Dalton Durst
 <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>, Andreas Klinger
 <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Ondrej Jirman
 <megi@xff.cz>
Subject: Re: [PATCH 12/13] iio: pressure: bu1390: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241010185401.414b4677@jic23-huawei>
In-Reply-To: <Zwfaq4GlYtQV3TTs@smile.fi.intel.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-12-67c0385197cd@gmail.com>
	<20241005190147.084dd468@jic23-huawei>
	<Zwfaq4GlYtQV3TTs@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 16:46:19 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Oct 05, 2024 at 07:01:47PM +0100, Jonathan Cameron wrote:
> > On Thu, 03 Oct 2024 23:04:58 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:  
> 
> ...
> 
> > > Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")  
> > Seems unlikely in the bm1390 driver. Huh. It is accurate, but I'll fix the
> > patch description to refer to the bm1390 which seems to be the right
> > name and add a note on this as it looks suspect otherwise.  
> 
> Fixes tag shouldn't be mangled, even if it has a typo.
> 
Agreed. I added a note above it and modified name of this patch
to reflect the correct driver.

Jonathan




