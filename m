Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9237C19E674
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgDDQ3m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 12:29:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30232 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726207AbgDDQ3m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Apr 2020 12:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586017780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yqtc2iXO4XwLwAH+Ev8DqQ8ksFmMxHRs6wL0orvLPSg=;
        b=J4AygyVdRfSYIYJgW7ho7kx8lkzX7IE/hv7U/Dl45q4Oe/i8b8oKMw1AY/wD61055stRGY
        Rs4psPmTCizHEnBQF0yu6zfwE3GJapAkQ6DMJTwT4dD6qFGI7ytDHZ3LkN0I3d5i8QMK6q
        evfrbIj5G6w4bZ2lgq1vmx4rvBc4duo=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-1t0BvXZUPsS4z7quBWV9lw-1; Sat, 04 Apr 2020 12:29:38 -0400
X-MC-Unique: 1t0BvXZUPsS4z7quBWV9lw-1
Received: by mail-vk1-f199.google.com with SMTP id q65so4137540vka.3
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2020 09:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yqtc2iXO4XwLwAH+Ev8DqQ8ksFmMxHRs6wL0orvLPSg=;
        b=ozorGiijcKLYGSNmGBzjcqKF9WvZv9W8cKimw5e8BE1l4wc0ZsBbSgz3rTWXZnuHZ3
         bhVlKTIC95RnkUqk8+Nol2FPPjnJA2o9k+OS88EyBEXIslUopx9pJ+2KAJaAADoIEA0i
         qkmPkxHAT+e7LaEV46Gu3quC5xI4AwYssjTbDkK83tgi7wicysdB7sFqGtcUpTMiC/yR
         yNBFenEjBFoFOvRggbmMWksQXoR4mxItMgu2mDXN6KqInf/XtuA5LxSd57wsLdvugwen
         oCvLRR5M9lNERr04XX62cEHAWyLhuF59To4S9nFKYFFOfBZx8yLYt3+r8D4vKneEUUcF
         yjPg==
X-Gm-Message-State: AGi0PuYi9AGXLG3ohXjCh1QBJswg9nSdwzbRpMphT2aC6S6cYwOsz0ib
        Pc3q6H2oT83kgK5+Lrb7isaXLOlt/ZJFon7qfYzXMq3wn0Q8OvmaRfo8b1XWaqAbXu92SfKDv1o
        kY9wvvD1DTm2WSh66QWYiAfOK8RyPhEsWOkSm
X-Received: by 2002:a1f:9a08:: with SMTP id c8mr10057468vke.20.1586017777230;
        Sat, 04 Apr 2020 09:29:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypKoI0DjM1bLM7YQjRkXsPf1BtEehW2nEGTwpMBUJPs2atS8XBHFRXloGct4Zt1D7St7MDkGihjE36P9u8Bz3SY=
X-Received: by 2002:a1f:9a08:: with SMTP id c8mr10057460vke.20.1586017776948;
 Sat, 04 Apr 2020 09:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <e9beff6b3a32ddf0de20821e50cf3ed562e36b48.1584122527.git.lorenzo@kernel.org>
 <CH2PR12MB4216CB1A1882DBE10CAAC967AEF60@CH2PR12MB4216.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4216CB1A1882DBE10CAAC967AEF60@CH2PR12MB4216.namprd12.prod.outlook.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat, 4 Apr 2020 18:29:25 +0200
Message-ID: <CAJ0CqmVmMe-YN-gYeS54cc_So1u-ARSQQkB_a+w6N2AZSeCGXg@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: flush hw FIFO before resetting the device
To:     "jic23@kernel.org" <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mario.tesi@st.com" <mario.tesi@st.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> Hi Lorenzo,
>
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Fri, Mar 13, 2020 at 18:06:00
>
> > flush hw FIFO before device reset in order to avoid possible races
> > on interrupt line 1. If the first interrupt line is asserted during
> > hw reset the device will work in I3C-only mode (if it is supported)
> >

Hi Jonathan,

any news about this patch? Maybe I am wrong but I am not able to find
it in your tree.
Thanks in advance.

Regards,
Lorenzo


> > Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
> > Fixes: 43901008fde0 ("iio: imu: st_lsm6dsx: add support to LSM6DSR")
> > Reported-by: Mario Tesi <mario.tesi@st.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > This is a new version of: "iio: imu: st_lsm6dsx: disable I3C support du=
ring
> > device reset"
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchwork.kernel=
.org_patch_11425389_&d=3DDwIDAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DqVuU64u9x77Y=
0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=3Dd7oUzE4fWeY3JqYqqd-uW_v1SJkij_sOpXRvpm3=
-Thg&s=3DBEgROrIZoG9oGrwQEENFz0DP88VioXUhpeZP2Y168XI&e=3D
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 24 +++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 84d219ae6aee..4426524b59f2 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -2036,11 +2036,21 @@ static int st_lsm6dsx_init_hw_timer(struct st_l=
sm6dsx_hw *hw)
> >       return 0;
> >  }
> >
> > -static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> > +static int st_lsm6dsx_reset_device(struct st_lsm6dsx_hw *hw)
> >  {
> >       const struct st_lsm6dsx_reg *reg;
> >       int err;
> >
> > +     /*
> > +      * flush hw FIFO before device reset in order to avoid
> > +      * possible races on interrupt line 1. If the first interrupt
> > +      * line is asserted during hw reset the device will work in
> > +      * I3C-only mode (if it is supported)
> > +      */
> > +     err =3D st_lsm6dsx_flush_fifo(hw);
> > +     if (err < 0 && err !=3D -ENOTSUPP)
> > +             return err;
> > +
> >       /* device sw reset */
> >       reg =3D &hw->settings->reset;
> >       err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > @@ -2059,6 +2069,18 @@ static int st_lsm6dsx_init_device(struct st_lsm6=
dsx_hw *hw)
> >
> >       msleep(50);
> >
> > +     return 0;
> > +}
> > +
> > +static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> > +{
> > +     const struct st_lsm6dsx_reg *reg;
> > +     int err;
> > +
> > +     err =3D st_lsm6dsx_reset_device(hw);
> > +     if (err < 0)
> > +             return err;
> > +
> >       /* enable Block Data Update */
> >       reg =3D &hw->settings->bdu;
> >       err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > --
> > 2.24.1
>
> I tested the patch and the I3C interface is working fine in this version.
>
> Reviewed-by: Vitor Soares <vitor.soares@synopsys.com>
> Tested-by: Vitor Soares <vitor.soares@synopsys.com>
>
> Best regards,
> Vitor
> Soares
>
>

