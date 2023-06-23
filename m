Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DE373B2BD
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jun 2023 10:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFWIaS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jun 2023 04:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWIaR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jun 2023 04:30:17 -0400
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E75118
        for <linux-iio@vger.kernel.org>; Fri, 23 Jun 2023 01:30:11 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ME85m1030918;
        Fri, 23 Jun 2023 08:29:50 GMT
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2113.outbound.protection.outlook.com [104.47.23.113])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3r936w4dev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 08:29:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpDYHLjaLUSuoayabdKSlUjFa3FCM2FLRG4zaxBbAQUVdWJlpqq+2CkO8y1YLXScmpBxFidHFsw48ihPgi4iWILS+DNCUSBlCdA8K7t5AVig3g+UbRehXnAUEhEHI7M4sgDSUjtJWnHUORssAY+cSz3ujCIleW88u5HdhBktgJ1vBJKfsJaFDmVKfn3xTi6SnBV4H6CIRp/9C0HG9TaYwLyWg+CNpNs3tzgYdWpTdd/5DB18PioKi8MK4m7/+tUf454sPllJZ+fPOs/TZ4Ls6x111JZtK/q40GPN8iqV9+pAp+MCGslPP164IO8JS8AeMDhfiqd8o6aks3JYrIea8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqXebtTdTZNZG+Ngb25VutqgeNWp9h78lESAp0E96Y4=;
 b=bxOEK938D1pMfEHvIta9zqPc/BiDKOo1Nw72yqB9RrmJ+pd0R14tm8HyFPv3Fy741CK8DuPuCl6YRerw/EN6thGP4wR7+Ny/J1rU6e5qsOhqqqitFEmLlVpZ/PVicAuPnzsQQnO6kerw/g8oHVkA4hr11AFFxOdEFAKU0UoHFQmkYVBxin6vOBMAjaJQHgPxEL2ojzGOQGR7UUIGu8IXbRMcn7s4Y6NrPb5C4YqgqYDq3bv4v5yQ9XLMIDsyuEVZZGH/YnnmGgFbW58b2I0lkibhb99SByvcTfrpL90AODyBvTkCovxSuliFfJlKGqX4iqXm2wn4abTBVmzwFTmDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqXebtTdTZNZG+Ngb25VutqgeNWp9h78lESAp0E96Y4=;
 b=gs4/7K7rDzk1s5aIyq/RCcJIJD5S8+DtJEt539IhSrRF6Z+qPkoJSlWArjMDCmMX0hRpGFChcGWDwC6YBkRtGYt2zp4X+PP5MRmZZtbfrOzeWc8omDnqu5umrhx8iuPrJuTxpgWiVKjQ9WFx+/NZCEPB76Q283rpKwS2YqvZJa0P1okj+96sK56NicEh65LXZ1CjhOEiN4Qm5gTKAC8j0+WT2f5h02GiJtKpEKhbSxEyD4EDPR+l4h2CnW9Sx44jMsmpNYtPcSDjHrtbJr6IfAfSpXGbImVXb7nZ24uHrPvSFQBI2ZS2+7KrJpQ5oV6hh4SxIr3bQSf7dO2js7AYTg==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYWP286MB3126.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 08:29:48 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::60df:b013:2731:f9c1%7]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 08:29:45 +0000
