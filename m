Return-Path: <linux-iio+bounces-16024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070D3A42B62
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 19:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E001890BB8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808D7266184;
	Mon, 24 Feb 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+uY28fN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607581D8E1A;
	Mon, 24 Feb 2025 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421935; cv=none; b=tQOZDv0jaGiZxVV/lF0ST9TBZhl9t74ul5b5WMFmFQ1LDztJyO4NNnPCnMjzlu8X4++UH6HANyGImIEqOlvtneV/ynVnCqImoy5qKgQGwzakWLwluqV24YtKwp1tnzwTVUyhmT2kT0lMvHjrPFSIIn0GvgC9zKsJy0ioCl2wj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421935; c=relaxed/simple;
	bh=4MLcmJIBvKKZweH+r4aizHk9WzkqSH1/Ftb5joBdaRc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PdQAUhTwdmPmaqt19mFhYxeERQkJy7wKntI4OfK9x1IhsVbhF6I9dAb3usZemGSQ2F2P9wRtZRorUhcpavQRiAvId9N1gOHS5GSLdrrVoIq6TRWd/XT2iqfja3lUadSGS94mKMWfs0lCn+AzphJPj4Q6mcMo6jPFxk1sMh2yUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+uY28fN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5452ed5b5b2so4742876e87.0;
        Mon, 24 Feb 2025 10:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740421931; x=1741026731; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXIG3rwFkUBNHGVcpVvR3tMHmQkVgrY0k20PaQNNWQE=;
        b=Y+uY28fNOnwQWLIlFEiOlDkCXakS18OwguKo8Fwd7uRsL9I3lfEBI2aCSCR7Vk+IUl
         FWDBPmG7oGNUGoEIRx8S+JHbbY0VFmf5VrWSEJ4bDESeWbZvh0/NKvWKFw36ZfYzRKAO
         dq6f7EMUWQ7bqiPjQWXj6SQmwxEdAwC83XXgrpZ3tqYotP4T49jwUhF0EjEu9Ib5ZdVZ
         dIQO8XZH+p5Q12+NF3S/qLSM4EcHk21NQo0FImdCnOujgQbKvZMDiy+1tQKXBrhgU2uh
         W2bZSiwQJbHHhlMEUn3TglXzv4YCAJ0+8shkMfCk18whrSH3820Q/T0uTNU4/jZT2zCO
         YQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740421931; x=1741026731;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXIG3rwFkUBNHGVcpVvR3tMHmQkVgrY0k20PaQNNWQE=;
        b=sfOuep1YqMd7miRRMzfP2EDb2zZtByV1BnF51UU3DhPNQF9x6RMPIEX3KlV0fYh0ng
         +agBDz/hnspz1DXfwQ+ZqjREMrKTcE7NwjwKvcpI3B/WEwQyBDMB/M8rouspkaXwKd1u
         gAPeqqORutFW/RJmFCrXL5oYjapxrdGwOd7m64iwNB+IEKr1uYcNfwUCqmx6Z4EGp29H
         N/oRdw+565in056vK9qhsLIJ4DVxq5wVxckF81iJFqgKVguPR8cay79/SS2lqoZV5GJW
         HKRV1nXKRCylzvwC5KxOzyw+UFm4DSgPsSxCMD3ziCc7gicKnOu7/Z4j/Zks+3RPx5J8
         7qYA==
