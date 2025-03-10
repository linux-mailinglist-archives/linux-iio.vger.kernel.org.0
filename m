Return-Path: <linux-iio+bounces-16685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5848FA59F95
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 18:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9DD16FE76
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCF4233D91;
	Mon, 10 Mar 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KpmEM4VC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D7223702
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628475; cv=none; b=Mhj/vFqWmPO+L/oXeUly3Ti65ONpdQZ+Aklynn/Nc+wQTjhNttAgc9XW6vTZl9IRKww0vN0es4fLDPHsR5vvy6yRdkOYpnOs+eDOa5Vjfozri9UoCV4AhKTOpEYKskFiXBuL6+VH90fHPWnpSlRA0fP+eXK1/O9eBK9JziHKQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628475; c=relaxed/simple;
	bh=vap/8qEfDYJND2AdXVA7z71mlnRugvEHBnTI0XUnheM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BzN1QR/4lsfgIx3hwq7qEcIm0/NQ+GvKI+QZ3c8K36+UDzFEj9hbSS2RoEPHE7dXFQAU8+h4NYfIVu48TcnZksnEm6OL5U5QT5bVNEBuicOIyP/isdw75vZ30co+52qcwOit6LWQZL+AM2aNVbi2khsVPS4f/yBxKjNsi5q2WY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KpmEM4VC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso1482616f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 10:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741628472; x=1742233272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgWPLY44UYfs7OSbFs+4rgP587/bNJC0XV4YHVYL62k=;
        b=KpmEM4VCpQxR5yAEKq+3oWWvTUofGix+mTld+3nmxJU/Oh8m214gB29pN9TrR6kkVU
         RrE3PkbvEuhY4lyeEzjEI8nvzocypDdWn2YS5Xrzy30FjrWcrQi7xTG6fP+oRi/iQWRQ
         WmAEb34+PFXbiypd6pLQLeHVYztSIv4Ytp9EbSySwjq2XL6YeneNg2wkRrwk9QXiU30a
         R0GtnUadDcv1oVlF5mb3fNUrxKdX5NLbfmvLZqcXQ2T6Jm/4CbYbOfNgLIc7aDjDPgD1
         SIaC19V1CgjEBM3IaKMMtD8EadqKE5Q9jh14FsE1MtBR4Jt8GP+bKp/DGKQ88ww5BItn
         Gbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741628472; x=1742233272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgWPLY44UYfs7OSbFs+4rgP587/bNJC0XV4YHVYL62k=;
        b=MgOQrOeE7XhQSv/Xbs4HxvYsw6jgcdgsQev6ahqSkdSQqkKNdpPQrMqEyhTJ81A7eu
         cFlTZcodmE9cSz/dcwD2Q/apJxW5jhSddpKW6O35PfvtRUsL9cE8WhWigiiZ7r7MwOsg
         uQPdnrgNSsy6TcYe0sutjI+2mLo+11gFKWCQ/1GkrrcGY+w5CURuPxFhIGnqAo2z0Ega
         hw+5hF1QChjLSgeIIr8kXoazSG9uF8Ic4zQIH8ie6WNHbUnNHOhHP7LQnlvDcejYp1tR
         ixAO3JI7+UQTgEneWSodjnQR/65y8xwSYfgPb/joYhZZifp0hjHunVRY9/djkfbY1wdX
         w6Uw==
X-Gm-Message-State: AOJu0YyYScdpRQtGizeMhW5/DTq5dZNFhQ9JFpXb6XdX5iORdvXtzDtW
	z0fyA06pMkJ0NBITAe9hlQxGmKkrVxsicd1iyIk8HiAMDnwPhzDgRweKc/siyZs=
X-Gm-Gg: ASbGncshxP1HviZEtzGlzXPMTV+XFy/pct5L5zyKlj27B1wRfUVODmuXwaHjVyx23Bq
	LDGMn+duzV6O7tGS3RCLuA5IpftMj7vFZ8o3YLYMW4DNUAja5KnErsZpIZyk++W5hlEn004896M
	otzR288pR5AZpryFAXb0xKOaRdB7kuk6djRY2hB/CVmmi2jzIrBNj+uw8LoshPWeRtfaJ0f9bWO
	H8JeoZfbkNfUlwCAJRoZU/QA2T2O6zQIqpVj4xfS49/Un9AS2OqeLQVfDb4wgaSLpoYK4HgZ4Zv
	yZw17eGjE23waOehjidUccyQ/qwKFNpzPHYYN3kCnOJihnPEl9tjvScqFxeXnp1OBR82bi2kz+8
	bTjuOTGdYkeFVdb/DsYI=
X-Google-Smtp-Source: AGHT+IF2E0/FEPYOs2Ol5yXnd/QF0za9bgmKGmRzY5a5rBVIupAH5/HrBOSGOMwS07vxF3l2bXd4bA==
X-Received: by 2002:a5d:5f94:0:b0:38f:4d20:4a17 with SMTP id ffacd0b85a97d-392641bcf76mr754572f8f.13.1741628471882;
        Mon, 10 Mar 2025 10:41:11 -0700 (PDT)
Received: from [127.0.1.1] (host-82-56-170-15.retail.telecomitalia.it. [82.56.170.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba8a9sm15597038f8f.9.2025.03.10.10.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:41:11 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 10 Mar 2025 18:39:53 +0100
Subject: [PATCH v4 2/2] doc: iio: ad7380: describe offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-wip-bl-spi-offload-ad7380-v4-2-b184b37b7c72@baylibre.com>
References: <20250310-wip-bl-spi-offload-ad7380-v4-0-b184b37b7c72@baylibre.com>
In-Reply-To: <20250310-wip-bl-spi-offload-ad7380-v4-0-b184b37b7c72@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

From: Angelo Dureghello <adureghello@baylibre.com>

Add a section to the ad7380 documentation describing how to use the
driver with SPI offloading.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/iio/ad7380.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
index 35232a0e3ad730c19b5201b74280bdb6deaa9667..24a92a1c4371db6b59ef47edf06cee860641ebbf 100644
--- a/Documentation/iio/ad7380.rst
+++ b/Documentation/iio/ad7380.rst
@@ -178,6 +178,24 @@ Unimplemented features
 - Power down mode
 - CRC indication
 
+SPI offload support
+===================
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html
+
+When SPI offload is being used, some attributes will be different.
+
+* ``trigger`` directory is removed.
+* ``in_voltage0_sampling_frequency`` attribute is added for setting the sample
+  rate.
+* ``in_voltage0_sampling_frequency_available`` attribute is added for querying
+  the max sample rate.
+* ``timestamp`` channel is removed.
+* Buffer data format may be different compared to when offload is not used,
+  e.g. the ``in_voltage0_type`` attribute.
 
 Device buffers
 ==============

-- 
2.48.1


