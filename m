Return-Path: <linux-iio+bounces-6923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A38F9173BE
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 23:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF371C24C0D
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6FC17E918;
	Tue, 25 Jun 2024 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="c9hzCpb6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049117E8E4;
	Tue, 25 Jun 2024 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352439; cv=none; b=eHIZlmc1u+QvhVq0/pT4fd2dhhQAdO0al98DKdgVlPaR+WWJyOIMGFLYhsRm5libE0gbih9TmJjQYFUJwKyZfJopQCYPBtuMYakfTunr9/lfS5m3SlyoeGUTo564ti3lIILhntYn0z1pq5PKkFrtWCKiqKUlIOcy6IXUEZuInEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352439; c=relaxed/simple;
	bh=Lr7wtAwe8WeXVNpahRAngjMhyDdLYvVSZVwSfGEv7Bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzl+Jy8+z4BTPY1jpoFOn/yqNehvhIv8X+7v0R+37+cZAgST/MubxQO52b8DZSrp0aGFSsdMGLZPHp1igEZQhh4u72k2gx9npAKbNHzqoi7t/7rGPPkAscKDi1wfwo8+IYu8wjXxinm4Nzh0rrGYRPo1PCi9+esSI9/WFfa+V8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=c9hzCpb6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PKdwaX011736;
	Tue, 25 Jun 2024 17:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bmLzT
	76BtpAvtD6539uOtN5jI2JdB6MmcU1lBv4m6s0=; b=c9hzCpb6eTz6KtqUDhP8f
	cN5fUshnhVtGDs5uJ55Cb9PnR57CdGF920AEA6J+/3hdDV6E8xpBvLBg9l9LC+iS
	bjQhkJmCQQQ8BiW3t+X4ugrjkKAlgCfOmLph4nUFnz/z9DUIZ24uZhot1cdRJKbm
	DWfb2IHzcIHeuxspnqfyD/6NDJeAsRyIJgIADDOA3P2lFvFqQUxpkjjVshBKwpLB
	ssVTtn1ACtjvwjDYqkC3yp0NrELXmJzX71TUboLNSIfMcZI8wqpTB2uZu31Ac0Vw
	dxQA6fzZcbsBqLuqzscHhzXLZOO1AJvntdXTsGWQBW9PWLi3t0U/+RpwI4g9PArN
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yyum1aa3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:53:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45PLrd0H006965
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 17:53:39 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 25 Jun 2024 17:53:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 25 Jun 2024 17:53:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 25 Jun 2024 17:53:37 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45PLrJF9013797;
	Tue, 25 Jun 2024 17:53:22 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/7] spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
Date: Tue, 25 Jun 2024 18:53:18 -0300
Message-ID: <add14694c64b574af742a5dcd5c9461e0ef5210a.1719351923.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1719351923.git.marcelo.schmitt@analog.com>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: VQKBQQdFEOX4cnt581vG677GvJaKNfJx
X-Proofpoint-ORIG-GUID: VQKBQQdFEOX4cnt581vG677GvJaKNfJx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406250163

The behavior of an SPI controller data output line (SDO or MOSI or COPI
(Controller Output Peripheral Input) for disambiguation) is usually not
specified when the controller is not clocking out data on SCLK edges.
However, there do exist SPI peripherals that require specific MOSI line
state when data is not being clocked out of the controller.

Conventional SPI controllers may set the MOSI line on SCLK edges then bring
it low when no data is going out or leave the line the state of the last
transfer bit. More elaborated controllers are capable to set the MOSI idle
state according to different configurable levels and thus are more suitable
for interfacing with demanding peripherals.

Add SPI mode bits to allow peripherals to request explicit MOSI idle state
when needed.

When supporting a particular MOSI idle configuration, the data output line
state is expected to remain at the configured level when the controller is
not clocking out data. When a device that needs a specific MOSI idle state
is identified, its driver should request the MOSI idle configuration by
setting the proper SPI mode bit.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/spi/spi-summary.rst | 83 +++++++++++++++++++++++++++++++
 drivers/spi/spi.c                 |  7 +++
 include/linux/spi/spi.h           |  6 +++
 include/uapi/linux/spi/spi.h      |  5 +-
 4 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index 7f8accfae6f9..51dd8a105b7e 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -614,6 +614,89 @@ queue, and then start some asynchronous transfer engine (unless it's
 already running).
 
 
