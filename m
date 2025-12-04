Return-Path: <linux-iio+bounces-26736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44086CA40E7
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 15:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 021A8307DF1A
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 14:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1654344057;
	Thu,  4 Dec 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6/rHqn9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A149C32A3DE
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764858954; cv=none; b=ZwUQ2YxVCqyquierl2eO7oOmrCcWI+dB4rrOC/vH9QwcBD1DDtcIDcwJ0yrZ6QTDajJMnaXqX0ykrIGFpHGAv8YgUxDcaiy/8Vpxz/e7SNoZRKxgfVzIgWb7CmFzWwUeJh/YEURKeEnQ5y9UfLeITWBnBrpGsNBJ4QOZvWCEV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764858954; c=relaxed/simple;
	bh=Hzz+mPxqldPjZ0UGeBzerpsI2NE9QERo1z4GmIcyRAs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=as143RV2RwnqBjyUn4q39GVGpqi/GXKIhuzNmzTWKDD4kqsXUscEpKc+NJW10c+Alb9OEID5/kKRq01kdJrgTFcI1WEjIN3P6B8Uo0r+zSySnpE29kwz/P6N01cXlin2uAmigyxBsO9nX/1NrCxHMkK54XxR9GS6CM2hDI3VczU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6/rHqn9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a1c28778so14312025e9.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 06:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764858951; x=1765463751; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Ns2EjNq5op1uWpU/IDU/iN5rRJVwaStIACnAldV00Y=;
        b=S6/rHqn9E6dMhZrOqG2IzpTGVHBQ19zK7R718LJs9Iz26CEyqyf7DL9awAwNoszkEA
         tYQmXqr2ybPV6TBnMYYrL934rQNohrDGcEp9ZfZEAJfOzx+eP+IGrXTofOF5YSJAJ+wp
         iUMxsLvZD75PVUeFe8YrAVeLKi0raOZAz1BiALhZ3F169EjPMZNP2w/W9UTB7wLP3LBt
         3Cvg8sCEnPVkyOXfJa7vasrmBBKA4w+V46HbqsDO4UM4za8O2DO1njhhgvTAisiVluFR
         OT31nZvEt4qmURA2hKYOyvGWeWGbYt8rzMBUE/Jm1VqLXK3pns3anS8VRZMrWjGzIQPb
         BJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764858951; x=1765463751;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ns2EjNq5op1uWpU/IDU/iN5rRJVwaStIACnAldV00Y=;
        b=qIEErmT6fXYDOxMsfWbj2k9NpV4bvE27VmLRzzqjDYaUg2GgGan02uZYa6TNkFYFCM
         XtZugvuiY1TTamWzYpJJY02Ku9KNA1UxzbfW0KqkjMLweFngPls8AvUZ0BPdkUK6DEWr
         lyADixYXeShhdtfif64Td+CFOtG+c5vq6xmquJIGiMrgnTJKn3LDR6FPv3voOeMplAkG
         S+xe47oYddGUSv1Q15ufa6q+6NxSuoQlkXz8xrqVznq3Z9Y0RuniwiW+styJNWVdKPLO
         h4QFXYKVLByECFlbfufyMunKEfW/hVc6PF9RsT996mAKhNDzzqUMNKL0kuEHxHmLRn74
         tRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz1RNtejRlsf/nFCltUus6RZ7Tx1k6vdEG9uCLKAzOJ6x1X2q2TpKIvoRD8i7+uijbfz4+XPxu4uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhkhXsovFl2YaFn+m4C4NqROWYorF5Uo3Jc7MgCJ2hzemcEU/
	r8XtuENCezcsZBVJZRRQTFZCxIxKlLtAP49CQFWI6/uNWAeZIYDq6rQ0
X-Gm-Gg: ASbGncuLqx8KDaTd8mGbF/xWi/8jc9ir1QoSueCR1GSHqA+Qs0dXCeSXAqBR7HmPYw/
	9CsMQQaIR9hVfu1THE5MO/VFXM46G8R8RxXCHCNqBYhxZDmYWDikCCJHly4FfEn3wvRy8sDyknR
	41aj7TLOAYpiS8IZiteFRFGp/ujG8yRqnzbWrVTVh8WbmI4rr3ft7CfXPw+jkVYSC1TFR0pb1EX
	w7AThCUzJYkxLIqLPv7i5oZQB7OdCDmAAY8mCkbsY+EC2grPD4oaNZmBGFNCbK1zK+NkcFelhAu
	XGcgGqvO5dxI2xXtx6ttwro9dTCSHjkVBYFzmJgrmhx027rLV8auDJYFYMQtImmBfakbJFLee6b
	MFESv3FC9Om6Td/AJUzT0/8FhEPrBUiTj6EiKUiwV4Ee103QdN7C+XZ3i9fnBxuA4vYT4pBigyN
	PflWu/dz3fOqrcTIFJQoA=
X-Google-Smtp-Source: AGHT+IG2seHuOWerjwXCdph63ZC8vZL+eIqVpQkFO/I0w+Uy389U61OmS2BgkM1euyc2+4rlvr7rWg==
X-Received: by 2002:a05:600c:4e8a:b0:477:9986:5e6b with SMTP id 5b1f17b1804b1-4792f395439mr23688625e9.28.1764858950670;
        Thu, 04 Dec 2025 06:35:50 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d22249esm3624680f8f.25.2025.12.04.06.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 06:35:50 -0800 (PST)
Message-ID: <77ca77847511e67066a150096a7af2fb84f1f25f.camel@gmail.com>
Subject: Re: [PATCH RFC 0/6] iio: core: Introduce cleanup.h support for mode
 locks
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron	
 <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guenter Roeck
	 <groeck@chromium.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev
Date: Thu, 04 Dec 2025 14:36:30 +0000
In-Reply-To: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:
> Hi,
>=20
> In a recent driver review discussion [1], Andy Shevchenko suggested we
> add cleanup.h support for the lock API:
>=20
> 	iio_device_claim_{direct,buffer_mode}().

We already went this patch and then reverted it. I guess before we did not =
had
ACQUIRE() and ACQUIRE_ERR() but I'm not sure that makes it much better. Loo=
king at the
last two patches on how we are handling the buffer mode stuff, I'm really n=
ot convinced...

Also, I have doubts sparse can keep up with the __cleanup stuff so I'm not =
sure the
annotations much make sense if we go down this path. Unless we want to use =
both=C2=A0
approaches which is also questionable.

- Nuno S=C3=A1



