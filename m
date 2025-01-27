Return-Path: <linux-iio+bounces-14619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9EDA1D926
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481431626ED
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D72213C809;
	Mon, 27 Jan 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FrE9NnSi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B3713B2A9;
	Mon, 27 Jan 2025 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990765; cv=none; b=cjV6u6jZSgTUtBqdWRodCvSJOJvZygzQj22654eVO9l228BMIzrg/SCb2y4K+Cws5YW77pcmvYXuOAaMuVnJuiQR0nYhlWIBaN7/j6t+69sovbQC+v/PkbkDQZvQ3amG6RL/gyCVwlya5VAAigmGWD05KnA3xjIlbBT0t8krLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990765; c=relaxed/simple;
	bh=OHSL18RvBZriiWkXZKUjxf21n5gk9tWcxY84arGHGNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNb0SLYB3T6s2I58DVNrO97SIZGFvK1qO68+cjxVJ9QGbtKI/s2Kn5eoQfSO8DJyWqx5VXDmWwR+h6s/R2zAEqGusT5smYnYM6+h2SNlytmZJvgqXfMqUVQjEp1IBjF9NLhuhnZEw0B55sum+kG/MON70WR6n276AB3ZW1/w69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FrE9NnSi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDHnbk005733;
	Mon, 27 Jan 2025 10:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QBjG0
	dOflPmL0R4h+DaUSxkIlROHNaiHpzgbeLIOb3I=; b=FrE9NnSiiYU+jQhToQj1d
	BtXVDEKN9xPtG/REevE1hywu7Y2ZQ2zn6lQC5w/VhY50z1KtxOKCWGLMUmoUBUlx
	0zlrrgkO8KJilUYvZ2stF3dogcvlb/oC1eJrfVyndk4mXCnM0TwvRW40pYgsqudz
	weq1wcQCT2LZQIrQS4XSdiisgB+yMy4ciytrmA/TsNH/1fqpqULH1Pu62cHXGx5u
	Oj8t0B677884N0W5UAvipBmsLNh4+MFwiqntSYrUifRnsMak5rQ4koDh9WBobM9R
	dU8uersTrnweeOLH6yJOecOI88iG3n/C6BI8lZdOxpNOvCB7Nt2ajE3TCA1YHy4p
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44e0qwjqc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:12:30 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50RFCTrn038526
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:12:29 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Jan
 2025 10:12:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:12:28 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFCHAm008407;
	Mon, 27 Jan 2025 10:12:20 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 05/16] Documentation: ABI: add wideband filter type to  sysfs-bus-iio
Date: Mon, 27 Jan 2025 12:12:17 -0300
Message-ID: <351b15550f8d8e7126ed8253f3a8028c708327f8.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: heoPHEawcgOwUSIA-59iQ2mkauv_38Uz
X-Proofpoint-ORIG-GUID: heoPHEawcgOwUSIA-59iQ2mkauv_38Uz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

The Wideband Low Ripple filter is used for AD7768-1 Driver.
Document wideband filter option into filter_type_available
attribute.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* Removed FIR mentions.
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f83bd6829285..9b879e7732cd 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2291,6 +2291,8 @@ Description:
 		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
+		* "wideband" - filter with wideband low ripple passband
+		  and sharp transition band.
 
 What:		/sys/.../events/in_proximity_thresh_either_runningperiod
 KernelVersion:	6.6
-- 
2.34.1


