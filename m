Return-Path: <linux-iio+bounces-24941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB0BCF55D
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 14:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90B7134A464
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 12:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E54279DA2;
	Sat, 11 Oct 2025 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="PNae96UE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCDB2773EA
	for <linux-iio@vger.kernel.org>; Sat, 11 Oct 2025 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760186066; cv=none; b=OR4QRgBVay9yplnl57kr5U62OS3sPPBxIzDVZo9DYNduU+1aY3/C/v+ERK6QhGr4o05WUJPV8LKJ2MoRMne4EwflX+yoxhvA7JLBiF0pT+aKQbsmm8MN8J1z6Ff+KUvlncf0CmqnQEiIB0lcOADLoN8xPh5JTrcyZMeW2GhQuVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760186066; c=relaxed/simple;
	bh=w1xca3l/z4TtwsDn7iSaDrhnal0StFB6JzF76Ro/aPk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t8tUIYupCHxQZC58BxGpicFbgoeQK0I2pMLfpxUvIVvXZrlYss/IiIen5toPWNTCxoNABXOPg72l8Jiiv3wDSRUozYFpfri2u77s+08wJ71j+DQ/lvoU/Z70SNQfXlSUc+7W8Vz1vDaXefyINAqafyL1STofUyJuYByvrd/C0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=PNae96UE; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 3D972104C1D4
	for <linux-iio@vger.kernel.org>; Sat, 11 Oct 2025 17:54:53 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 3D972104C1D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1760185493; bh=w1xca3l/z4TtwsDn7iSaDrhnal0StFB6JzF76Ro/aPk=;
	h=Date:From:To:Cc:Subject:From;
	b=PNae96UEPy7cfyGP26EFLlMbwRRotdUEGsL2XoWTnscQrdlJv2InWr3EF8M9EssmB
	 iF3YlnsKe1bdYQ5v6sbiRO8moEmZhDS5sFqXQSGKzctymYEcK+eZ+JBI5lAy2RfSDv
	 llg2bvy/VQfJO68pC7iPN/J/8Xe+GLtPrDn7V+W0=
Received: (qmail 21247 invoked by uid 510); 11 Oct 2025 17:54:53 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.543363 secs; 11 Oct 2025 17:54:53 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 11 Oct 2025 17:54:49 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id A5B9F36003B;
	Sat, 11 Oct 2025 17:54:48 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 672F51E81664;
	Sat, 11 Oct 2025 17:54:48 +0530 (IST)
Date: Sat, 11 Oct 2025 17:54:43 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com
Cc: skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: [PATCH 0/2] iio: pressure: add driver and bindings for adp810
Message-ID: <cover.1760184859.git.akhilesh@ee.iitb.ac.in>
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

Looking forward for feedback and suggestions.

Regards,
Akhilesh

Akhilesh Patil (2):
  dt-bindings: iio: pressure: Add Aosong adp810
  iio: pressure: adp810: Add driver for adp810 sensor

 .../bindings/iio/pressure/aosong,adp810.yaml  |  46 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/pressure/Kconfig                  |  12 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/adp810.c                 | 205 ++++++++++++++++++
 5 files changed, 271 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml
 create mode 100644 drivers/iio/pressure/adp810.c

-- 
2.34.1


