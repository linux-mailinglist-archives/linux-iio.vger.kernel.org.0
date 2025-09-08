Return-Path: <linux-iio+bounces-23889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878CEB49A8C
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 22:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2934116BC95
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92652D63FF;
	Mon,  8 Sep 2025 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b12oi8bc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFD1F09B3
	for <linux-iio@vger.kernel.org>; Mon,  8 Sep 2025 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361661; cv=none; b=SXe3zEFGoqLvaz2/0bt4diaHd8lqRgyyJicZJ0S60xyEcuFJN8n1JUDOG6LxoD3w/FuSSVqCF/SCnPo5GUeus2PVwNVr6QF0P/CLE4VT4BA3w69f/qlH0mPM7DwyCXYa0xnC0ASiafckUeqMeTgLbotubjvAJVFJdSBUSvMsXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361661; c=relaxed/simple;
	bh=yuzzhnkM37CWYAv4OpspWeehxp81EoCroe0eq6OZ65g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyM1cKPGyWwzGBKBVRtS6gh+6o/My3U+jNuyCTMbRIfveNObAcv9COlt+EJtXou2drdx6WB1z6fZeG7BYTnGkpVaB4sEC/nmSS/40H6ER1BCUSQ1KyG3/CPVx5GdWXXjRXR7+lj4ueiek1WV1ykwLLBKiK/RPmso1Easz9PNYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b12oi8bc; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5448c576e3bso1847811e0c.3
        for <linux-iio@vger.kernel.org>; Mon, 08 Sep 2025 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757361655; x=1757966455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUsRnS6S5SbO6vSAUZ6TR7L/hutR1NBcoKgb6OBYgfU=;
        b=b12oi8bcUynlyDtqrVoX2sZ9Fw+B/rVgivEsyihFsMk01diwlscztoXmUpkbszjOWQ
         iyTI/Ni8push6SJmB7bY8R5XlGYGNo3QYL8tS6G40igjwRGlamGJ4l931hRzRPZwGWx/
         67RBd373IKf1uynZRQoyf/wQXWQvDEslkGD1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757361655; x=1757966455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUsRnS6S5SbO6vSAUZ6TR7L/hutR1NBcoKgb6OBYgfU=;
        b=Jty2mI/j5FQNF/j/zktiXR50APp4i0hfGrjXpzaobBlYG2075kDklhSjgozrd8KIYO
         oApyMaZs9HwhK9dGEHmUb0oreGKDzZ+CzKDQ5Q4z/tDED7l2JhKCEPGvnZE8XfSP/Mow
         fG+TQ0jAnQNESE6bm0C5vXhTB6aH9IsS5qHqbs5n/Vwyf8oshv5v9/iIBaEWoAxeBXZL
         gGAmQa4JMNHGOFjZtCVw4Ds/xXLDMwzJbDWSr640nblUxI3vhy7TFLxyLnR1qtVQD8Vn
         7S7sSSWZ6ZaV3RpP2c/YvT2GSKNE+lD/F4TiUBjRPbCHP1R01ChjXxq8gOokDic9v5Hm
         N6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUquseQxQ/QbEkBjgLpuIgOaB7FP1yvPzYgubDsz+QFBDTa8TiRsJU4EE/HvN8cmo9WTBJm6uuuVKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+iCrCcLMe/Tii5t7Un4d7ZQmFl7AoUblaXqV+A9iSijiygdm
	breOkw7Yq2tG8F/6rr5C2ZB213LH8JJD4iIBm6fOtpr+I4/1QlQIMihOytEX8aqISF7y6pRmEam
	fieGSdVDFb+kiLG7eXWPZ1ZwYtsZY9oHJjSI/Po7x
X-Gm-Gg: ASbGncuUPP9Kg2FxnvCrkIC2+DZEECJ7fedF4nGsh+yp8aM46pl2NF+uDRCQ/uae+MA
	LjkrgQMOqIsP8htYJ/3L/sQ2BLhr58yXB9351V84y6Wvq+sfZOpOOS8Jx75HkUvbxLNGzRpYLCw
	BnNSHWwgnh6jP4Z3y3FatZaxnRklhkrbcleneveDIkF07co/GGOKa2n8HgQAQMLnOC1iLHWI+/b
	PYESCEu9SZKrgLocbLVduL9mIluFYhNIjbe41mFuUb9oFmil/c=
X-Google-Smtp-Source: AGHT+IGbHfWQ7K+J867YYnFD7YXddBcmBfLvcBDiu0VjbQ1ugtXctEOSpX1G6wEMGocPVdPqyapZRKDiR7+B7AzOmwI=
X-Received: by 2002:a05:6122:6599:b0:544:9414:105f with SMTP id
 71dfb90a1353d-5473a3c5cb4mr2242105e0c.2.1757361655414; Mon, 08 Sep 2025
 13:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903190102.1647098-1-gwendal@chromium.org>
 <e8e2a0b2-dcd2-43b9-9901-52cdfbd82b88@baylibre.com> <20250907120111.339a970e@jic23-huawei>
In-Reply-To: <20250907120111.339a970e@jic23-huawei>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Mon, 8 Sep 2025 13:00:43 -0700
X-Gm-Features: AS18NWD43EFN-Az2MNQBigPLjPh3g9d0Osp7sWqRpy-SxIbE0R-5p26oJS_ZbyE
Message-ID: <CAPUE2uuZCJwsgUKTSMBU5kRBPO2PRxYHH9na5E_8c+2cJOSmpQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: iio: Remove location attribute
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, tzungbi@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 4:01=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Fri, 5 Sep 2025 10:58:08 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On 9/3/25 2:01 PM, Gwendal Grignou wrote:
> > > The cros-ec specific |location| attribute has been superseded by the
> > > generic |label| attribute.
> > >
> > > Fixes: 7cbb6681d7e5 ("iio: common: cros_ec_sensors: Add label attribu=
te")
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio-cros-ec | 10 ----------
> > >  1 file changed, 10 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Docume=
ntation/ABI/testing/sysfs-bus-iio-cros-ec
> > > index adf24c40126f0..9e39262437979 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> > > @@ -7,16 +7,6 @@ Description:
> > >                  corresponding calibration offsets can be read from `=
*_calibbias`
> > >                  entries.
> > >
> > > -What:              /sys/bus/iio/devices/iio:deviceX/location
> > > -Date:              July 2015
> > > -KernelVersion:     4.7
> > > -Contact:   linux-iio@vger.kernel.org
> > > -Description:
> > > -           This attribute returns a string with the physical locatio=
n where
> > > -                the motion sensor is placed. For example, in a lapto=
p a motion
> > > -                sensor can be located on the base or on the lid. Cur=
rent valid
> > > -           values are 'base' and 'lid'.
> > > -
> > >  What:              /sys/bus/iio/devices/iio:deviceX/id
> > >  Date:              September 2017
> > >  KernelVersion:     4.14
> >
> > Not sure what the policy is on removing ABI, but moving this to
> > Documentation/ABI/obsolete/ to let people know that this attribute shou=
ld
> > no longer be used in new code might be more sensible.
>
> Is it still in use somewhere?
No, this attribute is not used anywhere anymore. `label` is used instead.
> I think not in which case we can safely drop
> it from mainline.
>
> Jonathan
>

