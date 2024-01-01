Return-Path: <linux-iio+bounces-1388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B638215EE
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jan 2024 00:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C821C20E84
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 23:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF79EAD7;
	Mon,  1 Jan 2024 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR1q34xC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C694EAC2
	for <linux-iio@vger.kernel.org>; Mon,  1 Jan 2024 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67fb9df3699so64449046d6.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Jan 2024 15:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704152923; x=1704757723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfXx5EgIM2G598PM8J8r6p3UFtvOXtIH6UL5jxCI4q4=;
        b=NR1q34xCF73217tFtz8zbxjE9RdhlciMAFJmAEIjW26ToZ6ZY6fuMJ6bSKe8QL4FMv
         pYnW0RDl1cQaXLFEPy5gIVDTJ4K2ET2QTSWIDoi/zimGIqvDeSQqLBkEJEQYRmISQkJt
         l8AaDc3/Lybi2qLTDJEsT6NGyLgKBGtP6aFTbvi0fGp7KI3Jbv4DKZnYQ94cc7d15hgg
         hrrrLOMkxGnBSWOCJIAkxmKH7AxpXUrpFEqJX4fNw3MmUDIbyuzuaVJ51vqoAChNe3sS
         9n+sK/yceAXa3P/Ds30gOWoF8j6m9QVbViytHCp24gxTvAZ9aUHWTpfwA6tn5+mionJ6
         faOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704152923; x=1704757723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfXx5EgIM2G598PM8J8r6p3UFtvOXtIH6UL5jxCI4q4=;
        b=A44kyk6piPM8iBCZyeJcDX/FkGQMEaguWyt4pck0aSZlW6joxMz5kpZP2+0LcTwV/M
         IskbOHBcusFn6B6IbE8hNHnqhEP7uO3C16AurJXU94+6hlQfhfIKYjuF9wKlEC/7BHCD
         nyh7nQBQ/mcTYtDp7g599x5K4jNQtnVaTAaCBfX/QQJZWeK4ID8NhVp22vyfrnceiU6s
         Jq1TUV1yZbTN0ibKn8kgwS3ihEsXXgw7IHf2MAbepOlRU0h7E7AveYMgKKPDx2l+kZPv
         qy2GxBET5ig0RTcBiebcTn7uLuvz1UVgAgurhNJamhvBoDBEEXCKgl3ow0DaZm5qc9ks
         tXZg==
X-Gm-Message-State: AOJu0Yzjyf5Tm+txIhhnDBc5puPsn1yu8tGhnA2dmOrtbw5EJOXSgaDn
	e8ZEKfQBRnJnJHsprjC/aVcmgIRtuIxZt4NR5e76qaUaHeI=
X-Google-Smtp-Source: AGHT+IHxRa/ZzlgolZsKDl2sWFYHaw/Fa7uHmjAxs7WWj9XRmMOqddBQL2ypCaxRF83mdOriDx/a/XFLrKdFwXXygvU=
X-Received: by 2002:a05:6214:1049:b0:67f:9d81:829c with SMTP id
 l9-20020a056214104900b0067f9d81829cmr19323848qvr.119.1704152923402; Mon, 01
 Jan 2024 15:48:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231183514.566609-1-jic23@kernel.org>
In-Reply-To: <20231231183514.566609-1-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Jan 2024 01:48:07 +0200
Message-ID: <CAHp75Veup_8sxqk3_sc-_5kmPA295eCcRzD4-GZ9QCWuOFA=mQ@mail.gmail.com>
Subject: Re: [PATCH 00/24] IIO: Clean up ACPI_PTR() usage.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 8:35=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Many of these patches touch ancient drivers so the authors have long
> moved on to other things. As such I'd appreciate it if anyone has time
> to take a look!
>
> The initial part of this series deals with cases where unused variable
> warnings are generated with !CONFIG_ACPI but they most date back long
> enough to predate this being reported by lkp in general and the lkp folk
> have gotten push back not to push out such reports due to the high level
> of noise. I think some of these were reported to me directly on my
> Huawei.com account but aren't on lore.kernel.org. If I can easily
> track down appropriate closes tags I will add them when applying.
>
> The last few patches are for drivers that did have the right protections
> but where the usage was so trivial I'm not convinced they took the best
> approach. In the interests of not leaving cases of what I consider an
> undesirable pattern around for people to copy I have dropped the ACPI_PTR=
()
> usage and config guards from those as well.
>
> There are 3 remaining cases of ACPI_PTR() in IIO. In each of those there
> is a significant chunk of ACPI specific handling so the relevant guards
> are there anyway and the complexity is more easily justified. I have
> not intent to touch those at this time.

