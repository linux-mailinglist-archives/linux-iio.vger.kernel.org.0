Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8567C670D11
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jan 2023 00:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjAQXRV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 18:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjAQXPt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 18:15:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C623B0CF
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 13:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673989354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7w76HtfzwdcmqP5jdkU9ZLwca97vCioI41/SywejLwE=;
        b=cqhrwLCsGTcIEiugrni63U3gGEn4ao4d2KNGYXwnM4d3jnFO4jUg18mhaKShKURiIm0VZj
        fX5LN5EBZnUaI+h2t9bOk8pV7itdk2CzWVCiSPpRx/A3vyaOxjHRVQLIDBZEa8JMT5VAJL
        rrJUqHclarTsOhdN3JS5yFJPZj2FL+c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-hH1jPAiQNI6IL7vSsyCOlw-1; Tue, 17 Jan 2023 16:02:33 -0500
X-MC-Unique: hH1jPAiQNI6IL7vSsyCOlw-1
Received: by mail-ej1-f70.google.com with SMTP id hc30-20020a170907169e00b0086d90ee8b17so6279874ejc.10
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 13:02:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7w76HtfzwdcmqP5jdkU9ZLwca97vCioI41/SywejLwE=;
        b=o4OMDnoZN4g3JuqeF2++oc07njkgqvcZVkt2IQmmUlfcJvBV3c/pB+Kbdm1ntkZsV2
         sWbzAZBeH4RCTbkPefm+0wXY2O3L9rLxnHcqgPwq4L67HeifOitZOWsyVsAetqNUVTRN
         y1RQIuAhbdZAl2DZtDYWxLX7aVpaxHzhadMKtkwDk64icrDMOF2sge3wSmAicRsceAjQ
         lOL/3s5aXfJsrxvpDCVkFm8oES+yyHAo3T/+zGeojEIdiH8oNmgYNinWS3Jm21MNonz5
         F35yVa9twttnQz44Ez2TDY7eQgBIdn+QhdKXJIUWv41YIwpKmy0CF6U1y7RMb2FYqckP
         w2hQ==
X-Gm-Message-State: AFqh2kpxs+57BNw3PmALSLNri2HjRBZVnVRgv9eo8Lh4i13sqgYDI6yz
        TDfM7awAgOv9e5VV5gSPJGx7QTmhJr1DlMT/H1ahfbTWxHXcOBiRSZrb3/b4L0XMP1eJOdiBsqp
        UBpg9Yq7JRlKGMG3snYyP
X-Received: by 2002:a17:906:f49:b0:864:8c78:e7ff with SMTP id h9-20020a1709060f4900b008648c78e7ffmr524131ejj.23.1673989351199;
        Tue, 17 Jan 2023 13:02:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvAJSrzqGgbRw1prAYhG1g+FMQCC1Uscp3OUxHkrUrWI/VWjJQOxnfATQw4f1HIT+XTEqIsJg==
X-Received: by 2002:a17:906:f49:b0:864:8c78:e7ff with SMTP id h9-20020a1709060f4900b008648c78e7ffmr524102ejj.23.1673989350949;
        Tue, 17 Jan 2023 13:02:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090676d500b0086a2e31d1c1sm5876991ejn.28.2023.01.17.13.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 13:02:30 -0800 (PST)
Message-ID: <a204fdeb-b2bb-5c61-8a75-de6dd244892a@redhat.com>
Date:   Tue, 17 Jan 2023 22:02:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] iio: light: cm32181: Fix PM support on system with 2 I2C
 resources
From:   Hans de Goede <hdegoede@redhat.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     Wahaj <wahajaved@protonmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230117160951.282581-1-kai.heng.feng@canonical.com>
 <5c95d25b-ff26-053b-efc8-5f6fd979c7e2@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <5c95d25b-ff26-053b-efc8-5f6fd979c7e2@redhat.com>
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

On 1/17/23 18:19, Hans de Goede wrote:
> Hi,
> 
> On 1/17/23 17:09, Kai-Heng Feng wrote:
>> Commit c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices
>> with 2 I2C resources") creates a second client for the actual I2C
>> address, but the "struct device" passed to PM ops is the first client
>> that can't talk to the sensor.
>>
>> That means the I2C transfers in both suspend and resume routines can
>> fail and blocking the whole suspend process.
>>
>> Instead of using the first client for I2C transfer, store the cm32181
>> private struct on both cases so the PM ops can get the correct I2C
>> client to perfrom suspend and resume.
>>
>> Fixes: 68c1b3dd5c48 ("iio: light: cm32181: Add PM support")
>> Tested-by: Wahaj <wahajaved@protonmail.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Thank you for this fix. I had looking into this on my todo list,
> since I have been seeing some bug reports about this too.
> 
> One remark inline:
> 
>> ---
>>  drivers/iio/light/cm32181.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>> index 001055d097509..0f319c891353c 100644
>> --- a/drivers/iio/light/cm32181.c
>> +++ b/drivers/iio/light/cm32181.c
>> @@ -440,6 +440,8 @@ static int cm32181_probe(struct i2c_client *client)
>>  	if (!indio_dev)
>>  		return -ENOMEM;
>>  
>> +	i2c_set_clientdata(client, indio_dev);
>> +
> 
> Why move this up, the suspend/resume callbacks cannot run until
> probe() completes, so no need for this change.
> 
>>  	/*
>>  	 * Some ACPI systems list 2 I2C resources for the CM3218 sensor, the
>>  	 * SMBus Alert Response Address (ARA, 0x0c) and the actual I2C address.
>> @@ -458,9 +460,9 @@ static int cm32181_probe(struct i2c_client *client)
>>  		client = i2c_acpi_new_device(dev, 1, &board_info);
>>  		if (IS_ERR(client))
>>  			return PTR_ERR(client);
>> -	}
>>  
>> -	i2c_set_clientdata(client, indio_dev);
>> +		i2c_set_clientdata(client, indio_dev);
>> +	}
> 
> And moving it inside the if block here (instead of just dropping it)
> is also weird. I guess you meant to just delete it since you moved it up.
> 
>>  
>>  	cm32181 = iio_priv(indio_dev);
>>  	cm32181->client = client;
> 
> Also note that the ->client used in suspend/resume now is not set until
> here, so moving the i2c_set_clientdata() up really does not do anything.
> 
> I beleive it would be best to just these 2 hunks from the patch and
> only keep the changes to the suspend/resume callbacks.

p.s.

I believe that this will likely also fix:
https://bugzilla.redhat.com/show_bug.cgi?id=2152281

Can you please add a:

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2152281

to the next version.

Regards,

Hans



> 
> 
>> @@ -490,7 +492,8 @@ static int cm32181_probe(struct i2c_client *client)
>>  
>>  static int cm32181_suspend(struct device *dev)
>>  {
>> -	struct i2c_client *client = to_i2c_client(dev);
>> +	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
>> +	struct i2c_client *client = cm32181->client;
>>  
>>  	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>>  					 CM32181_CMD_ALS_DISABLE);
>> @@ -498,8 +501,8 @@ static int cm32181_suspend(struct device *dev)
>>  
>>  static int cm32181_resume(struct device *dev)
>>  {
>> -	struct i2c_client *client = to_i2c_client(dev);
>>  	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
>> +	struct i2c_client *client = cm32181->client;
>>  
>>  	return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
>>  					 cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> 

