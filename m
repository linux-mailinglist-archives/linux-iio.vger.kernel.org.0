Return-Path: <linux-iio+bounces-23291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2490CB3577F
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 10:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A8D684DBE
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B497D28D8ED;
	Tue, 26 Aug 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RglVfoaL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52E1C3027;
	Tue, 26 Aug 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197946; cv=none; b=pr5wWOrt99bfPcaPFk4Pzn5vHYIbHm4Qyz7VCmFyMPzkR7l8ByQhnv6xjyuK/ln2T8KiI6XPHIVLjp2SQLxG/9X7EiQDDf+FNjbH8BlcD7zX1HD1NzRyyGNX0EPxRVr+ut7SBUI4hRVnkxNWq5x3EsuvutlIxEM8ZVxr8tcZK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197946; c=relaxed/simple;
	bh=H1byxbMcLuphpd9uBFkWbWvGEfjeREsyK1Dw90T6QIg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K+rvs+qRn0SnMDJ8uRjpjDgkSrbibSmeQsOGLEWv9mv7LhXIGkqd/8r60itJIb4n8h0EQuYqJ19wqfB0DAItrdQHXzIQHASxnbPauNr+q8h0n4aXK7iW36PFwHmoQ1tGz77sS/i55sBt0/jVZftzzB8q8tEivUsptOADxqXzZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RglVfoaL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q848Hm010646;
	Tue, 26 Aug 2025 04:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=epZOg/VhgPlBFYnmCsaGUiodeBi
	hqqJVIPku182Rk3Y=; b=RglVfoaLMQf0EoUW3QHvO6lVbnng45KRBT4KSX+LXcV
	0c+xjh2YA/xJYnp7p3U3vJGoxedGaw3YwmFpwXB0zsVCXBv5TuBVTe7QM8oUV3Qj
	kQzpQ3yHheukJeQAYx3dqqF/yVTdIo6G3Lc1XFpNgYGUusYP9URVk6HO//cCUhKB
	nl4+M3QzrZoOcW86aqKd3FV74W06mq8OL6vZK+ox10ys7IaYj+GvsMex+CPMvR4N
	srSCmIqG9FFgXaJUJMvW6Q6+QUod+eS93+bhgA2xarIVGvbRnJmU6PQx89O44vun
	h73AfWYI/jQ9AnIFwDPWNDzGlnXQ1UwyoAjQaQatMSg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48quyf29h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 04:45:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57Q8jSuM018624
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Aug 2025 04:45:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 26 Aug
 2025 04:45:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 26 Aug 2025 04:45:28 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.166])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57Q8jHnu015527;
	Tue, 26 Aug 2025 04:45:20 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Ramona Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>
Subject: [PATCH v6 0/4] Add IIO backend support for AD7779
Date: Tue, 26 Aug 2025 01:13:48 +0300
Message-ID: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4wGFVOVBmJRsUCE4mFltY3KHKfKPgAWb
X-Authority-Analysis: v=2.4 cv=DLSP4zNb c=1 sm=1 tr=0 ts=68ad7429 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=nAsWaW9lDWL_MRO3WFIA:9
X-Proofpoint-GUID: 4wGFVOVBmJRsUCE4mFltY3KHKfKPgAWb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDA0MiBTYWx0ZWRfX6j2lDfZ88MDN
 6pap7JIZD+fls5hnNStKhiIQOLcqALRrX35NnVVlRbzOX9DqSGK6g5hH9Z6fgqIvkxdb0gnXd3I
 xoZCQYDbyEQazM7MA1afu45z7dEL4uMJ6wYHjx/xju73HAgAbbFTrt6RU+JdjBp2SYbsWK2hFqs
 uWeX5hP3GwKi7FV7ai/8vwcNEQlkONRT25mx6xkwaAIdNt1BhK9qVQmlDKbvCuC5Q8z6jOZGfsh
 Y4/f2lJTz1XLEwhydgTI+9THxUWtxFj9eZoH91BEJ3DrpXdkk+3T9sbXdZf1oIT08Kmy2qHw+q1
 nXjbQHWxzfmtb2tYAP8fke3vaxGtokp41GpupdRARm69T0j3eIV54Md0xLXMlO5M7GiyIoU4Qr2
 N6eMKSJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508240042

  - Add axi_adc_num_lanes_set in the adi_axi_adc_ops structure to support
  setting number of lanes used by AXI ADC.
  - Add the generic io-backends property to the AD7779 binding to enable
  support for the IIO backend framework.
  - Add the adi,num-lanes property to set the number of lanes used by
  AD7779.
  - Move the initialization specific to communication without iio-backend
  into a separate setup function.
  - Add a new functionality to ad7779 driver that streams data through data
  output interface using IIO backend interface.

Ioana Risteiu (4):
  iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
  dt-bindings: iio: adc: add IIO backend support
  iio: adc: extract setup function without backend
  iio: adc: update ad7779 to use IIO backend

 .../bindings/iio/adc/adi,ad7779.yaml          |  44 +++-
 drivers/iio/adc/ad7779.c                      | 192 ++++++++++++++----
 drivers/iio/adc/adi-axi-adc.c                 |   1 +
 3 files changed, 196 insertions(+), 41 deletions(-)

-- 
2.47.2


