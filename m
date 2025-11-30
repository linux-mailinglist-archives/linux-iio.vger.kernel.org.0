Return-Path: <linux-iio+bounces-26575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8EC95285
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 17:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4800D3A32B7
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2592BF3E2;
	Sun, 30 Nov 2025 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esDBeNIv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB4D298CBC
	for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764521321; cv=none; b=cLk8SKVYz+kRFjEEjwxYedIxvGkEpnL1nGawiVrBipu3ScwL47iTLgcVeeaFJSm5MbVsrv/LUTxBeXqc+lhxfU817z8dkMcCbYb/qiz8ZrSEq3F16tYkf+aUPRsrlRB29/66G16OWnm2MpPv3L/u5IUHeyraBHkwYKRZsGPRO1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764521321; c=relaxed/simple;
	bh=ewwbrSniQiaaq2IUmPj0BN6zwOTSyC+nq1Rct+ZQLWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNo1RJnz6YubVeQKlyTRvbr9dMfdOuxfp9ctutDLhyqNkdkeSp2QfTdrjQfqrDa/mh/m10VQgKu0w4uPRI/daD82S/RImhD28Bjl5txcsetTAM4GZfPfNO784Cx/BwQVVSASfsBBaEoGLNpRSL+mfgzRbh8YE2a4V56lqg9lZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esDBeNIv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso6350530a12.1
        for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 08:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764521318; x=1765126118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewwbrSniQiaaq2IUmPj0BN6zwOTSyC+nq1Rct+ZQLWM=;
        b=esDBeNIvdoq5/KzFLC8HVTKX/liE9IK5Q/qls8Nx3o6Q2VNfjVT2YICdKsFhiASJoM
         Adt2t7327jPT6ysS8mcoUxh6ZLWPCvKfN0qcovWYgAKNd8xl4oVS508ygxnruDPFvvLC
         aOqMRFp3aamDWcny2b3RaJRE35DSSemdgHG8/QGEtpWDI15UDbV6DOlClUuNBUrbky8V
         e58SqbUIO2JYe+UvI7KiUXtfAxJ0zE+sTEJbuQnjAib92lvMtxMQlAhXmyekWmE3WEsE
         n6tAz8QCV2ye2GtQCWNnGgkG9Fu0w6mwBIqygIZheEE4tyUIndQMHIxH28IpvZsSeo9P
         eNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764521318; x=1765126118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ewwbrSniQiaaq2IUmPj0BN6zwOTSyC+nq1Rct+ZQLWM=;
        b=UcEyzdWr5uoHHk2iqGA/N/AXOrR53aQLMeABa7l/X9/zl/V1jMfword0/JR2eYqVQA
         BURkhbdC7iakhEkAL48zvBJGSMKQeVzueJ+BV/BLv37K+crWviBUWmatIlZbrjMxy3m+
         W9V9aYSg1+vbXlLZgo4G+AFul+zES2j34MK8xsawvPiGYl+jlGtQFui0LNyqn1EfF1rZ
         hMACryI810XsP0CviLyCq7D/cIVQEJKcAhfL60o5v3CqMFDddTbqQpiM5FuV9sPDNmFP
         mZlDRDDbaMfK30XDvWuSwCSQ/lJX0SYXmftkOyAoH9p2RW2Oawh5yoUSVaLFEzrTsf1W
         DCdg==
X-Forwarded-Encrypted: i=1; AJvYcCWxPqV1G/RTo6o0P+V8IeGsBAg9BjLcTJ1kPYdArxpW81Lb47etoRHA19YXLNbmc711onBG9JQ12nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPZFX6hXltaKn8uZCfiOHa3Fgy8Jkc+wWIvbUEAIDaZmmb+uUk
	+nLuB1pdaiPRZhfsbI7RsHk55uFmqCJoYkoe2JQugcFJC7U4yA2JF8fwaLQxj7eEpHPf+5RkgGw
	1C7UZuYh2G62HI7IVhP+nYAyl5ZI3Uu8=
X-Gm-Gg: ASbGnctrqX9GOBqcdrwsKxUFRtzuhekWLUoi0dpS1CffJvMC6BG4H2NvEc+1Ciwhkpn
	TgUdoa1X7dqrejoLklwijqV8aW8xV0Tf83mHx2cgwxQq8glAWI88nqTlEWBf4FZxnnswmpnQ9d2
	hN32Kv8BqeNhu6JZcga85Y3ToD6SVc84+Phn076p7Ast0HG3J8q1JH72g0S+8GtHD+hThfovImG
	ZVl8S+5jbIlrhhHn6kCvIIH87zZ14ULF/mcPVE6bjTpBsAzydQyqaw5L9K562PIkBeGFV2XM5/5
	8XNYTCGavlnyVMKU3BRx6xP2uJ2kZosQBj7eh4In5zx1acZFXlb72UZB84aPx7a/b71bi5MaAu0
	iR8zVB/c=
X-Google-Smtp-Source: AGHT+IG/r4z8LtpRhfPncU5qGR0fOw7ak3HUnyRk7PBijz1j1yOxUE/wu0XRbYBk5gRTmUKgpWv3Ugne214xpg9+EEM=
X-Received: by 2002:a17:907:1b14:b0:b72:84bd:88f3 with SMTP id
 a640c23a62f3a-b766edb7b14mr3971496866b.11.1764521317761; Sun, 30 Nov 2025
 08:48:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130153712.6792-1-raskar.shree97@gmail.com> <20251130153712.6792-3-raskar.shree97@gmail.com>
In-Reply-To: <20251130153712.6792-3-raskar.shree97@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Nov 2025 18:48:01 +0200
X-Gm-Features: AWmQ_bkSAYcsdWwqfIzLZ1jhQ5N49JbEIlNERjREOTB_qDo9y5iafT877EWk2uM
Message-ID: <CAHp75Vf00peRc843bR1fhCa_FP1H9=0J8VKVqjVfjLQ9m17UEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: proximity: rfd77402: Add Device Tree support
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, heiko@sntech.de, 
	neil.armstrong@linaro.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 5:37=E2=80=AFPM Shrikant Raskar
<raskar.shree97@gmail.com> wrote:
>
> This patch enables seamless integration of the RFD77402 ToF sensor

The Submitting Patch document suggests using imperative mode.

> on platforms that use Device Tree for hardware description.

The Subject is a bit misleading. This doesn't add a DT support (in
full meaning of it), this just adds an ID for enumeration via DT.

--=20
With Best Regards,
Andy Shevchenko

