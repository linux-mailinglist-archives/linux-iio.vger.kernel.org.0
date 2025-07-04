Return-Path: <linux-iio+bounces-21349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2261AF92E5
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 14:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B4C3AA5AB
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FE82D94A5;
	Fri,  4 Jul 2025 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW231LNU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108572D948E;
	Fri,  4 Jul 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751632789; cv=none; b=K065XCJexI8NST8n58jgKxA+gzN2PhpNTZBu0B5mNEO6d44mkg55KY/wn9Y6jMSyvZCEr7peI8LkAw09TR1IwYjhSNUSz1UW/8lwOMbS/O3qFIJdvzu4B5UOV8ch9BcISbK76t2QQRWl2ei2vS9DuWCL6LwSSG+TFbBODlzhcEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751632789; c=relaxed/simple;
	bh=kM65gUyDV8Nq6O0X5HePJHOOeCngpBNSIlUrnpmpZME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XpkmZc0XcYDYDz2YdIu9PJDexfQuMBVb+8X+LA59XJapk7S9NrqGF8hY5t2z5n/6fAGu68gbVdka4WXbE9kl1BsRi6JiMxW7+8Asgbh1dfOb1MN9xNizMH9iYEGcVLr7/XQri8fel2L5M5Iujc+xMH0upLx/z8M79S5pbR5VijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZW231LNU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1328238f8f.1;
        Fri, 04 Jul 2025 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751632786; x=1752237586; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kM65gUyDV8Nq6O0X5HePJHOOeCngpBNSIlUrnpmpZME=;
        b=ZW231LNUQSMqUpOkf0PO1o1HIEPt17lH9kRNXzVMEOApgXSXqZ08qa++OMRa9tSmS/
         xPBwKMc2Wrinmy5BYpcgaxCkSMGK1lPiLuqiEG9Ezk7qsHif0UoAqWRLf7V6Y67H+EOa
         oRTjOZdUajcIUQvF2b/tjTbm70e6qsXi0CQR4sQ67+pL/GG5e1mnkLjIw/J4guGajm25
         LT6Ph/Ox47GJ5rwqatXFiwnwhBqoL1dKbdoZPSNQgQkQlM81l2RpXQN8BwI+UoeD+06Z
         h9ojYol2s6QNTIVJTg4Q+kKl6unY8xEB23XXYpmbXi15VpRqh0Ydx/Jnuuk246X6FSkr
         PeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751632786; x=1752237586;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kM65gUyDV8Nq6O0X5HePJHOOeCngpBNSIlUrnpmpZME=;
        b=T9tSai3zYBHKxQmbHn3794wk2U7TFHJmJ4oecMkPA1A4Gtf14bnR2OgAEZQ39XmZxc
         rn4sSlq/uK6/RoqeIuyFjeeE2j5DHrD7GnT7KDPR6vv8RJkhfTZn0WMCaOuTVoI9v2sp
         WKGixoa7j5Zxa5DNOsCIDJIrl/XJlHAXQykf9/gA4U/XqLroW9ZEXyvXAg1KCFXeSrdt
         aF2pqsQ3BM7MUWNyWaO+NNIYX3jy9NYBlo+l5c1owp0IN/MZ2tnCb4MTRhRshc77gjR7
         BkEVBmltNKyqC44O8f2cfm3/AtvPBUs+zrfZDz7m7ouxQ4qQs/axcyQ/ZH60MCuMeVa7
         oygg==
X-Forwarded-Encrypted: i=1; AJvYcCUNOm6xvvRUJr9X8HM1z2SVeL9S1RH2A9tSUE6ZB6YGTAlc3cUTMTiUqItLRbX9Y9zqz17MZVVxjrg+@vger.kernel.org, AJvYcCWOMOXZkgbosfLZDXS+BH6G94XQd/uIkMsGkqfaVazeUg3Y28XuZCM7+nZ9Zl2JX0z4P+en3kBpBKodZiLI@vger.kernel.org, AJvYcCX5PdsFgsTJJJ6guad69FGTNUQgCxQw4lxZyofZeM/WiRYTQQnJIKZsemCF8MnXGqWGqaxMi9Ad8CAl@vger.kernel.org
X-Gm-Message-State: AOJu0YxE287CRNkxg3WflIi3V+RfAlBSNskJy6V8OLIkpbFv/2aBMhnu
	vEwzFY8zi28E5vq/PQVwDlcWemSfnFKsd+OqE5aUZSTY/OTaXfdVF6fx
