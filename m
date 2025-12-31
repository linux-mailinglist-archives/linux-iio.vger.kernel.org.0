Return-Path: <linux-iio+bounces-27442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46250CEC5AF
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA73300A1C0
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E5A28D8DF;
	Wed, 31 Dec 2025 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAVNnSFl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48051A23AC;
	Wed, 31 Dec 2025 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201459; cv=none; b=MzeSAMTtjj4sc0u5zfHTcf3Wmyb6uiZyGjJ9kADEtlTJafOviQITSSsTZBWc3I9pBO1PJdnCtuP4Yi8Kci5eK6HPji4pQ5cTIpIN752w2cS1c8+u5LlnMl75nALvkFcDfmbBDlaUfY0Ic1ioZzLzRUG4UKlnLdHMojHdyINGvhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201459; c=relaxed/simple;
	bh=O/uhqbHIuuxXKTJbbD+CaCGak7BN+HTuwzaAX4fcjoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjOtV7JuvvJmiljKAQw4RpRxd2fcOps5LJC4zLVPzXaCw7WhEjvVV4Tny9jiQan+nwd23qfPEtRI1GMRddLhHSPg/pH93/fIZGf1uO4VoTt6+YqbFl6pDbNupr6IeoKQTLHVds0HbKl0awpTXhNL3Q/GCgx9G9tCAllrDt/VNPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAVNnSFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD03EC113D0;
	Wed, 31 Dec 2025 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767201459;
	bh=O/uhqbHIuuxXKTJbbD+CaCGak7BN+HTuwzaAX4fcjoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DAVNnSFldSwHhqWqGo59fE04d3jZwXi5qSA3+UB2mw0vohnV+I24djHRweYbJLJqM
	 lhC3kzZtS+fZh7VsBWzAj5VPBalUrlN1qs3fK3rHRlcdVrvRhlpAa5AihxABkAdgRE
	 9G5fG0j6DKSmEVCUrieBm0vB5Dpni0zQckvQIK9zCiS2JTNIcFMpQZgx3WH5resf4j
	 N2ICfvohFdVYUm1J7FF6ZqSO1OGN64Gbtm0iJMcxhr3hjKPtGWj3J1V6+F6fVPdAya
	 a1hm192eHDTqmDZw6BT954bAlwIGNOITm3F8PADUoW3BjADhASHyhmiioWPjfObr9N
	 WAsUznlgJerkA==
Date: Wed, 31 Dec 2025 17:17:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: test: drop dangling symbol in gain-time-scale
 helpers
Message-ID: <20251231171732.48f0353e@jic23-huawei>
In-Reply-To: <CANhJrGNV8FfmjRniTLYGq_9pLnfGmy0HjO01SU0gzOwhD7Eahw@mail.gmail.com>
References: <20251228071029.2246703-1-rdunlap@infradead.org>
	<CANhJrGNV8FfmjRniTLYGq_9pLnfGmy0HjO01SU0gzOwhD7Eahw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Dec 2025 13:13:48 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> su 28.12.2025 klo 9.10 Randy Dunlap <rdunlap@infradead.org> kirjoitti:
> 
> > The code for this never went upstream. It was replaced by other code,
> > so this should be dropped.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216748
> > Fixes: cf996f039679 ("iio: test: test gain-time-scale helpers")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >  
> 
> Thanks!
> 
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied to the togreg branch of iio.git which I'll briefly push out
as testing to let 0-day have a first look at it.

Thanks,

Jonathan

> 
> ---
> > Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: linux-iio@vger.kernel.org
> >
> >  drivers/iio/test/Kconfig |    1 -
> >  1 file changed, 1 deletion(-)
> >
> > --- linux-next-20251219.orig/drivers/iio/test/Kconfig
> > +++ linux-next-20251219/drivers/iio/test/Kconfig
> > @@ -8,7 +8,6 @@ config IIO_GTS_KUNIT_TEST
> >         tristate "Test IIO gain-time-scale helpers" if !KUNIT_ALL_TESTS
> >         depends on KUNIT
> >         select IIO_GTS_HELPER
> > -       select TEST_KUNIT_DEVICE_HELPERS
> >         default KUNIT_ALL_TESTS
> >         help
> >           build unit tests for the IIO light sensor gain-time-scale
> > helpers.
> >  


