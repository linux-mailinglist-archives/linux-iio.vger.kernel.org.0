Return-Path: <linux-iio+bounces-8129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 946679446AA
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 10:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB001F219E5
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9B716F8F5;
	Thu,  1 Aug 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKGukX+u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D99A130E4A;
	Thu,  1 Aug 2024 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501141; cv=none; b=Xmsl2nWr3VaJy8NdguAGhdTFk6B3wIknrdnpvVi9FqUqRCpSkjcUF86vY6XUFPH71BS0VpOhmaxtGNZ2YI9jtab56oMobPSr+/JdRaBRd5a+SjbTHzowfEB3gTIbWCwCYjLt8+egwp3FOuzh2fQyjoTYRcfAIulwkLRUr32eWzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501141; c=relaxed/simple;
	bh=qkoQFL07ssSYlSUCk3oAK//k9g4lIbps8im3ROswpxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOPMwilgQijwLo85l39gzpGpekgzy3Xx/ZxQSS4bxpCOxtZqnb6EbmauoiPpZQ43HqaLogew4SOwAXtPJ0B3Y+BgMhHNUj+JtOJ0RdSwPGV4Mmf0JowRSutNXGLeRt6zqvvMlqaRDBRHPbeZExBihJ5AW2AEsjE9N9vnkOn0Xj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKGukX+u; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7d638a1f27so340941966b.2;
        Thu, 01 Aug 2024 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722501138; x=1723105938; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qkoQFL07ssSYlSUCk3oAK//k9g4lIbps8im3ROswpxY=;
        b=TKGukX+uKaOl4+70jqMulhyLr49cxS2NoWTjJVb9PdJIuMW8aLOGUP9G4xmCHgnHnd
         xP8pJzfHqycF5ZhhAE7NfNWfB5LJh2EuovptGJQC2pCVInFipLzIK0dzAuayBbxKH/mS
         FMtcAG8OVuqX/Ao49MYV5LKHY5LO4sv23baPU5HUj51utToUaF+e2MivQ1a1qOWxsrRk
         PSUKL4hlc0YOC7Lp7vh6TZCGijBtnWBperK/svWNNPg6dUBSV2sXEVGyi1r+lT5v2s/C
         WqjL9vo9uPsbs0Rpvgt8YySEEv/meldDs0G3cXZXWXNm8KJhZhZajgn2yy0E3XKQVhzw
         5EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501138; x=1723105938;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkoQFL07ssSYlSUCk3oAK//k9g4lIbps8im3ROswpxY=;
        b=VQ3AgSgEpQRJe5ivK7UwJ6sHLWDsq4S78532ht0hutXwiCgxdl7rxwGLfR0CP59ZFH
         6f3/waM0aKAOTZ11VsNKh4HIQNzBp7m7GwneAeUDWDc3DK8lIh/GvsoYif3M9ynUWAhm
         9xfC5vHEGqekFrCwCs4qh5fhBgpjPf/R6rLW9Fc0yqybRIRLS1D+kBkOJ5Z/eelZMc3+
         xXYTo2RQ0+aHupwdZB0VWTSkgsVO28U65A7wq+avLok/ygk9mLk7yw+XbnCKt6mopR2C
         3aFxkqC0ldDkx93cOtBuEA8NX3T8HqOBE8jDLLOB1sBZC4Zo+zV5NWX1kq2myMsqTemu
         9pog==
X-Forwarded-Encrypted: i=1; AJvYcCVjvstgMbA6UKZGseaaaE2RCKKLX03SEdaoQJDCMie4/I5B8kSt8OXVvOxO+D7yazadQM/ZjEG8OOr7vu39W6gE5Z5uKRv7x+HySOedkknSva5PHFx5SWY7DqhtNOqlog4ETbcZAS0t
X-Gm-Message-State: AOJu0YwQPxduSNVTGs0jmVXFRq/f59Wzp0SbSh4jCtbA9djguzBAg+88
	dwsq+zkqVZMYtOEZFEuWRUYlWjfxxdUeECHH0PhpbCsKDRkRnZqVXb7FikDSxWs=
X-Google-Smtp-Source: AGHT+IH5SzNIDaQpQyKa61G7z/j/6qCbg2VAFMF4TGiXyf+qyk1L9IhviRUHshwMNd+UAXB3Jvl+5w==
X-Received: by 2002:aa7:c04a:0:b0:5a7:464a:abf with SMTP id 4fb4d7f45d1cf-5b7008ae7d3mr1400551a12.24.1722501137311;
        Thu, 01 Aug 2024 01:32:17 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb3cb8sm9670411a12.77.2024.08.01.01.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:32:17 -0700 (PDT)
Message-ID: <6e6e2f4163faa217e87a5c44a7c35cfba5870844.camel@gmail.com>
Subject: Re: [PATCH 0/4] ad7124 fixes and improvements
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, Stefan Popa <stefan.popa@analog.com>, Alexandru Tachici
 <alexandru.tachici@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <dumitru.ceclan@analog.com>
Date: Thu, 01 Aug 2024 10:36:16 +0200
In-Reply-To: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
References: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-31 at 15:37 +0300, Dumitru Ceclan wrote:
> This patch series adds fixes and improvements in the ad7124 driver.
>=20
> Fixes:
> - properly compare config values
> - add a delay after reset to allow chip initialization
>=20
> Improvements:
> - reduce the number of SPI transfers
> - ensure that after probe the ADC is in idle mode
> =C2=A0 and not continuos conversion mode
>=20
> Another thing that could be considered is improving the config pop
> behavior as kfifo_get() will return the least recently added config
> instead of the least recently *used* one.
>=20
> This could be an issue when multiple channels are using the same "old"
> config and the LRU considers that one as the least recently used.
>=20
> If this is considered a valid issue, I can add another patch for it.
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> Dumitru Ceclan (4):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7124: fix chip ID mismatch
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7124: fix config comparison
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7124: reduce the number of SPI=
 transfers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7124: set initial ADC mode to =
idle
>=20
> =C2=A0drivers/iio/adc/ad7124.c | 61 ++++++++++++++++++++++++-------------=
----------
> -
> =C2=A01 file changed, 31 insertions(+), 30 deletions(-)
> ---
> base-commit: 380afccc2a55e8015adae4266e8beff96ab620be
> change-id: 20240731-ad7124-fix-37aec7fe0b6b
>=20
> Best regards,


