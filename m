Return-Path: <linux-iio+bounces-22713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F64DB25DCD
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 09:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD9F1B68987
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E73277CA6;
	Thu, 14 Aug 2025 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDy9hY5o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DD22472AA;
	Thu, 14 Aug 2025 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157317; cv=none; b=a5JPOUMjyoDHS1lMqSa9lzMpy+YV00EhlxfSoxeqWT/aaPUbDCcWNBifML3lm38CvYbeIrJaq1x4isbiX17cUjItbgr1UZhh5NPsmfeXbeHUAPP69bWr+q0IYgZVHmCVUCWG92yjVEHC/WAxk0SFwNNnpkJVgncrwSQ7/IdGWwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157317; c=relaxed/simple;
	bh=95pkVyiyQQftf87klLRi7TrKiivUcW2/Rg5pHvWJMiE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a4jEwSU8zLcodA5m/FvtuJ+WOQ7+eJCLppci7UZZtJg8fnUahHJBVUgcUOZcyIC5EPSi6eVDlbLxO6TGbEgBVYAbJmVgOMXJhBSQJ4u/WyA9jHQ9/ggCHHnKQAwCbKr8XP/7ZLjUBGccFF4e6LBMHwUDJeQb7O5qV6oQzSRtl1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDy9hY5o; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9e4193083so480694f8f.3;
        Thu, 14 Aug 2025 00:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755157314; x=1755762114; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=95pkVyiyQQftf87klLRi7TrKiivUcW2/Rg5pHvWJMiE=;
        b=TDy9hY5oa0vEzQufKLp1K3ScVqu0v3bZPM7SLpzdeaxzv2VpaiyHs22yxJDf6+vlPV
         EzTmc8fNLtM55XHMQkDQ+dSPmLcau6RPYetFgBLrP3Jl6qOSamuvMXyPuFS32Uo91Tw9
         p2SvFkUYjsCBQNUzYWPNQp27TB5o4D0MfDd8pJX+JvOhcvIumXPyuq7y29De+Fthf5ho
         SNxglIcxgCGBkK44sSFNOoS+8tLVSHQx1PKZBQvgM6ouuesLT6s9NsrqRwWrhG/S+Exf
         I4nGZ1jLV80QsFY7gJmVf/NzngtGs7ZtJWDapIOQtXWc51l+8iN9JUh0ktjvgaZaHH+y
         +LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755157314; x=1755762114;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95pkVyiyQQftf87klLRi7TrKiivUcW2/Rg5pHvWJMiE=;
        b=nAolSpsEO1nbVBdGtGukrYo6Rf49VxRq08OIJCemxJ974yVG4ZTY9N+qZXPgbSPtqB
         GCdnZq3UfJ9mK4EfnIT7Xk+RV7ZqRgTw9sI0E8W8c+0/8EXkRcplFstoZ95XG6ktc1t6
         KiVCclkAU2MBZPAQMw8zgvZWEWWdyFnOlMpI3iJNA8gjSXZBbAbzv3Ys3XB2yCHiOJZu
         72iNLzkIVfsTI+h//tkYLGQ3a+6+cU10rV8vkN1GJgQ7UhGWnP50jU7Q0FIJzh7NsTfd
         SdQcaZkIEy9A6sndX4pHIGsfg43osWXlLQQIXk1uREvPXQSOVcyDfSkCn34XWUSE1BgS
         sanQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHnr/sae9TbZ4vCDS4bX2a5ufqWc0KyPvCyqVRJzidIQYqMPaJIUG19EAnzaX4wMNI+gyaPMdfDYZQ@vger.kernel.org, AJvYcCVIeDgPWp7dD3125A1AXxJsy+sVoXxmbc1uzRQnBzL5WoxZSk+n64Fyxn3YEdgs/SaygCLeT8UPWVotcuuA@vger.kernel.org, AJvYcCXly4nY7BujBfI5zQukVF4b8Wkesn3pjTdgbPGIorsgqlQqUKh7WCndnM+pI8kkDtwWvxQ0nqOtRYme@vger.kernel.org
X-Gm-Message-State: AOJu0YyxxT37mJiz28sU/GqOZ1XGICoGngVrXZaO46RncNMtZsGw8D33
	x93/7LO2g4XkaviU6DdbpoRg84UT1W2Hq0oP8V/xITVa4D0ZgNbGctsq
X-Gm-Gg: ASbGncvkOV6ixXfYvzqCLUlB7dr6pgA9B4gS26qdk9XWSOnb8EpjqDwgK9UoFLRRb2n
	1G5U3Eh3k4ib1M12IRYhk9veLuM+QlH5mgFzRxagqxdCOvwbeYk72JkzVg0sz6zYWaukN37Tmim
	Eb2aEETH719jGHslzXOH8QbyE91+KQvQ6HlSzwfMqkN0OMy5+psB7exsgEblsHUsV6RMLlZVi1w
	I8FJ+SPDAbKvuXSuTA7SMIPE/wFFr7KQYvTXJXeONR8EmI0z7vtslQYHZbadj/y0T2fYipDDskF
	D55b3SY9SUdIvVwBqN+4G0Ld1tP93srm5xVIYlvZoqPS+SzQjO6bRdOVWmyYOBK9MFCq+n3kSB4
	1eeyArONFHdTMWFyk9Oeuk6yfICLq1Uszps1Ye1Wc1e8msOJkFCiFi/NdxQ/RNlczXZFqwp3Oj4
	fP+sHYrH0=
X-Google-Smtp-Source: AGHT+IHkOw24u8RuwNP+9gnD06nBLmyFoAvEktQxd4/kFTIBIRRoIBuhG43z5tniUPql4I/69y1wlw==
X-Received: by 2002:a05:6000:2010:b0:3b8:d14b:8f86 with SMTP id ffacd0b85a97d-3b9edf4458fmr1707165f8f.45.1755157313754;
        Thu, 14 Aug 2025 00:41:53 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cd044sm11017685e9.9.2025.08.14.00.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:41:53 -0700 (PDT)
Message-ID: <8330984c9e5130fb24b92a32d82899a7782f463e.camel@gmail.com>
Subject: Re: [PATCH 0/4] Add support for ADAQ776x-1 ADC Family
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
  devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jonath4nns@gmail.com
Date: Thu, 14 Aug 2025 07:42:37 +0100
In-Reply-To: <cover.1754617360.git.Jonathan.Santos@analog.com>
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-12 at 23:48 -0300, Jonathan Santos wrote:
> This adds support for the ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1 devices.=
=20
>=20
> The ADAQ7768-1 and ADAQ7769-1 integrate a programmable gain amplifier (PG=
A)
> with 7 and 8 gain options, respectively. The ADAQ7767-1 and ADAQ7769-1=
=20
> also feature a 3-pin selectable Anti-aliasing filter (AAF) gain.
>=20
> Jonathan Santos (4):
> =C2=A0 dt-bindings: iio: adc: ad7768-1: add new supported parts
> =C2=A0 iio: adc: ad7768-1: introduce chip info for future multidevice sup=
port
> =C2=A0 iio: adc: ad7768-1: use devm_regulator_get_enable_read_voltage
> =C2=A0 iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family
>=20
> =C2=A0.../bindings/iio/adc/adi,ad7768-1.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 48 ++-
> =C2=A0drivers/iio/adc/ad7768-1.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 389 +++++++++++++++---
> =C2=A02 files changed, 382 insertions(+), 55 deletions(-)
>=20
>=20
> base-commit: 0a686b9c4f847dc21346df8e56d5b119918fefef

With Andy's feedback fixed:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>


