Return-Path: <linux-iio+bounces-27431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0679CEACCA
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 23:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9214301D589
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 22:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839FC24DCE2;
	Tue, 30 Dec 2025 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6mlT2KT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB92139D0A
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767134828; cv=none; b=dUUVJffnK+FUxWXHMawH/EhcPVOrT2L/9zxMA742CnclSGT0PFDCK/YhLnTYK4lu0IZVt+7KJ8R6pKnZEBiCZ0Juw9iwvULoNw0RTmo3dfpHJWMmR9QZRhEEIfJrFKNbAKCPlavDip+Nw12cRdPSDBzLucoWNyiQd8ShYF8chG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767134828; c=relaxed/simple;
	bh=+S2WsQyFEwSta0SU0nHPCCKXgkUA8WyQf76MiqP6YHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdSiq+wGHwpg6wgn6guWiKD169bYlQo1h3eJSZypi+XFmwfN69R1K0NGeUCbh+j4sdLjYAAZZk3ekd7CYInBRvzDtmtx/M2uNMEeQLk16slqMBa/dkiZpY3XH459mhcCn/2gB5zVlkXqYRVixzimqfRv3rgpw5htPNog8qN8FzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6mlT2KT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso1844073666b.2
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 14:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767134825; x=1767739625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+S2WsQyFEwSta0SU0nHPCCKXgkUA8WyQf76MiqP6YHQ=;
        b=B6mlT2KT+uQV/6SqvCU8VlEUiuUQsAPiPJm7QrbPnS6Gc1O8efUC17kK9F435H7Dev
         nzbXJvPvvRewZM0lkue4YOhXMtF/Fdmh3YSjrS6SVaaSUD7pjp8UyQGXKb0sltPDMT7w
         sNEZl8ikeArBn6n6+Bqg2hSamuI1PlEQ7o6huprMGMcVOlmH64PADI8UwQ0NYYvrU54e
         WIGEX+TIt3MISM+x7FOShaVKq3E3P+/z/bIeRdpvof1166oa1ZO4goIzRymPkjM3arPH
         YUrKXxu5WOaDIkUbxZ/mpGHRIuwNF/73s+kSPal+mdnH9ElIERsHc61yiupx+7D9xxu2
         77Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767134825; x=1767739625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+S2WsQyFEwSta0SU0nHPCCKXgkUA8WyQf76MiqP6YHQ=;
        b=ry4KExQcT+hSK5QHZS1Wx6jlCp8U+r0MAOAiBqe1vV3VNbf7JX9FtVf7WlPWGTX/Mq
         dS4VEp6cOT/pqMiRX2vu8j3qpzTgk+ddlfdlRS4I2Jx+O93mI5hXnyO80Zcfw0XCfNgR
         ncTH9BY/no3BRj13SOHls/XIgqe1wSegzo4O8PIdEJBdnXn0k7WS239fpts0EecOQn7B
         UmuP6nfX0oHqSYvprVl+qsXtCHpORkYAnYU6l1tWOZkThGB1YBKt+ghD3di/VKV0dMQa
         Bo/4yJdLoOzkcJmx7+xNKzQR2M3P5LDs0N8xBfoizSY8T+FV1fMmtYZV/GnWigQUlplx
         iWyA==
X-Forwarded-Encrypted: i=1; AJvYcCVrX1iFttUvgyROHhk5funzeTHZOiGcnzVkVWw8tpr/MBj/HoNOv+DnDw3eSiV4LvJRgEEEObW5Sxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxop9E3eUqw/Ern1G45M+nCU+q7PFM2z/jrkvZHmAyYRvfNuokt
	Gl6lOBBpcj+xUjalXRdaaORXRrQV17Gu8R1VVqsbqJouvMGM/qk/Vqw9WrS85bu3bT6iQyQ/2k6
	fRi7EA6TGWv/ZOUG/Z6+43wfeeT6Egeg=
X-Gm-Gg: AY/fxX5ct8Lox0MS1rcNyTVheneT7Ku0NyZWPmTfCOYkywNH5v4oWWaMbrxH5JLD6zZ
	gKX/X1KfhZVmRGyGJ3L488WiqfWGk4+qcSCGU+untm+lHSomFtI58nF1jy4XZvx0i0DyY368l0m
	0qnbWev/w/rmHd4NIpcr+TtYu6GNsClpJ149pGrW+mh+cz6IWvlwWQ5AEry3APYCeW94wpQi7LN
	eRAWxzs0Mg2SiPMc7a16KZbUbtUh36m/lK6/3OTOJYcchzJN33lyuRFdaMIFsTEou21/113DRvU
	lvXfPeDa7+u0RDikCa66PMd2SmMkJEfRnD2w4nGvMvjoSBvKYPIalgUEpwz+gLkREJ5cdkcUSUT
	+OffvvQTIqQC073VNZw==
X-Google-Smtp-Source: AGHT+IE1e4J/o37+JKC45saUR92B4dNPZ1vnNQpDL40LVWWrFDK6HUihl+U/229geIzCT32bj62dptXES+w4hdW2VeI=
X-Received: by 2002:a17:907:6d21:b0:b79:fc29:ebd2 with SMTP id
 a640c23a62f3a-b8036f0a457mr3500867866b.3.1767134824862; Tue, 30 Dec 2025
 14:47:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230203459.28935-1-tomasborquez13@gmail.com> <20251230203459.28935-5-tomasborquez13@gmail.com>
In-Reply-To: <20251230203459.28935-5-tomasborquez13@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Dec 2025 00:46:28 +0200
X-Gm-Features: AQt7F2pzsCl8-U-XDrXFy2ku2Zwx4KOyf_8OKScRPWuH0RcD5A73u4vP-Xh0PiA
Message-ID: <CAHp75VefAPs8C9gJdz-zTkS3cpExg5pwOTMreiUs-ikSgpygOw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] staging: iio: ad9832: remove dds.h dependency
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 10:35=E2=80=AFPM Tomas Borquez <tomasborquez13@gmai=
l.com> wrote:
>
> Remove dependency on dds.h by converting custom macros to standard IIO
> attribute declarations.


> +static IIO_DEVICE_ATTR(out_altvoltage0_frequency0, 0200, NULL, ad9832_wr=
ite, AD9832_FREQ0HM);
> +static IIO_DEVICE_ATTR(out_altvoltage0_frequency1, 0200, NULL, ad9832_wr=
ite, AD9832_FREQ1HM);

Any particular point in not using _WO() / _RO() variants of the
IIO_DEVICE_ATTR_*() macros?

--=20
With Best Regards,
Andy Shevchenko

