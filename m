Return-Path: <linux-iio+bounces-21386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FD9AFA471
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241E17AC2CA
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E361FF1AD;
	Sun,  6 Jul 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5IsTPSc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08D2E36E0;
	Sun,  6 Jul 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751797598; cv=none; b=ZJjGmXn4On1gYS3/CnJ3R0O14N169uFyAepbw/ba+2RyRfLO90V8MNwpvjW33E4qxxoIDu6FUaKenGIB7Sd5tk3eDaKsm631Ow/UM80f0NeHIOT6dqL2PaCkFujo1sVmQ40yLy6IeBbppM4TFZDOF2K0qR7YfnkeUtbWkoL8RR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751797598; c=relaxed/simple;
	bh=sHztWTj75+wZmzNmNM9hTcX0OSwTHApDHrVwsUSSxa0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zj+kNB78bh/Xz6a29k0b8uC5Dt+0KaO3BWU6kHy42JmjAdtWJHW9cIVyL0zhIbV2jvOHzVCkoXvSlhr6+tqFLi5bHbuDNVhJBLXOZmUhSLUnWb7dcIiMqVWKt4HRxh5p7oDpe2uaPyv5SdWItDfZqTcUaON2Kl5+hJHaJNPTqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5IsTPSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0150BC4CEED;
	Sun,  6 Jul 2025 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751797597;
	bh=sHztWTj75+wZmzNmNM9hTcX0OSwTHApDHrVwsUSSxa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t5IsTPSci3VbTp8DR+IVeOSqAh1sm9ivyibY7v1ThJwk/pyIaOFwpQdpojw2Y2DA+
	 xBItBdl2XPLa791TtVLIfd/0dfYgbE1eqSdCCofP18bF7c+yuaYWhUJ48vjrquHjVi
	 NHYunhiL2g3F5f88jV/kwoXO/ITIWKCc2qVVqSDUuv/HMI8Pjkf7phBpBaNkenGlyZ
	 D4xrzBx019E4RXGmIOJB4NSHy7TX9+F5c47dHyH8CZuZY2q+SjV09CLO4+sCBFNjfR
	 uWcUUz8VOcA415nSY8OyzGykxy4tggxOFvlGqYHnYY0oslB7SoNLAme5vMvnYsDjUf
	 LtKVs6oXp5FdQ==
Date: Sun, 6 Jul 2025 11:26:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 38/80] iio: temperature: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250706112631.33bd5a4d@jic23-huawei>
In-Reply-To: <20250706112502.72441d9e@jic23-huawei>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
	<20250704075428.3219924-1-sakari.ailus@linux.intel.com>
	<CAKv63utwwwQVMrAZAGy9rkk5fFPncQ=TzggZf6K0s-+GB-oi6g@mail.gmail.com>
	<20250706112502.72441d9e@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 6 Jul 2025 11:25:02 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 4 Jul 2025 18:00:02 +0200
> Crt Mori <cmo@melexis.com> wrote:
> 
> > If that is the case then:
> > Acked-by: Crt Mori<cmo@melexis.com>
> > 
> > 
> > 
> > On Fri, 4 Jul 2025 at 09:54, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:  
> > >
> > > pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> > > pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> > > to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> > > pm_runtime_mark_last_busy().
> > >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>  
> No {} issues in here so applied to the testing branch of iio.git.
> I'll push it out as togreg later in the week at which point linux-next
> will see it.
> 
Actually - change of plan.  I'll wait on your set with the others fixed
up as I don't want to pull in the pm-runtime change if I'm only going
to have a few of these ready by the end of the cycle. I don't mind merging
that with the whole lot if they are ready though.

Jonathan

> Jonathan
> 
> > > ---
> > > The cover letter of the set can be found here
> > > <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.
> > >
> > > In brief, this patch depends on PM runtime patches adding marking the last
> > > busy timestamp in autosuspend related functions. The patches are here, on
> > > rc2:
> > >
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > >                 pm-runtime-6.17-rc1
> > >
> > >  drivers/iio/temperature/mlx90614.c | 1 -
> > >  drivers/iio/temperature/mlx90632.c | 1 -
> > >  drivers/iio/temperature/mlx90635.c | 1 -
> > >  3 files changed, 3 deletions(-)
> > >
> > > diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> > > index 740018d4b3df..8a44a00bfd5e 100644
> > > --- a/drivers/iio/temperature/mlx90614.c
> > > +++ b/drivers/iio/temperature/mlx90614.c
> > > @@ -225,7 +225,6 @@ static void mlx90614_power_put(struct mlx90614_data *data)
> > >         if (!data->wakeup_gpio)
> > >                 return;
> > >
> > > -       pm_runtime_mark_last_busy(&data->client->dev);
> > >         pm_runtime_put_autosuspend(&data->client->dev);
> > >  }
> > >  #else
> > > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > > index ae4ea587e7f9..bf689f6143f3 100644
> > > --- a/drivers/iio/temperature/mlx90632.c
> > > +++ b/drivers/iio/temperature/mlx90632.c
> > > @@ -1043,7 +1043,6 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
> > >         }
> > >
> > >  mlx90632_read_raw_pm:
> > > -       pm_runtime_mark_last_busy(&data->client->dev);
> > >         pm_runtime_put_autosuspend(&data->client->dev);
> > >         return ret;
> > >  }
> > > diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> > > index f7f88498ba0e..80d0eb7d2294 100644
> > > --- a/drivers/iio/temperature/mlx90635.c
> > > +++ b/drivers/iio/temperature/mlx90635.c
> > > @@ -749,7 +749,6 @@ static int mlx90635_read_raw(struct iio_dev *indio_dev,
> > >         }
> > >
> > >  mlx90635_read_raw_pm:
> > > -       pm_runtime_mark_last_busy(&data->client->dev);
> > >         pm_runtime_put_autosuspend(&data->client->dev);
> > >         return ret;
> > >  }
> > > --
> > > 2.39.5
> > >    
> 


