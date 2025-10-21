Return-Path: <linux-iio+bounces-25299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9153BF4A98
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 07:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957AF404DEC
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 05:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107B725A2DA;
	Tue, 21 Oct 2025 05:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="cbw4i/cj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07651246762
	for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761025799; cv=none; b=j6GTAFg1i/uhLzVVLfeF35Fgkd4QiYffYtXcUz1rQsvgDk3eS9judbyh9FOud/2pmDxoi/p2m4gY+10Y88fAxyByv4BHi8g06+OZZVLvYWPHfnaHijmUJU/TQWeFEi+sU/uJzDLf3hSTdlaapwG4Zy/t07CXQMbfPAOchKQxGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761025799; c=relaxed/simple;
	bh=0Bac+H8vcaz0xMB5WzDIsGdFpuUaiPfwCKXn/dJZX1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i896XxqKA0YxEgdDrat+PgH0Fyhytwp8RpjkkRIJoBFVOKVlUsamkjhrIs4Rgwlucxqr4ypd2ej9xdEeUhahtTrktdmo8mdhLs64rdTZ192WlL4f1y/7jw5OLEe4HLoexpofYdvL/OALiY6jj+qramqkxuq8TCtsQs69L8wwno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=cbw4i/cj; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 43A31104CBCD
	for <linux-iio@vger.kernel.org>; Tue, 21 Oct 2025 11:19:53 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 43A31104CBCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1761025793; bh=0Bac+H8vcaz0xMB5WzDIsGdFpuUaiPfwCKXn/dJZX1Y=;
	h=Date:From:To:Cc:Subject:From;
	b=cbw4i/cjVcRhF78KIoiJEijlaiHvWkjvaX06dQwmV5NyD6H1sG3bAmL5qtp4MUSA9
	 6LC5PxQf/8zgdJP4WiRNpCsi4IpgwLL3JR8R3C7QmvFd6c53EkCAdbYbMPz7dom6kw
	 g/liEU8OwmjbNWc/96pMKYi9U5TqiSh2ID6s6Uxk=
Received: (qmail 32212 invoked by uid 510); 21 Oct 2025 11:19:53 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.476333 secs; 21 Oct 2025 11:19:53 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 21 Oct 2025 11:19:48 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 006483414E6;
	Tue, 21 Oct 2025 11:19:48 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id B55A01E81391;
	Tue, 21 Oct 2025 11:19:47 +0530 (IST)
Date: Tue, 21 Oct 2025 11:19:42 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com
Cc: skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: [PATCH v3 0/2] iio: pressure: add driver and bindings for adp810
Message-ID: <cover.1761022919.git.akhilesh@ee.iitb.ac.in>
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

Changes in v3:
- Followed Include What You Use (IWYU) by adding additional include files (mutex.h, dev_printk.h and few others)
- Improved error handling of i2c_master_send() and i2c_master_recv() with additional transfer length checks.
- Changed style of structure initialization from {0} to { } 
- Rebased on top of v6.18-rc2
- Link to v2: https://lore.kernel.org/lkml/cover.1760374257.git.akhilesh@ee.iitb.ac.in/ 

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

Akhilesh Patil (2):
  dt-bindings: iio: pressure: Add Aosong adp810
  iio: pressure: adp810: Add driver for adp810 sensor

 .../bindings/iio/pressure/aosong,adp810.yaml  |  46 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/pressure/Kconfig                  |  12 +
 drivers/iio/pressure/Makefile                 |   8 +-
 drivers/iio/pressure/adp810.c                 | 222 ++++++++++++++++++
 5 files changed, 291 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
 create mode 100644 drivers/iio/pressure/adp810.c

-- 
2.34.1


