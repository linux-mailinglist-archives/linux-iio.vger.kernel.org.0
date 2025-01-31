Return-Path: <linux-iio+bounces-14748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C40A23E5D
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 14:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3F818862F8
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2811C2443;
	Fri, 31 Jan 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJlskc7a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73700323D;
	Fri, 31 Jan 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330506; cv=none; b=JRA04ksqGKerFnfvokuar3YLOigppx1pKeHoc+U7hsSU+HTyofefoLEJo0t7hSv3kzBdjtTJ2EX8xRh81ICoIbanjFLy+49Ji5QrMMn2R0XpfeLwa/QQp5f8pOkpRocKqlkCraRfODUGNhMu3XDEWxAG+yKTJS9B2UzDG3L935w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330506; c=relaxed/simple;
	bh=Xz8VjKejfbpPZ5ZbbgK5hu/UqkF3eVN8GGa71ni45u0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z8xCtFS4kkkEFF92olrthnF6sxLAAWbLmICAEC463yLbxIHbBvbj5zXG9Vkj72SGSFIse1lYmLSI59OxdKS7bLD70Qzr1RDdGZKIXtTxZ0knLWkOP04tcuFuEK9wu0Xl+ZSUhzIw3NS3a+FEUM57/y/qb3Wuz/15kDZiIGsaVMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJlskc7a; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401ab97206so1918957e87.3;
        Fri, 31 Jan 2025 05:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738330502; x=1738935302; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eu+Y8hwetlGIoMj6j81yHuOb5xgouesg8mpKJnw8jVA=;
        b=PJlskc7aQE72XR43o6u8nHs1vb6Q5zZJ7hWGYzbqBhy3GpMmyV4pWJcz1UJvpXJCZP
         X6bcPuqGEgDfzHnVljjvYy7olZajIzNQEykObFvx6rMkAylS3DbA4Eju5zSwxB6aRGiU
         xiiOIKaX2o8nuaZu4/L4gIL6VorspI4UxclEmkSHVhHlrm/r1c8jnxiIt/JS6Hinbs2E
         ZqzJrCls0ZfJ9sIacOP2SK4cguFUzgIkwv1Tr3Hnh1wY3zXEPPMdZTRCXSl9dtR/gnBx
         baBVjOPmLU55sG/0naEiAXYzko4yCfDkKSsXdwH7rlygK3joM/3XkNZxDi5QHi7xwEPx
         RyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738330502; x=1738935302;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eu+Y8hwetlGIoMj6j81yHuOb5xgouesg8mpKJnw8jVA=;
        b=iZvT4KstnR+X2WXY5/IIp/R0ZGE26G4/JEFSj3oNl0JTNmdSWYFPCoBnrQs/zsxXvc
         UdpQBWEONvZqqzfQ0M/yh38NYpYGO7d0VTlX7Z50383Dyj23hoUS8tkXCH8JgFZMou2o
         xpIaJEQ13DIJQbv/pxmixUUJIUfPRuw1Si2BcDvKFen6wjZY7eCyrpwvTPiqmvTqDXA5
         9pa4r4G0SYa9tCn2hB9Co2K8Pg16UlXtRqysZ715bp6SWdRJENAUJHFCLt558/WNWCzH
         fiamIZ0IrRWKP01VJ/mJ5KYF8od+PX9PGfUXuEaDZCbq2pXmWtfwOKDnX3b/SDcW3C8j
         fwpg==
X-Forwarded-Encrypted: i=1; AJvYcCUbgOqVMuZBGp/Vfc9SA4BnQN2+vtz3goUADSKBz8qSNYFghJztC6ZuEKa9JY3n+i47UHdLxjJVSkx7@vger.kernel.org, AJvYcCWWmF8LYYOQpdOns3rbaVbL+r74TyaQVWedmJBuXoljCmTKaB1MqawSZqU9YAhyGYQdFMU9RDWWUZk/@vger.kernel.org, AJvYcCXcEz2XmoCX0qNNnXDZjKfa2rp2ilAe3F44CP3UsG1e7FeLkA+xodL4srinACE8YmwFs2eqogQ0DJQIA64z@vger.kernel.org, AJvYcCXzQzuv/Jm2nNdjW2wA4JOA5HfZZXCVjkpkIfGgwCDYg23CSDBw1G1nNNUtKos9XoQ2WjrDNu1Zl0n/Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1rWwBu1ghAemZZnQw79g06pu8q4Aiqh5P9O7oRIMOm9nIXBT
	TdFeGe44Alv8Dr2tayBZPZqnXkAJ9ysGNIqD8epaEEwrSADVwDzE
