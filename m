Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF298383AE5
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 19:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242226AbhEQROQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 13:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236050AbhEQROO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 May 2021 13:14:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86DE861261;
        Mon, 17 May 2021 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621271577;
        bh=yEgSn654BCfnqHSlARIcumr5BUf/k+tIyGOaC4CG9WA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IsDILZUcJr5FjIdylSJHBrIrr2uEzw8vjGZxfEUzfyKfbR7hyiNReDekYpHzYvu6w
         +SY4rZQiGwkX5+DvCWLPj/GJrJtbpoFD69ZtLFj09A+KyCqFqnORzmHodULW3Xk0i6
         iKtdTFVrETdC8xns94WyJRwpFz9Te0VNyq+YGln/WpkvLq5w3GRpl8NGSqigVIctI9
         fC65duq04w9VZku+hWCsfQTM8Rr7NV+uAryN4tMAgA32qvc0RYP0crMoeyvnHr/V8u
         WFewIoJR31VUqGpCnMafRBc+gLR15F92yie3bohKAS0YABNAF5//ZuXmnIzlg9S9fA
         1D1KGLY2lLvBw==
Subject: Re: [PATCH 3/4] iio: light: si1145: Drop use of %hhx format
 specifier.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20210517125554.1463156-1-jic23@kernel.org>
 <20210517125554.1463156-4-jic23@kernel.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <9afce0cc-eadf-6668-cca1-2e5692d8fbc0@kernel.org>
Date:   Mon, 17 May 2021 10:12:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517125554.1463156-4-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/17/2021 5:55 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Since:
> commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
> unnecessary %h[xudi] and %hh[xudi]")
> use of these format strings has been discouraged.  As there are only
> a few such instances in IIO, this is part of a series clearing them
> out so they don't get copied into new drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   drivers/iio/light/si1145.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> index 3fb52402fcc3..a3c41ce9c156 100644
> --- a/drivers/iio/light/si1145.c
> +++ b/drivers/iio/light/si1145.c
> @@ -271,7 +271,7 @@ static int si1145_command(struct si1145_data *data, u8 cmd)
>   		if ((ret & ~SI1145_RSP_COUNTER_MASK) == 0) {
>   			if (ret == data->rsp_seq) {
>   				if (time_after(jiffies, stop_jiffies)) {
> -					dev_warn(dev, "timeout on command %#02hhx\n",
> +					dev_warn(dev, "timeout on command %#02x\n",
>   						 cmd);
>   					ret = -ETIMEDOUT;
>   					break;
> @@ -291,12 +291,12 @@ static int si1145_command(struct si1145_data *data, u8 cmd)
>   			ret = -EIO;
>   		} else {
>   			if (ret == SI1145_RSP_INVALID_SETTING) {
> -				dev_warn(dev, "INVALID_SETTING error on command %#02hhx\n",
> +				dev_warn(dev, "INVALID_SETTING error on command %#02x\n",
>   					 cmd);
>   				ret = -EINVAL;
>   			} else {
>   				/* All overflows are treated identically */
> -				dev_dbg(dev, "overflow, ret=%d, cmd=%#02hhx\n",
> +				dev_dbg(dev, "overflow, ret=%d, cmd=%#02x\n",
>   					ret, cmd);
>   				ret = -EOVERFLOW;
>   			}
> @@ -1299,10 +1299,10 @@ static int si1145_probe(struct i2c_client *client,
>   						SI1145_REG_SEQ_ID);
>   	if (ret < 0)
>   		return ret;
> -	dev_info(&client->dev, "device ID part %#02hhx rev %#02hhx seq %#02hhx\n",
> +	dev_info(&client->dev, "device ID part %#02x rev %#02x seq %#02x\n",
>   			part_id, rev_id, seq_id);
>   	if (part_id != data->part_info->part) {
> -		dev_err(&client->dev, "part ID mismatch got %#02hhx, expected %#02x\n",
> +		dev_err(&client->dev, "part ID mismatch got %#02x, expected %#02x\n",
>   				part_id, data->part_info->part);
>   		return -ENODEV;
>   	}
> 

