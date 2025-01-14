Return-Path: <linux-iio+bounces-14345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE071A1074C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 14:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC637A239A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1696D234D0E;
	Tue, 14 Jan 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcsYy+Uf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF3234D1F;
	Tue, 14 Jan 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859777; cv=none; b=qz8uyzl8F9fZnUVEJsECjkJVxCBK6F/BGGNXoZlug91qPBa/Goc8PoXdykNiQkrrhz+v+zesc+jlIvWKtaayMCSbppReQmLP/OX4Rua6LEb8qNNoEZXfgVllXnZivm+fqPURUhpEBVdnh6RMfXsRmspLSP//9wSjLOEo77phRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859777; c=relaxed/simple;
	bh=LybIkOJxYrYSoz0fCNyRDFobNPuFI2j2GwfUnR/4Pls=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=thU1ECyBmLKGfAJXEQ8IMqApDcflH99Hvs4fPunAYmWfSdOkUU5MMKCi8vrkQ19ZY0dumC2YDTHFwloM15JcnD+n8JC60SrS4A25u8/P65KSYXrjzkMgiDlkxj4k9jypKMXH58TNb7ivcw/tqJ9q7N5TT4pIKrFmvGIDHkSUecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcsYy+Uf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43675b1155bso62115515e9.2;
        Tue, 14 Jan 2025 05:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736859774; x=1737464574; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4mlmLjHf+efJRsQ5ikwrVFyOvdyPK8rsP6rrhzua5o=;
        b=OcsYy+UfQdzS1Xqcqdxr4k86CMmKmz7Zv1sA+A0lXiNZo8se4Ru6HgAauRzKN7pky8
         hTf9b7nDIlQZtAw1TXoAnxy7+DP+lpbGCiuH8UXd86coBTcdWWvSdY7+bMApvo8cWMna
         mDErOG/Ua20cFr0nLPp7ufJAv+S+DHAeTznb0fIu01461/k8OEzWerba4Yf/SHNUoQHe
         vo+AKd65HfS/EBasXEZ6iTeR6uod2+8kp0vGlTfc6RZ2i/GdMoK15nGqz3HO2ihMPIP1
         oVQRuWHSL/DctEYnL0YlgJSxeD3T9WCkg55EOcVCZxq09//5Cex4u91+8V/rt74iJfrL
         gmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736859774; x=1737464574;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v4mlmLjHf+efJRsQ5ikwrVFyOvdyPK8rsP6rrhzua5o=;
        b=UvjTy+MAtYHADSAseYQduMnet9pHqJAXP3IfUD3u0uVZSVW97LZH2QkO2XoS6qPkKj
         L+hn1ozjnLcyANPgpWDUKteZJJZVLschP7RhAMcj5xyr+rnYtD6whnpAiSmxCjWIkgvU
         ICrbOEPuhjbKfcH3VtSin2/Y+nG5ex7FRpKvktgSaCEaHiSWe7a8e3DG7kbkv8+vFSKy
         Vcebz/AJj6QaqK+cTF1PLHUIF9DxqntAYzffcjc++n/LGesajewqWUK4EzNFwAEwQIxH
         JeWIblVU3e8Md+qfFIpzmS3AC7fpLlXzJJj5ylBiNuJgzEhyQqh+t08YRM7g7K2v4tqR
         SPmg==
X-Forwarded-Encrypted: i=1; AJvYcCWSlPt8odyPffJuoZ1HM0Z7bzLuOc/qjVaxWnwO1mIf2f83VJeq0P1jNwlUv6x4XR6y46Y7d7+qotU=@vger.kernel.org, AJvYcCX/EsjhDQAMD0yHRcfdEBSTw+tjFqS5V7Ok947Im6BT40gIvOpO5wTX6fva+Zn+y3+j/qrCgxAfRZl+UzYK@vger.kernel.org
X-Gm-Message-State: AOJu0YwtfuucRIqlhQliSI5v09ORcKT04hfd24LC8oOA3BCiAPJstHdJ
	v2CklSQ26FhaMrn/rlRNzhZnhMTUKnCKIQachaILWdZYRBiI8L+YcYsL5w==
