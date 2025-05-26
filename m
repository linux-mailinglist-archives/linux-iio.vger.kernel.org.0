Return-Path: <linux-iio+bounces-19923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF219AC3C0B
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 458717A8BA2
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 08:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5F1F3B89;
	Mon, 26 May 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="jnHYW2Io"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FBC1EF397;
	Mon, 26 May 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249491; cv=none; b=q/troB6n5p3rs43KRLHlPcSGlBqmd7x2tMJ9n95SpG771q/iuOkDWJWxOFxJqFfiiLiOARl1SvjpF1Ds2ELZnvkWIXzTdnHuFWjbzdUezwe/WOnhrmw77kgH4xBT48UO1Ujo1dvL1CcoWI8Uzl/6QY3GTuMLq6whEgwST9nwYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249491; c=relaxed/simple;
	bh=4hDFARImdHW8q9Xkt1GJf+mXey0ax2ZFZf6iSRxik/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4orSFFt9YoHRMhTj7lO55/u3wpKL6vkET9Md76FBRGDjp0QtLJ8ZRMOUgVuPPSZ3Xo4Q0Cz+bgg6JmpjeXC0L79RIbCxr7pOHQ3wPlkz945d7kFFd102ffOM9/1N4SY9RCSzXU/4TKDTm1e0JtlzqIba0yYnPzocKTtAVt/lsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=jnHYW2Io; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=SwZCyK5YKWN6Lzgo880+koOFD+smQUGpll47r1Ci+jc=; b=jnHYW2IoW2FO1/0AvxflAAArGV
	F6jlek3Y87GTtpkDRW42Rm2IC9yOmm/nG+DgI1PNOU3y0C/F1nEEa/UwpRRq5FNZpLlwtmXZ0NBU8
	ODaIRVY/stgFmkDRFcMbt/lmgz+yX75+5tcFZNGKYNv+VApIS3Ne97YFkFFKG860HIAqVFuZM8V3m
	+7HwBgqA999VDiEx7kMkLBDcRCkW1NaQhpL7qp9gvxOwYYLNJsBMBxNVC1BfkUOhAfFyrS/OfxOtD
	1GfEznn1/JoKHHZg7K4XsD72LOkJ1helVe4sWp+a74O8EAJM0t2s1txFNdIGPXVi6xQ6XFuHSMMFi
	6Cw+SvmQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uJTYM-000CrG-2X;
	Mon, 26 May 2025 10:51:26 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uJTYM-000C3y-11;
	Mon, 26 May 2025 10:51:26 +0200
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
Subject: [PATCH v5 3/3] MAINTAINER: add maintainer for veml6046x00
Date: Mon, 26 May 2025 10:50:41 +0200
Message-Id: <20250526085041.9197-4-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250526085041.9197-1-ak@it-klinger.de>
References: <20250526085041.9197-1-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27648/Sun May 25 10:31:16 2025)

Add maintainer for Vishay veml6046x00 RGBIR color sensor driver and dt
binding.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f21f1dabb5fe..872273ee6bf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25859,6 +25859,12 @@ S:	Maintained
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


