Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F70F2D8F2E
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 18:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725308AbgLMRzg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 12:55:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgLMRzg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 12:55:36 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1621208D5;
        Sun, 13 Dec 2020 17:54:54 +0000 (UTC)
Date:   Sun, 13 Dec 2020 17:54:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     gabriele.mzt@gmail.com, lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: acpi_als: Add timestamp channel
Message-ID: <20201213175451.27dc9ea1@archlinux>
In-Reply-To: <20201210221541.1180448-2-gwendal@chromium.org>
References: <20201210221541.1180448-1-gwendal@chromium.org>
        <20201210221541.1180448-2-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Dec 2020 14:15:40 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add timestamp channel in list of channel, to allow retrieving timestamps
> when events are produced.

Giving IIO naming, events would be thresholds rather than buffered flow
that you are talking about here.

Not hugely important though.

> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  Changes in v3: none.
> 
>  drivers/iio/light/acpi-als.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index 1eafd0b24e182..ff0ecec65fae4 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -45,24 +45,23 @@ static const struct iio_chan_spec acpi_als_channels[] = {
>  		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
>  					  BIT(IIO_CHAN_INFO_PROCESSED),
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
>  };
>  
>  /*
>   * The event buffer contains timestamp and all the data from
>   * the ACPI0008 block. There are multiple, but so far we only
> - * support _ALI (illuminance). Once someone adds new channels
> - * to acpi_als_channels[], the evt_buffer below will grow
> - * automatically.
> + * support _ALI (illuminance):
> + * One channel, paddind and timestamp.

padding

>   */
> -#define ACPI_ALS_EVT_NR_SOURCES		ARRAY_SIZE(acpi_als_channels)
>  #define ACPI_ALS_EVT_BUFFER_SIZE		\
> -	(sizeof(s64) + (ACPI_ALS_EVT_NR_SOURCES * sizeof(s32)))
> +	(sizeof(s32) + sizeof(s32) + sizeof(s64))
>  
>  struct acpi_als {
>  	struct acpi_device	*device;
>  	struct mutex		lock;
>  
> -	s32			evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE];
> +	s32 evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE / sizeof(s32)]  __aligned(8);
>  };
>  
>  /*

