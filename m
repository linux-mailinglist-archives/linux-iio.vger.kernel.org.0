Return-Path: <linux-iio+bounces-27142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8577CC790E
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 13:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D15C30B1CE2
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 12:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB2344036;
	Wed, 17 Dec 2025 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bD+uDH/Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0C34165F;
	Wed, 17 Dec 2025 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973663; cv=none; b=bmSRfk2OeLlF9+/bEHl4s5wmbcHRIxAvpJKzoDDbHmN3K5/NlMJSQKAPsj/LYxg0l4AguHEaGYfGaKCTUES/7WtEexSGhQ/GSiBuWDkykvBRX/A5NltrXizo6IwXBGI+zE6YcDCSzIL0WaMzRDeERLA/9nsLlbpKsxarU+HpgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973663; c=relaxed/simple;
	bh=DaaLNQLpb3vDc1eYDeL/oEoMbkwxl9yfrm8dY/iu+eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HfFCM10Ec0X3jTZ/6uNr41M+2ZJW0+jfuopZaN/nsuuiAI4FJMKMNgZtIhZ6rw4LpWbiEpRJYQ0dTS14MwPg0r1pfHGe60gZ3KJQicUzxvsQn46xMYBLbrKclqXoPfQ0UsE6LiCOnReZBT70ig6CwSVUgZLzEWUE8Li6UxCQU8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bD+uDH/Y; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHAqqxt3839561;
	Wed, 17 Dec 2025 07:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0fNzO
	ZMS1MeY6GqG5tP+I0AoDb+uwPRd0H1aFV5RFRk=; b=bD+uDH/Yk0k/JinWsc2jb
	i77iAm5I5qA2hn/0h4Al3v0CzGfGxxk3AiYohqDWVB8KE+i2Vn9ZWSwhhW16DFNd
	v84pt/t0ad3VPi1dPGDwCgRmpufAJ8YAweXo0pm0cVCsnWHYJQHWTaWCYh+qHtWR
	uIwY8x/oi43WaBRIleA5J8ZxfMCH6+hEavfwiFZgZWnD+avuz/30P3vu2mRCe2PG
	77QAPGOE7daQdbQvqNwXd+fbzSl56kK98pkFyjnT03TnrFEp2C/R1dIM1ARGBFSh
	gpMYjgonfPHFIGsTxyAektfLZYqKk+9zN3vVFUQz7x3pnkMaDexP3QJwjzpCOjWS
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4b3jw9jehb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:14:05 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5BHCE40A041121
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Dec 2025 07:14:04 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:14:04 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 17 Dec 2025 07:14:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 17 Dec 2025 07:14:04 -0500
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.73])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5BHCDUvE014815;
	Wed, 17 Dec 2025 07:13:55 -0500
From: Jorge Marques <jorge.marques@analog.com>
Date: Wed, 17 Dec 2025 13:13:31 +0100
Subject: [PATCH v4 8/9] docs: iio: ad4062: Add GPIO Controller support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251217-staging-ad4062-v4-8-7890a2951a8f@analog.com>
References: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
In-Reply-To: <20251217-staging-ad4062-v4-0-7890a2951a8f@analog.com>
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
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>,
        "Linus Walleij" <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765973610; l=1479;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=DaaLNQLpb3vDc1eYDeL/oEoMbkwxl9yfrm8dY/iu+eE=;
 b=Fec71dDvyVAzEylQQv6z6ZB1seqgWqpnZDppwFKLL6ere58wMAPgClC3o7yxTX8nQBFGFVBlf
 Pn1d14NFr3uDIIc/gDChfV2ntQDvBZ4zODnBkV6+20Tt9XqBQykcKa7
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NSBTYWx0ZWRfX0W6XscDXYt4E
 3Ppwy/HB+Ygd8LvJ7xeUomge9mbuKWJAB24x01k2tgwWtDB7Ss3LgbIPx+Ug97FjthY7pzZCtMh
 P6tkToA5EKUYa+hHq1GvhWVsTdToa4ipOewUkQP0VCOYaRUYpfu/oX0yRDIHLyChg+VnEetx374
 Mwcstg8FB04UZ0COTQP/4C1QxF9eXQcTUGWw1m38RvKXfOoS5KPMaPNZi104arB0LovC3xzWcV8
 fNY9qezTSuIICcZ6snm+DIhG3a1Hf0gBLDJGvZ+wfsSlRzxKu8LmwYbmbkX6BSBV/kJqrxLd1Bf
 0tVVB/8ixiAPn8rgzLUtJm8bgmAIoRykgvaVIY0R49m74i3yAgpmRCeBi6LOn8rLoSSRGTwvVVX
 Aj0f/vdRf3LsRmVq76t9vwG0SCljbw==
X-Authority-Analysis: v=2.4 cv=TZGbdBQh c=1 sm=1 tr=0 ts=69429e8d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=EBGExmvx8FPMp0bAM4MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JIQs7TvOEAiN6CFmOHymmSn14qwfMAGa
X-Proofpoint-ORIG-GUID: JIQs7TvOEAiN6CFmOHymmSn14qwfMAGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170095

Explains the GPIO controller support with emphasis on the mask
depending on which GPs are exposed.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/iio/ad4062.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
index 8d388f9e2f450..d77287836430c 100644
--- a/Documentation/iio/ad4062.rst
+++ b/Documentation/iio/ad4062.rst
@@ -29,6 +29,9 @@ the devicetree ``interrupt-names`` property:
 - GP0: Is assigned the role of Threshold Either signal.
 - GP1: Is assigned the role of Data Ready signal.
 
+If the property ``gpio-controller`` is present in the devicetree, then the GPO
+not present in the ``interrupt-names`` is exposed as a GPO.
+
 Device attributes
 =================
 
@@ -134,3 +137,12 @@ The following event attributes are available:
      - Set the hysteresis value for the maximum threshold.
    * - ``thresh_rising_value``
      - Set the maximum threshold value.
+
+GPO controller support
+======================
+
+The device supports using GP0 and GP1 as GPOs. If the devicetree contains the
+node ``gpio-controller```, the device is marked as a GPIO controller and the
+GPs not listed in ``interrupt-names`` are exposed as a GPO. The GPIO index
+matches the pin name, so if GP0 is not exposed but GP1 is, index 0 is masked
+out and only index 1 can be set.

-- 
2.51.1


