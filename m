Return-Path: <linux-iio+bounces-18154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A2AA8AFF4
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 08:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E85B441801
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 06:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694B1C8638;
	Wed, 16 Apr 2025 06:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgTuAQcR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E779317BBF;
	Wed, 16 Apr 2025 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783302; cv=none; b=j7vAQsyHDNKbzHfnFEpzzt5PYmgpYsUzT3br7EWtJ02PGpG/or7MqwrYVK1oELvbFCyFMypWiqjAv/+zvvbrKK3Rc59IdcK/a179ZWqWiLjAOZ3UFbG0ROnrbNOP9F+ae0Id7t9BBEWKGWXQJeVXz5McyDwPCxmPZdPQfpl2Kmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783302; c=relaxed/simple;
	bh=nw0fYoKBNrGqxhQefdb1OLy2EWV10YlOsKcnVYup9co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbSMCf/9fo7HrToQuScVVWjqYGobBdC55SqDTZ1uBf2yr+THXyl4a/1h7FQElTE0FnysS7QXUchaDWec2WjJyOoneZDmDOqriwRkzE7pxVFHkcaX/pHk6RvkoNFnv5qC79MJS5s0YrqmVolBm7leP/XybWJkpoZm1aqYUyTubcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgTuAQcR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2aeada833so76827266b.0;
        Tue, 15 Apr 2025 23:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744783299; x=1745388099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEMwfYK2Ina1apMEGAXquVJGse8ZNYzgFZuw2g5OCkc=;
        b=jgTuAQcRGm0ESQIRDqPvrTsteYIVlkW1cTu6F2z7KIiIoj6K46mPaMeiBPojLqPGIP
         jJu3KBYkaLAEm80n1Wk7bl2ixcF7hKcdgFBOkhs8f6dTJwp090uSgqI9WnpaIrXaCzXk
         vAeoATXKl/9ToBnUTx/SbB+5tzEHePVAnmewaRxBxpyrVeSc0hMtPJfYTDvfw1Lc6YNJ
         /EmTHwg9huaSXJ8xvLBTR5FTjH53gr1EPZPr9eJvaOcWOchDHBnjLUFuVPLo2L14fEcP
         1J3Tcr+f4FWREWzrMvU7suVcILeehnAG4SE8s786kUQ/caQ8MrYoIAtQdsY92PTXELPH
         8Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744783299; x=1745388099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEMwfYK2Ina1apMEGAXquVJGse8ZNYzgFZuw2g5OCkc=;
        b=BZfW3U6MMnZ+yjeRpSRJenE+X+0vsa6bZ4brwwFH1wUDCXrfZ17KwH0QdLrP/kBa9K
         sEjFSMvcZljHpfBA/YAbKf2tUnLcuIe8Gu4AwOZXsvE+8UJ+M0c5QBR2Br1svMv+0X/Z
         QuoFEZpLCMaBCZLHiwP9tDCT3N8P/BVkf4y73YbD3YL6b3e4tG4nilkGt3RLuvR9Ovs1
         VcR0kdYhCLNQsycfDtHFEMHWy4s3xbZXfqAmAlNd+XGtumW+8Lu/6WWMMLiD1gWCmiQX
         81xokByuDDCX1LrSZ8P5ibuTmeWrw+ARQXzMc1bxGITT6ZppheTyot1Sen0VIrREq4OK
         L41A==
X-Forwarded-Encrypted: i=1; AJvYcCVVkrvszgFUd4NLJKqf7fghEz8cEHo/Ird89DJPEIGO3qdSULGF4UOVhBikEBHT7F3k7wNluqzKEVc=@vger.kernel.org, AJvYcCXVNzGcjpYEiFPBqnlt49SJnXvhONzlAl7eJ/mgPuns2xUKmxTpzu95XMsnbWMSKtBmXsuDqScfkY8sMApW@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9n1rTGo98USGDtUN0HMiKdmd2LFwga0FYXZ0I7DGCIjpVY/1
	Cbvhl5I3O9YI3yRxVrwPEXu0Plj96Ny06OIHeRn7YaWSqRhGbePy7I7bPFYkJA+br3GiAmAN8sm
	2EoZpmMr2eNVcRdaa2k6JlLy5Q/UdWeqaQL0=
