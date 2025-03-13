Return-Path: <linux-iio+bounces-16764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D46A5ECA2
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 08:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177771898DAA
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 07:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45411FBEB8;
	Thu, 13 Mar 2025 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFLzIlhb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B700CBA53;
	Thu, 13 Mar 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850234; cv=none; b=jWepQgU3XmAAFT262VFDKZhB0eAvz1nTruKPSiXe+S11TVf8qcjOHSnmYpI9ihv9kVYi3qD59TCnE2LVnHfJHnyTI1NOEAp+D7VTD2ZyJYozqpqmpXPQD+VgGWPSiziUMSMMAHvywQyldo1z0apCIknE3voQVBUqyzc9eCZN8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850234; c=relaxed/simple;
	bh=naI9JVR3MUeCMddBWDH5dmeWuvYgRpMlDDy8bd4HaCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FtdYPSJiGVbhemJMSn6Z/tJmU9D0u3apyNPcPiuqfuFIKWmqtDB0aiDjhffhGF1eJPosvTqOC7E+8iFbAv9kV+2RKWEVFFOoQDWEPc/qjp0WTqDxmPqr78XWhFn/qsudZnvt5CT+1MEzdfJ/REDx4nvd+MBWcJwR/QA5/PSzv60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFLzIlhb; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30beedb99c9so6066241fa.3;
        Thu, 13 Mar 2025 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741850231; x=1742455031; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5WHcmvIMGQWDWl3ITE+2vt5egvOVi0st3Z+q7JAjLI=;
        b=iFLzIlhbgsp2mP9hzhsrGQdWbY0IaQAjYAcbIVZEz1PWgB0EjIB8C5mZEm+eY0b16D
         J7ai9Su9JLQzUM/FnjY4EDEoeBqk+e/1+OtBo3AhKYywectHkAoJ8NiOgttqcl1kK5Zb
         faRDbQ5ZHuS+2+aMsPNQMzFkkMp9ZUf5LnJH7oglvmnxdRxV3D9gprmTTeRSgJkEndb0
         taP0KH3U9gIe+aOaQqFfXdo97Hpkq1BUKb4bpIAWwPPr+2FnbdbSxTJg57I443y1jXtu
         hUdsgE/YNmNwbquSoHqHZR7GNl823mHMa+umkkwBXhhZXzHWu4aqbNgHmZg9BFRQNrDd
         QR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850231; x=1742455031;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5WHcmvIMGQWDWl3ITE+2vt5egvOVi0st3Z+q7JAjLI=;
        b=l8Uf79jTM6Ggz7U5xRkOXWKVArmAKm+mhFEkBhzrjKlDMbQWdfefIXtwy6Pax+1NqO
         bLsNgr5yt+4ihx2mgkuzDrX8Kki/gdgBXyYBPNLz9xZ8PKbHIMc5H9xnJ+7I/W147loN
         SBlCa7B0l8kWFs82Vt/0ZYLXR/homdqqkf4vYPW0l63nf5VK74H5DwApAln0kTy7Ns5D
         30Y7Tihn0/I4J5NeRhNSDpS5c4Ec6ZWfnZb7ibH6CxT2wROhCsABJ05rhyXs+yjZhFGf
         8glHhwDZG/X0NpvgvXFjWwdq9bkphgxtkDmsPJALdSGD8J5dXBjXgOdczJIRUeTJ8E2Z
         746A==
X-Forwarded-Encrypted: i=1; AJvYcCU8Itmbf5u3wzZleCs0FldMTOB8NTQSF8BPhnERg0Be0WAj3YfodUmmjpGKMRFtdqicuNOvnN+E5sek@vger.kernel.org, AJvYcCUBk7ICuc7EWrHmhCpDqk3ysfisdP6WZM/3Na8rDS7CDLEhP0VnxBxwYejxjPENlAegZiYO5BPmuN3w7w==@vger.kernel.org, AJvYcCWS9LOFxYJrYg8tcOt+Oivog8ZfEs6btqDg43PGhQbOrV1oBrNAFDLXjB0O4Ap1KkSYaQeCuUa5@vger.kernel.org, AJvYcCWdFMN3yfziOFXjHRlBK6QoSn8lua1UiJQwtY+VKj41BB7iy6M7fLVpDTTl942BiPSWdfpHM14PeO84OLg=@vger.kernel.org, AJvYcCXA7q3YS/78LbbqCR+yaxjJ4OIQdkHSUXkhJBssMEqfTYvGzhtO9f1ZPJnIQ9imLSq8jT9GQDNXmtVnPxDbNlPR6dM=@vger.kernel.org, AJvYcCXGnZZJ3/1S5NQQfYkl3tgnTj2DWrBbGcjV2eEhOjRCFFMmL6Vgt+RJVJCzqH6wcdaWlknmagAbrgNmiYnS@vger.kernel.org, AJvYcCXqQpPBLNAmJQ8jhlSYKbH35OInp+cAYDgv1XS/T19XeNmxYkuNOpBJ/obntCSzfTPWxD+g88yLKqfE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7L2V5G8a5nWuisVdsApehjlT17DFJNpkwodSdHq6WLoMYIomh
	V+MPVRCevZtFpvDrScqSVLdEkeM2RQ0nAuSLQ7MYOa+ekQmuLS6g
