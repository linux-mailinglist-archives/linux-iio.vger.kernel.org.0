Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E0643E596
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJ1QBA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 12:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhJ1QBA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 12:01:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A16DA60FC4;
        Thu, 28 Oct 2021 15:58:30 +0000 (UTC)
Date:   Thu, 28 Oct 2021 17:02:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: add adddac subdirectory
Message-ID: <20211028170256.5a616bae@jic23-huawei>
In-Reply-To: <20211028135608.3666940-1-demonsingur@gmail.com>
References: <20211028134849.3664969-1-demonsingur@gmail.com>
        <20211028135608.3666940-1-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Oct 2021 16:56:03 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> For IIO devices that expose both ADC and DAC functionality.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Why v2?

Should be a change log (+ I would suggest a cover letter).
Also, reply to previous version if there haven't been comments that
you are replying to..

I'll assume most v1 comments apply to v2 and hence wait for v3.

Please leave some time for others to review these versions before
sending a v3.  

Jonathan

> ---
>  drivers/iio/Kconfig        | 1 +
>  drivers/iio/Makefile       | 1 +
>  drivers/iio/addac/Kconfig  | 8 ++++++++
>  drivers/iio/addac/Makefile | 6 ++++++
>  4 files changed, 16 insertions(+)
>  create mode 100644 drivers/iio/addac/Kconfig
>  create mode 100644 drivers/iio/addac/Makefile
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 2334ad249b46..4fb4321a72cb 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -70,6 +70,7 @@ config IIO_TRIGGERED_EVENT
>  
>  source "drivers/iio/accel/Kconfig"
>  source "drivers/iio/adc/Kconfig"
> +source "drivers/iio/addac/Kconfig"
>  source "drivers/iio/afe/Kconfig"
>  source "drivers/iio/amplifiers/Kconfig"
>  source "drivers/iio/cdc/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 65e39bd4f934..8d48c70fee4d 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
>  
>  obj-y += accel/
>  obj-y += adc/
> +obj-y += addac/
>  obj-y += afe/
>  obj-y += amplifiers/
>  obj-y += buffer/
> diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
> new file mode 100644
> index 000000000000..2e64d7755d5e
> --- /dev/null
> +++ b/drivers/iio/addac/Kconfig
> @@ -0,0 +1,8 @@
> +#
> +# ADC DAC drivers
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Analog to digital and digital to analog converters"
> +
> +endmenu
> diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
> new file mode 100644
> index 000000000000..b888b9ee12da
> --- /dev/null
> +++ b/drivers/iio/addac/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for industrial I/O ADDAC drivers
> +#
> +
> +# When adding new entries keep the list in alphabetical order

