Return-Path: <linux-iio+bounces-24815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5E1BC11AF
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 13:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2D2734DEFC
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 11:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21782D5A14;
	Tue,  7 Oct 2025 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FcAoANgm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB061991CA;
	Tue,  7 Oct 2025 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835759; cv=none; b=QVquCS5fHI7e/0GIGZsJ5tswnKZGQw5YiSdrj8Rv53whi1NukFbn+XmucVzlGxPx9/np9SfZiV9jv4iPT8DNNRdyyBhkC0hUqpfJgbC/zEzB+q8+aQpmtfc0oIs23fMInUgElScEC9TULewIC7hB6FGNQxY5oVYb0e/IaoAt5PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835759; c=relaxed/simple;
	bh=pCgjhOAfa0xJBY/SyhGRQksYUt+OUNex4S0WaZXWA4E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ll4+2NE2cbsdZCbl3w3tEBdjCVSX98l4O9kgjoku2biyVh7efa1mJB3zK7tRqdbkyhbmjQSLjswijGlUKbuvUTJdZUP6gP6xtWy1UomBr1wiIrtipvXXgs091uPx0LiHgNK2XoHVygDv/miPhqbn2wvWjmh7LWp80U6cA4ybqU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FcAoANgm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5978d308006564;
	Tue, 7 Oct 2025 07:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=s0vnOaWLD+wvbQNlkGU0J7hYscm
	kGTZq5roKm/OUSRk=; b=FcAoANgm8V7trDPIdPzhH3LuTwndUxIm7CTF0GheD3H
	43H8KB/l4HBeo5cFO23j8GSgAdZdDIs+xX47mM2o91F3MDQdXvWMNWAGEvhmL24F
	Auo9Em2VEv8Md5BNb7WUz9fvgANwc+17Gz7ZcOu0rxXKr6LPGRdroi8DbCeDtZ89
	6x7qHo38zcGBTDUjKfVg2ehmqSmSc+pwaPyRoQfYCBnVr9qpaCfhyyf7O7wfzwEk
	ouv7lHWpArPO4PSBO9kVtFqSVbGnB+ANduxJ6zMzrMUSZ1rr5Mtgfd4f8Jy/dPzb
	iusrYaTC0EtJW1TsD9NwLj0MHnaQh6maBRSZVDVyYqw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49myhq8qdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 07:15:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 597BFsoe058151
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Oct 2025 07:15:54 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 7 Oct 2025 07:15:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 7 Oct 2025 07:15:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 7 Oct 2025 07:15:54 -0400
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 597BFftR006224;
	Tue, 7 Oct 2025 07:15:46 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 0/6] iio: adc: ad4080: add support for AD4081 and AD4084
Date: Tue, 7 Oct 2025 11:15:19 +0000
Message-ID: <20251007111525.25711-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDA2OCBTYWx0ZWRfX4pefL6PqeBme
 GwqxSr4f7ARNC4qw0o1iK3sEGuFswOjzIWB4kBNLtcYz2iFarEVRgzkOTZwXYRtLOGtHci1TPdW
 stHzYh89X/F6h9eQ6fsA0lPG3mXkrOdW21dk4l8/yFrK3SUEQZuNBPq49Ek8HidPHesGyZpkngy
 j6NfAkFVXf5vmk6WRJS0dYCPnG6iFnxtLt/rFhVicLWYnNvnZZ1orG19nfwj6369pPbVWPOMRTI
 XJ8rYzYRpENDuxyc3UrPh7hj1XfWqxH9LH/fXaNisUiMKIlasPxofxbB11KmTGES4Aek9L9L74n
 xTlTIB3KwCe3lD6DhRbmx/sBXJeCfP2kh8G5SrawxzN5IJ2zKfi9E8ZthrWj8urlUPkXYXL25bx
 x8TBW2/SXwFA7J7KltSEJpGGPdQdFg==
X-Authority-Analysis: v=2.4 cv=IdOKmGqa c=1 sm=1 tr=0 ts=68e4f66b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=V9bAyUBXO8NA9gdfiQwA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: iuisRfTAu3Xgj9GnKStaMdMf8tAYzT4F
X-Proofpoint-ORIG-GUID: iuisRfTAu3Xgj9GnKStaMdMf8tAYzT4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070068

Add support for AD4081 (16-bit, 4 LVDS CNV clock max) and AD4084
(18-bit, 6 LVDS CNV clock max) ADC variants to the existing AD4080
driver.

Changes:
 - Update device tree bindings to include AD4081 and AD4084
 - Add chip_info entries for AD4081 and AD4084 with appropriate
   resolution and LVDS CNV clock count
 - Modify channel definitions to accommodate different resolutions
 - Ensure backward compatibility with existing AD4080 functionality

Antoniu Miclaus (6):
  iio: adc: ad4080: fix chip identification
  iio: adc: ad4080: prepare driver for multi-part support
  dt-bindings: iio: adc: adi,ad4080: add support for AD4084
  iio: adc: ad4080: add support for AD4084
  dt-bindings: iio: adc: adi,ad4080: add support for AD4081
  iio: adc: ad4080: add support for AD4081

 .../bindings/iio/adc/adi,ad4080.yaml          |  2 +
 drivers/iio/adc/ad4080.c                      | 80 ++++++++++++++-----
 2 files changed, 60 insertions(+), 22 deletions(-)

-- 
2.43.0


