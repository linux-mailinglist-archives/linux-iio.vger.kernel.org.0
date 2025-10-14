Return-Path: <linux-iio+bounces-25071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D099BDB9D9
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 00:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F1554F1896
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 22:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F81B30DD26;
	Tue, 14 Oct 2025 22:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xbxernbR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4B30CD86;
	Tue, 14 Oct 2025 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480486; cv=none; b=GGyV/GUs7D9/7kC8l0pafNMyFg9vRNkGtK2L82gVFGTQtNkc4Mlj1ytBFFcKsM63v0G93xpAkwbn7ZFT1TYkf2dulZOvMz+i4nBHK6aOW94y96CajOpKMIXNZUXSSFh7xu007Vli/vOSRsSlyoT/MsNdemj7vfD6YOa+GlukS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480486; c=relaxed/simple;
	bh=CbZR6oh7yyXoMRurg+zamO3Wbh7DoDCdmKsy7Lp+bDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OjRmhHSHdC7VRujBe1j1XBi+zv0mGBH8ukNQnoAsooE/e1bl3ISnt9QJuQjAxXuf599HlMmidHSyk6+UPNWQXGfVDK1iU9rOV7v3Sf0Cib7vezB+Z1YxNL/C5qfxavUDiAiQk1dO3XmfT4O+ln3RfJ62yh5lripzGF2cb27Mck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xbxernbR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ELEfp9015810;
	Tue, 14 Oct 2025 18:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=TXcrYMouAvjPgE/kXt0eLUMwCFf
	VA1v3Zt6G4eRsK9M=; b=xbxernbRR51PsvnrTGGsHpEDiKx5+RjBlDl38Aa30wZ
	C2rBdFQz6nbc78Sh4C+uWXDqhEF44//C6W/A+xfM/W25nbiuTunFUttY0g93sa0u
	XWoXFhPieUHX+x7S4olzNJ5gc8ArQFyKZWuK4VT2qb3bTSVCMIkhOnvUS9ch2nn3
	wF6L7S+2Az8w3GJoD7Lceshaoos1pafvMmuuQu7KR+GXjWzgATPP5NKHKJjXNKD+
	FCBY5yG/OSgF1IJ7ZrMb83RVVCcgCjtV8Pbw+fyq4VqbMvCEiL0y1u0F/Y9IOWjO
	0XWTu0PZ0gpYQglnNoS+6Uiyfbyra5DF0NQ6Qfanf6Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49qh30ve7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 18:21:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59EML7l7042697
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 18:21:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 14 Oct
 2025 18:21:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 14 Oct 2025 18:21:06 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59EMKpB6005486;
	Tue, 14 Oct 2025 18:20:54 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 0/7] Add SPI offload support to AD4030
Date: Tue, 14 Oct 2025 19:20:49 -0300
Message-ID: <cover.1760479760.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: GNthCdMjY6uTWR6lQkxflLgXbdOuI5M1
X-Proofpoint-GUID: GNthCdMjY6uTWR6lQkxflLgXbdOuI5M1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyOSBTYWx0ZWRfX/WMW03OC/c2I
 PAAhQnfLUxhdcNeozCpJpy4XNeZYtahHBugd9T0NzfQrdN/8JIqDrPrXxru91hUIvhDypQCU/L3
 ut4HqM1FPPiipXTwGJieiiVVAiZwiFEChwlwKP9lSjqJoJXQAS+QdevDXt4hEqq0CZaHzQzEvbO
 IQ7JbRrIgfqFBFCMythJwMQsNuOXNmQ5Pwv9RI/x0VDYPygdxwsREDQm70pxVnmyrIQhHs9ToKb
 B1UmjmmaeNvsWzt5uMuRk7Bz7x8Eh1Bus9xpZ31qOukR49IuWI4gQoLWs33hpHEYhp6brtKRF6D
 5i52rHOCLjUCFwlq4uaC08VwCt8CAXHOkGhHDfiEnNuKyxMUGAR315Bq9xBpHjGIFGhUTg89pfo
 YsB3TUkc8zfCN8D62umJYS+uL40LnQ==
X-Authority-Analysis: v=2.4 cv=YscChoYX c=1 sm=1 tr=0 ts=68eeccd4 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=ISJHB260PJg-Il1bfM0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110029

Hi,

Thanks for all reviews and suggestions to v4.

Most changes in v5 are improvements to the SPI offload support patch.

Change log v4 -> v5
[PWM]
- Dropped PWM patch.
  Since there are no longer changes to the PWM subsystem, I've also dropped the
  associated addresses from the recipients list.
[DT]
- Dropped leftover adi,pga-value.
[IIO]
- Made Kconfig entry depend on PWM and select other features.
- Reused ad4030_exit_config_mode() in ad4030_offload_buffer_postenable().
- Dropped common-mode voltage support on SPI offload setup.
- Adjusted offload trigger period calculation.
- No longer setting data frame mode from ad4030_set_avg_frame_len().
- Rearranged code to reduce patch diff.
- Dropped leftover adaq4216_hw_gains_db[].
- Tweaked ad4030_get_chan_scale() so val and val2 don't get overwritten.

Note there is also a patch to the SPI subsystem [1] that contains a feature
required by AD4030 offload support.

[1]: https://lore.kernel.org/linux-spi/cd315e95c0bd8523f00e91c400abcd6a418e5924.1759760519.git.marcelo.schmitt@analog.com/

Thanks,
Marcelo


Marcelo Schmitt (7):
  dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
  Docs: iio: ad4030: Add double PWM SPI offload doc
  dt-bindings: iio: adc: adi,ad4030: Add PWM
  iio: adc: ad4030: Use BIT macro to improve code readability
  iio: adc: ad4030: Add SPI offload support
  dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224

 .../bindings/iio/adc/adi,ad4030.yaml          |  76 ++-
 Documentation/iio/ad4030.rst                  |  39 ++
 drivers/iio/adc/Kconfig                       |   5 +
 drivers/iio/adc/ad4030.c                      | 636 +++++++++++++++++-
 4 files changed, 733 insertions(+), 23 deletions(-)


base-commit: 4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba
-- 
2.39.2


