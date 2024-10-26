Return-Path: <linux-iio+bounces-11311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBB49B173E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6441C2140B
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6481D2796;
	Sat, 26 Oct 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVcuhhZG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5AF217F22;
	Sat, 26 Oct 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729940641; cv=none; b=n4iPDdhFFuETnUOwKfchYmhJK9hXSrPF44U0nprxM6QOLzpFAe254/GgIdicvAG1C4TavKErf7Zq95v/76h36b9yVqhbRv++5yJWjBbaPtUr72pPKJeJLUnA48NLMsQ2IkrEC754bWVkU4KVjuzSE+zqLt/d43c9YA2alqecYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729940641; c=relaxed/simple;
	bh=6/j2yB4KsWr+cGt2R31iVvsCkKMPgvqnN3uoX7PQMkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmuEkiBj0Ko33gi0gB/jjTD7j0YnCd3i9uOsKRxY5hq+rZceJhvHIDOxhPrNzzK/omoowe9WRZaTq80Wfu564hxqwgpc7N1DRMq8zT+qe2uuREaK3RjGZeQ/oKNijReb4IAJj2QZMAvyLM0dHzCwyefAsE3+vxyudfRujBdYq18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVcuhhZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66E7C4CEC6;
	Sat, 26 Oct 2024 11:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729940640;
	bh=6/j2yB4KsWr+cGt2R31iVvsCkKMPgvqnN3uoX7PQMkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OVcuhhZGqMQ7YwaVOZ8dvtXqFFR+woVRrdxd7rxJuSqGvHc2XkeWc0nIfWIq2Gxem
	 xVueS5N/8i/TUG8TLrZuHulAC+H//WZj+t7RyutP+EAXeXFnB0pbtEUIYFCZ2aRmHA
	 uaRRIrM+G9pmOWz08eYNvj6fkKwqVI9PIAGedTq3MastZFj4woN7k7T2g6u8zjbCzL
	 nkpSEDiSaJHgR+tzEllNdGb9klZr2rCihpr9fcGxQ39nNjHPYKbH9r+IKeNStetmtP
	 0GuhDY7SoNpeDdp/fa2AYbZ0QaLx5rWU5nyjXlPKrc+EP3B51FEF6+BE3F6zs1CEQ7
	 PTdST8VqvWMdA==
Date: Sat, 26 Oct 2024 12:03:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 02/24] iio: adc: pac1934: Replace strange way of
 checking type of enumeration
Message-ID: <20241026120352.33ea650c@jic23-huawei>
In-Reply-To: <20241024191200.229894-3-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:04:51 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> When device is enumerated via ACPI the respective device node is of
> ACPI device type. Use that to check for ACPI enumeration, rather than
> calling for full match which is O(n) vs. O(1) for the regular check.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Marius Cristea <marius.cristea@microchip.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied
> ---
>  drivers/iio/adc/pac1934.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> index 7ef249d83286..20802b7f49ea 100644
> --- a/drivers/iio/adc/pac1934.c
> +++ b/drivers/iio/adc/pac1934.c
> @@ -1507,7 +1507,7 @@ static int pac1934_probe(struct i2c_client *client)
>  		indio_dev->name = pac1934_chip_config[ret].name;
>  	}
>  
> -	if (acpi_match_device(dev->driver->acpi_match_table, dev))
> +	if (is_acpi_device_node(dev_fwnode(dev)))
>  		ret = pac1934_acpi_parse_channel_config(client, info);
>  	else
>  		/*


