Return-Path: <linux-iio+bounces-11313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25699B1746
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A591C20F52
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06429217F22;
	Sat, 26 Oct 2024 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djjf5a5P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DB1D1F5B;
	Sat, 26 Oct 2024 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729940891; cv=none; b=uPrhzfZhOtJ10KsEtWEbDFAGO84ca7HrMbds85Ljr6yF1OJzu4lELnjSvcjlBO4mswtgqToJrnyvz8qFcQAq+j4B2N9futuuHbFZU4cgvj1ivkGwLjY3IoQCvzMnOJROXeWE6Z4h1CZpTOI29EOLzhahFEc466AvWqDOqDl7Uvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729940891; c=relaxed/simple;
	bh=O/fIQTdxWvINK0wsy+BNeKfvEcxfxdz8O9UySUZBOac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6eJkJYhngZms/Rf03Do8RKuD1jCqkeBgUzYrBk+L1AseuYRGzccOWgGwA8cKCtsqO7vRBIv0qpTtwRzNgsLYcdk+U2J66O1N8Rk2uR6puF9k/+7DBEm4vBY2Kp5XQYZtYzCtxTrsw2NZP252AGrwaTDlQ2Y6nLGrxBRCIJBqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djjf5a5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FE9C4CEC6;
	Sat, 26 Oct 2024 11:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729940891;
	bh=O/fIQTdxWvINK0wsy+BNeKfvEcxfxdz8O9UySUZBOac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=djjf5a5PVFw75iAYXx7094Wik31RjFgRf/1yzjZzKCXWxGWLVg52j4Bi2NrVLsJoP
	 xGVZVBSDtZucIBKGqmiVyI2lArOQpNuMIJEwYJSzIpQVuF+9ap00OCzNc5e2a8RQWd
	 3RNIQaidkwdIrjzc9dloBa5vddUegdKytEEzOA8cnrfGFUjq85XVh8r3V5S+fjMd9m
	 Z8JxzZ6x/tRz4SjVI4RPiMJFsolPvZxZp4qaF0o+0MKZ5CaWk64Fq13sK+QmKSmaB0
	 WEyIN/oopy2yYRsyLcL6YF1LSUuGBzgeUdm19DRzGlyWFO3GnkL7QrOJMLRdBQpvjE
	 wvesBUfCpJvJg==
Date: Sat, 26 Oct 2024 12:07:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Andy
 Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 04/24] iio: acpi: Improve
 iio_read_acpi_mount_matrix()
Message-ID: <20241026120730.199f1465@jic23-huawei>
In-Reply-To: <20241024191200.229894-5-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-5-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:04:53 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> By using ACPI_HANDLE() the handler argument can be retrieved directly.
> Replace ACPI_COMPANION() + dereference with ACPI_HANDLE().
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
There are two of you?  That explains so many things ;)

Anyhow, whilst a little unusual fair enough that you sent this with different
hats on.

Applied.


> ---
>  drivers/iio/industrialio-acpi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-acpi.c b/drivers/iio/industrialio-acpi.c
> index 981b75d40780..1e46908f9534 100644
> --- a/drivers/iio/industrialio-acpi.c
> +++ b/drivers/iio/industrialio-acpi.c
> @@ -28,17 +28,21 @@ bool iio_read_acpi_mount_matrix(struct device *dev,
>  				char *acpi_method)
>  {
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> -	struct acpi_device *adev = ACPI_COMPANION(dev);
>  	char *str;
>  	union acpi_object *obj, *elements;
> +	acpi_handle handle;
>  	acpi_status status;
>  	int i, j, val[3];
>  	bool ret = false;
>  
> -	if (!adev || !acpi_has_method(adev->handle, acpi_method))
> +	handle = ACPI_HANDLE(dev);
> +	if (!handle)
>  		return false;
>  
> -	status = acpi_evaluate_object(adev->handle, acpi_method, NULL, &buffer);
> +	if (!acpi_has_method(handle, acpi_method))
> +		return false;
> +
> +	status = acpi_evaluate_object(handle, acpi_method, NULL, &buffer);
>  	if (ACPI_FAILURE(status)) {
>  		dev_err(dev, "Failed to get ACPI mount matrix: %d\n", status);
>  		return false;


