Return-Path: <linux-iio+bounces-19931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382D1AC3D99
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 12:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CB83A466A
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CDE1F4CB5;
	Mon, 26 May 2025 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SgetagGs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0D1F463B
	for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253886; cv=none; b=jPJInsMqU0W/4984S7R0MNc2gaIYAYKRLnCA7hlQZVJCQNLW4uUTIIjtxOvxZ/X9pANQEKiAW4v7P9QXtGvZvJmX6SL0nAi1bL9Xj9hNsy4VA9tH9DE0hncweE+EDcsY7rGL1yZN0XA1npUNAXLRKtCyHgJ2zpkZ9dEzii0koEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253886; c=relaxed/simple;
	bh=vFlQmUYfvlbdocc1660HFvFkLaTTtU9EJLRp4LGDp64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YdmP3Y71ebaTn9EVWFVxccCyT/QyHjQder1k1TLJHRwOL9xq6/aLH8EcujK+fuGcGktT/ENoEeP6CpP9R9BtqcswDaSCP30TBTYxq0KODzaZIWiQIF7IY+9FWVpesMtL2vBUKp7GCPceqS1UF8nX419kcL7ls27MpitflEYc4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SgetagGs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso28822495e9.2
        for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748253882; x=1748858682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8aakW4/a4S4nlb27SNIiYOlQ/gC3M9NtCJYtqbcxPc=;
        b=SgetagGs8PSOW6gjJUzHNSL5KPbyJ1sL9I2V/IWqwD9YnWWb+38p2+oQ5gavmbAq2R
         Cos+w2j0ZKhg7kX6jByUIJe0/VkA0DW7Gh+YevRwbNaSY6L+AsWY6l7Hh6ctUTCK34Fa
         zYwtbajXaADGRALvhHLSEQLtgfD7E6zJvvSP27ZJcJH9aSK3nrTHNGAfVLQ1QIkCGZ92
         VOzV4eNytJypC2RL+fhijepz5q6co6urg0mTcKb0/fglon9LLv3etlyz2oXCNUMzdv1A
         7iDLafPdp561ZoLxGNWDMhRB+PHnnU18E3shRmU4hudOlmx75TP1k1fWSzzovZUCOoed
         pj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253882; x=1748858682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8aakW4/a4S4nlb27SNIiYOlQ/gC3M9NtCJYtqbcxPc=;
        b=MG+FoEpU2YOWTsKGK+g7ucxyNd4J3yvcaY56xma9DfLrQX4aXtGq4yx9pNFg2ebmDs
         emYJcLa3g2NTKNW/B96qT0yKfQNoG0DOqCA9nKbdpmkr2wdD0zxazn2v7WZMqIVW5rQT
         8qG6gsjt8ZdNAkOpZSVzWFld/fjxxofUmsknCeIas/OU3ne7bvfgzuzrPoxs6jMACtYg
         Ava9OPC8X1tfhQ+qc9joh+pJtAe53aYyNIRFXo9cj34n41EH+RI3G41GETmOokLLfqZk
         3lAi3QEaDftfiyAhAxpn7ynlBt5TbsqfzD+HMqQcZ8S2J6mjSAMSWLQp77x0MjIkynsy
         K/DQ==
X-Gm-Message-State: AOJu0YxKZx9cOIINHa4gh0AdXPaXohAjYHWuqLNsPccKHxEL9FoZETta
	OJVba1+NY1BRdBHVZJIZwESy9aTGl6hI9VzVuztk3+sgD1lJNmq7xK9bcqfPZgWXIzM=
X-Gm-Gg: ASbGncvU2InbQ0rzYFUkqW0hcrSdzkARbOeesDmEqbW5LaPlpQjg2hdBOjR6gPKcPk/
	UOLvYx7XEvIVpUJzS9HhYzKjRZJOv3IArqWJ1NO/dsxHhnUFvuI+9e13qslQI5Wx6fq2b2gokPg
	c6VTrvbJ6VW1BYBIbJEvFdYJj8oPfXgLuADuIxUPjLzAME8NZCoq/Tw/6YCz+MDX+NBZOXtRTyL
	OIVXadZiWxfDJ1mVhlgUzhJ5prlRfGOrcfUofgATIe9TlT0LlGia/iInWLZ9SRM6QdyCTeEXcD1
	hqeBMldVZvwp7Qbh6Y3KRPE8Az6tu2WMENrUerVTQBKnZJODE2zObGTzDSEtRnPjWU9lkgcPioQ
	bdCrmSIkHBn7qSD/BKXUPqva6AJOqT3Q=
X-Google-Smtp-Source: AGHT+IHV9Jp069LZjK2ZpV1/c9KQ2bNBfj2JjLVwtRuY/y1IZo9228sqOpSdgVRYYQ5s3ofRpZ1qNg==
X-Received: by 2002:a05:6000:2890:b0:3a4:d7ba:940f with SMTP id ffacd0b85a97d-3a4d7ba9678mr2708636f8f.8.1748253882426;
        Mon, 26 May 2025 03:04:42 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca888fcsm36141834f8f.78.2025.05.26.03.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:04:41 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 26 May 2025 12:03:16 +0200
Subject: [PATCH v7 1/6] Documentation: ABI: IIO: add calibconv_delay
 documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-wip-bl-ad7606-calibration-v7-1-b487022ce199@baylibre.com>
References: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
In-Reply-To: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=m1V9a4luyCqmxst4hAeMv2hk5LxVMC81ZTSMIekPDQ4=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgwscm+fy5Mqzei19Suf4fkFLsQo8JKtimLciJnL1fVv
 jD/l71ZRykLgxgXg6yYIktdYoRJ6O1QKeUFjLNh5rAygQxh4OIUgIlcuMHIcCtPn2N1a1fJdps5
 zQYczLLeXObN5X1tyVenx8b8/N27ieF/za/ClMUGpWdEI1I6DNz1f95U+JrCdjH5T39aaHUP6ww
 eAA==
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add new IIO "convdelay" documentation.

The ad7606 implements a phase calibation feature, in nanoseconds.
Being this a time delay, using the convdelay suffix.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ef52c427a015cf47bb9847782e13afbee01e9f31..7e59cbd5acb85fd0909c1d56f9d76a84933d418a 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -559,6 +559,30 @@ Description:
 		- a small discrete set of values like "0 2 4 6 8"
 		- a range specified as "[min step max]"
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_convdelay
+KernelVersion:	6.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Delay of start of conversion from common reference point shared
+		by all channels. Can be writable when used to compensate for
+		delay variation introduced by external filters feeding a
+		simultaneous sampling ADC.
+
+		E.g., for the ad7606 ADC series, this value is intended as a
+		configurable time delay in seconds, to correct delay introduced
+		by an optional external filtering circuit.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_convdelay_available
+KernelVersion:	6.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Available values of convdelay. Maybe expressed as:
+
+		- a range specified as "[min step max]"
+
+		If shared across all channels, <type>_convdelay_available
+		is used.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale

-- 
2.49.0


