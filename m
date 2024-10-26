Return-Path: <linux-iio+bounces-11314-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE739B1749
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAA31F221D8
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D781D2B26;
	Sat, 26 Oct 2024 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJSyAxzx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A4B217F22;
	Sat, 26 Oct 2024 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729941016; cv=none; b=LbJohCBkg+vrjXt+eiT2lBTvUKTgIINkm+bvNgnj4hCIiaREzw06AKl2PfyuLLIP+qJkciE/iqqKkfKR+1PedwBsGVLVjEnsbdQilCpzcbHQqnRnHmVQgnmWnDXd8HY6/F/OEhgZwNo35u6dVA47eBk+gDCf4z/U2Fv7jQB/TeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729941016; c=relaxed/simple;
	bh=D1zMmPozLxAVw1VGTlTrfMf5aOGrrGagHHpZWqLDsMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ca1BSXUm4P+6ml4aiWnPBMw+HYKwMwB207VPSARpS+K0ylSfTCkv1MkQFYoEj/mU0hDZag3GGGHLZApkgIoDzY/TkqW7NrUA/Ct7Z6kR2eMykdWCxf+8GAutQlaRHt8mrluult1//lb39s0JfvZzxsvhwqlVY4S0h23dH7ImpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJSyAxzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EE7C4CEC6;
	Sat, 26 Oct 2024 11:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729941015;
	bh=D1zMmPozLxAVw1VGTlTrfMf5aOGrrGagHHpZWqLDsMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VJSyAxzxD2jy6H7hrkmMPyirYvduX9fvXkMFHuMrBoslu1IpNGkBxXm7dYm0xCgX0
	 fO4X8Z+Iieuv/k2wNykQe59DH1C4Ny8MYhZLWiD0fxQMi4LRkSMZEg0PH1eIxiXdlQ
	 mTuOeatUyY4QWWitsNAQlrnf0p/b25/inRCbHEX8AvURWLGtWBw6UfDSTNfEAwxi6H
	 G7Qb8NC0Cv2GQL77CAaBCP5jobp2H4lYU/0yRas9kX2dcv8RcTXB5eQjZbAe6Sgwer
	 fgW727v24Qnyq0qvU91JWtYZTeGRB8JrdzgdAWSWEI0i/3E0G9cGcbm+PmjFnDJvAY
	 yHTQzZ97/6jmA==
Date: Sat, 26 Oct 2024 12:09:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 05/24] iio: acpi: Add
 iio_get_acpi_device_name_and_data() helper function
Message-ID: <20241026120943.55bb9671@jic23-huawei>
In-Reply-To: <20241024191200.229894-6-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-6-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:04:54 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> A few drivers duplicate the code to retrieve ACPI device instance name.
> Some of them want an associated driver data as well.
> 
> In order of deduplication introduce the common helper functions.
It's a weird function, but clearly useful to reduce duplication of
weird code.  So fair enough.  Thanks for adding the do not use message.
Applied.

> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/industrialio-acpi.c | 38 ++++++++++++++++++++++++++++++++-
>  include/linux/iio/iio.h         | 10 +++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-acpi.c b/drivers/iio/industrialio-acpi.c
> index 1e46908f9534..d67a43843799 100644
> --- a/drivers/iio/industrialio-acpi.c
> +++ b/drivers/iio/industrialio-acpi.c
> @@ -2,7 +2,8 @@
>  /* IIO ACPI helper functions */
>  
>  #include <linux/acpi.h>
> -#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
>  #include <linux/iio/iio.h>
>  #include <linux/sprintf.h>
>  
> @@ -87,3 +88,38 @@ bool iio_read_acpi_mount_matrix(struct device *dev,
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iio_read_acpi_mount_matrix);
> +
> +/**
> + * iio_get_acpi_device_name_and_data() - Return ACPI device instance name and driver data
> + * @dev:		Device structure
> + * @data:		Optional pointer to return driver data
> + *
> + * When device was enumerated by ACPI ID matching, the user might
> + * want to set description for the physical chip. In such cases
> + * the ACPI device instance name might be used. This call may be
> + * performed to retrieve this information.
> + *
> + * NOTE: This helper function exists only for backward compatibility,
> + * do not use in a new code!
> + *
> + * Returns: ACPI device instance name or %NULL.
> + */
> +const char *iio_get_acpi_device_name_and_data(struct device *dev, const void **data)
> +{
> +	const struct acpi_device_id *id;
> +	acpi_handle handle;
> +
> +	handle = ACPI_HANDLE(dev);
> +	if (!handle)
> +		return NULL;
> +
> +	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!id)
> +		return NULL;
> +
> +	if (data)
> +		*data = (const void *)id->driver_data;
> +
> +	return dev_name(dev);
> +}
> +EXPORT_SYMBOL_GPL(iio_get_acpi_device_name_and_data);
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 3a9b57187a95..445d6666a291 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -831,6 +831,7 @@ int iio_device_resume_triggering(struct iio_dev *indio_dev);
>  bool iio_read_acpi_mount_matrix(struct device *dev,
>  				struct iio_mount_matrix *orientation,
>  				char *acpi_method);
> +const char *iio_get_acpi_device_name_and_data(struct device *dev, const void **data);
>  #else
>  static inline bool iio_read_acpi_mount_matrix(struct device *dev,
>  					      struct iio_mount_matrix *orientation,
> @@ -838,7 +839,16 @@ static inline bool iio_read_acpi_mount_matrix(struct device *dev,
>  {
>  	return false;
>  }
> +static inline const char *
> +iio_get_acpi_device_name_and_data(struct device *dev, const void **data)
> +{
> +	return NULL;
> +}
>  #endif
> +static inline const char *iio_get_acpi_device_name(struct device *dev)
> +{
> +	return iio_get_acpi_device_name_and_data(dev, NULL);
> +}
>  
>  /**
>   * iio_get_current_scan_type - Get the current scan type for a channel


