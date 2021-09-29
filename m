Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA5041C22B
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 12:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245254AbhI2KBs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 06:01:48 -0400
Received: from www381.your-server.de ([78.46.137.84]:52692 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245245AbhI2KBs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Sep 2021 06:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=1WjBcHbtUHWwynb8HCYwJabWRtgbg4lrsK8hlGVcLMI=; b=f1evM4TI1bcX9clqH5czWYaIgd
        k3LQLnxdvJqhmvWCfCXt/ioxAOA67GoC/wZe4uYWHgV7J2qIm8uvGa3mD3wiafscpj9losoih54I3
        LA1qT6bOilB5TFWLsAhFwG5UOt6IOK/ngiwVUCD3qovwoJhBNhiTUZvVsgRWrQDisBWBD1fW9UAMi
        VfNLNgnnVJ0fTyJyOkaC9Q+J0pESTGkMpYM+Kx354SulHYCnHhT3odFfDPfs0GxYkNy5fgVe0FBYh
        tiyna+k21z9SGlIkpexEn31zzoF4e8zv7Ht25jIX7B3mnJv7zbrS5KvWAuIEQOc5NToBf/TeQ1ulh
        b/2RDeiw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mVWNc-0001Nh-Ev; Wed, 29 Sep 2021 12:00:00 +0200
Received: from [82.135.83.152] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mVWNc-000Rpa-55; Wed, 29 Sep 2021 12:00:00 +0200
Subject: Re: [PATCH] iio: dac: ad5446: Fix ad5622_write() return value
To:     Pekka Korpinen <pekka.korpinen@iki.fi>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210928195548.17846-1-pekka.korpinen@iki.fi>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <20d11fbb-ba93-802c-1abc-60d7f5ec0c0c@metafoo.de>
Date:   Wed, 29 Sep 2021 11:59:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928195548.17846-1-pekka.korpinen@iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26306/Tue Sep 28 11:05:37 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/28/21 9:55 PM, Pekka Korpinen wrote:
> On success i2c_master_send() returns the number of bytes written. The
> call from iio_write_channel_info(), however, expects the return value to
> be zero on success.
>
> Signed-off-by: Pekka Korpinen <pekka.korpinen@iki.fi>
> ---
> This bug causes incorrect consumption of the sysfs buffer in
> iio_write_channel_info(). When writing more than two characters to
> out_voltage0_raw, the ad5446 write handler is called multiple times
> causing unexpected behavior.

I'd put this into the commit message itself. This is useful information 
that should be part of the commit log.

>
> A similar fix was applied for ad5064.c in 2015 - commit 03fe472ef33b
> ("iio:ad5064: Make sure ad5064_i2c_write() returns 0 on success").
>
>   drivers/iio/dac/ad5446.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index 488ec69967d6..dfd541bbde5b 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -531,8 +531,13 @@ static int ad5622_write(struct ad5446_state *st, unsigned val)
>   {
>   	struct i2c_client *client = to_i2c_client(st->dev);
>   	__be16 data = cpu_to_be16(val);
> +	int ret;
> +
> +	ret = i2c_master_send(client, (char *)&data, sizeof(data));
> +	if (ret < 0)
> +		return ret;
Like you wrote in the commit message the function returns the number of 
bytes written. We should check that this matches the number of bytes we 
wanted to send and return an error (EIO) otherwise.
>   
> -	return i2c_master_send(client, (char *)&data, sizeof(data));
> +	return 0;
>   }
>   
>   /*


