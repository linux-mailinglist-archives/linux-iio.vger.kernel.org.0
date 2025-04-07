Return-Path: <linux-iio+bounces-17771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2BBA7E69C
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE2E1901AA6
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A881F20AF7E;
	Mon,  7 Apr 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZErjsPy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B7D209F32
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043014; cv=none; b=tUURThQKOZ+OUuQaY73MOc/EoHmPtMEsMoq6Hvz0upfbPKO/4G5umOy1lNUVz/MGCteAhUxV8/Cr3DgQKctfYEzmKWU7E/Yyi1437O/apv5bJxsgiA04mH3e+MC/Qs/xNP9gh89uHt+FBAG/Ko1DkeGY3oIgJ6rzQgDPTdYQxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043014; c=relaxed/simple;
	bh=vRVrWJ3L9pqC3C7k2gSNIRpGHM0Hqo65gqT0cTC+tMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ka6cos/FMkNNGNLT5wyOAeWKLujgy6rZjlQM3gFnGO078PW+5OBhNsClZIPyX50cgWmPGVcI/haHHFq1UaLBCwguK6WJpoSxioOX0cpBZCE5ZilhXKyX7Fu7EYBTLa7meJdxYojY0TSK1DAlG0iZn8yDwlVdHR0sULjoD5pgEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZErjsPy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a823036so42674675e9.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744043011; x=1744647811; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IugJknnOhVfVO2UA+62e+vNmfTnFW1bjkJUDRoqKTeM=;
        b=HZErjsPyc43m2B+llAD92m9dcZKCPRD6CVe4DmWpD8V1epIVdER8RVTvWQFZEwmdEa
         EpVQ+CEpWh8Q/ladV6Lztk7iLE6Q8aETSsbQz1RGvLMxWCcc2HhV0qXZoE9e7n9leWZi
         aUapRTJOaztWW5kZN/hsf9zRocMIauPVMFZ410fUPHOajmJcY6KiQGmNAdJWt5CpR0Ix
         X/zAIL9Q+2Vc75ZTF6U45YP9et4rtSfBCQjYEossFnObIllbQhUJBVakGnvrF+6qmmzQ
         rPSw8K4W1o2DHGCLUDGm6g0UWXnYzajYDaoPF0STjmdF5yirqgzE9RNCWvFfKIcxaw0E
         F9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043011; x=1744647811;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IugJknnOhVfVO2UA+62e+vNmfTnFW1bjkJUDRoqKTeM=;
        b=cHDUyu3w2kjR7xaxmMwrxEVB0HT2X1FkOMXtd1kwcjCC0wU9DlzY2je7IRgBy7rKyz
         lyLL1zTuEMHwPQWpdGrs4Lgmg5adj8AIk6XjKhf8mDTDeFXe0L20xNYMmTRwB4gykcGa
         i2cCSCzGOGiEDeIw9kWCVD/Ft2BTQP5XcWqhlGJTOO6LwGfdfunKhHeB5tuUD66xUpeb
         6HpimPy+wrhE3/GcFtqNL8eFhl2hI1jfeuuXXllHVo+oxwk/YI4IlWTfNsMkVIa0gB/T
         kxz7+lIGj21k0NUBu0p1rq4BhjIAtMdqskVFxRhXsWqxB7w/NyU/A+u73IfudAbgvRCh
         ltaw==
X-Forwarded-Encrypted: i=1; AJvYcCVOHoiKKy4ftgO9xVXeMTA0btIyd4mDNh2n7YAmJXQU87FcAG3n4tI3snHK9IXLunR8HJDLyMqgGck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYKwBfKyRa9zo3RfJb7f6TWxPemjmkeGt1uGGcPup9uHKgs3pa
	g78hJh/B2CtIBnXQIIZwzkjVIFf9pX+yXbnmciVWqLGd4WN09d5/
X-Gm-Gg: ASbGnct6bjkjqiFI2VO7qNCHwQQxRc3Xx8adisFZEOP6H/+W+lyaWLGqa9csI683W55
	90HwfdgUE4gVKhFAd0Nn+BhKJPrL/Rz4taAKzZhq4Ig/keLtAoGl2NtO73qbhk5zLObgQx7X15v
	Z7Mcm/j3LESlzq9vQ/AC1M4qpkSZN+rZf1vZBhMDjPPF2JCJI37M+2hDwd8nZOGf8fnhvxWF21f
	Oi4w9NcdzFSV9S+LUDoBnESNvEBOLBiwaYdxnWE2SrAnOBQ86GvQzQrK0KEmxCpFq0It0s3OiFx
	jNwPebOWUBNw5siJ8V0vh/6U1TaS2wI0Th4Sxv7WPNEuc2FqkKOM5R1YN21mhPGrNd3EAb60Jss
	ZhmkMVnDon3yAEyEB
X-Google-Smtp-Source: AGHT+IE6DrRokYcrsvgdqeO0pxPdlOPJP+qPavMLySyLwrQA0ft3AjwsiA8Sw0vnaYglOacZ642KGA==
X-Received: by 2002:a05:600c:c0e:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-43ee0694e51mr101024945e9.17.1744043010953;
        Mon, 07 Apr 2025 09:23:30 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1795630sm141825585e9.29.2025.04.07.09.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:23:30 -0700 (PDT)
Message-ID: <87a77863b890cb361ba8fafa27768326f689767a.camel@gmail.com>
Subject: Re: [PATCH v2 01/20] iio: adc: ad7266: Fix potential timestamp
 alignment issue.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 07 Apr 2025 17:23:31 +0100
In-Reply-To: <20250406172001.2167607-2-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
	 <20250406172001.2167607-2-jic23@kernel.org>
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
> On architectures where an s64 is only aligned to 32 bits insufficient
> padding would be left between the earlier elements and the timestamp.
> Use aligned_s64 to enforce the correct placement and ensure the
> storage is large enough.
>=20
> Fixes: 54e018da3141 ("iio:ad7266: Mark transfer buffer as __be16") #
> aligned_s64 is much newer.
> Reported-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7266.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 18559757f908..7fef2727f89e 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -45,7 +45,7 @@ struct ad7266_state {
> =C2=A0	 */
> =C2=A0	struct {
> =C2=A0		__be16 sample[2];
> -		s64 timestamp;
> +		aligned_s64 timestamp;
> =C2=A0	} data __aligned(IIO_DMA_MINALIGN);
> =C2=A0};
> =C2=A0

