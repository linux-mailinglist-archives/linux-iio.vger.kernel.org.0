Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215EAE018F
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 12:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfJVKFm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 06:05:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46928 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKFm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Oct 2019 06:05:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A4C7B28D5A5
Subject: Re: [PATCH v2 06/18] platform: chrome: cros_ec: Do not attempt to
 register a non-positive IRQ number
To:     Gwendal Grignou <gwendal@chromium.org>, briannorris@chromium.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Enrico Granata <egranata@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
 <20191021055403.67849-7-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <83d75a50-71a0-9dd9-e56b-5e7ec3ec5d96@collabora.com>
Date:   Tue, 22 Oct 2019 12:05:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021055403.67849-7-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 21/10/19 7:53, Gwendal Grignou wrote:
> From: Enrico Granata <egranata@chromium.org>
> 
> Add a layer of sanity checking to cros_ec_register against attempting to
> register IRQ values that are not strictly greater than 0.
> 
> Signed-off-by: Enrico Granata <egranata@chromium.org>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Enrico, Gwendal, this can be applied alone without waiting for the others, right?

For my own reference:

Acked-for-chrome-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> ---
> Changes in v2:
>   Remove dual Enrico's signature.
> 
>  drivers/platform/chrome/cros_ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 739f3cffe26e3..9b19f50572313 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -149,7 +149,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  		return err;
>  	}
>  
> -	if (ec_dev->irq) {
> +	if (ec_dev->irq > 0) {
>  		err = devm_request_threaded_irq(
>  				dev, ec_dev->irq, ec_irq_handler,
>  				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> 
