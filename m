Return-Path: <linux-iio+bounces-23339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C76AB3AA74
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 20:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E98169805
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF329CB41;
	Thu, 28 Aug 2025 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR/TCmwQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839A24A046
	for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407513; cv=none; b=gbogUtc0464GPQy6afF2YPneB6LkjcG4M0FtjHiFfkWLuQNaPoskpa6IQhVNcIbNNF+43D4WrXPxs8Ouzhj9edakvH30XhJJ29n2BOUYk2PN1P0NuH9DKchuHQAJNr8kEMkv1Jgfw0h78CI5FWVEgJeOpyKaTOaPAbcMSYnPpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407513; c=relaxed/simple;
	bh=l4gTuxpvJSCBQhnjy02SK8bFq0S9xzs8Dl4vtwRT3m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RU0Y8dmMIM5zR6m/ol56LMHxFhbOuUyw23tYtsi+4y1RHkEl3kCspr4Kr6C9DqmJji1Nnku4AWFSLsn2BkfBDRNSiUsb2ToE8yCl3dMJ5G3U4z2zn2QoUNAlFr8qeLMkKNbLzPg/p4dWFbhTC8Ldi9FiObY9XtLHfrb+bGzeL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR/TCmwQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb72d51dcso186797866b.0
        for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 11:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756407510; x=1757012310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4gTuxpvJSCBQhnjy02SK8bFq0S9xzs8Dl4vtwRT3m0=;
        b=CR/TCmwQrgddESMhxgSs3l8yJj18zL9NPdyFYgvnrZjDWNiqe24pRODRc86bGJ8PtJ
         M2ASzw3gxk84ebwFm53/+0dTJwStIfUwTOoZamb+tspUYjSFPVX1crACGmP/yqhdxK+o
         sMzyptZzlBuuX6NIjeMYKe//O2Gl++4jyJl6T2LaKSXNOaEE8HnCNwVkgvtzIbeJgwhM
         6D/0IeeE9eKQkb/2COrgfDn0hQxsH0GxXir8XXFO9T6Gzs+xrQmFDZSQur1c1BCAL2wD
         QC5lQzEF51PfTOzyiJL/XCZO098ay5EtGqRy03LqJfzBbqwZY4EFyAvWCuNrVwlatJt3
         SMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407510; x=1757012310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4gTuxpvJSCBQhnjy02SK8bFq0S9xzs8Dl4vtwRT3m0=;
        b=pSV6mpi/su8874fuzB7jYE84HNPFaMQiCE9mpK3JFD7GghiNo2+u33h3JfosQnlNrL
         RzAbhjbnItoA0chZYZIJKOsl5vBr5UOrV0d61epL8ETcYwjTgBWZN9jTuk/G3B12CXIY
         sLyZHjkaEhfMGRcjHwPurbo5FiRskkRaA/l/e5xnW9T6eWhFRDHIY12QJOP3SoIJALVa
         4BE6tL29pAFf93peQb7NmuoBaDw09GOreZk4eNuQaaNjbSAs6K/+dF3tiOHL5tka75VK
         fj6b+cfCyAQ3I/6S/QwNsZPyKUtnryDzjyqEY82SBoXWDl15tk7RXbRYHGnq90gaPrXA
         qnEg==
X-Forwarded-Encrypted: i=1; AJvYcCX8wEPEmkZvGn3DjhE3L33BuD8rw51+jaZXeSSvjaiDtmHund5RoK9+v0AqMvhJlSIdN6LXfa98ghs=@vger.kernel.org
X-Gm-Message-State: AOJu0YweFTP9ScVu1GlxdME6FDsm5rlMKECjTKnFwPm0PgJSforEW1LX
	HYciBWBHT0YHiRwn3DqHDqlSLp+x4r+XRYYsbsp1sSfQWT4MPcU4iFjf09nC6AdBHkAu2TDOuyk
	s2G/qMxTvIW6vZCQVapItQrIM6m4mwbc=
X-Gm-Gg: ASbGncsXvxdT4EmxK4xm3UULcRlz4miP2IV0BFATwmXoMujg619QX/MY9eGAeg8id0D
	/vncmRHyUQzf37pnObLHljEYKoyWOYDujIO/HhxqsnHKnBRhaeIkA5PZ5ZNhGSsOZWUuLSuzvP/
	2A/aco/0k8DHruTn5hbqgd35jS00niXMvf+8+i4EwhvYrguczSNf0PMzJFzri8TkjMeH8yoeRGp
	TmKTrw=
X-Google-Smtp-Source: AGHT+IF+YDIXEkaqtcttjwpzseg6lhUx3jwQZYowadoulmqE/sP2gD+NnS1OcHW38y3JTnyM7B6QK0IY0ond5pmSEzA=
X-Received: by 2002:a17:907:808:b0:afd:d94b:830f with SMTP id
 a640c23a62f3a-afe29522011mr1770314166b.64.1756407509413; Thu, 28 Aug 2025
 11:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJE-K+CTfwVJkKEzb8D0hijg1VRK4EUOBCytbFJme7EiLMFWBw@mail.gmail.com>
 <CAKbEzntRe1h_5_5JqJ0hTgYdSsrHZ=ZNtZiTTJVuRAMAEmpSKA@mail.gmail.com>
In-Reply-To: <CAKbEzntRe1h_5_5JqJ0hTgYdSsrHZ=ZNtZiTTJVuRAMAEmpSKA@mail.gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Fri, 29 Aug 2025 00:28:17 +0530
X-Gm-Features: Ac12FXyiamFjn-kTzsi8nepVlqW_DGgcu-2Mzm9__fzGSzzyRklNNp5Bhl1xhJk
Message-ID: <CAJE-K+A1MG1rg1-y15GqWUravy9xsjYgemFhgJpEBEitzM3wzA@mail.gmail.com>
Subject: Re: [RFC] chemical/mhz19b.c: Integrating mh-z-series in mhz19b_of_match.
To: Gyeyoung Baek <gye976@gmail.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank You for your response Gyeyoung,

On Thu, Aug 28, 2025 at 7:18=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> wr=
ote:
> Yes, that sounds good.
> As David suggested, using compatible =3D "winsen,mh-z19c",
> "winsen,mh-z19b" looks simple and appropriate.

But How can we confirm if mh-z19c supports Range settings, Zero-calibrate,
Span-calibrate? which Winsen's documentation skipped.

I still am worried just about this, all the other specs are almost too simi=
lar.
Would anyone be having a mhz-19c with them to check those 3 commands.
--=20
Thanks,
Sidharth Seela

