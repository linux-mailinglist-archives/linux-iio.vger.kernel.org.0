Return-Path: <linux-iio+bounces-21245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6355DAF5BE1
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 16:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C453A2E24
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 14:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEBA30AAD0;
	Wed,  2 Jul 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmbTHing"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6B8284B59;
	Wed,  2 Jul 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468281; cv=none; b=LZqZ6LaFaqhES2Kj9r0K8LGTBIae3cOiDqHy6qvjCzsFxt+7h/LotnQXPrdbPUUyS35WC2+DLcSdW7VGobez4whPmXM3WpBnxiGxjshiotSkfr6tdBLgZa5ln2wh7eh2vpq8U73B9QnqMRS8gG7mIxvfNXV+hVbzaH5awLSkfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468281; c=relaxed/simple;
	bh=BjH9ZL9GM336U/7LmIC7pQDa5Ym6s6rn2+kjuOw1wp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqPtyPxmWumZqFkytNYzK6NWyO1I8+/deSFq4QHY4mzMJGi/1LVG7fcIpBU+Y6MjnRXP/95xLy1E09t6Qtjr1Nt4M/rV04XXGRPtzuYLBY4zk0GnwUYg7lz/VgXmec6mjGEtdoWnneJ+sD3X68ySuIxM1JqAd1hcxgkXD909PyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmbTHing; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235f9e87f78so46800705ad.2;
        Wed, 02 Jul 2025 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751468279; x=1752073079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8mb6YKO/25FxCcRxNpOnxxYjHITO3LXQLCHLiZTW/c=;
        b=mmbTHing0/A9vlil6kCiIj9CAipnxFUoPNzynZn0I47jy9iQxhdRyjJRQ0zZyxkUXV
         9xp0lUAuhZMXRueAWechqOKjDLSR5LLHcUV9rL4pm1VgyODiET7D0azLUArZNiY8goDU
         lZAMNm8+4blmmjLT3WgtP2SCXOuCNDREadqkci4zry+UTLWF+MDJ0lYPdw+9FtNYZIDm
         1irD5YGfJoeRcpdrxK2iv62Etym433bhoMRFaU1ChoP5w/XTgB7cnpO50dba0n9c7QDR
         hKoZuD5d59X7YRp0yVW/2qJX8KNZDxEe8xyBVnI4IzIwfrowCb8D6uPMKjJRynH08lTB
         bp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468279; x=1752073079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8mb6YKO/25FxCcRxNpOnxxYjHITO3LXQLCHLiZTW/c=;
        b=Pv+FULPZf8TYOfpgPkd38JDlUY70fcxvk+nBvArdHpG7x1e6H0roJL8Ua1T6Eq7EgH
         gTSK/C3MKctYtQRKxDulQf3bL+/PYVglurTzsxvsCJZvBxVbHsPD4IlS21kZS9HLcdTU
         r2HRQ5cxKYrcHmwLLVKflwpqxg0ZTw92uApVcfmf2zNWAtjmTWy/kLFRVdLY5bJewnIY
         ZXHoRJJZjjD+QQ/b2k7jnpCkRhSo3UJbx4gV0JCDzI+FXea4dhB35izf21i418Mz69Tx
         z6bWSWLZFSB6+RV/abRMRcpCn+l4BtAw5D8LDQwE/3qzGJZo0WAxlsNSUrN8fCOE4HjG
         J/cg==
X-Forwarded-Encrypted: i=1; AJvYcCV+fUZ8hr93lXvrUzT+bjw3mmw8xQ/gw7zlZolJorTzLS8z51lWFghrxu3tB+q7He6tyGIzdEzTRfw=@vger.kernel.org, AJvYcCWqrH68fm0tYTQe+9JnU+eCG2RzCLwCyjhcZLt7y+JUGzM+Xh0LoJeMjrd4t0coF+GnkMysREspS/UAcFgS@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZH1q8DN5I+JUzgMv0PAIk2o7T5IVX4JEyUtiGgCzautHJNfI
	3+P11WHKizzzADN7gVPTdd7E/tjfsLdoQqs6nTqh3OHzD9C2UnVu8Bkq
