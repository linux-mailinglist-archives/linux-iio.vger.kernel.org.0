Return-Path: <linux-iio+bounces-21158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EDEAEDFEA
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 16:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A992D17A11D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE8E28DB6D;
	Mon, 30 Jun 2025 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QLsMDRz/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FF828C5B6;
	Mon, 30 Jun 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292010; cv=none; b=sHuyP9W8YkoF0sIkiUnVCOnQSWEWXRr21zdyvzo1BQnhsX5f35bTS4arN2meh0HATP5pxJNfJy+pTiJOymvRhrfWPO81h+05PhYBE60UKRFfQfS9eQApM2wkUfFQQ9RyukL8TQD51X7yAjgsBbMDDUO1hj2chsqmpQ2Q/Gxee38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292010; c=relaxed/simple;
	bh=v/EFpb2g/1VLFSZHXyPtKl28iIacDEDKS0b4PAOz6pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byp+a+DFmEowNC1paFatY2xbB+iC+iozENOdETpt68PLwUvd0QqAXWclcwTd5JYK8OjAyOpEtIuRhcHyuS+F0+BRfFA71SdTI9m2z36f0Cy11MBnNYyR7jgCGvDWjtNqijkTvzbBEf0XJNMdy+Q1BkpWWsYJ1zHj9KWYLa3Qupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QLsMDRz/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UDtscr026440;
	Mon, 30 Jun 2025 09:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KIZY7
	XfDaHWU2ruHiq+JTf39OLSoaDGd16TlNZJcSgE=; b=QLsMDRz/rH3FssivUd8wr
	H+KDQR+aFLC2HE9nL7r/1t2uDZpfMt/MAKmqk1GlKWC4bhKh3I3udq4+xBKBUH1F
	/jJJmUIpvbBTOcJsDCtV0XVFaGGZiCK5ak4sT6NT3mEJ8BTP0YEztU8jwT0rOsIm
	TXqKUkteHwpmWz3PJJ9vPrQqdlb3pwyZNtVjwM7jFk0e8vfCcq3D8tUhVZ9VNEh7
	9VsJeC23fWeYhp86s4Bvz29mhztfdJ2EFBKrj2QF9IaLj39ksCCwDYPzIqjIO5+g
	TyqTk713WXQjx+1ZOYa3pC88a4FOkClVKqsMq7gc7IFzK3WTG1DyJHUk3sFPgItg
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47krqa1094-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 09:59:52 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55UDxpuj039416
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Jun 2025 09:59:51 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 30 Jun
 2025 09:59:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Jun 2025 09:59:51 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55UDxZe2008279;
	Mon, 30 Jun 2025 09:59:37 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 05/12] Documentation: ABI: IIO: Add sinc5+avg to the filter_type_available list
Date: Mon, 30 Jun 2025 10:59:34 -0300
Message-ID: <1e27c7d1e1f7f7fae25dffec8d8e157d10751fa4.1751289747.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751289747.git.marcelo.schmitt@analog.com>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExNSBTYWx0ZWRfXxk99eZgsyL8T
 r/G3zhSSw76yl5tLowOI/lIYJSR3dRMEM3c4YZIsG7fchYsTGu7t8YXB/7qTyEQ02t+2fNV9TlW
 D3UhNdOiTN3RWEGvcuXhbknTG8JpTJc2g+Z5uPEW+1YgbnEa+bMqmb3/VhhA2W/YoEisM2eizER
 rlMZEui8hH/BtEiJsGgzTYLzz5HI21fXjq0IgU7Bl0odigwmgEMflSdCPr4sYDsXqBxDE0DwtTC
 nSVo+9AB4xv9qfii2wBspzs6GYiIx4cCFBaqHQnKijXX5UlckOWXhSoAettdF5pSS/qOQ5SIQbO
 q3XRTBoQi91afwXZUS8nvHmmywVgoKLTIAuiy1mHwNU8W+k5eBM8HKz9P8h3dsoBcrq4xaZsrGq
 OesZAQDuGa3l2BTgQi9qJcrA29+fopraNSOSr/L70q97GZDcY6K0+XK+3FzeX0hGOjLDq8jS
X-Proofpoint-GUID: J697rzcjYhHSUpzgrGWo0tpTS8cUS-3e
X-Proofpoint-ORIG-GUID: J697rzcjYhHSUpzgrGWo0tpTS8cUS-3e
X-Authority-Analysis: v=2.4 cv=U8+SDfru c=1 sm=1 tr=0 ts=68629858 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=Y0f5BrUp6vxN6OZ1eKkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300115

Add the sinc5+avg filter type to the list of possible values for the
filter_type_available attribute.

The sinc5+avg filter type is handled by the ad4170 driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v6 -> v7
- Fixed IIO ABI documentation by specifying the correct filter enabled with sinc5+avg.

 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3bc386995fb6..fcc40d211ddf 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2321,6 +2321,7 @@ Description:
 		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
 		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
 		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
+		* "sinc5+avg" - Sinc5 + averaging by 4.
 		* "wideband" - filter with wideband low ripple passband
 		  and sharp transition band.
 
-- 
2.47.2


