Return-Path: <linux-iio+bounces-7835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ECE93AE55
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 11:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0EA281743
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 09:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3731527BB;
	Wed, 24 Jul 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrkZYv1Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C714B095;
	Wed, 24 Jul 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812154; cv=none; b=h5PyHar/PFTgRzme2c0pYjofABpjLTTIXBSgB+d2ZKrXTLKyecKxbYt2SYdg38cteZqW1qO8J27ViYQsgp1OV8D1EnTEiHOUZD9d0uYg1nS7XPbYpIbtXDjgIuIRrMubEcxRoSJVhlV+X1+Rnt4o83T2jQ9LKZttkF/WNG9Q+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812154; c=relaxed/simple;
	bh=IwAkbMo1+kNeo3eAuHrEOCxgwG6NMtjmSxIUVLyO4sA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8QjCPRDd9RYfGaisiwat61k/zeC3DR3kaJ61NTfAgGCvwj7RnE6/HFoKS6ZeKbdQFmVOsHTPFfAmkln8+104xkk0HJg1JFSbDFfJNLqzDC2OyTLJRhf1WBNbDfrM3kS88No1+sFW68t0Yvb0Ox0gWyOCxQ2MBFe7LvOD0otXlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrkZYv1Z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266eda81c5so57083975e9.0;
        Wed, 24 Jul 2024 02:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721812151; x=1722416951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Z9ev0OSTNbjoHO0EqpkKn9z884VmTaWagd1rmqxwF0=;
        b=WrkZYv1ZNd0kIMExRsxNRECHnAkXohL04QnxZ9AHtv6KyG5MkIk+A7rg3tG2qO0R6j
         wam5B5BTzj8oBuiCNtFlyNhA9r4zt5Jf/s2hgh+qKIqLv4ZjmBJzwFjMbbcpi+gUMYsU
         0L3aJWrzpB4/fi/anZGWyHZrAiohB0yMpKaGIA877mz2NZ9gmHo8nyoMJOr3OJnEKdyd
         rw6PZhVNs8KZulUiYuYQopFCKLPpA0FkZcKp/e5Jk9VRGvcP0rHGL0LhqvUBWdynJ083
         /gyL4T2MDlVBeLRCy7MOiS+YWohgG3nlN5mQ/2a3se5aFAo0qI2CPaVWpJ7Wc8WCtWAL
         kgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721812151; x=1722416951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z9ev0OSTNbjoHO0EqpkKn9z884VmTaWagd1rmqxwF0=;
        b=FJ1mgEAvGt1L8uPHjL+ewH/zrxfwsPikIew/xqHsglnifxwt1KKui+hkne9eokrKnS
         Wsl1iM9wQ7pVhv3zE6wIOv+vb2L9rqBaFjKWM2ftoKGSGRl3LblrLgydydT+s0CWwdiQ
         kpo5pm2D+8srLBIeQSnuQ/C0HXCphyHLlLVtZiCplUtiIzpBsRM0bneu6zYplMpk5z5f
         tT6xBd8/KbSMwzTiqbbx5JlJHCQR/osfvfwHRVskFVgzjQvTEFU/ujXlZDV0t+gjglLk
         JeJCXBWKwb3C/t4Bn6ALhi2uSD9mItno5tYSUECsOqKOsM+RO7mv8rLMdAraB0LZoMK5
         S7eg==
X-Forwarded-Encrypted: i=1; AJvYcCVa2PGbiDR56zdRiu4Cta2ZUHrudCFBU2Gsfow+2P+ab8mn2MC5qwGw2wcsDPVz179TxPZQUWRLqAxbr6KwkIW6nBaH1Zz4va0LacVDLjPadBrihWxovDIzYzeqzfhlaz2ciyPp5FzgJA==
X-Gm-Message-State: AOJu0YyZxnhUiarpWkzQS/WMQNXXmmzzOrHcJK3LH4f1g/0GtWiVp4cw
	wUX2sCreaCMLf3GUkrNln+bJ9zLOghKuwYEhDgh89K3igtTCh3vZ
X-Google-Smtp-Source: AGHT+IFzCB4ue7sxQ0YiXZCfOSgLUCNUEBjfX+y5lOBz3Gq3NTLH4oBKzzD+7ZhM6CIjKWhsxbRftg==
X-Received: by 2002:a05:600c:154f:b0:426:6f4b:b386 with SMTP id 5b1f17b1804b1-427f7adf13fmr16815855e9.34.1721812151012;
        Wed, 24 Jul 2024 02:09:11 -0700 (PDT)
Received: from localhost (host-82-58-19-206.retail.telecomitalia.it. [82.58.19.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f938d9besm20123205e9.24.2024.07.24.02.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 02:09:10 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Wed, 24 Jul 2024 11:08:32 +0200
Subject: [PATCH v4 2/3] iio: ABI: generalize shunt_resistor attribute
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-iio-pac1921-v4-2-723698e903a3@gmail.com>
References: <20240724-iio-pac1921-v4-0-723698e903a3@gmail.com>
In-Reply-To: <20240724-iio-pac1921-v4-0-723698e903a3@gmail.com>
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


