Return-Path: <linux-iio+bounces-23010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F513B2CBFD
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 20:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF4F1BC5F44
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221B130F816;
	Tue, 19 Aug 2025 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UID72hXj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5135130F54B;
	Tue, 19 Aug 2025 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628132; cv=none; b=bUTNsBzFjQhigzdi3tpCsh5J+FsoVEh548yVB4DWrSIu/yiY6GokGlc7cr2/COo0P/NPi334jkkz+AYUNuHDC2KWHUiX5GA21QpjZmSbgdQz2HwxGFHKAtiMCgU/FoAd4DIoF7/4gWgWMHlyZhGxMDzB2B+lckAiPyHQpttEWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628132; c=relaxed/simple;
	bh=Lup7pLJ0rHa83q3S/pYxZQ7O2fwQ3EsCk5nx5UrX/tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhtjYLGqbFcdYJqXBlheKomzxYoFlFBuvD42SjPbXcp+I7fDGgVbyezkmnnTg9o5VVEoVkNfgacZLg90d8+tfM/d3gWU0RsON0ti02Hz/UbXghnx2guZzFKKOBKsVYf3FbMxvlIYr93697SbdJsLRaSWwyHwL1suz86IYzltEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UID72hXj; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ae31caso1010906566b.3;
        Tue, 19 Aug 2025 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755628130; x=1756232930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi3M08Gy0PoAc8Y6YQtFVDIBLGpr8qeW8qRK7d3r3kA=;
        b=UID72hXjZWV9G+f2SIiro6s5LVesXwu52njOMUCjP7BZd88pxy+ysxeDCB4qedXdfX
         ++pDAoaoaJX+Hw6NaGPk4suTHJYI0df42M8twwmTYyxy+rtLbbOtCRdh12iHMWiO4lnX
         cA7Wq4nMKWR7+6J/pTwCp0wVm+fOEPgYw3eajw4OJGkqup6OkW3Y3IGn+T4/bg12urs+
         MbNBvjmTJq+Gh8UAK/wy4QuUwqvvM6B4heHeT7HzV1hH6LmLf+GzF4g7Mt70+s2lKxRB
         kOaME9/dgFBKJqxOUqMcJDVmFgdDPfAvh/zRHZtPGj8PyiL6QXlWGs1ukAFVcx64w82g
         Pvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628130; x=1756232930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi3M08Gy0PoAc8Y6YQtFVDIBLGpr8qeW8qRK7d3r3kA=;
        b=FZpknfr5TkLZ4Jxic8k/2X9z8yWZg3lGcquELHsXumNXdooQMB8nd0mw5Z3YtkWHxa
         L/oHAay3yXZMsCYB9Be28kejtMbxFjYwY/e0Cft8hNRCtepvatxhftZqvYE1F2/459B4
         5Iw3UYUqrcmmI2zTNyd/kI0cYurz9WABVGabsEzo7aJJA74tcQIXS2Lg1UHizETgFkhR
         RhX/scbNlx7lRNA2vy9PHH24Qrm8I4yB3mdbAb7coZLlo7q9wLYFqfFLiLuMKetNXlGn
         BEjxdxEC7SYEBQJgFRcgAnTm6ufUy0UbHUrfD8vogY7zw+BdiTbGr+LqJX6jjW3h5upG
         c0EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcPxnWtYSBJKPU/Uqr5YwHX2sdpcXXnXNS2eQkJpMZfP36zGG+IGT8aGFZr4kIp1D8atToGtAjTMF2qUuV@vger.kernel.org, AJvYcCUdWJQv83ahmPNsSJeiCJ7+dyuJrisjUBO4AmvMIwYV7HIQNT33sMDttrfggTaco5ECIOiW9FFUJzLp@vger.kernel.org, AJvYcCXCRf5CyWSYzJ8hpCMtEaPUcd04mBRfjm6Rf2Mo+gudpMSLphd4H+h9TVevPHCpjUBNyuAoJfkJXTPr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnsfs5NGN7GGV+XFG3rqJDGgZF4Jm2qsP1SVxuPkxUZAurn6K1
	2r5Yj51Mz4e7R2KMkY/DalIB/sv8e4Xv9IVJUrdea2EN194Gog/zDr/RPxpcwHZf9aJO4jD1ZGd
	8VFFCbaLeECTbBMAKVmFMCG3uzxKXl/s=
X-Gm-Gg: ASbGncttTC0HrJrDO4hFuYJsIYnmsiU6Z437KblC70NEysE08mm/eWmwFHsAT5rvLZc
	Asfqowv3v7ovMoAMkKSS25vryxq1HI5gmZYSgQ/Z0/iCsd2NQcGM5eqI8T959cqFCZjFevnyYPn
	J/DDH+ATq20GgQlqOTdm2WInvwqmFPPmHgqjCAm76BqJZlyfhcibHX8RfwC3gKsbDgBYLNGh9a2
	93ic9NPshJBoC9H+g==
X-Google-Smtp-Source: AGHT+IEeGP1LFIY3EXRErHwtTbv4M2rk6nG5tRrYGtcmXGZOPqtXI9ACwjR9P80bcK39Tu/AL10NJ9kb41SRcmv8mC0=
X-Received: by 2002:a17:907:2d10:b0:ae3:6ff6:1aad with SMTP id
 a640c23a62f3a-afddcbb6b4cmr359441366b.14.1755628129253; Tue, 19 Aug 2025
 11:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819150448.1979170-1-salih.erim@amd.com> <BY5PR12MB4212A540F9799D6F326003388B30A@BY5PR12MB4212.namprd12.prod.outlook.com>
 <20250819184442.25f6904e@jic23-huawei>
In-Reply-To: <20250819184442.25f6904e@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Aug 2025 21:28:12 +0300
X-Gm-Features: Ac12FXyqadw1CvxKvYip12xTlF6JPr577hQM-tFyzXAossPM7HYZ5j8d-rvSi58
Message-ID: <CAHp75Vf-daUx1H7+PgeLsvpQsEJTV_9AVdkudCab=KVUw2grVg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update xilinx-ams driver maintainers
To: Jonathan Cameron <jic23@kernel.org>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "O'Griofa, Conall" <conall.ogriofa@amd.com>, "Erim, Salih" <Salih.Erim@amd.com>, 
	"dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>, 
	"andy@kernel.org" <andy@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:45=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Tue, 19 Aug 2025 15:10:15 +0000
> "O'Griofa, Conall" <conall.ogriofa@amd.com> wrote:
>
> > Acked-by: O'Griofa, Conall <conall.ogriofa@amd.com>
>
> I'm not entirely sure why but b4 only picked up:
>
> [PATCH] MAINTAINERS: Update xilinx-ams driver maintainers
>     + Acked-by: Michal Simek <michal.simek@amd.com>
>     + Acked-by:

Due to an unquoted comma, I believe.
+Konstantin

>     + Link: https://patch.msgid.link/20250819150448.1979170-1-salih.erim@=
amd.com
>
> Anyhow I fixed it up to include Connal's ack whilst applying.


--=20
With Best Regards,
Andy Shevchenko

