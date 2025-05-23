Return-Path: <linux-iio+bounces-19826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C743AC2426
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 15:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A693A6982
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 13:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65AD20ADF8;
	Fri, 23 May 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkPhVW+3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCC14286;
	Fri, 23 May 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007412; cv=none; b=g5grAKjzJuparld7Z4LjsiB/zrfwPgTbTlXTwQiMPdauKUR2Adf9JYEcEKUbaffzo8P9DaUFXrUeyDMT4SCB+n5nP3vjb7D2+uHrv+kDynykfA5YXMSvx2K0JIx3pTygO7sgLzze+fEQkCWhhMza+x5L80Mnmtr3D4oNVC7kGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007412; c=relaxed/simple;
	bh=6bDWNO9Zh7V3wmIT56V3cUwpLQapr952ByKU0FUX6lA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VykxfXvftu5fi3F5pxRzz6Am5DJUkEU+/cpzH0gfIv+pNNR8vsk5k2U5pciBhMhjiLsTkfcQh6kT2ZaH/PH84OnEk3SR8fkfghsxoGqdWMIDG3uxTZxRqiznxsrm+A8M+dGwoD2lTYHP6tgCsGXoteP1vmvyDWZQnP4/Et3nu+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkPhVW+3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0ac853894so8137066f8f.3;
        Fri, 23 May 2025 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748007409; x=1748612209; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6bDWNO9Zh7V3wmIT56V3cUwpLQapr952ByKU0FUX6lA=;
        b=LkPhVW+3HnuyApWRp0gPPkMuzyq1DjBt8daq+lKsx8TnI3cfJrMoY8rotxPQq6V4Hc
         kxLbwGBWmVIwscPDqOCB9mQlMhOM3WbBWBT7dex7erzxzORiX1enzD+kZwCvyVVPFuw+
         rlpGFMRH4UhaQsGFMfOJiMpbC5Vu9SCBgnUZ9noDtNr+o2kdoCR2vcNmYYG63yNnG1k7
         6iKcoPrL+jAAIDhdoIZFmbFXgMbIZ59Nw0gD82oq5ob8xErCP2u8pJdrv+3hzlSCEUa4
         UH0hLsQa2z9aR8UG8e2ZYivrQu58g4sBW2N4Hnnht3asIji4dmy0nUBThTwVsUH6DOeE
         ThLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007409; x=1748612209;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bDWNO9Zh7V3wmIT56V3cUwpLQapr952ByKU0FUX6lA=;
        b=Gxvw072SCbUiHWN41UxGyN1xvAFDOoTN4PO6+gbeBHYCUZ8Ph+A/vQpj20QYPRjlsr
         iooEKG5SGUmHeZVo6mtjqqwlmcEkcx9J/doEIsxXdbZVGuCJXt0daDeVMzztwoL/wTXZ
         XjBj8o95235G98hMhkFurzYFKeraq0PX5iWzxzi36jI4U1nvUcb1wIJmefaUA+WhNN2M
         JNxzrWLLHwNT5Z7pFQnflWAyRBLc/UFNLPrn+FYLWPyA9rCw+sSaAw68R31803wjfj3V
         fDs5Ljv4cJg+XQKzoVriqe04KTTHSNk4l8Z5btMqOLEJaaowlugMKSOBeyHTb5hcnDZQ
         DRKw==
X-Forwarded-Encrypted: i=1; AJvYcCWiFc1Fx61rGB/qPjNHuslbHMeOj/rUKzmungkBM0dhJcWTTYYpaWtv80Z5YYBAGX1oOLGzBKsFXuY=@vger.kernel.org, AJvYcCWlZmwo/1+XWQYAO1KZjfW/yq7LTQ2iKHiAc80pmiGi3ePiCsxjbhMdZMjrwaIpU052y6FhBnVHiUZ10QzI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpw00/aUM//Gp3HHQ0r/HWTtyCCnX0HiJJKiKVILxA6fKhZBRG
	/0yPRKjSBlR+YOK4vqUUnJ6mLIWLHqe4VY/pMpWV/EllzIdTl9tvaNYWfhLiMnQK
