Return-Path: <linux-iio+bounces-3218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56D786CBB0
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 15:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A601C20E2B
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8729313774C;
	Thu, 29 Feb 2024 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n1bSE8Ex"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3614EB5F
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217364; cv=none; b=sHX0twnHAZg4NXS/vwYi9r29PW/rgSI4hdInygLeGe257DmnvRudZI5S+YYxHNH15kSlyEyZwkIqU73Jlfg5t98elELARfoLUYkwL+0fjxuqOU0vYWAP7pssAtGts2wo33YCeDTS4XrRXEJtObY9yeS1ivXKX79QWmk/Y4Z1mqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217364; c=relaxed/simple;
	bh=u0JUBhjQ4sGb7MtY00JcSowml0hWIM4BZxLrLYwauig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHglIbvpli6IxmvYnilS0wtNp7uBkdqIfMuegg1YhICtc/zezSGOPyUwRhOEoVMwmqHkLbOGEYhlnQFYQEoee0Pol3VW5nvwIkMisu/hkyYUcI10u1bt+gtrYN41VCDY12j6902XccMuapDCwYwojaQAHMZ2NF8ehVmSWn8N+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n1bSE8Ex; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d28464c554so11202811fa.3
        for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 06:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709217359; x=1709822159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sz88iOY6NApYHzpIrcMwxyE6MowEg0Dpz6Nm6MlbMsA=;
        b=n1bSE8Ex0gTzYUbmetmN+kltXoAJj4bUW/nHi41qGUWt/uBRW9SMF8sMkIBcGq9ZbD
         Iamf0j06+t+jicwb1Gle+T6M/PrhVoYDTq5yCuCAmY3iQ+mDh6iLuu53V9fSzSZ8MogE
         mqFZa5kQPJ1KsZGVjpEoMdcw08uws5ToT3Lt46WFn+/eBqH7CIY0Re6oSrvBSW2fUB/Q
         Py+56nOteLTlYc/7L8nfAEoF2iXzb4Zxb9Y9FodVBgIGBfBsIjNdmTHktMCVb8E4dANa
         oTE4pyIlzVDujmB8WhDqT0bbUC490uIg7nxLVpw592RLZJzeapW68tK6R+LbWtLQynoz
         5DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709217359; x=1709822159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz88iOY6NApYHzpIrcMwxyE6MowEg0Dpz6Nm6MlbMsA=;
        b=Wxde7qxvonpKI+TgLRt2QHJ5HpPDo75q+UoaHdNZes29ekG6+V7laoCnTdWfXbGej0
         QGEfd8DcfnXTdVB4PYg3UxLXwRJ5hm2I15zT11HWV3PGKijwZZeXVqOxn4K6REqXmoQ3
         i9UjhRfUEItt7TAf8mKKBvbM2rU532oPc3BvW5A43zqwyyZRyZC4U8Rn4niecg/Xrzn7
         1floN7AqGo6OQdWIUSSm1vf29ABK5RJl2FUMS8Ek/kUrBI/A/YlJqsAGRcylbLNVNCjj
         htny3MQkQjMEnKvyfjDCXtCTx81WLPzg0k68ivoQ4yrQNG+jy8tA5SvVBaxJ1S+z4HAM
         DGIw==
X-Gm-Message-State: AOJu0YygnV28P9W6eAJ8wNIfuTJSKw1ASQ/XDl8Iku4cXFIrOlTZ+Fp1
	dfWQq5yPFLCz3BKGi+fZM9HdIYBJ+glsEmelciNvPdk01yqt8R1j5Z50zBC2idz4BLhR6g1CZbg
	+b/6eZ4a49BDvzqB6Xc7YBRu7PoiAQXhA8ky6lg==
X-Google-Smtp-Source: AGHT+IGHaNP/H4vHZKJ4y6B0kLqYob2bOrCNEIsNueH3s9653/jhA47m7OSjPlN4MpQUmkuqNouzzi7ynvk1S67YLaI=
X-Received: by 2002:a2e:7218:0:b0:2d2:d0ba:2586 with SMTP id
 n24-20020a2e7218000000b002d2d0ba2586mr1517275ljc.24.1709217359043; Thu, 29
 Feb 2024 06:35:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-ad7944-mainline-v3-0-781b922334af@baylibre.com>
 <20240228-ad7944-mainline-v3-1-781b922334af@baylibre.com> <06235b66-6948-49b3-b881-198443a421df@linaro.org>
In-Reply-To: <06235b66-6948-49b3-b881-198443a421df@linaro.org>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 29 Feb 2024 08:35:47 -0600
Message-ID: <CAMknhBHhrNc-6qggSD1pt8djc9cv93dyNON8c_np6RwqT3yzig@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add ad7944 ADCs
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:40=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/02/2024 19:10, David Lechner wrote:
> > This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, an=
d
> > AD7986 ADCs.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 213 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   8 +
> >  2 files changed, 221 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> > new file mode 100644
> > index 000000000000..2564ef4f58cc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> > @@ -0,0 +1,213 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> >
> > v2 changes:
> > - Removed default 'multi' value from adi,spi-mode property. This simpli=
fies
> >   things a bit by not having to check for two possible conditions (abse=
nce of
> >   property or explicit default value). Now, only absence of property is=
 valid to
> >   indicate the default mode. Constraints that depend on this property a=
re
> >   updated accordingly.
> > - Fixed spelling of 'conventional'.
> > - Expanded description to call out potential confusion of '3-wire' mode=
 being
> >   unrelated to the standard spi-3wire property.
> > - Added standard '#daisy-chained-devices' property for chain mode.
> > - Relaxed requirement of cnv-gpios since it was determined that an acti=
ve high
> >   CS could actually be used in chain mode.
>
> ? Please don't edit patches manually... Use git or git+b4. Or quilt?
>
> Best regards,
> Krzysztof
>

Oh geez, yeah really dumb mistake. Will resend. I do use b4 but it
doesn't handle per-patch changelogs that I know of.

