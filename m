Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D02541422E
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 08:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhIVGy1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 02:54:27 -0400
Received: from mail-eopbgr50097.outbound.protection.outlook.com ([40.107.5.97]:57248
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232835AbhIVGy0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Sep 2021 02:54:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi8kqsV8vgiPOovSFQhFS3c+DCOGKxI8C0q/0CB8Mr4MiKKWg7UBrqqGdDev2i9/pcMa7Q0btWWYOPw7QohVsLTOEK6qgwfaP5y1FNHqdtm1kduodTR+X8Y3I2vFYjddWnLnsf2gt9cMuKewxUh0aU5EzGy5VCxD+lwXlvBbfFnmUv/Zwt/d3wAQ3A8hb2pOTDoNjLThfa9hAT+to4w2dZoEt5E4XFTAULi7qugRyGao30j7/wzE2mRYUolgQ4sfWlf23qe6QObejlS3y+2j7TY3BASrnb9I8eo137BPEv9Irf6ki051iWcEb0ZPp7AvLgQ3T59+X8VrknAQRpYi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RGi9EfyjeBCBEYFKMJoB1HqDxSgwuv+m1pokPM0W7p8=;
 b=eSlSZAmk4d2l0Fak95tp7CiSOCHdZgxQPzQzJMqA21kQhXA9jxpQr9Ctg3ezw7CZB+Kcn2FXAKZ71ybQXnE6oWv+SSxQAGqrWmpScnSFumuBuwdTNHZBnnV10q+1w1xWqc38aQVGk96Cyg+UZNrq/tuv2t7Jn/CzXMrHgRZF/O3oAvqsZiQ+dquUgUrZqvOhvgvPSBPU4BJMDC+gn5iga9pKyKD5eOzmqTLM5VUZ6el1wOfqKWIvftihWkbwQnnEQm/i2xEZ1XCJO1Asfz0M9+ktvvIvMTu75QYw3WNFI5URkaxEq0CzT3lastp9WrzhUyX1bATbvlYxP5JpiUB+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGi9EfyjeBCBEYFKMJoB1HqDxSgwuv+m1pokPM0W7p8=;
 b=W+AIsLaZAMHNBNhxxrgJHj+5E8W1GYuEq1r1bc2TdcbBnL6o7W9xp6VWk+nrSQsybQO1/kA/e+5mv39PPXs/ZfkN+ht8rUieqEEjcmZd2R4IImF8lZ/M0jg3NegniLxm3AsK1093a3F1TEwA0DA0gIdmdJzfqPM0BwLMogH+AG4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH 1/1] iio/scmi: Add reading "raw" attribute.
