Return-Path: <linux-iio+bounces-2262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7004C84BB6C
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 17:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB1E2821CC
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 16:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3004A34;
	Tue,  6 Feb 2024 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWhar9yU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DB8F4E;
	Tue,  6 Feb 2024 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238344; cv=none; b=eSJUtbRC9VARQOMxIrLOIRdKnhIp22UiP3JqALuO5KKXDzzG2+TBo4EG3dl9cFDoDUXHqhXzANGB+s+rlm9AmWVmWbD4cswysFjWQUmGUoyFywpUcKUp0ZPMQIQKzoEKojTKAIJlTB71EN2OnPpj70/+inbgh+kBHKAenN/k9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238344; c=relaxed/simple;
	bh=4ThfSJ23r0wm4lNbZO0lgycZkt1nAW+7BwrOVPTbDBE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uN7JszAIh1xH7w8Y9ZxjJUWZWp0XnnH5ygZ0sd8rpxYU2dFmvk7sS1abSOzTNskJtZq84A6OAno+GNgWDIFZDT8svikP2D50ZCzwcFs+Xh2l8DR3ewUAhN+pZFPnlps4ol7IhlEJv4iOgN2LiEiTP3+aT9Avy1KU0aMEDY9QRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWhar9yU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b4b121e28so212743f8f.1;
        Tue, 06 Feb 2024 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707238341; x=1707843141; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ThfSJ23r0wm4lNbZO0lgycZkt1nAW+7BwrOVPTbDBE=;
        b=VWhar9yUMlsbkFn+X7g97aRpvCc55FtvV1KUuFlbTMMu3k3cskVom74RdHjSJ8y82v
         ZflLEq7wDNg7+wXDYGhgN7P2tO2t/ME6D9JZDE3/nfJ4r//YZoOKfNOEzC8alj3xp0ud
         FukIssMPGkSe+U6Q8cMeQjBk2q61vHIOOzWDDbYe+xpRW1gxUGSTh1B3QUawp2tboVdn
         Uk7YHRxAWX3gtvIQZaY9DXY999FQxew9IDrBloaf1Q0ENcl+nSVczf4dbwMxVhn6RS67
         P8jO/C94uzqQHLDBNB5OKB5YIO1nhg1DVQBN9yjKG9CkUsG0erVbR2gf10Y8nepWvbRn
         pTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707238341; x=1707843141;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ThfSJ23r0wm4lNbZO0lgycZkt1nAW+7BwrOVPTbDBE=;
        b=xDNwOGaisprL4+B0cSKEAncaSUUmOiCqXkEiPDW4I4NIlNHLx1NTCQknktGb2yhDU+
         duwKqlwnsOJNS4xCLdeNzjsV+R1mQJ1ahxHKpOudS89UnFcsM4DLTVORgEe9TVVTyY9o
         dpNtH7VT+B5hN17tfM2HpV+PviTNa/J5TLdg7dnAxzTgaI/7qLcxjvEQ+/oPe/GrZFPV
         mzDrVd/uDxiGMEAswf/60rK3ezpu8uES8CJzw+WLJu2s9wgf7mj0t1qKEzeFbDwNQI5/
         1h91PDX6N0Z6bcM1rsxjw1W2Hv3/unUnUCi9lLS2CkzvszWoXAJm/al7NxblARifXHW0
         4fOA==
X-Gm-Message-State: AOJu0YyS3mPNk3fUj9iwarWEkptbeCddxssgj26KLMR7mzWhfklAo25j
	+bK6gaAnz4asrLp0kuWF2s7O0LHpLPQJTSO529T+HGDyVKNdOLQN
X-Google-Smtp-Source: AGHT+IEppGmlHSNMpez09T7w3SnYVi/FFwtCTfZ4PEL0kkLxbruDjSinlgVGWX8XLB9umnoauTiluA==
X-Received: by 2002:a5d:6b89:0:b0:33b:481f:7e91 with SMTP id n9-20020a5d6b89000000b0033b481f7e91mr1665530wrx.39.1707238340719;
        Tue, 06 Feb 2024 08:52:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUrHXNuXP31e9r5KefZEkxdLDpNxwc/tGVNysnK4WHZ8RlSnxsfYHyOj4TZ0eFQaFEOg156AmX/BJL7CGOnlzoKvHrhinJjkY9JZr00bNQeQmQlhIaFIA2q06NAj0tQR7aut/ZSCsOxue4J7zbqtORqhezW4bKQ7s9TmgQ0BjLzV0aIhUuuc1Xfrp9nYGwMP6aEClLhibxM1qPdaCfiMNR6Cp912iidAmKuLl25uAJFzi2RnlOKgbcIlX14GrroUViVvQwLe1i0YLwVqzv8vOqNYcPylKJ9T/rD/QVOMljb8LED4rMRhB4i4GWCOC+FS0qsBTjuANv4BdudkhxCo4ZEPiRX8yOZ8WPl+RkCYBNf3agLUY0GXgEkZqGikKmesQ==
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id d16-20020adfe850000000b0033aeb0afa8fsm2517401wrn.39.2024.02.06.08.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:52:20 -0800 (PST)
Message-ID: <8d7d33a633f258389adba39930769d577a05cab2.camel@gmail.com>
Subject: Re: [PATCH v9 6/7] iio: adc: ad9467: convert to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Tue, 06 Feb 2024 17:52:20 +0100
In-Reply-To: <CAHp75Ve=Utqb0rtuO9c7xkxqpasFgzj4x4d4mm-CHM=_XJUrrQ@mail.gmail.com>
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
	 <20240206-iio-backend-v9-6-df66d159c000@analog.com>
	 <CAHp75VeWV0+hqCoUb4YvfObnEAv0AaYJmXgpxJLfve+mBwhkyQ@mail.gmail.com>
	 <CAHp75Ve=Utqb0rtuO9c7xkxqpasFgzj4x4d4mm-CHM=_XJUrrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 16:20 +0200, Andy Shevchenko wrote:
> On Tue, Feb 6, 2024 at 4:20=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Feb 6, 2024 at 12:08=E2=80=AFPM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> ...
>=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .max_rate =3D 250000000UL,
> >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .max_rate =3D 500000000UL,
> >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .max_rate =3D 125000000UL,
>=20
> Forget to comment that these might be preliminary converted to use
> multipliers from units.h...
>=20

Note this is just a conversion and I want to change the least possible. I c=
an do that
in a follow up patch.

- Nuno S=C3=A1

