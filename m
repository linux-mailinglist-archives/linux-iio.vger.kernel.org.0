Return-Path: <linux-iio+bounces-18526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89016A9742A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 20:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F27C07A9E4A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 18:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1A202F8F;
	Tue, 22 Apr 2025 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVZci9lv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4252013A26D
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745345081; cv=none; b=C+bbspasKSeSjPPeX3XZdOJzuCmtyHAxlbUb+ycxooYCgU5hG2c9cPfJAczPnsVB3AMkfOLQ/cvjQVIOYa0MmMcXFP+BdsPBErPOSJy5lpyHYdxHPuFn1kCEVZBRomq3Q2uuNUMsoH6CvmtFWgXhbM3VcbByD5dcp14mUAJYTpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745345081; c=relaxed/simple;
	bh=NTRFxksxespBRJMJewZpg3Fy87vhUzIx80XYdS1+Bnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPqkcmqFlj4vj9g0MvRn7klnmfSZnRq0OBxNX09yFSiF96I9u5Xdcj1rleETygDcAnO5t6A9kkMaSR5D/ZFEZcx1ADzMsVYpXvNDAi4m1EggSLzqn3DOIwnFCyD6m6nRmXfzoRR62OIt1goISqTR+gZrLiVf9+YBLYzy+ZWeALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVZci9lv; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so941960766b.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745345078; x=1745949878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTRFxksxespBRJMJewZpg3Fy87vhUzIx80XYdS1+Bnc=;
        b=MVZci9lvmL3m/Xw5okh9N78+DzSYpzRHnSLwQKiAjEgbyWpTJ4vIdpyFuKuqVPmDzt
         y6vxCpI1q8w5sgRQ/V0V6JFYdoPIOSs3IJ22HK9/uejBH50qnSnZlhPv7G7x5PhRtxAs
         BlMYIzuqpTWXHIWlvu6cEmtDg1hGwqqjugdd9NZlOEa1dGuwFs/f20/CllyWFAauVdy+
         lXuFEt7EP4P/Dyp6mJe4ulPya/LVM/8yscQ9JJyXl3i958OBJuylHiEPkDUoWw8rZU3g
         VLafvawDhfYPV2tAWoqSsV9JbR8g6Kcw1Xc0WQdbzs5MbS8YNjFpHPOYoSjXD0pkw2ZK
         ovhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745345078; x=1745949878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTRFxksxespBRJMJewZpg3Fy87vhUzIx80XYdS1+Bnc=;
        b=t8gQCPiEc6IT7rDiovbzZaYpzDVLnAZqftL9EZHLC2DO+T8gppVoHVQfsNy8zLzTj3
         1jxnVpgT0SOuLJBq9llAcGYCBlcjRZubrhqhhRZyDT3TtaRRrp9+eO9dz7S4gcDRoLqy
         0nIEL1T3FeM17iq1BLhWL+03ayDyWwqWUKiZ/XKALu+zKAQcl2pqOzX9XtjCKgFeOz6Y
         qifjwYP/zc+YgqDGUdrZ9+CMm8DIcb3ZHug2npHkDYJtabqt9gff9yqu6XHVrY58ehva
         gShjoI1f6IvJS0T30v39bFSdbpNSh+ey6lKFfuEzbYSoNEtOyJinoCvTeRgBzIU11x5d
         AaZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUI7KVsnJFmfvE2Mqoq+MeF7Y+dvVxZMFRsxS/PFqTxqZkXPbixl3i1JQ1y7lUfNL6XsKXYTZGsv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgAqox7W+NVwAidLaCtv2viAmVzNGItIUQUMojyRFOLJb0Ykj4
	Hba8qZlnRqljruo0is5RhkBVjm+k7pDf4H121mzqzy/I0CByNlUm8DOfg1hMT36ExsBAWUOSKKy
	LY+Shsq7SyOr4zO+Eab0R1p110Ov0ROvD9Fsjww==
X-Gm-Gg: ASbGncuS4qA30Wl3N6ntTPiXH2dt++1AGS+fsY/lvXDs4MedS78zqckeBpe5eSG/jrd
	+9qZQ2xsR/b6qbUzzlXTr6lWYFFs9YhQn8p6ISm3FTaoi604Cq8lZm100Jv7yNx3qUVEs38A3qJ
	/VCuOIZxBtRkOUUns2Q948
X-Google-Smtp-Source: AGHT+IFbw8mR0Gs6uIKRwyHI5tUnQCUZGIxJMTpzhwSfoM+1ScFKOiZOczCk7/7b8GVcyPM/XfG3NQgQnJ3N72ySjrs=
X-Received: by 2002:a17:906:c143:b0:ac3:afb1:dee7 with SMTP id
 a640c23a62f3a-acb74b83f10mr1360435766b.28.1745345078181; Tue, 22 Apr 2025
 11:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419232316.36002-1-nattanferreira58@gmail.com>
 <c2golk6627ybfpw3t7lnerritq2yysi5zhdlvahnvhxoevmojn@j3d2stvivkyk> <20250420211706.GB5621@francesco-nb>
In-Reply-To: <20250420211706.GB5621@francesco-nb>
From: Nattan Ferreira <nattanferreira58@gmail.com>
Date: Tue, 22 Apr 2025 15:04:25 -0300
X-Gm-Features: ATxdqUEv_H3MfJfXx9DgFlGC8FqBlBpDANyU3Ns5o-hlRcjJm94WwoANkqvFBn8
Message-ID: <CAKj1jXr3pacMg-9DkUijiJH0e_YSB=NoWcS+DcOu-vzwSrAWDA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads1119: Prevent concurrent access during
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
	jic23@kernel.org, lucasantonio.santos@usp.br, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2025 at 6:17=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> On Sun, Apr 20, 2025 at 01:07:28PM -0300, Jo=C3=A3o Paulo Gon=C3=A7alves =
wrote:
> > > Use iio_device_claim_direct() to protect register access via debugfs
> > > from conflicting with buffered capture modes. This prevents data
> > > corruption and ensures correct device operation when users access
> > > registers while streaming data.
> > >
> >
> > but debugfs is meant to be used during development/integration,
> > where this probably is not an issue.
>
> Is even worth doing any such a change? I assume Jonathan will have an
> opinion on what's the expectation for an IIO driver.
>
> Nattan, can you explain why you need such a change? What is the use
> case?
>
> Francesco
>

Hi Francesco and Jo=C3=A3o,

Thanks for the feedback and your thoughts on this.

To clarify the use case: The primary reason for preventing both read
and write access when the buffer is active is to avoid potential data
corruption and inconsistencies. When the buffer is streaming data,
concurrent register access (either reading or writing) can lead to
unexpected behaviors, such as incorrect register values or misaligned
data. This can cause confusion and make it harder to debug or test the
driver, as well as introduce risks in production if these issues
persist unnoticed.

I understand that development and integration are critical stages, and
while it's tempting to allow register access for diagnostic purposes,
my concern is that even during this phase, uncoordinated access to
registers could result in misleading data, which could cascade into
errors or incorrect assumptions.

With that said, I do see the merit in Jo=C3=A3o=E2=80=99s suggestion to all=
ow read
access while blocking writes. If that aligns better with the IIO
driver expectations, I=E2=80=99m happy to update the patch accordingly.

Let me know your thoughts or if you think there=E2=80=99s a better approach=
 here.

Best regards,
Nattan Ferreira

