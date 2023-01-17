Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA366E4C0
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjAQRVg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 12:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjAQRVH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 12:21:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911F9367D7
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 09:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673975964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewfumNS1FYmWl7FUU1gFFTcCMXASO4AeNvtcvaqR0WA=;
        b=LCuKVllbKS2QAuiOijQhQ3+W02AyvMXsVqR8beV70QT1P9cgG0w5p1ZmxyRjMLEGScRTsH
        nN0kyzhvCzxTOv/UKC32jkc7BPYYTBnyXndTzXWBfOGSNFBs9cn2T6Pl5M1I3DHz19LHt8
        nZs3SKTeexdo3ZjjGZ1PTR4KWj1P9y0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-465-ovkxQ9wuPhKajL-H5LSG1g-1; Tue, 17 Jan 2023 12:19:23 -0500
X-MC-Unique: ovkxQ9wuPhKajL-H5LSG1g-1
Received: by mail-ej1-f70.google.com with SMTP id qb2-20020a1709077e8200b00842b790008fso22429520ejc.21
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 09:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewfumNS1FYmWl7FUU1gFFTcCMXASO4AeNvtcvaqR0WA=;
        b=Y/mWnwrYI+LaUYq1flSzL4qiSxX+nyDsmMjm499Y+Aw7zpkQ/EzroX/orEpBXLAo+v
         DVlj2HCjJqvnhbyaULfNjHTiSlhDgsnxpxXeXQbVjbI7IHB6TICL0dJT4o2e9nAMOQV/
         M6BfHzJiv7JBLj29lwz45Vs2/utXEbfOMRhFSR9MZ8GUkaPX4tfhhOsZp2V+CKR2afBg
         GDLjvGfqgzEcf+p2yzKIzUxsZd1XBG+urbobzmxQ/drBdIlDiyJ4OP6Y7aIqDO0Fh8rn
         94OTMzqTGt+Dz6A16YO95bPfRDnRh+aSn2+HMgUCv7vnT2P9XF4snqXlz0rie99bJRhZ
         /kGA==
X-Gm-Message-State: AFqh2kpfUEioUphAYj6RhPY1GgVuUVIBwF8V3zO0LmFwVfsBJ01+SzMl
        5KGRI5AcSRBV7D2AGjFHWLf2u/o/nODJuziWZeay+dlZj6yRGPbAIUB92TlMJeaEpnA3Kj2zsLF
        YBL75nQMo/0jpwQ1rkkQh
X-Received: by 2002:a17:906:4684:b0:86f:b99c:ac8d with SMTP id a4-20020a170906468400b0086fb99cac8dmr3783652ejr.44.1673975960610;
        Tue, 17 Jan 2023 09:19:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtAZJ8m8Lta0dHgrvmfc7q8aPjIVicIKus68iWmBIaT/AmiMxP7pYPNDX7CjgN5HodtbJTYdg==
X-Received: by 2002:a17:906:4684:b0:86f:b99c:ac8d with SMTP id a4-20020a170906468400b0086fb99cac8dmr3783645ejr.44.1673975960446;
        Tue, 17 Jan 2023 09:19:20 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b0084c4b87a69csm13425121ejc.153.2023.01.17.09.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:19:19 -0800 (PST)
Message-ID: <5c95d25b-ff26-053b-efc8-5f6fd979c7e2@redhat.com>
Date:   Tue, 17 Jan 2023 18:19:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] iio: light: cm32181: Fix PM support on system with 2 I2C
 resources
Content-Language: en-US, nl
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     Wahaj <wahajaved@protonmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230117160951.282581-1-kai.heng.feng@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230117160951.282581-1-kai.heng.feng@canonical.com>
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

On 1/17/23 17:09, Kai-Heng Feng wrote:
> Commit c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices
> with 2 I2C resources") creates a second client for the actual I2C
> address, but the "struct device" passed to PM ops is the first client
> that can't talk to the sensor.
> 
> That means the I2C transfers in both suspend and resume routines can
> fail and blocking the whole suspend process.
> 
> Instead of using the first client for I2C transfer, store the cm32181
> private struct on both cases so the PM ops can get the correct I2C
> client to perfrom suspend and resume.
> 
> Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
> Tested-by: Wahaj <wahajaved@protonmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thank you for this fix. I had looking into this on my todo list,
since I have been seeing some bug reports about this too.

One remark inline:

> ---
>  drivers/iio/light/cm32181.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 001055d097509..0f319c891353c 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -440,6 +440,8 @@ static int cm32181_probe(struct i2c_client *client)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	i2c_set_clientdata(client, indio_dev);
> +

Why move this up, the suspend/resume callbacks cannot run until
probe() completes, so no need for this change.

>  	/*
>  	 * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
>  	 * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
> @@ -458,9 +460,9 @@ static int cm32181_probe(struct i2c_client *client)
>  		client = i2c_acpi_new_device(dev, 1, &board_info);
>  		if (IS_ERR(client))
>  			return PTR_ERR(client);
> -	}
>  
> -	i2c_set_clientdata(client, indio_dev);
> +		i2c_set_clientdata(client, indio_dev);
> +	}

And moving it inside the if block here (instead of just dropping it)
is also weird. I guess you meant to just delete it since you moved it up.

>  
>  	cm32181 = iio_priv(indio_dev);
>  	cm32181->client = client;

Also note that the ->client used in suspend/resume now is not set until
here, so moving the i2c_set_clientdata() up really does not do anything.

I beleive it would be best to just these 2 hunks from the patch and
only keep the changes to the suspend/resume callbacks.

Regards,

Hans


> @@ -490,7 +492,8 @@ static int cm32181_probe(struct i2c_client *client)
>  
>  static int cm32181_suspend(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> +	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> +	struct i2c_client *client = cm32181->client;
>  
>  	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>  					 CM32181_CMD_ALS_DISABLE);
> @@ -498,8 +501,8 @@ static int cm32181_suspend(struct device *dev)
>  
>  static int cm32181_resume(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
>  	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> +	struct i2c_client *client = cm32181->client;
>  
>  	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>  					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);

