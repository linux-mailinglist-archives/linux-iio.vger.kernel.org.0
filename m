Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6351995B7
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 13:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgCaLsq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 07:48:46 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56164 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730426AbgCaLsq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 07:48:46 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VBe4RL005230;
        Tue, 31 Mar 2020 07:48:28 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3020e6hfp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 07:48:28 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 02VBmRqw027934
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 31 Mar 2020 07:48:27 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 31 Mar 2020 07:48:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 31 Mar 2020 07:48:25 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 31 Mar 2020 07:48:25 -0400
Received: from NSA-L01.ad.analog.com (nsa-l01.ad.analog.com [10.32.224.203])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02VBmGgB024975;
        Tue, 31 Mar 2020 07:48:22 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v3 3/6] iio: adis: Add adis_update_bits() APIs
Date:   Tue, 31 Mar 2020 13:48:08 +0200
Message-ID: <20200331114811.7978-4-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331114811.7978-1-nuno.sa@analog.com>
References: <20200331114811.7978-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_04:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=745
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310107
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds a `regmap_update_bits()` like API to the ADIS library.
It provides locked and unlocked variant.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v2:
 * Add BUILD_BUG_ON() to avoid invalid types.

Changes in V3:
 * Nothing changed.

 drivers/iio/imu/adis.c       | 26 ++++++++++++++++
 include/linux/iio/imu/adis.h | 59 ++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

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
index ed41c6b96d14..94031b3fc9d5 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -333,6 +333,65 @@ static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
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
+ * @val can lead to undesired behavior if the register to update is 16bit.
+ */
+#define adis_update_bits(adis, reg, mask, val) ({			\
+	BUILD_BUG_ON(sizeof(val) == 1 || sizeof(val) == 8);		\
+	__builtin_choose_expr(sizeof(val) == 4,				\
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
+ * @val can lead to undesired behavior if the register to update is 16bit.
+ */
+#define __adis_update_bits(adis, reg, mask, val) ({			\
+	BUILD_BUG_ON(sizeof(val) == 1 || sizeof(val) == 8);		\
+	__builtin_choose_expr(sizeof(val) == 4,				\
+		__adis_update_bits_base(adis, reg, mask, val, 4),	\
+		__adis_update_bits_base(adis, reg, mask, val, 2));	\
+})
+
 int adis_enable_irq(struct adis *adis, bool enable);
 int __adis_check_status(struct adis *adis);
 int __adis_initial_startup(struct adis *adis);
-- 
2.17.1

