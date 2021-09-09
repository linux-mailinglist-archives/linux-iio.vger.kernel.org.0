Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D28404796
	for <lists+linux-iio@lfdr.de>; Thu,  9 Sep 2021 11:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhIIJPw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Sep 2021 05:15:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30276 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232397AbhIIJPv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Sep 2021 05:15:51 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1898cGEd001124;
        Thu, 9 Sep 2021 09:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=1R457ORdn5Ym4a0q2E+Q8/GnS0W8OhzeOyV/F+LLamI=;
 b=WvbAliyrHVViqMqh9eIPHtWhxvL3yJaEtTFIVakhsQ3H/1sgfRGE57avjlYO40674X56
 bIVFTNUYjd1Cj5EgAB+bwjpWBv+UUo7hp9Qh59k6761Ezen2Po1y5KiHtLfyV5c1Ztr9
 LEyeKKr6Ewfo8OzohnB93O+t1adwyml0hDe0BvzKqzvry7GWu2FaHPo/1Wgkrjpv46z3
 qAjB4zFzlLMJ8Np6IDR6V5pj4jh+i98MJ+61UiCVzWMLaXw2amHvSyb3PMSx+mmeb0SN
 XamikGfqqxGrTFUtLVj9/fhvZcxLnPUD2Yr/MSemAV5xbxWa+GHHNw5RH043AQ/w9ps2 eA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=1R457ORdn5Ym4a0q2E+Q8/GnS0W8OhzeOyV/F+LLamI=;
 b=PB3oFE2CjSqALv5Y1IP2+f7JhG6RRs64b1AYNALZJdbEJYJ0IEupXAxU4NBiK6EPSlnA
 gAI/6x/d+/7or8Q6XH0giS0wXr8sKyH2UgcGrwrwSQQc8Q48K3R6JnCKIF6DWz/2IU27
 hXBTi1iZoRXriMOnPHn4WstgIayc3QF/y+Jh47jsncGfPe0Ibdho/AX2EIWiy1/X3rFn
 sTWTIT71Vp+kXQr+MEw2PIw/lR4gjX3D2i1MAvTDuuVyViNsHu1IUfTdYVM4yvX6eYn3
 PFOE6Wlv5m3I+yz1tlUcOdCjQ+5HUENs3x1gnrt5aMXkmmM5W1yUv8fUGsK15I0uy+ob XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcs1dn05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 09:14:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1899AElk142249;
        Thu, 9 Sep 2021 09:14:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3020.oracle.com with ESMTP id 3axcpnfajb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 09:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqT7+1DMxh6n6wvVsrp2gvKFhQFby6yto9YDxGzb4QdWlHcdSMeqhLyiec0sitRnABsNgpcubPXvEzrI64DXNdN+id8jaKhWR4WyYV9ofx89xSpGdZdI6j7MGoVUNwVvODHTDQKMLvwbZyt3OVe2ORJBuPH9e2DpOMemG5Og3nHQ5iHiVOpDxoxbovu/nMn9P8c1Dgt/F8NIr4mjn5Sc5mjEZsPHeOWRaxbzQDAeSdOlXL92doZs7icoUIptTGjSyW3pQ1v+OU7uJgOagz+MKhpMFqPineUk+th/iiwjLZQtQPgk4oddGS6Pcf/u+goodhxz6c7Y/y36hQRW/LQlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1R457ORdn5Ym4a0q2E+Q8/GnS0W8OhzeOyV/F+LLamI=;
 b=G0f2qSce+Iwwjp8q7nLxgafk+8lL/C5+M9/BXT3y5uFa/mivyuGMteoKnUJkc2y44ibp+6B96fVq3LNdqYko67g8sPGHDeAysodIfe10e5hK8TkMe/SwK7JCPwT74uoca1tgMyf67FQetHpEMKkgfqOyP+zCahRoslJYkCXvPdyndTSNMeRUaM6gHpxuUkzRebQn/Lr99yI5khZU1OeIs53VWtHp8wAPO4A3fXgvAHKRtsNpsGoSyF3fopNpG0rqNwAw0pVWL6ZMVDcxso574NHwm/QLH2xLzp12vPMNDdjGK4JNAlYjtBvqy+HBlxayzJfHrhGU1J74epY8+Wle8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R457ORdn5Ym4a0q2E+Q8/GnS0W8OhzeOyV/F+LLamI=;
 b=wJYWOrdNl4fCgBg5C/Fn4EK270NpLfBnNBkTxst6SEFFEwhGJvLpYhistQ8TpNzabO3rmWw0JZNfvmiZbOtmT2fhYrBxB6wGA2NX0Ps2O44hJ4YJngvyWzQZoS53rqzKf3Wfug7L0lcEVCZxA1RtECPA3LiykR9wfMGQj5xQlbw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2366.namprd10.prod.outlook.com
 (2603:10b6:301:33::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 9 Sep
 2021 09:14:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.014; Thu, 9 Sep 2021
 09:14:05 +0000
Date:   Thu, 9 Sep 2021 12:13:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Karol Wrona <k.wrona@samsung.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: ssp_sensors: add more range checking in
 ssp_parse_dataframe()
Message-ID: <20210909091336.GA26312@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0120.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0120.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 09:13:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b622bcae-7d2e-44c4-5cba-08d973722ba3
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2366B8419673B2EF371A05138ED59@MWHPR1001MB2366.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVP3Ptglm6+tgFyMXNbQlDxqVErUeRUbO46G4fhfrXQi3qNO/GmDgihZ54ArtIrWG5jRUJ7Nex0FvMjPIA3uR/TfM3zkiJE/6xyxebkW/llKLYhEqHtMeiYjtV2KMCz1T9sWijS14+ZFz4JfagQy6t8m8OjuWBGockW8d+a0+lHRZVrZwjT/DDmOJPAjmle4fsKFUP0oATz3Ej5zM0Zrjn9hfHIZPt002IU/Y7lkt3UU45s7WHxX9HL6Iy3iWrt1rjMmWj5o+5b2dzgwLz6sx2mJKV1iwGhMAi4qNUC3SWLrN6m5FoZ05wIq4T75BqUB+Pmzshm40KGRemGpnGvyWbELVOPLP2wsSg/qbwQRsm21GVxYCfxmA4S6mT9SoAr43M6ljQnpg6TtIYVt0kHR0psgT5r47XiOgDfNIuhxwgfm/MUZW+snkfQ86PyU7lD3GjpXvh4xAe0aRgqTLi7dLOaUHBp7NWji06WJpYTkltK4mE3bYSSKHAPOGHSvzc1jyAETq4X4d1d7i8OmTzKXlmbrnaVAoXwZw4m7bUL7PIEIzXytD03WfQBS1Pmf78H8NltQLFjlBt5O79LHVcOxY8a/H50oIn1XmZA8qSs1uDgrR1CTVSSAYHJRt9GMploGAjxonI0ivsOeqZ3bszmA3VFvp2Y+u0DaJB7jqhvxC2eRXV3Wu/Fpj0pRyxaUQwgJSAwP3lHmmO0NyzBbO3S2/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(39860400002)(376002)(84040400005)(83380400001)(8936002)(5660300002)(186003)(86362001)(956004)(6666004)(478600001)(8676002)(33656002)(4326008)(9576002)(26005)(66556008)(2906002)(66946007)(33716001)(44832011)(66476007)(6496006)(316002)(1076003)(52116002)(54906003)(38100700002)(110136005)(55016002)(9686003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/zEpfBK0iOLDPVsG/ZqHHKeHQueLSBmxZHAEsdVm3NGKURZrwtwad1qv5bM6?=
 =?us-ascii?Q?T8KkxIaWb4TG3aTp4gdHftz78FdiypeULbU4GeWCx5AJbO+3Vl28IvS04rZg?=
 =?us-ascii?Q?ktPe4wZ8HPX3RMIo5ZzJoG/5b4VBBq32hcfGcQ8l3GUjBBDQtd5iAZQqdoF2?=
 =?us-ascii?Q?Ul8297RAb1f3Xv6aveyVLnhW2f+Ijsqvh3y/phXNV50oa+/X8GxHzBsIL01O?=
 =?us-ascii?Q?b6YpNLsNwhZIglKdSi5+6rNz7b+AmGt5gE5Z5mq8/4VKNgAuzgaNDF1qH3He?=
 =?us-ascii?Q?9do1Jn3nTiIYmONgwgnYSno9TK3wQLONMukT4YR3ylPKyvU7pTm6vJ/DhzPa?=
 =?us-ascii?Q?WGAwXQRV1/NBc+NDPqcwPWW5D0v/DThPrlaGSvOs5ee6P2jOkk0fI4wgdnZe?=
 =?us-ascii?Q?IBOlBvSTXaMkBho9bRe60pSjXRxzzFGEyxWxj/3022xzuI9ZC+wq3lHW2nMK?=
 =?us-ascii?Q?P1MAoXSxiAqgNbf6dk3GaQ/fDpBv+3juc5jeC9/AF9kf1H2068Zb1T4qnMc3?=
 =?us-ascii?Q?XahDFQFvgINr5GD9q36p3+TaPcMg/ac9I7zYCcwlaGUXczvQoAVXiR/F+R6O?=
 =?us-ascii?Q?M81IiVxz1lZzbKjlk4AmrPySNlaVMTS2k+Z9MrUG4B+A7pTbn8UkElbrqQ84?=
 =?us-ascii?Q?7lkEYl/ljeMQW1ixckydpTF64VEqsK8nkUBYZf3FVuPvKXdtvDRg8Bs5TSrT?=
 =?us-ascii?Q?mq3YWyX/2zy0hz3XX+tFX9cy55VXh2CRPaLllP/mVqHk9BFBwgIdS68zEyr8?=
 =?us-ascii?Q?CJECpTtuNzkMuAa+sH2HQbR4HoJcvuGFJ+CXDGVmNCJL7R/yWPZPgpXlRqpW?=
 =?us-ascii?Q?vXJW7BWDmcY8wlANTaaPD7hLbCe8JUfXBq4t1hcyuB7tWn5XBzFSx3I5YiD5?=
 =?us-ascii?Q?3NZxImRScZUfT4xMo8XrC4+7u/UKToSy4NQB0rwi6jAh+MCIKMNrtdMMBFIH?=
 =?us-ascii?Q?xnLawKfNQxoL9m5oVtp9y9sNW2n4/3tm4Oug+Avw5k1llaX9xH98Y5m0eFLI?=
 =?us-ascii?Q?OXoMtx0TzPnuO+2vKKVUVPGxlYSBM79WnRbwHkVYUHt5silwWteerFgaofTx?=
 =?us-ascii?Q?YT09TC84SHfC8jOuv+33VcdbTsFC1hOjXk6eEFUvJ5llyqtj3mwbJkkuUTdN?=
 =?us-ascii?Q?SEuO4J0Sqb4e95koBuJoMvhrkcX5zls4oEMCIsOHJdiDwvJR8GlOvPbzHQdj?=
 =?us-ascii?Q?cnodxeYpsPwdMtcIGOsXJG6yNFmeiMUvWuH/K/isSHLEJBmBp0JIphRkJtWH?=
 =?us-ascii?Q?Vl4FcVruM5U6V2k/XZ9tka79iG5It4AE/42Ep8wGWIzqehlFLbnR23+mcsvj?=
 =?us-ascii?Q?iYA0KTKdFSUjMGThrI8DfNpb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b622bcae-7d2e-44c4-5cba-08d973722ba3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 09:14:05.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0s5wHtek7dzOIfrugtjhBzlTSCmImdv9X8JyAUojbeST1z3N72bHU7fzn1tZgRwD6hofXrVDriR8Kgy6Q5yLSMhpLYpxgAcIhM7+doGRHFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2366
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090055
X-Proofpoint-ORIG-GUID: Uq3kyq05Cj1sd-Aec6isfVu_uezvNIDD
X-Proofpoint-GUID: Uq3kyq05Cj1sd-Aec6isfVu_uezvNIDD
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The "idx" is validated at the start of the loop but it gets incremented
during the iteration so it needs to be checked again.

Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 4864c38b8d1c..387551eac184 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -273,6 +273,8 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 	for (idx = 0; idx < len;) {
 		switch (dataframe[idx++]) {
 		case SSP_MSG2AP_INST_BYPASS_DATA:
+			if (idx >= len)
+				return -EPROTO;
 			sd = dataframe[idx++];
 			if (sd < 0 || sd >= SSP_SENSOR_MAX) {
 				dev_err(SSP_DEV,
@@ -282,10 +284,13 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 
 			if (indio_devs[sd]) {
 				spd = iio_priv(indio_devs[sd]);
-				if (spd->process_data)
+				if (spd->process_data) {
+					if (idx >= len)
+						return -EPROTO;
 					spd->process_data(indio_devs[sd],
 							  &dataframe[idx],
 							  data->timestamp);
+				}
 			} else {
 				dev_err(SSP_DEV, "no client for frame\n");
 			}
@@ -293,6 +298,8 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 			idx += ssp_offset_map[sd];
 			break;
 		case SSP_MSG2AP_INST_DEBUG_DATA:
+			if (idx >= len)
+				return -EPROTO;
 			sd = ssp_print_mcu_debug(dataframe, &idx, len);
 			if (sd) {
 				dev_err(SSP_DEV,
-- 
2.20.1

