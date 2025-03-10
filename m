Return-Path: <linux-iio+bounces-16664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4B8A59538
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 13:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5041673B8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 12:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834D229B05;
	Mon, 10 Mar 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHj/jkXt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B313CFB6;
	Mon, 10 Mar 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611244; cv=none; b=Cl9CGpWValorp0uT0IKkzW5O7ae6+oe5pBpuD+iAlJCc2GwYds71ZKr4osCWh0ONCqq/i5pHmTRv/6BQvD6sTiswwjhOh4rj4HGEpc7QWn17XUUkLCFHtCLi6XuyvjsAbQ84qyD1XCSPlaVYpQSMhZB94QXAQBng4aGwzl7CpqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611244; c=relaxed/simple;
	bh=mKOW0y7H+d8JdihJ/mXGS3CisQcR/M7PjYl0QDlLLdI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AO3ZTjEo7wdGQJS0iA3dnwAAEsd9W+Ck1PsuenbNekgSSv3aoA7quaGwOqI3mi1gjkcpyf6HaL1/3nqn44Gj+yqwiJ/hjYHmxUgOecApIo/HHAbnChEux+RJGEnmD8hdo/xppXkqHRDf5iDB+4oM8p5HxX87Gf/EYXeh6BM+CQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHj/jkXt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so1714758e87.2;
        Mon, 10 Mar 2025 05:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611240; x=1742216040; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=URGQNwjZdhyHI49nCxv8neX1u2OWYbpIKZ53BGm8OOk=;
        b=mHj/jkXtYaHMWlgpJi52YNbMlDpZr+4eB8Dzc5p3PuUzuv5oEzdQKTX8xQffcmvxlL
         2+mpj0jMWtenB2+GHvPDC5aZvNiJDxTOizvK4H92o7cHcUSpEogcJfQzb7LCN1u5OPl4
         zkwr4EjkAa7lrjhdWPadebKyXhWhLBGRRrqI8Rj7Csa1gXRaOUD6PhKc6SY+yj4DnMuQ
         m+0Z5uz5Ydk1xxEdi6XpG49IygE3+GNZFswV4z5UVhPwDXeKqPCvxMW5U/RJD6UPZdvQ
         5hVI65W3zed9UJ9R9tE3YaB4PxmJFUq2U3tyggk1T7gIXwk1+WsTdJLsaCSzNoucWyAO
         +/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611240; x=1742216040;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URGQNwjZdhyHI49nCxv8neX1u2OWYbpIKZ53BGm8OOk=;
        b=mEAz8vHwB/D6C4YVrQS9uZwKQjpx28Cpdr+oV3RtzAgS0410zi1/t8IOVK2nbO4l/1
         W2yhrcqnxW5bTY6HkSuf4NdqfQivsujTnpg48m/a43obufLpAgmIlV0wqx4UrKIJreHh
         qq3lYmkEMp7hcfyqfwibfAGTTyLNpLXvxtlqK3h+WA0/xXoh8QuAWBdT4kHhUHCgDbzZ
         MxgJZDUFo24bT2LkfDDXUZTspkpH7jjeepuF9rr6WfmhlAv8rGkMfZRaC01ccfFWSCfD
         Dbsl3MmhrYchyv1b/tbqk3bmGUOOBGdKxRoKgEdJRFJiwqCHNzTUHvRIwFvn2bzVWaXt
         J5ug==
X-Forwarded-Encrypted: i=1; AJvYcCV2IJjYbNouNgNCwEowIL5pDxvFQ4X4hQ8s+QqQOSGyVKaGXZ4QEoL7JOz6wlNKLs6XWpX32GaMNx0HIw==@vger.kernel.org, AJvYcCVXuNy2apPbeZkeKwZzfDyMF+8YTOJUchnTQ4jGuxRuV3NMV1fjAcHhi/tzRDEaoE7XTZXUaWW7J3UNQyw=@vger.kernel.org, AJvYcCVlDGx/SglJwPqTveY82X7ngvy4i+eMsWLU/OjB4zgIhrGAxPxhtFOtrmBAXXRockhAbbHB9FsaS9/r@vger.kernel.org, AJvYcCWjaWK7foFSyQjkGvypl5ad8v4wd3fcEQs/s1H67rTcigyjCl4sRdbqth9yE1PsKWa8w3Q6I0HDejdRTJd55sSa5P8=@vger.kernel.org, AJvYcCWuHY7K0k1TKNypc8BhEPBK+LIZ4l0hQzy08dcc2NQICHRPa2h5WIY6qD0Htrp3uSJUUTb6VSaHaPRB@vger.kernel.org, AJvYcCXRmy4PkjcUqrCUZzq+RIMpGqep9+qKnAVuhEBJCz+ZlhI3BonluETNY4v5AYVnukb+XmVSbg1i@vger.kernel.org, AJvYcCXze+T9XCzsbi676opRx133elnyeVxXhQT3QOUXIaADgQcpzJh3YTnp9q4dVrv71nB1QkmLekbXRmF5J6R9@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCBbj3u8MpfgT1zwLnUd8vBycGr1BzVUoQ1bHB+/cYJtAQcfi
	14jA0WZjmCdUqkrM7ymjpH3sNefvOBr8UYDiSVhYjsYDom5dWc6O