X-Forwarded-Encrypted: i=1; AJvYcCV0RsSuG/qDKC9SA1gerApWIgHZZ4TphysJLQS2bAZyt9pY9QmSE9f5iT4HhIaAZzhcc2+LOzeYvN/+pXUI6kg6Juo=@vger.kernel.org, AJvYcCVYtEPMT4yJa9WHgyf7rP1pwLpLrzHGzKuHLMtvxgIRcRCRXsMRZglpXYzpliS6mavqcrJZjAKIwzhA@vger.kernel.org, AJvYcCWMeMLQSVApRV0F8odPrJAhnDOXPNBdNb1cKLbpX6CTLRJnAT/HApHgrcpVZD2X/U4LjTG3OyPq4dLDOanW@vger.kernel.org, AJvYcCXphJbkmy1mvY+/AeanMM64UOF956H3NSMglj0TijQHuHZwDpB/a/rEL6H7ALeACMVkcOLELZDZ3/AB@vger.kernel.org, AJvYcCXxWJV2XHMUo8WU3MIdxlnXhK+voYBZgBqJ1wf3tM6VATGZ7Ymr+JNqrnugNRZEs/xOlMXLzNoeXgDjbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw75BbNDv5Y2EWo4pniwavgpPxJNY2yuWIvZsSJ8ojMKebBopl3
	foRXaxNgpN49cz54CGhAfaLIb8Avq0G9yUBaipuuXEU4sY5EJBmP
X-Gm-Gg: ASbGncuoKXwv51SD0EciZdymJQspn8CzFSEPTzf3rfY9S2a6gGQmoYvVHskK9jUmDTR
	FjfPyu9BZsLkLIe9jzq4MR9buz+XBdxm4ufCS+YXaMqC+GFbHWXezLbtIVd/uYVFYZtB0g/U+cR
	sexPkMvszc+SN9gL2/nidQnwTwk8OPXKHJoBVVy20XI1056gZNYbGMrRIb2QmXczehqsLyPpQPU
	U2rdYo1OwY7Y6q4ljldGPkiF6uhkJA/bpepGH/yi71XGNMgDE+l8eAsgt9ip9SJMpd4ob4XswQR
	+Z2sz84woM6ZTdOhDpa1m2ahX6CVxK9A
X-Google-Smtp-Source: AGHT+IFELQkBGEK3YIrY6vL2x7pgcre/YMocDwlofZQfU5axSRRV9108mGH1oEpDjZ+YLNE5cZW//A==
X-Received: by 2002:a05:6512:39d0:b0:545:944:aae1 with SMTP id 2adb3069b0e04-548510cf671mr29523e87.12.1740421931035;
        Mon, 24 Feb 2025 10:32:11 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545280ec98dsm3214737e87.42.2025.02.24.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:32:10 -0800 (PST)
Date: Mon, 24 Feb 2025 20:32:03 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 00/10] Support ROHM BD79124 ADC
Message-ID: <cover.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gHB9+0TKqLctmFZy"
Content-Disposition: inline


--gHB9+0TKqLctmFZy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD79124 ADC.

This series adds also couple of helper functions for parsing the channel
information from the device tree. There has been some discussion about
how useful these are, and whether they should support also differential
and single ended channel configurations. This version drops support for
those - with the benefit of reduced complexity and easier to use
API.

A few of the patches are examples of drivers which could utilize
these added helpers:
 - 4/9 converts rzg2l_adc to use helpers
 - 5/9 converts sun20i-gpadc to use helpers
 - 6,7/9 makes the ti-ads7924 to respect the channel specification give in
   the device-tree using these helpers.

patch 8/9 is small simplification for the ti-ads7924, and it can be
taken independently from the rest of the series.

NOTE: Patches 4...7 are untested as I lack of relevant HW. They have
been compile tested only.

The ROHM BD79124 ADC itself is quite usual stuff. 12-bit, 8-channel ADC
with threshold monitoring.

Except that:
 - each ADC input pin can be configured as a general purpose output.
 - manually starting an ADC conversion and reading the result would
   require the I2C _master_ to do clock stretching(!) for the duration
   of the conversion... Let's just say this is not well supported.
 - IC supports 'autonomous measurement mode' and storing latest results
   to the result registers. This mode is used by the driver due to the
   "peculiar" I2C when doing manual reads.

