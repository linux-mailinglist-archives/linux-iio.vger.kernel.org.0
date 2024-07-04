Return-Path: <linux-iio+bounces-7290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7275F9270C2
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A60D1F24BEB
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 07:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E1C1A2546;
	Thu,  4 Jul 2024 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvjEPDNt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0931195395;
	Thu,  4 Jul 2024 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078778; cv=none; b=e84LIHSmdVWLgGi9nZX0SFpC/fvBpwptGSrksPNWPhUQ/vZ/XKFyR/zPADgrGIGu76Mxx6CEihBKhyoR6r6RcDj1/16cU831r2fOWT8+YbYIl35ITdGqmrTZgabr+XPEVsR7vBlBbixoXWTegXtXtBRe4DNG69gEQ75aynuK6To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078778; c=relaxed/simple;
	bh=sH1ULTf0dpBYABTaExBv0LmCvOgNVkAEiLcvBN/Xt4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDtCantyyEHmReJL/k8YS9UqwSW07PiNLrP3uYep1dy0mjoAvmdMaCRGxt4UuekVDtPtQd8J5M3G96X4IFe0q0oKrrqRHOJfQ2uAvCBxxGCFvAw1C9FAzi3UmgrLP2n4QfdTlTfEygf+qRYtkXiOtJOBEMJiyvItRMfnylI9XhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvjEPDNt; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-36798e62aeeso219299f8f.1;
        Thu, 04 Jul 2024 00:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720078775; x=1720683575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud8q8tEe5YtJOR70f54uhrUy07klpZD5lmdiCHaTMLo=;
        b=DvjEPDNt66h6BleLJzIthlkgSBbkWtoY1PqngU2kVidXJA+cBfV2/noUatWivVZb7x
         JHUXLULMphsgWf+2FTPWJn2BfzGxXqPokFruf5kjvIlOFtyAv/pT81mvPhkJvN+LsCHo
         nV17Rep6SYqsdM4IAGPxesjDYv4tgtlF4xlKCy+uBmTNwoSTn2Z9fWRC6NzSURwidDSp
         vC2AcggB4//OMLHLuaI5kfqs3SuqL3JKIcfJxVvWU6I9KdWVwjVz3UEg4HsGbCyjV4jR
         hn2O0CCADiKQqoLXTfvNQ/xMLbhK5+GZ0C7SQ2muu3wxDj4TBCoAZXlwP59kA83gfzBV
         6Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720078775; x=1720683575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ud8q8tEe5YtJOR70f54uhrUy07klpZD5lmdiCHaTMLo=;
        b=YE6yGOD4iMzz6tu1z7zjvKgy9jLEfw8R5RKj75i95Dk0oFjhtM1E6mRVVsgnU2kMNN
         ePWgn4v9+QMgstq+OM7y/u6yfs1jqPK8XrnlXBzGxgjarN9w6HU0oeVASvijtsnGmYky
         7kP/jlNWqNp2HPrmLoAlf+vvnnC7KgXiY+wy5YdV3CVdgS4Za10zgFd0TANyuFBPcRzJ
         XTubUOOxyon+mc2ojot8wzwhRFcZEvj5TZAbdwb+7a9JJIm2gM2feGtPgXRiteVSBRbg
         b8NSTL6mjnUl9ofQiiUDf1iqnFY1R6uYz2bt3cmk4Y/FXCM2rEDUX4eKYCDTQYhFvhBY
         L2kw==
X-Forwarded-Encrypted: i=1; AJvYcCURbDZ8DJI2Bmo0TmDxv7v+CU4B5N/+IyWASXzSy97p/Sny8Y10w0eg+gXNnmKlYGmQqkcpnrc0jB/bLecqGXupfwry1MBV39uQUqxcA6HX7w5m9p6m74RxqvMPdXsxGUq9+QB/A++meg==
X-Gm-Message-State: AOJu0Yxe2ACuNwJiUblmr4Cxshrp7thQvOdgcjbbkI8w1KXPQyfVPrrB
	9xnDTewvQ3FX1NCLxNUiz0sx44Nvp9iGHFPlbI/vulTZU0+H1oonn8uJ579wK6ppLoS29D4rggb
	tRJljsLaUGtX9MO5Jzn/XhOcWTXA=
X-Google-Smtp-Source: AGHT+IHPyreorZod622o7grhoTIcWg9YvTN6bsC8lmqvqqPxkVLCIbpIHjCaLNrwMsg0Znq04jF9qE46pLJuWilgu9E=
X-Received: by 2002:a5d:5915:0:b0:367:9b8b:5365 with SMTP id
 ffacd0b85a97d-3679dd5460bmr619359f8f.35.1720078774768; Thu, 04 Jul 2024
 00:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
 <20240702-mainline_sdp500-v3-3-0902047b3eee@gmail.com> <5cfb4e36-545f-4d17-9b06-c18cdae9f0c0@linaro.org>
In-Reply-To: <5cfb4e36-545f-4d17-9b06-c18cdae9f0c0@linaro.org>
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Thu, 4 Jul 2024 09:39:24 +0200
Message-ID: <CADFWO8HCbzRY++tjBxE1SudEJi7UO0aOmpsJRub-3ogieuu1XQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] MAINTAINERS: Add Sensirion SDP500
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 5:15=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/07/2024 16:59, Petar Stoykov via B4 Relay wrote:
> > From: Petar Stoykov <pd.pstoykov@gmail.com>
> >
> > Add myself as a maintainer for Sensirion SDP500 pressure sensor driver
> >
> > Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 40c754b4c39c..65f9479ac343 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19533,6 +19533,12 @@ S:   Maintained
> >  F:   Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.ya=
ml
> >  F:   drivers/iio/chemical/scd4x.c
> >
> > +SENSIRION SDP500 DIFFERENTIAL PRESSURE SENSOR DRIVER
> > +M:   Petar Stoykov <petar.stoykov@prodrive-technologies.com>
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/iio/pressure/sdp500.yaml
>
> There is no such file.

Ops, I forgot to update both references to the file after it got renamed.
Here and in the bindings file.

>
> Best regards,
> Krzysztof
>

