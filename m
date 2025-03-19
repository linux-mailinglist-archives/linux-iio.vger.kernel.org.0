Return-Path: <linux-iio+bounces-17073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB1AA683F2
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 04:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8023B8619
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 03:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D19A24FC1A;
	Wed, 19 Mar 2025 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xCLnRGI5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A611F24EF78;
	Wed, 19 Mar 2025 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742356146; cv=none; b=hQlWYE50Xk6jmaUfEU3gZHEAdtuklqYF4lVxNcwQy+ghsKakz7uZYQYzCOaprfMh/T6Jubggq09NbC2n4sG0tmxtIQB1Bjz/j5kC8s72X8ihaKyTsP1uCCb0N8F9N+JZmHm18p5Acc0kVHJcl1k65bYf4BSHGs+iTrTOA/rZCjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742356146; c=relaxed/simple;
	bh=9UzEzqBW9gw9lWdlQemXd+lU2ocLMuHy9xPTCkwxg30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WMR4YGuZ1cM3vYk1WEz3YSkPGTBmUOYbWRRHemdsemYFPyezL0GkbUMiy1qHnY7nYEB4eD7ArdmP4dPu0H7GAg471vJcGpOkKqQb5r48QWL48HTZuuMqMIpT5OyV6CBH/RT/udEjxbkS/AKTsRaiGFDWV5S+FOYhVBZGykUQpsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xCLnRGI5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J0FsKb032650;
	Tue, 18 Mar 2025 23:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w79Op
	49Ne7nYeSjHHfIOFFqLZo/h5XHb+PdW0x1JekU=; b=xCLnRGI5WD+NvLJJQTN2F
	0mTaEYAXqicFEfz3BUn3QJcF+M23pkZEYT7RLBFjAeT9jSGSaZluUE8NLiMLSoFh
	nNefOIH/GByO2QvkinUqwfra96h6gu0Ze21gnwe+M8UxrpjRD7/Dw4RsCYbb5oT6
	3QW17D/821S/DUht6kS2YDoSZtr13gHUCic7KGNbASHWjQQBxvEeRB0gfpD+nEet
	C6a0b7jEkF6QKlBeg8r4DlXNx5uB90++1Ir4lRfwSAqjvETcRYQCgsvatAtmHujZ
	rZ7n2YK/uI9Sr76GwBeQr1+hrF0YgXCqZ2uPi7HcAxtcS0NgKzVrMDK99gZW0IO6
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45fk7wguw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 23:48:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52J3mdd1013792
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Mar 2025 23:48:39 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Mar 2025 23:48:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Mar 2025 23:48:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Mar 2025 23:48:38 -0400
Received: from [10.0.2.15] (KPALLER2-L03.ad.analog.com [10.116.18.50])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52J3mIC2005894;
	Tue, 18 Mar 2025 23:48:30 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Wed, 19 Mar 2025 11:47:56 +0800
Subject: [PATCH 2/4] iio: dac: ad3530r: Add ABI file for the AD3530R DAC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250319-togreg-v1-2-d8244a502f2c@analog.com>
References: <20250319-togreg-v1-0-d8244a502f2c@analog.com>
In-Reply-To: <20250319-togreg-v1-0-d8244a502f2c@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742356088; l=3941;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=9UzEzqBW9gw9lWdlQemXd+lU2ocLMuHy9xPTCkwxg30=;
 b=t6o+R+FwHAZs9l7jIkH5Ma8aS004veVBE4aXsp6mMbnizEsvYgGUT/HunVfgZWpbVmfEc7Hmu
 2/HrHGsqRnIB+mYg3cNCw1/0P9CQGlsYzDWc0WjiR8tKpy27LeE/KFi
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=YqIPR5YX c=1 sm=1 tr=0 ts=67da3e98 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=lV79kfigjcqFRbs2SJUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NuptqjGnxa69p1gOzLv9Fv__sXFDhuh0
X-Proofpoint-ORIG-GUID: NuptqjGnxa69p1gOzLv9Fv__sXFDhuh0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=833 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190023

Define muxout_select and muxout_select_available sysfs interface for the
AD3530R and AD3531R DAC.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-dac-ad3530r          | 68 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 +++
 2 files changed, 75 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ad3530r b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad3530r
new file mode 100644
index 0000000000000000000000000000000000000000..9d3126952fd1c5214afb895c4972dc4a891ed7d4
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad3530r
@@ -0,0 +1,68 @@
+What:		/sys/bus/iio/devices/iio:deviceX/muxout_select
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Selects which of the multiplexer's input signals will be
+		monitored on the MUX_OUT pin.
+		* powered_down - MUX_OUT pin is powered down. An 80kΩ impedance
+				 can be seen at the MUX_OUT pin.
+		* vout0 - Voltage representation of VOUT0.
+		* iout0_source - Voltage representation of IOUT0 (source mode).
+		* iout0_sink - Voltage representation of IOUT0 (sink mode).
+		* vout1 - Voltage representation of VOUT1.
+		* iout1_source - Voltage representation of IOUT1 (source mode).
+		* iout1_sink - Voltage representation of IOUT1 (sink mode).
+		* vout2 - Voltage representation of VOUT2.
+		* iout2_source - Voltage representation of IOUT2 (source mode).
+		* iout2_sink - Voltage representation of IOUT2 (sink mode).
+		* vout3 - Voltage representation of VOUT3
+		* iout3_source - Voltage representation of IOUT3 (source mode).
+		* iout3_sink - Voltage representation of IOUT3 (sink mode).
+		* vout4 - Voltage representation of VOUT4.
+		* iout4_source - Voltage representation of IOUT4 (source mode).
+		* iout4_sink - Voltage representation of IOUT4 (sink mode).
+		* vout5 - Voltage representation of VOUT5.
+		* iout5_source - Voltage representation of IOUT5 (source mode).
+		* iout5_sink - Voltage representation of IOUT5 (sink mode).
+		* vout6 - Voltage representation of VOUT6.
+		* iout6_source - Voltage representation of IOUT6 (source mode).
+		* iout6_sink - Voltage representation of IOUT6 (sink mode).
+		* vout7 - Voltage representation of VOUT7.
+		* iout7_source - Voltage representation of IOUT7 (source mode).
+		* iout7_sink - Voltage representation of IOUT7 (sink mode).
+		* die_temp - Voltage representation of internal die temperature.
+		* agnd - MUX_OUT pin internally tied to AGND.
+
+What:		/sys/bus/iio/devices/iio:deviceX/muxout_select_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading this returns the valid values that can be written to the
+		muxout_select attribute:
+		* powered_down
+		* vout0
+		* iout0_source
+		* iout0_sink
+		* vout1
+		* iout1_source
+		* iout1_sink
+		* vout2
+		* iout2_source
+		* iout2_sink
+		* vout3
+		* iout3_source
+		* iout3_sink
+		* vout4
+		* iout4_source
+		* iout4_sink
+		* vout5
+		* iout5_source
+		* iout5_sink
+		* vout6
+		* iout6_source
+		* iout6_sink
+		* vout7
+		* iout7_source
+		* iout7_sink
+		* die_temp
+		* agnd
diff --git a/MAINTAINERS b/MAINTAINERS
index ffdb3f21fc4fb35b349449afbb30fecd4fe72978..2d3c31c74594ca1934c67e7aad0a179feeaa39bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1289,6 +1289,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
 F:	drivers/net/amt.c
 
+ANALOG DEVICES INC AD3530R DRIVER
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ad3530r
+
 ANALOG DEVICES INC AD3552R DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.34.1


