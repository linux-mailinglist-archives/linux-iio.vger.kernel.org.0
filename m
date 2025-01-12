Return-Path: <linux-iio+bounces-14247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFF7A0AAF8
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645F61632EA
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DA41BE86A;
	Sun, 12 Jan 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv60FlsS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB251BDABE;
	Sun, 12 Jan 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699924; cv=none; b=pKw0shADq8P9CrRlIXd4/lT9n+I32ya7oSUUyXOj5zQpKDbJj5N0ZVG2f45x+9LQzzXgk64+Oxfw5OUsgfwNamQjSuR7WYVUoCMOmr8K01zz5FIsLwNiKxfQEUXUk/KIKenvUK3/BJgVwbEyXbsPk2MHZ0S3z6x0AE5kDkG1XzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699924; c=relaxed/simple;
	bh=xFv9Sq7Qg+XiMIWgdm8R65SmgkXmwD6YNA1qMm2pcoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCoUOd3i8ec4Rie5ZDG/0YVBlNaPfaJsr9k76/YBN+3OrrI+OjTr/t4g0Ito/ujkaJkabYK38Kg4FLZgIxNPvmgm56Shnj1lWB5KCudveDFn7vDomn3TIB0IU8VsxvVJOppTJb8YrQZovhYJGAa+d76j94s+z9AJFi1SRG5vLek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv60FlsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1C9C4CEDF;
	Sun, 12 Jan 2025 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736699923;
	bh=xFv9Sq7Qg+XiMIWgdm8R65SmgkXmwD6YNA1qMm2pcoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iv60FlsSvptDyhKU39WNACaTstbsC633jawEYJ0v3UfYdr2ytiM0bq1T1cy4gVBud
	 mtn1ruAF8Km3dmEoTQDtVCqI3ePRcQB/kfD6C7WYPdTl5kARhP0K57e5PPDzKRAhdf
	 Jsdgqm5ZBRsNdKvzg3B8zQ4l2jN0AJ8Q9g2Zshaf0E/k4x3shfbUxc7YrKMbM08V3e
	 PVRFsRihElsFnnPU2iJ4i2u0yje53TyuN7XjD4CjJZ48H6hMHVszR3yeNy/fUxbRBk
	 1MQGcU3V9zOMEdld4R/+OXm8jOX+WhFQ8GRn4nAe1AgE0fNCi7Udqh36r4zvso6w12
	 XYxpWoWQAthCQ==
Date: Sun, 12 Jan 2025 16:38:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 0/4] iio: accel: adxl345: add FIFO operating with IRQ
 triggered watermark events
Message-ID: <20250112163836.512ff0c5@jic23-huawei>
In-Reply-To: <Z4Poo4x9xvBpdeso@surfacebook.localdomain>
References: <20241228232949.72487-1-l.rubusch@gmail.com>
	<20250104130916.5a25b5bd@jic23-huawei>
	<Z4Poo4x9xvBpdeso@surfacebook.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 18:06:59 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Sat, Jan 04, 2025 at 01:09:16PM +0000, Jonathan Cameron kirjoitti:
> > On Sat, 28 Dec 2024 23:29:45 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> >   
> > > The adxl345 sensor offers several features. Most of them are based on
> > > using the hardware FIFO and reacting on events coming in on an interrupt
> > > line. Add access to configure and read out the FIFO, handling of interrupts
> > > and configuration and application of the watermark feature on that FIFO.
> > > 
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>  
> > Series applied but with a tweak on patch 3.  Please take a look at the
> > testing branch where this will sit for a few days,  
> 
> I would expect the comments I gave to be addressed as well before going to
> upstream, but sorry for having a bit prolonged vacation.
> 
I missed outstanding bits.  Suggested improvements will need to be handled
as cleanup patches on top.

Hope you had a good vacation.

Jonathan

