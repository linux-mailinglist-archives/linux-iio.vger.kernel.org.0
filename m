Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942C04F117C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 10:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbiDDJAC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Apr 2022 05:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiDDJAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 05:00:01 -0400
X-Greylist: delayed 631 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Apr 2022 01:58:06 PDT
Received: from mx0b-00328301.pphosted.com (mx0b-00328301.pphosted.com [148.163.141.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0283BA4D
        for <linux-iio@vger.kernel.org>; Mon,  4 Apr 2022 01:58:06 -0700 (PDT)
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2348IpAU008727;
        Mon, 4 Apr 2022 01:47:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=pfpt1;
 bh=gN8Vc+h2zLaR6sTWDmzIe/OmWiwKfAMM9gh4qaT2O/o=;
 b=H1G1BkA/fT8unzjH8OetvvP0j9OJhRgWySvucjP5BjTB4kuwEARV9wgWBuf7wsEVe23w
 fyBLu495raw/KT3i/+7VhBEPFSBSeEkkmd/tMuM4yiFnagqV65rBHzO2X84nebjrPsQH
 NskzPR+tjWcBeOshP0PRskkqoxlGFA9oT7T24tYcZODtDlOx6OyswRTRm7uvbgOMjuR1
 yowPjxiAM/6+n/DD+IG4RBn3aTjZrSv8XPq+3AODLDqvd+dQmPbSWVpOKrhTxEbh1Lp8
 t0MNYWNVyKOBb+Vz7Mhn87aFUfXzRIFKmtRAYr0BE5w6zyajAZUiFFUTMsECDwl0+y0e Ng== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-00328301.pphosted.com (PPS) with ESMTPS id 3f6jemgu1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 01:47:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPxfeFaBYJcwRTIZv4FtzBhhq+SPDNcmNpj1T+cu3b1pxJAEgG3zJGzuLEkEnFquYf6NQFragiQ0AbWOmdcTmNhJKDG+kGysy0O0z3Sc+Vu/Bup4zS2LzYsg3gCr84h7wZU+wigMdZej1C8hbpHB1H7zbn/vCuV3o9oiIokhrPwpinJE7cZHKbRHbRzkb78UqjxTDHEpOx9vLkgjmeiOx7D7GMkzr8V/yKAVhAxEgwU22WzcPk/dhsaMT1LXOkje6r4kdpdTAC4nht/doHWv3iVSaF6nvVZqYv410fmrOuhoL/nL772hPr1fXjcgOY8efcM7kOkGvMS/P47FmqJ5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN8Vc+h2zLaR6sTWDmzIe/OmWiwKfAMM9gh4qaT2O/o=;
 b=EkeenjUi4F1CfEGDHpEjuMV6u2gMgCKSRr2I3twLDwtkWoeStz1n1TUpQoP1jldkwMiDbHz+DF0I+22EIE6znepL13hOE0lee6O9qBOpvf8vIqhj9bxdc4QVEMPsSgfkjghGeX1S0DZsnFpl5ZxTe2AYvtIl7GKt1kfOQNEr30WmCNAeF73I6bzN222sPkhJBtbuXk/UW1KOTw+52aU9rCUwwtidSJz/GF9UVykJFJkPoeiAlgoyONPzw1RM1vnWq98SD1wFUOMSyKXeHK+2jogmioV2LAEsxQrkpxUdlX+JwuehBQmZEfgTM7wfjF6nw93K67FWSFZcciixcaQ7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN8Vc+h2zLaR6sTWDmzIe/OmWiwKfAMM9gh4qaT2O/o=;
 b=ZX3Kvt2eex9x4YrN0m7wOyM7mXOOghU+nfgLwFOF6CwJOO8/fdTHDvbKvSFVo61EaH1MAvJ185qIxKkPUFxXhxoXlel8OtW65wgyQRQ5asUo9aeGu8I5zc2O2kPWZ7psp/LPJ8UFQNrFJ2BN8cbgx8PfUW60Jjx+ncM+UuIJVGA=
Received: from BYAPR12MB4759.namprd12.prod.outlook.com (2603:10b6:a03:9d::16)
 by DM5PR12MB2408.namprd12.prod.outlook.com (2603:10b6:4:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 08:47:10 +0000
Received: from BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::64cb:4c54:5e87:543b]) by BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::64cb:4c54:5e87:543b%4]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 08:47:09 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jmaneyrol@invensense.com, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Fawzi Khaber <fawzi.khaber@tdk.com>
Subject: [PATCH v2] iio: imu: inv_icm42600: Fix I2C init possible nack
Date:   Mon,  4 Apr 2022 10:46:50 +0200
Message-Id: <20220404084650.17377-1-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::23) To BYAPR12MB4759.namprd12.prod.outlook.com
 (2603:10b6:a03:9d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cbe4c06-cfe1-4e9b-7c53-08da1617b474
X-MS-TrafficTypeDiagnostic: DM5PR12MB2408:EE_
X-LD-Processed: 462b3b3b-e42b-47ea-801a-f1581aac892d,ExtFwd
X-Microsoft-Antispam-PRVS: <DM5PR12MB240824051E929E8902A01EEBC4E59@DM5PR12MB2408.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCakbx9aXc2EzKFCUREQ6BeWXbWBZ25H5mSegd00hkEacd157nk9A4yi8gKzlgcm8D0tKaK70MMVWrPKFDxqqcXpPWb5ZzuWVQabvtc+5wbhu9dgw65Rr13zn03Bkvv/67L+1eSQcP96XeX+Ib+OWFMwZcLp3MyGd+NiZO3n+LOceI0TZWKOCpJEDa/LaXHCZWAZbH5ObsIfHpZLsKel4AeBR7k39H+JoTmuAERqvRC8QDv7tnnUolMLbh2H3PsDeMrucJ66HNcOPWSnysdfjsUU2txlUz0xRLwMuEqgIOYYMl0/uhjElgbU9TwCSsCS6QZthOfzGoLLsYQiaMkXYO058aOfON3+Yg975gbIVM3L/sL3Sl8zAaN4rDC9eet+pTj2+A0Ncn6VDhT6HKeotFbpcczAFNLuBAZk2EIy0hFwaw4lsnKCnpKKHT68YQsNzSvfAub2MCYCaZz3eKQmqB6PI8aSm1Sjf9yH705teRBDG6VkKJEP5e4NEnIw4w1CRhX58TYFvlDqa/Qb0McQWIPjCM0mzirtphVcM1ce+HstTvvhUOCjoPZ0J0eEjqBHq1lSRLy2gHZDmmj0MMlxzfjflkzWSZ3DBSQT2Gq1Ol6uucgt/KXyybF6wWFopNP+gNOYBQ//frEAEjk+UepfF/ggz19bA+rsTBFMLjS9sPVt2VfUZfLjJQs1Q0Ae2OtUAsr0QTKlM+UrR+swVgYehw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4759.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(5660300002)(36756003)(6512007)(6506007)(52116002)(1076003)(2616005)(26005)(186003)(6666004)(54906003)(6486002)(316002)(83380400001)(508600001)(2906002)(8936002)(38350700002)(4326008)(38100700002)(8676002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0YgBkaEM6lqnpJr+IKBcvSmlTJTDbJlCfxpxAroGj49vMN6h4zM4THwrjr6N?=
 =?us-ascii?Q?nldMCQMwTCYzETZkasOE5fOsSm0mr5ueQa6AGTHKYZGHD+qfiehxaOFTYXqX?=
 =?us-ascii?Q?hfKa0B6R9Ah6hCG3pBRz3jJhqlEkNBpKOjM9G3uagLZ6e5UcM2R8+/AJfExl?=
 =?us-ascii?Q?RRVH0y7izAcagbIxxZ8LuH0yZ/uYgrxNB8+ZYMhNNugSvgORNmTCGUH6nV0s?=
 =?us-ascii?Q?RAyI1fWu1Px2u+JElf3O85Cx6cOyU6NFGObv5uX+mzUP1cIXC/+fL3d4FrOf?=
 =?us-ascii?Q?EVyYDVIbyYw75Pgx9o3OCJc5T4ii81S2Bo1UtL+51BguUYyz5A+kpI6AUZkK?=
 =?us-ascii?Q?D/cdjYA6kE5irzNtA1CUfKNTJVjEojV+ysi6uvMgROF/rGNpJA2nSH94jH3P?=
 =?us-ascii?Q?XJIKj8JD+Cc1BBPp3f+ZJhxXGk8AKRvV6K00WVv0GFt1x/79Y+sHTPNbNhQD?=
 =?us-ascii?Q?7xDOjU9Vjc6jqVvF1kYjSCmGgUJw0R1x4vAyVU8feAuWpvMawA+WeOnIxO3f?=
 =?us-ascii?Q?/0dd7qxyAUXKublpAjH8eQ7oFlH0d9jki/LxqF/Fa1cHm+PRViVw2fMX2v1e?=
 =?us-ascii?Q?TosXVvSTcGBYsDYYgO9Pgsx6jbHiR+y2dZnoGSxvYb4pD5Ce4QA/oKL0OM2b?=
 =?us-ascii?Q?4NSZ7CnSjwNJI3mxHyxPsQklVqH8SERQYmGGLV0KiLN8c8JQKNAe5GUDmJle?=
 =?us-ascii?Q?7Z0eIHKrYQczDAPjHyoy7paFM6rwso1OgMOKvyn02g7PDCW9lyr3dfANIdge?=
 =?us-ascii?Q?BxyEyKbjuEOYOWK3xBvtdfB+Irr6GrXDLqHDZ+mRMunsXLf2KcatOJPazVCK?=
 =?us-ascii?Q?1uOulUJ0YifqlGgzqQ+Io+OtbV8QUh/0o5+Wn4DoY5MWmpOHbXP9fzsDgFEH?=
 =?us-ascii?Q?ZPbmZpFni/H8FGKpo5sqvqivDDFW7kiuKc2v/pN8ef7MQIlpCiL8ehvAF7FS?=
 =?us-ascii?Q?PZikRjWAs6SZBHhxVodY+V5g5n5Y6amASM1c0ICgXke5LzZyjklc935+E7yF?=
 =?us-ascii?Q?lcyw3puxEwO//BaG63gd7HJsicpZhtrH/AAiDVahtAL8ykbAeGkm2ZCZ4DRk?=
 =?us-ascii?Q?QMHorsxapjS6gM+yHr5waYhHbSEFN2cFOnPSwtcOeFcrtkyxR3pzCCOmqg2t?=
 =?us-ascii?Q?8Eri+Lpl5qdCdArP7WCJORd3xHQy8vahaQw3cmixfoyj4k5e58aircO8u6Pv?=
 =?us-ascii?Q?5wKpanD8kIfsAB6aDndsqhNPdjNkQfZuxrYBykoc2n9XMCtYqnvqPdMrrPpm?=
 =?us-ascii?Q?DAVnIpqGpVxoTflnzot3bpHASkAMFSJasV6S9/bPHk5O5FIWD7Frk2WPqe0y?=
 =?us-ascii?Q?S1mJijExJAR61PhQm4a6Pvsrw19HLUL+Cruk9eu+QHLTYR920BQpd62/lCXk?=
 =?us-ascii?Q?3RhNmnU4dbrFmp/p5vI2LRks3A8NIySNFhygjVa2GAlEez/3EHbmomwe5GCI?=
 =?us-ascii?Q?GNCMXU3Z8WjyIS7iwSwof57bYuE7y4AFhsQElesRDc9NQOHGZcwR/O6UqLiO?=
 =?us-ascii?Q?8J6kviSCXYCnmY/bDxog6RB21bsy8apYcFofI1YzYaIs8UfSG2hnBf9FT2qn?=
 =?us-ascii?Q?1li0FvrPSAoczPrV9pY8I7ZgRtvgr6ayQ/uYdNDMFt/UPXz0VJUMC8UOVyD+?=
 =?us-ascii?Q?nigCgFwgegxQJlqdjhX5E8bCurCrGtt1/jnt0lXOJwocv3IFJEoHI+PQnNX/?=
 =?us-ascii?Q?aruTvp+MOJeBZlHEunS8AvUohMfBFnQnJu3D52usMzFZs+hB4BeI2vc/Zjzt?=
 =?us-ascii?Q?LDUYnmtH6N/iY7TRJgRJfDwrW1raTKA=3D?=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbe4c06-cfe1-4e9b-7c53-08da1617b474
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 08:47:09.6125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSK+kpa8xXfAwLWJT3v8tX+iMoq27Nm81kAbfOKaLXK6P9pSYLdUBSqsvDMT81sLz/cMWpaN9hfpaAclC3+0j3Q17nNe94Zk4ZZ0o6+3CAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2408
X-Proofpoint-GUID: qODqAi1tFgHKlCbDJFOiM7UEc1HuGWCB
X-Proofpoint-ORIG-GUID: qODqAi1tFgHKlCbDJFOiM7UEc1HuGWCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_03,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=857 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

This register write to REG_INTF_CONFIG6 enables a spike filter that
is impacting the line and can prevent the I2C ACK to be seen by the
controller. So we don't test the return value.

Signed-off-by: Fawzi Khaber <fawzi.khaber@tdk.com>
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 33d9afb1ba91..01fd883c8459 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -18,12 +18,15 @@ static int inv_icm42600_i2c_bus_setup(struct inv_icm42600_state *st)
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
 
 	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
 				 INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY, 0);
-- 
2.17.1

