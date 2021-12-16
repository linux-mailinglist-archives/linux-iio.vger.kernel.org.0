Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44F476B06
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 08:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhLPHQr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 02:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhLPHQr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 02:16:47 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1927BC061574
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 23:16:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u17so18726291plg.9
        for <linux-iio@vger.kernel.org>; Wed, 15 Dec 2021 23:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sOGgtTvCATSHQGLexpvDJJINJ2PSOy0IILmJVv9FMbY=;
        b=l8TbPU7mFGoe47xzTNzm8pcU32TPFkr4k3eA9qlmSMBvsoBFWo+eVca5QCy1LiZ1Ie
         jaSM/eN6WWmcDrjPWRSx6SvHWh35IUdJhEnYKgLHWhDZB6+Iyb3OvCCzmvpHuSlv7pkC
         jQGJ2fn3B/X8cQEg+cnDIl0XLq0M1eGQVKX+okqSr0QWYVyGzQrF+1k3KHPvhYHSZJqv
         fir/KDP/QHRRteHADpbE4PcXr06x93q8EU0DF9DJjZojZ/6WnaYILmjlIQxzOL3DbGxW
         i3PZozxUTZDdhnsGJpqHdqXBQskG+xIJcVE+uW7jSvliFZc2abjevpTtGaPs5Vp8gPbS
         5Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sOGgtTvCATSHQGLexpvDJJINJ2PSOy0IILmJVv9FMbY=;
        b=PxcTi6nwjuI/1vrgfD9TiuiFOTTOmJwrx1y4+whOj3YrGz+FIfC+Zcl/WWD8Noy8jq
         picrww1S00FpIYQCmsYPFClQGl9NWPw3CfNFcb0aL6gEY+7XdjVNR8T+taGI7R2J3nB/
         5Gm03jYExPEb+11XDdUHmYQQ/PkxCe8jm77iMd1KYSgJM8BwywXUTbVIvld07XYdGmAf
         KaycXcaYrMDkAquVw3iwelfctSlpUKHomVSvcX72SnSDm4KhV/n/M1D1gbHr9DX/zI/o
         0CtN9WCzhwFkvwEG4b57uFh7LCim5Qz9gm2WMeYgu1k2rLqracbGowSAXZdzBAK7lLAv
         PynQ==
X-Gm-Message-State: AOAM533d39HxDq1rAMYj1ncZWLx5Au98AS4f/1iD0BLBbRoxESK3Kdab
        kULRLlhnw+tY3lK9B77tv8BG3YT8/FFR9ThYi9Yhd1mdeYPEKg==
X-Google-Smtp-Source: ABdhPJwxvE1rWeaEK/knRgSyWTmxlolwklvKfMOiSUbqzr5fIN9/nw4XAS8S/LvgnEbCm2cv7hFYqUumNDG2EW5ueVo=
X-Received: by 2002:a17:90a:3d42:: with SMTP id o2mr4492911pjf.150.1639639006542;
 Wed, 15 Dec 2021 23:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20211215151344.163036-1-miquel.raynal@bootlin.com> <20211215151344.163036-6-miquel.raynal@bootlin.com>
In-Reply-To: <20211215151344.163036-6-miquel.raynal@bootlin.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 16 Dec 2021 09:16:34 +0200
Message-ID: <CA+U=DsoVieRnfm6K-Oeva7poGBU+GbxfnS6uoRpc9=qihq6+Rw@mail.gmail.com>
Subject: Re: [PATCH 05/10] iio: st_sensors: Use iio_device_claim/release_direct_mode()
 when relevant
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> The st_sensors_core driver hardcodes the content of the
> iio_device_claim_direct_mode() and iio_device_release_direct_mode()
> helpers. Let's get rid of this handcrafted implementation and use the
> proper core helpers instead. Additionally, this lowers the tab level
> (which is always good) and prevents the use of the ->currentmode
> variable which is not supposed to be used like this anyway.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../iio/common/st_sensors/st_sensors_core.c   | 28 +++++++++----------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/ii=
o/common/st_sensors/st_sensors_core.c
> index 1de395bda03e..e57e85c06f4b 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -549,26 +549,24 @@ int st_sensors_read_info_raw(struct iio_dev *indio_=
dev,
>         int err;
>         struct st_sensor_data *sdata =3D iio_priv(indio_dev);
>
> -       mutex_lock(&indio_dev->mlock);
> -       if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
> -               err =3D -EBUSY;
> +       err =3D iio_device_claim_direct_mode(indio_dev);

I'm afraid, for this driver, we would first need a cleanup of
indio_dev->mlock usage.
Or at least that's how I would start it.
i.e. remove the indio_dev->mlock and replace it with it's own
mutex/lock in all places (except this one).

The whole story about mlock is a bit old.
As I was told, it was initially defined in the iio_dev object, but not
very strictly controlled during review [of drivers].
Drivers kept using it (as a convenience lock).
It was later defined to be an IIO framework lock.
Now, there's a (slow) ongoing work to move mlock inside the
iio_dev_opaque struct, and make each driver use it's own lock, OR use
iio_device_{claim,release}_direct_mode() where appropriate.

FWIW: this change could go in as-is.
But there's still the point of implementing another lock on the
st_sensor_data type.
I would try to split this work into another [parallel] series, because
otherwise [if fitted into this series] it would just grow and be
slow-to-review series.
But =C2=AF\_(=E3=83=84)_/=C2=AF

> +       if (err)
> +               return err;
> +
> +       err =3D st_sensors_set_enable(indio_dev, true);
> +       if (err < 0)
>                 goto out;
> -       } else {
> -               err =3D st_sensors_set_enable(indio_dev, true);
> -               if (err < 0)
> -                       goto out;
>
> -               msleep((sdata->sensor_settings->bootime * 1000) / sdata->=
odr);
> -               err =3D st_sensors_read_axis_data(indio_dev, ch, val);
> -               if (err < 0)
> -                       goto out;
> +       msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
> +       err =3D st_sensors_read_axis_data(indio_dev, ch, val);
> +       if (err < 0)
> +               goto out;
>
> -               *val =3D *val >> ch->scan_type.shift;
> +       *val =3D *val >> ch->scan_type.shift;
>
> -               err =3D st_sensors_set_enable(indio_dev, false);
> -       }
> +       err =3D st_sensors_set_enable(indio_dev, false);
>  out:
> -       mutex_unlock(&indio_dev->mlock);
> +       iio_device_release_direct_mode(indio_dev);
>
>         return err;
>  }
> --
> 2.27.0
>
