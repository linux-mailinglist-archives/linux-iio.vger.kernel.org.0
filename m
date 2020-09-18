Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6021B26FEC1
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 15:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRNhL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 09:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgIRNhD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 09:37:03 -0400
X-Greylist: delayed 89 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Sep 2020 06:37:03 PDT
Received: from www381.your-server.de (www381.your-server.de [IPv6:2a01:4f8:d0a:52ac::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DB2C0613CE
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2020 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=B6TUQsrRqJCqKpU4JJiNC9YnPCTRZ+Iw7AYx1RBQycY=; b=L0QyEn2/Ow+gbUD4tEPO1jLVIo
        WPPtxvh2yw3biWURMlpOyStu26LMiERkVam5TdVIkZkaGfs8O9BtTv9PLLSQMmziBVAqMqFyJROhO
        5VAIILn80eL6TTSXUthI1VLJcFYYsahmDc903eqMvt2Vh2qAO/iD7ubObjkyoGOnOngtTwkvYKuNX
        5vHNpOYYlZD2lLJPxlVvsZqZFT3+IzK/FtACuiCj48nS4glFtiw6lTPGfiPGKlcKfVq9T5y8zfDO0
        Kj/A9/FmPc+Khd3kEFjjGqoihxLZH4RlnBPH8pz33SenplQSqw21THpFR3VWWJA5ZwiaFhvlVu+qX
        q0tFC5Hw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kJGZP-0007nd-9i; Fri, 18 Sep 2020 15:36:59 +0200
Received: from [2001:a61:259b:1201:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kJGZP-000N6v-5a; Fri, 18 Sep 2020 15:36:59 +0200
Subject: Re: [PATCH] iio:accel:bma180: Fix use of true when should be
 iio_shared_by enum
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>
References: <20200913121227.764626-1-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9a5b9bf3-28e9-9643-0924-a7b33e339032@metafoo.de>
Date:   Fri, 18 Sep 2020 15:36:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200913121227.764626-1-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25931/Thu Sep 17 15:53:56 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/13/20 2:12 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Given a value of 1 corresponds to IIO_SHARE_BY_TYPE I have replaced
> it with that.  Should cause no functional change.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Jonathan Bakker <xc-racer2@live.ca>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>


> ---
>   drivers/iio/accel/bma180.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 448faed001fd..6b74c2b04c15 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -673,7 +673,7 @@ static const struct iio_chan_spec_ext_info bma023_ext_info[] = {
>   };
>   
>   static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
> -	IIO_ENUM("power_mode", true, &bma180_power_mode_enum),
> +	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE, &bma180_power_mode_enum),
>   	IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
>   	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
>   	{ }


