Return-Path: <linux-iio+bounces-16373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78660A4E8A1
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 18:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA894188A961
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 17:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5922C3779;
	Tue,  4 Mar 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgzDSHC6"
X-Original-To: linux-iio@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4FE2C375A
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107488; cv=pass; b=CrSFfPVonukrVfe5ypW4pOik9aHJhwbOKuCqPC0h5vmvE52JYEco7EagU8A7iAs7m7fxVAYFn+gjuVw/uzFgxmAvyqMymWQCU98EsUy6zx7DeOBImE1W0iQIAZbbGcqTSuDFIzLTyRKyklch6YY5kBbBItEe2VuDgpRtznFMFd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107488; c=relaxed/simple;
	bh=uE+73JXciPA+V7kPRV8XWL/c5IUQ7yVFJ3PFc8BY5Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QHA0a//vaAQ6bl2YhkrOcO1G+tdg9v1+6GrlyRp16rhkhUFyIO2470AxtnSm+7WotgYP0AspMusqClpgzdC+RyeMuCStFSyTXMJ+thTJrHVdhgkFWvQCWPxmZLd7Jp+W7m9IgjMDlNKUV+8VQxA4Zxq8kcpt+rqXPQ/2ePXWzdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgzDSHC6; arc=none smtp.client-ip=209.85.167.49; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 2480B40CFB88
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 19:58:05 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VgzDSHC6
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g9r5DrPzG1T3
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 18:50:08 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id D9D1242734; Tue,  4 Mar 2025 18:49:48 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgzDSHC6
X-Envelope-From: <linux-kernel+bounces-541583-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgzDSHC6
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 9758641EFB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:31:51 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 6416E2DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:31:51 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FC31887A9C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1091F8917;
	Mon,  3 Mar 2025 11:31:22 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407201EBA14;
	Mon,  3 Mar 2025 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001478; cv=none; b=G130xr74T8i879vQJBGhEYWuhB4EMXxCjybPdt+AXdGtznvWGR05bAE2ZybG6fxTlSiS/aUT+G1A4YbP0QSkHr8HBo1zX6E3a35Ngv5TaE4hrdkQXRM77UIE5y+RdYDYDNBRuXko1H8xG6pZcGvLb1Z7sMsgVriD/J5fl2Q3PrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001478; c=relaxed/simple;
	bh=uE+73JXciPA+V7kPRV8XWL/c5IUQ7yVFJ3PFc8BY5Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kPSkUdd2vtABH+86fPN8AG2dbCZxbuYExGnj2QLwbLxa5uLav7EH42V3YZKoGfgN7pc/qiwy45zM/q6+h5vLLCjQv1mMaoMGo2d4S+0HxgszPFyTkWbjrhk9ldkmMlOD3Iy4misn4XS6isDI5WhIRI+bjrIFTMky11JskDgcm5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgzDSHC6; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54964f8ce4bso1070054e87.2;
        Mon, 03 Mar 2025 03:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741001473; x=1741606273; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKXywdzc/Et4yJtFDduOL5DqpXRTEQpflOuvO6/QFtE=;
        b=VgzDSHC6Sa9fz+6hYG3hfQpXF/2dBZOiDvFK+N9GDY8aEPkkZhkif5qvqC0VbXs224
         UPP8K/RtRodLhr2+9Su360phU2g/7vqrus7OSKd9dZ0fFAhar5jY6IrVxWsBdFWwgWjV
         IZUQIiHcNXfDDnlJR4zKljtxLlyQ7aiP/qw9vIc84USCGPpEAD0fcqvTSs+tyepKc3dr
         P1lveO7+c99orZutbBINfxitWPAbLKrDrB5byswiXHwyC+3TB3+KbQZ1WrYA/fIZMZnS
         RJj3QuwGdwOAI4im4vI2rLU+rbM89mhXwpk3YlgvND398prdd4yUhUYnTfFT+Oh5Q2mh
         cIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001473; x=1741606273;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKXywdzc/Et4yJtFDduOL5DqpXRTEQpflOuvO6/QFtE=;
        b=PUwa4tPhULuRV/5VFWwhIK2SjrWdaB8kF0BlEboR17Z9okS2o9g3DsY1dM6lkK1wZG
         lP5VZ7eF+D7a/SZYP8HyxKoutI+trBsw6aOGulzyKmiXX2R9jXXBtacmG/e/a/Z/qSP0
         HuRAiKZO+2coL6EhFunrfDDT8nZLGe+CNmnH6pJoyeD26d6UGCQSYaSstBMbgS17/2v7
         5BtcYuzFT3eGGqKP/uf3PemgCDKkA4Lr2UyfiRzIRqy007c1dDHMRF7yRogdMsiNvOIr
         rMapd+QSUiahDuAg3xEA0zdjaNLDqSIPkbo3qwNg0OxdyPbuPyxwEi5bNdtMWl4zkKzB
         wdaA==
