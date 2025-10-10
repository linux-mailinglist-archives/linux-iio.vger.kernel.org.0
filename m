Return-Path: <linux-iio+bounces-24915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7E7BCDF39
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 18:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D05919E04D4
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE602FBE18;
	Fri, 10 Oct 2025 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDUOpkRH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D8B2FBDFE
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113473; cv=none; b=cokat6pOn5y9ggHT+UQk9Cln1Qmnahb6xTZCjxH+oqM+dauQxww4IRpWj/r/CJA0jB3RIZdMaoHtF2jKYsQxKZAWEnNNXzwgLs5d9xLdLFjZvawV728bdZPpRqAYvWLz5cP4xY8vXNZ8IwsKdlJ3r6bcNwVd93S9DJMG8KblgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113473; c=relaxed/simple;
	bh=PxAoGomB/6W/ejWKyFYAfi4QirisgQyAtVNkWP21M5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkPWTaU/jOa0nub8mBdeqNuZV0r8cXRQ4cHNo/kYfgY94p6mr06ZM9vLlKdMTrNYJ2A3V1ppuvTZuvKt70aTyomqjekkogoljy1obMuTvyars7kUBolZC8/m/NWey4YKsK9IFYpCIt0MANimGgJesOqg1VnBrkuJPutbx/PKK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDUOpkRH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb78ead12so373752466b.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760113471; x=1760718271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxAoGomB/6W/ejWKyFYAfi4QirisgQyAtVNkWP21M5E=;
        b=mDUOpkRHQ2sUhKRa/ldJy8cQ2uEDEDjn8iW9ldu+PP5fzUDa56nNhEFTUfy/IC5ySZ
         gRcLzSahuDz/GCn9u4A/Q22jI21yXmPNnys9qis4X00TSgOkJ0juBr8MywbUZo8OWpOU
         XFJLjtq9qfqY5Xidh9JcV0axVZ1OxcOp2/JtPZS7g7kc9+v9NF780tCDJLEE5DGBvzqg
         ES2X0NgbA3gGwdj6oNEzPWbKufBN5UonUVNiuO4LiY9c7Q/XVRdgNTlwJ6nIYsPk1AHy
         Mjv+rHCeZfOleuopAi2aeJjr20JBSll0pq7UHFoO2JQFOrA/yO0eJQdSx/6bSKP0ZIFG
         x6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760113471; x=1760718271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxAoGomB/6W/ejWKyFYAfi4QirisgQyAtVNkWP21M5E=;
        b=bF+z4uwzbNip6glEHVRSubnCmq2MLVJUVZKnO1++5OFw41kjsdGAhMe4C9TnRM8cFq
         0JEonAdhg/C4KIuw8FXdhV+LjiOZh5meseId9AM0fr0j0Ib0Ku7EnCjNw3MrFMimRl8B
         wrnOQnKL5C21DOmNpg2lxR1vh93q8qOgeaF6PNnZ20k3Pd1bko9J2lE/R+yWMvHJuJkb
         25vBA8suBCksNsR+9zU/7dnjIZezlG8SUIcUVcLHXmlbIBkqht4dWBG3oi0D+7TxOp9Y
         zj+Vx+LNq/d3QguCrP7WB4dw+V58OLFfvhb1gtC5aR1VKmTFn8FqAS61aY3kBrwIam8/
         Zfpg==
X-Forwarded-Encrypted: i=1; AJvYcCU8OYUUh2K0vFM2F9P4pJzcvPi378yXSYuB7cfnTDHDewVUOEb47n4haEQZ02RIUjgZWzYgHPLRr60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvlO+1y5rwGi8Ve+ZLNXLPMiz7XD/KpSUfgZMa1FMVi853JuVV
	teiDLv1MXbyPV1+Yk+3+Rumk+vuSw+htvKlKDkZl/eRx/so0BDKC0ZKGjPwKSOKayi8hx2hh6wO
	4BZU0HX1yFCX4K199tks0Mg6fzySjaGpQa9Mj
X-Gm-Gg: ASbGnct4IXyXwLqwigNUWeSA4J3cT4lFB2diZycn1A+3aY18pRgiCx2udIVr+DXbYbd
	NOSt/Yt6T2Mgz1dwaknLaOO4OGflT+/48Tx2ekUS2DnPrSWVa7xOlEvdlhGF7kXluVtwBpYqVKf
	fImePLXKS3iGFMPQeghxlK97NvdFXi+DKm376bPhVep7weiXdEnTY0EQNXFjqF9Evs5e8e9XXLm
	Xa94VYUZLYIn48Kq3hK+grG4g==
X-Google-Smtp-Source: AGHT+IH3dUeu7u4Wcz7UH2Wk1ekmwG/avu6DuHXVWRwrs6DlnQ2d6HiPwADb3eOBXMAPPzLk4dKdm1qs6zcf+ex/P70=
X-Received: by 2002:a17:907:7213:b0:b41:a571:21b0 with SMTP id
 a640c23a62f3a-b50ac1cc421mr1177748466b.39.1760113470537; Fri, 10 Oct 2025
 09:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009173609.992452-1-flavra@baylibre.com> <20251009173609.992452-3-flavra@baylibre.com>
 <aOg3dg21aWNTF47x@lore-desk> <160b32c14df3daa06304fef430534561cabcfaea.camel@baylibre.com>
 <aOjAK9LRMCcBspkb@lore-desk> <9dbd2ae7883ec8dba65706603a29f3144076840e.camel@baylibre.com>
 <aOkG-jBOYXxWy1z3@lore-desk> <007e87d2-92f5-417a-a6bf-1babd4c60c61@baylibre.com>
 <aOkysKyWX2hYEnED@lore-desk>
In-Reply-To: <aOkysKyWX2hYEnED@lore-desk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 Oct 2025 19:23:54 +0300
X-Gm-Features: AS18NWDo_jfto-o10CvquEBrSCsJkhlBP7cCL6i324_1eBlCH6pZSxx8Pwp6wkM
Message-ID: <CAHp75Vd8MmDXm_OPooHC3B+HdHoTn-TvGbRg-C3-gjNSZQoU7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Francesco Lavra <flavra@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 7:22=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
> On Oct 10, David Lechner wrote:
> > On 10/10/25 8:15 AM, Lorenzo Bianconi wrote:

...

> > In the IIO subsystem, we prefer to include the units in the variable/
> > field name as well, e.g. hw_fifo_odr_mHz.
>
> ack, but please avoid camel case :)

Don't mix up a camel case with units.
Or do you have a way to distinguish milli from mega, please?

--=20
With Best Regards,
Andy Shevchenko

