Return-Path: <linux-iio+bounces-18492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E11A96317
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 10:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326FA19E1665
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16460256C84;
	Tue, 22 Apr 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhw/4tAf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B4256C7D;
	Tue, 22 Apr 2025 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311365; cv=none; b=EU35PsC/BYmXmauXHQlnMNdyeIyYUljxsuv3UF26p95BnwgjBtZPpxHvurvB/ylgQURctW1Vt/fNR2j9asCEb+wq1cNuKsmsvNYpM0IubKzr9mWoji/WtRmK+v7xHOSPECOv8Zam1RdqrYuv4pDeLfdeF4eoJQuefMltJnpo+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311365; c=relaxed/simple;
	bh=xZqSNLlN/1aQNo2XrEbX5OaqDAT9LgK6KDw6FW1HPkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8diPm0EdYgRuCeyse9hgXVFCyXxjnvncre0w3oBwJtYySiWxZcNzw/BEF6FMO4rOM1Ki4pbc5WyQqdSIVCNBGYdv1MjXpxir1tHVqKz8yAw+tqLExC8kmRM+TpQuRaU/5CY6x7+kwGs4rfwSUxGp+YUC862Hh+gxRNv+N6hiug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhw/4tAf; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30828fc17adso4188575a91.1;
        Tue, 22 Apr 2025 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745311364; x=1745916164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl4p7DRFRIT+f45qPT/jcA3pklzI/QxdUifagNm8DiM=;
        b=nhw/4tAfmd6CSYdZ6vE9lqdNzinPuu8xIEeN36bhN13UtL5BzMFN89xAOFUyXiYKP9
         +uHLXnsJiHtVHnpBGhIQulRcnJNlVflhkGNTg3w/AxGrX+fu1071NXaYaAKQIG8ipa1R
         FxV+cnvYUPUdqWXQGIad7afruMRSCgvZL9JMkiddGuXDZDpdSr++3RLbgIfBuLa6IZwA
         WNZKPoDf+Qr847LEIHYI1hVllN3ZPOur/IFKSfMMlA9q/fOBwrdXsnW17IPtuejtETud
         bYjMwVvo5NPJk4mt+jFKsqMC4JZ9aHjAxHf8SFyk7j0SDctIbbhZAGjfzhsth1DHVv0F
         5iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311364; x=1745916164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dl4p7DRFRIT+f45qPT/jcA3pklzI/QxdUifagNm8DiM=;
        b=gMAEFvB2OMnmUAmp9hDq52mm5dWOApGre1FHb2HX1l5Tm1e7e6WgruuiU0+S/DpKHx
         pe0vjdo06Ose57P7ssoJXxcO5VqllnyUFr3vAeMLOoKymouzUimfiXf97mxYzqLUDiez
         kYmJPmDI4ERcYBkuOtZuFtRDKia8JwCXTZ3rfvKkpMwpojuxdJkr/L907mKeoZflDh3r
         vFHeH5j5KiAeQW8d+bZ7jzsZHmPvYcMlYsoPoeipXIvpvTTFR3iChxuh22SrApY7pM/K
         hUymza5E6+F9NXweNwq3FYFZ4m5JUvJPoOyB9oLgqxJIRum9IZF0CteapPM4QARbuUKB
         T9ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAgeAuHVa58fg609jRqTkBMRQycssAZSGc9QGY1my8TgD9vs+e4RIEU2iyUvWhj8uM5CqYIGqvjOgS@vger.kernel.org, AJvYcCXxNJVXLYrsPXw5HSgWgyogVzjMvC868+rc6OFeMPnQhRLg5fFiEtLVeqGts6affhA252E2XmCeNjII@vger.kernel.org
X-Gm-Message-State: AOJu0YxGzKSV4UIC8kJKUzNI9iOx++930qNVx3orzbAu2Q2RUSc7DFSy
	tyYfnlibSre+C1uEv7UC9VQ0Q+YruwCDDvElRJqMDBTd7SfIqbavknUrB7J/+ofyhT0p4TgNoDZ
	CPUnHIDryEXgV/fGpFDtZ2wdaLdU=
X-Gm-Gg: ASbGncuW2QBeEzzp6ifnd30hVUyRGQTn5W5+S3KtDuVv0KfnSW7KrlXUBTjwzX14rkt
	boRVhQLZZDDJ7iwYFwqQl423VOsxfXGvc/Io3rThbR+1OCKtkukOC1Rk/YolU7RUj+8eOL+xITQ
	0MUMRbU0dbzx24QtkgQ5QPi/Y=
X-Google-Smtp-Source: AGHT+IGqXBZzaRg3JHihoddQX0W5bstPf8xwZ6lzPnpvfWf0BpAYOl+Mq9UE7bYkMjao+4aXeYhJhmCS0WoWJS3Z2aQ=
X-Received: by 2002:a17:90b:2647:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-3087bb53159mr25282363a91.12.1745311363829; Tue, 22 Apr 2025
 01:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420181015.492671-1-gye976@gmail.com> <20250420181015.492671-4-gye976@gmail.com>
 <CAHp75VdAeJ0HhExE=OAeFdYz2MYFKgMffbD_Gidf86w=zhKccg@mail.gmail.com>
 <CAHp75VcaGqR-c23GCOKo3RLO-omtt9YgPuHmCUteAqYt6yon7Q@mail.gmail.com> <20250421142531.2084092e@jic23-huawei>
In-Reply-To: <20250421142531.2084092e@jic23-huawei>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Tue, 22 Apr 2025 17:42:32 +0900
X-Gm-Features: ATxdqUH-BGQfiB5JAWsTB-8h8Z8k_s4xUFodmxDcDVsMtg_yWULk-zBnPoGU4gc
Message-ID: <CAKbEzntJzKYsB3Nehyoo=2FrTnzKXcu0NcJEcvCXdi5HxvJk8A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Mon, Apr 21, 2025 at 10:25=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Sun, 20 Apr 2025 22:23:57 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Sun, Apr 20, 2025 at 10:21=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sun, Apr 20, 2025 at 9:10=E2=80=AFPM Gyeyoung Baek <gye976@gmail.c=
om> wrote:
> >
> > ...
> >
> > > > --- a/drivers/iio/chemical/Makefile
> > > > +++ b/drivers/iio/chemical/Makefile
> >
> > > >  obj-$(CONFIG_SPS30_I2C) +=3D sps30_i2c.o
> > > >  obj-$(CONFIG_SPS30_SERIAL) +=3D sps30_serial.o
> > > >  obj-$(CONFIG_VZ89X)            +=3D vz89x.o
> > > > +obj-$(CONFIG_WINSEN_MHZ19B) +=3D mhz19b.o
> > >
> > > Preserve order.
> >
> > Ah, I see it's ordered but by Kconfig, Why do you have WINSEN in the
> > option and no such thing in the filename? I would drop that from the
> > config option.
> >
> > Jonathan, what do you think about this? Which order (in case of
> > misalignment between module name and configuration option) should be
> > taken?
> >
>
> Hmm.. No idea.  It think just dropping it from the CONFIG name
> is the right way to avoid the question ;)

Thanks for your suggestion. I'll just drop that.

Thanks,
Gyeyoung

