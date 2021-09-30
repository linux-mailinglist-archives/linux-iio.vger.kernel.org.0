Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D541DF20
	for <lists+linux-iio@lfdr.de>; Thu, 30 Sep 2021 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350921AbhI3Qgl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Sep 2021 12:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352028AbhI3Qgl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Sep 2021 12:36:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35BC260FC1;
        Thu, 30 Sep 2021 16:34:56 +0000 (UTC)
Date:   Thu, 30 Sep 2021 17:38:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH] iio: st_pressure_spi: Add missing entries SPI to device
 ID table
Message-ID: <20210930173852.208f1815@jic23-huawei>
In-Reply-To: <20210927134153.12739-1-broonie@kernel.org>
References: <20210927134153.12739-1-broonie@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Sep 2021 14:41:53 +0100
Mark Brown <broonie@kernel.org> wrote:

> Currently autoloading for SPI devices does not use the DT ID table, it uses
> SPI modalises. Supporting OF modalises is going to be difficult if not
> impractical, an attempt was made but has been reverted, so ensure that
> module autoloading works for this driver by adding SPI IDs for parts that
> only have a compatible listed.
> 
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")
> Signed-off-by: Mark Brown <broonie@kernel.org>

Whilst these IDs are deprecated, we should at least be consistent that they either
work or not rather than current situation.

+CC Denis as driver author.  I'll let it sit on list a little longer so Denis can
take a look.

Thanks

Jonathan

> ---
>  drivers/iio/pressure/st_pressure_spi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> index 9b2523c5bc94..d6fc954e28f8 100644
> --- a/drivers/iio/pressure/st_pressure_spi.c
> +++ b/drivers/iio/pressure/st_pressure_spi.c
> @@ -97,6 +97,10 @@ static const struct spi_device_id st_press_id_table[] = {
>  	{ LPS33HW_PRESS_DEV_NAME },
>  	{ LPS35HW_PRESS_DEV_NAME },
>  	{ LPS22HH_PRESS_DEV_NAME },
> +	{ "lps001wp-press" },
> +	{ "lps25h-press", },
> +	{ "lps331ap-press" },
> +	{ "lps22hb-press" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_press_id_table);

