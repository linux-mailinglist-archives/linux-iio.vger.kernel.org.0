Return-Path: <linux-iio+bounces-17216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0C5A6D4AF
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 08:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11CF7A27CD
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 07:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B552505B0;
	Mon, 24 Mar 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeSQS9Yi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587EE2500C9;
	Mon, 24 Mar 2025 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800352; cv=none; b=s1paD6thWQ4Gqjonw04W3ZPHjKpByRbS+ataUJbxrRZwiuN2JFx7wUbyOop53Dvb6GVUwZMCYeWAeVqGAArkY5koQ7p4zgKe6ygvIjBkd1kExPKKslcenLQ1wKUz6f7gdK4Q3GxPKA2M5nE3/jnpDiL6WVnaJ9UU5Tl3lVsTz9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800352; c=relaxed/simple;
	bh=xxsp+OscMoZLwTVJ4/Cttaosh9NZrmtqrfWjgfCbC0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DOQDNF84sJZWAKgop7K3xBClAcGBGGDUCePjEIaLD4C+2uG8aGsmDFao6S+tUXDFNk49OgfL1dzCf1ZVKRrjFd7Pvqnvv8w2QkYLYkBfHMRHvEz0aNjAWp8nrp0MYxrQRfoFJKMCmO5s6sbxwTI8Hm4lapUNEsegLR9aOqczkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeSQS9Yi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307c13298eeso46357271fa.0;
        Mon, 24 Mar 2025 00:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742800348; x=1743405148; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sowTRCf+Tb5j3/bsFU0jjdH3gxVyOrbSH7sFKvyOG64=;
        b=WeSQS9YiEHeOGxJNW9vkxkffKcNfpHT2sgHbbu3wedLpFZ1w/wzFdumQPCB4pOgLzM
         hldP1r0ncQCGbQBBtAlUXpnE3byfxLehRJZU7h6V0gMLdXIAeDyKpCG02ntWHCsNNa88
         l0gVNfLLqAKvTpEwVeKB1B9df1kifWqQvvmNom5DdheKCm2iLGyybQQrvDws6084O6Md
         ZnqCZAi4o/jYQUFnb0XOLWL48+POM2uqFaT4tYXEIsY0xAz32r+GeNOdpFhuYhDIFY2u
         FTDk1R7btTdUcUn00H2R/4TeXhQeHAkyE07zVW9dC1d3417uDXQ8YoPzG+aiFd0YjAZv
         uL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742800348; x=1743405148;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sowTRCf+Tb5j3/bsFU0jjdH3gxVyOrbSH7sFKvyOG64=;
        b=crUbHmvK62U8gQevQKxuubm+8r1qN14gC3rBeIzMc0kwt9hO0RNFATimiU6O4PF8Jf
         tZNPndZKfx9YT6SVE86khVxFmzmZfQZAz+6mnxI0A81A6hRmorQtU5qHZwSZ6JTVMAbT
         kk0jx47l3yxI9IaDgm8UOEAx+ToB92cmjFyClUSOk0XEzorGppSrX1I3r7l7xUFMOsDz
         BKy/KW5CwbCEiy1/M3KmCdFplUVWEVyUOssSRlLsvVPLd8ERpxz1axGt8vb/7V0PuM3R
         7JiQj0ixde5vlaJnBOuJE/Nsyc7sa+CS+P5MKqruZNt5ZlxcW0lWNYNNYBpiLXXpUK+W
         VpfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDb3iwLDomehZ8LfNJCnc/plVEVCmUqQlZaNyEWLtH3hi9RejR29WPCxFJfT1ll3OHmnWJ4D38K7Wf@vger.kernel.org, AJvYcCWK1Sb4i8cv8Tsy1wlBEl6RE+GpDA8FbCIDrledceBy69gw2CXyYPIGyfqxHclP3sOLBuIcye2HR89e@vger.kernel.org, AJvYcCWfPxNNK+QxURYs/M3H53nGU3VFbayxQ4q0le0TZDnH6bn1zINjGsRIblzzTHyYxRvwI00F98KAO1HW7g==@vger.kernel.org, AJvYcCWzI5Cm+62h+IndJkz+o/iRX6/pzaZxwR8bg8mSTaX0KuOaQPon0ejr0pCNloERE77tRjvw1ru1XDHf4Q2K@vger.kernel.org, AJvYcCXXghqBQgS/E1F1/Ys6+6MHICG46o8Tx1my7kBCPgKEI19jMhqLl2hL8iK9t5PqlxnWtBo47Eki4U+tDW5P3l1n25U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOkCg2C2lZKobPrTHpMdO/mQ0gKCIXVid5gsjuRCFnvdMjA0I0
	V4D5m/4Cb09TQtRXAUu+cXeXeM3wvnxC3RSDBlbASSYOGxW0vPNB
X-Gm-Gg: ASbGncuM2ai6D5TiZH13f8zAFMqSRfYWWQGJwydEOGjUUIOQ0dmcCuUUw9JyNB3zri4
	aPDqSK1iyrSLs1fe9Rn1AF3WBW9XbMvm+iC2CD8uM5btMqUJnKnBB09o69zoR3Uc9L2u3I/q2wL
	/yO3WVUu9CDe7NCK5VLuB4KQC9SNHhBF7Yz/Megcu/BWW/CeyTnbApD+KAyXvKMOJj1GrsRZRMk
	GEStVjRI7JVAcGJMCeBER4TQUibqmkB3k48B9QvK+4idb6taNlUobzslU9vS/5/Q1MHPGLbxlKn
	eGoMXuegLDOFNq85psde9bMWhEj4e3kY6ezVWeuKiYRbusKNUKw=