Furthermore, the ADC uses this continuous autonomous measuring,
and the IC keeps producing new 'out of window' IRQs if measurements are
out of window - the driver disables the event for 1 seconds when sending
it to user. This prevents generating storm of events

Revision history:
v3 =3D> v4:
 - Drop the ADC helper support for differential channels
 - Drop the ADC helper for getting only channel IDs by fwnode.
 - "Promote" the function counting the number of child nodes with a
   specific name to the property.h (As suggested by Jonathan).
 - Add ADC helpers to a namespace.
 - Rebase on v6.14-rc3
 - More minor changes described in individual patches.
v2 =3D> v3:
 - Restrict BD79124 channel numbers as suggested by Conor and add
   Conor's Reviewed-by tag.
 - Support differential and single-ended inputs
 - Convert couple of existing drivers to use the added ADC helpers
 - Minor fixes based on reviews
Link to v2:
https://lore.kernel.org/all/cover.1738761899.git.mazziesaccount@gmail.com/

RFC v1 =3D> v2:
 - Drop MFD and pinmux.
 - Automatically re-enable events after 1 second.
 - Export fwnode parsing helpers for finding the ADC channels.

---

Matti Vaittinen (10):
  dt-bindings: ROHM BD79124 ADC/GPO
  property: Add device_get_child_node_count_named()
  iio: adc: add helpers for parsing ADC nodes
  iio: adc: rzg2l_adc: Use adc-helpers
  iio: adc: sun20i-gpadc: Use adc-helpers
  iio: adc: ti-ads7924 Drop unnecessary function parameters
  iio: adc: ti-ads7924: Respect device tree config
  iio: adc: Support ROHM BD79124 ADC
  MAINTAINERS: Add IIO ADC helpers
  MAINTAINERS: Add ROHM BD79124 ADC/GPO

 .../bindings/iio/adc/rohm,bd79124.yaml        |  114 ++
 MAINTAINERS                                   |   12 +
 drivers/base/property.c                       |   28 +
 drivers/iio/adc/Kconfig                       |   18 +
 drivers/iio/adc/Makefile                      |    3 +
 drivers/iio/adc/industrialio-adc.c            |   89 ++
 drivers/iio/adc/rohm-bd79124.c                | 1114 +++++++++++++++++
 drivers/iio/adc/rzg2l_adc.c                   |   38 +-
 drivers/iio/adc/sun20i-gpadc-iio.c            |   38 +-
 drivers/iio/adc/ti-ads7924.c                  |   83 +-
 include/linux/iio/adc-helpers.h               |   22 +
 include/linux/property.h                      |    2 +
 12 files changed, 1470 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79124.=
yaml
 create mode 100644 drivers/iio/adc/industrialio-adc.c
 create mode 100644 drivers/iio/adc/rohm-bd79124.c
 create mode 100644 include/linux/iio/adc-helpers.h


base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
--=20
2.48.1


--gHB9+0TKqLctmFZy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme8ux0ACgkQeFA3/03a
ocVH+Qf+PVSPEXpY6uBYLMku5n+QutsoR3rKRhpzdBZ3Tj+hKJn8+FyCyt+2G/vK
5/D4Svsjq8DAF4yPWYmDk5HZi5zgofR9KWOmI/VgO6amTBx3bZEScWCoyj2i7VYf
O0XCQ06tXbm7nmotSiQkY7VDXaGhfZPMU3nj+xUQ84iZTbTPOI8Os8RiPfstISiM
cnfScD22RKz+5zHt5oqSBmZHB0jrWHzeXGZF+3gZQ6502STKMTfu76PBnpJkc56S
XbSq9SH9cH0jorWT0kYQyqc+7Bsv0SY9LwHP2ynDDmD7PBIF/sA2FbOy3Mk8P+54
jdNn0uGJKc5cEqbL6o1tg85PP6ztuA==
=H7qR
-----END PGP SIGNATURE-----

--gHB9+0TKqLctmFZy--

