Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02AA420289
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhJCQC3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 12:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230426AbhJCQC2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Oct 2021 12:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633276839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vNokHA0aOscw6CYIcmFpDMpysV4wVMOoz9cpSVv/BUw=;
        b=coqzeAjP4LyOfUFZaZFpzNMPu36aJIhpfaW2sY6zOx3ArWCZCOudA17G4sVphpyaFw86aT
        cDKxHOqlgPSjbaAjf7xayLeqbsZr2VNRt35U2qWVYqbPA902UIx2MLRkPNPkcznioy5Yzo
        WL1KZwMipPsLnEZuTXrxrTw6F1xFI2k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-jf0y0QmQN9eZQgEsxaijHg-1; Sun, 03 Oct 2021 12:00:38 -0400
X-MC-Unique: jf0y0QmQN9eZQgEsxaijHg-1
Received: by mail-ed1-f71.google.com with SMTP id h8-20020a50cdc8000000b003dad77857f7so4993440edj.22
        for <linux-iio@vger.kernel.org>; Sun, 03 Oct 2021 09:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vNokHA0aOscw6CYIcmFpDMpysV4wVMOoz9cpSVv/BUw=;
        b=WpX1AflcJUvRiHYoYzIPfhiSZHRIH5vxVCHnUVGxq9lU28kVsSTgAwHd6SH0zwxzPw
         keTQera980Q5lZ6Sk9Kf4MvmvgenbYmbwEdzJ/XxVOPEQ2gKYluc6/NcIe8wJdI3DYdJ
         Gg/QwjvFAJ18wx4uZrCXGSzzeNi9O1RCn0kysLTTKejn6Nlb+hm5FVCuWNgCpXnxlM8K
         IKUKOtoEF3aLxu8p4eL5ntE/iLsqxH5IBYItbc/YvAMhhfGJU94D01+iLfXgDx5gYxwq
         m4aeba5D6a8qo8zE9HPcFgzsvXbQK6R6Fyhd1UXlOR2cXXO9bvcNuoac2XM2euBwTLvz
         ejjw==
X-Gm-Message-State: AOAM530ynoDNBz4OkBUhe2vQjHpoukJzCp3IwTbfdyeWnTnm2HIgzDgB
        2Ee5GlAybAx7HhvL5x/DsHHBdeI5D/pPH+CBaSeR2JUPjP+Bz2jVqGwTlo0/f9SJ53EiPN6JhXa
        lhGKTwkAcVeFt/9tgq/QA
X-Received: by 2002:a50:bf02:: with SMTP id f2mr12001460edk.226.1633276837507;
        Sun, 03 Oct 2021 09:00:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl8XlPkmMRTTtTohi0dtAHN4zOLETSbUrAAnvIlwvR55wIonZDElNZdcm2Hmwuw34Mcf6FgQ==
X-Received: by 2002:a50:bf02:: with SMTP id f2mr12001423edk.226.1633276837255;
        Sun, 03 Oct 2021 09:00:37 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id d22sm5571292ejj.47.2021.10.03.09.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 09:00:36 -0700 (PDT)
Subject: Re: [RESEND v2 1/5] iio: accel: mma9551/mma9553: Drop explicit ACPI
 match support
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20211003160212.417909-1-jic23@kernel.org>
 <20211003160212.417909-2-jic23@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <931c1396-0822-f5de-b1ea-ebe43362bf37@redhat.com>
Date:   Sun, 3 Oct 2021 18:00:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211003160212.417909-2-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 10/3/21 6:02 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The IDs look highly suspicious as they are just the part numbers in
> capitals, so lets drop these if no one screams.
> 
> Note:
> - MMA is registered PNP ID for Micromedia AG (not a part of Freescale)
> - Googling doesn't show any results for such ACPI _HID to be present
>   in the wild
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>

I'm not aware of any boards actually using these ACPI ids, so:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/iio/accel/mma9551.c | 21 ---------------------
>  drivers/iio/accel/mma9553.c | 21 ---------------------
>  2 files changed, 42 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index 4c359fb05480..2b74f67536a3 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -435,17 +435,6 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static const char *mma9551_match_acpi_device(struct device *dev)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (!id)
> -		return NULL;
> -
> -	return dev_name(dev);
> -}
> -
>  static int mma9551_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -464,8 +453,6 @@ static int mma9551_probe(struct i2c_client *client,
>  
>  	if (id)
>  		name = id->name;
> -	else if (ACPI_HANDLE(&client->dev))
> -		name = mma9551_match_acpi_device(&client->dev);
>  
>  	ret = mma9551_init(data);
>  	if (ret < 0)
> @@ -591,13 +578,6 @@ static const struct dev_pm_ops mma9551_pm_ops = {
>  			   mma9551_runtime_resume, NULL)
>  };
>  
> -static const struct acpi_device_id mma9551_acpi_match[] = {
> -	{"MMA9551", 0},
> -	{},
> -};
> -
> -MODULE_DEVICE_TABLE(acpi, mma9551_acpi_match);
> -
>  static const struct i2c_device_id mma9551_id[] = {
>  	{"mma9551", 0},
>  	{}
> @@ -608,7 +588,6 @@ MODULE_DEVICE_TABLE(i2c, mma9551_id);
>  static struct i2c_driver mma9551_driver = {
>  	.driver = {
>  		   .name = MMA9551_DRV_NAME,
> -		   .acpi_match_table = ACPI_PTR(mma9551_acpi_match),
>  		   .pm = &mma9551_pm_ops,
>  		   },
>  	.probe = mma9551_probe,
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index ba3ecb3b57dc..32c9a79ebfec 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -1062,17 +1062,6 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -static const char *mma9553_match_acpi_device(struct device *dev)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (!id)
> -		return NULL;
> -
> -	return dev_name(dev);
> -}
> -
>  static int mma9553_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -1091,8 +1080,6 @@ static int mma9553_probe(struct i2c_client *client,
>  
>  	if (id)
>  		name = id->name;
> -	else if (ACPI_HANDLE(&client->dev))
> -		name = mma9553_match_acpi_device(&client->dev);
>  	else
>  		return -ENOSYS;
>  
> @@ -1230,13 +1217,6 @@ static const struct dev_pm_ops mma9553_pm_ops = {
>  			   mma9553_runtime_resume, NULL)
>  };
>  
> -static const struct acpi_device_id mma9553_acpi_match[] = {
> -	{"MMA9553", 0},
> -	{},
> -};
> -
> -MODULE_DEVICE_TABLE(acpi, mma9553_acpi_match);
> -
>  static const struct i2c_device_id mma9553_id[] = {
>  	{"mma9553", 0},
>  	{},
> @@ -1247,7 +1227,6 @@ MODULE_DEVICE_TABLE(i2c, mma9553_id);
>  static struct i2c_driver mma9553_driver = {
>  	.driver = {
>  		   .name = MMA9553_DRV_NAME,
> -		   .acpi_match_table = ACPI_PTR(mma9553_acpi_match),
>  		   .pm = &mma9553_pm_ops,
>  		   },
>  	.probe = mma9553_probe,
> 

