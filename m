Return-Path: <linux-iio+bounces-22508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0216CB1F631
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 22:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF7717F6E5
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B715201276;
	Sat,  9 Aug 2025 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVWVm3Gq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3621D2E36F1;
	Sat,  9 Aug 2025 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754771698; cv=none; b=qytjbOwbTjFlOgsSFqO8fmETHUowHwclBukMLipr+7Tza4niaUFbtw82NtZZtHQgUGXxfM0wkm3uwNKfkUcI5n6hTioPlSpwGkx8O9u+RZUVDVx2yH1KrGgRr7IrXxUl4NuAgIJmWQGQbxby1qnUF5MvYK/sqVSJPJ9JQ9b3IdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754771698; c=relaxed/simple;
	bh=wqOLG9i9RjrWpwScItaVm5i8hEzKty+ljNIAUBVKf7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvxMwHOlqEiTbUKwiUrxXHOoWIXiFthcVQAAZex+ZuqtpLbSILgBin6y35eTTAy0k0pcn947Gi7P6N8u5dZ+Adlw6gZ50TiX+RzowYcIqrSTaAkuH299WrD5KUXUXmqkiG++a1la4TgGzeB1MwiiNu26IvvPOhVxh2lIw7TR0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVWVm3Gq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af95b919093so479965666b.2;
        Sat, 09 Aug 2025 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754771694; x=1755376494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kZmH6zEe19LahdSi523CClX4+3HiP+RimCUczdeWDI=;
        b=kVWVm3GqZq1whn6zUYE75gxKTSPs0y1jswUNSsTaQNr3TfgsbKpeCPwjeiuUPL77gc
         FgTUyxLuCEHNThH+w/RGAWqdi3URlBSx4gg5eA8hRRKth2a7Ra1eWExqBmz/lVfE3opQ
         qZBPN/8vh3452ADXCG0YNc7vn/W9FjvU0Q7e8X3f2kG2TdLM05dopG4pTBGMEP20HrHf
         wG3HtdtL+ekSV/2JEA4atHcH7HjJ47ZdqqRWwbLKZ7aaTq1u2DyusLsU6thQ6wDo1rg8
         hjhhg3udDVRMmtccv5ousQ/lehLl35ZHyJmPjwSN2sBAvEuraFCZr74F5dtjURO1db9Y
         3vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754771694; x=1755376494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kZmH6zEe19LahdSi523CClX4+3HiP+RimCUczdeWDI=;
        b=iK2ZGeTbSJ1CF3VQFA6eLmR6aGVW76ROGe6nSUf6HtbwIg8uvlmm8PwBjQWtNwlmq+
         s+86fk1fFJjNMBeO2wj/RSiLKpcYs1aCHvvOfcy2Zga4KVb11DfkJMkLmVo7B/jnJ71R
         Z4BgKtijLpP9iIQuaV3NPPHLqkJJBpS0iaRkou2nEZ1R6K92uIEcGKSVtYrkoslzVeQN
         FY0OfEouXouazNzzHHjxlfWpysqQEAxb2JC00RgUiv9BBwtXJf6hTc2ig0rf4mr4f5Xe
         FgLqaF/5/Qa7qavEyv/6nrRsAVyzPZNIYVs9/C23GFTNlyulvz7OfSUHFd+NVu9InyNo
         gcpw==
X-Forwarded-Encrypted: i=1; AJvYcCW/7BlazN8oMLEVFBZlruTuK+xBuiPeig3zudzoXcVAUqBMBHiprKPWbbs1NRqkU7WiL3WQU4TqwgA=@vger.kernel.org, AJvYcCWe+kToo8BXd/7P6Bxi/yBYmMQ5zkwY/Qy5OYu4DvXhujYzYLaeb7dqbHRAdnDEItbNZqjzM04+Mhy61qKi@vger.kernel.org
X-Gm-Message-State: AOJu0YxyUFQtGvbCEIjeEIs1XUsefktStOfe8wKIYU+XMrstc8/MB5i5
	Yb/xm88+kAI9Oy3rzvktLL78p1Drm+CGNwU0FA+HNR77dU8zwg+WgZ93aTB2YO1PyL/jD171cZf
	iqdds9jpto1325zb88Flk5xysg4rqFSg=
X-Gm-Gg: ASbGncsSayVPKVjXv/gDlJUyOvjObi9UJkbft5UsvrPhVReZFH4VesVxgMBvtlW/vDt
	XuALc424XJyzZU3nVzUStEfdiuiUuxQhJ+K4/eyFwSmM9k6yZWWAGRKcIXUcDrr9n3YNXHg8L+U
	TT4ETNl5NIdRBPhSoA3TEWc1DPeLtCzUJzA9z9eyS2r0mAftix9wJXy9OxQLGvgiEwPYS3poLcN
	G2/gCHp9g==
