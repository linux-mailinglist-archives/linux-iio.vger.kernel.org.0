Return-Path: <linux-iio+bounces-23929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F3B51565
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 13:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F19563876
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1545327E7EB;
	Wed, 10 Sep 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9MshjF9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39AF274B23;
	Wed, 10 Sep 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503434; cv=none; b=PV1d3IwX1ewHn1jogVxlRE88IH/zGH760SdyXR3BsqyuH7UBPsMzDYEiWSZ6NO2JHp94NQEDDMGjpf3TNmsn+eXbXX1NO01fr4fTp5o+/m6NEfRLjdhO8Odziusgj+tDvbkUz9xcbo7msKT/cGC6rF1TNQZxxPd6UaCrKaMsgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503434; c=relaxed/simple;
	bh=WdQaWEEj6zFIxUqvPggI0fiQew7wLJcex4Pwhghs7bA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HBhzHcekxF3+T6aogVlbUQz7DGRUgfv3KN/QGKkz1d5cKU9N9ehghcaUz7/nPQV4ZI35u0ya/IWu46PLM+Zq03acrzaGFcTQTmDboqRv2v+Bl2QGgObwHwSLX+4syRmkMURnqKvuGK271ilWSNrFM0U9HpAZso9eF5BRkSvp0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9MshjF9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso7514136e87.0;
        Wed, 10 Sep 2025 04:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757503430; x=1758108230; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCWlIKsn6VpyPvju2k855dDUq8CJXY07guBoClsf4qc=;
        b=f9MshjF9WPVV4I+z8TY3+jVmtTko0xurbf5mrv4hxfzaOrVPHuaSqofwRjwfe7Grgo
         h/7qQYf2ZDSjyiHcUw9o+a30UWLATOH26dn5Gt/OEqWFsUbEngWE3up7NG+PmXP1xdAK
         Rli/kQcaFO5hxrJnd/EvpO8y18O8s3Oq7O58EHb7lcipxqcv7qIgGoJp2609ZvY4F9ZZ
         r0wx8eN9RkNGuL2YnXxucEqZSqrU/Vkk9hdE3svM6pvcoe3BI6mNibri5OFQ+h/uUTgQ
         igTB9Q0iAyp7vnh5m0Y9QAofzODXFbZp+amA39DsDieRNSgX2YxgxkLtqVwhUoTfp2Qa
         ZbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503430; x=1758108230;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCWlIKsn6VpyPvju2k855dDUq8CJXY07guBoClsf4qc=;
        b=WX1wJPWW81g23/rKG3WGXvZs6AnYP/d7eJX6gleECZPVLuPYdRTb1URzErWafdCNGE
         rhkJxmTB3w8fjPHFIgX6g66dm7XsNancrDmQ2Eil38pu2GXWxKOpnF8Tmd7gM5ZKf9XW
         MTu4lan2brTd67f0Oe8C/1DBA+WDWPEBoMglq3HAxrLH9S0rXKqic1Fr0HEhQq90V20C
         vm8GvQjw6oqoyq8z1IKPaUi3h2luWymJF4y3BhDyBJHoHlgS9m/KcGf3HqGmwSWfJHKm
         7vDAX5QJwQe1Rh/uwpdJhfvBtznF84zT4pfNCX3p7AQ75uYoLcmEx/OCPZ/Q82PN/IFE
         HdDw==
X-Forwarded-Encrypted: i=1; AJvYcCV8YibiyvnZQVmSZUnyx0pMKr+4W7FSki70TUdTEnTfu2VQ8xy1PkIYZzclbznljarKs5AyxuyG9G9AgS5V@vger.kernel.org, AJvYcCVR9NQwFPWi5/SDiC1DxyaFu2reA17ZuOsg6e31Z2NinKpsB3aO7skwd1fM1sTcBQ4Jqkl+2/6Lg3o5@vger.kernel.org, AJvYcCX8S8A3WPrI+zN0Mcrrmbopp6p3xXmjgHwDr2gyylLQwkXI0ydD2mAzeDP03hheLyTlOV7W6i27xPLv7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YznGMjo7vgoYCc3YSAxm3CtZ4cZNKw7cDFkqECvhswxi1cGqKf7
	oWsJCHv6l/7X842tBykuyab3eU1y+xuB83RtxNt7Weqp86ODdpM+Q43T
X-Gm-Gg: ASbGnctiCHjjxCFjKo7coaIl/ftfTgkTmadk0yINNMLAzuXIWKsFwpAqbKA48iBuTaW
	4r15z0uR/2TrmS/Gwh+zWZatBopHYT0iZ6l1JC+l3iUjf0fTgkw/bq0yNtbfOlalAcJf1uNw6dU
	ezrq48p7O49Cog8pHu9CUYQFjCGBVZrhMCMirZtfN4b/kxvJCNVGCWKJRAyGPWV/oc9gZxuluT5
	220RsJnod391jz3Yw275B7WWLKy94SSP8c8FKD0mt3b+irf8ZSdKfLb7E51XMMGzlSt93L4Yamc
	QHT6HPjEWsIVRKqR/Fvm4GRSPj8ipiPRkNtPy9gcUXXWYlYYmaaSpunFyQJVsSQKsbRiOHKOCHO
	khzOTSD+Qt0svcyLvKl/hVDaCYzJ/MQ==
