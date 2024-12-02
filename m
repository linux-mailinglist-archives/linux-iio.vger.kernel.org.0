Return-Path: <linux-iio+bounces-12943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBE99E00E4
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 12:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917E8282258
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D4F1FDE16;
	Mon,  2 Dec 2024 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeyJ4STY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3B1F9AA3;
	Mon,  2 Dec 2024 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140075; cv=none; b=d/416/XCRQWtqsMFtCLS2vFD6OIA2I5cC79OYgIBpk16x1KCXa2KE5JPGCGFdhVeiSH+Mgdkk94peI5ldC96T4Pbn1SSvGo7lm6He2i07MwyMQhNB3WN82huKT3KJcUN+e+QCgBEzEhpgryAITv/4NAusQ8v4eckfpFDkCcCRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140075; c=relaxed/simple;
	bh=7b+5QBkw+sfaYLBUUpWCAzOQ6XFXSoqIasPZQOnv31s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o+i984XVJCiGaBVD2IbySDexHocddZRgbilMCkk6r0zO84viZ6H9nk4d/Sm5uX3ZGgzNx2m+GI20oPeDrD070kkevRNY99/FDzVPp8f5K3Mb7OHWgVJ7nnj4OGIvQpMiN1Xtb88bW3dugnFfcBmCj/Sn285mZVkrXruDmzYr91A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeyJ4STY; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53de556ecdaso4079003e87.1;
        Mon, 02 Dec 2024 03:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733140072; x=1733744872; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzUJUTzbvGPKwa+PxhmndHawfIFfq48oDBcRmcx5a4o=;
        b=XeyJ4STY6wQQVLbVa3idElKKOes0sPWc6pEbxwsdA7BdX2o8Mladj+ZC6DTfNk2K9w
         J48VTbNZmIGN6h+WyZLsSFnWzf7MMd0Fpf/IR/m25e2kiqCRUBDVLV6g2L/5tgDq6WZv
         0FdcgT6ihK4//wVvZThhlp7zlcf7r7dMvbp8XdZeeXmJ14z38K1oosz5XivX7UGmzcUl
         Jay8dNEjYE17dGRLvpC9yaStjRUcNqMKeNybmFUh3uFUJGIPy4kAabHvyU77cpC/6n2S
         PVAJeCdncei3mG4AXqCPtXNYbPvEr14ZDO6W86H7ZcJ/DUZ9CnqmM32TNlE9V11O4snj
         pJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733140072; x=1733744872;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzUJUTzbvGPKwa+PxhmndHawfIFfq48oDBcRmcx5a4o=;
        b=GgiBxD28t9KVnLVcyxNMCpaJVhgtL8Y/Ibk6nE0Wf72YNpEB2iIEc440EbKoXFt6pH
         JQeepGUsQzLLq3ROBIOipTsykQMfjzYhhCyr2ioxDnBvc6HVkkIwAeSsyBpLrAQRCtDc
         KCHB3EG3Si7O5k1pujSuOBVsFQe2vMZKwqfcl/6H3Arr+uqnDpNXkEPSaKr6hUmZle/H
         aSlzJnrQqbUynqZDqiwKQ82t1dJ9X4JpmRPbBQ6gGBu2tvspiSlZVErPvwWoXi2IK8LM
         0Syhf7/GoOJr/yjRXpHLHpbVjZuzwMUionxcg6SYuQb81cual3V74B53zxmDeALPIgv7
         smLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8r29MhBTU8OOmZNHVxF5B3mH3WR1quJ/HLrgVlLoBIKkXgw6wGADmKa2di6V+rCsrESjILdGeGKk69EFA@vger.kernel.org, AJvYcCW/DBKZuBtJYtkJ4loo2UmOsWfR7vQ12bRtmQeK+fRJpYDrAEiiZ/vVCO0VtyIJhMGVwmrmmy9UKIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNetsvr5Xgsn6Qr0RJktMhKEJRqAGxJQglnGsul6TtpmcjCh3Z
	iXMOp3jE+nZeYs6G65OVTyYN2hzh9KjdgRGXpAPqQUjK/5FdvBVv
