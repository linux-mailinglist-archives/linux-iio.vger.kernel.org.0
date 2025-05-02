Return-Path: <linux-iio+bounces-18980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79104AA6E93
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481A91BA7E51
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D89021518F;
	Fri,  2 May 2025 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Og/KlTv0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F528382;
	Fri,  2 May 2025 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180038; cv=none; b=mFFKNUgfThzp8dDhrwDfc1MTU0Am9VUI4b1oTjkfwFblAn25IlQDyL+Q6UCvaIe2KfCjThVZx7UV9LHlH3GQ24r6Zq8DsNuZ7WBGZZEIs/ISP9Yap6r/fnvoW7F9+FMdDN7gAqkX4XmZX3e88N/TFudNgt3QFgYbq+sf+EVuNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180038; c=relaxed/simple;
	bh=xvxeFqmwwqfFPGDg9Kr/q4evyXy2QadqZQMvYNW4DGY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tgSAFWjixXM6Ok3kX7JLh4Sb4+gPj2a5Ny1QN/MqNRd7JrowSVUCK0ijxpTW33jlWR0xnRGd5NRLF4Ps7u486clzI5NA3jaQDOfIc255ndumQccCp9BGz6g+LmN74BzvDQZxagpzvKGJh01HAjmYyg1Y3OeU+4TJJpkTpXvaMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Og/KlTv0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5426mq8c008008;
	Fri, 2 May 2025 06:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=+s7qNhrdsXhtcpRF2pny6jBhlRT
	PMk/+y1XlqUe41dU=; b=Og/KlTv0QTDmC5Hwb+CLU0vGz8eTG32oxclgtOi2zMv
	vNwrGzLuZqoYdvXdr7F2yuCV8C9+dWTKKrrNg6L3NOTBNE5xJk5UyrfzaTDlQC3U
	eGSLq2DXi1eqKZIghgfDXo/yNJV96ESFs2Par3R2VJ7fNs5MmZREutxml+0+9svL
	jfBacfBnAXP6qVAjXnWqhG82u5eZ2fSDVvEeRN+V9Of/v71Q5WPO/CpHvPxgz6dB
	zxGvz99uluUIWUTY+wrO77nESFpllaCcCDuAV/6tLSb3y0Sdi+wW0wlNcCsxD4WL
	rEufHCMWiBSKyS96+w+KJ1QlFgxvRM8c7YLg66mJ4sQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46b6u1m50k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 May 2025 06:00:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 542A0Pxt000899
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 06:00:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 2 May 2025
 06:00:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 2 May 2025 06:00:24 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.211])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 542A0H3G019409;
	Fri, 2 May 2025 06:00:20 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] MAINTAINERS: add maintainers for ad4851 driver
Date: Fri, 2 May 2025 13:00:16 +0300
Message-ID: <20250502100016.26279-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RuDFLDmK c=1 sm=1 tr=0 ts=681497bd cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=ZmWbj0fSwbq9jPR7GREA:9
X-Proofpoint-GUID: sr1sbG4cO3zoosvDyqoosMSJJXhEROZe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3OCBTYWx0ZWRfX3hF3+/L/jBCN 3IywNiNt7Dh6shnz/PqwjwDYBp7hEbpghKgNaWoZS4XReW5pyhJ/7Ww+xN9FW0selYewQ1QV9Fq NvVlE7gX47BkTl7LjMKYM883jPSe323tdtNVvylt2wvyCPRgOysijGVGcEUicoZWnORh78Lw7Fb
 lmiMiLpqplTIX5LBq2i36H8sk3ircdU1uTJQICc+yN+C2oPsvHDAkdGq5KkDqz4uqDUNAHAWX3w 3t4PcgAJKSfSPgrtuA+STLQYPdTobwrwUDMCAFjT1xJvvuOAL9sXo7lf4ms9uLh/I0WNmXhNFge jwMvFhTvKM2lewc2KezevleuRp2kqgaflbjeOvS63zV29zRhmXqZyY/Rn88OWx74f9E1ykc+7Nk
 gwd4apm28QCh4IBTNtCwxMdp3Mu4q0QGsm4hq8hnKk9F0ecJ1xctJCYUw3p0pb1Pi1zM109Z
X-Proofpoint-ORIG-GUID: sr1sbG4cO3zoosvDyqoosMSJJXhEROZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=811 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020078

Add the ad4851 entry in the MAINTAINERS file.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a0089db6670..d5a985ae62bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1350,6 +1350,16 @@ F:	Documentation/iio/ad4695.rst
 F:	drivers/iio/adc/ad4695.c
 F:	include/dt-bindings/iio/adc/adi,ad4695.h
 
+ANALOG DEVICES INC AD4851 DRIVER
+M:	Sergiu Cuciurean <sergiu.cuciurean@analog.com>
+M:	Dragos Bogdan <dragos.bogdan@analog.com>
+R:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
+F:	drivers/iio/adc/ad4851.c
+
 ANALOG DEVICES INC AD7091R DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.49.0