+Extensions to the SPI protocol
+------------------------------
+The fact that SPI doesn't have a formal specification or standard permits chip
+manufacturers to implement the SPI protocol in slightly different ways. In most
+cases, SPI protocol implementations from different vendors are compatible among
+each other. For example, in SPI mode 0 (CPOL=0, CPHA=0) the bus lines may behave
+like the following:
+
+::
+
+  nCSx ___                                                                   ___
+          \_________________________________________________________________/
+          •                                                                 •
+          •                                                                 •
+  SCLK         ___     ___     ___     ___     ___     ___     ___     ___
+       _______/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \_____
+          •   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ; •
+          •   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ; •
+  MOSI XXX__________         _______                 _______         ________XXX
+  0xA5 XXX__/ 1     \_0_____/ 1     \_0_______0_____/ 1     \_0_____/ 1    \_XXX
+          •       ;       ;       ;       ;       ;       ;       ;       ; •
+          •       ;       ;       ;       ;       ;       ;       ;       ; •
+  MISO XXX__________         _______________________          _______        XXX
+  0xBA XXX__/     1 \_____0_/     1       1       1 \_____0__/    1  \____0__XXX
+
+Legend::
+
+  • marks the start/end of transmission;
+  : marks when data is clocked into the peripheral;
+  ; marks when data is clocked into the controller;
+  X marks when line states are not specified.
+
+In some few cases, chips extend the SPI protocol by specifying line behaviors
+that other SPI protocols don't (e.g. data line state for when CS is inactive).
+Those distinct SPI protocols, modes, and configurations are supported by
+different SPI mode flags.
+
+MOSI idle state configuration
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Common SPI protocol implementations don't specify any state or behavior for the
+MOSI line when the controller is not clocking out data. However, there do exist
+peripherals that require specific MOSI line state when data is not being clocked
+out. For example, if the peripheral expects the MOSI line to be high when the
+controller is not clocking out data (``SPI_MOSI_IDLE_HIGH``), then a transfer in
+SPI mode 0 would look like the following:
+
+::
+
+  nCSx ___                                                                   ___
+          \_________________________________________________________________/
+          •                                                                 •
+          •                                                                 •
+  SCLK         ___     ___     ___     ___     ___     ___     ___     ___
+       _______/   \___/   \___/   \___/   \___/   \___/   \___/   \___/   \_____
+          •   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ; •
+          •   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ;   :   ; •
+  MOSI _____         _______         _______         _______________         ___
+  0x56      \_0_____/ 1     \_0_____/ 1     \_0_____/ 1       1     \_0_____/
+          •       ;       ;       ;       ;       ;       ;       ;       ; •
+          •       ;       ;       ;       ;       ;       ;       ;       ; •
+  MISO XXX__________         _______________________          _______        XXX
+  0xBA XXX__/     1 \_____0_/     1       1       1 \_____0__/    1  \____0__XXX
+
+Legend::
+
+  • marks the start/end of transmission;
+  : marks when data is clocked into the peripheral;
+  ; marks when data is clocked into the controller;
+  X marks when line states are not specified.
+
+In this extension to the usual SPI protocol, the MOSI line state is specified to
+be kept high when CS is asserted but the controller is not clocking out data to
+the peripheral and also when CS is not asserted.
+
+Peripherals that require this extension must request it by setting the
+``SPI_MOSI_IDLE_HIGH`` bit into the mode attribute of their ``struct
+spi_device`` and call spi_setup(). Controllers that support this extension
+should indicate it by setting ``SPI_MOSI_IDLE_HIGH`` in the mode_bits attribute
+of their ``struct spi_controller``. The configuration to idle MOSI low is
+analogous but uses the ``SPI_MOSI_IDLE_LOW`` mode bit.
+
+
 THANKS TO
 ---------
 Contributors to Linux-SPI discussions include (in alphabetical order,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9bc9fd10d538..341803110a06 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3942,6 +3942,12 @@ int spi_setup(struct spi_device *spi)
 		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
 		 SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL)))
 		return -EINVAL;
+	/* Check against conflicting MOSI idle configuration */
+	if ((spi->mode & SPI_MOSI_IDLE_LOW) && (spi->mode & SPI_MOSI_IDLE_HIGH)) {
+		dev_err(&spi->dev,
+			"setup: MOSI configured to idle low and high at the same time.\n");
+		return -EINVAL;
+	}
 	/*
 	 * Help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current controller.
@@ -3950,6 +3956,7 @@ int spi_setup(struct spi_device *spi)
 	 */
 	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
 				 SPI_NO_TX | SPI_NO_RX);
+
 	ugly_bits = bad_bits &
 		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
 		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e8e1e798924f..8e50a8559225 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -599,6 +599,12 @@ struct spi_controller {
 	 * assert/de-assert more than one chip select at once.
 	 */
 #define SPI_CONTROLLER_MULTI_CS		BIT(7)
+	/*
+	 * The spi-controller is capable of keeping the MOSI line low or high
+	 * when not clocking out data.
+	 */
+#define SPI_CONTROLLER_MOSI_IDLE_LOW    BIT(8)  /* Can idle MOSI low */
+#define SPI_CONTROLLER_MOSI_IDLE_HIGH   BIT(9)  /* Can idle MOSI high */
 
 	/* Flag indicating if the allocation of this struct is devres-managed */
 	bool			devm_allocated;
diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
index ca56e477d161..ee4ac812b8f8 100644
--- a/include/uapi/linux/spi/spi.h
+++ b/include/uapi/linux/spi/spi.h
@@ -28,7 +28,8 @@
 #define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
 #define	SPI_RX_CPHA_FLIP	_BITUL(16)	/* flip CPHA on Rx only xfer */
-#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
+#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave MOSI line low when idle */
+#define SPI_MOSI_IDLE_HIGH	_BITUL(18)	/* leave MOSI line high when idle */
 
 /*
  * All the bits defined above should be covered by SPI_MODE_USER_MASK.
@@ -38,6 +39,6 @@
  * These bits must not overlap. A static assert check should make sure of that.
  * If adding extra bits, make sure to increase the bit index below as well.
  */
-#define SPI_MODE_USER_MASK	(_BITUL(18) - 1)
+#define SPI_MODE_USER_MASK	(_BITUL(19) - 1)
 
 #endif /* _UAPI_SPI_H */
-- 
2.43.0


