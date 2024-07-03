Return-Path: <linux-iio+bounces-7241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6E2925C4E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 13:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F10E1C21007
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D6117E900;
	Wed,  3 Jul 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2mrjgvq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00017DE04;
	Wed,  3 Jul 2024 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004752; cv=none; b=G7MsgBd1hTEff0ba+2w6J5PNKF1OZ1T/3vKPurvT3MDfA5MHp/TFF7u7Bo+xc8l15pH9rScLbIAOTpPcn4GHW779QMDhk4V1SyBiebmNl2OEJfCFT8DEqOoTDmuKf2aqOBlnntp5EmRZK9k6hW2X3498X2Mv+VjGjy/jwavnVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004752; c=relaxed/simple;
	bh=AtufuHakgiGeUK6iDXQt3b7GibQgjYgBp7xXGZAc0ZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BbwXp/uDThe2GiWS3Ky9cDrlCHSVqKpXq/zD5NhIYlsXlWw3rw0U4ybA5i9wyyFfBM488ghhbDCYs8KHE71pLHmwdLeYfnps3vSCio24WibZbhLYDfvjHkNW0Uh35rZOftITYT5s/DtpdiioHEL0+fc6GaFEXuQyE8o+3wwRPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2mrjgvq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a751ed17b1eso85456266b.1;
        Wed, 03 Jul 2024 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720004749; x=1720609549; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AtufuHakgiGeUK6iDXQt3b7GibQgjYgBp7xXGZAc0ZE=;
        b=B2mrjgvqEnlbJIaisnNo32cM7E2GDMOv8q3nbbcdncW+QGATbDNzYobCG3QS5xQyJn
         mf+HJxwrMkhzCV+DE8RdgNS5pvgC8AgmKKjL5XkOUjpedkiy1JPjQtTTE2KgYtyKVT4M
         lU0TZY6M8o6ReaKmqbj7L9eP8Lr52ODhJugTgmpdsRv1w+t3XkRlAgNZYwmc7uQwF8ib
         ZAyp1Qiz2nTSpvoHsGKciuEeRLi7bT2QQQrI2nVxy0+pk1zQ+Ds2DGLoYLtb2CkPfGz8
         Uj8+yOh2/6niukHIv2PoxjccofAxP6rEmORNkBC6sHn9lS1vZTnrN4BD4xGc/8Gq7KKS
         l1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720004749; x=1720609549;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtufuHakgiGeUK6iDXQt3b7GibQgjYgBp7xXGZAc0ZE=;
        b=Dlb41/MPIblnvcrHpnA1Zdu/n9MR5RMDdewcFfrI8Tlyi6QkrVMJDKHT8gtZxO/JPN
         bs/L3VpfUOvKSR+08heeO1F2Evgd+GSXIbuEKxItehmE5Rye9bbCKU+P/Ll/wPfO9oVy
         E9B0aQCs1XuH8tufZ/QEhR+90VVnLWdhJVrR8fkMm54xccbFVdLX80gWaMoCvxMAEUrN
         MIjTTNpcul27qg25Y1+SpfWGJlzUTzw0e6UvQ8jAj8PGOTpAfRnnvS2fC3IqgFng3HuD
         JN5hAuiCU8s1O7/hDjbVLTfpLJF3rl7OykS7n1LzaDjbFLCRX+Y7AORtyLkFX1JMIPPt
         pRBg==
X-Forwarded-Encrypted: i=1; AJvYcCWWy5E/Dt8c6VDRj0t4UJUHHdMpTyZVv9HUPdvHeTgQmHHBcpP68/h+In1J56xQYhIhjLw6F/y+koxWnPdpDHL9fLAJlbI/ap1Oi3CJ09xv22h9/XK/lRhvI+/4CRco9ygwgRyNBYiiSsB6O8Do/c/enVnDMZnEXWR7hPvjrdm3gvjBLq3g
X-Gm-Message-State: AOJu0Yx8g0vNb4NkYa2qQJcrQgIuKXIJWCBiusNnkh2Iwnb+ejNL1iBl
	PyU5MH18BWRT6wYSlJtXTt6QTyllLJamml6IPBqhV7WGYVBQJCam
X-Google-Smtp-Source: AGHT+IHf7MFzp4LLom+o6D/8hyMvzEblmww27i1LILaQzgfwgc7RfSfx0fNDiElrClKQrROXBmLSyw==
X-Received: by 2002:a17:906:a281:b0:a6f:dbd1:b493 with SMTP id a640c23a62f3a-a77a240439bmr105122266b.7.1720004748569;
        Wed, 03 Jul 2024 04:05:48 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065735sm501843366b.135.2024.07.03.04.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 04:05:48 -0700 (PDT)
Message-ID: <429af3d1afe4297dde5c8795ca745d84d52e5033.camel@gmail.com>
Subject: Re: [PATCH v3 7/8] iio: adc: ad7606: fix standby gpio state to
 match the documentation
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guillaume Stols <gstols@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, jstephan@baylibre.com, dlechner@baylibre.com
Date: Wed, 03 Jul 2024 13:09:41 +0200
In-Reply-To: <20240702-cleanup-ad7606-v3-7-57fd02a4e2aa@baylibre.com>
References: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
	 <20240702-cleanup-ad7606-v3-7-57fd02a4e2aa@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 17:34 +0000, Guillaume Stols wrote:
> The binding's documentation specifies that "As the line is active low, it
> should be marked GPIO_ACTIVE_LOW". However, in the driver, it was handled
> the opposite way. This commit sets the driver's behaviour in sync with th=
e
> documentation
>=20
> Fixes: 722407a4e8c0 ("staging:iio:ad7606: Use GPIO descriptor API")
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



