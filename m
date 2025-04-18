Return-Path: <linux-iio+bounces-18242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CF6A935BB
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 11:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B71188FEA9
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 10:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC0126B2CC;
	Fri, 18 Apr 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiEtuVdd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E98F6B;
	Fri, 18 Apr 2025 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970388; cv=none; b=C+p56wUMf92nqnVtP/m60abARtlbzIw63/1j+5dG4VYQ/bkY1gIH+H71cZ7PFlQFcCR1bxyS8U4MysPzZzYiwFhd6nkh6mumr0pT0yrAiJyaMth549NccRJek8u+hbbysQA++mh08W5zUMTg7arsabKvdwO38KIp1yCKNf7ztPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970388; c=relaxed/simple;
	bh=AeKf/W9dGT8sW1ZvTP601LFb5+rNATWEhQWKe6IQb1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BdbCQLTMuWAqUZOO2vqggSOauP+5C1+cLBnFQyXNmtj/qs9F2eOSKHA+Yk9j/i/NbmuJp+Xt5QCdfgI8iohQmbjz/MC5/dGzwKURzeo9xFtgdlrJ5mvUHtIxacc9jhP5cAVhTD0a8mRaa9GBVxTBs6/mWEbNH1zALguu/L7GxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiEtuVdd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf848528aso13093835e9.2;
        Fri, 18 Apr 2025 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744970385; x=1745575185; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4gwDHlLSyfOGZDhUdR7viQRsWnq+WUz3dBSvyyL/oTI=;
        b=iiEtuVddi7lBWyz3FjcDORCr8XKz2eaVmO9yfTQ+QRRykbBNlE+VQ7eBDxiSqJE8NB
         /F77aDbdjuzOmom+foulpVpZbtfcaYkTXrWXvH599OBzo3p6V+BIV6ve8ZNjKrqGRKkG
         eHJ6t3Ld02C+btdJWVaLToB2C83C7e695toXL9LMZgYyFiIzcaZPLuPNHFpORMNH/+CG
         o/TGoA178GeGKUzZxLGrFEsaEp6lo6TAq0xRrOcQyeSCZluAwBIUbYZxnl0DSPP3X7Iu
         rQQB6pW/856ukE0pC8nbb8memxg4kXH2KSPAbJ+yvFrvP5ykEZix68LaOrqVK3xPKhin
         QkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744970385; x=1745575185;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gwDHlLSyfOGZDhUdR7viQRsWnq+WUz3dBSvyyL/oTI=;
        b=Q9IiTJzFZOXVRb0iXtx2mCIFbEUUzVRoTrO2OBQYT+kcEwUoZMIQ5jztZqSto3zXQ3
         29ytc7ve1vlPCqwN8mjZyhFEnh6VNgNC9vIqqzYX/NwCWZkTNxdTaNSj2ExNvFUSkx9v
         l9kxS2PocqN/65daJ3bkHL8fgk5G9wHgCbqcOGHMNVXbqmzX8vWZY3zHXTbgUD9gAj1L
         eL9V8XuUxq+voZafMlpNfRh7G0oigDHH4s0Q5HQAyYJse59HiC5r78YMG00P+Vo8CXxV
         RrFU1ye++gsapZa+HUUjWWJGEl3DTgHCp7N9jXqyg1nOEWg7uOWQD463VJgyF4/SzXhg
         kiBg==
X-Forwarded-Encrypted: i=1; AJvYcCUHGrxqf7V7oLJuF/ePldgCz0eUADSC6fxgp66tbrDhZwsNN5T0o6kP7nZmBRxBfue0ypWJQK95ejfA2sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPj8vLStbKKbcvL/5/iW/ImnBNyYGzZYcIh/hB8yg0iMOuefd
	RMmWt+d8fwrg26TY6s2Wb5P9hguoalu0bwWr2Rt3iuDKAax3aXBg
X-Gm-Gg: ASbGncu9uiyk1tTRmaGg6dRMRdxOKORgaD31XhW4uh6Bwa+tCa9OMCCXkcDclVdUvrB
	oGjLC0CrL9v+XfPviCwqju7ix/bvcjlcqTXcKFfPiR3ao0duicXvMPo8YUEZOkgw5cdgMpPwshs
	dqQoe2USRvKV1AjWEkKagUM1S18N5+ryFWLoxCe6XsldDeRhUWB8uHyXWMf67jcHAppkcM+6UWm
	n2gC8bCWrwV2P4P41xWDSYUxpgk17XsqXRkybGnpOVH1kfsQxkVaQRSKcKRmRX8Wj0KTRJxrYom
	QxS+ZlrBBNTkwN1DPMkVNEqBlvGikwuDGek0YgQS+cHwmnS/Yk8Jj9QVsRVH09rC0BgRc8tBHBb
	/wtCiC1Wca0gScAk=
X-Google-Smtp-Source: AGHT+IHzSil2G3YGnRzD5cowRm+z9RfTcSJoozpe7ba6NO1ln0LD3onqnxF8VbnwQ0vVLMFjQbwCSw==
X-Received: by 2002:a05:600c:b98:b0:43b:c0fa:f9cd with SMTP id 5b1f17b1804b1-4406ab7ff23mr17936375e9.7.1744970385090;
        Fri, 18 Apr 2025 02:59:45 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43bef1sm2245637f8f.49.2025.04.18.02.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 02:59:44 -0700 (PDT)
Message-ID: <c3399884bcd18ff730855103897f39081f409296.camel@gmail.com>
Subject: Re: [PATCH 8/8] iio: pressure: mprls0025pa: use aligned_s64 for
 timestamp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>,  Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Tomasz Duszynski <tduszyns@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,  Andreas Klinger
 <ak@it-klinger.de>, Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Date: Fri, 18 Apr 2025 10:00:05 +0100
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-8-eafac1e22318@baylibre.com>
References: 
	<20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	 <20250417-iio-more-timestamp-alignment-v1-8-eafac1e22318@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 11:52 -0500, David Lechner wrote:
> Follow the pattern of other drivers and use aligned_s64 for the
> timestamp. This will ensure the struct itself it also 8-byte aligned.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

ditto

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/pressure/mprls0025pa.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/pressure/mprls0025pa.h
> b/drivers/iio/pressure/mprls0025pa.h
> index
> 9d5c30afa9d69a6a606662aa7906a76347329cef..9fe9eb35e79d992b2a576e5d0af7111=
3c6c47400
> 100644
> --- a/drivers/iio/pressure/mprls0025pa.h
> +++ b/drivers/iio/pressure/mprls0025pa.h
> @@ -41,7 +41,7 @@ struct mpr_ops;
> =C2=A0 */
> =C2=A0struct mpr_chan {
> =C2=A0	s32 pres;
> -	s64 ts;
> +	aligned_s64 ts;
> =C2=A0};
> =C2=A0
> =C2=A0enum mpr_func_id {
>=20


