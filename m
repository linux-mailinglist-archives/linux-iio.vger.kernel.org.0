Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D3B1A753
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfEKJyx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 05:54:53 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:58070 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfEKJyx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 May 2019 05:54:53 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 717899E8F92;
        Sat, 11 May 2019 10:54:52 +0100 (BST)
Date:   Sat, 11 May 2019 10:54:50 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Angelo Compagnucci <angelo@amarulasolutions.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp3422: fix of match table
Message-ID: <20190511105450.544808d7@archlinux>
In-Reply-To: <1557258335-9863-1-git-send-email-angelo@amarulasolutions.com>
References: <1557258335-9863-1-git-send-email-angelo@amarulasolutions.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  7 May 2019 21:45:35 +0200
Angelo Compagnucci <angelo@amarulasolutions.com> wrote:

> In order to support all the chip variants in dts, compatible should
> explicitly list all the variants and not only the base one.
> 
> Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
These should have a manufacturer prefix.

Note that the fallback path to the id_table will work anyway
for these devices so whilst it is good to tidy this up there
isn't any great urgency.

Jonathan

> ---
>  drivers/iio/adc/mcp3422.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 63de705..91d6be3 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -410,7 +410,14 @@ MODULE_DEVICE_TABLE(i2c, mcp3422_id);
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id mcp3422_of_match[] = {
> +	{ .compatible = "mcp3421" },
>  	{ .compatible = "mcp3422" },
> +	{ .compatible = "mcp3423" },
> +	{ .compatible = "mcp3424" },
> +	{ .compatible = "mcp3425" },
> +	{ .compatible = "mcp3426" },
> +	{ .compatible = "mcp3427" },
> +	{ .compatible = "mcp3428" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, mcp3422_of_match);

