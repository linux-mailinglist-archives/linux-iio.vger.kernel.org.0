Return-Path: <linux-iio+bounces-907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B5E811B09
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 18:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FA728139D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 17:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468056B84;
	Wed, 13 Dec 2023 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XMKpDzII"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52ABF7;
	Wed, 13 Dec 2023 09:31:29 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BDEqJel018485;
	Wed, 13 Dec 2023 18:31:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	selector1; bh=eIOMYrQgx6HJw4rVlOYwJZbbCq5P34bEkh/hrlQWeIs=; b=XM
	KpDzIIebHdcupOssrpoVqLc7hi9T9LMKebwet/90J5t3iOsKhPMNnSkuZLYwOAXI
	uBrF4txu+Zv28BC7GLIdnNG+U+b68rtnfuWK+klHbgxmwivIStp3VvD49bL2RqTO
	8Gi9W+YBd+HeI1VjClT3QP3H03h0CJMlpNpC/0+E1CG/DR9bJV8/txCcMCby5nbr
	JQejFHDLsiDLyDfwq25ZA6CMd7CMhT069jsTSr7wrpbHfozWNvsS6YlcLqPwXnBN
	aY8ocIaVTgkmL4NjEseZ7tWskmYhPum+FxT4Elcje8SkIKC0+g2E6GliTqMNrpI8
	WQ5AnNdnIK0IRO4Okh5Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvehmhxxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 18:31:27 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3315A100060;
	Wed, 13 Dec 2023 18:31:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2B51126598D;
	Wed, 13 Dec 2023 18:31:26 +0100 (CET)
Received: from localhost (10.252.26.85) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Dec
 2023 18:31:25 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <william.gray@linaro.org>
CC: <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] MAINTAINERS: add myself as counter watch events tool maintainer
Date: Wed, 13 Dec 2023 18:31:17 +0100
Message-ID: <20231213173117.4174511-3-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213173117.4174511-1-fabrice.gasnier@foss.st.com>
References: <20231213173117.4174511-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_10,2023-12-13_01,2023-05-22_02

Add MAINTAINERS entry for the counter watch events tool. William has
been asking to add at least me as the point of contact for this utility.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4: Explicitly add 'L' line to specify linux-iio mailing list

Changes in v3: Add MAINTAINERS entry. This is a split of another patch
series[1].
[1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier@foss.st.com/
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5de540ec0b..e561d0b086ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5322,6 +5322,12 @@ F:	include/linux/counter.h
 F:	include/uapi/linux/counter.h
 F:	tools/counter/
 
+COUNTER WATCH EVENTS TOOL
+M:	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	tools/counter/counter_watch_events.c
+
 CP2615 I2C DRIVER
 M:	Bence Csókás <bence98@sch.bme.hu>
 S:	Maintained
-- 
2.25.1


