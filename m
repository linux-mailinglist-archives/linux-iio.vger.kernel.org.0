Return-Path: <linux-iio+bounces-16903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7335BA6357F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C070616D820
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFEB1A83EB;
	Sun, 16 Mar 2025 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="fMY2ZFmA"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4D1A76DA;
	Sun, 16 Mar 2025 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742126151; cv=none; b=RR/dWAdqoq77Ygu6ql/qCGgGd2fdesqGxFDM+MQA9p0zx2YJOa46cp5uDaAiSffbrdhCi8BREc42ECf43qQGzWEkqy0IH7PmXpdUTc+d/n21sDB5MxbKybPHDpYXBIngxSJxPo3EbkXzeagi81c2snZKMdEtb5E4iMtLbPJuRN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742126151; c=relaxed/simple;
	bh=QbxOt/p54DmSJP4dWQ2+aIefJ2c8bg/B7zel+FD7QxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t0zG48r+LBsDh4CnvGr8XliM7rG2UL1N1PqSqCP8mJTj2nyQy9U07OOCYIpO1qfKSaTxkwO4brlW9SfMxM72bvmXz5XMkdewbrlIdPP2ep+lssuFS13agCDgV5CVE9O5n3dpJLCYdT7O6iwcRJ/kFbULQ6TcpMyb9QRn8icqDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=fMY2ZFmA; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aN1Pst06T43cahFdp7DGzY+KntPPtJvnCVY8ZeSWHe4=; b=fMY2ZFmAI9N0ifUS41re2UWNAs
	7H65faB/7HQTrFXHMjrqRq8e4TujVE/YZPmjfTQGGsXdlKFHypiPxejNBDVS4AZTNU5NhV/PSVThZ
	Ck8Re54wKuDa9lCn34ssVNuj1h4AG56DHQ9FfPsxSN60fUZAWOmfLTTByq/1mwGjoay5E2Q10V/1e
	vrDE4Uj/4x3m4O8dUmfhISiJT2bxxzrQgJJl62fq50KQuGNWCEma3kvR2MlRbPir1AKFEjddzsY54
	oT8OYP8fb1JoZAdAYW4UjbVgxUeYHnXl7yDPhRj1ZPSBHWR4JCild5wqcWE/IZAg7uCFAqz3DID0y
	T4iWZ65A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ttmF1-0005hR-1c;
	Sun, 16 Mar 2025 12:33:15 +0100
Received: from [2a0f:6480:1:600:fc64:4dfc:9829:9e5f] (helo=anderl.linuxhotel.de)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ttmF1-0008s3-1S;
	Sun, 16 Mar 2025 12:33:15 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com,
	subhajit.ghosh@tweaklogic.com,
	muditsharma.info@gmail.com,
	arthur.becker@sentec.com,
	ivan.orlov0322@gmail.com,
	ak@it-klinger.de
Subject: [PATCH 3/3] MAINTAINER: add maintainer for veml6046x00
Date: Sun, 16 Mar 2025 12:31:31 +0100
Message-Id: <20250316113131.62884-4-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250316113131.62884-1-ak@it-klinger.de>
References: <20250316113131.62884-1-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27579/Sun Mar 16 09:35:38 2025)

Add maintainer for Vishay veml6046x00 RGBIR color sensor driver and dt
binding.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9763412a508..5dc2ada88f2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25281,6 +25281,12 @@ S:	Maintained
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