X-Google-Smtp-Source: AGHT+IEuz9sJpUKzmwW3Jy6jfLTjTrqYaKrZq54NviwCHzcqk8k4YCyVolw98oKgO5Jhk8p64YtViQ7X1Zdwx6hB5BE=
X-Received: by 2002:a17:907:3d4c:b0:adb:229f:6b71 with SMTP id
 a640c23a62f3a-af9c640e627mr806927466b.5.1754771694444; Sat, 09 Aug 2025
 13:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
 <CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com>
 <CAE3SzaTBzF=W9++d4CmW-vRkKLy9zd2oB4ADX8NuH-woTvJxqg@mail.gmail.com>
 <CAHp75VePmhLstCraz_+7Cqc_bLQ49+1rV4oH59a1oo2xHp0R+Q@mail.gmail.com>
 <20250806161801.000061c0@huawei.com> <aJO05BNi2TsYtdwe@smile.fi.intel.com>
 <20250807140401.00006c85@huawei.com> <aJcapPt8f5YMUBH3@smile.fi.intel.com> <20250809205736.34b75763@jic23-huawei>
In-Reply-To: <20250809205736.34b75763@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 9 Aug 2025 22:34:18 +0200
X-Gm-Features: Ac12FXxOtcAJgzshVTz7po25h_GlHwg-lGid0lpBnMSErpDEP1DTXUeEYdmxHMY
Message-ID: <CAHp75VffV4Xomb-1zp6_xB=r+PJzsDnj_gjwyWas8cX7dhuhng@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add remove callback with needed
 support in device registration
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Akshay Jindal <akshayaj.lkd@gmail.com>, 
	anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 9, 2025 at 9:57=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
> On Sat, 9 Aug 2025 12:53:40 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Thu, Aug 07, 2025 at 02:04:01PM +0100, Jonathan Cameron wrote:
> > > On Wed, 6 Aug 2025 23:02:44 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > On Wed, Aug 06, 2025 at 04:18:01PM +0100, Jonathan Cameron wrote:
> > > > > On Tue, 5 Aug 2025 14:47:32 +0200
> > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > > On Tue, Aug 5, 2025 at 6:05=E2=80=AFAM Akshay Jindal <akshayaj.=
lkd@gmail.com> wrote:
> > > > > > > On Tue, Aug 5, 2025 at 2:36=E2=80=AFAM Andy Shevchenko
> > > > > > > <andy.shevchenko@gmail.com> wrote:

...

> > > > > > > > Doesn't sound right to me. HAve you investigated PM runtime=
 paths?
> > > > > > > Yes I did investigate and found that PM runtime->suspend() ca=
llback
> > > > > > > co-exists with remove callback.
> > > > > > >
> > > > > > > > Looking at what the code you added there it sounds to me li=
ke a part
> > > > > > > > of PM runtime ->suspend() callback.
> > > > > > > Yes, part of functionality will always be common, because bot=
h the
> > > > > > > callback implementations put
> > > > > > > the device into powered down or low power state which is what=
 has been done here
> > > > > > > Both _suspend() and remove are called at different times in t=
he lifecycle of the
> > > > > > > driver, but with respect to register setting, they put the de=
vice into
> > > > > > > power down state.
> > > > > >
> > > > > > Are you sure about the remove stage and how it interacts with r=
untime
> > > > > > PM? Please, check how the device driver core manages PM on the =
remove
> > > > > > stage.
> > > > > >
> > > > > > > Additionally .remove() can have code for:
> > > > > > > 1. disable runtime power management (if enabled while device =
registration).
> > > > > >
> > > > > > If the device core enables it for you, it will disable it
> > > > > > symmetrically. I don't see the issue here, it should be done
> > > > > > automatically. If you do that explicitly, use the respective
> > > > > > devm_pm_runtime_*() call.
> > > > > >
> > > > > > > 2. device cleanup (disabling interrupt and cleaning up other =
configs done).
> > > > > >
> > > > > > Wrap them into devm if required.
> > > > > >
> > > > > > > 2. unregister the device.
> > > > > >
> > > > > > Already done in the original code which your patch reverts, why=
?
> > > > > >
> > > > > > > For eg: another light sensor bh1750
> > > > > > > static void bh1750_remove(struct i2c_client *client)
> > > > > > > {
> > > > > > >     iio_device_unregister(indio_dev);
> > > > > > >     mutex_lock(&data->lock);
> > > > > > >     i2c_smbus_write_byte(client, BH1750_POWER_DOWN);
> > > > > > >     mutex_unlock(&data->lock);
> > > > > > > }
> > > > > > >
> > > > > > > static int bh1750_suspend(struct device *dev)
> > > > > > > {
> > > > > > >     mutex_lock(&data->lock);
> > > > > > >     ret =3D i2c_smbus_write_byte(data->client, BH1750_POWER_D=
OWN);
> > > > > > >     mutex_unlock(&data->lock);
> > > > > > >     return ret;
> > > > > > > }
> > > > > >
> > > > > > Correct and where do you see the problem here? Perhaps the prob=
lem is
> > > > > > in the cleanup aordering and some other bugs vs. devm calls?
> > > > > >
> > > > > > > In drivers/iio/light, you can find similar examples in pa1220=
3001,
> > > > > > > rpr0521, apds9960,
> > > > > > > vcnl4000, isl29028, vcnl4035. You can find many more examples=
 in
