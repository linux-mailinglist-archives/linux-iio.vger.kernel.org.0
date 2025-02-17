Return-Path: <linux-iio+bounces-15706-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC63EA3868C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB893A27B7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6FF22069A;
	Mon, 17 Feb 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjUKCLYk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1D15F306;
	Mon, 17 Feb 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802620; cv=none; b=G/tqlNyC6DxK3P/B/Zvvigko96DA8KrGd91PE8kk3ZnhAoeQwTs3NCV4RFafPlrq1NRJAlv2WspvFt9RDc3pux6lpYOi6KI7cddlFKHhAYGCxFeMqXe06u4JssrvtMQj+dq/QCBy5RqIIGKw4K1bEimdjJ76VL0O/7mJ9jJy55I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802620; c=relaxed/simple;
	bh=94CHu+FtmQQHk7PDr0sHJg3vDzg+hrM32lccmBkQ5+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sx7Umvsu6Gp23jamIv0m/tAfS5IZzaMfgQKGB6I3oaOqZQB5NXE4jhVRK+zuPzgclCnol/D5edKk/O2OdpLW3O3CliK2yGVPtIdXM1vjS8MymeXBSWuMXtOoi2hTuSwujwi78KgSW38n8arbmDvuDkMrJZnniG40eti90eLL3c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjUKCLYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C16C4CED1;
	Mon, 17 Feb 2025 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739802619;
	bh=94CHu+FtmQQHk7PDr0sHJg3vDzg+hrM32lccmBkQ5+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EjUKCLYkJb5bY2PucFHDB/ZKsY7PmzP/dpf96HFKvmgnhf0MOD7u89KiPBKcOyMch
	 4yJTQKBf+/nu/RjNQDTvNEKfev86BV7D13p0p0/wCAkMpz1gpy2XTNrJD7rW/fJXM0
	 HGkiQgNE4yrCsmGA3RMiWh88Vq+7UBoswDNns/rHuI3zRoSi0uhdoOur1r8PFZAXP8
	 pV5R1f3FCtz5cH0VFUkhX0aZEMqfRF8YTPbaI+bknWTyUEqZlApjk18z2PEffwfn3e
	 CiwRsxaxmKj+RkS9buFW/wo97T35fCkEhI/dVKcUBYHmF+julrJtZEMOoRQ07zLYc8
	 yU59ytUXTmCNQ==
Date: Mon, 17 Feb 2025 14:30:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan
 Hunter <jonathanh@nvidia.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Emil Gedenryd
 <emil.gedenryd@axis.com>, Arthur Becker <arthur.becker@sentec.com>, Mudit
 Sharma <muditsharma.info@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Ivan Orlov <ivan.orlov0322@gmail.com>,
 David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: light: add al3000a als support
Message-ID: <20250217143006.1f043a0e@jic23-huawei>
In-Reply-To: <20250217140336.107476-1-clamor95@gmail.com>
References: <20250217140336.107476-1-clamor95@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 16:03:33 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> AL3000a is an illuminance sensor found in ASUS TF101 tablet.
Hi Svyatoslav,

Just a small request.  Please reduce rate of sending new versions.
That tends to give time for discussions on earlier versions to progress
and for more reviewers to see the current version.

I'd suggest at least 3-4 days between versions.  It's great to
responsive to reviewers of course!

Jonathan


> 
> ---
> Changes on switching from v3 to v4:
> - return write function directly
> - clean up and fix i2c_device_id
> 
> Changes on switching from v2 to v3:
> - droped linux/iio/sysfs.h
> - set driver name directly
> - switched to IIO_CHAN_INFO_PROCESSED
> - split al3000a_set_pwr into 2 functions
> - added i2c_device_id
> - improved code formatting 
> 
> Changes on switching from v1 to v2:
> - sort compatible alphabetically in schema
> - clarify commit descriptions
> - convert to use regmap
> - arrangle lux conversion table in rows of 8
> - add more used headers
> - improve code formatting 
> ---
> 
> Svyatoslav Ryhel (3):
>   dt-bindings: iio: light: al3010: add al3000a support
>   iio: light: Add support for AL3000a illuminance sensor
>   ARM: tegra: tf101: Add al3000a illuminance sensor node
> 
>  .../bindings/iio/light/dynaimage,al3010.yaml  |   6 +-
>  .../boot/dts/nvidia/tegra20-asus-tf101.dts    |  11 +
>  drivers/iio/light/Kconfig                     |  10 +
>  drivers/iio/light/Makefile                    |   1 +
>  drivers/iio/light/al3000a.c                   | 209 ++++++++++++++++++
>  5 files changed, 235 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iio/light/al3000a.c
> 


