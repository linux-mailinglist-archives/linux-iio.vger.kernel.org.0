Return-Path: <linux-iio+bounces-7781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130B3938D28
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 12:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3762B1C2215F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E216F0E7;
	Mon, 22 Jul 2024 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRyBcJIh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638916EBEE;
	Mon, 22 Jul 2024 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642629; cv=none; b=sh5uH8csLGlhExARKTga7/J68f5dBfRKITC8fAEQYxquBeYaSQGU7rpaAduVgKiAMLLhI3m4vsbpbKC7YvWXJWXmCi0Wdgft6Sh2iOwOere0GRwLyKL8D00Eb2bxQO73XUX/lpc1jQwlGOMRyijEPY5BzNlIJCl8MUzTHMoZ7sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642629; c=relaxed/simple;
	bh=IwAkbMo1+kNeo3eAuHrEOCxgwG6NMtjmSxIUVLyO4sA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LRIBMaCYX/1uxCo/Xw5/+h/sBVo6ckwmSMN07MPj68BabpK/p8NdWLXwgYVFQx2XDN3eQnqjsyFXm4yjw6tGDb3H+xYMvg9cxHqMP0Gst4CzZXp8yleL5dNa7/ef0msSumC821NwS+2JnVgcwnhXFmUgaWLXTQHahWw0Pv/Fbsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRyBcJIh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3687fb526b9so1821628f8f.0;
        Mon, 22 Jul 2024 03:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721642626; x=1722247426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Z9ev0OSTNbjoHO0EqpkKn9z884VmTaWagd1rmqxwF0=;
        b=XRyBcJIhKxrEABzRYMHLcuwIWqaz04dgmt0VB0rbqcYD05/vB6QNeCHrBKPrnv01IE
         EayVw5i5n58dzYm1D1pFV5LXYlcL7DkqvWrr8+vY3Rxf4iukPSqg0EnTmIc3c613/Z5B
         joo8Cv/h+Sp3PhEG+JzNgTgVjESkEOEU7ybI3NMeWD3iNdypzYH/0l0VZDThMZOJElQn
         sfNmN+iwgbQZK+7QCrba57dnAHLxzP8kdgOAHY/m2qCRLVi82mT/cP+T+KXMAeg+kiAY
         OXirMCa7jhP83LZsL/GkoNhjdz1/3uKILCuc+3spfrQdfN8duyQ7OISCGq+T6S4ffm0+
         Q+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721642626; x=1722247426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z9ev0OSTNbjoHO0EqpkKn9z884VmTaWagd1rmqxwF0=;
        b=eVC4TDiLbutGLTdWKIdCYnYerGEAKwU0+4ZCkW56Iha/sYeO+cLkzXegzJUrkPy/j3
         4odHVtq46qsuU+KDlLYzKaPEk0sT5bMwzWIIAKnpefRQDhWyA62FKCDKLFiF6fweWapE
         C9tmfrxQBRi/9r+YekX82c2pKf4SrG92wanSp0/ayB7/BJX/s6CU9C3YYULHFGvcg0so
         tpvXlzfzRfCZuhj8o9psutEv97jWvjJD0E385XOdrCz+a1NxbUs+SdXLrLEM4vcv34zE
         Spk+q5/ZKyaWtX/VL8mcyqztNj04wylGDbufCnBCCfCqHk8d7N8FCJEa65T1HZo7gvY3
         hTZg==
X-Forwarded-Encrypted: i=1; AJvYcCWy6mBT3JER14rgM2tsvlXX/6LTgsIObCH/R1VBRiLTxyH2kCg6/L4H23y4hlgUvjcEXlhRkDocncNiTKfuKhCvm8y1r7UzKmCdMlYEGAbCcuRrupjQRYkE7lzxx8+/nmFHckiMIXa2qQ==
X-Gm-Message-State: AOJu0YwoLbPq5CG+5O6S8JWsIqwZn9kjycuOfx4mkEKC+P9U2ZKiDLi6
	oCZxlBuPAL+v+UFB6Vu1NFHwp304YVGOQO0OnngdOrDvWC6SDyB9
X-Google-Smtp-Source: AGHT+IHyk/4tp7D8Za7TcfF2O4vK/gidkmyVd/KJl8gR+YZaekRPRa+ODVXSVnBEBUqN5lrjFCsepw==
X-Received: by 2002:a05:6000:b85:b0:35f:2030:d42c with SMTP id ffacd0b85a97d-369bae13610mr4123668f8f.17.1721642625842;
        Mon, 22 Jul 2024 03:03:45 -0700 (PDT)
Received: from localhost (host-82-58-19-206.retail.telecomitalia.it. [82.58.19.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ed7b8sm8050062f8f.106.2024.07.22.03.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:03:45 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 22 Jul 2024 12:03:19 +0200
Subject: [PATCH v3 2/3] iio: ABI: generalize shunt_resistor attribute
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-iio-pac1921-v3-2-05dc9916cb33@gmail.com>
References: <20240722-iio-pac1921-v3-0-05dc9916cb33@gmail.com>
In-Reply-To: <20240722-iio-pac1921-v3-0-05dc9916cb33@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.0

Move ABI documentation for custom shunt resistor attributes into the
generic iio documentation file. Exception for pac1934: leave it
untouched since it does not comply with common iio ABI generalization.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio             |  8 ++++++++
 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 | 17 -----------------
 Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc  |  9 ---------
 3 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 7cee78ad4108..935d67fd1a43 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2289,3 +2289,11 @@ KernelVersion:	6.7
 Contact:	linux-iio@vger.kernel.org
 Description:
 		List of available timeout value for tap gesture confirmation.
+
+What:		/sys/.../iio:deviceX/in_shunt_resistor
+What:		/sys/.../iio:deviceX/in_current_shunt_resistor
+What:		/sys/.../iio:deviceX/in_power_shunt_resistor
+KernelVersion:	6.10
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The value of current sense resistor in Ohms.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 b/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
deleted file mode 100644
index 6d2d2b094941..000000000000
--- a/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
+++ /dev/null
@@ -1,17 +0,0 @@
-What:		/sys/bus/iio/devices/iio:deviceX/in_power_shunt_resistor
-Date:		March 2017
-KernelVersion:	4.12
-Contact:	linux-iio@vger.kernel.org
-Description: 	The value of the shunt resistor used to compute power drain on
-                common input voltage pin (RS+). In Ohms.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_current_shunt_resistor
-Date:		March 2017
-KernelVersion:	4.12
-Contact:	linux-iio@vger.kernel.org
-Description: 	The value of the shunt resistor used to compute current flowing
-                between RS+ and RS- voltage sense inputs. In Ohms.
-
-These attributes describe a single physical component, exposed as two distinct
-attributes as it is used to calculate two different values: power load and
-current flowing between RS+ and RS- inputs.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc b/Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc
index 8916f7ec6507..8dbca113112d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc
+++ b/Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc
@@ -13,12 +13,3 @@ Description:
 		available for reading data. However, samples can be occasionally skipped
 		or repeated, depending on the beat between the capture and conversion
 		rates.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor
-Date:		December 2015
-KernelVersion:	4.4
-Contact:	linux-iio@vger.kernel.org
-Description:
-		The value of the shunt resistor may be known only at runtime fom an
-		eeprom content read by a client application. This attribute allows to
-		set its value in ohms.

-- 
2.45.2


