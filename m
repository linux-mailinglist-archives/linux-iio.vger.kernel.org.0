Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE32DA0D1
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 20:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbgLNTta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 14:49:30 -0500
Received: from www381.your-server.de ([78.46.137.84]:35884 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731027AbgLNTta (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 14:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Bf8Eaym1lTrfVVM9GiFw+RR2ujpDFDc7mSnjArhEs8g=; b=HJwBGq/iDgTHnJMC6HXczq7OEl
        f6NBoQr6LgFusviTbjtu72Nxk3DeT34H8NYi1crEDBk2vzx06B0oT/sm1Yks5EEN+Iw4b4XOnE9Of
        aADDUAvm3HxXyQsYGKfHPRf3/67j3nEc9vLWksc5yOyEWZK5uUn87gn5NBYLipPF68+dSYId2CXo1
        fXsmr5qsI8cxS8LyX9D6v28RH3GQhDrGXk3nUVYDOsvglyjf/BByVRAuCVIrWbPRVEs/md3jaVreP
        yT2uFGTezuI/EE4GWO1ZgJLxNFRPYrp12eUodMTMe9D5+koZxt3xhnmWItkd57GoKgncz4BlddwIo
        wmyW3tSQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kotpt-0005eH-CH; Mon, 14 Dec 2020 20:48:45 +0100
Received: from [62.216.202.54] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kotpt-000CnI-71; Mon, 14 Dec 2020 20:48:45 +0100
Subject: Re: [PATCH v2 1/1] drivers: iio: temperature: Add delay after the
 addressed reset command in mlx90632.c
To:     Slaveyko Slaveykov <sis@melexis.com>, Jonathan.Cameron@huawei.com,
        cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, andy.shevchenko@gmail.com
References: <20201214193711.12592-1-sis@melexis.com>
 <20201214193711.12592-2-sis@melexis.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <07dd0bef-263a-3fe9-7634-8b25913ff950@metafoo.de>
Date:   Mon, 14 Dec 2020 20:48:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201214193711.12592-2-sis@melexis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26017/Mon Dec 14 15:33:39 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/14/20 8:37 PM, Slaveyko Slaveykov wrote:
> After an I2C reset command, the mlx90632 needs some time before
> responding to other I2C commands. Without that delay, there is a chance
> that the I2C command(s) after the reset will not be accepted
>
> Signed-off-by: Slaveyko Slaveykov <sis@melexis.com>
> ---
>   drivers/iio/temperature/mlx90632.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 503fe54a0bb9..f0eaadec11eb 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -247,6 +247,8 @@ static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
>   	ret = regmap_write(regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
>   	if (ret < 0)
>   		return ret;
> +	usleep(150, 200);	//give the mlx90632 some time to reset properly before sending a new I2C command
> +										//if this is not done, the following I2C command(s) will not be accepted

Did you mean usleep_range()?

Also consider reformatting this by putting the comment before the 
instruction, I think that will make it easier to follow. The way it is 
right now it will not pass scripts/checkpatch.pl.

