Return-Path: <linux-iio+bounces-2406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A116D850A61
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 17:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB6EB217B5
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23EE5C600;
	Sun, 11 Feb 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0uZ+ANg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC922837D;
	Sun, 11 Feb 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707670577; cv=none; b=Du/4XgU9XayoUoB0uBm1hsHG0s2xh+XdufCbWxbaMZHJ4wNRhian8WCsitF/uNKbESJG658/n6x4qwbHoQuBXDuyeSjxKphbeTTboFU3hi5MVBAYXBcrQ/6RzPF8eafmU2Ph9e7lZELDKaS6ETcVojE+AlE2+ZSDRnQbJC3WTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707670577; c=relaxed/simple;
	bh=Ej/ihYp4hY5itSE1AZa3yPJGr+/JNb56ykWgA89PrxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NC8+seYVv6PblyPNq3kI2LstfX1bvX3qPPP9azvYlZFHmIO6GLFxGl1fu5SmKHuA92v48fL9w9S2RW4oWgTJZPCwYA2rVDtK94a9VfnR8eoDl7C8v1DXyAMKnJPk9YxuxbsjZg7Zdc2anqEeT++9NGtz+LmaCDpWUmjlHhyGOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0uZ+ANg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26fa294e56so338820266b.0;
        Sun, 11 Feb 2024 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707670574; x=1708275374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOid1dOmZ3lOaF/xchE0MoTEIX4i3h4QJTK0bTlOVRo=;
        b=i0uZ+ANg6qAio4dhZY5mRbpFgmrLPJHjf8AolIgkfxTFsIYVV6tC4vbeCIaJOZj5AO
         1Zw3tETONvA4WKet5d7A1k5lOiBO+AyKPiR1+J5XQ20gyX/NHHZVkKE+b+juiHSVz1dZ
         Fo2PcTQj6j8FBdRBjcFii6kerZePfr72eNRe4vNmXtjznhZXjDB1MbwgbpQlSW8uGANK
         DZGISDcyLdtbPWoLmYp7svcATAZogUAjLH9+03sct+BcvZZHRsiTebZp3enmHsKPzebs
         JkGziwLvrOYRjSL7tCgEzUK3yDHSBF8jcy8gwrqtrrYYlsadQelJRWptJwHrkD0Q95vG
         lxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707670574; x=1708275374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOid1dOmZ3lOaF/xchE0MoTEIX4i3h4QJTK0bTlOVRo=;
        b=NugzN5elCQNPAkGBEO/tS3L8l1D8QcwVFkLoKOt6zpQpa7DsxhYWSxG3T/BOWHnVuL
         vJlxDF2+XbsgY4+DFl7UHMTYuvUCoS4NgrE8Ojj2VK3hnQMxdwuGHpFpuilsqxZ3Ys7E
         188lL/wKDH/MSGP6NwDe1zH4Y2p/tfa3wIo8P1nS4hRtUzzp26V2CZtnYFTG56OSQ6eF
         KC1MbNw9iMPVx//HGVv4ubdY5FjRHnRspkFWWjT9pzoFjj3rehReZUd96otVAqtRclA6
         FtS/6XfhQ7Nh7AbTyGi8Qx4cIG4gK7lSgKfyplugyAzfTK0PbplTEJ9qpiWo/RV4fepA
         VS4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBZk94l6NZBi4jHWA0t7E7Vf1egbzkrI/TBR3v1QmOZuZ54C76Fhv2XRfHiWkN1rZVtmfu1DC5ZDm/scEc8rtrpLH1ykMdGEPxbQ==
X-Gm-Message-State: AOJu0YwgqKEU9xG0RANLmeQycToogjb2EgRD9fFJaJFRg789rbfKQ9Re
	naS3CkE/ZFYY/dKQKZSJj+7oCFiHyC8Wxxhzcgh6qlr09ysk7xfX8IhSK/EXuxlq3aXSsAvgfpH
	+OWs3pXvtVyTEQ8tgh+4Ygbn26yM=
X-Google-Smtp-Source: AGHT+IFt0BqKGQzFmfhedpOjhcAxm8Y9ssForkMZBUlza2Xw8PC5ZM6eNYkJew/Iw8/+Tw9AiQcAv1h/RZstaevVgh8=
X-Received: by 2002:a17:906:2b46:b0:a3b:41ab:e62 with SMTP id
 b6-20020a1709062b4600b00a3b41ab0e62mr3958420ejg.26.1707670574233; Sun, 11 Feb
 2024 08:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
In-Reply-To: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 11 Feb 2024 18:55:38 +0200
Message-ID: <CAHp75VeYbZsfUi+VMMqJUXf6t18H0jY7Sh1tBCsUqxihkoBhoA@mail.gmail.com>
Subject: Re: [PATCH v11 0/7] iio: add new backend framework
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 10:57=E2=80=AFPM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:

> Changes in v11:
>  - Patch 6
>    * Directly use dev in devm_iio_backend_get();
>    * Move comment above the proper place.
>  - Patch 7
>    * Added blank line between includes (to logically separate them);
>    * Move back to 10 millisecond sleep;
>    * Constify expected_ver and removed unneeded cast.

Assuming that the fwnode vs. device reference count is fine (as we
expect the backends to call respective APIs and hence have backend
device pointer valid despote fwnode reference being dropped before
getting the device) and timeout thingy had been reverted to the
original value, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for patches 4-7 (OF is not my area of interest at all :).

> Jonathan, the series is based on next-20240202 since it already includes
> the io-channels fix Rob applied in his tree. I guess it should land in rc=
3 so
> after you rebase, all patches should apply cleanly (if applying them of c=
ourse
> :)). Let me know if anything fails...
>
> Keeping the block diagram  so we don't have to follow links
> to check one of the typical setups.
>
>                                            ------------------------------=
-------------------------
>  ------------------                        | -----------         --------=
----      -------  FPGA |
>  |     ADC        |------------------------| | AXI ADC |---------| DMA CO=
RE |------| RAM |       |
>  | (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|---------|       =
   |------|     |       |
>  |                |------------------------| -----------         --------=
----      -------       |
>  ------------------                        ------------------------------=
-------------------------


--=20
With Best Regards,
Andy Shevchenko

