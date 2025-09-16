Return-Path: <linux-iio+bounces-24172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D81FBB59D63
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 18:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535BF1887FDA
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 16:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F3F3728BF;
	Tue, 16 Sep 2025 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAlF6tEM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE827713
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039659; cv=none; b=nRW2Nc9r8mQm6qalxBI6CCrOtsI7NxxXwSLoT8qsqmhhmynQWhgAaGcwwT5L863k6ff3cBYJOt9sXu8wzAIWVTLWspSeHXOMy9ARUCThau0zr8XtUok9ofAXKqAe+1KPoHT9Ce/EbLv5Uksj4LOQcBTRq5rqyK0dwFcynng2qM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039659; c=relaxed/simple;
	bh=ulrBpmULpfIvUTZuGDI6k7fL4z+It/qAwTU3sy4JRNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UX9S0zOUB06MVcwaALT8Z4YF8mxRZYEFkkDV5UGCFtgTaw64s9YM8pFom9qjw2hUSRk9oQbiMOoF5tpWpcZfQ9lp5mH+y6Rv9INdLU9J1nfhkAQLlL2SCXRQwqiolhNW1BwZ9JupE5teL7FnN83byegk4RR5n6yeEgae2sjKuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAlF6tEM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b046f6fb230so4757866b.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758039656; x=1758644456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulrBpmULpfIvUTZuGDI6k7fL4z+It/qAwTU3sy4JRNA=;
        b=FAlF6tEMVhLJBRSiGqNvlLzuyefv2GGW/3r4gmVNhxQ2oN703pMr7WRxPba/N1MaYX
         ly9UbOtCDrQsdUnwZflXE2Ftc/3qOJuF+MAfPivUqvGu39nKjZ8AbUv/YnQiDbVcn/Ji
         qKk1zz5uw8ZJRMJHfplWtpERA01Cv52kmzQM57sCd9c6z1cPSRny8/UC4oNbLjGugWCb
         f8JQzy6lZ78kwuzKE7aWa5WHYXekfhFE4Ow+gpZzvvC4Ol4duJSU2dGExPp//kNgmMOd
         0grEIfR70SFZnqM1p5vdPFRSG16S4BS1RZp/XsWbuq6rbxY5gvc5oRcs5i6/slwZ/ySN
         td+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039656; x=1758644456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulrBpmULpfIvUTZuGDI6k7fL4z+It/qAwTU3sy4JRNA=;
        b=j7J54uPvV6uVX1ohXSzZDBfAZVWpMNBMKs8uoYYSZkJ/gD84qzwEN1kf9acevBkOUS
         yu7lW/PJToGA0T6ekqKaazCKBYtvuDzXkQ6dkzkU9pfqrOiDhy4/5AUngxatdEMcmwmp
         2+Ey+0IhXzP0VWcRP8Ua3umNiX7piitBSHD5xSL+P/bZ643fYQod31xO7nSgLAZi/Dxn
         VjVGdk1K3qaWqW230Fp7EBS4Ckua9yTqJ98R2otxfVZ3vd4h3Qi1Ek0mfgqD5xd32b5a
         MuG1CuUYq5Jnsjz7nXn2nAh1kU+VPFJ4n/rSsvL09GP8eRE+iu//qra91dk7cyVSd6GB
         PFNg==
X-Forwarded-Encrypted: i=1; AJvYcCVC756hLM5zieKaciN5h+JblTTkk/J/LbJZ24F/H2BEA9mMOsqIQUS2CzXepCHLA+Gj+3b4CPguELE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+NIW0UFceuivGp+bfl9KjHLymlIR+y2XVEZ7W+16qvZSVCyU
	wRzqZyeSxW48MNKj7IieNoT6/2g/W8WYgqAFDXhu8uyBmwumL90wt7NgGyRZx1+LnwLDXZIX+UE
	OZutKb42YiAYE1kh7L1DG4u4/SpTb05o=
X-Gm-Gg: ASbGncs3N3aV7rRAlVk9Zjj2aeUPdhttolC3JVtoPvnNAgnmZ+qdFqKJtQjCxB5ancz
	LOfEm41Go9FllxHORH0FjXV1FE4wSFJ4lY8Dg57EjVlQr757jn6laI1iCzpE0QT0gArsaxf7ueJ
	fFIIcXtIdyMhgqVsbDmceg4WZdgQ/4MkbA4JDbN+xYyIcm8re72uUiZ1gZlJhnpKy5uCNTGLyNN
	qOJKv61f5ntnaLgih2B
X-Google-Smtp-Source: AGHT+IGA8Hqku61GdN0tv82dLQSpehp3yOORqLZ98SpsQ5y7NQFjpoQmHrSdJ6nWYWpl2lgbZa5OwvxQ8sZ190mW4i0=
X-Received: by 2002:a17:907:3ea6:b0:aff:1586:14c2 with SMTP id
 a640c23a62f3a-b167ea602f4mr354112766b.4.1758039656243; Tue, 16 Sep 2025
 09:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com> <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
In-Reply-To: <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Sep 2025 19:20:20 +0300
X-Gm-Features: AS18NWDRlilzMzu6AWDLe7t6r54-DCtwvznfQrFZlMZ-V39YV0OjdaouC0GJw1E
Message-ID: <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to devm_spmi_subdevice_alloc_and_add()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org, 
	casey.connolly@linaro.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:11=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Tue, Sep 16, 2025 at 04:35:35PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 16, 2025 at 03:24:56PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Sep 16, 2025 at 10:44:40AM +0200, AngeloGioacchino Del Regno =
wrote:

...

> > > > +MODULE_IMPORT_NS("SPMI");
> > >
> > > If it's exactly the files that #include <linux/spmi.h> should have th=
at
> > > namespace import, you can put the MODULE_IMPORT_NS into that header.
> >
> > Which makes anyone to import namespace even if they just want to use so=
me types
> > out of the header.
>
> Notice that I carefully formulated my suggestion to cope for this case.

And I carefully answered. Your proposal won't prevent _other_ files to
use the same header in the future without needing a namespace to be
imported.

> > This is not good solution generally speaking. Also this will
> > diminish one of the purposes of _NS variants of MODULE*/EXPORT*, i.e. m=
ake it
> > invisible that some of the code may become an abuser of the API just by=
 someone
> > include the header (for a reason or by a mistake).
>
> Yeah, opinions differ. In my eyes it's quite elegant.

It's not a pure opinion, it has a technical background that I
explained. The explicit usage of MODULE_IMPORT_NS() is better than
some header somewhere that might even be included by another and be
proxied to the code that doesn't need / want to have this namespace to
be present. Puting MODULE_IMPORT_NS() into a _header_ is a minefield
for the future.

--=20
With Best Regards,
Andy Shevchenko

