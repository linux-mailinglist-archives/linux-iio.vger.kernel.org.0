Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46AE419E698
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgDDRJf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 13:09:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39229 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726148AbgDDRJf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Apr 2020 13:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586020173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QWRTCLa8Lrg41uT4tash6NtlYbsWQwWBHYcndSdHsf0=;
        b=UpBj5TZX/PzNgB6ZJvmz5I4cxTdwYBdvS2faUzC68ws7idXFuzz9RjbZ6L76bBcwd0hC1J
        yl5ljMbIyis+EiIIqRytNZnVfiP/+ltMjVKtlQEURyLRUgTi/3lUl6MegZiWbmjy6ajZQW
        gRiooU9Iy0kBvkhST8J3UU+HadzUKVg=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-3EWWemJLMd2I5bUxsjIkmw-1; Sat, 04 Apr 2020 13:09:30 -0400
X-MC-Unique: 3EWWemJLMd2I5bUxsjIkmw-1
Received: by mail-vk1-f198.google.com with SMTP id f7so4151444vkb.20
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2020 10:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QWRTCLa8Lrg41uT4tash6NtlYbsWQwWBHYcndSdHsf0=;
        b=RXzVTKsOYZiATgaU3j9G40tbb1co665VQKwIp9KGhWTcjXEBr5yDxwfVmad45/DE0e
         rllS1cAWTK4WR97c0fCmpQmlkwCNdbehNK1+38Rjvb7H0XCiNinisu7GgK9AG12iTe6y
         BcrjWN4AGzGI1FFzjoLYLqEid/5JFjfNpsZ9uU5tPm+/u5QgXtjROfekME+dRENRbB+D
         PJO809GYNLxStHv/14tpfprq+klueboF7iykeRm6IaBrA/atozw1I+YQBo743t7J0UU1
         WD6sBBItdTPoZnGxXGz/xNg98auSsHpkSY03Q/0IEPO6BnZxJ9TWTbdQHrincg0JAn4P
         YISQ==
X-Gm-Message-State: AGi0PuaQaTyHYnSdgpy0TdORgyA/A5uxiV6ajlSzf9Jdy0DRvie8BUS5
        ZI/GKmQADwHv3ue7P4UvLuNQubpQP4zrPnZBHbN5DtaRczWMp2/hVJpojgDG94viJPXx+rCV3GD
        5UbjAMvDqryf+RTdDQtThcz+2q4acgPgdVrTd
X-Received: by 2002:a05:6102:7c3:: with SMTP id y3mr7065685vsg.64.1586020170184;
        Sat, 04 Apr 2020 10:09:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypLs1M7CiZbB//2kHGlGCd4AY6/8c98UCnAZaDk19f3JdjAZES8EMYd8tWUXZLuiThpZFCiNUdu64iYWcWJeW2I=
X-Received: by 2002:a05:6102:7c3:: with SMTP id y3mr7065670vsg.64.1586020169827;
 Sat, 04 Apr 2020 10:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <e9beff6b3a32ddf0de20821e50cf3ed562e36b48.1584122527.git.lorenzo@kernel.org>
 <CH2PR12MB4216CB1A1882DBE10CAAC967AEF60@CH2PR12MB4216.namprd12.prod.outlook.com>
 <CAJ0CqmVmMe-YN-gYeS54cc_So1u-ARSQQkB_a+w6N2AZSeCGXg@mail.gmail.com> <20200404180642.6e2014c6@archlinux>
In-Reply-To: <20200404180642.6e2014c6@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat, 4 Apr 2020 19:09:18 +0200
Message-ID: <CAJ0CqmWaUp+H9GiEedjZ+Wc+=Bj=Adv60LeKqPrCmH2vD4sM9w@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: flush hw FIFO before resetting the device
To:     Jonathan Cameron <jic23@kernel.org>
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
> On Sat, 4 Apr 2020 18:29:25 +0200
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>
> > >
> > > Hi Lorenzo,
> > >
> > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > Date: Fri, Mar 13, 2020 at 18:06:00
> > >
> > > > flush hw FIFO before device reset in order to avoid possible races
> > > > on interrupt line 1. If the first interrupt line is asserted during
> > > > hw reset the device will work in I3C-only mode (if it is supported)
> > > >
> >
> > Hi Jonathan,
> >
> > any news about this patch? Maybe I am wrong but I am not able to find
> > it in your tree.
> > Thanks in advance.
>
> I'm running a bit behind on catching up with fixes after it became obviou=
s
> they wouldn't make the merge window.
>
> Applied to the fixes-togreg branch of iio.git and marked for stable.
>

ack, thx...sorry for all the noise around it.

Regards,
Lorenzo

> >
> > Regards,
> > Lorenzo
> >
> >
> > > > Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO"=
)
> > > > Fixes: 43901008fde0 ("iio: imu: st_lsm6dsx: add support to LSM6DSR"=
)
> > > > Reported-by: Mario Tesi <mario.tesi@st.com>
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > > This is a new version of: "iio: imu: st_lsm6dsx: disable I3C suppor=
t during
> > > > device reset"
> > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__patchwork.ke=
rnel.org_patch_11425389_&d=3DDwIDAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DqVuU64u9=
x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=3Dd7oUzE4fWeY3JqYqqd-uW_v1SJkij_sOpXR=
vpm3-Thg&s=3DBEgROrIZoG9oGrwQEENFz0DP88VioXUhpeZP2Y168XI&e=3D
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 24 ++++++++++++++++=
+++-
> > > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index 84d219ae6aee..4426524b59f2 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -2036,11 +2036,21 @@ static int st_lsm6dsx_init_hw_timer(struct =
st_lsm6dsx_hw *hw)
> > > >       return 0;
> > > >  }
> > > >
> > > > -static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> > > > +static int st_lsm6dsx_reset_device(struct st_lsm6dsx_hw *hw)
> > > >  {
> > > >       const struct st_lsm6dsx_reg *reg;
> > > >       int err;
> > > >
> > > > +     /*
> > > > +      * flush hw FIFO before device reset in order to avoid
> > > > +      * possible races on interrupt line 1. If the first interrupt
> > > > +      * line is asserted during hw reset the device will work in
> > > > +      * I3C-only mode (if it is supported)
> > > > +      */
> > > > +     err =3D st_lsm6dsx_flush_fifo(hw);
> > > > +     if (err < 0 && err !=3D -ENOTSUPP)
> > > > +             return err;
> > > > +
> > > >       /* device sw reset */
> > > >       reg =3D &hw->settings->reset;
> > > >       err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > @@ -2059,6 +2069,18 @@ static int st_lsm6dsx_init_device(struct st_=
lsm6dsx_hw *hw)
> > > >
> > > >       msleep(50);
> > > >
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> > > > +{
> > > > +     const struct st_lsm6dsx_reg *reg;
> > > > +     int err;
> > > > +
> > > > +     err =3D st_lsm6dsx_reset_device(hw);
> > > > +     if (err < 0)
> > > > +             return err;
> > > > +
> > > >       /* enable Block Data Update */
> > > >       reg =3D &hw->settings->bdu;
> > > >       err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > --
> > > > 2.24.1
> > >
> > > I tested the patch and the I3C interface is working fine in this vers=
ion.
> > >
> > > Reviewed-by: Vitor Soares <vitor.soares@synopsys.com>
> > > Tested-by: Vitor Soares <vitor.soares@synopsys.com>
> > >
>
> > > Best regards,
> > > Vitor
> > > Soares
> > >
> > >
> >
>

