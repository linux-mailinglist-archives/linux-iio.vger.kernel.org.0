Return-Path: <linux-iio+bounces-22309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF213B1B3BE
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 14:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDB33A7D80
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE0926E701;
	Tue,  5 Aug 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl5Obup4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA1E17BA9;
	Tue,  5 Aug 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398093; cv=none; b=hYVAWtRjHr9PATBMT/2HfaKQQqeU8L8n8w2JjTyc/an4Sxf8GcVNQq62x6Cekdwa4O0vH2QPj4N6feaGXcpnPakCfOwhYpAl1s6YKWiaeVKNdmGqs1xtzt4EC7lusjsu5X/wd67EpMIgp8lVz51L8jDCEdtChBuPjxNTdFA8zqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398093; c=relaxed/simple;
	bh=puskYHQyC6KL85FMnyUigLBXFVESpYhBrg0RpClDOWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2rVj91C/zH2Hvk2xRFr6o2BBhruyGF0mMQ3hGI7/TJ2vU7AlyLnskfpsRmC2oWiosfyta1blepo8nCkbUdtdgu9HG+r3QmMf85rCYSmpiLFw/tGaYHDdFVBRkqjcEWo6DzxK1gYIwDlJkW5lvQsE68EQj3IfhcXxk7KqgLOJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kl5Obup4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af93bcaf678so504525366b.0;
        Tue, 05 Aug 2025 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754398090; x=1755002890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRPcVMFRBdpJOvWHPvTEp2JM/aBDAM2/KtZKKIHDMGg=;
        b=kl5Obup4d3lXGP4Qh4u7sWP/vfnyVkkQ9T2NBzeJbMA88Hvurhmr0qauxz82U0Lw2x
         EaLVCl1R3WC8//lE2N2oJA1wBKB8gUfGiM4XAtDfD1o9CAbm7rFBy2oKH+R1H5SjazFZ
         pPzZQosTefNbh+dCz5R4q0OstYuV0AjWYjsd1yFAe9tjh0/ir+3FFwDn/eo1u9pj9do/
         9PMBWPaObFSBdbCfqC3QNQbObnusTTxSZ2ZJZSqBoRMLm5zwxGJcquUS9xiXusywh5/B
         Y7T96ZF9fzi6QgizUo6OI9+1hd3Qgj8dNbPBHDonb7MkmQStRRUy0stGbpubl5vv577D
         wj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398090; x=1755002890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRPcVMFRBdpJOvWHPvTEp2JM/aBDAM2/KtZKKIHDMGg=;
        b=CsMu0LNDsh0hYnO3+QxKl7uaBaecX1XRdkJHUlIB30DceoCJWzs1EEhuSeI72u/lH2
         4aO87s0P/PDJx6nO9pigSzb8rMmQa7fGbMK52CtYMVGim4IVukgT687Z3oVE3bMFD3kW
         sx9DrW1MDMP28CkrHP0qW4pc6KI41LZUaxhV8gLlmVJ4TSlbZghaCXV+eNWHQZKd5d0U
         58Rn+oYd6atQKaYjavQMar69aKwsYb+sTlwQxmtaMtsNJ20KIRtRBUQAz31mDPiYiEWG
         Z7A54agmhuB0cfpCInjutxda3+wjelRK0wRGlsci+BaByR/Npi1F7BNuRoFATuB//Qj/
         ib8w==
X-Forwarded-Encrypted: i=1; AJvYcCVV1jE4g5ub+MiHTGA5zRCLp3UXsf5Y9x5tfFjHDSjrIeSYGK0/j1AFhzhYUwLpgn8xhLk5Teqs7NZ3qmDZ@vger.kernel.org, AJvYcCXGrYxdh9Xo41QgIjXhHe1iUonxTD04MDZYKM7FNIk5ShmNV9CPhn4/zLgLtZhEq5Lpmmxp0LO3v48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPf/JtTopOFUDOrWmNN2evxc0+rEaAQ2P+hFley8LNa+Td74W0
	On4nDRotP62PV4I+izatLFpE5ZOMqqwTqI6qgPuA7Ta4k7ardSAby9edW4WHcJLuPGCTK0U7UYj
	v7k7/RCX0bbzjmOXtj4PwxGG1k5stf6I=
