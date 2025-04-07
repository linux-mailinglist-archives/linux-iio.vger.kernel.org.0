Return-Path: <linux-iio+bounces-17773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15913A7E6CE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 18:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C29423804
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC16120E6E6;
	Mon,  7 Apr 2025 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAUe25Hv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134ED20E6EA
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043052; cv=none; b=Lia3JkATzZ8IOt4jJHEg8PXBGEu1V5AhNifHVjjzJq+sfVm5iHugwfqm/UJisot19qM+t8NxaU2QNSWrSMxjo/xbScj8NzL8L3RxIyzSqiXnD2DvXp4JRSPItbpRrvKO/yNGzte8/SvKDRHaJXWWCG1YpEPo0E9QnIc9OrRJcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043052; c=relaxed/simple;
	bh=22g81uud7KBoGGb9jl96wnWnnQT0kA2wyY0bAh0tRzY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SoHmbPFqgiaI0/7ZK6Lac/PcbnKlAjfbxtqv8lCQxT7G7XaOjCf7g+A6bR2LisVoe+KN6B/R/J6u7jN3uQpHTE4oe/qlyp1A3cp2MINEwqCBMQRD2QFUJLOxkGVdwuETeJzv/0SRpnL7VefSArQQfciBAAjThC5bQFY6EN3QJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAUe25Hv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so24677345e9.3
        for <linux-iio@vger.kernel.org>; Mon, 07 Apr 2025 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744043049; x=1744647849; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sKZD41H2c2OFdIkas2dcbo2x3TAY1Dk6uTZfNa94jqQ=;
        b=hAUe25Hv18ddRECJS2fPYNyoq3kEH+WTrYVtfIPD6qyIwDcaFXHmV/yOEnnj1opKS5
         NZJ+yVT9PycUqjyO3D9bpJbty2SuCOw0IIPKwb13U4AMn6ZROA8XYiinKQl9sBkOyBpt
         sVvtMKMzIRst6AbELKif1rANQlSITHNwZjjt5mT/0awEWEL/ykRUrYIz4CVrhy75PA4p
         yRiZP0pmO9fiqa/IQRGtjfCmYFG+oI7SGztoVmn0dSFEcvplH1Fpr4Y+4vKshauPpWVz
         QX4QkWlGGi7AtgVK4oM/GXhDjxm4Wkut1WcwBGv5PhSIyVLdyItE7ZsKmmNIM/P6TEI4
         TZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043049; x=1744647849;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKZD41H2c2OFdIkas2dcbo2x3TAY1Dk6uTZfNa94jqQ=;
        b=upOokskSuG4zgV2dpiXqvDJ9X9f8doML9hxG+9k2wOeGTYImARLS6VLC0NNNCCexzf
         oh1sv1d1t6JtYbkc+K6y3cJea5HXTwg+4pE92WKiXtt96pUXHpkd0/xiyva1AaK/aJNF
         Q5r3wdxD08ADqblxlRyA0OtQW1d5zEMjjGnpFLHVvyhIKDBz2JunRhVmmX/nAq52W05d
         A3lpW9sUICfntPmxjnqfRt6L7XgMatWmMmuhIaQq/w3kvCbAs9gshi9SDYFFmePtzMym
         G9BwUqLlD6fKSNAZhRF4DqvhIamkhMGpO/Kc8WUrqFIu+c4d68jDRBTsaKTRY1kQXOm3
         B8Lw==
X-Forwarded-Encrypted: i=1; AJvYcCW/UQIbzfWnh8N+yiPwEnvL9mrW3N4VdnHhK6KugZrBkwz3J7Nm3QprtRULkyQbJO7VMw5EXNB2PAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAEF+wAqu/TDHpHmpnPZa4xrxm7LX4Q6HJk756LM42bigA/i2J
	+afz3Dc1+xIKSwPZzo5kiKu8Jb+CwLvyhKsBkmtwC0YDJZtPw3dL
X-Gm-Gg: ASbGnctNnBhfim8VMRaLztGLPdK6sAAwm/3yBfp9oV3TFEqmzzVsdddSi52IE8HUyEr
	sEf0jY/pqJm9+SDfnXxlQc+FiwG0ERI3uuXvr9vRVea/qpdqXflXNiuElWtinbWRiKeypHFnUP9
	Va45zy63ZTk3NEXNpmOhglfXlazE4VLSqXj+oM8mRfvkauf5di/O7rTYAw9dt2NC9GP50rnzCmm
	8r+R0iYyYLiTUV9i29ACqfoMKKni7y5GPVHr+2aANiDJPbYkrflF5DEOPS9OTc5KTJiKz7HhYRU
	hb+ZGErf8FHk39GCrAw/w5Xz/T2IEVxBXl2nPoKkONJ6dbpqiWBF4tPT3EZJaetQ9aFG5b72FIn
	0WGlRa5JN/ES3BBjS
X-Google-Smtp-Source: AGHT+IEHN8XK1ROyFvhN9JqVZ5MYJR3Atwx9wlXUq3IKQdK23CmdMyGnlKiIG3CLGGIRP80dXJUbbw==
X-Received: by 2002:a05:600c:4f0e:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-43ecf9c3224mr99724305e9.25.1744043049194;
        Mon, 07 Apr 2025 09:24:09 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1662feesm136702735e9.12.2025.04.07.09.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:24:08 -0700 (PDT)
Message-ID: <cae4bde5515ec95475dd130c1d508618a38963a5.camel@gmail.com>
Subject: Re: [PATCH v2 04/20] iio: accel: adxl355: Make timestamp 64 bit
 aligned using aligned_s64
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 07 Apr 2025 17:24:09 +0100
In-Reply-To: <20250406172001.2167607-5-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
	 <20250406172001.2167607-5-jic23@kernel.org>
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
> The IIO ABI requires 64 bit aligned timestamps. I this case insufficient
> padding would have been added on architectures where an s64 is only
> 32 bit aligned.=C2=A0 Use aligned_s64 to enforce the correct alignment.
>=20
> Fixes: 327a0eaf19d5 ("iio: accel: adxl355: Add triggered buffer support")
> Reported-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/accel/adxl355_core.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/adxl355_core.c
> b/drivers/iio/accel/adxl355_core.c
> index e8cd21fa77a6..cbac622ef821 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -231,7 +231,7 @@ struct adxl355_data {
> =C2=A0		u8 transf_buf[3];
> =C2=A0		struct {
> =C2=A0			u8 buf[14];
> -			s64 ts;
> +			aligned_s64 ts;
> =C2=A0		} buffer;
> =C2=A0	} __aligned(IIO_DMA_MINALIGN);
> =C2=A0};

