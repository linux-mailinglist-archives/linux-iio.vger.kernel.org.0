Return-Path: <linux-iio+bounces-11332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29989B17A9
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100F91C2147C
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECA1D47A3;
	Sat, 26 Oct 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY8WuDdi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB961CACDB;
	Sat, 26 Oct 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943845; cv=none; b=McdOxFivR2lCCkE9xTJ6y9EitDsXkirI+Snb6OPXk4vVzGBP+2Z/jeF9OLmRQd8ptN6wAknMaxHefSKDoahQEcBkaSp9VRC+1ftd5hEdVE7k48u32YQHl3opaVGQm/+VRQPCnKNedS+68jGKj+WKk7zxVswYAzmxHQtLI9pHq3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943845; c=relaxed/simple;
	bh=C2LYciOTqDpQ1fEV7ENZqP4yCmNX2145AGTfwg8Tx4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArRhIYU6nRVBIKLtMoD8MOzqZ3ES3oJgWu35tsAxK2TVyPJYQkdqk7UdbqUv3f4UWPh27mLmuDkQJe3pYfsDFUzF3bsbhO93Lp8m2oZTOjuVjwFQomZBcgQi5VZBKC+AyKysAoMyexkgJLQyt7yPgsXYbtuObQ3H0UQYDpCMGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY8WuDdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73968C4CEC6;
	Sat, 26 Oct 2024 11:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729943844;
	bh=C2LYciOTqDpQ1fEV7ENZqP4yCmNX2145AGTfwg8Tx4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FY8WuDdiAeasbNeLytgZFGnALODgUMCICcdQ2lgDEdKAFT/30CUPyFuR1bHZioae3
	 WrKPE/2S8SZx1hLHuCoSrkz1aoib2qdBxkvecBs70IxG7nGInJ+s2h3qRHpteaROJc
	 iudTEIiWkdRL8YKY81lc9907W/X8Dd9LVlnGhVdKS+KWNUKcStwpzXUBzQ+6Aw6+OG
	 bvPrbf++qcto2oWKDI72PONzn92hHKSOHaqEvkeXeWLL/udCnJgHVGRXCQC63HroKz
	 Y4tHdADgTieAjvIxTde56yiKPtVDEU9JU1Nw403EUz5UiWW5xy8HmJZA+ACObREi9e
	 j5VXmhxiLBKhw==
Date: Sat, 26 Oct 2024 12:56:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 23/24] iio: light: ltr501: Add LTER0303 to the
 supported devices
Message-ID: <20241026125643.36237f7e@jic23-huawei>
In-Reply-To: <20241024191200.229894-24-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-24-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:12 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> It has been found that the (non-vendor issued) ACPI ID for Lite-On
> LTR303 is present in Microsoft catalog. Add it to the list of the
> supported devices.
> 
> Link: https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303
> Closes: https://lore.kernel.org/r/9cdda3e0-d56e-466f-911f-96ffd6f602c8@redhat.com
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'm not totally happy that the MS catalog is enough to justify inclusion.
Would prefer to have an actual device. 

I'll take it anyway as better to have a policy on this than make it up
each time. So for now I want:
1) A device name or
2) Entry in the MS catalog.

Not
3) Entry in a driver on random vendor website that we have no evidence
   is in their products. (the Bosch one the other day).

Jonathan

> ---
>  drivers/iio/light/ltr501.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 3fff5d58ba3c..4051d0d9e799 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1611,6 +1611,8 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
>  
>  static const struct acpi_device_id ltr_acpi_match[] = {
>  	{ "LTER0301", ltr301 },
> +	/* https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303 */
> +	{ "LTER0303", ltr303 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);


