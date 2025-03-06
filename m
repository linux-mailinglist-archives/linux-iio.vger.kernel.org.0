Return-Path: <linux-iio+bounces-16472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6410A54CED
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 15:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8911896BC4
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE2A1624DB;
	Thu,  6 Mar 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="doUMyCjj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF914A088;
	Thu,  6 Mar 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269897; cv=none; b=lbHcua5OlwXH9Lzlekcxi11QrHnnehLqv+CL3nGmy+b8iHEg+xQ8o2wj7m2g+kN5cm1ZfWrIGii2uKUG7JrnllH/MB50XmP+A4qg+x94qSX/H8XAd6uRWNv0gw6Xti79trCVd9P4nqIcb8zjGMzsy8823dMH5BjN2KrtT8KfyZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269897; c=relaxed/simple;
	bh=l9PcVGMuLf6x2NgslipPJ3y+26BzU/UmXhuxWc0vSHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XA2kMYRXW+maUmk3bnGNe4lnkXJjC5DgumGsjSf2XUPP69jrH4NVe73npEtV3b8hm7G4Fl0W3eEEovmrBQlSc+S33PhZUQg/Pznimtg0BXzfoe0XZfIlCwHJaPLxlaE4aCks/sSiy0IUyMMhBHL8NmlEI2yQjZzkR1aVTqLWnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=doUMyCjj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526D6ONp024249;
	Thu, 6 Mar 2025 09:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WPRdk
	l5lQifMs291yzgJuLsgyC06hJp10lX5LMWARD8=; b=doUMyCjjuYG1FPtFPthqq
	0x9kI30Gu5lm1ILefpdaqg+Fgp/9BwutqDHpU2FFOMfn7ZzTllkERuzJeCgh/khx
	nJ8MKZhZBKWOuO8cjMp+ca5OVyawjiw3PXjp6GW46p5V7lhOb0KFP5Fxhm7dkXlN
	Z+sDLzm8AgyrpVKt568mzIBWtY/ZtHbeUxaeLv3hLt0yRwO8ZKNFa9xPEnBYzkvw
	ieQMVbOh/k5igy2a1jog8aUCFi+7C3BjyjWtkrt8k9eN+r9hDPHbmZgxXFO4aEyC
	yCfS6/8vnYAWimLq1mC28nwUUDrkSttd7jv5LYIZR9fZoGNg+I0h0tNZ1N32qi9e
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 455wnudfnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 09:04:29 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 526E4RwW064962
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Mar 2025 09:04:27 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Mar 2025 09:04:27 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 6 Mar 2025 09:04:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Mar 2025 09:04:27 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.71])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 526E4CqS024033;
	Thu, 6 Mar 2025 09:04:20 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Thu, 6 Mar 2025 15:03:14 +0100
Subject: [PATCH 1/4] iio: code: mark iio_dev as const in iio_buffer_enabled
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250306-iio-driver-ad4052-v1-1-2badad30116c@analog.com>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
In-Reply-To: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        David Lechner
	<dlechner@baylibre.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741269851; l=1550;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=l9PcVGMuLf6x2NgslipPJ3y+26BzU/UmXhuxWc0vSHQ=;
 b=UryjerKdn9p9sv6hGxvn+L6f8Q+Y5X2//3M6jcwmUJXuvGj0E1RMYDzmJOewgStCiZCxt1JKk
 XyArk5EEgY4DsKBnHchRuQI+FMn7sV2heIZNdgdhwAKa3ZGuZPQ8iA7
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 4pAuiujDIuRDQJxOnUxP_6J_sth7VG3L
X-Proofpoint-ORIG-GUID: 4pAuiujDIuRDQJxOnUxP_6J_sth7VG3L
X-Authority-Analysis: v=2.4 cv=VNcnn8PX c=1 sm=1 tr=0 ts=67c9ab6d cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=o4BEsY4NupaUgmND53EA:9 a=QEXdDO2ut3YA:10
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503060107

The iio_dev struct is never modified inside the method, mark it as
const.
This allows to be called from get_current_scan_type, and is useful
when the scan_type depends on the buffer state.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/industrialio-core.c | 2 +-
 include/linux/iio/iio.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index b9f4113ae5fc3ee1ef76be6808cc437286690dae..a727278752676fcc9e2c5a9b5358092b44c6fff0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -211,7 +211,7 @@ EXPORT_SYMBOL_GPL(iio_device_id);
  *
  * Returns: True, if the buffer is enabled.
  */
-bool iio_buffer_enabled(struct iio_dev *indio_dev)
+bool iio_buffer_enabled(const struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 07a0e8132e88278c82be740e12ca2d9078710206..33612df92779d8ac380a66340e0e76eeb7e2cd5d 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -629,7 +629,7 @@ struct iio_dev {
 
 int iio_device_id(struct iio_dev *indio_dev);
 int iio_device_get_current_mode(struct iio_dev *indio_dev);
-bool iio_buffer_enabled(struct iio_dev *indio_dev);
+bool iio_buffer_enabled(const struct iio_dev *indio_dev);
 
 const struct iio_chan_spec
 *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);

-- 
2.48.1


