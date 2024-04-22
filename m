Return-Path: <linux-iio+bounces-4432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC588ACCC0
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 14:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985F1283372
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15CC1474B5;
	Mon, 22 Apr 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azdWQuLf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3849C4AEE0
	for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713788968; cv=none; b=X09YVa+Qe8uqmtPwchXT2FE7NCbgkj2zSSrpv3NWZgTQnYw8p5EdEN4hx7Bd3hoOg8AE7tMdQbL3CcZv12QKqZWKV+qtza3X5qK4utvfO3QlL3xTWX2ql8tu+ElQzSrdGeEoqJFxTla4wQm1JhTx1F+aJswilOg8q9KA29zQOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713788968; c=relaxed/simple;
	bh=tY3hqOMNYscz9jzHHBdAglRztHVYeixQfzoF5uBTcc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMeNkdyl6HWJULpLRQs7xHP9rb2Vsks0s5liag0vkigxy4trRs0B+TWIbcB/QIfSNYux+3bToC8it/TULAa9T/FdUNaLjYho8jdA38AoErxgQMbbhGPiH/lPAxoUyAoqz+76wvirnQzdT3YT5BsDxbwrdXXo78EKWpL7Rs7paUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azdWQuLf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518f8a69f82so5215167e87.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 05:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713788965; x=1714393765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2prIhMqy/1vH22JrqOdcseM0ZWL1h/fj9GI5fvBttto=;
        b=azdWQuLflIqie1rEsFMgG2MtsTXCNpBGPWX3RBHuiYFh1xNYy0kmNi1aVkQ0hKyrAF
         1+Z46Ew/TjwzpdobOLZhkAFA1R2iDW4UO6IZQp4DwEa404rVwff7DLxUdY0hJXvYqXWB
         Jap3YvDhwV2KMUB5riygaVaBxQA+kUvcoT2rmkNZT4EuJfc++qb1BVDfvIq+UXZnAy+P
         jUjXn+M5CYk1XfHGyYM+eCjMpY8UXetyA0EYlzig8hMo8BZjPLgv8757YlrnH1E9QYXA
         FnOWN8Kw9uL9hKTA9HGDPFAwlJ2JvT/C74mdbG6Xxe+Cmg/B5ttcsYoFfSFqnd9Nr3yv
         S6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713788965; x=1714393765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2prIhMqy/1vH22JrqOdcseM0ZWL1h/fj9GI5fvBttto=;
        b=Ogz8QqR/l4wJYRZ0cjYNYUXEXFD96VgwxbIBOz0Q1+AC1dl3yz0gQLP6GsgJRs3NQC
         04V+tjQBrUzREYxNg+3oJnno3BfZlUX0ksiLz1ctt1VUaR+dJTu21BhLV3y3FKglWwHT
         uV9yrFehtjr1wpWQHyOetGOdlu5aWDoTi7XPfVts8+9POyzqnWNhgzPjApV5f6IixXwd
         Gsk8/mW5NbuLkeAShmaVx61MOnn3ijtbvOHbaoJRJcghuEFJoHkXWg7Rahw+dfEEVAsr
         f6FIgMOEO/1x9t5lz4fEmCtEkGXUepGg/uMUpkPHpWTqX/YOUdJoQyBk2mcXsuEZLbx0
         PHPA==
X-Forwarded-Encrypted: i=1; AJvYcCXQD6k2BUltPj9l0guYhtONqaNLI6wFGjuCrjHKh8i1glo0hkUY31gO4faNFS6tqXoMOmlIku3uB8gqGjf2bVQ//dzKr4FVwCU6
X-Gm-Message-State: AOJu0Yx+bJjtG60i+T71rsWRhJradXOPO/jKs9JbAC7g8HzEpy4UPJJr
	FP4q1baAvN29z8ZX2KnsUICLB5Rf9zkFoTP9MsUDFTTvLnMYAj6baiFsNLVwiqllwx/dqJ7ZnJM
	Em127xQgZfFzTQGbZnSawMqg7KEE=
X-Google-Smtp-Source: AGHT+IHtGDCbwfN/GWI+hbwgESlSj9wQP8Hj+23LNPfvVQvDa4tk3tRb1WJK9LGkvJINv04D7bZXYfF6sbfJrxMndgk=
X-Received: by 2002:a05:6512:31c9:b0:516:cc31:dbf0 with SMTP id
 j9-20020a05651231c900b00516cc31dbf0mr9618679lfe.17.1713788965135; Mon, 22 Apr
 2024 05:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417164616.74651-1-hdegoede@redhat.com> <ZiYX5JlwS9nGkS2Q@surfacebook.localdomain>
 <81f83cd6-6d17-4e11-97b6-7f1f11bc3078@redhat.com> <CAHp75Vfsnffq8J=j9-8w2VWHyMp4e5gw7F11S8XMdMN8TXMwKg@mail.gmail.com>
 <1b497e81-3e2c-4b07-a922-79d92054d6c8@redhat.com>
In-Reply-To: <1b497e81-3e2c-4b07-a922-79d92054d6c8@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 15:28:48 +0300
Message-ID: <CAHp75VcpbQZZtw2ReLuGMoyOYy8sSEuVf7j1dopt6gkWecAoag@mail.gmail.com>
Subject: Re: [PATCH 0/4] iio: accel: Share ACPI ROTM parsing between drivers
 and add it to mxc4005
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Sean Rhodes <sean@starlabs.systems>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 2:45=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
> On 4/22/24 1:33 PM, Andy Shevchenko wrote:
> > On Mon, Apr 22, 2024 at 11:24=E2=80=AFAM Hans de Goede <hdegoede@redhat=
.com> wrote:
> >> On 4/22/24 9:55 AM, Andy Shevchenko wrote:
> >>> Wed, Apr 17, 2024 at 06:46:12PM +0200, Hans de Goede kirjoitti:

...

> >>> I have briefly looked into this and I like this, except the part of t=
he big
> >>> function being in the header. Why? Why can't it be in a C-file?
> >>>
> >>> Note, 3 users justify very well to me that shared code, should be sha=
red in
> >>> binary as well. (I.o.w. you may argue that IRL there will be no more =
than
> >>> one of such device connected, but in case of DIY and prototyping it m=
ight
> >>> still be the use case.)
> >>
> >> It is only 1 function and it is not that big. IMHO the static inline
> >> in a header solution here is much better then making this a separate .=
ko
> >> file with all the associated overhead.
> >
> > Look how the i8042 RTC header became a disaster. :-)
> > Nevertheless, this can be part of the IIO core for the ACPI enabled
> > kernels. Which eliminates a need for a separate module.
>
> Putting this in the IIO core, with an iio-prefix, so say something like:
>
> #ifdef CONFIG_ACPI
> bool iio_read_acpi_mount_matrix(struct device *dev, struct iio_mount_matr=
ix *matrix, const char *method_name);
> #else
> static inline bool
> iio_read_acpi_mount_matrix(struct device *dev, struct iio_mount_matrix *m=
atrix, const char *method_name)
> {
>         return false;
> }
>
> in include/linux/iio/iio.h ?

Yes, like SPI, I=C2=B2C, etc. do in similar cases.

> works for me and that also avoids Jonathan's worry about using an acpi_
> prefix in iio code.
>
> Jonathan how does that sound to you ?


--=20
With Best Regards,
Andy Shevchenko

