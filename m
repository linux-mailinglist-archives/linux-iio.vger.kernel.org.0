Return-Path: <linux-iio+bounces-23208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB0B33D2F
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610E8189FD37
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E842DE71B;
	Mon, 25 Aug 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="v4QWmirp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501242DE6FB;
	Mon, 25 Aug 2025 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119171; cv=none; b=ZZh5fjvZlsrNt7DyUoGh28QzUeQlWrs1eEn5YHry1qb7/ay/hVgIdZalfclAEyFGcMCfZ93QAkBG1uiIx1w9+vspLlOItlsz2Um/fUQgeKoUFA6Nky/WDFveRRNGvCqi94rFnDmHy5WQEpwgk085u/wIZOo5PoYJeAxFiq4UXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119171; c=relaxed/simple;
	bh=0PhTECnQWmkaQFRhGO8C6E3vapKDPdS2Qf5gumshVt0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMJkrr59zs6XRd58SeTWZfdeejFTUr2eFzfYzSSxJfBMNpA/hGb82XCXaIEEOAu8jMtQbm9hBxUpFO06oVcg2tnDfzvPUAZko2em0/xNZFNgptZm96AO6e3nIwfFRRz1rKBHOwmYbnh/O7p3WeKMdzXwNyyt9SLLDOdgU5H0FI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=v4QWmirp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8QCBL018328;
	Mon, 25 Aug 2025 06:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ExXkZ
	LkAnFa2N+cqsaGjGupmUoFpB2ygkHZfTYbtPck=; b=v4QWmirp3IP3pL0xKUlfD
	TRXb2KzS59dCtZ9DiISFLwOAbhwik7Z9x5V+OJn+n7Zsb+x+U2nWz3Nz+USWdRLp
	ovTCJXxP1ug+TgNZAhpB6DiRIW3lZVRiHfC9ueN4ZIfQB6lvGudvRW07s2I0/icT
	eJiEiNsxj6Q14zLgl52kYIqojSn1UhpwRQ2ZK9PGAXYXgLLJmXfinYUDOCJJUrrU
	ZLW+w0JuOyJ4ZmPsIIkAgWOibqeDxmxtviZ3zUDpF0fIQyXekLQByIs1IoG0Upoq
	PQlYwi+flHTlvrnBYtDzrzWjfiSFM41RGYP+e1d7nDEeOwIZcPNDQPafU0Kvdw81
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmafgj8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 06:52:30 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57PAqTdZ038568
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Aug 2025 06:52:29 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 25 Aug
 2025 06:52:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 25 Aug 2025 06:52:29 -0400
Received: from IRISTEIU-L01.ad.analog.com ([10.65.213.1])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57PAq608026383;
	Mon, 25 Aug 2025 06:52:22 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Ramona Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>
Subject: [PATCH v5 1/4] iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
Date: Mon, 25 Aug 2025 13:51:16 +0300
Message-ID: <20250825105121.19848-2-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
References: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfX9kOYfuICYtek
 qseA+Y8vcLD8VEtOBR9iMCdnfa/DJodV0/Mh2WAW6iQHZQuzTEaktVt0ZzPlnKY2zrKgPs4Cppd
 m7kjKDmJrlcUPV8yOxILAmXg1bA388i5R3yaf7ZYSX0lRjFGuS8NvvQgK6O56uLDrXXbeN742Xj
 SFLgCP3RSHPtUb8cHSqhYLu9Rh9M2IeZjFJ6bbQYISpW0ycjQ5zjBGazXRyZv8QiN/wJ8m5kLbv
 K/IemWMG4BswfZRyKrJc1VrqC4xRtQZ6SVU6dglxi6HfOgtoMy/Rj5mkpLI1PO7zrCmmExVhxI5
 GHvvrInA3GWs7RxC/XQt2s+PFmn6H1yCiGcO/qkNru2Kl8nsmFBiuxeT8EXDDMwNNbMc7DVVnQX
 AHJEgdbQ
X-Proofpoint-ORIG-GUID: Jt-1b9jmtD-NLjl_6Uujvm8CZAbkTQgp
X-Proofpoint-GUID: Jt-1b9jmtD-NLjl_6Uujvm8CZAbkTQgp
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68ac406e cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=uNKIQ4TcjcV5qgwVPWcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

Assign num_lanes_set in the adi_axi_adc_ops to axi_adc_num_lanes_set()
to support setting number of lanes used by AXI ADC. This operation is
included in the generic structure because the number of lanes is a
configurable parameter of the generic AXI ADC IP core, not specific to
a device.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
changes in v5:
 - improve patch description
 drivers/iio/adc/adi-axi-adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 2d86bb0e08a7..20bb59c24acf 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -617,6 +617,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
 	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
+	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.47.2


