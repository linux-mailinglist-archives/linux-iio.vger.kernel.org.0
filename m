Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1278224C58
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGRPOr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPOr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:14:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799D22067D;
        Sat, 18 Jul 2020 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595085286;
        bh=VbJ/FjM6srdfm9TONP3k9sR+5joZdjbsflcnTl3rH1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uOI1UXkqGZ5r9R/TwB6u/GrHCTCR9aqk3AoaSKK+2+Itynmb/Xcb6Tl5tDl6vgQdf
         OM14EqNXpJt39PAx9ZxSSI84f9rAZBWYWr94nmmIb8XxnjWWNmY8nruVTKpPk9mD/e
         qZunj0rzJ7QjVuIyw/c/Zg21PJ6ZO5R12hUKPN4A=
Date:   Sat, 18 Jul 2020 16:14:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Kevin Tsai <ktsai@capellamicro.com>
Subject: Re: [PATCH 27/30] iio: light: cm32181: Fix formatting and docrot
 issues in cm32181_acpi_get_cpm()
Message-ID: <20200718161442.1bd79612@archlinux>
In-Reply-To: <20200716135928.1456727-28-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-28-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:25 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/light/cm32181.c:107: warning: Function parameter or member 'dev' not described in 'cm32181_acpi_get_cpm'
>  drivers/iio/light/cm32181.c:107: warning: Function parameter or member 'obj_name' not described in 'cm32181_acpi_get_cpm'
>  drivers/iio/light/cm32181.c:107: warning: Function parameter or member 'values' not described in 'cm32181_acpi_get_cpm'
>  drivers/iio/light/cm32181.c:107: warning: Function parameter or member 'count' not described in 'cm32181_acpi_get_cpm'
> 
> Cc: Kevin Tsai <ktsai@capellamicro.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/light/cm32181.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 160eb3f99795e..9764099faef9a 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -93,10 +93,10 @@ static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2);
>  #ifdef CONFIG_ACPI
>  /**
>   * cm32181_acpi_get_cpm() - Get CPM object from ACPI
> - * @client	pointer of struct i2c_client.
> - * @obj_name	pointer of ACPI object name.
> - * @count	maximum size of return array.
> - * @vals	pointer of array for return elements.
> + * @dev:	pointer of struct device.
> + * @obj_name:	pointer of ACPI object name.
> + * @values:	pointer of array for return elements.
> + * @count:	maximum size of return array.
>   *
>   * Convert ACPI CPM table to array.
>   *