X-Gm-Gg: ASbGnct8/ZKDhLQpiAG4rzL9s8k1zjx/EKcNzRgt/Juz+dxcM4+z4TYc2NaMXo9AWe8
	yMKLYwSExIBX5quZSLkC7TvspahbfgPgZsWjX72doQAvFEHORkx2fgfMXImVxsntM+8BF8MSymD
	DLw9ZdBYeXeNCWFEIZJUj+wQznfpglBYl5vbTxYnzLJAOeIfNjKoe4GYK4K1GpZwm+qjhmX+G7J
	1n4oVG8MoNUXVbAi/MrAhljZ5wZwLqHALZdVpibExmK/47z/l795IRZS20RixLz2UsnjFxh7pxy
	2taM+bBw77ZEqMkjhwCj/dFS6/rlc7HafDR4nu7vE/GnWLHduH4=
X-Google-Smtp-Source: AGHT+IFA0RtQIyW+e03BOnWNOQUvnrcxE5yBsLBwjPqTi5ZfcZSG1+DhL9uQlcM6UFbaXZyVT+qAtg==
X-Received: by 2002:a05:6512:2342:b0:549:8b97:75f2 with SMTP id 2adb3069b0e04-54990e2bdd0mr3668356e87.1.1741611240055;
        Mon, 10 Mar 2025 05:54:00 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bc4basm1458604e87.164.2025.03.10.05.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:53:57 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:53:50 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel@sholland.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>, netdev@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-media@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, devicetree@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-iio@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Lechner <dlechner@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v6 00/10] Support ROHM BD79124 ADC
Message-ID: <cover.1741610847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="muBpqT72KPU1YOIU"
Content-Disposition: inline


--muBpqT72KPU1YOIU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD79124 ADC.

This series adds also couple of IIO ADC helper functions for parsing the
channel information from the device tree. There are also new helpers
included for iterating and counting firmware child nodes with a specific
name.

Series does also convert couple of drivers to use these helpers. The
rzg2l_adc and the sun20i-gpadc are converted to use the new ADC helper.

The gianfar driver under net and the thp7312 under media/i2c are added as
first users of the newly added "named child node" -helpers.

There has been some discussion about how useful these ADC helpers are,
and whether they should support also differential and single ended channel
configurations. This version does not include support for those - with the
benefit of reduced complexity and easier to use API.

NOTE: Patches 4,5,9 and 10 are untested as I lack of relevant HW.
They have been compile tested only.

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
v5 =3D> v6:
 - Drop applied patch
 - Add *_for_each_named_child_* iterators
 - Add a patch converting the thp7312 driver to use the new helper
 - Styling and minor things pointed by reviewers

v4 =3D> v5: Fixes as per various review comments. Most notably:
 - Drop the patch making the TI's ADC driver to respect device tree.
 - Add (RFC) patch converting gianfar driver to use new name child-node
   counting API as suggested by Andy.
 - Add fwnode_get_child_node_count_named() as suggested by Rob.
 - rebase to v6.14-rc5
 More accurate changelog in individual patches.

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
  property: Add functions to iterate named child
  iio: adc: add helpers for parsing ADC nodes
  iio: adc: rzg2l_adc: Use adc-helpers
  iio: adc: sun20i-gpadc: Use adc-helpers
  iio: adc: Support ROHM BD79124 ADC
  MAINTAINERS: Add IIO ADC helpers
  MAINTAINERS: Add ROHM BD79124 ADC/GPO
  net: gianfar: Use device_get_child_node_count_named()
  media: thp7312: Use helper for iterating named child nodes

 .../bindings/iio/adc/rohm,bd79124.yaml        |  114 ++
 MAINTAINERS                                   |   12 +
 drivers/base/property.c                       |   54 +
 drivers/iio/adc/Kconfig                       |   17 +
 drivers/iio/adc/Makefile                      |    3 +
 drivers/iio/adc/industrialio-adc.c            |   79 ++
 drivers/iio/adc/rohm-bd79124.c                | 1106 +++++++++++++++++
 drivers/iio/adc/rzg2l_adc.c                   |   38 +-
 drivers/iio/adc/sun20i-gpadc-iio.c            |   38 +-
 drivers/media/i2c/thp7312.c                   |    8 +-
 drivers/net/ethernet/freescale/gianfar.c      |   17 +-
 include/linux/iio/adc-helpers.h               |   27 +
 include/linux/property.h                      |   20 +
 13 files changed, 1471 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79124.=
yaml
 create mode 100644 drivers/iio/adc/industrialio-adc.c
 create mode 100644 drivers/iio/adc/rohm-bd79124.c
 create mode 100644 include/linux/iio/adc-helpers.h


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
--=20
2.48.1


--muBpqT72KPU1YOIU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfO4NsACgkQeFA3/03a
ocUrtAf6AkAaWL1Jnt8D97sqQ8s0urKuXJ/Emcn098LL3HXfpGZ3oOnkjn8mfJAa
Ic6x2BRQXOvDu/hzU3JAm3mPKKFi0Ksp/pFf28GP9hKetp3mmL6juBUdRJeNzNPN
BqAVFgh+GGv8UT38XCSI/7+bh1i50mU+t12fCDl7m+vXEYA237ulDTN1wWN+Jhd+
HpAjCsUj7hqY2HRHGecTzWMFGXdjZFGJJzxgqnuo+D1e000IkpHx9/9jejmHPkUK
ADeKqj0nQCp2LV/Kx8r393w9/MmpSBOD93cjCjHeN6OizuKvesExCkZUJA9BvvaE
giS8zbsz3QJNWA1MoPkbsNQ26lL2+Q==
=+1Jo
-----END PGP SIGNATURE-----

--muBpqT72KPU1YOIU--

