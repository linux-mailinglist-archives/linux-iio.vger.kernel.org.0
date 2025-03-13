Return-Path: <linux-iio+bounces-16779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7082A5F60B
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116463A8D84
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 13:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D4B2676CD;
	Thu, 13 Mar 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxxTbQrH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0CE537FF
	for <linux-iio@vger.kernel.org>; Thu, 13 Mar 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872964; cv=none; b=SypgEdPIADuUA8cNmlAzYSX5aG5VNsxjvwysSLAhVcjWvdmllitaelxZdrhGbLhKAdlLmZp8a73Qu5wiW1HtcVRoVVy4QUWFDBoEU70YdtgngysmY5QLGCGlk6XpnVaA/M5KO5ddD4Vw18MbBd3B7ndjCrKzft9CHBz1r+5W0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872964; c=relaxed/simple;
	bh=j7H5ow6WpxIBA05ozKOO9tywsUZKtPjp3nAOTfJOYsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuGIgCrJkE/BvF1Q+ut1gjnJbUUlTtnzaFaj9+cgFd5Ocjif6l4fJZvOdeBErpm030HbaFw5X3zyYI4+4GtoPv/k/0P/Mx+yMb4Mry7q0liqpNTUfLkt3EbB2RCdd4xfk7F8wWZHoiXjCRw26dVUb+9HzxtK05HIu9KhkpXFyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxxTbQrH; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3014678689aso339173a91.0
        for <linux-iio@vger.kernel.org>; Thu, 13 Mar 2025 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741872962; x=1742477762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3/aF+WPRGvE7vEMN7Z6pZLhrexZRm7solIvzlSCpzw=;
        b=RxxTbQrHkYVgt12DgPJYeLVM/xKWW3A4CqXZ22lJPa9Z0Px2w6VpeHvBypZsOVniC5
         PLWOl1dDESYed9bkbpmiGKa2/LTwKd5WElKlK5UCe45IRatNbUFSULKZLyBLQVNRMuRP
         6mFvEVMFmdAEqz2A43N0QWWsEdMYuG5N3/fYAOiLb+it/iWxO+70ImJAtFGvnI1PIn/8
         r4V2Yanhc78wc5FJqXJPJByujryjyG3EMudLfF6jnBM6aW44Xf/hQdH4FvkFobuWP00s
         cJbednKu2ZbXl5eGogfiKE6Vf/JdemOm0DFwhxfa9FfB+tGhqCvzjDLothzC3BTJs/ZT
         7OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741872962; x=1742477762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3/aF+WPRGvE7vEMN7Z6pZLhrexZRm7solIvzlSCpzw=;
        b=MM3HivvOCrwpma8Q7z0gCxvbagm7HAIHbKmlBvv9Dsezrs/EwdUX1q/p8GB+Guh2pQ
         lb9i6PHouDx41dIPvpYKmdLRZ8peZYG43NlwVLsQ/GpDcvjh4kWhfF0DHUcvXMj1jdvt
         b98dh7ISAbDTgaFw/jszlYuRvJtktMtrnt4iq+khh3pHBLDGkq6QcdmrgBTMf2r9CcF8
         MDFPkOzWFyCy4AJFM2QKj8ETsPznv1B4rHdKGzd9gOiX980JJGNwGf/HucaU2VT0XTUX
         5pC0g7Hhzw+zr1GO8lS5jpYpC5HrcKdD+nXzraeoOaoSo/mt1Kp6kggZyIYtdVGteWaC
         Cj6Q==
X-Gm-Message-State: AOJu0YzXjuvlf/8jXn54D0UU/tJwwysFqefdmIK7dj+tDedqtuafrrSx
	3EwixG1M4rjuc47G3K9XHkNmVyObFuuCDdUZ4jcBQdoc67+Cz3Hlb+0PQI1eb3AKZ+NWJbDr/4p
	HjwbrnJHqJPIfSWF4Isn6Ev91ZE0GP3c2aXX4xA==
X-Gm-Gg: ASbGncuCBhiPbtMcTH72dN090s1vq28hyZK/Gm8lDcLiTwshz3jVmAUPI2QJIivFgsA
	7SaRAsEAbBSqW4Ww+/hNEM1EcFG9pVm+jSTVSk2WDLwMjHeJlzDXlInkfEGZl/t11wMkwc1stZb
	pZNGODBCtszv/4unC8AAg+770g+Q==
