Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075C62B0B44
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 18:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgKLR2b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 12 Nov 2020 12:28:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2097 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgKLR2a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 12:28:30 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CX7nR1kD3z67J8Z;
        Fri, 13 Nov 2020 01:26:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 12 Nov 2020 18:28:29 +0100
Received: from localhost (10.52.124.211) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 12 Nov
 2020 17:28:28 +0000
Date:   Thu, 12 Nov 2020 17:28:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
CC:     <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: buffer: Fix demux update
Message-ID: <20201112172821.0000088b@Huawei.com>
In-Reply-To: <20201112144323.28887-1-nuno.sa@analog.com>
References: <20201112144323.28887-1-nuno.sa@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.124.211]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Nov 2020 15:43:22 +0100
Nuno Sá <nuno.sa@analog.com> wrote:

> When updating the buffer demux, we will skip a scan element from the
> device in the case `in_ind != out_ind` and we enter the while loop.
> in_ind should only be refreshed with `find_next_bit()` in the end of the
> loop.
> 
> Fixes: 5ada4ea9be16 ("staging:iio: add demux optionally to path from device to buffer")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Yikes that's been there a long time.

Could you provide an example of a particular layout and the result of this being wrong?

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index a4f6bb96d4f4..276b609d7917 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -865,12 +865,12 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
>  				       indio_dev->masklength,
>  				       in_ind + 1);
>  		while (in_ind != out_ind) {
> -			in_ind = find_next_bit(indio_dev->active_scan_mask,
> -					       indio_dev->masklength,
> -					       in_ind + 1);
>  			length = iio_storage_bytes_for_si(indio_dev, in_ind);
>  			/* Make sure we are aligned */
>  			in_loc = roundup(in_loc, length) + length;
> +			in_ind = find_next_bit(indio_dev->active_scan_mask,
> +					       indio_dev->masklength,
> +					       in_ind + 1);
>  		}
>  		length = iio_storage_bytes_for_si(indio_dev, in_ind);
>  		out_loc = roundup(out_loc, length);