X-Gm-Gg: ASbGncvGmlRWSqNJAeypbeTbYqy8KnpargOEJmD7zN4EM3raftfXwBxkjKTGGT9zuDF
	bcn5WcZXx60smt28Kt7gp3ylMZZ30mo2JDnS8rePvZ2MXyprOmsxER5qx2SgkpyH9TYd5yi3VbY
	2C9mtxh3pOcKz/N58LxSrVtfxI5YFK0kHu1uzELXVuW8Iyud8VBj+PJY6m0hwkrQNml1/pvAwT/
	gMzR8eK3OcYcUtk/WaNCKLrg6EXeWS4GJ6RjHIFrB/n4Ia8I3EwAhsBzrvR1UcigEfSqOT4gzcL
	7iCvBSfw7WmtoFmXX5G/5FH2I/qjTwoEYJmtPm0eBU/nMrTisIz1fofI+EcoLVsc/bVALWc=
X-Google-Smtp-Source: AGHT+IGgNwNCyuwa7r5FGF7RkrD49EIguonUe9/QiJBv7+/xI5mloY38Y/AsFY/SVbUDzwPV58ljBA==
X-Received: by 2002:a17:903:2984:b0:234:b743:c7a4 with SMTP id d9443c01a7336-23c6e56f44emr61631745ad.38.1751468279578;
        Wed, 02 Jul 2025 07:57:59 -0700 (PDT)
Received: from mbox.localnet ([36.50.162.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b8ec2sm132043445ad.183.2025.07.02.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 07:57:59 -0700 (PDT)
From: akshay bansod <akbansd@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Date: Wed, 02 Jul 2025 20:27:53 +0530
Message-ID: <3363941.44csPzL39Z@mbox>
In-Reply-To: <f96b68a5-d750-45f0-8cdd-9761b5daca1d@baylibre.com>
References:
 <20250702135855.59955-1-akbansd@gmail.com>
 <f96b68a5-d750-45f0-8cdd-9761b5daca1d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, 2 July 2025 8:25=E2=80=AFpm +0530 David Lechner wrote:
> On 7/2/25 8:58 AM, Akshay Bansod wrote:
> > Update the sysfs interface for sampling frequency and scale attributes.
> > Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-aware
> > and recommended for use in sysfs.
> >=20
> > Signed-off-by: Akshay Bansod <akbansd@gmail.com>
> > ---
> >=20
> > Testing:
> > - Built the driver (`st_lsm6dsx_i2c`) as a module.
> > - Tested using `i2c-stub` to mock the device.
> > - Verified that reading sysfs attributes like `sampling_frequency_avail=
able`
> >   works correctly and shows no change in functionality.
>=20
> Nice to see it was actually tested. :-)
>=20
:-)
> >=20
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index c65ad4982..1cef10919 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -2035,7 +2035,7 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct =
device *dev,
> > =20
> >  	odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
> >  	for (i =3D 0; i < odr_table->odr_len; i++)
> > -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
> > +		len +=3D sysfs_emit_at(buf, len, "%d.%03d ",
> >  				 odr_table->odr_avl[i].milli_hz / 1000,
> >  				 odr_table->odr_avl[i].milli_hz % 1000);
>=20
> Let's keep checkpatch happy and change the indent of the wrapped lines to
> line up with ( since the ( moved.
>=20
noted. I wasn't aware of that.
> >  	buf[len - 1] =3D '\n';
> > @@ -2054,7 +2054,7 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struc=
t device *dev,
> > =20
> >  	fs_table =3D &hw->settings->fs_table[sensor->id];
> >  	for (i =3D 0; i < fs_table->fs_len; i++)
> > -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
> > +		len +=3D sysfs_emit_at(buf, len, "0.%09u ",
> >  				 fs_table->fs_avl[i].gain);
>=20
> ditto
>=20
noted.
> >  	buf[len - 1] =3D '\n';
> > =20
>=20
>=20

Thanks for the review. I'll revise the patch.

Regards,
Akshay




