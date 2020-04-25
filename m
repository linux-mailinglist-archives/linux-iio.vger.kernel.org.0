Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE691B87C0
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDYQqC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYQqC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:46:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F3A2064A;
        Sat, 25 Apr 2020 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587833162;
        bh=2u3MUtRc/mykauH/EOj5sP/xhx3ZGzNGw62iD2Rx6ys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VgdLiPhfNLRThZ3qVYP7cO8M1TZ7XCeKps0FaqGPvOxXzKb4or0cgOTgd2jVO3llY
         4Tnyp5PpUaJRtLrpmRcBTXmPmQZqBKeimrXXIJqqSBjV3QDPb/erN0jU714fuD2E//
         lFZvQGhKuzCd8tSTCu78OdHYvt7/XxdjlPbrlMQU=
Date:   Sat, 25 Apr 2020 17:45:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 12/16] iio: pressure: hp206c: Use
 get_unaligned_be24()
Message-ID: <20200425174558.3b14e374@archlinux>
In-Reply-To: <20200421003135.23060-12-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-12-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:31:31 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied with header added.

Jonathan

> ---
>  drivers/iio/pressure/hp206c.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/hp206c.c b/drivers/iio/pressure/hp206c.c
> index 3ac3632e7242..d746882eccc8 100644
> --- a/drivers/iio/pressure/hp206c.c
> +++ b/drivers/iio/pressure/hp206c.c
> @@ -93,12 +93,12 @@ static int hp206c_read_20bit(struct i2c_client *client, u8 cmd)
>  	int ret;
>  	u8 values[3];
>  
> -	ret = i2c_smbus_read_i2c_block_data(client, cmd, 3, values);
> +	ret = i2c_smbus_read_i2c_block_data(client, cmd, sizeof(values), values);
>  	if (ret < 0)
>  		return ret;
> -	if (ret != 3)
> +	if (ret != sizeof(values))
>  		return -EIO;
> -	return ((values[0] & 0xF) << 16) | (values[1] << 8) | (values[2]);
> +	return get_unaligned_be24(&values[0]) & GENMASK(19, 0);
>  }
>  
>  /* Spin for max 160ms until DEV_RDY is 1, or return error. */