X-Gm-Gg: ASbGncuU2032UbUODnsi4VOIP/AesrmvyFaAHfYMynL4GNlltaxR1X9yEQXycaoiBgZ
	ojoZceUo1rDNyhseKEz7Qbn7b3XgoscYLJGOvUBglGpnlMDBRpD0Y2Y1yVv5xiuPcBii01etMl9
	rmSBBQAcoJLBXPm7ZHahuPL6k1Z+YX80VsErg5G4n0GViJ8TTlAtLgE3cXXl8YOGlQhfPhj1JRF
	Hd18reJzEJ+5uHCrFLlI5ji9+Y3RIXZqvK4oc+4LxfVntZnmWJnWapblU4oNzbW0ZjArLjgP0FF
	w8R3cjeh/2so3c/vyO8AiH5XjcA5y00YOEGTuEwtSnas3W0=
X-Google-Smtp-Source: AGHT+IHs1oVh4GLAYU8vC+tcDofEQq+9y0jY+lRpK5r5psyIMy3xlfB9XvH3oDlFxONwU8Y6qIEgAQ==
X-Received: by 2002:ac2:4e01:0:b0:540:1e17:10d2 with SMTP id 2adb3069b0e04-543e4c3c39cmr4025101e87.49.1738330502155;
        Fri, 31 Jan 2025 05:35:02 -0800 (PST)
Received: from mva-rohm (85-23-190-22.bb.dnainternet.fi. [85.23.190.22])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307a3428055sm5590001fa.98.2025.01.31.05.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 05:35:01 -0800 (PST)
Date: Fri, 31 Jan 2025 15:34:43 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RFC PATCH 0/5] Support ROHM BD79124 ADC/GPO
Message-ID: <cover.1738328714.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="daWK6XH5vuFu49SL"
Content-Disposition: inline


--daWK6XH5vuFu49SL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD79124 ADC.

Quite usual stuff. 12-bit, 8-channel ADC with threshold monitoring.

Except that:
 - each ADC input pin can be configured as a general purpose output.
 - manually starting an ADC conversion and reading the result would
   require the I2C _master_ to do clock stretching(!) for the duration
   of the conversion... Let's just say this is not well supported.
 - IC supports 'autonomous measurement mode' and storing latest results
   to the result registers. This mode is used by the driver due to the
   "peculiar" I2C when doing manual reads.

I sent this as an RFC because I implemented the pin purposing (GPO/ADC)
using pinmux - which I've never done for upstream stuff before. Hence
it's better to ask if this makes sense, or if there is better way to go.
Anyways, resulted drivers spread to 3 subsystems (MFD, pinctrl and IIO).

Furthermore, the GPO functionality has not been (properly) tested. I'll
do more testing for v2 if this pinmux approach is appropriate.

Furthermore, because the ADC uses this continuous autonomous measuring,
and because the IC keeps producing new 'out of window' IRQs if
measurements are out of window - the driver disables the event when
sending one. This prevents generating storm of events, but it also
requires users to reconfigure / re-enable an event if they wish to
continue monitoring after receiving one. Again I am not sure if this is
the best way to handle such HW - so better to ask for an opinion than a
nose bleed, right? Maybe the next version will no longer be a RFC :)

---

Matti Vaittinen (5):
  dt-bindings: ROHM BD79124 ADC/GPO
  mfd: Add ROHM BD79124 ADC/GPO
  iio: adc: Support ROHM BD79124 ADC
  pinctrl: Support ROHM BD79124 pinmux / GPO
  MAINTAINERS: Add ROHM BD79124 ADC/GPO

 .../devicetree/bindings/mfd/rohm,bd79124.yaml | 111 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/rohm-bd79124-adc.c            | 890 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/rohm-bd79124.c                    | 165 ++++
 drivers/pinctrl/Kconfig                       |  11 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-bd79124.c             | 276 ++++++
 include/linux/mfd/rohm-bd79124.h              |  32 +
 12 files changed, 1518 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd79124.yaml
 create mode 100644 drivers/iio/adc/rohm-bd79124-adc.c
 create mode 100644 drivers/mfd/rohm-bd79124.c
 create mode 100644 drivers/pinctrl/pinctrl-bd79124.c
 create mode 100644 include/linux/mfd/rohm-bd79124.h


base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
--=20
2.48.1


--daWK6XH5vuFu49SL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmec0WsACgkQeFA3/03a
ocWxwwgAm4eAzcDyXSJ+HL2AMGU0v0RQQMilaqZDrdqzDyTvxd9AxePvb8c0xnjL
SWD7Af8dQF0S/XqNVn+71b7hEiURF5FY5kCd5HuvzxM9/O2xjQy9mA8KD03SIBGL
TuHYjGCsXfRg38lpKfUM+uws/1pvzl3IKjhLrh3gxtoZt++f6JZgBh/YBe1Vpmyr
0c+QGgz0dMMAdV/r70zV5KY0KQMSXZEqEpiSTemJH8XvxkoW6tuWmc6G7sVNoJgJ
JQN5LXmRcfkVl6wSYTSgqk3GPIizmjrxTcqCGqRwYyo6yM6jT7uZ1/SZguoeZUDh
GLFBGJgML2UIpbI1SCRdeO2nhUzVnQ==
=tXv2
-----END PGP SIGNATURE-----

--daWK6XH5vuFu49SL--

