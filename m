Return-Path: <linux-iio+bounces-22842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DF6B28EB9
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 17:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF2616C560
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3652F530F;
	Sat, 16 Aug 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyO7e3wI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2CA2E9EAB
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356448; cv=none; b=XPx5f548lWZFUVoXgvnpsT15sCEzibZ4024gQobEX62DSafvhHkpFG0oH0Kcdn9U0OOzVXP6O4f0e1O0mI32BXJMVPC5FLsHTEG5VJUpTU8WFZAMMRaROhxvduI35Rxot8vp8jHHLmkcYN2G81lX56x+z9tYkq0MzjYbvtbYa5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356448; c=relaxed/simple;
	bh=Bj1y+Tt4nl+90eJ5tH6PCyvdTJ3cHAd2jCaW3RgDx4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0RaVinBAPzZ7RihiAPz8ABVAhA+3rIlgk8TxGcsBlR7KiPKjh1Pcs5+FHvxBzZZcRVmXnJ9fs3oxyADKIXZ09285h3WEGPqM+kp1FO0NaGgpk6HWpMcm7eqmTA9Uzgq+ERoqSe+CIF9UbOu+h1TrWPP4dKUO2uJHtAl8r4Kw3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyO7e3wI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389B9C4CEEF;
	Sat, 16 Aug 2025 15:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755356447;
	bh=Bj1y+Tt4nl+90eJ5tH6PCyvdTJ3cHAd2jCaW3RgDx4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jyO7e3wIljuEHStLgVzadhomRXePqxaKWwPg+OoNH26uRMfpathaNTPsTBb1RuOiP
	 T9s0GZ8lJmW9ACQIJpt9QidUhRjlugzVW8eRCkFC3nxlIneJFEuXByHdXstUZ2IJoW
	 Y+2usQXrFVzfZKhAcRYe0cwIRoTtE1aBdd+5pbMOohRxWHepDZP1nY+qrewBrtq4My
	 kGDEVsw/WyrsRFys2ZO23mng+CQrkzYxHBIzsxm3zkW0nJ366sCsFdAkszUsrInih8
	 pi1/Iz5HRtEcMGeu9DA0qJGZZP/8+95iNiHFFdG3jhA4FWXTwgP1DEHNRzRi7oWVUG
	 EixOPuwd7k9Hg==
Date: Sat, 16 Aug 2025 16:00:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 16/16] iio: light: Simple conversions to
 iio_push_to_buffers_with_ts()
Message-ID: <20250816160036.1971b3e6@jic23-huawei>
In-Reply-To: <7ae1bb4d28e7958cdda7fb53807017034f67628a.camel@linux.intel.com>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-17-jic23@kernel.org>
	<7ae1bb4d28e7958cdda7fb53807017034f67628a.camel@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Aug 2025 06:29:10 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Sat, 2025-08-02 at 17:44 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This new function allows for runtime checks on the provided source
> > buffer
> > being of sufficient size to accommodate the enabled channel data
> > layout and
> > the naturally aligned s64 timestamp (which is non obvious and a
> > frequent
> > source of bugs in the past).
> > 
> > This patch includes the remaining simple cases for light sensor
> > drivers.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Mudit Sharma <muditsharma.info@gmail.com>
> > Cc: Jiri Kosina <jikos@kernel.org>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > Cc: Matti Vaittinen <mazziesaccount@gmail.com>  
> 
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied.

Thanks,

Jonathan

