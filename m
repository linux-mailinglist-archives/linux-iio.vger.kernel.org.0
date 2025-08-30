Return-Path: <linux-iio+bounces-23486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C81D1B3CE80
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342721B25DE9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A022D8789;
	Sat, 30 Aug 2025 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB62WKQS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF20B2D8779;
	Sat, 30 Aug 2025 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756576957; cv=none; b=QsUFyz+8n6ggiv2bL2/p+60js4i2M8hbxIhLOMX6v/A1VALmevwCt4Ypvy6L8Eagb6cRSwnq4HhNruEYG+cZ/CHAMyczpVeSFi7boPfgq5JBlh8yKjRpWiMBzn2xFFXZNKsCmhuRdxfcbAPBt4qlVIAPfPBZevoBgzDtJfcgk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756576957; c=relaxed/simple;
	bh=Ao8imHYo5IzQ9Frm5yhbR77Zb2XvtE17zjk66X/cYUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUSaTmnL5SKQGIFAxlVOzu1kWpY/VhteUqxxcQQNmTl8D4NypksKAgsL69uz9CJE6XkOJOt2p9yiLaNm6TKYHWckvqFFPAkifyiisXcjdZPCEmr/pvLqAK6y2gxbkJOz53FqfJOvb0a5eIVrzoWRH3CI6VcqCoh9DCQTGGwNwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB62WKQS; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-336ce4a8bfcso3258181fa.0;
        Sat, 30 Aug 2025 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756576954; x=1757181754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epsny7acfAGYj85X4uwMr4fqde6oRVpKItTrIp/5hXw=;
        b=NB62WKQSK5W1lKJKY1DXedDAT6jMUsL8016hm2fJgz3T8JMldWLwPVDEHLJzbtWjfY
         sS6rucCLLuTqQoHC+eryoYHJz3OTbA2Rlj4CBArci9QFRNP70hWnaG3HTlSb2qQEFrCp
         7PTL90hcfFn0zGIC+2h3lBxfRpFgGQqBEJrpKCuNEOpw9rUzCn5lbtIDyMioZvnjuYlI
         H3I6i8t2myMwnqpM8WF4eQjsqIFj8PXVjgJbe/LZuYHScb83CU2IOLkScSDbN1xR9s+2
         YmNEVvvx0mEftVYxmHX4dX70HXMmFYDw85wzHliG2iGx347/eboWPRnbsIJ6ND68e6yU
         YodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756576954; x=1757181754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epsny7acfAGYj85X4uwMr4fqde6oRVpKItTrIp/5hXw=;
        b=lD7auitj5WB+kMLhtp/W4OOolJsSL3JEpXLEAc+vuhwVpSb9wvWroFRl9kNAzWJEmK
         oFauKDsYOQMGclwTpm929LdKj+013puZ7G9e1ou6wWOmb9DRmmqmyS/39LRB32B8YmWL
         zS8AROHHAEunxSvF0p6iZotvPZFrJr1AYAlqBR1AvlZx4z2/NuFPvGJ+U/nsOn56rrQW
         TDHwuoDp8SJNfS6p44ao5PDyKNkJVI7c8c/QbFh1sVcr5IEBZNyx9N7h6lXRHxpwL+hF
         noc/lB8X8A9yoS60khUB7nSbJfCyFNPp22NJaRzmANWgVf1sqb2ZSAIEp0kgLlntqkQo
         GHNg==
X-Forwarded-Encrypted: i=1; AJvYcCX+Sbr7OgjBZpqu7LdKpWHseI2AQBiy3u/0wm6FX9FgFxXOrDnnR0aR8FBEoWXrJO28gq8tX0sEdEsK5nqF@vger.kernel.org, AJvYcCX17n9gcFQTSL/zja+6ZYdJR5MK4e54un7xahEq0k6Xtku4h4/NtPylDPqt59jsl/VU4HsvgEkH45Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxceMstn69Laj6DVtyE5kq3W1st2mqyoQUTCaaRg4ap3wmbLlD
	tEealNLwriEB25qi55a5xqjAt/gz/F9ipxcFDxgspuvcwo0nXooS91mYNU69ObqXsjBj5DnBDKn
	fAln9T4syjyT+hl0E4zQqlldNgZQ6s0o=
X-Gm-Gg: ASbGncugodXbA6l5WQA3vCryCaPV9N1h3T6dg8dsHFY6QkbRkljq7jreQaoHiDGTVMB
	dwawxhisdZ/qv/ZFL9CiMH2RlM0hk4pkHEW1Vj8AlN9+iSiPTkyLygG31Fwwcsmk2MD0/zzr3yj
	MYSfjPBWWQROiZRsoria9GY/DcHCXKCy1skmVIQECwK6GCo3v+7GfiW5bGENz2DKjk50qcK4+JA
	D+Bin0=
X-Google-Smtp-Source: AGHT+IFYbWcvlq4vBHu7LPLPkJqryqkTThxW7bWrivBX1b8nehyrj26P86tSJh21eVC980GYXhTbwoZ5Jk1PoUPQ8eE=
X-Received: by 2002:a2e:be24:0:b0:336:b941:4ac1 with SMTP id
 38308e7fff4ca-336cae3b72amr6297091fa.30.1756576953563; Sat, 30 Aug 2025
 11:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830113502.83102-1-akshayaj.lkd@gmail.com>
 <CAHp75Vc6J+Qm4hsV=PJn9Oyfn5xr9SZLGMagHm9NdFrkk9Y_5A@mail.gmail.com>
 <CAE3SzaSYLFFRL4OuqUbk8J0dWCuxedCyGiX2_tJySG1FC=w95g@mail.gmail.com> <CAHp75Vcitq5+fJJMKFGC9Qsqe8yAuoxK99YohR8N9218iR_Ocw@mail.gmail.com>
In-Reply-To: <CAHp75Vcitq5+fJJMKFGC9Qsqe8yAuoxK99YohR8N9218iR_Ocw@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Sat, 30 Aug 2025 23:32:20 +0530
X-Gm-Features: Ac12FXzcCU-jNW_S8F494tnEXjlXNBKI-Q7NsUK_8okhnUZWGsU6PS4EDQU0rGs
Message-ID: <CAE3SzaSmkjiqkAG8CCsu_ZOqSFSAaETNeZu+mSL9=MHoiSmX2Q@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr390: Implement runtime PM support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Andy for acknowledging. Follow-up inline.

On Sat, Aug 30, 2025 at 8:16=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Aug 30, 2025 at 4:24=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail=
.com> wrote:
> > On Sat, Aug 30, 2025 at 6:04=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sat, Aug 30, 2025 at 2:35=E2=80=AFPM Akshay Jindal <akshayaj.lkd@g=
mail.com> wrote:
>
>
> I see now, yeah, this is unfortunate.
> Just rename the leading __ to  the _unlocked() suffix. It's easier to rea=
d.
I did not get this part. Which function do you think needs to be renamed?

Thanks,
Akshay.

