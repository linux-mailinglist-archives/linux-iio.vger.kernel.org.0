Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361B4494549
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jan 2022 02:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbiATBDe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jan 2022 20:03:34 -0500
Received: from mx0c-0054df01.pphosted.com ([67.231.159.91]:32828 "EHLO
        mx0c-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345541AbiATBDc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jan 2022 20:03:32 -0500
Received: from pps.filterd (m0208999.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K0VdmZ010083;
        Wed, 19 Jan 2022 20:03:04 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2051.outbound.protection.outlook.com [104.47.61.51])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dprrpg6d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 20:03:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kbqj9oytF78nC1VAWpm1xiQuM/ybfCuEZA6CmticjaJaUrGSDUTIX5mE8+Ztkj54qgYH+3lsy8aVx5eDTM+E+YnlPf0g5D4k99/FBHcDVAJjnhPGlOtwZxsqIngsG9f6qHCx7hayezFT8T2P/WwCn89mtpaRbNFjTG09iryF1y2t7U2JX9MDG50kmVHOzCet2bvLlSjE90zV5MxXWpJSZF3YKG5NviwJJJaw6akPMsi1R+udz0jlHmDwz76bjBBJV3c4TbwhYdz32ToCLNdjz0i51OaWHudVd9ZhXFnFFs/Jp5zuMIJ+zYXBvJed+8ebm9UmcKHgPr8C0zJYuKwH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO7O+CioqUBh/mgqYxouOLjq/GsR7cGVI1UNJ/cIDs4=;
 b=WZuCKQxH+sCU+pqLv7dxuy+85t5nMjGJXONW5phsUU6xjeLjgE5MbGujd2IGSZIf6poGREjoRTkzOrY+hIUxWtc15nHVgW0jZa5VQa9YjCHBokc686G4TJzf3fUClLS7fw5kTBUcvQ0VsrhgovCfe3pECFpQKCo4R2Qg2eH+BEk8Sl9HQ2n8D7jcoa4SNoQM7JK5+jU9RiZTQDeqfpqLVvKDYV8ZeQzDzj8Ti62Dvagos6syBP33j6Rf85tDwpnU0gS3TrL9IHcPh6RYCCzaUYhijWJn4eLE6czifFCgctGt3iNz7F82u9hF9jy609I27ED6AIHMegn+qc1Uz0zULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO7O+CioqUBh/mgqYxouOLjq/GsR7cGVI1UNJ/cIDs4=;
 b=z7jtW1o8m63PaYZFrtqrd+wXuJ2SKil9zxDijKWhtaFgztj2DK9FGZ5ZXDSClpfxpV4HOOxPEKX+Zl1bnSx88jLpIWojxQYgXDrCkU4hKbGW2Chh1TdGgpRu85vgvslSb0CBW11WUyClqxQ81PFtFNZHX+M0eJOAmkZWSOaMLmk=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YTOPR0101MB1065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:20::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 01:03:03 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 01:03:03 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     linux-iio@vger.kernel.org
Cc:     robh+dt@kernel.org, michal.simek@xilinx.com,
        anand.ashok.dumbre@xilinx.com, jic23@kernel.org, lars@metafoo.de,
        manish.narani@xilinx.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH 2/4] iio: adc: xilinx-ams: Fixed missing PS channels
