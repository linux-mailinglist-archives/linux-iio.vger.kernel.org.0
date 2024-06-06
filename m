Return-Path: <linux-iio+bounces-5883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A910B8FDF6D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 09:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0CB1F26F5B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3076313C822;
	Thu,  6 Jun 2024 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mswvoYCF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193543173;
	Thu,  6 Jun 2024 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658403; cv=none; b=SsIxVIrNjt6Cf4G+vhZWCx/mb53tISX8yF82rcpP5+FhcyHC1PL33fjeSVQye8eiBaab9gG2ZlrwO3fjdHvZHVIsibY41PVeQAOtM4dm57TsBEftp1uk/E/EhHu81z0evLzEMAH3CAh95T9xV0VbiBTXWNxNY9axm1yqRGjSjjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658403; c=relaxed/simple;
	bh=KJK3SBHG4M30EhZ3riJ+DmdxwA2mWKKSmKq/Yal9JGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=h2pXROpKI0m3urpDd4p7mg60cuwatbg23M7k3TtYATOJgWZKy8BIsgTDIfv31GfckDAIUhNsVy+IWdV5JjxbtSHfDq07JMKhSdiTWByLhkbZxYRDfl6kNgAIjkcDFn0VYhKQRLyjWqRggnB6PAmCArnvy1H8vLJdtnhSa6KQT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mswvoYCF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4566moH0015468;
	Thu, 6 Jun 2024 03:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+gfp6
	a3Kz7W6AXuY8SswixfHIH2hVyHaa0nt0Pi7GM4=; b=mswvoYCF03BJ6evhNqAph
	rNQ1BVjCO/2FlvMpRHL/p2veRIn6edOdkZoxmkW5Q1ARIqYUX3vw4cjt+tEp5gSV
	1YiPucn6JRkVCqR8yw8IU5O3Fp+3SIYjkAnMqP2qocIXUMBAK3F1BSxv9B1TWLPl
	TcoJxLhg+VqHNj9+tZaEnkw9RMjsAWsal9430LWSrn7eeHC4Vayps5zPliTXnC3j
	tld7ejjaIeccZaknCxM6VPP7m3+QOAyTJJnbg80JeICReeYnU2+paxRRsp04LsPQ
	NBgB8fZ3mz3d6NpZNSnGg7JbP/2nrnz0z6dARBAi1gioA0U8JgJD2Cp+5qne8iz8
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yj0hvgrfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 03:19:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4567JHgh030124
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 03:19:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Jun 2024
 03:19:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Jun 2024 03:19:16 -0400
Received: from [127.0.0.1] ([10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4567ItBc025782;
	Thu, 6 Jun 2024 03:19:11 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 6 Jun 2024 09:22:37 +0200
Subject: [PATCH v3 1/4] dev_printk: add new dev_err_probe() helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-dev-add_dev_errp_probe-v3-1-51bb229edd79@analog.com>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
In-Reply-To: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
To: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chris Down
	<chris@chrisdown.name>,
        John Ogness <john.ogness@linutronix.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti
	<andi.shyti@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717658563; l=1147;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KJK3SBHG4M30EhZ3riJ+DmdxwA2mWKKSmKq/Yal9JGc=;
 b=qB0ADqkAY1DbSRbNVSmIVXBYoZLvWqVYYgHw2RnNmnh2RUhEUOhN/XL2U6UV599pMGmKeF6Z6
 0cR5esuubnhARnkhf4USoATHUlQT7whUp0hkOC6SZXfdvED/fwSWdCI
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: VcZc7b1AyPnLelhtntjs3k5BkuC5_nVv
X-Proofpoint-ORIG-GUID: VcZc7b1AyPnLelhtntjs3k5BkuC5_nVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060052

This is similar to dev_err_probe() but for cases where an ERR_PTR() or
ERR_CAST() is to be returned simplifying patterns like:

	dev_err_probe(dev, ret, ...);
	return ERR_PTR(ret)
or
	dev_err_probe(dev, PTR_ERR(ptr), ...);
	return ERR_CAST(ptr)

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/dev_printk.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index ae80a303c216..ca32b5bb28eb 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -277,4 +277,12 @@ do {									\
 
 __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
 
+/* Simple helper for dev_err_probe() when ERR_PTR() is to be returned. */
+#define dev_err_ptr_probe(dev, ___err, fmt, ...) \
+	ERR_PTR(dev_err_probe(dev, ___err, fmt, ##__VA_ARGS__))
+
+/* Simple helper for dev_err_probe() when ERR_CAST() is to be returned. */
+#define dev_err_cast_probe(dev, ___err_ptr, fmt, ...) \
+	ERR_PTR(dev_err_probe(dev, PTR_ERR(___err_ptr), fmt, ##__VA_ARGS__))
+
 #endif /* _DEVICE_PRINTK_H_ */

-- 
2.45.2


