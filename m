Return-Path: <linux-iio+bounces-21928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 894EAB0FB08
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 21:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D34E1C84F4C
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 19:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B60622F152;
	Wed, 23 Jul 2025 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="B4SYYgi8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4A1EEA5F;
	Wed, 23 Jul 2025 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753299716; cv=none; b=esw43cIB3MOhUnk4RDzvKdE6y1SFhq2XsyaleCyLaS2gr0LWh0chr3h2YgNry5Jrz4Q/COjEZBM9UzHQeMJXKANa6QaK7Ga3ZDHHoUff6Uh2hWnnD0IVbrCfGL5bKK2XiqnQGbYmz1/dQsyvTWIigiGFfeaEOfHthATHl2zpSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753299716; c=relaxed/simple;
	bh=tXkjt9YB46wQ7fKSEspeGwCyc8yw9KfMpYOU1ApO+HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oB8i5Afl2AIqPjByvqmbDtkKTTj/8oepKNKXylrbIJVi8l6VDJxNl1zKBW0A5x9vTEf09sBImo4tCLhZidycnngUxRPUs+QAl8y7SVE5nP3AMsYnGeJks8cs6o0z4rJEHggmMT6qicZi1AqWqgmEYSxJ3SmXtNpwBUhacYOLV4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=B4SYYgi8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b271f3ae786so244398a12.3;
        Wed, 23 Jul 2025 12:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753299714; x=1753904514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXkjt9YB46wQ7fKSEspeGwCyc8yw9KfMpYOU1ApO+HU=;
        b=B4SYYgi8F6BQuun12lLY8lSRO5BhUmwk+nN+P7KnjJfU4/Y3yiNc5gzCIsMd77ehHO
         CIhDxJeVv1fbcaThBPKhjLjxl4UtzwwYMi2PsEtuWBuaCHOY9xdiZ9CCGFhwKFUnxdHx
         BFXpUOCdoRgMT+ayucALWEVN2Djp4KvEWMUwS+93lPtd9ceTqnWGiWy1nmQcZPQJoOwJ
         8HLXyTlzz+qZ52BQYoZoxKBpagVSElbdLQ3FjjToBJ9mCsRTRsfLFEE1LC1j0rckg81D
         BtzxhgFMvtV/cKgOOZEIRk8oXdnFdOzA72X247jcewvefLP5vktivOJprfZlQzQdDNUA
         F5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753299714; x=1753904514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXkjt9YB46wQ7fKSEspeGwCyc8yw9KfMpYOU1ApO+HU=;
        b=SvyzdogEHxyzrqa6gDUCzMjvhL5WsiR7wqLFHoyQNkkBUYhp4KdoA0ONvDKq5ev3WF
         Vtp00TSHu2iaPYGvIWPGzhzT4HkNjd5EzeGvOTeUI1Cxns5lFyGzD1OOITTKImxTireh
         H6jh8Jk3jQh0ykPmbcEitK4x6cQSlW1VTkPJGNv1ilziijHBz1ed26fDyvniBmMWMd/a
         +8JBNcPi4E0NadZ8WODuYQ2grhnFsR6M2hbLFGF9+8J/r2Y9jEKTdaPiwvYoQ5Rz/EQt
         yk7axcN8+wirJBYjjfY8mK5MAtT3emnNy6wDLDp2bS/X51lBky/Ci+eml6qko4zLBWQW
         db1g==
X-Forwarded-Encrypted: i=1; AJvYcCUjdAj0u8KUVFgyADN6tr2nUMtKxNMiGbmiFKhkcV4ciAy8UIHJB9M/iudNzSO2/wbqVZiTbwTmum3w@vger.kernel.org, AJvYcCWfZflsimMKTpcihF/g065JODNAAFTgVkPzNc+Tle6d3rbL/xwFzcjK+ucM097cHVQiMXn1xZpb@vger.kernel.org, AJvYcCXgtXhWfwjw95qCjWcZAETZILIsYX8GtoXdYNuNyS8lsmv9tuqvXvnbkotU5P+Jde+Mom3QVBXNAhPa@vger.kernel.org
X-Gm-Message-State: AOJu0YwzIpmPYZxeHLcS1nvCMFNu74SK57C94NWx7Qf8KCIR8PO+58X/
	JLO2lTzUk/H3r2BsAZBjp3VZg8aUy6gwJJsHBN81Y5BoYiu+bdYvCwIO/bms3TpVUXxy+Sipbew
	IWdmrZhC003IS9CIn43QOxH8wNAgcZbI=