X-Gm-Gg: ASbGnctEdDnTFTi2CDuK8ytxPJDH+qut4Hcv047SyMuCNpISqQQF5yG6HzN3F5vthae
	npAHKlUGanhrfz4IiC0tT9sfhCp+Ogjzd9vZTwf7PBlnyCC/my6LXEV3yJPYpi04aBhrs1zEX+g
	2LTGzQ0jHoH0ax2HzFAy1+x8Ku6quUac1IgzkbF2U6JOzeVYMDN0hPJBwTM/fXdt1ay8WNolm8+
	4fBZiqqmGXcIBVOY0ubB00gitF8UHt9oO23a4AayeWXJmybFI5M2hdklaYyGSGwfvhY3MFt8EI6
	ZBCOaxZrNwTh67aY3X0BXx2PI2CCv1DyoAptWE9EW+O9Vgm9Y1nIaVVo66zoAA==
X-Google-Smtp-Source: AGHT+IHx3X2FqctNBmr2hZceebB3bJJVXoyrN9cDqpAfPu3OVpvwfWDgftPDLFysrAbjWyTNApS5UA==
X-Received: by 2002:a2e:a7c1:0:b0:302:22e6:5f8 with SMTP id 38308e7fff4ca-30c206c0ccemr44055391fa.22.1741850230372;
        Thu, 13 Mar 2025 00:17:10 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0d2574sm1227071fa.7.2025.03.13.00.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 00:17:06 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:16:38 +0200
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
Subject: [PATCH v7 00/10] Support ROHM BD79124 ADC
Message-ID: <cover.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7xzkgzh6Rt0Ce+oi"
Content-Disposition: inline


--7xzkgzh6Rt0Ce+oi
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
 drivers/base/property.c                       |   27 +
 drivers/iio/adc/Kconfig                       |   17 +
 drivers/iio/adc/Makefile                      |    3 +
 drivers/iio/adc/industrialio-adc.c            |   79 ++
 drivers/iio/adc/rohm-bd79124.c                | 1107 +++++++++++++++++
 drivers/iio/adc/rzg2l_adc.c                   |   38 +-
 drivers/iio/adc/sun20i-gpadc-iio.c            |   38 +-
 drivers/media/i2c/thp7312.c                   |    8 +-
 drivers/net/ethernet/freescale/gianfar.c      |   17 +-
 include/linux/iio/adc-helpers.h               |   27 +
 include/linux/property.h                      |   24 +
 13 files changed, 1449 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79124.=
yaml
 create mode 100644 drivers/iio/adc/industrialio-adc.c
 create mode 100644 drivers/iio/adc/rohm-bd79124.c
 create mode 100644 include/linux/iio/adc-helpers.h


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
--=20
2.48.1


--7xzkgzh6Rt0Ce+oi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfShk0ACgkQeFA3/03a
ocWNpgf/TG9MRdXix3NCy8/EzhHwwwGPzHkZu844kW+j84Ro7p67BMd87uiY6kj0
SWfT77vNLXFXNhHhTOGYXjdtLxaXsmqWCOBzmafT93NAXmBIE/Ypis7uSZe0xmRc
hAzDEhE0bHEaLzu+Dlln4Ud6wc3wayHSbGDx6810Gh6JQpfbdbY6boyE3F+5yy+b
erV2JcPGKfjMfQVeVy4kIXHrjeTphelK6HIwS64lLSkzDsL6V4oMkNThXpFG27t7
P94a2cMBiNvX5g55O3VusaA5uyN7ab1uETa1jvvI9e8liARAp31nkbXJCuLb7AKB
56rkfS4sM+2R7cLBLSxTqts/5xjWVQ==
=laFK
-----END PGP SIGNATURE-----

--7xzkgzh6Rt0Ce+oi--

