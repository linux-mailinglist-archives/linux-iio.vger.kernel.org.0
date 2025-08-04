Return-Path: <linux-iio+bounces-22261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B222BB19DA6
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EF73B59CC
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 08:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F2E239E7F;
	Mon,  4 Aug 2025 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9GLkLez"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8F19882B;
	Mon,  4 Aug 2025 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296356; cv=none; b=O9gcMYmgCrfnwh6AX7XenguEcCkm2vFPBeeqG42NqaoNbE9Gx4lOonbPV6I3xufZgK5JXnU76Ado0T4i0xbtfdD95E/WcfL6r+iEovvGb72qs1mTk1HQNv32p2D79YePuWby+8eckOxMo9SBdPQnsP+wiBwdq3VFjc6bV9eUjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296356; c=relaxed/simple;
	bh=iTQYetpitRBpoxne1saf/xEb1/lIidaIbDsl0rod9lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ln3nVTczrqn7WQncZVN2mdYIsj8siXVXYjuwaXsPAKb/x5xSSN5oom3guqD0JXhIYKd6RGRCNtLRMHRjFhlvsdmPTkrbvLSaK3JiQJiGhtjFnqFEm3HlMpJLnEC30u+8g/ehjKbbxpK3wc+y+Tf+e6Zzp2jRdacn3mMpEuw5+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9GLkLez; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so6070238a12.2;
        Mon, 04 Aug 2025 01:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754296353; x=1754901153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTQYetpitRBpoxne1saf/xEb1/lIidaIbDsl0rod9lY=;
        b=c9GLkLezGz80ywYdWIjTBBZc1SRiftMm9Qla22cGewEAXnxnLA/ROjU3vLSBKliVKP
         zDflx1YWUAMtY1q8t8966UoEqdep6yaXNg5VwF7EEW84PUTJvG+AMtwWesFgRJ/+q5jX
         r9i9/JRjufn1r/jRqs6p2S3BCaEGvEblpGPgNqvBgzUnrO3kvQ+8FU6wbE9zBGzeveat
         pGZ55s3LbKZpZ6Tf2Dmwwpd/H4t9KVBYulmTSs+OSu9oirTnEvqEOYL2XDsRdDssIBIi
         r90oGJrFQvaJZVH5yNrhATQTKxt94K1N4OeHfmO6+u8LkQVy3cbX3eRza+4WHyPLhCZw
         v74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754296353; x=1754901153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTQYetpitRBpoxne1saf/xEb1/lIidaIbDsl0rod9lY=;
        b=u4pdCuMUgvgQRCDD/86Q+Jbz2QauEq1Z/+aoBvuAb3vjTKlJb7CrC+6G7BrVB++8S1
         rfuwQyEUCnvv/BW1GYsy5OsYcvh70OJTAV45CBcdmiTB1cU0Yx4IqMPASP3teJuGDS8+
         gGvxsLoC8CBlwEjQmjZX8FjH0Cxy8l59OyFA9OoGxRUk9nkfRs+f6r2xDbThxeuZ+LmX
         fhBxMVIlW3pL8pg3mguCtyH5b+dLr69wPaBNsHEp83xY06RT+hkaJ+wl2S1d9DdOXOUh
         9g02IQGhTGK3fIrycZ+r9npWOHwjrH+zPn6KThufd6psgTuDxor326WstC/f0ynAnjjS
         yk6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQJs1mTZA7LMdmAYp5vsCUCfwX2D1EqNN4y2BLWMm6RVT8Y4MsJNvWdgbhLzVKUAe6a4nicO3LCOIg/1Pg@vger.kernel.org, AJvYcCXSjCL3OTAl8A0b4NGiam6cGgDqmfOj43YrJOJRQCNDaSfhOzfAOUYF0Hv66EuBIuxg4MB/+ewVqU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNl9hC7gBrRMlftzTlxfgMQ65WjViAD1/ABEpb4HcWz6eQ9yu4
	kVCAy9ZToK5xcsQ+fpZUPVPVI6qHDGuwd+aNrYmYxMLtYLakdLsyZoT8uIVB4qF2Q+cc6eNF4Mj
	zACoHnQ0KNrVX5UBjzu9WAxM/M/xM/L8=
