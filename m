Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857933C1DDB
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 05:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGIDjV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Jul 2021 23:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhGIDjV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Jul 2021 23:39:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D4DC061574;
        Thu,  8 Jul 2021 20:36:38 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p1so20354662lfr.12;
        Thu, 08 Jul 2021 20:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgObjxd836J01Nl5oCqassoOm41G96StAN2mBy6f6k4=;
        b=M33c2EL7z+WEZC3oDvuC3shlwtFr4uiO3JilGf9Eo4z6vLw6dx+Jf+BZ36qnTRiA18
         6Wb5vaAAAMAKIRgRGaFzSMoKV/b9G/mphNE3Ygrs3MUoI3tOtVBGhkBpcgBb3/qGThlM
         wX/+0FWZ1Ejtgd+2u+/PVDbklQgiSvMmgKXy4OyL5HlGTe8MMy03rFBbCYoEGvJhxoLU
         usBTJ6Bx0yn4xScP4jbLaXF5ePg7w4rJlum2bTAgyU33jawZj9VGWVysTJ7oQ3/EuBIV
         FRAv/EE/1q4ccZdJnJPplMJJtbrSVYmoOsCsqlfi22hfN2LNRgkCHRRhv91Db3WdvUqN
         Nkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgObjxd836J01Nl5oCqassoOm41G96StAN2mBy6f6k4=;
        b=fI83NZzIVYxmy4JCz0nmoVHRJnbg2Pshyorgcwli+qcatlAu7+sSOLrTQFcrYUpmBU
         YhlbWjDORGVqql8eYlPr/YT/cdEChZFUW5otrXDREqbRthZt5EEZunm9niUAXaGQq+r4
         fua/pAZv5i5/XJIYdBGCm8Mbkur1eqhukFnOGpkxVeJS4Lqx1zvom8bavZMRdfgYivHD
         BEKDiujanl/xmVthvjjjfCnriSURkyMAh2JqU89zSBPyaOC/rA93EI0K74weIvYICcx6
         jpUMlPYAGYCuwvsk7WJFnFNTT2L+03o2HC8yFAnR+A7li4Rn7l9JwGosv8Nq2SmFrsma
         AiYg==
X-Gm-Message-State: AOAM530rITqJSWT1uxtdZeKzfE9rJRy/CgsYdXJtF5LCWcn6G6NS51Ne
        z/vfN28YRJH28kzFC+DtNIRXDhPfAclHqEoEXvA=
X-Google-Smtp-Source: ABdhPJyDqDlrpIzJfkA7MkaBaE2HUpGUAL9UjDk3tOBMXIdWPUxXBAEJvNWAsn7kBZzQ85vEDHGwLlkIUBDzGFYqiVM=
X-Received: by 2002:a19:5016:: with SMTP id e22mr24174635lfb.539.1625801796743;
 Thu, 08 Jul 2021 20:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210709031526.30746-1-jrdr.linux@gmail.com>
In-Reply-To: <20210709031526.30746-1-jrdr.linux@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 9 Jul 2021 00:36:25 -0300
Message-ID: <CAOMZO5BHDBR5y5q559UexTmYbhPwSp1MV3TJ3k+z4W8ehE-5_Q@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: fxls8962af: Initialize return value
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Souptick,

On Fri, Jul 9, 2021 at 12:17 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> kernel test robot throws below warning ->
>
> smatch warnings:
> drivers/iio/accel/fxls8962af-core.c:640
> fxls8962af_i2c_raw_read_errata3() error: uninitialized symbol 'ret'.
>
> Initialize it.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/iio/accel/fxls8962af-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 078d87865fde..8af1c8f58e83 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -628,7 +628,7 @@ static int fxls8962af_i2c_raw_read_errata3(struct fxls8962af_data *data,
>                                            u16 *buffer, int samples,
>                                            int sample_length)
>  {
> -       int i, ret;
> +       int i, ret = -EINVAL;
>
>         for (i = 0; i < samples; i++) {
>                 ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB,

Would the change below work?

--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -637,7 +637,7 @@ static int fxls8962af_i2c_raw_read_errata3(struct
fxls8962af_data *data,
                        return ret;
        }

-       return ret;
+       return 0;
 }
