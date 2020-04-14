Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816BC1A856D
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 18:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436908AbgDNQnU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 12:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436882AbgDNQnT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 12:43:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C84C061A0C;
        Tue, 14 Apr 2020 09:43:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cl8so4338039pjb.3;
        Tue, 14 Apr 2020 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOohlzAiNKfUzsvao/Q2tVKLwGqeqHoBfplEnNk+A1M=;
        b=T2JB8l3JocTfBjxOI7PpooozKdlQ9JBHlQdMCz07hJdJXwuxWFwJP9SXp0WJH5bwq1
         eR5zFUYchzZW5JnxZtk7n7E/D2+8ni3blABsh3w3D9PefNTRy2L/kt19fMcLqFrLuL3M
         sgtmiDab+t0nhmCWySwYjbOksI4jhBG9n9dI7d43xmkSdtiFwiUtuONVDh1JvatXD76T
         l2BRljIIM+942pwrl/FhSrbDsNesSxZKXz+shgMQg6RLTwxHDbjuSeLojyUK3SbPWMJt
         HxjyBdEjUT+4fQl0T/6jLXeuvgYLxXeindxgYCXAtTZLOD4vDUqd74Ekhz86ub92WWsd
         fz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOohlzAiNKfUzsvao/Q2tVKLwGqeqHoBfplEnNk+A1M=;
        b=sR53mPJDJKAybvsko4JxZK6c2tSnN+ybcp+IuJYXpdUgOEtuhxTEkHYmdTSXUwB9jm
         0iFdzcjX28p9vYhuqOiy0BHYqlQrpMMEG4RV6nN//MWqS6Q9vow/dSaE9CkigLr2q35F
         J69AFKpREluFcE8AAkVGCP1FRJCurxso66NImTL+w36iVCx4Tbv0ogGBnn6VEce9Ughx
         sn0JMvvCtwvo8DfomlyKdQJHiFC5YLKT84eZd/b7dyABzf5STyz8RiUAVeMc+gyUhW50
         UOmhr+tj0MedLd3VOAbJ4lxQGpzy/di8CbisOHEO+ygx02sU2ySJGJIryDVG8hrr3WV6
         ecdg==
X-Gm-Message-State: AGi0PuYKngSuB+OSp9CoKylyY6q6PEHiiPJBgO2vzxQ6ScBsUtjD/iDL
        UFp2jTBBPx8suAV04d7yqR7E6y6cT6XDjQeGgjQ=
X-Google-Smtp-Source: APiQypIu1D5dL806JQXfQ/JKdGfF4gC8kgyPW+X8fK/e0eKjkozYSPlnET4zbmu/GSn3HKuAEC6w358C5Ks5h180L9c=
X-Received: by 2002:a17:90a:224b:: with SMTP id c69mr1181020pje.8.1586882598601;
 Tue, 14 Apr 2020 09:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200414153415.957-1-mani@kernel.org> <20200414153415.957-4-mani@kernel.org>
In-Reply-To: <20200414153415.957-4-mani@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Apr 2020 19:43:11 +0300
Message-ID: <CAHp75VdBvJRVxSTcWkPyW=ePhr2oPmKpEar=XsXF+KV+w1306w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: chemical: Add OF match table for CCS811 VOC sensor
To:     mani@kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, narcisaanamaria12@gmail.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 6:34 PM <mani@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <mani@kernel.org>
>
> Add devicetree OF match table support for CCS811 VOC sensor.
>

This looks good to me. FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/iio/chemical/ccs811.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index 951358710f64..310e9dedc9ba 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -538,9 +538,16 @@ static const struct i2c_device_id ccs811_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, ccs811_id);
>
> +static const struct of_device_id ccs811_dt_ids[] = {
> +       { .compatible = "ams,ccs811" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, ccs811_dt_ids);
> +
>  static struct i2c_driver ccs811_driver = {
>         .driver = {
>                 .name = "ccs811",
> +               .of_match_table = ccs811_dt_ids,
>         },
>         .probe = ccs811_probe,
>         .remove = ccs811_remove,
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
