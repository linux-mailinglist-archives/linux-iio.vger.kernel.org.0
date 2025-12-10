Return-Path: <linux-iio+bounces-26993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6F5CB2CB5
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 12:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E15E3042FE8
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462431B111;
	Wed, 10 Dec 2025 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLTtdKzl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976930AAD6
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365228; cv=none; b=br/OcT2PGc3Nsi9b/B6B6BjIVrhUpoOy8lICLyoBEKq4lxUNkYVwXxQcPWPs+07fUaWwvMjnevgbsDk3jJEdw8it+tHNL+AQlKk+7gCLS37xWqfnxTShW4GbcF9olBsgrtQjrdv8qqa7LFVqQEfXUmHoBfWzs29jTO/y3+v3BJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365228; c=relaxed/simple;
	bh=c197u76OouKFvW5WUGD8yM08eqliDKrAKAQyg6iqv4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNK4bM2Tm66vTo/3oKEZ/B0CsKSjioD3HrSLRZ9KtaBfCL9HalMKelIkq+3GI0NgNKYmsMixomMi2ZfpzY1+r27wjeI7GRgROPEUK6j/0oW06VcR3U/JU6Gv1/a/JL+YUZOG1xvinX88dXiFjRZLVZESiQ+6wDxcO2ue/Uizh5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLTtdKzl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7277324054so1004758466b.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 03:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765365225; x=1765970025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jhiv+eO0tAWQHPSXGq7ptJN7WZerVf/KkKcRUXayuOs=;
        b=OLTtdKzlCo/NBWO6HmNXbwTnAe3/hAe0LT5mKKPHcacPVPBCzTXfIql/sRHU8GVqQn
         xV1bNIfe4lVFhxxlxrDktS091tEULaEuJiOk8jpwJAX4Ig174MHMUEi/1qq7iTvyOxDO
         THTbE2QIK05AeqSOCecD9LbvDOeJa2VJ3mlruihDUqx9/ZEH8/bFMpNAxq4Dop5V99LM
         RxwOah68r5rH7k9syKSPmZoV+TK8WYvzcRJicQRTgu5d5/Iycv+NG6MZqRw30HuDhNd/
         DRo+ad9z9DVif//sw6aYPNZmdCJPv/UNTp4iahlHbfhVKzzYjoTX6Xuhls1e8jDiFZWA
         2P9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765365225; x=1765970025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jhiv+eO0tAWQHPSXGq7ptJN7WZerVf/KkKcRUXayuOs=;
        b=xNiOpXqdlWmGEDj/CVu2tcHwqnvps99CVkm8iJw7xOEIBLWwY2bMbDq74tzrSo3Wf6
         Hd5SYR7UrGjn4d5oYYp/ILB0SmEETbALHjthGWim2cPEGq54onpjHs0KvshvBpL/3arO
         iJoMhp9kUMbl5EA+N/Y6RfeLWpYAxegRTUzj+0MK0I/uDn2O5nZSnJtp+3dKSQLh8XKi
         DYaDHA+fwcrt9+Hu1Zs2kCgcoYKjRg+faN6BfXUkorC+MD3HF0tdN+lNivQ0jB6TdTPs
         rmLmEqGmUOxvGreaDC5L3kzhI20Xn8Dmw3hbp5Ijvhg/C/u01XveBotG7j/jf8rVfHc7
         AwxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEDRJjhzV1qt85YDlc+aOQpjyx4Ddo6BLebnFswtbRK48emSbHJSCdNuAm8rLmC616jrMkKMGZIKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPC2FXbZsPq5rk1i+JD+eXpmMADn735JjR/bOxl9ganjN842MF
	LcFmEHiTs2qrH4tALP18g8Wf96hZmZIoycJFRomtYEMrSeVAMQT5+FvaJjZigxMQ011RdI2S8PO
	1ndHbPqzLbddU6HaoLyIly6oupQtUkSk=
X-Gm-Gg: ASbGncs3gufWEkXJ4xhAgbURc6L6+XQ/1mDXz4brPDcbNrAvql+9vLccHhuRm/VwsIi
	2n2+HNcHSUlz+vNK/9tQgV9/L4CBdLChfuCFsQIJZuPf44WKmy+V53uE9WbEW+0j6RD/KnVhvlX
	maY2CwIv2TfndS4tDY7CI8pHNBKheaeoryt4IiBN47slpodBnQ8RLY99D+BgGMCkzTvrNUVZLjZ
	CvLEVh/Ur4OAGCZPThNWom8/IIioVPyn5/xmYwwN0h7WNTaOdlZcsJum/FQ9z/xsz61VF9xI8FS
	1Hbjo+oJ/OwUdANHu7hjKJ0+LOFd7MC60RtYErQLIkunh5jcnOReNvXLxJsOSLt932OhZod7CPG
	F39lpIMo=
X-Google-Smtp-Source: AGHT+IGtuFtFPYk13o8udcL9hsaziweHofEXYfv62MD7ZleLZRlqkRNUti3T+gn8WS05tXPQys76VG0aYwJIS3UpDSA=
X-Received: by 2002:a17:906:6a0f:b0:b73:7158:d9cd with SMTP id
 a640c23a62f3a-b7ce8427b7cmr187591666b.52.1765365225062; Wed, 10 Dec 2025
 03:13:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208-ads1x18-v7-0-b1be8dfebfa2@gmail.com> <20251208-ads1x18-v7-2-b1be8dfebfa2@gmail.com>
 <CAHp75VcOVpGbb3UBm+QQrw25=yU+J624c29ptMk8yrJpNEL=jA@mail.gmail.com> <DEU8OOETPWRO.12I8HY6SHTQAA@gmail.com>
In-Reply-To: <DEU8OOETPWRO.12I8HY6SHTQAA@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 10 Dec 2025 13:13:08 +0200
X-Gm-Features: AQt7F2q5OUPksfrHz7nFZi2-mEgNlBgsMsFD3aPC8Lmf_i9Ntvzc_n2pVFKd_fI
Message-ID: <CAHp75VeuA-Wvs9o9cXBFxL6D90mvN9eQA=tOtxB2GT7sPSqw9w@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: adc: Add ti-ads1018 driver
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tobias Sperling <tobias.sperling@softing.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 6:07=E2=80=AFAM Kurt Borja <kuurtb@gmail.com> wrote=
:
> On Mon Dec 8, 2025 at 3:19 PM -05, Andy Shevchenko wrote:

...

> >> +       /* ...Then calculate time per sample in microseconds. */
> >> +       return DIV_ROUND_UP(MICROHZ_PER_HZ, hz);
> >
> > If time per sample is in =C2=B5s, the associated frequency is in MHz, s=
o
> > the correct constant is HZ_PER_MHZ. What did I miss here?
>
> I was very confused about this, but the dimensional analysis works with
> HZ_PER_MHZ so it should be the right constant. Thanks!

You need to keep in mind the sign of the order of magnitude. Since we
don't use floats in the kernel, the small units are represented as
divisors in opposite to multipliers. So, the used one is 10=E2=81=BB=E2=81=
=B6, while
the proposed one is 10=E2=81=B6.

...

> Do you have a suggestion for this? I can keep the ADS1018_FSR_TO_SCALE()
> macro but it will get a bit more complex or I can just hard code the
> scales and document the calculation. I'm inclined to do the latter.

I believe we will see based on your next version. Just avoid hard
coding magic numbers, and put more comments, ideally with the
references to a datasheet section.

--=20
With Best Regards,
Andy Shevchenko

