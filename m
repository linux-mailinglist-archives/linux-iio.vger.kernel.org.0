Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E3A47582F
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 12:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbhLOLvf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 06:51:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9618 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236958AbhLOLve (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 06:51:34 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFBSu1V009444;
        Wed, 15 Dec 2021 11:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=DFIknfCmQ9IZvL32MqBls1f6mgxAnGA+YbFPUDVyE9E=;
 b=cLZK4eNmgVmDhH5hTY8+Kw3sqZoUT1xVeHuBO7j6KeM9KeEBcE9qJTdQlFTxVMTxUlGt
 XpDXghBz/7DsmbcB7XNDQvnv/eIiEtHpQNI9Od8VQYm89N08g+yfJ7L/ClhpLlIboiA4
 ePEVcwvG/wFvtbJO7CxW5VviX7xG5FVgjLdsRzhripS43Zwi9BNsrPiFrBeRu0r+bhUO
 wq+mPNmmmvrZf+jkuki8lkh16Ho6izl3pSQVtqyeaj7ceIdj9rNHeI8tyMs7xGlaFJUs
 UjmEIW8yGprl3iYLXIvNT5fXBFOot1ZWGwwyBNkSs99RYqwSClQxXNRA3dDicuSB6jNh 5w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cx3mrxq3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 11:51:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFBo8ip029983;
        Wed, 15 Dec 2021 11:51:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 3cvj1fa9rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 11:51:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbymk9C6K6PeKnw2tcwbHYwGQMeoSPvitkvIZHG9T3IJuUcVx+ifVZZI1NBbAnkRfF+lKGLojqR0+whj2Od3jHAfLtqVZcPVvlJwzk4imcQMXbtHNr+ZdeXOnGbeQTPMQCs30R4ukm0ijY1Si7Hv6JWb72PYs1iSZzRRzV4pi5exw3/6n1f8xRSKX9417Ae3SheUKO8FVJ+XitHTjlKo8UYUz9MdRnSjy1u44NY1+y/R/LRQj/BrCsoDsF82ImBj3gmzAICOaX3XVsS9HsePgC99n9aIwkXfw5aOV29A71DIdz8b+x5yZBOCGzF0PJWhdZLyYLTcfKXXfEh9xz5VcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFIknfCmQ9IZvL32MqBls1f6mgxAnGA+YbFPUDVyE9E=;
 b=SLmhlsORMhICwC2Zy7R4qf9kh6pJJnn38RStsd0Dx6ivDRJpYFWGe8338UX5mgbyjFTtyd29pEUtfMnB6xTKDDphVTWS/eSAXLw86dMhmniIk5smgeET+F1U8Tjv3wOXf+AlZtifrPlrujay9bMcW1UIF4ca2buXUidb91F96BKqwuWstRQHKk82KxI6UkS33fqzNEbzsEipQy9lkGUp1DAVQtx92yC6lKMw1s/GSwuESDboDEVlfyphXMES7jcVG9THHVu/YGf5FT93uItJqXESBo7e8uRX/vGiskfDyYsMJnto1cP9dE8FNpQNQlVXyYl7fzLcxwqEe1RDyJ1JvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFIknfCmQ9IZvL32MqBls1f6mgxAnGA+YbFPUDVyE9E=;
 b=znSNudFp6Nry36lVKF8rfiszD7i6r4VbeiH0waZovg5Dgegu34WLm8kegKthIGk7k6qDkEhn9W2oMvBY+RMbLK4IYm0dYHOuSyBn5+1bLoU53bfxEpwwszcFgcEvt67YDGFI/4xS2wofsLIYGcW4pid5pNsUaiXLK5vj8GAZsRI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1664.namprd10.prod.outlook.com
 (2603:10b6:301:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Wed, 15 Dec
 2021 11:51:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 11:51:10 +0000
Date:   Wed, 15 Dec 2021 14:50:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: addac: ad74413r: fix off by one in
 ad74413r_parse_channel_config()
Message-ID: <20211215115053.GE14552@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0177.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92bd57b8-da9c-49f8-0acf-08d9bfc12fbf
X-MS-TrafficTypeDiagnostic: MWHPR10MB1664:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1664FE0B6A8E21F9A499DCE88E769@MWHPR10MB1664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEe2YLWBbXRJpB32TS3K1q4RRh6o2lrpyrKsJMnggNT+pKe8XgMZkV6vC00gYvOZy+CXOeYEjmB9oTQGJfIMSk2sTNqsfgFM6URCHychzH1V+Pg2zNlJ3+pn8ka6PKby7wVTxczMNx9D3SYTWWyDNFsTR7a42f4yYUdHnEUADx9fjC3MB5QTkZiwRadzi1C5sichwlXa3hnlv9AOz8KhIESRZD46aGeXhz+lGgEizTW+TdZ96kO/wwZEBTOhQzSw1FSujLSjGS5JCVzvf6EpQv2DDNpIucRGxJzdgsZGYI0vq5IPDjkL0Apxm6RikOYinNxnD4wR3HvrDfU0WLLhjVwJmbi4KDgr0UmuXdm1LuMSgxSCxzxdGdsKfopvE8dcntHhbJNy+08ml2vS7V/sgIKrgn0n74XQscqUbIJrmD/9rfLQKEyKH9yyip/twWXNGE7hpKpxBCyU63DU3URIhcRyLuNTQFIV2+6XzaNewMyx4SnhfiGevgaQsG253p2PpvWKdDRmHhErK/Cqone93+uzaLh+ZVxKLmMCp2FX/7Du5m3TN1XngECKwOFtF+TohCf4wBLg95vHELw45vIAWk0xtpyBK0Qy9EzGySUTSgLhPBWYn/EKPN8pZu3rmjhcJBbizhDnfeP92HZ0nYMbCs5cfcTzSk7IzseNrOqeLGDbKr7Gn43tCNnvSBNJoeXCfMxXuRcPPhopEGdbyA6kfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(2906002)(6916009)(1076003)(8936002)(86362001)(54906003)(6486002)(33656002)(316002)(186003)(508600001)(52116002)(83380400001)(6506007)(6512007)(38100700002)(8676002)(66946007)(6666004)(33716001)(44832011)(66556008)(5660300002)(66476007)(4326008)(9686003)(38350700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F+MZf+TpOHxtlF1q5CTwZlAtKxD8vBAD+Eud3lze6z0JFYLzeMTRTmZyPAxJ?=
 =?us-ascii?Q?RmjHjr7J3NIEALMlPond3uZOLf8zQqA8q4RHkLKgp+RglHOB16523SKazeoC?=
 =?us-ascii?Q?xJdv+IPDRE6k1EWUAchzschcCIZ44qgkBHP+u2O3KEd2HmsWCnADFAduJS2J?=
 =?us-ascii?Q?44GRNhTVitGjxagB9AdXz+UFuLENHpaH+s3EQfUmpnsRPgcesp0/E5kTenCf?=
 =?us-ascii?Q?OiVo+omD63lMKoTW4cHHYtfYM8eXrIdLkxwIdXMrkHAOBihH5S/MJM31z5f9?=
 =?us-ascii?Q?5zQtaOImOOiiNmY4bwvrJps2Zha0sIzEwN+bvJnQQvSzgUc2/+f+BWXvtLBL?=
 =?us-ascii?Q?klWxGADBJZElD68fPguB7Yq36l/fQEyd/20rUXSBQrQq5ea4v8vG03INUQaz?=
 =?us-ascii?Q?3NVUf8WXaaUdXJ5GUltcphbr09TL45eImPmKV2LIzp00700JTR3d8xfXK1LZ?=
 =?us-ascii?Q?WdUA8+OZk4zNWlonjpkmwoonw3IvDk4JDhtszySxUmtYkB4AfrPnuVqIzBRm?=
 =?us-ascii?Q?mQqojY/HojZQ2/HDTbanYYO1bfo5hwfGSNROkFHmKwQ92VEIf4bShzVc8zml?=
 =?us-ascii?Q?r6+9xt/1/hkXvaL6LSIXZuXUzRjznAG2Xeqwic/wTqZ8Y8tbPLmxgsmFrkz4?=
 =?us-ascii?Q?fR/A2rc5ehYNWX1UAQYgSe+MW74Ymo0DYqWiay8umD9nZK8xdYVIB5FK8IPi?=
 =?us-ascii?Q?+DJlyjqnJK+U+PA/iA+Efurw5PTPlIDWQdBw6Q6TxrKsXOpfMtQGgl/8YAkM?=
 =?us-ascii?Q?Hwmn2HQeU3Q7hl9uGzGD5ctgxn67+VKrVX089P5IbOuEsoq8ZBJRtjPm3c+0?=
 =?us-ascii?Q?ROpRDE24UknEFrmNaQylGf1EfwFUBmGt/wKtwaixceLwzoo5E0XHYxqb3rOT?=
 =?us-ascii?Q?9COAxBhdBGgvrJbpofFmEO63quKnbuS+E+EdwdyDCKf3LJjfcCOYx0jopWIX?=
 =?us-ascii?Q?QDivRAkyV4CH9pVLGAoj1JDuziDur/mpYyFjeFXftRP+evl/PbHyQnyw1swv?=
 =?us-ascii?Q?WYASLr8qY4ZbLFyoDL7NQmrruLuFC/XxA5bOEru1EOVLV+dNIgqYM2xSy78e?=
 =?us-ascii?Q?n4+F7rh13bO29R2w0OPyH+reei1lUjWC12vs3BT/wGvE/u4MBHBBZrDK1n7u?=
 =?us-ascii?Q?+PajWa4HGHrVQLxfMHG2OFJgm10HrDay+bNtLho5cegdHOt6bkUS/hDyusPt?=
 =?us-ascii?Q?v8yEoLJH7bRwZacsoltjltbSQtfkjJjk+q7gItkhcmXnowbNKf6K9bOSc6aJ?=
 =?us-ascii?Q?b2jYKJfkJNlkHDoqOG5CXAnoKELjWHAGnCJFBrFoMT6cuR614b8s8R2+QrDB?=
 =?us-ascii?Q?UlIf3Opaaz2Ll6CcFlCUbYhacXK2p2Sfrc9TUZ2HCf/vW1GfCQWuc1H0ryBb?=
 =?us-ascii?Q?Erb2RNo12WvXImvksvTSEtJR1oBUz7qo9Twwx2fL34gpKfmMYKvw8jIvZm75?=
 =?us-ascii?Q?bH2vOONRIuKIUUVN/JVTzZWNEp4iBvrf0Oc0RRUAtENYhvzXaIV/AVx7QEqP?=
 =?us-ascii?Q?pKOtmtTOfaFCpYVlNr+DnPUe+FoQu5PXdJnLgsmkLfC21Z9oQ9J79gRuOrOh?=
 =?us-ascii?Q?VySYngvdWf1oF6s+15xG0fcYWT7aAjZqMrTUO1ey3/98wHMDsb/QPVWJiD0g?=
 =?us-ascii?Q?VLeFjceG7i1LPPZ9ZRudq5H2LXcJJtSp9yEpyugzKuX/Rn7Jz+JqR+h8uuF7?=
 =?us-ascii?Q?yM1/0q9jofF2iLS3FybZYo9/Fyw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bd57b8-da9c-49f8-0acf-08d9bfc12fbf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 11:51:10.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6hK0+s1RNTeaZw212ivekiYc9FLYXCWTUR1qyI5Lq69Kt96z4PV+ToOtN7UegdBR4tPy9n1UJAkWRMrt80ZAj6l1ZD7vP4iukDaWkGUo7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1664
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10198 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150065
X-Proofpoint-ORIG-GUID: eHoJItvWWXwMzI_2qjQKRLyOXqseHi3D
X-Proofpoint-GUID: eHoJItvWWXwMzI_2qjQKRLyOXqseHi3D
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The > needs to be >= to prevent accessing one element beyond the end of
the st->channel_configs[] array.

Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Obligatory grumble:  When you merge a new driver please use a patch
prefix based on what the driver will use.

 Bad: [SUBJECT] subsystem: add new driver for XYZ123
Good: [SUBJECT] subsystem/xyz123: add new driver for XYZ123

Same rule for adding subdirectories.  That way no one (me) has to guess.

 drivers/iio/addac/ad74413r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index cbd9aa9b399a..289d254943e1 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1150,7 +1150,7 @@ static int ad74413r_parse_channel_config(struct iio_dev *indio_dev,
 		return ret;
 	}
 
-	if (index > AD74413R_CHANNEL_MAX) {
+	if (index >= AD74413R_CHANNEL_MAX) {
 		dev_err(st->dev, "Channel index %u is too large\n", index);
 		return -EINVAL;
 	}
-- 
2.20.1

