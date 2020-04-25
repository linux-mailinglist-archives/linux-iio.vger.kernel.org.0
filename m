Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D8F1B87BF
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgDYQoE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYQoE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:44:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B956206A2;
        Sat, 25 Apr 2020 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587833043;
        bh=uZCBUJZEzW0z09TgGaREQnRw0gr1CLxrtcr4BRCKyMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tf9LjmGUy9Bc7oCxTLVLedGNnBj9ywXptxltZ9US6MgDhVpbFHWonQAUl5I2KU7Ii
         4x3JSqOIJ+E/fiNmze9Qd3KKR7QC6Doz1cV5xIdKKG8fCtr0R6Yv9yd7wnOwB1Ykbm
         IwVxcU6FrTIGFVkGmmWJxuWCryis0CweiFX94pVU=
Date:   Sat, 25 Apr 2020 17:44:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Song Qiang <songqiang1304521@gmail.com>
Subject: Re: [PATCH v1 11/16] iio: magnetometer: rm3100: Use
 get_unaligned_be24()
Message-ID: <20200425174400.3a121e81@archlinux>
In-Reply-To: <20200421003135.23060-11-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-11-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:31:30 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> 
> Cc: Song Qiang <songqiang1304521@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Header and typo (see below fixed)

Applied to the togreg branch of iio.git and pushed out as testing
to see what else we missed :(

> ---
>  drivers/iio/magnetometer/rm3100-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> index 7c20918d8108..b3ae9a6c439b 100644
> --- a/drivers/iio/magnetometer/rm3100-core.c
> +++ b/drivers/iio/magnetometer/rm3100-core.c
> @@ -223,8 +223,7 @@ static int rm3100_read_mag(struct rm3100_data *data, int idx, int *val)
>  		goto unlock_return;
>  	mutex_unlock(&data->lock);
>  
> -	*val = sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
> -			     23);
> +	*val = sign_extend32(get_unalinged_be24(&buffer[0]), 23);

unaligned

>  
>  	return IIO_VAL_INT;
>  

