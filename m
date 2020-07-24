Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACBD22CF5D
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 22:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgGXUZS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 16:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgGXUZP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 16:25:15 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827D9C0619D3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:25:15 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id c197so344008vkc.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xw0VogwRVAWx0Lb43RAqoeDJMMc+QTpBoKmnYilS2RQ=;
        b=XRSTbN397Lv5HHeBf0PTYdl5iZd1rOmSedSKhkZaHsHrh0GxxjtX6b4nTdhpWg0BFI
         QnTIUOT/ZAHwdv0qgtmzjoLu3kZPzEGgUctp+z9cRRhiKuJ9a9r8bbHcEzwxH7zko8Xj
         ie414LEULBOk/M6drV0y6T8EIUXoAB62lbyLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xw0VogwRVAWx0Lb43RAqoeDJMMc+QTpBoKmnYilS2RQ=;
        b=ciaU5iu91F3IhARaUtdBpZ/2e/oO5wSUmLTBBRnAqw4zm0bTmxfE6Vf4AIUTcDlQ5a
         SgngztsDu/Olyjw/XwLCUl8C3RUeWM+aq//ULYZrWNaDhboYeyOzfRm+bMLI8QGF3i42
         1aYIJDl/iQvU3jWa/YudoGZo2Ovv1Z1sNqrIXuzOAZq39iX+g0fBOrA2y7yC+trSOU3t
         h/kx2BlCBEZCJmfVW8W2q7v1Ai3mLYlMgUdiOVkvfl0w+UX1h5+5YPAttPzqua8HBWBD
         lIXZy+qc4kLTmzzhhQbxkUrjz25x8xQVIDSn5YDYI8WaWo1RIUAI/RC+y/F0AG23o7Ct
         kaxg==
X-Gm-Message-State: AOAM530FlvqS0aGeccSJuX6RfeGEoXPrITGgwPIASRzmVeEvoXGyIxRz
        nU6NUupgKXZ0lgm4ZoxHzf+sZr1PGIE=
X-Google-Smtp-Source: ABdhPJxYyAx50bm/Kf9ADtRcSQn4I/Agq8XKZjebphU9elWln+6lpCvv/kLUksHpUKT6kWiTjsP+lA==
X-Received: by 2002:a1f:788c:: with SMTP id t134mr8477216vkc.30.1595622314221;
        Fri, 24 Jul 2020 13:25:14 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id e22sm248542vke.40.2020.07.24.13.25.12
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:25:13 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id c197so343980vkc.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 13:25:12 -0700 (PDT)
X-Received: by 2002:a1f:61c2:: with SMTP id v185mr9671569vkb.42.1595622312356;
 Fri, 24 Jul 2020 13:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200723230344.1422750-1-swboyd@chromium.org> <20200723230344.1422750-4-swboyd@chromium.org>
In-Reply-To: <20200723230344.1422750-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 13:25:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsBkaMWSNFGimx3jFk==xsK+_NL-i1M0Dr_X9sc4EL9Q@mail.gmail.com>
Message-ID: <CAD=FV=VsBkaMWSNFGimx3jFk==xsK+_NL-i1M0Dr_X9sc4EL9Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: sx9310: Enable regulator for svdd supply
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Thu, Jul 23, 2020 at 4:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Enable the digital IO power supply (svdd) during probe so that the i2c
> communication works properly on boards that aggressively power gate this
> supply.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c | 49 ++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 84c3c9ae80dc..d21c17a4d541 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>
>  #include <linux/iio/buffer.h>
> @@ -131,6 +132,7 @@ struct sx9310_data {
>         struct i2c_client *client;
>         struct iio_trigger *trig;
>         struct regmap *regmap;
> +       struct regulator *supply;

Done need to store if you use devm.  See below.


>         /*
>          * Last reading of the proximity status for each channel.
>          * We only send an event to user space when this changes.
> @@ -914,21 +916,31 @@ static int sx9310_probe(struct i2c_client *client,
>         mutex_init(&data->mutex);
>         init_completion(&data->completion);
>
> +       data->supply = devm_regulator_get(&client->dev, "svdd");
> +       if (IS_ERR(data->supply))
> +               return PTR_ERR(data->supply);
> +
>         data->regmap = devm_regmap_init_i2c(client, &sx9310_regmap_config);
>         if (IS_ERR(data->regmap))
>                 return PTR_ERR(data->regmap);
>
> +       ret = regulator_enable(data->supply);
> +       if (ret)
> +               return ret;
> +       /* Must wait for Tpor time after initial power up */
> +       usleep_range(1000, 1100);

ret = devm_add_action_or_reset(&client->dev, sx9310_regulator_disable, supply);
if (ret)
  return ret;

static void sx9310_regulator_disable(void *regulator) {
  regulator_disable(regulator);
}

Then drop all changes below this line.


Seems like you could add support for the other regulator listed in the
bindings, too?


-Doug
