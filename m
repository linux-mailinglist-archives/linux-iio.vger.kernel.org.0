Return-Path: <linux-iio+bounces-16295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E11A4C3D2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 15:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73FFD7A85C1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C60A212FA7;
	Mon,  3 Mar 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="x4nTk59A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04F7DA93;
	Mon,  3 Mar 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013299; cv=none; b=GpRSGs34tcRyQvK0asQE+fwmUwR3RCQbExvz3p7s8N9jD3ymq6vGB422D8wdeo5aunLpGKyLDVOEQpwqIX9PMgmnZzyyC+2fmUgLPBTJ9JHtOoEYsqyan9hAM+DTncWvZPe/EBh18LAoWtfh7cZAjGq+O30qSnxEn+T2DfKwOHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013299; c=relaxed/simple;
	bh=l+kX2MTcfcF4+A6ZDDJW3gOUltnc5ogqGlhahThBv6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=ZO/BwQgzHNV/1fnI9JC5so49EpxchLwvqIvYQAp4J9qF6RdVaoiSgI21Gtlq71PweAdoGj3iOsvPX3dnWefB/haWsly+NKEwH+f9zjI6KQIAppyVhBDyL0ncInNpf1GtcR2Cg5R4NWpsiWhBKn4SS152C+zJ6krwcugvYzmZv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=x4nTk59A; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523BqxeT032403;
	Mon, 3 Mar 2025 09:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=eAq+InRFatcB8I+upMd0/I2BuDO
	dtHZMZkmyJfVMurI=; b=x4nTk59AMQ4QrZ7is5pktJdEdiClwovAq3erKdxrooy
	AmFNpPPuWN3/eIYApWf2/T3NiUhzqDAe2B5U9vgUMZkWfaUHzFSrjK5klzB3FtzP
	HVjmOTc6vPKmtHHRvEFDVQflUeelYobIenDZ4geGDxhYzapD/nc4nzl5h+562Sqb
	qiyBZEfX3g3mYr221WN++lsXwVso2qQF7HaV3NdO6QBWdOkMo1MAUQ05l2VyTTCN
	bOQ9ydL6s3y9S6RXKtXbRpPrad4+U1x5kEzVhLi8EBM268s0FP7jWaFCME2dZJ0Q
	pDBGZDJawMm91B+F8XAsBCzYz55KYx4TM7qHpwcPcCg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 455bxnrs3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 09:47:49 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 523EllMu009991
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Mar 2025 09:47:48 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 3 Mar 2025
 09:47:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 3 Mar 2025 09:47:47 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 523Ela3p021465;
	Mon, 3 Mar 2025 09:47:38 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 3 Mar 2025 15:46:25 +0100
Subject: [PATCH] iio: Mark iio_dev as const in getter methods
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250303-b4-iio-dev-const-v1-1-c2d9d5fe5ac1@analog.com>
X-B4-Tracking: v=1; b=H4sIAMDAxWcC/x3MMQqAMAxA0atIZgM1VUGvIg41Rs3SSisiFO9uc
 XzD/xmSRJUEY5Uhyq1Jgy9o6gr4cH4X1LUYyFBnrLG4tKgacJUbOfh0ITP1i+PW0EBQsjPKps+
 /nOb3/QAnfsPPYgAAAA==
X-Change-ID: 20250303-b4-iio-dev-const-cc26bac40292
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741013256; l=2674;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=l+kX2MTcfcF4+A6ZDDJW3gOUltnc5ogqGlhahThBv6s=;
 b=Mk5PYJ/Lw7WTo7fbs0GnzymiuJQbUz2rtjhSeOnzV87AnVF2YqKcSrqjyofleXvgofrYvB0+S
 PEKSFajKNWUAw9rMR/63vEk23Aqbne4ikDXD+x0LM9qNtzWtY6hGVT1
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 5NphpABY9T-8umLWhdcUhUF86nlycp8F
X-Proofpoint-ORIG-GUID: 5NphpABY9T-8umLWhdcUhUF86nlycp8F
X-Authority-Analysis: v=2.4 cv=Y/ICsgeN c=1 sm=1 tr=0 ts=67c5c115 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=QG0Klee38qREIk_fXF8A:9 a=QEXdDO2ut3YA:10
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503030113

get_current_scan_type read-only method allows to support multiple
scan types per channel, which may also depend on a buffer enabled state.
Mark iio_dev as const in iio_device_id, iio_device_get_current_mode,
iio_buffer_enabled read-only methods so they can be used from other
read-only methods.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/industrialio-core.c | 6 +++---
 include/linux/iio/iio.h         | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a2117ad1337d55468c0f21c274fcbedd352c97ff..3b743cc1af6a15c5b9828e2c54d89ab8abb5524d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -197,7 +197,7 @@ static const char * const iio_chan_info_postfix[] = {
  *
  * Returns: Unique ID for the device.
  */
-int iio_device_id(struct iio_dev *indio_dev)
+int iio_device_id(const struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
@@ -211,7 +211,7 @@ EXPORT_SYMBOL_GPL(iio_device_id);
  *
  * Returns: True, if the buffer is enabled.
  */
-bool iio_buffer_enabled(struct iio_dev *indio_dev)
+bool iio_buffer_enabled(const struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
@@ -2227,7 +2227,7 @@ EXPORT_SYMBOL_GPL(iio_device_release_buffer_mode);
  *				   the opaque @currentmode variable
  * @indio_dev:			   IIO device structure for device
  */
-int iio_device_get_current_mode(struct iio_dev *indio_dev)
+int iio_device_get_current_mode(const struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 56161e02f002cbe3a835cefce0e702c0f9776c81..b9ddfdeaef64dc5df687eac44d3f968bed2fde8e 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -627,9 +627,9 @@ struct iio_dev {
 	void				*__private priv;
 };
 
-int iio_device_id(struct iio_dev *indio_dev);
-int iio_device_get_current_mode(struct iio_dev *indio_dev);
-bool iio_buffer_enabled(struct iio_dev *indio_dev);
+int iio_device_id(const struct iio_dev *indio_dev);
+int iio_device_get_current_mode(const struct iio_dev *indio_dev);
+bool iio_buffer_enabled(const struct iio_dev *indio_dev);
 
 const struct iio_chan_spec
 *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);

---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250303-b4-iio-dev-const-cc26bac40292

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


