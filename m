Return-Path: <linux-iio+bounces-14563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4CDA1C2FF
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 13:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE883A734D
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1534207DF1;
	Sat, 25 Jan 2025 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOIExhW4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0CD23B0;
	Sat, 25 Jan 2025 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737807065; cv=none; b=Vw5+beKy4O2qhO5aAZ13iX2Jws+IbGWrqON8pwfjnBn89BVf4ReQv5Dvv0jkldloFmEsQvRpb3BeLRSGxCAM5SRwb3QDRExxnFZruSVedQDJIZm1NGd0HgLMjFFXT5KRy+Y8EKiGw/wPkTv5G8mcnvNnmvWB8H24cp3mrLpu9K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737807065; c=relaxed/simple;
	bh=/Uvqg6XuEUvoHoXAX29VieoBj1Cxi03Lt6+8NLmGt54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFVnYB/UUSNA2oRooKiogs6aIeFtRzHGn7n4OT+dMy7+5SVlr8EI+ZyeDa2Cez5sn5DmZLtLW2RC0VkfJtNlmF79f+xngQBYUyFazqjrzWhTTzjNim5fl70PYRo/T6/ZDI4UN5lhb1gmDTFKcg+8ph7YBZzyphsFmI1ysyqZTmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOIExhW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E77BC4CED6;
	Sat, 25 Jan 2025 12:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737807065;
	bh=/Uvqg6XuEUvoHoXAX29VieoBj1Cxi03Lt6+8NLmGt54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fOIExhW4Ddds+CyqMT/vGcfDiNgb4qu5tuEVyZtrxz7RUIlTndujhyZuxMrMUhkKk
	 EJWX7s3X7UKTU0EBSzRvA4093MVANz/YDff8e/o4LwI6ch8Dm370PrdvMWtL4eJ71H
	 t9wl9VEwRK7IHmLpfQmI+iEeGp5I7A9mJrMW25Vh1nvTaP8TDDBfBHp6eibyKbYWwl
	 s87g03GSrWVmCSdnrZMJXPixE3jgENhZo1F0/E4f9HJ+UvTY2rfdL7dg18ArlhHSMz
	 Ry4n5CL+lfE4kGnStzChWQj2QWVxVEkdkIqtOrZe1A/X9UBVnG8+RHShOETHlRvC8T
	 uIvTf81obCynA==
Date: Sat, 25 Jan 2025 12:10:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] iio: ad3552r-hs: add support for ad3541/42r
Message-ID: <20250125121058.01de9f0b@jic23-huawei>
In-Reply-To: <20250118161101.68fffa2d@jic23-huawei>
References: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
	<20250118161101.68fffa2d@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Jan 2025 16:11:01 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 14 Jan 2025 16:30:09 +0100
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > This patchset add support for ad3541/42r, 16MUPS, respectively
> > single and dual channel DACs, together with some minor fixes.
> > 
> > The ad354xr connect through a DSPI bus (while ad355xr through
> > QSPI), so a new fpga HDL supporting bus mode switch has been
> > developed to support them.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>  
> All looks good to me. I've not applied it quite yet as there were
> various reviewers contributing to feedback on v3 and I want
> to give them more time for a last look.
> 
> We have plenty of time at this point in a cycle so no rush,
> but if no feedback needing a v5 I'll probably pick the remainder
> of this series up in a week or so.
Applied 3-9 (first two already on tree as you say below)
For now just pushed out as testing.
There is time for more comments / tags etc if anyone wants
to give them as I'll be rebasing on rc1 after next Sunday anyway.

Thanks,

Jonathan

> 
> Jonathan
> 
> > ---
> > Changes in v2:
> > - reproposing the patchset using platform data for bus mode
> >   change functionality,
> > - improve commit messages,
> > - add separate patch for instruction mode,
> > - add separate patch for sharing model data structures,
> > - remove error on wrong id,
> > - fix id detection info message in case of wrong id.
> > 
> > Changes in v3:
> > - improve commit messages,
> > - removed some not useful dev_err, 
> > - comment syntax fixes,
> > - add lock guards for bus mode change,
> > - remove externs for range tables.
> > 
> > Changes in v4:
> > - keep in still patch 1 and 2/9, that was already picked up, in particular
> >   the patch 1/9 is the same as in v2, the 2/9 has a minimal change:
> >   removed dev_err() message, so can be eventually be re-picked up,
> > - fix commit messages,
> > - add mode validation in axi_dac_bus_set_io_mode,
> > - use dev_warn() on wrong chip ID,
> > - fix instruction mode patch to unwrap properly on error.
> > - rename ad3552r_update_reg_bits to ad3552r_hs_update_reg_bits,
> >   to respect module name in the function name.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > ---
> > Angelo Dureghello (9):
> >       iio: dac: ad3552r-common: fix ad3541/2r ranges
> >       iio: dac: ad3552r-hs: clear reset status flag
> >       iio: dac: adi-axi-dac: modify stream enable
> >       iio: dac: adi-axi-dac: add bus mode setup
> >       iio: dac: ad3552r-hs: fix message on wrong chip id
> >       iio: dac: ad3552r-hs: use instruction mode for configuration
> >       iio: dac: ad3552r: share model data structures
> >       iio: dac: ad3552r-hs: add ad3541/2r support
> >       iio: dac: ad3552r-hs: update function name (non functional)
> > 
> >  drivers/iio/dac/ad3552r-common.c |  55 ++++++-
> >  drivers/iio/dac/ad3552r-hs.c     | 322 ++++++++++++++++++++++++++++++---------
> >  drivers/iio/dac/ad3552r-hs.h     |   8 +
> >  drivers/iio/dac/ad3552r.c        |  36 -----
> >  drivers/iio/dac/ad3552r.h        |  17 ++-
> >  drivers/iio/dac/adi-axi-dac.c    |  33 +++-
> >  6 files changed, 350 insertions(+), 121 deletions(-)
> > ---
> > base-commit: d487a2869417596556c56b781f82ebeedaea6889
> > change-id: 20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-762ff6c91edb
> > 
> > Best regards,  
> 
> 


