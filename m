Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C847430801
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 12:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbhJQKl3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 06:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235835AbhJQKl2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 06:41:28 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12CDA60D42;
        Sun, 17 Oct 2021 10:39:16 +0000 (UTC)
Date:   Sun, 17 Oct 2021 11:43:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Pekka Korpinen <pekka.korpinen@iki.fi>
Cc:     ardeleanalex@gmail.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: ad5446: Fix ad5622_write() return value
Message-ID: <20211017114306.6a56a718@jic23-huawei>
In-Reply-To: <20210929185755.2384-1-pekka.korpinen@iki.fi>
References: <20d11fbb-ba93-802c-1abc-60d7f5ec0c0c@metafoo.de>
        <20210929185755.2384-1-pekka.korpinen@iki.fi>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Sep 2021 21:57:55 +0300
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
Applied to the fixes-togreg branch of iio.git and marked for stable.

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

