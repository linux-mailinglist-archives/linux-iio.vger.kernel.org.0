Return-Path: <linux-iio+bounces-24699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9C2BB8A00
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 08:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBF93B01E7
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 06:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4FE2288C6;
	Sat,  4 Oct 2025 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsQcbSYu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2662248B8
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759558814; cv=none; b=EXedV/jbBO9pHMN8muayR7fmt1HBLk+CS9kWQca9B3yB3dhVaQi0dYyxk1zoosgJTjrnLWUp3OVxhCw5779lNn7R+Tzz1mA3Ad1Va3pEvXgRhA/zt74W42WGQUo1jirBz92KrgvRT0opp3s4/vjURW8olJlJ1kn55f+P6L0jq34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759558814; c=relaxed/simple;
	bh=cwvKQypMKJEPIzEUZe5Z66F8rm5W3HyDor7r3ulkwlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txfXrPr9W8E97IMR+jPkYD0hXOLthzNSas9CAla/iBknW/nZIyaggnydIa4ec17Du7AFBg0s5JlThbocHaiEIgOYglb9nO9gcQ1I9u5k6c7QdbKYEbpT6VgFROzIrdBI8415k035ulJzDIco6BeE29wbL2J+/MHeI7JD1f9sGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsQcbSYu; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6395172532fso2471320a12.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Oct 2025 23:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759558811; x=1760163611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwvKQypMKJEPIzEUZe5Z66F8rm5W3HyDor7r3ulkwlk=;
        b=DsQcbSYu7jmoi7Q+Gcs1dSwmcralfjQOtn1b6DBQVTC3YSVMap/XHeQwkyBd9WSBFh
         XWifW1fyvtxhjcZsr3aOUsKcmBfqJWyGXKhp/DMzh4bm8PBEsQsnvsuwTPw1Cd5AwzcZ
         WxQGNSw2WMwh9m/O/voAbmsI0qN2BD6bLQb+oMRLinb4TpospDam6X6UeX/q59hDOPkj
         gh0oMvZaiTVHDeoXQ0LOYUGevdKfPhJr9M8FZOP4kPHfRPy6oy83t+GX2v4Lk27cje94
         ZVQwmayvGF0J6ieKo1sOmgf+QwlaWSPx7ZcK9PkLe7zuFHMpLamrj6C07soPihS7I+h+
         e1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759558811; x=1760163611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwvKQypMKJEPIzEUZe5Z66F8rm5W3HyDor7r3ulkwlk=;
        b=Yzms0qP4XtmL2bsID9xO1v3jU9cnPtoc9PW5vIDVRF5HboFv/X9b1TQVlJjIbX2yPD
         gKQYpqtU0mPUBcHOn3Jl4uiTepUGd9jgwso66jbjAy6aOM7jgfaTUiWfj2x6uOZeHo7u
         37M20XSxTB4PETODpUcGDCOaYMh9JgyhqakanlAxnsheOePi+uSguFUW5fZyIJ8y/23o
         Z9YhXpGhHfKOCOsCiXJHi7Jshw3sMcdpBjvfLbuCRguqcyywKde9ZbUoWSvE/f21DLu+
         ERhswAjTB5WPOYPrUHLffebweCh+ASHDqxSFG9cE4r0pOod0Ntg560/sOKK+1NGi5TLz
         TSFw==
X-Forwarded-Encrypted: i=1; AJvYcCXJzfLIvqTLiht8GX/MkQNfet4OBa/RbnOhJ4kBQD6/Zzv9AHZCOU6hIG1DymX559nuhpYwmQ2Sbdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6S7l34+pzhYGHtwTpIIpOsigkgbqs6vI3UAWfLDiEqo88SE6C
	7f9ltABfEcsOn+Sb8CNSAn2f4EwjaYV5s5WDIn9EzsLwJYlcKK+5P3JghX73iSdgTbQ+/+PSeEY
	ybgImMWK1hh0DA3c//nw54cu1vG47Brs=
X-Gm-Gg: ASbGncsw1PbZZOzuPi2ve8ariz3bKK+Q/a57oVjDLQk6/YFgu/Aj1h2tnUBiM/FSF8e
	+uML/bz0Nk84vP1jVzpxXVjPZlLl0Uk8CeEEurbZT3/lR42V/P7qmcdafmVgTi2A0xHAc+27iGd
	3F5WivlhbB0ZCyNYeSRvG4/1kdgoYmOjkAjc6GabtBpoCeB8jJLJswjb4m03jrwl676tQS764YQ
	q66V7ysdikEX0c6uHFzsel9mMG4UxCgB/jZbq8TLg==
X-Google-Smtp-Source: AGHT+IHvC6Z7Roar6Te7hGz1HgNqfK/9bJzycQ+JL4engfzt5VbPcx2Bzy1MDjmUK9nyex0/tG8Inr/iSP65hfRQ6uc=
X-Received: by 2002:a17:906:c14c:b0:b47:de64:df1d with SMTP id
 a640c23a62f3a-b49c1a76234mr684527466b.13.1759558810901; Fri, 03 Oct 2025
 23:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004015623.7019-1-raskar.shree97@gmail.com>
 <20251004015623.7019-2-raskar.shree97@gmail.com> <21b1dc10-acad-43b9-a9c6-24abb2886856@gmail.com>
In-Reply-To: <21b1dc10-acad-43b9-a9c6-24abb2886856@gmail.com>
From: Shrikant <raskar.shree97@gmail.com>
Date: Sat, 4 Oct 2025 11:49:59 +0530
X-Gm-Features: AS18NWDFYveno3GXr5tGCM5q0b7CRS7Tq77mFhLV_Q5_pds9PsSNUL9CCHseVRU
Message-ID: <CAHc1_P67arWxOeBJZGGREQvBwVG6VaJkRu6_RawWDqRunBdzow@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: max30100: Add pulse-width property
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 8:52=E2=80=AFAM Bhanu Seshu Kumar Valluri
<bhanuseshukumar@gmail.com> wrote:
>
> On 04/10/25 07:26, Shrikant Raskar wrote:
> > The MAX30100 sensor supports multiple LED pulse widths (200us, 400us,
> > 800us, 1600us). These settings affect measurement resolution and power
> > consumption. Until now, the driver always defaulted to 1600us.
> >
> > Introduce a new device tree property `maxim,pulse-width` that allows
> > users to select the desired pulse width in microseconds from device
> > tree.
> >
> > Valid values are: 200, 400, 800, 1600.
> >
> > This prepares for driver changes that read this property and configure
> > the SPO2 register accordingly.
> >
> > Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
>
> The subject prefix [PATCH 1/2] says it's a two part patch series. But I t=
hink
> you send all changes in a single patch. If single patch use [PATCH] inste=
ad
> of [PATCH 1/2].
>
>
Thanks for your feedback.
I have shared 2 patches, one for device tree property update and
respective driver update in
MAX30100 driver. Can you please check the patch with subject ' iio:
health: max30100: Add pulse-width configuration via DT' ?