Date:   Wed, 22 Sep 2021 09:52:35 +0300
Message-Id: <20210922065235.12891-2-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210922065235.12891-1-andriy.tryshnivskyy@opensynergy.com>
References: <20210922065235.12891-1-andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain
X-ClientProxiedBy: PR3P191CA0035.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::10) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1700d95c-0975-4ea4-686b-08d97d959a29
X-MS-TrafficTypeDiagnostic: AM7PR04MB6949:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6949973D69256DF5DFB70783E6A29@AM7PR04MB6949.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: woZsqDr4jQBxb88bY6skC6c3sMnYnRlM14fn0rVAP/TxHd3lD1i2ze1rYqahYyS7n71xHMF6SQ0JpFGlAYdOiJcaPhfjXyV/J5adr/zcld+7e2bnLzomYhZQ62KXw08Y2of//ShUlnvxIV+t3osKwBcV0HqhmnVZd05/cZZpuxg5LT9DTg9tX/a+fQnOwKUCLfvHiJtEWNc1WR8Dd7m4MdOIHGq1bLrtig79CmKoG7JiL/HyhH7iD0cJIwXySkLOs9EuPkC1PStbmkJp7Aq5O8nyvrS8gKZsyLQ/LaVfOf7jKtuzoHThaH9UAaCBB+/xbNHV+zUrtYD8SXyiDQ4vELkV63GQRhynZZLHrEqpJ9LNTSfshoLimkxW/XkSOsmsYNBrCVysuo8aaErUl1n9XQjzSCX2cfbYfFkVki5KxtiGp6GnzOV3IrokszwfAqqXBqrx+rkyWffzxrJEIKNqxD5j22K0871x8OYVx83qN6Me6sHk1c2kg2d5ejLyEFMQvOydHABHoJD9/HzYi9GE9STH4z7zmWDhd9JiRHdH6PpwbWTOxDfHTgZbBQNA4ZmCovT+1vnZjZX9GiXoJvlSK+/Y3l5bEEJktoxRcLjzY5wFHZQvPUA9WsWVjeTSIRMqrDD1/nbmMgc/D5nYgjDBU52PXOLyny2NXr7+aCIjaBZEoyN1d0+J3i+gsetUJNsKGopOWLFZun90Ar+BSuSp3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(346002)(136003)(39830400003)(38100700002)(86362001)(1076003)(107886003)(44832011)(2906002)(5660300002)(8676002)(36756003)(2616005)(38350700002)(8936002)(66946007)(55236004)(26005)(508600001)(186003)(66556008)(42186006)(83380400001)(316002)(66476007)(4326008)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Qlqa7jKuf+3urEQbzliH5LYqOBAPYQhgCMrxhlXC1i7cta8EZZnLakamvYj?=
 =?us-ascii?Q?F8dSkLHuT5cro7Kw79mKHtl2u5vphjLpoaoL0fJaGjQOJxNb3FrM4ynAZF/1?=
 =?us-ascii?Q?jgqmHH5nJ0xmvFe9rhhk08oDvfzGVjsL4VGo3+gL3bVXeHia2qyjKPvETY83?=
 =?us-ascii?Q?AOQfiuw85H4mj36IM2LhVfQnIyNWStSzAahbaQg8OzOfdNw5NVnfcTh6xdu/?=
 =?us-ascii?Q?ZFO3hg3jXnXiHLPhs5vALOsbEZZdMtbSmEKPggtDOkks5lnrpO6LpgQDS9DY?=
 =?us-ascii?Q?qOuGGPiijbc3JzqHz++LfaysTnmrs98do4XDkR7Wy9WS9ISEyeLds7dhmS+K?=
 =?us-ascii?Q?NRg+duuu4MRqzRG34y5+o3vLZwDQaia0eGfO6xAFSWAV07To3nqGTu5kDhxX?=
 =?us-ascii?Q?zGAvNIIr3q+F+Ywv49U2WoUebcQ4qpOq5EC+X/3y3F53EwRdUkKV71JXZZx9?=
 =?us-ascii?Q?UtM5xL9Gg8QLln8pamf709432HKWhmH/7ECwd51mI/mIxxM8dM7qQQdpTeU7?=
 =?us-ascii?Q?fQIwttsmT0PdeugxE9T2NMwg0KXTk93OiITVpssu3W9LxqMRV0oBx1Hxp8ZL?=
 =?us-ascii?Q?bTQKxFkwtGY18gTAYnGKlbL5PKDgFvLK3D7reQH6/WwiBhTpVp7fOs6R/0sP?=
 =?us-ascii?Q?RXSkNIKTiLAIAjsQt3on+UQyk3jsdsClnbTT+exlG16vByNL7Ronz/FPeMYz?=
 =?us-ascii?Q?pbFlhfkttJywVGknRyRm2UyHSgtreKjHWAOODo/5QtRwE0H9TexaZaxkbARV?=
 =?us-ascii?Q?zm3sLg/DS42oWw/NZFYP4sXeqN+BM5RShCnsMRIZKe2e+pydwTGoKYift2BD?=
 =?us-ascii?Q?7l4ZA0ZiSOU3vegp7t5rsG5nTlGH2CRk8MJol7CiZNBPE3xqvdzX8mGAijJc?=
 =?us-ascii?Q?ts5w8czYb6ETZOjl1gJMwdBW/8aQcET7801yeXIbEidVEUmHcZxyVLHHwE/w?=
 =?us-ascii?Q?2E+Wjwv6ScUp0LvN06zxCcjSQcoRa+eLsS9t+yjIP+KFLjWlhyAYtItj7/0V?=
 =?us-ascii?Q?OVWMaN6Y6cCgZmNwc3wrKwxtmtKH4oqEp/gH0jntjo4E3A3tUUphym2pIefw?=
 =?us-ascii?Q?52zrNcmE1jWPs3nP2tElKg/H5Vdke4vlaABzyZgoul5uYeH+byntO7nQd/s0?=
 =?us-ascii?Q?ppiLoh4Bre4Ob/UM0xG5G8K0yQG4heLgn+SqMvMgwe969zxC+kIgkwAKxx3Y?=
 =?us-ascii?Q?uOGaoc7QLciHGTj2cSgdktaEOMzojOoRWC/VQtU2LGFKGILuqwa7kgYw7zoz?=
 =?us-ascii?Q?Z5gD2OU3YQRNBF6/LHN0U8CBS0NxufowPUOxVODfjWtjN6Ih3EijTQHn6WZf?=
 =?us-ascii?Q?cYPuqd9p2H8krqLLcLzQZyB/?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1700d95c-0975-4ea4-686b-08d97d959a29
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 06:52:54.1478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nIatudCNwtukGFbEG6/nzvxL5Iug3OPmIke7ihmnWg0Rfe5dNWEuRvyWnduGgAl4zWlpOux1JF8w+BDPpwIhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6949
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
reading "raw" attribute in scmi_iio_read_raw.

Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 7cf2bf282cef..b88780a25796 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -286,6 +286,9 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
 	struct scmi_iio_priv *sensor = iio_priv(iio_dev);
 	s8 scale;
 	int ret;
