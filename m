Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FAFF68E6
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 13:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfKJMR6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 07:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfKJMR6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 07:17:58 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02CFF2080F;
        Sun, 10 Nov 2019 12:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573388277;
        bh=rCC8uEJIQJxJnqP/dZzpYXpADRBvhBPUGrzMfUvqyqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dbwMHEq7DT44fxjkfQCbUz6hZ8wz1JJfGFMHaeiRpWRx8VZPf375ZAwjUx+Au+eIs
         +yjfEZa5ih9QXYSb9tlhQQpL4fy/rsja5NUdjvqzxc7euuKfM789sn6X3/DX+y2L2J
         tKyWUYDb+CGyeYhexWXl0i+iRjzs3+YXP/p4+tsw=
Date:   Sun, 10 Nov 2019 12:17:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Enrico Granata <egranata@chromium.org>
Subject: Re: [PATCH v4 05/17] platform: chrome: cros_ec: Do not attempt to
 register a non-positive IRQ number
Message-ID: <20191110121750.78f0824f@archlinux>
In-Reply-To: <20191105222652.70226-6-gwendal@chromium.org>
References: <20191105222652.70226-1-gwendal@chromium.org>
        <20191105222652.70226-6-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Nov 2019 14:26:40 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add a layer of sanity checking to cros_ec_register against attempting to
> register IRQ values that are not strictly greater than 0.
> 
> Signed-off-by: Enrico Granata <egranata@chromium.org>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

This strikes me as something that could be a potential fix to backport?
Any known cases of a negative irq getting to here or is this a by
inspection thing?

Otherwise seems obviously correct.
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan

> ---
> No changes in v4, v3.
> Changes in v2:
>   Remove dual Enrico's signature.
> 
>  drivers/platform/chrome/cros_ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 925f84dbf621..d3dfa27171e6 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -149,7 +149,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  		return err;
>  	}
>  
> -	if (ec_dev->irq) {
> +	if (ec_dev->irq > 0) {
>  		err = devm_request_threaded_irq(dev, ec_dev->irq,
>  						ec_irq_handler,
>  						ec_irq_thread,

