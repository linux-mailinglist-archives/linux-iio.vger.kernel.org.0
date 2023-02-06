Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEC668C05B
	for <lists+linux-iio@lfdr.de>; Mon,  6 Feb 2023 15:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjBFOmo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Feb 2023 09:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjBFOmn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2023 09:42:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EC719F3D
        for <linux-iio@vger.kernel.org>; Mon,  6 Feb 2023 06:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675694515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GI5zrOMuqq6hI/pVCzSKXBHfvX9lvifU/Z2Rz/c//h4=;
        b=KrEQlw+R6tNfQZW5voQ+K21RW7Cnd1b3o4hFuLM3YLQMO2apTQ6+fYBKaMalpoSfDO+77/
        FONB1ft4vjcrnJOprF/4UsYoTOwFShrm1Qqm3N8cgoYNKJtRutKsCuOLccApIN5qLyOt+X
        SD9wSneKSJ6LbHY4gKV4p/Cz00+0PH8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-606-ZwHoJyzkOuCVPQe2g0Z_YA-1; Mon, 06 Feb 2023 09:41:54 -0500
X-MC-Unique: ZwHoJyzkOuCVPQe2g0Z_YA-1
Received: by mail-ed1-f71.google.com with SMTP id s26-20020a056402037a00b004a25c2875d6so7752633edw.8
        for <linux-iio@vger.kernel.org>; Mon, 06 Feb 2023 06:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GI5zrOMuqq6hI/pVCzSKXBHfvX9lvifU/Z2Rz/c//h4=;
        b=pEcphJir20H6Af9KYAboNr+IDOvaIkbbCKaafXapoipk6xiPcAJnV/KpCgbPHzfABM
         8HIGuXT+TirEHqF2enwtDK6fnugYVdjUg7Zkff5hIjxtQFaneiez4Dv/d1YiA1miQOv2
         qaNSEfTTsgXJWbLLClPBNVAmQzZchoeFdk+bBj6XaTUoAWeN0AdKBqoBpp2qAJj8EEFW
         SyfHLjs7rOi4ZKcKWMr2Oj8MXew49u5IHvPKXfaOogYezx+eCTNhlr4vsHwkpwkUK1IH
         g0elM26ObdoJMEtdn9bRIoFYxrsSRMEn32mKgWsiQugiM2q8YNae9pnAGz2kULLYCgb6
         bYOg==
X-Gm-Message-State: AO0yUKWdzZQEWf4/M8iAdFnswMFy3J+CaFnRXUoyaEw8ulcdkF0iUEyN
        7F9GQlzfdon5D3V+lpomlT017ihvetawoW750gdpdiBeJFTwCnNoCmPoX8S6t1muFNryOkQV03d
        v4ycXAOf5u+PSVR5D2iFX
X-Received: by 2002:a17:906:7e42:b0:86f:763c:2695 with SMTP id z2-20020a1709067e4200b0086f763c2695mr20230013ejr.17.1675694513275;
        Mon, 06 Feb 2023 06:41:53 -0800 (PST)
X-Google-Smtp-Source: AK7set8gvBjtb+8j/pHDXISiCix7QKuVSYJBhFPw/tQ3MT5Oet+UMNlzjTrdzeOzfn66LAf6oEd3fA==
X-Received: by 2002:a17:906:7e42:b0:86f:763c:2695 with SMTP id z2-20020a1709067e4200b0086f763c2695mr20230004ejr.17.1675694513128;
        Mon, 06 Feb 2023 06:41:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709065e0c00b0086a4bb74cf7sm5533299eju.212.2023.02.06.06.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:41:52 -0800 (PST)
Message-ID: <0d57bcf5-0d82-1754-dc38-d4814b8bb138@redhat.com>
Date:   Mon, 6 Feb 2023 15:41:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] iio: light: cm32181: Unregister second I2C client if
 present
Content-Language: en-US, nl
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230206063616.981225-1-kai.heng.feng@canonical.com>
 <20230206143637.00001b00@Huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230206143637.00001b00@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2/6/23 15:36, Jonathan Cameron wrote:
> On Mon,  6 Feb 2023 14:36:16 +0800
> Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
>> If a second client that talks to the actual I2C address was created in
>> probe(), there should be a corresponding cleanup in remove() to avoid
>> leakage.
>>
>> So if the "client" is not the same one used by I2C core, unregister it
>> accordingly.
>>
>> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
>> Fixes: c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources")
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Whilst this fixes the leak, it introduces a race between unregistering
> some of the hardware and the later removal of userspace interfaces. 
> This needs to be handled via a devm_add_action_or_reset()
> registered handler so it's automatically cleaned up at the right place
> in the driver remove flow.

Good point, I missed that issue.

Regards,

Hans



>> ---
>>  drivers/iio/light/cm32181.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>> index b1674a5bfa368..37439e103d273 100644
>> --- a/drivers/iio/light/cm32181.c
>> +++ b/drivers/iio/light/cm32181.c
>> @@ -488,6 +488,15 @@ static int cm32181_probe(struct i2c_client *client)
>>  	return 0;
>>  }
>>  
>> +static void cm32181_remove(struct i2c_client *client)
>> +{
>> +	struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));
>> +
>> +	/* Unregister the dummy client */
>> +	if (cm32181->client != client)
>> +		i2c_unregister_device(cm32181->client);
>> +}
>> +
>>  static int cm32181_suspend(struct device *dev)
>>  {
>>  	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
>> @@ -531,6 +540,7 @@ static struct i2c_driver cm32181_driver = {
>>  		.pm = pm_sleep_ptr(&cm32181_pm_ops),
>>  	},
>>  	.probe_new	= cm32181_probe,
>> +	.remove		= cm32181_remove,
>>  };
>>  
>>  module_i2c_driver(cm32181_driver);
> 

