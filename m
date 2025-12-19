Return-Path: <linux-iio+bounces-27195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93451CCFF73
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 14:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2F333011A5B
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A669D346E72;
	Fri, 19 Dec 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teBvR8B7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B48346A18;
	Fri, 19 Dec 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147694; cv=none; b=dulf7qeGaHUpgxPQWjAJ8fpPxr1jdGoLVCc2Q41zKEpUMsmpP/fZpVH50FQS2NWnFGSz3bkb9VCwz7MCf1LqH9NogkUlcUFMEC00mQFABJFVToAvmI2+lbpkTaVfOZhedYhIZwW30eQIW3wMqkn2hjZTf4mR5b5xEm3fxkViFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147694; c=relaxed/simple;
	bh=fOzAHkxt5iinVm06DoISIgR3PqOmEltc+dyaPliZvww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kOEoXNour6KYqz/8wJ4/fw7CJ7Rq41vDv6HeX4rQYh5T7MTGp1iJFABfCGtTztScbAMn68o2k/0jAwQWS6KFaAAIh3iGd2HCFVI+ayofjgp3wXczPTpIwiKZc8tjWBzuPLt8ohDMjuibo+ueu/isNSljI5DSDED7p9Tc1vLkhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teBvR8B7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08ED3C2BCB1;
	Fri, 19 Dec 2025 12:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766147694;
	bh=fOzAHkxt5iinVm06DoISIgR3PqOmEltc+dyaPliZvww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=teBvR8B7UAfz22+Cnkv52nIeZ2mqh/xJCCwJyFI/tEeSoJZOkMOTd+iSJ5KRmxUi5
	 cqu1e8GnNmu8DvTMatnx1TgaCd2NoLUF3h+XKv9Ip98L8U0plMrUN4mKvYzRgf8ysl
	 Z8qR3UIN5A6LImgkFctiGkaRgjWbCjgk/WlEeU3xKvW7O126wkJrN28QvWvaNE++IR
	 Nica6YKQpLjl9o+LskvoafwdXj/8mzLXZ5SVxnfRuXzf+kAWp/TUG9F+lmHk0wMJpc
	 I15P0t8zTh38wHDreupTjVxCEicG1lVUiTH2BV7W1bCLXyvwVQeRH3VXkw77jkcrcE
	 F7izyvaXOYEBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32DFD78769;
	Fri, 19 Dec 2025 12:34:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 19 Dec 2025 12:34:53 +0000
Subject: [PATCH v2 6/6] Documentation: ABI: testing: add support for
 ADF41513
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-adf41513-iio-driver-v2-6-be29a83d5793@analog.com>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
In-Reply-To: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766147692; l=2353;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=1MCQTuBKOvCkCb1guQDYrrs5FOybrR5OguIAEADSstQ=;
 b=zX4QIZP0+UKrF3EhmsaEgvJ+ku29ecs1Afhul5WA+1NSVinSR8fzUk+v/JjcoiJWKOrnVn10h
 x3AsagCyzkNB0F8aWFXZOghVDX6URAaVvjHkzeqnoL/fsMbTRi/X1/7
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add ABI documentation for ADF41513 PLL sysfs interfaces

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-frequency-adf41513   | 27 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 28 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf41513 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf41513
new file mode 100644
index 000000000000..11ffd248eedb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf41513
@@ -0,0 +1,27 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
+KernelVersion:	6.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Stores channel Y frequency resolution/channel spacing in Hz.
+		The value given directly influences the choice of operation:
+
+		- integer-N: requested frequency is a multiple of the Phase Detector
+		frequency.
+		- fixed modulus: fractional-N mode with fixed modulus.
+		- variable modulus: dual-modulus fractional-N mode with extra variable
+		modulus added on top of the fixed one.
+
+		It is assumed that the algorithm that is used to compute the various
+		dividers, is able to generate proper values for multiples of channel
+		spacing.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_refin_frequency
+KernelVersion:	6.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Sets channel Y REFin frequency in Hz. In some clock chained
+		applications, the reference frequency used by the PLL may change during
+		runtime. This attribute allows the user to adjust the reference
+		frequency accordingly.
+		To avoid glitches in the RF output, consider using out_altvoltageY_powerdown
+		to power down the PLL and its RFOut buffers during REFin changes.
diff --git a/MAINTAINERS b/MAINTAINERS
index c536c3afc1ae..48fa1011b797 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1606,6 +1606,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf41513
 F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
 F:	Documentation/iio/adf41513.rst
 F:	drivers/iio/frequency/adf41513.c

-- 
2.43.0