X-Gm-Gg: ASbGncskWPiAFlkljZgNIdVWyoOQ9Mo2aJxTNsyUcmreJtz/vqHqxrq7pAJJ+Q6/OxY
	yBxnRfolY0a+PLHM9idW78FLUW2WjJ+7bYZ3adtoxik8DHtZRN1Tw83LBVlV7WYFW3BaRXQUtJJ
	L7JXSlTFMm9S20+DzU332CYiyMmI9obzLSbRqa+NJBBX3+CAGevhu0wjX41P/KtEmnTSegQ8Azg
	ggSDDcac3Y8LpLdwIDdjr18laHnhKtG/abrEz8b
X-Google-Smtp-Source: AGHT+IGWeJEGKh+77TLxgOqUFZ6T7wS6eJlh3839BVCy1uQyeIhZdVq4g4jKDXGiGQwgtBSfZKGUpxHiJcD0En+3NEg=
X-Received: by 2002:a17:902:e349:b0:23f:9a4d:2762 with SMTP id
 d9443c01a7336-23f9a4d291fmr33727935ad.31.1753299713947; Wed, 23 Jul 2025
 12:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
 <CAFBinCCmsw=XGPtrk1XbphOu=OwhxmAiZ+2h4x_M-_f64Vo-7A@mail.gmail.com> <8e5e1d09-0706-42b3-8ae1-00a0e2f5139a@gmail.com>
In-Reply-To: <8e5e1d09-0706-42b3-8ae1-00a0e2f5139a@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 23 Jul 2025 21:41:43 +0200
X-Gm-Features: Ac12FXxIbHkGKJlc4jEtw4fHm14nx983sxWIVJ-SRO-9-6MULnML1Fz74CS-trI
Message-ID: <CAFBinCBu4Z_HZuhPChsyraStK=RSAKH4vtNLCoFWAWUjm5n6ig@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: cleanup: fix duplicated 'is is' in YAML docs
To: Sanjay Suthar <sanjaysuthar661996@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	ribalda@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 6:30=E2=80=AFPM Sanjay Suthar
<sanjaysuthar661996@gmail.com> wrote:
>
> On 23/07/25 01:08, Martin Blumenstingl wrote:
>
> > On Tue, Jul 22, 2025 at 7:06=E2=80=AFPM Sanjay Suthar
> > <sanjaysuthar661996@gmail.com> wrote:
> >> Fix minor grammatical issues by removing duplicated "is" in two device=
tree
> >> binding documents:
> >>
> >> - net/amlogic,meson-dwmac.yaml
> >> - iio/dac/ti,dac7612.yaml
> >>
> >> Signed-off-by: Sanjay Suthar <sanjaysuthar661996@gmail.com>
> > Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >
> > Thank you for spotting and fixing this!
> >
> > To my knowledge nobody else is currently working on amlogic,meson-dwmac=
 changes.
> > Meaning: with an ACK from the netdev or iio maintainers this patch can
> > go through any tree (iio, netdev, devicetree).
> >
> >
> > Best regards,
> > Martin
>
> Thanks for reviewing the patch. So you mentioned, now the patch can go
> through any of above mentioned tree, Is there any Action item left on my
> end related to this patch? Also will I be notified about when the patch
> will be approved and merged by the respective owner?
Apart from waiting a few days there's nothing to be done on your end.
Both the netdev and iio maintainers are fairly quick to review
patches, but they have to review a large volume. So give them some
time.

A little bit of background in case it helps understand things better.
In my opinion this patch can go through three trees, since these areas
are involved (in no particular order):
- netdev
- iio
- devicetree

If one maintainer takes a patch that somehow touches another
maintainer's area what typically happens is that the maintainers give
their Acked-by and agree on the tree through which the patch will land
in mainline (=3D Linux Torvalds' tree).
When the patch is picked up there's typically a mail, informing you
about the tree that it has been applied to.

In case you don't hear anything after a few days (my rule of thumb is
a week, during the merge window it can take longer though - but we're
not there yet) then please send a short gentle reminder that you're
still waiting for a reply.


Best regards,
Martin

