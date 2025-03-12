Return-Path: <linux-iio+bounces-16745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F4A5E05B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 16:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C881D1696CC
	for <lists+linux-iio@lfdr.de>; Wed, 12 Mar 2025 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BFD24DFF8;
	Wed, 12 Mar 2025 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPja19er"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED7D1E493;
	Wed, 12 Mar 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793396; cv=none; b=dNYh9qRw/pFfQ5OMfyg2CDgPK89IEVTb6YOivLsRFOamVNK/89A1Va/6+v47/eLX6bTLO8qW303GvQHnsyhuSNJLXTVNfw45RmeuZdoVRHo6NmUfWhogVUK5Tit6cVjKiJqvVtCxtqgSgdI0lellA2WLKVFuEK8+wvKwRI/hjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793396; c=relaxed/simple;
	bh=FSXBX4j7B7b+XnlTLJ17zxN4ccJzAqSAdocTOkuwjFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a68ZYlVaeT11MQY8xFcG3nurOSlsbc1b9bEXmbS9Ybe2Kn/qsAV0FASsBQ3FTojsFy+n21z2ZUkIbtq4Aau1nVzjuGqG0cjSuvZErsCWqGZ10xiqvtWbPzuAp5eDK3hRpaz2SX+pUu7T7NsWxTh+kr1U6wXcL4p+LqmTmkconM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPja19er; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62444C4CEEC;
	Wed, 12 Mar 2025 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741793394;
	bh=FSXBX4j7B7b+XnlTLJ17zxN4ccJzAqSAdocTOkuwjFE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=FPja19erujvsYrf3tmXvsIjEPGgfu98M/ReHdy+PozpROvc1p5nU5k2hUK5cfXD+O
	 aQqHao/nMuLNz/jlkuRGxr9LG9Kd327socaBoD+wHIeg7rw/jpa2D12L39l0C4wlNI
	 TCPy0dQ2bNb6g0WiK4F2B/bmK2+Ekq5WlSjMrmNitt3otjEHYtVma7cS9+FeQyOLa5
	 4g/12xhCG2FuoTtu3XouKDjHRevREEmmiSatX0XM7OfArf6thntgMpbEww52OVpxrK
	 dj/93O+KJJNN91g+JKnh2U8mORPjNwBPgtcm2ksmSwLVxWnks+6ldo7DbIWbmGVC6J
	 M9751FzDikTiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5116DC28B28;
	Wed, 12 Mar 2025 15:29:54 +0000 (UTC)
From: Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org>
Date: Wed, 12 Mar 2025 16:29:40 +0100
Subject: [PATCH] iio: adc: sort TI drivers alphanumerical
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-sort_ti_drivers-v1-1-4e8813e662d2@softing.com>
X-B4-Tracking: v=1; b=H4sIAGOo0WcC/x3MPQqAMAxA4atIZgu1Pw5eRaQUGzWLSiJFKL27x
 fEb3isgyIQCU1eAMZPQdTYMfQfrEc8dFaVmMNp4bQej5OInPBQSU0YWpZ21Y9RjdMZDq27Gjd7
 /OC+1fsa55R5hAAAA
X-Change-ID: 20250312-sort_ti_drivers-04336a06a425
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tobias Sperling <tobias.sperling@softing.com>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741793385; l=5636;
 i=tobias.sperling@softing.com; s=20241122; h=from:subject:message-id;
 bh=pr36xwj3Tb4zVizwF/veJfHorhZaS8NYWrN5ZPaOFoY=;
 b=qTX1AO98j3b96kwWP2rf/qDe9PH+ILdOpWXtlmNDK2GCf1+oqdC8FkSNGwQlQisyzCGFJuyGZ
 XnxwQLOeCk6Ds+VXUrVDbxr6VXCUUIQuHFhNYoBNK3q0f6RaGxD0XHe
X-Developer-Key: i=tobias.sperling@softing.com; a=ed25519;
 pk=v7hgaMHsrA9ul4UXkBVUuwusS9PF3uHW/CC+gABI65E=
X-Endpoint-Received: by B4 Relay for tobias.sperling@softing.com/20241122
 with auth_id=281
X-Original-From: Tobias Sperling <tobias.sperling@softing.com>
Reply-To: tobias.sperling@softing.com

From: Tobias Sperling <tobias.sperling@softing.com>

Sort TI drivers again in an alphanumerical manner.

Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
---
At some point the order of TI IIO ADC drivers
was scrambled up and is now brought back to
alphanumerical order.
---
 drivers/iio/adc/Kconfig | 114 ++++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6529df1a498c2c3b32b3640b5c3a90d8fff33788..75ed633a3c43d176a4e73e341eea3fef890325d0 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1440,18 +1440,6 @@ config TI_ADC084S021
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-adc084s021.
 
