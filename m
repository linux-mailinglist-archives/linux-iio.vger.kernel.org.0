Return-Path: <linux-iio+bounces-1719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33226830585
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 13:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66311F25B51
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jan 2024 12:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99D91DFDE;
	Wed, 17 Jan 2024 12:38:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FFA1CD2D
	for <linux-iio@vger.kernel.org>; Wed, 17 Jan 2024 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495111; cv=none; b=tKLA6FHseTdXev0dtHBh98CP3tJv5usr6NyloNUMbKp1G+7r+ex7visV/z0SLudp2KeWU4fp7MVHfNZvmFYBsTkFB/y5BBalzNq8FkmOz/g6oSBphFy/5LRrd/1Q+XQnDZyqtYGxGLUumAjF8uvnZG9cWTHg54VF8wCeaPULFBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495111; c=relaxed/simple;
	bh=jceYsI/9Jl2Iq55S3KWYXSC33Zm3Gn0yFh3qtCc1qjk=;
	h=Received:Received:Received:Received:Received:Received:From:
	 Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=Y/Be6N2R5Gg5jquiJuG5k5/KdCWwlhytAamdx6A1WUIi9KgBT0sPHldKLuFCglbYt1JqlP4z2TYyM5LMeEXyhubMzSq8lcOZWtaBMXroe80W7q0dBN2Y8XZbfZ14xKwTEHNgF7TlrAaOoRo2vcuHSqAFPpay5GPNp+xKTXr2Jlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H8JXJA018298;
	Wed, 17 Jan 2024 07:38:10 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3vpb9mgu22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 07:38:10 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 40HCc8Wc030398
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Jan 2024 07:38:08 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 17 Jan
 2024 07:38:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 17 Jan 2024 07:38:07 -0500
Received: from [127.0.0.1] ([10.44.3.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 40HCbu0w023809;
	Wed, 17 Jan 2024 07:37:58 -0500
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH 0/2] iio: adc: ad_sigma_delta: misc fixes/improvements
Date: Wed, 17 Jan 2024 13:41:02 +0100
Message-ID: <20240117-dev_sigma_delta_no_irq_flags-v1-0-db39261592cf@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN7Kp2UC/x3MUQrCMAwA0KuMfFtow4q4qwwJwWY1MDttRhHG7
 m7x8/28A0yqisE0HFClqelWOsJlgMeTSxanqRvQ4+hDiC5JI9P8Ykqy7kxlI60fWlbO5nDEeL1
 FQfYeevGusuj338/38/wBe2wuVG4AAAA=
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Renato
 Lui Geh <renatogeh@gmail.com>,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705495270; l=1315;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=jceYsI/9Jl2Iq55S3KWYXSC33Zm3Gn0yFh3qtCc1qjk=;
 b=VdYZWjk032/zzTMSYMIwC4/hbUxJghXITUpZ4lLGcrXMUgiCPffUSSdR9uuNJBoiZaAMecyO4
 FNeRvi57vH5AXwyjnMkVwFEMcvhsh4IpYzC3UZQ3tL3S0wdBCskyRsH
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: yGeT_eIS-6sWOuTlJMOrQTpiz7axeATQ
X-Proofpoint-ORIG-GUID: yGeT_eIS-6sWOuTlJMOrQTpiz7axeATQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=642 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170090

The first patch is for ensuring proper alignment for the sigma_delta
buffers so they can be safely used in DMA context. I'm adding a fixes tag
on it but I'm not sure if there's any urgency in backporting it so up to
you Jonathan :).

The second patch is about allowing the IRQ trigger type to be specified
in firmware.

The sigma delta ADCs have a fun history around this as they initially
forced the IRQF_TRIGGER_LOW flag and then changed to IRQF_TRIGGER_FALLING
as that is what is stated in the datasheet. However, as seen in [1], in
some platforms we can verify that IRQF_TRIGGER_LOW is the one flag that
makes things work.

Apart from the above, and as seen in similar patches, respecting the
firmware configuration is what makes sense. 

[1]: https://lore.kernel.org/all/CAPJMGm4GaSjD6bdqMwCr2EVZGenWzT-nCCf3BMRaD1TSfAabpA@mail.gmail.com/

---
Nuno Sa (2):
      iio: adc: ad_sigma_delta: ensure proper DMA alignment
      iio: adc: ad_sigma_delta: allow overwriting the IRQ flags

 drivers/iio/adc/ad_sigma_delta.c       | 7 ++++++-
 include/linux/iio/adc/ad_sigma_delta.h | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)
---
base-commit: 801590b27bfbdb6721f85e2c3af70e627e52c8d5
change-id: 20240115-dev_sigma_delta_no_irq_flags-2425795e2a00
--

Thanks!
- Nuno Sá


