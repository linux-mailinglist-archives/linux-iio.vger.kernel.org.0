Return-Path: <linux-iio+bounces-24257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E629EB863A9
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53571CC39E6
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 17:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923A12EDD6D;
	Thu, 18 Sep 2025 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HCZ3ZyR1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926D2BDC3F;
	Thu, 18 Sep 2025 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216862; cv=none; b=GmvLFyRgQ0EY2UkezoSEqzULCY9nJZNO/jFPT84+uz38RN+hiAC7iBqphpX3sQgv8+gK75vbb2WiDOtWwnt/hTUunEUvbUrg389nc0fLoa1T58wGYgaaABLYTvZq7cgmB1pVCljMtn8Fvw59zvY3/+BZZpTLAC90ntd0MuOh2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216862; c=relaxed/simple;
	bh=UV8W3SUxTUAtn4/rLOZTrj2aaONIvsNe/S4eKLHPzFw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D2hgkC1fIVW8/9/xlwWD9zJ0KDCATme9ALDwfH+qEe7p0T17oFkTtuNgpboGROvdBG0Jigwb0FecbE7u8Syhp8STRMqC+x9AWMOj+Gh01HSy5Ymds8Wm4zF71zsdSBBvg86NYtV7ZBbnGLzjVLpq9lcnhbtne1M3KVzoQ4NAkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HCZ3ZyR1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFrCxK020630;
	Thu, 18 Sep 2025 13:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Z3yMZw/9FoxscjjuDKtLJN8o2nI
	6AP3ngcyXtiLnNt0=; b=HCZ3ZyR1I6EtP/U40FK7BWfrIwP7mrJfJlEff7IB74a
	esttdIYFpcR0a0DKqrLZHaKz7yp9jjAk8xnxvw48+iBu1zsw2HN3KdJI7VnAyxa9
	abIcitTUAMDj5hyJ/hPumkgTTymgOhZkb5N5cFFuzNCHmVjySRBYwOMsyHvu1WIr
	7g9tZgKgVet+SjjUdH1/RQll3b1/a1gR5RBnWaIuPuMwgvrZa/bJlt2/t8t5w0tQ
	I/9Pwfcm/CYFoqho65jW/h78fvtI5rRo5YAQyhJMh6bpXkzQOplUamInaMCxbenu
	ZCPg7NAripqotmThW0afEBjtSaO9XwH76aeefHbf6hQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 497fy1mf4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 13:34:03 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 58IHY2Kr061650
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Sep 2025 13:34:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 18 Sep
 2025 13:34:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 13:34:02 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58IHXnVk021963;
	Thu, 18 Sep 2025 13:33:52 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <broonie@kernel.org>, <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dlechner@baylibre.com>, <ahaslam@baylibre.com>, <andy@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 0/2] Add SPI offload trigger offset
Date: Thu, 18 Sep 2025 14:33:49 -0300
Message-ID: <cover.1758206554.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: y9Q0_FIWMT_5FiPPEjUpWSMT0HY2lwZO
X-Proofpoint-GUID: y9Q0_FIWMT_5FiPPEjUpWSMT0HY2lwZO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwP//7SQ/t9lJ
 EVhJYn602dwkTy3S6Ym3+2kOhijypDzP0FtE6VqXaoXQ63YQl1a3FWuSUTomsVt/PyVL4rmw7kJ
 Y9aQslqYc9REItpidipieVPBgq9iBNxpOjpXF3RWN33ofH/UzwzVd2Rev43p36SuMsSz48CfUlU
 0BVqRIARLqhRC2mN5xj1aP9NmI+q9M/rnI0iAixqe/VBohsp6RGtk3hB0lBD6QHQ3hF8RqTO4Pg
 dhrEQNVW++shWwt6iGVV6TsdWsexFISoNr9j2HIsmZ9M0xHImXUffsADLbSayolXS1juOGK7PfT
 irkpEzcBKfjDvFZ/l4lXoe54il1aKgTDqeJDvr/ZEb+NFtX0bgPXJzAde5VpZs9VeRYR4pL0189
 ggWD5aHQ
X-Authority-Analysis: v=2.4 cv=acVhnQot c=1 sm=1 tr=0 ts=68cc428b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=2m_82NOn16k-Eq0OAzwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

This was initially proposed as part of a patch set to a driver in the IIO
subsystem [1].

The changes to code in the SPI subsystem are minimal. From that first version
to this one, the changes are:

Change log v1 -> v2
[SPI]
- Using upper case: adc -> ADC.
- Codestyle/readability improvements according to suggestions.

The updates to the ADC driver that use these changes proposed to the SPI
subsystem will go in a patch set titled 'Add SPI offload support to AD4030'.


[1] https://lore.kernel.org/linux-iio/cover.1756511030.git.marcelo.schmitt@analog.com/

Best regards,
Marcelo


Axel Haslam (2):
  spi: offload: types: add offset parameter
  spi: spi-offload-trigger-pwm: Use duty offset

 drivers/spi/spi-offload-trigger-pwm.c | 3 +++
 include/linux/spi/offload/types.h     | 1 +
 2 files changed, 4 insertions(+)


base-commit: e27fcbde216b317fecfd4487ffcd7f81726ac8ea
-- 
2.50.1


