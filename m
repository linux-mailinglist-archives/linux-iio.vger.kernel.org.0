Return-Path: <linux-iio+bounces-25456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05678C0CA44
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 10:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8326918875C7
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4232EFD90;
	Mon, 27 Oct 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvifwJYk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C0526FA50
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557129; cv=none; b=oGYjIkVspbqrC1COvi2zY0cQUy26ZaAICdW887tW8BiIWfQU0NLHU/DYrXVOI3qSGj1BVIJ61nkAQYQFdIxUyJVw6k1Q1/b3qqOyZgFvG4ijPZHAwda/00d76KcVEzUR7V2PjILzNQHkveonhsrjf9c8O7Ti1prWzqx8DXk9ecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557129; c=relaxed/simple;
	bh=YJ3Na5nmh5DDcjGriWUnHW8mLHF0cCL13X2wMKwKkZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku/1piCiXI73x5M/QsnF4nJ67ebnLeJx7WKUPVg2u+r3czHSlWgerPI0ag7daZgYPBVF8Rne4FXjgxdf6DIXANCp3MmRvZVMqG2KkbD6tGheACcXm1J/ltQ8IToWsBYFqgTFJo16fA80iz66d+snYJlQFQebetHN2boMb+llZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvifwJYk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a27053843bso6105931b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 02:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761557127; x=1762161927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ3Na5nmh5DDcjGriWUnHW8mLHF0cCL13X2wMKwKkZs=;
        b=QvifwJYkJnnKP+TjMgC30TrsGQM675Pv5fHKYcevIQ7AbDKujy1eWdWf6RhhlrmkPQ
         vgWA5EEZ4oQ3Y9xH3KH8bLGgjYMBHWrv4i+FaDchgiDoFBsOo2hRnLn10NecAPqUTfNR
         gfcuVKSOe8lbS3V2CSTeo/lgs8b0zvqJlIGC8+XUR0pWFk/s95lPsATouQbmurxLioZk
         tWGYVtTzLeE+bHZ6XIt4jI4nZfDaql3HxSPY9V3DUoYHI6+BAWzn6K5DQB/vP9533Ooq
         q1U2VIsgy1rPR8BFuStatnPsWnM/oypjsjgtnAGZ0a5W1jkt8v9pjH+VisGv9Smrqc4G
         5Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557127; x=1762161927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ3Na5nmh5DDcjGriWUnHW8mLHF0cCL13X2wMKwKkZs=;
        b=pTEvbvw4gaZI4HheMTxyA34EnHpAk+HWJ8sWxUtIFLWwA7sV/iZ2aN8H8lydD73BTQ
         uDY2/YkzN6ULuGuqJT2tgx1wFNkSTPYvX1ieVq/7C8Pwwmz+n4cIqeZ5mPMXkjbw6Bly
         AfU2kT2SrS3BcwpZd67PBQuo5RivkxVjyxWoWXS06NiMCuvTVjwZa45jpT6QYZAcMhCS
         JcfbuyIwbT+OgLNNIq/acCp8Q0ZipCU0wrUsSY30Yj/fxI/rrlrNxNEhC1RHzJ51wZ5N
         RP7GYgW1AfopMfzJrcagJ+2bIeYv4UnInCiIZsUl55LsB0mfvUx9SdFtqFPjT40qon8M
         3Plw==
X-Forwarded-Encrypted: i=1; AJvYcCXw6FmBtp1mGJsra3iVoQPM+umZZSjAUj5qjl8xTG2uK39ShEFamZHZp4cenLdxMQ7JDU7/f5j1ssQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCprM5GgCnH/e42Bbgu7wEtjjLe6aj9j94jMMFU7SZHmPSoJmL
	ouPuE3PA3XEyAJW3Q5VnlgkvQk0KVCO4iTLKa/40D/+N0tzGq0PxthiRJEVM/IN0KEwGZK4VfRG
	0SuUGeIBMIKRpqgVvC2VHgo7OmpgetOw=
X-Gm-Gg: ASbGncuS/8IXVXylBt7HiRgFPfuCu8qmVeHG6+LodnzemzPg7t5KYCppaERI8x6N8JN
	lgpCBZbPhoBPfbn7AMqPJNmVuIdrL68UZls3WceveO1zgD7GLvY+FhTlwwh5he2a17gaLPEdou/
	dk2vBdFmy2M0ucECa/ndtK0bKNFD3B9ICuafkVxNG/jMdnlYkAAS8zyhNtrH57H1Q/Pst5sxZKa
	IBMeUAsMn3yYKOXckkm+15bSZsdcKyJB725Fhh2FBQehZz8I5m8LTCWJKrG
X-Google-Smtp-Source: AGHT+IEiG1Heztw+sAzc6C9orRdKxxd8nUg5Hwrgtqpqrdenw2oiLdlGPf8acbWrVKMFxCxLmp8gxM8EFG6JHJGyBFc=
X-Received: by 2002:a17:903:1ab0:b0:290:c0b1:edb8 with SMTP id
 d9443c01a7336-2948ba56285mr114949085ad.40.1761557127361; Mon, 27 Oct 2025
 02:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025102008.253566-1-kriish.sharma2006@gmail.com>
 <CAHp75Vc=LeYEowm4HOa4iPJSMQmu75ch-wbKT4WNOyWvYH3u9A@mail.gmail.com>
 <CAL4kbRPy67Vkq1A_H_E=B99+M-09s7xWMYHCMPYFaCG0nMWWnA@mail.gmail.com> <CAHp75VcB9yLZq31zHa8wuE2DtxJ0j5hoco3q=F4WG8yDuTrtkg@mail.gmail.com>
In-Reply-To: <CAHp75VcB9yLZq31zHa8wuE2DtxJ0j5hoco3q=F4WG8yDuTrtkg@mail.gmail.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Mon, 27 Oct 2025 14:55:15 +0530
X-Gm-Features: AWmQ_bnQqMCu_7fuK1sZJyFkgn5UMbNBZRiMmlLawMoRHvGlI9KxSUmDU_eS-jM
Message-ID: <CAL4kbRNi+B1Fm9fnEvmLS_n1SWQnb+BC=xht4=qJOrnEUqqGhA@mail.gmail.com>
Subject: Re: [PATCH] iio: document @chan parameter in iio_backend_oversampling_ratio_set
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Andy
I've sent a v2 that combines both kernel-doc fixes into a single patch.

https://lore.kernel.org/all/20251027092159.918445-1-kriish.sharma2006@gmail=
.com/



On Mon, Oct 27, 2025 at 2:24=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Oct 25, 2025 at 5:12=E2=80=AFPM Kriish Sharma
> <kriish.sharma2006@gmail.com> wrote:
> > On Sat, Oct 25, 2025 at 7:05=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > Is this the only issue with the kernel-doc? Can you run manually
> > > scripts/kernel-doc against this file (with -Wall) and check, please?
> > > The change itself is okay, FWIW,
> > > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >
> > Thanks for the review!
> > Looks like I missed another warning in the latest linux-next:
> > Warning: drivers/iio/industrialio-backend.c:1069 No description found
> > for return value of 'iio_backend_get_priv'
> > I can send another patch to address this if you=E2=80=99d like.
>
> You can combine in one patch, there are no strict objections for
> fixing all (small) kernel-doc issues in one file at once.
>
> --
> With Best Regards,
> Andy Shevchenko

