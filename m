Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090107A9E49
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 22:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjIUT77 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 15:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjIUT7q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 15:59:46 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C53D43CAE
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:23:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so20405211fa.3
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316999; x=1695921799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOWL8UFN0vGXrTIparX6s/KCVRR+pmZ6D/qH1lVsdWQ=;
        b=EKeygh4+yCldeC17x2OVoxSCsHbk+Ar5PnSDyaEmm5W9hh3PGVzZRYqb+gc/jd4bts
         TX9HWnwP7O6jF2OK96H6XTn1LF4It5Iu5ciwxIsSKkxKc12hEWghvcF+JaWpl+3T6FgB
         dizVoDfEdKvmiY9QC838/Z+9YMPZzZh833Yk+aPcAI2+hAFf0XPu0zJEiaeYoJUCEWt3
         8auejeLigyRKP4kQQqCBSTUcgxFM+t3CzyLiDA/z5uFHWYiDTUF6pyzDuVSjGwF5QHPQ
         L6T5qT80Wlo/16S4uDabgmKnsYPtlnoHTFjYPO6vxA2EBnP+745rxuTYTolKkswg6mhh
         sZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316999; x=1695921799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOWL8UFN0vGXrTIparX6s/KCVRR+pmZ6D/qH1lVsdWQ=;
        b=NQ+1BLBT6HWLaUelM3k22EhYKrIPvEPDMcJC+rg01AobqKnzaXQoqeJlBkn8xLqbzn
         lAegl4LuwUu2DmjRpiTMXqPzJHjdrVann+xeHNFXi9YchlXCymzrj/DJbJ7Pit3jQz5n
         Vqh5+zsE09XTaxQjSLkP/W8Fi6n8fXKMsP9ss8+4nbfogLBfhJ4ogTyDENJcarTgmbl8
         A5qgZZjX/wbo+a3qPpX1zIyBuPbMUdGVh0QprrnVEHBJezVbPdCyCr2+1htIJK8Tv2xN
         3s9ZHCT/MQxnPkfItcD+sJuzejfRyHABF/erQqoFTq/TEWAqxW9x7eCstKzQBAdsRSDe
         cQAw==
X-Gm-Message-State: AOJu0Ywys752PLGv3QIYJeubVUP4f+G9nCt1JscJlGwCwqRqrYLBAaqW
        ga9R7np6PF8sF7yaBWnPx9YEL6KJ5FfKdI+UMK/8togyif0=
X-Google-Smtp-Source: AGHT+IErr9vfLKcGbuaDz6p0WEc9gtQaWzHZCdYrnWpb8xs+8uWyyRU6Xrb3jaQvYbOOtHHu0seULw==
X-Received: by 2002:a5d:6405:0:b0:319:6ec3:79c7 with SMTP id z5-20020a5d6405000000b003196ec379c7mr5205794wru.36.1695306152763;
        Thu, 21 Sep 2023 07:22:32 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:32 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [v2 02/19] staging: iio: Documentation: document IIO resolver AD2S1210 sysfs attributes
Date:   Thu, 21 Sep 2023 09:19:29 -0500
Message-Id: <20230921141947.57784-4-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds documentation for the device-specific sysfs attributes of the
iio/resolver/ad2s1210 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../sysfs-bus-iio-resolver-ad2s1210           | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210 b/drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210
new file mode 100644
index 000000000000..32890c85168e
--- /dev/null
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-resolver-ad2s1210
@@ -0,0 +1,109 @@
+What:		/sys/bus/iio/devices/iio:deviceX/dos_mis_thrd
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the current Degradation of Signal Mismatch
+		Threshold value. Writing sets the value. Valid values are 0 (0V)
+		to 127 (4.826V). To convert the value to volts, multiply by
+		0.038.
+
+What:		/sys/bus/iio/devices/iio:deviceX/dos_ovr_thrd
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the current Degradation of Signal Overrange
+		Threshold value. Writing sets the value. Valid values are 0 (0V)
+		to 127 (4.826V). To convert the value to volts, multiply by
+		0.038.
+
+What:		/sys/bus/iio/devices/iio:deviceX/dos_rst_max_thrd
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the current Degradation of Signal Reset Maximum
+		Threshold value. Writing sets the value. Valid values are 0 (0V)
+		to 127 (4.826V). To convert the value to volts, multiply by
+		0.038.
+
+What:		/sys/bus/iio/devices/iio:deviceX/dos_rst_min_thrd
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the current Degradation of Signal Reset Minimum
+		Threshold value. Writing sets the value. Valid values are 0 (0V)
+		to 127 (4.826V). To convert the value to volts, multiply by
+		0.038.
+
+What:		/sys/bus/iio/devices/iio:deviceX/fault
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns a hex value containing the fault bit flags.
+
+		Bit	Description
+		---	-----------
+		D7	Sine/cosine inputs clipped
+		D6	Sine/cosine inputs below LOS threshold
+		D5	Sine/cosine inputs exceed DOS overrange threshold
+		D4	Sine/cosine inputs exceed DOS mismatch threshold
+		D3	Tracking error exceeds LOT threshold
+		D2	Velocity exceeds maximum tracking rate
+		D1	Phase error exceeds phase lock range
+		D0	Configuration parity error
+
+		Writing any value will clear any fault conditions.
+
+What:		/sys/bus/iio/devices/iio:deviceX/excitation_frequency
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the current Excitation Frequency in Hz. Writing
+		sets the Excitation Frequency and performs a software reset on
+		the device to apply the change. Valid values are 2000 (2kHz) to
+		20000 (20kHz).
+
+What:		/sys/bus/iio/devices/iio:deviceX/los_thrd
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the current Loss of Signal Reset Threshold
+		value. Writing sets the value. Valid values are 0 (0V) to
+		127 (4.826V). To convert the value to volts, multiply by 0.038.
+
+What:		/sys/bus/iio/devices/iio:deviceX/lot_high_thrd
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the current Loss of Position Tracking Detection
+		High Threshold value. Writing sets the value. Valid values are
+		0 (0 deg) to 127 (9/18/45 deg). The interpretation of the value
+		depends on the selected resolution. To convert the value to
+		degrees, multiply by 0.35 for 10-bit resolution, multiply by
+		0.14 for 12-bit resolution or multiply by 0.09 for 14 and 16-bit
+		resolution.
+
+What:		/sys/bus/iio/devices/iio:deviceX/lot_low_thrd
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the current Loss of Position Tracking Detection
+		Low Threshold value. Writing sets the value. Valid values are
+		0 (0 deg) to 127 (9/18/45 deg). The interpretation of the value
+		depends on the selected resolution. To convert the value to
+		degrees, multiply by 0.35 for 10-bit resolution, multiply by
+		0.14 for 12-bit resolution or multiply by 0.09 for 14 and 16-bit
+		resolution.
+
+What:		/sys/bus/iio/devices/iio:deviceX/phase_lock_range
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the current Phase lock range in degrees. Writing
+		sets the value in the configuration register.
+
+What:		/sys/bus/iio/devices/iio:deviceX/phase_lock_range_available
+KernelVersion:  6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading returns the possible values for the phase_lock_range
+		attribute, namely 44 and 360.
-- 
2.34.1

