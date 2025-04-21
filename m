Return-Path: <linux-iio+bounces-18449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E10A951F0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6836B3B3C47
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857E0266B47;
	Mon, 21 Apr 2025 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myuuF7ki"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6507320F;
	Mon, 21 Apr 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243385; cv=none; b=GrHDWoCjmcATlJZCF0lyvt5tVplA4oCKQnODfIApyyDgYksH4pASGzwD/wK3sO3bhBLLTg1/xzAnnGsFhNTb+bOC9n2fL6Q4bAu8+9qZJRvOGCXf9glHVIO09txYg9v8Byib7lceCyK7N3bpQxPGUKM6njS5TfRs0eXjLNx1UCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243385; c=relaxed/simple;
	bh=l977plpmk0kxbBwv0656HR/4LTk1DAyZQR5KKCWAEqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmU7rFGQEe0Uw/fbURxmgJroia+Yej9ezSHzT9+adglUw6gTst86ovDDgSN+uH0z5scqIy2No1sdF7ii93/m8VHeMcqf5t5CibV4mG0Fbw+CSUyszF8MUV94Uu1UUskiheysl3tMEhBDzFuv+VFcJrnXNd4fRCMoKkNWSo2sgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myuuF7ki; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476b89782c3so47610371cf.1;
        Mon, 21 Apr 2025 06:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745243382; x=1745848182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGx2p1+NRS+hgnX+A6l8EzX7jNG+2zBOfPRO5rKiie4=;
        b=myuuF7kipqr2h+NMAmqqPu4oPM6NHfGzoCGf7+S1ijSEf0v+zpaqUyeAuNOWTIIt8U
         RRWsv5QM1hbaTQ5o/qwPium/8csjM8LA4FsUXtwnJRv/cmUBntLPckEQo8otoB+dpb7+
         4dM1JMgehf+Ex0SiHwHnlZLlXTMtAiC7d+fpLmrl0DA/wxG5b4flylBfu9bkTMpdJJA+
         4rgsb1f4cyJ1kr7h+qxwkUiJ5KEC3z20cz3gISV7nNkozso6dTChqVw/FKMgpAe9sqs9
         mukGaZTJ7vyAKwUXLKX7FlVdEmoMCEMJicLssWMq5m0oO+JywRVG88M/W6qB5OWZygis
         TJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745243382; x=1745848182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGx2p1+NRS+hgnX+A6l8EzX7jNG+2zBOfPRO5rKiie4=;
        b=u8nOkU3GGVhIg12CgSEWfcWvk+z0tvsYtprPbsB0aapaHdmeRU/4IJPpmfT2OMlM9h
         W91vBlip+6s3dnFNBJ6zx34HL0t3C9KqzotJ1vhlkuF2UYGHWGIFjS4GwWLx73yr2bY4
         YwSORO1UqfsB41Ci3Dt0CVLIsn6JSx03Nk3epqUHSTe7JmHCOUvagwRr1n9aqlY4kXrj
         9rXtRbwL4VYCeIGWdrkQX8NuP244tNwU2CPHr5D0JeQKKnnzXNQLJr0nBAs2qsmlhJOG
         /Sa80Pw1APfIfItQHKrl0DOxRjd4o72omrl6sseRbcrCR1XOUpw2g/Ph0ausNq0+kV3o
         lq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRrpYzsM82X0aciiJs6O2NS1y8/AAL2ETkLXwJVogO0PGqDxE/RRfGuoPVa1NXWPWtRxgwmf1j+6Q=@vger.kernel.org, AJvYcCXcRIwqoRsu3E3mhp4c9vvUInZKrRREIUTeMSVFap26zhkrrKzv0VuXPgNoEouHRP0Z44ZIyz/wsWqyXhMg@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5up51GiuyAhMwj+u8v2ZXhI1P0f114eDpvf4pL5LvbbtPw4s
	sNZ95/LnedQJBdmuqgo/bMJlqGHlwloj8CAZYi7yPbQo4MrBBqV7AA6RQEIv+KC+mM+yA8Fznmp
	ArbZbt1rWiiE7P9r3kwlnKmfX/W8=
X-Gm-Gg: ASbGncvGP63EslvuEt8tgHM36BAjcXce1AcJ2UHql+AXpPVHZXS8TbebfU49t+1uzG5
	l1YnrveSK31vorqYcouIjLY5L/7sAqAnkwG3K4zk5488wej0vqpAXqq8wvZXmzhgJx5+mNSVeJf
	7eM6gTgOGdoh2W37f0iJW9VzvroylgScRGtO5+jgxlFJ4BrbPR6rDUzw==
X-Google-Smtp-Source: AGHT+IFCRDEQECEJYjxyKWUBfHcU70YDu9Hdfq/MMsvE0/1Ruba11CTbntRDCvns5SkXCogDR5hE0ZbhsSjPtbHP/F8=
X-Received: by 2002:a05:622a:255:b0:471:cdae:ac44 with SMTP id
 d75a77b69052e-47aec4cf303mr202416191cf.47.1745243382551; Mon, 21 Apr 2025
 06:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420014910.849934-1-gshahrouzi@gmail.com> <20250421123127.3a5a7d65@jic23-huawei>
In-Reply-To: <20250421123127.3a5a7d65@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 21 Apr 2025 09:49:31 -0400
X-Gm-Features: ATxdqUHi6_oLdhhSvnK3V3HpaBLwSd6oHgBL4E1raTEh9xxnYSdB_6-I_5_l3Ro
Message-ID: <CAKUZ0zKZ8QfbkPAWaJ59LVR4KfPa0mjv=vx3_NnH-yvx1kHavQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] staging: iio: adc: ad7816: Fix channel handling
 and refactor
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, sonic.zhang@analog.com, vapier@gentoo.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 7:31=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 19 Apr 2025 21:49:05 -0400
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
> > Changes in v5:
> >       - Use correct patch version.
> Generally I wouldn't resend for this. Instead a single email in
> reply to the messed up version saying it is infact v4 would have
> done the job.
Got it.
>
> Alternatively a quick reply to that thread to say it was messed
> up and please look for v5 would have worked to make a reader
> move on directly to the newer version
Got it.
>
>
> Jonathan
>
> > Changes in v4:
> >       - Include missing bracket for condtional statement.
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

