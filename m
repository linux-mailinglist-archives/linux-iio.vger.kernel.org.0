Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9178835B5D8
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 17:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhDKPLu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Apr 2021 11:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235503AbhDKPLu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Apr 2021 11:11:50 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 509EF611AD;
        Sun, 11 Apr 2021 15:11:30 +0000 (UTC)
Date:   Sun, 11 Apr 2021 16:11:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: pulsedlight: Fix rumtime PM imbalance
 on error
Message-ID: <20210411161116.5f99195d@jic23-huawei>
In-Reply-To: <20210407045938.29129-1-dinghao.liu@zju.edu.cn>
References: <20210407045938.29129-1-dinghao.liu@zju.edu.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  7 Apr 2021 12:59:35 +0800
Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> When lidar_write_control() fails, a pairing PM usage counter
> decrement is needed to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Hi, patch content looks good but it needs a fixes tag so we know how far to backport it.
Please add for v2.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index c685f10b5ae4..cc206bfa09c7 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -160,6 +160,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>  	ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "cannot send start measurement command");
> +		pm_runtime_put_noidle(&client->dev);
>  		return ret;
>  	}
>  

