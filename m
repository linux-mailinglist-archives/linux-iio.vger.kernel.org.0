Return-Path: <linux-iio+bounces-13977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA980A0445C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1969D1887E64
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC41F1F37DC;
	Tue,  7 Jan 2025 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nxjhVUYJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E11F3D52;
	Tue,  7 Jan 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263630; cv=none; b=vDqzLbqgXEe1yg89OxXbs8OOAc7uMN+WXKIDM2ec9WdJqclARSzPVv/Kp3/RNT4Z46HbVY7TREnn7zdHTpSk3z1QY0bkD35xtoYTKvNOhBtvr7X5xKhwQ969XhtGO85QOgUNM9uJjRuaajkb/TYOCHXlkoz6i/Q2u0iRFD9xpz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263630; c=relaxed/simple;
	bh=gyR3m55EKCxZWSDUkHoK6Q6c5uLqo9DFj9fAyDQjUfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TozcnMFdLoniJButiFi7gWtukBGAwfm2jpEj0dBob2pmQn6CVGTxoSUhY64xkunTysipRdkHirFE0pa8UEaDqwXtKXvn8J0HiGSn3d7WaPWQs1GHMr1+0CqgQaAF02Zxzb9il9Q/xDpJPGy3RR6Jj61KoeHqeVhH6vMAAF8+4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nxjhVUYJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvFiC013565;
	Tue, 7 Jan 2025 10:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SnKhq
	sClEwuk8LQXWat2+c1++i0zsSU6aSju91NOGJk=; b=nxjhVUYJs8bO8+sbhUG3O
	KlDRXB9UTNljLrx2f5rY1ldAGXv44dnyf8pMPYRBRnK4/sejKaSd9e97625AMlIJ
	qkGHHH8m6vv0MNNGoYMfdkU8BFuyn6h9pXX5zHfEN6IKdu9OgTbSEBo6yTU4a/VK
	rtcG0GOxBy74RDWPd9XAgE8Il4CX/qy8gIOs/l2KPxP7LRZ0hscqZHcJWpQ1gZqp
	ajKvLAjBxRah0deNLLL388XS1SmR37pjo2YQqODJq+UyNY6BEMALF5fNGr6eNxLJ
	YjCK1y5YSvMsIbE2HMiFb1OQ5HoTMsMzeehyKQyKTLNZywVW9MIXxFmDziwvTxxY
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4415f6gdn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:26:53 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FQgvD034165
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:26:42 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Jan 2025
 10:26:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:26:41 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FQVEK030339;
	Tue, 7 Jan 2025 10:26:33 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 11/15] iio: adc: ad7768-1: Add reg_write_masked function
Date: Tue, 7 Jan 2025 12:26:28 -0300
Message-ID: <67649c43050d161621bc0494638bfa71fed82ea8.1736201898.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736201898.git.Jonathan.Santos@analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Zvu3n0tMr1no_BdbUm4xbzgnje13JXIO
X-Proofpoint-GUID: Zvu3n0tMr1no_BdbUm4xbzgnje13JXIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=797 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070130

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

This commit adds the ad7768_spi_reg_write_masked() which is a helper
function for writing specific bits inside a register, without interfering
with the other bit values.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 574d735f2c3a..675af9ea856d 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -242,6 +242,21 @@ static int ad7768_spi_reg_write(struct ad7768_state *st,
 	return spi_write(st->spi, st->data.d8, 2);
 }
 
+static int ad7768_spi_reg_write_masked(struct ad7768_state *st,
+				       unsigned int addr,
+				       unsigned int mask,
+				       unsigned int val)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = ad7768_spi_reg_read(st, addr, &reg_val, 1);
+	if (ret < 0)
+		return ret;
+
+	return ad7768_spi_reg_write(st, addr, (reg_val & ~mask) | val);
+}
+
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
-- 
2.34.1


