Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16A7630ECF
	for <lists+linux-iio@lfdr.de>; Sat, 19 Nov 2022 13:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiKSM6A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Nov 2022 07:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKSM6A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Nov 2022 07:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CD69E0A5
        for <linux-iio@vger.kernel.org>; Sat, 19 Nov 2022 04:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668862627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4oyHKxSWWaJxvSt13X7gQ3W9bbef9cwNK4vJDf9Pqz8=;
        b=OQ2l/pToaqKpABG+cTabYSP0miyNCY0iTtN4MA0J6j0nKycnaomnWMjxKD2/jsTh19JF3W
        mNMcmbREKmXYWOGyXWuUtD13iovctjI6aIroABPZFd1qH2WJUzzQCgmzFWo8nT9ELg9Gox
        IJkLFqQ0v0ex/w8nB+yn3GZfQzluwSw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-118-NvNzrw1qNeaoBHXNi0nzUg-1; Sat, 19 Nov 2022 07:57:05 -0500
X-MC-Unique: NvNzrw1qNeaoBHXNi0nzUg-1
Received: by mail-ej1-f69.google.com with SMTP id hs34-20020a1709073ea200b007ad86f91d39so4718414ejc.10
        for <linux-iio@vger.kernel.org>; Sat, 19 Nov 2022 04:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4oyHKxSWWaJxvSt13X7gQ3W9bbef9cwNK4vJDf9Pqz8=;
        b=oUBplu2lezxIlYc+toWkcveCkMz3zIjnedpAT8Qz8Dh7gTcIMheKN+1xsSDf9seLR/
         +wkDjGlJejCNqscX7UcfoMM0iU7JRYvrwOVMHlV19KVIt/R6XXSa+dH9A6FHwtOYmZ6K
         FelsPhwH/Lr1ikkrgIKNfMMgVgo/6/0ffKdXJnWEHho6l3mOvmadmyPyKgLyXNRNRQq+
         dzGYP7RsEMr/6HHJesBjPt9baxrLpkUJm5BLBEKR/0eSclDF28b14y9Itiw/Jy2j3HjH
         w/XDPXO6cXHuyDoNyukyNZ409QWsH+8EVn/Xlj5dmiWStONeXzGBYq+o2ovLLL0R630f
         xvEQ==
X-Gm-Message-State: ANoB5pmYsmBjTaZugXMHt80mUpL47+gBgEtU2qUM1j4zayAg2o/h2kKb
        85nTznn1YjH/wLhdB34RJX42AHcg29V6GSlkxpmz0ZMZa+QZkxKbTtA8ySmcK6+uXCVQJ+m9ODg
        7hil+aRMyhc9ib4bwR6vL
X-Received: by 2002:a17:906:c1d0:b0:7b4:64d3:e6f4 with SMTP id bw16-20020a170906c1d000b007b464d3e6f4mr1966163ejb.594.1668862624097;
        Sat, 19 Nov 2022 04:57:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5kBIoMWHwUuIUW7BwTZr06498SZcEjQzU5PBmA2v2+rdXV+tr4u0SaFqxlCpSE9YmY7eUUCg==
X-Received: by 2002:a17:906:c1d0:b0:7b4:64d3:e6f4 with SMTP id bw16-20020a170906c1d000b007b464d3e6f4mr1966143ejb.594.1668862623902;
        Sat, 19 Nov 2022 04:57:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id r9-20020a17090609c900b0078d4c72e2cesm2837826eje.44.2022.11.19.04.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Nov 2022 04:57:02 -0800 (PST)
Message-ID: <d52cd527-6365-c54f-410f-3f4ebe029dbe@redhat.com>
Date:   Sat, 19 Nov 2022 13:57:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 056/606] iio: accel: mma8452: Convert to i2c's
 .probe_new()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Martin Kepplinger <martink@posteo.de>
Cc:     linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-57-uwe@kleine-koenig.org>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221118224540.619276-57-uwe@kleine-koenig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/18/22 23:36, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> .probe_new() doesn't get the i2c_device_id * parameter, so determine
> that explicitly in the probe function.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/iio/accel/mma8452.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 3ba28c2ff68a..f97fb68e3a71 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1545,9 +1545,9 @@ static const struct of_device_id mma8452_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mma8452_dt_ids);
>  
> -static int mma8452_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int mma8452_probe(struct i2c_client *client)
>  {
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	struct mma8452_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> @@ -1846,7 +1846,7 @@ static struct i2c_driver mma8452_driver = {
>  		.of_match_table = mma8452_dt_ids,
>  		.pm	= &mma8452_pm_ops,
>  	},
> -	.probe = mma8452_probe,
> +	.probe_new = mma8452_probe,
>  	.remove = mma8452_remove,
>  	.id_table = mma8452_id,
>  };

