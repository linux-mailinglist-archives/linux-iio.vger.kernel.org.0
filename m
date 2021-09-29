Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FBB41C1E6
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 11:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245124AbhI2Jrz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 05:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbhI2Jry (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Sep 2021 05:47:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B698C06161C;
        Wed, 29 Sep 2021 02:46:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so3784130pjv.5;
        Wed, 29 Sep 2021 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRb6GtweOQTJtQqt+eAkXwu4EBYpz5bP1O98wcEaZU8=;
        b=peGr8gYEJb+0TyUtZ7vqBPpXueOkDMlS1axF66LFGp+fItysdUtbt84LO85Cs0dtzq
         cm/1L7v8/EfQL6k42GyPV0KORoqxqpv4NwJT+chv0riK852/UnxsfsckGRcUmyFmj2U9
         fXp4fvTybVim0j29gBmxqYatGnkHyIE887VAabtHKM/DIESvgRzGuFwjV1gWermpOjnC
         Li7PPTRmQmgwSDIcBdbalmsBzV2MyyarRyhYpaZlUFX1Ws26MZSQMsJH3g5u1Z8c1vk4
         tSIPBekiXfOD1MPPPpEuC9FiruF75kmFceSTLe/3sLgTdCPDKKUsKAzzLkvA0o+Sbphn
         XQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRb6GtweOQTJtQqt+eAkXwu4EBYpz5bP1O98wcEaZU8=;
        b=T1HpAolBZ98HZoOsqnI5MPlni0ntYoNfemKTwY7O4UvHvptAunmpU7tAC53w6t3u6D
         OWPBxwcNnVEDnoInL8sO3PxjGIqtvJ6lIv5+hLZpx3xpNFmxfGh7v0cC/53L3yBbRz1d
         hRvct+oW0jFuWD3gZkdzxtgnWF/qMPCZE2uO4JAjBMc+LtE+Vs249bKHfNkYzdV896R3
         L8mXnMuRfHokktsVeDMj6Nw612mjkLhkFVG1GrSMwk0fVK7vLB9REl/9kK1YGxTer5LI
         7RXk20nECzna55CanDMLz1LSagBKRlt2zr5O9aKQ+xZHsCubzKFcBoyuHGoQqxo+tGkt
         f//Q==
X-Gm-Message-State: AOAM531E2+OFufc/cGB5pE3P5U7uyqaFi4evM79guO+G7/1xdQ42SWbf
        /vLthWRqgvaeps/ICg0//PrZlCv8UilaaMbVRCM=
X-Google-Smtp-Source: ABdhPJyNHGVfB/KAkq26HeUsgGiNNXl30qfjOQrV4zyIPODAsfprNyULY2ZqvDgpdZkB//X15w04QkV/jc/Av+X9w0I=
X-Received: by 2002:a17:90b:38cf:: with SMTP id nn15mr5446613pjb.81.1632908773663;
 Wed, 29 Sep 2021 02:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210928195548.17846-1-pekka.korpinen@iki.fi>
In-Reply-To: <20210928195548.17846-1-pekka.korpinen@iki.fi>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 29 Sep 2021 12:46:02 +0300
Message-ID: <CA+U=DspS04Crdr7OwfrTuBueTYOA+rV9sS0_mB-Q9+hsoufxKw@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5446: Fix ad5622_write() return value
To:     Pekka Korpinen <pekka.korpinen@iki.fi>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 28, 2021 at 10:57 PM Pekka Korpinen <pekka.korpinen@iki.fi> wrote:
>
> On success i2c_master_send() returns the number of bytes written. The
> call from iio_write_channel_info(), however, expects the return value to
> be zero on success.
>

Requires a Fixes tag.
But other than that:

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Pekka Korpinen <pekka.korpinen@iki.fi>
> ---
> This bug causes incorrect consumption of the sysfs buffer in
> iio_write_channel_info(). When writing more than two characters to
> out_voltage0_raw, the ad5446 write handler is called multiple times
> causing unexpected behavior.
>
> A similar fix was applied for ad5064.c in 2015 - commit 03fe472ef33b
> ("iio:ad5064: Make sure ad5064_i2c_write() returns 0 on success").
>
>  drivers/iio/dac/ad5446.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index 488ec69967d6..dfd541bbde5b 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -531,8 +531,13 @@ static int ad5622_write(struct ad5446_state *st, unsigned val)
>  {
>         struct i2c_client *client = to_i2c_client(st->dev);
>         __be16 data = cpu_to_be16(val);
> +       int ret;
> +
> +       ret = i2c_master_send(client, (char *)&data, sizeof(data));
> +       if (ret < 0)
> +               return ret;
>
> -       return i2c_master_send(client, (char *)&data, sizeof(data));
> +       return 0;
>  }
>
>  /*
> --
> 2.33.0
>