X-Google-Smtp-Source: AGHT+IGsXDCG4ZjN7pLx7lx8UFP/pMnqrU6SGROqMgXZekNuMXpdZ2YyX9RsZUMPTG7fRqTAPyeU/g==
X-Received: by 2002:a05:6512:308b:b0:55f:43ba:93f2 with SMTP id 2adb3069b0e04-56260e41eb7mr5840133e87.18.1757503429842;
        Wed, 10 Sep 2025 04:23:49 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795d5f9sm1164484e87.78.2025.09.10.04.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:23:48 -0700 (PDT)
Date: Wed, 10 Sep 2025 14:23:34 +0300
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
Subject: [PATCH v4 0/3] Support ROHM BD79112 ADC
Message-ID: <20250910-bd79112-v4-0-f82f43746a8c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="naZTmkm+dDrSdzud"
Content-Disposition: inline
X-B4-Tracking: v=1; b=H4sIAAlfwWgC/x3NSw6DIBAG4KuYWRcCClK76j2aLqY46iRFGqSm0
 Xj3Epdf8j92WCgxLXCrdki08sJxLjCXCvyE80iC+2KoVW1Vp5V49a7TuhamaVFdHVqlGyjpT6K
 Bf+fS41k8pBhEnhLh2fdxpSS1s07ZxthWjpxlwG0r5+h9/M75Pgbkt/QxwHH8AcaTwKWZAAAA
X-Change-ID: 20250910-bd79112-436a087a5013
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2933;
 i=mazziesaccount@gmail.com; h=from:subject:message-id;
 bh=K5kBEYwPCiL2VCpMX2TvfCPMM5mtV90zLtesxp2x3/o=;
 b=owEBbQGS/pANAwAKAXhQN/9N2qHFAcsmYgBowV8JjLO9BCWd8Do9M/zrFw0sOa6CLWJH/rWgb
 KZYwulDGs6JATMEAAEKAB0WIQQjH5/zBlvbx8soSFN4UDf/TdqhxQUCaMFfCQAKCRB4UDf/Tdqh
 xXo7CAC2C6bXMFGxNrmg5LvbkrcbingPjFb06o19+x5YfDo95SZxSENGga2tCsN0EKYkrvP+XCa
 AqPd3puFg7lNdxlPjTtvLU42VyTaMMDW7BkP5kH9NtTQD97YYxhZMIK+AwX7fQZDfv576GI3YNW
 +/2R17jyJZqzWdRN32WTLAUL1EYQ6BevK9M6m42wFH8ahUBeBNNCnDExHk6rysLi8uB63UOCQLE
 1qzFAFJYWZPKMq5a1Xn3VxWGLlU9TqKk6JxbamJ1mIWMAj8zOhvbr3QBslQ+ZEOJ2hLlqxjyoZG
 Bsrey/u+kVKTbk64pmgH+MJQUfrc/RIQh2B5+842qDIQRDW+
X-Developer-Key: i=mazziesaccount@gmail.com; a=openpgp;
 fpr=83351EE69759B11AF0A3107B40497F0C4693EF47


--naZTmkm+dDrSdzud
Content-Type: text/plain; charset=us-ascii
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
Matti Vaittinen (3):
      dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
      iio: adc: Support ROHM BD79112 ADC/GPIO
      MAINTAINERS: Support ROHM BD79112 ADC

 .../devicetree/bindings/iio/adc/rohm,bd79112.yaml  | 104 ++++
 MAINTAINERS                                        |   3 +-
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/rohm-bd79112.c                     | 553 +++++++++++++++++=
++++
 5 files changed, 670 insertions(+), 1 deletion(-)
---
base-commit: d1487b0b78720b86ec2a2ac7acc683ec90627e5b
change-id: 20250910-bd79112-436a087a5013

Best regards,
--=20
Matti Vaittinen <mazziesaccount@gmail.com>


--naZTmkm+dDrSdzud
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmjBX7YACgkQeFA3/03a
ocWuAQf9HFI2G8kA6QakaO+3gtVqg+TtZKvI8wAz1aozh/phdlDTlWCGK7MEZgaM
O35uZ0bDW7GPsnX+jLBg//Zi/0YDB1VoR5bE19Cg6Q5QpsYE/wPk31G88cAOtXnz
i5MBLLwa0IJnmAcceNzzeFZDh0T8FFe07rYpe6lLFU/3mC8AayLdSOdg7Nj0zSnn
E5s4wEOrJFU+rdNsMD69pIWoS6Dln7aDu2AnjkgESffpulTd+yCmfwMJt8HXV8x/
1xsOo499BWKsrpflJWvR3TuhBSOUN1WnVCw4jbPqjuheJdAk6Vo5YKyB6Q/dO9GG
lPZYhJpTs0WuqelPvN30pWkxFsiocA==
=ZPow
-----END PGP SIGNATURE-----

--naZTmkm+dDrSdzud--

