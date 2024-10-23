Return-Path: <linux-iio+bounces-10961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F19AC046
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 09:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0651F24F99
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 07:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17470155C82;
	Wed, 23 Oct 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UAN6oKaf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3D15573D
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668729; cv=none; b=LbvWji5ox7UB3uWBSFp/ACeyFIfLe4IVvSsUN4SAItVYrEfsNURQOiQQwqbCNeJh4E1LwTMUJsJMzRsGEbGK3PIxmuBwwQukB1EF027nw2ybyRa7FWLkxvzJ0JfnJk9fDKJZqtnWdjJ7VlZCQ33MwGc40uNK74xd0v3Uu7FaKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668729; c=relaxed/simple;
	bh=dTDdz6StFkQ7UdOGaYxF3BlZM5FwqqVkhyMDlmNMuoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2Pd2MbAyKA59qDU/WwTeI5yjHxnIMwR53l2lupQrt66Pqa6LTSl3aVuoim3PY+YXpiUgW3ZAcX16LOfi++dH0VLa9P4Q1H1qlPVSh8T1Gi/hJgMXEnrKdV9g8rDS4BeZ4iW5P2vPBUTs/Zs9b6up95tgOX0L4aOL8C06LlExuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UAN6oKaf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso7783477a12.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729668725; x=1730273525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ld+3WPOQF7W9x7JI6fzkyd3V36oBi0SwcjkGdighsL4=;
        b=UAN6oKaf4ef/I0JzdYXntW/u1JELU3eF4tG4EwLfCt8Ws9hTY9Ry8SlxXhGudhk9Ys
         55jsm/zokV/kXDEyKoSfci8rysfnPuxheO891auEldiFNvK1z0Bmf31j7YA+TlYOyVDR
         b07je4+Ncoz5gNEBart9a5qAY/uee84lrBdeipNdO1ulslV3TFKzcs3LjPrQOwJSCqDZ
         8B+UzoFiO+tN1t/bTAMXqw05sZZwme47UXIjdvJc2dm7lhXC0znddgRuHqxHmGGtXBwb
         +SWXtoAT85MH/Cf9T1LUQtlIE7ncBn5QwVri7kwJMCQsyazaGivWm350buutSzjClKOl
         6lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729668725; x=1730273525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld+3WPOQF7W9x7JI6fzkyd3V36oBi0SwcjkGdighsL4=;
        b=s8RTk3XtOm37ft1vGoI7kvIXicLRs9hFXklX9ZLPalOfspX922MIt9QgjepDy2ZCkN
         mk7RWxIcR8DsFB3Tmsst+UohklWWsxfuXZhSaSspbWa4QKhY7yDJYvgKvR1N+y7eNcPk
         uXT2FeKQWX0QbQI3DOOyfQvsHFdzAyRbeXO3OWcxdpM6T7o+NvRoJ3YYKJfRbQcK/gIG
         yuG4IboFC0Peg+RO2Xi9bdxmSTDf+Wg3HaJfjL82pf5jStkQDYAtFRkdVF91GdjJsyEF
         2TMEtKKGmDr29isWsKd3XDLdLT03HhGjn8/ZHKQ3/LKD2UG8xtgDhYbI+DafXafTrwET
         4kPg==
X-Forwarded-Encrypted: i=1; AJvYcCX1kYk7bZSgpnv0SZMMQgYUtJc4kn8W3YzSq/HuWtf7V1j/8mg+dtRsu2uQj4cvFHRSf23VRoGeLgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9+01C0a7AUP/HC660YtsD75r5xWSK91DCNvnU3otmj+M1gZif
	ZHA4udbHSSNNAYBxAjOZDSno4kuqa0PYhynZBggKxmFF1KjFrQG9XsUJ2V5VOvmIvgJ4A7fhEsX
	BJHoNs+IxsYznfO4rPXyMPtFs5L0NgoN0jYOyOw==
