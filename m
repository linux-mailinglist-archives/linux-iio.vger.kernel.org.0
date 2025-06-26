Return-Path: <linux-iio+bounces-20972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811F1AE9C0E
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 13:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763447BD7A7
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A7527147D;
	Thu, 26 Jun 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rxIIx9iY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B41270EA4;
	Thu, 26 Jun 2025 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750934995; cv=none; b=Wk2i6qULxfBemTQvNYghNoHNTU4S89OtIdTSFYDZLBv9zAe4H2YXyTDttlO+Bi3/xtHZo2ggPmPUx+BZmkB9giwTrpE1ZJzfcNqrDPDr7c7J+UR47eoeGUlEkw5QthUhSkWgWfEFxKuZqJZf4VcIbBoD8cNh1JM5JHXBsBkg+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750934995; c=relaxed/simple;
	bh=mFRjb8fmFiaBhT2JXLP52myv4IP5BBvNB5AttQVOReE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blYCUWgmGTm5vThngpRiF8G3CAEpk42SzlT2Q9tsQxX4KtBojoe8SSZ3MsMcbv4n0k+Ax5xMG0hUskt7iXotF1DgeQ06eCTN56D2yZawo9LnYXp/G0zmVyXGCybd0HnwjDWrynS4Oo3siVDMJ9YGfr5cMe/71ghu8pbu2l/zW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rxIIx9iY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q8LhbS024510;
	Thu, 26 Jun 2025 06:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mkpwI
	HepDdARJDTm2KwRycIbq3HZ+9Mn5HWM+DOoWhQ=; b=rxIIx9iYl+2esGXQYUnwD
	Fj82CmO/RvNBTm/E4mCxOf/GDa2JXFc0u8b5CmghhsyqjLYJK+KCi61c5cXqbGUb
	DGB6pbvWb5Zgl+nwc1Dqf/pGQZDx1fJC6I0pujSyaKAWLZYjAByr8OTxOFNZOzZQ
	HQSQhXYEqUaGigb0ZLxSOFWNAnB45dKYNIP0P/7h2hBL5D92U5+fv+FRWfJl0WOt
	wnxpqzdZcq003oonE83QT8A70VnNobWnF9GidGEVj0ftypWuN2rDpBXlBqvdhCLp
	6E1Fk2QVJUmv4KC4l63CZdGboQcpA9ZMsyC0KaiHtAzsF5nFNU+Lly72s06DlPcK
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47ge72xsgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 06:49:51 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55QAnn7s047057
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Jun 2025 06:49:49 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Jun 2025 06:49:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Jun 2025 06:49:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 26 Jun 2025 06:49:49 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.167])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55QAnclv000419;
	Thu, 26 Jun 2025 06:49:44 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/2] iio: adc: ad4851: add spi 3-wire support
Date: Thu, 26 Jun 2025 13:40:24 +0300
Message-ID: <20250626104024.8645-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626104024.8645-1-antoniu.miclaus@analog.com>
References: <20250626104024.8645-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: qY9YEawe6QgjNLlwx2kwSz5-Oi8VVYwQ
X-Authority-Analysis: v=2.4 cv=DKGP4zNb c=1 sm=1 tr=0 ts=685d25cf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=4TnTp_t2Nb-xTEFrOlkA:9
X-Proofpoint-ORIG-GUID: qY9YEawe6QgjNLlwx2kwSz5-Oi8VVYwQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA4OSBTYWx0ZWRfXyGxO46DPO2+4
 aVmsH46vDVmwdLGQfsRigbsNf5OpkLQUYXoV06qoUypqZ3ZpX/3WFLiRBogdxr2USjfHEI1oVH1
 f9v62GrMXmM77mOWX10K0ki7euIBgTVDdIbaBr9G8Y0iVzZ9obH8DXdFsHVKimBZUi3HZahRvrH
 LNdt8ZbB62RpaTb+Dxb9UxGxT0K35VE/E4BtPn3mln2t8kECXjluZsVQUBal2Afkxh6grrWcM1Q
 VFiS6EdsMBCBkxRQapRSwz9d7T8GIO4nKmVmgoExl45weVoDIZAMHdRMiYbiaXMYCk1DRJ5G7T2
 587b2Rcez4EM3UiQbfklQE2GhE9n3nejAUeIWW925jFDGXAMVsaVYkHl0ljbmUkXdOaQJcU62IM
 bwNOcd7nY+48GFEzX0y8F1DBl7lZHx6hCFPPd3VBSvfxxDDVChOsYpJz66gBOEbKotX0BLNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 spamscore=0 mlxlogscore=998 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260089

Add support for 3-wire configuration within the driver.
By default 4-wire configuration is used.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4851.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
index 31e1e02c0ce3..1ad77f2a4580 100644
--- a/drivers/iio/adc/ad4851.c
+++ b/drivers/iio/adc/ad4851.c
@@ -444,10 +444,12 @@ static int ad4851_setup(struct ad4851_state *st)
 	if (ret)
 		return ret;
 
-	ret = regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
-			   AD4851_SDO_ENABLE);
-	if (ret)
-		return ret;
+	if (!(st->spi->mode & SPI_3WIRE)) {
+		ret = regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
+				   AD4851_SDO_ENABLE);
+		if (ret)
+			return ret;
+	}
 
 	ret = regmap_read(st->regmap, AD4851_REG_PRODUCT_ID_L, &product_id);
 	if (ret)
-- 
2.49.0


