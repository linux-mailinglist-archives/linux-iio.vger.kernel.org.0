Return-Path: <linux-iio+bounces-19455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF341AB324E
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 10:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287AF3AA658
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 08:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462D259CA7;
	Mon, 12 May 2025 08:55:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75C433CB
	for <linux-iio@vger.kernel.org>; Mon, 12 May 2025 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040104; cv=none; b=ZMV/SHTI2pTba/BmA9QLL5pOM0WIZMnO5gEeR/amOmQ4qJMRy/yaM1LhUxtiLGwl+gIqwjzGP4IUjdCMtAr175EMWB+huVUpRiLsEO0CdguSwRjfddB7VO+Su77GSJ1vwTGIwAKviYFva9Rzeoenx8jjyTnq2ZP8muXclTMYvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040104; c=relaxed/simple;
	bh=f1BLsH+QodvHEXJ1Wl5oAoWHL/iX0dOLZGpjDxCtOTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP46N+HSWXgo8eDnlRpgyURJ2vqrWWVaU2/IbXT/X3S8+QZyqAdAdRAKO1ytb+C20iIRdzLf2lUpK02WSu8lwzm0eAJPrsG1eMKGKWZHe26AkfM7eqgEM5xSrbbjomHsJE8OeJIyrP3BmjfgK79gDzSWgF//9LUFJJfnuX1WDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: l/k/pa9NRku0QjyjF5TH8Q==
X-CSE-MsgGUID: n9c8xXMuRUC0AjvOutV4/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="48993563"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="48993563"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 01:55:03 -0700
X-CSE-ConnectionGUID: fuBeuUbcSqmOeUTCz8SpFA==
X-CSE-MsgGUID: OEDB8slaQ82v6ak29AEL2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="142260901"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 01:55:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uEOw5-00000000rqx-2d8o;
	Mon, 12 May 2025 11:54:57 +0300
Date: Mon, 12 May 2025 11:54:57 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>,
	Justin Weiss <justin@justinweiss.com>
Subject: Re: [PATCH 1/2] iio: bmi270: suspend and resume triggering on
 relevant pm operations
Message-ID: <aCG3YRP66cKyzr1B@smile.fi.intel.com>
References: <20250509171526.7842-1-benato.denis96@gmail.com>
 <20250509171526.7842-2-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509171526.7842-2-benato.denis96@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 09, 2025 at 07:15:25PM +0200, Denis Benato wrote:
> Prevent triggers from stop working after the device has entered sleep:
> use iio_device_suspend_triggering and iio_device_resume_triggering helpers.

The cover letter call it a fix, where is the Fixes tag?

...

> +const struct dev_pm_ops bmi270_core_pm_ops = {
> +	RUNTIME_PM_OPS(bmi270_core_runtime_suspend,
> +		       bmi270_core_runtime_resume, NULL)

One line (it's only 85 characters and it's fine in this case).

> +};

...

> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -52,6 +52,7 @@ static const struct of_device_id bmi270_of_match[] = {
>  static struct i2c_driver bmi270_i2c_driver = {
>  	.driver = {
>  		.name = "bmi270_i2c",
> +		.pm = pm_ptr(&bmi270_core_pm_ops),

Is pm.h included?

>  		.acpi_match_table = bmi270_acpi_match,
>  		.of_match_table = bmi270_of_match,
>  	},
> diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
> index 88a77aba5e4f..b25171413531 100644
> --- a/drivers/iio/imu/bmi270/bmi270_spi.c
> +++ b/drivers/iio/imu/bmi270/bmi270_spi.c
> @@ -79,6 +79,7 @@ static const struct of_device_id bmi270_of_match[] = {
>  static struct spi_driver bmi270_spi_driver = {
>  	.driver = {
>  		.name = "bmi270",
> +		.pm = pm_ptr(&bmi270_core_pm_ops),

Ditto.
>  		.of_match_table = bmi270_of_match,
>  	},
>  	.probe = bmi270_spi_probe,

-- 
With Best Regards,
Andy Shevchenko



