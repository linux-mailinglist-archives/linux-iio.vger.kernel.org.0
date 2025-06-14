Return-Path: <linux-iio+bounces-20663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902A1AD9F1F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 20:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB2A3B7A6B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E11B4153;
	Sat, 14 Jun 2025 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmeSSnNK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE752E11DB;
	Sat, 14 Jun 2025 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749926783; cv=none; b=NPICl+eOmmIMYLQGa04KXKg5y1SnC2zUzV+LjBKPn3sJA+l2mBjdhF/eMSHxH9fjS00zPS2hSUqcg2iZnY39jmdSSjrgq16bQlf7SvhwwY3KUcco4wtoYkigwFa7xOLKJLsEhf/MNDdML+iYYR2mJCYPrUvFd5wm84sEYIBj3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749926783; c=relaxed/simple;
	bh=Bb5ZUwAlQq8gkEwgvvmGUrtzWmZ9r+fPXehJZ6wwGbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0o1FDC7pQmfyOSw3LFvKdxDn+x9DloOy2Ix6vunn4byaUsrJjBBBe0WUe3p8ZFIR0YGK5Phf11NrSh/hyzbaLipGdfWuB2oQoV5PpXgj40AhM9ixT7B8Jtw/9GGr83CUa3doEDkO8/02KDmlOMtl5furcsY/U13Z6lIFNxQuLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmeSSnNK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade4679fba7so580221466b.2;
        Sat, 14 Jun 2025 11:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749926780; x=1750531580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nj8I/kGHN3gWcFvFq+8HgzJ24UO3U/GkH1WHXxfLGQo=;
        b=PmeSSnNKfjv1MLTTm9tAEU/fUN848eGyEnr931Ybg02TKJAfhAb0uhEM7o65VpnN8y
         7EUjKlW6t5J0hZIaK8pdg8p6RR3/noDZhFblhjFOsEBaX2I0he57HP6L3JGuuccBMC3X
         QhxrIQzGrNSclqdQN+UcxUHA/neERMRkvKZw2BqkgfyfSsDQiATPJNifYPN2dMq4Su2V
         MumvGKE2utjNNf6g3C6g6DVKV3DpTDXmDNLQ6BoJ3Fb+uvRPoNh/jcpeYKk7PBisUmTu
         zt+sE+6dKPs0ShJCvBc4912mWC6hW7+oo4TMVqJIDNkmfVhQ/ez90UPyNe+m9+xsAVBM
         WARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749926780; x=1750531580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nj8I/kGHN3gWcFvFq+8HgzJ24UO3U/GkH1WHXxfLGQo=;
        b=iz2Y6cF/kIsBF8/Yog4OX6fM7b5Dm88v0WSe5KQrnzoHcrd/xwWVRBaBPSx0Gy9onS
         eUiUcxnl2KiXyO7HzAOQTQthCC3pIF7S9+4nzYeTBbDKaEiWtOB6Ig5oRQSqRy1q9pz2
         g2a+quIx0/MNNt0aMPtp1xgQ/qqyUPjVYares9kfhHfddMLsGsKyF230hGgOMz9yMnka
         7f6gSXqiNl/pWsuJKO8BZLwAglccNZwrjlf+3xKDboWJCXMbmHue4mHP/XD/ehC2+MIn
         EYrd/oFKFa/gxwHpRLfmr1X3f1FBQE4ObnQ441QqPfWIUcyySLMKqq6Tvko/xd1aVZgi
         Oflw==
X-Forwarded-Encrypted: i=1; AJvYcCUFJC14IkqL+xU0AXsplrRu5AV5k70dn6xZSJUPVbekml0r5pPLAEHY2yq+iCqup6JPNI7hN14G2ryI@vger.kernel.org, AJvYcCWGfXdNVQf0EugotPDHiA3mLRD7Q53uHdcJqOzN20KscYj1014mromuTldE1WM2UbEqaf1Cl8/2FsFRsVII@vger.kernel.org, AJvYcCXABlAaonuOG8PhHplsw3uG9y/gwf8q4zECRjY9ny85lo6OGqUFlG0fh/8z1kKsLWLqkXYDlWmqYhec@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ZgmhUXQzuPXAqCVV1UPRZKhq5Zi/nsT9SQywaAjq8Uclukqo
	dPN7wjMyNAwmDp276aXVopP/Soz4Dtt7H+577/MMmRivv3I5yAawDsU1juxlBzu5psjl6jofNpl
	NqrvHh92pla+sCCpKTnfxxBdVw1d4WmQPGjAL
X-Gm-Gg: ASbGncsDzF6sZ20FcKD2udLiNQT4yirRvFLUEUyZkTvvUDke5FWRwzuFbQZab0VO1pV
	7pQ7niIXIBM5TMvPP19pWpsJIsANKKae6i28E2KAS3zIuD/GfB8xRzcBN7htivvE3axKE6H6j13
	FUxltnpU3AjIYrFz+Zmrw5y8WkFAzinmTuJNnFJ4FrwuQ=
X-Google-Smtp-Source: AGHT+IHk/igkzFnuL8wtHTLuYiKKBK/qzjOLKCm48WVyulSSu0AARqoztRMXdHMM/WVfOTTC7Mf+m+5P5tP3arAYsYs=
X-Received: by 2002:a17:907:3c8d:b0:ada:6adb:cca with SMTP id
 a640c23a62f3a-adfad363e89mr317250566b.6.1749926780064; Sat, 14 Jun 2025
 11:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614091504.575685-1-sbellary@baylibre.com> <20250614091504.575685-5-sbellary@baylibre.com>
In-Reply-To: <20250614091504.575685-5-sbellary@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 14 Jun 2025 21:45:43 +0300
X-Gm-Features: AX0GCFtuIQ5JcvZBY4qwc6SDF3RvqoMmXTuXsmVyJS0lq-bmr8PhW-TTssyztQw
Message-ID: <CAHp75Vf=zQ+pdo5V1fAq2qWEpdUfNfWdO+_iW0wETWSniXisyA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] iio: adc: ti-adc128s052: Add lower resolution
 devices support
To: Sukrut Bellary <sbellary@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Angelo Compagnucci <angelo.compagnucci@gmail.com>, 
	Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 12:15=E2=80=AFPM Sukrut Bellary <sbellary@baylibre.=
com> wrote:
>
> The adcxx communicates with a host processor via an SPI/Microwire Bus
> interface. The device family responds with 12-bit data, of which the LSB =
bits
> are transmitted by the lower resolution devices as 0.
> The unavailable bits are 0 in LSB.
> Shift is calculated per resolution and used in scaling and raw data read.
>
> Lets reuse the driver to support the family of devices with name
> ADC<bb><c>S<sss>, where

I believe it's incorrect, i.e. it's something like ...S<ss><?>, where
<?> is something you need to clarify, and <ss> is definitely a speed
in kSPS.

> * bb is the resolution in number of bits (8, 10, 12)
> * c is the number of channels (1, 2, 4, 8)
> * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> and 101 for 1 MSPS)
>
> Complete datasheets are available at TI's website here:
> https://www.ti.com/lit/ds/symlink/adc<bb><c>s<sss>.pdf
>
> Tested only with ti-adc102s051 on BegalePlay SBC.
> https://www.beagleboard.org/boards/beagleplay

...

>   * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
>   * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
>   * https://www.ti.com/lit/ds/symlink/adc124s021.pdf

Forgot to sort out in the previous patch?

--=20
With Best Regards,
Andy Shevchenko

