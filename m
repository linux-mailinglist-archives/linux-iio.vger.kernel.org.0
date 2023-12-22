Return-Path: <linux-iio+bounces-1224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E898A81CAB1
	for <lists+linux-iio@lfdr.de>; Fri, 22 Dec 2023 14:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DDC1C21FDC
	for <lists+linux-iio@lfdr.de>; Fri, 22 Dec 2023 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B944F1A58E;
	Fri, 22 Dec 2023 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iqa5Kbw7"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F21A28F
	for <linux-iio@vger.kernel.org>; Fri, 22 Dec 2023 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703251706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjtBwcyrS/xfG3xz11U3E0BKYyC+0OSUW6t3X3+SrTk=;
	b=Iqa5Kbw7iiVID9SFpKTGXTiBDkEqqhmblqcrME66gUdtagNwMO8D/kgs9fFD7yhjPZZtK2
	2eZxUsNcOxaJIsdUndYRZ4eq2gmODJknG79CRfggd88KKNOLQol8lqdLuQYrhln9xNO2eR
	hBtY80/DWNOcXt9kqfVjVFeSP+mTxtY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-XShY8HZWOu2a1weKN7JMBw-1; Fri, 22 Dec 2023 08:28:25 -0500
X-MC-Unique: XShY8HZWOu2a1weKN7JMBw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-553a7468be9so818842a12.2
        for <linux-iio@vger.kernel.org>; Fri, 22 Dec 2023 05:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703251704; x=1703856504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjtBwcyrS/xfG3xz11U3E0BKYyC+0OSUW6t3X3+SrTk=;
        b=UT4CnSL0o3UUQZL9D/PwMkD8I+0m/NG+mjt0e+iTLnW2oupjuFRFo7PI/MqdkCrMxV
         iRebn4kWzq4hKN4Uj0VKwrFfnrNhiuDcJ5P2rdwuc6jDgdy4KidWYW0i+UdTlB7+FfJ+
         D60q4wmGFZv/xEtrBRmPXOcC+n5iFmKSikZXL8rLqmiVfDUOFDi6EOInJSMvNB81kyA3
         BrBkTFftD8cDqfDhKqr1axWRsNvdw/hcMsZoBc0qxDAIXPnyzTfRPF6yyUgzPmEXxq0G
         /sBlCHslKckoxVRJaFVGssQL+hiQbjzz4FvJpgbFV/J6OEBmCcxud+Hng6jeUGN8A52/
         eg1A==
X-Gm-Message-State: AOJu0Yz4LMXiLeOL3QidprH3/hVK27rpc64QARBxKrVoH09xdvKTQ95n
	IOBxOUOSxkfst9D1FsYpkydr2bMsuteX3Wt0fERbkYuzuEbrQ1qoSYF6uFDCRJ9/7rP5fKMS953
	NLVdgxL826H/oG/oHxz6ahBphmwL0XrDKYKyCW8Px26U6
X-Received: by 2002:aa7:c7d4:0:b0:553:451d:981 with SMTP id o20-20020aa7c7d4000000b00553451d0981mr611579eds.27.1703251704706;
        Fri, 22 Dec 2023 05:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8dKAHszdWVmVU3P+KG67bHgG7OlsmCbL7vkqRTd451rgN60S1dg0/d1u9nbfcB9U9ZPw0e7teJrPTePkYpk8=
X-Received: by 2002:aa7:c7d4:0:b0:553:451d:981 with SMTP id
 o20-20020aa7c7d4000000b00553451d0981mr611573eds.27.1703251704410; Fri, 22 Dec
 2023 05:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219231503.1506801-1-jekhor@gmail.com> <20231220145229.020abe62@jic23-huawei>
 <CAKWEGV50duj-TcKdQp1BtN_QgnBZyG0WgAqo8Y5UtCinqOAh_g@mail.gmail.com> <38313826939a468ff8c7eee24e2cf07e9eef6768.camel@linux.intel.com>
In-Reply-To: <38313826939a468ff8c7eee24e2cf07e9eef6768.camel@linux.intel.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 22 Dec 2023 14:28:12 +0100
Message-ID: <CAO-hwJ+RDnukVhL1=PirK=hU7gm2t73xsg=aDss0M9hj_CSuHA@mail.gmail.com>
Subject: Re: [PATCH] HID: sensor-hub: Enable hid core report processing for
 all devices
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Yauhen Kharuzhy <jekhor@gmail.com>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, 
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 1:44=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2023-12-20 at 17:04 +0200, Yauhen Kharuzhy wrote:
> > =D1=81=D1=80, 20 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 16:52,=
 Jonathan Cameron <jic23@kernel.org>:
> > >
> > > On Wed, 20 Dec 2023 01:15:03 +0200
> > > Yauhen Kharuzhy <jekhor@gmail.com> wrote:
> > >
> > > > After the commit 666cf30a589a ("HID: sensor-hub: Allow multi-
> > > > function
> > > > sensor devices") hub devices are claimed by hidraw driver in
> > > > hid_connect().
> > > > This causes stoppping of processing HID reports by hid core due
> > > > to
> > > > optimization.
> > > >
> > > > In such case, the hid-sensor-custom driver cannot match a known
> > > > custom
> > > > sensor in hid_sensor_custom_get_known() because it try to check
> > > > custom
> > > > properties which weren't filled from the report because hid core
> > > > didn't
> > > > parsed it.
> > > >
> > > > As result, custom sensors like hinge angle sensor and LISS
> > > > sensors
> > > > don't work.
> > > >
> > > > Mark the sensor hub devices claimed by some driver to avoid
> > > > hidraw-related
> > > > optimizations.
> > > >
> > > > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > > Fixes tag?
> >
> > Fixes: 666cf30a589a ("HID: sensor-hub: Allow multi-function sensor
> > devices")
> >
> This flag causes
>                 hdev->claimed |=3D HID_CLAIMED_DRIVER;
> I don't see the flag is used anywhere after this assignment in hid
> core. Only two other drivers are setting this flag. We need Jiri's help
> here why this is a special case.

It's used in hid_report_raw_event()[0]:
```
    if (hid->claimed !=3D HID_CLAIMED_HIDRAW && report->maxfield) {
        hid_process_report(hid, report, cdata, interrupt);
        hdrv =3D hid->driver;
        if (hdrv && hdrv->report)
            hdrv->report(hid, report);
    }
```

The whole point of setting HID_CLAIMED_DRIVER is to have hid->claimed
not equal to HID_CLAIMED_HIDRAW, in case we need the hid core
processing.

Cheers,
Benjamin


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/hid/hid-core.c#n2015

>
> Thanks,
> Srinivas
>
> > >
> > > > ---
> > > >  drivers/hid/hid-sensor-hub.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-
> > > > sensor-hub.c
> > > > index 2eba152e8b90..26e93a331a51 100644
> > > > --- a/drivers/hid/hid-sensor-hub.c
> > > > +++ b/drivers/hid/hid-sensor-hub.c
> > > > @@ -632,7 +632,7 @@ static int sensor_hub_probe(struct hid_device
> > > > *hdev,
> > > >       }
> > > >       INIT_LIST_HEAD(&hdev->inputs);
> > > >
> > > > -     ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> > > > +     ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT |
> > > > HID_CONNECT_DRIVER);
> > > >       if (ret) {
> > > >               hid_err(hdev, "hw start failed\n");
> > > >               return ret;
> > >
> >
> >
>


