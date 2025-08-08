Return-Path: <linux-iio+bounces-22467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B141B1EA6D
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F661704FA
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A80827EC99;
	Fri,  8 Aug 2025 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zu229Yr+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224454670;
	Fri,  8 Aug 2025 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754663677; cv=none; b=lWxgUnA4iPdsyqUXgMZy5UwwV54q/SZa+s+iN63wPiC900tVzXHtw905+wpdGJseqPMNhjnfgR2dbZMOmi6IRmUw2GCFMCr/+vdk3/+eXVJ1H420KZRYCz3u4FNaLqy8aGsbhxh3zjHQTLqKQJRqa+xfzxraa3mu5Q1rpxPYZOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754663677; c=relaxed/simple;
	bh=kYHUTT3Xqq8o5B/hrEPsdMBtPx9gOVTwcc+BdNCivKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkmgQEp/yG5gi+lvcm76FqBxduZzQjzFCASJQjr3Xz5t7ypRH90x2n/CoSKkFsHA2r6mvVPKg2iC7bzmcxtIouwgV7rg4x6cFHx7myYJGEY6BSQKqsxDAzTGPscCEbcm5CUQ059CUoKiLQAg4L3e28f/PHHoOqPr0VbGww+V1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zu229Yr+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso392697066b.1;
        Fri, 08 Aug 2025 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754663674; x=1755268474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYHUTT3Xqq8o5B/hrEPsdMBtPx9gOVTwcc+BdNCivKA=;
        b=Zu229Yr+SzP/24xwOPYuoHDHDIKidKE26ieci3ueSz07P6XElXSi6wYNmf1WO3WJXl
         OymQKwl8uItvoSUmLfUpBWEzQ72MC9HNC50uBZbgDAzgAsZw2pEj5RU311R1VVMXMm2w
         lENS1Pb6FJeo5HH92jLFqnjk9beYI1MORVaMJeIJXJSdYDX5t1L4DM/+qHFInt1R0KHd
         08ln8hZjDI1eCNX4tG5pCe7KNr9EYG1N3rhP9AoG8nxg5LNFXOrDyv1/QoL1I0DT9jOv
         VQTibeUmnQjnRm2p7m1PJH45lIElQFORwTCJAEZqac3aMKmjNGNaUlEY2l2GNjHpHsge
         a2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754663674; x=1755268474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYHUTT3Xqq8o5B/hrEPsdMBtPx9gOVTwcc+BdNCivKA=;
        b=TL4b8N1WZBvKad88S+MGUtVhR3zJwSAA9YlD3hsEGbPOWuG0M7ku8EUL9OpktEY8nx
         y5qKHGGWIIyxeqkPbmqfMulNVJP92X4t3yrFdfWUzC0Bcw+gY/DcoE3pfo6JMFEOhhNu
         leM6hDOcyl6wzgrgW1oCy5m9/fox/AUdrnNhXKOEcnCkR8Pw4SQuqbaSVdh87uGnnYnq
         Is7UNbJZO14z4ng//ZMTdhzLRdyeYItty6xavo7qQiqsf12skDB8tAuwpjaH/Nb38hkq
         ObP2YrmgpAGQJNfVGZeHv6ituykkF6huY4BRImqOdZG/Dhrdt0SJhpPovbGkCSHEK6uW
         T1rg==
X-Forwarded-Encrypted: i=1; AJvYcCUN5F/qE0wir0SuxqsOdGvbGpued3j7oqc8zVGc4NRvlSH3S7c2UFK9X3GGEDrUGCNRdfGfUdqfy/GwldLW@vger.kernel.org, AJvYcCV/V6S/Rj/ECO4l1PA2Ofl49i6XuUcC8tV73zGJJBUzYEJllE6qI6nc+oFMs0Kp3sFiW7Dppwa1pQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKgk+qwRbNZOwJu4IVoBUS0mFScEv77BYv3TgJ2utSQMLvZqkJ
	UCspTTG26AP54/RTnmvU1oE1zZJHWQNLSrTsWElqvu+VWghE8p8qJVbpFiIKuHwy8MH4qmZVr8l
	4BA6T5B2T/LJis1Am+h2LO5M2ECahMfo=
X-Gm-Gg: ASbGncsAcRRDaiihMye8Dmq6ivQWWMBNSgfrRO0Kna+fjpn/yxmMW37FKd67P+fu5Eo
	xQQ4onRlfXq1yXnYIaDXDi4ixvXiOAObYkVhKzMgbtgQk8qxT+TegY0xuQBJHzVmt8GkiZNB5uL
	McGZSl55weT0ZvYOGuNZrVKwNiSucFd58onJdWkhvhbR5pO5fAxMqCQZ4xxg7rngEM1SExyUpVi
	3pclk8Akg==
X-Google-Smtp-Source: AGHT+IHdXUU6FDGhQqwfa/Uv5/ZMqJrgOiAmWqcGJ5OuxyOkYHaeyxDl9A5vUp9Dn5DFaHbM4IyDcbnCFL3W4m6ioO8=
X-Received: by 2002:a17:906:9f91:b0:af2:bb2d:9b1e with SMTP id
 a640c23a62f3a-af9c640d8b5mr302323966b.5.1754663673960; Fri, 08 Aug 2025
 07:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
 <CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com>
 <CAE3SzaTBzF=W9++d4CmW-vRkKLy9zd2oB4ADX8NuH-woTvJxqg@mail.gmail.com>
 <CAHp75VePmhLstCraz_+7Cqc_bLQ49+1rV4oH59a1oo2xHp0R+Q@mail.gmail.com> <CAE3SzaTq90n3HP6UrtimxqbmhfkxPNBdby0tY9bxbxzc9pqvqQ@mail.gmail.com>
In-Reply-To: <CAE3SzaTq90n3HP6UrtimxqbmhfkxPNBdby0tY9bxbxzc9pqvqQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Aug 2025 16:33:57 +0200
X-Gm-Features: Ac12FXzW7zU9TPPQc2hzh4WpiG5wkdv_uRWURdmFwu_Mpk8oUs5RatFEdSasUMo
Message-ID: <CAHp75VcqBtSfd9=e2=AYnNhYJgWXUA_GFLFpOjKZDS32jNvCaw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add remove callback with needed
 support in device registration
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 4:24=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.co=
m> wrote:
>
> On Tue, Aug 5, 2025 at 6:18=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > Are you sure about the remove stage and how it interacts with runtime
> > PM? Please, check how the device driver core manages PM on the remove
> > stage.
> This driver does not even have support for runtime power management.

Exactly. And my point is to enable it instead of playing tricks on ->remove=
().

> Pardon me, but I am not able to see how runtime PM came into picture.
> Am I missing something here?
>
> Code walkthrough says the remove call flows from
> driver_unregister------__device_release_driver--------
> dev->bus->remove ---- i2c_device_remove-----.remove() callback.
>
> Request you to correct me here.

Right, and now find the PM runtime calls there. Put them in the
picture and you will see my point.

--=20
With Best Regards,
Andy Shevchenko