Long awaited series, thanks for doing it!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
(with some individual nit-picks that you may fix whilst applying)

Side note: We now have: array_size.h, container_of.h, hex.h,
kstrtox.h, sprintf.h.
You may start considering replacing "proxy" headers such as kernel.h
in the code.

> Jonathan Cameron (24):
>   iio: accel: da280: Stop using ACPI_PTR()
>   iio: accel: kxcjk-1013: Move acpi_device_id table under ifdef
>     CONFIG_ACPI
>   iio: accel: mma9551: Drop ACPI_PTR() usage
>   iio: accel: mma9553: Drop ACPI_PTR() usage
>   iio: accel: mxc4005: Drop ACPI_PTR() usage
>   iio: accel: mxc6255: Drop ACPI_PTR() usage
>   iio: accel: stk8ba50: Drop ACPI_PTR() usage
>   iio: accel: bmc150: Drop ACPI_PTR()
>   iio: gyro: bmg160: Drop ACPI_PTR() usage
>   iio: humidity: hts221: Drop ACPI_PTR() usage
>   iio: imu: fxos8700: Drop ACPI_PTR() usage
>   iio: imu: kmx61: Drop ACPI_PTR() usage
>   iio: light: jsa1212: Drop ACPI_PTR() usage
>   iio: light: ltr501: Drop ACPI_PTR() usage
>   iio: light: rpr0521: Drop ACPI_PTR() usage
>   iio: light: stk3310: Drop ACPI_PTR() usage
>   iio: light: us5182d: Drop ACPI_PTR() usage
>   iio: magnetometer: bmc150: Drop ACPI_PTR() usage
>   iio: magnetometer: mmc35240: Drop ACPI_PTR() usage
>   iio: potentiometer: max5487: Drop ACPI_PTR() usage
>   iio: st_sensors: drop ACPI_PTR() and CONFIG_ACPI guards
>   iio: pressure: hp206c: drop ACPI_PTR() and CONFIG_ACPI guards
>   iio: light: max44000: drop ACPI_PTR() and CONFIG_ACPI guards
>   iio: adc: ti-adc109s102: drop ACPI_PTR() and CONFIG_ACPI guards
>
>  drivers/iio/accel/bmc150-accel-i2c.c       |  2 +-
>  drivers/iio/accel/bmc150-accel-spi.c       |  3 +-
>  drivers/iio/accel/da280.c                  |  2 +-
>  drivers/iio/accel/kxcjk-1013.c             | 33 +++++++++++-----------
>  drivers/iio/accel/mma9551.c                |  4 +--
>  drivers/iio/accel/mma9553.c                |  4 +--
>  drivers/iio/accel/mxc4005.c                |  4 +--
>  drivers/iio/accel/mxc6255.c                |  4 +--
>  drivers/iio/accel/st_accel_i2c.c           |  5 +---
>  drivers/iio/accel/stk8ba50.c               |  4 +--
>  drivers/iio/adc/ti-adc108s102.c            |  4 +--
>  drivers/iio/gyro/bmg160_i2c.c              |  4 +--
>  drivers/iio/humidity/hts221_i2c.c          |  4 +--
>  drivers/iio/imu/fxos8700_i2c.c             |  3 +-
>  drivers/iio/imu/fxos8700_spi.c             |  3 +-
>  drivers/iio/imu/kmx61.c                    |  2 +-
>  drivers/iio/light/jsa1212.c                |  4 +--
>  drivers/iio/light/ltr501.c                 |  3 +-
>  drivers/iio/light/max44000.c               |  6 ++--
>  drivers/iio/light/rpr0521.c                |  4 +--
>  drivers/iio/light/stk3310.c                |  4 +--
>  drivers/iio/light/us5182d.c                |  4 +--
>  drivers/iio/magnetometer/bmc150_magn_i2c.c |  3 +-
>  drivers/iio/magnetometer/bmc150_magn_spi.c |  3 +-
>  drivers/iio/magnetometer/mmc35240.c        |  4 +--
>  drivers/iio/potentiometer/max5487.c        |  4 +--
>  drivers/iio/pressure/hp206c.c              |  6 ++--
>  drivers/iio/pressure/st_pressure_i2c.c     |  5 +---
>  28 files changed, 60 insertions(+), 75 deletions(-)
>
> --
> 2.43.0
>


--=20
With Best Regards,
Andy Shevchenko

