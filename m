Return-Path: <linux-iio+bounces-19641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A60ABB129
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 19:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9EF07A95C4
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD33218ABD;
	Sun, 18 May 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRKJWyUn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABEE1E4AE
	for <linux-iio@vger.kernel.org>; Sun, 18 May 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747591043; cv=none; b=NYukQHpL3/JHska6tXSV2ogjUErgoijVem2qSda3iyzuWCTO10vH8QCNQhx7ZpLwjhU+lVE9GRZoPVswzX73RIsROANcOI4a2UdwLyDl01gf5aKg5SOJmVCvnWsczn6UUZrZPQ/1SFYUccOTZrSwwOoDKXSGOE0AuGZsBOFBgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747591043; c=relaxed/simple;
	bh=HC76E/dwXfIl6pYIBkobwkFXZFuJulNgYmZGbbEF9Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eaZ6nyGhzxxMT/cgZPJrAltCrKzC6OvT6xLxaajfpTkrG3BS2ndzwb0cVuiEt3DJ24DJ2qd14YfNAd6ZqiiAXy3PsXJaLW4pTHGidoNyDhD8beS3q9rMJn5jA/w1K0kskNVc83fb53JtN5kGvRzHQzNXR0OZNrhFSQ6FdsUeYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRKJWyUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57912C4CEE7;
	Sun, 18 May 2025 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747591043;
	bh=HC76E/dwXfIl6pYIBkobwkFXZFuJulNgYmZGbbEF9Vc=;
	h=Date:From:To:Cc:Subject:From;
	b=IRKJWyUnuno7EbViNQalQcNiz/Oliof/RdNZNL73VRedDMC0R98PAT7qQPrCg9LVD
	 iFON9X4WaM61g37dn0LwwdhNRGqCMZdUG/CTbB8NqBKpFZBPT41UwGZgse/QTLOZGI
	 k89EOkkGJk7Tqv2AJMonNNU9blx7Cb8VqL7kRdsPkwSuHCD/CxLtOHC7xeCQD6BDim
	 YjCI6Vl/NyDjEeMPFkUu5djKeyoAV87reHeTozqZ+lhZgwhZkA2BF40ljN5lFliiMq
	 eYyS2MhFYo3Z9VB0s3k2gT5AyWB+9IeISMIB9UUklOVfAP4NiHyPuy31fSOhqIy64c
	 9q4vZC7YQ9GJw==
Date: Sun, 18 May 2025 18:57:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org
Subject: [PULL] IIO: Fixes for 6.15 set 2 (or merge window given timing)
Message-ID: <20250518185719.0c816d81@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 65995e97a1caacf0024bebda3332b8d1f0f443c4:

  Drivers: hv: Make the sysfs node size for the ring buffer dynamic (2025-05-02 13:59:02 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.15b

for you to fetch changes up to 9c78317b42e7c32523c91099859bc4721e9f75dd:

  iio: accel: fxls8962af: Fix temperature scan element sign (2025-05-15 17:17:02 +0100)

----------------------------------------------------------------
IIO: 2nd set of fixes for 6.15 (or 6.16 merge window)

Usual mixed bag.

adi,ad4851
- Avoid a buffer overrun due to bug in pointer arithmetic.
adi,ad7173
- Fix compiling if gpiolib is not enabled
adi,ad7606
- Fix raw reads for 18-bit chips by ensuring we mask out upper bits
  as some SPI controllers do not do so for 18bit words.
- Fix wrong masking for register writes.
adi,ad7944
- Mask high bits for raw reads.
adi,axi-adc
- Add check on whether the busy flag has cleared before first access.
invensense,icm42600
- Fix the temperature offset to take scale into account.
nxp,fxls8962af
- Fix temperature to be in milli degrees Celsius not degrees.
- Fix sign of temperature channel.

----------------------------------------------------------------
Angelo Dureghello (1):
      iio: dac: adi-axi-dac: fix bus read

Antoniu Miclaus (1):
      iio: adc: ad4851: fix ad4858 chan pointer handling

David Lechner (4):
      iio: adc: ad7173: fix compiling without gpiolib
      iio: adc: ad7606: fix raw read for 18-bit chips
      iio: adc: ad7606_spi: fix reg write value mask
      iio: adc: ad7944: mask high bits on direct read

Sean Nyekjaer (3):
      iio: imu: inv_icm42600: Fix temperature calculation
      iio: accel: fxls8962af: Fix temperature calculation
      iio: accel: fxls8962af: Fix temperature scan element sign

 drivers/iio/accel/fxls8962af-core.c              | 15 +++++++++++++--
 drivers/iio/adc/Kconfig                          |  5 +++--
 drivers/iio/adc/ad4851.c                         | 14 +++++++-------
 drivers/iio/adc/ad7173.c                         | 15 +--------------
 drivers/iio/adc/ad7606.c                         | 21 ++++++++++-----------
 drivers/iio/adc/ad7606_spi.c                     |  2 +-
 drivers/iio/adc/ad7944.c                         |  2 ++
 drivers/iio/dac/adi-axi-dac.c                    |  8 ++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c |  8 +++++---
 9 files changed, 50 insertions(+), 40 deletions(-)

