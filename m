Return-Path: <linux-iio+bounces-23383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42566B3BFC9
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEE51886448
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566DF322C87;
	Fri, 29 Aug 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLywLSEx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62C322A3B;
	Fri, 29 Aug 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482479; cv=none; b=gaN+BwV/Ib1takpV8SiFGf2F6Kf7KWpw564Rs2zYCBWPSbwW5jFPIXhsbIyx7CVd4kd68FGYTH8yW83M+rvonp1WnaqBc6WyhlmSDwA82gOluVYalcMymV2tbIRSwc5LKn3qWGLvMKi0fGtpxjTHTgPtNoiZOvOvekR9LzJLpao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482479; c=relaxed/simple;
	bh=lnwOaQYRQcYYMVH8ncbgN/sEc5KTSu1MghIcOaktWoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8xFqjViqIKi9gDUaXTVVIAdpPh0N6YDLFAvpIM77xRp5k7+4RfwPPnnge2tbSANFGmnBDvEK/AxO4YXlwZfKLlDQNCSm+alEMP6SeEE6jGhJAz0cp4oNrUwJRR5DqCP+i0fTGKdR2lkQylpkzZ9BgvNgXhA6KZ6cAKzI3gmxgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLywLSEx; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb72d5409so384651066b.0;
        Fri, 29 Aug 2025 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756482476; x=1757087276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAJIIWls01qcbdO+Zw0VxcPwlrsbBbyxT5nPcRBFdos=;
        b=ZLywLSEx6h/sVFfSbp99BbtqFA9WOCA/FY+VZwox1dzlDneAb35o0Nd/XznWzPRDBy
         KFujILIC1eRQf/SSUOVSjZqbY3cU6os2xuLPDl25kR2o7vBwqW1btxI3y8Yz5wS9yMV+
         asAU5U972Idsqi7pr/Lio3Xz6WVcg/HlEnWjeDad7zj9Nn3I93cdUEGbgOL1EEE7IsJd
         oqFwi4fsQ9zVp0wYk51R6308+YRUssi7DK1Nb480lDuS4apC16pNRzgS7LEz+vyWNDrE
         B1B8A8Xa/DYoSh0me199h15ZCNb6NCy1gf++edCRv790RalpbKnADFhI4lpSs84y6rsJ
         L7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756482476; x=1757087276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAJIIWls01qcbdO+Zw0VxcPwlrsbBbyxT5nPcRBFdos=;
        b=S/fkhr0is2uWswl15whDvgOIVtJ/C/koSDwb1jDhlh5AkBJZqVM2e2cM3/EMjAtgUI
         EZXpZwRonvkijUcG6U/oKh9j91YDuTey/vgOQt8GOaefhCl9wMJaiaTSVfsqMOTeaLnT
         8a8nWOtPnqpJzsQ5hgkndoc2Om+0bdLZB+X5w1galtjxJhoMaFZrrKkTRe21C0tdqDaU
         LONMWnsyPbGgGulDqHHVhAJEsuVbSjJX/WdRfSd0asACdSJ0UdduOERFMoXZJAxQGsxs
         z65ngc44VgOaqx9jvZ4N3uQKrdHfr+wtmP2dcuiIFDYtgUgBodBZMpP/Gx0tGWM4nye/
         1arQ==
X-Forwarded-Encrypted: i=1; AJvYcCV548k3xBrnAXiNh96q9XJp075een6JjcvVXf8iFp74RJpwF6chmGoJAxHAAJlW1DEJL5Pa+3mbnEwb02U=@vger.kernel.org, AJvYcCVW4OUKK4SADxwv5i1liqP8jHdH4XoyPSXobCHj3/y07Y5YSueKSSunMY9c7Vi8MSKGCD63qZYL/kI=@vger.kernel.org, AJvYcCW4FgsN9oc1qq3hkwGJCgx9xOTCdjC8Ti2rFZIH4i7FLZAEjQ7m+a3zdWIboT6s5l1LGPHG+F6ALoAPoHnX@vger.kernel.org
X-Gm-Message-State: AOJu0YwqZNC2w45x6fHljSYAQ1asvmY2YREPQXnyZ/7CDKt5mme3iw31
	HkHBo0PKzCliVIt/BlD6N0GSIO5NnRn1TJIiageDTB1agJcOJIDC2zIfWxIrnBPmAyewxhz0hAz
	jY/XWUJVg8UA3cfBlwFH4I8Ne6NEPwB0=
X-Gm-Gg: ASbGncuwxdWQXhOXnIhMwriizzEDholLfQcbZijr/lXXwZcHODq4MjoGp6LJVmvRvM7
	V59uA85iqFCjSeXR82Q4qmHWmoygiLWjrUqY0p4lx2TNPlI2NgR1i72RgOdGgvkOeE4VEWy8sjd
	n6p9OWQx1BLRbRLh62rWQkppOj3uhmE/OcwUoDQEQ3X65j/0YPHWtwBqMYqUV3bk4XS1F9hq360
	RPzp32qegIpQ+lRsA==
X-Google-Smtp-Source: AGHT+IFJq4hKgpclpLAzxMbJKPxkfTuTBk+yeSHiyUHSoi5ySksUHWMjTOQ/E9rzP4cQzVNVXKhPw9IIS83Ir4FS3n0=
X-Received: by 2002:a17:907:948a:b0:aff:1719:a477 with SMTP id
 a640c23a62f3a-aff171a7dbamr84852466b.31.1756482475759; Fri, 29 Aug 2025
 08:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz> <20250829-88pm886-gpadc-v1-2-f60262266fea@dujemihanovic.xyz>
In-Reply-To: <20250829-88pm886-gpadc-v1-2-f60262266fea@dujemihanovic.xyz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Aug 2025 18:47:19 +0300
X-Gm-Features: Ac12FXwHNw5zWhs_BHazXdsjfePEaiLMfI77QMptP_oixXXRAfk8XbUX9VDuX3c
Message-ID: <CAHp75VdxGs-tifyD+T+H+TPq9ZY0Oz5zfKsoqf2uuekZCnfizA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: 88pm886: Add GPADC cell
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, 
	David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 1:18=E2=80=AFAM Duje Mihanovi=C4=87 <duje@dujemihan=
ovic.xyz> wrote:
>
> Add a cell for the PMIC's onboard General Purpose ADC.

...

>  static const struct mfd_cell pm886_devs[] =3D {

>         MFD_CELL_RES("88pm886-onkey", pm886_onkey_resources),
>         MFD_CELL_NAME("88pm886-regulator"),
>         MFD_CELL_NAME("88pm886-rtc"),
> +       MFD_CELL_NAME("88pm886-gpadc"),

List seems ordered, please prevent it.

>  };


--=20
With Best Regards,
Andy Shevchenko

