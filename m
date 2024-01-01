Return-Path: <linux-iio+bounces-1387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 428988215ED
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jan 2024 00:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B337B21089
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 23:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F22EAC2;
	Mon,  1 Jan 2024 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3ilqQlh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED6EACE
	for <linux-iio@vger.kernel.org>; Mon,  1 Jan 2024 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-67f9f6ca479so70269026d6.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Jan 2024 15:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704152387; x=1704757187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhBk4bt9xSguL36J2Cil7OJ8uQHHHNYnayRBkIHAUx0=;
        b=e3ilqQlhfA8e3AvOCA//gw7oxXYTgFvIN+y9SEvwHoawFYnfGUs2yL1woViDfb5d8c
         O6dTABsrK1/hanLzPgTy5x20CJZRuME6hbStOQ1KnaShxA98/Uzxx8Ii2Z+qWaHex8lR
         KVdMrFKhr3YQCMarYooiKEeH7R+ckkQtJn8wNV4UA0bodW0fquwUDvZlmtocYpwTqXqI
         Y35PC+qyiAoPlgvK11x2j3pmbsqaMrav/t1a3U9i+uoeeGob9le0e3m7ZqJ37KtBE11c
         D91PT55cY5KD+kt2RgW40EYjhlO3m2ztWyxE48s4SKV4Mw9EHcT56/3TvdNxjtOSw5jo
         7gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704152387; x=1704757187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhBk4bt9xSguL36J2Cil7OJ8uQHHHNYnayRBkIHAUx0=;
        b=iXeqvMarVCFk5CRV8PfMudP9XgM+vY1ganHLnZoMCVhajUh5Ip6M/qJ9YMlTNQAADB
         6vlg4IY+wJgMVT99BKblsxuUTwBcI0rENARZv0l39iJyOSVTNjAQxU5bpLEqGUFCNr0/
         YxwAjOASoQ5L5kZia0n1o3idbvLasClwlpy1ETXMg/gL9SxBeUX8IKdzvb+kVb2fpc1t
         K8LDyLusCOyDEmbKPWlCrsaG5dp8xP9HMhH78NiA6SUjXTdK4wIG+74uOabyuB9K9556
         gAwI8bLlJeqLVAUk2RXkQU7+ca7edS1B0nt+MFGgMeigofptDqjykyz9cyMPAGsvp++q
         YtiA==
X-Gm-Message-State: AOJu0YwvhV3ov/ehp9nWV9BI4wh0Bb7sj594Qcw+K7kw1gj+n7xJw0N1
	NeHzbeGBShckOa44/d201NvaTvvJnJJPJV3O9Jc=
X-Google-Smtp-Source: AGHT+IFbWYz3ytmAc64Gkik9BKiEPDk2b0FHIOfiJQ0MBn4cTN0LtjSAa883Byarbe9MGSblQfA6847uewYE167/1G8=
X-Received: by 2002:a05:6214:21e6:b0:67f:8bee:a1a0 with SMTP id
 p6-20020a05621421e600b0067f8beea1a0mr28814578qvj.60.1704152386794; Mon, 01
 Jan 2024 15:39:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231183514.566609-1-jic23@kernel.org> <20231231183514.566609-6-jic23@kernel.org>
In-Reply-To: <20231231183514.566609-6-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Jan 2024 01:39:10 +0200
Message-ID: <CAHp75VdxcQXF9PRf+aNbRc7THHpo7H7KRvUD0yZO+NTQcJm69w@mail.gmail.com>
Subject: Re: [PATCH 05/24] iio: accel: mxc4005: Drop ACPI_PTR() usage
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 8:35=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Avoiding unused variable warnings when using this macro adds
> complexity that in simple cases like this one is not justified
> for the small saving in data.
>
> Switch include to mod_devicetable.h as that contains the only
> acpi specific definitions needed in this driver.

ACPI

(and in other commit messages that repeat this text)

--=20
With Best Regards,
Andy Shevchenko

