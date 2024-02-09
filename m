Return-Path: <linux-iio+bounces-2350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7548884FBE7
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 19:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13491C24704
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 18:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7FD57871;
	Fri,  9 Feb 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZupwJq4z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C55465C;
	Fri,  9 Feb 2024 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503569; cv=none; b=M5+AATjcWXv8EW0lNx5QCx+5vsiP/XQ/B+3JN6l8QItugRBZRnpGbVv8sqOlC2yeE3xczhHr6ue7Hut3bMutbpWrLKkUsUY8BGTWs033Gk7m0jUL1O7cB1DEjZc6tYrV6B9iq/kw9ew620mXmf/vGcsmUEsP5MfqSErjDzu+M4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503569; c=relaxed/simple;
	bh=JNTkfXDKnYmx9qcdMivbrD+hm+W+BQExAVlatDoe2ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fzfS6CJpKkxUGHGXBHYx2xNujNWeUtxgkZtRysuDsaPyqOiSCKJD23ssJA/LZfrg4dLjZBErSw0jAvpzNXPeHsi7sFjPsPnSAXvOsHDtOhRftHc5E/MuQzd7dK+toQ7ZbZeKVuTeIKaqRcDhlm5SikGgjor1XUQRiDyg60nljeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZupwJq4z; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419DfAVm014512;
	Fri, 9 Feb 2024 10:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=tToJ2nH/bMvc+wQ2tKjQxUKeaZr0nzKYa53MGnTHLOs=; b=
	ZupwJq4zAt6NVpEa0IkCrTEPSFjWD6Kq6LZiCoXZfhI/As8UzrOT2y/L3y4/xUmc
	LDBCqo2PXHb8MJbqa3uKzQtINsNulCNQObu90UFpxgi+oMSVydmG5g9tLKlcFyQN
	1LaTt+Yj/MA47oOlqMo2uVwAQU8td2Svvp1tCHiHZxGdgYBTo508/hid/OQbotZW
	2ilPZrxHSwS/my5C7hCpgj4sLNpAv++G5iBJYBdIG/u53E6GzPzy4nbWm4dT/RPo
	s7ZM5MzKpeevb6vv7Ngq7QhO8+b32tNzbzgj8FR72z+GHX6GEDfziyzlwEK7QWdb
	V0BRPMx8u7b1Q5BKdwS0RA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w53423p96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 10:25:54 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 419FPrlV047848
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 10:25:53 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 Feb 2024
 10:25:52 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 Feb 2024 10:25:52 -0500
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 419FPVJ3013228;
	Fri, 9 Feb 2024 10:25:44 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 9 Feb 2024 16:28:53 +0100
Subject: [PATCH v10 3/7] of: property: add device link support for
 io-backends
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240209-iio-backend-v10-3-3ed842064318@analog.com>
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
In-Reply-To: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        <andy.shevchenko@gmail.com>, Rob Herring
	<robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707492532; l=1401;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=oansVzQ6wwqDt/vEJ286W3FVH7izZYvS2xgQKAhAc7I=;
 b=4O+n5wEnUNhfz15dQxym8k6BKzM5XmsiFn9duISB4DbdJDauwEV+8oSXgmO407/VtNYVfD38l
 ITN0HdDfioCAj8zOJjKUYNDX6rTzdXjVeB8P+U2lvpZ6/RIMJ8i/29E
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: uY4j4pD61xKb5-Rg_p2aONxgYvfDMe_M
X-Proofpoint-ORIG-GUID: uY4j4pD61xKb5-Rg_p2aONxgYvfDMe_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090113

From: Olivier Moysan <olivier.moysan@foss.st.com>

Add support for creating device links out of more DT properties.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index a7be85b0bfb6..4669fa2b2008 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1251,6 +1251,7 @@ DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
 DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
+DEFINE_SIMPLE_PROP(io_backends, "io-backends", "#io-backend-cells")
 DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
 DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
@@ -1341,6 +1342,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_iommu_maps, .optional = true, },
 	{ .parse_prop = parse_mboxes, },
 	{ .parse_prop = parse_io_channels, },
+	{ .parse_prop = parse_io_backends, },
 	{ .parse_prop = parse_interrupt_parent, },
 	{ .parse_prop = parse_dmas, .optional = true, },
 	{ .parse_prop = parse_power_domains, },

-- 
2.43.0


