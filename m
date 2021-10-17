Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4885C43080E
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 12:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbhJQKnW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 06:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245345AbhJQKnV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 06:43:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50CD460D42;
        Sun, 17 Oct 2021 10:41:10 +0000 (UTC)
Date:   Sun, 17 Oct 2021 11:45:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Pekka Korpinen <pekka.korpinen@iki.fi>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] iio: dac: ad5446: Fix ad5622_write() return
 value
Message-ID: <20211017114524.3c1da153@jic23-huawei>
In-Reply-To: <20211014173738.2446-1-pekka.korpinen@iki.fi>
References: <20211014173738.2446-1-pekka.korpinen@iki.fi>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Oct 2021 20:37:38 +0300
Pekka Korpinen <pekka.korpinen@iki.fi> wrote:

> On success i2c_master_send() returns the number of bytes written. The
> call from iio_write_channel_info(), however, expects the return value to
> be zero on success.
> 
> This bug causes incorrect consumption of the sysfs buffer in
> iio_write_channel_info(). When writing more than two characters to
> out_voltage0_raw, the ad5446 write handler is called multiple times
> causing unexpected behavior.
> 
> Fixes: 3ec36a2cf0d5 ("iio:ad5446: Add support for I2C based DACs")
> Signed-off-by: Pekka Korpinen <pekka.korpinen@iki.fi>

Hi Pekka,

No need to resend a patch so soon.  Feel free to just sent a 'bump'
type message in reply to the original posting.

Anyhow, I've picked that up today anyway (and only noticed this whilst
marking it applied in patchwork).

Thanks,

Jonathan

> ---
> v1->v2: Check against expected result, otherwise -EIO. Add Fixes tag.
> 
> A similar bug was fixed for ad5064.c in 2015 - commit 03fe472ef33b
> ("iio:ad5064: Make sure ad5064_i2c_write() returns 0 on success").
> 
>  drivers/iio/dac/ad5446.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index 488ec69967d6..e50718422411 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -531,8 +531,15 @@ static int ad5622_write(struct ad5446_state *st, unsigned val)
>  {
>  	struct i2c_client *client = to_i2c_client(st->dev);
>  	__be16 data = cpu_to_be16(val);
> +	int ret;
> +
> +	ret = i2c_master_send(client, (char *)&data, sizeof(data));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(data))
> +		return -EIO;
>  
> -	return i2c_master_send(client, (char *)&data, sizeof(data));
> +	return 0;
>  }
>  
>  /*

