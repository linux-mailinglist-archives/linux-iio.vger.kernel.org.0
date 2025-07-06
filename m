Return-Path: <linux-iio+bounces-21388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452F3AFA479
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA2C179BCD
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F348C1FFC77;
	Sun,  6 Jul 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhLFtpw5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859D1FBE9E;
	Sun,  6 Jul 2025 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751797714; cv=none; b=eMQBZ1UUaCLuFPDTFl86rrHzBL8S54n0KUvpIueKRxyh466zQQhd4lO0ytNzC0Q2BDh0bM0innPRIBOp/IDzPMkt+EwrYdiNxhyV8Zr7EgoBleqOIpyxJT6CdlCPUm6t2jwlxl60PyFNQtt4v0xOSNl/GOEu0RPal4who/KHPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751797714; c=relaxed/simple;
	bh=sqsfmxEMIHdCJ5mIhZR1e9TAHhF/LbbsxqPufJRT8c8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zzg+gHW5TE0zrSK+DUoo0oJccPtDX9vVfEK1i6X88yZ+ffVvI2ZzLCC2nRecUPmhtslOYKi4gQ2kcW00ahXu8ZzN06VDHZlGQg58Lml8ZOwFcjHIVB55GgIjjxglJKpUZSwro4SYxPr6evFZRFvwa6F4hqVtFQMDuyvWScOBq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhLFtpw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFDAC4CEED;
	Sun,  6 Jul 2025 10:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751797714;
	bh=sqsfmxEMIHdCJ5mIhZR1e9TAHhF/LbbsxqPufJRT8c8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fhLFtpw5+ZJG++ZceMLxqKTiBFoyym9P1c4cz7G4yl/7Bh0a0nb0QMvNVNSRCTeC0
	 t8Gi35BLa3JTrBJxdLF7Rz6NjZwsescr6gs+n/M1LPXBDkyaxLG+kMKXsuBGbsvic5
	 McFenVsS7vKQu6iQ1nYYF/7eLdO1lsrwPl8ock97VU82KPYjYEgVBh+mn5HLRMIgDh
	 3+uldIEmPTpzU+hi/i9OhI3LGNK+5Kmm9LV5n5P1BuEN+53Ainsn3d40zEultgti1I
	 Nw6NWq+eAHfEkgyP+i3ji4OVRrvN6dDDKQ6Z7uw6eHTEyFpUDNS8SUxi9I4Nx7grSJ
	 dP+cwGMrImcMg==
Date: Sun, 6 Jul 2025 11:28:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Gerald Loacker
 <gerald.loacker@wolfvision.net>, =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?=
 <barnabas.czeman@mainlining.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Waqar Hameed <waqar.hameed@axis.com>, Hans de
 Goede <hansg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jakob
 Hauser <jahau@rocketmail.com>, David Laight <david.laight@aculab.com>, Al
 Viro <viro@zeniv.linux.org.uk>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 35/80] iio: magnetometer: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250706112825.5747acd1@jic23-huawei>
In-Reply-To: <20250704075425.3219648-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
	<20250704075425.3219648-1-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Jul 2025 10:54:25 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>


> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index 761daead5ada..53d860e640a9 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -263,7 +263,6 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
>  	if (on) {
>  		ret = pm_runtime_resume_and_get(data->dev);
>  	} else {
> -		pm_runtime_mark_last_busy(data->dev);
>  		ret = pm_runtime_put_autosuspend(data->dev);
>  	}
>  
Drop {} in both legs now neither has multiple lines.

