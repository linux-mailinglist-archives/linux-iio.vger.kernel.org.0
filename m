Return-Path: <linux-iio+bounces-26218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6358C5D076
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 13:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0483B2FB2
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2C0313E1B;
	Fri, 14 Nov 2025 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aMtm6zBj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A012FB08F;
	Fri, 14 Nov 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122209; cv=none; b=ECDLsG51h/Z9SgqF4bOF4UUceISlcG11ROTXkHBxPrHytaFz5ukqof+63rnp1hm4Lxa55CtPMcWNofjXisWphU/lKXcLJVpUZWhLSpF4KUDEeRymCj6redn8EaiUVgFkzOTFPrV2wwvHPjZEGggysKqWCTdqEonemEYSMVp0DF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122209; c=relaxed/simple;
	bh=ZJfTysD1AInk3W4VMRR9yEsCe8X31yY3XoTCWXVARTk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQh4Gpvr9PYekF4cCgn9/gousF2jS05jowxrRWEl7uPdH+eJXfL54so4+zEBgdAUDgNvLzMYAiaJ0LROrfHJr1LdwFXZWm4sWSewxZvS9BRS+AFBOqMCQSHEZ1SVTdf4kafa0DmCbwoiU8SrRnuLVostrSVCwK5O03/axZ4oDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aMtm6zBj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE8H3lW3654525;
	Fri, 14 Nov 2025 07:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=LuU2sVKUX/c5ku4iRMv1s5eComd
	YLCvDIbwKUDl/gYk=; b=aMtm6zBjBGbBrG4ucpyEQ1yQEtFrYCGsIKaDuWSCg78
	oHhamACcU+FsJVxacoUdZStL3v0OlWQ/yKanKj4AJ9Y56HgZ0oZ/VpxngfErw4uV
	umTtX4ng8SM8LiR17Ai1aRRlZZOgjCa8aSXVzef3/e8xVMI3nlX5ZShmcYPKfIwn
	MPn5t68Mtk86a2LK3RYNjOffJQasoqhr2QLmilBi5vhLq6oZWEmb7gFo0KpmNVRk
	DWtNKuWDlY0qt7oa8FuFZrQkl2FvUG6JODg5DzMI9U7xvpBKQ3Cl5GoitlSldOTb
	4Z3S9UgdHCL/9YRVIryV2QaWK6JFMMl+ZhNiVjBjJew==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4adwaw1wq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 07:10:05 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AECA4MG045507
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Nov 2025 07:10:04 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 14 Nov
 2025 07:10:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 14 Nov 2025 07:10:04 -0500
Received: from Ubuntu.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AEC9r1x019558;
	Fri, 14 Nov 2025 07:09:56 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/2] iio: frequency: adf4377: add clock provider support
Date: Fri, 14 Nov 2025 12:09:06 +0000
Message-ID: <20251114120908.6502-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA5NyBTYWx0ZWRfXzIID1O2d07Uv
 qF/zNX4h+YLAFo56oXYlqthUQssNE7lpZvBlSNWLQps0mrLEqGigzsISGoiS/9ay0jrbRpD7zgI
 Qqg2QB3NwKVJUBSvgnQXF/i7dDyYIs64G72dGQXqanIX/nEhhBmKZrb0d7Y3iFkS4jQXu2oH6gm
 4rKFP/d8nAO/viKqwfhpdH2R4fIrHC74UHDVHec0ocUd7cmaL9xU1/2CVW2i8xyZWFs9q5/kLy+
 HfKsq0BRV4E23OJ2NxqRS1POcD2CdQVFz8VPdqHdjHHkiUflud8uH2S3nt009TkRViM1fbMYwXM
 gJdWRnMimi6O/8TS3nx9Z1SchYBPMtGigVu4ypJLRaRupgZxdD5rD7Rg9e1PAZPeah1glaVh9Xj
 CVOXi0QLFsuyrs+D330MYsnV3pb/Mw==
X-Proofpoint-ORIG-GUID: ALdTJBQIaGFi_KjO8UlA5kgJ0v8aLzSC
X-Authority-Analysis: v=2.4 cv=M91A6iws c=1 sm=1 tr=0 ts=69171c1d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=xhyw43Vw4g2VkAmxKawA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ALdTJBQIaGFi_KjO8UlA5kgJ0v8aLzSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140097

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
  dt-bindings: frequency: adf4377: add clk provider
  iio: frequency: adf4377: add clk provider support

 .../bindings/iio/frequency/adi,adf4377.yaml   |  20 +++
 drivers/iio/frequency/adf4377.c               | 131 +++++++++++++++++-
 2 files changed, 149 insertions(+), 2 deletions(-)

-- 
2.43.0