> > > > > > > sensors other than light sensors.
> > > > > >
> > > > > > Good, should all they need to be fixed?
> > > > >
> > > > > The complex corners that occur with devm + runtime pm are around
> > > > > things that we must not run if we are already in runtime suspend.
> > > > > Typically disabling power supplies (as we can underflow counters
> > > > > and getting warning prints).  Seeing as this driver is not
> > > > > doing that it should be simple to use a devm_add_action_or_reset(=
)
> > > > >
> > > > > Key thing to consider is that runtime pm may not be built.
> > > >
> > > > This will mean that user does not want to handle PM at all at runti=
me, so why
> > > > should it be our problem? If device is off, it's not the problem of=
 the driver
> > > > to do the power cycle at run time (yes, this might not apply to the=
 system
> > > > suspend and resume cases, which has to be implemented as well).
> > > >
> > > > > So the flow should work with those calls doing nothing.  That mea=
ns that
> > > > > if you turn the device on in probe we should make sure to explici=
tly turn
> > > > > it off in the remove flow. That's where devm_add_action_or_reset(=
)
> > > > > comes in handy.
> > > >
> > > > I don't think we should do that explicitly in remove. As I pointed =
out above,
> > > > this the case that driver should not override.  Otherwise there is =
no point in
> > > > having the common runtime PM. User deliberately makes it not compil=
ed, so they
> > > > should prepare to leave with it.
> > >
> > > Hmm. I don't agree. We turned it on so on error or remove I think we
> > > should turn it off again.  We do that in many drivers that never made=
 use of
> > > any of the standard PM stuff because they only touch enable and disab=
le in
> > > probe and remove.  If nothing else I don't like the lack of balance b=
etween
> > > probe and remove if we don't do it.
> >
> > We can do it, but this sounds to me like a step back. Implementing prop=
er PM
> > runtime callbacks is a step forward.
> I entirely agree that runtime PM is good to have and it does a lot more
> than just turning the power on and off once per probe / remove cycle.

> But runtime_pm is currently optional (system wide) and that's not somethi=
ng
> I think we are in a position to change.

True.

>  We should support runtime pm in
> as many drivers as possible but not rely on it for 'correct functionality=
'.

Why not? If the driver doesn't care about the PM, then why bother at
all. The PM runtime is for that.

> To me turning a device off at remove that

> we turned

Key words! And that can be done in different ways. One of which is the
PM runtime. The custom on and off is basically an open coded part or
the runtime PM functionality.

> on at probe is something
> we should do.

Yes, of course. I do not object to this flow.

> Now if it's already off, then sure don't turn it off again if
> it has side effects to do so (which is the heart of the underflow warning=
 issue
> with regulators)

Sure.

> > Doing the former in the existing drivers is not an argument to me becau=
se all
> > of them avoiding use of the PM APIs. Note, with PM APIs it may also inv=
olve
> > devlink and other benefits that device driver core gives us.
>
> We have lots of drivers that do both minimal management at probe and remo=
ve
> as necessary to function, and if it is enabled, full runtime pm.
>
> Though recently it has shown up that there are some underflow issues if w=
e
> aren't careful wrt to regulators being handled by devm.
>
> > > > > ret =3D regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SE=
NSOR_ENABLE);
> > > > > Is the paired operation with the second disable you add in remove=
.
> > > > > Wrap that in a devm callback.
> > > > >
> > > > > More complex is the interrupt enable as that doesn't pair with
> > > > > anything in particular in probe. I'm curious though, do we need
> > > > > to disable it given the next operation turns off the sensor and o=
n
> > > > > probe we reset the sensor.
> > > > >
> > > > > Is just clearing the enable bit enough?

--=20
With Best Regards,
Andy Shevchenko

