Return-Path: <linux-iio+bounces-2250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDB384B7B2
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 15:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B7828AE87
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DF013246F;
	Tue,  6 Feb 2024 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRwzftyU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4513132477;
	Tue,  6 Feb 2024 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229296; cv=none; b=Prjr1hmxoOkideQhczr/7/3JiJYv6dC/kJD6AzHI0spBZOe2H0KMActLYIzE2k9OeR6ZxfoyydN19JujciFQTjDd1hrWdgWMq2+Tgn4MDBW2t0Hen+h2GnXhyTLs0p5HP7jinCdt1gY9kgJGGFvNywyKCBZntWryuqLpedy8RR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229296; c=relaxed/simple;
	bh=d+4LUy6/AXvsok/CmQkFMjIn3dwhjOv7WvhbmYtGbyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Keh2pZFGc8F5EUOLih/fBi+8QdgEIla2OnVPVUxTb8VO4znbbzcuKVDLB13Av3R18NB0KAaQZmF3ZPXg5/vyRXZAAumj8hOKqoiHdnQRMshLJ37W9lbvTTP7UEtQar2ZZRtmY+6e8tdhX7fIuhtIfFTqltnDNALkzaD9bRFyV9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRwzftyU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so7248900a12.1;
        Tue, 06 Feb 2024 06:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229293; x=1707834093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGlgrXYQNRN/frivs/TOiols8aGK78k49L43gMMLUOY=;
        b=GRwzftyU4AlegBbfpKtNxyuICtVy5CQVeMbu0mONXtns+vAIbwXr/DUpo8Q7LM5pv8
         PClFvu3pGg8eKq6a160ogEu4bh9daBLPFJTE+JTJiSxNNeQ2qNzvH0Fn6Cy9bKhCK+Ig
         FjYYwwQ0Z8Pgy69uAIclf0oHefvJ01uj5jBceM5pzFqIuREY1IO2Xaze6DSUA1px31/S
         jZ/cQaaNmW0sb8mUBfu2ajlUtbvSUWN9Xj0h3VDgP9hzaAynjX1aIc24p9ph+Vv57ngx
         XCtvMlR5MagV6QvZJWTsWf2asvWUy5rozhq512C+zE/csmWRlfaHxih3wsdzdf4w6jGv
         v96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229293; x=1707834093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGlgrXYQNRN/frivs/TOiols8aGK78k49L43gMMLUOY=;
        b=TA56mc1IKaqjlhCIBtj5aXbqy9njWtLvh3ITrx56HXrzO81lW33vdXOEMXPhLQxPM9
         rBBb5dRIaBAyRlVQTSFRpZtA695VTF5umna7N/AQp0GXUDD6tQyCOxe5lA6la+dZ+HIh
         lSb6yGE2Tn9manvG+SlMWEcFXU1+ACAFP6zeSiYARc+ppvlyFXAC1XfZFwpRl04dcNza
         2fZNH1HdNnwaWa6bda9pWHHEFcB6gpyELAIYlVql3eHlVnCBb9WqakdGZeUxCtygI/FI
         1/a8gHa95xdo+6hcpZ2NCbEU6iEUuXlmPsyDVDm+wZNym+6c+nYnoPcKxYQcG5tn7K3r
         zqMQ==
X-Gm-Message-State: AOJu0Yw07UN/J1urKMXecjGkX0sK7AaSC7NVhqpKq64kBP2o6z2jXJFu
	Ep3T1pAbz9DohoCsIcilm4zjG2Yrz3j98NPYjCbpfefWia4S3PF/3TYeBcy4OUMDFe3Oai0fZYf
	J+Ck/YeHxOjDeXrepVk9lahrXrKA=
X-Google-Smtp-Source: AGHT+IHG/rFkciYQXFtNDOoXB55bAp3RzgaNcKIAeGKLESHn7iapFoH4ux1efitneFzRoR1Cuoob2VGteH0EHqtVbVQ=
X-Received: by 2002:a17:907:1048:b0:a36:d1e1:71ec with SMTP id
 oy8-20020a170907104800b00a36d1e171ecmr1923897ejb.46.1707229293076; Tue, 06
 Feb 2024 06:21:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
 <20240206-iio-backend-v9-6-df66d159c000@analog.com> <CAHp75VeWV0+hqCoUb4YvfObnEAv0AaYJmXgpxJLfve+mBwhkyQ@mail.gmail.com>
In-Reply-To: <CAHp75VeWV0+hqCoUb4YvfObnEAv0AaYJmXgpxJLfve+mBwhkyQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Feb 2024 16:20:57 +0200
Message-ID: <CAHp75Ve=Utqb0rtuO9c7xkxqpasFgzj4x4d4mm-CHM=_XJUrrQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] iio: adc: ad9467: convert to backend framework
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 4:20=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Feb 6, 2024 at 12:08=E2=80=AFPM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:

...

> > -               .max_rate =3D 250000000UL,
>
> > -               .max_rate =3D 500000000UL,
>
> > -               .max_rate =3D 125000000UL,

Forget to comment that these might be preliminary converted to use
multipliers from units.h...

--=20
With Best Regards,
Andy Shevchenko

