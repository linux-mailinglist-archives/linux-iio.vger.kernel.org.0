Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447BA70E6A4
	for <lists+linux-iio@lfdr.de>; Tue, 23 May 2023 22:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjEWUlj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 May 2023 16:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjEWUli (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 May 2023 16:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B24DCA
        for <linux-iio@vger.kernel.org>; Tue, 23 May 2023 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684874449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rMQ7eLbEFSL7P/VJL4e74XFJFLVTAz5TY06pr4IOvM=;
        b=Kwg2ddmExLO26kETlOofZvOxn1awIDo2zJ4cFvo2z4+a8hjmBuELnCYIBDI22eZneZqPXL
        qNdgSfrWNvSmWxXsrK2nw70ZiYoiQGp1pAwSh8l/vn/WVX6NwSbW6rq+/aJRvkHCpI2K+5
        CamLerwPf7yj/LsGMrF36sG0zuHE3RM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-_IFz9SFCNeq6itxTKFePbg-1; Tue, 23 May 2023 16:40:48 -0400
X-MC-Unique: _IFz9SFCNeq6itxTKFePbg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a341efd9aso6108966b.0
        for <linux-iio@vger.kernel.org>; Tue, 23 May 2023 13:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684874447; x=1687466447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rMQ7eLbEFSL7P/VJL4e74XFJFLVTAz5TY06pr4IOvM=;
        b=c6OvfE6qhpTBlejc2KHHyhNMeQcG0pSpACwdSh0hKTJ/hMR+j806I+6wcTen/1wXhc
         aXK8ymgrAEHg06Dfo8htDz1qrK4QOy61PbusUxn3uyEeLlPycu0nigN/MPh6Myq0iXhw
         fW00ysawv7fBy6QXj8MOzrvFjw8HuShUuQP4+ogJKkxJqJxoFpLMzseWktYpIxKOnQSA
         qH+Jd63M4UN5xUF2W7onIk/gueGpoo3Hp+0cVaR4yGjnrwYk0oBmqXFIvjpBlqV7Jz3V
         aAlcEy5wWNxXelRt6PEecvUMnJ008tb3fhGjhMptB0lUU6D39GmXV/JdQQGCClu8g5j/
         eg8A==
X-Gm-Message-State: AC+VfDziRMUcvvTD4gj7nbtr8nqgcJpahUOsRrEi4hrZb6gYntdKNuo0
        MyDYoBEgwliNGmyxK9JbDUGQvmRIWZTPJFsXWVUjJLPqzEgYj7R3xcGEJBvznoMuHEZUpXxetQc
        LNWxKzQThe3pACGJA+HPx
X-Received: by 2002:a17:907:9620:b0:96f:87ae:49eb with SMTP id gb32-20020a170907962000b0096f87ae49ebmr15035630ejc.16.1684874446897;
        Tue, 23 May 2023 13:40:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UABLe7XvMRicsNjqvU8k8lcO7W3ZyeIxc+Et+uuCViEHkE6dnM9saQc0tYIN+/nhDga/gTQ==
X-Received: by 2002:a17:907:9620:b0:96f:87ae:49eb with SMTP id gb32-20020a170907962000b0096f87ae49ebmr15035611ejc.16.1684874446572;
        Tue, 23 May 2023 13:40:46 -0700 (PDT)
Received: from [192.168.43.127] ([109.38.137.153])
        by smtp.gmail.com with ESMTPSA id j27-20020a170906535b00b0096f4c9ce526sm4967732ejo.225.2023.05.23.13.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 13:40:45 -0700 (PDT)
Message-ID: <b9954a28-1ab2-468d-beb5-2fa2e0f2c069@redhat.com>
Date:   Tue, 23 May 2023 22:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] staging: Switch i2c drivers back to use .probe()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Wolfram Sang <wsa@kernel.org>, Jean Delvare <jdelvare@suse.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Kalle Valo <kvalo@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Crt Mori <cmo@melexis.com>, Haowen Bai <baihaowen@meizu.com>,
        Tom Rix <trix@redhat.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        kernel@pengutronix.de, linux-media@vger.kernel.org
