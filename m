Return-Path: <linux-iio+bounces-24910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05A4BCDA21
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 16:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7D63B2DC3
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A082F6588;
	Fri, 10 Oct 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuzBevIT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C37C2F6195
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108149; cv=none; b=cVkz8as16f1JAEs+u6BbFlQM4ln/LXSUOqeL+qDIgkz+4XLAieLKVX7ka6dN9sxg9UDs3zDgaHGAuPYROkhCqsCgYi8azZQoFYhoxQDp4Kgc/xeuXKqBHQOswjGaiR//ZVahH4woPytvQqaZjWjrBFLzpQkQcoUvm2XeLcaV6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108149; c=relaxed/simple;
	bh=6+gv/w4gUrEGa/XwIA7UjRaNyK0xz55jWAx88AKH4d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvikiZtvBEL33pWmwiOC42ceoYTSmvrmiFeDNn/BS07v7vFqcUwe7dtnZykLjuDRex/TJVp+8r1ALFcH1r8t9HvU0BGWPGYzgcySUuI0Chg24aksDBZqyMnUWy9ABvehlEruMv+svnuA0t9X3fhX/ItMC4i6a9KE4DfG3P5w9sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuzBevIT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so4175528a12.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108146; x=1760712946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPLbWNPxZc2wfvIlljRognyXQF9RLtB9DEHDg3spNS4=;
        b=QuzBevITHS31OVdN2VllQcYiL+rnhdB5KzRrFg3yC+uA2UeFtuUOwrdCyGSYtG5CwA
         WizpIrEYxHrW7EhUX7woeBmITUJhxv0qGcO82sB7ngvPPujgGm5w47KMDVe73x9HSSrk
         MCrD5G6L2L0bWMIYn9aMF6beAPhqgXGliE+y8xhEJWzrvNs1nkxQP6SLG6IpkofL1d09
         ZyO1oa9BnVgqEyYbUX2MDo6mt2MPMSIDSXlGwjrCNwyRP73wjBuI3ciokQ+zjwt1hmmp
         +pVvoYXo8xG8NPZ7To9kDrWjNogGs6Cks6QrakW250lG2HaHxQLG5N4+NH8ueqH7Fr1U
         IWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108146; x=1760712946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPLbWNPxZc2wfvIlljRognyXQF9RLtB9DEHDg3spNS4=;
        b=xR3GHsx8M3Y3NRiXkedvYGxQskDrQj4wVsJCJ5INthXjAZvvYPmTxiszOFrrYqrZvb
         3ysOJj86relWYGJkHpGqKPDMy6u5qUhTEtEN1Ba0tS6KTlYAJ90QvP7ojtnQCYSrVOV6
         3YO37h6jl/TWDT1BIGVevtckEOzpf6hp8Fw/m9UOTLyjydc/gCnFGbuAjA45fY7TF0eV
         nFtJea7dPChsYWXWXFoUtRxpxiJ6iuE8JBitknagRiCHhC0TUaRgjSImVrWp7XkuE/JY
         mxTmkbMFQZ8TLX3V1+99nvkkzuQAD3DytD5lsszt/xI3k0m7gBa4PzzIgkg31EL6uRQ5
         5I6A==
X-Forwarded-Encrypted: i=1; AJvYcCUgDVTN6LQuq4hSX59ApUhj/R0LM6ytsbBrC7Q7tqmYbQnwSkH0rOVTFscFETM1UidCozRejwPYX20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8+QCqDcWmX+OHLu1tm/Jt1zJbeHN9deBnB9ES4bTUSJvcq8G
	2pSJC4FfNUEUEDeOnQuwhe+l9GOmtVuglP3NvtAOWigJq9HupLDBZdkNFfEjpPXVVTohy/LhRTp
	cTUEmmB20gjS/nwfVK/Oc+Mr3EVIfFds=
X-Gm-Gg: ASbGncux23szrgiPtPNuE7KFCECbn5/ydspzVdO/tPmFj3YB9QNwuVQgxhtR0S0J2gf
	qviiGwtVSruF1uv1XtoaoEChsFc/PbQXhRUT9GY/XNwlNQhSIRN5ollNrNDjR0Tdtv7iLmnhLP1
	2ByNbGwC7xdXvxFqWhe5BxakYXlaK/yVnwhw7AcloUE+x9nBE6+RHp/u4/FpIYV4SRcykZ4sCzI
	W+sVflgjHixDXsJ3CM+HsQtDZB+aXLOoiBd
X-Google-Smtp-Source: AGHT+IGkvwFBFghkv/zq53Sv+Yq1LeqEQPVseBK8uEWfs8vTYsR13eTVsDsXGa4XRQtqexUM4bBgzRzSTpZwrJqX1DU=
X-Received: by 2002:a17:907:e8f:b0:b34:985c:a503 with SMTP id
 a640c23a62f3a-b50ac1c34c9mr1122595266b.35.1760108145750; Fri, 10 Oct 2025
 07:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009173609.992452-1-flavra@baylibre.com> <20251009173609.992452-3-flavra@baylibre.com>
In-Reply-To: <20251009173609.992452-3-flavra@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 Oct 2025 17:55:10 +0300
X-Gm-Features: AS18NWCWhWCW7KSsOItV_xEhoRQPB-J80xRVLRJuJLRllK75wOUDTJXaeqkV6Ug
Message-ID: <CAHp75VfOfeS21=5SK6Qa9Fc-WQdjDkz1ecoTFrk=hT1NGGt0TA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 8:36=E2=80=AFPM Francesco Lavra <flavra@baylibre.com=
> wrote:
>
> The rate at which accelerometer or gyroscope sensor samples are fed
> to the hardware FIFO (batch data rate, or BDR) does not have to
> coincide with the sensor sampling frequency (output data rate, or
> ODR); the only requirement is for the BDR to not be greater than
> the ODR. Having a BDR lower than the ODR is useful in cases where
> an application requires a high sampling rate for accurate detection
> of motion events (e.g. wakeup events), but wants to read sensor
> sample values from the device buffer at a lower data rate.
> To support the above use case, add a sampling_frequency sysfs
> attribute to the buffer directory of st_lsm6dsx IIO devices, which
> controls the BDR for a given sensor independently from the "main"
> sampling_frequency attribute (which controls the ODR); introduce a
> new `bdr` field in struct st_lsm6dsx_sensor to keep track of the
> current BDR value, and use this field instead of the `odr` field in
> the code that deals with the FIFO data rate. In the sensor hub
> driver, make the bdr value always mirror the odr value, since there
> is no separate configuration setting to control the BDR for data
> produced by the sensor hub functionality.

...

> -               *max_odr =3D max_t(u32, *max_odr, sensor->odr);
> -               *min_odr =3D min_t(u32, *min_odr, sensor->odr);
> +               *max_odr =3D max_t(u32, *max_odr, sensor->bdr);
> +               *min_odr =3D min_t(u32, *min_odr, sensor->bdr);

Can we get rid of '_t' parts at some point? Or IOW what is the good
justification for typed macros here?

...

> +       ret =3D iio_str_to_fixpoint(buf, 100, &integer, &fract);
> +       if (ret)
> +               return ret;
> +       bdr =3D integer * 1000 + fract;

MILLI?

--=20
With Best Regards,
Andy Shevchenko

