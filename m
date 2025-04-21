Return-Path: <linux-iio+bounces-18446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A934A951DC
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD3B3B1956
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AA126656E;
	Mon, 21 Apr 2025 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z741RD4G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F69265CAB;
	Mon, 21 Apr 2025 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243095; cv=none; b=sGsicNHf+goQzD+cJncv+dzQZOqfL13IT8y3Vq4eTs37kGQnI75RCXaKmGdhxXCDwcF3/pgxVBuCP3GuXg7ksSU9toLSdij7yyY4YMQi9fPNkLtqIh9gBIONlHBv/LoYxVXbJ96bp6CV0TsM0kj39MNypNCQkVIQNiyfnm3KQpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243095; c=relaxed/simple;
	bh=E2F1I2DRDs4lcPmP+73ms3CRLlBK5QiJqEpvigoUffg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGoksbfbbisTU5aQWLCL34S9+rVzxPl0e+ZXrC4N4GE4Yv9J8Mq1TNqSEA705vEvf6uwDWTqvSTNTPS2guyGe1v8VNkiG7eFismuUDejJ+8qlv473hLa34ce1fEfmzZrMrJH21jZ0Zaivh+WWRHsbfXgRFTSh+/L7CkRQzozymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z741RD4G; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47698757053so48074291cf.0;
        Mon, 21 Apr 2025 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745243093; x=1745847893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+rz5Axxady4tMqOuG//Mk9tsSexspjxF9mxBCn+v+E=;
        b=Z741RD4Gd309vWnb7apjKKz3GY6vo4vBRzcmn07eGSG0ygKaj6hZOQCk7ZT5xC75av
         5lKlm8dvN8wdzf79VHx85fnwzEq3riKzhqs7ucEKeAVi0CbBtVQ3phiMXgSSQSqSEn8b
         EjNnLkO8Ryg7SuCEVNbQVPfRc48tQL+7x2XMWUMMkPrIAOd3fy+BD2W9R4NLaYM1QqvS
         +ROQ9GaTOcqEXrzrajI6s1SHEEbcn8teTdw8Geq9eFp+9MbtEHih3E7vgYGXse+KbQ2H
         BU64uzWfQ3usNVKmH6Ryn7ZU2TifvYGG1xboeKwVRXTKfrMRVuteqE3JNpukmoFGPe8E
         iaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745243093; x=1745847893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+rz5Axxady4tMqOuG//Mk9tsSexspjxF9mxBCn+v+E=;
        b=HnwIC6aTDBK62rWuAMkHTfIxZlWnPzHEPrW70+pncjCjNnurOBrVz12VxuAkHv9fwp
         KPnPP6WRfXA0BC7HWZ82lgG9g9Q3CLJZAlSmOzmbIrqttUjFgptEawdEgrCxKBdqZY9X
         WlQF3pJqrHy3KfmgcsVGF9h8E8awaQlZ/HDdyp1QChH3LKSqr1TApNooKmnfGx1uLLo1
         gKjiu5lRAIUvt2h/Pn2LeKhILkJRHibTwJCCThYWUcJlMQj4vKzP5ZFhmUyYOf5H2sZe
         b16IEGwr9BBz0o4I4etIXWFJD8dBpKN22unvs7cv5SWQcYEN5GDX+8Oqpm9CsBJ2o8m0
         GXvw==
X-Forwarded-Encrypted: i=1; AJvYcCUAtqMRfFIthq5w1osyprGLOGeqOUh5zWYonbWiIveP+H9X1CcisQCxBTz3FlvD/68q0PRJKEo3VZclRDq9@vger.kernel.org, AJvYcCVHy5om2tem/uBV07IBWM8sASh4z3clBnE04MVfcFcqm6RzG4bkJtSXYvCKqg77hg6ZHUPHDroEOIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAN0zRrbLHsuyRQxmS8S16rRiBRZ1niOJQuuH/cpeEfpENY2Y
	r+s5NPZQYPF8crfpI3Ja6GfxGWUAfohzUzAnxdbKep0gJWFHB959bc4gKxSHhT6F3GaojaGCKp0
	nuD6iWlsXCwL5pk6nhzDHgUcU6Xk=
X-Gm-Gg: ASbGncs5aI9AoOjrLymt4wMKYJmYuPCnM48hTcyxhkJHFibb079VYBpyPZCqfa8vZvS
	vVWe/pnOJeyX5WltAeoIQuLy3g+gOChX02TSrVy4Wn+ammkvNeZIBFfMvcfY6kGnLjM3ln7c6bI
	MQTnsapHOx5qgYVZOiVekQlS5OS07wltlhEqhji/vPU2C943azxjDTbQ==
