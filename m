Return-Path: <linux-iio+bounces-22459-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFA8B1EA0C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66A21C25731
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2501527F195;
	Fri,  8 Aug 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WPSVevxz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D327E04C;
	Fri,  8 Aug 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662282; cv=none; b=okLnDUbXUGL6e7H67aQEYMOLTzwn30GUl7KH5qfSwjdUVIXOqQ96lfpP4PzLwT0awdAVHla8D1PTmd7JbeQRd+FdLpbwkHMR8ajzMrGC1No8if2V7Jh/cahGLsAnIy6iSVj+pIpBD3fUcd9dHixQ5olPivBWW5aybTsIj0RfyKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662282; c=relaxed/simple;
	bh=Qrq3pejRNB8LkxKpo8d1h53C505sv3QK3OTNzDTx/1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8U2RCULW2gweY5pWw4xKJZeHnGzH3t+vZn4+027+ZtjXuBFu+dJ9xVVzH3mmFB/cDDQ1KJKVsXODT/hjtc2Jq7i/5CMLX15BlEi8Pc3KGPbwDxaY/cFOEUP3fmzGvhaO7EQhGHMpu3DiRujW6MR4CbSeqMK1Rjhn2J1V91DY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WPSVevxz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DHmFt025567;
	Fri, 8 Aug 2025 10:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1yb8Z
	MvLlz+cYZOEhfjPEZ8iq2oBiuN8TdK0lxNjIMg=; b=WPSVevxzvJvmqmhbiTH5j
	PplZ/J1e31QVSPtoG9gpsm/faVv8ve6eYZsFgyxn152KhrbmREd+Sl4IIuuDL76B
	t4oaGzbXWanWl34wqXBSxLpQ7x6e7BDRtz6elmGfmSwJY6cJ+wd3OtgTr5qCnktx
	X4SjiFsSkKolmYGicgYzUjpXzAkju4ebESbJjTXhBb2/iMInWDi3Fo2cwh8CQF+E
	RFokRk9zb1ujybsOn3fZtgiS6oAvc2ZcLTnDxjrzaSgYX9CwkXHy9w8A8BgNVjzE
	WwbnMtJ977TYtqMrm+M0v5HaIs3beiJ5HskLI7zrX5JsZR0FYrYCf5UmdsvIL1dG
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48dj0708as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 10:11:07 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 578EB6Kh062944
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Aug 2025 10:11:06 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 8 Aug 2025 10:11:06 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 8 Aug 2025 10:11:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 8 Aug 2025 10:11:06 -0400
Received: from Ubuntu.ad.analog.com ([10.32.13.94])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 578EAqfE014662;
	Fri, 8 Aug 2025 10:11:02 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 4/4] Documentation: ABI: iio: add sinc4+lp
Date: Fri, 8 Aug 2025 14:10:16 +0000
Message-ID: <20250808141020.4384-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808141020.4384-1-antoniu.miclaus@analog.com>
References: <20250808141020.4384-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=R4sDGcRX c=1 sm=1 tr=0 ts=6896057b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=NyCsbHEqHMHvVcFNcFUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEwNyBTYWx0ZWRfX9W5RUp+FRi2V
 zMK1lebHYZ1xFE2qSyWV55DwljxZDgHpi2KF01Jiz4ZhytklqUW3Ms6XJ6B0Qo4bSef43av59rr
 efj55pG8vwpK5Ze9E6GCQhjswWKKG0Y/L6yA8WR0zPYcGTd0cuNLb1OmGNMrAKCGodxhg8aWSP1
 VLBYPW+Nep+jSp69DiYxCUpkli+BoFzDtOHx6YEGKR4wyF5TWzG80sXQnE2iKdYhWWs06eVmRe5
 UZ6Uqr0JDKTsAF/GTpl9inWG81kxH0+fjOBFJ/2OSvhVKS698+xjApIwyp/fK3ldgGjjiPjpVVf
 Re6tIzHmSIqhuFsFEvbxmWLFVDMThBLJ6MD6Q/MalHqdDa7EJ1qDZCKkV+5YwCbtsisd1SXGS9Z
 62pKXKbQ
X-Proofpoint-ORIG-GUID: ajKfGj5UC6VIvw90UL48EUnVkYaYtvyY
X-Proofpoint-GUID: ajKfGj5UC6VIvw90UL48EUnVkYaYtvyY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508080107

Add new filter type to the sysfs-bus-iio ABI documentation:
- "sinc4+lp" for Sinc4 + Low Pass Filter

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - change from "sinc4+iir" to "sinc4+lp" for better generic naming
 - remove "dsp" filter type
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 28f51e4cc367..caafdd88c601 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2309,6 +2309,7 @@ Description:
 		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
 		* "wideband" - filter with wideband low ripple passband
 		  and sharp transition band.
+		* "sinc4+lp" - Sinc4 + Low Pass Filter.
 
 What:		/sys/bus/iio/devices/iio:deviceX/filter_type
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_type
-- 
2.43.0


