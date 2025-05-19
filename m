Return-Path: <linux-iio+bounces-19656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4E3ABBACD
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 12:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079723AF6AB
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 10:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50432749E8;
	Mon, 19 May 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gvQq8HzH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E53274657
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649735; cv=none; b=cb/sB+m5guqNxLXqEgs6mGudj3ZzkI77Rai3kyEoJV4SVVZou6NkAIgpQq3oFeUyh4Ln7STL8ukSu6ECOsGYt/QhwPBj/IuW7zvs3Q/7cNgB97/WEF7p58qNbaNnAlTYR947R2T+QQgebTliLm9nV08G2srZHEXZsffW+Lh3/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649735; c=relaxed/simple;
	bh=kAXfCDDkqD0YIX5fRdivLoZDb1cS9/ZqEEtcHuRvJc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNXGsoydAVpndlCzLlVR58ZAssEPEOj9zs0eZLVI+p0uu9rDJNxN5QuOnqDUeu1hU57nQCCTw9JK8G5kijtZI+H+SEAu5JkjaPA4N4XCTUXzmbiJkgwgG7fh1jDBp+bn92Ca70Cn+fBCVOIqe+98Z03FUDjvu0K/NArDl3rZRJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gvQq8HzH; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a376ba6f08so127600f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 03:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747649732; x=1748254532; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCnfzj1ToVJ8veFs1TqP1KJeHenvC/HvjKycXP/yVqE=;
        b=gvQq8HzHrxAwosigLcKy+tRLlQSxdstOmMmayhHeowy7WvjKNfMUJCNqj3VIfLtNH5
         13kQ7eptQkqs+PSXdIyQ5cuGAh9ZrIFyj0dzASNro6XMp6cbm24euF4aSFADsKBXs39n
         VHDPyM6rZFUf5Ed25roBhiODBPDuqWpwXqVdKAJ+ppxpXtb9gi4W6lbcnAbpLq5UKaIm
         7RgvWmO8/FkhgRCz0wJfATYlXRm7MiT25OaEqTtbLGZ4OAzOlzcg/vBurLeBsTxNp4b2
         oJNv8eg7mqpcWa2/WpLcrYwsffuyOqrA+mCnzeOuI3hCEwXpe7DG/k3/g2QvMl/elbKH
         Ia6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649732; x=1748254532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCnfzj1ToVJ8veFs1TqP1KJeHenvC/HvjKycXP/yVqE=;
        b=St6H54MMBixKqXfaaRd1Botcp9hixPEZKI4rQtHjuIsS3e3smhTxD2O2tzXIfN1xOE
         nqkANTcV9Hd9I+VxTsldXsJ/0yMUx/mJHH/fJ86UfCUSVbJagZ8b7kYSgCsG911BhjeL
         1loTTutfIRK/IlwKjyYzKlMIbH+4DgNgkY2ezZW8bglXnA/gRIRRnlJFXdl5kBxA9UY4
         2OA2ukoTt700Xsi1FgHxzdhEy/QRLqNJUlzdzVSg0PJhN0gjCOcg0ByF4NCBsNVJ5t8+
         ERIEYEvgGtoTmlzWv4O/Y/D4eDYZRj/KCY2Z5AIQt8ruJ8yX1THuFCzeSS66jZ4HtMx0
         n2Xg==
X-Gm-Message-State: AOJu0Yxzp8L6FhA2YXnMCqAYJa3l6vF36xQ/uOrzZLIAQ04eE/FwWbqJ
	KchXgwe0PGTzufwpMunc+ClEDgZvMLtrhHXbzxs4p8OTB/S2sKnca7wT3WhWejXAFU0=
X-Gm-Gg: ASbGncv3QFEAIefE3j41tVuG33XxLHtQJBlHR5LnEyzvFwyUOABsCGx/du84IiO+D5l
	2omKAix7A5valBhbwUjF8Ry3v7qs54gh3U3OMygUnNB2iMXyUq/qJnst+xAehWYT0/W1JlyJReS
	3DsDPOhwUY9Iql9sfhke7oHkeRvcC/zIPuuDwgV57U+/vozXW5JkLLezoANAVrSCwO7Ud8xHuhQ
	sWqfpu/BEvwgmwVUKlXSkjpSVOWKzoFwydPdVLEXjCKlQp5h+eMxHN50kAfIaPZ/4cdtqN0T5mB
	ODukvAPJfU2NgoC+gvIare7gbFvVVVDp6LDqkOGAbiXoRNzgCek+J0fecWSYF8sEWxcWsjlOybO
	E4fuGzH/eESSACYCxxNfSzdCD3sdWpew=
X-Google-Smtp-Source: AGHT+IEkeNEpFV4F4DukOo+8s4LSL5goJzYTBy9MSihVWCaRY8jONp/y+12U3eIyMbpPCa2we8wGpQ==
X-Received: by 2002:a05:6000:4313:b0:3a1:f67e:37bc with SMTP id ffacd0b85a97d-3a35c7dca79mr10651186f8f.0.1747649731714;
        Mon, 19 May 2025 03:15:31 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm12499021f8f.11.2025.05.19.03.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:15:31 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 19 May 2025 12:13:38 +0200
Subject: [PATCH v5 1/5] Documentation: ABI: IIO: add calibconv_delay
 documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-wip-bl-ad7606-calibration-v5-1-4054fc7c9f3d@baylibre.com>
References: <20250519-wip-bl-ad7606-calibration-v5-0-4054fc7c9f3d@baylibre.com>
In-Reply-To: <20250519-wip-bl-ad7606-calibration-v5-0-4054fc7c9f3d@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=WN6HkM4XgPmjxefJhFewSDj6qFVZk19CADasf1AQmr0=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsjQZol5vdl757rEBKY8s/9MKk8Ze+XZkpdHzDG+kv5cZ
 KqkGmdWRykLgxgXg6yYIktdYoRJ6O1QKeUFjLNh5rAygQxh4OIUgInsW8nwP4736t0wBo0JtdrO
 SmfirR6Ka8y0VZ+zzOurms2nK7prVjIyXF5wLK5dLoiJ49E/VlvFzCY3zdo0iSUhprvXFPPLvHN
 jBAA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add new IIO calibconv_delay documentation.

The ad7606 implements a phase calibation feature, in nanoseconds.
Being this a time delay, using the conv_delay suffix.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 190bfcc1e836b69622692d7c056c0092e00f1a9b..4cf482eca3d8a0a80b051fbb496f82f836ab76f8 100644
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
+		I.e., for the ad7606 ADC series, this value is intended as a
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
+		If shared across all channels, <type>_calibconv_delay_available
+		is used.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale

-- 
2.49.0


