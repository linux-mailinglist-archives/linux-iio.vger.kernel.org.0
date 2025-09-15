Return-Path: <linux-iio+bounces-24101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C9CB570E6
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 09:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1311F16A28B
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 07:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F932D249B;
	Mon, 15 Sep 2025 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/TwOcog"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D52D248D
	for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920308; cv=none; b=ZxVmcS+rCQTRr/OmQnaPtlFh9iyOVqDGCcYT45Ir0jkZo5fZkV+YSx+XSNmSPNnWTp7m1tVDuSgm+K6P3aWOE4s9S/zenTdVGFJCmzLn36YGFDFYQKorMG4ohbHhNK9LHeIsLsrxcjzFx9MYJ59dxtB5GnSffDguz3HqQBiNFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920308; c=relaxed/simple;
	bh=IsgAPpyXkbreJRRA0w7kjsQFxpj1ev/QH3Dka/0dZS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=baJR1khlCGDOrUrEhiqwFCLSIlFLjg8PwY5SSppc4ndu7FYziDOIStffdC4v9COBmZS9buQLxKaZbVqEsc+T9q6ZAMAb4zcVBbwRAYBfXkAvF0ZVDjTvE0QoOSM/6lv5M4oTHIljFeeGSGJTQm9PZXP03F834KIOSIur/LjZZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/TwOcog; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f6507bd53so4047001e87.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 00:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757920304; x=1758525104; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfX7diTZFOB89teVPyN0MNu/bt0BkcOn8S63v6cexCc=;
        b=U/TwOcog4nGwRa92uR2r/+gTYTVD1MbQ4RsHGQapP82m/TB9e9rARu6Mi6rAGHkh69
         sJrO1FbZQKhMcP7sVNjjv+hVgUKBz5ZwqwmIkbgWh/91AEnMMuyNxSa3d/8cD7xhQkhU
         b2VD6CsxjxJ8QVwKiikufuAygkrPh/lKi4DRi4ncBv9Q/MQeFt9coem9EGqiVHlaLzpO
         BbLWOkD8wPg7gpj5Iv1AK8Ogrc14KPNccZJZxMuHQmAnWvZfcmb+VDrXD+hXDnE1Ec66
         mh1vk+0eBF3n0FBWmyGxCs8eF14mYM6Do6MqD2MU6SllRNB4hUu1IjMKzSJRu2W3GSNs
         GkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757920304; x=1758525104;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfX7diTZFOB89teVPyN0MNu/bt0BkcOn8S63v6cexCc=;
        b=H3ssC8ml++0mR/z//oX5ztWom6uO3gjALDvsr5Wr5tWRSawHDHkBcymku6Ybh2TkwY
         31kphwOjgukXn9sWK3UBWU1INdOeZvOd++2h6MXy5554j4zMKYDdHv7wjA2G/DiBq61a
         NJJLb7Lz+xxMsBqf/t4xUqXhdS0etFzv4jtWlxBbCEqNSzt2mHf1WbWrLI0vxgtBLRzy
         3fXWW6pMvQLk5wkGQ5htUhy4LlSydb66aIfd5We2xFB4dbVrB0i7ywHVX/VZh5A3JgkR
         bb69n4fInCgQu8nWEsSmdceyg6acAkTH9ewg7haFqYtJdgnUzS6Me6/BhBdy1W8BYT9M
         d0rA==
X-Gm-Message-State: AOJu0YyrLEG/KV0yS0+agkmPkRBEOV4se09QJ3Aqkl9PZfDQHNORNGD2
	HAOAiMc2rTDuOwAQvgdYEm/+UEZW+h+zuGaQ9KJlrv0Z6yyyYnpaBDlAw9UJAql0
