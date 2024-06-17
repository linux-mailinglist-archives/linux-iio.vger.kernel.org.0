Return-Path: <linux-iio+bounces-6336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9651B90A5EC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 08:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1488B1F2381F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 06:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B181802AC;
	Mon, 17 Jun 2024 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFd/7egt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1B79D3
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718606048; cv=none; b=jhCN1ALC6ev1UEAyQVLXneb/tiIgg6WqcoR4rDXyWXQTSXQ161SViHyDPDDUH9s3NfQmxEhP3uOD69UM1+zGcyuxDAf0aX5J2fbb50yvAQlC/k0SUOrwiMo4nCuRWljqB/7LxZsxXeM1VXWuxOWm67Y9Z1lN0fzs4WNir9bcAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718606048; c=relaxed/simple;
	bh=US33UbpaJOkf6FXLZ8ZqwfZ+RaV4AjdH5q8ltCeM4nE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KgmXWh9m7oeknuiHhnoS7qEb3744EnmQy1M57dyqoafqkwBWF64tdB9JD8t4LptJXfLbA5sGgbNF7faBIuyeOEtr6Y/tAY5cU70SKX1jBKqb5AQPzDrMpX8M1LvyUgWXviCy09qFJVSh58YxEgzwOeJUC+t0rJAC1HqmDusEsvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFd/7egt; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so5967459a12.3
        for <linux-iio@vger.kernel.org>; Sun, 16 Jun 2024 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718606045; x=1719210845; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=US33UbpaJOkf6FXLZ8ZqwfZ+RaV4AjdH5q8ltCeM4nE=;
        b=kFd/7egtKq6bOIjDGta3yDkCD+K7aSUUCNXLUkeu2lqsKQZ2PXfjkXZ+VUEctRIui/
         dkoqVMmMvBhjMVZ0P41wQY269AUqeQXAMBUzqISVyfoWzaIrrOorlhtNmSz1nDljd3Sc
         J5M8F8h6QKLoVO14rWbp1KHECRb2/hLJWd8e1aP9UARNpRX3MGTpNji9lJZiXPr7zO5x
         Ac/vDUkfD2K+xbmb7tvNR58oVqCzE4G9eiIm6ykXP1Z/ZbnrHGIKXfKylWLctfM7IOZL
         foCuWNMdxmevR4Wy8JIEr+JGMbS8EUlwuK4sh0JfLA7r/0xeCNidTryp21qRz0D8D2Bw
         MLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718606045; x=1719210845;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=US33UbpaJOkf6FXLZ8ZqwfZ+RaV4AjdH5q8ltCeM4nE=;
        b=TxRNvK+Y7cuCuc31znVwzWuA6/qWdY2995xcR5SUF8qwSjQ5hwFfDClABadZScGWaK
         Zip99X+TJLBDzU7Bn6CaLtddZ3Amf10oqsUaJLef7BUKyLbbmGyyU1EEjI740jqP+xGC
         AULtHz7ggr5i2U7eVLPzeQ4rXyw3mbv7MvSQeJhlTY84OkbGRLYCsRERcxD2wb6/zqvP
         KyiqYfbK3zOru5gTai/Y8c6iGyFmqVo2tLz8H5vU9I3zT9XE91oF8InBIaB7q0CJndRe
         nXyIGnn/jd/0KJZWnISJ7Lh4hwoO3RidpbUr0lkcsjOZWYzdljCTPrvhoCEZAqgAg+Aj
         Q5Nw==
X-Gm-Message-State: AOJu0YyE8oBJY3n8VPAniyTUy3MQXt3pp7P2T6I7ZGfT7eemKg6orPOq
	695zneOYKE3NCdGQwlUm5C4LBor9Z1Mu9fXj3fmy65Tddn7Jfsx4
X-Google-Smtp-Source: AGHT+IEluLVs1QT23RDiheH51A2rHKYu3C3Ls4BKEBPAJGPcj6QE5Dw/BXIaGhOtQCNp29hegk/2sg==
X-Received: by 2002:a50:bb26:0:b0:57c:6461:9981 with SMTP id 4fb4d7f45d1cf-57cbd66ca1cmr7304710a12.17.1718606045080;
        Sun, 16 Jun 2024 23:34:05 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743b026sm5915140a12.97.2024.06.16.23.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 23:34:04 -0700 (PDT)
Message-ID: <0990501bd9195e4d97febaefa5636696bd204db5.camel@gmail.com>
Subject: Re: [PATCH RFC 0/3] iio: add helpers and accessors for active
 channels and masklength
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>
Date: Mon, 17 Jun 2024 08:34:04 +0200
In-Reply-To: <20240615141847.70429abd@jic23-huawei>
References: <20240612-dev-iio-scan-private-v1-0-7c75c8e3d30b@analog.com>
	 <20240615141847.70429abd@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-15 at 14:18 +0100, Jonathan Cameron wrote:
> On Wed, 12 Jun 2024 16:20:47 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Hi Jonathan,
> >=20
> > In [1], you suggested for an iterator for the active channels (so drive=
r
> > don't directly access masklength). This RFC showcases that iterator and
> > goes one step further by giving an accessors for masklength so that
> > drivers can read that variable (we have drivers doing that). The
> > accessors uses ACCESS_PRIVATE() so it will warn us if some driver
> > directly access the variable making it more difficult to mess with it
> > (like changing it's value) without being noticed during review (or the
> > auto builders).
> >=20
> > Anyways, before jumping in changing all the drivers using this, I guess
> > the questions are:
> >=20
> > 1) Is the iterator useful enough to add one (kind of like it and save a
> > line of code :))?
> > 2) Do we care about going with the work of marking masklength private?=
=20
> >=20
> > If we go ahead the plan would be:
> >=20
> > 1) Add the helpers macros;
> > 2) Convert all drivers that directly access 'masklength';
> > 3) Annotate it as private.
> >=20
> > [1]: https://lore.kernel.org/linux-iio/20240428142343.5067c898@jic23-hu=
awei/
>=20
> Cute. I'd not seen the __private bit before.

Yeah, I first noticed it in <linux/irq.h>
>=20
> Looks good to me.=C2=A0 I think we should spin it a little differently.
> 1. Add macro and a dummy=20
>=20
> #define iio_dev_mask_length(indio_dev) (indio_dev)->mask_length
>=20
> 2. Convert drivers
>=20
> 3. What you have + the ACCESS_PRIVATE change.
>=20

Agreed. Looks better

> that accessor still lets people change it rather than making
> it strictly private.=C2=A0=C2=A0 I wonder if we need a little more compli=
cated
>=20

I do prefer your inline function as it's a stronger guarantee... Though cha=
nging it
through the macro is also odd enough that should clearly pick the reviewers
attention.

- Nuno S=C3=A1