X-Forwarded-Encrypted: i=1; AJvYcCUK3HRNM2ci7pQ/5m+R9wDjpQV3e+mO080sQFA0Q1olQ4JVT9VThZpSwAIe0Lj9xXMecxXzzjYRyP5YTcssaGmjV7A=@vger.kernel.org, AJvYcCUh5wilUuU2Ddt9075lSAe6vCLQLkJIIwO21u7sw8OUAL7czs5SAMpX9nI0nVwLgYlXcoNdvkH4bYjf@vger.kernel.org, AJvYcCVtJAkgylMRJD7CbS6EfJTADgNMUl2/QhecUGLH5NoTeHYARR/uJkmATaN9RGRD9Zp3Ir1rtOnYAtdg@vger.kernel.org, AJvYcCWMZx08vv66tKf5QD3WpbtIhoulkZvbDD9zhRlEgfVpts3S7P3YS9YVkk8/a6oYzK3+tSEY5MilwPWfww==@vger.kernel.org, AJvYcCWPFtO7yUalBNXnhVG5zLlxz6X8psHt+h8bq6o58OOn3flkvzybsQFNxZQ/kGhx2ksvyypHje9s@vger.kernel.org, AJvYcCXC5aJTjgefVoLvuAZamwgRSpmquNtqNDctTP3KquMP9owbMXXTTCUSkbRDlWmmms9M5nVy8oXJbq1ltzT0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SzPxh9Ki9Cbvh2GfKsmT8zNE26BzbbEf9UaiybrxtowjI5Ra
	jtpRTAXe78qGbV+ommlDAOz7gIDP5TQ48cI1Zspj2PWZxwzOA5Sa
X-Gm-Gg: ASbGnctVozXSzhFC4dGVDJOOL0B1cH4brC8PPAYd8/id6uvMcmTEHPraclVqSXX3bKi
	qEVO4BmIXKs6HrkAfqt4xcaTSByqTmRWj0PuZryJtV/+AQpTSuwdb1FmMp9GcF2qjCztKSx8SuL
	89AgNUNer8lkajLBhzaDaiIQO8H1cA//awOHCYwtJ1+7RKl2IF1eBb+qcSVTElqOt7P2hI25k0w
	ThaaHY1/nIN3mB8o3E4Qd+8Ea8Dz97H9YSVEyVJwhrgbEfo/2UqoMMcTZtKt+czgROMZSSR9/Q5
	8hwYbxHhprHtJVvL9YzZGsIfRi1MSUHloc6sBzykBUhxIb/0BWSkdt8jxJrsqTYpLkhP04+kRSP
	5UH1YDCPqlyk=
X-Google-Smtp-Source: AGHT+IHy7eVfyRfz75KlXzMg33WQpUvOMs2XoHaFWGcBRo3/jfRN7pYYEQKL0JaanfwqklYifmbf2g==
X-Received: by 2002:a05:6512:3c92:b0:53e:39e6:a1c1 with SMTP id 2adb3069b0e04-5494c38bde7mr5379294e87.43.1741001472861;
        Mon, 03 Mar 2025 03:31:12 -0800 (PST)
Received: from mva-rohm (mobile-access-2e8451-125.dhcp.inet.fi. [46.132.81.125])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495cb976e7sm595497e87.56.2025.03.03.03.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:31:11 -0800 (PST)
Date: Mon, 3 Mar 2025 13:30:59 +0200
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
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH v5 00/10] Support ROHM BD79124 ADC
Message-ID: <cover.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ok8G6d4pd5Kde/Tf"
Content-Disposition: inline
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g9r5DrPzG1T3
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712173.21698@ZcfxoNyQUCQFcUf1HADVeg
X-ITU-MailScanner-SpamCheck: not spam


