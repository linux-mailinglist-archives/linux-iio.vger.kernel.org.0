Return-Path: <linux-iio+bounces-27690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D766D1CF80
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27BAB30239C1
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3B837BE96;
	Wed, 14 Jan 2026 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVLIefO0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2C52E7BB6
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377364; cv=none; b=VAT0Z1n4XvrqX6ZtcUPq+X7bVXwz24/jyeG8+YtgdSNtgfpPE0LxIC9wxX/sjwsIlpRveGIsAOJNFjEAw1Rhegym9ETn3aXMnapeTWWFuF9Jrxv3XwojSqBQC1uvMH84PMfscTvxzMp561MjpAYZGTXEZ6Kpz5mcnBRApC5UQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377364; c=relaxed/simple;
	bh=qykM1JYbULj151QKzbc/hEiAVXe8AXiyAC3x5F6hwNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEbNAcTULQBpjV/jY+9Qe7hgarR/oprW4Cc0vT/L2dqbdvWdeSRYVrFzfkMYbl4JSkqt8HBpHn2TYCXmDqnd/xQP4/AeuZR4h2t7BAtXjue/HUUrVyYhNBnPY+m3wM2l6141sSsT86XFSxqoP+dHuAG0ITwR1/Ovk34cw4Sqk3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVLIefO0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so14486036a12.3
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 23:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768377359; x=1768982159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qykM1JYbULj151QKzbc/hEiAVXe8AXiyAC3x5F6hwNA=;
        b=mVLIefO0pTPrZbdi6zYFlTo2PoXY6Tto9cq/dgBCTVhGk33OX4Mx+ZIt8u656FIdf2
         N33ALNw0AI6gJGyipcVEe9eTWDQIiYhPAHl2CiaWJGGhrWkMlypH/VAiMBUcfH1UZ19f
         jKsRKoR75f6V8KD+6+3b7JtqTztEvqQQ+0u1b3U0LbD3aPXziOJu7I9hcGYnQGJHNHA3
         Mf+bBo6XY1pNIKF/II5GGRwzM+Lh9rYOHWgGl3pLukSVb9fJL9ijj3Ek6OG0xSzssyeG
         y3Sw7UphyHcLH5nsyWmUTXnovCEsvFLLxe/V4a2fVxG2JXupPyjv6KgTNQBe1ylj3V/2
         dboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768377359; x=1768982159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qykM1JYbULj151QKzbc/hEiAVXe8AXiyAC3x5F6hwNA=;
        b=iy3YWEvsF4KRuODEf7/2pLN2W9q3TGdD/Evf/8MJEdtfPcwV6fIGN285QrdeH7C5o4
         auovPH4/ESbFaROek7WpzWt41xOR9eY3+9naE9JKdJXCOGLgNm7PoQiZlgUsDXc3w2en
         lp2Fa6lpQgnqcPeFk59H+X1UaDnPS/bWTaRAXt+4iuwltQd8kygXpJh1X20xAJWWkMot
         iM2IKn85YAJYwX+slbUhDpVWQWmvYXe4uszofqNkB+2lZE6ci6FwfhiMEMiPNL/kMjid
         q7rimc9GKkFrSMpAVU01nBfJ1vDOJbDGMuH4sjAzF6rBANpnFexg5vowg5hJ7ucIHWzh
         +vNA==
X-Forwarded-Encrypted: i=1; AJvYcCU5l/gU2kjtBHZyVE0H8G9Wqv3OZtsKefn/+iLS7v+wTuDlZrOpnfLM/YpmalzFqVXZl3pdtCzsjvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXE5fUOQsh3eVPq4H77/v354gNT5Sm6eqKa612DyENC/LDOTAq
	TyLEICn4aeL9LfEYeMHVlwcCvQvos4s3nNFz4HSV0Qh/vC87KJs8DkqgKDy1mFqZO2430qyCcxe
	0BXMTrH4tj64BrGY2B0MWavDo/8Hp+04=
X-Gm-Gg: AY/fxX7HW/zJjS/BwNehfVPcVkgd7zs/ubrGugsJpOxjjsrpOOL2WVw1adZSbxUWdrg
	BBwi/EZ5xeU2lIjZSSUAZEjMJAp+qOXn0QI1Sme8hGtyPJ7M7HTJT+tspBS9ohLfAwQY9xxeJAI
	+LAXcf8NGBMuef409ygoq7fUQJpz70NBFOv1+TjHA1yy0wRq8E0xQTTAMTe6LdgiLphNTfLJJnr
	wbqhp+cdOA7CR+MFY0vv4CQim3GiwraoJGaKD/z+TZtixPfLR+tvpI3fYEXjHa9aIzGB3n6jL8Q
	FK4oJzZUdWdAqwr2aQOCBDj6G9sJpvNDRERFEFJN84GVQH8aOeKZjW1q8xAYJYKq0a3x/BE=
X-Received: by 2002:a17:907:72c4:b0:b87:3740:dd87 with SMTP id
 a640c23a62f3a-b8761028cb8mr153119766b.26.1768377358593; Tue, 13 Jan 2026
 23:55:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-honeywell_abp2_driver-v6-0-231c3a8c222b@subdimension.ro> <20260114-honeywell_abp2_driver-v6-2-231c3a8c222b@subdimension.ro>
In-Reply-To: <20260114-honeywell_abp2_driver-v6-2-231c3a8c222b@subdimension.ro>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Jan 2026 09:55:22 +0200
X-Gm-Features: AZwV_QjeZfZf02MH8c_Fn9ULWM2JP_J64viMY4LtyiOs2gGz_6slFb6GduuSBKU
Message-ID: <CAHp75VeUkNEHeF5ey08AU+drZKunL5PzoSJ=0JPXzc0Z2Um3ng@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: pressure: abp2030pa: remove error message
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 9:52=E2=80=AFAM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
>
> Do not print redundant error message if devm_request_irq() fails.

the duplicate

(It's not redundant, it's duplicate because that API prints something
very similar.)

P.S. Do not send a new version for this, I hope Jonathan can tweak
this small detail whilst applying.

--=20
With Best Regards,
Andy Shevchenko

