Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CEF34F8E9
	for <lists+linux-iio@lfdr.de>; Wed, 31 Mar 2021 08:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhCaGmY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Mar 2021 02:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbhCaGmM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Mar 2021 02:42:12 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881CBC061574
        for <linux-iio@vger.kernel.org>; Tue, 30 Mar 2021 23:42:12 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e8so19017788iok.5
        for <linux-iio@vger.kernel.org>; Tue, 30 Mar 2021 23:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8zvzcX1fU+/ksK3JExZzqQhTbUc6jUOKZ/SVacs6ig=;
        b=rV3HUlpqq5saRYMfNuYd0eAASuXCiIMND+kBmTGc5y2VX2L3jnYnPyjh6jrmLdKqBk
         6NSgWWEJc1PdUVm41J/sTcYNIEv1mvny6OvugDN6KFjjS4kTTofKitLAAIU1PM3tcM7x
         nJAvzdymDXWbMiIxELlJFegCl6iDI4sbv84/wQAFtl/zBui39FmeCDGW91rMjmWgRQdi
         6Pr4cmY3WgKHfnNqi4o5Tx0G/uQ94Dpqgcqx+Wvtj8mPiS3s4cjYu3jGDd9pu2fpzQTR
         QmuD/HGwQ4KqPsiStD5+a7PNlZJC+mUck0gl4tMmbiz5BFeIqobCqRu0xm6DhyzmFyPc
         13gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8zvzcX1fU+/ksK3JExZzqQhTbUc6jUOKZ/SVacs6ig=;
        b=d900WhAlsNxZPC8zsCf+8l3MYbDbed/p5xccN67ZzXYThPN1lidRmDlMh4libKk4hB
         h2KSzTPMySlRsh9sK7XQNFlFiNL80Z6Bmib6dx8nOStGboV/BNAOfIge2QDYXp5P2MuM
         T3ikuAyVbo8NlIPYoRSqhBOi5YEM2f5aOzwgod4drdpHsuiUo8Mnst4Ufnc80cRjuv8e
         zHZj6QC1ZDWHNVrqCYOf+QWxCXsGDGcB9n+KEMb6lt4D532kFvyoWQaOhYoDx+EOpAIe
         DaI6tencgrUqxX1J4sG0iny7VEDw5nVycj8w0No0iX3IF6A+IiQoSCHYwXXSYNRhMs8z
         RaJw==
X-Gm-Message-State: AOAM5300yjIxiB5ehyPw98s7lpaBv7ycnjIC8PQP1WY9cDMjaWLvMr5N
        43hLdu1lVV5YCV143ouE+ArIrbSOD9y5ClKG+VP9q7g+6bU=
X-Google-Smtp-Source: ABdhPJzURj7p0PhFXvOBeBjh87ygjw+vxxAQj1pZOeRHP7n9EWOQBqySn2xG8mZK05kKBDdiGX0ItTrmG7ryMMW5GCU=
X-Received: by 2002:a02:cd33:: with SMTP id h19mr1705243jaq.88.1617172932027;
 Tue, 30 Mar 2021 23:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210314181511.531414-1-jic23@kernel.org> <20210314181511.531414-21-jic23@kernel.org>
In-Reply-To: <20210314181511.531414-21-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 31 Mar 2021 09:42:00 +0300
Message-ID: <CA+U=Dsqdobgbg9nOFfqXLpN--mAKnVZnnwT+m_tg7r2Ujm3pQg@mail.gmail.com>
Subject: Re: [PATCH v2 20/24] staging:iio:cdc:ad7150: Add of_match_table
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Rob Herring <Robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 14, 2021 at 8:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Rather than using the fallback path in the i2c subsystem and hoping
> for no clashes across vendors, lets put in an explicit table for
> matching.
>

I thought I replied on this.
Seems I didn't

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Link: https://lore.kernel.org/r/20210207154623.433442-21-jic23@kernel.org
> ---
>  drivers/staging/iio/cdc/ad7150.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 30abfacda074..0afad49bcddc 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -12,6 +12,7 @@
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>
> @@ -655,9 +656,16 @@ static const struct i2c_device_id ad7150_id[] = {
>
>  MODULE_DEVICE_TABLE(i2c, ad7150_id);
>
> +static const struct of_device_id ad7150_of_match[] = {
> +       { "adi,ad7150" },
> +       { "adi,ad7151" },
> +       { "adi,ad7156" },
> +       {}
> +};
>  static struct i2c_driver ad7150_driver = {
>         .driver = {
>                 .name = "ad7150",
> +               .of_match_table = ad7150_of_match,
>         },
>         .probe = ad7150_probe,
>         .id_table = ad7150_id,
> --
> 2.30.2
>
