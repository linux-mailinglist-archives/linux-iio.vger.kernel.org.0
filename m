Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F903C35D4
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 19:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhGJRfl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 10 Jul 2021 13:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhGJRfl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 13:35:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D5B61279;
        Sat, 10 Jul 2021 17:32:52 +0000 (UTC)
Date:   Sat, 10 Jul 2021 18:35:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antti =?UTF-8?B?S2Vyw6RuZW4=?= <detegr@rbx.email>
Cc:     linux-iio@vger.kernel.org, Hannu Hartikainen <hannu@hrtk.in>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] iio: adis: set GPIO reset pin direction
Message-ID: <20210710183525.0684bd90@jic23-huawei>
In-Reply-To: <20210708095425.13295-1-detegr@rbx.email>
References: <60e5ac8c.1c69fb81.c69f0.abab@mx.google.com>
        <20210708095425.13295-1-detegr@rbx.email>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  8 Jul 2021 12:54:29 +0300
Antti Keränen <detegr@rbx.email> wrote:

> Set reset pin direction to output as the reset pin needs to be an active
> low output pin.
> 
> Co-developed-by: Hannu Hartikainen <hannu@hrtk.in>
> Signed-off-by: Hannu Hartikainen <hannu@hrtk.in>
> Signed-off-by: Antti Keränen <detegr@rbx.email>

Hi Antti,

For future reference (in IIO anyway as not all maintainers agree on this!)
please don't send a v2 in reply to v1.  It gets lots if anyone is using
a threaded email client as it's buried deep.  If I'd not been following
the discussion I'd probably have missed this.

Seems correct to me, but will leave on list a few more days as rc1 isn't
out yet so I don't have a good based to start collecting fixes on a the
moment.

Jonathan

> ---
> Removed unnecessary toggling of the pin as requested by Lars-Peter. I
> missed out on the conversation, but I agree this is better.
> 
>  drivers/iio/imu/adis.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 319b64b2fd88..f8b7837d8b8f 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -415,12 +415,11 @@ int __adis_initial_startup(struct adis *adis)
>  	int ret;
>  
>  	/* check if the device has rst pin low */
> -	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset", GPIOD_ASIS);
> +	gpio = devm_gpiod_get_optional(&adis->spi->dev, "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(gpio))
>  		return PTR_ERR(gpio);
>  
>  	if (gpio) {
> -		gpiod_set_value_cansleep(gpio, 1);
>  		msleep(10);
>  		/* bring device out of reset */
>  		gpiod_set_value_cansleep(gpio, 0);

