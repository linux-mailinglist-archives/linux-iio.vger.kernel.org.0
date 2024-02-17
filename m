Return-Path: <linux-iio+bounces-2717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB7585914D
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 18:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5209282CCD
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444DD7D410;
	Sat, 17 Feb 2024 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnSPC0AW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077D6D1D3
	for <linux-iio@vger.kernel.org>; Sat, 17 Feb 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708190553; cv=none; b=k35XHZngD07fakAfI58L6bS2kiCzVwSx2nZjNf3eHAg/wdBe7MEz82apIua0i0RbxAiWJ50qWrP3Skzy7VQIFuyqS3YTluseTTA1/4QTaEAWFiGCKdqr4K/GUnd0GohYIa3TUXjGxVRkvEqQUK4l5JI+yex4a2DC6XveEYqrrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708190553; c=relaxed/simple;
	bh=Cm9gizh67sBaGsk8mpqv8k//A3yt50wYQmmRwCozzeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWFUw5HCy8PfW0K7tHsYhtWkBhoYb4NNUI8p5zNJB3sTg2Yh+xHRsrqJGwyuNra0bm6yr788xa9MlnmZYJ3kveOb960YmUT54br1J44OODsDso09aaNoeYYbrO93u0lAKjP8uK7M6Q7R+BvX99HEkJJK2NhmW2yEkI9EGJMQvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnSPC0AW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CBEC433C7;
	Sat, 17 Feb 2024 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708190552;
	bh=Cm9gizh67sBaGsk8mpqv8k//A3yt50wYQmmRwCozzeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UnSPC0AWekTw+gHB4/2D9fKJLnqu56w7632AwekJcpu2uwLfBmEsR0CGEZl+qKv23
	 oIb0PqQTjuHhO+1eCGFHnkoDJ32s9eHbytkxThPV6X4alHLaIDjJtjZ+depGUyJzb5
	 ovxo3KWVdyJOnlhq3GpF/HOp4AeazsvqoOJd4kRkCz8nFamS7t/u9MooTu6bWn7EkT
	 1l6KciejozunBxHdUItvwcgpG/CUYtcDJ8+r4jgfodFE9RF+RNNcPeAAFdbcmpXZ8H
	 hoocDYs8Npu3xGHYEPF2Izv4hteLFKekNghsPc69viDXqFiJf6lw2g6JEJ0vho8awh
	 TvanjLZAYCELg==
Date: Sat, 17 Feb 2024 17:22:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan LoBue <jlobue10@gmail.com>, linux-iio@vger.kernel.org, Andy
 Shevchenko <andy.shevchenko@gmail.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, jagath jogj <jagathjog1996@gmail.com>,
 Luke Jones <luke@ljones.dev>, Denis Benato <benato.denis96@gmail.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, Derek John Clark
 <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v6 0/2] Add bmi323 support for ASUS ROG ALLY
Message-ID: <20240217172219.600aff63@jic23-huawei>
In-Reply-To: <298cba01-25a7-4c5f-92ee-e8d3254f2eca@redhat.com>
References: <CAF6rpDwZaCJOpLEYayVW8_aXQwKdpcLCDSRjbTNk1rr43EPriQ@mail.gmail.com>
	<298cba01-25a7-4c5f-92ee-e8d3254f2eca@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 19:45:07 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/16/24 19:16, Jonathan LoBue wrote:
> > From: Jonathan LoBue <jlobue10@gmail.com>
> > 
> > This patch series adds comments about a duplicate ACPI identifier
> > between devices using bmc150 and bmi323. This series also adds the ACPI
> > match table for devices using bmi323 to allow those devices to load the
> > proper driver.
> > 
> > Changes since v5:
> > - Updated patch titles
> > - Add patch description to cover letter  
> 
> I have just tested this on a Chuwi Hi13 tablet with
> a BOSC0200 accel. I blacklisted the bmc150 driver so that
> the bmi323 driver would load first. The bmi323 driver
> "successfully" fails to probe and after manually loading
> the bmc150 driver (to fake a module loading order of
> the bmi323 driver loading before the bmc150) the accel
> works properly.
> 
> So from my pov this series is good to go:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
Thanks.  I've tweaked these a fair bit for minor things whilst applying.
1) Author (From: in the email) didn't match sign off. Given address was the
   same I think I'm fine to just fix that up.
2) All the lines had a leading space.  Deleted those.
3) quite a few lines went just over 80 chars - I've rewrapped the comments
   to avoid this.

Anyhow, with those tweaks, applied via the slow path (it's not a fix as such
as the right driver was never loaded) but I'm fine with a request for a backport
of this to older kernels after this is upstream (next merge window).

Some of those would have been caught be scripts/checkpatch.pl - make sure you
run that and either fix ever warning or have a good reason why not (there are
often good reasons so don't take that script as a rule book!)

Applied to the togreg branch of iio.git but initially only pushed out as testing
for 0-day to get a head start checking for anything we missed.

Thanks,

Jonathan

> Hans
> 
> 
> 
> 


