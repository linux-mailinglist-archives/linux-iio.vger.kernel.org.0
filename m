Return-Path: <linux-iio+bounces-26727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B21E1CA36A9
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 12:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5AB230DCF7F
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 11:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83022E7F00;
	Thu,  4 Dec 2025 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO1to1Ab"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B32DC359
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847257; cv=none; b=Y0MaV+uPs9KQvxT7ji8Ag/2unyHFFCBWao9LqwHCLQsZ2ZhRSMLAZCxeQxtvNMAk7NwOyIxE2BwGfddMONdYbDj/66zK7nNsK5tcneRL+mlZzC2mapzLuufNh9v95imgtQUBgqNFA00HdqQezRyc2EBXnYWKLyVU19x4f0OwmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847257; c=relaxed/simple;
	bh=pX/Y2qHHQuJdoY7Nj6TLZScxT93HDvgydCAJHn1NTUY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UGJup0A/FNJwTQCDboNJ+7Yi/V5d1pgiUOVoYalRg58Ld/c6DlIDWB5mW2X3QGcekpErXsoyP8EUXASNtwNrRKPpBsNMWciZwPnrsXgaqxYMGgL2imI6D6QSLrEztBx9hIjqZqQ0G3M+En08DYwe5spVq9OUppiDyYajXoQRRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO1to1Ab; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477b91680f8so8027685e9.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 03:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764847254; x=1765452054; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+V/jd1hrDdjmCSV8L3bsesujq+v5N7N5mczmqtAzPM8=;
        b=fO1to1AbewcD6PB87AASFwjn6Fi0n1h1pkeKr9r8pdHyIcn5EgBaVR0L0gTnrkiyrU
         MLIvxjlBXA6L/m2wBppSwAkXnpC7nkPSIBMoeo1KkyG9dg5EEGGzKc8ZbnPBMnIBQ+YA
         9q4wDeVYm1j5KWg/mQb61V0UnE75SnoEvBS3T08zZ85lfmzoYnFJJ67Kyw8vM8gNEl0T
         ZRTQVWCaRoAVVJo79l4ju6MhJwZPHg7r/Od4Ze8KQ+wnMSihEJMV6tUKrIkUq5vXE9tA
         RzQWFsK0Uv2qyCo7wqGbDWtMS7iFlOETbR6LztWg/VAeQfvzHzoAcd0lbUnnAhyiu1xP
         sjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764847254; x=1765452054;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+V/jd1hrDdjmCSV8L3bsesujq+v5N7N5mczmqtAzPM8=;
        b=CIxrHpi+Wj9maRzGVsekAn1BrLY3vlAK2u1+dvbHyA44HGiM/M4rEt6qTUtX89wjVe
         qEuutPJMJOkH+Rv0OmExWA4/oXMiWbNcg2Cp4vwWYvYDnk2wjDpe9XAy0Tpr3DUemizc
         Ll1XhlxloqLquDpSeBNe+QjfhPOb3Mn+jJzBYBUJH2H0p2n5XMLLgFLODdLQxR6cigLn
         dOi5pS8ZH54UDWYALN6J6uBeSCW9gSnyY6MKvPr0N15GyUkMS028F2bGQEYH0DLM2hXT
         ddlIHTWN+1Qwih+du7L6jAa1iM2Mwz8CY8XwethCr0tqC6ahq2+COKDXFOt97U7V+2rx
         3KyQ==
X-Gm-Message-State: AOJu0YyaZ8PmSq3sW1ADWQeruSD7KK6FNGDw0zDhXErkRqQTdnkgl5S+
	RnUsfaFkrCROa0ZnIFn3vbz7GtcKb/tV2jHeK/p4BMabr60yxUULFZh9
X-Gm-Gg: ASbGnctQllfaufjhfueQaP4FTxQ9NemB/xoHcA2iiWRwQvcGyhbthTN6ZfwYiYKb5ef
	NQ0Nj+L6Y8eisOk3REFk93Q22FAKse3jBkRj3Hl6/B/TT7VoSf3AFQzh2BZ3WHphpyGKehMDKx8
	LhF3mSllQ4DT6E+7YGgxzai1yvg7Gd5Wc9yQzUH9DPUleYmSriOvnZcKo2la0NbystRApbb/4gF
	0FNOufc4D4wBF72sQumpoPjIsSMii8kyDStcV7pNfO69W0xMnTexIhhUnF8nUcFJ9Y3TWX4N14s
	g5uXw+iQ24l+IjdWgRosk3MgTi8uFoZZWR7F5/iBeSfou1hdQb4PgO/2cxbPY5UW4ME8mSPaOLt
	1vi+Ng34fzFT7XoypJ/zUhSiuWwjGkslhZohdiG2jIZOKgdZRt1yUGvFclRCsk3VOp4hhfJ9yap
	/BpLHZAkcNQSS77WoK/w0=
X-Google-Smtp-Source: AGHT+IHHL0Pn3x7hpgzx9JCpCTmuHVgdJY8XKaDpVk2HK02TVV3ywWTlhSq9ISZLx3wcMi4xE3IVmw==
X-Received: by 2002:a05:600c:4443:b0:477:9b35:3e36 with SMTP id 5b1f17b1804b1-4792aedfbf4mr59408465e9.2.1764847254392;
        Thu, 04 Dec 2025 03:20:54 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310a6d9dsm25539915e9.2.2025.12.04.03.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 03:20:54 -0800 (PST)
Message-ID: <9f42333103ad4a0703f557aad7a2b3954ac55fa8.camel@gmail.com>
Subject: Re: [PATCH 6/6] iio: buffer-dmaengine: Fix coding style complains
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Date: Thu, 04 Dec 2025 11:21:34 +0000
In-Reply-To: <aTBmT605yRjGtTR1@smile.fi.intel.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
	 <20251203-iio-dmabuf-improvs-v1-6-0e4907ce7322@analog.com>
	 <aTBl9U1KS__Lkfbt@smile.fi.intel.com> <aTBmT605yRjGtTR1@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 18:33 +0200, Andy Shevchenko wrote:
> On Wed, Dec 03, 2025 at 06:31:53PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 03, 2025 at 03:11:41PM +0000, Nuno S=C3=A1 via B4 Relay wro=
te:
> >=20
> > > Just making sure checkpatch is happy. No functional change intended.
> >=20
> > ...but trigger the fighters for 80 rule!
>=20
> I believe
>=20
> 	scripts/checkpatch.pl --strict ...
>=20
> should catch this up.

Don't think so. I do have b4 configured so that --check runs checkpatch wit=
h --strict.

Checking patches using:
  scripts/checkpatch.pl -q --terse --strict --no-summary --mailback --showf=
ile

- Nuno S=C3=A1

