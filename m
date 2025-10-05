Return-Path: <linux-iio+bounces-24740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 050B5BB968E
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4C014E162D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDD72882BB;
	Sun,  5 Oct 2025 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="b31aQgtm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEDF126C1E;
	Sun,  5 Oct 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669992; cv=none; b=hJq+iJL7ANdLmx+VvplmV9GgC27nxdBdMBg20tCPICidS0BjMZAigBOzqzNMsRfZELmL3YW7DM9/zcl6g7Hf5YPNQU9jnoZeVs0lNyEDVgzEjZJqBhHZUfRUXybWmxv6xBCr+rTt4zargsPOJrjEzbzV+SULVhqCO92ErLJcTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669992; c=relaxed/simple;
	bh=C0F73d6hMVogz9A12rZ7wDVv13XpjXh1c3qpPf7hvvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PtwVDrHcppJGpBYqKKw+/L2xeCbgKiA8GZj45/a5jtEizCXsDpCsDQrY1FcNZN8UFTAS/T7lBxovWJ1hx9n5g93ODINZLV1Phfy7USJroGWWnK3Xe01vBda//y5rNutyhqojhAuEfkKZim4ad/sZdbNMP/CCOUsTW/EZDBj7yBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=b31aQgtm; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 35EC5173BEE;
	Sun, 05 Oct 2025 16:13:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OoiqpWVlQyMaOvts+6yO0xpiCDX0J7fmEVwzjWDN/Ug=;
	b=b31aQgtmQUUEhddkwvyNdIZDTUEjViOatIR2pwa8tJNYpQIkQl+k40PcdXc5TdBzj3xsfv
	4nFX7gMLCIcyojzf4lacqbjIdRpXdCgUhuXk80TzHTs2kOC2h4LD8JHexauuxoy0/v79Dq
	n+jW3x38baVjw+k335yq0xUgZ2F1AhuxiMgM3TSk8XL9TllQWtWR5veu+POhrSU348bTGW
	KOGSW8aAxLEFNzI1CBpWWkFS90VAMo8dZoorXHeGsYfSMNWTPF9sCvp+0YZoGTtVyeboa4
	GCFdIjNWBiCNDTKEmK/XLDIiGwyR+zqCeezB8/Q4EUU9a/eVjpYRGyBl7oPO7g==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:15 +0300
Subject: [PATCH v4 06/19] iio: accel: bma220: cleanup includes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-6-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
In-Reply-To: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=758;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=C0F73d6hMVogz9A12rZ7wDVv13XpjXh1c3qpPf7hvvY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnJzYkxzcTdQSS81cmtKSnNJTGdGYXk5CjJac2JCbDJEME1RQS90SE5M
 QnlBV0lrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtNjd
 BQW9KRUhRcko2ZGpPa2xqamU4UUFLUlpCR2VBR2E4UzhIRTZhMjlxNklaVEM0d3JmU0JsemZmbQ
 pjR3JTci8yZWlnMXhiRFo3bFlVRWswVTk3S1hPajZqaUlHc3ZIR1BCZnBoVkpXTkpYRUxRano3V
 TliUEswRWE2CnBYamU5UEliVUNrWDJJaldQME96Y2FvazBldFpZc0o4NDlqdndLUmppL0xjVDlk
 T0tNTFVLcjQ0c3dNTnRPR0QKV0ozZjVrV0x6YWx4R2Y5ZER2QjMrejFXT24vbEppajlaU3pOY1h
 ldlpqbDRaMjR5ZDhEWVFQZGE3YUJXamhnSgpURVBkVldZb1VKQ3B3bzZwQmV5dmpzbVk1b3MyRW
 RBZGkrdXlhSWtrZlE5UDJVbUU1QS9KUUV4aGdpVEdZUUtlCmN0MGZxTHh1b2VobWp0elJvUWNIN
 VJPcFppSldCSmphWTBDRlJjamN5TGI0U2tQTVluWHEvNEhNZUpGbU56SjcKUHRoaVRPMlVubTZW
 SURCU3NhTzJnazlYRVZBZGFZbHgxeGh1NjAyQ3dZYXA5bmpDQ1FXZ3R4dVVDQ3dvWTYyawpIOWF
 TSHI1TVJnTzI0UU0raEhwQXZLMUF3VGlPVWRFMUkrNFRZK2NKYjl1MnJKVXBwdDFxT25QNUllWm
 w3R2YvCjdST01lbUxpSUNnSTRUdWdqS2NoOGpDdGprR0w2Z3RqNFQvbk5uVEwzVGhBVkxuam8rV
 mQzZFh3ci9JKzFzcUIKWDN1eVloT0RRQU9zek1Md0RoRVNUWkhoM0FRTkU0STg3alBxTDhzMXV5
 V0JMbXVVSUpRR2ozTWd2Mm1Lb1BPVgpySHN3VTZMZlY1Y2tCM1FlOW9jVUtrUW85SHd1Z2FJZzN
 4ZUdHNSt2OXEyT0lpdHk5QlVRMittSWkwek92S1dzCjRtMDFFY2FwZ2dZa3ZBPT0KPTZnVU0KLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Tweak includes based on requirements.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v4 split from bigger patch (Andy)
---
 drivers/iio/accel/bma220_spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 45ac0d7ee27de65b204bd2766f26024e4ed57f4c..abff24a48e5aaa5efb05cdf1924ffea24f4da4c5 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -6,9 +6,10 @@
  */
 
 #include <linux/bits.h>
-#include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
 #include <linux/types.h>
 #include <linux/spi/spi.h>
 

-- 
2.49.1