X-Google-Smtp-Source: AGHT+IGIcQ/qkOH4f0efAIsakCdLqhNqY4LYe4mmqUwLFuwUa0Qipj0FoFEBLw2HZkwHnNe2Z94rqKHLyweAtiy2SkA=
X-Received: by 2002:a05:6214:c47:b0:6ea:d6be:215b with SMTP id
 6a1803df08f44-6f2c463fe82mr253512396d6.36.1745243093007; Mon, 21 Apr 2025
 06:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745007964.git.gshahrouzi@gmail.com> <20250421122931.13202ca9@jic23-huawei>
In-Reply-To: <20250421122931.13202ca9@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 21 Apr 2025 09:44:41 -0400
X-Gm-Features: ATxdqUFAbjpx3MFjc3K3f1DwNxW16cyZ7M2yUtmCrTFRFvvxdKKOIoewOoIYhyc
Message-ID: <CAKUZ0zLpRRPDBF5qaUXCukSn=uZFbDUG8UhXrQbpkrZyePe1Ww@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] staging: iio: adc: ad7816: Fix channel handling
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, sonic.zhang@analog.com, vapier@gentoo.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 7:29=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 18 Apr 2025 16:47:34 -0400
> Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
>
> > The original patch combined a functional fix (allowing channel 7) with
> > several refactoring steps (introducing chip_info, renaming structs,
> > improving validation). As requested, these have now been separated.
> >
> > The series proceeds as follows:
> > 1. Fix: Allow diagnostic channel 7 for all device variants.
> > 2. Refactor: Rename the main state structure for clarity before introdu=
cing
> >    the new chip_info struct.
> > 3. Refactor: Introduce struct ad7816_chip_info to hold static per-varia=
nt
> >    data, update ID tables to store pointers, and switch to using
> >    device_get_match_data() for firmware-independent identification.
> >    This removes the old enum/id mechanism.
> > 4. Refactor: Add has_busy_pin to chip_info and use this flag to
> >    determine BUSY pin handling, replacing pointer comparisons.
> > 5. Refactor: Simplify channel validation logic using
> >    chip_info->max_channels, removing strcmp() checks.
> >
> > Regarding the 'fixes' tag: I've applied it only to the first commit
> > containing the core fix, primarily to make backporting easier. Is this
> > the standard practice, or should the tag typically be applied to
> > subsequent commits that build upon or are related to the fix as well?
> >
> > Chainges in v3:
> >       - Split the patch into smaller patches. Make the fix first
> >         followed by clean up.
> >       - Include missing channel for channel selection.
> >       - Address specific feedback regarding enums vs. chip_info data.
> >       - Use device_get_match_data() for device identification.
> >       - Move BUSY pin capability check into chip_info data.
> >       - Simplify channel validation using chip_info data.
> > Changes in v2:
> >         - Refactor by adding chip_info struct which simplifies
> >           conditional logic.
>
> Hi Gabriel,
>
> Whilst I appreciate the enthusiasm. Generally slow down a little!
> If there is a fundamental issue like an accidental sending of the wrong
> version then please reply to the thread cover letter to say that.
> Otherwise, even in the presence of build bot reports, it is good
> for any non trivial series to wait a little for reviews to come in.
> Ideally a week, but a few days can be fine if you already have a lot
> of feedback from reviewers.
Got it, makes more sense to respond to a fundamental error like that
in the cover letter than send an entire new patch series out which
bloats the mailing list.
>
> IIO is moderately high traffic and whilst we are good at hitting
> the button to mark a thread read, it still takes some time!
Got it.
>
> Jonathan
>
> >
> > Gabriel Shahrouzi (5):
> >   staging: iio: adc: ad7816: Allow channel 7 for all devices
> >   staging: iio: adc: ad7816: Rename state structure
> >   staging: iio: adc: ad7816: Introduce chip_info and use pointer
> >     matching
> >   staging: iio: adc: ad7816: Use chip_info for device capabilities
> >   staging: iio: adc: ad7816: Simplify channel validation using chip_inf=
o
> >
> >  drivers/staging/iio/adc/ad7816.c | 94 ++++++++++++++++++--------------
> >  1 file changed, 54 insertions(+), 40 deletions(-)
> >
>

