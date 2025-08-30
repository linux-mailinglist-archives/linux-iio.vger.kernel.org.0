Return-Path: <linux-iio+bounces-23503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0989AB3CF22
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 21:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAC33A7118
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDFC2DECDE;
	Sat, 30 Aug 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7UuqZAx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B62DEA9D;
	Sat, 30 Aug 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756583395; cv=none; b=qKc6OMPoW63w9LFvz+98PmClwqCGfsbsG7vqqtKUZADiH9sTYM4JEbzs3dH0WgiFnpEd95Tcmi8hblQPUpPqgy7x/5fsouL719CFOSBMbMo8JJr3QvztSrGHxXvo1Y8jpY35wLLoNfH8jvYXZRKNwQAqVngQz2FMPquIECO01/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756583395; c=relaxed/simple;
	bh=EDQGaBsuAF5Xizt0suEYw5Td7Gain8j/3q0oZ0DNxQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZxjmGmyidVeUdR4qpvdvLA3bCIttF9QGDga3tY5idvcaRr9iDQ22LK0qnHyZPVam09wFII+S9ou+EBcKzIWYiOOBOm3u9XC4tuvNED9c5v4/t/iOpBeKZkpNfhfeH8O3y+/VinVh164S3a4UOi3UZI1xIcF0GNHpXaLeM4vUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7UuqZAx; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-33685e3b16aso25654941fa.3;
        Sat, 30 Aug 2025 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756583392; x=1757188192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DueR/GEqo3hCQmlzxFwcejwA/SFxDN4Mj/COkpTcI3k=;
        b=A7UuqZAxo03uDEJJKTxKdQBJMH9859KB9ZcqItTlEZc+V0kpBNk184w0jL00IiosrO
         UY2EYfSmqN3qxUeoLSMvN6xzVHB/P4xOsxc9MjXIl8+ygqMuHqnOpA0ySBkaZPYoKjEU
         4LTnxtOuoo0PDOHGOJHf8sa8P6gywxLmXokWjooWCiNekheYUE7IFx7ViqhDx7Ig6c9F
         /jHk9uloD4irB8AXLpIGrU1KLsfyahvuDOtpsoPOtypPbi9L8naR614tWXMlrZqo2/0K
         lu5a5I+QGGgc1/9rCqU5As33XmDHftddRtWkA35pfCoyRUp1eAup+M3cNx/yz9/4FE4c
         4EuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756583392; x=1757188192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DueR/GEqo3hCQmlzxFwcejwA/SFxDN4Mj/COkpTcI3k=;
        b=ozuc4YItpmMAvU3Zm3GWW319NCfj4IC3sh9sSZ0kmPOBepRqAiqt3jDWfYqw1q6Chw
         engRFP9l1HBSQXsTcYfo0YaBupgOoD+WbsDbpgRuHGWjMncoLL5zN7PvLR39PT32+DwR
         fOr5veI/HlYnmyKkI8iJZGSo27pK63eKYhGSBJM1m2a7zbtB7w7IMXg/dfnn202UWQWb
         4j5EhRr9G1j8NMg1i/k1Mj60yjtgZQCCTy5l/ZBuZ1AZJ3orZRcDPDNF7auaCePkga3s
         gOX4Oe7nnlNPZx+5ev7B0sJeQUX1T5sgio2AFKe1bdgijn+BlvPiDtx6hKxaVp9M22Rt
         oMgA==
X-Forwarded-Encrypted: i=1; AJvYcCVELLiPlSxKXV3w5rFAqsumlQynxsrGB9G1R9vdpOVH8O8Y+bNegHwclxTPMUID643M7h9Ch1rPtR8=@vger.kernel.org, AJvYcCVZB7lr8l0kXpYPJYgshjqvL9QaJY6Qjg8FgO5+ghAnkav6c0y7VXxpOIoAZ1wneJe7v5N6ljcLYnJm0NCm@vger.kernel.org
X-Gm-Message-State: AOJu0YwrCUQOGU5TBb5zENZ8OGHRXFWxR3aQ/UTML+stc+sQzjbaFepK
	GU2YPCpNkflRawcaca3YDvSSqIm/Mi5BlUDsq/HVFwKDeRDSdpHlEsexy+4grPxCGzxT8GlbZqG
	tYy0auysImTlTcGdS/3IQtGyqdS8vzjM=
X-Gm-Gg: ASbGncuZTlz0BdA1pCL++D45V7ft09c6qq9memyuI6FeAdxBCurJ0IMb4MGAGqL7bXF
	OUw5O1iYRsYqevwXvzKlRxnz6SYn2+Eju/Y+KVmeCuZYAzj1xnl829rVl1gfSnhTA4jHOmo+VSz
	P8BX0gcVbby6q+L6t5idTHL73a92q3am+0JyGTza07EVO/gajLDxhTPtyafKVTymQXVnGUy+kow
	Q6pKOM=
X-Google-Smtp-Source: AGHT+IFHzvqmScs0rB94sqP2SFmpNGXc3ZrY+CFaLUCwhYFsAwPnsDCN8xQuey6Qy5ONGXqf/jLo005v0Zs7MafdN6U=
X-Received: by 2002:a2e:a482:0:b0:336:7c7c:5ba5 with SMTP id
 38308e7fff4ca-336cad21f17mr5414161fa.23.1756583392121; Sat, 30 Aug 2025
 12:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
 <20250825152608.6468c27b@jic23-huawei> <CAE3SzaR14zWWM_g-H4C76+6fBDotuAux7n2V1g94R2xLFQZOYQ@mail.gmail.com>
 <20250830190806.7dd92eb9@jic23-huawei>
In-Reply-To: <20250830190806.7dd92eb9@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Sun, 31 Aug 2025 01:19:39 +0530
X-Gm-Features: Ac12FXxtg-5Q6tqukKvl-H-bYxYYmRmaJu4lbAggOzvPfT0BkgloAr99EKg8X5I
Message-ID: <CAE3SzaTNoQujrR_h212XLpBbBWddzmSJb9bbUOFmDTBv20p7Ag@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add runtime PM support
To: Jonathan Cameron <jic23@kernel.org>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 11:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Tue, 26 Aug 2025 02:29:12 +0530
> Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
> Normally we'd check the register to find out what whether the event
> is enabled or not.  If we are asking for the state it is already in
> then just return having done nothing.  If bus reads are an overhead
> worth avoiding regcache will ensure we only do it once.
>
> Then if we are doing something, do the runtime pm get / put as appropriat=
e.

Hi Jonathan,
I looked into the code of multiple drivers. Almost every other driver
uses a flag
inside driver specific data structure to denote whether events are enabled =
or
disabled. Some use masks to mark which events are enabled in case multiple
types of events are supported.
For eg: bmc150, fxls8962af, kxcjk1013, ad7173, ad7291, ad799x, hi8435,
max1363, nct7201, pac1921, palmas_adc, bd79124, ads1015, ad5421, bmg160,
bmi323, inv_mpu6050, and the list goes on. I see this in at least 30+ drive=
rs,
maybe more.

On the other hand, regcache is used by only 4-5 drivers.

On the basis of the above arguments, I am strongly advocating the usage of
irq_enabled flag in ltr390_data. Moreover, using register read to
determine existing
event config every time we do event configuration, seems to be an unnecessa=
ry
burden on the bus and increases lines of code which I am finding it tough t=
o
convince myself for.

Having said that, I have prepared a v3. Kindly give your feedback on it.

Thanks,
Akshay.

