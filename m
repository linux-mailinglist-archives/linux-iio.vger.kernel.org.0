Return-Path: <linux-iio+bounces-27373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7122CDFF7B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D002302412B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EC5314B73;
	Sat, 27 Dec 2025 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWFjX2z7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4D189F20
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766854142; cv=none; b=U17uK/eROe9LZ8Tbhcy/VdrHO/rDi7IZCDWpQdvb5gk/uqc2leC9Ot7vFAIKMVlII3So78PevmbD4zJX3xxU1jeplRLL4MxCWrKJXJlyHGecASeqHK3u4ljQm7fTxf286kVB1++ehYophA1ZTEj/NqsCG+QKeqGIUN41pMOVXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766854142; c=relaxed/simple;
	bh=TNRVqW3gjSFfe9X1NbMKmJOoDl92rJ20qVC9LfsL7Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTUiGh2KeZsYh1uxqtE3HAWc/M6xlt67PVVPL/c/FfLD1ruBeeWgmg42WERQPhaGik3zWg5T2J2sd1kW4YXtvKzp3w4QGb1TXljtWg8puLYZ+/mYDbukPLnu9IKe85eE2RErd/gTDkYrcPVdHh1jzrxVe9RPLwOOgEnWtguBFw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWFjX2z7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7a6e56193cso1283446666b.3
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 08:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766854138; x=1767458938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK4n1sdp7HuObNdMW+Zm6wjkLkjxMECcZnXBrtHk700=;
        b=NWFjX2z7dqtRE0RPZmcYvaMGJxOrCfVANUMkj5ohC1eaA2HpDxLA1anYKBWer2sLEG
         1+nZKKtvrhWA9Zq1SqVICsB8nIoAZzPyxD56+TjySq1hyCDX6Uvze4CJzQcro7q4Jnor
         NCdFHZ6t+u+B8Q5Mct/ssUPAvIZWLpoh+2ViAPaY79mb1SCKkG8iUotiXZS1y/IrfTD0
         iNegIBm28nqx1JOyh67XAZUJbQa98t/551y138Q6qI894c6yHvfuo74Lxqx2hF8fsfht
         zLFlHtA0GtOd414DgWRNliItwCwp/yt0m8Uz3BL9sCN/49yDR9JBk7xsn79FYX6XrSHs
         HMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766854138; x=1767458938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rK4n1sdp7HuObNdMW+Zm6wjkLkjxMECcZnXBrtHk700=;
        b=vKRi/1EYxzGFZ+QB+lh1yeibUCrJunvjKbEQC//mkNAdLphe3QsV6qtSabIhKuP2H4
         Uucu6F58i8VJcbj+fcO6OsWXOrT0kfU1HGTuRHLW1eM/5Fakh+NDf8Z1o0l1/NU0o2wM
         nzpdRhsGLsfntmohZR7cOubpT/+TasqrmOTwuOBDhyXTtlDTg1Jqku0HNbhGtaN18DRa
         OXwSrYNezwgl3lVzWvqdvTyBVv0I90fQp2mQU/hX+LQINhO8uQqNag6ToX63p8oJhiHx
         o/6Pp/5osvqeLlJ+Efq5sy4uQGzKCHjKhs28A0TQhTlBn87hDuiYOGmnrMtanF7Wzrh+
         UQoA==
X-Forwarded-Encrypted: i=1; AJvYcCXO8h4IKkKxEDlln8lRco7mOcPAjUXCUlTIFGb7MrwLh5IYHjZYkPsPR6OUQCbXq7b5wVZbu4reHwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmuspXxOvRLwGAC3GJg05hgQgAUAlHz1WVkvhYYicaZ0BhZF/v
	Xht2VhpKtnVDK5owGThuJttichVhIpD6/yTiJDUN/mLCtNQJirX/SHIyRPoEaLRDFdhR5q7VAmY
	nnchUHaMNF1GqDMnrI0OPTWj4DQM0NxE=
X-Gm-Gg: AY/fxX5zkdLKE69cj9HM38XZwJ+pCVmb9RKUZwcltnc+WDetSvz5clBPOrpfE7/xzU0
	lb4T6AmrQHC5RxDCxTVo0MYYhfKVJv5lU9FZmhq2GL2K+HqvrYfRPrAuA9TaVNhvsTRC6dxgvBq
	YGnaPnierhIO7Vkdojzhy7Tw2lGvrTg8mNU87XrGK5wkPqdleYCLuoLq6llEl608VduJiOPCDDU
	rVDFeum/Xap/LuwumoVeLwZuKeRizwqmXIZum5rjPhsP1WjEP5ben6Pa0tZTvLlQAsmNQG/9dZQ
	VoESBPIblDh9qu5QtRtgUsm+ZORtS1xvFMn8yidaW9FzMMm3pMC1hX4DrGi9elenHZ9PjEUbHAA
	NQIXnSg==
X-Google-Smtp-Source: AGHT+IG89CuGeWaZ4V/PuYMfIH5hSeD5FELjxMutQERexQjyYl+iWIFU62Il09wfJwFKk+WyTWUAJ7McJaHiThagpjw=
X-Received: by 2002:a17:906:7308:b0:b73:5131:c45b with SMTP id
 a640c23a62f3a-b8036f90f21mr2421177166b.22.1766854137647; Sat, 27 Dec 2025
 08:48:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765900411.git.Jonathan.Santos@analog.com>
 <43504217d5b3c32da946bed0ce4d81e216f7c7c7.1765900411.git.Jonathan.Santos@analog.com>
 <20251227155525.6d712f42@jic23-huawei>
In-Reply-To: <20251227155525.6d712f42@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 27 Dec 2025 18:48:21 +0200
X-Gm-Features: AQt7F2qEVB0rJ59ndOVO8uI12ByxAaUR96Ef9U3GzvwbaKtq02ZnujoQfbsFLAc
Message-ID: <CAHp75Vde6K-EAEwN_0zTO+9e-KCq-V3t84BXu0Tm-P04f1endA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] units: add PERCENT and BASIS_POINTS macros
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jonath4nns@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 5:55=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Wed, 17 Dec 2025 02:52:45 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:

...

> > +/*
> > + * Percentage and basis point units
> > + *
> > + * Basis points are 1/100th of a percent (1/100), commonly used in fin=
ance,
> > + * engineering or other applications that require precise percentage
> > + * calculations.
> > + *
> > + * Examples:
> > + *   100% =3D 10000 basis points =3D BASIS_POINTS
> > + *   1%   =3D 100 basis points   =3D PERCENT
>
> I don't understand the final equality in these examples.
> The top line is as it says 10000 basis points but you have it equal
> to BASIS_POINTS?
>
> > + */
> > +#define PERCENT              100UL

Be careful with UL. What would be 10% from -555 (minus five hundreds
fifty five)?

--=20
With Best Regards,
Andy Shevchenko

