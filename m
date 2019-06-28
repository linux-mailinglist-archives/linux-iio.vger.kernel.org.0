Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85A3A5A647
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2019 23:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfF1VX1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jun 2019 17:23:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfF1VXX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jun 2019 17:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QlsQ1+q1SjKC8lMaCgpafyBcinDt68zhFxuroemk0jo=; b=Ava474VzaHhDGQbDK3FHJx7/bG
        ORDMh1wgigViphdpWl1V81aqB8Of+6Ct2veLvaqc7VzgJew/toTHyUoEFNwe+pv+OwMj9eN672wpl
        dwvbYH9d9bnREXqJ+++eSDSK7JXYf/qFH1XlOH4cZJ9PuEnCzRIBs5K0NudT37tZlO7aSu/Rbha/S
        afUdr0I33hJAQxuGgDzT71l73wpZL+dPTbTr21lBzn51I3AjpkBkDL5Wd81BTt2Xokj3E/7fD2mmf
        ZM946lLfTDbMCiGLdWLtM/Th/uWb2wvfHxEjndgSzCbU4au9UWrVQdAvv3sQ4ONH3mzIAWI+AnjTk
        61SzjF0A==;
Received: from [187.113.3.250] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgyL2-0001VI-LU; Fri, 28 Jun 2019 21:23:21 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgyL0-0002e2-0x; Fri, 28 Jun 2019 18:23:18 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 5/5] docs: spi: convert to ReST and add it to the kABI bookset
Date:   Fri, 28 Jun 2019 18:23:16 -0300
Message-Id: <7895cce04cd4d140fb519a02315a8309c4c3ebb5.1561756511.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561756511.git.mchehab+samsung@kernel.org>
References: <cover.1561756511.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

While there's one file there with briefily describes the uAPI,
the documentation was written just like most subsystems: focused
on kernel developers. So, add it together with driver-api books.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/index.rst                       |   1 +
 .../spi/{butterfly => butterfly.rst}          |  44 ++++----
 Documentation/spi/index.rst                   |  23 ++++
 Documentation/spi/{pxa2xx => pxa2xx.rst}      |  94 ++++++++--------
 .../spi/{spi-lm70llp => spi-lm70llp.rst}      |  17 ++-
 .../spi/{spi-sc18is602 => spi-sc18is602.rst}  |   3 +
 .../spi/{spi-summary => spi-summary.rst}      | 103 ++++++++++--------
 Documentation/spi/{spidev => spidev.rst}      |  30 +++--
 drivers/iio/dummy/iio_simple_dummy.c          |   2 +-
 drivers/spi/Kconfig                           |   2 +-
 drivers/spi/spi-butterfly.c                   |   2 +-
 drivers/spi/spi-lm70llp.c                     |   2 +-
 include/linux/platform_data/sc18is602.h       |   2 +-
 13 files changed, 198 insertions(+), 127 deletions(-)
 rename Documentation/spi/{butterfly => butterfly.rst} (71%)
 create mode 100644 Documentation/spi/index.rst
 rename Documentation/spi/{pxa2xx => pxa2xx.rst} (83%)
 rename Documentation/spi/{spi-lm70llp => spi-lm70llp.rst} (88%)
 rename Documentation/spi/{spi-sc18is602 => spi-sc18is602.rst} (97%)
 rename Documentation/spi/{spi-summary => spi-summary.rst} (93%)
 rename Documentation/spi/{spidev => spidev.rst} (90%)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 38ece18f5d1e..bcaddbfa817f 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -115,6 +115,7 @@ needed).
    power/index
    target/index
    timers/index
+   spi/index
    w1/index
    watchdog/index
    input/index
diff --git a/Documentation/spi/butterfly b/Documentation/spi/butterfly.rst
similarity index 71%
rename from Documentation/spi/butterfly
rename to Documentation/spi/butterfly.rst
index 9927af7a629c..e614a589547c 100644
--- a/Documentation/spi/butterfly
+++ b/Documentation/spi/butterfly.rst
@@ -1,3 +1,4 @@
+===================================================
 spi_butterfly - parport-to-butterfly adapter driver
 ===================================================
 
@@ -27,25 +28,29 @@ need to reflash the firmware, and the pins are the standard Atmel "ISP"
 connector pins (used also on non-Butterfly AVR boards).  On the parport
 side this is like "sp12" programming cables.
 
+	======	  =============	  ===================
 	Signal	  Butterfly	  Parport (DB-25)