X-Gm-Gg: ASbGncvgas6uxAkSfn1Y5nVipneWTvMss9TJrRgHp6GInJjfkl9buUYKPPL/XlD/4G8
	0/9qQzlMcQoJj9Y5vWaSKAJjJYuXm4AlI8Gxka8IWKUQp45oBjqhDWiTc/CtF9zLOud3pgGbrwx
	6/xO+ZPBQZoaDk+u27j9Vvm6eDrp9zuqfPM/WoOXH3bcqIQdlltpX0LRXEepRpHF1+ldORbyAF1
	mG/H7fSEVX/ITHQwm7ykR8MH7WfUgxjlqXY26/8RvIHpn8RtLqkf6kh26SWHi2WTsfoMsOEYcvx
	6wyam+sKbWAFvPFtaNWHweh3zpEyEFDcGkE6DEIRyaKrhAv9TXkWuZREgSXgCsNERXSOVg==
X-Google-Smtp-Source: AGHT+IGEZQqooZXYhGVoWPdBr2vTu84V+4w3rPWYqllSwEygO+t6NPXOBmMzmHVAtMjkZ8S2Ox0sXg==
X-Received: by 2002:a05:6000:4911:b0:3a5:2915:ed68 with SMTP id ffacd0b85a97d-3b495ccbb9emr2195447f8f.28.1751632786152;
        Fri, 04 Jul 2025 05:39:46 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030b4f6sm2467772f8f.10.2025.07.04.05.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 05:39:45 -0700 (PDT)
Message-ID: <ab0a407412c705e409d9d26591543713a092c13f.camel@gmail.com>
Subject: Re: [PATCH v2 0/6] iio: Add support for MT6363/6373 Auxiliary ADC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-mediatek@lists.infradead.org,
 kernel@collabora.com
Date: Fri, 04 Jul 2025 13:39:56 +0100
In-Reply-To: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
References: 
	<20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-03 at 16:11 +0200, AngeloGioacchino Del Regno wrote:
> Changes in v2:
> =C2=A0- Added error checks to all regmap r/w operations
> =C2=A0- Moved adc_vref addition to different commit
> =C2=A0- Various other fixes
>=20
> This series adds support for the Auxiliary ADC IP found on the new
> MediaTek MT6363 and MT6373 PMICs, found on board designs featuring
> the MT8196 Chromebook SoC or the MT6991 Dimensity 9400 Smartphone SoC.
>=20
> AngeloGioacchino Del Regno (6):
> =C2=A0 dt-bindings: iio: adc: mt6359: Add MT6363 PMIC AuxADC
> =C2=A0 dt-bindings: iio: adc: mt6359: Add MT6373 PMIC AuxADC
> =C2=A0 iio: adc: mt6359: Add ready register index and mask to channel dat=
a
> =C2=A0 iio: adc: mt6359: Move reference voltage to platform data
> =C2=A0 iio: adc: mt6359: Add support for MediaTek MT6363 PMIC AUXADC
> =C2=A0 iio: adc: mt6359: Add support for MediaTek MT6373 PMIC AUXADC
>=20
> =C2=A0.../iio/adc/mediatek,mt6359-auxadc.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/iio/adc/mt6359-auxadc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 440 +++++++++++++++---
> =C2=A0.../iio/adc/mediatek,mt6363-auxadc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 24 +
> =C2=A0.../iio/adc/mediatek,mt6373-auxadc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +
> =C2=A04 files changed, 416 insertions(+), 69 deletions(-)
> =C2=A0create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6363-auxa=
dc.h
> =C2=A0create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6373-auxa=
dc.h


LGTM,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