X-Gm-Gg: ASbGnct+JHMJUCwDY+i1JfrxS2uXKwaIm732WAtD5/DKfOCMLB+QlwBbu9/JLahnlhA
	X0akVUpg0sM4+A/4zdinCHN1nosAe51GQJWa33X43ZJn3raTozrzbMU9ylshrXfUrF3QZBnNgis
	GxovXlioYh9e5oIBS8MsTzslk8u5T984l1M8w=
X-Google-Smtp-Source: AGHT+IGUeKC6ldQzvby8Nf7EIpx50LD0DP93zySLyTJQvNKwsZAWdGlamD3fPvt/5+EhZ19lOjY1MyN3zGoM+7S3zaw=
X-Received: by 2002:a17:907:3d4f:b0:acb:1165:9a93 with SMTP id
 a640c23a62f3a-acb426b5ae3mr39928966b.3.1744783298921; Tue, 15 Apr 2025
 23:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8f765cfd6e93fad4e755dd95d709b7bea2a388e2.1744718916.git.marcelo.schmitt@analog.com>
 <CAHp75VendQGLdpggySS3mX6M2YSeS70bvE8yg7sp_LNGDS-Scg@mail.gmail.com>
 <22858e4f-db8e-4c97-8551-a1934a9f2fe7@baylibre.com> <CAHp75VdKpSnwfKO4GaJmVOs8kHASsZ4V9yNcZ7EF_GVoDNmrfw@mail.gmail.com>
In-Reply-To: <CAHp75VdKpSnwfKO4GaJmVOs8kHASsZ4V9yNcZ7EF_GVoDNmrfw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 Apr 2025 09:01:02 +0300
X-Gm-Features: ATxdqUE1ACoc9Bbx7e6SSejR07bifi3qZikc4QQ4cFD1JPE4yJT8opEB8TYHwS8
Message-ID: <CAHp75VfuCkohVLUJKgcMrgad-fRk4aKx_Ki0gRxxhJP3qgvS1g@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad4000: Avoid potential double data word read
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 8:59=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Apr 16, 2025 at 12:22=E2=80=AFAM David Lechner <dlechner@baylibre=
.com> wrote:
> > On 4/15/25 1:02 PM, Andy Shevchenko wrote:
> > > On Tue, Apr 15, 2025 at 3:21=E2=80=AFPM Marcelo Schmitt
> > > <marcelo.schmitt@analog.com> wrote:

...

> > >>         xfers[1].rx_buf =3D &st->scan.data;
> > >> -       xfers[1].len =3D BITS_TO_BYTES(chan->scan_type.storagebits);
> > >> +       xfers[1].len =3D chan->scan_type.realbits > 16 ? 4 : 2;
> > >
> > > But wouldn't be logical to have
> > >
> > >        xfers[1].len =3D BITS_TO_BYTES(chan->scan_type.realbits);
> > >
> > > ?
> >
> > No, SPI expects 1, 2 or 4 bytes, never 3. If realbits is 18, we
> > need len =3D 4.
> >
> > It would have to be:
> >
> >         xfers[1].len =3D roundup_pow_of_two(BITS_TO_BYTES(chan->scan_ty=
pe.realbits));
> >
> > But that gets too long for 1 line
>
> Actually there are a handful of drivers including SPI core that need
> that helper already, I would prefer to have a helper defined in spi.h.
>
> , so I prefer what Marcelo wrote.
> >
> > Maybe an idea for another day:
> >
> > #define SPI_LEN_FOR_BITS(bits) roundup_pow_of_two(BITS_TO_BYTES(bits))
>
> Right, but as static inline to have stricter types.
>
> > There are a couple of places in spi/ that could use this and several
> > iio drivers.

Or even wider, in bitops.h / bit*.h somewhere. Let me craft a patch.

--=20
With Best Regards,
Andy Shevchenko

