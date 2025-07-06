Return-Path: <linux-iio+bounces-21385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1E5AFA46E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0310217CDC4
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F19B1FBE9E;
	Sun,  6 Jul 2025 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY1GoYzp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA832E36E0;
	Sun,  6 Jul 2025 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751797508; cv=none; b=OXMUgD18R26l+FvAJqYe8hEAfB5YtaGi3FinR0ypTr9wUHmHwyzPskzn2LXZAHs4bHdCQZY9z29weKmPjljqbs6fi/ecCXmzD31bSrXWfjx11HULIhqsOSWkyOJ5TdRKeXpNc7OooXMYXxmo7rklcIVVe366tuFbyQqmmzz6Pd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751797508; c=relaxed/simple;
	bh=9CTyYqQfhkO4M4tsxG+CapX0CHp0nQJuzVYVPBnx47c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtT4nPB32lY141txfYR/stxeBprPJJEnATtuxmvRJb3yZZlj1w6AhFSIr5cYQ64tL9cF7sOlV4ioGq1z7JsFe3Dz2be5mkE7oo8UrXS3+atXfnT0egTiXJIw9YzgEcnIh5SltfdgYA2QPgWyPRzVYZNJMoQd2sC9o1U8Z+MkCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY1GoYzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97928C4CEED;
	Sun,  6 Jul 2025 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751797508;
	bh=9CTyYqQfhkO4M4tsxG+CapX0CHp0nQJuzVYVPBnx47c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cY1GoYzpiyCeJ8qzRRnDxvgfYIdV5MOHRDgCNklcNIve6HEfjVnLy1NMSC9yMYebT
	 MRWS2WLaFqpRixMaZ3qx3fw8nENC6cEcpiFENC7VDwEHUt3YGmwx5vqiCTxvV2NMvN
	 nj4BMc5PsAW+SYT+OfZz+Kx/lJGXCcAPxEm6qKA0R8Nz/umjJMFEWh00/AKGVT3TfF
	 7ZkhewmG2wqQ3RRfHNFd1X9Zf7/jwM1Y8ig1O2SyNgb9+D376HJzVRY/KkIyX1MFEe
	 jyamgZlYjZXdsLd8jjY18DUHJhbxu0kvf+Dc4r791xQK/p4K3BsMN7dczCaRdO0q4K
	 d3oqRlXHf/ziQ==
Date: Sun, 6 Jul 2025 11:25:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 38/80] iio: temperature: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250706112502.72441d9e@jic23-huawei>
In-Reply-To: <CAKv63utwwwQVMrAZAGy9rkk5fFPncQ=TzggZf6K0s-+GB-oi6g@mail.gmail.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
	<20250704075428.3219924-1-sakari.ailus@linux.intel.com>
	<CAKv63utwwwQVMrAZAGy9rkk5fFPncQ=TzggZf6K0s-+GB-oi6g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Jul 2025 18:00:02 +0200
Crt Mori <cmo@melexis.com> wrote:

> If that is the case then:
> Acked-by: Crt Mori<cmo@melexis.com>
> 
> 
> 
> On Fri, 4 Jul 2025 at 09:54, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> >
> > pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> > pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> > to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> > pm_runtime_mark_last_busy().
> >
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
No {} issues in here so applied to the testing branch of iio.git.
I'll push it out as togreg later in the week at which point linux-next
will see it.

Jonathan

> > ---
> > The cover letter of the set can be found here
> > <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.
> >
> > In brief, this patch depends on PM runtime patches adding marking the last
> > busy timestamp in autosuspend related functions. The patches are here, on
> > rc2:
> >
> >         git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >                 pm-runtime-6.17-rc1
> >
> >  drivers/iio/temperature/mlx90614.c | 1 -
> >  drivers/iio/temperature/mlx90632.c | 1 -
> >  drivers/iio/temperature/mlx90635.c | 1 -
> >  3 files changed, 3 deletions(-)
> >
> > diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> > index 740018d4b3df..8a44a00bfd5e 100644
> > --- a/drivers/iio/temperature/mlx90614.c
> > +++ b/drivers/iio/temperature/mlx90614.c
> > @@ -225,7 +225,6 @@ static void mlx90614_power_put(struct mlx90614_data *data)
> >         if (!data->wakeup_gpio)
> >                 return;
> >
> > -       pm_runtime_mark_last_busy(&data->client->dev);
> >         pm_runtime_put_autosuspend(&data->client->dev);
> >  }
> >  #else
> > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > index ae4ea587e7f9..bf689f6143f3 100644
> > --- a/drivers/iio/temperature/mlx90632.c
> > +++ b/drivers/iio/temperature/mlx90632.c
> > @@ -1043,7 +1043,6 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
> >         }
> >
> >  mlx90632_read_raw_pm:
> > -       pm_runtime_mark_last_busy(&data->client->dev);
> >         pm_runtime_put_autosuspend(&data->client->dev);
> >         return ret;
> >  }
> > diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> > index f7f88498ba0e..80d0eb7d2294 100644
> > --- a/drivers/iio/temperature/mlx90635.c
> > +++ b/drivers/iio/temperature/mlx90635.c
> > @@ -749,7 +749,6 @@ static int mlx90635_read_raw(struct iio_dev *indio_dev,
> >         }
> >
> >  mlx90635_read_raw_pm:
> > -       pm_runtime_mark_last_busy(&data->client->dev);
> >         pm_runtime_put_autosuspend(&data->client->dev);
> >         return ret;
> >  }
> > --
> > 2.39.5
> >  


