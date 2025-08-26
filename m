Return-Path: <linux-iio+bounces-23317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5103FB372F6
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 21:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CFF1B6738A
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81D32F60A7;
	Tue, 26 Aug 2025 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tag5K1h7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A662D46B4
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236049; cv=none; b=mvqml6KVVpumTT9kXTtzJkFjRs+hI/c0uhnLKmfUQmf1mjd/sFUYW+NChDml3zcWfTNdHde6SMJn3FqAMXktgUR4ySR/uBuec9oj9TGevde4bBvnfXjE2pLxKKnMVhxOKl7iidspCAc7wkhjrBUH079ty8aIT4bc6iwU/WbWekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236049; c=relaxed/simple;
	bh=ry3N32N+DjfqMYYRPckyB1ZRvTp7udEqnMEm7cyiPz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTkuJTbGmqVMa9Q7+2H4ihqjUqsw34s91VZlHu9uxwGjYOngxv/huQvekNrl1BdWGiFjwXnHS7Ke5dTzwM98qxxBxxYYhOoanSBB6uaymzVVTg6Mmxm1HCPqRRAR5vyNjxviuSv8KQJoytmrNkbicy7GOvzEUYpwQFFei35Yado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tag5K1h7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so8288996a12.2
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756236046; x=1756840846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=02+rESFuNlSWXg4eQ3p9GiZr5jN6yQn8zm4BP3ZW60I=;
        b=Tag5K1h7fk7pJjYGUCqAMan5Af+fw2wIxHRH0Pnnj5wAX8kS82b2xa/pP1xKEu7o4x
         g80EYxjdLyWIzOprkkXkGy9XL0xwaJK4hn+2zaTjSG0f6HMR6R4kieMnXks4vGAwezen
         e+uq5tPkNUloC3bfTOuiWfdREAn4h5ePVsX+A0hqkQrn2p/5PIlZR/ujtqiIRVvazRn6
         OZigjoCunFML7naoO41//nfKBzAp8qExxxMfpw6kYVgofmPkpO5jts3NV+nV5SlHQMVx
         RyMKllfJnD89+S/kZwX2vrvYAk46vwzxoE/8PCB70dzA4YP3cSZKkfRQbPFrtBcMPukG
         LQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236046; x=1756840846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02+rESFuNlSWXg4eQ3p9GiZr5jN6yQn8zm4BP3ZW60I=;
        b=jHfBnLwj0Fhix9ZUBL201LYfsNYPuqFLXLp5R7mrt/QFN3DqtxUCI74WViuI18KE9q
         22x4Woa40jTciicx8WA2AKUWiPcZWSyBVS/UCeBeaX2/trr6vjXdtD+dgaua3CA7I4qp
         FO5TNVKiSl1E9fNIsZdv501sNY+eFamFfMX6G1U38zY9xyC11Hq5EB+CRN+GuDZQ0sJp
         kBKwMaZlz01b+i9kS07rykMINzQD5csYMCcCK3nQLOsWj7hpiXxb2IdMDkRSgwWl+wnj
         rEhQY9A5jUQjQhmhxWwGKWDjFfETHqjERQPkgqmo64fJOOimqdVCJMXuQcZqCelme31V
         zVjg==
X-Forwarded-Encrypted: i=1; AJvYcCXnaqShPkYzNVbnqg5H+38hEqU2hN6mYf+E7pzHgn1YdpppKC5A0dor+MnDvw72AyY3FRSwQ/IKnJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyENcOa5ZnTv992Vi8wRQxFv2Jn3M7rZj1gYGAnHPAjDHTZXpf5
	1Vi54Vap/k7DH+k4nwT+5/LELM24qzL9k55K6Zm9kp5VBbwGXepCGgQLECNZuG/XdJv3z42oZXr
	vQod04vArqOhk6Zx4KI+WNsNu6Ylx9G/7K/7dD7Q=
X-Gm-Gg: ASbGncuRpdiGFMWHDXQMxxAfin7hdRnJ3B6/elo/a7NNezIjT2Pn0LD8RU7Cn6T3vcV
	EosHfrnzcTtBePal/3c0F3ubm1KosXQ5yrP+X55WnKOaLT5aznugpdjgOcIsKTXlVqucoHr2FSZ
	NdabPYDmS+7u8LBivvTaYhDV4t5XsnXEjH6VKJXiDQYmpTUj+aeByI2H6YyW/Qcx2Ell7Gt01Zp
	vqjikT9WbOUC9G6MYwYaC47znanxQUFQqGKCDRvkQ==
X-Google-Smtp-Source: AGHT+IHuxl03XRlG6YvKgfGJ2cVPr142ZivLtUkvBVMJe1/p9nSUlXJIscZUCW4ZM4MHpEMbK2zp5+wwT5ClbEYPezk=
X-Received: by 2002:a05:6402:2786:b0:61c:8c63:a91e with SMTP id
 4fb4d7f45d1cf-61c8c63adfamr3629105a12.25.1756236045906; Tue, 26 Aug 2025
 12:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJE-K+D_U3F_61vzXPHDZV_Rm4Jzd--nO3yf083g7-0=Hh7OFw@mail.gmail.com>
 <CAHp75Vcte3F3VNhKZPd4vv45Kedzok0LKQax1jt=geG9w7b1EQ@mail.gmail.com> <CAJE-K+CNsGdJWeYW-NL7PtkOog3YfLEeqJLJRHEtTfb=A=o8pg@mail.gmail.com>
In-Reply-To: <CAJE-K+CNsGdJWeYW-NL7PtkOog3YfLEeqJLJRHEtTfb=A=o8pg@mail.gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Wed, 27 Aug 2025 00:50:34 +0530
X-Gm-Features: Ac12FXyklB_D-8lhVliPGmPFPXnbH1bucaXYtl8EW03qC5mkVJ-OFSNV8WD_XSg
Message-ID: <CAJE-K+BjnNdE0kN1fqfZQGb+9Gcdead=DRiAXn6qpSz-WKOj9w@mail.gmail.com>
Subject: Re: [PATCH v1] chemical/mhz19b.c: Replaced datasheet reference to new revision.
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "gye976@gmail.com" <gye976@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, 
	"dlechner@baylibre.com" <dlechner@baylibre.com>, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Code referenced the mhz19b sensor's datasheet i.e mh-z19b-co2-ver1_0.pdf ,
newer revision is mh-z19b-co2-manual(ver1_7).pdf. Hence, the document's URL
has been updated.
Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---

diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
index 3c64154918b1..05e739e962f0 100644
--- a/drivers/iio/chemical/mhz19b.c
+++ b/drivers/iio/chemical/mhz19b.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2025 Gyeyoung Baek <gye976@gmail.com>
  *
  * Datasheet:
- * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
+ * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-manual(ver1_7).pdf
  */

 #include <linux/array_size.h>
-- 
2.47.2

