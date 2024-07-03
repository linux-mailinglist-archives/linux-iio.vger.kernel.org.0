Return-Path: <linux-iio+bounces-7211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A697C925459
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 09:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42865B2213C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 07:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E4482C1;
	Wed,  3 Jul 2024 07:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbIfh/Jv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE5130AC8
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990265; cv=none; b=azS6ZMTcoQ49Rs6GCoC4qeaUgxsMX28EbkFWcwjwOCMOo2UO4cEI1SPVrDvQ1gzu0cQEfCe4si40yRP4eHZnKdK77iSBBD0qvPNfG9UoxC3uQcuc7VaJlGPmNuWzgbos1pqjs3RIZl4zyITAK1u4ES5b5shBCn6iJCXatXaIYvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990265; c=relaxed/simple;
	bh=VaQH8FnAeZDc8Csmsnv9JLeK47HkCPT9RMwfnkOGtnM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=klaotPK/i0ThvUTS332mmdHoF8D0poJXmdCIXTk5E3kVWWlMGleLZhzQ8y/UDbgH48A1jVF4qNdiDpov34rsX15aOoXg59nP4jm6OeWGteChTyK7xh5MTK5gx1x/9MZn84kmtxLkt7XcPhldcEuaWFAOYyVu76xsQiWxDzm2GcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbIfh/Jv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso38877625e9.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Jul 2024 00:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719990263; x=1720595063; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VaQH8FnAeZDc8Csmsnv9JLeK47HkCPT9RMwfnkOGtnM=;
        b=NbIfh/JvGOEoaKxYCnm9OA8oJJcVv8ljDwwsVAcsVlnMTshg3DUQxBB/0OJZwufV32
         waoK6U2nqKkPgfhCpa9TGLKef3kQddvtrlKcqCDYFdgDN3zKtQMXQNx9QzRjQSF3mSsm
         j1FcVyf8+XW9fInMh2w4y6o0PeWvt13x6joJlESKIvpUMWdXNfP66dbUTZmgF2rhF6XO
         xHnJ6D9Q+Aog59E3LDFCo1hdALk2TfKV3jKP5sb+1q0En9rEMQv3UDbJnVzyPjBOynb3
         nMq3Rsn5bvRYuBAtI0ZCHL1dBlzsDf4UfONfTjU/BZXfFe3JqwAFbMCxHF991LCGxkLi
         XLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719990263; x=1720595063;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VaQH8FnAeZDc8Csmsnv9JLeK47HkCPT9RMwfnkOGtnM=;
        b=MW1tqSQTk3Wrd0JboC1Sa3DyMd6aBmIO+nWrwnWQXAOjE4Xm542PznRI47YAVKDhMA
         ID1j9vPc1aHhGzWsCpO6RTR5MCVwSLQPdvylaU/F19pX21XGi/FpfKgeXbu8XGoaSLfz
         Mpg16q+QAYLJpEeJovqtoXRAPSO78VsGdziCpwryKYzboAlQGHkCHpsjLSVLAOaZYGrp
         Xzv7ubS0YV/pN2ssJdsMOtFmy2fBtAyvkWL6CKwOXTinAH0DGAuoBoZDSuZwVvyLG2pd
         pdr1dMiAdXHbh0cPYVQmJJJVoS5LOMDblztHlA6e1UDmWX2BiMYhaB2MpNXgFySSGz5C
         4n1g==
X-Gm-Message-State: AOJu0Yy4uqucHf+b2jTgqQeZh9G9R9a6w5y6U5yuB9Oerx/nXXLqLn+N
	iqk9zOHD7BeB4f2E44YFyhJYf8mdAFXrx3pa065Fy6Wi/KUoGqsf
X-Google-Smtp-Source: AGHT+IF1/X4CW1biRaLUYQHCJICLl9pL8jg7bhq/psGQ54W0jjdfLvD12ERfTNls96cW+bjZA37eHA==
X-Received: by 2002:a5d:4576:0:b0:367:84ae:ddac with SMTP id ffacd0b85a97d-36784aedff1mr2314026f8f.17.1719990262321;
        Wed, 03 Jul 2024 00:04:22 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd6b4sm14991759f8f.17.2024.07.03.00.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 00:04:22 -0700 (PDT)
Message-ID: <115b0657ff02ea10c9d0687a637759ed4164ffaa.camel@gmail.com>
Subject: Re: [PATCH 08/20] iio: accel: cros_ec_accel_legacy: make use of
 iio_get_masklength()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alexandru Ardelean <aardelean@baylibre.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Benson Leung <bleung@chromium.org>, Guenter
 Roeck <groeck@chromium.org>, Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea <claudiu.beznea@tuxon.dev>
Date: Wed, 03 Jul 2024 09:08:14 +0200
In-Reply-To: <CA+GgBR-uazN8==3FHWo6Vb_Y3YEoMMnOLqJnfXtAsrS7Pc6B1g@mail.gmail.com>
References: 
	<20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
	 <20240702-dev-iio-masklength-private-v1-8-98193bf536a6@analog.com>
	 <CA+GgBR-uazN8==3FHWo6Vb_Y3YEoMMnOLqJnfXtAsrS7Pc6B1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-03 at 09:37 +0300, Alexandru Ardelean wrote:
> On Tue, Jul 2, 2024 at 7:02=E2=80=AFPM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Ue iio_get_masklength() to access '.masklength' so it can be annotated
> > as __private when there are no more direct users of it.
> >=20
>=20
> I would have suggested maybe a "iio_for_each_active_channel()" here
> instead, but after looking into the driver a bit more, it looks like
> it's part of a broader rework.
>=20

Yeah, we have a scan_mask that I don't think it's guaranteed to be indio_de=
v-
>active_scan_mask. Also don't think (at this point) we need another
iio_for_each_active_channel() helper which takes mask as most of usecases u=
se
indio_dev->active_scan_mask

- Nuno S=C3=A1
>=20

