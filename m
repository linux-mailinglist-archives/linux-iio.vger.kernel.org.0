Return-Path: <linux-iio+bounces-21676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3BBB0560B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 11:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC3416BB1E
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CF32D63E0;
	Tue, 15 Jul 2025 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="LwLN1F7M"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456A6BB5B;
	Tue, 15 Jul 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570931; cv=none; b=cHHhb948b85z4Y9oKuIUpaKVibbV96PRUB7RGeyqiVoYwV622xmD3IBn2tCmGiVsGj2ytWCM9ks/z0lVnH4EJFB1QZgSPsyhAaZktQh9pn/Ft8kOHeOEesAbbHDYKkI1UXZdPuWgNlT8Ol+lbGPPqqtXRki4hlv1I+xyCvk8GZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570931; c=relaxed/simple;
	bh=qOedZv7756/fVVd5cPJtxxIJU+1REqIcJB4kfq+mB7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8Qm8nL1I44EoTBtKjyb2CK5lQ9+7Vw2+pd6DAQczt/IIJ2lu7PoeY+ba+maFUgVPb2qGYDhpYnf//TXJZT5ucf9fi3dsSzxNGTej0VJQADDufMzCJ10VqjlT3BXdihCZOkfE03j9t5t8TfEYuwBCBF1whljz2HgFcJzOynA4tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=LwLN1F7M; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cNybS8mn+hrVW7tJqT823GFnF+wuyNe0y7fZM7Cs0D4=; b=LwLN1F7MKlmbegR5FqVMBSGDyH
	2q9WZNEmB+wN9RBY09AbFaDIOonMu2h3qdLaheds1DNw+0DRGULpm5hlVN/+vJYBFyiJeqj3uBgiG
	hwUqv9rcWaHiJ6IXUy5Oh1gGJO/AD2b3KTbN6pkVXXTlcaOzcs2QNFXa7jnmfqlOSW/iVlZyOzPFB
	uWu4fc3ahy52R1Ss4vBgfv+euZyVXJ6f/ClIzGfvFMAO2iH9vLbvZkSzEfpa4gyNI98jmziMm/E0u
	xH55Uih2UHWrZyadvNHxpqaFeaMWYITza4uFExymvzo8ctEVVK67zjObhzJjQv2hzzsTs5FZPEUFb
	g3Hca5lw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ubbVC-000HmM-0N;
	Tue, 15 Jul 2025 10:59:06 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ubbVB-000AWe-02;
	Tue, 15 Jul 2025 10:59:05 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: lars@metafoo.de,
	javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com,
	andriy.shevchenko@linux.intel.com,
	arthur.becker@sentec.com,
	perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com,
	muditsharma.info@gmail.com,
	clamor95@gmail.com,
	emil.gedenryd@axis.com,
	ak@it-klinger.de,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] MAINTAINER: add maintainer for veml6046x00
Date: Tue, 15 Jul 2025 10:58:10 +0200
Message-Id: <20250715085810.7679-4-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715085810.7679-1-ak@it-klinger.de>
References: <20250715085810.7679-1-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27699/Mon Jul 14 10:54:31 2025)

Add maintainer for Vishay veml6046x00 RGBIR color sensor driver and dt
binding.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb025a19..d38e92d5229d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26424,6 +26424,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 F:	drivers/iio/light/veml6030.c
 
+VISHAY VEML6046X00 RGBIR COLOR SENSOR DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
+F:	drivers/iio/light/veml6046x00.c
+
 VISHAY VEML6075 UVA AND UVB LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
-- 
2.39.5


