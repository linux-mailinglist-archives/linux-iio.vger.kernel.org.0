Return-Path: <linux-iio+bounces-24465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294DDBA5139
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 22:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4265E1C00D79
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39F427FB34;
	Fri, 26 Sep 2025 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Qp0nRuG0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B69213BC3F;
	Fri, 26 Sep 2025 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919091; cv=none; b=hbHEOD4vJDxVKqbil3pUo1LvDE+9KuGKII2meubIzcv06eHtf0YC6lPhFAfSd47fqXlCvrWRmt1sv5RasSpTtY+BeYsnpwFSeWpiNbNfjbB7F7a6+l+waKtvJJ5VfIRYG++jPzQS+SUc3Eptm4p+sCbyWNULSRSIy9vIsanIc2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919091; c=relaxed/simple;
	bh=rAWVXUrM4gu0fdZfprKWIcm5gOU7QGFOOJJsvWgYLrU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PGyDrN9iermx60gC+AiiQV+bv7yj4djn4Du1ubJfsaxGw6L8WWD0sBbCTgBP0ThTbWu9isijlP+W1OFWPXdLVcGwS8zuXRqp/my+lWv1n9TwjXzRJ4BpzYx/uiPRWYJtmtBhMBYyUEm6XZHj2zgBihLL2LzIWrG0ECXSUHUZygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Qp0nRuG0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QHOSIV017131;
	Fri, 26 Sep 2025 16:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=DFpXpOXND+SHYxJy5pNTPCnqtEC
	ZN8QLLgErVFxlTMw=; b=Qp0nRuG0IXTnsxGIGmbT6a+iL1KEReIO0ge/IPc1bST
	a1/j2HZf4/pyDruTYga9qERVFb58c/9XJIdHNradTqjNDEQj7kKP8slcSVS9NTtX
	RwBVBnZOQR78u7lzaA900ledB8oBzem5Alo8Req1g3XsL58O/DxP3E8AD751RtNm
	A3EOEhVxjQ0cg2nqXGO+FG3wMhhV6sNRdtFhKzOCE7DwVSDVw+q+j3hhdeCgJdnH
	OeWER6j7olfp9p7yvK6OcrAmxr7KZ6hereRZjnGN+vwpHXa9LKTgQ3Ob6mSX9vbk
	J7jRHzeZAUYLtZ7s3d2MeVHW3Iq96NrHDJ23FaEilIg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49db1hq541-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 16:38:04 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58QKc3C1026812
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Sep 2025 16:38:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 26 Sep
 2025 16:38:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Sep 2025 16:38:03 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58QKbmXW010144;
	Fri, 26 Sep 2025 16:37:51 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 0/8] Add SPI offload support to AD4030
Date: Fri, 26 Sep 2025 17:37:48 -0300
Message-ID: <cover.1758916484.git.marcelo.schmitt@analog.com>
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
X-Authority-Analysis: v=2.4 cv=fd2gCkQF c=1 sm=1 tr=0 ts=68d6f9ac cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=LDzTrm_DnJI8KpCx88EA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX+JKecNzP0dDU
 5DmFwktf5adr0qrqcCKgHJ9PnfSFmvLhPsuDqzULDrb/5Gtn8rqO7b2jlLRzt1Oj8C2wyAksqbw
 WH8sCp20TpbllTpPMc4M/5rYmRpbJMPBw0NO8MgNlfpYjeFcxeXoBZtDDE4wl1TOZtMupvTR/XD
 G/1t0zqMkzARvIkBZxCsZk5l0wFn+AxgJkfpCbtDuOirjwDZ4sx47D74TP1BGd01Vp5XVUSA60P
 mGmzKPJsRPMF4JHZABOTlSFsfcx9MPIKuWDS3JhEfk0P78u4/t+ZLPy7Pl3lyRZX6RLDVUZk3oi
 fo1bdE0BuI0/lXh3AC7sA3vu6m8fC9N2/pEG9TEjyvtkxughzvHyqP2VL2f/piKY118viPtJvSY
 VQdZY8RXdMSL2c92EJdu7G4pEt2jwA==
X-Proofpoint-ORIG-GUID: T3tYFgyKbNiTCutFeMVjo_zN1ilJ7Hgf
X-Proofpoint-GUID: T3tYFgyKbNiTCutFeMVjo_zN1ilJ7Hgf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_07,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

Hi,

This patch series add support for high sample rate data acquisition with AD4030
and similar devices. The last couple patches in the series add support for
ADAQ4216 and ADAQ4224 which are similar to AD4030, but have a PGA in front of
the ADC input.

The patches to the SPI subsystem were submitted in a separate patch series
titled 'Add SPI offload trigger offset'.
Link: https://lore.kernel.org/linux-spi/d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com/

Change log v2 -> v3
[device tree]
- Picked up reviewed-by tags.
- PGA gain now described in decibels.
[IIO Docs]
- Picked up reviewed-by tags
- Updated AD4030 documentation with link to a working project that supports
  double PWM setup.
[IIO]
- Dropped "Fix _scale value for common-mode channels" patch accepted in v2.
- Dropped Nuno's and Sergiu's co-developed-by tags as suggested by Nuno.
- No longer shadowing original error on ad4030_offload_buffer_postenable().
- Reduced transfer speed for register access. (new patch)
- Select SPI_OFFLOAD_TRIGGER_PWM instead of depending on PWM.
- Renamed __ad4030_set_sampling_freq() to ad4030_update_conversion_rate().
- Dropped st->mode check in ad4030_update_conversion_rate().
- Dropped ad4030_state mutex lock.
- Let SPI offload transfers run at the max speed specified in device tree.
- Don't round offload transfer bits_per_word to power of two.
- Take common-mode data size into account for offload xfer bits_per_word.
- Disallowed SPI offload for 2 channel interleaved mode.
- ADAQ patch updated to handle PGA specified in decibels.

The code was tested on a remote setup with ADAQ4216 connected to a ZedBoard
running Linux kernel 6.17.0-rc7 built from SPI tree for-next branch.

Link to v1: https://lore.kernel.org/linux-iio/cover.1756511030.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1758214628.git.marcelo.schmitt@analog.com/

Best regards,
Marcelo


Marcelo Schmitt (8):
  dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
  Docs: iio: ad4030: Add double PWM SPI offload doc
  dt-bindings: iio: adc: adi,ad4030: Add PWM
  iio: adc: ad4030: Reduce register access transfer speed
  iio: adc: ad4030: Use BIT macro to improve code readability
  iio: adc: ad4030: Add SPI offload support
  dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and ADAQ4224
  iio: adc: ad4030: Add support for ADAQ4216 and ADAQ4224

 .../bindings/iio/adc/adi,ad4030.yaml          |  90 ++-
 Documentation/iio/ad4030.rst                  |  39 +
 drivers/iio/adc/Kconfig                       |   3 +
 drivers/iio/adc/ad4030.c                      | 750 ++++++++++++++++--
 4 files changed, 826 insertions(+), 56 deletions(-)


base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
-- 
2.39.2


