Return-Path: <linux-iio+bounces-22507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D579B1F62D
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 22:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD58189D241
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 20:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F70276022;
	Sat,  9 Aug 2025 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV2bczuU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC42E36F1;
	Sat,  9 Aug 2025 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754771313; cv=none; b=PnquUgR94F5N+8+bVZIetwNDi6pWMJbTvnWIi/YGyRzUjDNI2mM0LFKlsI7rjeZoo8DN0329Z+IabSr6/ZQsoJNzV8byH25NL+VVKWqWCB2CXffoc+7bs9UAFfs1/wFzKlA4adGkSw/n0SyBIKwOLeQ1jVQAllDgBZvctuva+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754771313; c=relaxed/simple;
	bh=37hFr4JQ5cAUiFBjprBnJALMGkmbzYbC5hvMuHDdEeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9laC04hjV21XTGoebqUxRv/CUX3C+kSqpFS93Bl1i92E3EFGjFJ8+AETccL762iIT8CEisaybS+tdTAdzFptEK4ehKU3ibN1UjU+1od7CUdx+Y2mEuxWovdmejmasXvpYrEfUX44gYaYKFGzWuIqFEeR22tbSONk3Guq1UD0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV2bczuU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af9618282a5so631799066b.2;
        Sat, 09 Aug 2025 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754771310; x=1755376110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvCp3OvNUB4OhNHYWKMJm9g+RtzmygR3Z13148Yf9dI=;
        b=iV2bczuUFFEqo7x3naXLETf4tnfSGgANKzYH0nClX7TFXHWAiw1Kgi60tPBXSfNAoX
         xvj4Ewc/8Zbs9fw/hOUJ2wdcwuQCYe/X5Of27gybAi+HkmpiPoSJe8JedIziGJVJjLC1
         PxiQi869Sj+QeV19f9SM+H1IpLbg3E0JwhgnMpD8EgUlbjjPQ3N46dUDm0frgqrIv75F
         5nXsA85KzANNSz1Io4t5xgXpTH8XXMUpqla1blh6B/b7fzP83uG1dH/BKYcdam4WXEox
         jF7e9Ot7M9/LDBWQVeL/SluwMc4umGQPpYpgsSKMCTHI3uiMrnCwZFdFZwHlJmVyvOGW
         OUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754771310; x=1755376110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvCp3OvNUB4OhNHYWKMJm9g+RtzmygR3Z13148Yf9dI=;
        b=o1If/tpc2pbo/N4iRANiOKlLiESHeGYFIiwIBIE6mxFQJsl197jLVQP3KB8GIZ6EHn
         8znM0rAmi7ZKiWFQOtzuW7JTTfT0oxV9hHTz/PFz2pQVI87urz8VBIRLRZhW4aq0jJjB
         XGw48t4YA7lba0YBOGESNuppiq7DOVP/AaUVVLF77kOd1NvIHGJZLHw5dmgWImGv3YWi
         +2at1X1gdNwxGXFcsr/RScs+IQP8YhRtuuMWWjZ5rca9DtNoqrVkQHRyVv6YyeZSl7nv
         T6Hk5b0AN7z/IOksANSPiFD1lPp94kyclAFwhZT/GdtL9ERb23HD1rVUGdhETNluGOV/
         TdRw==
X-Forwarded-Encrypted: i=1; AJvYcCU+/1mlrAkWgKIgihKkRAGvLgqMjmm6gxgmFr4OUxHdP9vKV7rdMi0E85uk7J5gVw12xBAPVRc8ay4=@vger.kernel.org, AJvYcCXCcK0AR6ON1IatHp7UITABeFD0mBT6mWU7vs9/uIwmrh0hqard6ip7uTHJ7Gnm/itqC3e9hMV5sqCnm15P@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqr8DXXNMtHwhyCNhqP/HlMImwblDB88Q0IUNPk5bDVQ4aenri
	3THfzt6TEDS8aoOoABF+uPIRpsrc0xBsDF8oBLw9pFvhIJKZkdPZC1UFU7+o5hL6li6ymB83VC8
	lbxDlaH1PwB664V2xMnO5gUYgy0owWPA=
X-Gm-Gg: ASbGncue8se5DbVaOfp99Nj46/PukyZqYeVdhrQPcr4BuIXXvk70mZm07bDdN5/tfjw
	Ngi12K1yI9+cq5tY9Y5HVndhJeG590p7hS1HCQ/AC+rOWyEIVKs1/Hh4/9PjScbyTzsWLY/itpv
	Cqz1JBH3uW1fttagbM9hPpaOUUEcDuljgP6MJDMkLcy4audsdx/rk87RR7Wksi6GGGwPASPQSe0
	TuyBNjXqQ==
X-Google-Smtp-Source: AGHT+IGcC8v+IXhY2ttWzIwIXrVDJZJwHOrz5ae0rZ55TlsOES7mAXPKPdPq5D0f+gfh8MsYX6xE8mXSdXxSj5318co=
X-Received: by 2002:a17:907:948a:b0:af9:69d1:9c6d with SMTP id
 a640c23a62f3a-af9c65b02d8mr723466366b.40.1754771309447; Sat, 09 Aug 2025
 13:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-icm42pmreg-v2-0-a480279e7721@geanix.com>
 <20250808-icm42pmreg-v2-1-a480279e7721@geanix.com> <CAHp75VdKNE0xD8xbJQ2RSCA=_MB9DMZtXRTCNkpdKdv8vW-Q-w@mail.gmail.com>
 <20250809190609.4fef9df7@jic23-huawei>
In-Reply-To: <20250809190609.4fef9df7@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 9 Aug 2025 22:27:52 +0200
X-Gm-Features: Ac12FXz9Qx9vHpjcHamJejeb1GK9RQZkty2IQjqDet9B67oLvWEl908F5wrZO8w
Message-ID: <CAHp75Vc5CxOj77cw85hmioFTG6YJCe3ZJWwJsJW+QL79K8GpWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: imu: inv_icm42600: Simplify pm_runtime setup
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 9, 2025 at 8:06=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
> On Fri, 8 Aug 2025 23:37:51 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Aug 8, 2025 at 5:58=E2=80=AFPM Sean Nyekjaer <sean@geanix.com> =
wrote:

...

> > > +       struct device *dev =3D regmap_get_device(st->map);
> > >
> > > +       if (!pm_runtime_status_suspended(dev))
> > > +               regulator_disable(st->vddio_supply);
> >
> > I would rather use positive conditional as it seems to me more scalable
>
> To potentially save time when Sean looks at this.  I don't follow. Do you=
 mean
> something like
>         if (pm_runtime_status_suspended(dev))
>                 return;
>
>         regulator_disable(st->vddio_supply);
>
> ?

Yes.

> If so I'm not seeing why we'd want this to scale as it's a single use
> devm_set_action_or_reset() callback doing just one thing.

While I agree in _this_ case, in general the check and return
immediately is more scalable for reading purposes, e.g., indentation
will be one level less. Also it won't require additional churn in
adding {, i.e. changing conditional line just for that.

--=20
With Best Regards,
Andy Shevchenko

