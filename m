Return-Path: <linux-iio+bounces-4142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E74789BA74
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 10:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0222835CE
	for <lists+linux-iio@lfdr.de>; Mon,  8 Apr 2024 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2DF38FA7;
	Mon,  8 Apr 2024 08:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpyG0kzu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB610E9;
	Mon,  8 Apr 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565487; cv=none; b=Yzt/lVyEzRr0YdcH+j6wxdP7/7MSgqoJsvUXx3yI7WXUXwShky44pWGBzlV/VhNdd5g0Pg/sI+TzxyYG7qTLUSqQmdkTgBLcMcCcLTjeIdzVKKZ6rBPNSTLwRu/4VmMRNrp/rkn9f3QpLr/5nyXG+7oiMLs83GcEwWejiUGoun0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565487; c=relaxed/simple;
	bh=rrM4TxubxqPeEYOH+wck6tg3nhRCRKAf7aYuz1HQhoE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJx9P/8a4XC5CzRpqWkZefKGUCtu0qiLkV7A2GnNEUbM9WWjoF8KXDxWeXMRpHM/g2/5va5AxsPt/Wi+7EldvYOssyX9z37o3s258YIpwRorpwOjvejNkWGRKzuzbDsYdtxKegj5eAkJOA7rmCNtGKvXz3Ap2a/YdRoYhdqQ/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpyG0kzu; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a51a1c8d931so331559066b.0;
        Mon, 08 Apr 2024 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712565484; x=1713170284; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rrM4TxubxqPeEYOH+wck6tg3nhRCRKAf7aYuz1HQhoE=;
        b=BpyG0kzuGqyxC08raoFpvDqedHM7NSMH42mYd7wXN+QhiuY8dX58vsiuqeLyOKY0b8
         vo725qLccRf8Mdt2qFHT+Oe9c+tlqN5Qcka0A04nJLtk8AERdrJJvXeP7FIOJl3/5/xM
         aZ5gbq0Y3nF4/l2tgDFZjAOvddZVMVTFKZ3EoPURSP2L4pqRqey+wmjq8zyka58MikdH
         1RMa2SfRF/KilqlNCAsF/D78CMVkEjDlid2BnZZzTfGKXpomSb3YH8ys5/U3j1pfZz0P
         ekRikUePvraMK/gttSuFgnZPHQkoI6/nru+10kKQml5sRXVC+epoR8cy0Fx5wLx50h41
         En+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565484; x=1713170284;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrM4TxubxqPeEYOH+wck6tg3nhRCRKAf7aYuz1HQhoE=;
        b=XEXBVhHzKoHDK5pkrgOTZa0UrI/BgQ/IStidpxGbQpw1SZwglwxqVNdmVQ7mpQegnB
         xtNGx4YnSR5IpEJ63lIxJ3OFcyZVQhM9Ko1aQ4uwv+lec3+imBAqiayf6JmCAbMwDWMp
         N0E4/NviiZybhuECc8rMZySFWzOXUU3QmX+/L1MC3QHXbFQC4EcIkhStWALJ/IdZUsw2
         sfTspqGHiyEVpB2zdAtmAO22vHyb1zskFDnAa7MM+89iYfOT8J8mnVd7XyRHY85a+BCi
         VP3ON2hIBFRAPC/RY/TDJP/a07m+/IEQ54+tpRTjjzwFuPrvnbDn9/iofsIu0QIY59Bn
         vyFw==
X-Forwarded-Encrypted: i=1; AJvYcCViEmWo8wLsN9WJxBoHLaw2PNkP6TybPBAU+lEPVI/NSsJPn4pLed0uPOydesQ2ZXhGCAEkL0G94BOq0XOpd+hrYw7cxgbsMTe4zA==
X-Gm-Message-State: AOJu0YzM+l6NrV2vIkTqLsoT7++QnfuvqJatcl0aMFT5K1UP2HsQ/GKm
	PkM0c9T2vNdSz8MRAwg9vkXcQqF6ZgESMukhXHpixbSwqsXkw17EwZqqcTPaKLyYBw==
X-Google-Smtp-Source: AGHT+IGZITCwEhqKnga08lueR88bZHZNvfA+2v34n+8j0x6NZXchZuKLHpZl8KpUG0XsMiHxkhBSFA==
X-Received: by 2002:a17:907:175d:b0:a51:99b8:9dc1 with SMTP id lf29-20020a170907175d00b00a5199b89dc1mr4851255ejc.51.1712565483514;
        Mon, 08 Apr 2024 01:38:03 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id en1-20020a17090728c100b00a51adace6ebsm3552256ejc.79.2024.04.08.01.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:38:03 -0700 (PDT)
Message-ID: <b79b30bcaab03d2bcfc096829cdb443712376da9.camel@gmail.com>
Subject: Re: [PATCH v2 09/11] iio: backend: add new functionality
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Dragos Bogdan
 <dragos.bogdan@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Olivier Moysan <olivier.moysan@foss.st.com>
Date: Mon, 08 Apr 2024 10:41:35 +0200
In-Reply-To: <20240406173248.2a574251@jic23-huawei>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
	 <20240405-iio-backend-axi-dac-v2-9-293bab7d5552@analog.com>
	 <20240406173248.2a574251@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-06 at 17:32 +0100, Jonathan Cameron wrote:
> On Fri, 5 Apr 2024 17:00:07 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > This adds the needed backend ops for supporting a backend inerfacing
> > with an high speed dac. The new ops are:
> >=20
> > * data_source_set();
> > * set_sampling_freq();
> > * extend_chan_spec();
> > * ext_info_set();
> > * ext_info_get().
> >=20
> > Also to note the new helpers that are meant to be used by the backends
> > when extending an IIO channel (adding extended info):
> >=20
> > * iio_backend_ext_info_set();
> > * iio_backend_ext_info_get().
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Whilst the code for the backend retrieval callback is simple
> I wonder if we are better off just not having it for now.
>=20
> Keep the infrastructure that checks for the default approach not working
> but don't actually provide the alternative until we need it.
>=20

Yeps, agreed. That's why I brought it up in the cover. I'll place a comment
stating we're aware and what may be the proper solution and have it when ne=
eded.

> Advantage is pretty minor though so maybe just keep it.
> Unless others have strong opinions, up to you to decide whether to keep i=
t.

> One trivial thing noticed inline.
>=20
> > ---
> > =C2=A0drivers/iio/industrialio-backend.c | 179
> > +++++++++++++++++++++++++++++++++++++
> > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 49 ++++++++++
> > =C2=A02 files changed, 228 insertions(+)
> >=20
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industria=
lio-
> > backend.c
> > index 2fea2bbbe47f..ac554798897f 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -29,6 +29,7 @@
> > =C2=A0 *
> > =C2=A0 * Copyright (C) 2023-2024 Analog Devices Inc.
> > =C2=A0 */
> > +#include "asm-generic/errno-base.h"
>=20
> You'll need a strong reason if you want to do that include rather than
> a normal one like linux/errno.h
>=20

Hmm crap, Fairly sure this was clangd automatically adding the header file.
Sometimes it's actually useful. Not in this case :)

- Nuno S=C3=A1
>=20

