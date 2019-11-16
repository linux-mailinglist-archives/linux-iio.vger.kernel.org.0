Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1BFECC2
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 15:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfKPO62 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 09:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfKPO61 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 09:58:27 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6810206E1;
        Sat, 16 Nov 2019 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573916306;
        bh=nqj7UgNe0Y4TorqsN/gXEjpreuWHhGzDviu/NK0eTGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QVmsY/9yc7WAqHURPRvwYQp9if/HCsbC7uuA8wgiI30LncE8VOxnkm81x4xlLGGMS
         +u0DVtmTf24lRld1uMYn7vx1KUwqI+pVEdpEJJ25KN1rPP4fpUZSmChFREr0EAshUh
         CsS4GbWha/LIQQfZe3mLqufeUIq3dN8oxL681T1Q=
Date:   Sat, 16 Nov 2019 14:58:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <denis.ciocca@st.com>, <tglx@linutronix.de>,
        <alexios.zavras@intel.com>, <allison@lohutok.net>,
        <linus.walleij@linaro.org>, <ladis@linux-mips.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] iio: st_accel: Fix unused variable warning
Message-ID: <20191116145821.1ac46310@archlinux>
In-Reply-To: <20191111032115.3008-1-yuehaibing@huawei.com>
References: <20191101134741.25108-1-yuehaibing@huawei.com>
        <20191111032115.3008-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Nov 2019 11:21:15 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> drivers/iio/accel/st_accel_core.c:1005:44: warning:
>  mount_matrix_ext_info defined but not used [-Wunused-const-variable=]
> 
> Using stub helper while CONFIG_ACPI is disabled to fix it.
> 
> Suggested-by: Ladislav Michl <ladis@linux-mips.org>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Applied to the fixes-togreg branch of iio.git as I've now closed for new
things for the coming merge window.  This will go upstream after the merge
window closes and probably hit around rc2.  Thanks for cleaning this up.

Jonathan

> ---
>  drivers/iio/accel/st_accel_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 7b83764..7320275 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -992,6 +992,7 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>  #define ST_ACCEL_TRIGGER_OPS NULL
>  #endif
>  
> +#ifdef CONFIG_ACPI
>  static const struct iio_mount_matrix *
>  get_mount_matrix(const struct iio_dev *indio_dev,
>  		 const struct iio_chan_spec *chan)
> @@ -1012,7 +1013,6 @@ static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
>  static int apply_acpi_orientation(struct iio_dev *indio_dev,
>  				  struct iio_chan_spec *channels)
>  {
> -#ifdef CONFIG_ACPI
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
>  	struct acpi_device *adev;
> @@ -1140,10 +1140,14 @@ static int apply_acpi_orientation(struct iio_dev *indio_dev,
>  out:
>  	kfree(buffer.pointer);
>  	return ret;
> +}
>  #else /* !CONFIG_ACPI */
> +static int apply_acpi_orientation(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec *channels)
> +{
>  	return 0;
> -#endif
>  }
> +#endif
>  
>  /*
>   * st_accel_get_settings() - get sensor settings from device name