-config TI_ADC12138
-	tristate "Texas Instruments ADC12130/ADC12132/ADC12138"
-	depends on SPI
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  If you say yes here you get support for Texas Instruments ADC12130,
-	  ADC12132 and ADC12138 chips.
-
-	  This driver can also be built as a module. If so, the module will be
-	  called ti-adc12138.
-
 config TI_ADC108S102
 	tristate "Texas Instruments ADC108S102 and ADC128S102 driver"
 	depends on SPI
@@ -1464,6 +1452,18 @@ config TI_ADC108S102
 	  To compile this driver as a module, choose M here: the module will
 	  be called ti-adc108s102.
 
+config TI_ADC12138
+	tristate "Texas Instruments ADC12130/ADC12132/ADC12138"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  If you say yes here you get support for Texas Instruments ADC12130,
+	  ADC12132 and ADC12138 chips.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-adc12138.
+
 config TI_ADC128S052
 	tristate "Texas Instruments ADC128S052/ADC122S021/ADC124S021"
 	depends on SPI
@@ -1499,6 +1499,16 @@ config TI_ADS1015
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1015.
 
+config TI_ADS1100
+	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
+	depends on I2C
+	help
+	  If you say yes here you get support for Texas Instruments ADS1100 and
+	  ADS1000 ADC chips.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads1100.
+
 config TI_ADS1119
        tristate "Texas Instruments ADS1119 ADC"
        depends on I2C
@@ -1511,6 +1521,41 @@ config TI_ADS1119
          This driver can also be built as a module. If so, the module will be
          called ti-ads1119.
 
+config TI_ADS124S08
+	tristate "Texas Instruments ADS124S08"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  If you say yes here you get support for Texas Instruments ADS124S08
+	  and ADS124S06 ADC chips
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads124s08.
+
+config TI_ADS1298
+	tristate "Texas Instruments ADS1298"
+	depends on SPI
+	select IIO_BUFFER
+	help
+	  If you say yes here you get support for Texas Instruments ADS1298
+	  medical ADC chips
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads1298.
+
+config TI_ADS131E08
+	tristate "Texas Instruments ADS131E08"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to get support for Texas Instruments ADS131E04, ADS131E06
+	  and ADS131E08 chips.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads131e08.
+
 config TI_ADS7138
 	tristate "Texas Instruments ADS7128 and ADS7138 ADC driver"
 	depends on I2C
@@ -1532,27 +1577,6 @@ config TI_ADS7924
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads7924.
 
-config TI_ADS1100
-	tristate "Texas Instruments ADS1100 and ADS1000 ADC"
-	depends on I2C
-	help
-	  If you say yes here you get support for Texas Instruments ADS1100 and
-	  ADS1000 ADC chips.
-
-	  This driver can also be built as a module. If so, the module will be
-	  called ti-ads1100.
-
-config TI_ADS1298
-	tristate "Texas Instruments ADS1298"
-	depends on SPI
-	select IIO_BUFFER
-	help
-	  If you say yes here you get support for Texas Instruments ADS1298
-	  medical ADC chips
-
-	  This driver can also be built as a module. If so, the module will be
-	  called ti-ads1298.
-
 config TI_ADS7950
 	tristate "Texas Instruments ADS7950 ADC driver"
 	depends on SPI && GPIOLIB
@@ -1588,30 +1612,6 @@ config TI_ADS8688
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads8688.
 
-config TI_ADS124S08
-	tristate "Texas Instruments ADS124S08"
-	depends on SPI
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  If you say yes here you get support for Texas Instruments ADS124S08
-	  and ADS124S06 ADC chips
-
-	  This driver can also be built as a module. If so, the module will be
-	  called ti-ads124s08.
-
-config TI_ADS131E08
-	tristate "Texas Instruments ADS131E08"
-	depends on SPI
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to get support for Texas Instruments ADS131E04, ADS131E06
-	  and ADS131E08 chips.
-
-	  This driver can also be built as a module. If so, the module will be
-	  called ti-ads131e08.
-
 config TI_AM335X_ADC
 	tristate "TI's AM335X ADC driver"
 	depends on MFD_TI_AM335X_TSCADC && HAS_DMA

---
base-commit: 97fe5f8a4299e4b8601ecb62c9672c27f2d2ccce
change-id: 20250312-sort_ti_drivers-04336a06a425

Best regards,
-- 
Tobias Sperling <tobias.sperling@softing.com>



