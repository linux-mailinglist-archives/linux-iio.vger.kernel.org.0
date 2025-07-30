Return-Path: <linux-iio+bounces-22155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE43EB167E9
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 22:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B91AA5A5E
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 20:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3AF221D94;
	Wed, 30 Jul 2025 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqNAiXCo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A21DFD96;
	Wed, 30 Jul 2025 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909093; cv=none; b=lcYr05RZX48KCyUE7m/2A0bW7T3nu8CTK/04Z5hUvzm5TaGYOgf+GVyFJaJ859bqERHi9+n0WiKqbVOx1XPSHufS6HNmdNV2NH2XvKh1YJRIGQggRMqN3IFF99Oqk/UywGHe/iq44VQ4fXeGi0/nBrVLhA29dSf/vyWMx+EBn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909093; c=relaxed/simple;
	bh=44/DD350qh7WckBw9PGHp873Y/ioGlF9qgdVnOswNv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eh+9Z3sAOUdfawGZxySyHsO+4q8iSNRaXMS504L4N32ZryJgqzA7LELaCL/L7f9jYFjnULRJ0EIdS1plX/8Wl3WOuZakujRyiZ+/TVhR0SuG5aodto/nRPqeiLIuIFOKmwGQPAGDbv+kPAibk5+LOOFoc0x0o0VoACPGMvQxA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqNAiXCo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0de1c378fso29371666b.3;
        Wed, 30 Jul 2025 13:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753909090; x=1754513890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOhp7r2EAcVU0KVvO1LP2KNwmRmtVbUzrMAhBUC15b8=;
        b=gqNAiXCoGX/m/powAQARpfnnziHiynxz5GqbmJF+NKs6xCmOdW+Cr05j8xyvU/B+C0
         uDzpad57pI2wdl6vkm1ED7uROk/9AG60t0auix5tksxH4KxgVY2pgutaIzq84PmnQMfc
         U7aLeay4qVJFXd5kWDMTJornjCtWKhMVqPd7VHAyTM1fy9U033K3i0GqGMcW1fAA3G4A
         mjqEj9vUP2HIKhs+CDBi12Icy3T3Dwa1C9tnSM6TgiVGdOeT6BW6Gmrcv4fn7lJ8P8Oq
         +qKyb7eqJM5j6+Jg2R1YH/4WudFMeVdHsxvyU9NqGcj8BjnT7hlNM2buwzH2VuLV1rT9
         4BVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753909090; x=1754513890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOhp7r2EAcVU0KVvO1LP2KNwmRmtVbUzrMAhBUC15b8=;
        b=e5E7NgRa52XiuUn2gFKqQyyAkIXXJ2ZVBhG51puGSvkSxMqCHj3sHcU8jSQliDZTao
         dhsMe70I2LEpxgScZ6endFqtLyJ3XmftiuMhLS9nmC9lbN0fFV82ZuvlvTsRsi0Muhbe
         Px8DX2B1vpijRKvY5YUeoJPAdxN3clU+flqxtUEp9heZik6fDZYUMOzSgCd1mmUhB6Ol
         6VArvrfHpdOJUajDtbuYDTUgUnInX/x0FzfHuZs+mU3Omapc77+j0YoE3CtqJkYPNq1e
         XWTyoDG3UxwKnIESNy1oTj3/mXXRepxen07IhjAQGMiRoy8g0KJjCcpeA+bRVOImFDda
         wwxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGo2IU8jVPVEeT7h8KC6yt+PuDCSMW90P/eEDpwSJHhh9rB6eAReQef8Hr4xhAD87Q8VOmy+5p3xyzkk0v@vger.kernel.org, AJvYcCXBh9j2dxSincQBKB2YTUbKI/VJITvOTtmLmGVstkRLYirWwYeQY7Mv9+ryFtCwtEv9JEHbnTRg0DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FgMQxDgOkR3CkWNhTG9gYUvudj4+HfLcOW2BHSvuZDgSeEDG
	svvG9wmmOsZwZ8I5wp7cmJlfYJkldTYEKJaa4jZ8X39NzmmzwrLJLV1HJDqdv3rBSaN80G6qqys
	Mweg2qhf1m5rmi0ptVVePuSgabjceVMk=
X-Gm-Gg: ASbGncuamWUWNr983WfAVbWtjyYoR/023i4+gJ7Vgr7RnQfgDPhCdclH1X8l6ULwUzj
	aAMO9DOzbLlTJdZZIFwG00OieE+sM+JIAtYd0wQaDvgm7vauP4SnFy7zC1HjKqktMtuD5b/AF0t
	CnPMEdO2lff8vlRgfI5p2hfKEiRfAyKHdEd4coIp1w6sH9UjD+z1sKGJ+S/g3KtftRcaWWU8RhO
	VeMa3NGlw==
X-Google-Smtp-Source: AGHT+IFmpXrYzcmF+DYbymakSMAuwdT8++tJ5UvyNGeE55SK7ywq+6We2wcrxllHy1JZt5aJkdVOMj3VHa31r7GiSog=
X-Received: by 2002:a17:907:7245:b0:ad8:8621:924f with SMTP id
 a640c23a62f3a-af8fda56751mr576429266b.56.1753909090119; Wed, 30 Jul 2025
 13:58:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com>
In-Reply-To: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Jul 2025 22:57:32 +0200
X-Gm-Features: Ac12FXxWIKzQumu6ECe2lGZVknHLNjhuKfVhKTzp8DYtfrctUf50gbxsZMlIKr4
Message-ID: <CAHp75Vc2K3AmPhwme3+7cCGwDTA6V+4Ug8f++iFr8gCThCOnQw@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: bmi270: Match ACPI ID found on newer GPD firmware
To: liziyao@uniontech.com
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yao Zi <ziyao@disroot.org>, WangYuli <wangyuli@uniontech.com>, 
	Jun Zhan <zhanjun@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 2:56=E2=80=AFPM Cryolitia PukNgae via B4 Relay
<devnull+liziyao.uniontech.com@kernel.org> wrote:
>
> From: Cryolitia PukNgae <liziyao@uniontech.com>
>
> Some GPD devices ship a buggy firmware that describes on-device BMI260
> with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40,
> let's match the correct ID to detect the device. The buggy ID "BMI0160"
> is kept as well to maintain compatibility with older firmwares.

No, it's not true. See below why,

> ---
> Some GPD devices ship a buggy firmware that describes on-device BMI260
> with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1],
> let's match the correct ID to detect the device. The buggy ID "BMI0160"
> is kept as well to maintain compatibility with older firmwares.
>
> Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41=
.zip
>
> [1]. See the update nodes in the archive file above

Yeah... I think you need one more attempt to fix it right.

...

>  static const struct acpi_device_id bmi270_acpi_match[] =3D {
>         /* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
>         { "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },

Unbelievable! How is the above supposed to work? Do we have DMI quirks
in both drivers (bmi160 and bmi270)?

> +       /* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
> +       { "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },

For the record this is incorrect ACPI ID, nor PNP ID for Bosh, unless
I missed that https://www.bensonmedical.com/ is bought by Bosh or part
of the groups of the companies.,

>         { }
>  };

Can you work with Bosh to resolve this as soon as possible and use a
real Bosh ACPI ID (BOSCxxxx) or PNP ID (BSGxxxx)?
Also, each ACPI ID adding patch (when it's incorrect) must provide a
DSDT excerpt in the commit message to show this. Ideally this also
should be confirmed by the vendor of the device (GPD) that the ID is
incorrect and a correct one needs to be used.

--=20
With Best Regards,
Andy Shevchenko

