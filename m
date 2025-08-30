Return-Path: <linux-iio+bounces-23435-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DBDB3C8FC
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 09:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7716F16CF8F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 07:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EF028466A;
	Sat, 30 Aug 2025 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVLp4PXQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6317283FF4
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756540769; cv=none; b=U5Jq7Kfq5xnfKQz9l7C3EgyoxSOIi4U0jOwOtP9E8qWlJC8N/hk6mAoTjSK/qfrqjqbiBBlJ+LW8osa18YdfDpfpE++QT9XjRxYQvoajyewXyOtP52DaW65v5dDyGvfbPg2ctF2kL5D5jl8YrmmRIaVrCozh06MTsN/22dIKWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756540769; c=relaxed/simple;
	bh=fSFAhpglVF3JxNg3GSb38yL8okJxMGwMtl4SGPZP7XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWKvA5KYIXZ2yfhh2GTjmbQyk/wyt2tT4A2HUPfKZe8mlX3GaUwbtO84KgdjeUVLy9amBYjH2Jg+EGoyK9FWEA7laW1d41fNZw6+1d5li3pGmxWEwhPdyfEbbDFiAdWZOiycMsZMjvC/XMeGesj6Xziwqt03bxpyWKn8ojSHgS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVLp4PXQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so437337966b.2
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756540766; x=1757145566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=birFOmrH08fgJAcwbmqlDFLbxlQDQfSJd8UtaiXOa5k=;
        b=cVLp4PXQo6N+c3G2ibN1Ea26CXzeKzTudVOZtCZuGOPhhBqJKUuIhwbh3nem8dCEeJ
         SDsC184VylgXzNcZblM4awQ4gfdmHwgGn/mwI+fkaaB0zjs3zZ70ePJ+2bTI5qiPj6F/
         2muc7VJDb+1xSdZqbF2M9kFPQR2Mg76ean2uhG7AGHDwz/5bjWiCEeV69256TFK6Lm/S
         faeYT+1kLVrug4DCBwZCg0Ar/bHziCWnwQrT7PirAK1CLmljyNzicSlFciba+TJ2rQuW
         w589/yReQmQznIshHFgpo4wHCn8nC2nk8P+vxK9dIb9KDZY6jC8l7hls0WAckz5s/uND
         fGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756540766; x=1757145566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=birFOmrH08fgJAcwbmqlDFLbxlQDQfSJd8UtaiXOa5k=;
        b=etmdl6pI0tG1NUVOzv4ytdkFIHh+ILtWk1Yr83XBQhsK8nav28XM5+sFb4QfwkZvne
         4TdiS1SztAd6D/E7SGINVp5uq3yaKLLxGD8wO21DEBUmZf6hu4N6ytFRJg/aN71y32Qo
         lYwvoJ48mw6gRmVkR4+YUiGrhgHWeM5v2QPVtyz4n5fnBJE3rNSBqF9GVpFZnMHxKv46
         78duGhPxdOKND8m64GLsuLqjO3Bg2UD2u3EKHMOQZGmRDa8NmthFgpDA73ncJfQa+4DC
         YyI/3676q+npTyKHIAaCwQmMjLuj9cHAEPtIvoSJDpOhVZ5XOseD3Y4il6si0CwY1BaK
         T6qQ==
X-Gm-Message-State: AOJu0YycmGya2EcrrdMxtmyZXpPS4hb7/ucCuVi3pUWbJBUqGVtPh0yg
	J51vm0r+H24sNPZranIszCYGyyuYqnZW7o9QuuqQT6vxZazAcFwsi5IXh+koVfvHOmS20+gMJhu
	r/MWDCFDolgU1/TGWpxv3FCYPl+Cc4sg=
X-Gm-Gg: ASbGncs02T0V7I6AMAqdZ/XKcDOHm+P6NIrnVoFx7vv3Z8Y2dSZv6CXklVnnfSWSSDx
	lWX1Coole6YSmHCZ1TZKFN9FClULpSNgrj8Fs4yAEmyFUqVkhbU85kw0BLKpRfwSEdirpn51nR0
	XZxM+NXtXXXyROprsgDDsfUt3MMrrWhb8y92LuVG59hKsEJ0TSH6bGt7RLGMO/+esHy217raT/s
	m+vg2c=
X-Google-Smtp-Source: AGHT+IGXo4NooMYnETBRQkbv00irPPxHqgSzl9zb3JWDbPsu2QbC7h/CAcEaFPL5bJmpLh73zVy9pTahaIvYKaMsN+8=
X-Received: by 2002:a17:907:c24:b0:b01:6e50:208c with SMTP id
 a640c23a62f3a-b01d8c7da70mr101401166b.22.1756540765811; Sat, 30 Aug 2025
 00:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-adf4350-fix-v2-0-0bf543ba797d@analog.com> <20250829-adf4350-fix-v2-1-0bf543ba797d@analog.com>
In-Reply-To: <20250829-adf4350-fix-v2-1-0bf543ba797d@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 10:58:49 +0300
X-Gm-Features: Ac12FXwVx0nbnoPRMILzmEcy_K1QMFIfYbTRLruUW5Kw2ox21rlDDh-fe7Qdb8k
Message-ID: <CAHp75Vd-_iDZw70+T9uSQm96d=+-puPOihGt+9TLsamW5bkWvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: frequency: adf4350: Fix prescaler usage.
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 2:25=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Michael Hennerich <michael.hennerich@analog.com>
>
> The ADF4350/1 features a programmable dual-modulus prescaler of 4/5 or 8/=
9.
> When set to 4/5, the maximum RF frequency allowed is 3 GHz.
> Therefore, when operating the ADF4351 above 3 GHz, this must be set to 8/=
9.
> In this context not the RF output frequency is meant
> - it's the VCO frequency.
>
> Therefore move the prescaler selection after we derived the VCO frequency
> from the desired RF output frequency.
>
> This BUG may have caused PLL lock instabilities when operating the VCO at
> the very high range close to 4.4 GHz.
>
> Fixes: e31166f0fd48 ("iio: frequency: New driver for Analog Devices ADF43=
50/ADF4351 Wideband Synthesizers")
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>
> ---
> v2:
>  * Added fixes tag;
>  * Added TODO (suggested by Andy).

Thanks, this is a compromise I can agree with.
Reviewed-by: Andy Shevchenko <andy@kernel,org>

--=20
With Best Regards,
Andy Shevchenko

