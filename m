Return-Path: <linux-iio+bounces-24090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F63B56854
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 14:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47207173B9F
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBDE25F973;
	Sun, 14 Sep 2025 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyHOSFR5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394AE253B67
	for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851719; cv=none; b=AbkZrXVWmwF/6VmpXcPiwJ0csGTc0nPJu4OemykwHchlBdFNPUKiL5oEPPg9vWEP4gxorADUoII0upnHogMSJ3pjXky+yIHHyExYmDxbGgg+7s9AFipW4I+I6fbBldvll1PyQKETCOkrMO9w5M+CaNAH5bSwGYdOrYmUrhtv6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851719; c=relaxed/simple;
	bh=EigXt8LqTfePC/LqOfQhPeqk7WEnREgVUKFouhhjbzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udGoFhARWs8HFQtcx0XCCThx/72pLZxnJsZX4t7rGHPm35n1Xpc4TQmcdCvjf+rtcFuOSsFD2XcoxC58ak5fKEIC7KgYrzi45WzRmkp4p65e+61br6ANCFDCtDbhud6C6q1SiZnSJBkgiAhZP0y7fJ3Eq7sUmB7hxIWjIt2YLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyHOSFR5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7a16441so493965566b.2
        for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 05:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757851716; x=1758456516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymLIEuumg4YCNkpQZsBBfzaLM4aMXii3QJ3NddaKZEs=;
        b=ZyHOSFR5WRT+InZlRPr6YfavsqxoQ0ewZD8KGP5DrtVlTkFIwxetYM+p9AdZSVVRcZ
         XwVxJPJM6IEhDVNI+nmcFOEP0QMdriMG1Y3bohRPjInQkQZN4XEqmvXr6wsC2G6BIehj
         Dhy7eudCOByaNf10gkTj4S3QQLVfV1q1EyhhdQ7dbntUbwlfq+dq6rmt4kGycsHcEWsZ
         UD37z4WiEJ1gY/UmwFLEZ6TJhmThRf56mweRInX+T4/PiDWjT0O6Ypc6F5/pSP2ZPGqJ
         du5947VXhPd1TtYWHb4VRsfGXI87FrYFtxfgnGXZT0QscgkOmTpCvm/G0dqlMnD23yI9
         Mimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851716; x=1758456516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymLIEuumg4YCNkpQZsBBfzaLM4aMXii3QJ3NddaKZEs=;
        b=Dmc+OjmVm8Y81mE1sUyDar7NfMU3az2YRzSPSWZooZxW+bgZaTY4kiLYnDZe6VpFnk
         uypzmiTmSX+HFH3SZily/MZLcGOmFw5VdgBmqOsAQwH0Pcxhz1Rr18vTJ3epFose06yw
         w5x/KtjUntZzcn7bQ/Zf61sLzYYt9bED7zOrP0cxwrJ2v2YUp/9/mgyQ21992SvLrgJp
         ypXN5sC+ohWazaN2qB+D6mOm8eVcu11D5DNchau4OUvmUAbLIAcOMZ7dDvJT2BnWd0yg
         r91j3jKJIVyFGdnkRDUnYbOr+Ixmf542yK3Bi6UyPhxuyoXsHjm51+U7PqFTtPhBy7Qj
         /Wkg==
X-Forwarded-Encrypted: i=1; AJvYcCUDUFeodVbXD1bAWVTz3fSavUMiYBw/GSpg7Qd6TAMgDARXiVLGh0OCd5txDqJ9dbDGa1vH6qNMFnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7nLTMz5jk5GlrndUeE7Pxsn74pZt7mcxRG9PSaMe6Ib/4XaA
	jcMIkJgrvNgcToD1zTBAorZNaQaiu1qEI91Nio0RQJLE8tra/Q2vAPzM2UR98PfQu1NquNvSDnl
	4VQvc/fc7w17HnBKDKJkk9jB/xgCjS5o=
X-Gm-Gg: ASbGnctxNhf1h3/zZsYpIwJNPAePU7nqRqP9DeTWqi21YdC8VGx9WcT4mmXU3NNUKgw
	Pc2q+a26753+4qfmREnYSrVfcY8VtfTMnqDGvjlXbOPfTYPN1N/e0O4K6cwtCjIiEQRqx4AB7Iv
	VBtobfYekPyWGppXq0Yz7Yf8IY2UN7Tn/ZW1Es1VEufWTTyY1GO9BnkgvDNOIwrMzgXzsrz23bb
	3uJGbmh8r+Mh4AX+TOB28W66Nf+
X-Google-Smtp-Source: AGHT+IEKkbNP3MW3lSi/qyjRAql//emEvsvwlMA+9H36XPYpDZpeNQ0Wlwf6V3nUlHWa6e6uCNQbNFf0xyyBqH3XLew=
X-Received: by 2002:a17:907:7f05:b0:b07:89ff:5ff0 with SMTP id
 a640c23a62f3a-b07c365fb66mr908806466b.51.1757851715422; Sun, 14 Sep 2025
 05:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-8-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-8-0b97279b4e45@subdimension.ro>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 15:07:59 +0300
X-Gm-Features: Ac12FXwgIGwTL2oMKLhNSJfFYEfKocLrB2d6dw-jdxsp4PGcNAww3JU4P4nSCzA
Message-ID: <CAHp75VdPdSrXDyuiwvOyC64qDhoTRZ0YFEDjHnYCX7dvBE1P1w@mail.gmail.com>
Subject: Re: [PATCH v3 08/18] iio: accel: bma220: reset registers during init stage
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 6:40=E2=80=AFPM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
>
> Bring all configuration registers to default values during device probe()=
.
> Remove trivial code duplication regarding bma220_power() in _init()

...

> +static int bma220_reset(struct spi_device *spi, bool up)
> +{
> +       int i, ret;

Why is 'i' signed?

> +       /**

Same comment as per previous patch.

> +        * The chip can be reset by a simple register read.
> +        * We need up to 2 register reads of the softreset register
> +        * to make sure that the device is in the desired state.
> +        */
> +       for (i =3D 0; i < 2; i++) {
> +               ret =3D bma220_read_reg(spi, BMA220_REG_SOFTRESET);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (up && ret =3D=3D BMA220_RESET_MODE)
> +                       return 0;
> +
> +               if (!up && ret =3D=3D BMA220_NONRESET_MODE)
> +                       return 0;
> +       }
> +
> +       return -EBUSY;
> +}


--=20
With Best Regards,
Andy Shevchenko

