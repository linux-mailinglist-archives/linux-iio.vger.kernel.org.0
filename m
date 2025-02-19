Return-Path: <linux-iio+bounces-15758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BCAA3BB9E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CB2188B55D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 10:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089491D5ACD;
	Wed, 19 Feb 2025 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMJDMuef"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C93C2862A1;
	Wed, 19 Feb 2025 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960749; cv=none; b=FrRQJ9GkAs1AEOdRQIj13UThG1WM+S90au//oxEU/bWVqwv4Nu0yCF20bo4grcufMV9VHupLq0JoK3Zc/cuFk04NqGotO8SNa+fA201Muw/wTNV3mZOsytp0zdCSpRXS7CkPivQ0Hy/GjCsPdvozCJTuM1nyiPRjXy1JUnwfcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960749; c=relaxed/simple;
	bh=8uSV57w6guRspjPcI3Ph7+Z4m0bpeZZl2dptfc9qUu0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZxH1/F7xmD9tERJm7E1aXYOc1dZ89u9NtW3UJZSzXccVoFrl2ygxexru9mpN6Egqd49LSczeNtkMQGY4fVeTIiL30aHrw1V+TS1EG5VWVVfySMCxFGL92FEc69tASihUrPT8PDwcU+ClwNErBZAi3/iITHHZeIVTlwKG8U82bng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMJDMuef; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb90f68f8cso633392866b.3;
        Wed, 19 Feb 2025 02:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739960746; x=1740565546; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8uSV57w6guRspjPcI3Ph7+Z4m0bpeZZl2dptfc9qUu0=;
        b=SMJDMuefHnoSMZWI6AoWkWOpwnFvGGx0EkflpSg6vympw+k22q+YvOrB/x1wtxG5JF
         naa/2V5HOsqzEVyV8geI2GI+/Vmo08HWk18KixZDladUYhVfJCsyHPDH95dmHcvQaxsO
         22P7QToZyma2I9dtppWLiJPyl9NQi/qbJSsnsz+QWjWeJoudCyd+BbMoY6a/iVOHaEBv
         iIwiXRcWOY0oTisTgwSHqRjn/IuBQNH5AgTQE9sk/3wFSy9YgZ67gElZqeegufJwTeFe
         rL0/Jt+ivcNUv426w23dAozQe7/M7JQ4jfpioOKkbJk9QbzHOAaiLeY5lelFD10n3Kb/
         9/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739960746; x=1740565546;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uSV57w6guRspjPcI3Ph7+Z4m0bpeZZl2dptfc9qUu0=;
        b=lRDXg1l+PYCSlO/EdFzUNDUQkLHt3zjvLWeoXn5r+vZ7sysCAbrl8ugCLJpJxNA9mG
         /M1ZuuLGxWu/hKs8lI3sLtrmlSBEXfpJ18neOSGLqt0lo1iIN9YMr+I6Q31btSOhU78A
         5Hnath0Bi820LICyi3F2CZMm6qOaGUSWiux3LZ+qdTm+zItX3+x1HHMQdWUHF2na37vw
         QRk0VFTogVZNMl1yBnfuI1+zB/31PMUbm7KaFQmq1ZC4eH+MHg9ZQKQpHDRsxNwHzHg/
         OCl9S0oQc/nxJUYVHd89LxfKRjPIp8uVbJAJWMrVyx6wPkDAop838KrsRgt6KCYxU0td
         MKLg==
X-Forwarded-Encrypted: i=1; AJvYcCWLmSf1j8alLm2yLtV5wqmh/9PqynC4ZfQT1I7Qn58jcpQAhryoifF7OF5N2UGS0o5OthflSjr+bDa7yk71@vger.kernel.org, AJvYcCX855xGeaw2R0f1e1TvVHUhw+ujkyIauOYkS9sglJSjTh0D+nG4xZ2Zs/MFtFyuXKcvwK4Ey3/ipik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTxa5b2ENjDZxRCMfJR3RBufHTXLAcnnhtmqFhJHFrWuWulOyp
	n/GdX1uSi9m26Axuj6+tJ7s8hODir/YOe6CB/tFpAisGoEiU+yqC
X-Gm-Gg: ASbGncvkPg0LLJY/1t1jFlEAJAuagSw3c3hOUXTXdDyaLMdYC0QobzJB/rplqwOPktf
	3akOyKXNW0tuxxbZ4zDbaxplPEyH1zI/c/zMlzTalC1KOf2A9JHBHJIOCJyni7wXQiaFvdSmYRU
	UdBPzHEt+a8aIttOfALCr49YSe91yM5IdWq1HhTo9RYFI3wbRgx3PhrTsrAN0VHyhz78b9+xI6S
	bNOHSo1FJRP0EKbt8Grzz2fZ9QpFUl38/b6r09W5j2i4aZ313kpYL85dRouU+7IXZniskKXDBkB
	7Y49METaq590R45NXchlSFkS0gLA7+fZ3u8dqzzEBUpaf92rLFclEijiHSCnH5o=
X-Google-Smtp-Source: AGHT+IFMGXP2CXvj2q6FX1Qnoy46K40AnJgjimp1pXLWx7bAkbQDY9uMJg9gte8M1MxsR7Rx+8eQTQ==
X-Received: by 2002:a17:906:c154:b0:ab7:fc9a:28e2 with SMTP id a640c23a62f3a-abb70df002amr1908313166b.47.1739960746021;
        Wed, 19 Feb 2025 02:25:46 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb4d3ef3c0sm893376266b.41.2025.02.19.02.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:25:44 -0800 (PST)
Message-ID: <908388ae994bd39b1e8f444adabc214c91433590.camel@gmail.com>
Subject: Re: [PATCH 0/2] iio: adc: ad4695: fix out of bounds array access
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Lars-Peter Clausen	 <lars@metafoo.de>, Jonathan
 Cameron <jic23@kernel.org>, Trevor Gamblin	 <tgamblin@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 19 Feb 2025 10:25:48 +0000
In-Reply-To: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
References: 
	<20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 17:17 -0600, David Lechner wrote:
> I was doing some more testing and found a bug with the
> in_temp_sampling_frequency attribute being corrupted. This is a patch
> to fix that, plus a bonus patch that cleans up some related code (it
> wasn't strictly part of the fix, hence the separate patch).
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> David Lechner (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad4695: fix out of bounds array =
access
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad4695: simplify getting oversam=
pling_ratio
>=20
> =C2=A0drivers/iio/adc/ad4695.c | 26 ++++++++++++++++++++------
> =C2=A01 file changed, 20 insertions(+), 6 deletions(-)
> ---
> base-commit: ac856912f210bcff6a1cf8cf9cb2f6a1dfe85798
> change-id: 20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-7f16ebc=
3be14
>=20
> Best regards,


