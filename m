Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B5155EB1
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2020 20:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGTpZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Feb 2020 14:45:25 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39170 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGTpZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Feb 2020 14:45:25 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so795498ioh.6
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2020 11:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lPYHWB1clo/zt5lx0lgH0H2d974i2DzLaBDz4EaGRF8=;
        b=c8z+98NjP4L+ykxX8U06pwkB7VD1RmMWX/Wp/g6Y8MdIoarhI6g3jhrfPuVqpmaa+/
         BmNJVlGh3DIO2OsJyVTThP5j2ZzBlgKz4InQBznBp3KIXPZsHoCnjSBrBiXRB58m5OH8
         su4MYFV+hdopRXpfIkOTp7MxcJhgOYl1GgGBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lPYHWB1clo/zt5lx0lgH0H2d974i2DzLaBDz4EaGRF8=;
        b=RBHOUucVrVd39qqVhb5L2E+NYsS28Sn+WlFtB85lL/PLbP6F4UYFKhWR8xeyRwqzGC
         zYpJj2IArPaOpegxb3VyvJ/2hx2KPzRECjrb/RPqPHmucZuSmgipVR/itUt+KkMRPKNX
         50vkeEHp7UuaOPrlA+qzeY/4nV7uog/2hMO5vZcC2MLY1TDvaO1uW+9Cl1L3XrSD3H9O
         +LrWrCFbtMkj1Plwf0CujtyN+z3PYLqELVXbwKy857+eJUH74omXRxDcfzp4R0vSoxaV
         6t8MbNFrhNsBNUAPGTCh554ROSa895Pc18uHMHGNaRdQuRuK4n8Ij9w4fwD4RoWvBhju
         3WcQ==
X-Gm-Message-State: APjAAAVh+Q7wgOo4q93YxyNHV3OlIZrFez2NB5fi7ju+I+VUeCNPtXXF
        NdXnGhHnt33NRSeFaYlfbsm6md1U9Z3rKW8Ljk0kkw==
X-Google-Smtp-Source: APXvYqw5uwAkn33O9wLLDDnI9SFctWgc3sYeTPDCRMkhYPJlzb3CFnceG1Cmvj9Ijpygjy1Je0NxH79gDV/y2sIkoyM=
X-Received: by 2002:a02:ce87:: with SMTP id y7mr148364jaq.26.1581104723318;
 Fri, 07 Feb 2020 11:45:23 -0800 (PST)
MIME-Version: 1.0
References: <19efdcd597b21ece9ad0ff894b6566d2ef4e2c02.1581066317.git.agx@sigxcpu.org>
In-Reply-To: <19efdcd597b21ece9ad0ff894b6566d2ef4e2c02.1581066317.git.agx@sigxcpu.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Fri, 7 Feb 2020 11:45:12 -0800
Message-ID: <CAJCx=gmoX2NO_AQKX_MddYAB7uVyB2OTDSSJE1yLb7Y36QMntA@mail.gmail.com>
Subject: Re: [PATCH] iio: vncl4000: Fix early return in vcnl4200_set_power_state
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 7, 2020 at 1:12 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> Don't return early unconditionally.
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

>
> ---
> I've not added a 'Fixes:' line since this is not part of Linus tree yet.
> Tested proximity and ambient light on a vcnl4040 and checked the driver
> suspends/resumes correctly and puts out valid data right after resume.
>
>  drivers/iio/light/vcnl4000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 3b71c7d538af..38fcd9a26046 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -149,7 +149,7 @@ static int vcnl4200_set_power_state(struct vcnl4000_d=
ata *data, bool on)
>         if (ret < 0)
>                 return ret;
>
> -       return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,=
 val);
> +       ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1=
, val);
>         if (ret < 0)
>                 return ret;
>
> --
> 2.23.0
>
