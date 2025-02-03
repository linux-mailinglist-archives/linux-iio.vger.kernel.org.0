Return-Path: <linux-iio+bounces-14944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF4A26353
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 20:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DCE163FDA
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80AE20B807;
	Mon,  3 Feb 2025 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qSLstqN7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE966205507;
	Mon,  3 Feb 2025 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738609893; cv=none; b=rJM1AkAzaF/3ih6AY7TuAiQx7yZrw/dFXt3GJbqUttpdv+KnhYLjjI2TdmLFo2TMwC3QuOvaRDPQD82YfVr8Vgy7gISE0qLaqxQWpUX6iGB6MnRncbwIc88PoOuVnE6j5a/zLizF7tDO8gAYKAfZ4n1B599TL1dI7lXj1PPZVMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738609893; c=relaxed/simple;
	bh=wsMMIMq1C/N6bJhF4VtiDEOlnNV12lE/8UIo0noR294=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ddH5EsTPv4uKQn70csn6YoNjI904zyCSfeo5t4MiOpuU2oIrQ+GANLq7XCRxzEnyf72COsef415zKcLFMBT3gNA3HV2BQPhklsEeDk7Y2ohaxFIP6vYEH8Pav6Q7IWCo0IhdjDHN54KV0p+WEpUBfx1IgsAtZ3ojXAx/l3hjr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qSLstqN7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513I2RtG029876;
	Mon, 3 Feb 2025 14:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=qViXkyLZy/s+CobQAADEY7NcJWf
	8zZntyNQPukceM3E=; b=qSLstqN735cu9aPwgatQdnRAfMMtncsEqi1NS5y5ONF
	lVffxbvZxsUraqB3dSYVFLdVYo9LrZIC2q4PQ+fJyKdyWvMnc5IHhu/72ZqDjVhV
	B+xJilwHTDDHcWtRPtw+a14SHZPsPm8SWUQwxv4xhLTMZLI2xrpSQK1wKBBGQDde
	bkgKUzRnV9dcmwoadWfivoZtQiFijVSbGKGNghH8k6lAvJPavP3Elq0DP6W/au2j
	owmYf0mL/qYrJPPfjNYq5/h/Awq2lKzK7wXWGsrrKTYuzDElhNu9Ig10lRL7Ve6y
	5KxIWiUzW09w9ZvNqJnmh1R481n2R7bbwALb3aAQyXw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44k2qtr8bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 14:11:03 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 513JB2gh051995
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Feb 2025 14:11:02 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 3 Feb 2025
 14:11:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 3 Feb 2025 14:11:02 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 513JAmuB026369;
	Mon, 3 Feb 2025 14:10:50 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cosmin.tanislav@analog.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <marcelo.schmitt@analog.com>, <dlechner@baylibre.com>,
        <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 0/3] Re-add filter_type/filter_mode
Date: Mon, 3 Feb 2025 16:10:44 -0300
Message-ID: <cover.1738608986.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: cZx1c8T1fiA7lMCl29w2TS1lAHZhSr4Q
X-Proofpoint-ORIG-GUID: cZx1c8T1fiA7lMCl29w2TS1lAHZhSr4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030139

Better document sysfs ABI for ADC digital filter configuration.
Also update ad4130 driver to support the standardized IIO ABI for digital filter
configuration.

Change log v2 -> v3
- Added in_voltageY-voltageZ_filter_type to main IIO ADI doc too.
- Added filter_type attributes to ad4130 driver so it also supports the
  standardized ABI for digital filter configuration.
- No longer dropping AD4130 specific filter_type_available options from sysfs-bus-iio.
- Re-add sysfs-bus-iio-adc-ad4130 just mentioning the ABI at sysfs-bus-iio instead
  of repeating the doc.

Change log v1 -> v2
- Split into 3 patches.
- Re-added sysfs-bus-iio-adc-ad4130 to keep filter_mode separate from filter_type.
- Removed in_voltage-voltage_filter_mode_available from sysfs-bus-iio.
- Added deprecation notes in sysfs-bus-iio-adc-ad4130 asking to use filter_type
  for new drivers and referencing sysfs-bus-iio.
- Improved commit message with explanation about use of filter type attributes.
- Dropped AD4130 specific filter_type_available options from sysfs-bus-iio.

Link to v2: https://lore.kernel.org/linux-iio/cover.1736261047.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/b2132bd3ca1d64cdd8d5afab1f1f33c574718b50.1732901318.git.marcelo.schmitt@analog.com/


Marcelo Schmitt (3):
  Documentation: ABI: IIO: Add filter_type documentation
  iio: adc: ad4130: Add filter_type attributes
  Documentation: ABI: IIO: Re-add sysfs-bus-iio-adc-ad4130

 Documentation/ABI/testing/sysfs-bus-iio       |  9 ++++++++-
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 20 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 drivers/iio/adc/ad4130.c                      |  3 +++
 4 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130


base-commit: 9b75dd1b7d6b98699a104c6b1eec0c8817e5fd4b
-- 
2.47.2


