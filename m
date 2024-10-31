Return-Path: <linux-iio+bounces-11695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C39B7CAA
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 15:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B3E282E85
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83691A072C;
	Thu, 31 Oct 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4a/OJvR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ECF126BEF;
	Thu, 31 Oct 2024 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384429; cv=none; b=ZjdcaxUSkUCcb9UyoTd6VDEy8lLj6qadMepkeX3Csjz9c08dEl0niT7e7F777RanV4Vf1ZW5HpdEtIduPrento5VjY17L3u83wOxVCD/19cm7CHkfBJ5LjMenzPAr7BAmm2hh+fBFsKd69zz2s33DXGVR+R/Br75DLC9PZjUzbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384429; c=relaxed/simple;
	bh=WubJgVoi6PG6mHA8Hf3mBv1Yym6DwrDwuVi/BNcnArg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ndlZJm4N/E6oVRucRmUIWiKAzAG6RMQvrEDYfZWuCN1YjuZUHV+OlSFzh0OWhNWgXg57svSxC/G8EBetjWDtMGsJptq9r8rxds9qDKF2iWQ3zxXmTX2X8MZopsyqARrFuEhzsqeMorIZ3CNH7eb0y5NXx7yH6QokV0ZzW+3gQwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4a/OJvR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so8065025e9.3;
        Thu, 31 Oct 2024 07:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730384426; x=1730989226; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=djH3xY8dq5iylljAgal9aGEEdDS+uM5AxS6wGMBJ2o8=;
        b=g4a/OJvRQa6Cagm7H+jIS8GSQJRNxkOqJvhsLacS1Ya6DDW2O6g977g7sUpSUVuZx4
         6amB9+qZwG6IJF4paaM4jT4+E7fiWpby3BAxfTGQo4cKgnYSxuMFgEFedvVoY3MToDtH
         kgBlT9/EkfuOxuIT1FPfFKuX81dlNGLQVr9eMC82OrvNwY46m51mv+8+Smej5CLtedQ8
         6jLyCI2PBraWFTq3IIufmJIIK/6Np/P76jG9ZDS8qUsHI1GXVaE7kvvFD7WIRbwaCTl4
         7pojgZ9QzytBcrsGukaVnekFc+7M6c/JozivmkUP+5NQkN/50IiiMRoNpeV+nx/cEXwX
         OgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730384426; x=1730989226;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djH3xY8dq5iylljAgal9aGEEdDS+uM5AxS6wGMBJ2o8=;
        b=f/JiZQet3G1B3CvPQidGI8fIS56A23Y1jh/S5U1dSn1S9C078dxx3jmDEfqk+BoEVa
         p1z9xaePx7U+KtTHW0HD5x41Am2dnkEy/1+BwpxRF/+vSHBTOjmQh68HRq4hFixajr0G
         bhBymTrzE9UcEOgyDWU4tkG8M1kNf/LUKilIEi9YOCK6h4lbo1rOzwr/9JL5klvaCfLs
         J29XXQHxHVjg7bwxvuYT24nRMphWUjKEQeN0A54Pd71Y8pjwXTo0PPrOH4z/dXyZpPHx
         Y1wJmdnZGNgFT794ebc5rpjkl29jnZLA0uDhI8ZIlyksNC3wJOqcyDUQK8vSQhTl3Y7S
         5rhw==
X-Forwarded-Encrypted: i=1; AJvYcCUKIno9qUmd2mjIRWpP91zyiAZs7k/3YTLdw3C+H9+TgIfP3O1HNRZHETs8VWI2N0LcfwgWiWCOnIY=@vger.kernel.org, AJvYcCVEsbg77Xj2ixTGvGnnLz4qnbbzUP5tx7ialHmQ1a8DGUbf5ft+mbGWM0/VvoTeUvIRlPxaWTnU6ccspsYr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+CuRUaI5pOveQ5gYWDs0ar9x24woUXWyIV8eKAasFkSxqTEc6
	ZXKhqadskCogh1btc8jIwhSH0X0s2RaLvN++46HJjRHHXkKXt4dR
X-Google-Smtp-Source: AGHT+IHnnWWxWqwFHUA8ebQJ9jzEPeDxBePOMzMIocOqw7uibyVZhqpa7EYoXeri/foB3J0gggPd5w==
X-Received: by 2002:a05:6000:18ac:b0:37d:51a2:accd with SMTP id ffacd0b85a97d-381c7973bf8mr145305f8f.0.1730384425443;
        Thu, 31 Oct 2024 07:20:25 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116abc0sm2215836f8f.94.2024.10.31.07.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 07:20:24 -0700 (PDT)
Message-ID: <4760ad42ae34ea53ffb98995d65c5f1d6a6b3f9e.camel@gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7923: Fix buffer overflow for tx_buf and
 ring_xfer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Zicheng Qu <quzicheng@huawei.com>, jic23@kernel.org, nuno.sa@analog.com,
  lars@metafoo.de, Michael.Hennerich@analog.com, djunho@gmail.com, 
 alexandru.ardelean@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
Date: Thu, 31 Oct 2024 15:20:24 +0100
In-Reply-To: <20241029134637.2261336-1-quzicheng@huawei.com>
References: <20241028142357.1032380-1-quzicheng@huawei.com>
	 <20241029134637.2261336-1-quzicheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-29 at 13:46 +0000, Zicheng Qu wrote:
> The AD7923 was updated to support devices with 8 channels, but the size
> of tx_buf and ring_xfer was not increased accordingly, leading to a
> potential buffer overflow in ad7923_update_scan_mode().
>=20
> Fixes: 851644a60d20 ("iio: adc: ad7923: Add support for the ad7908/ad7918=
/ad7928")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Nuno S=C3=A1 <noname.nuno@gmail.com>
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> v2:
> - Fixed: Addressed buffer overflow in ad7923_update_scan_mode() due to=
=20
> insufficient tx_buf and ring_xfer size for 8-channel devices.
> - Issue: Original patch attempted to fix the overflow by limiting the=20
> length, but did not address the root cause of buffer size mismatch.
> - Solution: Increased tx_buf and ring_xfer sizes recommended by Nuno to=
=20
> support all 8 channels, ensuring adequate buffer capacity.
> - Previous patch link:=20
> https://lore.kernel.org/linux-iio/20241028142357.1032380-1-quzicheng@huaw=
ei.com/T/#u
> =C2=A0drivers/iio/adc/ad7923.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index 09680015a7ab..acc44cb34f82 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -48,7 +48,7 @@
> =C2=A0
> =C2=A0struct ad7923_state {
> =C2=A0	struct spi_device		*spi;
> -	struct spi_transfer		ring_xfer[5];
> +	struct spi_transfer		ring_xfer[9];
> =C2=A0	struct spi_transfer		scan_single_xfer[2];
> =C2=A0	struct spi_message		ring_msg;
> =C2=A0	struct spi_message		scan_single_msg;
> @@ -64,7 +64,7 @@ struct ad7923_state {
> =C2=A0	 * Length =3D 8 channels + 4 extra for 8 byte timestamp
> =C2=A0	 */
> =C2=A0	__be16				rx_buf[12] __aligned(IIO_DMA_MINALIGN);
> -	__be16				tx_buf[4];
> +	__be16				tx_buf[8];
> =C2=A0};
> =C2=A0
> =C2=A0struct ad7923_chip_info {


