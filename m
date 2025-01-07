Return-Path: <linux-iio+bounces-13968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3356A04433
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E797A166735
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D048B1F2C50;
	Tue,  7 Jan 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZDz5ZJjw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3A1F1312;
	Tue,  7 Jan 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263501; cv=none; b=kF6aU1iKOJaNNy33aNhVMNF/cGkQsymgAFHzbR72cWVYVrB2l3O9w4JO3t90Z7EHZDqJv2C05CxBnGqgK6k39U2APyikyaIkOPYR8hL3ZdBE9Y4lB14Vj6aNfFXR4tmG6OZ2vENgVkDK6ow5Ic8zNCFFlXWMMc4v0Iww58LRdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263501; c=relaxed/simple;
	bh=/If+iBAMuUIVP5HQTf/lKqpJ9aVZ1G8YWx3s9Z0iZN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ix2RsMhBwUVQgiYUnKUDgt1WwyNBfbMJxXpX4juTwYRTaGyYWlUqYTKU6v3PmRtvEjurcuSMb7GauWVY0flS/8U4rALhfoHt0UhSfX5wSQGZOgmIOJly/EY4xRd/kiIsFDrdkRBItAC8mCoPWArkxNi2MWloV3gkz/RKolktotg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZDz5ZJjw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvDdd013537;
	Tue, 7 Jan 2025 10:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XIarC
	/HzhP6BfVrKBwNalJeTu5vYAuJ+sz1OUsCi/DY=; b=ZDz5ZJjwWcsh4whZFS6s7
	BBIZ8pxcnHlH3P++/sYkchORDbwVFxWUYAepjx4zjxfUHMoFobtOK2Q1WlbbftOu
	M2hBLAxJ2RIgY09Fh7SmIFDmj9j1/R7Rnj0yN3c7opzKONRwrwW2WiO4E2Wtczq3
	KYc1ElS27xuapwORJnVi/MELFm0zgSaMM3txNjCCKjvsSvlGiajbqL4wjdvEnnzB
	CdETCXgA8rfl5h5t04mn/4KJaxBSO8JbtMSzRKAO862INR5QJoU+2FuaBnkdeO9t
	akXWaU0Mrqn/MQZjtciQYP75nwUAENB54vQR16oCTHimagDu0YwdHE7QpIY8J2DW
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4415f6gddp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:24:44 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FOhlB033998
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:24:43 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Jan 2025
 10:24:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:24:43 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FOUvi030254;
	Tue, 7 Jan 2025 10:24:33 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 02/15] Documentation: ABI: add wideband filter type to  sysfs-bus-iio
Date: Tue, 7 Jan 2025 12:24:30 -0300
Message-ID: <40707fa904ba7b1659554747ff7520139dd6f94e.1736201898.git.Jonathan.Santos@analog.com>
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
X-Proofpoint-ORIG-GUID: XTHpWR45dDbaeWH-kxHBY_-by4yzT65X
X-Proofpoint-GUID: XTHpWR45dDbaeWH-kxHBY_-by4yzT65X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070129

The Wideband Low Ripple FIR filter is used for AD7768-1 Driver.
Document wideband filter option into filter_type_avaialable
attribute.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f83bd6829285..c4c21a7bfba1 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2291,6 +2291,8 @@ Description:
 		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
+		* "wideband" - FIR filter with wideband low ripple passband
+		  and sharp transition band.
 
 What:		/sys/.../events/in_proximity_thresh_either_runningperiod
 KernelVersion:	6.6
-- 
2.34.1