From:   inv.git-commit@tdk.com
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH] iio: imu: inv_mpu6050: read the full fifo when processing data
Date:   Fri, 23 Jun 2023 08:29:24 +0000
Message-Id: <20230623082924.283967-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0104.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::20) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYWP286MB3126:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3d2406-51c4-424b-a5e3-08db73c3ffd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/LMLcYth/yXurcJ069QvGleKLmMt7X/4Yp77iHKaoDKECP5ooFTqgB3oJulhN365Uht47bALn2z+kVrV5p+tfz1w5wJt3JZ1LAvDnLM5LqM0d5ktlN1S+0re7FWmISNU9nll+krJRIHgIsPI8YoV8T8jiSVPjOuMSku5bOcqwVYcG/f90T8feZGQzJT6AgBXG4yIhdrpYpb1lEilEzPfge2Yq7k47O0b/A1yPfOKYJXXAbvnZ41IiMcByIeS+DsR6bNwAYFqyRFcfamwrEkYAzvwqf6vtpIhSx7g5mAOWrQ/Be2uWJlTcJMvLVqb6poYmYbQyaHXGzg9ge2ZVwGFL4sw2xQxl8xEWtUKiOuv5xjNRYVFzfoMHbQCaCWbnFA8EtV4aCDk+0D4ZbNbvk7O5egoFhrh5KwWLtJRx8agb1lhl8OdE+FQSKyWAljwKRFR7uBbdifV9cLSvUaVxhQG4smuqc9/nrTmU46183AEyLJ1dAaZayXz5hMEm5cyAYDksnMzwf0oeEk1paScoACytrHAbPemUhXvTivDaZomiqtVjhs/cipz6/oNU9sKdTAxNS5sPO+lf3qLMYFDAGu/61BecBNqJuMuvSwvfhDBKPdEj8LsWLJsEucLWEyNzJu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(6916009)(6666004)(52116002)(83380400001)(6486002)(186003)(9686003)(26005)(6506007)(6512007)(86362001)(2616005)(1076003)(5660300002)(2906002)(38100700002)(36756003)(4326008)(66476007)(66556008)(66946007)(478600001)(38350700002)(8676002)(8936002)(41300700001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wkucyYgoFRa9fAkCvMtnz/prGh+nQtO0h7C9T8le5YEa0usJOUXDnYK2FdXx?=
 =?us-ascii?Q?0zmq4KPCTtUjLnZn7UDzMOy33M6byVwBhxr0CQZUiMXkQ/vrOQNuh3T2A19m?=
 =?us-ascii?Q?ocPUrjYCY5hCc1IQYhBCRDqmy0x2etn6vCBARk3gLinpKD+wUJbCc/K5vgy+?=
 =?us-ascii?Q?XKoFARrQHdHqfYiK1uAkuEJ7SPcXDpuRr1YbfaE/o0IUb4ZCH2A3sqPrNvdY?=
 =?us-ascii?Q?+HUwoKOpZ7Q59wsXuhcvK+P37py+tcI2OI4efdF+G4nYnIs80nCFB5iasl3G?=
 =?us-ascii?Q?FrVf1MfGYpuyMJrdD7qXKc/8mQHMQ+AHjJG4cjztvSk1MkPipzTe6l8rRJaN?=
 =?us-ascii?Q?KxDePmn7NLPc3tFPRqGvQSqapiUKHypem6QmNlC8GFuEQnULQAYQjm6a1uV4?=
 =?us-ascii?Q?FZmJFz5ltVlQpdAU6GdXgVs3OyExD9Q4KplbcoIiZsfmaLOU6AKbsgKEW5ol?=
 =?us-ascii?Q?hdhtpMKpze02LM7kp/8FkHVAoCtS0cTb7q1z1MbUrKZZ3fHh9Q7DOIvqOOhh?=
 =?us-ascii?Q?koElLrTkmEHrgYIYOaIqvJtS6ei37hM7gkZnCiBWRnaSBEbh6hOfG48UMY/f?=
 =?us-ascii?Q?Im+hmbGFyzY+ndShFGe40Wj1kExjeiTz9CDniQDyQcrVP6MT42VeBR8aNZ25?=
 =?us-ascii?Q?wlSqoaOncapl/NQvMPfzq/zW9hYRHl9bFGs6j2F8wLjWENYBM7ZoGMcdrsgx?=
 =?us-ascii?Q?/dfgtK3b6HGwPOwtWKodjoA87AhsYMYD6uB1Ky6i2r9379dHRnamG1P/nTJq?=
 =?us-ascii?Q?SVQSQdTj/AR6l4wMhbGDCqQswtAa+Rk9snjxlxaBOiAG579v99pj9J1H1IF8?=
 =?us-ascii?Q?8BLqEsyHOPbbTaP+ok17eSP1krRAY89JuH/A3BH2BErMwKVfb8XXAucwBnfL?=
 =?us-ascii?Q?0R/ZBUUpzUnvQz8jCjV4T9ug33qRsSUSLQGuk2CIJal5hT2zVlyP6cKES7Ne?=
 =?us-ascii?Q?BAnqTOCoarbexOzV6MxDXe3QKg57A2gTeUyBfnl7aEBWVulFef039wfdZ9F1?=
 =?us-ascii?Q?iD4ksWsjQRB5QA2Lz6oAuC0eEL4hjbDWdfUZE0EjWq8kQzD4WuEvPj4RR/Tz?=
 =?us-ascii?Q?ePnqEqfR/ssYYkDuDVbArXznOkcB01ZbHHTeH4V1AtplAVU9FuJB4Q6eGz6d?=
 =?us-ascii?Q?xWZoIrETTnxzYwnacDHfXr9YTNjZpRourTzibNG5+DnWxHtt7h11bs9s5sCm?=
 =?us-ascii?Q?EQjbRvANr9Tm/6OqK5FR5Cf+4R6erXGbBYtRi+FiznxIRp+XCmUNqa44OxiQ?=
 =?us-ascii?Q?0D2W3WZQbyejfoVQwvJelaho2jfYpjmNCG7Q7/ArsogH1Tln4v/noyTXZRM5?=
 =?us-ascii?Q?f3ZbyoHEmllyKuivPw4sSdHSMQx/inUjfgIkPydUR6v9Ar1Tp/Rs1m97XvAt?=
 =?us-ascii?Q?wlH5Ugwps0do9CeRejG+PEuHFgAAIz0MOR8SOfaNlBVnZC13jFQ2O+N0dyBm?=
 =?us-ascii?Q?nyb1ewM9YXyOuyyrpHtcwzaqg29+VOWvdi0IIGdrL5ycR5Th7v+WLdII+4hs?=
 =?us-ascii?Q?7sUCiJ1g9DNfhiYwrEBqiToGTqshQizeUdVmJx4VW1Jnhj6/8527g1587wZf?=
 =?us-ascii?Q?0JmNr94A9H31d3mJKsOEnHl8+bio4Gp6Q0uGAml+?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3d2406-51c4-424b-a5e3-08db73c3ffd7
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 08:29:45.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsDagi7O3C37r5fMn3OjgkdAmTIQr1YiPfQDB/AOCU4vyr5FEAKOcEoXRykDdeAL+jp36IIrJ56kk/9NpH6K8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When processing data read the full fifo data in 1 time. If there
are several samples in the FIFO, it means we are experiencing
system delay. In this case, it is better to read all data with 1
bus access than to add additional latency by doing several ones.

This requires to use a bigger buffer depending on chip FIFO size
and do an additional local data copy before sending. But the cost
is minimal and behavior is still better like this under system
heavy load.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  3 +++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 19 +++++++++++++------
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 13086b569b90..29f906c884bd 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1345,6 +1345,9 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 	st->reg = hw_info[st->chip_type].reg;
 	memcpy(&st->chip_config, hw_info[st->chip_type].config,
 	       sizeof(st->chip_config));
+	st->data = devm_kzalloc(regmap_get_device(st->map), st->hw->fifo_size, GFP_KERNEL);
+	if (st->data == NULL)
+		return -ENOMEM;
 
 	/* check chip self-identification */
 	result = regmap_read(st->map, INV_MPU6050_REG_WHOAMI, &regval);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index a51d103a57ca..ed5a96e78df0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -179,7 +179,7 @@ struct inv_mpu6050_hw {
  *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
  *  @magn_orient:       magnetometer sensor chip orientation if available.
  *  @suspended_sensors:	sensors mask of sensors turned off for suspend
- *  @data:		dma safe buffer used for bulk reads.
+ *  @data:		read buffer used for bulk reads.
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -203,7 +203,7 @@ struct inv_mpu6050_state {
 	s32 magn_raw_to_gauss[3];
 	struct iio_mount_matrix magn_orient;
 	unsigned int suspended_sensors;
-	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] __aligned(IIO_DMA_MINALIGN);
+	u8 *data;
 };
 
 /*register and associated bit definition*/
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index d83f61a99504..66d4ba088e70 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -52,6 +52,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u16 fifo_count;
 	u32 fifo_period;
 	s64 timestamp;
+	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
 	int int_status;
 	size_t i, nb;
 
@@ -105,24 +106,30 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		goto flush_fifo;
 	}
 
