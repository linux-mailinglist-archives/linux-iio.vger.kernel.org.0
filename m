Return-Path: <linux-iio+bounces-17772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D37A7E6C9
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B2A442F20
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1692116E1;
	Mon,  7 Apr 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxoOY4cv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7520E314
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043033; cv=none; b=XMFdoFls5wb8zeKR3EYXtw3Ist/EdKBpX3ZKD+eS8usDOXCE3VtldUQMkddmn+2pxNd74G6+DWBtEOwcwkNAhhLFtNcAh2jXUOf6b36vn+a19Mfs0BMhpzn0rc4J3iAFEIXvq+s6ICvaCv6f1ImdcZnjIBAs+Oz8tyi00L4lods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043033; c=relaxed/simple;
	bh=AlG+uV3riE4txM1+s5ZoXHiDM70Z0IbAIIT1tlFGKCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rdr5a+veRyEiYVyBXYZHAR3GXEVNiyOQ/urUE8QY9AxA6sWAo8hGCmVrPO9WnFEjVRgX57gX5llL5s6pV7nGugeVAXYD5T4Q4wY+k3TWY00qL5uQ8xntK5+aMh9l9ji7BZgW8zKJezJZlja89i7Y/r43S9U9h0S5dmA4+Y9f734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxoOY4cv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43690d4605dso31096245e9.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744043030; x=1744647830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cAIwAFIkZGnM5h8uWjH//Z+fhHOMNi8zITm4h9eMVCI=;
        b=VxoOY4cv419YnmhOM3HV933QwNlxGBG8K5sJCxon5kEWIEmwRhUASG8zkvd0gCaiwh
         IjmP04BZj4LpKIncUIvow0ZK7dd/W7CS79gsVmMp4Ezr6hzh6MFnNOrypaFugSfefiJ3
         ymaZ0i1xs0Cwg3oYhtCdmxDohY05f1tv5/aCj0G4+AXxyTM+5YIY/4NwyKNVbwxQbPpn
         aztPSljWu6MM9ATpw/VHjF45mM5bOVdthlWkmULeut1SMBxgN1qfjOSX8iFTWOXIZhp0
         JkkrxDhA62ckfBxlhSFefUYijkMt0u0vsF0kkPx03DiKTCc3Gnp8j3hnmFyW1i7imRhJ
         47cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043030; x=1744647830;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAIwAFIkZGnM5h8uWjH//Z+fhHOMNi8zITm4h9eMVCI=;
        b=RW6vSMlPK3BNVYWspuYvc26FcCnIbYJ5Hu32pzQltVyjzm+0t0gzRU1BQ/sB2ZG91+
         Ht074oOMM0neLJ4hTSxfdsYmJQyLjyVQw84kEajm05YTn6+NXlh4TzQpycEkQLPqvcrt
         0kNKoqdADV0c7/RceHu3rry120+XCTh3W4e56p5+e9lYMNrdpyn/Pfs7GrMQ/KWWNTIy
         a35MfwNzKtFKDwmCAKHzUIaNUaCziGNewtKdlnHpVYeZJxc8w++Wwjr9e7149kI+RnFV
         sAacOQ0JS/RRJnfCaqoFOL+Iea+NUj+5B2DQ10VviyugIlYPWDL7CA0EbokoyNLyZxEd
         Y3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy0SNg/Hi8kDBfjppc7cI75t14BJo4caQ8yvZNhauVQ3GdUsBunjLnK7SkU3dd54Wg8vHwF/C84lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIowO0VNqdjsmluPfZt/IshL7DcA+bhY7EasqpqyKch/QPdvZ
	0mOVOdi/prsXNKdI7I+X22NMeAS81ntn0mmW2WpfcHmmm9e+U2Em
X-Gm-Gg: ASbGncv2JUOhEuBXkfWZmHA87/9iyrsfr5XXUYAwcjmUg+udXCtfZrmjxx0LCCMx/Qe
	paNt2xPXulXAv5DfioMSlfYb5MtJ7oyaP2aeYK8utx6ZHrI9mDpArIE9TjeUOxMKTRzhvMPSRhf
	W4NM8Lg1AxrU+9blk8umpNigREjPFmoO4obEjDJn9n6ffXKpmLap8QgzxYEE6fCzAc8wQYmk4WK
	bMDgCWb3xC8GzGRXYQmoyHuXMQ24i2craJ0GaZgMVk4wjBYBvpheUC7HEn6DWOGENSfO/eFF0vm
	xUdn9+KqlDBahgH7USVIP2x44Jtzs7UIGAjrjPxgdJ9GcmwVPWaWzlKdTqUkZ0ysoHytGFtOnOF
	FmJpjaHBBsCM5Rn8joEVOU2S/bLY=
X-Google-Smtp-Source: AGHT+IFdoZtqiv+lCt5u2YLTd1Blmo9+LVl3ET6gajVaN8YDFSRlvV4BSEOoA9FdmUUyXINedZyq+g==
X-Received: by 2002:a05:600c:4f08:b0:43c:e2dd:98f3 with SMTP id 5b1f17b1804b1-43ecf9c4235mr91870955e9.21.1744043029557;
        Mon, 07 Apr 2025 09:23:49 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec36691b3sm136950345e9.34.2025.04.07.09.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:23:49 -0700 (PDT)
Message-ID: <963ce00109494ccf2396f15bce919f94af5bd0e1.camel@gmail.com>
Subject: Re: [PATCH v2 02/20] iio: adc: ad7768-1: Fix insufficient alignment
 of timestamp.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 07 Apr 2025 17:23:49 +0100
In-Reply-To: <20250406172001.2167607-3-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
	 <20250406172001.2167607-3-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-04-06 at 18:19 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> On architectures where an s64 is not 64 bit aligned, this may
> result insufficient alignment of the timestamp and the structure
> being too small. Use aligned_s64 to force the alignment.
>=20
> Fixes: a1caeebab07e ("iio: adc: ad7768-1: Fix too small buffer passed to
> iio_push_to_buffers_with_timestamp()") # aligned_s64 newer
> Reported-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7768-1.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 5a863005aca6..5e0be36af0c5 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -168,7 +168,7 @@ struct ad7768_state {
> =C2=A0	union {
> =C2=A0		struct {
> =C2=A0			__be32 chan;
> -			s64 timestamp;
> +			aligned_s64 timestamp;
> =C2=A0		} scan;
> =C2=A0		__be32 d32;
> =C2=A0		u8 d8[2];

