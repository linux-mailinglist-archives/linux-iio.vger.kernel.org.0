Return-Path: <linux-iio+bounces-25035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEDBBD5777
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 19:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F79402C13
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 17:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD6D2BEFF0;
	Mon, 13 Oct 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="iBXdMhYq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AA6273D83
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374915; cv=none; b=TlIzvlRa21fRFMFPDejBWrbZ9yJdqhVsTZ7Z48K/xS5+Pn1gcczJKDltRSi3fvJBRROgKU9k0rKWa847B4qMaGL0ehfXwq/SDLunolUtR4KhcpZZLmTCq5WDwcrrfCdKLeknguz2g/GfU8WVieHK81W3bMs2JEjZOdDBBcDQw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374915; c=relaxed/simple;
	bh=yI5gthnF0tLE1kh41LiwdsRsimRp2mZa0vEaG2gzQjg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q3gYv8PrzOrpd264tgi+g8Ee7Qfj1d+H5fMHJjMdNROIx0lisWcaojh4K79s1eYIk8PUSTO0ClmG9BubtoIm/kwAL/vGhfX3un0W9j5Hor3YYFdtPiPzmOl12Y+T55pR0stQuu6XnsS5uPDH1Qg69E2dBKkJF2CL27aOV8S9E2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=iBXdMhYq; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id CFB4E104CBC9
	for <linux-iio@vger.kernel.org>; Mon, 13 Oct 2025 22:31:46 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in CFB4E104CBC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1760374906; bh=yI5gthnF0tLE1kh41LiwdsRsimRp2mZa0vEaG2gzQjg=;
	h=Date:From:To:Cc:Subject:From;
	b=iBXdMhYqtCL4al+LLO2EvNaxNqc2m6qzGzhjNQaRMO3dIz68IFqvpW68V6mOc2MPv
	 o/4LTkPfvkEvOJWdnEuWFHVUsJlY3KSrD2SCgS5K7/QsQ7JIlMvFu7n5lWiTI0pnhw
	 pUMAhaXjJPsFf6AYNyc1wJF15NEQrA+3SCbdLZSg=
Received: (qmail 28716 invoked by uid 510); 13 Oct 2025 22:31:46 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.471035 secs; 13 Oct 2025 22:31:46 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 13 Oct 2025 22:31:43 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 73F61360077;
	Mon, 13 Oct 2025 22:31:42 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 5739E1E8152E;
	Mon, 13 Oct 2025 22:31:41 +0530 (IST)
Date: Mon, 13 Oct 2025 22:31:35 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com
Cc: skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: [PATCH v2 0/2] iio: pressure: add driver and bindings for adp810
Message-ID: <cover.1760374257.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch series adds support for aosong adp810 differential pressure and
temperature sensor driver in the IIO subsystem.

Patch 1: Adds bindings for this hardware.
Patch 2: Adds driver code with device tree support.

Overview of adp810:
This is digital differential pressure and temperature sensor from aosong under
the brand name of ASAIR. This sensor can measure pressure from -500 to +500Pa
and temperature from -40 to +85 degree. It provides simple protocol to measure
readings over I2C bus interface.

How to read from sensor (Protocol)?
To read from sensor, i2c master needs to send measure command 0x372d to
start the data acquisition. Then host/master should wait for minimum 10ms for data
to be ready before reading. Post this delay i2c master can read 9 bytes of
measurement data which includes - pressure(u16): crc(u8): temperature(u16): crc(u8)
scale factor (u16): crc(8).
Host/master can optionally verify crc for data integrity. Read sequence can be
terminated anytime by sending NAK.

Datasheet: https://aosong.com/userfiles/files/media/Datasheet%20ADP810-Digital.pdf

Testing:
Driver is tested on Texas Instruments am62x sk board by connecting sensor at i2c-2.
Data communication is validated with i2c bus at 100KHz and 400KHz using logic analyzer.
Sensor values are read using iio subsystem's sysfs interface.

Changes in v2:
- Wrapped yaml binding description to 80 lines.
- Dropped block scalar ' | ' from binding description.
- Carry forward Reviewed-by tag from Krzysztof on device tree binding.
- Grammar and spelling fixes at multiple places.
- Ordered makefile alphabetically.
- Ordered include files alphabetically and used IWYU principle
- Explicitly mentioned unit of measure latency macro in MS (milliseconds)
- Added inline comments for explaining CRC8 polynomial for CRC calculation 
- Used scoped_guard() for mutex for safe and clean lock handling.
- Used resource managed mutex_init() -> devm_mutex_init()
- Removed dead code in _probe() function.
- Used __be16 and related helpers to handle big endian data processing.
- Apply reverse xmas tree guideline while declaring local variables if possible.
- Used parent device pointer in dev_err() calls.
- Hardcode device name string in _probe() function for simplicity.
- Made default return value of _probe() function to 0.
- Rebased and retested driver on top of 6.18-rc1
- Link to v1: https://lore.kernel.org/lkml/cover.1760184859.git.akhilesh@ee.iitb.ac.in/

Looking forward for feedback and suggestions.

Regards,
Akhilesh

Akhilesh Patil (2):
  dt-bindings: iio: pressure: Add Aosong adp810
  iio: pressure: adp810: Add driver for adp810 sensor

 .../bindings/iio/pressure/aosong,adp810.yaml  |  46 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/pressure/Kconfig                  |  12 +
 drivers/iio/pressure/Makefile                 |   8 +-
 drivers/iio/pressure/adp810.c                 | 212 ++++++++++++++++++
 5 files changed, 281 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
 create mode 100644 drivers/iio/pressure/adp810.c

-- 
2.34.1