X-Google-Smtp-Source: AGHT+IEJBETWRzafCHMiJacmhO3+2BGfuEPqovyY1jdP6hMCT71V63RIrqcr+Gk7ya87qxf9ULOTWDHVQyBI2z8liWE=
X-Received: by 2002:a17:906:d54e:b0:a9a:38e6:2fdf with SMTP id
 a640c23a62f3a-a9abf96d1ffmr137056066b.64.1729668724464; Wed, 23 Oct 2024
 00:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-ad7380-fix-supplies-v3-0-f0cefe1b7fa6@baylibre.com> <20241022210239.6a61b32f@jic23-huawei>
In-Reply-To: <20241022210239.6a61b32f@jic23-huawei>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 23 Oct 2024 09:31:49 +0200
Message-ID: <CAEHHSvYCx1zWmAf8iSdVTaxfewFLoeJo6RXQj7-3hwX40yCjOQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] iio: adc: ad7380: fix several supplies issues
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 22 oct. 2024 =C3=A0 22:02, Jonathan Cameron <jic23@kernel.org> a =
=C3=A9crit :
>
> On Tue, 22 Oct 2024 15:22:35 +0200
> Julien Stephan <jstephan@baylibre.com> wrote:
>
> > Hello,
> >
> > This series tries to fix several issues found on the ad7380 driver abou=
t
> > supplies:
> >
> > - vcc and vlogic are required, but are not retrieved and enabled in the
> > probe function
> > - ad7380-4 is the only device from the family that does not have intern=
al
> > reference and uses REFIN instead of REFIO for external reference.
> >
> > driver, bindings, and doc are fixed accordingly
>
> I considered a few responses to this series.
>
> 1) Asking you to pull the fixes to the front even though it would be pain=
ful.
> 2) Asking if the missing supplies patch should really be tagged as a fix.
>
> In the end I opted for the variant that may just confuse the stable folk
> the most and just took it as is + added stable to the 3 fixes.  Hopefully
> it will be obvious they should just pick up all 5 (or maybe not the docs)=
.
>
> You are correct that the refactors make it easier to review the fixes
> and this is a fairly new driver so I'm not that worried by pushing back t=
he fix
> as it's only to 6.11.
>
> Applied to the fixes-togreg branch of iio.git.
>
> Note the side effect of this is timing is tight for having this available
> in the char-misc-next branch, so it may push back additional device
> support until next cycle.
>
> Thanks,
>

Thank you!

Cheers
Julien

> Jonathan
>
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> > Changes in v3:
> > - Use fsleep instead of msleep
> > - Add all trailers from review
> > - Link to v2: https://lore.kernel.org/r/20241021-ad7380-fix-supplies-v2=
-0-2ca551b3352a@baylibre.com
> >
> > Changes in v2:
> > - Fix kernel test robot warning about variable uninitialized when used =
[1]
> > - drop commit removing supply description in bindings
> > - after discussion on [2] we decided to add refin supply here, as it
> >   will be needed in the futur
> >
> > - Link to v1: https://lore.kernel.org/r/20241007-ad7380-fix-supplies-v1=
-0-badcf813c9b9@baylibre.com
> >
> > [1] https://lore.kernel.org/oe-kbuild-all/202410081608.ZxEPPZ0u-lkp@int=
el.com/
> > [2] https://lore.kernel.org/all/20241015-ad7380-add-adaq4380-4-support-=
v1-0-d2e1a95fb248@baylibre.com/:warning
> >
> > ---
> > Julien Stephan (5):
> >       dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply
> >       iio: adc: ad7380: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: ad7380: add missing supplies
> >       iio: adc: ad7380: fix supplies for ad7380-4
> >       docs: iio: ad7380: fix supply for ad7380-4
> >
> >  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  21 ++++
> >  Documentation/iio/ad7380.rst                       |  13 +-
> >  drivers/iio/adc/ad7380.c                           | 136 ++++++++++++-=
--------
> >  3 files changed, 110 insertions(+), 60 deletions(-)
> > ---
> > base-commit: 1a8b58362f6a6fef975032f7fceb7c4b80d20d60
> > change-id: 20241004-ad7380-fix-supplies-3677365cf8aa
> >
> > Best regards,
>

