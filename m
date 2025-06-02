Return-Path: <linux-iio+bounces-20143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA80DACAF55
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 15:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F3D1653C9
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 13:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBFC221F00;
	Mon,  2 Jun 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FCdGcOro"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D9221737;
	Mon,  2 Jun 2025 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871924; cv=none; b=QLzHwdf8TjpWvE+5YjCcm14LO6X1j3pOtxsp9flDijWR9EF80D9jTZ3d3E2/c609YlInI4Ei2gWfQ9lzrLGUu6DTJLNx2+7vnv13gpPVojZ8zERTCR3uQctpCPrUDv/himgm1C6ZnK+kllUdEm5filt5d+/+GHGuQjiHdL13rpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871924; c=relaxed/simple;
	bh=Y/ENBTBOKjiGoUjmrtbJTOgN9tjKqiHLG1bf4VOj//U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inFgC7od4ru8Cn/BPDMyT0AXAfOObXvHtnouz1I4/h+WF5lJ1xvV0J7gRLXieL7jxU1ArWGuu7uZSUmmx2z7e0vc6VuI46vzWdfh9VtxO20HE9l1qoNuvD40d0Ut8qqjIw74KGLSkXY6UZafWEuTeqPIl7iZuHPcGXqhCbwj0I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FCdGcOro; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552BcuxP020787;
	Mon, 2 Jun 2025 09:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Yeruw
	6pyYIyxlgDjhqp+GYhfyQLjwkBjZoFzxoGcI7g=; b=FCdGcOroHd71JMdamC/N4
	sEz6I7EFsNeUTdiL2Pvjgsa3GgnILnQB/Rv0tHxNzNZzlhME5/jgh0VXgW4uyq0B
	+MH7Rts68zuhE/KgLF+oWw19D8VZWpT9TpMD8OlTVbnl4ZfkcR3dRUupeHTu8wqy
	hkKmYX+WNb2U9FLs55b/Jbi6VgD2pQ5sPA7NAgQpR/OOZIQXiQjaCqxESq2VUcMr
	LZUqFlymAYnVxWWW30KwxAFA+GTCZ5xRGK4iku89WQFkMBesPrTA240QtmKlGW2e
	2ejZrIGardsmL6Xi1UWOK8EILOlCHUjQicCRtfTUX6WEMpRE8/DGuOA2OnZZSiVb
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46yxp57u24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 09:44:59 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 552DiwlE036976
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Jun 2025 09:44:58 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 09:44:58 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 09:44:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Jun 2025 09:44:58 -0400
Received: from romlx5.adlk.analog.com ([10.48.65.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 552DiSJM010531;
	Mon, 2 Jun 2025 09:44:50 -0400
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
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
        Trevor Gamblin <tgamblin@baylibre.com>,
        Herve Codina
	<herve.codina@bootlin.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/5] iio: adc: ad4851: ad4851_set_oversampling_ratio parameters update
Date: Mon, 2 Jun 2025 16:43:39 +0300
Message-ID: <20250602134349.1930891-2-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
References: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=HdIUTjE8 c=1 sm=1 tr=0 ts=683daadb cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=r0u9AmH2YJ65VWHPuukA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDExMSBTYWx0ZWRfX2DxwX6cUH9SH
 lP3Cfl3EFCqykJ5VXuisVhTmhoIdpHPewQsWX+HKZ339zM9Brvz0xQFGHR1Q7fjccM3wEihwYt1
 dtPabvP3XW+qD1WC+N/TL+QUjV8Usry/pKB0e3TxBGCKi1DMg8tFBIKE143jUmU2YfmHn8pyR6R
 aPU6jDsa/7fclzgOJe1OLgExAIjtUhAk1U0t8Qy4uKifsGSAnOYkS3RNufjaJ0ttFKb8Nd1mjyU
 xMGpCZ2zJ1JTgDZt84kIcfI6rTjKMgABkIRznUlHU0DmSLTcWMvmxMEHGwCAqatI5ipuAJiKtxI
 Ab2n2stipLOXAYbdaWl4nAnNM1BVVhJX3rMjaF8gqq+Ai8oAm7v8K2NDsiXiy5a2ktQgLy7RZ+/
 A3xubbOecmP+cwl3F/UpYoGE1+QmLLffpaFJtPo4NJjENbgSIYW5vqCnPB3xQmE74UKHITnM
X-Proofpoint-ORIG-GUID: poxK0ldYnsgIZxBesTSzFLBxkJrJq5g8
X-Proofpoint-GUID: poxK0ldYnsgIZxBesTSzFLBxkJrJq5g8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2506020111

Remove chan parameter from ad4851_set_oversampling_ratio parameters
list because the parameter is not used.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v5:
 - update commit message.
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


