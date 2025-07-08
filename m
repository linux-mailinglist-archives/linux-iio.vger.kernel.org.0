Return-Path: <linux-iio+bounces-21441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A2AFC351
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 08:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9569B562EAA
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 06:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A807231826;
	Tue,  8 Jul 2025 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF1m5ZAg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92F22F774;
	Tue,  8 Jul 2025 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957417; cv=none; b=qix8p9yGx+xOnmLB2IiOWiV1RPQg2WyMaWZgx2d+z1saoqS3h9gtQK3VIFlZZLPdCc1i9SoF1trd2tvn0lRc+JBWxaWkueVf/uQ4NXl6bGbXnXrjQhmVjdL6/Ni7IeOoHiqeIUK7MxehxA178GhydvZddgY23/9uYV/gKhfDgEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957417; c=relaxed/simple;
	bh=p7Vczb2qgKmJ1lCdlCQ9oB0YanB7KoIMpQZqJ3Ly4MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mye0r70gS/rW6JX6xW7R3M8ziRjxmSpOR/q59GI3k/1jQpY2Ghnsor7ZNvvUgV3guOMglMZH9qNhAt9XXTUMGQEYbLvQrKRUEChF/YYyDUCTPwKnMkcixw67WbKqS+GRmUgxivjYrF6YgR1D7YmZ5YmSkmnt1EiAiM3cmpLcCr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF1m5ZAg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso2106015b3a.0;
        Mon, 07 Jul 2025 23:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751957414; x=1752562214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqugteN2eEIc2l2DBcvL/f8yXrIHgaMnuOSPwTtzdIk=;
        b=IF1m5ZAgwOml8U4Ig3SGpSN3h5D5P8UiOTFHx0EG9o2asQLzYc3nK4/2uhlBpnP+RQ
         dSRxudRpSiBqeS14q+TL359T1tZvjqAYyV6OQqTYHgkV2ArGTlKNbwafKDYM15A41yu3
         YIO5njFp5MVxzT6rXUHCybt7gRmBemOGYlOd+jCcG5lNlsOIF5POLGCLdvluNi2RBGGp
         oISjCq9VThXv1FlZv35ERIH/O+IKw9PTEJzv8B/kzQWuLxxTv2dHXznhcCijnp5/DiCu
         EWtj6r95o3TznwxgqX1K/DUCJk4rrMsHFGqi263x/cKG8rg8O5l3FBuVFepUMmOa8oCj
         LlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751957414; x=1752562214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqugteN2eEIc2l2DBcvL/f8yXrIHgaMnuOSPwTtzdIk=;
        b=p25wEzPtbKMdh2kyucXn7A4kS0eEmCy54SzY5bEq4Bm+lqmNu08OoyVAmWzikdexDZ
         az+yWIrl7TfpKprlIqrZRG14c7tid7B/OfezRTEsBk9wpWISoGDE8Ck3Do0GU/dentSG
         Da5Mje9NEnXBm8sAK8gFReyaD7WYGMnBP2I1hklh+bGPObkoYhbV/4yAJD/JWqFIj1Ud
         dEpQTCi180vbvRENwlq2+l6MP7qv10W0bhrQwCi6jMJGteOLoO7UxHwEQbaIiR/RWSTw
         E10zKf4c8ZbxGZvP8f4HFZbccRBHY1VwzSViMgoYWeB5YySu3yxd9vmNhatw8By56yrU
         O8qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUedMkYxJt7M+6pV99RJ6qo5eRYPoEPEUu+7sMwTXAqIevw5CBEh1WRgVfA/tvfi3dRVy/xHas260E=@vger.kernel.org, AJvYcCV3ZRqu0KWvhhWGnRmHdGStS07ypBGdAcBAeIMKP69I+AVXYHDeUNFLJFExgMcmAvgIEwLZMJljrSt9v8bp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8y71TwZma5S5wA3iMKbO9F104GcZslKI6yJEeKHNLa3RGBk4L
	fS8fIArLuBVgDtH49s3yjMGjDXhbA2HbwWAYTyHwKYYKxZ3eMLisiiM2
X-Gm-Gg: ASbGncuz/dutxVFZ2ULw6fL9tDCbFFHysR8u05slOS4hqIgADhgqszSsSw3HFQJcjhQ
	ELj5x1lAUVSGqmaGlZOE2ZSq6jVL1xeS738twTwRZZAwzqDEvaobwIP9IKp2IZWo0jnXpl9hbdV
	bxnQdE+iSF3w2F59nKwZ3iSTUBh1ti9Bl5CAGr7jMUx1QYxb87LllUoprsqp+IjumuDIrUzpeis
	mm/eI9hCfFcyanIyucq4el799Evvj75uCZmmb+0w0GtKAF4uv4I2Ec9Gc8P9zTT4SHgKWm3Ve5W
	0a79WaAYBDwCmN++SMCBcMP+pI1/yLbwIH0Xf0gZCe0ula9yTIp3BAPDWMrW
X-Google-Smtp-Source: AGHT+IEDnB13/b3LmDOwrFJZtQd45JvmCuztyCFmjCx6EDfkeVSU5wUDDdMIIH9GoBNpGm4oSRkvBg==
X-Received: by 2002:a05:6a00:1c86:b0:74c:efae:fd8f with SMTP id d2e1a72fcca58-74cefaefdf8mr18459328b3a.15.1751957413474;
        Mon, 07 Jul 2025 23:50:13 -0700 (PDT)
