Return-Path: <linux-iio+bounces-22924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED26B2AB89
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 16:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4116C1B68289
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B335A2B0;
	Mon, 18 Aug 2025 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="M2YuH+oK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2054335A2B2;
	Mon, 18 Aug 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528281; cv=none; b=RHiR1wCH8JCdXQFz4EcCb22v6Ga6ZcD0tFDn1jUYLNzKpEZy0rfA9JliqoW2vTdFjUwLgesQInV+5ydEvQiEjvQo79RJ/Oq70PYIl6/eiVHLsMVnHVQasMEfe+0Ku7MLodL7BmaPVvuq2TWoG8qHhikLiUUWBCbcFZNVfNUH0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528281; c=relaxed/simple;
	bh=mMKIkhPKdEqNAGhDWDIfws0cG0Cg578nDe0eBj6SHHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=IG4+THhetn9uDdbj+3XMre667gbobd3RgnP312imkUW0ZoRjaxxVF//9OOH7+P6HDwkWSMX1Wl0I7k3T4ox0u5oMk5IC2UfjHDjTpKeJTmvG3iVpKBiHgg6wFN1a87ahNVym4c92VtLfEH2Srr5g+rMbawVQRy96kTQ9x3mgqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=M2YuH+oK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEYiww025389;
	Mon, 18 Aug 2025 10:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=lW3/LPo9dCqQoq2/cIX+6sSFCzF
	WxgpwuV5nvG1cwHU=; b=M2YuH+oKVjHg+BPuQySTVY56lEVZ+J2ijaR4BLO9qBW
	BhFfowSXdh5bRg6+l2t2UtdWJRQLzKz0lGPXoiw8QpLdQl3s48LP4gt+bRGbaqAk
	fMmEGY61TABK6fmEM7UudpsBRTVR7uhlhi7oNY8KP9875KMiEWAZLRdkCA/dj79w
	hvNxBaNU0mU7bPsNyHd6GRxpLYyhihVOlGFucYeHTgRlYLvClIRPmnD/dFWd6hE0
	2MBnqLfZuf+1X2XFK2HD4dflzVYoMqJeB2h2JqioOKU4xvoix11pCwG7K46oJlVv
	s8JQpvwEeJ7QfswRVLh3wDYn/vYwplmCXMKagrdjIZA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48kn0svs6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 10:44:36 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57IEiZW6051886
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Aug 2025 10:44:35 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 18 Aug 2025 10:44:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 18 Aug 2025 10:44:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 18 Aug 2025 10:44:34 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.53])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57IEiOH0012430;
	Mon, 18 Aug 2025 10:44:26 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 18 Aug 2025 16:44:23 +0200
Subject: [PATCH] docs: iio: ad3552r: Fix malformed code-block directive
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250818-docs-ad3552r-code-block-fix-v1-1-4430cbc26676@analog.com>
X-B4-Tracking: v=1; b=H4sIAEY8o2gC/x3MQQqEMAxA0atI1hNoq5XiVWQWNYkaFCstDAPi3
 S0u31/8C4pklQJDc0GWnxZNR4X9NEBrPBZB5WpwxnkTbEBOVDBy673LSIkFpz3RhrP+sZ/7YNi
 6TjxBPZxZan7v4/e+H/whBm9tAAAA
X-Change-ID: 20250818-docs-ad3552r-code-block-fix-6f680d124e5c
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
	<andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755528264; l=1010;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=mMKIkhPKdEqNAGhDWDIfws0cG0Cg578nDe0eBj6SHHQ=;
 b=+hsDxYSXH2Uqi86QlI8NPUrQtWyjjoSnx/TQrdFtgVia00Ndw11RsBrIeGT5IL2jYd3GYzsCc
 iT6TXZ0ngk+B0ShxIWnuUQGXxdaOUKnwWgd6lI4Wh20TJuZkKLQ2TJ6
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: oru05bQXb3Me-rQLmyEU2Rrunz1r81CR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDE5OSBTYWx0ZWRfXxhILP4/A/oQK
 KikVY+hX8czvhLy4GiHY6l2REbz8ChAkuudDC3ZxO4Cv6+9jSgqyanFSU3iWhQhR6HnYCs/oKce
 Gwkrqauhc4CYV5svNLDZzI31rLvo094dGwHS6tntNCWf7ua+r0/xrgobBE2zgB+/vyy3txCwJPK
 IBOqjMVkOlh1FLS6FF2twVuMpUG+Go4R6wmJdfYXa+bKUYI5jVfxct2iCu4csYXYRvgYBhCHl0R
 9ntqbVfqyU36L1pSMhV415V643HG6vkCkT35hMJ5rZJOv4FoJDaE8ZnHkmonWVcE+BinqLhzFZi
 WxtQV1QU5an12qrMt7e4H+4g0TtK+N8TllYFqW5qt1aIP7DOEa+2CJ9f+BN1Pnzj8KgFPneDPGl
 2NWtRN9m
X-Authority-Analysis: v=2.4 cv=T6qMT+KQ c=1 sm=1 tr=0 ts=68a33c54 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=0rILtPB_kMdZEppRk8EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oru05bQXb3Me-rQLmyEU2Rrunz1r81CR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508170199

Missing required double dot and line break.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
To resolve the code-block directive syntax not being parsed.
---
 Documentation/iio/ad3552r.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/ad3552r.rst b/Documentation/iio/ad3552r.rst
index f5d59e4e86c7ec8338f3f4e82d7a07587e3d8404..4274e35f503d9f7d8a5427a72d761d6549f4c683 100644
--- a/Documentation/iio/ad3552r.rst
+++ b/Documentation/iio/ad3552r.rst
@@ -64,7 +64,8 @@ specific debugfs path ``/sys/kernel/debug/iio/iio:deviceX``.
 Usage examples
 --------------
 
-. code-block:: bash
+.. code-block:: bash
+
 	root:/sys/bus/iio/devices/iio:device0# cat data_source
 	normal
 	root:/sys/bus/iio/devices/iio:device0# echo -n ramp-16bit > data_source

---
base-commit: 35e3d0cd8e89d811b915593cbd8d9891d21d4a1a
change-id: 20250818-docs-ad3552r-code-block-fix-6f680d124e5c

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


