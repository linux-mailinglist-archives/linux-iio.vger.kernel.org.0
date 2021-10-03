Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BF4420331
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 20:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhJCSFE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 14:05:04 -0400
Received: from www381.your-server.de ([78.46.137.84]:42492 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhJCSFE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Oct 2021 14:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=AV6fLLE+vPxaRZGKMzPBHqaI1Z47gYzc4PWZ9pMnjd4=; b=CzcsebtSpI2wHE5F6wgdWKFznh
        OBpHPEwVuNgt0DNe1Akx5aejSygoi/tozAMMUoa6fotzUMOUygZpg6x4s48Op+dKz3GzBuEA+mXMp
        Xg2g3Uw7Nm0QWMy0apE5mN6iYqZh6FFT8dWdg2uSiF3rdJqlZ2WwPoPWgEWY6iaXAZiAhJkRSueg8
        +hDbmQHYTkS27RfipXBTUpEwYVULX23FQRCDUpm4S+ILzFZY06fZw6aJhhsBMpygGipzsUSka0sLw
        3qMZfDPftd+zzv5qKv1COWIc+yy5IdzndFwP0F848jdaHfOD8O8eelX5SdKNoJVcJGZ2E2EBFhAYj
        VKSqNNAA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mX5pQ-0008hJ-RW; Sun, 03 Oct 2021 20:03:12 +0200
Received: from [82.135.83.152] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mX5pQ-000FP3-NV; Sun, 03 Oct 2021 20:03:12 +0200
Subject: Re: [PATCH] iio: accel: sca3000: Use sign_extend32() instead of
 opencoding sign extension.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210603164729.3584702-1-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <30fd2ee6-8182-8576-80ff-1cebab55a0dc@metafoo.de>
Date:   Sun, 3 Oct 2021 20:03:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210603164729.3584702-1-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26311/Sun Oct  3 11:08:49 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/3/21 6:47 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Whilst nice to get rid of this non obvious code, this also clears a
> static checker warning:
>
> drivers/iio/accel/sca3000.c:734 sca3000_read_raw()
> warn: no-op. '((*val) << 19) >> 19'
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/iio/accel/sca3000.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index cb753a43533c..0692ccb80293 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -731,8 +731,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
>   				return ret;
>   			}
>   			*val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
> -			*val = ((*val) << (sizeof(*val) * 8 - 13)) >>
> -				(sizeof(*val) * 8 - 13);
> +			*val = sign_extend32(*val, 13);
Should be 12 I think. The index is 0 based.
>   		} else {
>   			/* get the temperature when available */
>   			ret = sca3000_read_data_short(st,