X-Google-Smtp-Source: AGHT+IEnPPDATgowgnImDNLSvusoM0BTZl2CHm0V3kdZ6FVCrucX9v/2JU56loHRJqHxxkYiE05MEQ==
X-Received: by 2002:a2e:6817:0:b0:30b:f599:d78f with SMTP id 38308e7fff4ca-30d727317a3mr56663871fa.7.1742800347972;
        Mon, 24 Mar 2025 00:12:27 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7c19c3sm13336481fa.4.2025.03.24.00.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 00:12:26 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:12:17 +0200
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
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v10 0/8] Support ROHM BD79124 ADC
Message-ID: <cover.1742560649.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x9LRqC/eTzOvp8+V"
Content-Disposition: inline


--x9LRqC/eTzOvp8+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD79124 ADC.

This series adds also couple of IIO ADC helper functions for parsing the
channel information from the device tree. There are also new helpers
included for iterating and counting firmware child nodes with a specific
name.

The rzg2l_adc and the sun20i-gpadc are converted to use the new ADC helper.

There has been some discussion about how useful these ADC helpers are,
and whether they should support also differential and single ended channel
configurations. This version does not include support for those - with the
benefit of reduced complexity and easier to use API.

NOTE: The rzg2l_adc and the sun20i-gpadc are untested as I lack of relevant
HW. They have been compile tested only.

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
v9 =3D> v10:
 BD79124 driver fixes as suggested by Andy:
   - Use regmap_assign_bits()
   - dont change the mask for caller in bd79124gpo_set_multiple()
   - styling

v8 =3D> v9:
 - Drop the gianfar and the thp7312 drivers from the series to limit the
   review noise and to simplify the merging. They can be submitted later
   as separate changes.
 - Drop the fwnode_for_each_available_named_child() as suggested by
   Sakari.
 - BD79124 driver styling and fixes

v7 =3D> v8:
  property helpers:
    - Fix the example in fwnode_get_named_child_node_count() documentation
      to use the fwnode_get_named_child_node_count() and not the
      device_get_named_child_node_count()
    - Fix the rest of the new macro's indentiations
  adc helpers:
    - Treat 0 ADC channels as an error in
      devm_iio_adc_device_alloc_chaninfo_se().
  rzg2l_adc / sun20i-gpadc:
    - Drop zero channels check from the ADC drivers using
      devm_iio_adc_device_alloc_chaninfo_se()
  BD79124:
    - Use unsigned for regmap values
    - Commit message fine tuning
    - Check devm_mutex_init() return value
    - Handle 'ALL pins as ADC or GPO' cleanly in BD79124 driver
    - BD79124 styling / typofixes

v6 =3D> v7:
 - Inline device_get_named_child_node_count()
 - Fix kernel-doc for fwnode_get_named_child_node_count()
 - Minor styling fixes
 More accurate changelog in individual patches.

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

Matti Vaittinen (8):
  dt-bindings: ROHM BD79124 ADC/GPO
  property: Add functions to iterate named child
  iio: adc: add helpers for parsing ADC nodes
  iio: adc: rzg2l_adc: Use adc-helpers
  iio: adc: sun20i-gpadc: Use adc-helpers
  iio: adc: Support ROHM BD79124 ADC
  MAINTAINERS: Add IIO ADC helpers
  MAINTAINERS: Add ROHM BD79124 ADC/GPO

 .../bindings/iio/adc/rohm,bd79124.yaml        |  114 ++
 MAINTAINERS                                   |   12 +
 drivers/base/property.c                       |   27 +
 drivers/iio/adc/Kconfig                       |   17 +
 drivers/iio/adc/Makefile                      |    3 +
 drivers/iio/adc/industrialio-adc.c            |   82 ++
 drivers/iio/adc/rohm-bd79124.c                | 1147 +++++++++++++++++
 drivers/iio/adc/rzg2l_adc.c                   |   39 +-
 drivers/iio/adc/sun20i-gpadc-iio.c            |   39 +-
 include/linux/iio/adc-helpers.h               |   27 +
 include/linux/property.h                      |   20 +
 11 files changed, 1479 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79124.=
yaml
 create mode 100644 drivers/iio/adc/industrialio-adc.c
 create mode 100644 drivers/iio/adc/rohm-bd79124.c
 create mode 100644 include/linux/iio/adc-helpers.h


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
--=20
2.49.0


--x9LRqC/eTzOvp8+V
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhBc4ACgkQeFA3/03a
ocWangf+NI4B0saJ44yhPgbEq325fSJhMOfkikVYiNQDzf5tPKqdhE3H2+EJitTR
Q3uQ6HF0uvIhH+sVBIPZpFSDeiS/80JCyyaeXyqaIaAwhyrctLf8wJ0Np8M/c7kt
kNdnEQPK2zPPSEurLI7f6GmskY71NXfH1Ogdtve32GfLvm89NIPwolg3MmC43/T3
TteJLSflBgs8HLarrggxMuz4sW1QSIp8My2iIim9A4SKfeHh6VabjqVx1Pgt+9Pd
aRVXRV+j9OpBkvViz3602kp4TWCGnP3/uJSYGPPaqdFUPD+9ylptoTPBW9e8ZbbT
ak6Ih1C9yZ6LE/GY2JLdRu+3U2vhpw==
=yHBg
-----END PGP SIGNATURE-----

--x9LRqC/eTzOvp8+V--

