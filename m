Return-Path: <linux-iio+bounces-13135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF90A9E6A05
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 10:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEDF28295D
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF641DFE16;
	Fri,  6 Dec 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib349zOm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC301C3F2C;
	Fri,  6 Dec 2024 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477216; cv=none; b=YZxoaK8M4L2HqJwt0Abe+jbzkCTOcJ8D7CtMoxkukOfvtK1DwRxMJHy84mWA9iU+93iBYabNfU/XPjT+B2HL3yYdVrXJIROfTfMGFTx+p/eJCZz0n7rpZaRDZX014M2So7e7bS75alRJgVnlluSSerQuY2xh0xhqSicW7Q+HZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477216; c=relaxed/simple;
	bh=DOgjgIHtbvEEs4icMPXghie6iZ1iNRD3xyyVRQQWGo4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J2uYR9n+7g88IFa8Frn+KCP0fy9d3VAaGIb9SggghaRNQQQROwWlf1j/eIAzDi3AwVGdtsil197O/eeTjcYDedAM0t6ThDpxsS3XK6qrx8KuXQld3MpzmlXfxaPnWW9ylVHGN3FuRbfGTdXT5ujWGaIZguNk9504rzADXyn7jvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ib349zOm; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53dd2fdcebcso2329462e87.0;
        Fri, 06 Dec 2024 01:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733477213; x=1734082013; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpFq1+DMaQvpewJxrv6v8zSoD14ZkAeC0fz9lQIxpy8=;
        b=Ib349zOm6HI7ZszDLJQDQes2CAQvwZlGSVeqoyZGYIH4de9VVlxtqFkd96COgkNfQS
         NHIGLknN7d3MHWASurWg8jGEoV5TcO45zsEiyMZAuck1oHnrVLKMlGYrCCY5BdJ+0dl3
         rNIfE4hA1Mcru1y9EbbKhanNuvsTo+4Urr+1o4/oEmJwRX6z5eifzMgBsRS6cfubuGw2
         60B16KSy8Vj2opv3KSl76jGdNYJdq5INiK7aw2CzihncqJMv9DqLoy/TJi3D32sAWgWf
         6PCSVz7C4T6QNcM1yZC8dkZPdkBva751lI8UJsLSrdpbZJGbgDzUpNE66FuRuL+p84pA
         Yybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733477213; x=1734082013;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpFq1+DMaQvpewJxrv6v8zSoD14ZkAeC0fz9lQIxpy8=;
        b=Ugya9/4CJThKQi48mYavYBoFwaQ+nLkGWyFLZbNaXSetFVmHWbfQyk9qMp1tad6TCA
         nHtXHcIdctRElQHkdQcz6GqwcnBPqct3f89FOSXDM8W9alx3vLOkAaKcg9fPYPS895gz
         E6DLrkAeJ75Q2/i/yu5EUdq96A9Fx06tOwOuAsuP1lN2KzWMj1Exx+RItV/RZ3Vt2w1V
         Xjv5hzLTDj1/aXe8TM84t3vjyngxppGPmtpUvURNxvU9G8mifDbbKYCi6dNFSfCg2H67
         A/H45W1f1nRmTJsa3m/pyXJCYNjU58hRrVbpiT2VpbQvqzTPaYfYBRS39SLtUhXsphfm
         ph6g==
X-Forwarded-Encrypted: i=1; AJvYcCUIZSYbbH/Vjm5qPEMG4q3Lc+Rkc6webqBKfB2gnXVTb7gnWSv5t4bIVLCbIRmfqZwKA9FkALHOFyM=@vger.kernel.org, AJvYcCX8rxgr0bZ0CFySYJwu5bOfPsi8C3UHa0qUqFP67VwVkJ2nHvxd6QPVMRiwMnrKugxNYq8CoFbPxXE55hPd@vger.kernel.org
X-Gm-Message-State: AOJu0YzBqEIgMe7IYdwK4qATALKOzWGSEVN48NjOU1sJftjWPCOS63YA
	VdwMeJOP9woLSrUqxvld7/zyPxSzj0Sx3No1ng/ob8qOmW8hBM6h
X-Gm-Gg: ASbGnctNyL6pOncs55L6doR1sgsaoLgSjb3iMQjmmqzaRdb+2pCsjnmFjl4oZohTJAH
	sSte2tsM9kcwNRCivDwylVTFWnfq6c0q06e8D8qMILhf/g/INvll8avZFI1LlwybEDFylpd6UO0
	bvpLtWkLQ83eH/ehZOnfh3JoQoeMpmshZz/1ovROqwduVCAMPaowEEljiESdXVoxspuyKm/cf95
	dizkkk5pX49Y0aJegpn0HG6wJJEtIsrqZufD7Eo5QU9ixRheQkIHONA
X-Google-Smtp-Source: AGHT+IFyvsA+zQFzRoi2X/NTwbQxmXVEoExfyBnwbC7Oe3QZMaB61RMhwvmWEaefbh7vu3cS++0avQ==
X-Received: by 2002:a05:6512:e9c:b0:53e:2151:4d9f with SMTP id 2adb3069b0e04-53e2c2e8a34mr1180354e87.44.1733477212853;
        Fri, 06 Dec 2024 01:26:52 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229c95fcsm447449e87.229.2024.12.06.01.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:26:50 -0800 (PST)
Date: Fri, 6 Dec 2024 11:26:42 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: kx022a: document new chip_info structure members
Message-ID: <Z1LDUj-naUdGSM6n@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZRsxLEK7ScoQg9xB"
Content-Disposition: inline


--ZRsxLEK7ScoQg9xB
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
Revision history:
v1 =3D> v2:
- Improved wording based on discussion with Mehdi.

 drivers/iio/accel/kionix-kx022a.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-k=
x022a.h
index 142652ff4b22..d18d56cef098 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -137,6 +137,14 @@ struct kx022a_data;
  *
  * @name:			name of the device
  * @regmap_config:		pointer to register map configuration
+ * scale_table:			An array of tables of scaling factors for
+ *				a supported acceleration measurement range.
+ *				Each table containing a single scaling
+ *				factor consisting of two integers. The first
+ *				value in a table is the integer part, and
+ *				the second value is the	fractional part as
+ *				parts per billion.
+ * scale_table_size:		Amount of values in tables.
  * @channels:			pointer to iio_chan_spec array
  * @num_channels:		number of iio_chan_spec channels
  * @fifo_length:		number of 16-bit samples in a full buffer

base-commit: 05ff9c9c53c643551fe08fe52bd714310b9afc2e
--=20
2.47.0


--ZRsxLEK7ScoQg9xB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdSw00ACgkQeFA3/03a
ocUDTwf+P4KomFZwCDODH0Wi+GgjWuc85SqsCo6G62umi9jipPr4eKZcog1DWCHj
8mKGCI5P330uHh5j9zqbclHYR7CXR4jTCnRgkedtMPx5eTA/Rib9M2ccj6bN6Qpb
iBb7zVEqyt96BCKDH4VxFqtplb8nSunLWGMKvSvZqZ1SfUHBn4yHf6X8SAqai9wk
2RrIf8yI7VDyhvIT6fTPA4GeIpEFUTP7hB7X9KJslzXsMsosObwxuu1WwDYOZIBD
iVex4yyrYOrnnR5ZCrxXyNIc+IUvpFRj6k7wPTARNNLqAd2CeaZvrMS+BVk+pm8D
35UVFEyxmqYKHseyBEATnBkGp7WoHw==
=aqMx
-----END PGP SIGNATURE-----

--ZRsxLEK7ScoQg9xB--

