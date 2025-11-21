Return-Path: <linux-iio+bounces-26361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D8C786C9
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 11:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 58C0B3249D
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419AA305040;
	Fri, 21 Nov 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oh2ivgxf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1BB34A786;
	Fri, 21 Nov 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719206; cv=none; b=MTe/BsgsSsj17ChqpG4afX8e+jhMyKF2vvcBfCl8tCHqplC6MM7GgrHX/JcPOoMyCFa/ZUWK4cGk1JF53YIhnMkCUX9PdOtSDgEJny6IOavR28fuMX4te0eDvE8aYxTIMZQMsuH4S2iFDQIoDpzYtOVhSxnjQBbVjgj6ihxqtck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719206; c=relaxed/simple;
	bh=4ngOHI0oQJ9ODvGvOW6kol0M+om6BeyoWwEBajehyeU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JcdvKWDMAQs02oYqePYlpHNywsZ9t6ywuq0fg9NGZXOFWQL2/aKMVGl/ab8PC3cm1EqVsKc+XRJmAfEtPMER2ZQx5i14+WgwxBjhT+Rq59pC/JPyJTyBBiJT3dbrq6bsoZWLCD8f4d0I0WwmE9cR6ni+9MqhNDIRWxuDtADIpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oh2ivgxf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL6KJvW2556766;
	Fri, 21 Nov 2025 05:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5Q1/Qu6oH/Iq5pIb5Q7+xQKZ5r0
	Sx9x+6nGD3ljvf4s=; b=oh2ivgxfCKLZpIQ+pyOeI0xutwku7F4kHZkeDrSamhX
	lgWv2O73cysm+TvFf7XeGhEHz6Amjr0ySDCVZ0LGY9KgWQTKmsVk8GQMZnBtx5QH
	P023I8A/81PpuB+pt1dFCpZva+KfRUvIgnfHM5pim5B+TIfFQTooj2iza96uMamS
	AUl+OlNqq0U3vgPFFtypNcclVlzmFTo6jl4WIPoBU88zX1DLiTPR3bCaBThYCJ++
	HME4DwlHCJov4OSzDKQ6Yc7L+nkPHf8MH2xI3at2HaNEMiW+kpC9OLztCBKZ4iYw
	uGwxek3oWYpqvCqWAby1noJSgwFNaegTOaQujIXOIZg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ajjqjrwd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 05:00:01 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5ALA00PV015301
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Nov 2025 05:00:00 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 21 Nov
 2025 05:00:00 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Nov 2025 05:00:00 -0500
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AL9xo94027151;
	Fri, 21 Nov 2025 04:59:52 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [RESEND PATCH v2 0/2] iio: frequency: adf4377: add clock provider support
Date: Fri, 21 Nov 2025 09:59:31 +0000
Message-ID: <20251121095933.19032-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: O0pP-IiaX-3qfmgCv0ogh2sJvywsV4tY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX/JjPM9eVx2m9
 2Ub5bK2LAySyEkKDNkVl9BwKI/5MzEik1jqulrrenUya29KsgL+FRufiRAt+Uqk6KbDWMMUzDI0
 TgYq9T8tolbfK48ctS1e73gGKga68nrztmDMsiqVPBkj4DhmpdWqSV9xaNSl10Gv0AORHn5vqyI
 VfxFgZNdXrPJmISu/aBoM4HCe8ErUhJ+1coIvU2bMB8D1N87FgFWyqp7HC9qc8RVxdAoQOwJgfM
 J+T8gBMvHIq+/EJsFDTdUj+HWRY/GHY24//8Bjoz67OvGhrIjjfF0e2ah7Y0CD+mzKzaUlpsTAi
 eDrmzbzInUvPtIjxrLIGZyDC90ncERBeYSQW/LjxKqRpBR7F0FWw5v8VAuSjEe8HQVF+yXQnKUI
 NoT6jFLq6bxDCwRkX4FTkg6d8c4t2w==
X-Proofpoint-ORIG-GUID: O0pP-IiaX-3qfmgCv0ogh2sJvywsV4tY
X-Authority-Analysis: v=2.4 cv=ffygCkQF c=1 sm=1 tr=0 ts=69203821 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=xhyw43Vw4g2VkAmxKawA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076

This series adds clock provider functionality to the ADF4377 frequency
synthesizer driver to address user requests for controlling output
frequencies from userspace.

While implemented as an IIO driver, the ADF4377 is commonly used as a
clock source. This patch series enables it to function as either:
- A traditional IIO device (when #clock-cells is not specified)
- A clock provider (when #clock-cells is present in device tree)

The implementation provides standard clock framework integration with
rate control, enable/disable support, and maintains backward
compatibility with existing IIO configurations.

Antoniu Miclaus (2):
  dt-bindings: iio: frequency: adf4377: add clk provider
  iio: frequency: adf4377: add clk provider support

 .../bindings/iio/frequency/adi,adf4377.yaml   |   8 ++
 drivers/iio/frequency/adf4377.c               | 119 +++++++++++++++++-
 2 files changed, 125 insertions(+), 2 deletions(-)

-- 
2.43.0


