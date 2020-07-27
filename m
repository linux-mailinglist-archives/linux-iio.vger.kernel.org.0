Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D6722F4B5
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 18:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbgG0QRS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 12:17:18 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21858 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731321AbgG0QQj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 12:16:39 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RG7xmj019091;
        Mon, 27 Jul 2020 12:16:38 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32ghn5eykx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 12:16:38 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06RGGbgj050467
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Jul 2020 12:16:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 27 Jul
 2020 12:16:36 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Jul 2020 12:16:36 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06RGGShn009603;
        Mon, 27 Jul 2020 12:16:35 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v7 6/9] hwmon: pmbus: adm1266: Add group command support
Date:   Mon, 27 Jul 2020 19:18:11 +0300
Message-ID: <20200727161814.14076-7-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727161814.14076-1-alexandru.tachici@analog.com>
References: <20200727161814.14076-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_11:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270111
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

The Group Command Protocol is used to send commands
to more than one PMBus device. Some devices working
together require that they must execute some commands
all at once.

The commands are sent in one continuous transmission.
When the devices detect the STOP condition that ends
the sending of commands, they all begin executing
the command they received.

This patch adds support for the group command protocol.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/adm1266.c | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index b61a968d67f9..f571fe1ee35d 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -73,6 +73,56 @@ static const struct nvmem_cell_info adm1266_nvmem_cells[] = {
 
 DECLARE_CRC8_TABLE(pmbus_crc_table);
 
+/* PMBus Group command. */
+static int adm1266_pmbus_group_command(struct adm1266_data *data, struct i2c_client **clients,
+				       u8 nr_clients, u8 cmd, u8 w_len, u8 *data_w)
+{
+	struct i2c_msg *msgs;
+	u8 addr;
+	int ret;
+	int i;
+
+	msgs = kcalloc(nr_clients, sizeof(struct i2c_msg), GFP_KERNEL);
+	if (!msgs)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_clients; i++) {
+		msgs[i].addr = clients[i]->addr;
+		msgs[i].len = w_len + 1;
+
+		msgs[i].buf = kcalloc(ADM1266_PMBUS_BLOCK_MAX + 2, sizeof(u8), GFP_KERNEL);
+		if (!msgs[i].buf) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+
+		msgs[i].buf[0] = cmd;
+		memcpy(&msgs[i].buf[1], data_w, w_len);
+
+		if (clients[i]->flags & I2C_CLIENT_PEC) {
+			u8 crc = 0;
+
+			addr = i2c_8bit_addr_from_msg(&msgs[i]);
+			crc = crc8(pmbus_crc_table, &addr, 1, crc);
+			crc = crc8(pmbus_crc_table, msgs[i].buf, msgs[i].len,
+				   crc);
+
+			msgs[i].buf[msgs[i].len] = crc;
+			msgs[i].len++;
+		}
+	};
+
+	ret = i2c_transfer(data->client->adapter, msgs, nr_clients);
+
+cleanup:
+	for (i = i - 1; i >= 0; i--)
+		kfree(msgs[i].buf);
+
+	kfree(msgs);
+
+	return ret;
+}
+
 /*
  * Different from Block Read as it sends data and waits for the slave to
  * return a value dependent on that data. The protocol is simply a Write Block
-- 
2.20.1