X-Gm-Gg: ASbGncv8/I6QRtdxFmexR/E+teEsww6xNCNcGESKH8DNpW+vZp/ODlILyCTBl/caCaa
	1DfllkLEzSWgo7jVJHbKhWi/Mwqq+xT543EfSFrHL4znVnEIZwpw+oylOP6CcVLvQj6JwKhgDL5
	rS8PfBTJURpCvw4VUP82HZZgIeOssus0XGJGcTkVHKQPuANN4++f2gn5lwnIMmELkR80HvggsQn
	ac/VQBgTXZEizyB0Ek9RDnHIqCEjAsOj5jLhrvEz7mz3piE5eroWPexw8XBptvIntC2jqlivpQm
	SrQXr1GTb+pLPEwTptmbiNQJKASMsxc048KYZidsLRDWbEj1wCYdUd8Izg==
X-Google-Smtp-Source: AGHT+IEJNZbsuLslNaIZu542B8RwwP86P0qzXTWfRc5HuzNrYBNWQdY1q1NWDlhooDeYz03dgOWXVg==
X-Received: by 2002:a05:6000:40e1:b0:3a3:5f36:33ee with SMTP id ffacd0b85a97d-3a4c2104755mr2724657f8f.32.1748007408824;
        Fri, 23 May 2025 06:36:48 -0700 (PDT)
Received: from [100.73.1.233] ([91.205.230.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62b47sm27082480f8f.58.2025.05.23.06.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:36:48 -0700 (PDT)
Message-ID: <a0a926291e2975572cfc1499eef930b0c762591f.camel@gmail.com>
Subject: Re: [PATCH v3 0/2] iio: dac: adi-axi-dac: fix for wrong bus read
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 23 May 2025 14:36:50 +0100
In-Reply-To: <20250523-ad3552r-fix-bus-read-v3-0-310e726dd964@baylibre.com>
References: <20250523-ad3552r-fix-bus-read-v3-0-310e726dd964@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-23 at 11:00 +0200, Angelo Dureghello wrote:
> This patchset is intended to fix a random wrong chip ID read, or a
> scratchpad test mismatch, tests done in the ad3552r-hs driver probe. The
> bus "read" operation must always check for busy flag before reading.
>=20
> First patch fixes the wrong bus read occurence, second patch reorganizes
> a bit the busy-wait polling code.
>=20
> NOTE: due to ongoing changes in adi-axi-dac.c, this patch is intended to =
be
> applied after the linked "ramp generator" patch.
>=20
> Link:
> https://lore.kernel.org/linux-iio/20250408-wip-bl-ad3552r-fixes-v4-0-b33c=
0264bd78@baylibre.com
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v3:
> - fix axi_dac_wait_bus_free(), 0 must be checked on poll, not -1. Someway
> =C2=A0 failed testing it here initially.
> - Link to v2:
> https://lore.kernel.org/r/20250409-ad3552r-fix-bus-read-v2-0-34d3b21e8ca0=
@baylibre.com
>=20
> Changes in v2:
> - invert patch order, fix first.
> - Link to v1:
> https://lore.kernel.org/r/20250408-ad3552r-fix-bus-read-v1-0-37add66aeb08=
@baylibre.com
>=20
> ---
> Angelo Dureghello (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: adi-axi-dac: fix bus read
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: adi-axi-dac: use unique bus free=
 check
>=20
> =C2=A0drivers/iio/dac/adi-axi-dac.c | 40 +++++++++++++++++++++++++-------=
--------
> =C2=A01 file changed, 25 insertions(+), 15 deletions(-)
> ---
> base-commit: 6fb85f14853ddde06d57030c753168402bf69cd9
> change-id: 20250408-ad3552r-fix-bus-read-1522622fbd2b
>=20
> Best regards,

