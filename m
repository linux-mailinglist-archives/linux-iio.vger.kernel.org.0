Return-Path: <linux-iio+bounces-27116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0E2CC3191
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 14:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 133B030382B8
	for <lists+linux-iio@lfdr.de>; Tue, 16 Dec 2025 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C9033A9CF;
	Tue, 16 Dec 2025 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKq6RGTy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59533A9C9
	for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889780; cv=none; b=BrvMQIlHyxa32O0zbWr4fFA6Dn/uYPKYtN+z3+ETbYab8LxX5BWNzABpNi61ycne1YiOSB1GNBFXhXM2PVIntOAmsrzw2Ae+1gNcBHn/5WjuoBUpGQmGtBXsRTyyEeN4NnvJi3IbKWm/EXby0/Rop9QGv35K64xvrh3RyPq9xJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889780; c=relaxed/simple;
	bh=E3/gW6a5iXb1il+ZuSzcbNyrL/JcJBU6wd7Tnwh7SrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t90zbb/6ekroh7IauXSNi5700KSarafjW2BCpveo5Rf7JWmbinpRZiBqjvmzak0MmlsJgaRh26IDsgOWu0L8fawYK7GmAH3Csxka563G4+iOmw3EUat8w+cDpWcwrtnAuwQe1It43KWPJmnln6Q2ECARL9NUu+mooIUSqePrgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKq6RGTy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47a8195e515so37240335e9.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 04:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765889777; x=1766494577; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E3/gW6a5iXb1il+ZuSzcbNyrL/JcJBU6wd7Tnwh7SrE=;
        b=RKq6RGTyXWReybwU880rkMfCPhsxIz0TSUDNksVKxfIBOSgxjgZ+YF350/QaPy30p4
         R4QYTaCToa9CpSDvQKAPnF6R7oMAEr/Eq0Iq9zkyTDs8GWMQQv9Zd3OHPwIj+hDWjhCd
         4Jo9BdVIprTIGUwdvugbpwZRG0YEPGpWlDSoFj0pPvXSGpQs0mjx41DXD8caO1Srx5xs
         ugMzIsn/ooxQYry7BWPltmeA0MdJox+XoasSWNyRwrqWsfj7IGP0tVkKEZFMYKOuOy78
         O4GpNlGwWjmzlWG9VfMyw4KvRpE1Mhq3WPkD+9/p4wkftuxVXeT/ow40/r5Gvd/hROf7
         KxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765889777; x=1766494577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3/gW6a5iXb1il+ZuSzcbNyrL/JcJBU6wd7Tnwh7SrE=;
        b=le9p+Jm+k7qLtIxkUidkJmt/wMNUTybU4wIkzHyfkxhBepTxFuK/JVDT1HDe+K0VSS
         ZoqQwTiq+RiQJr+Z7eIIIyMQRPLEvVVmVp7QfyatIYD/g9x6Jw+WnG0mJsExT/pkQ5UD
         gfAofOlacWFO6sHzuC4eV6I8xMETdegpUrYLzla/q98/fojc7zeB1bzv2oSkwPoa8Cx+
         Zcz8XHKq8zl35nSHACIcwKlknkMZQr1LELu5ClczpztlAl2g3y7nb/CpdgurZ2AVWpJu
         uvWjtz4+IcsBNy8MKrkET9yrevEg1nyFXsX1CQD8UhCWTcGvPiriGJBhbejUFpRby4L9
         TgAg==
X-Gm-Message-State: AOJu0YzJSRQ/AodRFT/0j2zPxds5T69x8JzviFOrnX8J50SZHam8+EOB
	yrjwr6wAGnLqdPupFtYB2owrTRIGlE3asHKHcuRlyVIzK5/ABCzFiTAl
X-Gm-Gg: AY/fxX4sptbNifGBqMikhDUqy5FTAngOk0w8IP7f0H/qsQ5yDfus/0cpfXq12Q1M1Z8
	ebAFSSjpbyFmjn65bZtfgwMrza3261Vo/V414I6DclPqDu5LK/tSScauA/GeY7qBxJezBHkYEgO
	sJB5AFDAaU38mBD5L8EWRo/okFuvcS5ux5hb2M+7WdfcW9QhMo1BSBaR1OLSn1i+gfasS28FSOn
	InEzmf7VXHWJBOou/GcPzSi8kn5NG4k2Xy+NGgR/HAKpG2GaZllS5SXcK5Lx2HWFD/TvUXZxJpQ
	y0Uusru9gj1xi6T72Ft8kOap97Bt0MSQJxPbFTx26XqESPAFjWsfEwaQJ451f4WXiECzShhGOad
	EWJqfz7gnDVvtX18+uXwA7nN1YiCys8LAu5X6AmmOK9C6f2qPvwdjmv36gxO+ju9NMmeiwXRps9
	1eWB/UU7OeHo8XneNK/yE=
X-Google-Smtp-Source: AGHT+IFHmN2KBvWwgA5szldh9meTcsgrjUuEb3K8eIvn60x1vOZrNT4POCZ1Nc30SM9TShqqTvgUvw==
X-Received: by 2002:a05:6000:310f:b0:430:f704:4ef with SMTP id ffacd0b85a97d-430f70407bbmr9051063f8f.61.1765889776537;
        Tue, 16 Dec 2025 04:56:16 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a09fbesm35503466f8f.0.2025.12.16.04.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:56:16 -0800 (PST)
Message-ID: <2a265681ad73bebf1ad7aeea418fb9399b8350cf.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 16 Dec 2025 12:56:57 +0000
In-Reply-To: <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
References: 
	<20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 11:40 +0000, Tomas Melin wrote:
> Not all users can or want to use the device with an iio-backend.
> For these users, let the driver work in standalone mode, not coupled
> to the backend or the services it provides.
>=20
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---

Which users? The only usecases (for all the supported devices) we have requ=
ire
the FPGA backend. So do you have a specific usecase for a specific device? =
If so, I would
prefer an explicit boolean in the chip_info struture for the device(s) we k=
now this
can happen (unless you have a usecase for all :)).

- Nuno S=C3=A1