X-Gm-Gg: ASbGncsqiDs/Qiu2W9A5ntZaLCVOVegggxNhoeP46J+CbkBon6V3LxYsXIxLuAnHDJ5
	0j2Y8vWuEsHjliD8ImgUL76nlM8844gNx1N7kPg4TfT9oYVThrSUM4mtYa99+/GF5evZSvu30li
	3QFzlE6B4cbStLtIP3+RkwRGYuGRAf7Q9jDBwWnXuxChqxgE1Y+2zHd+rnRzCZbbGS5Hhvou6UU
	yJFHtdGXvECawOwFlxRKfWfDn8zxtD3hmNRoiN6dw50Eyjmg1RdqerI
X-Google-Smtp-Source: AGHT+IFIz62MfwBuZME7MVogwfKQcWcn+994S5k0u0UnacF62zbdlzDiLo5U62H63uF5RYoA83f8fw==
X-Received: by 2002:a05:6512:398c:b0:53d:ea3c:2ba0 with SMTP id 2adb3069b0e04-53df00d12afmr12838986e87.16.1733140072128;
        Mon, 02 Dec 2024 03:47:52 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6495ba0sm1426130e87.172.2024.12.02.03.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 03:47:50 -0800 (PST)
Date: Mon, 2 Dec 2024 13:47:42 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: kx022a: document new chip_info structure members
Message-ID: <Z02eXtrrO8U5-ffo@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KFfhg9dvQCPxm6jq"
Content-Disposition: inline


--KFfhg9dvQCPxm6jq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The kx022a driver supports a few different HW variants. A chip-info
structure is used to describe sensor specific details. Support for
sensors with different measurement g-ranges was added recently,
introducing sensor specific scale arrays.

The members of the chip-info structure have been documented using
kerneldoc. The newly added members omitted the documentation. It is nice
to have all the entries documented for the sake of the consistency.
Furthermore, the scale table format may not be self explatonary, nor how
the amount of scales is informed.

Add documentation to scale table entries to maintain consistency and to
make it more obvious how the scales should be represented.

Suggested-by: Mehdi Djait <mehdi.djait@linux.intel.com>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Wording is difficult. Especially when not working on ones native
language. So, I am glad is someone evaluates whether using the 'NANO'
to describe 0.000 000 001 is correct - or if term like 'ppb' would make
more sense...
---
 drivers/iio/accel/kionix-kx022a.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-k=
x022a.h
index 142652ff4b22..82c4ced7426d 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -137,6 +137,11 @@ struct kx022a_data;
  *
  * @name:			name of the device
  * @regmap_config:		pointer to register map configuration
+ * scale_table:			Array of two integer tables containing
+ *				supported scales. Each scale is represented
+ *				a 2 value array. First value being full
+ *				integers, second being NANOs.
+ * scale_table_size:		Amount of values in tables.
  * @channels:			pointer to iio_chan_spec array
  * @num_channels:		number of iio_chan_spec channels
  * @fifo_length:		number of 16-bit samples in a full buffer
--=20
2.47.0


--KFfhg9dvQCPxm6jq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdNnloACgkQeFA3/03a
ocX//ggAxZpa9WgDEFp2qhfc9aaWTV8LOS3OmYPbO15WvGemNjfa42GC7yrsUh7r
9P8dTom4eaI6XMnLsZ8U9S/qLwgQkXn2EmjE8vPh2XC3Iqs5zAD50XYv8yqgyefv
kD4epENf1hXmmV92OuFq1EEJvdOvfwlan1ASuf0tkpWPVHD8t9mTbx7p35zijfzT
p8XlPTs7hynQUkTYGTJnli0vqJx1kS3hr9IfB/+FqMuVnGw/ssUIr1E2RNVrVR0e
SvX7m+6bobwF3mexGRK9aSb6VR90DSU7mKL1c5KO4id9XYGXbLPcsWWXzRLi+/AD
SkWusjh0uDDR14jLWs06+7Wfu+viNw==
=2akq
-----END PGP SIGNATURE-----

--KFfhg9dvQCPxm6jq--

