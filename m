Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05AF4ED6EF
	for <lists+linux-iio@lfdr.de>; Thu, 31 Mar 2022 11:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiCaJbx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Mar 2022 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiCaJbw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Mar 2022 05:31:52 -0400
X-Greylist: delayed 1079 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Mar 2022 02:30:05 PDT
Received: from mx0a-00328301.pphosted.com (mx0a-00328301.pphosted.com [148.163.145.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024A018D986
        for <linux-iio@vger.kernel.org>; Thu, 31 Mar 2022 02:30:05 -0700 (PDT)
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 22V90M4i002901;
        Thu, 31 Mar 2022 02:11:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=htMHvxhcvJ6Yht8mPDnGKBDdBA/7v6KAjJMRUF5FbgU=;
 b=LTLMrxJtcxQ/bgsjE6Mi0+HaXMTdfHc/5UcV8nbWqcPiPQFrAvskdJ/Pp4yzhM2pCRU0
 In7sspIGZ256T3EDUTgVY/+0b9LlhHu+ClmgTH7Hqhm/RXU1GnB7AZWh9yckaAYmMd/z
 rPCZisAFPptFWN2tFAEgYhJZYBKFLOKRQwjJ1VPOfq9LKWDnKBbSPm8ze9ko04eJgSew
 +ucbFIyl2+3ufazOZOuMpvuCH83w7WadW4Qt+mRy8uQhi8XAC/uvJQFg7cJ3lSq4rsuO
 iFhzp4xSFmnpSvA5VMNI7q51JvgK4zW2hOoJhZyZy+c/JhICSOm4S4BYPb9USN37nE+v MA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00328301.pphosted.com (PPS) with ESMTPS id 3f1xak2jar-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 02:11:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBmfmQWp2CjGo3Qe0kBUcnFJcbBMAmLX2m8nCJWJRJW9UGr/fHjbNpt3DpxX5JySskqdD5KQpz6akWNmcy/jil1k80VYP5bzxOu0JpJZY/BLJtZXRVam0onedMYoTx9hAub55oMWoi87DcA5DPkwFDf7NSEKmGhIJOupn8M4Z1Byo0FosaEMw0kJvnHRHOlV8eEeeZEG26SVMqQLt21XiFT36nei3yASC3052xLDwd2tJARDLv69+F2QNY2Cg9hM+VP9uh1PLjtUITIFWd2TqCWsGIS6Pr5S6q7bEk2PcZS/EVtm0BHr+Xg1PiXyd+Keub8Q02O1BU+s9jCC/gP4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htMHvxhcvJ6Yht8mPDnGKBDdBA/7v6KAjJMRUF5FbgU=;
 b=b4tySgJfjsFKpboTMlAcnV5Zj2/3josLfUzjWRPpYKDfa5WykI1oDFzFhLh+YKwdCduNApApql5hLdrtYwaGRMhSO1yd4sMKHClJLygqVvO3wAesE0dahJnNvq7uEb1+ll7jP+diV8a02mmeN26snQZYa5H2k1YrMUR3DTESM1WGZReQvmtKNw2hHSapzJMDJVAeSMEtQjKK0S1S/jRVLBDIEWnp/Ekte4IOZY/hg+twitgWKIghGndZVgaiA6GaWIAphFf2QWG1MQKJjWpKi8R8kBlXwBkbFzFx0v1Ciwh2i3LPQ6wNU6bGNwrdmwZ8A4OG1B8BcAgq9k/d/fzIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htMHvxhcvJ6Yht8mPDnGKBDdBA/7v6KAjJMRUF5FbgU=;
 b=IWKdsgFbWnP5Ii1rlJypLKeKeCvBoZJEUfZOu46utTBdTgccEWxfFEvQFyi3dpR+2CZsGfuFk/XqKLchK4C6y6GR0MAC73qsdkVIsicQI47NjpkDfkdZ2JApvHotapjZ1+PRNv8bq3MT3GDP60RZmTGAP7LOtP8sVeGUnP6jqzA=
Received: from BYAPR12MB4759.namprd12.prod.outlook.com (2603:10b6:a03:9d::16)
 by MWHPR12MB1677.namprd12.prod.outlook.com (2603:10b6:301:11::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 09:11:40 +0000
Received: from BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::64cb:4c54:5e87:543b]) by BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::64cb:4c54:5e87:543b%4]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 09:11:40 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jmaneyrol@invensense.com, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, Fawzi Khaber <fawzi.khaber@tdk.com>
Subject: [PATCH] iio: imu: inv_icm42600: Fix I2C init possible nack
Date:   Thu, 31 Mar 2022 11:11:21 +0200
Message-Id: <20220331091121.2680-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0140.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::19) To BYAPR12MB4759.namprd12.prod.outlook.com
 (2603:10b6:a03:9d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17b3b27a-e310-412b-825e-08da12f67788
X-MS-TrafficTypeDiagnostic: MWHPR12MB1677:EE_
X-LD-Processed: 462b3b3b-e42b-47ea-801a-f1581aac892d,ExtFwd
X-Microsoft-Antispam-PRVS: <MWHPR12MB16778599E2D4120E9DD95423C4E19@MWHPR12MB1677.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/MfqcBjRkdm2EAv2gOTS1rOluz4JAzOt2eAhPnz7jGdc+52gHZZq58d64ZrGNAHPBsb/r70srihOHfRx5n5lKEtpKDgCyh5AwPkAVyVgLwMQJyKvk+8NtX4uNbNSMbosJ7DVn4NRc+WD7cU50Qq5j34318q8+6sp10GoiUhso2gF4C3Dc8iRkLTuZUVT/oA2a2VsWmjf/AkqGSr+eoGb+nwmdvAKUqTeXaYRnDWDijevDIj0LXwIcYqnEZv2nbCQViK2nx0af/Ja8seEeJJw+h2+K+I/mZpPk/jrHOUJkCEXX/o0gnCFgA2qS3boNZjhkZjoZ0pMMBW2xLTdtSJQNmQ1xZr1u3xh3PDWAVeLYh3+98jeonLSBCbrmcsv31Ja+zbugeUxW96GEaC+eOxwNwaF/0/9uYAMFjTBaODFV+X2ZDBU+cRlOVu5ISvE8iGA7QA41JXIpyWvrtx9ouAtqIf8id82qHPqmiZ4fHYNof0ihJsRcIAjrqkRlBX59J0xnVWJBxPLurilaXiJXsGxre5P7/J+nTCFAXe6UWpcOlnNuJu38G6/HwMgr+XI3UFgLUW/9LgPwnzhl9e47QQSVLk2+9SA9OaC17dua+jDrN2A65oH4zX7DF1qS1YAyOYumKwYIOD7Vm9BcPaz9cYeQE5y+85kKPo6Si8MU6d3+wBhAKV1cKV2JkfR69CZETu9cS3uCU9KLdWgYH1mJGmow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4759.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(26005)(66476007)(83380400001)(6512007)(66556008)(36756003)(52116002)(66946007)(4326008)(8676002)(6486002)(8936002)(2616005)(6666004)(316002)(1076003)(5660300002)(6506007)(86362001)(38350700002)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/SbLN9jOcHD3NwnlDZfN/g0qj1/YIEK77h5/boNxwodLB7op/TbJs9mM3gzf?=
 =?us-ascii?Q?L1fXXYj2LC+0VczqIaiWiqageVO3jm5AyScEnmqEhAsTpRKjKXC5jp8NfzF0?=
 =?us-ascii?Q?pQrHrNHISUvwHyFIX473ak83t3MBQajs4ZcGo0eM8cVIWPfun29BVf3tVHIA?=
 =?us-ascii?Q?nHt4dw98lQrQpCRLXzIboPi/DaNHfrS9x/us1piU+6Wo4tDAvl1zuxzsip+g?=
 =?us-ascii?Q?lja1+51ozcrtUoC2PzXkzXrq/UGvTS+zZyMdpltqbHME0ZjQXpse5IS7XEcr?=
 =?us-ascii?Q?mmfC5OUOGe4Wf9e8aZzv3nWC3JhDNhDlmyvq+U1FCst4bmA9wHD/N1k/j/r3?=
 =?us-ascii?Q?45CSQ46PzFe63YYgNuBEnEejlM/X1+kYr259EpeG/jIF7BUZrO7d0pYWG0ia?=
 =?us-ascii?Q?I1HtWjLrO9H6/2gHEADEGaZAN5JSxW644G0T6BBRtAyXgDTsJznwNpBLHes/?=
 =?us-ascii?Q?o1q73V/M14GjHTwHpsqu/RQ/Uvu/AXqtHRJzvsmlSH2KbbbCKHOuk9sGw5WY?=
 =?us-ascii?Q?SnLpVS50D/yBU3R5tq/0PYpxWBajiVnEGPRLry119cnxiL9SEMBqh0rdnIqO?=
 =?us-ascii?Q?RpvXxAHNfB7/kGpQx9xoee2tm6StNcke0J1QKYSS0vL87JU5REb8fUC2RDfG?=
 =?us-ascii?Q?qJ56aRQPlt1oiI28Rc3Yt7ioyjtW4dtP7fanadYEInDvHgw0BGCLldd2L6fm?=
 =?us-ascii?Q?m9DUTUklE3aaJYUDXGsi7y29sJEqTcdeg/9Fw/LCrecOLeAv2i7/Ai4f/1Lf?=
 =?us-ascii?Q?Qvqs/n+4ouhJwZZrlLDcWVfIRuNTGM/ErZlYyF4fkhgPqcpaF1W+Vh8h2+5m?=
 =?us-ascii?Q?5PgFAfkIbVsuIl9kZJsw19hgnuvU4SvQsNxKXo2iKxWCeuGTrDVkb87+y3g5?=
 =?us-ascii?Q?aUrsXuaLvMgsQhTgKv+90F3/0ekxyyphawEXlpO25prkvJS/skLFap2grgYL?=
 =?us-ascii?Q?EHDi6OCmAJ6koZUlZQvFbeRBcVpVx3dxVjSngabtJ0vbXTHSXPhnMFshp2hD?=
 =?us-ascii?Q?1L4Z9Jl06FPcLA9onl+KyKHyfTDZy+cDRyJuY/HtoH2wUjTQjNUenjYIfC86?=
 =?us-ascii?Q?chcbic9Jc2uA376zz+BK7SoS5hXu0FAafhDGlams9m/jhPdK1ozSlPFxRkYo?=
 =?us-ascii?Q?RfYPwlpyoKw16houeeOSQdUMIfDQVWDSh4drRzgMLs3oLwbpvEdxCkw5QXd9?=
 =?us-ascii?Q?hLOdEBLJb5K8OZ/QXXKGM1lZJf4h2K8jXTxDnsCJHAPU45RaaWUiJl0THZRD?=
 =?us-ascii?Q?Hn1Q9B/ng1Fico73bPFG6Q8Wz0qZuTvfvvLw5B6dX+2jNPT1Bnf29AmX3Pz6?=
 =?us-ascii?Q?KCvtkJKXZqWxmZge8eOoQB/LYhIl/HSd2xjuae9dpnIrsjURo5CeD784Rgft?=
 =?us-ascii?Q?yCwfBihq6a5xaSvBDMcxz5z04REzGe9cLbd1xWtIJ3unaFofvXaKLe3cUDyB?=
 =?us-ascii?Q?ZfCssH9CgMd3Oz0iVXjZmhgDcCm0AIpqCwNS94s+xTI/IEVzsqlk/8wrxgrJ?=
 =?us-ascii?Q?5FnDMQbAP7SRJMW82Ht1jcSE84lTFQi987BhdvE+i6C+6NmOfp82M9+yR1/s?=
 =?us-ascii?Q?K3yq803SPW3qmKfVgZPu9UEkfaDZxe/+z9jvatkkAdcWw55NGIG5USZU9b9d?=
 =?us-ascii?Q?zlApjRGHW5q4H8RyAUxQRMOD7byJZKfVWkMkAkPhhUoRtcTN4OQyywRFc7HC?=
 =?us-ascii?Q?fAxAVOovcVHSRtKdT2jNdFQ5pPUsL4BHhFggsZMb/qTuflKu2scvs4OeWPfc?=
 =?us-ascii?Q?sSeP+Rh63FP8pMsU5xC6YvBnB6Mukpg=3D?=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b3b27a-e310-412b-825e-08da12f67788
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 09:11:40.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zcq8XnvCX6L64x9ZWTAdOGiCkae2hr86bIAw8h+FKzl4tEQLdGXcsmdnmDM9Fyu0sFAEcvvgoC+blbNyp5ljSbV6bt1oqX03COvlu4r9KQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1677
X-Proofpoint-GUID: Oq8As5aZJwLjlz5C9WjlKe_gfSsNDYYB
X-Proofpoint-ORIG-GUID: Oq8As5aZJwLjlz5C9WjlKe_gfSsNDYYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_03,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0 mlxlogscore=744
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Fawzi Khaber <fawzi.khaber@tdk.com>

This register write to REG_INTF_CONFIG6 enables a spike filter that
is impacting the line and can prevent the I2C ACK to be seen by the
controller. So we don't test the return value.

Signed-off-by: Fawzi Khaber <fawzi.khaber@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 33d9afb1ba91..9c1e373a5daf 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -18,12 +18,16 @@ static int inv_icm42600_i2c_bus_setup(struct inv_icm42600_state *st)
 	unsigned int mask, val;
 	int ret;

-	/* setup interface registers */
-	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
+	/*
+	 * setup interface registers
+	 * This register write to REG_INTF_CONFIG6 enables a spike filter that
+	 * is impacting the line and can prevent the I2C ACK to be seen by the
+	 * controller. So we don't test the return value.
+	 */
+	regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
 				 INV_ICM42600_INTF_CONFIG6_MASK,
 				 INV_ICM42600_INTF_CONFIG6_I3C_EN);
-	if (ret)
-		return ret;
+

 	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
 				 INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY, 0);
--
2.25.1
