Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A541C6E8F
	for <lists+linux-iio@lfdr.de>; Wed,  6 May 2020 12:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgEFKi3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 May 2020 06:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728338AbgEFKi3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 May 2020 06:38:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABEDC061A0F;
        Wed,  6 May 2020 03:38:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a5so671626pjh.2;
        Wed, 06 May 2020 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1OkzDtpIyQuO7IKIy35A+BZWVbOn5RiVMSLQdPPTaSc=;
        b=cfeMbzjjr2O4Cw1uSwSiiOnq7ozVGG9+v0gmcQMqOdBGNT94BtXZeH1Vk0DpoIaAJ9
         Tllhu5B8YINCJR6KvA87+KtaEftkw2Hj+qPDr0N7dih/CK0166AMBKfxUJ4JgOG6ujKR
         UEo4flpajmZABW4JGOjPD+mqNoenPHGzcRKoatZBzZGBOBu/8CwjQ77cHoCmPm24tM+L
         bEH5L7IHljTsB1bC1Qvv28aFGS8RKx3ewTBxyUR0G3Tbkwno4CbtDs9mLomGZBD1q1IT
         ZnN2XJBvG4uHXGM9774PbHY4gDBTF/0YqeoUIHoWtgZ1eO2ZBwdwW9WxmINyrR2JJYzH
         gyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1OkzDtpIyQuO7IKIy35A+BZWVbOn5RiVMSLQdPPTaSc=;
        b=Cfpm4/LIeZHSRcHNGdZ6TvXilXqVB5SKFaa0AspgOWUDGLcmZiXkur/MseMIp3J75s
         gTCeaJ2JPx67Ypxi2XHA59izeUb9tdEGTijrk+ROSSkWP0VAGhH+l1foRtImfBoJN1vb
         424qPC2GCWadmV5A67U/1hoNLe5hrY5WVvN0AoMACR//mTL6qydxuL+bcBs4xEz5gi+O
         VXg3ge9LdXUmohmV5WjbWV6pP3JPzJpcuil26ApiUBu7C9dOgZATobGPpX0hYLAVpiWT
         bzJkABogg9MbisI6HoaRLd/Fa9gEImIkBk68/Q63gunZDlNZRH0elp3EE0gT2vUCCxhc
         7Tgw==
X-Gm-Message-State: AGi0PuZ9zdJ2xSydLBizZqYhg2mWmL2GPtn9BOIjzCQH/+uVPgWXxRDu
        AQVkKEs5854WBXDS8glvaGcDAGiIQsm57g/WPWJxnK7opSE=
X-Google-Smtp-Source: APiQypIQSsE756MmU5Ui9qd6Ru5n1fOj18yZcTKTZaLH1fRbMTqqyO0CS+qusaR0TW0AGLITbhdOtcSi1Yf7K190AJA=
X-Received: by 2002:a17:902:6901:: with SMTP id j1mr7086450plk.255.1588761508837;
 Wed, 06 May 2020 03:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200506035206.192173-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200506035206.192173-1-christophe.jaillet@wanadoo.fr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 May 2020 13:38:22 +0300
Message-ID: <CAHp75Vdi+ZYpQPHgoREQ6LTaUHTPmNkR7ULZaVNTJr7Bvh-q9Q@mail.gmail.com>
Subject: Re: [PATCH] iio: sca3000: Remove an erroneous 'get_device()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 6, 2020 at 6:55 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> This looks really unusual to have a 'get_device()' hidden in a 'dev_err()'
> call.
> Remove it.
>
> While at it add a missing \n at the end of the message.
>

It should have Fixes tag because it is a quite an issue (get_device()
breaks reference counting with all problems we may expect).

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is purely speculative.
> I've looked a bit arround and see no point for this get_device() but other
> eyes are welcomed :)
> ---
>  drivers/iio/accel/sca3000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 66d768d971e1..6e429072e44a 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -980,7 +980,7 @@ static int sca3000_read_data(struct sca3000_state *st,
>         st->tx[0] = SCA3000_READ_REG(reg_address_high);
>         ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
>         if (ret) {
> -               dev_err(get_device(&st->us->dev), "problem reading register");
> +               dev_err(&st->us->dev, "problem reading register\n");
>                 return ret;
>         }
>
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
