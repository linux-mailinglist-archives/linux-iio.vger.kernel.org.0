Return-Path: <linux-iio+bounces-17239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCE0A6D915
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 12:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E2A16E9D7
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 11:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E001A25E47B;
	Mon, 24 Mar 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vz6V5mei"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3625E460;
	Mon, 24 Mar 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815455; cv=none; b=RmFAlvc8s5cfGigB+qY9kWlJg9vl5exHxtjeulL6hWHZOGHomblW/JcxA48EoPjbZmH77rN6xirtlp2tSjTJ0bM4SpJibxUEClYtCCSXhZC5/VZA7RfKzYfPp6RRE4VmfDTlS0oSGIenAx5HAdJCEuEKjuGUp11UwGPmKnyQOPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815455; c=relaxed/simple;
	bh=9UzEzqBW9gw9lWdlQemXd+lU2ocLMuHy9xPTCkwxg30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K+PcSAPE6xuvbSMArs57SaTGbJVF0L/wKIzfMxXW0DpD6xCb43MeXpBwB8q5OtVqqYUu/TBOMW91KG7Y5wTJ7KIhdnXvItJtR+lhZm3BQGuqsHFHhKLWzmDmKGo5P/qWwibdQPthi6CRcXKrXmrUL3taDof+Lh1Dmm/gL3ijgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vz6V5mei; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OALq67000574;
	Mon, 24 Mar 2025 07:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w79Op
	49Ne7nYeSjHHfIOFFqLZo/h5XHb+PdW0x1JekU=; b=vz6V5mein/MgUZJ4D6pBu
	EKRfUQKcORfw9bNPvWS4zp0ULboEMRZ69XB6LBjJAxu1yJ2Owkj+FX6XEYwO/ELC
	fX082e7Tf3gSe+xgnBafPmXt8UOvwIBQ1cIA9OZ2mu+8VUO5uWfA1nhLz3w50Cg9
	y/5Vwegzt6OrbTeCHdg2gyVUjHrumLDvMD+Fkp1iyp+UL9bKpCIvBgyOXc4F/VB1
	s3lVdQE22UQfH7W2/j65crUYrVwaBkj4ElZXsZCO2CW+pAtwt7EIE+98Iw4yR/Y3
	ZaJWinbb8QLK+6hZq19rBZBbgNbUVLxKMZTMbgHevHHsFzFVMuTOoE3IHhOG3G2L
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45hq27ascf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:24:00 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52OBNxks052257
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Mar 2025 07:23:59 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 07:23:59 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 24 Mar 2025 07:23:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 24 Mar 2025 07:23:58 -0400
Received: from [10.0.2.15] (KPALLER2-L03.ad.analog.com [10.117.223.46])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52OBNb9i007643;
	Mon, 24 Mar 2025 07:23:49 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 24 Mar 2025 19:22:56 +0800
Subject: [PATCH v2 2/4] iio: dac: ad3530r: Add ABI file for the AD3530R DAC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250324-togreg-v2-2-f211d781923e@analog.com>
References: <20250324-togreg-v2-0-f211d781923e@analog.com>
In-Reply-To: <20250324-togreg-v2-0-f211d781923e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742815405; l=3941;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=9UzEzqBW9gw9lWdlQemXd+lU2ocLMuHy9xPTCkwxg30=;
 b=lIRb+Zc70QUY0IsCtHIW4DJU/uBGpRfM/uktrLBTpFQ5MO7yckGSBUiYcM5s5Z2OSo+SdNsa1
 kRGRdlrqWUNDP/cRd5SB3m2qDTq8JY09Y2i+q3mzfSje91QVRhSpxm4
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8v7CHXQGqXX-AdYQ0Jev8cw64D2Ltucz
X-Proofpoint-GUID: 8v7CHXQGqXX-AdYQ0Jev8cw64D2Ltucz
X-Authority-Analysis: v=2.4 cv=DoZW+H/+ c=1 sm=1 tr=0 ts=67e140d0 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=lV79kfigjcqFRbs2SJUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=846
 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240082

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


