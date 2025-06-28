Return-Path: <linux-iio+bounces-21093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CCCAECA5A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 23:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FCB3A31C9
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E7E246BDE;
	Sat, 28 Jun 2025 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9C8acx1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66B1854;
	Sat, 28 Jun 2025 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751145084; cv=none; b=B/dfyajarV0KZNztkYXmqGN78FmQFOivW/s4WWfCVfugsp4f3fZi5znVMleev84YktUHzYKZnqLpSx6ziojPwc3RTckuL9H3m2ZBz4GdEPyhD7xaTibCAmdVS8vkHoiG7/x1SW4oC1YczLU3eLbkK80U6G9oQR94yfWyk/dedwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751145084; c=relaxed/simple;
	bh=K5lOL5R+pMRvani4cANrVeMbRi59BKZl5QLUHLJeD4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVW4nL8be6sMy2ByBDUfGiP9gLWW1fJ6dvxV1XHRAgq5Ag8TCw63cpR5QYMVT1H6TNjea/WwOHjEjdvWd27Iu+4yTxmiaHFVU/aX7M8eaA4lx3OnTWut+/rF0hT0xQd01fIph2d+c+GMwKPVBeWU95ozwlw1tujCmqcryonWSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9C8acx1; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e840ff8d8d7so170635276.1;
        Sat, 28 Jun 2025 14:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751145080; x=1751749880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg2ZN4x/jiYpxSvViT0rI/By5pMyua8QKrH6UGvMF7o=;
        b=h9C8acx1VDiIRw/mUiDkHd1DYaGfyuVo5VhKgJMzkumC8i6q5dpQsBuC7o5X5ESfDJ
         GXRUQwCvnOnPyGsjN3a9G5mIfSaaJqAxK2LychJed06qDJfG74T/Mfrsp/KyinA4RkHW
         /4Q18wtU2gzaaQnvlTjzmEm5FszKqIbQRyQcgiQGxUVbZvWA26VSMf/nbcgk71EiEef5
         vzxlhZMwbmklIdaMpnCkZSft9meM3wcS+z8k4cciiHhUDOhy7aTOpaZXdWR28QRv//xR
         5yEIixuDGQ6CgGdWdMwMDxfAtHER4Njn/VersElFqfprbk6FOCIpIghcC8XuaHDcJJt3
         DcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751145080; x=1751749880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg2ZN4x/jiYpxSvViT0rI/By5pMyua8QKrH6UGvMF7o=;
        b=djWp4ylJ+m5uO8/ABTHmftCVWbMsZUaP9j9/e2kPMSmXdkKG00TbnOyTyKHm/hXiDu
         EBwO6V9Q27GmBxWuyl2i4UhWJN0B9HgO6f40Axm+voaEhCxhzJvoldGeBzcYpRWz7hI2
         EYmQTEyIWLZaQKJv9PbHpxXClH4dr07uBM3X3qAf/6gac646dHslywNXshL4fVO3J9y6
         5b9o6m0d8xRmYIKBqZdpTFzj4pOUjvbKKJsAspwMeQRTNCBBhiEDhrR92IsV5av/A6EO
         VRoQReKtYSPZcY+gEq8UdmBG9FDfwNr8S1jnU3QpZi3+us53cREPd9A5cUaHgdkRqI5B
         /MiA==
X-Forwarded-Encrypted: i=1; AJvYcCVHjggfnc2fL7A5RzxUNZRFOn0oi/JsrnB+DytB3n7JwU2y8Q3eB/k8/Kl8vPWhdvIbUP9psfTthsJHm/f5@vger.kernel.org, AJvYcCVY5z2ihEyfu781/p05JcZOQ0+t09/OHLcmgDRNlWvqLF3wB8BNClv2+qPopw5qC4aG7QdZlM1vBYw=@vger.kernel.org, AJvYcCXdM78AXLU/B5jTXRhVe4SfQMZRaYVpXGU2PWuxopVOc8kN18fW/+yyQ0NMx5jBr0u88vECfZRA0KWq@vger.kernel.org
X-Gm-Message-State: AOJu0YzKFhtyyrUapc4LBtLI8XC2+Ba4f40jyvDaQE2ecIKCDRN41nbn
	DzKbujQvcMEDmZmHzF6UI5/3mu4VhZ49yFnvGlws941fphl+hzQDovWijFYSGhv48hRq0qKHJby
	+AXScq+kGWNCG/lEasJRmRZGwvNpQS+E=
X-Gm-Gg: ASbGncs1HpZs8JFflfC+ePkAkap5RL3u+eXR/OmZwsdv+5pXRB4MHst/6Etyuz5Ecy1
	h47dznQC7sAsM3NAtFh8pPgK+YiyoNPN61ipc6xZLK0EeB7cK92rupXlDLczwljSiNjalJxenYk
	PBdLojKBY8xyx0hTDxUwYFsUYw8M9wnzsj/pslhYFRdZw=
X-Google-Smtp-Source: AGHT+IHTUCGAoH63GNLK/MPuTMrLTXnWs1MVm745M9pYQVSTlRlKIRjDAN9Q4WMwdtG2YrOyGFwqMh08Ucjwfpk43Qo=
X-Received: by 2002:a05:690c:74c7:b0:711:7256:54c2 with SMTP id
 00721157ae682-71523ccf032mr23088097b3.5.1751145080578; Sat, 28 Jun 2025
 14:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622155010.164451-1-l.rubusch@gmail.com> <20250622155010.164451-5-l.rubusch@gmail.com>
 <aFkh-E1dG__p_G4m@smile.fi.intel.com> <20250628170839.482a3d63@jic23-huawei>
In-Reply-To: <20250628170839.482a3d63@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 28 Jun 2025 23:10:44 +0200
X-Gm-Features: Ac12FXzDfEya4tHe5BQ4CX4SgP5_iICg3xqcWHJseES0YJdR7UNgNanLqvpVn8I
Message-ID: <CAFXKEHZ7bNuy+6X4NgPPMOsT3AkSXhacH=3HS33bLTNgYa3PWg@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] iio: accel: adxl345: add inactivity feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan, Andy and the ML,
Thank you both for the review and feedback. I'll prepare another
version for the 313 and the 345.

On Sat, Jun 28, 2025 at 6:08=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
>
> > ...
> >
> > > +   case ADXL345_INACTIVITY:
> > > +           axis_ctrl =3D ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
> > > +                           ADXL345_INACT_Z_EN;
> >
> > Consider
> >               axis_ctrl =3D
> >                       ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN | ADXL345=
_INACT_Z_EN;
> >
> > (yes, I see that it's longer than 80, but it might worth doing it for t=
he sake of
> >  consistency with the previous suggestion).
> Hmm. I'd go longer rather than do that just because it looks really ugly.
>
>                 axis_ctrl =3D ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN | A=
DXL345_INACT_Z_EN;
>
> I don't care that much as long as long lines are justified by readability=
. Here
> I think either Andy's suggestion or the all on one line are justified.
>
> Tomorrow I may have a different view :(
>

As I=E2=80=99ve seen quite a bit of discussion around this. In fact, using
binary OR here might not even be necessary, since I can define
ADXL345_ACT_XYZ_EN and ADXL345_INACT_XYZ_EN directly and OR the fields
in the header. If you have no objections, I=E2=80=99ll likely prepare this
change for the next version.

Best,
L

