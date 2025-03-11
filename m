Return-Path: <linux-iio+bounces-16730-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B00AA5BC4D
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 10:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E2D7A99AD
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDB82222D3;
	Tue, 11 Mar 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRz5Uu2z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35BBEC5;
	Tue, 11 Mar 2025 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685429; cv=none; b=E9/Xa60W/t2atxj+etIavX5FLfvaPoVdlKdXybbe9ScCqz53DibAC7srFAO/ijvMdUEwyrCS2PwZ5aBkw7ZTNl734Weo9Cmd3uJ74RkEX5souhB3bQcJ6QQJU8czcU9P4i3V6at/uqFQZGYvCZWDbVg0ssBpGvrGWRpw0mMtdBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685429; c=relaxed/simple;
	bh=YKKWusVEPuYbvV2rrlks0SmXuehc31lbFjyXp4E3eNQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YdzOA4qe+ns8xMVpTObT14oocO9Z2hr7JvigYdurRHqEcAU3Sr0LTGa+UhlBxlT/cahS8d2H43StBaESMKleCmDlOusVQzAbbyZ8vVAZ0NFxKLc3TnRx9/eIl+BZ5L4rC8nGQX0w3kUxVeradM6p8M+VIE8OZFDXjM6iNfxAyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRz5Uu2z; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso8949305e9.2;
        Tue, 11 Mar 2025 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741685426; x=1742290226; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wmf7tWGBy0+Q+Wo0VDLRVe/HSdaVi0H9c35gwAFIOKE=;
        b=kRz5Uu2zEJO1JZmgtVugef4JI0rjlN7qGV+B8zwn4u05LFQWbThTTCB+FDjKC3tW3P
         B1WPGSzKmhY4uFboQw70nwRphtGfMW3j28nD2VAivQoNB0binkRP+B42fIxLoeQu0x5F
         BLW0szYd7hnf9TjwtqLWzKtf+FUFD4aax0xKaVGbRcj3G9XBro8SInhecpAxVl5JRWB5
         ubkT3K59pIlsWDigrrY1YHcP6ENZ1SRvR2KA/c/t+4QamSXOEfJycSqr7y0FgvrbWoRV
         9MBRIm0jMHtfIexNqq2/k2FBVksMSPZqLAOfGOIaJE2QjwYYVQslyPSeS7uQTvkViXf9
         qmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685426; x=1742290226;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmf7tWGBy0+Q+Wo0VDLRVe/HSdaVi0H9c35gwAFIOKE=;
        b=YuqnCgLYFqipGWhXR89JMN/e09+BqmqSkaJrLOfr29iqg/S0PdVI82x9BHEH5WaIgT
         GV9yNwdsk17k4MnVqIXOcxPNHQc9/OcLZv9Rr98L/o+QMSgHIjHio4XvcoBn1pp5MFeq
         LsvSTVELg55W+KMq3ajAGQm0CWZhYkEKdSLp51Hgi4uBz3GMXkHnxfzaXqhfEu5Wf6b/
         xTR9Bx6kTakcFbMX9wW2lvgw7yIQuZUwLrOP1Tz9Qrtc7JdLdqvctSRC+G0zJiDNoWSq
         kMT0r0K64q56okUN6eMyVTJRfhWmuaG42YxrWTqBJqNbzdiPwxhk+UcG5Sx8Z3MN63/6
         rnDw==
X-Forwarded-Encrypted: i=1; AJvYcCVc7LI1f7k9k/Cg+vAHd7jIiQnC6uUBbyEIRUVmIJ0VwmVQAYszXsczw+BJW6GV0D0iqlQ+e2b1JQZBEKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzceTt1XCOVc2q/GAbIEFzc9Lsb0wGxrtixovTVsN9rlg7XHKpj
	J8dkurDWVKiMJyxKxh6irJDSHcXlDYAUFFXqLd5G+bZ/0fF3cNdJUR7dUCrgW40=
X-Gm-Gg: ASbGncv5zMBu5b8yUCrYwSFBSNuxPpFl+JIfnmFMOOkQdvQfhimwBqq/MFAnHstVi/d
	Ar9ZmJ8Cz9+FTR04yxo1hSNx1EuU0y/EBVvX56qq8w2+1rjp9y75MA3s2nuPj5MfdOQ+wKfqW6J
	N/tb+gtedeTI40vYBhQcJWXPchOAH2rXZ+yYas1oWi0AdNZNrmhuNqjgi63580IHmfBLlTuAzM1
	yQolrcePJ5jHcT4UxvR51QSn0K47zkCrppljCC/WpcSZvbppAFIZGDqTIXZTTL4VT/LRH7Q1XuC
	9h5ZgDSbwKcP5WIdlDVNt2EWomx0PwNiCV8HRy6pa4URGljRMZBoi1N3c2tPJJkciBTLPdce05h
	aqBwn1c+TI9uQLI+z
X-Google-Smtp-Source: AGHT+IHWg9V3cIUsp9hvthuc/1Em8kCwRXxKB2XHUv/zb+BPe3QSusp0mJa1UBMlRsBwMWuJcE+wuA==
X-Received: by 2002:a05:600c:198e:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-43d01b85209mr43416085e9.0.1741685426185;
        Tue, 11 Mar 2025 02:30:26 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cee22c13fsm96944475e9.40.2025.03.11.02.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:30:25 -0700 (PDT)
Message-ID: <5ee9f7cebe54313dbb4054a7215a5220316bce9c.camel@gmail.com>
Subject: Re: [PATCH 5/5] iio: adc: ad4030: explain rearranging raw sample
 data
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Esteban Blanc	
 <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 11 Mar 2025 09:30:32 +0000
In-Reply-To: <20250310-iio-adc-ad4030-check-scan-type-err-v1-5-589e4ebd9711@baylibre.com>
References: 
	<20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
	 <20250310-iio-adc-ad4030-check-scan-type-err-v1-5-589e4ebd9711@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-10 at 15:43 -0500, David Lechner wrote:
> Add a comment explaining why the raw sample data is rearranged in the
> in the ad4030_conversion() function. It is not so obvious from the code
> why this is done.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

(BTW, for some reason I started to send the tags without first checking the
complete series. So I could have just replied to the cover :facepalm:

- Nuno S=C3=A1

> =C2=A0drivers/iio/adc/ad4030.c | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index
> 54ad74b96c9f256a67848330f875379edc828b0b..636f9f33e66af73d102722b984dc123=
0e141
> 7d1e 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -646,6 +646,12 @@ static int ad4030_conversion(struct iio_dev *indio_d=
ev)
> =C2=A0					=C2=A0=C2=A0 &st->rx_data.dual.diff[0],
> =C2=A0					=C2=A0=C2=A0 &st->rx_data.dual.diff[1]);
> =C2=A0
> +	/*
> +	 * If no common mode voltage channel is enabled, we can use the raw
> +	 * data as is. Otherwise, we need to rearrange the data a bit to
> match
> +	 * the natural alignment of the IIO buffer.
> +	 */
> +
> =C2=A0	if (st->mode !=3D AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 st->mode !=3D AD4030_OUT_DATA_MD_24_DIFF_8_COM)
> =C2=A0		return 0;
>=20