Received: from mbox.localnet ([36.50.162.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417dde0sm10402432b3a.73.2025.07.07.23.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:50:12 -0700 (PDT)
From: akshay bansod <akbansd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Date: Tue, 08 Jul 2025 12:20:04 +0530
Message-ID: <22754870.EfDdHjke4D@mbox>
In-Reply-To: <20250706115003.5752261c@jic23-huawei>
References:
 <20250703053900.36530-1-akbansd@gmail.com> <2413481.ElGaqSPkdT@mbox>
 <20250706115003.5752261c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Sunday, 6 July 2025 10:00=E2=80=AFam +0530 Jonathan Cameron wrote:
> On Thu, 03 Jul 2025 22:28:13 +0530
> akshay bansod <akbansd@gmail.com> wrote:
>=20
> > On Thursday, 3 July 2025 10:12=E2=80=AFpm +0530 Andy Shevchenko wrote:
> > > On Thu, Jul 03, 2025 at 11:08:59AM +0530, Akshay Bansod wrote: =20
> > > > Update the sysfs interface for sampling frequency and scale attribu=
tes.
> > > > Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-awa=
re
> > > > and recommended for use in sysfs. =20
> > >=20
> > > 'must' is stronger than 'recommendation'.
> > > Of has the documentation been changed lately?
> > >=20
> > > ...
> > >  =20
> > > > st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev, =20
> > >  =20
> > > >  	odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
> > > >  	for (i =3D 0; i < odr_table->odr_len; i++)
> > > > -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
> > > > -				 odr_table->odr_avl[i].milli_hz / 1000,
> > > > -				 odr_table->odr_avl[i].milli_hz % 1000);
> > > > +		len +=3D sysfs_emit_at(buf, len, "%d.%03d ",
> > > > +				     odr_table->odr_avl[i].milli_hz / 1000,
> > > > +				     odr_table->odr_avl[i].milli_hz % 1000);
> > > >  	buf[len - 1] =3D '\n'; =20
> > >=20
> > > My gosh, this is error prone. I'm wondering when some CIs will start =
to
> > > complain on this line. But this was already before your change...
> > >  =20
> > I'm planning to drop It entirely or should I replace it with another `s=
ysfs_emit_at()` ?
> > I've seen other device driver returning space terminated buffers. Maybe=
 I'm overlooking
> > something.
>=20
> It is rather ugly currently but not a bug as such as we know we don't act=
ually run
> out of space in the page (it would just overwrite last byte in that case =
so odd
> output, but not a bug) and that we always print something so just as you =
suggest
> sysfs_emit_at(buf, len - 1, "\n"); is safe.  It also checks under and ove=
rflow
> so that safe + hopefully won't trip up static analysis tools.
>=20
understood. I'll revise the patch.

On a sidenode, I see a lot of repetitive code trying to write to a sysfs bu=
ffer
from a static array. for example

 drivers/iio/common/st_sensors/st_sensors_core.c:629
 drivers/iio/adc/vf610_adc.c:614
 drivers/iio/accel/adxl372.c:972

 ...

What if we export a symbol from industrialio-core.c which does something=20
similar to

 drivers/iio/industrialio-core.c:815

 'iio_format_avail_list(char *buf, const int *vals,
				     int type, int length)'


but rather than taking integer array, it take `void* ptr` and `int stride` =
as
parameter. Then iterates from `vals` by `stride` for `count` times and type=
cast
the pointer and 'sysfs_emit` it.

static ssize_t iio_format_avail_list(char *buf, void *vals,=20
			      int stride, int type, int count) {

	// iterate (void*) vals by stride and perform `sysfs_emit`
=09
	void* ref =3D vals;
	for(int i =3D 0; i < count; i++){
=09
		ref +=3D stride;
	=09
		// typecast and write to buf using sysfs_emit
		...

	}
};


Thus, drivers can use this as follows.

=2D-- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -618,20 +618,11 @@ EXPORT_SYMBOL_NS(st_sensors_verify_id, "IIO_ST_SENSOR=
S");
 ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
                                struct device_attribute *attr, char *buf)
 {
=2D       int i, len =3D 0;
        struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
        struct st_sensor_data *sdata =3D iio_priv(indio_dev);
=20
=2D       for (i =3D 0; i < ST_SENSORS_ODR_LIST_MAX; i++) {
=2D               if (sdata->sensor_settings->odr.odr_avl[i].hz =3D=3D 0)
=2D                       break;
=2D
=2D               len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d ",
=2D                               sdata->sensor_settings->odr.odr_avl[i].hz=
);
=2D       }
=2D       buf[len - 1] =3D '\n';
=2D
=2D       return len;
+       return iio_format_avail_list(buf, &sdata->sensor_settings->odr.odr_=
avl[0].hz,
+               sizeof(st_sensor_odr_avl), IIO_VAL_INT, ST_SENSORS_ODR_LIST=
_MAX);
 }

The details about the various types to cover is still unclear.=20
But does this sounds feasible ?=20

> >=20
> > > >  	return len; =20
> > >=20
> > > ...
> > >  =20

=2E..

> >=20
> >=20
> >=20
> >=20
>=20

Regards,=20
Akshay Bansod





