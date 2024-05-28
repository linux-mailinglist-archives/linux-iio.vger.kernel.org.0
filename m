Return-Path: <linux-iio+bounces-5401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF988D1EA7
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F69B1C231DD
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21454171640;
	Tue, 28 May 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJjnImwn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A869170851;
	Tue, 28 May 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906287; cv=none; b=MzcIJ0GcMv5wkdKWu39dsxvSxgde0EF/d/OFh1p1tOByMwFr3FcMPqBnppPfWYwIzfg/Bhi15WHqXWA1Pxe2iU9RGfMqJlty85MYuI4DlZQ9rytzw5zLQU5Yk9B2CSs4oIE8uEsh++sSaJlf1Vak+w6ZkttGXWN6LGjdPXHK9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906287; c=relaxed/simple;
	bh=L9HR7Zebysg3EevGIOd9lPAIsSehvGC0AXfmfZvgvfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1DHvAVoXFXWyc9X0p+7ZPBnPYfuKEuhEDW/dWDE7SmpfXh6yKUyNDr4f+seQNWpP/W1VdXCDykt6ck/3XVAq0Yy8vntsXo+cLZcUJQ4XRW4VrDHOeYy03ZX+I0wypYqCULCiOvyeZYqYRZeICjDDRsBTLf1bkTdEUgrQAQbB3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJjnImwn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5785161b98cso474408a12.1;
        Tue, 28 May 2024 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716906284; x=1717511084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFDH7urImGj6WfUQVPUhLS8k2uRVZUKW0f9TaM7kELo=;
        b=bJjnImwnKVaNuUcrTCb+LctApYk6yGuL0fD8N1/QLdb55RhUgH+xtjAM1Q4snoproP
         DVTDtOJ5wuVCRTQmzTsGlDXzLyYzEC/opeDNKCAM2VEYOwDenQFFSUQNsWbJIQQ3Q/f3
         c4pN36sPt3Dl8hKQ/qNIxIPuli6dFc2tK6K7jfOD3FAP1ZKw5uw51gOWpF765OgXVmdV
         rIJYCSYD1pCX4grmg1jiJViD4M4O6WGC20piEnEUbD6pV9Z3eyCkTfDUyyDG/OgZwxQk
         g7oiML+xPPLALAC+sCG8HtCLyAdYMTZAHMSIjNUjZ+4jR+YJGIHqZc1ia2pBw5jR/DSQ
         zaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906284; x=1717511084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFDH7urImGj6WfUQVPUhLS8k2uRVZUKW0f9TaM7kELo=;
        b=rKLHByVsUgxE7vE+V5xwT2pgjxzSmJn5ExhNUXYsmDWbPekuBUKX/l2HJcHh6oKI4W
         9O4vz+OshOWnrufpfKBgYJkdz8mfXLe0AEU2Ya7aWPGPFPyAhhWftbctdz19F87PzmG5
         /WNfIIeemznKgf72dKjKLT7JfN9wJLoMC7D/iS+wCo1BHFEwDN125UjDtiEUDilLvMUS
         1DclQjnWiajkjBiRTUf5o2pWcXGg6e4Ed75x7lkQUgm8dKLePGxqxsH0l0KyxoZ96hEA
         QvPOLqy5SJCEuePqDf5j7ORBCcLmaJQwvp/bdcNl08MFPloXpx7iBjsfHhRwR5A65SxU
         h6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXYJkNsmf8vGkqf1jOqOLsa6a0Gder9/uJ1DR7n4hv5F4Nn374LAqhn4yo/1stGlY3wNIcKz71ReHmyJBoVVfRrb5eUQcegSGsp8NSY9qqU9wvbjj1ODsA6S+B3asTHScCMpGrZGESXy0gifgOvjWlwpnNTxY5JXwASlzLUgCbhmQ==
X-Gm-Message-State: AOJu0Ywn2qr8aL1lqAl7JwpclRTDZyMWoPnz3YkE5QqzIcErl2LpYLwa
	FB+6nNMpnAO0huMx1Zfy19P2DM+dRF9r8wKe7h2Pqy2heCKpN3ibtPI/4v2cWqU=
X-Google-Smtp-Source: AGHT+IEETSQFSiiDzjBNuO5xDkW/T5RRIdUhjSextgzVqULSvYwVifpT9KGqZC51x3qse6l8McHbXg==
X-Received: by 2002:a50:d782:0:b0:578:69cb:1efc with SMTP id 4fb4d7f45d1cf-57869cb2015mr7276031a12.9.1716906283854;
        Tue, 28 May 2024 07:24:43 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:3736:ef2a:a857:c911])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d7dc9efesm2495580a12.48.2024.05.28.07.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:24:43 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v2 5/6] docs: iio: add documentation for interfacing tools
Date: Tue, 28 May 2024 17:24:08 +0300
Message-Id: <20240528142409.239187-6-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528142409.239187-1-ramona.gradinariu@analog.com>
References: <20240528142409.239187-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for IIO interfacing tools describing the available
tools which can be used to retrieve data from IIO sysfs.
Reference this documentation in adis16475.rst

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
changes in v2:
 - new patch
 Documentation/iio/adis16475.rst | 23 ++---------------------
 Documentation/iio/iio_tools.rst | 27 +++++++++++++++++++++++++++
 Documentation/iio/index.rst     |  1 +
 3 files changed, 30 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/iio/iio_tools.rst

diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis16475.rst
index 91cabb7d8d05..65a09577db4e 100644
--- a/Documentation/iio/adis16475.rst
+++ b/Documentation/iio/adis16475.rst
@@ -384,24 +384,5 @@ data is structured.
 4. IIO Interfacing Tools
 ========================

-Linux Kernel Tools
-------------------
-
-Linux Kernel provides some userspace tools that can be used to retrieve data
-from IIO sysfs:
-
-* lsiio: example application that provides a list of IIO devices and triggers
-* iio_event_monitor: example application that reads events from an IIO device
-  and prints them
-* iio_generic_buffer: example application that reads data from buffer
-* iio_utils: set of APIs, typically used to access sysfs files.
-
-LibIIO
-------
-
-LibIIO is a C/C++ library that provides generic access to IIO devices. The
-library abstracts the low-level details of the hardware, and provides a simple
-yet complete programming interface that can be used for advanced projects.
-
-For more information about LibIIO, please see:
-https://github.com/analogdevicesinc/libiio
+See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+interfacing tools.
diff --git a/Documentation/iio/iio_tools.rst b/Documentation/iio/iio_tools.rst
new file mode 100644
index 000000000000..cc691c7f6365
--- /dev/null
+++ b/Documentation/iio/iio_tools.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+IIO Interfacing Tools
+=====================
+
+1. Linux Kernel Tools
+=====================
+
+Linux Kernel provides some userspace tools that can be used to retrieve data
+from IIO sysfs:
+
+* lsiio: example application that provides a list of IIO devices and triggers
+* iio_event_monitor: example application that reads events from an IIO device
+  and prints them
+* iio_generic_buffer: example application that reads data from buffer
+* iio_utils: set of APIs, typically used to access sysfs files.
+
+2. LibIIO
+=========
+
+LibIIO is a C/C++ library that provides generic access to IIO devices. The
+library abstracts the low-level details of the hardware, and provides a simple
+yet complete programming interface that can be used for advanced projects.
+
+For more information about LibIIO, please see:
+https://github.com/analogdevicesinc/libiio
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index fb6f9d743211..66fa69102e3a 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -9,6 +9,7 @@ Industrial I/O

    iio_configfs
    iio_devbuf
+   iio_tools

 Industrial I/O Kernel Drivers
 =============================
--
2.34.1


