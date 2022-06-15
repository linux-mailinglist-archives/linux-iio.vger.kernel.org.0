Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C5D54CDDB
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 18:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiFOQKy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 12:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiFOQKx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 12:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDBE134B91
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655309451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8C7CNnZsHIiOsbHm8tz+65i/chIUrJHAiiny+QpZ2g=;
        b=KmOVoinpXZQiTvaMAWn6q1bYN7RjR2dAeJElTrppuCZTuF63zdmo7jAu6mgRBPp+h+wr/Y
        QSgNax8/+ynpqFyu3HSTjInkLBJVoPigpTU+zt5CP2jU9sBF+Sf6zVpED0RTFrr4Yrncfn
        XUXthmSlTeR5XiNS6+ClwXrPHLEU4HY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-AAiSkUf6NYqbhldZu7tL-g-1; Wed, 15 Jun 2022 12:10:50 -0400
X-MC-Unique: AAiSkUf6NYqbhldZu7tL-g-1
Received: by mail-ed1-f72.google.com with SMTP id s15-20020a056402520f00b004327f126170so8940696edd.7
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 09:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L8C7CNnZsHIiOsbHm8tz+65i/chIUrJHAiiny+QpZ2g=;
        b=tkFY8ljBISUHAXqaj5UEsvigHd2X6e+EAk+Oo9o4wTelwOc8Nd3G+y/8/jVM6IETB/
         a6P74kCdp1rYOVgymTD9GG/trrXbdi5pOgFLemgab78vtE7aZN6jQFlB7GDHEuvzJJLM
         5C0ZC3Aao0qTcjqiYPh+KG2S9YOvokxz9RtxJ6+ONMXNDTZTdiuq/U//s+chxyONMETd
         qiLdRFEYHDVwF3r3rfny5PehLK/GUEPx0kLuD7z5e48W4ETkB6WAWpjflWyAr2C+8b+/
         Wh1M9auzh7OjmcbdwxNrBcloRkKK7rJvFaEkgzDoNHlGDihpFw8wZJrMzJXFiu4LR8QE
         SnxQ==
X-Gm-Message-State: AJIora+0kHNU6f0NmLfEaGojpqswOLM0HL7bBJR3VfqV7v3hlaFmRHMr
        GHKNOG+CZ5FpurgVsquA/cVQJkCo3Gs9y78RBVJUdkFzacid6ecqvyqOQcb838OEenoLneadzZ3
        Of/931xjU3ues19W2ZUxp
X-Received: by 2002:a17:906:7952:b0:711:d4e0:da23 with SMTP id l18-20020a170906795200b00711d4e0da23mr489483ejo.305.1655309449558;
        Wed, 15 Jun 2022 09:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1todeVP2438ghYV55GiAx7PH0P9XpRlMmKnC0cGTTtRvrHmdwvSVJuWAVKv6YDvzlO8oAM35A==
X-Received: by 2002:a17:906:7952:b0:711:d4e0:da23 with SMTP id l18-20020a170906795200b00711d4e0da23mr489467ejo.305.1655309449389;
        Wed, 15 Jun 2022 09:10:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id i27-20020a50871b000000b0042dcbc3f302sm9604497edb.36.2022.06.15.09.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 09:10:48 -0700 (PDT)
Message-ID: <8690f687-8f9d-b03f-226f-3a289e718ed5@redhat.com>
Date:   Wed, 15 Jun 2022 18:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] iio: accel: mma8452: ignore the return value of reset
 operation
Content-Language: en-US
To:     haibo.chen@nxp.com, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-imx@nxp.com
References: <1655292718-14287-1-git-send-email-haibo.chen@nxp.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <1655292718-14287-1-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 6/15/22 13:31, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> On fxls8471, after set the reset bit, the device will reset immediately,
> will not give ACK. So ignore the return value of this reset operation,
> let the following code logic to check whether the reset operation works.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/iio/accel/mma8452.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index e0f0c0abed28..c7d9ca96dbaa 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1511,10 +1511,14 @@ static int mma8452_reset(struct i2c_client *client)
>  	int i;
>  	int ret;
>  
> -	ret = i2c_smbus_write_byte_data(client,	MMA8452_CTRL_REG2,
> +	/*
> +	 * Find on fxls8471, after config reset bit, it reset immediately,
> +	 * and will not give ACK, so here do not check the return value.
> +	 * The following code will read the reset register, and check whether
> +	 * this reset works.
> +	 */
> +	i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG2,
>  					MMA8452_CTRL_REG2_RST);
> -	if (ret < 0)
> -		return ret;
>  
>  	for (i = 0; i < 10; i++) {
>  		usleep_range(100, 200);

