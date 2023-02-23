Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537A96A040A
	for <lists+linux-iio@lfdr.de>; Thu, 23 Feb 2023 09:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjBWImY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Feb 2023 03:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjBWImT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Feb 2023 03:42:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1420832CDF
        for <linux-iio@vger.kernel.org>; Thu, 23 Feb 2023 00:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677141694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SmdTtDQ2mjq0WzUoKIpi/WB/3RUaciUEZ6ilHbrlMPI=;
        b=Ly0O7a7JSw0Tt7log+KORNSfwVJVohZb4sF8cPYwZ92MP0+b1B9a5sa9+2gdQEzDLTGvG7
        P0rkYphXqlZdcjGRvjXelSEoprX7LzPX9Nzyi3LRveFq8V4THa379Jl0X6qfKLkZpOs+hG
        yAqK4PzQPFRB/9foRfbCBPfeE8IiK6Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-408-XUF7ZzoDNNShtODt4WW-7A-1; Thu, 23 Feb 2023 03:41:32 -0500
X-MC-Unique: XUF7ZzoDNNShtODt4WW-7A-1
Received: by mail-ed1-f71.google.com with SMTP id co14-20020a0564020c0e00b004aab4319cedso13374780edb.2
        for <linux-iio@vger.kernel.org>; Thu, 23 Feb 2023 00:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmdTtDQ2mjq0WzUoKIpi/WB/3RUaciUEZ6ilHbrlMPI=;
        b=eLcL9RY+PkerFA13Bekv2dcXmjlLhz2b59bSTSipyRi3VKaY80hrXW1g077eVr1ZAM
         LP+Op/wJoLE+hl8OAQuYa+zIVOU79VXGs2dE0/zf0DUbx/3SwrXUlk14O1CThUxYLb2C
         6hgSpOYu2ffc3LBnWeMKO7JX9dchA9WASnmumM8VGAWJLwTYwdJle5B6/sR8Oq7SJJMf
         oSjLPYkfxnQF2hYJLlMbvvAR84qyDb1ZMik0Q3yAS1e8HUqJXsyb34vuuIU09Qv53tSt
         6TvMt9sL/gCDNEzWmWYt4pFEAY1rz6K1xa3K6q7svpJBuk3xVjs0jKF2qoFY0KXrgyRc
         70bA==
X-Gm-Message-State: AO0yUKUdLAvgO9Dec/vTRCDl8PejYo9NCB0iuuLyM5qvQFLGJAvNievX
        NIIk2PLGqEAPE7/oKt9AyD8IN0Q+dKEFf/lQuqOEcT7+MOsakPdlu9lDXMNHvQ1dossEnijLs25
        YcaYpjSt0vP5jkGvjcCFW
X-Received: by 2002:a17:906:5f89:b0:8c3:3439:24d9 with SMTP id a9-20020a1709065f8900b008c3343924d9mr16623939eju.24.1677141691720;
        Thu, 23 Feb 2023 00:41:31 -0800 (PST)
X-Google-Smtp-Source: AK7set9bKjW9ItVZ1ldmAq+rxBMd/u+ZhxSimq8PX0SH6U2iyRLZNPPOSSXjU33eVJFsjmgRH9wEKg==
X-Received: by 2002:a17:906:5f89:b0:8c3:3439:24d9 with SMTP id a9-20020a1709065f8900b008c3343924d9mr16623922eju.24.1677141691427;
        Thu, 23 Feb 2023 00:41:31 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906038b00b008e17dc10decsm2754595eja.52.2023.02.23.00.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 00:41:30 -0800 (PST)
Message-ID: <031354f0-be2f-fe59-4ca9-b8196e5e87fa@redhat.com>
Date:   Thu, 23 Feb 2023 09:41:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] iio: light: cm32181: Unregister second I2C client if
 present
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     Kevin Tsai <ktsai@capellamicro.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230223020059.2013993-1-kai.heng.feng@canonical.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230223020059.2013993-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2/23/23 03:00, Kai-Heng Feng wrote:
> If a second dummy client that talks to the actual I2C address was
> created in probe(), there should be a proper cleanup on driver and
> device removal to avoid leakage.
> 
> So unregister the dummy client via another callback.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Fixes: c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources")
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks this patch looks good to me now, and you
already added my Reviewed-by, so from my POV this
is ready for merging now.

Regards,

Hans

> ---
> v4:
>  - Remove logging kmalloc failures.
> 
> v3:
>  - Use devm_add_action_or_reset() in a correct place.
>  - Wording.
> 
> v2:
>  - Use devm_add_action_or_reset() instead of remove() callback to avoid
>    race.
> 
>  drivers/iio/light/cm32181.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index b1674a5bfa368..d4a34a3bf00d9 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -429,6 +429,14 @@ static const struct iio_info cm32181_info = {
>  	.attrs			= &cm32181_attribute_group,
>  };
>  
> +static void cm32181_unregister_dummy_client(void *data)
> +{
> +	struct i2c_client *client = data;
> +
> +	/* Unregister the dummy client */
> +	i2c_unregister_device(client);
> +}
> +
>  static int cm32181_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -460,6 +468,10 @@ static int cm32181_probe(struct i2c_client *client)
>  		client = i2c_acpi_new_device(dev, 1, &board_info);
>  		if (IS_ERR(client))
>  			return PTR_ERR(client);
> +
> +		ret = devm_add_action_or_reset(dev, cm32181_unregister_dummy_client, client);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	cm32181 = iio_priv(indio_dev);

