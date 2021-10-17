Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9383F430B25
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 19:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344374AbhJQRTn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 13:19:43 -0400
Received: from www381.your-server.de ([78.46.137.84]:38046 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344366AbhJQRTl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Oct 2021 13:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=QBENmn8DWKF/mfK74+vyzNo90m6r1VsVFZ9Mto1R0KI=; b=l8Zu8RB24+vEP3bgA3eSbiG9hh
        f6kPoPi1rZZ4L/4wbM8+ldImYSDtIckC4t0eisQe4z3f3y6r1rsCmIeTKXHzjcKwdtpXAY/Xf40E2
        OY0hKC11YK/OCx69c+6yeqdEhzKRGgVJH2SFdwfGep+voW6jpse0cArwq4X73XyfOaaDe2q0j3ftB
        AV6h/zSHHeiwUOXN3iobYqpUufBgGuwhViiZVCNDT2Uk7VuFBCPOfHGZAY9w/EXA8JaUXpJgYMt9N
        6kkSxft1memtUXT3xzY47SfqUxgp2EdpGOEhPHuPaHdR5rcmjGIUskGuCIW77NI+gtgGWyHfx+RF7
        +k6aN9jA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mc9mp-0006tp-9J; Sun, 17 Oct 2021 19:17:27 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mc9mp-000Jj5-3l; Sun, 17 Oct 2021 19:17:27 +0200
Subject: Re: [PATCH v2] iio: accel: sca3000: Use sign_extend32() instead of
 opencoding sign extension.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20211017160303.72441-1-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2c475dda-829f-3d7d-da0f-91a4aee1bee8@metafoo.de>
Date:   Sun, 17 Oct 2021 19:17:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211017160303.72441-1-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26325/Sun Oct 17 10:17:54 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/17/21 6:03 PM, Jonathan Cameron wrote:
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

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de

> ---
> v2:
> Use the right sign bit (thanks Lars!)
> Should be bit 12 for a 13 bit value.
>
>   drivers/iio/accel/sca3000.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index cb753a43533c..c6b75308148a 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -731,8 +731,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
>   				return ret;
>   			}
>   			*val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
> -			*val = ((*val) << (sizeof(*val) * 8 - 13)) >>
> -				(sizeof(*val) * 8 - 13);
> +			*val = sign_extend32(*val, 12);
>   		} else {
>   			/* get the temperature when available */
>   			ret = sca3000_read_data_short(st,


