Return-Path: <linux-iio+bounces-27544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB64D03548
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 15:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCCC6300B695
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2688B4A5B00;
	Thu,  8 Jan 2026 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX/mUYo+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01748482201;
	Thu,  8 Jan 2026 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767874517; cv=none; b=DUIKpSWBFMjtn/lvcMKaro4+6+vy7uqj5vK1c7LxwZMPMPQBC/WtVf3CqzADTZiIwskYdJRHJPxKnaWrmhuxyjxqYVZyWtQTT4gczJ7NBy6Z88EThMzmHW25ULEmYvD9Zo5FeA0AvDzuNrmajq70YJ4rkdAqnc+7azHUTGOQ2yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767874517; c=relaxed/simple;
	bh=puoANkdqjUwpAENBzs8EIsrA+jvE2c2p91Sby4FaBTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5ZB+cF3FZ4ao1LZ8RzZ54AYGzXIj7rT2FyhvhvBCll6MsjpDNqIilr/xjHXJNWeNUU35BY80rTmEUljuY8cwVpk6WCuy+9XUwpAots68ycviEK4G88+iT3neRRXWez539Ekp03Uq4iVMA/YcFpmE9U80z0J3OOUuT9hYZ91zmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX/mUYo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8149AC2BC87;
	Thu,  8 Jan 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767874515;
	bh=puoANkdqjUwpAENBzs8EIsrA+jvE2c2p91Sby4FaBTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XX/mUYo+F2eEwHAbwMyNmVn8nE5BMs4wMQLsErlA9zGaerbVq21ZQiZ1gDLdgmr1Y
	 uQTI8y7dibK4pqSh4COQCtbrfxFDu8JNuFDXCDpZALGoBDe1th6ZJvZweIY0eMAgEK
	 OHymePtlSF8AGISMOzkb6BdVX7O9BjRb9tv5qq6z+hoA24GbUTznus6xmsLJdfm2l+
	 JrU8q5Bjh8vZTRqWSt11dS40iekBbFeOT4F8vAc8c8mPGHOAuxMTE+sbSlmfVuEblF
	 1q4Ug49jjdUJwq8R2hR+Qb0QqfBVE/IIY2KFb43nLQte2TcrwixNxIU+5v/UIkFkhb
	 yJ5eXr/fRJQTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DD9D185ED;
	Thu,  8 Jan 2026 12:15:15 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 08 Jan 2026 12:14:55 +0000
Subject: [PATCH v3 6/6] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-adf41513-iio-driver-v3-6-23d1371aef48@analog.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
In-Reply-To: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767874513; l=1730;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=G8lkskp439tmkyRoT9F24VAmxHi49pi19EkNAx8s4Mc=;
 b=3wJO6+sacBSehsN32V8hDJVbltIkuZW6oQEBtjzTIHPVBMMZAPW88TZVj39pbuwlb1qMTqhDi
 utJND7YHF5HDjNPZAcL55s0Dny6c5+s1CuuuR7mBLK9q8R1XWDa64R+
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
index 3bb7d9fe7ed8..f0dc0e7c1bbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1615,6 +1615,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-frequency
 F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
 F:	Documentation/iio/adf41513.rst
 F:	drivers/iio/frequency/adf41513.c

-- 
2.43.0



