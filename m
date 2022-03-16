Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA4E4DAF8D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Mar 2022 13:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiCPMZk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Mar 2022 08:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbiCPMZi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Mar 2022 08:25:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4837D4BB96;
        Wed, 16 Mar 2022 05:24:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22GBnC67002689;
        Wed, 16 Mar 2022 12:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=9iV3IFHzlIFL3gHFZ04m1JKR4FFq/t83wKSBM+77k2I=;
 b=EdMj0MJXYRdwen5Oqy+FqAIFcoAA81nkhbfd1laeFVgKhJfIvDme5dw9I2LRSqXiUTBT
 AErUlccj4jIgUQOZpKazCbITWd032Ek62XCNDFgYEtoqof2ac+4LwSh/71tUPIzRj5ZK
 MQ1usEr87S90SOd8vtjT1rvfkOA+d5JMqgtywFyo7XoEA/4pyyk8h7KwFahig7UkvmwX
 5cVMhxgx2Ph2xuz2TcXhDhJws1IRktN/ZQncJfXZdV6QzStGn8aZnMNaWWAb8io9wF2z
 p0LhCApPfGQuEZjuwr4NeNvC7VRdmAVwMeQhfOAh8SpFV3dL3YIcCzue1OCzA4o/nVH2 OQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu62wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 12:24:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22GCAuNw072482;
        Wed, 16 Mar 2022 12:24:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 3et65pxhbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 12:24:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCu6k2SLRhaNCRejEDiqiNHZIz79H2ZSAD1QuJoQBVYGm1L1Wv3Pg0KEP51+jyALOIcfmSehHyS5dR0Gs5BBQFjUMbPEyT/Cz4e15sSmOfcd1roi3LtH378yhC/3gBXLXcmN8zvQV9ixtuBuP8WHTIMf+YCGIyeu24cITBA/w4Xg7k2zRVQ1AqPs+g8n8yB6U6GJkSGWia6dOEtE9Gtcf8Lb6WYOgV9lTAJqiHeii16zj4K2bfzrWDmus0/YUoBZHxYCEPoZ98O+dwJe3cCH9XZHTM1wW+rEzEwXBkNYG27zaor9rqd0QbatW9SPrNqz3B1E0GXGhuhMaq0ebMIwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iV3IFHzlIFL3gHFZ04m1JKR4FFq/t83wKSBM+77k2I=;
 b=RFBbHQYVqHL38O2MhuPwJbjWbrHWLTDTo8E8MNR50bWSwG3il3FwDNGXX892ehfWUkDfyytYsPJTAHLlJaomwX5AeVA+h9xDulnommQhI5c/qvOfMvghIUoJZKZ007BCLCegWlWhNJZGnJEbcrA4La3qbbPD9k0kvMPf03NWTb+la3YDvPnReWIk4uzAzGtzPBDeQZ/dFYXrzuOH8iPpaHiAVXOixZUIr2xEe/87cKrNwOyU7vx6jSG/MRRGHi96QZQQoY1QqBQPRJSeKvpmmbOHsEipYzyrwGL3wOGMpWA3e6I352wc9/aukTkcJtDU8Z9s+IH/IOuSVUtk4vUy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iV3IFHzlIFL3gHFZ04m1JKR4FFq/t83wKSBM+77k2I=;
 b=pvUAgGOSnqHAIdE/FpVKY/BgObDW6wL2PSWd/RACLIRcs3ROaJRx/h6JoWUHp3SHHZaDxNuMxUlpXw69ibxcN2jubA9rF4ZISz35i8WtlmtzpIoHfSWu4nX+bKRZ+gueN3+07wtjZCQmN4hpl78kdJLmjlz8/7KKfSp1SUfA83k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1475.namprd10.prod.outlook.com
 (2603:10b6:404:44::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 12:24:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 12:24:05 +0000
Date:   Wed, 16 Mar 2022 15:23:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Mihail Chindris <mihail.chindris@analog.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: dac: ad3552r: fix signedness bug in ad3552r_reset()
Message-ID: <20220316122354.GA16825@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15e2f1e9-d116-414c-fb14-08da0747dcec
X-MS-TrafficTypeDiagnostic: BN6PR10MB1475:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1475ADFACE0853B5805B22528E119@BN6PR10MB1475.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bR/L3aY3mTM7pyV8x7Lf5VKEcTUAlE8mAPescOjG8EwzcuXEkPicr4r11FLfAfpCpGvZSg98LJfeqNgKX0jiMfo4CVnHk9XxA08TRDy3Drpl04rqvP+s82LvDOTdacYVRKq9w4duuNk7Vte2Kiq5MONJ2HTnDBSHtZWxFMjn+Y4JZpnjh9CzeFV5J4039Nu7xFR8+Z4MKH+VuaYyTnprlfSJePORWXFeZvRivgVELZgmq1+6vV8NRmnZZBRI6VyQCo2jvmskzLxgH/tyWo4FMDGhX3JNoo4szonsKD2dwMOxG3vUT+MzesL07QdMRseNotGhous0fnjlBFC6ViEVd4FMDaVMksHgzqy+hYHJxfq9zl7FyFsSK8ibQzAvAseCFApMbr3rqjmg25CGXanwLTQAnESYz7bPfxfVOWwi1nldY1VJbYOcpix4bbRvfZ7J8iN5PFymqE2A0RupA6feEHWKLu01OH3ONRLa/fe6itzpMdN7tNIP8K+heUKSUIZLD6oWnE40z9ugz4UT+huCf5OZXdwQTbF/j0UFeIlAMu0cVjbHc3OdBrC+kVsr6OQy7z2qXUYJFsPr7+vuwYQh2OZdfzUff/Wq1r8667TwCgv59PlRuLHc5+6FBJtliBOaN7FK9BuC4p4CEZ2qi7lTfJsDmFeXa6VPhuVuBvVC/EXXycbkg3cgpDe7y8cOG+I3LjoAP18A4z7SJqUTFxaGMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(316002)(83380400001)(54906003)(110136005)(1076003)(33656002)(26005)(186003)(66946007)(86362001)(38350700002)(8676002)(4326008)(66476007)(66556008)(6666004)(6486002)(38100700002)(508600001)(6506007)(52116002)(33716001)(6512007)(9686003)(44832011)(4744005)(5660300002)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rGo4+wjmmKxH8uzHw9QHzqzLYCTfDx3lep08fB5yJChPo0CJx9TH5ziRpRb+?=
 =?us-ascii?Q?V0rAvuXA4xHMf3DY3HO4seHkX/KXfqKGXG06PlHANYVxIZaJr/+HSfeqE77Q?=
 =?us-ascii?Q?HYMjcB0uVUO8NhhaKgFI4LG1zceIk16RnjVp3HLPkEMzn2tI/96j6WPXGO0N?=
 =?us-ascii?Q?HaziZV8pS6Pz/yUl9Xpas0cL9Qu9AMDWJCfJshLk2vvsFuR24LTSXMp5M/vG?=
 =?us-ascii?Q?5Lfmvjxd/N72BPbLeLzbEdDgsIehn+dGSdoSrz9NopPQOjNhPokOKvfaAAWr?=
 =?us-ascii?Q?GAK1y94/+770Go74OV7smqoOZdxBE4CQFT53odYuCbMMJXy8w81C1bDSA9Sh?=
 =?us-ascii?Q?a4lxWoFunMr4jpGCTgVLFzGa+hKETkBQTOht/VYe4zDhM/8fmkv//j6EPcpO?=
 =?us-ascii?Q?49ABEaqk3obygQ6EOACnsaIK3/PloS09IAOFitkzSep9KkrMgLeuvhJ3UuJh?=
 =?us-ascii?Q?wYm4v+lzy7th9yHBeFRLtRfiV3Iiyw/j0Q9sLww6ML6Tv0LbYOmskgm79qWd?=
 =?us-ascii?Q?nLA8DXGoq4bT2MbLTdMKHP/ofUthqnfjAAptrM2Z1cqOEGTt16YwDjBl5rY8?=
 =?us-ascii?Q?91qoARz6yw5eYT4EvBGOA44AKlBncTUvmhG7MR9FWGRGk5QefBsUdpAfD5R9?=
 =?us-ascii?Q?WtnYIABBR7nWXnnzL7OeH458zda945jkYHGdlfMS/Lv6GW2/co2s7ZKLYySX?=
 =?us-ascii?Q?7A69EjZb1g6kQ/otlOnTDS6xXnueuVic8qKGyCg4fW22eRfMO5afaM7cZAzm?=
 =?us-ascii?Q?GyHeKKrJrRrf12bd76VVGQ/vgLVpJud5l4BZ7xFwtS/EiWNFJ8Scth7t2yIi?=
 =?us-ascii?Q?5n6JP9Kdta9E4RqIzHvOYztSxlq7/RzE3k11P07I+7iF2EEsQfy32tGGlaW7?=
 =?us-ascii?Q?kcmLPA+f3YHu8iLurc+qBkWqgxRibwloGUr5+PP5u+43Xqh9AMCtMBqKCVrc?=
 =?us-ascii?Q?VbFH5IKuvNeSLWS5ILq/3MYHSRYbGfzmyWgTBnWv1vrMrzlosRV2QFlDMsf4?=
 =?us-ascii?Q?w3uOrd8ayIfpbOwx9z/oV+eb7/PVZYf4wbT9R/FUZDb7QSk6Hikuo4GkoYB0?=
 =?us-ascii?Q?/r9HjURDl6OG3i3QwC50c6Du3DpaMH7xctSY5/7SghnEnmiY6jYJr6Ztrsvk?=
 =?us-ascii?Q?lzNXd08kq0eSn4uZQdMUuE43BYBFNQvUJ9pOnWLLgEHWwmbZJvAlxNr0ITir?=
 =?us-ascii?Q?9a/2dx2CCDLgm3RgvoPGkVSD9kQ1ANn+8eWsQCcp0K4AEA8r/0yamp9/38bn?=
 =?us-ascii?Q?pSmqhJSdmYEzeV8+H6hCO9GdhBgAPIT1FdQeWdPLtCYl5J2CklYXVGrVOb1m?=
 =?us-ascii?Q?AH/+vEOV9u7OjlU2vVjOv5uQ+UaIGDe1GHrdZjZjJ7K+Km7ZO/JnRaQDkqa9?=
 =?us-ascii?Q?Rxi+eo9fIbpa705Gpe0q2ft1RO58g6nAahgRrbcrIx95aI5Epv6G2ZYM5ipW?=
 =?us-ascii?Q?0+bxlKJV5Uh4CUNqsF9XFlD6npgT7sa+Tuihp09B41G8R8V+0pGyPg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e2f1e9-d116-414c-fb14-08da0747dcec
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 12:24:05.8343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLgtEgnHINo5uTPmI1Bm9cSgF4RCtxEYrRTIEmKkswJxjqeD9SA1j05SKD2MSRtZRJdwnlpxYa4nQ6SJjPxHJN2TWqsFlHZ7c6iFN2TgzAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1475
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160076
X-Proofpoint-GUID: B0-HF-KBOlveaA0GeENQoslYJhcwyLJc
X-Proofpoint-ORIG-GUID: B0-HF-KBOlveaA0GeENQoslYJhcwyLJc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The "val" variable is used to store either negative error codes from
ad3552r_read_reg_wrapper() or positive u16 values on success.  It needs
to be signed for the error handling to work correctly.

Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/dac/ad3552r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 97f13c0b9631..e0a93b27e0e8 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -656,7 +656,7 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
 {
 	struct reg_addr_pool addr;
 	int ret;
-	u16 val;
+	int val;
 
 	dac->gpio_reset = devm_gpiod_get_optional(&dac->spi->dev, "reset",
 						  GPIOD_OUT_LOW);
-- 
2.20.1

