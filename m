Return-Path: <linux-iio+bounces-25453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED4AC0C887
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 10:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026A519A147C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569AA211F;
	Mon, 27 Oct 2025 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3nkzana"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61325486D
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555271; cv=none; b=Ln9L/xAitZJzuT+rxGjhsopYQeHKtO3DfIzyDQFKWyeyQVodq3RdWK6+Yqw5Obnt2GAjhIY5umNYv352xD33nDOtdbIRvZZa+U+2SEqXWxxhE5JeEO4dYEq5Zll7dV7FX6FjKHjpkFdRKfJuk1SoCNTFt4TfYtGS/0zzTHaqVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555271; c=relaxed/simple;
	bh=FylS99QsA9gxDMDoBp+srgkQTQf25jWk722m3FG0juU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVqUKexy5GSwgkPbOfz+lOtx3N0/wwhW3argEvhQegejJicKzI1jGIii1cVkGFSvzyGJodCj3ACN5OYrBChFYbjh9KyVGh16aBUll3igp3eNygLaPiNJnZiPQQM1QuorKQ3MnTNx2mA5UG3jEKTbT6EFSeRLnLAG/RxXNPAc6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3nkzana; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b64cdbb949cso991887766b.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 01:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761555268; x=1762160068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FylS99QsA9gxDMDoBp+srgkQTQf25jWk722m3FG0juU=;
        b=B3nkzanaTS+DCfJQQdTa9/I8Bw/9RQEZandVY4kuTqat0+LCgUjY8hJYQovj8rRxgK
         unfwJ9eu2+A3c9UTGMG4Hkm/NcaO57Lfm/6HREEUbRFZMYfDA7ujWLrKA1rlA1oa8RnZ
         VN8Ae2qIp16R43Z0H+k3FotvDr+qBOiYHbe6vnJkkTCteBtiHdAOAkG3vFdJ/9D5UCVs
         tPOigPLMWOJMwf0wbfA3a3AQSKlpxAhA5+xIpxFR3Ia/z8ntNjo3HnjS4SOovWOMvqD3
         JBIMaWd4gsJVnScBRAR6lAtkeDFESAnxSKwQ5dRSHhpeyqVI8d5QQc0ZykA21y8xZ1V3
         UyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555268; x=1762160068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FylS99QsA9gxDMDoBp+srgkQTQf25jWk722m3FG0juU=;
        b=oF4rWfrMnzicZ0oIC8ET7yZZvPSod+++JHYEEE+Prd/vnaOw1hIZcRvICatpnlzqmr
         UdKpnVgOZgDHKbd81kGOT5udksC6GryK5fbkNsQqd/w+K9GZYl0B8WXMHTbPEBBiyaf7
         M1/J1Z1W7lZZnnUY8Y5u0LGDp1kr/T2CFoLTcDV8ErWU6BOav6qIaqUdk3ZfyXWU+rpK
         fOpoetSH8mHKJkyWYuBR0PcxznuujR1lhZE/aiq/T30zkAHhCRxxizZcdgpVt3VLxfEl
         C+R5C7kWkD11HZM67MLdoPQwvZDPYikOm+XcvUucc2pXQ4pvD6ACqCuGbK3vJQX2xNDv
         LzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSXv8F/Cr4/ENv90gTcihbtYjVBBLFOJHeyJ/crceJPRp/BzF9fIGnrjGO2hsjO5ZWcj9LXffvSBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgsFORGqGRxbJPWrBJBEScWl36VB6xRxGgmbUhIUJMUUYtZVw
	3Ef4I9My2XFhkBxZnlCkk6F8E64AQxUbrIF9xej71Xr8RO79SkO3OZLKP/9h6am7BzXomCZq2I7
	mhFCVw1WSfBvcHLf5hFacr6Lset66hLI=
X-Gm-Gg: ASbGncvhfC3FsWtggHDICJCQ03EftHIKH/sfBXp1Qam1kYQrmo71j0ZvblwQcIRBJxW
	2FJ6PBpIHyslHw67Rww855d/nxaEPPS4F6/oC9s7Lo9ia3mLQKos6Yw6uroy+nN2m/3op/rs0en
	b3hjT2WwVyW4fmU5kZIHnAEYyc4IOGtHW46iFY+fzATuRi5k/zVpJa0BZ6o0uSJRkwnTsmWUtCs
	dlKV6gLozTfDyb1OCb5XZN/diT54pPbI3rmFFbZP/fLYfw7ofuKktuuULBdiyDlhtL56IcJ
X-Google-Smtp-Source: AGHT+IEEwsR8ydlzzYHSrluue6vFNPLtag30nDyQMzqddTjn2d1HRqClZfBAQvsrpP8VYxX+CJLuItx4f2kKSyEP5D4=
X-Received: by 2002:a17:906:c14f:b0:b6d:604a:b89d with SMTP id
 a640c23a62f3a-b6d6ff25f30mr1222691966b.33.1761555267505; Mon, 27 Oct 2025
 01:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025102008.253566-1-kriish.sharma2006@gmail.com>
 <CAHp75Vc=LeYEowm4HOa4iPJSMQmu75ch-wbKT4WNOyWvYH3u9A@mail.gmail.com> <CAL4kbRPy67Vkq1A_H_E=B99+M-09s7xWMYHCMPYFaCG0nMWWnA@mail.gmail.com>
In-Reply-To: <CAL4kbRPy67Vkq1A_H_E=B99+M-09s7xWMYHCMPYFaCG0nMWWnA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 27 Oct 2025 10:53:50 +0200
X-Gm-Features: AWmQ_bkG2lho3tGefkbYnxp0Rg5zaX9UQwGIMCg14KvNjAU9MvWOzf6DdMthcZw
Message-ID: <CAHp75VcB9yLZq31zHa8wuE2DtxJ0j5hoco3q=F4WG8yDuTrtkg@mail.gmail.com>
Subject: Re: [PATCH] iio: document @chan parameter in iio_backend_oversampling_ratio_set
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 5:12=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
> On Sat, Oct 25, 2025 at 7:05=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > Is this the only issue with the kernel-doc? Can you run manually
> > scripts/kernel-doc against this file (with -Wall) and check, please?
> > The change itself is okay, FWIW,
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
>
> Thanks for the review!
> Looks like I missed another warning in the latest linux-next:
> Warning: drivers/iio/industrialio-backend.c:1069 No description found
> for return value of 'iio_backend_get_priv'
> I can send another patch to address this if you=E2=80=99d like.

You can combine in one patch, there are no strict objections for
fixing all (small) kernel-doc issues in one file at once.

--=20
With Best Regards,
Andy Shevchenko

