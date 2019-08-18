Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1189187F
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 19:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfHRRyl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 13:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRRyl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 13:54:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA9A20B7C;
        Sun, 18 Aug 2019 17:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566150880;
        bh=E4YAksr6/atavT3eenuPTPNHrhUiFlyVbLsPoOPBKdk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nVn1KS69vWzqkVQsyvIntDNexxOK3ScycSUAPS2CEmS/kHhk8WlM0zOPXHF0AAgFe
         UbsEqEUv5w6Qo8Bd2q3msN/19HvwZS11e3AKw5Zq91iGwibnvlJ/R61nEHfqZ8IVXE
         hTZmWxi746zK7ajbckzE5Cgv7Ca+c59ym9S7QJ7k=
Date:   Sun, 18 Aug 2019 18:54:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iio: imu: adis16460: fix variable signedness
Message-ID: <20190818185436.05969228@archlinux>
In-Reply-To: <20190816062835.25588-1-alexandru.ardelean@analog.com>
References: <20190816062835.25588-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 16 Aug 2019 09:28:35 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Caught via static-analysis checker:
> ```
> drivers/iio/imu/adis16460.c
>    152  static int adis16460_set_freq(struct iio_dev *indio_dev, int val, int val2)
>    153  {
>    154          struct adis16460 *st = iio_priv(indio_dev);
>    155          unsigned int t;
>                 ^^^^^^^^^^^^^^
> 
>    156
>    157          t =  val * 1000 + val2 / 1000;
>    158          if (t <= 0)
>                     ^^^^^^
> Unsigned is not less than zero.
> ```
> 
> The types of `val` && `val2` are obtained from the IIO `write_raw` hook, so
> userspace can provide negative values, which can cause weird behavior after
> conversion to unsigned.
> 
> This patch changes the sign of variable `t` so that -EINVAL will be
> returned for negative values as well.
> 
> Fixes: db6ed4d23dd1 ("iio: imu: Add support for the ADIS16460 IMU")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16460.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> index 1ef11640ee20..6aed9e84abbf 100644
> --- a/drivers/iio/imu/adis16460.c
> +++ b/drivers/iio/imu/adis16460.c
> @@ -152,7 +152,7 @@ static int adis16460_debugfs_init(struct iio_dev *indio_dev)
>  static int adis16460_set_freq(struct iio_dev *indio_dev, int val, int val2)
>  {
>  	struct adis16460 *st = iio_priv(indio_dev);
> -	unsigned int t;
> +	int t;
>  
>  	t =  val * 1000 + val2 / 1000;
>  	if (t <= 0)

