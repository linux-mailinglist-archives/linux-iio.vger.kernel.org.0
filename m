Return-Path: <linux-iio+bounces-27462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F15CED28D
	for <lists+linux-iio@lfdr.de>; Thu, 01 Jan 2026 17:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D2C43000EAC
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jan 2026 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34902ED84C;
	Thu,  1 Jan 2026 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS36cKCF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2EF2D46DD
	for <linux-iio@vger.kernel.org>; Thu,  1 Jan 2026 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767284754; cv=none; b=sWYVZo80ZJUFEvW3C3l1X0DjdBUvo+DLLmI6Hw546Bj2hR+/7pFp06SbANH8vxYw94wtl39v5vVUVIM2Sjpx3spGrgFxbXW+x3lij8T0LMGhHD9AYtpekB6D4t2yfvwNgN1CQZcJFv547lFONy9jazxJNEmGensudANlAAXQywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767284754; c=relaxed/simple;
	bh=2r4VTLT9xan+mgLSR2xWbBRlHL+FGtUT3aWVAlc1cS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gesHA7jMtEFb7FLSA6jixdmUX1XAUB4ERuZlWi5np2lFD0kUkLS2JbppNSgUzNpEp5cqPaiaC5QCYjIZyX+9g6YmdoHORXpzCSjwMBPtbKvr+sfPmQEHG7YS1e0WJLeaKmgtds/JVDUeqSp7Gck5pgeJqdTQvr69NuN3aRni4kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS36cKCF; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b83b72508f3so143245766b.2
        for <linux-iio@vger.kernel.org>; Thu, 01 Jan 2026 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767284751; x=1767889551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2r4VTLT9xan+mgLSR2xWbBRlHL+FGtUT3aWVAlc1cS4=;
        b=gS36cKCFinc87Dfh4Imjym0wPJokOyI6zr6kex3LATuW3/y/dJbziCVrB77zfzTz4A
         4V7UOcyh5Tvntn6qOHZoF8zZFjZTz/KJ9R/8RGw1L5YXHnsi+FzLWpMuRBBs7DjR0dI2
         D0zSjEJhsYhNcSJQxu0rqGH9gWvru/zxXD3QopuBonHN/pa1aJavOXbNYfXRAqyarbal
         VXpndEIwWX0S69rGxMlqGUtck+dUIDn1Zm1xz3dqa1SaCMS7TtM+f3rjxDEzRowsqCoI
         U4EWtPM6NYa+efhTtkON/ZHkKbras0XvHpGAGTBtryEjyQRMe9h9wu19kp1blY8PhUqN
         Arow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767284751; x=1767889551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2r4VTLT9xan+mgLSR2xWbBRlHL+FGtUT3aWVAlc1cS4=;
        b=uI/djf7IWCN95aoTqsRoV6ZGJiZ0QIr+3z+j/EMx19JGfwobUPny6HfgXDG5/FIkKk
         7O5hXsejwZQ9otksq1q1U2K1y8ypra/VedIFgMWlwZD4b3MJ9efRVmdlMpWq3glumvd/
         gBZwVDD2qbuJWWtTM7EnS91yahog47VhhjvFmyqHneq7Ey1fysvZUCNe6HHT3qtvV0pY
         On3+8voxUITvra7DRBMhHthNCWzcx6PSQJo3fNtHVHNCEWjIiACKffIG3JGpctBMvwmH
         9Uf+JLq/iz+roowNvb+NbAScJEQEWeEURKA5YN8kxHwVYgNvENQ7MTu6kmwIlFoS8Otx
         ZCGw==
X-Forwarded-Encrypted: i=1; AJvYcCXDRaaGNhRBjPfSsJt7kpIttIJq3U7PbTO1FgMWoRklVzbJmwdzKu7kL/SncUvVBd4+xwwzAYmybaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCuJl5qtGQrh5LxK2KbEs0CpiAJMeKZ8SE3jba5b3PiOu2w++
	E8gfkOF52dlWFopOSVBmbJRJKQ1QCZC+TEa9nJdTGE6eStnlSDJZIrRc3IMZiZWyJ4hou5WoDP/
	YokwA9aim2QlAiUbyjDTFh+9PMfjknMw=
X-Gm-Gg: AY/fxX7AQk84MLGTS02osbcEv3QD9nN0EMT27hunlMYMTE/t9PZr1/s6RplDU5yrjAP
	p5++kmplmhK4padm+hjALwzKY21RZ9ydlHbgwh1+xjj6ubTOppfsVSO3AIzmJ7CKeBNeoW3Iy3N
	GYNWi8oJS13Lc1UNdwPPEqamrXVEnbGty8wU/69qsLkQN0CvVEh1CZrL/BGXnMeVMjwr9SfiZyf
	FcrA91avDVF2mQiyqBpIcfqBycAHZCAYJmTylBsfhUg8KkCoa37oCmdB484pjJvQyWOl6Y=
X-Google-Smtp-Source: AGHT+IEjVDdR44NrCRbTMZck7fShtWvQJES837s/kqS3/7QCo/r7wj5KNn22/vOnGrhf6Fau3jxa7OrP0/qvVBOFOJA=
X-Received: by 2002:a17:906:730f:b0:b73:9937:e96b with SMTP id
 a640c23a62f3a-b8037183903mr4408428666b.52.1767284750947; Thu, 01 Jan 2026
 08:25:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221083902.134098-1-raskar.shree97@gmail.com>
 <20251227174559.33539640@jic23-huawei> <CAHc1_P6m11M=1bP-0k_ndgtkLtfnkSCMScznCC+HnWWQ1XtGHw@mail.gmail.com>
 <20251231170819.0365d731@jic23-huawei>
In-Reply-To: <20251231170819.0365d731@jic23-huawei>
From: Shrikant <raskar.shree97@gmail.com>
Date: Thu, 1 Jan 2026 21:55:39 +0530
X-Gm-Features: AQt7F2r-A_88P4yhFxjZCiTWn8IBbIceztKgquaZJfVxkPOxlc5xnP_KYHRZcm4
Message-ID: <CAHc1_P4TPzWVMrcrn-Jt23a2GF6+a2BDrFyt99b6m7ao98PKuw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] iio: proximity: Add interrupt support for RFD77402
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, heiko@sntech.de, 
	neil.armstrong@linaro.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If you continue having problems, take a look at the b4 tool
> and it's options for using a web gateway.
>
> https://b4.docs.kernel.org/en/latest/
> sending your work.
Hello Jonathan,
Thank you so much for sharing the b4 documentation. I have successfully
submitted the v4 patch-series using the b4 tool.

Regards,
Shrikant

