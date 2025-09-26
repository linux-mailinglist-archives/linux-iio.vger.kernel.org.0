Return-Path: <linux-iio+bounces-24474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50E1BA52BD
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 23:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D701E1BC5160
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAB7286D7D;
	Fri, 26 Sep 2025 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OkKf3T0q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557E34BA4D;
	Fri, 26 Sep 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921155; cv=none; b=qjNESPQ4BNjodFlk0ibj4WWM/pRB84iM3OCkc02X9NySIYezDw6bLJ3vt1Z+dJZ7fAQOc8M6B0sc7bvfXOQ6oZmlM11G8NI2+m7I0fldco1nOqTCTG8VQnP4n3ikSrnZGaHQ0H0GGA8AIOPY0Ws30HyRTl2QIbDi1/m7/+XK3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921155; c=relaxed/simple;
	bh=CPaFK2Vc9610oLrAE4VTHtYvICfhkshdxskyhGEMgGs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lhx8uJ6OP5tp846OSUtDVwD1hmuIivuUiYP+ySFTXH0zHhrDhKlXYraUzYNtiQLO/Upne4x6I03x/iSg/BYzDZ1y8pKHC9eALPuGEjWvIE9waw8J1I232sDq41B1O8Q9j0tvNUvc7OrxELmUJiv5g6RyDx+cteBGOpbRnLc5fs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OkKf3T0q; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QHOS1u017131;
	Fri, 26 Sep 2025 15:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=JvMSdbdP9VCwaI82pg3rY7gl/Qy
	LwThdAhGQOGeQS8g=; b=OkKf3T0qp20JcdrD9s/I2J/hPSWXsyvo9eGMb2Fki93
	sqZZqAUtvgkzAllf0u0glqjCrrnv2bd7w+5Wj0If2sZOa0U1V6KRgHAhSjk6hwlU
	bHHG+GeUiFeRPeXXb1Y2iN9NPp15rX+j5RB1O74M13Nf+8u+xj/S1Q7+ouJYbjAN
	MLMyKBsb67c98nfngsR5ay7wOME3Pr6+x+eNaumoqvaUSfDQ9UnF4kC2Lf9S4TDT
	N4bYE5ar2WsnSrYFm4DtIODm0H9ewIhPJ3AD7OAoJ6qAsm/4QgdPEf+J63nmRywL
	8PUOTSf8LDRScjmpSeU539qb1OH7+eVacVo0Zd+vJDA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49db1hpp6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 15:00:58 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 58QJ0u6Q001065
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Sep 2025 15:00:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 26 Sep
 2025 15:00:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Sep 2025 15:00:56 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58QJ0h1o006117;
	Fri, 26 Sep 2025 15:00:45 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <broonie@kernel.org>, <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dlechner@baylibre.com>, <ahaslam@baylibre.com>, <andy@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 0/1] Add SPI offload trigger offset
Date: Fri, 26 Sep 2025 16:00:40 -0300
Message-ID: <cover.1758913065.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=fd2gCkQF c=1 sm=1 tr=0 ts=68d6e2ea cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=n5SytP7nWlXxJYHU_ogA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX9Dg01Y8XmBSa
 HKQ2xQrqb7VMwopsvS7oAhQ4iwit8KRBGDjr2xU6QmbZ6GHjhKM2aqk0Vw4j/C+z0IoDPOzhOWt
 41QUHJfm9DLOfGZUZfZ8zehJ/ueDUffUODG4zirzB19Psst9bqR7GiiLV6tyo3q1TK6xpcdPhDK
 ToVaeYfNkO2TU2tbvPtxr/GNLbyIOvZLzjG/SeBZP8tx4cYXPvGtR1z5JndF4UkNB34azee0juH
 Ta/mywYyBLbapUcjDFc/y6GCyb4DQINB9Gw1NTf5KPfkSEPHd6h6vpuBb7aTMEawzuuIuoEXdNx
 uhwQ0gNZ0013Wed2TlFsKiOeQMOviuRd+OcLzbJOFfpCyH1lmU3jXQcUXzrN76uRxqcsMEpqCTU
 xDio6MvWDnpYp9QINk3Rp4oAsrYseA==
X-Proofpoint-ORIG-GUID: RSGGw-7FCbqBmFA-alLCGEfSSAo8ErP1
X-Proofpoint-GUID: RSGGw-7FCbqBmFA-alLCGEfSSAo8ErP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_06,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

Add SPI offload offset parameter needed to achieve high sample rates with ADCs
that require some synchronization between a conversion start signal and the issue
of data transfers.

Change log v1 -> v2
- Using upper case: adc -> ADC.
- Codestyle/readability improvements according to suggestions.

Change log v2 -> v3
- Squashed SPI offload trigger commits.
- Added documentation to offload trigger periodic parameters.
- Picked up reviewed-by tags.

The updates to the ADC driver that use these changes proposed to the SPI
subsystem will go in a patch set titled 'Add SPI offload support to AD4030'.

Link to v1: https://lore.kernel.org/linux-iio/cover.1756511030.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-spi/cover.1758206554.git.marcelo.schmitt@analog.com/

Axel Haslam (1):
  spi: offload: Add offset parameter

 drivers/spi/spi-offload-trigger-pwm.c |  3 +++
 include/linux/spi/offload/types.h     | 10 ++++++++++
 2 files changed, 13 insertions(+)


base-commit: 7e2212429ec9a7b11644a7971d5d606d44ee4d78
-- 
2.39.2


