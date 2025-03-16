Return-Path: <linux-iio+bounces-16914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF03A636A2
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 18:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C552716E812
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955E31AA7BF;
	Sun, 16 Mar 2025 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="A7qC9ZSC"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B804032C8B;
	Sun, 16 Mar 2025 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742145041; cv=none; b=bRoFbE/QupFAYEe8FMe1lEfQlRAnwWFDICevp23oP97dxz5d3YgNmUYZSQPMD9R55GXCeGqT+WHfQtIoPJbSZDcqvL3T03nY3T6NyphjQho7ChED9CB9cTJBOQBjoU7GBX1jdkW/Wz76WV8JON8i+Pfcw8H1B24hXHUGbK1dIWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742145041; c=relaxed/simple;
	bh=QbxOt/p54DmSJP4dWQ2+aIefJ2c8bg/B7zel+FD7QxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/R+1ZWkiCE0NeFoTRI4rUQUOOG1A6FSm+jk4mZJTCLJgp2RsHk+fimH6LrBKyDMyQIz6wEKoIjGawoCYhUHpBRF3KDgZa7uQE9+6IBxpnCwiK0x+vBXJYWx+qMidPv40a44YKCisAu0CKcK/Fl2pIxoHGxoMmxQx88AanKvM3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=A7qC9ZSC; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aN1Pst06T43cahFdp7DGzY+KntPPtJvnCVY8ZeSWHe4=; b=A7qC9ZSCiIGTDLA1y+is8wGNgO
	1OsmNGvCDJDE0lKxNlFcjX5TM/Fhgxe8kJ5Bq/NAHg5o1P0zlEd3/UEVc4YJfAJ3FPXwnPQ5itl4v
	9NamJI/3Ry44IgJjdrvrjHTtW/MR+xVFzbeHoU4xkxiRdXsKL1EVN2PzjgURewWZZl+CjVFqrNXG/
	xH3ZLUui3rM8HzjNLUDuSXfryiKt5f7J7N2KjR5kfG7zQo2UCOjnmcxqq05cMuxoSbFz81w48SIfv
	gYmoH4rTbtNjuLtkcY2D8bIlGgZ82+MS6ErsNfZtgtEOhD8xhemBXW00KoV6flGuXqXbeWq0i3U7t
	MJNFi+Ow==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ttrAR-0000Da-0I;
	Sun, 16 Mar 2025 17:48:51 +0100
Received: from [2a0f:6480:1:600:fc64:4dfc:9829:9e5f] (helo=anderl.linuxhotel.de)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ttrAR-000MlM-0a;
	Sun, 16 Mar 2025 17:48:50 +0100
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
Subject: [PATCH v2 3/3] MAINTAINER: add maintainer for veml6046x00
Date: Sun, 16 Mar 2025 17:48:13 +0100
Message-Id: <20250316164813.30291-4-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250316164813.30291-1-ak@it-klinger.de>
References: <20250316164813.30291-1-ak@it-klinger.de>
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