X-Gm-Gg: ASbGncuhoeCi95msVAg0y2MyUN04HkD9h5DvstsI7P9rrUy/V91Znt0Dsmdh977w+nA
	hYm8ciATBUQ/XeP9+54wolg8SyryPV6OMpLl1MxWHQYONa+QqdnGiPEq3Or4XhuTrNWt2mStUyS
	TATxCfAPuEUfM3x9sg9eimRqCBD5KWFODoS6RtcLX8EJblmzjyblRTDqC2pKPa3hjwEivs+1Klw
	vHARTbS4A==
X-Google-Smtp-Source: AGHT+IH6DeA/ce/hbahE7AcivAbp2pqKZ41PlGyGTZPzNybb1tOic3ZUG1nL+ONNjaTKvAR1mxAevqP6wvWdpdXHaAM=
X-Received: by 2002:a17:906:730e:b0:ad5:777d:83d8 with SMTP id
 a640c23a62f3a-af94016a3e8mr833174366b.29.1754296352789; Mon, 04 Aug 2025
 01:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754041258.git.mazziesaccount@gmail.com>
 <0ed3a1e9346d84d20838e89a531e8d99f95bcb97.1754041258.git.mazziesaccount@gmail.com>
 <CAHp75VerC+m1XMpZFO6dLp+0HdB1+Xn47on38Mg5AXfDYwWd4A@mail.gmail.com> <6aa66380-8109-472e-8869-bcdc4b0114aa@gmail.com>
In-Reply-To: <6aa66380-8109-472e-8869-bcdc4b0114aa@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 10:31:56 +0200
X-Gm-Features: Ac12FXwH6pqffRfL5zx6JEIdcbcEjz7rKaByIOHmB1k4dzhCdgkC3KqtCaBKkg0
Message-ID: <CAHp75VePYYH3VbOjY2r_1BuLZ-CEa+mJiS2SwSswsFhiha0VYw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] iio: adc: ad7476: Simplify chip type detection
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 7:56=E2=80=AFAM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:
> On 02/08/2025 01:01, Andy Shevchenko wrote:
> > On Fri, Aug 1, 2025 at 12:07=E2=80=AFPM Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote:
> >>
> >> The ad7476 driver uses a table of structures for defining the IC varia=
nt
> >> specific data. Table is indexed using enum values, which are picked by
> >> SPI ID.
> >>
> >> Having the table and an enum adds extra complexity. It is potentially
> >> unsafe if someone alters the enumeration values, or size of the IC dat=
a
> >> table.
> >
> > I don't see the problem here. I like the part about converting ID
> > tables to use chip_info instead of plain integers, but other than that
> > I do not see how enum is worse than the split version.
>
> The potential culprit with using the enum for array indexing is, that it
> requires the array size and enum values (used for indexing) to stay in
> sync. Eg, used enum values must be smaller than the size of the array.
> Also, the chip-info items in the array must be kept in locations which
> match the enum values.
>
> Yes, we have ways to do this, often using the last enum value as the
> size of the array,

> and/or using designated array initializers.

That's what I kept in mind and seems already the case in this driver.
That's why I doubt the brave statement in the commit message.

> It still
> requires programmer to do this correctly. Changing enum at the top of
> the file may break the array indexing (in seemingly unrelated place, at
> the bottom of the file). I agree this is pretty trivial issue, but it's
> still a thing to keep in mind.
>
> Splitting the chip-info in own structs and using direct pointer to the
> struct makes it harder to get it wrong.
>
> Finally, dropping the enum makes adding code which does decisions based
> on the chip-ID less appealing. It hopefully encourages adding _all_ IC
> specific quirks in the chip-info instead, which will keep the code path
> (IMHO) cleaner when all chip-specifics are in the chip-info.

Final argument makes sense to me.

> Anyways, Thanks for the feedback!

You're always welcome.

--=20
With Best Regards,
Andy Shevchenko

