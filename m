Return-Path: <linux-iio+bounces-23448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44EB3CAC8
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 14:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F081BA6B61
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6287727B353;
	Sat, 30 Aug 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k//+X7Sd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8B527A916;
	Sat, 30 Aug 2025 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756556893; cv=none; b=pBPqxCzDCd31iyftmqQQ7uOPB1vCcV8fQODaQxkD5ollVBkOF61p5PfKE9JRLm9aunTAhVK5DludDo0X91oyDGJdXjam95zAlaBNBrS/Suci215WYeJrEMHi0lE6b3vKPEIzTQD9Gj+NAmns+EV8G7fHH3u830HZB+HI1CwGVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756556893; c=relaxed/simple;
	bh=K1QUqIQmmrtYo2Q5+MJeWsGVTSkJyPL+YyobkmmGhKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gI5o3AnfI5bUryGzgfH09jfpYRfFQ/pSTdY74B4TtvBzY2Z8DJY/yQH+Y6HvGR4+7gU8LDZdvNum1jATnV6P2b6VC2uhm3zN8RWZtDCes99QmQ5GCAbX+GUY5TAcd9w8CwB1XQiDTINyR+EEbTjFhf4pNpjW/lLGYK6069Xeae0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k//+X7Sd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb72d5409so512158766b.0;
        Sat, 30 Aug 2025 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756556890; x=1757161690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvc8o7UNrMIYNJEN9nvLvWQOOGJV+mKtBRbCIep0MbE=;
        b=k//+X7SdfvfoVCYygWGPr5YoKhOvsZMefmVVuJYFtXW+mmZxHa8ZjkmzhPJCPY+SsO
         NcSsu5XePIn9OLdG5pTyPnw7XJe4WqgGw/94Bdn2ggnIyZWElrXVdOrNV7QvrqEJJQrN
         L/Rl+hjSdcN6mhu3OLasyd/PCkfPeiQAlaEKge34n3djQsP+R7qW4243HhjUnkr2eW72
         pU558emGIYKA3YtqdShodPItVVZthGranJ1IpPwmHTCJM6Bh6Vp0pqOC7khGFIufgUxQ
         F2RZ/DH+XQfQsXVJghO+9FSXcrKxtqZESSpTluWRqaNscEfi2/p/50LHDA2I967vOBlS
         RpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756556890; x=1757161690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvc8o7UNrMIYNJEN9nvLvWQOOGJV+mKtBRbCIep0MbE=;
        b=hVq835exd2UPw/myhRX2tYvUmGT689ubrMfn21faVHGe5BXQI/APXR/J4aCbh8KlQh
         jKGvJdvWxSCL4ggCmGVamv8dRClTStG8rm0uAQ6VktVsI9VqOBhmyDbHTyYs3CTN/A8+
         BjaHB2C3i1idh3A2Mkc66nU3B1wJlGvUbmIdhXwzahOs6aOdlfjj6j6TI4vOah6nDg12
         QNS0Kh5EN6howhiM2OVjZ0KEbdfrQkpHhEdgWqzrrk/DxITKXOixrnLJhIkpAEm2qgXl
         IG5hqHqHnYpUSzb9Sjh/H3FM9KOqLqWVLSjkp9de3wHHfMuXRbzouKjYykBDnbx+g2VQ
         GA9A==
X-Forwarded-Encrypted: i=1; AJvYcCU3vlRSKbT8lVFoLWvrNnDy4AUXZTJS8mEo06TCALlSmiD5x7ihIfQzmeZH85RPr3ZE4z851+lNvv8R@vger.kernel.org, AJvYcCV3pcaOjanD9C7oWK049Hey2FTsgcF1LPV//fiKwBRSVhzgKdY95n6oHFOdYnX+xtU2FSP5d6nJQtn1g30x/DMKvR8=@vger.kernel.org, AJvYcCWIk5/w2LgQ/8/M+hwQwYnsMC9vfAjc9DNrg5E+lqY90Mn77m+OFgFbsiqcla7PrfubfoWDzCXTleSr@vger.kernel.org, AJvYcCWLbnuF2RUaSglUj07VircZxgQ8i0NCVrHkBEs+fDDo+/ou4+JhIB5oXNUUS6sszy7d2mS4YbEOu661wJ0o@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqAN84wABt+/NFm+/WVmSzz8uJBNx3yzKN06A98Yi+X5qtKw3
	RhRCLh686j25n4NQtTKDv/Q4ZpEqBaeCuIfNtSBqoCNsYVmNATdMqjqsbrvTM5LndX3DSnAbqr0
	zkBEa8FREvOAdt8p58p9eQi+A/9QJy2k=
X-Gm-Gg: ASbGnct1/1Rw+UzXnCQi/Zec72mh11AsjhuBUOQMj+ObCCtNAAWqUXIVIAmHBeTpa+C
	nyfgA3J4lgh9/M66IP4N9YR/Jc2i43PDEmJPK6DXXsJN7/IcmtOwJSbrgqAw+zAYfcbJ8FMUzkn
	ygJR5veoHFh3oyUDDDNZbafv5HdAkhje+FlUCigODgoBr8wS4pq9vi2dPRtuF9ZS63XHhKyN/PI
	Jy2r58=
X-Google-Smtp-Source: AGHT+IEr0gAqLRVPp+T6uONOIrQAUIkZ8IPlCVuv/BuIBm4huTRigMtOCfRrrfAh3rWu2s7VHQSCiaBIs2UpJH3Iosw=
X-Received: by 2002:a17:906:c149:b0:afe:af91:2e44 with SMTP id
 a640c23a62f3a-b01d8a6ac14mr178645166b.14.1756556889693; Sat, 30 Aug 2025
 05:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830-s3c-cleanup-adc-v1-0-de54dfb1d9ea@linaro.org>
In-Reply-To: <20250830-s3c-cleanup-adc-v1-0-de54dfb1d9ea@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 15:27:33 +0300
X-Gm-Features: Ac12FXzTMEaLZRx4DmdS9a1kWVVbTCHUuOOLisze_-ZWmUB9tOIR-XUWXvJJxDc
Message-ID: <CAHp75VfTk7Vr6Rccq0DFDm8Qnhb37iPYj4DwH1U2bwDMV4h_Qw@mail.gmail.com>
Subject: Re: [PATCH 0/5] iio: adc: samsung: Simplify, cleanup and drop S3C2410
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 2:09=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> S3C2410 is gone from kernel, so we can drop its support and remaining
> related pieces.

>       iio: adc: exynos_adc: Drop S3C2410 support
>       iio: adc: exynos_adc: Drop touchscreen support
>       iio: adc: exynos_adc: Drop platform data support

Reviewed-by: Andy Shevchenko <andy@kernel.org>
for patches 1-3.

--=20
With Best Regards,
Andy Shevchenko