X-Gm-Gg: ASbGncskBcGJ0YRD/87bPQ4irNEKRMVFZ6ZNiTNON5ZuB8jd9o+MEKhqvg50fVAywLB
	1YhCn29Pjst+Myn1t9E3ZZy988vVIwatK3XJySC2qT5LUe9a2rWoTWwY/uXNf112UjARBJ1foaD
	fxx3wkJntdw6GPONc0KpRwzAlznVgj3SqyMhUvQBhJuEb5mUR0S5SL1JnM+623az0pm+nC1qIAf
	RJEVJ359hbEfgRs2dvSmoL6czXWIbwbDpoBfRm6vizgST/7Ufc/zI+5RfLchpkCOYR+WBEfutwD
	zLe+0F1Uk6x+LOGZsT9VKpbetQkfsS1Gq8RupliyfIMNfSLclgaUJc1pZqG/eMSq5iDHAHXOprA
	w
X-Google-Smtp-Source: AGHT+IEKf9ILjCFJqPCUH2PHaaufla0XDu49Ptyr8HUDefhyIQamLz+7Rjd0PCXV6MB0AXWje637sg==
X-Received: by 2002:a05:600c:3b08:b0:436:18e5:6917 with SMTP id 5b1f17b1804b1-436e255ffd6mr244167405e9.0.1736859773985;
        Tue, 14 Jan 2025 05:02:53 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-16e6-da80-8c5d-53e8.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:16e6:da80:8c5d:53e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0f69sm207412415e9.13.2025.01.14.05.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 05:02:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jan 2025 14:02:50 +0100
Message-Id: <D71TEJCQD9XK.5FNF9SJLFJ94@gmail.com>
To: "Matti Vaittinen" <mazziesaccount@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 2/2] iio: light: veml6030: fix scale to conform to ABI
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rishi Gupta" <gupt21@gmail.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
X-Mailer: aerc 0.18.2
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
 <20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com>
 <129de6d6-50f4-44d7-9a06-db61a6669810@gmail.com>
 <D711DZJWGQX5.2D4PLVQN7NB8Z@gmail.com>
 <CANhJrGNT9H07MokRbVXRmDprZ+aV0XoDi=LhvrOkeSLzHnqsYw@mail.gmail.com>
 <D71AW9R10XCO.D7ONB8ZU3M56@gmail.com>
 <CANhJrGOya1tmYcovYJZWkWmVE9NdLFHiDw7izmKtfYTXm57GVQ@mail.gmail.com>
In-Reply-To: <CANhJrGOya1tmYcovYJZWkWmVE9NdLFHiDw7izmKtfYTXm57GVQ@mail.gmail.com>

On Tue Jan 14, 2025 at 7:43 AM CET, Matti Vaittinen wrote:
...
> > I will give you a simple example, so you can tell me where my reasoning
> > fails:
> >
> > raw =3D 100 counts
> > scale =3D 2.1504 lux/count (when IT=3D25ms and GAIN=3D1/8)
> > processed =3D 215.04 lux (raw * scale, ABI compliant for IIO_LIGHT)
>
> Your reasoning does not fail. But, the scale =3D 1 / (N * total_gain),
> right? (N here depends on how we choose the scale/gain values) Here,
> the total_gain means the effect of both the hardware_gain and the
> integration time.
>
> Hence,
> processed =3D  X * (raw * scale)
>
> =3D> processed =3D X * (raw * (1 / (N * total_gain))
> =3D> processed =3D X * raw / (N * total_gain);
>
> Hence I thought you might be able to get rid of this 64bit division by
> using the total_gain from the iio_gts_get_total_gain() instead of
> using the scale. Or, am I missing something?
>

I am not sure by X you mean the maximum resolution, but if that is the
case, the following would work (pseudo-code):

/* Maximum resolution (2.1504 lux/count) * 10000 */
#define VEML6030_MAX_RES 21504

total_gain =3D iio_gts_get_total_gain();
processed_int =3D raw * VEML6030_MAX_RES / total_gain / 10000;
processed_micro =3D ((raw * VEML6030_MAX_RES / total_gain) % 10000) * 100;

return INT_PLUS_MICRO;

Is that what you meant? For my previous example (100 counts, IT=3D25ms,
GAIN=3D1/8 =E2=86=92 total_gain =3D 1 * 1):
processed_int =3D 100 * 21504 / 1 / 10000; (215)
processed_micro =3D 100 * 21504 / 1 % 10000 * 100; (40000)
The expected value was 215.04 lux

For IT=3D800ms, GAIN=3D2 =E2=86=92 total_gain =3D 32 * 16 =3D 512
processed_int =3D 100 * 21504 / 512 / 10000; (0)
processed_micro =3D 100 * 21504 / 512 % 10000 * 100; (420000)
That is also the expected value: 0.42 lux

Given that the driver supports multiple devices with different maximum
scales (currently 2), it will have to be added to the chip data.

If we are now on the same page, I will implement it like that to drop
64-bit divisions.

Thanks again!

Best regards,
Javier Carrasco

