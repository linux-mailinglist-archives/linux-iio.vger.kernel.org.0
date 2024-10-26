Return-Path: <linux-iio+bounces-11331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63659B17A5
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147B81C21557
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6A71D4613;
	Sat, 26 Oct 2024 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQy4NLhi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4D1CACDB;
	Sat, 26 Oct 2024 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943671; cv=none; b=HdBl3WBmJstEMYDIMrAlu7ILJ0yWgmo7f3OAnqakugSOZbc4KGmNKVNbl3+/lIv5s9Kz2un+1r3tZbw86Q+KujcuulqFmpL/lHqQiGF3XEjnKDYXEenZx7eey+NH6cqxdVqB7xaylrmiQf05vF4zICaXmp+7/yIL6aw/+V7vais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943671; c=relaxed/simple;
	bh=WOjSA1awcKay0Xb405c+Eg4piWCa5OaVqKiO9AYrNLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVKzaUDwTwzvYCWDlcJECNrdfYfGaxHq87YA7nbiajF0p6sPA9gsEjAL0iEheenSuYIZOs8E6eV5JKRziENiE1mYfE0u/tjpMccQ0G15CZbRfmAKwd5z00KV6aQCSRpXCLkdxnVAQ7EuNCl5wycQq0rjF8uKGINToalVmSJRpXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQy4NLhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB08C4CEC6;
	Sat, 26 Oct 2024 11:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729943671;
	bh=WOjSA1awcKay0Xb405c+Eg4piWCa5OaVqKiO9AYrNLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LQy4NLhiD6rEmnndBAz+ie0fyNBqWAZxrsYp5UVDlKBzdu5PiRpgOjLatxuIVfxBB
	 FaUZv78XZxfcJWeQ8mY110pzm4eb4T8+SziVNw8nbHajq5IcgoXIRM8+CXP7C2fj/L
	 xY9jJEtJpjPFOe/ffQozEKpnR2clMmLJ2TTaJyeip8ENLPb8pYIFoalrwZLY7DdDJa
	 WLA8I2bvYdJ8gseYMOEJB+rpnsosJTAzHLt6uX+J+oy6uiuR19dPA5x/hQFHtCqA1v
	 xgyM35F69xLXIG941maLgnVtGOzW7mGvDaUvnpWJOvyHt7uQEJEDbiY6fiPjhHG/TV
	 U91F/fp7b8TKA==
Date: Sat, 26 Oct 2024 12:54:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 22/24] iio: light: ltr501: Drop most likely fake ACPI
 IDs
Message-ID: <20241026125408.32d72326@jic23-huawei>
In-Reply-To: <20241024191200.229894-23-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-23-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:11 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The commits in question do not proove that ACPI IDs exist.
> Quite likely it was a cargo cult addition while doing that
> for DT-based enumeration. Drop most likely fake ACPI IDs.
> 
> The to be removed IDs has been checked against the following resources:
> 1) DuckDuckGo
> 2) Google
> 3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
> This gives no useful results in regard to DSDT, moreover, the official
> vendor ID in the registry for Lite-On is LCI.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.
> ---
>  drivers/iio/light/ltr501.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 8c516ede9116..3fff5d58ba3c 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1610,8 +1610,6 @@ static int ltr501_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
>  
>  static const struct acpi_device_id ltr_acpi_match[] = {
> -	{ "LTER0501", ltr501 },
> -	{ "LTER0559", ltr559 },
>  	{ "LTER0301", ltr301 },
>  	{ },
>  };


