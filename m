Return-Path: <linux-iio+bounces-9290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D999702FA
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5921282272
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B4D15F308;
	Sat,  7 Sep 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPYuGfou"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA551B85DC;
	Sat,  7 Sep 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725723481; cv=none; b=Vmle8trmBFJBv7BrMoYxFGOW9R+bNRiD6SBk3JyBikSj/CxK3IBVw3OiMHiru/qwZmcHkJA5AkS20A1HgzDs0Cktr5Z+1PUMiKYB5HpAlkHYrLavNC6NE+eZnzrxDkMimkpur8O+6zb7Hleg+n4FzsQSZg2QO5ii0PVJ8E5bybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725723481; c=relaxed/simple;
	bh=+1PBS0rsaFakbdn65HASWoi1e+X/NQMiqYkoRsesY1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAtZ/87fXxfZLG0PJbqPIEq0eVhEZTmnEndW/BjVR+WipRhFUbA6TofkK/SxDqdQdtAmItspCNzJ449Z94GHUBUMDDTedri+DH5lTPQSikFfoXKZkHuVjRJ7P6r9QgEd7jMdBoBdLY92I9Iji+mHhLr3JjOqi67quilR0KIIfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPYuGfou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B73C4CEC2;
	Sat,  7 Sep 2024 15:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725723480;
	bh=+1PBS0rsaFakbdn65HASWoi1e+X/NQMiqYkoRsesY1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kPYuGfouKah82OISpuADTXAqIrlhixSPxphgguyBnKa5H1BLqx5Shp9IQUw92jTou
	 izPk7HBGjwlHdHMHK13jNz0TuxT8AvBxnS24g7hjJIBVR9n3WxaAdTTroQT0dAgQ8g
	 2TpvomPotN6ug/PiH0eCwtQbpDL+BlFQGXu2dlgxUauW6F/svG/NrT9m5JDBITCOog
	 njteuiQKqoDq2WDhM4JFwXdLb1zquRozgmKkZSerE9J80UxYui2zAq7tCD33tjISY+
	 BFSXD58z2eyDii4TEdJRxj/5S1ZIhINCxBxXKH6FeJfaXtFnnStjEjmHcMycSE23k3
	 2TckZmcgxNAFA==
Date: Sat, 7 Sep 2024 16:37:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina
 <jikos@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi
 <lorenzo@kernel.org>
Subject: Re: [PATCH v2 0/3] iio: Introduce and use aligned_s64 type
Message-ID: <20240907163752.2eb3be6a@jic23-huawei>
In-Reply-To: <20240903180218.3640501-1-andriy.shevchenko@linux.intel.com>
References: <20240903180218.3640501-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Sep 2024 20:59:03 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Instead of having open coded idea of aligned member, use
> a newly defined type like it's done in, e.g., u64 case.
> Update a few IIO drivers to show how to use it.
> 
> v2 (took only one year from v1, not bad!):
:)

Applied with that tweak for patch 2 that you called out.

Will probably be next cycle though before these go upstream
(so think of this as queuing them up very early for 6.13 :)

> - avoided touching unrelated comments, code lines, etc. (Jonathan)
> - used kernel internal type for the in-kernel code (Jonathan)
> 
> Andy Shevchenko (3):
>   types: Complement the aligned types with signed 64-bit one
>   iio: imu: st_lsm6dsx: Use aligned data type for timestamp
>   iio: hid-sensor: Use aligned data type for timestamp
> 
>  drivers/iio/accel/hid-sensor-accel-3d.c              | 2 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c                | 2 +-
>  drivers/iio/humidity/hid-sensor-humidity.c           | 2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h              | 3 +--
>  drivers/iio/light/hid-sensor-als.c                   | 2 +-
>  drivers/iio/orientation/hid-sensor-incl-3d.c         | 2 +-
>  drivers/iio/orientation/hid-sensor-rotation.c        | 2 +-
>  drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
>  drivers/iio/pressure/hid-sensor-press.c              | 2 +-
>  drivers/iio/temperature/hid-sensor-temperature.c     | 2 +-
>  include/linux/types.h                                | 3 ++-
>  include/uapi/linux/types.h                           | 1 +
>  12 files changed, 13 insertions(+), 12 deletions(-)
> 


