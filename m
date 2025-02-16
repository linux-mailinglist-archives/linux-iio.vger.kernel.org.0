Return-Path: <linux-iio+bounces-15563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED51A374D1
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6BE189017F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D645D194C75;
	Sun, 16 Feb 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6XnjVzj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704CE15E96;
	Sun, 16 Feb 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739717113; cv=none; b=YnzCKjUgw/Gpqs2rLNWLRjwEYAhs6DYgO3F4cg6hkAUhpPkBR3jCZaY7vrdbZMNw7NMTSLXM+N6YBO1iPZCJm7t1qTmxt4hmYG0yi0ov9CyadLgZMNXkbxy+r6j4yK8ldJAgnY7zfV5SPPcDlW3RRN8qwRK5FJIZ9QXBiiJzOUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739717113; c=relaxed/simple;
	bh=pmGRk4vOS77MiP6exh6v8aST+mNjyk/CcOPGgO3L3LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mf2mzP4b2n8tmxzRKiROgulWHdJYqX5cVs4xszZbwMp/pP+I3WSishi+qcvhq3X0XZyG7URWUu7gZwB35GO6eTiS5krLShK3+Z6WUPYD9RKatyDL57m2PuKgfK1nDiDkrlS5bhtPTXW5vlYjBLUCiNUV240pNQS02KK7apX0BNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6XnjVzj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43690d4605dso21850405e9.0;
        Sun, 16 Feb 2025 06:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739717110; x=1740321910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgoPiu4L0d+uwVhq811pmlQRXBjbOnZtJLQQjeJ8K34=;
        b=m6XnjVzjG7OtZWpKzNLnAzrhkBMgShx28gWzDKTeW9VHKuIJ+O79A0Am9zflg8WH9C
         FpZ+RxCu8AQYsxlQ5VhqEuSDhGPraBASW1Lr9l5r/2biRWS37tXjOtiZ1j+FpjTZANPg
         2PpGXxN4fkZKtCwfwUc/qahzxoEM8vXoQ4QXwTGcrMjkH+ULyiCvdXdULxaGp5qorlMj
         3DxaBPvi/q791gv8/wIJQtCotWFiz8eH6UN9Z6WvyPpkAwL0bsW0+s2tC03dQPtAtO7X
         xaEqP8/WfZqeKjj/LjzYZkKcdXlHDFgZ9KjfCi4YMe4w26vpEDm46f7OncBmyQYoHg8h
         ZJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739717110; x=1740321910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgoPiu4L0d+uwVhq811pmlQRXBjbOnZtJLQQjeJ8K34=;
        b=bCkr5EDehN65QQG7rgpZb7dIEE5GGTtVb1Yx2zzIGHxr9OqhOZeXjcUsFqtAmi7DJR
         RXdvUG2Bi0VOokALtjK1bVhbkHSA1m4FG7bben6kaGbfStnSCeZJBs7jJPHk5JkgaRD1
         g1zfJ/IK122qtElfBHK9VPry5/MCtVr2/8M+fexYmNkgh99JvZIqJVHLYHpI/hM1HXNv
         juXFQPqYiwaUYoOkmFzpePhAfNAHFSbOElTylqzEnVAgFVbpGQDdTF21pT7aaEaLsQap
         /D20wnxiLpH1YOH52SPwYptglB9ly2tItZ7NvV6LPCh+8/Rs6S3SHerdAQM9LlW1zvft
         sfcw==
X-Forwarded-Encrypted: i=1; AJvYcCVVaFo92yoSgre8oa8W1KZF6hYSCyhLdwjDcYjeemeJsRs3P5uqehiEzehjHzy77AsZM/+hSX2LK/c3JMgu@vger.kernel.org, AJvYcCWmNzMNcFLFARw9y5uDA7zxN4er7ztxJX6bfY6A+lcpVKoP6C1M3Xa8d4Ahg0PuIBuK5+vl9KMOF/uS@vger.kernel.org, AJvYcCX09G4dyCJI2esa4cEj0dcks1ON5KuLsPlyidy40rOGlYVESjjJaQgsnO7DgWqZn0ombsyOQXuFUDqr@vger.kernel.org, AJvYcCXY9zkwvW04V501dJvD7xQuidFmnwt/vqdO/OEjmmyl+0DLDtcv2uZbbVnFfbA7HTlTVvDKNEAx/s4XpBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ib7sXZnjrAfnnHJiWJ4FLIFc8knlgm3FF88KLvhXtbG5HMFn
	IGWPvwyRKrMbGXYzQlaYslIiXKQdyO/Z10MyUTvMb7dOT3s1ceVHn2vNuaiV8YAny7ZwECimPCU
	81I+u74mArWsxIUE+y+mtP35EwQc=
X-Gm-Gg: ASbGnctSj6MnFxN55yxZLgG0qBiH0Y9gdIAEJOMTACVX82+eEVkoQKaolhoBzmAz1WS
	ciwTHZY0NSEu0OgBnSah3wzz0Kkx28xvmjRnpeoSj+P1kpA6SPgkpzD8Ev3DUP/r7tn5BzRr+UA
	==
X-Google-Smtp-Source: AGHT+IGh8eNYaZBnlWnZ4LQvz8z9CUu+mW5bKnKzVgfnyaSWf6MDVVIua8yRdh7bpsLYukVvtUkeDTn8ETZBptj4r+I=
X-Received: by 2002:a05:600c:1d23:b0:439:554e:70d4 with SMTP id
 5b1f17b1804b1-4396e6d4ac3mr48078825e9.1.1739717109429; Sun, 16 Feb 2025
 06:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215103159.106343-1-clamor95@gmail.com> <20250215103159.106343-2-clamor95@gmail.com>
 <20250216144201.6238345c@jic23-huawei>
In-Reply-To: <20250216144201.6238345c@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 16 Feb 2025 16:44:58 +0200
X-Gm-Features: AWEUYZmA45HWOqydNoo6KsPr6Qwq9PwiU8_YyusjKN9KFyEui2foYZJsMG-ZaYs
Message-ID: <CAPVz0n1TqscXQvyyD44FWZtRvV6kqAdbD0AYYCmyJOqG_DgOsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: light: al3010: add al3000a support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
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

=D0=BD=D0=B4, 16 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:42 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, 15 Feb 2025 12:31:57 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > AL3000a is an ambient light sensor quite closely related to
> > exising AL3010 and can reuse exising schema for AL3010.
> Hi,
>
> For a binding like this, also explain how they are different enough that
> we can't use a fallback compatible.
>
> Thanks,
>
> Jonathan
>

Fallback will cause use of inappropriate driver. As I have already
told, hardware configuration matches but data processing from sensor
does not.

> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/light/dynaimage,al3010.yaml     | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al30=
10.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> > index a3a979553e32..f1048c30e73e 100644
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
> > +      - dynaimage,al3000a
> > +      - dynaimage,al3010
> >
> >    reg:
> >      maxItems: 1
>

