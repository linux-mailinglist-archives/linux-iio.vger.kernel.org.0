Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9B9364045
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 13:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhDSLPn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 07:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhDSLPm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Apr 2021 07:15:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FD0C06174A;
        Mon, 19 Apr 2021 04:15:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cu16so15728885pjb.4;
        Mon, 19 Apr 2021 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyLO68cYQAdbeG7I5stptSDRdNhYWf3KZX5hVoH8RUc=;
        b=tVD+Frbk3fpsSGakZ6vAUeXjiXHk6aLxIzoWOJ79QCPRe5sg+qOssPKCBuFpZ5ExOh
         cYbxMV4raTskb/a7ddC9H5i2BKwdEq7spfQHIlf2jVAkHJxBU0Ei6GsXCcCdL2QMpnuE
         NuGaQ74p+iU9G4sazo85cs6eV/ZPi5LU+H8jafL3qNVRBzyNmgrPMsxyXExPo+DHuwFv
         tdPpf/Vv0zAL3K2sebt2+RdE1DKO/JaqaSETVgIsu5ibHTsU6O17m3ulHZtfSBA3otBu
         36NS3LLD+mlC9bWFvFn98OLWOwUKvIpKeoMzxT9rPLm0PMCFOiMv5yHZ7jV44lhX0FUs
         RgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyLO68cYQAdbeG7I5stptSDRdNhYWf3KZX5hVoH8RUc=;
        b=mioWvyt+fHfRk88zYgm96AIrBvJoaQlcCMhkEQZjow9BrW4Y4NXqRIPY5HMyQRJQZk
         pK9c6F8eTDxhI0AaO/TSbDbOY+Mk1wY/unOAN/ksIvFen5ZKktNTMkeukiAzkX1NOyLP
         RY+OW9zc8qvhHZg7jMXe4nebJ3dV8inoKQ86CV7C9Uu3WJnfEmHe9rV3+My9sBln7wIT
         AIgO5kGQaU7IhEm7i0G0oSNJUW4fVAxG3rvzeSjQb0i52R1L6V9WCYwnLELWlv00DM1I
         VHk/IEhJII5yHE0iPYOQU564gSp2k3sX8rN2my8l3W1LLk6rZCsW/Vi4SPU4dbMHYT7F
         yJfQ==
X-Gm-Message-State: AOAM53144tzNkvaI3rzKuKugd1VjBMQo2OIK7pa8BSvxvcvZW/eizFZk
        KkZk5V395zG0nsnKMiMxEeDD7iKULBywJgpjojU=
X-Google-Smtp-Source: ABdhPJz+wzghLLCvx06cKOPWLeBhgarcoxi0Xt2i3Juf+K3Pdv7kq6+jr+XQ6egZQWF1rL5+Yj/RWsbr5jNrL4ku0SM=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr22295456plq.17.1618830911997; Mon, 19
 Apr 2021 04:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210416134546.38475-1-tomas.melin@vaisala.com>
 <20210416134546.38475-3-tomas.melin@vaisala.com> <CAHp75VcibWup79np=xeQpO2z+OGCFXPhL6vWL6aWRZ+G8+djwQ@mail.gmail.com>
 <91ea3aba-854e-30f1-1236-733debfcf5dc@vaisala.com>
In-Reply-To: <91ea3aba-854e-30f1-1236-733debfcf5dc@vaisala.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Apr 2021 14:14:55 +0300
Message-ID: <CAHp75VcWu96EAjzYYwt_gqscvJp3s9Y+ZnaK2NQa_=L+S+r5zQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: accel: Add driver for Murata SCA3300 accelerometer
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 19, 2021 at 1:29 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
> On 4/17/21 3:39 PM, Andy Shevchenko wrote:
> > On Fri, Apr 16, 2021 at 5:21 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
> >> Add initial support for Murata SCA3300 3-axis industrial
> >> accelerometer with digital SPI interface. This device also
> >> provides a temperature measurement.

...

> >> +       ret = spi_sync_transfer(sca_data->spi, xfers, ARRAY_SIZE(xfers));
> >> +       if (ret < 0) {
> >> +               dev_err(&sca_data->spi->dev,
> >> +                       "transfer error, error: %d\n", ret);
> >> +               return -EIO;
> > Why shadowing error code?
>
> Returning EIO here to have full control over the return value from this
> function. As return value of this is used for testing

Care to show what kind of testing requires this?
Also why can't it be refactored to accept all error codes?

> for possible status error (EINVAL), feels more confident to have it like
> this to avoid any confusion. And atleast spi_sync_transfer() return value
>
> would be visible in error message.

> >> +       }



-- 
With Best Regards,
Andy Shevchenko
