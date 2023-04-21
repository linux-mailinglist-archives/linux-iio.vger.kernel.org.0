Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE2D6EA72B
	for <lists+linux-iio@lfdr.de>; Fri, 21 Apr 2023 11:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjDUJhv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Apr 2023 05:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjDUJhs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 05:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1C89EE4
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682069817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uzH8QW/csXN0CxzGkETec+n4HWfPUmGi/veY0RKNigI=;
        b=A9G8t/mvmiJGYi5E5OHApMz+kU4o/wB5OYGwOTFoAPGEHzK5GF8nOkHq1p60emv+t0Azww
        /GvgJRz8oZzfQAeFjsMF3Z02DBRZytroes+c+FRLYIw2wKg2eLgLdmamT2AT2/Smmiuncu
        K+JtOoQrf7zK2klS00Q4CDdi2fsPeWE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-aAncbsAJMSOsXUKPZ9lw1A-1; Fri, 21 Apr 2023 05:36:53 -0400
X-MC-Unique: aAncbsAJMSOsXUKPZ9lw1A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50692ecb3c5so1616759a12.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 02:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682069812; x=1684661812;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzH8QW/csXN0CxzGkETec+n4HWfPUmGi/veY0RKNigI=;
        b=RYVUVCP8ALSpvLZkK+yOXggILqYg/WF+JX5arQINoPoyWB0bFkJZVY94zTjB+dQAfR
         FyPxp7fSsr3UjGYeHldPSmAUh63PNL/aHi4r8/kaTnPcI9C2oMqixbg9jQW3zFomB8Oc
         o2lKPlb63ZjzeApCVAzXHw5QsRM3BNg8bGlLMK4EbdbBV7WtQU1/Ttp7N8t5FP3WDyTt
         +ktV/N9UBoMe19iIpSpYGbU/38jWZJ8vCbdb/DXQA1dNRIIMD88EDsXqCfEl6vS9KhnP
         gPu4biMSUQIQKugyqRmsWxy+WQNJr18CiDGwyd00fRqsG2vz3sAH0NJWx8uVQb4SMiQ8
         pl7w==
X-Gm-Message-State: AAQBX9el1YutbAl/JghkCB/SIsbj1dl3JHbW9j/bQebU8GzlPmhEg9ja
        /fYqgs4NlxsVJwOW4bhM2rX+m0KpnrSH5IuviZAn5tfry/+MycxC6OY1V044AyqkfJ3yssqpTs1
        oYInXm7kjGRkF02BVrUai
X-Received: by 2002:a17:906:b354:b0:953:3e29:f35c with SMTP id cd20-20020a170906b35400b009533e29f35cmr1733510ejb.45.1682069812659;
        Fri, 21 Apr 2023 02:36:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350baQKAMD9B4o30q5gQRB/0ZHP7CQjqkTnOQkVeItXf6HwlW8pFLFiptNIBKmQfsiYwSmMf3yA==
X-Received: by 2002:a17:906:b354:b0:953:3e29:f35c with SMTP id cd20-20020a170906b35400b009533e29f35cmr1733498ejb.45.1682069812419;
        Fri, 21 Apr 2023 02:36:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id mb20-20020a170906eb1400b0094f432f2429sm1827793ejb.109.2023.04.21.02.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 02:36:51 -0700 (PDT)
Message-ID: <6feb48c8-6d74-6605-b7d1-48103ca9187e@redhat.com>
Date:   Fri, 21 Apr 2023 11:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] iio: light: al3320a: Handle ACPI device CALS0001
Content-Language: en-US, nl
To:     Marius Hoch <mail@mariushoch.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420232631.68864-1-mail@mariushoch.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230420232631.68864-1-mail@mariushoch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 4/21/23 01:26, Marius Hoch wrote:
> This sensor can be found as CALS0001 on the Lenovo Yoga
> Tablet 2 series.
> 
> Tested on a Lenovo Yoga Tablet 2 1051-F.
> 
> Signed-off-by: Marius Hoch <mail@mariushoch.de>
> ---
> v2: Explicitly include <linux/mod_devicetable.h> (don't rely on
> linux/i2c.h including it)

Thanks, the patch looks good to me and I have
tested this successfully on a Lenovo Yoga Tablet 2 851F :

Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/iio/light/al3320a.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
> index 9ff28bbf34bb..36214d790f71 100644
> --- a/drivers/iio/light/al3320a.c
> +++ b/drivers/iio/light/al3320a.c
> @@ -16,6 +16,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/mod_devicetable.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -247,11 +248,18 @@ static const struct of_device_id al3320a_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, al3320a_of_match);
>  
> +static const struct acpi_device_id al3320a_acpi_match[] = {
> +	{"CALS0001"},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, al3320a_acpi_match);
> +
>  static struct i2c_driver al3320a_driver = {
>  	.driver = {
>  		.name = AL3320A_DRV_NAME,
>  		.of_match_table = al3320a_of_match,
>  		.pm = pm_sleep_ptr(&al3320a_pm_ops),
> +		.acpi_match_table = al3320a_acpi_match,
>  	},
>  	.probe_new	= al3320a_probe,
>  	.id_table	= al3320a_id,
> 
> base-commit: cb0856346a60fe3eb837ba5e73588a41f81ac05f

