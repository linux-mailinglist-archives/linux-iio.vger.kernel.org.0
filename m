Return-Path: <linux-iio+bounces-7060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1091CEAD
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 21:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B83282CD2
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F45139579;
	Sat, 29 Jun 2024 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xcsQISrp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE35686636;
	Sat, 29 Jun 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719687921; cv=none; b=MPrT9vlEgNdi3UK2SEVZuXOqk6/4riP4kFERAOn1Loscfd4uNHCv2guiqfcqsRwyHpXTWPHJdo1fmnN8C1eCLcemr4bNKldrPjAcZQE/necGlbsJhy8gjHS6BJx6P93B+DYTbhdSbyZWtZ9drf0ujJD+9AvNsn2wJzvw+vJCc28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719687921; c=relaxed/simple;
	bh=e/C8R8+GeBjP/3lzWt4dmGA/fFL2qdvIypLr+8Tq//8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lq7Q6E1JU9MXHdsEcdqrKV1UXi/hftMwdgU5qA6mTQB6y62cC5yQ2SszzItVbsSqFhBphD5Q8+g4WhFRy5XCc7Mm+mBxl6c+WUpTjaDrDtjKQ3dZAf6oneRUwCb7w8Hl7WeElbotv63tlMpXzqB2UQO0vj+pt+fNhfFCMN3xGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xcsQISrp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45T92kKH003733;
	Sat, 29 Jun 2024 15:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XxHoc
	IhLZgt1XMYqTo0cxS2GxaPCSePyTL6hhJ15S3g=; b=xcsQISrpfYpgvDneEWurS
	Nmhwk/RujWoQUB5V9zd8tIhCg06u8VIj0O3siA3+rBhYigL0jqn4eDbjSWqomVBd
	S6A+4tAuKAddzWMpYnBmMZNvNpW2qeXb9rTPn/tDhilEJazR2uAJRZjIlm9v3/nq
	Zv3AJFZhE7pD1mT6oiR7UfFxcQrqoIS4w7QE0Yu3tnJTWtBtTNh1kum9Zqlt11oy
	Vo/ag5FMLCaFSMgqZZueGGbkMi0DVsLOVWwybYcnDvlIb7KC2RlWVdkheiIqJabl
	SrM1Kyi/ft9hI9W26+Ab7Rjsl6Okw/2LNyOslAvVDtJcnu45vldB9I1i2RUfHis3
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 402f9u0ym4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 15:05:03 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45TJ523s046801
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 29 Jun 2024 15:05:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sat, 29 Jun
 2024 15:05:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 29 Jun 2024 15:05:01 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45TJ4gAn001328;
	Sat, 29 Jun 2024 15:04:44 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/7] spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
Date: Sat, 29 Jun 2024 16:04:40 -0300
Message-ID: <7eb23146ad6bf6090183c6340e4d59cb269d83a7.1719686465.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1719686465.git.marcelo.schmitt@analog.com>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ljdyvD0VxO7uWNJHNo00xZtqNIQsHaA8
X-Proofpoint-GUID: ljdyvD0VxO7uWNJHNo00xZtqNIQsHaA8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406290138

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

Acked-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/spi/spi-summary.rst | 83 +++++++++++++++++++++++++++++++
 drivers/spi/spi.c                 |  7 +++
 include/uapi/linux/spi/spi.h      |  5 +-
 3 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index 7f8accfae6f9..6e21e6f86912 100644
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
+that other SPI protocols don't (e.g. data line state for when CS is not
+asserted). Those distinct SPI protocols, modes, and configurations are supported
+by different SPI mode flags.
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
index 93f59ebb5b79..c8ba5e490850 100644
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


