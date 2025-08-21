Return-Path: <linux-iio+bounces-23078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5A5B2EFE3
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 09:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BADEE176C71
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D8827FB2D;
	Thu, 21 Aug 2025 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y56494OW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A77A2475E3;
	Thu, 21 Aug 2025 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761845; cv=none; b=MptdsZVhiZm74jiuz+9b7r1+vm0co8DDTZxRUaGZMBWXfQzWHuimxw+/2Zkn6Ejs9gic1DZd7hI41cv9Jqja7xSxc4lVw4bHs6J1zmd5OdhTaWSPpPLOh4KiKkEb0CvTcF4teSl0tnZGaeftNoyZueLOM6what2n/DDIODM0oVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761845; c=relaxed/simple;
	bh=3kbdTGNhBGkfs11dz/zU9MhRJkL/GeXAirIfRKZE6cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzG/6UZR0ayaQiEafs5wQnc+L+pkwB+npqBPL0hvIdgNWMaM1YOTv3kPC9bvCzoJoIw4ls0l0o2Mtd6UacKuV0YTVw1jNoY6Lta0vPP2wemsqUlnlb1nFSpcZAHTOXQ9BCXI5fmKJpoPzLOeO1pOOxcAmxuTXs6bei0i2Rfk0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y56494OW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ae31caso133554166b.3;
        Thu, 21 Aug 2025 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755761842; x=1756366642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24G+nBqd0Wh3p3XQK8bKfArAh0wXUKeakrnoiFr0zuE=;
        b=Y56494OWEjELxukDDN58prMPfAJX6cX/cK4gleJBW3Bfkwp7pQrCc/1a63jGbXlo6w
         rrS3XKPfST5FaSM69rHq8m1ukeOYWh1vdPqzwrngpH0lyJDsxlQzAKoKbc+uAiu/SozV
         CjoW1GItyOylSNq20pXnChYW5KmNJI5a+1AnZw4C8tPwYjwKhqm9Ls0flsPrSg5ZmZYl
         n3B/UIA+TGC3/GilefLRcR/PffVQwt/iDlEiBt4Y3tfBAHUeZ7/vbd7M3a+MV3PD+hG0
         1whwtG02nMiTarSV4R/+j4oOYn9kZpaQPfQo6vL62+sha2V4cuPNfeMM9ZTmg5I0fLqh
         ghHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761842; x=1756366642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24G+nBqd0Wh3p3XQK8bKfArAh0wXUKeakrnoiFr0zuE=;
        b=m0O2TFiy1uLShC+k2QSuVazUOjXuwfuB/WDVtClutyAr+z7XXIKI5Y1K7+hEd111sD
         y+q+rmQPC2h0jPhdBDtFOozPO6gWs/DgEoFkC2szdtktcivSY0ls2x5XmoNoGfd8z9/K
         FSTmxPIncJzC8VHDaY9rI48XE8OE6Vcmt1MPlbwYdZ0fE2NpGl2TIYjQx+Dk/BfQA9Mh
         DkTfq3ljWXK91chhD2Jkg2zJjQgqqk64FzHbjCagIXcQHAHc3Y4ESWE2E8csEmfXJEpR
         n8b23fa3ZJwVKAgAubxL8sPddG9athyfsAL5CR+G59IsXr0rnA9Z1g3+jp0C3T7C9P/n
         jfRw==
X-Forwarded-Encrypted: i=1; AJvYcCUqAjJkjKO4cLcJ5TWtyZa0XjAlVoiG+yoctJyPsT9J/nlPKrEqPcN1oUMst46DTwQSbsTX9aGpMOMECJxn@vger.kernel.org, AJvYcCXYT8Lf7w47xhNEwFVjKcplHod1/h7GYtTCZXaA9FSQsk7F74E+SiU1dwj3wAml6dB2qP5FE7SUq14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOfb+dp1Qd3oYVy1SxTH3SsK2gC1WbU7DgSSW+AguVmeKRBLc
	saYixwYcKl7lTaDr8dKbtehzue3ZV26XMfbgHcgSjzX+LVGqt+qN92/173L//Gdw+Y4L+/MoCH1
	Y84nTlhNhlg+Xh7FhvpflI6HkL5JeIEvQBzfG9XY=