Date:   Wed, 19 Jan 2022 19:02:44 -0600
Message-Id: <20220120010246.3794962-3-robert.hancock@calian.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220120010246.3794962-1-robert.hancock@calian.com>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:610:4c::18) To YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e52f2823-d16a-46ea-9823-08d9dbb09c4d
X-MS-TrafficTypeDiagnostic: YTOPR0101MB1065:EE_
X-Microsoft-Antispam-PRVS: <YTOPR0101MB1065389D92497A437FC860F8EC5A9@YTOPR0101MB1065.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IV9MsTi939bmee3v+RHQM9YkP1MfJ7j748KyI/fS2LYTvgSlDgD1TXD9SFEDN1d8emuyDLcq84W3SYJGuhU6NBQGgbqn7aP0SYTpSyOnsFNMHcwWnbYbIFsUDPMuJ0Ug7Qe5uTtnWNtn824qnXMfjllfCJQoqsvc7LTPGLKu+a1tTOLIwKc/3UPMANZzhkUlidmmw0fQ/w+sO4clamDgPWtLzgHTf3ADzhaq3jHKo8aT6z+jbJXQcTug9n32ZC9bRU4JZdqnxwB4WtqMRFeuFf0WPG7wIhs2Y7ox/m3tvS12u4uNcEqZhZfukSEC3W4FXOC/JM6WrxethBgOkvgO6gv92Iv39CQS+P7IVv4vR8Q8JwdeEoC1cVrrNNgiJ+LNubR1KHkuN3ihaPZEMtMHfxOCnU9fCENF34lcnfFduy1mOjdXSVebddkF+8bPs/ulXgjjpj9yrctuxWRtIfQVNc6JhszLWnGZD4WH6CZPaj4gcQMYZq2O6gs894SC4/zzvGkiKK9Mc48zu25Vu6FL0EG8eoz9w2zcGsdb2DY763bfS+eTx+wCyeWNsgrT1g0jpQ5/aebqdke2TYhVwdU4c0nNc0R+pD9TWnmXeMc5QAFponH9DmxzYSrfnKwdztJOzcfu5msZP5No4mertzRUQxDeYUInaDcz5f7OHTX9n7CZcdVIZeLWv6C+HNjW8G6fiBmU5rpgkE0eoeNqkWDe/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(44832011)(4326008)(2906002)(66946007)(66476007)(66556008)(316002)(6916009)(1076003)(6512007)(4744005)(38350700002)(26005)(36756003)(6506007)(6666004)(38100700002)(52116002)(5660300002)(6486002)(107886003)(86362001)(508600001)(8676002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oo3kdDv1x1jiUowkYDhjJzpBLRhXetcYDtlRmWazFspiaxcP1vicw2Lny72o?=
 =?us-ascii?Q?UGiP4cFXUu5cxq4ztHiVyp41L2TzPERdWT4Rr86DB8egrb5S0mJJvpErnbck?=
 =?us-ascii?Q?tRhKTiUp5mVm8FSAWnjMPcpO6aD0ZpgYsqyJ/an8YAifiC2CvvNrpsRvw5cg?=
 =?us-ascii?Q?9tp7VGd7qb37g+LI1ZVB9ecEINeEeMjfgkNTJhB0RkJRA96fvEQf3AN/7ZXq?=
 =?us-ascii?Q?ItcSJMM7lUvFc/wN79KvIJC7b1QVs4tBVjL3oBqVQ5UlE6d+kp7MdV0nu4D1?=
 =?us-ascii?Q?s6hxeI7r58usBnbu1m4J489H4Uo5mbgmzSOwi/ohf+93kvofR8h1gh1iNxld?=
 =?us-ascii?Q?JUeHDyV4xAht3wJ0pn5xKqRJvvlh8yKYx+rWeWnkRRO2QN/ccg4rwPFeac9J?=
 =?us-ascii?Q?VzRj/SWb130Bhe96I8Pi+OZa0gn1SwL6te/J03xVoXLHglhSXR7TpkU/ov6O?=
 =?us-ascii?Q?JwpBY26es1FvnJFi6XfiPC9AwLF0U01Mq1vNr1qsFPcKpsOPTJWperpTTUE8?=
 =?us-ascii?Q?j6DVZCisdFhnIVUkTrD7c8dASQ8roeYdUL5haaIMAx51M2SHHVr0128ib3sL?=
 =?us-ascii?Q?H8/FBgKq5FUQUh+sYnzkQvwKQsaoZRdgbhOlB3imDMPcqDuWPws16KJkVZQo?=
 =?us-ascii?Q?G2coESB1G10tOjnb7TRlsQtpK5jB6vNJ5Jp25yihsU+HVKj/5q+PV64bKJmV?=
 =?us-ascii?Q?dbz+0hxhGgRkhlQ1h564wbbxzh4XmAJAa0jg1UU3jaj4UNLI5sLhMlvJKfm0?=
 =?us-ascii?Q?Bi2smEFCfLd4hN+9kJVtmV3AvqgtWciZFp2LeDDsn6J1LsrnEl8V19Zosu5j?=
 =?us-ascii?Q?VzM9I+Be5TGsJN8rDUAuFlJL/kwTs24IkLn9yFcrlL5Ph9AjcAjjTtjOcqKp?=
 =?us-ascii?Q?DClP6BksVSGa2MGQx1ovj8+xYM/8tfGTDYttCpjJr6CIF9ch+f0T6Hj6zGdP?=
 =?us-ascii?Q?yhFRwxNr4VvNFmwx3cy/2dpBwVr8+khiG5bs9q22lM8tY28ywfDQc9nWleWw?=
 =?us-ascii?Q?SDyL+aOu4j9EKe/F7fQO57ZXbgpGUFzrhqaRODezgY1f2/wMenhcsSKo6SaG?=
 =?us-ascii?Q?wVdvMByBu5MLe7YTKMwc5g4hIAagkUhjI28R8jpbx8iHDCylOFw97iE8dLOV?=
 =?us-ascii?Q?cOrbbwZbv4z0yqUJXfKoeoBpAiALIV/6oJt1VwumeGDB596k96jM7CiUEbsx?=
 =?us-ascii?Q?C6PhpuyGgpIpjzQLVONnHqdfJSMTPWe89cUVgWIV9XrV4jcNiYRS51iqqIlQ?=
 =?us-ascii?Q?G+pkPGcsBEDzm3T3g/uhHxOH7S/dy/0g1waavXctVrFCZbG07E7rrT8feUgi?=
 =?us-ascii?Q?oUwNSpa8DhmKgJ+XaUKK/IhC3pVogh4B1YNIV3jtqHh2bZXhCay/IHiXJtLk?=
 =?us-ascii?Q?7W4qHIJ/z7KEoOY26B10RluHNeTa+u01/Ril5ZFRjKJaEgWRWYasGfs72x7M?=
 =?us-ascii?Q?MrRzBh6IMeS9U30MRUUzp0vPaEhxndLTFgiNlU0Ras+jqzn/PNuzna8QYR6H?=
 =?us-ascii?Q?1+5fp4ERjomqCyHp6wRHeF2R+LCqwtq+UxCwvPqNlle4jWh9MXxmGbwWS0Qj?=
 =?us-ascii?Q?ArOrimT5agW2Rg4Irt522esjz74/TpsO0dr5atBWLBgE/3+AqyENgSz/T5Sq?=
 =?us-ascii?Q?lDlAninigugWmAn/UPS5Vc0ZTKssvY0svLxM9nVY8Cy3YGzR1Rro9ZlcVAfJ?=
 =?us-ascii?Q?+Yb4tqh+Ic9Iokqt497GHdKEMsI=3D?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52f2823-d16a-46ea-9823-08d9dbb09c4d
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 01:03:03.4255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6oDnQ0MQ7HSb2nIGXkflZV8DfKe7Mx26dIkEJxJ5AHt4VxdCT6tIMJglFkepu/3AaXhLji+6G9dgNNcwWiz55lLFqKT6XyNZJylJnWXu4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1065
X-Proofpoint-ORIG-GUID: rJ3jSLKTFKWGGZX0TT_jUHbzszW_dV6W
X-Proofpoint-GUID: rJ3jSLKTFKWGGZX0TT_jUHbzszW_dV6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=843 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200004
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The code forgot to increment num_channels for the PS channel inputs,
resulting in them not being enabled as they should.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 drivers/iio/adc/xilinx-ams.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 8343c5f74121..b93864362dac 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1224,6 +1224,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
 
 		/* add PS channels to iio device channels */
 		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
+		num_channels = ARRAY_SIZE(ams_ps_channels);
 	} else if (fwnode_property_match_string(fwnode, "compatible",
 						"xlnx,zynqmp-ams-pl") == 0) {
 		ams->pl_base = fwnode_iomap(fwnode, 0);
-- 
2.31.1

