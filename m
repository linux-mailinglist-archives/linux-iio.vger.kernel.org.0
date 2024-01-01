Return-Path: <linux-iio+bounces-1386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1E48215EC
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jan 2024 00:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4212281AD5
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 23:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AB6EAC2;
	Mon,  1 Jan 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxEvQNs+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1D0EAD3
	for <linux-iio@vger.kernel.org>; Mon,  1 Jan 2024 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-680adbf077dso14304686d6.1
        for <linux-iio@vger.kernel.org>; Mon, 01 Jan 2024 15:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704152034; x=1704756834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSoURcoSFY9bGxwMvZ1RYoA5wmX6ucrA/F93oxLouyE=;
        b=FxEvQNs+vdPBzdwolGAiQ+p00ZP4ClIymUYn8GSiQtAN+ussvIOat8dGi3fS7q8cJV
         kWcqkDQzn4rOBqUj5L68XkceVS21J4+uxQH7rV0t55g1E5VF+7hpG3oGI3oymdPUGJRB
         zf4jxWIJ4FXNyLPbTkQYDxA0iMrmFDbon/myWOXJHWUc7D2BL9oMEoeXbXN7sFx//I/m
         ktFd/GPJ9v8DEEmVSZn1qKtSTMT203QiGmPuO8VKC0lcJ4rorFODvO0XAJ64ki/qsKUM
         BjYdigwY11ORv6Mk/PjOKFXubAGRYj6CsnwXvnT6VZIzf0wjh9OZWr9a33klEOfhdNa7
         x/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704152034; x=1704756834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSoURcoSFY9bGxwMvZ1RYoA5wmX6ucrA/F93oxLouyE=;
        b=PcimzPvpZlNIVty8DZNfCmpZIcv/Z4yEHgTwjSDfPaKcC8RmOPGIUDIiaQrPVsBikc
         2CROePC0GyDN1fzUzQhy6rZ+xSAhrSCzWd7Cg7ay7hjEFrOvVPDpLyxPNaS/HM3B7lvO
         0ngjEY+fAhj7YaChHimY8jsVOv++yntpsfuQ0aeEstoPTrJUA0XU48c7Sxa2Pt8YxE0r
         DRz2bBt167wGMZ5pBy1wJh6zUxVCMFHDHQYtdzgF2bLiApcHe44UZA9Kv5iDAbJjhqx+
         G7zq1rlffl8bvFoQFnB6SVr6HSEZ6i6V842kF4ZJncheJWlbIiWjEFPX5p1lCh6zX9JW
         Bz4g==
X-Gm-Message-State: AOJu0YzWeEneG4pQ7trdRGBaL3C2Pc//dMGL00zjwHdoQGk7mipBMT+h
	+srr8ey0Gt9Ygy16N2+cBFbRfBHzYr90XvO3t1A=
X-Google-Smtp-Source: AGHT+IHCsRa4BYB1xSvvwE/DgpNtW8mWCf9uSx1nhsq2NVFcl43Qve1yfP4PgLIgugBCSUutUeOOXnl4r/ctqm0UtZg=
X-Received: by 2002:a05:6214:21e6:b0:67f:e61:7f08 with SMTP id
 p6-20020a05621421e600b0067f0e617f08mr26475107qvj.69.1704152034056; Mon, 01
 Jan 2024 15:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231183514.566609-1-jic23@kernel.org> <20231231183514.566609-3-jic23@kernel.org>
In-Reply-To: <20231231183514.566609-3-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Jan 2024 01:33:17 +0200
Message-ID: <CAHp75Vdyriv8cqGEomUtmNv9rVGfL47QVJ=7kUEm150edMP1gw@mail.gmail.com>
Subject: Re: [PATCH 02/24] iio: accel: kxcjk-1013: Move acpi_device_id table
 under ifdef CONFIG_ACPI
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 8:35=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This avoids a build warning due to the use of ACPI_PTR().
> Given the driver already has APCI specific code under CONFIG_ACPI move
> the table rather than removing the ACPI_PTR() call as we already
> have the complexity of CONFIG_ACPI.

...

> +static const struct acpi_device_id kx_acpi_match[] =3D {
> +       {"KXCJ1013", KXCJK1013},
> +       {"KXCJ1008", KXCJ91008},
> +       {"KXCJ9000", KXCJ91008},
> +       {"KIOX0008", KXCJ91008},
> +       {"KIOX0009", KXTJ21009},
> +       {"KIOX000A", KXCJ91008},
> +       {"KIOX010A", KXCJ91008}, /* KXCJ91008 in the display of a yoga 2-=
in-1 */
> +       {"KIOX020A", KXCJ91008}, /* KXCJ91008 in the base of a yoga 2-in-=
1 */
> +       {"KXTJ1009", KXTJ21009},
> +       {"KXJ2109",  KXTJ21009},
> +       {"SMO8500",  KXCJ91008},

> +       { },

Can you drop the comma, while at it?

> +};

--=20
With Best Regards,
Andy Shevchenko

