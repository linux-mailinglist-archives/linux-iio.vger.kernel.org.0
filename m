Return-Path: <linux-iio+bounces-20145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9764ACAF5D
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 15:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9544316CE1C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398FE221DB6;
	Mon,  2 Jun 2025 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="whK0nOkm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7878421CA07;
	Mon,  2 Jun 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871942; cv=none; b=oYt+8JRbUI/8nNeLJnUMw2KKs20tEtkA23ax434QWPq3YTmrAfQu7h1/yYswPPUoiw88ngeCBlylM+4VfZiXuJQ30J2sWZpjmShmoTf/7ChjTw9H1iSYKirgSvXXbQXcSmNSw4rzzkH4tZd5RpOgoGubO1/XTVpvCMcQt48dNtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871942; c=relaxed/simple;
	bh=aZ6KDPpqQd6PIKhfm5iFPTZOyMtFZAgy4KblWmjg+Xo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3EJL09wyJuhj73G4zF9jEPb8fVUzontc2CHJyI2WsSH6z/RHG4/v2+/rlmwYL0/GCFW75qQqT93ZQN3Hxmy7D3PCAAId36/mXcsjUkLhk8eBUKvJg3qCq/0yo3c2VRt+dqHACE+Fzr13rHaEa5NzLYtyMMjCXStBvkDgZFxPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=whK0nOkm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552B5jCN008126;
	Mon, 2 Jun 2025 09:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Z4HrS
	sobTkq/aAUiiSqlgZFrfwt6tgiQ8W9QyDIklOs=; b=whK0nOkmQq7kb6iNBGXgo
	3TSp/1r52jkQ8ZkdU4qHOWamVeSG1Qxh+JUslwHPZPj5rJUktuGxR2xN1lgo7i2R
	TM+k8+jZXrbDKNdkHGQFwGK4vo1GrD4mW9Cf/b/adWzar4AEvO+2tfQRXng3kY9K
	zZx2f7bGNdR07X/UKvsFnNBnlOlQpe6xr5x5/Wf+rmfffLWRYOMlSrY2gutzVD3Y
	FzcyJSpbSR55NGnXghlKm2lj1ugFstuz84bTAlrx1f8IZTu1/2FCMgEPxGKvz8+C
	k7LGmCFHogAyB+3sL6dWNqHXVdRBjyhz1FeZXNy6akYrCAjQ6by3NFIXM9LfsiGO
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47133mjk0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 09:45:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 552DjIkw037026
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Jun 2025 09:45:18 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 09:45:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 09:45:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Jun 2025 09:45:17 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 552DiSJO010531;
	Mon, 2 Jun 2025 09:45:08 -0400
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        "Dragos Bogdan" <dragos.bogdan@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/5] iio: adc: adi-axi-adc: add axi_adc_oversampling_ratio_set
Date: Mon, 2 Jun 2025 16:43:41 +0300
Message-ID: <20250602134349.1930891-4-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
References: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: LX0BGHtD_INlSlL4BNcyd5uTw8lLOX3a
X-Proofpoint-ORIG-GUID: LX0BGHtD_INlSlL4BNcyd5uTw8lLOX3a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDExMSBTYWx0ZWRfX3W4Dc6ad2Xb8
 a6ikvWYgmDUe/LJ0R7y02dx7Aor0p/hCYrdPp3mZ33sOUGfsQjcB6z5gg3O2BdtWX/KPg25BQ4v
 QFdDRK/tpY5UeVO791SxnNSnBGuXXpL8DjMVJiJzLeAHk6TJccdpJa8JBVyQQU9u/xjy1EQiswz
 1q2KJBWWBrdIAwiiJ+ZVk+uWopo1bacHkuVgKTe8/tk18CLR3KDCKumImUf0tTs8XV+ctCc9lcy
 S7s+bjG0CCGNh4xpRoHOHmXni2+1d/be2xJjVwz3+eWPelKKFOf/rTtSCe6s1q25vrp+bGKqDM2
 qhr6FLYiwpfcuOXuJ31cZVoZHB6UNNs3LlQLn9vGZUZiKdCg2Bq1SbeFxRq9VIhW6s/26CVSWh1
 YiwfRdNei4G0o+DSZ0xHkXDV9eZk8nKBc1fKnSrBvN+Ve9dJ1lUwbnl05xuFyLQtw6+Rq8Jr
X-Authority-Analysis: v=2.4 cv=DY4XqutW c=1 sm=1 tr=0 ts=683daaef cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=YaUefwTmmUCeskgydjwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2506020111

Add support for setting decimation rate.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v5:
 - move change from axi_adc_ad485x_oversampling_ratio_set function in the
   previous patch.
 drivers/iio/adc/adi-axi-adc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 9e8c30230791..0b8673668745 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -80,6 +80,9 @@
 #define ADI_AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
 #define   ADI_AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
 
+#define ADI_AXI_ADC_REG_CHAN_USR_CTRL_2(c)	(0x0424 + (c) * 0x40)
+#define   ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK		GENMASK(15, 0)
+
 /* IO Delays */
 #define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
 #define   AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
@@ -242,6 +245,19 @@ static int axi_adc_test_pattern_set(struct iio_backend *back,
 	}
 }
 
+static int axi_adc_oversampling_ratio_set(struct iio_backend *back,
+					  unsigned int chan,
+					  unsigned int rate)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_update_bits(st->regmap,
+				  ADI_AXI_ADC_REG_CHAN_USR_CTRL_2(chan),
+				  ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK,
+				  FIELD_PREP(ADI_AXI_ADC_CHAN_USR_CTRL_2_DEC_RATE_N_MASK,
+					     rate));
+}
+
 static int axi_adc_read_chan_status(struct adi_axi_adc_state *st, unsigned int chan,
 				    unsigned int *status)
 {
@@ -550,6 +566,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
+	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.34.1


