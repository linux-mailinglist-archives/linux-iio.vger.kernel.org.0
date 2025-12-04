Return-Path: <linux-iio+bounces-26749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B7ACA44A3
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 16:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA0ED305AE50
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373842DC76C;
	Thu,  4 Dec 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDODQaAf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF21275AF5
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764862427; cv=none; b=Qt5gk8kkP/VFEYxal1a53wnG0WQPyj2rT9IRo3ojU3PDcZMcx942ewvKMXfUVeO0wIwsb9YgZpCC3pzVX5xNN+WhnURU6hSbvhqiw6Vc5vjXvawnPTHBZR7aPKYDmrjhG8M/rcxBfnFXIum890b59S7U2t8LcNMTFWvE6M3v9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764862427; c=relaxed/simple;
	bh=+QB236nZWvmf+vv0k7kEhrS4YqFdCk+3gZuDhXAbRGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zwr51m/89BzlTLj5lzZqxd2L4C1uRqJUCn/XLiW91NpFSrJEyM/r9OvkvefCCyFha9JT+mZ8C9l7Vnvdusvd6wPMnsxg1ki/cihLZTsEBtd9jQT16P2cFWi3fxLTISB1kJCGt4yQ1D4up4w+hfX96sqh1/mpctnQNLvR3f8v30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDODQaAf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b77030ffad9so165101766b.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 07:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764862424; x=1765467224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtfJKHoZGvy9YHPqXGgdsrF/13ANH6Jtv/wbt4evSm4=;
        b=gDODQaAfVReR0MsPaNjYaK5AupYyo2ZaSx6VdX2TJzTtCAYxkzVCqUwRifG016ZUjd
         QMeVU6ANqagIbIAVyymqn6o89WEaiMIMFV80Cv4V2aEmvELUfYgGlD+c/4ympLGYGdWI
         TovCeObaWYpxIvqA8O24KkhzZXAzw8Ut0ueua+5aKePgJYub9O8eC488grh0hsaXIjnv
         Mk+P9aZuARVj6Gx1szvR8wDhjCK7ZFI6jJNMGsrf31RGUXkTn5zCiz2FA1hLVPIF0oEJ
         f0/HdyH9wKLC2FxG59apAKKcjNBYcpC3cZX1Gqv0jLJuWxD+3bicTpTzl3ueY62pcEP1
         YjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764862424; x=1765467224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BtfJKHoZGvy9YHPqXGgdsrF/13ANH6Jtv/wbt4evSm4=;
        b=JYC7QKmrxLVels0EW4o1a/ho/XkUvVNn6D2JokWTgLcSV56ceb+38EAqVf3smnIapi
         8Tk28EKWwfeuF/4GYDNZAB4W+b2BuNp9OD3GftLXelqWr2I3BtcDQpL3cehmCaWu5Lha
         +4MM8gGwFOD+leBvBCS3hNCIb5eQEn+636ofpeOiCNLDsG4fxWJflaI4Z+4a5F5S2eaj
         lMDfVk0gxFyImmAaJMnCI3juqEDeiofnalktBa1XwN2EnB5pBerFzwWxjQxB4vCWi3LQ
         9hGey3ObZTHqDMXWU2MxQsLgZSK2fL5LtgR9SVfRW+D7h6noU0rsfJD7f6FyN6Yc2ofo
         5haA==
X-Gm-Message-State: AOJu0YxxfuNP6HtY1sYLv6tbXVn6Y7kDR7mFIcgMz4aXqvlZ9Wd8UBue
	O5pxIncj8xhiKXSjbF0+xkPNcMqm9kHm+eG/Y6e6Dxc07b/qV4gh2cXJVkGm/ieGQZ3A0I2paMk
	zDnFV1vRoe3D9X3EWMEp2ktcEpxWD+nE=
X-Gm-Gg: ASbGncvfrC01WdaTcJMInwxEYbz/YiPNlh4Soj5y67W+wm9/Js658JyLTFbsc0OAfi6
	BtED37P4DJezvTAJ9i592QoPJgDjw7WZN0BXwcXKBvnQAy/8FnqjWLign9uQtbzeWZd95Uu112y
	R98Sl/ajgsbY3i63moduVaWbZ7gJXXKi9rdgBrMKKca066XoG+QpOpnNnJ+hvvwVzHM+b3zCJe2
	O1N737ygjXRW9hW+EtkJzvfu6Qtq/v9s2pF4oLH/mJJpmlYHGobZmGCfAVCmNdzye6nHWFABlGk
	M2POgPqoT+DsqzA9E7ku3tP9dOlDn2WQX6jEDYlpfFvVFIHXJEuMgIHyh9/cItNMvBL9wdQ=
X-Google-Smtp-Source: AGHT+IE6zidAGFhjhNEdblRtf39l3+sKQXt2Vke7LvVywd/njcjAv00+Vwo4yBa3yvngUncn4Hf/1X6Nnj5IRwABIgI=
X-Received: by 2002:a17:907:96a6:b0:b73:845f:4432 with SMTP id
 a640c23a62f3a-b79dc520f21mr626852666b.32.1764862423655; Thu, 04 Dec 2025
 07:33:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com> <20251204-iio-axi-adc-minor-change-v1-1-2d441d6c5b65@analog.com>
In-Reply-To: <20251204-iio-axi-adc-minor-change-v1-1-2d441d6c5b65@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Dec 2025 17:33:07 +0200
X-Gm-Features: AWmQ_bkieDrvlYBUtF8tnbFJkCglmsW98pH0D_b-hmkjvjG2GGOxhpJ5H4m-Uzo
Message-ID: <CAHp75VdSAGxy-fkdigSFumKuRNDGtF-82sbdMoPyNpBVv5nB0A@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: adi-axi-adc: Make use of dev_err_probe()
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 5:23=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:

> Be consistent and use dev_err_probe() as in all other places in the
> .probe() path.
>
> While at it, remove the line break in the version condition. Yes, it
> goes over the 80 column limit but I do think the line break hurts
> readability in this case.

...

While at it, you may also add

  struct device *dev =3D &pdev->dev;

at the top of the function, which might lead to even more cleanups and
neater code at the end.

> +       if (ADI_AXI_PCORE_VER_MAJOR(ver) !=3D ADI_AXI_PCORE_VER_MAJOR(st-=
>info->version))
> +               return dev_err_probe(&pdev->dev, -ENODEV,
> +                                    "Major version mismatch. Expected %d=
.%.2d.%c, Reported %d.%.2d.%c\n",
> +                                    ADI_AXI_PCORE_VER_MAJOR(st->info->ve=
rsion),
> +                                    ADI_AXI_PCORE_VER_MINOR(st->info->ve=
rsion),
> +                                    ADI_AXI_PCORE_VER_PATCH(st->info->ve=
rsion),
> +                                    ADI_AXI_PCORE_VER_MAJOR(ver),
> +                                    ADI_AXI_PCORE_VER_MINOR(ver),
> +                                    ADI_AXI_PCORE_VER_PATCH(ver));

--=20
With Best Regards,
Andy Shevchenko

