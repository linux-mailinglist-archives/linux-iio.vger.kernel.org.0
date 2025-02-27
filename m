Return-Path: <linux-iio+bounces-16141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108F9A48530
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 17:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F93317D049
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834081B0439;
	Thu, 27 Feb 2025 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="aKHt2hRN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7DD1A3178
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673791; cv=none; b=IUA3/DRqprsMNBIQyMTKwMz/x9wHdfXT6nXwVibbnOV7cBixHsiw/MbcstpICxRCroOPFK1yUH3bQ2pFD0Q3dSTsSdKO2I0XG8QrzeY4v6MPnglv2LAIMyJfsBiDTKKT2MZFE0ttRORIQdsFFND8b4b+ZctVzfE5O1Nz8I7pXu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673791; c=relaxed/simple;
	bh=PgRYUUeTT1JBmil9ECVJeO3haSqsaiggs8Yz5Nhgtw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KbjPeAZJ5UF1E+IDrLdXkNGbXMKeRT+PF4v29bt12wJVaSL4foqrTtV7F+TxBasAlBLqduy3ERrg1wltxETrHNCVV6ByIQ68vlMljxCBnJsStpwWarjwT8/BcE1laqoP1BFseuJVqba2bVfXk0n9ZvEQDt98vFKJfVveRIlLBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=aKHt2hRN; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=uyV67zBxhxQ45yLPsz+CN/F+f5ojkxID4+JV1MJhHxc=;
	b=aKHt2hRNqQgkGbX+Y0tqd5xrl5PNcuC6dvFM+lszxu3eoFiMxmtoT8JruHbdnwYf4AHQUdrKjRm23
	 ixMiwngJ+F8ASW6i1nWbftovrMwIIpFd2h3uIEDX+lwVCVLdOSIO9oHs0Kt5Gt7Kt8OPJKmbdcNJAw
	 QNkTVg0y1oOodskw61ZoOGmefMYn9emWguSXLLJi1GvJe/cu/wRDVXNZTbr4GFlGTlLFHth9GkX0nq
	 ybfhZdqG9Wf6N0pbKgYMPKfvGN9dZtvSjjPMT6d1a4J+AkU+4MsykZML2Z2KgSGkHglFDnyxop6Nip
	 lb6lXQoZEW3lE5XlG9bth9iv0bEIZVw==
X-MSG-ID: e6781c98-f527-11ef-a399-00505681446f
From: David Jander <david@protonic.nl>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	David Jander <david@protonic.nl>
Subject: [RFC PATCH 0/7] Add Linux Motion Control subsystem
Date: Thu, 27 Feb 2025 17:28:16 +0100
Message-ID: <20250227162823.3585810-1-david@protonic.nl>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Request for comments on: adding the Linux Motion Control subsystem to the
kernel.

The Linux Motion Control subsystem (LMC) is a new kernel subsystem and
associated device drivers for hardware devices that control mechanical
motion. Most often these are different types of motors, but can also be
linear actuators for example.

This subsystem defines a new UAPI for motion devices on the user-space
side, as well as common functionality for hardware device drivers on the
driver side.

The UAPI is based on a ioctl() interface on character devices representing
a specific hardware device. The hardware device can control one or more
actuators (motors), which are identified as channels in the UAPI. It is
possible to execute motions on individual channels, or combined
affecting several selected (or all) channels simutaneously. Examples of
coordinated movements of several channels could be the individual axes
of a 3D printer or CNC machine for example.

On the hardware side, this initial set of patches also includes two drivers
for two different kinds of motors. One is a stepper motor controller
device that containes a ramp generator capable of autonomously executing
controlled motions following a multi-point acceleration profile
(TMC5240), as well as a simple DC motor controller driver that can control
DC motors via a half-bridge or full H-bridge driver such as the TI DRV8873
for example.

Towards the IIO subsystem, LMC supports generating iio trigger events that
fire at certain motion events, such as passing a pre-programmed position or
when reaching the motion target position, depending on the capabilities of
the hardware device. This enables for example triggering an ADC measurement
at a certain position during a movement.

In the future, making use of PREEMPT_RT, even dumb STEP/DIR type stepper
motor controller drivers may be implemented entirely in the kernel,
depending on some characteristics of the hardware (latency jittter,
interrupt latency and CPU speed mainly).

The existence of this subsystem may affect other projects, such as
Linux-CNC and Klipper for example.

This code is already in use controlling machines with up to 16 stepper
motors and up to 4 DC motors simutaneously. Up to this point the UAPI
has shown to be adequate and sufficient. Careful thought has gone into
the UAPI design to make sure it coveres as many use-cases as possible,
while being versioned and extensible in the future, with backwards
compatibility in mind.

David Jander (7):
  drivers: Add motion control subsystem
  motion: Add ADI/Trinamic TMC5240 stepper motor controller
  motion: Add simple-pwm.c PWM based DC motor controller driver
  Documentation: Add Linux Motion Control documentation
  dt-bindings: motion: Add common motion device properties
  dt-bindings: motion: Add adi,tmc5240 bindings
  dt-bindings: motion: Add motion-simple-pwm bindings

 .../bindings/motion/adi,tmc5240.yaml          |   60 +
 .../devicetree/bindings/motion/common.yaml    |   52 +
 .../bindings/motion/motion-simple-pwm.yaml    |   55 +
 Documentation/motion/index.rst                |   18 +
 Documentation/motion/motion-uapi.rst          |  555 ++++++++
 Documentation/subsystem-apis.rst              |    1 +
 MAINTAINERS                                   |   13 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    2 +
 drivers/motion/Kconfig                        |   42 +
 drivers/motion/Makefile                       |    5 +
 drivers/motion/motion-core.c                  |  823 ++++++++++++
 drivers/motion/motion-core.h                  |  172 +++
 drivers/motion/motion-helpers.c               |  590 +++++++++
 drivers/motion/motion-helpers.h               |   23 +
 drivers/motion/simple-pwm.c                   |  199 +++
 drivers/motion/tmc5240.c                      | 1157 +++++++++++++++++
 include/uapi/linux/motion.h                   |  229 ++++
 18 files changed, 3998 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/motion/adi,tmc5240.yaml
 create mode 100644 Documentation/devicetree/bindings/motion/common.yaml
 create mode 100644 Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml
 create mode 100644 Documentation/motion/index.rst
 create mode 100644 Documentation/motion/motion-uapi.rst
 create mode 100644 drivers/motion/Kconfig
 create mode 100644 drivers/motion/Makefile
 create mode 100644 drivers/motion/motion-core.c
 create mode 100644 drivers/motion/motion-core.h
 create mode 100644 drivers/motion/motion-helpers.c
 create mode 100644 drivers/motion/motion-helpers.h
 create mode 100644 drivers/motion/simple-pwm.c
 create mode 100644 drivers/motion/tmc5240.c
 create mode 100644 include/uapi/linux/motion.h

-- 
2.47.2


