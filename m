Return-Path: <linux-iio+bounces-19650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AC0ABB4D9
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 08:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C23B76A5
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 06:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBDE225413;
	Mon, 19 May 2025 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="bLzxZKJS"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF33A2253BD;
	Mon, 19 May 2025 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747634974; cv=none; b=czZKdF/RoPJQuT0vvFTVHjvYGvYZPA1+/TKAayJKU41Chd5545udRiwapd9a/8LNQsCnok1i3No8gbPKBd3LwajWP3Vw6qvOxnDoy7/MnygefJhKQ8UjJr8pUjKr9yHKEYG/nGPhFlNOrf5wareA9GA8cXOJLETxL1RRXHj361Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747634974; c=relaxed/simple;
	bh=4hDFARImdHW8q9Xkt1GJf+mXey0ax2ZFZf6iSRxik/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aAtpOiK+Q4C29ieIyn9BXaJ38jtDxzmrrRtdRj3X5U7cvfv40PrWzoK2NWa3TTn2n9+Bzp76KrHjE702Yu8yBE3exyNksRv30cHcy0uy6ohjpLSH7EsMQeJSGPiMcjhOOotCvpcO5QOuqzhGD++fbxeBTe/fygDXj9ql8q/LTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=bLzxZKJS; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=SwZCyK5YKWN6Lzgo880+koOFD+smQUGpll47r1Ci+jc=; b=bLzxZKJS2PdeYvbI+rwtGAoKbT
	WxPCSljV/maQWfvJfantzyVAVn5QPoG8lb4CjgW7n6X0ydlJCMV+gyQ7HDdM7BRH82kczT0bUzNuL
	Ya22YtW9kSSvqMVILnmFPCl6i9+jAkv4G8sOkmY2ZZHARJQnlGUPXyygn0cA+nDZU5sO3yU3ArKAc
	T4I18AZKnNHaoubKGk36ncjve7R56g5f34XqWkeQ8imAL2xO/KdxvxVa3aon38r3zgTA/Rmwv8I9A
	zA9PMoAq9qyNNiaR+/nzxYgKKGXMJEwifEcyVTMYytJcau/MpT6JnqCpTTPQblnbCOYNjhwOSo0uS
	LVldmWpg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uGtgo-000FEF-1O;
	Mon, 19 May 2025 08:09:30 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uGtgn-000Ogq-32;
	Mon, 19 May 2025 08:09:29 +0200
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
Subject: [PATCH v4 3/3] MAINTAINER: add maintainer for veml6046x00
Date: Mon, 19 May 2025 08:08:04 +0200
Message-Id: <20250519060804.80464-4-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519060804.80464-1-ak@it-klinger.de>
References: <20250519060804.80464-1-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27641/Sun May 18 10:31:14 2025)

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


