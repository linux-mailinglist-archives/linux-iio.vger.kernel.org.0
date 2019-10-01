Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 032F7C317B
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2019 12:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbfJAKcZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 06:32:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38792 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbfJAKcZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2019 06:32:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6FC6028E304
Subject: Re: [PATCH 05/13] platform: chrome: cros_ec: Do not attempt to
 register a non-positive IRQ number
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Enrico Granata <egranata@chromium.org>,
        Enrico Granata <egranata@google.com>
References: <20190922175021.53449-1-gwendal@chromium.org>
 <20190922175021.53449-6-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <884a673d-e9d0-e83a-24e2-7d4d662fd95e@collabora.com>
Date:   Tue, 1 Oct 2019 12:32:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190922175021.53449-6-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal and Enrico

On 22/9/19 19:50, Gwendal Grignou wrote:
> From: Enrico Granata <egranata@chromium.org>
> 
> Add a layer of sanity checking to cros_ec_register against attempting to
> register IRQ values that are not strictly greater than 0.
> 
> Signed-off-by: Enrico Granata <egranata@google.com>

I'll get rid of this signed-off as is the same as following

> Signed-off-by: Enrico Granata <egranata@chromium.org>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

For my own reference:

Reviewed-for-chrome-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/platform/chrome/cros_ec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index f49eb1d1e3cd..9c8dc7cdb2b7 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -146,7 +146,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  		return err;
>  	}
>  
> -	if (ec_dev->irq) {
> +	if (ec_dev->irq > 0) {
>  		err = devm_request_threaded_irq(
>  				dev, ec_dev->irq, ec_irq_handler,
>  				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> 
