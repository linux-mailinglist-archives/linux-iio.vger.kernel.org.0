Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD6937F436
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 10:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhEMIgT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhEMIgG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 May 2021 04:36:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C59C061574
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 01:34:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n2so26193338wrm.0
        for <linux-iio@vger.kernel.org>; Thu, 13 May 2021 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=RYQZdJR8O2hOdYGOr+I8k1Mi0n4yb+4ZnBTdhExylYY=;
        b=hZZKWbtjwX27qYNC+aUM9urAU2Unp55TG7eYvuwZ5qkMAaxT6PUU1mGoKE9LkoyESZ
         WbZXSt+CCPBkZVMGTviyMAm2I0owT4vCBU/0sxKR/de58HmGVdgK5TYlgAictnkw0Few
         41U/ZpzUElz6rWLZRdT58aWp6rct/adB6AFGWZJZCOFbmBJri/be89K3rFkTb5sKOMC9
         dI55CLOf+Jf5HLYOak/4/zXQAa43zqOC8+AJQd4hZRbUGcJiN/dF5YDtdqGeKQEVaHpm
         n70V5+F0HFmw3bG6WMAvzqLn2+xkd4fsESfHLn7Zng/KnBqNo6R7m8p1scLDwZSGZwtr
         YViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=RYQZdJR8O2hOdYGOr+I8k1Mi0n4yb+4ZnBTdhExylYY=;
        b=Ps9NA0qphOmd3ZkQ4paJOGdeNWBfAmyE1du943zRmSzyhEaX9j4l3vXSeOEzOVsi2v
         HOwgFMRkAT60Lpn15A/ti0uyS9gh4E7zwz6c2K09dLJR6HH3qxCAt0af0bXDz3F9Rh+P
         80cVQAkw8lAmPNnuH/yn997dFBhbYzrybEHgBKb7CAxGtNJJSJPX5IZwBUxsiNmGoU5/
         wNgyH/YNOF/3F1aE0GD9eNgrOJ8jIROYdm90QWaMt7Es4qBzD9NEcd7y62k3PSMWPSI8
         D8KhBnfaGz20TFUK4dPOU4OvvgmyZTqLmkjxx7coVDfMr3oJ8MR5wPmae7ySWa8PF0H8
         shDg==
X-Gm-Message-State: AOAM5304RKCc4uHF/0LIus+Zly5PAejjg59RQ6u4KUQj2VPEupwcSYEd
        +S3Ud1KJKB5Z5fb7qXi5oIk+gg==
X-Google-Smtp-Source: ABdhPJyd34/mjgS0GUn4bceUUVmXh/jwAh/+3t6c/P1tLlqDhS5tCCCJNBfg2Px4TFYUMRbkAnaoMw==
X-Received: by 2002:adf:9cc1:: with SMTP id h1mr48750187wre.135.1620894893828;
        Thu, 13 May 2021 01:34:53 -0700 (PDT)
Received: from localhost (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id n2sm2059563wmb.32.2021.05.13.01.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 01:34:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 13 May 2021 09:34:52 +0100
Message-Id: <CBBZA9T1OY9C.2611WSV49DV2G@arch-thunder>
Cc:     <linux-iio@vger.kernel.org>,
        "Julia Lawall" <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/28] iio: gyro: fxa210002c: Balance runtime pm + use
 pm_runtime_resume_and_get().
From:   "Rui Miguel Silva" <rui.silva@linaro.org>
To:     "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        "Jonathan Cameron" <jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
 <20210509113354.660190-2-jic23@kernel.org>
 <20210512152243.48c2fc74@coco.lan> <20210512153005.0a9b1fb8@coco.lan>
In-Reply-To: <20210512153005.0a9b1fb8@coco.lan>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Mauro,
On Wed May 12, 2021 at 2:30 PM WEST, Mauro Carvalho Chehab wrote:

> Em Wed, 12 May 2021 15:22:43 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
>
> > Em Sun,  9 May 2021 12:33:27 +0100
> > Jonathan Cameron <jic23@kernel.org> escreveu:
> >=20
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
> > > In both the probe() error path and remove() pm_runtime_put_noidle()
> > > is called which will decrement the runtime pm reference count.
> > > However, there is no matching function to have raised the reference c=
ount.
> > > Not this isn't a fix as the runtime pm core will stop the reference c=
ount
> > > going negative anyway.
> > >=20
> > > An alternative would have been to raise the count in these paths, but
> > > it is not clear why that would be necessary.
> > >=20
> > > Whilst we are here replace some boilerplate with pm_runtime_resume_an=
d_get()
> > > Found using coccicheck script under review at:
> > > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@in=
ria.fr/
> > >=20
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Rui Miguel Silva <rui.silva@linaro.org> =20
> >=20
> > LGTM.
> >=20
> > Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> Hmm...not quite...
>
> > > diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fx=
as21002c_core.c
> > > index 5af7b48ff01a..539585b0d300 100644
> > > --- a/drivers/iio/gyro/fxas21002c_core.c
> > > +++ b/drivers/iio/gyro/fxas21002c_core.c
> > > @@ -366,14 +366,7 @@ static int fxas21002c_write(struct fxas21002c_da=
ta *data,
> > > =20
> > >  static int  fxas21002c_pm_get(struct fxas21002c_data *data)
> > >  {
> > > -	struct device *dev =3D regmap_get_device(data->regmap);
> > > -	int ret;
> > > -
> > > -	ret =3D pm_runtime_get_sync(dev);
> > > -	if (ret < 0)
> > > -		pm_runtime_put_noidle(dev);
> > > -
> > > -	return ret;
> > > +	return pm_runtime_resume_and_get(regmap_get_device(data->regmap));
> > >  }
>
> fxas21002c_temp_get() and fxas21002c_axis_get() seem to be
> missing a pm_runtime_put*() if something gets wrong at
> regmap_field_read(), e. g.:

Thanks for catching this, you are right. However I think it should
have is own patch, since it is a real fix and this one is not.

Jonathan, bellow goes a proper patch, please feel free to squash this
on top of yours, or just apply it separately, your call.

Cheers,
     Rui

8<-------------------------------------------------------------------

From 314a56247515c05c0c5504c1e305127878af0c9b Mon Sep 17 00:00:00 2001
From: Rui Miguel Silva <rui.silva@linaro.org>
Date: Wed, 12 May 2021 23:39:29 +0100
Subject: [PATCH] iio: gyro: fxas21002c: balance runtime power in error path

If we fail to read temperature or axis we need to decrement the
runtime pm reference count to trigger autosuspend.

Add the call to pm_put to do that in case of error.

Fixes: a0701b6263ae ("iio: gyro: add core driver for fxas21002c")
Suggested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/iio/gyro/fxas21002c_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas2100=
2c_core.c
index 1a20c6b88e7d..645461c70454 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -399,6 +399,7 @@ static int fxas21002c_temp_get(struct fxas21002c_data *=
data, int *val)
 	ret =3D regmap_field_read(data->regmap_fields[F_TEMP], &temp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read temp: %d\n", ret);
+		fxas21002c_pm_put(data);
 		goto data_unlock;
 	}
=20
@@ -432,6 +433,7 @@ static int fxas21002c_axis_get(struct fxas21002c_data *=
data,
 			       &axis_be, sizeof(axis_be));
 	if (ret < 0) {
 		dev_err(dev, "failed to read axis: %d: %d\n", index, ret);
+		fxas21002c_pm_put(data);
 		goto data_unlock;
 	}
=20
--=20
2.31.1