+	int err;
+	u32 sensor_config;
+	struct scmi_sensor_reading readings[SCMI_IIO_NUM_OF_AXIS];
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -300,6 +303,38 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = scmi_iio_get_odr_val(iio_dev, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_RAW:
+		sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+					   SCMI_SENS_CFG_SENSOR_ENABLE);
+		err = sensor->handle->sensor_ops->config_set(
+			sensor->handle, sensor->sensor_info->id, sensor_config);
+		if (err)
+			dev_err(&iio_dev->dev,
+				"Error in enabling sensor %s err %d",
+				sensor->sensor_info->name, err);
+
+		err = sensor->handle->sensor_ops->reading_get_timestamped(
+			sensor->handle, sensor->sensor_info->id,
+			sensor->sensor_info->num_axis,
+			(struct scmi_sensor_reading *)&readings);
+		if (err) {
+			dev_err(&iio_dev->dev,
+				"Error in reading raw attribute for sensor %s err %d",
+				sensor->sensor_info->name, err);
+			return err;
+		}
+
+		sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
+					   SCMI_SENS_CFG_SENSOR_DISABLE);
+		err = sensor->handle->sensor_ops->config_set(
+			sensor->handle, sensor->sensor_info->id, sensor_config);
+		if (err)
+			dev_err(&iio_dev->dev,
+				"Error in enabling sensor %s err %d",
+				sensor->sensor_info->name, err);
+		/* Use 32-bit value, since practically there is no need in 64 bits */
+		*val = (u32)readings[ch->scan_index].value;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -381,7 +416,8 @@ static void scmi_iio_set_data_channel(struct iio_chan_spec *iio_chan,
 	iio_chan->type = type;
 	iio_chan->modified = 1;
 	iio_chan->channel2 = mod;
-	iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_SCALE);
+	iio_chan->info_mask_separate =
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_RAW);
 	iio_chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
 	iio_chan->info_mask_shared_by_type_available =
 		BIT(IIO_CHAN_INFO_SAMP_FREQ);
-- 
2.17.1

