Return-Path: <linux-iio+bounces-27860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDDCD32AB7
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 15:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15FB8309CB45
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 14:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4650394493;
	Fri, 16 Jan 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S13uX1f+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B293393409;
	Fri, 16 Jan 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573959; cv=none; b=k5GXO652FY6BQrpaL+44wDpn1HUOncD2m2KgrNsIjiJClaeVJPxrkBHt/wb6XE11hjLB5Gqw3JmRW2Dia733/1byD5yUSIh486gbwdZ2eRHlBa9GzNZGO/7Ddqjyu/+xEt/OFop7OYOoSuxNGRgY+riLu8i4x9Cq/JtdQA0Qk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573959; c=relaxed/simple;
	bh=o2HxcyW0QStTKG3nQqZIQ6OnmiHT1M67S0DXHoU4M3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1sanR+MMwIgBZMzEWGozYrahPdel9eROrNycdh9s8J3pF6Bus/tQAZJG11DSb93/t1nnCArkAidd1EbbqMUcFXYG/g0gbGM2z5p1v2yVtCiG37YlDxoZaeq8kPR+bt6UacCYJL6zQY22ZKBbiCaqJvLrCe5fwokYWGFhoxvM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S13uX1f+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2629C19425;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768573959;
	bh=o2HxcyW0QStTKG3nQqZIQ6OnmiHT1M67S0DXHoU4M3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S13uX1f+gXxns+EU8HqI6iqgZ5N39UWgZgh+KIhCUSnJkdOmAhlN++b7K4JpbC9S2
	 DexRc4Fb2JwgPLk8S3uuT/81uYYi8moWNFO/QpSeDYYT9i+jaGsXv8xT874LWCDPA8
	 yoxHTKrg3eQ++LobW7QUAYqurEu6/NR/8FclG2GJE122GFVVQg0SyavSEPIURReNJM
	 BJWO3NVacpr6o+n6IN7LTsQhy4gP0egkk7tL88rVAFIO3OE+adGa8mtvHIWvW0BHiT
	 ODRxg6vMZw6qSuTCZSavKlaNsRANPgIIVADTfhYlqPLBzl6wpGuXjufx8CNDIb+d76
	 Cw2wZ/4NqIhIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E859AC982C7;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 16 Jan 2026 14:32:26 +0000
Subject: [PATCH v4 7/7] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-adf41513-iio-driver-v4-7-dbb7d6782217@analog.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
In-Reply-To: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768573956; l=1730;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=XmIPEdRSVNIKebBJlrt1qNk/D+h4L2zUrbtQ3vK3kdM=;
 b=tAIkjD8vTZD3FobOdGfBvm/RNSCgC8cE3Pa5J5V+RjNyF4JxuH/cnLQVvaQar9H37Oc1QsVch
 8pGAYLn/iEsBvpOgBnLcYpjbtRzNqTRwqcufQktStP4BeP8V5JSGd9C
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add ABI documentation file for PLL/DDS devices with frequency_resolution
sysfs entry attribute used by ADF4350 and ADF41513

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-frequency | 11 +++++++++++
 MAINTAINERS                                       |  1 +
 2 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency b/Documentation/ABI/testing/sysfs-bus-iio-frequency
new file mode 100644
index 000000000000..1ce8ae578fd6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency
@@ -0,0 +1,11 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
+KernelVersion:	6.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Stores channel Y frequency resolution/channel spacing in Hz for PLL
+		devices. The given value directly influences the operating mode when
+		fractional-N synthesis is required, as it derives values for
+		configurable modulus parameters used in the calculation of the output
+		frequency. It is assumed that the algorithm that is used to compute
+		the various dividers, is able to generate proper values for multiples
+		of channel spacing.
diff --git a/MAINTAINERS b/MAINTAINERS
index e61619af9248..46a88498cc58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1623,6 +1623,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-frequency
 F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
 F:	Documentation/iio/adf41513.rst
 F:	drivers/iio/frequency/adf41513.c

-- 
2.43.0



