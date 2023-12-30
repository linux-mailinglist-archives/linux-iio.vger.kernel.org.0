Return-Path: <linux-iio+bounces-1327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0918205DE
	for <lists+linux-iio@lfdr.de>; Sat, 30 Dec 2023 13:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5ED1F21A0D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Dec 2023 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1BF79DE;
	Sat, 30 Dec 2023 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge8upnf8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177FF9461
	for <linux-iio@vger.kernel.org>; Sat, 30 Dec 2023 12:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE60CC433C8;
	Sat, 30 Dec 2023 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703939022;
	bh=pXruWp/hhzCajnppmmUvh2KqcYUL8Yn9WyIjWsEYt4c=;
	h=Date:From:To:Subject:From;
	b=Ge8upnf8hQdsCYltvUSvK6Rw+NQSmk/ZwB7SEnugPk1ARFBHJ64Syxhvecr4soT/3
	 8DFoogKsz0pqOsEeWBXtNYdvL7WdzTbRCeFC1Zsg0zDic8gZthOenlrcl81ih5Kjfc
	 Du5IDrbgSMnKUZr27MahcZTCIUinFPasQM5iq6yZUoVnb8N23jIoSGz/ZuTd8fd/0E
	 T7meZrabUQqG4H91I00hto3Wkx6GIoGPS1edOZPBm7NOxlFaw3VJBST8FaxHsxTchT
	 GYPCw2pg2xFO4a19t3zYxfcM3FEBBh+HIubJtBklHnbl5a+7Zx27jq8Pmmspeo/lUZ
	 5KcEOVgowrDjw==
Date: Sat, 30 Dec 2023 12:23:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 2nd set of new device support and cleanup for 6.8
Message-ID: <20231230122338.3b303a57@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following changes since commit e9215fcca2561b208c78359110ee4009b454f761:

  Merge tag 'w1-drv-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1 into char-misc-next (2023-12-21 11:23:10 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.8b

for you to fetch changes up to 8645e659e2d227f6ce8fcea1ac640c324fbbb3e6:

  iio: linux/iio.h: fix Excess kernel-doc description warning (2023-12-26 16:02:46 +0000)

----------------------------------------------------------------
IIO: 2nd set of new device support, features and cleanup for 6.8

A late/optimistic second pull request. The bots have been poking them
since Wednesday without any issues. There are a few fixes in the
ad7091r5 driver as part of rework to enable the ad7091r8 parts that
are included at start of that series.

Includes pre-work for major changes to the DMA buffers that should
land in 6.9 and will greatly improve performance and flexibility for
high performance devices by enabling DMABUF based zero copy transfers
when we don't need to bounce the data via user space.

New device support
------------------
adi,ad7091r8
 - Major refactor of existing adi,ad7091r5 driver to separate out useful
   shared library code that can be used by I2C and SPI parts.
 - Use that library from a new driver supporting the AD7091R-2, AD7091R-4
   and AD7091R-8 12-Bit SPI ADCs.
 - Series includes some late breaking fixes for the ad7091r5.

microchip,mcp4821
 - New driver for MCP4801, MCP4802, MCP4811, MCP4812, MCP4821 and MCP4822
   I2C single / dual channel DACs.

Cleanup
-------
buffers:
 - Use IIO_SEPARATE in place of some hard-coded 0 values.
dma-buffers:
 - Simplify things to not use an outgoing queue given it only ever has
   up to two elements and we only need to track which is first.
 - Split the iio_dma_buffer_fileio_free() function up to make it easier
   to read and enable reuse in a series lining up for 6.9
iio.h
 - Drop some stale documentation of struct fields that don't exist.

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: buffer-dma: split iio_dma_buffer_fileio_free() function

Anshul Dalal (2):
      dt-bindings: iio: dac: add MCP4821
      iio: dac: driver for MCP4821

Christophe JAILLET (1):
      iio: buffer: Use IIO_SEPARATE instead of a hard-coded 0

Marcelo Schmitt (11):
      iio: adc: ad7091r: Allow users to configure device events
      iio: adc: ad7091r: Enable internal vref if external vref is not supplied
      iio: adc: ad7091r: Move generic AD7091R code to base driver and header file
      iio: adc: ad7091r: Move chip init data to container struct
      iio: adc: ad7091r: Remove unneeded probe parameters
      iio: adc: ad7091r: Set device mode through chip_info callback
      iio: adc: ad7091r: Add chip_info callback to get conversion result channel
      iio: adc: Split AD7091R-5 config symbol
      dt-bindings: iio: Add AD7091R-8
      iio: adc: Add support for AD7091R-8
      MAINTAINERS: Add MAINTAINERS entry for AD7091R

Paul Cercueil (1):
      iio: buffer-dma: Get rid of outgoing queue

Randy Dunlap (1):
      iio: linux/iio.h: fix Excess kernel-doc description warning

 .../devicetree/bindings/iio/adc/adi,ad7091r5.yaml  |  82 ++++++-
 .../bindings/iio/dac/microchip,mcp4821.yaml        |  86 +++++++
 MAINTAINERS                                        |  15 ++
 drivers/iio/adc/Kconfig                            |  16 ++
 drivers/iio/adc/Makefile                           |   4 +-
 drivers/iio/adc/ad7091r-base.c                     | 269 +++++++++++++-------
 drivers/iio/adc/ad7091r-base.h                     |  83 ++++++-
 drivers/iio/adc/ad7091r5.c                         | 120 +++++----
 drivers/iio/adc/ad7091r8.c                         | 272 +++++++++++++++++++++
 drivers/iio/buffer/industrialio-buffer-dma.c       |  87 ++++---
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/mcp4821.c                          | 236 ++++++++++++++++++
 drivers/iio/industrialio-buffer.c                  |   6 +-
 include/linux/iio/buffer-dma.h                     |   7 +-
 include/linux/iio/iio.h                            |   6 -
 16 files changed, 1107 insertions(+), 193 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
 create mode 100644 drivers/iio/adc/ad7091r8.c
 create mode 100644 drivers/iio/dac/mcp4821.c

