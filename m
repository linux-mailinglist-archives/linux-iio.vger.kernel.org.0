Return-Path: <linux-iio+bounces-21387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76109AFA472
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8C83BB2E3
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723DB1FBE9E;
	Sun,  6 Jul 2025 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG1z4Ss2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF42E36E0;
	Sun,  6 Jul 2025 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751797651; cv=none; b=GYbCOXndz+jHGwri35lXk6KKji2hY8bzHYA4t7Xdgqu04ic3KXwM3EEwelf3vRddDgy3WlEDxq3zHM4IN3/BFQ6E1ZRveIgyiTs0ZUnmTAB0gdnfupFirTtMgKPE36xtgSeodXtxQAMhc5Z5dc4d9L0LW6SKgSH9uPJgrbX5oRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751797651; c=relaxed/simple;
	bh=44ZnyjYsXfPP0u5itXesAoGZJiqOXFNJTQSwtaVPofE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/izxCjfk2rBfto+3hrNKbdHdW+HQHS15QWPYwXKvYGZ413bs0U4kNix11tyS6Ue4zNs3g01t912qarvVZxPNRY1BRy60ypY7i3N5zxIQWpLpvi9qRckIS9R5fWvUaVsYqCEtP5dpQicFqREYmWpPI0L/XEJSK8oi0TL7MWkIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG1z4Ss2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3ECC4CEED;
	Sun,  6 Jul 2025 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751797650;
	bh=44ZnyjYsXfPP0u5itXesAoGZJiqOXFNJTQSwtaVPofE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MG1z4Ss2G8AK7MokXVKs7xf8Tc4TjbjkFB3dXLejILKx91pWZiLXNpFQYOugYj+NJ
	 u0gwfY9yo2Kd+Q6Q0yLXnHCWvxjrVUf2up5+PEWHajRGnCUCILMys8hsxKEIOVbGyZ
	 oRVoIzg5az55dJ+ANPCuA+Fm3ThbO5FSnYDM6NmqUtQlUDfCqgDMRQtTs3HRSY44bH
	 RAqbyx3ps2N4oOdMVDEg+HTLiHGLRaEmLKvp+aj3OiMUXVwCdKuz7isn/oRWjwaqSn
	 6wu22MUvNDtdP7OSTHnv4XxX9HDAJ/lrx+fy7OEK1ZuxbPerzjDwmsJMefbIdCav8v
	 KqcfA1I5hrArg==
Date: Sun, 6 Jul 2025 11:27:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andreas Klinger
 <ak@it-klinger.de>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 37/80] iio: proximity: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250706112723.268e7bd0@jic23-huawei>
In-Reply-To: <20250704075427.3219858-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
	<20250704075427.3219858-1-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Jul 2025 10:54:27 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> The cover letter of the set can be found here
> <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.
> 
> In brief, this patch depends on PM runtime patches adding marking the last
> busy timestamp in autosuspend related functions. The patches are here, on
> rc2:
> 
>         git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>                 pm-runtime-6.17-rc1
> 
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 -
>  drivers/iio/proximity/srf04.c                     | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 1deaf70e92ce..d53a596128f5 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -191,7 +191,6 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>  		}
>  		ret = -EIO;
>  	}
> -	pm_runtime_mark_last_busy(&client->dev);
>  	pm_runtime_put_autosuspend(&client->dev);
>  
>  	return ret;
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index b059bac1078b..f2e2c638a2b6 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -118,7 +118,6 @@ static int srf04_read(struct srf04_data *data)
>  	gpiod_set_value(data->gpiod_trig, 0);
>  
>  	if (data->gpiod_power) {
> -		pm_runtime_mark_last_busy(data->dev);
>  		pm_runtime_put_autosuspend(data->dev);
>  	}
>  
Drop {}



