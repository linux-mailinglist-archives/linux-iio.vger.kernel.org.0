Return-Path: <linux-iio+bounces-25024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D07A8BD1CC7
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 09:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 566E23487DA
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 07:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838C2EACF9;
	Mon, 13 Oct 2025 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Y/c8FD6W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899422EAB70;
	Mon, 13 Oct 2025 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340565; cv=none; b=lEVu4xM1sF6eFsDzUf+PrxDGFYymVNyINwlRUbeaeaiJiKfNTtFn+sWf/h4yDQtY8la9iZc60b4RSJZdyxT1qENwHMRfG5aaTF5bZ2LhREV9iul4dK/rbk2cWsipzcpdbb5DZ2Phzq83U+zNlx3kDkkvfGQmKzKmEB2YJ9diADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340565; c=relaxed/simple;
	bh=YsrV1v9GZv4ByAUMVgIvzqnHgkWpVSUu5ueG6hcSSCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M5u44veA3CczzERpSz3tvCnDsiFMjPUOil+ZrLKQhamoR2l2UJw7iA6SmOmnF0w7HGAe9aLU0lIYSFr02W+lPlwJ9gpaVWXBGE7GDZf241L7Y0TH6M/MLhhEivhel53GsztEVxqZT4/CpjQ3M6eMCsJpEXBF+ZUnBQwLbSDQtTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Y/c8FD6W; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D6Yihd008822;
	Mon, 13 Oct 2025 03:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zzSfE
	i9ARLQAt9rVLhDWE/raMm4btPkKu7GDhUgeG2k=; b=Y/c8FD6Wp3LZSQd+DC3I+
	Y0QTzhSlPodILiYIaQwIx3xoH1ACO29lWSNy5LNx0EK6salF2dPkLeu8DNz2v8uw
	4hYUrZST+mN0ItCsHUTJpRr/Ozd8hCnNcv8zt8ITH4SOZuvpTf5p2UZDAPVQ9YAR
	B7ZveYylgG8l1BEyUOwYpQWDHoxkslhO5qLsPJ9Q/ATiJ6DZr0D74kS3qRInwVEv
	mhvM1kQa/RtD5DIfg9dt9nEZBl25cOWVSRg+A5HI/F6skhb69zZp2k94PAPypzI/
	5sIMfq7l/wDM9dKWmLm8Cv42vkHWYyPHJx+i4PSMRgRsrd8i1Tw3i2lDLXNo4Wgq
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49r5jc52cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 03:29:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59D7T7w2062926
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Oct 2025 03:29:07 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Oct 2025 03:29:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Oct 2025 03:29:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Oct 2025 03:29:07 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59D7ShZC013800;
	Mon, 13 Oct 2025 03:29:00 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Mon, 13 Oct 2025 09:28:04 +0200
Subject: [PATCH 6/7] docs: iio: ad4062: Add IIO Events support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251013-staging-ad4062-v1-6-0f8ce7fef50c@analog.com>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
In-Reply-To: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760340523; l=3236;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=YsrV1v9GZv4ByAUMVgIvzqnHgkWpVSUu5ueG6hcSSCs=;
 b=Q+jIhe9C0PPIWq2r/f1eg4qQjyFV2mRLMoJkFUGlBmHwOKFtpLM0snIecS1I80qyaPCdgw9vK
 4wqA33J4uWGDTSMVnY6pbElHQBccnITsCbjJOPyBazy9G7LRWghN1CW
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=OdqVzxTY c=1 sm=1 tr=0 ts=68ecaa44 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=gAnH3GRIAAAA:8 a=FYPAJmQbBWBKA0HC2wsA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: IauLRs8A14fxiqJ2k_5m-t_Nf5lrMvEW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDAyNSBTYWx0ZWRfX8ZfMoL2F/9W+
 xEchNYBkzyb0/XRAcFOf87+A+dPOuRuMpER9O44QMCg5hO1AxKtx9vj9Le1lzjLKWc5sKpfTuOp
 haCsliaxQUze1CcjZZZiGfSYzw+k6hiV/X7DiO5EZKof6j3rZBTbdruRYRhUTCFUck+15Xu7fmG
 FpyoXaAwm+mlCaF1mVnNBzbGKUb6yZSeFOJcJwh62LBqsfVg5Dmw43cl1flPOjwVapwcmQHQ4Mx
 hXNUF5LfEkwfxo9uwj72WMjIim2zXaUP7VAbrlOhjOTkm89pOmgfUwffrZv6/igmazgl+wRdlz/
 7CCI9XNXrdU0NLZnM2o9aFhlxitd2SBskICEOV0DW9R7hb7wk2f2FGCvPKne+Q9Hhdy1akQwvv2
 1XkfdhhQoI35eQDw+HB0065AwxmK/g==
