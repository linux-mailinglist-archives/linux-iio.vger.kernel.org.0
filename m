Return-Path: <linux-iio+bounces-2756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF93D859F69
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 10:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578C31F211B9
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26EF22EEA;
	Mon, 19 Feb 2024 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6munMwo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32C222323
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334220; cv=none; b=H15Rco46A4HIOiwcdGD0FB0Jf/YWW+4j8W1l5VPyvyIEdIyZwoKI3ic3L/B9AlCYQZqlNn/HQHDOUWrKbviQEmCts9vea4IAt8HA8gA7s7za5ctWKFgwsHPKbDpvdigvO3jGa7sev06BZ/9zUDckDgWtlTfmlCMTk8Rh2Q8Ar6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334220; c=relaxed/simple;
	bh=MlSpfk8NgxjvBEwN7lDUund2jmU2k0UEXjhD10l9WT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tryjr6QKPDxNPOLbjRLJO0u+mFH7vBkDCNPmn7493GPz+0iKWml99asDwhFYY3CI78gWOVuSlIO7PnHpvKlpWme4K0KLytE1aQy4hpY2Kp18v9Kn8lVTc2QmbiNJukIWNXka+GRVHKzDCqa6CXGazravmaAC230PXEaUz2yxSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6munMwo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a36126ee41eso530178166b.2
        for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 01:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708334217; x=1708939017; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MlSpfk8NgxjvBEwN7lDUund2jmU2k0UEXjhD10l9WT4=;
        b=k6munMwoLG3CfuomJ6A61+grrU3yHeGiE6T3X5WUYnqw9HTfA1HJRyE3xk+ykwADm5
         RZQiPxKXoaRPQ6BrJk4WTFvFWwILtnn+z1+wlT7ZWHkLeTh5NG4LWoHu5G19STa96u8k
         bq5Y37QH5OBGGFOm32WRKu+PqWD7jdxJh+mPTHCle3IL/ixX/9DIzuqrCc//EvBOap2j
         UBNDm1SLICLl7Mvb8hSNO6Mwq0Kt6nxtEP2XsyHywV6Jbr/3mh7U5cF3SQBGNTnenlXg
         9BS6kC/1AZ6+17jjElhJmnxjb2Le0HJQgl6k3sSR09gIy3ak5DgWdbop0D9kfztaM3+n
         MzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708334217; x=1708939017;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MlSpfk8NgxjvBEwN7lDUund2jmU2k0UEXjhD10l9WT4=;
        b=HGZQjl5pm8E4IzS9UQUVzgcZHe27gGyNL5ioed4uaUC1KirGRmA/KqC7mIIsHi2Tcw
         CXtYVcCuwAHOc6/yATIfBkKLVco4vMeawsmw/UK9j38IUdQ8az/nFPoO4nlKLEL9XIQL
         8VWGS9NxVVKh32yV0KEVG6F0Eze70ZADJ8cbA6Jg4iFdsJbVgzVVZo/dxJyhaevCUVe6
         AaoHPL/aaVCTlDPJxL7NIH1ei5tU1KkUh+7F64Xxby6RJIiEGOq8rKE88Y5XmdilCpHn
         aY9rhFNWC7FSXEoe0Ub82TqAibmM75C3Nw6xsQBgFX7y/fdZdKQslgA9iS02PfjxUzhm
         tplA==
X-Forwarded-Encrypted: i=1; AJvYcCU+/79LcARAn0BTUvmaEUbwNK1oX3HOfjxSUKSfXKz3eXosoDxSyHhb93wC0dPbplsdpwmvUzu3HsLxeli1MncmfNWl0zrD2Lpf
X-Gm-Message-State: AOJu0YwccyXsHKdq02qudEVHYjky2csWEjw+D7TV+DOPPbpIHuOdWj90
	YWkGFRA6xE5ZpRGU/nONIRUeljD6ughYMUDJndPuOPgQZC//lpe4
X-Google-Smtp-Source: AGHT+IH2V/O+ir1Bce/JUAuIMdpFiG5kXHgMoHbwDnJZP+CC5NtGFwouSydSHT78zWIagoHNgmuoAg==
X-Received: by 2002:a17:906:fa0c:b0:a3e:998a:cab6 with SMTP id lo12-20020a170906fa0c00b00a3e998acab6mr1188322ejb.74.1708334216632;
        Mon, 19 Feb 2024 01:16:56 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id tb27-20020a1709078b9b00b00a3e502f5d3dsm1787702ejc.60.2024.02.19.01.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:16:56 -0800 (PST)
Message-ID: <6fff9a9c64c9ba13af4f272a63132dec7a97ae02.camel@gmail.com>
Subject: Re: [PATCH 0/8] IIO: Drop incorrect includes of linux/of.h
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Andy
	Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 19 Feb 2024 10:20:17 +0100
In-Reply-To: <20240218173323.1023703-1-jic23@kernel.org>
References: <20240218173323.1023703-1-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-18 at 17:33 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> These were false positives when I was looking at which drivers
> should be converted over to fwnode based handling from
> linux/property.h
>=20
> None of them use anything defined in linux/of.h, so drop the include
> and include more specific headers (mostly linux/mod_devicetable.h)
> instead.
>=20
> Jonathan Cameron (8):
> =C2=A0 iio: light: vl6180: Drop unused linux/of.h include
> =C2=A0 iio: light: al3320a: Drop unused linux/of.h include
> =C2=A0 iio: light: al3010: Switch from linux/of.h to linux/mod_devicetabl=
e.h
> =C2=A0 iio: adc: ads8688: Switch to mod_devicetable.h for struct of_devic=
e_id
> =C2=A0=C2=A0=C2=A0 definition
> =C2=A0 iio: accel: adxl372: Switch from linux/of.h to linux/mod_devicetab=
le.h
> =C2=A0 iio: accel: bma180: Switch from linux/of.h to linux/mod_devicetabl=
e.h
> =C2=A0 iio: accel: kxsd9: Switch from linux/of.h to linux/mod_devicetable=
.h
> =C2=A0 iio: dac: mcp4821: Switch to including mod_devicetable.h for struc=
t
> =C2=A0=C2=A0=C2=A0 of_device_id definition.
>=20
> =C2=A0drivers/iio/accel/adxl372_spi.c | 2 +-
> =C2=A0drivers/iio/accel/bma180.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/iio/accel/kxsd9-spi.c=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/iio/adc/ti-ads8688.c=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/iio/dac/mcp4821.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +=
-
> =C2=A0drivers/iio/light/al3010.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/iio/light/al3320a.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A0drivers/iio/light/vl6180.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A08 files changed, 6 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


