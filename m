Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEE916C11E
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 13:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgBYMla (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 07:41:30 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40990 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729525AbgBYMla (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 07:41:30 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PCX044022287;
        Tue, 25 Feb 2020 07:41:09 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yb23aghvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 07:41:09 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01PCf75e063023
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Feb 2020 07:41:08 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 25 Feb
 2020 04:41:06 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Feb 2020 04:41:06 -0800
Received: from nsa.sphairon.box ([10.44.3.59])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01PCev8c005013;
        Tue, 25 Feb 2020 07:41:03 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 3/5] iio: adis: Add adis_update_bits() APIs
Date:   Tue, 25 Feb 2020 13:41:50 +0100
Message-ID: <20200225124152.270914-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225124152.270914-1-nuno.sa@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_03:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=830 adultscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250100
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds a `regmap_update_bits()` like API to the ADIS library.
It provides locked and unlocked variant.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis.c       | 26 +++++++++++++++
 include/linux/iio/imu/adis.h | 61 ++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index a8afd01de4f3..fa0ee35d96f0 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -223,6 +223,32 @@ int __adis_read_reg(struct adis *adis, unsigned int reg,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__adis_read_reg);
+/**
+ * __adis_update_bits_base() - ADIS Update bits function - Unlocked version
+ * @adis: The adis device
+ * @reg: The address of the lower of the two registers
+ * @mask: Bitmask to change
+ * @val: Value to be written
+ * @size: Size of the register to update
+ *
+ * Updates the desired bits of @reg in accordance with @mask and @val.
+ */
+int __adis_update_bits_base(struct adis *adis, unsigned int reg, const u32 mask,
+			    const u32 val, u8 size)
+{
+	int ret;
+	u32 __val;
+
+	ret = __adis_read_reg(adis, reg, &__val, size);
+	if (ret)
+		return ret;
+
+	__val &= ~mask;
+	__val |= val & mask;
+
+	return __adis_write_reg(adis, reg, __val, size);
+}
+EXPORT_SYMBOL_GPL(__adis_update_bits_base);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index b4c35d137e2a..07073f698718 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -303,6 +303,67 @@ static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
 	return ret;
 }
 
+int __adis_update_bits_base(struct adis *adis, unsigned int reg, const u32 mask,
+			    const u32 val, u8 size);
+/**
+ * adis_update_bits_base() - ADIS Update bits function - Locked version
+ * @adis: The adis device
+ * @reg: The address of the lower of the two registers
+ * @mask: Bitmask to change
+ * @val: Value to be written
+ * @size: Size of the register to update
+ *
+ * Updates the desired bits of @reg in accordance with @mask and @val.
+ */
+static inline int adis_update_bits_base(struct adis *adis, unsigned int reg,
+					const u32 mask, const u32 val, u8 size)
+{
+	int ret;
+
+	mutex_lock(&adis->state_lock);
+	ret = __adis_update_bits_base(adis, reg, mask, val, size);
+	mutex_unlock(&adis->state_lock);
+	return ret;
+}
+
+/**
+ * adis_update_bits() - Wrapper macro for adis_update_bits_base - Locked version
+ * @adis: The adis device
+ * @reg: The address of the lower of the two registers
+ * @mask: Bitmask to change
+ * @val: Value to be written
+ *
+ * This macro evaluates the sizeof of @val at compile time and calls
+ * adis_update_bits_base() accordingly. Be aware that using MACROS/DEFINES for
+ * @val can lead to undesired behavior if the register to update is 16bit. Also
+ * note that a 64bit value will be treated as an integer. In the same way,
+ * a char is seen as a short.
+ */
+#define adis_update_bits(adis, reg, mask, val) ({			\
+	__builtin_choose_expr(sizeof(val) == 8 || sizeof(val) == 4,	\
+		adis_update_bits_base(adis, reg, mask, val, 4),         \
+		adis_update_bits_base(adis, reg, mask, val, 2));	\
+})
+
+/**
+ * adis_update_bits() - Wrapper macro for adis_update_bits_base
+ * @adis: The adis device
+ * @reg: The address of the lower of the two registers
+ * @mask: Bitmask to change
+ * @val: Value to be written
+ *
+ * This macro evaluates the sizeof of @val at compile time and calls
+ * adis_update_bits_base() accordingly. Be aware that using MACROS/DEFINES for
+ * @val can lead to undesired behavior if the register to update is 16bit. Also
+ * note that a 64bit value will be treated as an integer. In the same way,
+ * a char is seen as a short.
+ */
+#define __adis_update_bits(adis, reg, mask, val) ({			\
+	__builtin_choose_expr(sizeof(val) == 8 || sizeof(val) == 4,	\
+		__adis_update_bits_base(adis, reg, mask, val, 4),	\
+		__adis_update_bits_base(adis, reg, mask, val, 2));	\
+})
+
 int adis_enable_irq(struct adis *adis, bool enable);
 int __adis_check_status(struct adis *adis);
 int __adis_initial_startup(struct adis *adis);
-- 
2.25.1

