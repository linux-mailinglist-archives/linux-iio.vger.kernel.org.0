Return-Path: <linux-iio+bounces-5745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD848FB0B4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 13:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F13282375
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 11:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BD7144D3B;
	Tue,  4 Jun 2024 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnbMkOk7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4F4A07;
	Tue,  4 Jun 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499143; cv=none; b=buLRckyZj2TZeurHYHOCcBr0h6FY9ceR78FW2esKZwVGpTFFUk5ZR+f6ZS2Sr72N9ullqJeGKvozl19sGMXXAsb8rRzHOhGuBYHVgXEiD6mZWR3KiSGHwxBeXHkTveuxfPb71YVwOtrAn9U8Z79HF6l4zGkcoumIHJt0uIq8N3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499143; c=relaxed/simple;
	bh=TY7XvU4SbXdxEdswCoVLHuqEj9CxfdQLBwmuALZPUxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzIY+oXAB9DZTo26MrRFq1r1jGItqGxHQTkTPtRC0DDUr2uNi8apbwYCZZLAefNkxaIQzMLFFgRvtTat3eA8u0Apo+gYmwxnoxgHMA8mgcorOyKbeydBsPZilSLzVHAKKBiJJe38lnaYcSoRo+V5FOXT+B2ccwXSiDXA0765QfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnbMkOk7; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b98fb5c32so3052228e87.1;
        Tue, 04 Jun 2024 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717499140; x=1718103940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjJNON3xbO+Yh03gyOu9rx6tlrOQ/KcMrKYC4qdTMT4=;
        b=jnbMkOk7tUVVy8fW44JZSGZea3OUJCuffIqYc1j/lGfLowPTnPJsmTvgzHd/kh5emR
         fgUu0JFObDkAZ6PapU2t48Ac07rna4vRODWpvCx8yxX+bEIfGEHdEYusTlaWDVkkKnfD
         rklotBjrth/1VS1Sib0AkjAbZtswr7zBxEvENCRUoYPYc1Wl4TTmgm9Ix2ne2UFCKU69
         1++jE/3SYSHXBVZQjr0jv3D4R4BO1+3XqPhiryBL2N1hd+YC21NKLBofOYQHgOmKCZkv
         tGHXkMoDwv+VAq/NxH/KVzn/a0JewAQpKUVdsJy9cwc22SPx7B61/SCE7jU/rCm7qEos
         qisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499140; x=1718103940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjJNON3xbO+Yh03gyOu9rx6tlrOQ/KcMrKYC4qdTMT4=;
        b=IAa1wb6uOg5MpfMekEv8zNVfwCuX+o+Kso+GfvpvLWDvz9v1fheomwA+xEiHp+ua4B
         Bda3H3lk8liKv6gl838wAV58aH8qXoRYjoHNDvpuQ8vRdIlCnocyvTbZTgVQAcxu5GI2
         TPazZ/nx/+HMLY11dakKFMqgex3LZWXt8VfabK2Zn9l53mElGcfOIBsVVTudb2cVaiYr
         remiIvYHU6jpb835iXbWiJdA/aiwXsTe1feZktTcb3J+6Tvnf4nZseQBbk1zY68RGtDy
         HsZR0Z0/VKvd5ZiZY2/803PtzsivJpayEvJoBL89yHiI5vyZ4AF2mGobgPZILqB2Bc9u
         z0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXWvXedEk/eskLraoXJRRMC6sLfE2VgfRLSOIV2QlXtg9W86PGa8/ZO/AMRUA+yXWNYq8fkQzWeQgUist6T7mQhIQPJ7lhP60MpHNYSagEs8PI+Y5sXsTY8qJ08AmhYApLXCUiMDG7jxga0Cvi3EcGcov7Ckb2z4UzwwNSBRDd0qT1s3w==
X-Gm-Message-State: AOJu0YwY2xLTmNuvFrz2VO01t956I+KTD/3dNwCgCmzxEy9tPMJ0irch
	OIRHKY83JoUvUGxU5CP0HnwJmvlIuXCkaRrzzRuS2xstxZgAr2n00en0oW8zaByUXP+wpIK6lOz
	s/1VlHEWfPc5Z869oB1+opl6s+L8=