X-Google-Smtp-Source: AGHT+IHWmIR4kpbb00sMcfdsJNY1QLnanZfFEcwk9CY2vwjomhSbiexzo5AhAte8N7h9usuw5EVLU8GM4gvA2X291zc=
X-Received: by 2002:a17:90b:3c8e:b0:2fa:13d9:39c with SMTP id
 98e67ed59e1d1-2ff7ce6f379mr39739143a91.14.1741872962187; Thu, 13 Mar 2025
 06:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMmuoA+1Qi2qnF64nmHobL6hSFdf6GUrX=BjZ=0aGULu75b3GQ@mail.gmail.com>
 <20250309162637.6937c7c6@jic23-huawei> <CAMmuoAJy_GPL-7tfbrgH9U4T4UvUiDoHozw67BqadoV_nAJXog@mail.gmail.com>
 <20250310193215.0f091dc0@jic23-huawei>
In-Reply-To: <20250310193215.0f091dc0@jic23-huawei>
From: Prince Kumar <855princekumar@gmail.com>
Date: Thu, 13 Mar 2025 19:05:25 +0530
X-Gm-Features: AQ5f1Jpgsa_9Tc6S3DwxKNlzJTSXVkxfbS0DczwexqIjv5ZqdrF7-NMjG6ZqZtg
Message-ID: <CAMmuoAJPQiYfz=f-0L_UokwoVK1tHfcG_ohmVwN7Vy3MeZiPLg@mail.gmail.com>
Subject: Re: Proposal Discussion: ADE9113 IIO Driver Development for Linux Kernel
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thanks for the valuable insights!

DT Binding Flexibility: I see how increased flexibility can complicate
matching rules. I'll lean towards a part-specific binding unless
there's a strong case for generalization, and I'll review adc.yaml for
best practices.

MCU-Assisted vs. Direct SPI: I=E2=80=99ll check the IIO tree (togreg branch=
)
for SPI offload logic. Adapting it for an MCU is intriguing but likely
beyond GSoC=E2=80=99s scope=E2=80=94could be a stretch goal if time permits=
.

Reference & Guidelines: I=E2=80=99ll align with recent ADC drivers and
iio/dummy/, ensuring consistency with IIO standards.

Appreciate the guidance=E2=80=94it's helping refine the approach. Let me kn=
ow
if there=E2=80=99s anything else worth considering!

Best,
Prince Kumar

On Tue, Mar 11, 2025 at 1:02=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 10 Mar 2025 10:33:44 +0530
> Prince Kumar <855princekumar@gmail.com> wrote:
>
> > Hi Jonathan,
> >
> > Thanks for your valuable feedback! Your insights are really helpful in
> > refining my approach and ensuring alignment with best practices.
> >
> > 1. DT Binding Flexibility:
> >    I initially considered making the DT binding adaptable for similar
> > SPI-based ADCs to potentially support minor hardware variations with
> > minimal changes. However, your point about maintainability makes
> > sense, and I see that most existing bindings tend to be more specific.
> > I=E2=80=99ll revisit this and reconsider whether a part-specific approa=
ch
> > would be more appropriate. If there are examples of flexible but
> > maintainable bindings worth looking into, I=E2=80=99d appreciate any po=
inters.
>
> The problem with increasing flexibility is that in usually means
> more complex matching rules (see allOf/oneOf statements in existing
> bindings) to ensure we require what is needed for a given specific
> device.  Those are a lot harder to read than separate files but do
> make sense if there are only one or two minor differences between
> a small number of devices.
>
> >
> > 2. MCU-Assisted vs. Direct SPI:
> >    This was more of an exploratory idea rather than a fully defined
> > plan. My initial thought was to assess whether offloading certain
> > operations to an MCU (e.g., pre-processing or buffering) could offer
> > benefits over direct SPI communication with the Linux system. Given
> > that this isn=E2=80=99t a typical approach, I=E2=80=99ll take a step ba=
ck and ensure I
> > properly evaluate the feasibility and trade-offs before including it
> > in the proposal. If there are existing implementations that explore
> > similar optimizations, I=E2=80=99d be keen to study them.
>
> There is SPI offload logic in the kernel that will merge this cycle.
> (it's in the IIO tree on git.kernel.org togreg branch
>
> Expanding that to MCU based handling (all implementations are currently
> FPGA based) would be an interesting project. May be too complex to fit
> in the timescale of a GSOC.  Perhaps a valid stretch goal though if the
> rest falls in place quickly.
>
> Jonathan
>


--=20
Regards,
Prince Kumar
Phone: +91-8557032850(M), 8556911521(M)