X-Gm-Gg: ASbGnctK328dPBheunulaiLmKn4uXgrM/IFjH67LSdK1fyslhnt9cwUoRPF6BxaBAXi
	hFo78MiuPpWIZkLPEtdhX8ovmluXqd0UMd0HGkdjt6ukNGLXvYazDHqjQ+mn/xScrjfyCy80YBv
	s0e3LL35LFf1XffE/R1JN5b1x1oUUVjsmIxvj3iBk0BcqihhHmiMt4mW44FKwIwvQi3IEPG69rs
	Jm/G1bVIw==
X-Google-Smtp-Source: AGHT+IHGF9Ud8gh8UvtlfG6tG2ciUV6ow5sjsaPmKKNcVLwPdsG7ADxVDRcqjNqsUWkecXeSBKFszhGXbhw+3+NbI3w=
X-Received: by 2002:a17:907:7292:b0:ae3:f16a:c165 with SMTP id
 a640c23a62f3a-af9401aff4cmr1379494066b.31.1754398089425; Tue, 05 Aug 2025
 05:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
 <CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com> <CAE3SzaTBzF=W9++d4CmW-vRkKLy9zd2oB4ADX8NuH-woTvJxqg@mail.gmail.com>
In-Reply-To: <CAE3SzaTBzF=W9++d4CmW-vRkKLy9zd2oB4ADX8NuH-woTvJxqg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Aug 2025 14:47:32 +0200
X-Gm-Features: Ac12FXzFtjMEtaNWvs1Vz485HQLvS005IiKgjdLb6tmVsPWtaxaqbf-fjJ7cKoA
Message-ID: <CAHp75VePmhLstCraz_+7Cqc_bLQ49+1rV4oH59a1oo2xHp0R+Q@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add remove callback with needed
 support in device registration
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 6:05=E2=80=AFAM Akshay Jindal <akshayaj.lkd@gmail.co=
m> wrote:
>
> On Tue, Aug 5, 2025 at 2:36=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > Doesn't sound right to me. HAve you investigated PM runtime paths?
> Yes I did investigate and found that PM runtime->suspend() callback
> co-exists with remove callback.
>
> > Looking at what the code you added there it sounds to me like a part
> > of PM runtime ->suspend() callback.
> Yes, part of functionality will always be common, because both the
> callback implementations put
> the device into powered down or low power state which is what has been do=
ne here
> Both _suspend() and remove are called at different times in the lifecycle=
 of the
> driver, but with respect to register setting, they put the device into
> power down state.

Are you sure about the remove stage and how it interacts with runtime
PM? Please, check how the device driver core manages PM on the remove
stage.

> Additionally .remove() can have code for:
> 1. disable runtime power management (if enabled while device registration=
).

If the device core enables it for you, it will disable it
symmetrically. I don't see the issue here, it should be done
automatically. If you do that explicitly, use the respective
devm_pm_runtime_*() call.

> 2. device cleanup (disabling interrupt and cleaning up other configs done=
).

Wrap them into devm if required.

> 2. unregister the device.

Already done in the original code which your patch reverts, why?

> For eg: another light sensor bh1750
> static void bh1750_remove(struct i2c_client *client)
> {
>     iio_device_unregister(indio_dev);
>     mutex_lock(&data->lock);
>     i2c_smbus_write_byte(client, BH1750_POWER_DOWN);
>     mutex_unlock(&data->lock);
> }
>
> static int bh1750_suspend(struct device *dev)
> {
>     mutex_lock(&data->lock);
>     ret =3D i2c_smbus_write_byte(data->client, BH1750_POWER_DOWN);
>     mutex_unlock(&data->lock);
>     return ret;
> }

Correct and where do you see the problem here? Perhaps the problem is
in the cleanup aordering and some other bugs vs. devm calls?

> In drivers/iio/light, you can find similar examples in pa12203001,
> rpr0521, apds9960,
> vcnl4000, isl29028, vcnl4035. You can find many more examples in
> sensors other than light sensors.

Good, should all they need to be fixed?

--=20
With Best Regards,
Andy Shevchenko

