Return-Path: <linux-iio+bounces-15296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADCDA2F8A8
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 20:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A88F16152D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 19:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E468256C6B;
	Mon, 10 Feb 2025 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQtXtdZJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D012566CB
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215788; cv=none; b=VR2ITq+9TIcEOriRPkjQlgHUrXHr8tQXYAPSvsHSfWqm/bq7QgebZAruPFcL9kYp/4f17rUllyIZj1A6u2j7gmnlXJXlGzfUu9j9rFTNHxKCZi7e+/jQEIltQZXYIhU1tARZQGHvp4QrK/frRPNdNEg/tWVDC16HxTTh0YwSMsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215788; c=relaxed/simple;
	bh=J6v2T8F3QKnPGKPzjUqAuyD1hJ/7t346N5BSWAWMV9c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=NA8kUG32Rgx7VBCX+rI1VZXH+5GA1CVQJb/+JtZ/kue+vCAquopSxS7C5QB30r9jWJK3NgIw+pquwIACI/OMxnYHN9rBCqpxEUUxmjEc1mb3UWe/bvJh9IQd7+oFE6JxLCJwgDn0yLHB4x2SYhjOxx/SOQa+mkTTm7H5E0bEkjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQtXtdZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE79C4CED1;
	Mon, 10 Feb 2025 19:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739215788;
	bh=J6v2T8F3QKnPGKPzjUqAuyD1hJ/7t346N5BSWAWMV9c=;
	h=Date:From:To:Subject:From;
	b=lQtXtdZJTBBY9lhDy699slpxibHLgGq9Ph6FkkjYJhnXmqT0Qa7KELKb12pc/YxFa
	 3BsuAP+dAyNDcrx67WXjE5ILUDhhlIJLocmfmngws8ijJpA1RetCNv92g0Uzg8CHOa
	 MTC0efiJKNF2xsni2nv5VRqi+PXR8VctV8nfT7Nei+j0sPPk1JPiNyFP76xnBq2DJ1
	 f3vYo3cnQmp2XaIgI3gfXHV676onF3Q7pHsY5cRx3V4Y6djW+mcV7sbJE4mdPI2+cy
	 FNOcfLe/8KaEtP6YuuWbqZ/eLE8pjiq9SZVtiKg25YxIuU16mPjw9QOcH2rE8BlEoq
	 3Zp13bq/91EvQ==
Date: Mon, 10 Feb 2025 19:29:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO fixes: 1st set of fixes for the 6.14 cycle.
Message-ID: <20250210192941.67c3901b@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.14a

for you to fetch changes up to cc2c3540d9477a9931fb0fd851fcaeba524a5b35:

  iio: filter: admv8818: Force initialization of SDO (2025-02-08 12:46:32 +0000)

----------------------------------------------------------------
IIO: 1st set of fixes for the 6.14 cycle

hid-sensors
- Fix an ABI issue that occurred when we gained multiple proximity sensor
  support.
adi,adi-axi-adc
- Fix missing pwm-names inItems entry in dt binding.
adi,ad3552r
- Make sure to clear the reset bit in the status flag so future
  resets can be detected.
adi,ad7192
- Fix use of value where it should be bit(value) to select channel.
adi,ad7606
- Fix up reporting of wrong available scales.
adi,admv8818
- Force SDO line to be initialized without relying on it already being
  intialized to read back current register value.
atmel,sama5d2
- Fix wrong number of bits reported for readings from sama7g5
avago,apds9306
- Fix wrong scaling of scale values (missing a few zeros).
microchip,pac1921
- Fix resource leak by moving ACPI_FREE() call up a few lines.
tyhx,hx9023s
- Fix a use after free caused by releasing firmware a few lines early.

----------------------------------------------------------------
Angelo Dureghello (3):
      iio: dac: ad3552r: clear reset status flag
      dt-bindings: iio: dac: adi-axi-adc: fix ad7606 pwm-names
      iio: adc: ad7606: fix wrong scale available

Dheeraj Reddy Jonnalagadda (1):
      iio: proximity: Fix use-after-free in hx9023s_send_cfg()

Javier Carrasco (1):
      iio: light: apds9306: fix max_scale_nano values

Markus Burri (1):
      iio: adc: ad7192: fix channel select

Nayab Sayed (1):
      iio: adc: at91-sama5d2_adc: fix sama7g5 realbits value

Ricardo Ribalda (1):
      iio: hid-sensor-prox: Split difference from multiple channels

Sam Winchenbach (1):
      iio: filter: admv8818: Force initialization of SDO

Victor Duicu (1):
      iio: adc: pac1921: Move ACPI_FREE() to cover all branches

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  1 +
 drivers/iio/adc/ad7192.c                           |  2 +-
 drivers/iio/adc/ad7606.c                           |  2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 | 68 +++++++++++++---------
 drivers/iio/adc/pac1921.c                          |  2 +-
 drivers/iio/dac/ad3552r.c                          |  6 ++
 drivers/iio/filter/admv8818.c                      | 14 ++---
 drivers/iio/light/apds9306.c                       |  4 +-
 drivers/iio/light/hid-sensor-prox.c                |  7 ++-
 drivers/iio/proximity/hx9023s.c                    |  3 +-
 10 files changed, 62 insertions(+), 47 deletions(-)

