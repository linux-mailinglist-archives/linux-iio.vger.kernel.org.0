Return-Path: <linux-iio+bounces-13962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B881DA043CF
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2507A3A404C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262501F2C50;
	Tue,  7 Jan 2025 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="s13G3fxM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1BE4C85;
	Tue,  7 Jan 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262719; cv=none; b=XgpgjQngvwDMOyeDIKYg+stG+0Zgs9bSXgqUF5l6N6+9Ec2iy8k6kPCuWYvaXNIG8sqt4eWoi76AQJf28z8XHiukLyg7njD9RzoxAgmP4t0nchQGcnJGCPX/rDSZ4m/D6x1PqMwafmhZSHHPPcbzKWj6TQnYQA0bd2IP2Yz6fc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262719; c=relaxed/simple;
	bh=WF5IF6sLCQ4N20cbvBAkckWt5lV1bkTXVWsBNZXy5kc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oZf5CJLaYWDPAdmISQKyQQ/xhXbrQQyqyePyo7NIB/vIsKDcvTjcWRVtwb/YDUEhcYm1ihFHQD2cayWxIspMyKIt4cJJLP3oEcVgRugQfu9SbBnbWZoJRjdorKh4G4QWKp6zd1JYYTZl2/WLAxYJC6FRoxTty7GgZqYn9pYR1wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=s13G3fxM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507EvFe2013565;
	Tue, 7 Jan 2025 10:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ADkpAURUBcBxXV9QWdTOu6GpTbY
	px3N6yEdfS8lnWZU=; b=s13G3fxM2+/0A97tvhy9Gey6eK0pAHneq/bnKD5V6tI
	MPE7qx00pFKCSOmAjg7RRrjXtednYMOPWQRl6MavOSF7tjE8UwAe0A4UEVe5DtGQ
	b/iPz1AFDLkjLsSkycLXDazBPbDKVJL9Gah8jg0YZ/ZF7cNTz5RUoNHsPZ8nz1Ps
	r6YXzRhQ2AayZu2020uEq7pcHN1gkiqBw5HqR1aXsSdsgG4xz0jmLoX4o6g9tMHu
	cnZlIGxwbeKjYo2JwFl5i/dECT1MfNts9KkbMg3gUXOnGPh7TuBLq3dsUgQr3wQ+
	S5o50c8oV55wdkuVYfaZyD3527v7p4qG3BIxwQQtp/g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4415f6gbnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 10:11:30 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 507FBTkM033220
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 10:11:29 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Jan 2025
 10:11:29 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Jan 2025 10:11:29 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 507FBAbg029705;
	Tue, 7 Jan 2025 10:11:17 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cosmin.tanislav@analog.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <marcelo.schmitt@analog.com>, <dlechner@baylibre.com>,
        <granquet@baylibre.com>, <u.kleine-koenig@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 0/3] Re-add filter_type/filter_mode
Date: Tue, 7 Jan 2025 12:11:06 -0300
Message-ID: <cover.1736261047.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: Pl0qzJRoG-SSkWWMvsIT05EyfrT70g9-
X-Proofpoint-GUID: Pl0qzJRoG-SSkWWMvsIT05EyfrT70g9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070126

Better document sysfs ABI for ADC digital filter configuration.

Change log v1 -> v2
- Split into 3 patches.
- Re-added sysfs-bus-iio-adc-ad4130 to keep filter_mode separate from filter_type.
- Removed in_voltage-voltage_filter_mode_available from sysfs-bus-iio.
- Added deprecation notes in sysfs-bus-iio-adc-ad4130 asking to use filter_type
  for new drivers and referencing sysfs-bus-iio.
- Improved commit message with explanation about use of filter type attributes.
- Dropped AD4130 specific filter_type_available options from sysfs-bus-iio.

Link to v1: https://lore.kernel.org/linux-iio/b2132bd3ca1d64cdd8d5afab1f1f33c574718b50.1732901318.git.marcelo.schmitt@analog.com/

Additional specific comments in patches 1 and 3.

Marcelo Schmitt (3):
  Documentation: ABI: IIO: Re-add sysfs-bus-iio-adc-ad4130
  Documentation: ABI: IIO: Add filter_type documentation
  Documentation: ABI: IIO: Drop AD4130 specific filter_type_available
    options

 Documentation/ABI/testing/sysfs-bus-iio       | 29 ++++------
 .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 55 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 68 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130


base-commit: 9b75dd1b7d6b98699a104c6b1eec0c8817e5fd4b
-- 
2.45.2


