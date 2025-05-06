Return-Path: <linux-iio+bounces-19182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B3AABCE5
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 10:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFAD3B158E
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 07:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E8F230BE1;
	Tue,  6 May 2025 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcrvVufE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48311865E3;
	Tue,  6 May 2025 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517680; cv=none; b=kRz4OGqXFIME/HWRmYrCnLimSQr+h9ws7NCCNQ3vAPNfUUWMNeD3xuAvFd8xjfmxy+ZQcpPhTTbgdSW13Lrh/mnuyTHd8eOAnxCE26Q9is8zfZGspTXxx0SouLEaI0W+fWfUxIgQGxj1O1Hau0t+6t1ELhdaHLhtlwsC0O83c48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517680; c=relaxed/simple;
	bh=p7pvOZB2NRNvGY3O257XuxFkgiCcQz8KrGDhaUE1jeM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OmGgwQ2E3HCu0EjAsjkCWyVBIpDJtKWY+Lh3KNqyIsq/eOeG2/wojn2b/mu9+PviSNzzkQnR+tFxdiRM8GTO2Mk9VFWWVDeU4rEPb4KgmyucJb72yQQyETfAbJ8KIa2wp6urYRQBjUzI2fVEa15MfB5En92wK0F8258ir6Rlgk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcrvVufE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso35031775e9.2;
        Tue, 06 May 2025 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746517677; x=1747122477; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cP0pNdBoaxygoFAdiEmhS7Skmfb1gZrZwVoFfqQfonA=;
        b=FcrvVufEuwppPtCTbIosdQu9c3e0sjkwqNPJ1bOSQ5zd1sssbH2bo/rcqSpVQ9rgor
         xjRJjnODdWt3RYF09ZDC0qr8/MAWPzNW5sOAUBVpNMMs7Zleu7u6SKDvzFZKIsJpfqec
         ECfeShkgdnE0/j3ESHWMOBL68Zs23kg8H8+2ZsgyJYbKh81wRXspBdeCpLcLK/k4JXXd
         9KRmTue2aTGksptkVBFCYovjmUCkfMrstgXisSxys0sn5m792LCxxERvVtuq4FdRR2ti
         jlt5VGxCHsbA0a94/OAK0Gxpu5oBG93yi7CmeKKgRx5JfMdY8Q4t9Ed42CfX2KPXS9lG
         psLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746517677; x=1747122477;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cP0pNdBoaxygoFAdiEmhS7Skmfb1gZrZwVoFfqQfonA=;
        b=vbzxbs4bgOfyiT5jvGJOHO/btMr0qHdPFZAgzkzdTTWsgXx7qll4MmrIvCiFy1uQz4
         5w1xUq0vAlTLMoRyOXK5+doAmDxyAKd4tIgwojSJJqmJAOfE/a6vMlEkNxi/ug7VscNU
         j0G8j+I9VsJpLBMy768hH74Xn4BjptKQNWYjh3RekQ5BSM8sL1hslt4F7ntVHaGMCrEd
         rW79Eaw3r1xTVXuOkhSsXPY1osXDpyJ+Lf9BPCJ9awDv3Hb9fdzz9QZ+JZmZr4vd9v+s
         uKntk1s4V4/lKatjoNxAkdadXatkiBemG+pwvJ5P/pZx3yIdRlMTZ+eGbmyuW07NoXCV
         vkWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW92RZ65kBpDzJXtTZ4CbBlg7vGnyzTor5wqA+2/eMSGuZLa89WSjcL26YsRUAH5n53IqX2Zk3qK0=@vger.kernel.org, AJvYcCXd9F66/Ni7cHzXBsos9HqI9stMFDo+HbXq9P4BqeT2ioT5YXWLpT4v2Z45V4/yZ0ZEXCt1QBfRT/zb8+hb@vger.kernel.org
X-Gm-Message-State: AOJu0YzQXFe00+TgFva57eM6w10qlc1XUT3X9hI4p/GXDAECjIxNhgLj
	sVSlCjJh6oiv4noTSeKiZvChXbDHAaroPIUMJLam2FXOSrRZLUmIT7l1ZGKk
X-Gm-Gg: ASbGnctfKnNG5OnXTCgfhIZioSBLA2nrfv6qCt1Go2Nk8alyav8vvrsHX9jE6GSbiXh
	rcbISaqG7ZXozD0kOjQWwYCP1OBiWbpKYcXDsHiiA1NYrsH4x06NyMaRRZNIwwPvvFWjRPmZoeE
	kBZOYx2CQeKAxdTpOBow1chx9vzu/8TX3ksFKE+RBETXk2Rjw1Hdrmh2XE3KeKtMorJO/38V/A2
	3h/qqEn93HyeJC3cS3AEIdc9Rm/KUI00irNQBfiO67GH/u8UFf9xkU7Qkrq2A41U8pmHGW4pO6E
	jTr8fbjjlue+sCSkbajgU68oYnt/nJejbjzh3r/2vJiFFs1T7e4H3XGDSTubHWgdrSo04DRcM4Y
	yjrUc2Jx08hqQn1eAivIL8ZDTnA==
X-Google-Smtp-Source: AGHT+IGM/ONloZ3cXEEt7TBduShHNzqs0myDIHa0Xt1OqT9XaAYxmOg1/XJiS7mExmrFrJsw9Fuh5g==
X-Received: by 2002:a05:600c:1c91:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-441bbea0cdamr113462375e9.7.1746517676785;
        Tue, 06 May 2025 00:47:56 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7a46sm12535159f8f.44.2025.05.06.00.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 00:47:56 -0700 (PDT)
Message-ID: <bf75a685e8e94a90a84123122994592a505b8d02.camel@gmail.com>
Subject: Re: [PATCH v3] iio: backend: fix out-of-bound write
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Markus Burri <markus.burri@mt.com>, linux-kernel@vger.kernel.org
Cc: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>,  Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,  linux-iio@vger.kernel.org, Markus
 Burri <markus.burri@bbv.ch>
Date: Tue, 06 May 2025 07:48:20 +0100
In-Reply-To: <20250505203830.5117-1-markus.burri@mt.com>
References: <20250505203830.5117-1-markus.burri@mt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-05 at 22:38 +0200, Markus Burri wrote:
> The buffer is set to 80 character. If a caller write more characters,
> count is truncated to the max available space in "simple_write_to_buffer"=
.
> But afterwards a string terminator is written to the buffer at offset cou=
nt
> without boundary check. The zero termination is written OUT-OF-BOUND.
>=20
> Add a check that the given buffer is smaller then the buffer to prevent.
>=20
> Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack buf=
fer")
> Signed-off-by: Markus Burri <markus.burri@mt.com>
> ---

LGTM

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-backend.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index a43c8d1bb3d0..4a364e038449 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -155,11 +155,14 @@ static ssize_t iio_backend_debugfs_write_reg(struct=
 file
> *file,
> =C2=A0	ssize_t rc;
> =C2=A0	int ret;
> =C2=A0
> +	if (count >=3D sizeof(buf) - 1)
> +		return -ENOSPC;
> +
> =C2=A0	rc =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,=
 count);
> =C2=A0	if (rc < 0)
> =C2=A0		return rc;
> =C2=A0
> -	buf[count] =3D '\0';
> +	buf[rc] =3D '\0';

you could have mentioned this change in the commit message...

>=20
> =C2=A0	ret =3D sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> =C2=A0
>=20
> base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e