X-Google-Smtp-Source: AGHT+IGKVX7EW81SfP255Jyii0GXmIvdQOfcnZjcozuN3AC14wMPa/o28MFGzPREGwZRW/+wCvISJRXveGKYPM4NcEU=
X-Received: by 2002:ac2:5de5:0:b0:52b:9955:43b3 with SMTP id
 2adb3069b0e04-52b99554482mr4801820e87.60.1717499140011; Tue, 04 Jun 2024
 04:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
 <20240530093410.112716-3-angelogioacchino.delregno@collabora.com>
 <CAHp75Vexddt1xUGogRDZA9pM1pFp2=ZtCQnCfXePahSCb+oKpg@mail.gmail.com> <84f1c58c-0a5d-4131-a16b-b76bf28862ee@collabora.com>
In-Reply-To: <84f1c58c-0a5d-4131-a16b-b76bf28862ee@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Jun 2024 14:05:03 +0300
Message-ID: <CAHp75VcwnjrsAY1qF68MpBWV-NLFSxTP_PDL+ER==KNdBAFFTA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] iio: adc: Add support for MediaTek MT6357/8/9
 Auxiliary ADC
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com, 
	marius.cristea@microchip.com, marcelo.schmitt@analog.com, fr0st61te@gmail.com, 
	mitrutzceclan@gmail.com, mike.looijmans@topic.nl, marcus.folkesson@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 1:38=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> Il 30/05/24 15:34, Andy Shevchenko ha scritto:
> > On Thu, May 30, 2024 at 12:34=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:

...

> >> +#define PMIC_RG_RESET_VAL              (BIT(0) | BIT(3))
> >
> > In this form it requires a comment explaining each mentioned bit.
>
> I don't have an explanation for this, I know it's two different bits from=
 some
> reveng, but the downstream driver declares that simply as 0x9.
>
> Should I just "mask" this as 0x9 instead?

In this case for all of the questionable forms, please add a oneline
comment suggesting that "these are different bits without known
purpose of each." or something like that.

...

> >> +#define MT6358_IMP0_CLEAR              (BIT(14) | BIT(7))
> >
> > As per above.
> >
>
> Same, I don't have any explanation for that.
>
> If you prefer, I can define this as 0x4080, but honestly I prefer keeping
> it as-is since I am sure it's not a magic number but really two bits to f=
lip
> in a register.

As per above.

...

> >> +       u8 r_numerator;
> >> +       u8 r_denominator;
> >
> > Can you add struct u8_fract to the math.h and use it? I will Ack/R the
> > respective patch.
>
> Yeah, I did that exactly because u8_fract wasn't there and I didn't want
> to waste more bits, but since you just asked for it... well, I'm happier =
:-)

Note, it's enough to have my Rb tag and route that change via IIO
tree. We have done similar way for other changes in math.h (or aline)
in the past.

...

> >> +       /* Assert ADC reset */
> >> +       regmap_set_bits(regmap, pdata->regs[PMIC_HK_TOP_RST_CON0], PMI=
C_RG_RESET_VAL);
> >
> > No required delay in between?
>
> No, as strange as it may look, there is no delay required in between: thi=
s is
> because the register R/W is behind the PMIC Wrapper as much as all of the=
 other
> MediaTek PMIC (sub)devices, so, missing delays was intentional here, yes.

Maybe a comment?

...

> >> +       mutex_lock(&adc_dev->lock);
> >
> > Why not use cleanup.h?
>
> I want to unlock the mutex immediately right after executing read_imp() o=
r
> mt6359_auxadc_read_adc(), and I don't want the reset to be done while a m=
utex
> is being held, as that makes no sense for this driver.

That's why we have scoped_guard(). Exactly for such cases.

> Besides, I find the macros in cleanup.h to be cryptic - in my opinion, th=
ey
> require better documentation as, for example, I don't understand when the
> guard(mutex)(my_mutex) is supposed to acquire the lock and when it's supp=
osed
> to release it.

They are cryptic due to limitations in C language. But for the end
user it doesn't matter. The behaviour is well understandable and makes
code cleaner and less prone for errors such as missing unlocks. So,
please use cleanup.h.

--=20
With Best Regards,
Andy Shevchenko

