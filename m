Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F71B7A97F3
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 19:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjIUR26 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 13:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIUR2T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 13:28:19 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9474BBEC
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:16:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-9ae22bf33a0so525837466b.0
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316596; x=1695921396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOWL8UFN0vGXrTIparX6s/KCVRR+pmZ6D/qH1lVsdWQ=;
        b=qOSnKTWNTyxDJAD/n1BeOK6v6FCdI+DmjuyOOEqw6Mvchy5xdw6KJRs2XTYGyG5lSg
         OKlCGBxlraNA143oCIwa/1aBJAAyE7xZu9eKLRzz7s3yzxwXlMPKcaqgwbKqjCqMvlAJ
         vRP/ChFihnrWREcBvQVt05CXxPoqz3nUOf5yDe/DbUWemO30yE4zGmpG1SIthErIy6bj
         7vVWPutZTh+yMXzrPVb3LlUROW0jw+0pdI8MxMXLCLY/nKbjA0RAvF5yGN08XRatC/Oo
         ws5VHtIFLNHs3gLEhYETJpZfRVRM/i6kmm0g6Xuwz3EjazWVMPJ9u8bSUwrFjhOh97WE
         cyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316596; x=1695921396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOWL8UFN0vGXrTIparX6s/KCVRR+pmZ6D/qH1lVsdWQ=;
        b=iB6aWRD1cbHNhoTHrLrPWAsKSQ0XVSPiz+O+YLC3kGJmttXFJ7kSCiZ6etwr5SdMss
         DNfmeUxFgWQrlUeyIE5Cu6Q8hLBhVHwm8yTAJo8/nF3XWG6dGDWAzpHi57Nw4vytb1CB
         1SFXhxcZ3ZvNzsRisaDjAMG7QPOnHFEsac8SMEJpCMHj3uBkTVLzI5FWNsojtb2sb2aj
         cTyFc7lHgaO1GSI3+kGEpJAHwa7zfHuREf9dCM9+GeeUq3yiS2ebXyLOD7SvVTxIzpBC
         wYzo/UKG3e2+ahvsGyuZdn2RwywgbmN0dwjE6/044Oqd5GjM9thqbSlCmTYTQJBENo8O
         8GRw==
X-Gm-Message-State: AOJu0YyQbA6vb6kBUalHlRqzI7R6I3h2tx6NTTUbKaOzalKbdutZq/Nn
        rF6ogvQdCrOVTSGrNezCdgdB24JBayPzq2W6zSu/S/49PGM=
X-Google-Smtp-Source: AGHT+IFzcBipIczu0UM4gStcHPA5qOTjVF5hSW6xMiN01FgCN7Y6ZAzNQO6cw/yOKmnG0hURQ665bQ==
X-Received: by 2002:a05:600c:3789:b0:3fb:c075:b308 with SMTP id o9-20020a05600c378900b003fbc075b308mr4598413wmr.12.1695307454403;
        Thu, 21 Sep 2023 07:44:14 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:14 -0700 (PDT)
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
Subject: [PATCH v2 02/19] staging: iio: Documentation: document IIO resolver AD2S1210 sysfs attributes
Date:   Thu, 21 Sep 2023 09:43:43 -0500
Message-Id: <20230921144400.62380-3-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

