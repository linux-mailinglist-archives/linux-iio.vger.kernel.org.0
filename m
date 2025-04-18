Return-Path: <linux-iio+bounces-18239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760CBA935AF
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 11:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68CF27B52DE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 09:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022E426989D;
	Fri, 18 Apr 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvNas3wH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE14269CF1;
	Fri, 18 Apr 2025 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970266; cv=none; b=GgGoeJSuOA4wtmieg2vVH5Kf7kzIK5EcYaghxlYHWmbC3uzJNGgtD2EgnsbE0k7F3G6NOGACAIXJnHTsnpIOa/E+KyoyU5KKxsTh/UvDd0JuRYEyeRhdPiUMbZGh7CYaRpNJwSe8wROKTRamah9sbE6nXL5ralXy8odkdUrGZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970266; c=relaxed/simple;
	bh=DPXCXDdzGRDaJBA7PVkaoaMrxHBF6CLQ3KTY//OOtRs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDXncTZj6Ip0EPY1K5t9Qiddg1H8KeOPVUMFDLai2QmxyIQ8ZfiWbIT4stfgn89rZOKGoUSYVAviY2ZTz3Qs2IYiDAessxByPjhfxJjGjBebjO/7M6BstXz2EqglTaoTvj2ZpfTP2kIPERbMiYqzJNDeMeCpT/KSVcz9shnPBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvNas3wH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so1143696f8f.0;
        Fri, 18 Apr 2025 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744970263; x=1745575063; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vyt8vlbCUmrgxaje/SGVdwJgpors68AcKgtfPJppRuw=;
        b=kvNas3wH9KjdkD6kYAI7jCIGb/zEsCLCwNATt993BLHD8qzpb0FmsYghQjWGDo3Av/
         VWnSexhjZJLD49361Sl8LNQ3CjmWnz9Q5KHXGzcp1McwP6W9EDRcm7Il1P80XTgUFaI1
         sovKG5mV8iG6DHzOfHuWK7B4q1fToUn3ObovixtZAacnaqhWkpa0JKgjT3CfKknzdt5V
         87stbE36w96UBNY16hCa2ZzaAJoW1iMTpqbaUED8j/XksR9PLguvt1wz7D3iBQTfm4A7
         sHPKJcou3DW77upJLINvqJmyaf1NMWoqsyi3MXgL4b+IqhAPGNhsoQxDmjsjfXSpUlpN
         SiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744970263; x=1745575063;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyt8vlbCUmrgxaje/SGVdwJgpors68AcKgtfPJppRuw=;
        b=IJBYVLb0eVJL9W90Iaim6zxa7ML9VIs/hdnaooV/MtA7XENseZqCymahgW/Z5p3P2V
         Z6Kr9adg6SwPn3hgj9aTHvgpjFksFBwKiQU9VzQDfy9B2XCbTQmDW4CveCC2SoQaZ1PE
         tIb9Hw/nmSWgeHMpFKTXiIngiWr2XNUYCWOPa7ors7m4mDpEtH3uSz55byIIOsD4iXcQ
         QIlPrHrgmxmsJ+ON+4vpebmNCNbZWi48F55UFxRZyHIMAJcF38NUryo8Tfi3//U0b9ra
         Ssxw+Ip7oro7iKM08BVSsntvzpOr1yd7suyYD8dgDwwCZG/st32OwEqnXJ9PHSB0X3ls
         huJg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Fs7ldur5k0N2yruQ2sMouMW+bqsJg5wJEL5ozWn2/tEJ+WgUnJ+vfw63+s+oKX37C2xgJIQDQjxGtJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rWOHgmCGYmPhRW48LFM9fquqMBSPKFRroP8qsMUocxoJirIg
	idEGmZuQJ59eLg24E+4ceTIyZu48s/DwetG5EvOKXmCETfGDL4Ja
X-Gm-Gg: ASbGncs1D9ze/7qIZeqCIM4sYk0fT0E9PbkKNjoEAaF2d65yMJhcRG6dUstdS9gfdh6
	FfRDjMs5gdEbie849rMO8WEeSx6MiPW3cqVLYISSjsdSBsxF9UETSMlBbH73xICJbg5NDfZXfYE
	LgXThA3gSHQcP8W7fo9QW6pr5IotwRTDQDNq3ON304JZULctIUyCnCpvStVE8lNzQpWUNu0W3G+
	EqhdqbeWKXHhDNeznKFxEF/7ITJYIvkQT/6i0/9Xc/MKOGptEu8eQOTzYyb750cHdbbam44q8Kv
	QCBbsgZNxhtPhuyrCd/rNO507Og0yjn9o7p1Z4MCTa32uzQE8RLhC8gg/4dMeZsB0wsRWo/ru5S
	sV4TR1lXWn0q0los=
X-Google-Smtp-Source: AGHT+IFJu/NfcqWAjNuPs+r5w0auetjnU6mwnE3w1maeyZRnlV35H6XNIlmASm/PfX9aMr3HbzbBqw==
X-Received: by 2002:a5d:47c9:0:b0:39e:e588:6746 with SMTP id ffacd0b85a97d-39efbb240e7mr1584070f8f.57.1744970263248;
        Fri, 18 Apr 2025 02:57:43 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a4b68sm2247940f8f.87.2025.04.18.02.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 02:57:42 -0700 (PDT)
Message-ID: <494ee0cc5be01cb6a4db29d7f1a11dcee22850d6.camel@gmail.com>
Subject: Re: [PATCH 1/8] iio: adc: dln2-adc: use aligned_s64 for timestamp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>,  Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Tomasz Duszynski <tduszyns@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,  Andreas Klinger
 <ak@it-klinger.de>, Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Date: Fri, 18 Apr 2025 09:58:04 +0100
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-1-eafac1e22318@baylibre.com>
References: 
	<20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	 <20250417-iio-more-timestamp-alignment-v1-1-eafac1e22318@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 11:52 -0500, David Lechner wrote:
> Follow the pattern of other drivers and use aligned_s64 for the
> timestamp. This will ensure the struct itself it also 8-byte aligned.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

With the fixes tag:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/dln2-adc.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index
> a1e48a756a7b519105393f77c4aebde1f2f85d50..359e26e3f5bcfe16d723f621bdfc01d=
f2dfcf6a9
> 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -466,7 +466,7 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *=
p)
> =C2=A0	struct iio_dev *indio_dev =3D pf->indio_dev;
> =C2=A0	struct {
> =C2=A0		__le16 values[DLN2_ADC_MAX_CHANNELS];
> -		int64_t timestamp_space;
> +		aligned_s64 timestamp_space;
> =C2=A0	} data;
> =C2=A0	struct dln2_adc_get_all_vals dev_data;
> =C2=A0	struct dln2_adc *dln2 =3D iio_priv(indio_dev);
>=20


