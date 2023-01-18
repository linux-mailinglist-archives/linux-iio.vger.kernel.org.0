Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D410767247C
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jan 2023 18:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjARRIn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Jan 2023 12:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjARRIj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2023 12:08:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA29D2D140
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2023 09:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674061670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBANv9H3NJKZ6sjNqm34M+TVsHXbeGsvXhw690AG2bM=;
        b=JI7+jwkvMJP/c2ACwauw9rhv1i2JFNMEn2NJMsSCb7deFTYo6CN10doI5S4neWUt5Bjot6
        hZ2UIj2aht2s0IHz1edHYlZC7eDLKVlywzGsp9V29mJHbMX+VHvvnxr0QDSYTRyk3QfmRw
        dUkxvRVfF43zMudTAc0sZwXYq30HugA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-LzQlJxrpO2GrNmAnd0uuFw-1; Wed, 18 Jan 2023 12:07:48 -0500
X-MC-Unique: LzQlJxrpO2GrNmAnd0uuFw-1
Received: by mail-ej1-f72.google.com with SMTP id nd38-20020a17090762a600b00871ff52c6b5so4875360ejc.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2023 09:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBANv9H3NJKZ6sjNqm34M+TVsHXbeGsvXhw690AG2bM=;
        b=NU9u8zLcuiv7T1YMW6JMEF9h1D9gOIvzkqPTm+CVMC1f0DETLEqM0YlbzgTVvSZGxa
         gXbxScdjSo1uzXuU8YAUiyWVSmKsOratwsD9oxN70AIlW1jGrsPjdKmwGgcZH0gD8PWv
         nUFJZJbpT7EabPI62Q6q3yhIHZUHlXpyTGxYy8LDPOU8n3LMe5TGufm6fvgQCH1v6FxA
         097PHOWcU7Ed0wPktIiyFlocxDacz1CRy0GT6PTR6UKeW2/uiM23s3AO0gJKGFZy7XUv
         5Gn27DuWidAE+XAjaDVo0of3bU6eYMj4T+/GlrDoDIlQFAwYBsTyfdld3Phn27ytdl4U
         DPYQ==
X-Gm-Message-State: AFqh2kojqw/bxpcF+jJOXg7gWMhWFBE049MHn1YQp4beylCjj9ficn/R
        0CcAIBhO4g/FQleucqxN9QQJYsybgnhh22XTTEpOAYrAOQQIquL921Vx5trv6ms/rC27Amk6Zck
        7pqM+FEnhfA58Ihy4OY//
X-Received: by 2002:a05:6402:3496:b0:48e:9c36:6c39 with SMTP id v22-20020a056402349600b0048e9c366c39mr10655817edc.0.1674061667349;
        Wed, 18 Jan 2023 09:07:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuM6N50uo34MhuDQ2myK4tmuRftD6RxUPFaD0W5wWJaH1S/YZtVCY64QmVFCMkp4Ewl6ol/wg==
X-Received: by 2002:a05:6402:3496:b0:48e:9c36:6c39 with SMTP id v22-20020a056402349600b0048e9c366c39mr10655801edc.0.1674061667188;
        Wed, 18 Jan 2023 09:07:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906538d00b0085a958808c6sm10297082ejo.7.2023.01.18.09.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 09:07:46 -0800 (PST)
Message-ID: <3d51f766-bd80-870d-c939-99660526c654@redhat.com>
Date:   Wed, 18 Jan 2023 18:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] iio: light: cm32181: Fix PM support on system with 2
 I2C resources
Content-Language: en-US, nl
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     Wahaj <wahajaved@protonmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230118170422.339619-1-kai.heng.feng@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230118170422.339619-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 1/18/23 18:04, Kai-Heng Feng wrote:
> Commit c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices
> with 2 I2C resources") creates a second client for the actual I2C
> address, but the "struct device" passed to PM ops is the first I2C
> client that can't talk to the sensor.
> 
> That means the I2C transfers in both suspend and resume routines can
> fail and blocking the whole suspend process.
> 
> Instead of using the first client for I2C transfer, use the I2C client
> stored in the cm32181 private struct so the PM ops can get the correct
> I2C client to really talk to the sensor device.
> 
> Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
> BugLink: https://bugs.launchpad.net/bugs/1988346
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
> Tested-by: Wahaj <wahajaved@protonmail.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> v2:
>  - Removed setting drvdata to the dummy client.
>  - Added bug links.
>  - Wording.
> 
>  drivers/iio/light/cm32181.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 001055d097509..b1674a5bfa368 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -440,6 +440,8 @@ static int cm32181_probe(struct i2c_client *client)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	i2c_set_clientdata(client, indio_dev);
> +
>  	/*
>  	 * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
>  	 * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
> @@ -460,8 +462,6 @@ static int cm32181_probe(struct i2c_client *client)
>  			return PTR_ERR(client);
>  	}
>  
> -	i2c_set_clientdata(client, indio_dev);
> -
>  	cm32181 = iio_priv(indio_dev);
>  	cm32181->client = client;
>  	cm32181->dev = dev;
> @@ -490,7 +490,8 @@ static int cm32181_probe(struct i2c_client *client)
>  
>  static int cm32181_suspend(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> +	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> +	struct i2c_client *client = cm32181->client;
>  
>  	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>  					 CM32181_CMD_ALS_DISABLE);
> @@ -498,8 +499,8 @@ static int cm32181_suspend(struct device *dev)
>  
>  static int cm32181_resume(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
>  	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> +	struct i2c_client *client = cm32181->client;
>  
>  	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>  					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);

