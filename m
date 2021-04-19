Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033B73641AF
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 14:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhDSMaF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 08:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhDSMaF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Apr 2021 08:30:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A56C06174A;
        Mon, 19 Apr 2021 05:29:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id j7so14723316pgi.3;
        Mon, 19 Apr 2021 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFlc5mbgU4DaSsMGvssgO49BiIPoeqfHq/MqZ+4QPPA=;
        b=rgu8PiRrM/fxkTfu2pgNzkPr4TvtZiGakzYCxIO1Dycip8BEmE8Nqzvfhb4J0DlNH3
         fRaaJaHHOnm1UvnMai04TnFcxVEPgAcE4479AXHk10M7EQMknVb2R0NPo+yv1aP6zQhU
         I/uhMtDapBeDZblE7Ru5Px7x/rZQ/py7ToodNHvi64djZxDUBkunoP90MobANJs9L7lr
         TeJVwqVKx9iyj+PEL+j5IL44GhV0fDJ6lRSQIf8gEHKLi0DPVqupJeRRBqnCISvsjlIo
         F+Rwr8xrDivpujt1iHFSJi93fj6lxS9Iz8ETfc7hYvcZ0M/i2RySMWoTur8qdD1MFVlo
         6yyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFlc5mbgU4DaSsMGvssgO49BiIPoeqfHq/MqZ+4QPPA=;
        b=NOrz6/CkoweT/i41Yubnw6FXKvTfzxnQqWmM8EUs5oEO5uV78nPSlboOzlVx1yQ8pW
         W/cK4vMFBU2JTDDntoIuv6hYwAk8c5pN57LDJxXC3x7Zbu5p2aoae/OId87PUxBYrI4x
         yZaxT528TlufbSFKluBveM/q09uDr5iRQKCIjorAtEvKC9cTp5n9OVkITgQ1ysG1vwux
         QHiPrAh4ViT9ZSoLvoSqlOMto/c7ZIty9yvusNuz6nrYlzLyX9iF2lFEXtxe/d8VQ8lh
         RYY0LjFgTzzDnMygSyqANbaGb5kktgzXIhY9zPXaimc3XqF0HoUm0FX7CVJjjQvk1NiS
         RjJA==
X-Gm-Message-State: AOAM5301IagBAMKEnPgu3ZTNMs6x04GxdJdoe5BCz8iMiE5H+qkspjzP
        CAhkdB8P0cMNyn0m+HvFTjY6gASNyx1b7cGaZU/Pctm/DtA=
X-Google-Smtp-Source: ABdhPJxp8WPaEQeDXxwjAc/0MLIYa+FO/MJPEHabR07raJpYigST9GgZYAG/LDfgL0b47ifxvrfyoM/LLjveLtPXLOU=
X-Received: by 2002:a63:cb44:: with SMTP id m4mr11714731pgi.4.1618835372151;
 Mon, 19 Apr 2021 05:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210416134546.38475-1-tomas.melin@vaisala.com>
 <20210416134546.38475-3-tomas.melin@vaisala.com> <CAHp75VcibWup79np=xeQpO2z+OGCFXPhL6vWL6aWRZ+G8+djwQ@mail.gmail.com>
 <91ea3aba-854e-30f1-1236-733debfcf5dc@vaisala.com> <CAHp75VcWu96EAjzYYwt_gqscvJp3s9Y+ZnaK2NQa_=L+S+r5zQ@mail.gmail.com>
 <9d6e9205-6fcd-1112-46da-2062e12311e1@vaisala.com>
In-Reply-To: <9d6e9205-6fcd-1112-46da-2062e12311e1@vaisala.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 19 Apr 2021 15:29:16 +0300
Message-ID: <CAHp75Vd_bV63rQLfGHk8uxROt=br33sZ18E14uAsuYkcQiMx-Q@mail.gmail.com>
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

On Mon, Apr 19, 2021 at 2:36 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
> On 4/19/21 2:14 PM, Andy Shevchenko wrote:
> > On Mon, Apr 19, 2021 at 1:29 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
> >> On 4/17/21 3:39 PM, Andy Shevchenko wrote:
> >>> On Fri, Apr 16, 2021 at 5:21 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
> >>>> Add initial support for Murata SCA3300 3-axis industrial
> >>>> accelerometer with digital SPI interface. This device also
> >>>> provides a temperature measurement.
> > ...
> >
> >>>> +       ret = spi_sync_transfer(sca_data->spi, xfers, ARRAY_SIZE(xfers));
> >>>> +       if (ret < 0) {
> >>>> +               dev_err(&sca_data->spi->dev,
> >>>> +                       "transfer error, error: %d\n", ret);
> >>>> +               return -EIO;
> >>> Why shadowing error code?
> >> Returning EIO here to have full control over the return value from this
> >> function. As return value of this is used for testing
> > Care to show what kind of testing requires this?
> > Also why can't it be refactored to accept all error codes?
>
> I was referring to this:
>
> +static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
> +{
> +       int ret;
> +
> +       mutex_lock(&sca_data->lock);
> +       sca_data->txbuf[0] = 0x0 | (reg << 2);
> +       ret = sca3300_transfer(sca_data, val);
> +       mutex_unlock(&sca_data->lock);
> +       if (ret == -EINVAL)
> +               ret  = sca3300_error_handler(sca_data);
> +
> +       return ret;
> +}
> +
> +static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
> +{
> +       int reg_val = 0;
> +       int ret;
> +
> +       mutex_lock(&sca_data->lock);
> +       sca_data->txbuf[0] = BIT(7) | (reg << 2);
> +       put_unaligned_be16(val, &sca_data->txbuf[1]);
> +       ret = sca3300_transfer(sca_data, &reg_val);
> +       mutex_unlock(&sca_data->lock);
> +       if (ret == -EINVAL)
> +               ret  = sca3300_error_handler(sca_data);
> +
> +       return ret;
> +}
>
> So this goes into error handling only when transfer indicates EINVAL
> (which happens when
>
> transfer otherwise is good, but device return status has error flags set
> i message).

In such cases I would recommend introducing your own error space (with
positive numbers) or playing around with the number of transfers (but
this usually works only if you anticipate several of them in a row).

Something like

#define SCA3300_ERROR_FLAGS 1
...

if (ret > 0)
  return error_handler(..., ret); // ret in case if you want to
convert the code to something in Linux error code space.

> >> for possible status error (EINVAL), feels more confident to have it like
> >> this to avoid any confusion. And atleast spi_sync_transfer() return value
> >>
> >> would be visible in error message.
> >>>> +       }

-- 
With Best Regards,
Andy Shevchenko
