Return-Path: <linux-iio+bounces-6486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE95A90D2CA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4981F24662
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6304E14A636;
	Tue, 18 Jun 2024 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="l3In2dJz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60426AC1
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717337; cv=none; b=W22c9CX9G3ZoEvpEu3k7L5O5r1WQXvxuNeSbJIJrgwUlVBNCwsex9I6nwklSWs104wWtNsJROVYukymk0/Jjqyh8ZxKszn2q8MeczisDr3f4a2hBfpGdx9ye0U/0rX8seWpZlCXnr1bhnUaQ/ycLjrq9gYRJki/eygRV6DMuFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717337; c=relaxed/simple;
	bh=BVQDqjFfzsW4ydyxUPo6xN6cIkfRYfYqbK/Z4U+FN2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Cv7b/bWV3ZxE9wtIGAEaztpr7g8Jvf6KDd87bDU7LFKG+L8HKw0Gb5qDNIXNVZWk5C/fLNKlRHtJXAZErsZoBSbZoZb0D0ZKv44lFB8e6mooo8keDNQL0ozTO7pLbz0Zb5MCC0ECRMLFdfY37qozCBHP/BukP/b72sjqXUs66Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=l3In2dJz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I9MBLG007179;
	Tue, 18 Jun 2024 09:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qsFaV
	4tM7mgTiH8fpkdslGhRrciI/dhEmwz7lBR9HNw=; b=l3In2dJzXZdWlIpuYePpw
	nA6o7nSgqfPwVrHQ7gV8eDMIBiab63RhKgrr4bClvHnG4Aw8zNyjG4pTipP4nHLP
	SRPQjwvfF+9LeQdGZu7FgQzxi56tCxzZ+wy7uYOWFJeGhEUn8rSBnbiTL5ikqBva
	JpYQiFVw9M0kgypuZMBI/FnffG5UCFGz03hnej/jMIofMlDoZ55ItbpenT0q4ofJ
	O8Dm3DG+kfIVMhXHZlQYEmQxLrIQ/y3TCpfb+DO65R1DXtuvkSsUwNioEIzCllMJ
	utxnl0hTaYVtjqzmuL/TAAggsmm4xPIhd/piLxItncj9LrdufobvdDVCICtBCVRU
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ys4t33byd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:28:43 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45IDSg79023619
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 09:28:42 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 09:28:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 09:28:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 09:28:41 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45IDSLWT025769;
	Tue, 18 Jun 2024 09:28:33 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 18 Jun 2024 15:32:12 +0200
Subject: [PATCH 9/9] iio: imu: adis: remove legacy lock helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-dev-iio-adis-cleanup-v1-9-bd93ce7845c7@analog.com>
References: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
In-Reply-To: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718717531; l=986;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BVQDqjFfzsW4ydyxUPo6xN6cIkfRYfYqbK/Z4U+FN2o=;
 b=WeqD3K2YLfw/Po4WF8iaCSRgeDI6z49rhvFfifzKLT8EpYI23zCuVNx0Yg2MVhKkOqiTZih0T
 JkBkr1jFdiVAJmt3RXXPTvbH9w4Z/kNKACbhQtU4gE4elBQD4qPk7ZL
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Fbjk3jWCb9F-7QBuvxNcT0Hm4Uf7NWmx
X-Proofpoint-ORIG-GUID: Fbjk3jWCb9F-7QBuvxNcT0Hm4Uf7NWmx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=556 spamscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180100

Since all users were converted to the new cleanup based helper,
adis_dev_lock() and adis_dev_unlock() can now be removed from the lib.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/iio/imu/adis.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index bc7332d12c44..e6a75356567a 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -407,16 +407,6 @@ static inline int adis_check_status(struct adis *adis)
 #define adis_dev_auto_scoped_lock(adis) \
 	scoped_guard(mutex, &(adis)->state_lock)
 
-static inline void adis_dev_lock(struct adis *adis)
-{
-	mutex_lock(&adis->state_lock);
-}
-
-static inline void adis_dev_unlock(struct adis *adis)
-{
-	mutex_unlock(&adis->state_lock);
-}
-
 int adis_single_conversion(struct iio_dev *indio_dev,
 			   const struct iio_chan_spec *chan,
 			   unsigned int error_mask, int *val);

-- 
2.45.2


