Return-Path: <linux-iio+bounces-26522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF5C8F782
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 17:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF2F3AC5C9
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 16:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B056337115;
	Thu, 27 Nov 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILUboCil"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB1F2C235D
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259990; cv=none; b=BoUzKGs9a9m+RbHAiTO0LiKaSF8MO3DOy9DFmv6aeVZTWx2/iRqWQLkBWo91TSVcrBcd7D7MFe8GA/StrNBaTTRNG7V+LLZ20UHixAu7Je+vbGyDcVgKo0NGuIwRz7gDSuMHodzlcBf4Up52FsY2jLs8wQF5SNXBZ3paIohUTMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259990; c=relaxed/simple;
	bh=vHkgE8J7FmhstuADR1oxca5gWYlZxfEf1EiRPemtMDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1zI2IcsV+vDm1XeeQZRR6MDC6kaq9E3l7OJF47sLEqhr16oloxk91Ugh+UU4S7WewTMOz57w8dTi5JWZQqiVQ5456l4iEXz9mWF2XwpsfhFW5sF1KhWRDRFPaPRBUQY9wNeBShukSrk4PbgYu6KE/PINrtqhqwyrHGNmkW38No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILUboCil; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b735487129fso147398466b.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 08:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764259986; x=1764864786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHkgE8J7FmhstuADR1oxca5gWYlZxfEf1EiRPemtMDo=;
        b=ILUboCilhRu7W2l5uL+twL13aTtqP0MhjgKRRx2EMIflWnKm2tTIgbXCp9YjNKx4uu
         UsKxTeNgyxoxqMXz3Cf64Of7brK0+IiX8CjgvisY2mcFDpRTG2JO2Le9mJDH3klbrY5N
         C/OCOysbYHIDDRPNHlyvUxA0eu+ypLJ3qSI0cw3KEbK3SzDI9oRyX9AvAq4QGNRy+d0K
         A1XUYALNm8gGVaBIqY93OILPgJ06q2xrQDn/ZR5NDnlmBPM2gk+t8BFZQI3+vNP+GF+B
         LdNWFf+5jS1NyT8YJ4G6rJmQd1u6PAQeU5jrjouOzp+aQCxDSNr8Q9J9Nj42mPRCY+rn
         HFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764259986; x=1764864786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vHkgE8J7FmhstuADR1oxca5gWYlZxfEf1EiRPemtMDo=;
        b=DReaW60lrGoj/AToqzpXVSQZas1oXJ0ZbPTKpeKlL/DpK3FX81P/yP/GArsh6Kch9y
         D7PwtO1OCjvFy2807+x3KWr2bDPoeUNFtxdopuh+MlEn5TVc/9mytwiNYV7w0N1/qPXh
         VXWwLfvVWTZFsUI7L3515mWPpOynEYQEebGJaqXGBM2zNPEErqQUQnKfeomnjahzgSpk
         B27/hLFwErFzVD/+ZK++QPQCiwq0QyIa7cCmIHPHGJS3l6RfR15P4OoIqQInbw1M3NFb
         S2PjZeGDIdFf/UJ/tEVk5c90Kj+wkiAfA8/rPBzQjDYe5gxkHuexKn9J3RgopQiPJML/
         jJpg==
X-Forwarded-Encrypted: i=1; AJvYcCWS7UsUNx8YUBFYS+wbTGJcfl2ai8lWjUjh42Eo0lptbXKTvBUnQ/wg91TYWWy+aPluaAI0h92oS9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFABZlWLCRl4d6ytDlz5rxGQZx37ctTSpPXIJL+OWSNsh5GQXh
	00FSCdss2q6RNghH9KtIEkTWf0cL7b9tUUUB5ITPzsMJec/FJucFi4ojy4sv6AoI3uUWr3SmIBk
	Xy51EQS2LPPNINYbXo0Oq/lCllP2xAEo=
X-Gm-Gg: ASbGnctR/3VrsBQ0qbGun4Z7ii7LujQ7DwSjPfqY0+KkJW9A6RXoe1Rz/sJxZ0Dm72H
	3dgf8mJoEtrG2mZh6qjfD8zxw8Jf2PCpkuCF4ZtO8BIjIB/p7NUWvYuGGQ6XFBe7FaTx5Acwl0s
	LNiv0f+LtdLLqfXfs3i6l4QqyLhugz/XhLg2C16D4ifjYJGcPSNPiuLxDL5rvf9sz9ADZHUwLj9
	vHNWuHJxWK/WhXusNcFAdhdlVyJazKpg0tzn4dJltPSdiGS19iLLmN1pMd4kRCwhKn1NNFjJSOC
	MxUBTlwuS3H9Hmuc3Jul1S0EInS4sxZVpWZAsmxW+gBoGhT6dacVZOOfCak4FWrH/54fJqQ=
X-Google-Smtp-Source: AGHT+IHL5lD9l+Hh164xtP764PC1ElejfIHOpAawihP6o7z5n7+TtXrvPC3UUFXr2PXT/YoRMV/DR5xhbgT7VKwIfhk=
X-Received: by 2002:a17:907:d05:b0:b73:7ca6:220d with SMTP id
 a640c23a62f3a-b7671a4728bmr2613030766b.59.1764259985521; Thu, 27 Nov 2025
 08:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com> <20251127155452.42660-3-dev-josejavier.rodriguez@duagon.com>
In-Reply-To: <20251127155452.42660-3-dev-josejavier.rodriguez@duagon.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 27 Nov 2025 18:12:29 +0200
X-Gm-Features: AWmQ_bl-vjVNPE1-lBZUlM8SQoQAsmh5XSIjD1Lm2LJMWJiupqb_fmgKaxReBWs
Message-ID: <CAHp75VfhM5GuYY1qUKgBhePDo4oe5k3K1ZDTPbYJNr5NtjVVfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mcb: Remove MODULE_ALIAS from all mcb client drivers
To: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Cc: linus.walleij@linaro.org, brgl@kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, morbidrsa@gmail.com, 
	jth@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net, nathan@kernel.org, 
	nsc@kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 5:56=E2=80=AFPM Jose Javier Rodriguez Barbarin
<dev-josejavier.rodriguez@duagon.com> wrote:
>
> MODULE_ALIAS information is no longer needed as now all mcb client
> drivers are reporting such information through MODULE_DEVICE_TABLE.

While this is not a big change, I still would recommend to split on
per-driver basis, and with pushing the first one as kinda a fix after
v6.19-rc1 (to v6.19-rcX) allows other maintainers to apply the rest on
driver-basis. This helps everybody I assume.


--=20
With Best Regards,
Andy Shevchenko

