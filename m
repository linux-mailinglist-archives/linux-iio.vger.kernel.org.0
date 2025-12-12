Return-Path: <linux-iio+bounces-27045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE6CB8DEE
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 14:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF5F30505A5
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 13:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9221E322740;
	Fri, 12 Dec 2025 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRUjgMGZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE830BB8E
	for <linux-iio@vger.kernel.org>; Fri, 12 Dec 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765545037; cv=none; b=L1Mv3r1erbt9SQQB04/jzyQ7qR13ojtSO2crgaTpXOyTDIRa7H7RbynercNAbfozrukxZEJgezc24Ic8XHl6KMGOhNz4TRj/t3tZwhYoNViW6W/AippZpJ8aS7VzyUIN59QE8rR+E4kavFJDSmbJF69Tk6OfXswH8ytvo0LRLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765545037; c=relaxed/simple;
	bh=kCrA7tf2FGXKTyLeTTmIczXz3T0WPj9VKpf7cyKPslg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=j3F8AD3ZH0MaUT/aRlwG+ZkNrFTw2wkh9u1kIL676VlrRyNwHGJC16Rj5u7gixrasDn2ks7hcKIfJGdotKWAlhlWCtLLzDB10lk2QMaHsz6h98Lb5d8vZFISSjjO4PD4/zX37o0mb2h/3wciyWvmkw+6Bark9MYxEBsoGiZTYrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRUjgMGZ; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-93f573ba819so353893241.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Dec 2025 05:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765545035; x=1766149835; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCrA7tf2FGXKTyLeTTmIczXz3T0WPj9VKpf7cyKPslg=;
        b=MRUjgMGZA6Y7GK35jr3XZ7YVt3T0ADvA/XLlYbugYpqvCUUt4k7mOK8W0e42U1+U2L
         WpHbzIDsaxM2640gw5NTMloox9kJX7L2cW91AkhLbj2FmpWjf3zicyTzTP8wFZ6iCD4D
         69aBhFG8SXioQ74Lt12n43t7+RTc/meOagk36laWUPpx96cCM1nzgo3BGrJ8B1UUAwEH
         UAdsJXhQIWKqPt4CtM0djhTEwkgaTXrXLnxwpi/wRtTNg7FZLX2up5sWxfyJLLCIrHlj
         i3qr/sRnHe2C5WK5GTsedb4O8zn82/qC5OFbQs77MF+C8ETDAAERnvCKoAjNvfqbZbqI
         MRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765545035; x=1766149835;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCrA7tf2FGXKTyLeTTmIczXz3T0WPj9VKpf7cyKPslg=;
        b=GRMgW7oV24FR2yM1FU2xytxDNQ2n/Xk42wO9QosvyggpY1DwgXgZev0jTWVbseCe9E
         H9zuzhb1KHsVl7xBgL0EHnUgmu8CsFPlgmpq5bddBfDSkXWsL6bCCB1/IQEeYP5aEcaF
         IBvw3IXI8nX0ecTsOK4/N0kJbuk+TSESG31Le1A1ansfXKoBi7LzrNYvcDjjbjZ8l+VI
         ugB3QJBCJoUGQx3jy2eVpDr8rm/0DhScF/6JLI7DosSxBz8Ln4Ci6F3LEcn1cEugLfZV
         lxys6hnD+54IlLUyikSXzKl8l1S+tUvI023+e9SWLUeqkmescZvOoZU2hdm8W8jycgdv
         3bMA==
X-Forwarded-Encrypted: i=1; AJvYcCVdSTVtyuhDyyE5yM/MG+qmWOCOfyhuHdACrlIH1ggQWrI4tETzbRsqMzxDm4HQRmH93y352c0Ml84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV78fYcQGEtWOTzI31q0ELSPKn35usKAwMf1tCX2arN4YX84m5
	K22f/3FFQ8TqMEddf9goIN+GSrLvPziwPzI2BdCfmdNrTMMaMGWR1ahhQezabw==
X-Gm-Gg: AY/fxX5J8K1EtosvrNODFOf0UyYGfEVU2v5Ug6cYszbjxRC4/qpfgIu9NYZN27yxAVw
	4bWRS9ngS/Lh2/cR1hySXhLUEP7vyUtXGLLTstdMSCuJXxbPrcGwgTCEn00uuvdmQkkyAvDzDeY
	SB36hLbO5HDNR3WicS7defTZbZP05JRXusAAWNHFIf8p1bLEjYKC1uzFmNn3TEvmTOBpIw5QWXj
	eCnBIoWXpJKyi/1V2zQOo2FNEJMgvItgRzbebepctggQaLx5z2KjGgsj1r6gqR4gf7Xlg8HaGZd
	f31RapD0nQ/nktsce7OBnSgh4Bg+Vpmz1QNCq+TfyHcypMVH4nppjliScTR111Du3wn5g1alF6J
	C+3KC2/6p8o7AEdy7TgVxQ6PSoJMPw/gO6uoXkeEEdrRtJhSCiAoaYIldyXoJu0WTM47EeQO6Pv
	O/zIA=
X-Google-Smtp-Source: AGHT+IHJ2JqdZctPRyGNwGPT9qU+RSXeGGF9JiKVcuTcnmuKZkCf5xEk7yDW1KvX4ymSMlHcLWGBnw==
X-Received: by 2002:a67:e70e:0:b0:5db:e297:2c75 with SMTP id ada2fe7eead31-5e8276a3597mr434027137.18.1765545034626;
        Fri, 12 Dec 2025 05:10:34 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e7d0e77d92sm2185707137.1.2025.12.12.05.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 05:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Dec 2025 08:10:32 -0500
Message-Id: <DEW9HATVCPDE.9X0RFCJ4UJMP@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v8 0/2] iio: Add support for TI ADS1X18 ADCs
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Tomas Melin" <tomas.melin@vaisala.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Tobias Sperling"
 <tobias.sperling@softing.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251211-ads1x18-v8-0-5cd12ac556da@gmail.com>
 <8568e452-15a5-4a94-aa2a-b7525888799b@vaisala.com>
In-Reply-To: <8568e452-15a5-4a94-aa2a-b7525888799b@vaisala.com>

On Fri Dec 12, 2025 at 3:40 AM -05, Tomas Melin wrote:
> Hi,
>
> Sorry for coming in late in the cycle, can you please explain why the
> driver for ADS1015 could not be extended to support also ADS1x18
> devices? Briefly looking into the topic, they seem to be very closely
> related.
>
> Have You looked into that alternative?

Yes, this was discussed in v1.

Although they are related, these two devices do not use the same
protocol and regmap is not a good fit for ADS1X18. We need two different
SPI message structure for driving the two operating modes (direct,
buffer) and the trigger needs some special considerations because
ads1x18 share their drdy interrupt line with the MOSI pin.

We concluded merging the two drivers would be too messy as both
protocols would need a lot of unique code. Not to mention different
triggers, buffers, custom callbacks, etc.

>
> Thanks,
> Tomas

--=20
 ~ Kurt