References: <20230523200036.465180-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230523200036.465180-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Uwe,

On 5/23/23 22:00, Uwe Kleine-König wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
> back to (the new) .probe() to be able to eventually drop .probe_new() from
> struct i2c_driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this patch was generated using coccinelle.
> 
> I chose to convert all drivers below drivers/staging in a single
> patch, but if you prefer I can split by driver.

I'm currently doing a lot of cleanup work on the atomisp code
including the sensor drivers. Specifically I'm working on
removing drivers which are duplicate with the standard v4l2
sensor drivers under drivers/media/i2c . So this patch is
likely to cause conflicts.

I have my own branch for my atomisp work from which I send
pull-reqs directly to Mauro Chehab:

https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

As such I think for the atomisp drivers it would be best if I directly
apply the atomisp bits of this patch (no need for a resend) to my
media-atomisp branch, is that ok with you ?

Regards,

Hans




> If conflicts arise until this is applied, feel free to just drop the
> files with conflicts from this patch. I'll care about the fallout later
> then.
> 
> Also note there is no coordination necessary with the i2c tree. Dropping
> .probe_new() will happen only when all (or most) drivers are converted,
> which will happen after v6.5-rc1 for sure.
> 
> Best regards
> Uwe
>  drivers/staging/iio/addac/adt7316-i2c.c                   | 2 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c           | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-gc0310.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-gc2235.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-lm3554.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c       | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-ov2680.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/atomisp-ov2722.c        | 2 +-
>  drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c | 2 +-
>  drivers/staging/media/max96712/max96712.c                 | 2 +-
>  drivers/staging/most/i2c/i2c.c                            | 2 +-
>  drivers/staging/olpc_dcon/olpc_dcon.c                     | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
> index 7e3d1a6f30ba..6c1f91c859ca 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -138,7 +138,7 @@ static struct i2c_driver adt7316_driver = {
>  		.of_match_table = adt7316_of_match,
>  		.pm = ADT7316_PM_OPS,
>  	},
> -	.probe_new = adt7316_i2c_probe,
> +	.probe = adt7316_i2c_probe,
>  	.id_table = adt7316_i2c_id,
>  };
>  module_i2c_driver(adt7316_driver);
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index b3152f7153fb..46db6d91542a 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -781,7 +781,7 @@ static struct i2c_driver ad5933_driver = {
>  		.name = "ad5933",
>  		.of_match_table = ad5933_of_match,
>  	},
> -	.probe_new = ad5933_probe,
> +	.probe = ad5933_probe,
>  	.id_table = ad5933_id,
>  };
>  module_i2c_driver(ad5933_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c b/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
> index 273155308fe3..21eb4234a081 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
> @@ -483,7 +483,7 @@ static struct i2c_driver gc0310_driver = {
>  		.pm = pm_sleep_ptr(&gc0310_pm_ops),
>  		.acpi_match_table = gc0310_acpi_match,
>  	},
> -	.probe_new = gc0310_probe,
> +	.probe = gc0310_probe,
>  	.remove = gc0310_remove,
>  };
>  module_i2c_driver(gc0310_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
> index cb4c79b483ca..9fa390fbc5f3 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
> @@ -864,7 +864,7 @@ static struct i2c_driver gc2235_driver = {
>  		.name = "gc2235",
>  		.acpi_match_table = gc2235_acpi_match,
>  	},
> -	.probe_new = gc2235_probe,
> +	.probe = gc2235_probe,
>  	.remove = gc2235_remove,
>  };
>  module_i2c_driver(gc2235_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
> index c4ce4cd445d7..cf5d9317b11a 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
> @@ -945,7 +945,7 @@ static struct i2c_driver lm3554_driver = {
>  		.pm   = &lm3554_pm_ops,
>  		.acpi_match_table = lm3554_acpi_match,
>  	},
> -	.probe_new = lm3554_probe,
> +	.probe = lm3554_probe,
>  	.remove = lm3554_remove,
>  };
>  module_i2c_driver(lm3554_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> index 0e5a981dd331..1c6643c442ef 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> @@ -1600,7 +1600,7 @@ static struct i2c_driver mt9m114_driver = {
>  		.name = "mt9m114",
>  		.acpi_match_table = mt9m114_acpi_match,
>  	},
> -	.probe_new = mt9m114_probe,
> +	.probe = mt9m114_probe,
>  	.remove = mt9m114_remove,
>  };
>  module_i2c_driver(mt9m114_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> index 63de214916f5..b5d93a96d588 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
> @@ -719,7 +719,7 @@ static struct i2c_driver ov2680_driver = {
>  		.pm = pm_sleep_ptr(&ov2680_pm_ops),
>  		.acpi_match_table = ov2680_acpi_match,
>  	},
> -	.probe_new = ov2680_probe,
> +	.probe = ov2680_probe,
>  	.remove = ov2680_remove,
>  };
>  module_i2c_driver(ov2680_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
> index 5d2e6e2e72f0..6a72691ed5b7 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
> @@ -1019,7 +1019,7 @@ static struct i2c_driver ov2722_driver = {
>  		.name = "ov2722",
>  		.acpi_match_table = ov2722_acpi_match,
>  	},
> -	.probe_new = ov2722_probe,
> +	.probe = ov2722_probe,
>  	.remove = ov2722_remove,
>  };
>  module_i2c_driver(ov2722_driver);
> diff --git a/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c b/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
> index da8c3b1d3bcd..c94fe8e861a5 100644
> --- a/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
> +++ b/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
> @@ -1794,7 +1794,7 @@ static struct i2c_driver ov5693_driver = {
>  		.name = "ov5693",
>  		.acpi_match_table = ov5693_acpi_match,
>  	},
> -	.probe_new = ov5693_probe,
> +	.probe = ov5693_probe,
>  	.remove = ov5693_remove,
>  };
>  module_i2c_driver(ov5693_driver);
> diff --git a/drivers/staging/media/max96712/max96712.c b/drivers/staging/media/max96712/max96712.c
> index 99b333b68198..77943bdf3fb9 100644
> --- a/drivers/staging/media/max96712/max96712.c
> +++ b/drivers/staging/media/max96712/max96712.c
> @@ -427,7 +427,7 @@ static struct i2c_driver max96712_i2c_driver = {
>  		.name = "max96712",
>  		.of_match_table	= of_match_ptr(max96712_of_table),
>  	},
> -	.probe_new = max96712_probe,
> +	.probe = max96712_probe,
>  	.remove = max96712_remove,
>  };
>  
> diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c.c
> index 4e85e681922f..ce869280a056 100644
> --- a/drivers/staging/most/i2c/i2c.c
> +++ b/drivers/staging/most/i2c/i2c.c
> @@ -362,7 +362,7 @@ static struct i2c_driver i2c_driver = {
>  	.driver = {
>  		.name = "hdm_i2c",
>  	},
> -	.probe_new = i2c_probe,
> +	.probe = i2c_probe,
>  	.remove = i2c_remove,
>  	.id_table = i2c_id,
>  };
> diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
> index 2fba52e0bd7b..d5271eac14f6 100644
> --- a/drivers/staging/olpc_dcon/olpc_dcon.c
> +++ b/drivers/staging/olpc_dcon/olpc_dcon.c
> @@ -779,7 +779,7 @@ static struct i2c_driver dcon_driver = {
>  	},
>  	.class = I2C_CLASS_DDC | I2C_CLASS_HWMON,
>  	.id_table = dcon_idtable,
> -	.probe_new = dcon_probe,
> +	.probe = dcon_probe,
>  	.remove = dcon_remove,
>  	.detect = dcon_detect,
>  	.address_list = normal_i2c,
> 
> base-commit: 1f3413dc8eb0de023c5ec5994aef8225262d0f19

