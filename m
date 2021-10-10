Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589DD42806F
	for <lists+linux-iio@lfdr.de>; Sun, 10 Oct 2021 12:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhJJKXv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Oct 2021 06:23:51 -0400
Received: from www381.your-server.de ([78.46.137.84]:33124 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhJJKXu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Oct 2021 06:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=c46M9ZL4PHoGNLaSjDTPmoqEixflkJdQTjuXl7mlxts=; b=NdYv0K/aMeVYKrxzSSA1vU9q8h
        EuuOtDYr7Pb19hoo9Wh7KOb46hG/bqQL66SdBNWJBkDaaRptisfD5Yr+yoNxiEK6XxEE8szPf0VCD
        vFSVt16n4Jmkft4R6A2oXzimNAd11E4qCtuHfg3x9I2KY4XCthawPdRAYfLAPIzm11S0Vfaanf/UG
        KPe1EpvkLXzzH4Htx0N91C2XE4EqIUU8DBBi+E8gF9qVe1hnEY2hvLU1PnSbFiPCLxztANcmjNBaX
        Q6MiGe8wF3HCYEjDj917rX91fKaw3sKw0b85fvEAlW5ShEJWp6xxfqi6QFpn3OfwKoV5z8QiUoUsy
        xUyePzIg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mZVfn-0004Gm-Hh; Sun, 10 Oct 2021 12:03:15 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mZVfn-000StH-A7; Sun, 10 Oct 2021 12:03:15 +0200
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix an array overflow in
 st_lsm6dsx_set_odr()
To:     Teng Qi <starmiku1207184332@gmail.com>,
        lorenzo.bianconi83@gmail.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        islituo@gmail.com, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
References: <20211010091230.895549-1-starmiku1207184332@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <8efeaffd-ae9a-d0ef-0222-6c94c0e31e7e@metafoo.de>
Date:   Sun, 10 Oct 2021 12:03:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211010091230.895549-1-starmiku1207184332@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26318/Sun Oct 10 10:18:47 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/10/21 11:12 AM, Teng Qi wrote:
> The length of hw->settings->odr_table is 2 and ref_sensor->id is an enum
> variable whose value is between 0 and 5.
> However, the value ST_LSM6DSX_ID_MAX (i.e. 5) is not catched properly in
>   switch (sensor->id) {
>
> If ref_sensor->id is ST_LSM6DSX_ID_MAX, an array overflow will ocurrs in
> function st_lsm6dsx_check_odr():
>    odr_table = &sensor->hw->settings->odr_table[sensor->id];
>
> and in function st_lsm6dsx_set_odr():
>    reg = &hw->settings->odr_table[ref_sensor->id].reg;
>
> To fix this possible array overflow, ref_sensor->id should be checked
> first. If it is greater than or equal to 2, the function
> st_lsm6dsx_set_odr() returns -EINVAL.
>
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Teng Qi <starmiku1207184332@gmail.com>

Hi,

Thanks for the patch, good catch. But there are a few things to improve 
here, the goal should not be to silence the output of your checker, but 
to write good code.

Let's start with ST_LSM6DSX_ID_MAX. As the name suggests this is an 
entry at the end of the enum that is used to get the size of the enum. 
But its value itself is never assigned to any variable of that type. 
This is a very common pattern. So strictly speaking there is no bug, 
since the out-of-range value of ST_LSM6DSX_ID_MAX is never used.

The other thing is that we usually don't want to hardcode range checks 
for array sizes with integer literals, but rather use ARRAY_SIZE() 
instead. This makes sure that the code stays correct when the array size 
changes.

If you really wanted to modify the code sot that your code checker does 
not detect a false positive I'd modify the switch statement to 
explicitly handle ST_LSM6DSX_ID_GYRO and ST_LSM6DSX_ID_ACCEL and the 
return an error for the default case with a comment that default case 
should never occur.

- Lars

> ---
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index db45f1fc0b81..edf5d33dd256 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1308,6 +1308,10 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
>   		break;
>   	}
>   
> +	if (ref_sensor->id >= 2) {
> +		return -EINVAL;
> +	}
> +
>   	if (req_odr > 0) {
>   		err = st_lsm6dsx_check_odr(ref_sensor, req_odr, &val);
>   		if (err < 0)