-	------	  ---------	  ---------------
-	SCK	= J403.PB1/SCK	= pin 2/D0
-	RESET	= J403.nRST	= pin 3/D1
-	VCC	= J403.VCC_EXT	= pin 8/D6
-	MOSI	= J403.PB2/MOSI	= pin 9/D7
-	MISO	= J403.PB3/MISO	= pin 11/S7,nBUSY
-	GND	= J403.GND	= pin 23/GND
+	======	  =============	  ===================
+	SCK	  J403.PB1/SCK	  pin 2/D0
+	RESET	  J403.nRST	  pin 3/D1
+	VCC	  J403.VCC_EXT	  pin 8/D6
+	MOSI	  J403.PB2/MOSI	  pin 9/D7
+	MISO	  J403.PB3/MISO	  pin 11/S7,nBUSY
+	GND	  J403.GND	  pin 23/GND
+	======	  =============	  ===================
 
 Then to let Linux master that bus to talk to the DataFlash chip, you must
 (a) flash new firmware that disables SPI (set PRR.2, and disable pullups
 by clearing PORTB.[0-3]); (b) configure the mtd_dataflash driver; and
 (c) cable in the chipselect.
 
+	======	  ============	  ===================
 	Signal	  Butterfly	  Parport (DB-25)
-	------	  ---------	  ---------------
-	VCC	= J400.VCC_EXT	= pin 7/D5
-	SELECT	= J400.PB0/nSS	= pin 17/C3,nSELECT
-	GND	= J400.GND	= pin 24/GND
+	======	  ============	  ===================
+	VCC	  J400.VCC_EXT	  pin 7/D5
+	SELECT	  J400.PB0/nSS	  pin 17/C3,nSELECT
+	GND	  J400.GND	  pin 24/GND
+	======	  ============	  ===================
 
 Or you could flash firmware making the AVR into an SPI slave (keeping the
 DataFlash in reset) and tweak the spi_butterfly driver to make it bind to
@@ -56,13 +61,14 @@ That would let you talk to the AVR using custom SPI-with-USI firmware,
 while letting either Linux or the AVR use the DataFlash.  There are plenty
 of spare parport pins to wire this one up, such as:
 
+	======	  =============	  ===================
 	Signal	  Butterfly	  Parport (DB-25)
-	------	  ---------	  ---------------
-	SCK	= J403.PE4/USCK	= pin 5/D3
-	MOSI	= J403.PE5/DI	= pin 6/D4
-	MISO	= J403.PE6/DO	= pin 12/S5,nPAPEROUT
-	GND	= J403.GND	= pin 22/GND
-
-	IRQ	= J402.PF4	= pin 10/S6,ACK
-	GND	= J402.GND(P2)	= pin 25/GND
+	======	  =============	  ===================
+	SCK	  J403.PE4/USCK	  pin 5/D3
+	MOSI	  J403.PE5/DI	  pin 6/D4
+	MISO	  J403.PE6/DO	  pin 12/S5,nPAPEROUT
+	GND	  J403.GND	  pin 22/GND
 
+	IRQ	  J402.PF4	  pin 10/S6,ACK
+	GND	  J402.GND(P2)	  pin 25/GND
+	======	  =============	  ===================
diff --git a/Documentation/spi/index.rst b/Documentation/spi/index.rst
new file mode 100644
index 000000000000..bad6259a7bb6
--- /dev/null
+++ b/Documentation/spi/index.rst
@@ -0,0 +1,23 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================
+Serial Peripheral Interface (SPI)
+=================================
+
+.. toctree::
+   :maxdepth: 1
+
+   spi-summary
+   spidev
+   butterfly
+   pxa2xx
+   spi-lm70llp
+   spi-sc18is602
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
+
diff --git a/Documentation/spi/pxa2xx b/Documentation/spi/pxa2xx.rst
similarity index 83%
rename from Documentation/spi/pxa2xx
rename to Documentation/spi/pxa2xx.rst
index 551325b66b23..457faef8be74 100644
--- a/Documentation/spi/pxa2xx
+++ b/Documentation/spi/pxa2xx.rst
@@ -1,8 +1,10 @@
+==============================
 PXA2xx SPI on SSP driver HOWTO
-===================================================
+==============================
+
 This a mini howto on the pxa2xx_spi driver.  The driver turns a PXA2xx
 synchronous serial port into a SPI master controller
-(see Documentation/spi/spi-summary). The driver has the following features
+(see Documentation/spi/spi-summary.rst). The driver has the following features
 
 - Support for any PXA2xx SSP
 - SSP PIO and SSP DMA data transfers.
@@ -19,12 +21,12 @@ Declaring PXA2xx Master Controllers
 -----------------------------------
 Typically a SPI master is defined in the arch/.../mach-*/board-*.c as a
 "platform device".  The master configuration is passed to the driver via a table
-found in include/linux/spi/pxa2xx_spi.h:
+found in include/linux/spi/pxa2xx_spi.h::
 
