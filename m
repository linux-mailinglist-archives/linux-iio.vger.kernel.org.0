Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD57410C50
	for <lists+linux-iio@lfdr.de>; Sun, 19 Sep 2021 17:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhISQBR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Sep 2021 12:01:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhISQBQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Sep 2021 12:01:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E16FC6101B;
        Sun, 19 Sep 2021 15:59:49 +0000 (UTC)
Date:   Sun, 19 Sep 2021 17:03:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma7660: Mark acpi match table as maybe
 unused
Message-ID: <20210919170330.0b79cb0e@jic23-huawei>
In-Reply-To: <20210919072616.3849723-1-daniel@0x0f.com>
References: <20210919072616.3849723-1-daniel@0x0f.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 19 Sep 2021 16:26:16 +0900
Daniel Palmer <daniel@0x0f.com> wrote:

> When building kernels without ACPI support the table is declared
> but is not used because ACPI_PTR() turns it into a NULL.
> 
> Add the __maybe_unused attribute to stop the compiler whining.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Applied to the togreg branch of iio.git which is initially pushed out as testing
to let 0-day poke at it and see if we missed anything.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma7660.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
> index 47f5cd66e996..cd6cdf2c51b0 100644
> --- a/drivers/iio/accel/mma7660.c
> +++ b/drivers/iio/accel/mma7660.c
> @@ -254,7 +254,7 @@ static const struct of_device_id mma7660_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mma7660_of_match);
>  
> -static const struct acpi_device_id mma7660_acpi_id[] = {
> +static const struct acpi_device_id __maybe_unused mma7660_acpi_id[] = {
>  	{"MMA7660", 0},
>  	{}
>  };