--ok8G6d4pd5Kde/Tf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD79124 ADC.

This series adds also couple of IIO ADC helper functions for parsing the
channel information from the device tree. There are also two helpers
included for counting number of firmware child nodes with a specific name.

Series does also convert couple of drivers to use these helpers. The
rzg2l_adc and the sun20i-gpadc are converted to use the new ADC helper.

The gianfar driver under net is added as an RFC patch to use the newly
added firmware child node counting function.

There has been some discussion about how useful these ADC helpers are,
and whether they should support also differential and single ended channel
configurations. This version does not include support for those - with the
benefit of reduced complexity and easier to use API.

patch 6/10 is small simplification for the ti-ads7924, and it can be
taken independently from the rest of the series.

NOTE: Patches 4...6 and the patch 10 are untested as I lack of relevant HW.
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
v4 =3D> v5: Fixes as per various review comments. Most notably:
 - Drop the patch making the TI's ADC driver to respect device tree.
 - Add (RFC) patch converting gianfar driver to use new name child-node
   counting API as suggested by Andy.
 - Add fwnode_get_child_node_count_named() as suggested by Rob.
 Changes which were not proposed by reviewers:
 - rebase to v6.14-rc5
 - Do not include all recipients to all of the patches.
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
  property: Add functions to count named child nodes
  iio: adc: add helpers for parsing ADC nodes
  iio: adc: rzg2l_adc: Use adc-helpers
  iio: adc: sun20i-gpadc: Use adc-helpers
  iio: adc: ti-ads7924 Drop unnecessary function parameters
  iio: adc: Support ROHM BD79124 ADC
  MAINTAINERS: Add IIO ADC helpers
  MAINTAINERS: Add ROHM BD79124 ADC/GPO
  net: gianfar: Use device_get_child_node_count_named()

 .../bindings/iio/adc/rohm,bd79124.yaml        |  114 ++
 MAINTAINERS                                   |   12 +
 drivers/base/property.c                       |   57 +
 drivers/iio/adc/Kconfig                       |   17 +
 drivers/iio/adc/Makefile                      |    3 +
 drivers/iio/adc/industrialio-adc.c            |   82 ++
 drivers/iio/adc/rohm-bd79124.c                | 1108 +++++++++++++++++
 drivers/iio/adc/rzg2l_adc.c                   |   38 +-
 drivers/iio/adc/sun20i-gpadc-iio.c            |   38 +-
 drivers/iio/adc/ti-ads7924.c                  |    7 +-
 drivers/net/ethernet/freescale/gianfar.c      |   17 +-
 include/linux/iio/adc-helpers.h               |   27 +
 include/linux/property.h                      |    4 +
 13 files changed, 1462 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79124.=
yaml
 create mode 100644 drivers/iio/adc/industrialio-adc.c
 create mode 100644 drivers/iio/adc/rohm-bd79124.c
 create mode 100644 include/linux/iio/adc-helpers.h


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
--=20
2.48.1


--ok8G6d4pd5Kde/Tf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfFkusACgkQeFA3/03a
ocWURggAh0aahWuhR4X2pAbWcrvLlgY0D9RSlfBWXUHB68G1gPrJjp5CTgZLemkh
d8hIvugJVz+G6zfkewr+abXoQbFlTjXSnKUUB6DAt0uoeJolaV6QxfNX9JwyLhMH
v5nQ2dValRMeFZVoh1hUCXjtrTFJCjBeGKqDb2Rb17SxjzYk09ObnyIJRh4MABsl
pyiO6m0xFOLr5vjd7f2sygWRigBYQPuDyTcre5WG0o3vNBTlEfr9BmR8aPNGFaJs
7KvjqfOj8BGczBrxIHCUxMiNkEIGCKODg1dMdm3VBLI03/Uy3LR73AEqzX3wjEY4
BBEZarVDoaTTVCmV9HvB+kvmJdW1GQ==
=xpnm
-----END PGP SIGNATURE-----

--ok8G6d4pd5Kde/Tf--


