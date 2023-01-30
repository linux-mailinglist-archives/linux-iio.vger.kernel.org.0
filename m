Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8808680742
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 09:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjA3IRe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 03:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbjA3IRd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 03:17:33 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AEDC643
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 00:17:04 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mf7so10619319ejc.6
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 00:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=If23+I5OsLle0CeuHGRBPPsTloj+VqhA/YVdt5yI7Dk=;
        b=nCgm7ovhjr1aTM1hEii7fKocRz+FTT8en1DrDxyesnQ0vZO9lUpQ4HtBQl7h6wPZvk
         NOjLorhLW9tDFTAGPisqFhESfdfM0Q16HYqGOW67fzCnYfIwV6XkrZkFNo0NzfgLTuM6
         Jh1fVWhkOJxU1ZlXVqP3GP2kM3n1JGoByFUYNYuvy51g3BGec7v+ffP4EqqKzAGlKU/f
         YIkO6FCos5iPLmc+Sj41S2bLsjLpSMtjL62ebkBNIkDv3oFEqJUZgEiXtb7958JNDWw3
         QUg1N47iJi7tRbXXmIu9stIT19SJ850t/3c0t7HoyEesiKF+vdwfkcxKei6Se4mXikL+
         Ktbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=If23+I5OsLle0CeuHGRBPPsTloj+VqhA/YVdt5yI7Dk=;
        b=PKP1OggJOS/GJsrMQj5SpwCT958AAvns1LEPuMkOX+kV1GymLq1nb9YXPRj6OWIv/e
         0Zr67fP+K66M0Yy8qYgK4f4UIs7zQZScMUq7qGttLVaoxZJQ5WbTg6XTtv825dCj61aw
         yGyD8mS/JcIeXnMZ4GYA+TjfzgWxiQugt2eidO6P6qqjONmgef+kivEaJ6Wu8oZb0k3u
         BxSRgrriG579hfUdBQHjvMf355ryA8vQ7M5p6d49Aew+kFmV+ywQUDED5o3WenOkiJ3T
         zHr1zL8DGtjRSwQWPRurO3ueVWp4qnkJViqdVH5aQI75qFUNp0Zr207nIpj+HzDh/UEe
         bZLQ==
X-Gm-Message-State: AO0yUKUcj/k2sJE4mnfL1dcbFloRfwlLfTe7TbjlAE6S4H8VBtG152rH
        dcpLGmvrRvcobKXbBqqObCbJWFiTvZ8=
X-Google-Smtp-Source: AK7set+XGgxkaa2g/jyhE7ALl+WqNyIwmiO7FRFvcWIGHp+Zvvkd3Y1+Kbt5ID2k6ALegC37mzFSsA==
X-Received: by 2002:a17:906:2096:b0:878:8249:bef6 with SMTP id 22-20020a170906209600b008788249bef6mr13664868ejq.59.1675066621818;
        Mon, 30 Jan 2023 00:17:01 -0800 (PST)
Received: from [172.16.196.130] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d19-20020a170906371300b0088351ea808bsm3312194ejc.46.2023.01.30.00.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 00:17:00 -0800 (PST)
Message-ID: <7b2be002-aef7-f7b2-0e7e-9666d4179a52@gmail.com>
Date:   Mon, 30 Jan 2023 10:17:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] iio: accel: kionix-kx022a: Remove the unused member
 g_range
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org
References: <cover.1674996464.git.mehdi.djait.k@gmail.com>
 <e884d53fed0d8322d8be1de2593d4f5f8975af9c.1674996464.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <e884d53fed0d8322d8be1de2593d4f5f8975af9c.1674996464.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/29/23 15:37, Mehdi Djait wrote:
> The g_range member of the driver data struct is not used and
> should therefore be removed

Well spotted, thanks.

> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/accel/kionix-kx022a.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 1d3af42ec0e1..bb43cb0acce4 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -162,7 +162,6 @@ struct kx022a_data {
>   	int inc_reg;
>   	int ien_reg;
>   
> -	unsigned int g_range;
>   	unsigned int state;
>   	unsigned int odr_ns;
>   

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

