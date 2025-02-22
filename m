Return-Path: <linux-iio+bounces-15948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0190A4092A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC39B17B05A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D5718A6A7;
	Sat, 22 Feb 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPs7DcuS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13070830;
	Sat, 22 Feb 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740235186; cv=none; b=NiQzEKjJsZGyfcLvdO5VSTUEtf2q0WUKGGpzzDItolj4VjpgvNLeGDLlU/qbKTcsg086qdUrxm0Y23cuLC9xxZVYL9hbodjucl3llxcj5HPcGxL48v9pciNIuSCthN1KA0SxmI3eK8YxTrDeXmPWbDqn+mmhyLEJjvfIALBtI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740235186; c=relaxed/simple;
	bh=PBmt0sYMIFhvFdLPyTV+3bLT9pVncOJVnlGTV+VP3VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXB32e+OVN95yX0FsvvG0O7WqhtZ8xvi+sirkKOgbr1oDXCqJpE3i5/nFthvJ9vkG9HkyEYoy3WXTLesSmuGTy1gn5KnRf5kZ+VFmag0aBSk+wdIdDVwrCXXa3rICKroc/NuRe+QQe3+1ZqLjTrcB2/Iiyx9nir/qkAHr89RDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPs7DcuS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f1e8efef5so1783986f8f.1;
        Sat, 22 Feb 2025 06:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740235183; x=1740839983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBmt0sYMIFhvFdLPyTV+3bLT9pVncOJVnlGTV+VP3VU=;
        b=jPs7DcuSlf/zyV13+3l+tDrD1mUi4714T6WYrpFWy5qi1HEyMz3Gpy4I3GNgnwOsC3
         2WYZKbQeWhpONX0DBxtSl5cda5gVmM1XI3pxw7vze21fOnt2HGVB7OhRLB8G+BtrrBKP
         qaoyoB8/YK5MpLin0xv+hanF2DV2ureCd0gZuIvULaqLn1FK0Tqv78f8Dd3czrRZoKTs
         r/z2JHsF9jwgYbvji9e9y5BI8g2Ec607w0+4xOfbOMQ0RJWz0j09dSpZUDWRaDjRP1nS
         pGAhcaAEsH+DpeXJQzIdz5zx7ufut88jLJJEBQ3akuS5XJUQKT+abL3OiC1dUMSqogPr
         rZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740235183; x=1740839983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBmt0sYMIFhvFdLPyTV+3bLT9pVncOJVnlGTV+VP3VU=;
        b=TqhiT86QwRreIMGn5CHGgJOHhPn+hLCxBYtpTp3Z2CoM0FuutPXLmxKCbhVBg8ZCvQ
         5yhIvafBxIwOue0gttFZBRJ7HpnyLHg2UdLjt7tqGUynoGiARzUOneSeG/578rVSiabe
         pt41+AX8OQpTHh9I/oMkp44wvYHuvJD2fLOP65obtJsJ0cVvNkP7v1YVM2S9NGnC/XlC
         oP6hkvYc9sHLkKSVCes6l6vlqFfyQMmhz1QkPHuMaxJClvDlBjubYkQlExYs5IuRhZL+
         oJ/dL44iT/K9R0lgUsq+3UF97Mcai7J8zaKv3+zMtpcGTxKtYbj+Ax0BEERbCzQ7bNfk
         uRhw==
X-Forwarded-Encrypted: i=1; AJvYcCUFc5omtoT/9JPp/4UMkX1hoOnkDIgLgWgaCfoFM3PPBtk+TcrIjzN8wQGm2VmrGb7n0RHfK3r9EMuy@vger.kernel.org, AJvYcCUfQe5J15+QWta0prHiNbESpPM3jIT/+u4NHanxFC98tPphhIOQD47JYOZC10W1jk4SW80r7jExazUoQtwi@vger.kernel.org, AJvYcCUlHsuSbq3cTv4VsrH15f1RFZX8du0WtTBgFcIwnjAYhFiHFJHFtuC9byismw3tvUQsiCWTAdg5D+GgMGY=@vger.kernel.org, AJvYcCUthXgKPR1sfiyHYJ6dbTzKw1bumJpD7UjdIUh7JWUKkVFBZC03rrLwJwJcMVyw0WdKkqwBy4p22zwv@vger.kernel.org, AJvYcCXcE0xY2QhRjW8QHUvnYrawMNuwF/XXNhb8/FFQP+OEZB8w5X+uYe1MtmwS/cg4nBe2m2JDSvYfNIrmwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKSWAMNnWy56H3fkgWC8xgXza3scTqpNn7HpaQhsmax/J4A8Ep
	AV+xM7Bu6SMygHDX+SrY6XaHgxvLWy2fFNYMG+guoIjtyS6hE08/N+cRqRRbDtwAWghJ7bRJBLk
	o278aVtkYgGrwWtkPlHUtJfSJaO4=
X-Gm-Gg: ASbGncuYsxSumrKZy5OdfniJDZqj6lUgWYquzJqEIjjr2HhhQb30ArY5gryMzR6I9oI
	IzNf0gfd/rESvyZrH/NgZ3OVN/HQl23sH54LzCM1LHb70f5iKTZ/kgqz6FYOYgArowoFsC3J9RF
	l7JY+7ZfNZ
X-Google-Smtp-Source: AGHT+IHhfsh8L7SoEfSEAPt4i71ayj8NVEs5Jlp8DnbYgaOEu/0ofJ6OfKwdPbxf6QtaA24Nr5hPTMqg2KwgIHxy5SI=
X-Received: by 2002:a5d:6d03:0:b0:38f:32ac:7e70 with SMTP id
 ffacd0b85a97d-38f6f0c13dcmr5144501f8f.49.1740235183190; Sat, 22 Feb 2025
 06:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218132702.114669-1-clamor95@gmail.com> <20250218132702.114669-2-clamor95@gmail.com>
 <20250222142910.4e6b706d@jic23-huawei>
In-Reply-To: <20250222142910.4e6b706d@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 22 Feb 2025 16:39:31 +0200
X-Gm-Features: AWEUYZnZiYzFm0aljnXobt-fG7MOBn3hu3PRi2D5FDNHFhs1inR24Sh-v5qul0w
Message-ID: <CAPVz0n0up=vkVzryYLauNCM2=hnz-o_ECm+ooXC8y=C2q+T_WQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Document TI LM3533 MFD
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 22 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:29 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, 18 Feb 2025 15:26:59 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Add bindings for the LM3533 - a complete power source for
> > backlight, keypad, and indicator LEDs in smartphone handsets.
> > The high-voltage inductive boost converter provides the
> > power for two series LED strings display backlight and keypad
> > functions.
>
> Wrap patch descriptions to 75 chars as describe in submitting-patches.rst
>

Alright, though why then checkpatch script has max line length 100 chars?

https://github.com/torvalds/linux/commit/bdc48fa11e46f867ea4d75fa59ee87a7f4=
8be144

> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