X-Gm-Gg: ASbGncsUamU2Tdj97HvsOKszFLzx/Z81QcCNJ8DJIuQk91c8x/rS/EfqknSSzJaFrpo
	s57RB+N3/bJb0iHEcS4CUlZBLouZq2lx/TJbVqhfLUq/HHzOFly24mIikRbu01jsNvUB8/14/lD
	NU+Xvf2hrug9ZLOq2nON7P1Ktax8SWpZAoTmrjfBDDdnDXCDA1GcXOxvgkEK/o4zKgVu7mVt6/I
	Zbn1+LiHEN/ulgpjiaugF+8KZAQwxzp6I6TIJ6Nf6Q9/Q7lqSuE1+J1qRArHenhWgHj4f30POun
	2T+SpYTcQTT/LhgusfBNm2PToVhZqZUa3D+rwNFB8zfjOCFqU7el/LC2tgfRgPxLGFqKILleFTi
	YDC+6ULRnIIsBFjQX21gherJE+w==
X-Google-Smtp-Source: AGHT+IHnZijPDedKaSXjvGExCJ5Bp7pMs2ApqYkbSxd1AwGKZxuCUAgkgsahBx5kGvRvP16aCqLHUA==
X-Received: by 2002:a05:651c:439c:20b0:336:bc68:d29c with SMTP id 38308e7fff4ca-3513a32712emr26510541fa.3.1757920303946;
        Mon, 15 Sep 2025 00:11:43 -0700 (PDT)
Received: from mva-rohm ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1b39dca7sm24425461fa.50.2025.09.15.00.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 00:11:42 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:11:23 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 0/3] Support ROHM BD79112 ADC
Message-ID: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8bOBuaMJtlKxByA+"
Content-Disposition: inline
X-B4-Tracking: v=1; b=H4sIAGO7x2gC/2WOSw7CIABEr2JYC+FbWlfew3SBFFoSKQaQaJveX
 dqVicuXzLyZFSQTnUngclpBNMUlF+YK4nwCelLzaKAbKgOKqcAdwfA+yI4QCjlrFG6lEpgwUNP
 PaKx7H6ZbX9nG4GGeolFHX4diIiJSSCwYFw0aXUZeLUsdV1qH15yvo1fugXTwu29yKYf4OY4Vv
 lv/PxQOMbQttZxJ3qhW/yj6bdu+nc3mlt4AAAA=
X-Change-ID: 20250910-bd79112-436a087a5013
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3740;
 i=mazziesaccount@gmail.com; h=from:subject:message-id;
 bh=OQts2Lx4+UAW1/ys5F+pD0K4L3rowsIP7nue6xgUq4I=;
 b=owEBbQGS/pANAwAKAXhQN/9N2qHFAcsmYgBox7tkk7XzsSoPjuJX+cHp+q1VsI8zGA/a9G68r
 GfTYVeHw66JATMEAAEKAB0WIQQjH5/zBlvbx8soSFN4UDf/TdqhxQUCaMe7ZAAKCRB4UDf/Tdqh
 xZLcCACVuPI9vlMdaQSh7lRG0eoFHyxnCaGTmey9MGafcZHg8cpHcJheRvHRsDWzgoCkNxmSBVl
 9VIEZ+bIP3OUcYkEwvr1aryFh+to21v2gvXRtWMHWwnvjdUWr7wcOqBMBVXa97XcR/NhKCILZiQ
 Wv32PsOBlEZl3qs8lnOvJBxb2fb+VaV40J/YitollxrnVxHinDUAXaipS7xdFic8xI9PmyfzhM9
 Yn9pwb+vSWvYND5GF9MFkrvSeB7JO7juHuDTIefc3SzaLcDRCRs5ymzjGrsEFjtsYfRDhYZkB2h
 eC6rFbCoNaI7yy5oG456TZDS+/WPmdkwb5c8TNkKi34Pm+ie
X-Developer-Key: i=mazziesaccount@gmail.com; a=openpgp;
 fpr=83351EE69759B11AF0A3107B40497F0C4693EF47


--8bOBuaMJtlKxByA+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD79112 ADC/GPIO

The ROHM BD79112 is a 12-bit, 32 channel SAR ADC / GPIO IC. Or, a "Signal
Monitor Hub IC" as data-sheet describes it.

