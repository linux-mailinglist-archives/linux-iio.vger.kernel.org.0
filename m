Return-Path: <linux-iio+bounces-20019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F89AC8476
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 00:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7421BA5109
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 22:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DF5224227;
	Thu, 29 May 2025 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oJPFLAw1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F721FF5B;
	Thu, 29 May 2025 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748558927; cv=none; b=jPok1hKeeJozYYXCU+IV7MAAJvoN6xKfhCwHRe4p/BC271zA5U//du9WihnzQfCPrjoO9MS429xqqsQz4b0sM+XraPR8XXh5+o1yxEuRDyqoIg6OdgXOvK0CRwNcDhxxm0DXH12JclgnEE64x/Nk82LzW1qU2fTsQoOjk2TUchk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748558927; c=relaxed/simple;
	bh=8zb4rHGya88dCBscbgoGqLLR58/RNd03oMkC6Jiqb0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DH95lVQjY2ZBtszRVnWD963sZCtGSCAO+N/gMrrhlHGb9XkkKLskS2TT75UU25wGZ/7HGmnXzowmKFI0f7DrHqgK5dTVayZKbPHOXTKBXzXYEZ2ocsmaxh3zgX+yYrxbZiuWPMSxfLHUlsOTsb8Qsuqd5zKYbPAUsnyYYk0/LBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oJPFLAw1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TM67WZ012161;
	Thu, 29 May 2025 18:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jwL49
	c9PxLueP67fojEUh5JG7Onn+D+SDx9GtpYcXXI=; b=oJPFLAw1YGPbgvYVzzNo/
	yF9c+xWpj1A2Blp5kMw5W34ZoxIkuNb8PiDEcseuk2H10KRwyHXx22zfx0iz0VZM
	D2tRBEmwEWXqt2kxbrV/86uxDaaG8mj+7ruFbaITkEoEX9bw+iaSCcw+Ujoi934S
	c2hxFq7/t+25GM/DzGBm3+fMsYwdQ4kHsSJotB3YWihAeCbp4Bx4SiOeMehpIbp8
	liKIbVZeyrmbt9LSI+y2ZJ5oUGrd/NytsjECmZsWlVV41ALtTQG/mYjP5eeiwjXC
	WvKQxcxPAir+gIkUYO7O0yg5ODS1OR5067ApzW3EgOxfID2cPXypryRDqyLLxpaP
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46xjw64bm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:48:35 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54TMmY4w010276
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 May 2025 18:48:34 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 29 May 2025 18:48:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 29 May 2025 18:48:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 29 May 2025 18:48:34 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54TMmH25017125;
	Thu, 29 May 2025 18:48:20 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        <andriy.shevchenko@linux.intel.com>, <rafael@kernel.org>,
        <djrscally@gmail.com>
Subject: [PATCH v9 01/12] device property: add fwnode_find_reference_args()
Date: Thu, 29 May 2025 19:48:17 -0300
Message-ID: <55924e747e4891ae75288343d9f3ad2361174bd2.1748447035.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1748447035.git.Jonathan.Santos@analog.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDIyMiBTYWx0ZWRfXxNoKbCrr9tmJ
 k/bWfx/bxEeCISB36KdyFSDICM5lTG7QPVqnJhgVp4lEME3bc6VruuTUE/5rtG8zA8h7LrrDedV
 1ZyQOCJ1QT9fD1i2Ad8AmzUF7RNBcTGVhldDJZpCGO9b8cjgP4UI6V6M09dRQbrQ7CByCKsfUxy
 myTd2m5rV3VASQhmTcozKTD/Jv2S08P97aMM7jLjOtKd3oY4uBqpI9h6y7qJqYMOdigKnE1UdoE
 NPo657vrIFes51PhuF6rqndkFDYQQr1uF56Ec/dzzPp5ZXwEtLXrHMnoTmyZB5eAC337YEt5qWB
 dTvuSfD6tQGh1hczfhOZ3KyzZHeqWLXGFQpbpROIzhwMLgkGclUBcK7/Sc9PwzFOaA3rbMwBioC
 4qGMhtg22uj/0rhtY57beuDVpji9yU27/L291JgJ1FouCr+kHV9y+Gwdg0zGR+N2tXp5W7pj
X-Proofpoint-GUID: 61jfqiC0k2AN6Vb7CYcqVTLifghnCIrv
X-Authority-Analysis: v=2.4 cv=RMGzH5i+ c=1 sm=1 tr=0 ts=6838e443 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=qJIK3qRHYySv6ljgYl8A:9
X-Proofpoint-ORIG-GUID: 61jfqiC0k2AN6Vb7CYcqVTLifghnCIrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_10,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290222

Similarly to fwnode_find_reference(), find and return a named reference
to a fwnode handle, including its arguments. This wrapper facilitates
cleanup handling and improves readability.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v9 Changes:
* New patch.
---
 drivers/base/property.c  | 32 ++++++++++++++++++++++++++++++++
 include/linux/property.h |  6 ++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f42f32ff45fc..b5d82facd7c5 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -645,6 +645,38 @@ struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(fwnode_find_reference);
 
+/**
+ * fwnode_find_reference_args - Find named reference to a fwnode_handle with arguments
+ * @fwnode:	Firmware node where to look for the reference
+ * @name:	The name of the reference
+ * @nargs_prop:	The name of the property telling the number of
+ *		arguments in the reference. NULL if @nargs is known,
+ *		otherwise @nargs is ignored. Only relevant on OF.
+ * @nargs:	Number of arguments. Ignored if @nargs_prop is non-NULL.
+ * @index:	Index of the reference
+ *
+ * @index can be used when the named reference holds a table of references.
+ *
+ * The caller is responsible for calling fwnode_handle_put() on the returned
+ * fwnode pointer.
+ *
+ * Return: a pointer to the reference fwnode, when found. Otherwise,
+ * returns an error pointer.
+ */
+struct fwnode_handle *
+fwnode_find_reference_args(const struct fwnode_handle *fwnode,
+			   const char *name, const char *nargs_prop,
+			   unsigned int nargs, unsigned int index,
+			   struct fwnode_reference_args *args)
+{
+	int ret;
+
+	ret = fwnode_property_get_reference_args(fwnode, name, nargs_prop,
+						 nargs, index, args);
+	return ret ? ERR_PTR(ret) : args->fwnode;
+}
+EXPORT_SYMBOL_GPL(fwnode_find_reference_args);
+
 /**
  * fwnode_get_name - Return the name of a node
  * @fwnode: The firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index 3e83babac0b0..f35ced8f50f7 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -144,6 +144,12 @@ struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
 					    const char *name,
 					    unsigned int index);
 
+struct fwnode_handle *
+fwnode_find_reference_args(const struct fwnode_handle *fwnode,
+			   const char *name, const char *nargs_prop,
+			   unsigned int nargs, unsigned int index,
+			   struct fwnode_reference_args *args);
+
 const char *fwnode_get_name(const struct fwnode_handle *fwnode);
 const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode);
 bool fwnode_name_eq(const struct fwnode_handle *fwnode, const char *name);
-- 
2.34.1


