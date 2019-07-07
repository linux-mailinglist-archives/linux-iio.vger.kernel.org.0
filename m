Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE6614DC
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2019 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfGGMBR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jul 2019 08:01:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51502 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfGGMBQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jul 2019 08:01:16 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BDA113A14536DBF70C58;
        Sun,  7 Jul 2019 20:01:13 +0800 (CST)
Received: from localhost (10.45.56.64) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Sun, 7 Jul 2019
 20:01:09 +0800
Date:   Sun, 7 Jul 2019 13:01:06 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     <linux-iio@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: fix
 iio_triggered_buffer_predisable() position
Message-ID: <20190707130106.00001740@huawei.com>
In-Reply-To: <20190705134355.19493-1-alexandru.ardelean@analog.com>
References: <20190705134355.19493-1-alexandru.ardelean@analog.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.56.64]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+CC Matt as it's his driver.  His latest email is in .mailmap.

Jonathan


On Fri, 5 Jul 2019 16:43:55 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> the poll functions.
> 
> The iio_triggered_buffer_predisable() should be called last, to detach the
> poll func after the devices has been suspended.
> 
> The position of iio_triggered_buffer_postenable() is correct.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/chemical/atlas-ph-sensor.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index 3a20cb5d9bff..6c175eb1c7a7 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -323,16 +323,16 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
>  	struct atlas_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> +	ret = atlas_set_interrupt(data, false);
>  	if (ret)
>  		return ret;
>  
> -	ret = atlas_set_interrupt(data, false);
> +	pm_runtime_mark_last_busy(&data->client->dev);
> +	ret = pm_runtime_put_autosuspend(&data->client->dev);
>  	if (ret)
>  		return ret;
>  
> -	pm_runtime_mark_last_busy(&data->client->dev);
> -	return pm_runtime_put_autosuspend(&data->client->dev);
> +	return iio_triggered_buffer_predisable(indio_dev);
>  }
>  
>  static const struct iio_trigger_ops atlas_interrupt_trigger_ops = {


