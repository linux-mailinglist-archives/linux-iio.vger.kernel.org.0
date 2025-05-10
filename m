Return-Path: <linux-iio+bounces-19409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4FBAB255C
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 23:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFAD1B6303B
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 21:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254D91EFF92;
	Sat, 10 May 2025 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jziadjWl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C04685;
	Sat, 10 May 2025 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746913207; cv=none; b=VAuB2nw1Oa7BTJueA5u3c/59UW6plaFp5eA6bN0IL5NSqKwAarypfXkxSgXWb+8Muv4+ahvfNlp5DFuvnm+t7ad+sKAjbLHGmUuWC2FQh2gZv/mSMfx3ngHDxlVnUJi/i1K4sA2L7di0+aGND5UogJdxk0Q9Vc2Y1lLQqWU/53w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746913207; c=relaxed/simple;
	bh=ZGCJs8/+7SziRHF07Ccgt7veBSiO9g4qhAv1dPWEfz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=It7+F2wBw4J835l8NGZRTyja66J6Twn7ylZsHG3RVvjGPNx8QgRvBeUo+CnV+trGiZMjeUUdIK3s6iDDCTwYJIQBhj66JLBJABNfQzBoR0DnMJ2HFaWEPy2HcrW2htAEEbze3oVKES4IjHdHjTZ+DjQMnyF2ztiXBNp8U/bWZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jziadjWl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad243b49ef1so85940966b.0;
        Sat, 10 May 2025 14:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746913204; x=1747518004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGCJs8/+7SziRHF07Ccgt7veBSiO9g4qhAv1dPWEfz4=;
        b=jziadjWlFlCFv/bICM2cif8HpXo5PeAG/ZnoaQhc/Vdg6XUBwC1R0g2P0zIooetjMa
         0EL9b3mmRProdTCp/wjNH8+D6HwzTugBcvye1JCMIv9GAPwGpda7mxJQtVyuZw7i4P0u
         hmBip6nSjORCGmxswm1WN9eL+rNfjZiFYO0LxCJfOFiTAyW1aoMcydNre/f4+ypbyYv5
         pwF7kgeUl4uxPqORZ2KuyflnpqTkUzergiS1KbolduO3w/m9Rq3s9Ds4WPgt5OSROsRX
         IueYfrFdJb2MHbVvNhXi/26ZqG6GpwQyrJLPT6E6M2SZHp1OCp4a2+vSLwr1zI9K9vt1
         BbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746913204; x=1747518004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGCJs8/+7SziRHF07Ccgt7veBSiO9g4qhAv1dPWEfz4=;
        b=JBczULdIL3MdWG1DNOXfc1XC/+tt76wDU5xd/a2a0hqLkMpq1tGWyZBaSMm+OFBDFg
         7DovetpNYZl/h4dC7xEVirJ1slWdg5OyHyp40Q+r/vpuVjvUhIVmy8hAlfuqbxm65/mX
         iWPQfKVHhXh8e601FSQuCGfAJtr16XSDcDbmCzojIGlyJBM3lGK8/iRj0C+gwimJwh0B
         fekR9dLx5peN5I0ubyRVfriUw8uq5DMWewU3WXfydf+QarYKJyBTK932CIOQzQJMoEpd
         IDpMT1ZBYM7EP7Qmw9j9TNBRN+r5LPYRZmC+HNNkfzSp0DXIz/j6diJLJOBWVQ3a43hD
         YXNg==
X-Forwarded-Encrypted: i=1; AJvYcCVJYrK6unxECnMfDH/DGzdT0SpXQJxA72dqa6Wp6rn0v0AEWP19XE5QRVRv2Rb5SuRK/QHaINZP+Wk=@vger.kernel.org, AJvYcCW5YaBjSFs9N/rrzX6Uh0tBOJep1NlSrfVU5Wv+KvtsrZrfCeIgT6vXR+k2FhFZCvnVLLAflR325VsjfVCe@vger.kernel.org
X-Gm-Message-State: AOJu0YwY3RMwfVMK/A9BFEdSyFJ+1WSem8aXFaHFFt3+GJzXRk89GxyQ
	e2olARP5SEyEPdSjz2xo1kNPzDDunQoBvCKzV5rD8Jgoivdj1qaBnpDsizle8gANifd81sjsVNx
	NDIKC0xS6wcxOseABoeScBXcfzZ4=
X-Gm-Gg: ASbGncsjPUKGqLG96HFjF/w9s7eciCGWVrVaEukxah+ns8G4yNeImaYPRW4RVtFwM9n
	4kkdN6NhmkLGQqL8iJ1A/zttfKRGL/obfBJOH33cjPtA2KQzcIUK18GiHrWW6bME29xGDqYtFuC
	hKt84Mu8/QjolPpe1XgQpjbF4d0LpeYMwN
X-Google-Smtp-Source: AGHT+IEJmvwo2zzI8kIqdy979LYb1/sRMLdHuClRjJKcqpKGwlPNjQIkpimX8ZZ4P3PJmtsZRhsyy9djagZBEbK/XpU=
X-Received: by 2002:a17:906:9c8a:b0:acb:52cb:415f with SMTP id
 a640c23a62f3a-ad219141697mr739693366b.48.1746913204192; Sat, 10 May 2025
 14:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510190759.23921-1-andrew.lopes@alumni.usp.br>
In-Reply-To: <20250510190759.23921-1-andrew.lopes@alumni.usp.br>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 11 May 2025 00:39:27 +0300
X-Gm-Features: AX0GCFtjpQt22vD4Ev-sWBraboWbxDj4ACWk65TmrfdEKdll5ltvx7KF3qCYC3g
Message-ID: <CAHp75VcUK3krw4qZyUGyKYhDAW_j9UQ7_VtwEx=6V2NMd2XcNQ@mail.gmail.com>
Subject: Re: [PATCH v4] iio: accel: sca3000: replace usages of internal read
 data helpers by spi helpers
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 10:08=E2=80=AFPM Andrew Ijano <andrew.ijano@gmail.c=
om> wrote:
>
> Remove usages of sca3000_read_data() and sca3000_read_data_short()
> functions, replacing it by spi_w8r8() and spi_w8r16() helpers. Just
> one case that reads large buffers is left using an internal helper.
>
> This is an old driver that was not making full use of the newer
> infrastructure.

> ---

Changelog is missing.

Also some of my comments became ignored.

Besides that you had a question which I answered in a previous email.
Please, do not send new versions before settling down on the discussed
pieces.

--=20
With Best Regards,
Andy Shevchenko

