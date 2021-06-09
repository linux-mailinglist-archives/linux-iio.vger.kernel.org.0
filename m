Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6A3A198C
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbhFIPbg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 11:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235379AbhFIPbf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 11:31:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D19F560E0B;
        Wed,  9 Jun 2021 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623252581;
        bh=BsamdNAI8z2Eq8d5wyZPH4t38jutckXryySGyH6Lpxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgW1+hn1XcB+m17u3lSE4bkT8/1SSxb5tLln5SN1fp2ZtJk8dqvS2K4zYcKsWh4iT
         WfouVQ/uoghAPeqAoeowUjY48HebO0JQAoFUc1z16ZhBsIJO4Jh4HI0832as9HSpZo
         /uOOkvEgt4EEx0nlezYfFkOv0mq82lWTOvt9V/KCjZESGnB7WVVKICyq70Dvef9wFz
         PLr+lW4AWF3wTQe774qvsr6Zp99MjHKbPVQ+NiHDIGQMkuMidDOAv63MP7I1X1CI5+
         iiOSPQCCK0uDqV2ouqKLnGtU0wIh8q9IIeTRVX2PbyRn0/oauNvBh+vEy+T0bl1zIb
         N6GNfCoRqGMIg==
Date:   Wed, 9 Jun 2021 08:29:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 4/4] iio: light: si1145: Drop use of %hhx format
 specifier.
Message-ID: <YMDeZMzNoxl1vGjf@Ryzen-9-3900X>
References: <20210603180612.3635250-1-jic23@kernel.org>
 <20210603180612.3635250-5-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603180612.3635250-5-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 03, 2021 at 07:06:12PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Since:
> commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
> unnecessary %h[xudi] and %hh[xudi]")
> use of these format strings has been discouraged.
> 
> As there are only a few such instances in IIO, this is part of a
> series clearing them out so they don't get copied into new drivers.
> 
> Use the 0x02x form as the length specifier when used with # includes
> the 0x prefix and is very unlikely to be what was intended by the author.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/iio/light/si1145.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> index 3fb52402fcc3..e2abad48b9f4 100644
> --- a/drivers/iio/light/si1145.c
> +++ b/drivers/iio/light/si1145.c
> @@ -271,7 +271,7 @@ static int si1145_command(struct si1145_data *data, u8 cmd)
>  		if ((ret & ~SI1145_RSP_COUNTER_MASK) == 0) {
>  			if (ret == data->rsp_seq) {
>  				if (time_after(jiffies, stop_jiffies)) {
> -					dev_warn(dev, "timeout on command %#02hhx\n",
> +					dev_warn(dev, "timeout on command 0x%02x\n",
>  						 cmd);
>  					ret = -ETIMEDOUT;
>  					break;
> @@ -291,12 +291,12 @@ static int si1145_command(struct si1145_data *data, u8 cmd)
>  			ret = -EIO;
>  		} else {
>  			if (ret == SI1145_RSP_INVALID_SETTING) {
> -				dev_warn(dev, "INVALID_SETTING error on command %#02hhx\n",
> +				dev_warn(dev, "INVALID_SETTING error on command 0x%02x\n",
>  					 cmd);
>  				ret = -EINVAL;
>  			} else {
>  				/* All overflows are treated identically */
> -				dev_dbg(dev, "overflow, ret=%d, cmd=%#02hhx\n",
> +				dev_dbg(dev, "overflow, ret=%d, cmd=0x%02x\n",
>  					ret, cmd);
>  				ret = -EOVERFLOW;
>  			}
> @@ -1299,10 +1299,10 @@ static int si1145_probe(struct i2c_client *client,
>  						SI1145_REG_SEQ_ID);
>  	if (ret < 0)
>  		return ret;
> -	dev_info(&client->dev, "device ID part %#02hhx rev %#02hhx seq %#02hhx\n",
> +	dev_info(&client->dev, "device ID part 0x%02x rev 0x%02x seq 0x%02x\n",
>  			part_id, rev_id, seq_id);
>  	if (part_id != data->part_info->part) {
> -		dev_err(&client->dev, "part ID mismatch got %#02hhx, expected %#02x\n",
> +		dev_err(&client->dev, "part ID mismatch got 0x%02x, expected 0x%02x\n",
>  				part_id, data->part_info->part);
>  		return -ENODEV;
>  	}
> -- 
> 2.31.1
