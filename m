Return-Path: <linux-iio+bounces-14296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411EAA0BCE0
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 17:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117AB3A7A2B
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 16:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE231CAA63;
	Mon, 13 Jan 2025 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcYvkxBc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF405240222;
	Mon, 13 Jan 2025 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784427; cv=none; b=PPrlZXcuBPkiy02nstrvm4sXKd4kEGekEhOKbitx1+7tkcFb00Q54wUnp9Ev39D56JNglPR3p75iLglYIIu66f9O+uZ7noPpe9WcskqaZqk7GN7gWH84qDb57d5dSnduwuoO6mp4u1vcYo5NFeXBVMXIHj5b+Our54bY76Bstdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784427; c=relaxed/simple;
	bh=vKYTFsjo8X4xyhkcQDZf2Uu5qji/uSlkM3n9FlBxrY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UtjSlEFPUHfDBAi2ChOGs6L3puxUt+RYAGvgyUVby5SNqW7SwfYL+19xQl7LZBUFU3mqQhmmgOPV0o+xYlNjYXTEdblwZa1aIgFCeZ/4tYn7oRK/895wF8KWbFyfylmlv7sVM1ffGx9Mk9HF65il4SkMl/QWUJ+nSNw2++sh2xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcYvkxBc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2326265f8f.0;
        Mon, 13 Jan 2025 08:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736784424; x=1737389224; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ehArCO2coamQ+lUBqJrA2SzrWVwFqU4+sbtjZZLoRTg=;
        b=CcYvkxBcS3/NEQlDRGfcHAzvMp8XiyMIGVqkTihhcOnIyOb+95CP8NKRGcgpPLleWZ
         Mo2hCmU+Qo075ZkbnZWHfacjH9tio//IF+EKnitEpYlL+2JiriKOM1YZOXgWEuP2G9TK
         HuUjSUNjMG2FwvSStoSnXrzKH9D6IhZSUQDzqxGz4B9qY1zJ74Yr7lvTGgPOAqtrScCX
         sR66Mjz8YYAwyscDe2KHFYuHup6WR2GaPQFp1STfWNM5+IyfQRKKox8+utxTVjiv9Hh3
         99wlYiF8SBBYOeF0NHjgTyX/BHCDAX7UPNuiZ8/gBL2fxisOEwlOCXog2F72tShUM5Fh
         MFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784424; x=1737389224;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehArCO2coamQ+lUBqJrA2SzrWVwFqU4+sbtjZZLoRTg=;
        b=TpEHBYQEzzAuAke8fJsNc7Dg8p39hhTLolTr6d163nnTeKYnI5Jfu4cOJVab993HAC
         3CMVReEO1vfHbfcBpZP/l5kgKhirxUhnlQkL7sW/oRsSr2aUMwutTdLy7cma3EG23vUM
         i7Qq9Du2irBIOmVjYpoiQlAoMx0c4tOJVDVjp2JizzmIPZ4PF7yagj3PuMEZOXzyg7Tr
         2TJRlm7UKR5cupONLGlcMzB+t2Ic6HRJULf/do+yxIg8It8e2dTXH9lw+QJj2mYjFEPs
         DDJuY5QCdzMU0XKhClTJcXBMTj4RjA8icIRmLyElfgIYDGbdKJ9RwIkcHATTCOB10Ut5
         iL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSVKry3pqpk4brg+1Cyw66HSMLoOZPSdXqj3OaSXPetxsVbiG2B1H9B1QXPtm7fjY39dLLrcv34dPSqiEH@vger.kernel.org, AJvYcCXc6khHKxDWApZrS8NJuo9LNrXll6n4sLdSS53HJxp58S2HGg0c+tMP3L8bgL3e2JseZGbtDdC4qHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR2F2mBxts0M4oq2hG4xFk1nkjC2w1iy1W8EX0QSAdGIA1YicP
	XiIIKcqL0A8K6PIXUGH0C1cuCfs7T0ELBvGKiSC+MAnXMRpMpjy/
X-Gm-Gg: ASbGncu+x3LQwRcRK0E6JUTIwBsMq1hhQhi/pF5Jml6f06qCXsspJwuLXOoQNvsd4d+
	sssOOHr6NYDnP8FLciecXZs3qcwKrlVN196nzdYnSIA2o1UlVs7RrHOoVdyUc4of2ru06E/ZuoM
	Y4Hp5k1ak/S8iJiBvpFFl48D4zxweq7h7rZd4TVnPsPKJciBAxsghjiF3m+cldos0XecroibnfR
	UNwz/G9jORlkc1jeI57LEGsV3paHR7naS+IPHxJEbYEKHSJJA6q9Vd1QvDCpwuXYa2YeUw8dbr/
	XpDZrzKjw3V8bPJ14wkWA2+1GS1A
X-Google-Smtp-Source: AGHT+IGpz345mCQ6rVC6kLxR2jNSdysT5xseGgBn7/Y8V7UvDplI0uoeXZn4XoHOYsWVwiCpNyg7Cg==
X-Received: by 2002:a5d:64eb:0:b0:386:41bd:53a3 with SMTP id ffacd0b85a97d-38a87310667mr18104401f8f.50.1736784422491;
        Mon, 13 Jan 2025 08:07:02 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d012sm12507361f8f.8.2025.01.13.08.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:07:02 -0800 (PST)
Message-ID: <e1e34a7db3b39895871cf5e067bc2d932fe2502a.camel@gmail.com>
Subject: Re: [PATCH v3 5/9] iio: dac: ad3552r-hs: fix message on wrong chip
 id
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno Sa
	 <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 13 Jan 2025 16:07:01 +0000
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-5-ab42aef0d840@baylibre.com>
References: 
	<20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
	 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-5-ab42aef0d840@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-10 at 11:24 +0100, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Set a better info message on wrong chip id, fixing the
> expected value as read from the info struct.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0drivers/iio/dac/ad3552r-hs.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 8974df625670..27949f207d42 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -326,8 +326,9 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *=
st)
> =C2=A0
> =C2=A0	id |=3D val << 8;
> =C2=A0	if (id !=3D st->model_data->chip_id)
> -		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read
> 0x%x\n",
> -			 AD3552R_ID, id);
> +		dev_info(st->dev,
> +			 "Chip ID mismatch, detected 0x%x but expected
> 0x%x\n",
> +			 id, st->model_data->chip_id);

Since you're doing this, I would prefer dev_warn() over dev_info()

- Nuno S=C3=A1

> =C2=A0
> =C2=A0	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
> =C2=A0	ret =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STA=
TUS,
>=20


