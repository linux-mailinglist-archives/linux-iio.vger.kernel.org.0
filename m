Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E5C68B90D
	for <lists+linux-iio@lfdr.de>; Mon,  6 Feb 2023 10:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBFJxL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Feb 2023 04:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBFJwr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2023 04:52:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4E61CAE6
        for <linux-iio@vger.kernel.org>; Mon,  6 Feb 2023 01:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675677119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=owEYQNcSgjMplel5oj3hjxZa5dZAvDaBXhOMUtOhUoc=;
        b=QBAgqzR1BC9eLNdUssnJ2W18sk1oNDHd3+TyAbaOOF4PHlttVlswVJu8vGPolXDB19I13Z
        JYIsIzKlRb1efml+uSLj56aHTlwxJntOhgn7AgBtJFXeY8KyhOzm2VYjnSDukXSz8gK6yF
        h3j/EkeYL/hOGLi+sFoJaqtV5z3aDbI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-274-NObgEnzvNEmFMc9hdrLu-Q-1; Mon, 06 Feb 2023 04:51:58 -0500
X-MC-Unique: NObgEnzvNEmFMc9hdrLu-Q-1
Received: by mail-ej1-f69.google.com with SMTP id ud13-20020a170907c60d00b0088d773d11d6so8277279ejc.17
        for <linux-iio@vger.kernel.org>; Mon, 06 Feb 2023 01:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owEYQNcSgjMplel5oj3hjxZa5dZAvDaBXhOMUtOhUoc=;
        b=QRWiMOCUYV4zvbdxRYb7AS7GrPEDwM9JkW7g0zFBtBBWmLLHgGHZOIXsnc1AaVjT5L
         Enuzo72+bxLDcbYfD6GVOYoyAEjByXkHax3ykooQ8nE1YbjAAJHMpA+TLUrK0v/vYVaU
         mFzrzUSJ1madNq2T7r8aCJk68xxVLsg/uChsSdU/5NYZfTx8/p7EfsErBAByJi0rBr7w
         yoTB6tzw9ijM1vBzSVqUFnTJSGdq1/WhV1Lv5FR6ySrLB9IPk5E/bslIOVNnwdupCjN6
         0Lb6OnRjtRfYtrrM6vLhNtAwH1WcS7N8H0aOOjB2fQ8cQHxsfedbFiU8UojrdYkr5oiq
         IcXg==
X-Gm-Message-State: AO0yUKXebDyoSmU1iF7Qa9xJPmlZ4GqIuZ9p0vuKgJNzO7vTCEU8Uher
        hsVu/TpsTLMDURLZVTNZ/JG+BM30LOlggFXbTzDvf9NsjC20bYNVElWmRhgdqBbRdhpQUXxexdm
        751bAn8EW9KbCdwsJ2DD+
X-Received: by 2002:a50:9341:0:b0:4aa:a76a:c428 with SMTP id n1-20020a509341000000b004aaa76ac428mr5601488eda.6.1675677116591;
        Mon, 06 Feb 2023 01:51:56 -0800 (PST)
X-Google-Smtp-Source: AK7set8R7YfE5UxluqXarKoSjZxXBOJ+bTscBS5IqBZTYnjBUWkFkaKqIphqD14gAJ07SG61fBF/pg==
X-Received: by 2002:a50:9341:0:b0:4aa:a76a:c428 with SMTP id n1-20020a509341000000b004aaa76ac428mr5601481eda.6.1675677116426;
        Mon, 06 Feb 2023 01:51:56 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id c5-20020a50d645000000b004aaa656887esm2167221edj.96.2023.02.06.01.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 01:51:56 -0800 (PST)
Message-ID: <2d5dc77a-4c57-cad5-3fb5-6dc999d3954d@redhat.com>
Date:   Mon, 6 Feb 2023 10:51:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] iio: light: cm32181: Unregister second I2C client if
 present
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ktsai@capellamicro.com, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230206063616.981225-1-kai.heng.feng@canonical.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230206063616.981225-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2/6/23 07:36, Kai-Heng Feng wrote:
> If a second client that talks to the actual I2C address was created in
> probe(), there should be a corresponding cleanup in remove() to avoid
> leakage.
> 
> So if the "client" is not the same one used by I2C core, unregister it
> accordingly.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
> Fixes: c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thank you for fixing this, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/iio/light/cm32181.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index b1674a5bfa368..37439e103d273 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -488,6 +488,15 @@ static int cm32181_probe(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static void cm32181_remove(struct i2c_client *client)
> +{
> +	struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));
> +
> +	/* Unregister the dummy client */
> +	if (cm32181->client != client)
> +		i2c_unregister_device(cm32181->client);
> +}
> +
>  static int cm32181_suspend(struct device *dev)
>  {
>  	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> @@ -531,6 +540,7 @@ static struct i2c_driver cm32181_driver = {
>  		.pm = pm_sleep_ptr(&cm32181_pm_ops),
>  	},
>  	.probe_new	= cm32181_probe,
> +	.remove		= cm32181_remove,
>  };
>  
>  module_i2c_driver(cm32181_driver);

