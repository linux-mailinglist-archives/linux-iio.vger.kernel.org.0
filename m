Return-Path: <linux-iio+bounces-20209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D598ACDF4D
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 15:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854271899C35
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD2233DF;
	Wed,  4 Jun 2025 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cuufOvGN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CB41E411C;
	Wed,  4 Jun 2025 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044199; cv=none; b=tuEjW1YIsqRjgfnH3JqX1zfbb22Miy3h9M95g4yJ2uI0Mr0ZIFc2NwpI4O0n4as2KVdDqkPRklanXtFL6u3WjriBzjn/mqlejZRGvTVwJ0dbNMtGPWY4oo/VW/7RBWg1lwR8+P2LaZrmfx0n0vh5wVmnWcBGAARnoh3fPzdVuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044199; c=relaxed/simple;
	bh=LjIYXPHD1emI9FEWude80itp7UFfioaOXAfLHYaQFQ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xhnscen0VElx2AquCNWt+Hx5bRBgL8OHTlqp645wRwmdLAhAhvRNb8IBu35uXlRaMmoBsL5mqGBYjFOCWjjubveUUdguYiM5AswR5PP5lsU0Fxm9sQ5U2E+EDUowOayt/HnmT0xPMIgyxmgv8tggwGK3FH+qipyBpjVc4Ms5BpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cuufOvGN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554CLYNx030454;
	Wed, 4 Jun 2025 09:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tofbD
	U0TxVED6wHZNiaQAWcBgw8svPQ+Y8Cusi2jr0A=; b=cuufOvGN+Zrq6D7cia6ZH
	OopcUnMzjgX82CDR2lN8WGmmGqMxpE9P4S9M2penvfcUrX3hsSDUjPf+WMdzu/On
	Jk8HF7hVxj8ouxZ0qf6uk7NTuyjFm1/eOjdlsW4pmAVZiggCb2pdSqbSddUfGN8Q
	ycYuq+CF50bldbKahfIzKQubX9G60epwP9dIZo+UAXrjp3GtdJFFP1PT+8yXrhDN
	o5Cuth7VnPwh7P92xXjuND7f+50yCiN5aC2nbSflj4MBFoRtcGLRLKjXymQZfmDn
	Xnkb411W/Jp6TH8scsuz6SUT6WnGGwKPC1j8fv6M7bHTKOdH8FzLV7ysaiToMaT/
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 472p2vgcj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:35:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 554DZ5nW030268
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 09:35:05 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 09:35:05 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 09:35:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 09:35:05 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554DYVPX029277;
	Wed, 4 Jun 2025 09:34:55 -0400
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
        Trevor Gamblin <tgamblin@baylibre.com>,
        "Ramona
 Alexandra Nechita" <ramona.nechita@analog.com>,
        Ioan Daniel
	<pop.ioan-daniel@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/5] iio: adc: ad4851: ad4851_set_oversampling_ratio parameters update
Date: Wed, 4 Jun 2025 16:34:03 +0300
Message-ID: <20250604133413.1528693-2-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
References: <20250604133413.1528693-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwMyBTYWx0ZWRfXwQlLLF4+veXt
 66McX7qK6oVBwGp6SLzMpkksrycE05YmyprTGGOWVunyAqZNaPiWCBUe3/i02Th7NBU3Id872sX
 0rzbyL1XKFTO17pfSWmOl/UyEQj4eIwf6UUHM9manCN0PemGYplbmCCDddiejQR3UxxL2O5EpXI
 P3LQ5oQisVzQD/nKfZV6tI4vJIr4DUP70K/bM6pjtR8EEzCY0muXWIH0xdXDXNWc9GW8shkGLPq
 t5V/Mz+hYR81rq/vVNtHlrsk562fRHCOXcghr965kTx6yDba8bC3ubwTS2Nc4iBOIjTCu5HvA1m
 /dKBgE3s7JRljFgFFUQdkqjIANeqSgeBnCncD1zSj5HpD59tTo7nsgdDXc6lMB1YUBgkpEly4/1
 5UqDvc9QxWuUOqj4h9i6UlscIREPK2XulJdjP1id8zNNsh7no6UzbEYzlm7nFEnaznYuxeaa
X-Proofpoint-GUID: tFdR-BrqqW3UL6uswQuvSc9fkLHUf3ja
X-Proofpoint-ORIG-GUID: tFdR-BrqqW3UL6uswQuvSc9fkLHUf3ja
X-Authority-Analysis: v=2.4 cv=CdgI5Krl c=1 sm=1 tr=0 ts=68404b8a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=r0u9AmH2YJ65VWHPuukA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040103

Remove chan parameter from ad4851_set_oversampling_ratio parameters
list because the parameter is not used.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
no changes in v6.
 drivers/iio/adc/ad4851.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
index 98ebc853db79..12f90aa3a156 100644
--- a/drivers/iio/adc/ad4851.c
+++ b/drivers/iio/adc/ad4851.c
@@ -294,7 +294,6 @@ static int ad4851_scale_fill(struct iio_dev *indio_dev)
 }
 
 static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
-					 const struct iio_chan_spec *chan,
 					 unsigned int osr)
 {
 	struct ad4851_state *st = iio_priv(indio_dev);
@@ -831,7 +830,7 @@ static int ad4851_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return ad4851_set_calibbias(st, chan->channel, val);
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		return ad4851_set_oversampling_ratio(indio_dev, chan, val);
+		return ad4851_set_oversampling_ratio(indio_dev, val);
 	default:
 		return -EINVAL;
 	}
-- 
2.34.1


