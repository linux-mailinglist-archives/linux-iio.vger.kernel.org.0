Return-Path: <linux-iio+bounces-11717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A469B832E
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 20:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE011F23696
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810B1C1AB6;
	Thu, 31 Oct 2024 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h20r/HXl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D17347C7;
	Thu, 31 Oct 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402245; cv=none; b=FivZfk1fYZF3sWy3PNwos7OwcBoq7NHS5eU16Q7iqY6vHzM9OWY7ZY/GarE9L3HJryLoMCVlXaWwrMxTJD5+Z9OnFQX7LdY9ph2zUEHqVYa/elt9efB5mVDOFaplVWyV+ralGZ66hOY3HFWiKd9uHKC6+ks2Iz81pU0WMtM0YQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402245; c=relaxed/simple;
	bh=YF+XtBwianWfnGOhO4q0gH+LPuCSKvryQB8Ejf+k/qg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cahb4ZNwcw+rtaJZTpW8/BCAC+dr+WUd3e8AY8EbS6/3gk6dfrChnpZhou2Zm2E62z6g33Gt0UUP04S2qSXm8rB02fQTtBOW5h3Ej62H7eQQ9oWnNvUeQeCSgAE3nyX3VL3TJXe6hueOJpkbLoKbhYokaTW2+3ibCOinngUGy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h20r/HXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4E8C4CEC3;
	Thu, 31 Oct 2024 19:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402244;
	bh=YF+XtBwianWfnGOhO4q0gH+LPuCSKvryQB8Ejf+k/qg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h20r/HXlVt2UNyklb/EkzYCghRuWSN9YfQB+6hACEi0IPJhtxEe82PfKEj5PUoHKq
	 ELmiTGFghrQRTVNQhVgWrDEGm/fcOyXdlu5RCb+V/nU+ny1R3rb1w1K9RUJVI+jaeB
	 Z/KToI1C7qrHt1PmKbSQUxTXBrXHk/5qURUM0PWhWyk3CZGQngqJbUwcfKBD5ovbj+
	 D7YAq0gk7hE8d/GDYNCOcMVC0BVLOdc8zl7JsKx1n7/2ZjbqYB+FpS0nI2ucqpusmF
	 ZCOETC0kVwUt5bph66JJ9GReiYhpulFJ6UyRoIVpqaIvrF1pq56kFPlF1yBYIJOutV
	 NrJt3lKgQzZ9g==
Date: Thu, 31 Oct 2024 19:17:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v1 1/4] iio: acpi: Fill data with NULL when
 iio_get_acpi_device_name_and_data() fails
Message-ID: <20241031191717.1a521f03@jic23-huawei>
In-Reply-To: <20241030160756.2099326-2-andriy.shevchenko@linux.intel.com>
References: <20241030160756.2099326-1-andriy.shevchenko@linux.intel.com>
	<20241030160756.2099326-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 18:02:17 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Fill data with NULL, if provided, when returning NULL from
> iio_get_acpi_device_name_and_data(). Note, the current users check
> for name to be valid, except one case which was initially doing
> like that and has to be fixed separately.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/54fac4a7-b601-40ce-8c00-d94807f5e214@stanley.mountain
> Fixes: dc60de4eb0a4 ("iio: acpi: Add iio_get_acpi_device_name_and_data() helper function")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is counter intuitive as usual expectation would be no side effects on an
error return.  How hard to fix all the users to initialize to NULL if they
care about that?

There is still a chance we set it to NULL in here anyway, but that should only happen
if we know the return is good in the sense of no error (missing ACPI etc)
but not necessarily that dev_name() won't return NULL.

Don't think dev_name() can currently return NULL but 'maybe' it could...



> ---
>  drivers/iio/industrialio-acpi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-acpi.c b/drivers/iio/industrialio-acpi.c
> index d67a43843799..33c737c7a2f8 100644
> --- a/drivers/iio/industrialio-acpi.c
> +++ b/drivers/iio/industrialio-acpi.c
> @@ -102,13 +102,17 @@ EXPORT_SYMBOL_GPL(iio_read_acpi_mount_matrix);
>   * NOTE: This helper function exists only for backward compatibility,
>   * do not use in a new code!
>   *
> - * Returns: ACPI device instance name or %NULL.
> + * Returns: ACPI device instance name or %NULL When returning %NULL, the @data,
> + * if provided, will be also initialised to %NULL.
>   */
>  const char *iio_get_acpi_device_name_and_data(struct device *dev, const void **data)
>  {
>  	const struct acpi_device_id *id;
>  	acpi_handle handle;
>  
> +	if (data)
> +		*data = NULL;
> +
>  	handle = ACPI_HANDLE(dev);
>  	if (!handle)
>  		return NULL;


