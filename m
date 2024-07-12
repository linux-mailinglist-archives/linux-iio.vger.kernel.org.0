Return-Path: <linux-iio+bounces-7566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DED19300CE
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 21:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A951F1F23263
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 19:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5E282F4;
	Fri, 12 Jul 2024 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="k7X99EGj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43521340;
	Fri, 12 Jul 2024 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812076; cv=none; b=cyef8RTzZkswWhrvS8MqhKDhxhs76Ol3SqgE60eUnqFrAzsGdrPknvlrdq6QbOqcOcDO9xAPy4sM4pVgSXec+MizAY7EeRe/4hXakhwgJUYIEqAVPtLBZARKrm37pYVIydMMUqoKvlIHb1YAaRbV23HWiTOSDE9zBJH0sHH7qoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812076; c=relaxed/simple;
	bh=EF8JQWDuWvKr807E12dlTmePe+3zXvkPA0OlEj6QCsM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFPQFLa9QrgcIV6vsEXU2GDWKT84lOsK+cC9i0w5QF05D+5o6uzGdN9kfbMYQNTQNm4cV/yyIx9Bexmb5G5WT7mlYh+ge8/9wdkrxnmZgP5vCcRQxy/AcFHV3mKyuf1ICN2gGgcur7uDz8TkH/8Tc5cge4uuXxvg42Jbz71LA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=k7X99EGj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CH32f5007173;
	Fri, 12 Jul 2024 15:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0iVaf
	gOIMreGaaicZbTCuawP5WWF1GJu6ylqlcjoRAE=; b=k7X99EGjMGuvXgrKOleEm
	B0UMigLaH5j9tKv23iz3paYiM4yKtDswVxTsC80JZ0b5hJ3/oFcQBjpudrV2tkBl
	aZ7j3QgYS6Xc46MsUpuSO9GD2SUytcs/XzSC7gZ3fK4oKsOZ7XOZRjYdRPUBZGPM
	W7Al5GoX9h7QbfgbtqQ42zhgsm3OHHmysHAPtEmK8PpVRjmAZTv+V/RUwr7/Sf9E
	Bg5GATipUVynOIBc4YfXDBUKT7AZVo94o/zk04UmmrswpCHBgXtrOq2FBb/pLhIC
	jZF89xYISpPZGQ4DCR9SI2bmHxT+gBdEtn1I5/Zjp7T7uNllSXP0nCmQ5ZBGJPcl
	A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40b2qp1gxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 15:20:58 -0400 (EDT)
Received: from m0375855.ppops.net (m0375855.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46CJKv0g012834;
	Fri, 12 Jul 2024 15:20:57 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40b2qp1gxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 15:20:57 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46CJKuK9009420
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jul 2024 15:20:56 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 12 Jul 2024 15:20:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 12 Jul 2024 15:20:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 12 Jul 2024 15:20:55 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46CJKawU004342;
	Fri, 12 Jul 2024 15:20:39 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 1/7] spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
Date: Fri, 12 Jul 2024 16:20:36 -0300
Message-ID: <9802160b5e5baed7f83ee43ac819cb757a19be55.1720810545.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1720810545.git.marcelo.schmitt@analog.com>
References: <cover.1720810545.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: hiFnea93k3AslcgAJj0YySYlRJMIcBIR
X-Proofpoint-ORIG-GUID: XLLJW_fi5dmDfk__ebBzVsjqsL3Dl45g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120130

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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Tested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/spi/spi-summary.rst | 83 +++++++++++++++++++++++++++++++
 drivers/spi/spi.c                 |  6 +++
 include/uapi/linux/spi/spi.h      |  5 +-
 3 files changed, 92 insertions(+), 2 deletions(-)

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
index c957a7710777..04826f6a7dda 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3944,6 +3944,12 @@ int spi_setup(struct spi_device *spi)
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