-	/* compute and process all complete datum */
+	/* compute and process only all complete datum */
 	nb = fifo_count / bytes_per_datum;
+	fifo_count = nb * bytes_per_datum;
 	/* Each FIFO data contains all sensors, so same number for FIFO and sensor data */
 	fifo_period = NSEC_PER_SEC / INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
 	inv_sensors_timestamp_interrupt(&st->timestamp, fifo_period, nb, nb, pf->timestamp);
 	inv_sensors_timestamp_apply_odr(&st->timestamp, fifo_period, nb, 0);
+
+	/* clear internal data buffer for avoiding kernel data leak */
+	memset(data, 0, sizeof(data));
+
+	/* read all data once and process every samples */
+	result = regmap_noinc_read(st->map, st->reg->fifo_r_w, st->data, fifo_count);
+	if (result)
+		goto flush_fifo;
 	for (i = 0; i < nb; ++i) {
-		result = regmap_noinc_read(st->map, st->reg->fifo_r_w,
-					   st->data, bytes_per_datum);
-		if (result)
-			goto flush_fifo;
 		/* skip first samples if needed */
 		if (st->skip_samples) {
 			st->skip_samples--;
 			continue;
 		}
+		memcpy(data, &st->data[i * bytes_per_datum], bytes_per_datum);
 		timestamp = inv_sensors_timestamp_pop(&st->timestamp);
-		iio_push_to_buffers_with_timestamp(indio_dev, st->data, timestamp);
+		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
 	}
 
 end_session:
-- 
2.34.1

