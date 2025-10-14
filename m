Return-Path: <linux-iio+bounces-25075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FA7BDBA09
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 00:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88140189BE48
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 22:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813D330DD23;
	Tue, 14 Oct 2025 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kLdoF998"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D237830DD08;
	Tue, 14 Oct 2025 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480540; cv=none; b=qndasD2VAyFOOrm7NZn++5rlRnT4MKO+XRG+b1eN/PjX/+dh6+QPMyl3+rnfE00EUvEyBlM4uhd6bECrcBkQsRsLIgrktqkZyscR4b9EzohMqacnW9QDMhD/pfGmJiXsrQB6zaTD2p0iiOXux+WYpn2B/NKWBgHhicdWo+v93/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480540; c=relaxed/simple;
	bh=ZOJXlfsfVxJTguGRwIyBrAg8MqZ0wAQgxBl2uSeInXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFPbatZQFUMrL1jETg+5DxHoJHbSfIwhfFcLAsP57ua+mx3FPWh7AbSg9JCugfdlI9jxZ+xG3bsbW79stpiraLdCx59oGfole+DmOtpFE+NmI5w9/CaDo117oeDqbvorVoPodYxQk6dA85PcCQAvnieA+5DQ0BScrCqAu2W2p7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kLdoF998; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EJ6iTl008597;
	Tue, 14 Oct 2025 18:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4m0Cl
	nXe/fyz6rYlHrdMykmJwSxMKyWpBGHQnbxEM6U=; b=kLdoF9987aVEj83ynR0JL
	4se7qsurLk7bLlxuR9CgOfmCJ4IkDOnA7tWrBh8GG9krSVuGJIzu5Wh3TfTjdHau
	RdOzO8ppVrjVIY9Zotref3mG5XYF5ClhC5jjLzVA0pBi13ADn9m91/y56x70Inyl
	9Ll7F9I2WMLasNz6UupFJlUDQBs5yQcLCiKWYitFdeYzCL1+cdnhZriQ3NvIeTdL
	NpKBr9Pl/FTMXyRg7FM5QqxtHz9ac/Hd3rUlXh1E4B7NwaiQ0sU0a54AeJCTbniv
	3VbQI2118RUj7tL7KYXBBwlUKACwFAJpTzHSupCjiPD509mqpOW1npeTC2ArSMKH
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49qm50krak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 18:22:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59EMMCqg042822
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 18:22:12 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 14 Oct
 2025 18:22:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 14 Oct 2025 18:22:12 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59EMLw5K005510;
	Tue, 14 Oct 2025 18:22:01 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>
Subject: [PATCH v5 4/7] iio: adc: ad4030: Use BIT macro to improve code readability
Date: Tue, 14 Oct 2025 19:21:58 -0300
Message-ID: <ec78fd7e4348e2cbc99ae08004c48b7ea238ecf7.1760479760.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1760479760.git.marcelo.schmitt@analog.com>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=cJ7tc1eN c=1 sm=1 tr=0 ts=68eecd15 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=gAnH3GRIAAAA:8 a=HwBGVG7bte8kWS4IyKsA:9 a=br55WurUj89AL1qEz8Q6:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDA0NyBTYWx0ZWRfXwfiKn1k/HshL
 Ix6Lfxtb84VV40YiMEnlppdVXptq5JblQOkEYtF4XzdusZFkvWdr1/CLgN8pIHhKjiZxl0hc4Np
 pBWh5vBM8eYPBK59/RDnhReYYVMbMMf7I3rfDw2KNsC7A+JCh18G7OSlN0lOGwv/QUc4ugiquyE
 jW7VkGcUaZy83imtjCOlWFX12+EpUX3O3m4vcPWmb3H8nZ+GYKimBHRgQT0V74AmWojXqcuVpN3
 phQaqdPfyzslD4dMRbdy+eWYQvVeQHC8RFGRrPcvA8R/ZpN+lYW/M+rs2sgwsqdUCg4OixX7Lm+
 pyiAtgATa66WinW7RgsQHbgcYsLVH7v6/EiQE6aR4KoCow6K0Xv1uuhqsc6ZLOwZjSSfZ44vOx4
 5vgPrfyu2JDBGTlaS2PIgjQY7eoE0w==
X-Proofpoint-GUID: 2xDFQqunkPRnCj8PwEmi1QiIUKvIogjr
X-Proofpoint-ORIG-GUID: 2xDFQqunkPRnCj8PwEmi1QiIUKvIogjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110047

Use BIT macro to make the list of average modes more readable.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/linux-iio/CAHp75Vfu-C3Hd0ZXTj4rxEgRe_O84cfo6jiRCPFxZJnYrvROWQ@mail.gmail.com/
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4030.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 4393160c7c77..b2847fd90271 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -233,9 +233,11 @@ struct ad4030_state {
 }
 
 static const int ad4030_average_modes[] = {
-	1, 2, 4, 8, 16, 32, 64, 128,
-	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
-	65536,
+	BIT(0),					/* No averaging/oversampling */
+	BIT(1), BIT(2), BIT(3), BIT(4),		/* 2 to 16 */
+	BIT(5), BIT(6), BIT(7), BIT(8),		/* 32 to 256 */
+	BIT(9), BIT(10), BIT(11), BIT(12),	/* 512 to 4096 */
+	BIT(13), BIT(14), BIT(15), BIT(16),	/* 8192 to 65536 */
 };
 
 static int ad4030_enter_config_mode(struct ad4030_state *st)
-- 
2.39.2


