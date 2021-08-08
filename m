Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB2F3E3B58
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 18:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhHHQWf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 12:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhHHQWe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 12:22:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5001060F35;
        Sun,  8 Aug 2021 16:22:14 +0000 (UTC)
Date:   Sun, 8 Aug 2021 17:25:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/iio: Remove all strcpy() uses in favor of
 strscpy()
Message-ID: <20210808172503.5187cd24@jic23-huawei>
In-Reply-To: <20210807152225.9403-1-len.baker@gmx.com>
References: <20210807152225.9403-1-len.baker@gmx.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  7 Aug 2021 17:22:25 +0200
Len Baker <len.baker@gmx.com> wrote:

> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. The safe replacement is strscpy().
> 
> This patch is an effort to clean up the proliferation of str*()
> functions in the kernel and a previous step in the path to remove
> the strcpy function from the kernel entirely [1].
> 
> [1] https://github.com/KSPP/linux/issues/88
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
Applied to the togreg branch of iio.git and pushed out as testing
so 0-day can poke at it and see if we missed anything.

Thanks,

Jonathan

> ---
> Changelog v1 -> v2
> - Modify the commit changelog to inform that the motivation of this
>   patch is to remove the strcpy() function from the kernel entirely
>   (Jonathan Cameron).
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> index f282e9cc34c5..3a6aa1c4bf6c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> @@ -264,6 +264,7 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
>  	const char *orient;
>  	char *str;
>  	int i;
> +	size_t n;
> 
>  	/* fill magnetometer orientation */
>  	switch (st->chip_type) {
> @@ -282,17 +283,18 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
>  		for (i = 0; i < 3; ++i) {
>  			orient = st->orientation.rotation[6 + i];
>  			/* use length + 2 for adding minus sign if needed */
> -			str = devm_kzalloc(regmap_get_device(st->map),
> -					   strlen(orient) + 2, GFP_KERNEL);
> +			n = strlen(orient) + 2;
> +			str = devm_kzalloc(regmap_get_device(st->map), n,
> +					   GFP_KERNEL);
>  			if (str == NULL)
>  				return -ENOMEM;
>  			if (strcmp(orient, "0") == 0) {
> -				strcpy(str, orient);
> +				strscpy(str, orient, n);
>  			} else if (orient[0] == '-') {
> -				strcpy(str, &orient[1]);
> +				strscpy(str, &orient[1], n);
>  			} else {
>  				str[0] = '-';
> -				strcpy(&str[1], orient);
> +				strscpy(&str[1], orient, n - 1);
>  			}
>  			st->magn_orient.rotation[6 + i] = str;
>  		}
> --
> 2.25.1
> 

