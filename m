Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDC461EF91
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 10:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiKGJuv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 04:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiKGJuu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 04:50:50 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAFF6578
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 01:50:49 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id r81so8382464iod.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Nov 2022 01:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ncLpQO0jtkFJO9tU8yV3uX5OrU0I8qwWFBw/f+h3WkM=;
        b=BF8aP4ZoD5U5lJ15GAnYo6qcW6ZY0Qz7W3ig5OdKEz7DMN1OBLDX8y64gFQbMiXfbN
         vxsr0lAiRnuG5btbLSB96ztBk1SxCmW/OmsCazP0v7RQQTci/gBnmEQg5h3ji8bcry3E
         fOM3Weyrgz4f6MSUSvHNBT+yvDa9DlDZjgYBlkI7nmfjQx6KFaLQLGHmuJ7gXGHO7Gxk
         0bwFuqNfBgjrWEehQSufgTmfa/P5C6hfnPsfEhaiMXGmhZYioSiE8CIGqIcTKmR7OQz3
         BGbzik/H0DSUM1XhH86AfBlQ9bXwjgg2+Wdg17sj40Sz0jNptDHyAVR2rMpgJtt/X4NM
         /TlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncLpQO0jtkFJO9tU8yV3uX5OrU0I8qwWFBw/f+h3WkM=;
        b=yYwILQp6mex178YNT3GbIL2nPdc0ZOQRP+92Qms+Qsr7Z2PCTyH5NAQhWr3A030Erq
         UBpailBkfydomD8UNQoMXlgY1P2RAGHOjiLg9GbV1R1osEH3zFeU5tcardQNR1iguHHK
         O1eZfpcoO04iVgzYZ4ZEZSI07CxR/6wWdTF7eh1px7z19g7eL4gJ1+Z32Y4uWkR+GqUt
         Yk50tH1TsBnHwe9uwlyHQUF0f5t+dbtxbASLxoaSSM7OcIhZr9pF6ss0xxmeWPzUt7fJ
         iiLIb6qEjX3HClqTpuOySwMRfCJZoVlBTCn59AltPzCPaNRcH6NK+DYNBJnJ4Wb83IkI
         ebVQ==
X-Gm-Message-State: ACrzQf3zNKzGVhnKF7PM4QN+qvRWtRohIUzVuc2a6zhAtR3PG4n8LVOj
        KU95IH1rJZmlX0ERNtvMCJD08raIc2tjj4/hUO68bg==
X-Google-Smtp-Source: AA0mqf5wnM887T4W7d8zNW3jwKUdHCPI9xeXs94V4a3wTB5FRGjycl2rJANoxmUgTierg7EmPutJ2KO0tB44hFuoxGc=
X-Received: by 2002:a02:330c:0:b0:375:b652:7863 with SMTP id
 c12-20020a02330c000000b00375b6527863mr5950237jae.32.1667814648681; Mon, 07
 Nov 2022 01:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20221105125108.383193-1-jic23@kernel.org> <20221105125108.383193-2-jic23@kernel.org>
In-Reply-To: <20221105125108.383193-2-jic23@kernel.org>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 7 Nov 2022 10:50:12 +0100
Message-ID: <CAKv63uttO539kP4D-MBF4AjyEeB2LD8Ny4Caq_W5HiwgcO+efg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: temperature: mlx90632: Add error handling for devm_pm_runtime_enable()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, coverity-bot <keescook@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        coverity-bot <keescook+coverity-bot@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-off-by: Crt Mori <cmo@melexis.com>

On Sat, 5 Nov 2022 at 13:51, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This call can fail so handling is necessary even if it is very unlikely.
>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527134 ("Error handling issues")
> Fixes: c83d3e5ca97f ("iio: temperature: mlx90632 Add runtime powermanagement modes")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index a17fe5f4967a..7572ae3f8432 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -1267,7 +1267,10 @@ static int mlx90632_probe(struct i2c_client *client,
>         pm_runtime_get_noresume(&client->dev);
>         pm_runtime_set_active(&client->dev);
>
> -       devm_pm_runtime_enable(&client->dev);
> +       ret = devm_pm_runtime_enable(&client->dev);
> +       if (ret)
> +               return ret;
> +
>         pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
>         pm_runtime_use_autosuspend(&client->dev);
>         pm_runtime_put_autosuspend(&client->dev);
> --
> 2.38.1
>