X-Proofpoint-GUID: IauLRs8A14fxiqJ2k_5m-t_Nf5lrMvEW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120025

Explains the IIO Events support.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4062.rst | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
index 3770740a1a9b1419cd97882a988578e514407f59..f83b2906228ca7fa076a9340a0eff94b5c102c77 100644
--- a/Documentation/iio/ad4062.rst
+++ b/Documentation/iio/ad4062.rst
@@ -26,6 +26,7 @@ at the end of the read command.
 The two programmable GPIOS are optional and have a role assigned if present in
 the devicetree:
 
+- GP0: Is assigned the role of Threshold Either signal.
 - GP1: Is assigned the role of Data Ready signal.
 
 Device attributes
@@ -60,7 +61,7 @@ Also contain the following device attributes:
      - Description
    * - ``samling_frequency``
      - Sets the sets the device internal sample rate, used in the burst
-       averaging mode.
+       averaging mode and monitor modes.
    * - ``sampling_frequency_available``
      - Lists the available device internal sample rates.
 
@@ -70,8 +71,10 @@ Interrupts
 The interrupts are mapped through the ``interrupt-names`` and ``interrupts``
 properties.
 
-The ``interrupt-names`` ``gp1`` entry sets the role of Data Ready signal.
-If it is not present, the driver fallback to enabling the same role as an
+The ``interrup-names`` ``gp0`` entry sets the role of Threshold signal, and
+entry ``gp1`` the role of Data Ready signal.
+
+If each is not present, the driver fallback to enabling the same role as an
 I3C IBI.
 
 Low-power mode
@@ -94,9 +97,42 @@ latency and internal timings, the sample rate is not configurable. The burst
 averaging mode does impact the effective sample rate, since it increases the
 internal timing to output a single sample.
 
+Threshold events
+================
+
+The ADC supports a monitoring mode to raise threshold events. The driver
+supports a single interrupt for both rising and falling readings.
+
+The feature is enabled/disabled by setting ``thresh_either_en``. During monitor
+mode, the device continuously operates in autonomous mode. Any register access
+puts the device back in configuration mode, due to this, any access disables
+monitor mode.
+
+The following event attributes are available:
+
+.. list-table:: Event attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``sampling_frequency``
+     - Frequency used in the monitoring mode, sets the device internal sample
+       rate when the mode is activated.
+   * - ``sampling_frequency_available``
+     - List of available sample rates.
+   * - ``thresh_either_en``
+     - Enable monitoring mode.
+   * - ``thresh_falling_hysteresis``
+     - Set the hysteresis value for the minimum threshold.
+   * - ``thresh_falling_value``
+     - Set the minimum threshold value.
+   * - ``thresh_rising_hysteresis``
+     - Set the hysteresis value for the maximum threshold.
+   * - ``thresh_rising_value``
+     - Set the maximum threshold value.
+
 Unimplemented features
 ======================
 
-- Monitor mode
 - Trigger mode
 - Averaging mode

-- 
2.49.0


