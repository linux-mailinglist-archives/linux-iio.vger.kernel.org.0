Return-Path: <linux-iio+bounces-13539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8C59F3388
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 15:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BBE18850C8
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBDA5FB8D;
	Mon, 16 Dec 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CoFvJeg2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699EB45038;
	Mon, 16 Dec 2024 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360554; cv=none; b=in3VzHi7ilPN0WGgI7+fG9WNdNEP/UK8RS5uuw5oCrHKlCUTgSp3OP3mTdwdWu5ODcteDpkgWjglfQOlrh7k7ual7eKXSDK6zKGPUzYmtLqiTYcWe87zH9pizzOiGJ5hybRfDbcf8cLCE6Ozd0/LfoaS0TPJ24C1m3r5zYpP9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360554; c=relaxed/simple;
	bh=qEyKN77h4oTwLJ02cSL661Z1gf2Jb/Q3c8qZsGRXFXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gig/lLAjyJ8oMJE8Bl//6LpYqknKRCjHQfkkPFVBYFm/nx57Up7KsjbpaaQmQylfa7jDivoirjglz4JraP35fZ2sHPn48QD6xpGQdGXQckGd4ktQprB8YlAzfTXqtIAd+BY9AO9/3eIrCsifErs+BrlodeZhQN8HriTWrWOb1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CoFvJeg2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9pmLp018507;
	Mon, 16 Dec 2024 09:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IT/uD
	oHz7u2CMKwPPesIK4EWtdxyGXsQwisJ0qfhNmk=; b=CoFvJeg2Pu6Qj2/YYfaG3
	DGcTdzqvM5y0L0aCL/zOdZQ34giFVCyk+V0b07Rr7f9iGO94YT3PuUcoNmIkKR0c
	zuBna2QQmO49b6NHPGYLADi+F6/cgceFnxe7Z1pKFsgSUzipOKhpZPSOcTOJMI4z
	nDPy23FbYxmBwaab6RAW8AiWHtO4ZV9nQSwdh78leB+kLbXqFMeCh49hsW8wrzcH
	2GoVJ9PSplgfr0nVbdAkQp2z9QlimSU9UtDJAlxnfkZeuGa/Bkw2/8beI3amvQTt
	jJw8E7Zwn7VIONMof0/ACBBqzr3DeIqYkJfvaGIx+VB/ctTYMSUKqSVNHnmKdEfY
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43jhxvh1cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:48:50 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BGEmnT9044442
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Dec 2024 09:48:49 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 16 Dec
 2024 09:48:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 16 Dec 2024 09:48:49 -0500
Received: from dell-precision-robert.ad.analog.com ([10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BGEmKdi018405;
	Mon, 16 Dec 2024 09:48:44 -0500
From: Robert Budai <robert.budai@analog.com>
To: Nuno Sa <nuno.sa@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Robert Budai
	<robert.budai@analog.com>,
        Shen Jianping <Jianping.Shen@de.bosch.com>,
        Alex
 Lanzano <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <robi_budai@yahoo.com>
Subject: [PATCH v3 1/7] iio: imu: adis: Remove documented not used elements
Date: Mon, 16 Dec 2024 16:48:07 +0200
Message-ID: <20241216144818.25344-2-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216144818.25344-1-robert.budai@analog.com>
References: <20241216144818.25344-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: -pcSo7ZU6xPhVBA9az2AFJoo5DcYsfdk
X-Proofpoint-ORIG-GUID: -pcSo7ZU6xPhVBA9az2AFJoo5DcYsfdk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412160124

This patch removes elements from adis.h that are documented
but not used anymore.

Signed-off-by: Robert Budai <robert.budai@analog.com>
---
 include/linux/iio/imu/adis.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index e6a75356567a..4bb98d9731de 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -99,7 +99,6 @@ struct adis_data {
  * @spi: Reference to SPI device which owns this ADIS IIO device
  * @trig: IIO trigger object data
  * @data: ADIS chip variant specific data
- * @burst: ADIS burst transfer information
  * @burst_extra_len: Burst extra length. Should only be used by devices that can
  *		     dynamically change their burst mode length.
  * @state_lock: Lock used by the device to protect state
-- 
2.34.1


