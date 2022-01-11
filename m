Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B35C48A857
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jan 2022 08:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiAKHZZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jan 2022 02:25:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28800 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229562AbiAKHZY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jan 2022 02:25:24 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3TGpX006818;
        Tue, 11 Jan 2022 07:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=j5OkU3VijG0C0wFj7KZfNNctEC0gIBVTASdsjb3gu4s=;
 b=tEgkfH/jw0HeVHidiGw5Eqx3ptxJOhVwjUg3pD/oKyv/40IMpA8c9QmvQtB4NoZ73T/6
 lOpQWKffOPTYfbamym7OCTuxQ76veoEgI2MXw28qVpiu/Q2a8vvcMUIXacDMSpSVjGpf
 yyJNvMAOTRI6dNcmzN3Y/jMdJbqF7o0SYM5obzcdnJXWCx8OLP4w+Q4DXZiPfjer4ycM
 sGdSA8qLs8/W3CxhmBRg/hSyTa5hjfoYRPSBRDUd1FwYzwzJNrDjeSP/Qpbk24CWnEsa
 2EKLHifRsuNnonyu2fUhcJqqHOkFCtyaJHSe5WDAbabfe3/HpjWzUrE1lcVA4IALkA6i cQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjtgakjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 07:25:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B7FbWB146904;
        Tue, 11 Jan 2022 07:25:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3020.oracle.com with ESMTP id 3df42m8jy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 07:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFKQWeFsp56I/Z//x24njRXkEDNnEao/TBOp0M+py1bFO8Dhq++JaVolXeJZCUl75kPQKYGZMr7Gae3E2JiRp7QyMwMGinIl59NqplDPjPnzoNiaw000jkqU28xuqWlUKdZJHPA6uRh7fJixXLtkoB3iOyEBzQwhNcr/+s6V5GMfMmNXOYKkNzsNyRQJYDVRxrLJAHmhjOak9PTM4wrCCmaR02X11avGPLCqc6R3206i0njCTZiNvxPr+bQ0HZ+ryg2fJCjlLUzHyeUmpiJ1Gw2RBJgb8aJqulK3RlBVxP4AQd6phTddBqopdOGegFq35//YchkJomIthAGPQLh+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5OkU3VijG0C0wFj7KZfNNctEC0gIBVTASdsjb3gu4s=;
 b=XpOXX5dyaEsIOstiEfPSGOgKqlxNajGSVzlo3XLS3OMrd9iy11iwBxSivHchgHnVQi1lAD5kRXDEQcjKtU8LnEx1b2M4igeO6AdHxVe3ikkGOZ8QrSe0dedJZRXOQMJrcdhU1EPBteise8jtXlvifWHievV/PERRAVMvZqGLeKK1v5CRiknLoEskj2o07i6+0lGYDyQU0l+MHP/3+BqKsIjZ+Vr7ngfI7oo/+pvhosObcDQlwMiT1W7f/wV21y/kIRLKQTs2YtaiieepmDRxojeAZhSCmcsXes7lITY0dXKInuXmNiyKy3glb8iiLeFHk9wgeCNn4dauOPE+bLod4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5OkU3VijG0C0wFj7KZfNNctEC0gIBVTASdsjb3gu4s=;
 b=dnK1fx8Szka4VY4n6b6pDuaNciNl9ZIPApICPmgOvffpVv105fgABVSFmPdqWiv3/LZaovaH8CR5Nyv2i+3tTWZiMD7ijUcA0DtB9E3JRAHARY4QCtGvSWw49Tlw+C5Jg8efJQJJVU2Mw0L4mSb6gL8aWy7gmGBG1iAJDkZ4qHE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1824.namprd10.prod.outlook.com
 (2603:10b6:300:10a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 07:25:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:25:10 +0000
Date:   Tue, 11 Jan 2022 10:25:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] counter: fix an IS_ERR() vs NULL bug
Message-ID: <20220111072500.GI11243@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a654991-649a-4a55-2d63-08d9d4d38057
X-MS-TrafficTypeDiagnostic: MWHPR10MB1824:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1824D0238F40A209393819828E519@MWHPR10MB1824.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3V6FSucPqZV/ZDhS8OxW6jN8fsFq/3VFeJu2CW1+woRmnyqCxUaFKtP1BDfJm81A5uHmwt6yJyRt1ms4ANt+xQ9KDnWVqcaarADzjfUWeMxMvd2OYZ8hWlJHnBME9SBEoYlwRVEeZ2AzlgGms+KaFr1H3vp+OlrIzN63oCaCP3bR3e4nkubUqwve7xUUiO2CEqS+R3t9O6y+Tnq4Z84XrK1N62XFiTiRrRIkPOzdzWFCoyi1Q8IUMs05ZxyOF4tPqwI4o3RwiwDFKQJsSimSqd40KweFsylp2krQJxLCdv3jpbmIVixBMo28BIaCEjJrTCz/pRO3wF2zCYASN85rvVrIaBNqHUEI9M/Om8Vm0gW6W6VaplQ+oIuTe7CcFwUH7KohOOzR+bwfHqh1PhSliQMfSlCHHUgSMSTXS2e/6C3C3NEZvJVPzGnrRC7hvmTkINqHl59b0K0vNZD75qriLQt0RrTIxiAKE+hZuh7T9sR8ZvLMFQWqHGH7/P/TxQuImHcD/PmYTvY9RWoJTnoBK1VTVV2phd1Rrpp8ukI3ZKDF8obajOGJu5qPHc3Y09EAAmvmJN+4NOQEdW78Xf4S1q1dKrEkqglK29AtDGNMVyl5k5ojNLEfn5khVS41d7oiy048V4k0xUFh5HrrVlH/4zNg6xS0G5CYRpiFHV12I1cFVSUI2ejpJR1BOkQ2L70nhlOkmvWoN22r2G8D95fe8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33656002)(8676002)(1076003)(86362001)(5660300002)(38350700002)(44832011)(38100700002)(8936002)(186003)(33716001)(26005)(316002)(110136005)(4326008)(54906003)(6506007)(83380400001)(66946007)(508600001)(6666004)(66556008)(6512007)(66476007)(2906002)(52116002)(9686003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DoRr5aSXne6bef6FrXXfYxybDsNIERrawbHOBnm9JFK4IyEhrMxUXrNvIwen?=
 =?us-ascii?Q?sj5nTkxREepLwwiFDSqrqeZyaTbJo5oze81KL4x1pkLGVHJLcwi53QS6WKG1?=
 =?us-ascii?Q?eZd5x1nDn4QuTI8sln9YPCef91H5JOB7VdMjm7ogDQU6NrV0uU0sqsYy0Eyi?=
 =?us-ascii?Q?Uw8VV+6Yv02P0rARTWVfRR2iNgN1Hzt4QGShlX3o0RYSn4P/EZgJPI5KLz0M?=
 =?us-ascii?Q?eMVTI5hTlEUq0lAoesSye6cz0ke4npVs1pICYtcf6qFkhA97sSXoAEruQdDU?=
 =?us-ascii?Q?5Htd2CKTgczndGpeheY71QcizMLm5Zbx2Da4L9/crzKk8TqPYUekn7xvHhIP?=
 =?us-ascii?Q?HSWcfmQWM38bpFkqz1MgZ6b44Lgf0y4DHgXBAd540keryoYSfMG94X6RXK8T?=
 =?us-ascii?Q?8xGlcfQ+icOKtKca3jBD0IInjqSF+Zx89Udx0IkhsxGb/iriuhF0tLuOrvBj?=
 =?us-ascii?Q?YgelPFxPllhpyYoJZVwcn567MtLkYJ4ascg7D//JT+LkfBUIz3HhWz2xfd3d?=
 =?us-ascii?Q?ZjH96REe7S2NTYpZNsAOhQWCu4I5UsRbzNfxyEFiiTt5R59qFxXwCYbW1Cto?=
 =?us-ascii?Q?MMiMGNOe1fSVGc4bbW/aAKkyl6y2JP+47YGQk6stpnFziRKY7U0FQgY1Ub6f?=
 =?us-ascii?Q?gzuWEd8eBLc1n/I6eGJJ9gtwnKLXawxERiLpjrPiemJSCddOTwot1Cd+reDI?=
 =?us-ascii?Q?0Cu/0EzZI/VDC9ukpeIo9PMadHdMvnapMfx5SebMdxdI4l5wUf8taI6r/zyn?=
 =?us-ascii?Q?b2DhFqngNIfZLsAfCKicDBMEDBbeG5wI6OzUqBVyCg/YyQA5HmZL7XkEtDZT?=
 =?us-ascii?Q?WdFMhpxcsRJY2f1eWrc9i3tAJM4X8wSyCt2/ifMHi9uEb12Z4KyRGZaHX7qE?=
 =?us-ascii?Q?UHPbZkxAVFcwINnBsWybxm087h39XciV7d1JDGv4IBCmx14siPBlNunNnxSU?=
 =?us-ascii?Q?X8TUT6pg/CQOiTKyab7ES/P0G3B09phfwnNrkGeVPwI51jSu8iOIv1AK/BFl?=
 =?us-ascii?Q?u+tpThz8dGv5SC7q1MXGvw6YLZIjbd+EP6H1jEI2Q/F7VlY4I9BeATMe74D1?=
 =?us-ascii?Q?x6YYroX8V9hjdi4ZJxebAd+e79RIqE8f8dbS2OnuJesENnMVyo86f4VCoRIF?=
 =?us-ascii?Q?jfLZAMeVjVxF5pUTr76Kxkw3rGep9SbSr1UuYQKS/Ovz+ZUYrrOYpoRJlaOJ?=
 =?us-ascii?Q?Y+OCo7XaOG1wh2ue8ybM1+T5hhvsjElHMDIrgnfuyrn5uS35wgkpPjqg5XoO?=
 =?us-ascii?Q?KB0yZIU9IqxVg5RayLougb0sFtrf9e0NeB0sRt4YxTvfvGDPGiKlp4Id6Ocn?=
 =?us-ascii?Q?heu5r7xpUZtn7Om+tgep78MFVxpQmnDcimywjcpiUrgXzg3MicpwCmjaMIQK?=
 =?us-ascii?Q?I3WV5oBj9V+e3ybPqjI3hSJm1BD3Vm3IvR109JgDkYj0iF1/LKLYMpNd4IkM?=
 =?us-ascii?Q?C5ghAT1zoonkwPdq0I7eUQ+K5KEMl1R5PlO4Y1tu0XtMM1RcU0elp5S4SiZJ?=
 =?us-ascii?Q?zwvwEVLK+teNFCgw+JBd4r4MmV43iEX4VsWy9MK4Cv2LjwcHLPD0f8QGpYxE?=
 =?us-ascii?Q?fC0U9FkMvTQxN+977BOfQOFimTTrU1ivVcSuvBpchVz0LrUnqyb0gb5wlgkC?=
 =?us-ascii?Q?s2iwGYTRuLJTg6IXP93ZGle9DalrLq51Yni+7+Tjp3yQwpcZAe9QgMd4Wwsk?=
 =?us-ascii?Q?LJiJr4CdW/Vv6lDvz4Eh0xwDwwg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a654991-649a-4a55-2d63-08d9d4d38057
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:25:10.8989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVJPCawAYc9iineHBTH0a6NyGoEQylzzPSNoRErZ29iiIGzKexFRy3hSfeAU0A9BCtzD/VfyvgZ79LMsZzmJsOIiFRd8cDHpaVujVBBKTPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1824
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110039
X-Proofpoint-GUID: qe-2vLqhac-OWZkhTsF-cWJDQJEA7TKY
X-Proofpoint-ORIG-GUID: qe-2vLqhac-OWZkhTsF-cWJDQJEA7TKY
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are 8 callers for devm_counter_alloc() and they all check for NULL
instead of error pointers.  I think NULL is the better thing to return
for allocation functions so update counter_alloc() and devm_counter_alloc()
to return NULL instead of error pointers.

Fixes: c18e2760308e ("counter: Provide alternative counter registration functions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/counter/counter-core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 7e0957eea094..0abb28cd3d16 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -90,10 +90,8 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 	int err;
 
 	ch = kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
-	if (!ch) {
-		err = -ENOMEM;
+	if (!ch)
 		goto err_alloc_ch;
-	}
 
 	counter = &ch->counter;
 	dev = &counter->dev;
@@ -125,7 +123,7 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 	kfree(ch);
 err_alloc_ch:
 
-	return ERR_PTR(err);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(counter_alloc);
 
@@ -208,12 +206,12 @@ struct counter_device *devm_counter_alloc(struct device *dev, size_t sizeof_priv
 	int err;
 
 	counter = counter_alloc(sizeof_priv);
-	if (IS_ERR(counter))
-		return counter;
+	if (!counter)
+		return NULL;
 
 	err = devm_add_action_or_reset(dev, devm_counter_put, counter);
 	if (err < 0)
-		return ERR_PTR(err);
+		return NULL;
 
 	return counter;
 }
-- 
2.20.1