Data sheet states the maximum sampling rate to be 1 MSPS, but achieving
this would probably require the SPI and samples to be processed by
something else but the CPU running Linux. This could work with the "SPI
offloading" which has recently landed upstream - but I have no HW to test
this so nothing fancy is implemented here. It's still worth mentioning
if someone needs the speed and wants to try implementing it :)

The SPI protocol is slightly peculiar. Accesses are done in 16-bit
sequences, separated by releasing and re-aquiring the chip-select.

Register write takes 1 such sequence. The 8-bit register data to write,
is stored in the last 8 bits. The high 8 bits contain register address
and an I/O-bit which needs to be set for register accesses.

Register read consists of two 16-bit sequences (separated by
chip-select). First sequence has again the register address and an IO
bit in the high byte. Additionally, reads must have a 'read bit' set.
The last 8 bits must be zero. The register data will be carried in the
last 8 bits of the next 16-bit sequence while high bits in reply are zero.

ADC data reading is similar to register reading except:
 - No R/W bit or I/O bit should be set.
 - Register address is replaced by channel number (0 - 31).
 - Reply data is carried in the 12 low bits (instead of 8 bits) of the
   reply sequence.

The protocol is implemented using custom regmap read() and write()
operations.

Other than that, pretty standard device and driver.

Revision history:
 v4 =3D> v5:
 - Minor driver changes
   - doc
   - SPI optimization
 - MAINTAINERS and dt-binding unchanged
 - Link to v4: https://lore.kernel.org/r/20250910-bd79112-v4-0-f82f43746a8c=
@gmail.com

 v3 =3D> v4:
 - Fix Kconfig dependency (I2C =3D> SPI)
 - Styling as suggested by Andy and Jonathan
 - Moved I/O documentation comment and read/write functions next to each
   other and tried clarifying the comment

 v2 =3D> v3:
 - Mostly cosmetic changes to the driver
 - dt-bindings and MAINTAINERS unchanged

 v1 =3D> v2:
 - Plenty of fixes to the driver (thanks to reviewers, Andy and David)
 - Add gpio-controller information to the device-tree bindings

See individual patches for more accurate changelog

---
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno S=E1 <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: Linus Walleij <linus.walleij@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-gpio@vger.kernel.org

---
Matti Vaittinen (3):
      dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
      iio: adc: Support ROHM BD79112 ADC/GPIO
      MAINTAINERS: Support ROHM BD79112 ADC

 .../devicetree/bindings/iio/adc/rohm,bd79112.yaml  | 104 ++++
 MAINTAINERS                                        |   3 +-
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/rohm-bd79112.c                     | 550 +++++++++++++++++=
++++
 5 files changed, 667 insertions(+), 1 deletion(-)
---
base-commit: d1487b0b78720b86ec2a2ac7acc683ec90627e5b
change-id: 20250910-bd79112-436a087a5013

Best regards,
--=20
Matti Vaittinen <mazziesaccount@gmail.com>


--8bOBuaMJtlKxByA+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjHvBsACgkQeFA3/03a
ocUijwf/TIWG2Yx/GJYf6+EPN0SAwyp/2z/AebFqy2n2AuYUhZcN/PrFxZp9FEhS
kk1WSFb50J4z+GbFWLeoHHFGNFhlG81+wZVS7yfZdRsc/SSNqLq/UmjTAo8B8Qjj
Gbx2v0g4elgDJUF9/Mm/fjramHHN78xamBEay1z7qe09Eg5YtKP3l5F+KIv4Oehx
w4TOcT5/+utmfJ3lnxdoekSJn6SXPW7M53JvLZ0Wt7q4qdDdvgk/3s3EB9tLZDcg
KibOB5bkzVWGJpUZOHeVaRTn439GtbOsNDmjE0VuyRnzg261BfVWJ/OW30M9pQ/1
PU61iNvc6GSx+XS4yeluIh9+Ye2i6w==
=cHlS
-----END PGP SIGNATURE-----

--8bOBuaMJtlKxByA+--

