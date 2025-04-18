Return-Path: <linux-iio+bounces-18261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3FA93985
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E288C1B63834
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC182066FF;
	Fri, 18 Apr 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjX88RiC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599670823;
	Fri, 18 Apr 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989734; cv=none; b=aPWHTonD7/mWu1JEm9ZL6VsQoohIWHaLYr4cLiQy3Z4yEH0/77IYfw2B7yUc09Im0o7XqfZmOvigFioB+IAm5ckHmZtGcnlOkpMXOPxyux0ig3ugLftIYa8AtmbUBtYhrrbBU5IfsO0jtuUXxL9xq8zJv8Xr1LZwHoCaNTNCwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989734; c=relaxed/simple;
	bh=DM/eToi4fQsi4jJmxexxgjn3uiKzE9cRCKPbXFEP1KE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2Xx3N2ILnXs5J2o3ysA3lnkbNU7bbLgLW5k4Z9Rro5UVLk6ozv2kff7n70UsXDc5RrwspJ4Q0KSdRw/f3d88gFtIowdYTmJwHNcfgL+DBhHNxCzrqxcFULqmpuMPakHLIDdJgM/Gp8WT+Aj5DE9pIh6+MECZN8UBiG2P6M5hKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjX88RiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE1FC4CEE2;
	Fri, 18 Apr 2025 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744989733;
	bh=DM/eToi4fQsi4jJmxexxgjn3uiKzE9cRCKPbXFEP1KE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MjX88RiCq1lmjN9igA4LAXgTOAmTSI6+n3mJXgDh7iSpq27lZ756si/BWLFYc6o4l
	 bHJ+ZX59fydYad4MFSV1v6PakgH2+NmQOlVajkhfMEMCTbTJivPgqJeorMxxKG92Nr
	 3zA9KL8X07V+n2X/JHjI/4ifOQWB+UVaw38o6sFs2hFYt+s1/eg322wnIAmkwmHyxv
	 LQX/AaIqUkh0Y406ADK8iudNJhpw+b89fzu4gHDzr8p5atX++3yQrUzeyeBd189xhz
	 iIh0RnmUg2sqHrN4A0nI4jgNNUsPC78NR9b22i0iQysOz6itJpErruj1zboOc0ZZcJ
	 m31KYwgETtEPA==
Date: Fri, 18 Apr 2025 16:22:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v8] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
Message-ID: <20250418162208.2be5f219@jic23-huawei>
In-Reply-To: <CAGd6pzM6=A1=ioLm4C51Nc8TBai5sSELpWbLfShwScbxfs=HhA@mail.gmail.com>
References: <20250416140259.13431-1-simeddon@gmail.com>
	<CAGd6pzM6=A1=ioLm4C51Nc8TBai5sSELpWbLfShwScbxfs=HhA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 19:39:03 +0530
Siddharth Menon <simeddon@gmail.com> wrote:

> On Wed, 16 Apr 2025 at 19:33, Siddharth Menon <simeddon@gmail.com> wrote:
> >
> > Use bitfield and bitmask macros to clearly specify AD9832 SPI
> > command fields to make register write code more readable.
> >
> > Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Signed-off-by: Siddharth Menon <simeddon@gmail.com>  
> 
> I'm sorry... I forgot to add the reviewed by tag
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Applied to the togreg branch of iio.git. I'll initially push that out as
testing though to let 0-day poke at this and the rest of the stuff I queue today.