X-Gm-Gg: ASbGncs9Z6mlIp0aTl1cVZ97nlqPp6S/jvZRlDO96N+5tYjoADjimTWPquPLa7/o8QL
	hTh7VcF0RUqICYT5sJC6nzcKwreiqW0DebfcAJDUergOXZqoRAQUJ/mStvUCRKbdAeFAUrtxftN
	hjzGlnyQn3JPgSCPVHa3qbO5ZWYj4qtDDD/OlYAwhF5XVgDcJIb1Cnu7UjJp+OEhHmPE0ITAWim
	TZcCfFi4g==
X-Google-Smtp-Source: AGHT+IHV+N7yC+M0hWbA3nhwDnasBe568CCNA+rn05cUkQzYm3tjh2I5R97rqFeRh8pRmLl9frw7PWFFKL7CEcGCHHM=
X-Received: by 2002:a17:907:7f29:b0:ae3:6ff6:1aad with SMTP id
 a640c23a62f3a-afe079ac04dmr139223066b.14.1755761841507; Thu, 21 Aug 2025
 00:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-bmi270-gpd-acpi-v3-1-91a873cb87c0@uniontech.com>
In-Reply-To: <20250821-bmi270-gpd-acpi-v3-1-91a873cb87c0@uniontech.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Aug 2025 10:36:45 +0300
X-Gm-Features: Ac12FXz2ox-pqRAZ7X8Nl5-8RH4Q6MPpmTutuZ7rN_2YCcDTx9ilamgDvwop_a0
Message-ID: <CAHp75VeTgWifRnqYxi8P_yfMv_GMvJJi4+xJNB98gtKp0z93=A@mail.gmail.com>
Subject: Re: [PATCH v3] iio: imu: bmi270: Match PNP ID found on newer GPD firmware
To: cryolitia@uniontech.com
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yao Zi <ziyao@disroot.org>, WangYuli <wangyuli@deepin.org>, 
	Jun Zhan <zhanjun@uniontech.com>, niecheng1@uniontech.com2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:17=E2=80=AFAM Cryolitia PukNgae via B4 Relay
<devnull+cryolitia.uniontech.com@kernel.org> wrote:
>
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
>
> GPD devices originally used BMI160 sensors with the "BMI0160" PNP ID.
> When they switched to BMI260 sensors in newer hardware, they reused
> the existing Windows driver which accepts both "BMI0160" and "BMI0260"
> IDs. Consequently, they kept "BMI0160" in DSDT tables for new BMI260
> devices, causing driver mismatches in Linux.
>
> 1. GPD updated BIOS v0.40+[1] for newer devices to report "BMI0260" for
> BMI260 sensors to avoid loading bmi160 driver on Linux. While this

the bmi160 driver

> isn't Bosch's VID;
> 2. Bosch's official Windows driver uses "BMI0260" as a compatible ID
> 3. We're seeing real devices shipping with "BMI0260" in DSDT
>
> The DSDT excerpt of GPD G1619-04 with BIOS v0.40:
>
> Scope (_SB.I2CC)
> {
>     Device (BMA2)
>     {
>         Name (_ADR, Zero)  // _ADR: Address
>         Name (_HID, "BMI0260")  // _HID: Hardware ID
>         Name (_CID, "BMI0260")  // _CID: Compatible ID
>         Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
>         Name (_UID, One)  // _UID: Unique ID
>         Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settin=
gs
>         {
>             Name (RBUF, ResourceTemplate ()
>             {
>                 I2cSerialBusV2 (0x0069, ControllerInitiated, 0x00061A80,
>                     AddressingMode7Bit, "\\_SB.I2CC",
>                     0x00, ResourceConsumer, , Exclusive,
>                     )
>             })
>             Return (RBUF) /* \_SB_.I2CC.BMA2._CRS.RBUF */
>         }
>         # omit some noise
>     }
> }
>
> Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41=
.zip #1

>

This blank line is not supposed to be here (the tag block is
considered as the last lines in the commit message without blank
lines, like a text paragraph).

> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

...

No need to resend for these nit-picks, I hope Jonathan will tweak them
whilst applying.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