-struct pxa2xx_spi_controller {
+  struct pxa2xx_spi_controller {
 	u16 num_chipselect;
 	u8 enable_dma;
-};
+  };
 
 The "pxa2xx_spi_controller.num_chipselect" field is used to determine the number of
 slave device (chips) attached to this SPI master.
@@ -36,9 +38,9 @@ See the "PXA2xx Developer Manual" section "DMA Controller".
 
 NSSP MASTER SAMPLE
 ------------------
-Below is a sample configuration using the PXA255 NSSP.
+Below is a sample configuration using the PXA255 NSSP::
 
-static struct resource pxa_spi_nssp_resources[] = {
+  static struct resource pxa_spi_nssp_resources[] = {
 	[0] = {
 		.start	= __PREG(SSCR0_P(2)), /* Start address of NSSP */
 		.end	= __PREG(SSCR0_P(2)) + 0x2c, /* Range of registers */
@@ -49,14 +51,14 @@ static struct resource pxa_spi_nssp_resources[] = {
 		.end	= IRQ_NSSP,
 		.flags	= IORESOURCE_IRQ,
 	},
-};
+  };
 
-static struct pxa2xx_spi_controller pxa_nssp_master_info = {
+  static struct pxa2xx_spi_controller pxa_nssp_master_info = {
 	.num_chipselect = 1, /* Matches the number of chips attached to NSSP */
 	.enable_dma = 1, /* Enables NSSP DMA */
-};
+  };
 
-static struct platform_device pxa_spi_nssp = {
+  static struct platform_device pxa_spi_nssp = {
 	.name = "pxa2xx-spi", /* MUST BE THIS VALUE, so device match driver */
 	.id = 2, /* Bus number, MUST MATCH SSP number 1..n */
 	.resource = pxa_spi_nssp_resources,
@@ -64,22 +66,22 @@ static struct platform_device pxa_spi_nssp = {
 	.dev = {
 		.platform_data = &pxa_nssp_master_info, /* Passed to driver */
 	},
-};
+  };
 
-static struct platform_device *devices[] __initdata = {
+  static struct platform_device *devices[] __initdata = {
 	&pxa_spi_nssp,
-};
+  };
 
-static void __init board_init(void)
-{
+  static void __init board_init(void)
+  {
 	(void)platform_add_device(devices, ARRAY_SIZE(devices));
-}
+  }
 
 Declaring Slave Devices
 -----------------------
 Typically each SPI slave (chip) is defined in the arch/.../mach-*/board-*.c
 using the "spi_board_info" structure found in "linux/spi/spi.h". See
-"Documentation/spi/spi-summary" for additional information.
+"Documentation/spi/spi-summary.rst" for additional information.
 
 Each slave device attached to the PXA must provide slave specific configuration
 information via the structure "pxa2xx_spi_chip" found in
@@ -87,19 +89,21 @@ information via the structure "pxa2xx_spi_chip" found in
 will uses the configuration whenever the driver communicates with the slave
 device. All fields are optional.
 
-struct pxa2xx_spi_chip {
+::
+
+  struct pxa2xx_spi_chip {
 	u8 tx_threshold;
 	u8 rx_threshold;
 	u8 dma_burst_size;
 	u32 timeout;
 	u8 enable_loopback;
 	void (*cs_control)(u32 command);
-};
+  };
 
 The "pxa2xx_spi_chip.tx_threshold" and "pxa2xx_spi_chip.rx_threshold" fields are
 used to configure the SSP hardware fifo.  These fields are critical to the
 performance of pxa2xx_spi driver and misconfiguration will result in rx
-fifo overruns (especially in PIO mode transfers). Good default values are
+fifo overruns (especially in PIO mode transfers). Good default values are::
 
 	.tx_threshold = 8,
 	.rx_threshold = 8,
@@ -141,41 +145,43 @@ The pxa2xx_spi_chip structure is passed to the pxa2xx_spi driver in the
 "spi_board_info.controller_data" field. Below is a sample configuration using
 the PXA255 NSSP.
 
-/* Chip Select control for the CS8415A SPI slave device */
-static void cs8415a_cs_control(u32 command)
-{
+::
+
+  /* Chip Select control for the CS8415A SPI slave device */
+  static void cs8415a_cs_control(u32 command)
+  {
 	if (command & PXA2XX_CS_ASSERT)
 		GPCR(2) = GPIO_bit(2);
 	else
 		GPSR(2) = GPIO_bit(2);
-}
+  }
 
-/* Chip Select control for the CS8405A SPI slave device */
-static void cs8405a_cs_control(u32 command)
-{
+  /* Chip Select control for the CS8405A SPI slave device */
+  static void cs8405a_cs_control(u32 command)
+  {
 	if (command & PXA2XX_CS_ASSERT)
 		GPCR(3) = GPIO_bit(3);
 	else
 		GPSR(3) = GPIO_bit(3);
-}
+  }
 
-static struct pxa2xx_spi_chip cs8415a_chip_info = {
+  static struct pxa2xx_spi_chip cs8415a_chip_info = {
 	.tx_threshold = 8, /* SSP hardward FIFO threshold */
 	.rx_threshold = 8, /* SSP hardward FIFO threshold */
 	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
 	.timeout = 235, /* See Intel documentation */
 	.cs_control = cs8415a_cs_control, /* Use external chip select */
-};
+  };
 
-static struct pxa2xx_spi_chip cs8405a_chip_info = {
+  static struct pxa2xx_spi_chip cs8405a_chip_info = {
 	.tx_threshold = 8, /* SSP hardward FIFO threshold */
 	.rx_threshold = 8, /* SSP hardward FIFO threshold */
 	.dma_burst_size = 8, /* Byte wide transfers used so 8 byte bursts */
 	.timeout = 235, /* See Intel documentation */
 	.cs_control = cs8405a_cs_control, /* Use external chip select */
-};
+  };
 
-static struct spi_board_info streetracer_spi_board_info[] __initdata = {
+  static struct spi_board_info streetracer_spi_board_info[] __initdata = {
 	{
 		.modalias = "cs8415a", /* Name of spi_driver for this device */
 		.max_speed_hz = 3686400, /* Run SSP as fast a possbile */
@@ -193,13 +199,13 @@ static struct spi_board_info streetracer_spi_board_info[] __initdata = {
 		.controller_data = &cs8405a_chip_info, /* Master chip config */
 		.irq = STREETRACER_APCI_IRQ, /* Slave device interrupt */
 	},
-};
+  };
 
-static void __init streetracer_init(void)
-{
+  static void __init streetracer_init(void)
+  {
 	spi_register_board_info(streetracer_spi_board_info,
 				ARRAY_SIZE(streetracer_spi_board_info));
-}
+  }
 
 
 DMA and PIO I/O Support
@@ -210,22 +216,22 @@ by setting the "enable_dma" flag in the "pxa2xx_spi_controller" structure.  The
 mode supports both coherent and stream based DMA mappings.
 
 The following logic is used to determine the type of I/O to be used on
-a per "spi_transfer" basis:
+a per "spi_transfer" basis::
 
-if !enable_dma then
+  if !enable_dma then
 	always use PIO transfers
 
-if spi_message.len > 8191 then
+  if spi_message.len > 8191 then
 	print "rate limited" warning
 	use PIO transfers
 
-if spi_message.is_dma_mapped and rx_dma_buf != 0 and tx_dma_buf != 0 then
+  if spi_message.is_dma_mapped and rx_dma_buf != 0 and tx_dma_buf != 0 then
 	use coherent DMA mode
 
-if rx_buf and tx_buf are aligned on 8 byte boundary then
+  if rx_buf and tx_buf are aligned on 8 byte boundary then
 	use streaming DMA mode
 
-otherwise
+  otherwise
 	use PIO transfer
 
 THANKS TO
diff --git a/Documentation/spi/spi-lm70llp b/Documentation/spi/spi-lm70llp.rst
similarity index 88%
rename from Documentation/spi/spi-lm70llp
rename to Documentation/spi/spi-lm70llp.rst
index 463f6d01fa15..07631aef4343 100644
--- a/Documentation/spi/spi-lm70llp
+++ b/Documentation/spi/spi-lm70llp.rst
@@ -1,8 +1,11 @@
+==============================================
 spi_lm70llp :  LM70-LLP parport-to-SPI adapter
 ==============================================
 
 Supported board/chip:
+
   * National Semiconductor LM70 LLP evaluation board
+
     Datasheet: http://www.national.com/pf/LM/LM70.html
 
 Author:
@@ -29,9 +32,10 @@ available (on page 4) here:
 
 The hardware interfacing on the LM70 LLP eval board is as follows:
 
+   ======== == =========   ==========
    Parallel                 LM70 LLP
-     Port      Direction   JP2 Header
-   ----------- --------- ----------------
+     Port   .  Direction   JP2 Header
+   ======== == =========   ==========
       D0     2      -         -
       D1     3     -->      V+   5
       D2     4     -->      V+   5
@@ -42,7 +46,7 @@ The hardware interfacing on the LM70 LLP eval board is as follows:
       D7     9     -->      SI/O 5
      GND    25      -       GND  7
     Select  13     <--      SI/O 1
-   ----------- --------- ----------------
+   ======== == =========   ==========
 
 Note that since the LM70 uses a "3-wire" variant of SPI, the SI/SO pin
 is connected to both pin D7 (as Master Out) and Select (as Master In)
@@ -74,6 +78,7 @@ inverting the value read at pin 13.
 
 Thanks to
 ---------
-o David Brownell for mentoring the SPI-side driver development.
-o Dr.Craig Hollabaugh for the (early) "manual" bitbanging driver version.
-o Nadir Billimoria for help interpreting the circuit schematic.
+
+- David Brownell for mentoring the SPI-side driver development.
+- Dr.Craig Hollabaugh for the (early) "manual" bitbanging driver version.
+- Nadir Billimoria for help interpreting the circuit schematic.
diff --git a/Documentation/spi/spi-sc18is602 b/Documentation/spi/spi-sc18is602.rst
similarity index 97%
rename from Documentation/spi/spi-sc18is602
rename to Documentation/spi/spi-sc18is602.rst
index 0feffd5af411..2a31dc722321 100644
--- a/Documentation/spi/spi-sc18is602
+++ b/Documentation/spi/spi-sc18is602.rst
@@ -1,8 +1,11 @@
+===========================
 Kernel driver spi-sc18is602
 ===========================
 
 Supported chips:
+
   * NXP SI18IS602/602B/603
+
     Datasheet: http://www.nxp.com/documents/data_sheet/SC18IS602_602B_603.pdf
 
 Author:
diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary.rst
similarity index 93%
rename from Documentation/spi/spi-summary
rename to Documentation/spi/spi-summary.rst
index 1a63194b74d7..96b3f8b8b3db 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary.rst
@@ -1,3 +1,4 @@
+====================================
 Overview of Linux kernel SPI support
 ====================================
 
@@ -139,12 +140,14 @@ a command and then reading its response.
 
 There are two types of SPI driver, here called:
 
-  Controller drivers ... controllers may be built into System-On-Chip
+  Controller drivers ...
+        controllers may be built into System-On-Chip
 	processors, and often support both Master and Slave roles.
 	These drivers touch hardware registers and may use DMA.
 	Or they can be PIO bitbangers, needing just GPIO pins.
 
-  Protocol drivers ... these pass messages through the controller
+  Protocol drivers ...
+        these pass messages through the controller
 	driver to communicate with a Slave or Master device on the
 	other side of an SPI link.
 
@@ -160,7 +163,7 @@ those two types of drivers.
 There is a minimal core of SPI programming interfaces, focussing on
 using the driver model to connect controller and protocol drivers using
 device tables provided by board specific initialization code.  SPI
-shows up in sysfs in several locations:
+shows up in sysfs in several locations::
 
    /sys/devices/.../CTLR ... physical node for a given SPI controller
 
@@ -206,7 +209,8 @@ Linux needs several kinds of information to properly configure SPI devices.
 That information is normally provided by board-specific code, even for
 chips that do support some of automated discovery/enumeration.
 
-DECLARE CONTROLLERS
+Declare Controllers
+^^^^^^^^^^^^^^^^^^^
 
 The first kind of information is a list of what SPI controllers exist.
 For System-on-Chip (SOC) based boards, these will usually be platform
@@ -221,7 +225,7 @@ same basic controller setup code.  This is because most SOCs have several
 SPI-capable controllers, and only the ones actually usable on a given
 board should normally be set up and registered.
 
-So for example arch/.../mach-*/board-*.c files might have code like:
+So for example arch/.../mach-*/board-*.c files might have code like::
 
 	#include <mach/spi.h>	/* for mysoc_spi_data */
 
@@ -238,7 +242,7 @@ So for example arch/.../mach-*/board-*.c files might have code like:
 		...
 	}
 
-And SOC-specific utility code might look something like:
+And SOC-specific utility code might look something like::
 
 	#include <mach/spi.h>
 
@@ -269,8 +273,8 @@ same SOC controller is used.  For example, on one board SPI might use
 an external clock, where another derives the SPI clock from current
 settings of some master clock.
 
-
-DECLARE SLAVE DEVICES
+Declare Slave Devices
+^^^^^^^^^^^^^^^^^^^^^
 
 The second kind of information is a list of what SPI slave devices exist
 on the target board, often with some board-specific data needed for the
@@ -278,7 +282,7 @@ driver to work correctly.
 
 Normally your arch/.../mach-*/board-*.c files would provide a small table
 listing the SPI devices on each board.  (This would typically be only a
-small handful.)  That might look like:
+small handful.)  That might look like::
 
 	static struct ads7846_platform_data ads_info = {
 		.vref_delay_usecs	= 100,
@@ -316,7 +320,7 @@ not possible until the infrastructure knows how to deselect it.
 
 Then your board initialization code would register that table with the SPI
 infrastructure, so that it's available later when the SPI master controller
-driver is registered:
+driver is registered::
 
 	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
 
@@ -324,12 +328,13 @@ Like with other static board-specific setup, you won't unregister those.
 
 The widely used "card" style computers bundle memory, cpu, and little else
 onto a card that's maybe just thirty square centimeters.  On such systems,
-your arch/.../mach-.../board-*.c file would primarily provide information
+your ``arch/.../mach-.../board-*.c`` file would primarily provide information
 about the devices on the mainboard into which such a card is plugged.  That
 certainly includes SPI devices hooked up through the card connectors!
 
 
-NON-STATIC CONFIGURATIONS
+Non-static Configurations
+^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Developer boards often play by different rules than product boards, and one
 example is the potential need to hotplug SPI devices and/or controllers.
@@ -349,7 +354,7 @@ How do I write an "SPI Protocol Driver"?
 Most SPI drivers are currently kernel drivers, but there's also support
 for userspace drivers.  Here we talk only about kernel drivers.
 
-SPI protocol drivers somewhat resemble platform device drivers:
+SPI protocol drivers somewhat resemble platform device drivers::
 
 	static struct spi_driver CHIP_driver = {
 		.driver = {
@@ -367,6 +372,8 @@ device whose board_info gave a modalias of "CHIP".  Your probe() code
 might look like this unless you're creating a device which is managing
 a bus (appearing under /sys/class/spi_master).
 
+::
+
 	static int CHIP_probe(struct spi_device *spi)
 	{
 		struct CHIP			*chip;
@@ -479,6 +486,8 @@ The main task of this type of driver is to provide an "spi_master".
 Use spi_alloc_master() to allocate the master, and spi_master_get_devdata()
 to get the driver-private data allocated for that device.
 
+::
+
 	struct spi_master	*master;
 	struct CONTROLLER	*c;
 
@@ -503,7 +512,8 @@ If you need to remove your SPI controller driver, spi_unregister_master()
 will reverse the effect of spi_register_master().
 
 
-BUS NUMBERING
+Bus Numbering
+^^^^^^^^^^^^^
 
 Bus numbering is important, since that's how Linux identifies a given
 SPI bus (shared SCK, MOSI, MISO).  Valid bus numbers start at zero.  On
@@ -517,9 +527,10 @@ then be replaced by a dynamically assigned number. You'd then need to treat
 this as a non-static configuration (see above).
 
 
-SPI MASTER METHODS
+SPI Master Methods
+^^^^^^^^^^^^^^^^^^
 
-    master->setup(struct spi_device *spi)
+``master->setup(struct spi_device *spi)``
 	This sets up the device clock rate, SPI mode, and word sizes.
 	Drivers may change the defaults provided by board_info, and then
 	call spi_setup(spi) to invoke this routine.  It may sleep.
@@ -528,37 +539,37 @@ SPI MASTER METHODS
 	change them right away ... otherwise drivers could corrupt I/O
 	that's in progress for other SPI devices.
 
-		** BUG ALERT:  for some reason the first version of
-		** many spi_master drivers seems to get this wrong.
-		** When you code setup(), ASSUME that the controller
-		** is actively processing transfers for another device.
+	.. note::
 
-    master->cleanup(struct spi_device *spi)
+		BUG ALERT:  for some reason the first version of
+		many spi_master drivers seems to get this wrong.
+		When you code setup(), ASSUME that the controller
+		is actively processing transfers for another device.
+
+``master->cleanup(struct spi_device *spi)``
 	Your controller driver may use spi_device.controller_state to hold
 	state it dynamically associates with that device.  If you do that,
 	be sure to provide the cleanup() method to free that state.
 
-    master->prepare_transfer_hardware(struct spi_master *master)
+``master->prepare_transfer_hardware(struct spi_master *master)``
 	This will be called by the queue mechanism to signal to the driver
 	that a message is coming in soon, so the subsystem requests the
 	driver to prepare the transfer hardware by issuing this call.
 	This may sleep.
 
-    master->unprepare_transfer_hardware(struct spi_master *master)
+``master->unprepare_transfer_hardware(struct spi_master *master)``
 	This will be called by the queue mechanism to signal to the driver
 	that there are no more messages pending in the queue and it may
 	relax the hardware (e.g. by power management calls). This may sleep.
 
-    master->transfer_one_message(struct spi_master *master,
-				 struct spi_message *mesg)
+``master->transfer_one_message(struct spi_master *master, struct spi_message *mesg)``
 	The subsystem calls the driver to transfer a single message while
 	queuing transfers that arrive in the meantime. When the driver is
 	finished with this message, it must call
 	spi_finalize_current_message() so the subsystem can issue the next
 	message. This may sleep.
 
-    master->transfer_one(struct spi_master *master, struct spi_device *spi,
-			 struct spi_transfer *transfer)
+``master->transfer_one(struct spi_master *master, struct spi_device *spi, struct spi_transfer *transfer)``
 	The subsystem calls the driver to transfer a single transfer while
 	queuing transfers that arrive in the meantime. When the driver is
 	finished with this transfer, it must call
@@ -568,19 +579,20 @@ SPI MASTER METHODS
 	not call your transfer_one callback.
 
 	Return values:
-	negative errno: error
-	0: transfer is finished
-	1: transfer is still in progress
 
-    master->set_cs_timing(struct spi_device *spi, u8 setup_clk_cycles,
-			      u8 hold_clk_cycles, u8 inactive_clk_cycles)
+	* negative errno: error
+	* 0: transfer is finished
+	* 1: transfer is still in progress
+
+``master->set_cs_timing(struct spi_device *spi, u8 setup_clk_cycles, u8 hold_clk_cycles, u8 inactive_clk_cycles)``
 	This method allows SPI client drivers to request SPI master controller
 	for configuring device specific CS setup, hold and inactive timing
 	requirements.
 
-    DEPRECATED METHODS
+Deprecated Methods
+^^^^^^^^^^^^^^^^^^
 
-    master->transfer(struct spi_device *spi, struct spi_message *message)
+``master->transfer(struct spi_device *spi, struct spi_message *message)``
 	This must not sleep. Its responsibility is to arrange that the
 	transfer happens and its complete() callback is issued. The two
 	will normally happen later, after other transfers complete, and
@@ -590,7 +602,8 @@ SPI MASTER METHODS
 	implemented.
 
 
-SPI MESSAGE QUEUE
+SPI Message Queue
+^^^^^^^^^^^^^^^^^
 
 If you are happy with the standard queueing mechanism provided by the
 SPI subsystem, just implement the queued methods specified above. Using
@@ -619,13 +632,13 @@ THANKS TO
 Contributors to Linux-SPI discussions include (in alphabetical order,
 by last name):
 
-Mark Brown
-David Brownell
-Russell King
-Grant Likely
-Dmitry Pervushin
-Stephen Street
-Mark Underwood
-Andrew Victor
-Linus Walleij
-Vitaly Wool
+- Mark Brown
+- David Brownell
+- Russell King
+- Grant Likely
+- Dmitry Pervushin
+- Stephen Street
+- Mark Underwood
+- Andrew Victor
+- Linus Walleij
+- Vitaly Wool
diff --git a/Documentation/spi/spidev b/Documentation/spi/spidev.rst
similarity index 90%
rename from Documentation/spi/spidev
rename to Documentation/spi/spidev.rst
index 3d14035b1766..f05dbc5ccdbc 100644
--- a/Documentation/spi/spidev
+++ b/Documentation/spi/spidev.rst
@@ -1,7 +1,13 @@
+=================
+SPI userspace API
+=================
+
 SPI devices have a limited userspace API, supporting basic half-duplex
 read() and write() access to SPI slave devices.  Using ioctl() requests,
 full duplex transfers and device I/O configuration are also available.
 
+::
+
 	#include <fcntl.h>
 	#include <unistd.h>
 	#include <sys/ioctl.h>
@@ -39,14 +45,17 @@ device node with a "dev" attribute that will be understood by udev or mdev.
 busybox; it's less featureful, but often enough.)  For a SPI device with
 chipselect C on bus B, you should see:
 
-    /dev/spidevB.C ... character special device, major number 153 with
+    /dev/spidevB.C ...
+	character special device, major number 153 with
 	a dynamically chosen minor device number.  This is the node
 	that userspace programs will open, created by "udev" or "mdev".
 
-    /sys/devices/.../spiB.C ... as usual, the SPI device node will
+    /sys/devices/.../spiB.C ...
+	as usual, the SPI device node will
 	be a child of its SPI master controller.
 
-    /sys/class/spidev/spidevB.C ... created when the "spidev" driver
+    /sys/class/spidev/spidevB.C ...
+	created when the "spidev" driver
 	binds to that device.  (Directory or symlink, based on whether
 	or not you enabled the "deprecated sysfs files" Kconfig option.)
 
@@ -80,7 +89,8 @@ the SPI_IOC_MESSAGE(N) request.
 Several ioctl() requests let your driver read or override the device's current
 settings for data transfer parameters:
 
-    SPI_IOC_RD_MODE, SPI_IOC_WR_MODE ... pass a pointer to a byte which will
+    SPI_IOC_RD_MODE, SPI_IOC_WR_MODE ...
+	pass a pointer to a byte which will
 	return (RD) or assign (WR) the SPI transfer mode.  Use the constants
 	SPI_MODE_0..SPI_MODE_3; or if you prefer you can combine SPI_CPOL
 	(clock polarity, idle high iff this is set) or SPI_CPHA (clock phase,
@@ -88,22 +98,26 @@ settings for data transfer parameters:
 	Note that this request is limited to SPI mode flags that fit in a
 	single byte.
 
-    SPI_IOC_RD_MODE32, SPI_IOC_WR_MODE32 ... pass a pointer to a uin32_t
+    SPI_IOC_RD_MODE32, SPI_IOC_WR_MODE32 ...
+	pass a pointer to a uin32_t
 	which will return (RD) or assign (WR) the full SPI transfer mode,
 	not limited to the bits that fit in one byte.
 
-    SPI_IOC_RD_LSB_FIRST, SPI_IOC_WR_LSB_FIRST ... pass a pointer to a byte
+    SPI_IOC_RD_LSB_FIRST, SPI_IOC_WR_LSB_FIRST ...
+	pass a pointer to a byte
 	which will return (RD) or assign (WR) the bit justification used to
 	transfer SPI words.  Zero indicates MSB-first; other values indicate
 	the less common LSB-first encoding.  In both cases the specified value
 	is right-justified in each word, so that unused (TX) or undefined (RX)
 	bits are in the MSBs.
 
-    SPI_IOC_RD_BITS_PER_WORD, SPI_IOC_WR_BITS_PER_WORD ... pass a pointer to
+    SPI_IOC_RD_BITS_PER_WORD, SPI_IOC_WR_BITS_PER_WORD ...
+	pass a pointer to
 	a byte which will return (RD) or assign (WR) the number of bits in
 	each SPI transfer word.  The value zero signifies eight bits.
 
-    SPI_IOC_RD_MAX_SPEED_HZ, SPI_IOC_WR_MAX_SPEED_HZ ... pass a pointer to a
+    SPI_IOC_RD_MAX_SPEED_HZ, SPI_IOC_WR_MAX_SPEED_HZ ...
+	pass a pointer to a
 	u32 which will return (RD) or assign (WR) the maximum SPI transfer
 	speed, in Hz.  The controller can't necessarily assign that specific
 	clock speed.
diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index d28974ad9e0e..6cb02299a215 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -695,7 +695,7 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
  * i2c:
  * Documentation/i2c/writing-clients.rst
  * spi:
- * Documentation/spi/spi-summary
+ * Documentation/spi/spi-summary.rst
  */
 static const struct iio_sw_device_ops iio_dummy_device_ops = {
 	.probe = iio_dummy_probe,
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3a1d8f1170de..d5a24fe983e7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -543,7 +543,7 @@ config SPI_PXA2XX
 	help
 	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
 	  controller. The driver can be configured to use any SSP port and
-	  additional documentation can be found a Documentation/spi/pxa2xx.
+	  additional documentation can be found a Documentation/spi/pxa2xx.rst.
 
 config SPI_PXA2XX_PCI
 	def_tristate SPI_PXA2XX && PCI && COMMON_CLK
diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index 8c77d1114ad3..7e71a351f3b7 100644
--- a/drivers/spi/spi-butterfly.c
+++ b/drivers/spi/spi-butterfly.c
@@ -23,7 +23,7 @@
  * with a battery powered AVR microcontroller and lots of goodies.  You
  * can use GCC to develop firmware for this.
  *
- * See Documentation/spi/butterfly for information about how to build
+ * See Documentation/spi/butterfly.rst for information about how to build
  * and use this custom parallel port cable.
  */
 
diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index f18f912c9dea..174dba29b1dd 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -34,7 +34,7 @@
  * available (on page 4) here:
  *  http://www.national.com/appinfo/tempsensors/files/LM70LLPEVALmanual.pdf
  *
- * Also see Documentation/spi/spi-lm70llp.  The SPI<->parport code here is
+ * Also see Documentation/spi/spi-lm70llp.rst.  The SPI<->parport code here is
  * (heavily) based on spi-butterfly by David Brownell.
  *
  * The LM70 LLP connects to the PC parallel port in the following manner:
diff --git a/include/linux/platform_data/sc18is602.h b/include/linux/platform_data/sc18is602.h
index e066d3b0d6d8..0e91489edfe6 100644
--- a/include/linux/platform_data/sc18is602.h
+++ b/include/linux/platform_data/sc18is602.h
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2012 Guenter Roeck <linux@roeck-us.net>
  *
- * For further information, see the Documentation/spi/spi-sc18is602 file.
+ * For further information, see the Documentation/spi/spi-sc18is602.rst file.
  */
 
 /**
-- 
2.21.0

