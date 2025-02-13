Return-Path: <linux-iio+bounces-15485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1569A33AD8
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 10:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196451697CB
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F5920E700;
	Thu, 13 Feb 2025 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUxn6nTh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8720C49E;
	Thu, 13 Feb 2025 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437952; cv=none; b=tT6t99v4jfCr0FBHc52O35jqv8M5yEkbl35cPeTbxbsZdMlQ2j1sYw1Eq7dNHrGXJpU/5UU/ibx9om5sIeZSHNYgHOA1jb1fFrb2NsGl17hzmX5x7DIor7eqYjhlkNB3EtJWmA5pmSSFmdcsQDs2sYbsGjiFpEwDWcLVCnD5jts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437952; c=relaxed/simple;
	bh=yLddpAR4+uHNaBfR84/0dHce0z/yGb9TvcOzbtkoKUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQxVkxjxB6rps6sFU+TfGTtL28RB3zvi7GAR7lQrxMO7BOj9vU5w4eqABKAPlEVGUq9myLGvdLuPwP0/3lk5DB8Ughjdoc9u66Dd6PCmSlmHxy1joGdjNfZB0AvceOMzqhrXfAjQLKXWjs2XdPKt4knAx5/zUUneDOLUmAveY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUxn6nTh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43946b5920cso3724635e9.1;
        Thu, 13 Feb 2025 01:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739437949; x=1740042749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg1JP0auLt2hGreWRb8PL7qoComGrRDHQlIsTeKF7VE=;
        b=fUxn6nThMhkaowpzeUlUhRdy876YqU+QJaOkjvp097n5uKLxHFKzXD7Y8PGZTHJGDI
         r63PL2zP8RtBwlla8ASkyCV349z5lh6ThXSk2f4hVKLcK50jBXhOxNW47Q0J+gKa+bwu
         qhvkyD3BkrXZ5RaqeQtbzdmWcXaRbMkgrOsSbISvdsoBraTxbzRag5MjOmMLECSq1Wr5
         293cij+RKi0v4Bd5AgRiRnT1LQI82dAVPwkHkfmZ2enGf3SEAnEsG6Urgm07XL6p8xR9
         7DHpflb+bs8IfmkNnNb8etdI3k/RyFsePLEBkOchGyayFZKAZg9M36bR8ZW/9gX7w5mE
         TRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437949; x=1740042749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tg1JP0auLt2hGreWRb8PL7qoComGrRDHQlIsTeKF7VE=;
        b=MAB1NrBhMxMKGoD8KdPOBh/ughTGMHRnp2QPztzg4S72XOOe87uVgdFFC2q6cAyNXo
         TaBhEiLTTdfFgvhDUVTKM05RGoIf/Vw2xZWIWL/qQI611CK4ShV7LaP/ceEr/bPlZM/G
         ODjZJnxvLuzWLehMxPutGOXSyKoJg5lc0/Y0AtETZeTOhr3vk7zsaNsmrbS0taW35JnZ
         PfxAWw8sLeBkLa4FGZQxVW2qPVfSl8GwOmYak02OrMFJGXBBKT8tdxljuahKImZGoRPA
         JJWvWeA70I1nKrZ01HcgGF9H4j1zGBgeg4LvRkopTac/W8f/O0oIhNq6XHA3QRWJZ3KL
         4lZg==
X-Forwarded-Encrypted: i=1; AJvYcCU0+8mneDkp1qVqoL9YHaxV4b+LAqLFXpZEjEgWeg9tHyAEoj7KOJhKiZ2U/091uFPb1EapfdAXMCF/@vger.kernel.org, AJvYcCUnbdqA9YLi341g+TLdM7GSgLPtcHy26BmsEAZ3mhy5etpcwetOFa2ogybOgVrXjjfLeXS8wezQF/va7czY@vger.kernel.org, AJvYcCV1uYuD6ATSjNYEkAmZH/UV2eI4PvEgHb+U8ICwQQyRMBjKxEv7Iztsx+bBEHmhXXzvsB4YGXqxyPrB@vger.kernel.org, AJvYcCVbFYvLAUZx7WSOLRBSr6N3UXQqZtid/eyeAG1EAoGkdgYQWJRuJc3DUCGpor46CxFYWhNYOcEFheGdyfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe2Tk1CVWUjtUV01K01iHk9yXK9ZkOQhKcCTFaKDLq15CrT1nP
	jWBeBS2bTjp4vVIYmJW090RrTDjuuhRqWeDfrOt+JOsPEKEpoXC8MSJiYOTF5opCxkaatNQMI1u
	qEGeDdjo4v2APFEZ1lu2pr4mEwMM=
X-Gm-Gg: ASbGncu8bdAUArFSjnFdwd97WE93/je+VMxXMb+MJGRvw/gG77aMx2aBzpoocfCYSLy
	8pip8P2x9jPG3eF7qHC0iSNYOvSNcYV4XzqXxnV+QIoNR1BuWU8wZgiA9hZVIZfU1LicsDtG3mw
	==
X-Google-Smtp-Source: AGHT+IEIXiFHGpQVqWcQkS8ro0yUEuPnyaUHznDC/xhn3mOMYppaKdBfxc4IehqBFdtdLKysYuxZvKa7oxsPHk5SNG0=
X-Received: by 2002:a05:600c:45ce:b0:436:e3ea:4447 with SMTP id
 5b1f17b1804b1-439601a9bc9mr30373085e9.30.1739437948788; Thu, 13 Feb 2025
 01:12:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212064657.5683-1-clamor95@gmail.com> <20250212064657.5683-2-clamor95@gmail.com>
 <20250213-eminent-antique-koala-5a68fd@krzk-bin>
In-Reply-To: <20250213-eminent-antique-koala-5a68fd@krzk-bin>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 13 Feb 2025 11:12:16 +0200
X-Gm-Features: AWEUYZnFHGmvApSVhe437rJ4JjjYpQhXvUgc0fkqXWr4PnY20ptTukWJUhLNQ3o
Message-ID: <CAPVz0n1fDGEi0fV+CegKo7GWjv4piPqYyDd6Mo1j2mtXSp8w6g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: light: al3010: add al3000a support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Emil Gedenryd <emil.gedenryd@axis.com>, 
	Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Per-Daniel Olsson <perdaniel.olsson@axis.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 13 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 11:11 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 12, 2025 at 08:46:55AM +0200, Svyatoslav Ryhel wrote:
> > AL3000a is an ambient light sensor quite closely related to
> > exising AL3010 and can re-use exising schema for AL3010.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/light/dynaimage,al3010.yaml     | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al30=
10.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> > index a3a979553e32..6db4dfd5aa6c 100644
> > --- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> > +++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> > @@ -4,14 +4,16 @@
> >  $id: http://devicetree.org/schemas/iio/light/dynaimage,al3010.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >
> > -title: Dyna-Image AL3010 sensor
> > +title: Dyna-Image AL3000a/AL3010 sensor
> >
> >  maintainers:
> >    - David Heidelberg <david@ixit.cz>
> >
> >  properties:
> >    compatible:
> > -    const: dynaimage,al3010
> > +    enum:
> > +      - dynaimage,al3010
> > +      - dynaimage,al3000a
>
> If this stays here, keep alphabetical order.
>

Acknowledged, thank you.

> Best regards,
> Krzysztof
>

