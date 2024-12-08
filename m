Return-Path: <linux-iio+bounces-13212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660F69E8510
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 13:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4751884ADA
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 12:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FA148FF5;
	Sun,  8 Dec 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrIhqqhv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D91474B8;
	Sun,  8 Dec 2024 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733661881; cv=none; b=Yj3JaIPW5ZFALLeGg39S2WZIwNa9ViDYaruSTDRNXaGlsNL09gHae2kVnRLiXB1Z94l7vngM9AeWaQzZaHVQMKEBk7hym6RAd9KD3KS1SgF0s2LLbWyzZt/ZC7DOOumq1yvBOf7ZPL0aeUqlSPz40idNB826bqMlPqbiosxgH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733661881; c=relaxed/simple;
	bh=02i3xhJ2ZofhZibsaBmk4tq/PMRAHawWr/bhj0z2Sf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajg59JcSPUhZQ9jBSdIfGyEnRus4Otn7d2s0wSvwMzbXzs8nravfgI8XH64wBW/8XMbSfQY8q29rc1JlhTF34+aF2FOvP9qvXnpeR2p7nnw8Cs8Pgpe2Eo4lukvk8hHTMgGHi8vaRNCaQkc1uxoCNL32M3ZP+ubu0m784bZjNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrIhqqhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0273BC4CED2;
	Sun,  8 Dec 2024 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733661880;
	bh=02i3xhJ2ZofhZibsaBmk4tq/PMRAHawWr/bhj0z2Sf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lrIhqqhvN5teZnAXDgQIBzdmZ+ibCaUZOMd+Z/1DK7m2OqREelJfL6H8pSaMjKTAg
	 ItE/kTdhEZsP0cQ8dyjs/BR4N7OytcYiqL+33X80FSPQXPmHLU+OL3+agjxm3Iq2T5
	 VPYlij+MBlpizn0m1G6bHaOq8ERR5ACoa65BiWUiAW0biulELQS9HCqVDyCod0JrNV
	 JJSm2bs4yTGXqbpyO+DB9egJ4TJ3gSk9YrBxvuUTD3aNWcpVpsSis1H8OgtzVhxTvi
	 EApZynrkmboMmGZYrPUYvGCzbs+tlDdo+R/B4snSUslBOR9HEczh6jCla+HdcYT2Ii
	 GDnhcPdT9k41g==
Date: Sun, 8 Dec 2024 12:44:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, Trevor
 Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v6 00/10] iio: adc: ad7124: Various fixes
Message-ID: <20241208124427.3b90701e@jic23-huawei>
In-Reply-To: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  6 Dec 2024 18:28:32 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> here comes v6 of this series. Compared to v5
> (https://lore.kernel.org/linux-iio/20241203110019.1520071-12-u.kleine-koe=
nig@baylibre.com)
> the following things changed:
>=20
>  - Rebased to v6.13-rc1 + 64612ec9b909. (No changes needed here.)
>=20
>  - Add Ack from Conor to patch #3
>=20
>  - Fixed how R=CC=85D=CC=85Y=CC=85 is written. This was wrong before beca=
use the overline
>    char must be added after the character that should get the overline,
>    not before. I got that wrong because of
>    https://bugs.debian.org/1089108. I would expect that now this is
>    properly shown in most browsers, MUAs and editors.
>=20
>    I guess Andy still doesn't agree to write it that way. Jonathan,
>    would you decide here please? If you agree with Andy I suggest to
>    replace it by #RDY. Andy suggested #RDY_N which I think is too far
>    away from the original name. If you (also) like R=CC=85D=CC=85Y=CC=85,=
 just keep it as
>    is.
>=20
>  - Fix error handling in patch #8
>    I just pasted "return ret" to all callers of
>    ad_sigma_delta_clear_pending_event() before. Now the error handling
>    matches the actual needs of the context.
>=20
>  - s/irq controller's capabilities/irq controller capabilities/
>    as suggested by Andy for patch #8
>=20
> Best regards
> Uwe

Hi Uwe

Given the mix of fixes and other material (kind of fixes, but also kind
of new functionality), I've queued this for the next merge window in my
togreg branch.  If you think there are particular patches that need to
go sooner then I can handle them in a split fashion, but that does add
risk that the whole lot might no land depending on timings (particularly
given it's coming into vacation season).

Initially pushed out as testing - I assume we'll see that sparse warning.

Thanks,

Jonathan

>=20
> Uwe Kleine-K=C3=B6nig (10):
>   iio: adc: ad7124: Don't create more channels than the driver can handle
>   iio: adc: ad7124: Refuse invalid input specifiers
>   dt-bindings: iio: adc: adi,ad7{124,173,192,780}: Allow specifications o=
f a gpio for irq line
>   iio: adc: ad_sigma_delta: Add support for reading irq status using a GP=
IO
>   iio: adc: ad_sigma_delta: Handle CS assertion as intended in ad_sd_read=
_reg_raw()
>   iio: adc: ad_sigma_delta: Fix a race condition
>   iio: adc: ad_sigma_delta: Store information about reset sequence length
>   iio: adc: ad_sigma_delta: Check for previous ready signals
>   iio: adc: ad7124: Add error reporting during probe
>   iio: adc: ad7124: Implement temperature measurement
>=20
>  .../bindings/iio/adc/adi,ad7124.yaml          |  13 ++
>  .../bindings/iio/adc/adi,ad7173.yaml          |  12 +
>  .../bindings/iio/adc/adi,ad7192.yaml          |  15 ++
>  .../bindings/iio/adc/adi,ad7780.yaml          |  11 +
>  drivers/iio/adc/ad7124.c                      | 217 +++++++++++++-----
>  drivers/iio/adc/ad7173.c                      |   1 +
>  drivers/iio/adc/ad7192.c                      |   4 +-
>  drivers/iio/adc/ad7791.c                      |   1 +
>  drivers/iio/adc/ad7793.c                      |   3 +-
>  drivers/iio/adc/ad_sigma_delta.c              | 194 +++++++++++++---
>  include/linux/iio/adc/ad_sigma_delta.h        |   8 +-
>  11 files changed, 390 insertions(+), 89 deletions(-)
>=20
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> prerequisite-patch-id: 617af17fc377a984762c61893b9f2a92ae62213a


