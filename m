Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A583FAC28
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhH2OSO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 10:18:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhH2OSN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 10:18:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9058260295;
        Sun, 29 Aug 2021 14:17:18 +0000 (UTC)
Date:   Sun, 29 Aug 2021 15:20:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] drivers/iio: Remove all strcpy() uses
Message-ID: <20210829152021.7b5cae16@jic23-huawei>
In-Reply-To: <20210815174204.126593-1-len.baker@gmx.com>
References: <20210815174204.126593-1-len.baker@gmx.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Aug 2021 19:42:04 +0200
Len Baker <len.baker@gmx.com> wrote:

> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. So, remove all the uses and add
> devm_kstrdup() or devm_kasprintf() instead.
> 
> Also, modify the "for" loop conditions to clarify the access to the
> st->orientation.rotation buffer.
> 
> This patch is an effort to clean up the proliferation of str*()
> functions in the kernel and a previous step in the path to remove
> the strcpy function from the kernel entirely [1].
> 
> [1] https://github.com/KSPP/linux/issues/88
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
Applied.

Thanks,

Jonathan

> ---
> The previous versions can be found in:
> 
> v1
> https://lore.kernel.org/linux-hardening/20210801171157.17858-1-len.baker@gmx.com/
> 
> v2
> https://lore.kernel.org/linux-hardening/20210807152225.9403-1-len.baker@gmx.com/
> 
> v3
> https://lore.kernel.org/linux-hardening/20210814090618.8920-1-len.baker@gmx.com/
> 
> v4
> https://lore.kernel.org/linux-hardening/20210814135509.4500-1-len.baker@gmx.com/
> 
> Changelog v1 -> v2
> - Modify the commit changelog to inform that the motivation of this
>   patch is to remove the strcpy() function from the kernel entirely
>   (Jonathan Cameron).
> 
> Changelog v2 -> v3
> - Rewrite the code using devm_kstrdup() and devm_kasprintf() functions
>   (Andy Shevchenko).
> - Rebase against v5.14-rc5.
> 
> Changelog v3 -> v4
> - Reorder the variables (Andy Shevchenko).
> - Get the device in the definition block (Andy Shevchenko).
> - Reword the comment (Andy Shevchenko).
> - Change the conditions in the "if" statement to clarify the "0" check
>   (Andy Shevchenko).
> 
> Changelog v4 -> v5
> - Use the strcmp() function to clarify the "0" check (Joe Perches).
> - Modify the "for" loop conditions to clarify the access to the
>   st->orientation.rotation buffer (Joe Perches).
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 36 +++++++++++++---------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> index f282e9cc34c5..6aee6c989485 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> @@ -261,6 +261,7 @@ int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rate)
>   */
>  int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
>  {
> +	struct device *dev = regmap_get_device(st->map);
>  	const char *orient;
>  	char *str;
>  	int i;
> @@ -279,22 +280,27 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
>  		st->magn_orient.rotation[4] = st->orientation.rotation[1];
>  		st->magn_orient.rotation[5] = st->orientation.rotation[2];
>  		/* z <- -z */
> -		for (i = 0; i < 3; ++i) {
> -			orient = st->orientation.rotation[6 + i];
> -			/* use length + 2 for adding minus sign if needed */
> -			str = devm_kzalloc(regmap_get_device(st->map),
> -					   strlen(orient) + 2, GFP_KERNEL);
> -			if (str == NULL)
> +		for (i = 6; i < 9; ++i) {
> +			orient = st->orientation.rotation[i];
> +
> +			/*
> +			 * The value is negated according to one of the following
> +			 * rules:
> +			 *
> +			 * 1) Drop leading minus.
> +			 * 2) Leave 0 as is.
> +			 * 3) Add leading minus.
> +			 */
> +			if (orient[0] == '-')
> +				str = devm_kstrdup(dev, orient + 1, GFP_KERNEL);
> +			else if (!strcmp(orient, "0"))
> +				str = devm_kstrdup(dev, orient, GFP_KERNEL);
> +			else
> +				str = devm_kasprintf(dev, GFP_KERNEL, "-%s", orient);
> +			if (!str)
>  				return -ENOMEM;
> -			if (strcmp(orient, "0") == 0) {
> -				strcpy(str, orient);
> -			} else if (orient[0] == '-') {
> -				strcpy(str, &orient[1]);
> -			} else {
> -				str[0] = '-';
> -				strcpy(&str[1], orient);
> -			}
> -			st->magn_orient.rotation[6 + i] = str;
> +
> +			st->magn_orient.rotation[i] = str;
>  		}
>  		break;
>  	default:
> --
> 2.25.1
> 

