Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A7B4F13F2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 13:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbiDDLpN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Apr 2022 07:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376291AbiDDLpK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 07:45:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AD462FA;
        Mon,  4 Apr 2022 04:43:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234ATcS8024447;
        Mon, 4 Apr 2022 11:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=rhkhDM1RNY7cYcImd9QdVoz+gy0kt5Lq7rtglJnFw/o=;
 b=d/m9fPjL0Zj1ev/THlSxNbVHy5D2RaiApj5ONvM+3+e1+sv4Ff8WNo0zz6DNBQuHg8E+
 OPs6PQKPriX88flh0+CLm6tRisG7B2yQGoC/t/nvzetw8Ngcwvjnz0YO3FYqCDZkbMvY
 5gJuOUXwP45NlVnNt0pWfvn4K0nkleBuGd3hpaXNGR2lCIuQA0mIOW2rTLvMAoQURI8I
 86xfTFrVShFobjeXj7ZUR3gIwkBqypr/GTSW6SYM2ARKy9Q1Sq/Nv84Klbbj7yXLznsG
 H0c3Dc0Z5omFZyEpR7j1VTZ/0AaO5Ok3wh1ESEbTCubLsAspgdAvpiZ8Fxv0vXz5epV/ LA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t2w17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 11:42:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234BfWZt034814;
        Mon, 4 Apr 2022 11:42:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx24x2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 11:42:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM5JFMaIg9eP0Y+qgLubBcu8AkWOc3NFKc7ZsLFUYpYWSdJoen07fc91OR07dpVLjPdSX8DdEOuPvU1WRPup0DnGVQBRG5qbG6fTsTrBgIp4OV+nR5GrMi5gdnncGw2ncvmfv4mi35O0qCBbIiCqElLV6G9ISnPCgXQBKMdXliUcnRcGJ9Lp/Ck/9PwYRrjJUFjeY/DesuZOO8CcZaTa0UGLUFPRWoL5ma32SE2vRgVMnlwtlhFB8hBF7m944q4hyr9tEg991yV3rOCjZOXz17XraqgCHzXMjzwsmUpv18OpvibKwH3ZkknsZfTRbRSmnEcWjGkUsgY+aYKBWlDGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhkhDM1RNY7cYcImd9QdVoz+gy0kt5Lq7rtglJnFw/o=;
 b=JkmJ2eFIzoXfLBifCj7pv1zkxz+4dQqQ6JFZhp/9w3YhxPLz39gke7PBJuAvFhu3osShc6i9nZ7f5r+ZXYsSQTDf/2QH81xXViCxEugwz5/+mX65bbC7eZsZ3MryelDVtHDDcuO8gEmPoFdZaVm5+GQLuNiD3l/mi75Uu3FgVpooNuItk6/o2f6Fu4pybn9JqdDkoRdcrrIRZR754/dhsqm231K+qjw22tVNEb2F1UnaW5BgDdqGzVB65mrggBfwAYCM8vuDJ0adwjilvXpxD7Aj7UHVu6vQee2GR+ZJWEIF85GkP4muH5GZ9UtAdpFuSxyXIy88ZljlP7iQXEpLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhkhDM1RNY7cYcImd9QdVoz+gy0kt5Lq7rtglJnFw/o=;
 b=njIvpqauu6eKK/fRZqaeuau1uaBs7IWx48ykTiZxc+DveSCObq3LWl+2jNTihrsLRrDFNIq/5Xw6/IuH2lP9bJ78QzDdGhJxv8EN58SPz1kYqb/WBnL194rLmbyQRUlwDiUo+XNFvzMr9yYxZppGL3QlMdnxMHGPkStglZgF3w0=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by BLAPR10MB4898.namprd10.prod.outlook.com
 (2603:10b6:208:327::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 11:42:56 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::ddcf:9371:2380:d00f%7]) with mapi id 15.20.5123.030; Mon, 4 Apr 2022
 11:42:56 +0000
Date:   Mon, 4 Apr 2022 14:42:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        "Sa, Nuno" <Nuno.Sa@analog.com>, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio:dac:ad3552r: Fix an IS_ERR() vs NULL check
Message-ID: <20220404114244.GA19201@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::16) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ca3ce3b-bc3d-4403-d180-08da163042a0
X-MS-TrafficTypeDiagnostic: BLAPR10MB4898:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB489899A947F50026D5AE266F8EE59@BLAPR10MB4898.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4iEooCz+TAamLOvNRqofvqlKNoSjGWsln5rbcgwlRuPNxXxICln4S95VU5ubqXK3lelJcw4XIvH6TnC7P8/fR916DgTKnH1oCrh3e5HeR7+y1hdgWA7L9mQXIhXNwVMx6uEf/vDdT1KMQ5QWugfhFF//oqgsuIWvUos2dzNN+vr7XP1QBl6WMTtNP9/PvaZb+R9J3tBh0/JI2ZScavzHFNwlfJN82lvQsn3zWw8wYl9xcl6h74ZogV42+J5hEDZ72oL5Ct1otmCF8TTG7RhQPuomcI0HIsXKUAXUk9lsNLO+Lpi7O+XDFfKBO9a/NmfeEdsZQdlr+RY3Msi/1hD/0Qdmz9OeefhsDXTg4j58u0nSC5PuzhKI9p1yktvtX/R7q+AjqmgvdnSWNOI2Kv2+UlgdTRNyE/VUsJpGGoxtjqPdGsBcZHOB3zGcuBu9cMpCJvuC8jLe2KM/MtbfVFCToO120zyYYYqEvZ2F4764U9SviJ5KVJtnVmS4OL4uPppnlqI15VsAufv4LHkWoCcVFnZmm+wp6ra7sXMTTtkfokt/hKyLaN/BxypQ+NdAA9vA+Ba5aBU89e+hv7Yp0LC7hjnunQ15FdPta4o7uyi7gbj/QpY3XdykR+Ew9E2AiW1EqxxFfqdjryVb1sZ9yTBaSe7Lc5K2EJLBeG213h4AAZlF4OgzmtaOde6BB3UYfyt54IKliv1bknImOk5mvYW/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(38350700002)(54906003)(186003)(26005)(5660300002)(1076003)(33716001)(316002)(6916009)(33656002)(2906002)(6486002)(52116002)(508600001)(9686003)(8676002)(66946007)(6506007)(8936002)(6512007)(6666004)(83380400001)(66556008)(66476007)(44832011)(4326008)(4744005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?imtclMQHunqRTbhi5mhckyqBsadxtg3VaOZc56ru0PiABq3rkE8OmmikPKhp?=
 =?us-ascii?Q?B5gefs+U00IJvnYQ/dpUfT/XEu4HTVaupoUGRTZYokakued27p/7CGoXjZ1a?=
 =?us-ascii?Q?+WX90OgVQ9nUPFpTz2jzZ/qcHcOjAUf4Y7Wx8IEm7NYj1+OTIbcAxQKAG7ul?=
 =?us-ascii?Q?wI0LUzX+M+5D99K7v/6RHXRU10KEUz+K1OHzwVAUXfRcsqWmbw6W+XYYm2Wb?=
 =?us-ascii?Q?WcAvYMvM1SX0aGRI89kBHQf7jrJjVHmFmqu+cIN/+2Kq3JXaOyeACxlqvyOB?=
 =?us-ascii?Q?Fhcp5197GiaBATqhnTXsmEZxixlEUB++sfaXc8q97dLMeFmrbx1Sv7aog5wE?=
 =?us-ascii?Q?hcVZaJ3K2IpUNYAd+An8NFkSm77VsLw3qxXcEjFogWRHF3fdhfYmbqMwtjLX?=
 =?us-ascii?Q?n+DNKdMCYFooowpT7YpCbPIBC0iCCh3lRH5ukfZubIo7Z9k2jTw9fSNFs8RF?=
 =?us-ascii?Q?+8NvB0mRvw+UroOReuPILLtnaQ7beMGhr5sPYKsyfIR8MTrId9ZgUJh5GA3a?=
 =?us-ascii?Q?XRdSLlScadJs6+IEyOB6YYc+NF4rWc0Ue3sXCKMT8MeuZOWYQcCEPHHvheiK?=
 =?us-ascii?Q?nvUMstP67pfkNqnTtaNQkwUD2v1uEHIMzW8eLNMn4qtesDuINzoTJjHMlJpO?=
 =?us-ascii?Q?Lmix1+GZ4FaheOhNbFeGXMRZr54alkXExzW4B1QRbBtMe6AwPJbkl5ojEgDI?=
 =?us-ascii?Q?TiA7zA+YYlUrHGsdgYN/5oisB3K/t2w/3Jv06Bcn71R9XqEnGARaGhX5CteY?=
 =?us-ascii?Q?exg062+wJI45GtZX36rO7DvxPaDw8NaXXTL1d8Y1Nw5YKkVzncD77y3J9kNo?=
 =?us-ascii?Q?XBImEuZ82LDa6Y2rRN6LLyIqboGa6Iz01u51BZxQNbsduh8owsM9BqgNqPCg?=
 =?us-ascii?Q?ft1IXkUaB7Vi3a8S9yUY5l2vBkSvCXwt+1/1vCOAt6AEBEiny/ckw+TjFT8b?=
 =?us-ascii?Q?lJnOKVYiZjWjlclLV6AJJzHcgQ5jhCRsqLU9x2sfznTIskr5+dR5sU0SHHSK?=
 =?us-ascii?Q?nbE0CIdsKzlto9sRW0/5cRShreJw2rx8FcBAiyXdlvyMuA4tE4DWIzKeyxVf?=
 =?us-ascii?Q?KeG1PnT0hLzBSZi+PuU9FTiB7E8UOF7qgsmNEG+CEwksSEdOgGOtoJnWyef7?=
 =?us-ascii?Q?ZIsDrVIAasLUKsiwmeUCZ6k3j8wCYU2LPuJyanGYHSulEb4qyqBNsPHeqMQ+?=
 =?us-ascii?Q?pZaU/pH9I37ekRnA5U8bJQel8iEvUeoeVQayuuLhZ7FO2hq5TRLg+Sqy679O?=
 =?us-ascii?Q?K1bn8zaOWOQMTjojsI0iG15GlwJPpow6S8ArwzJII4ssOGHBG7+E36cDDkq7?=
 =?us-ascii?Q?tTfzfscJmrnfZ9iRl/seIlsT1ccP13x3DmV7ABR2N9/4fBtw4Zlc0Nd0t3Rr?=
 =?us-ascii?Q?VbYAi/949TQKtFEqXldWZnEvsqu2bQTwzaEOJWqTFTMYRWpxqMWQGI/kLpDk?=
 =?us-ascii?Q?e5lTlcEj4nRz9L/p9iUygUs4LcGu63HODRgrYBiOJ4ikCXqIor1gajs6nl6o?=
 =?us-ascii?Q?byWGvSjxdfRdomvCkjRJdhs5tke5cKXKwEPbrhtD5800S60k0h4Rq4snc1ug?=
 =?us-ascii?Q?Dsr8ZUqc6/zBNOs7fNBB1KSuSfBI/Yzk6xI4YzU7OSfI3swMzouLSTWZCvij?=
 =?us-ascii?Q?PpvJvwkF74kguXONBPvj9UD3fQm1dVrvEJXs8faieBYZg0P271T1hMvJmWG+?=
 =?us-ascii?Q?D+J+FI6Gm5iF1L6m45qC8J+R/z46epAGjnLq0f6nyrzIwAb1zKssDWFKb7u5?=
 =?us-ascii?Q?4X35RcZp6OqOGPNPv7B2jeWjOBp4jG8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca3ce3b-bc3d-4403-d180-08da163042a0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 11:42:56.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INide8cOBNQAXZRM61OD33FdwYwHnYwgf9t4qywvl99hb7Vq+9VHKWj2OES5H2CagTaPQAU6LiDF2kXUPyEf8kscKiwdcmkjPMO2YfHHg3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4898
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_03:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040066
X-Proofpoint-ORIG-GUID: k2khQtORNn6h_G_rsj00PCpco4QRtk1w
X-Proofpoint-GUID: k2khQtORNn6h_G_rsj00PCpco4QRtk1w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The fwnode_get_named_child_node() function does not return error
pointers.  It returns NULL.  Update the check accordingly.

Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/dac/ad3552r.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 97f13c0b9631..59f49b7564b2 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -809,10 +809,10 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 
 	gain_child = fwnode_get_named_child_node(child,
 						 "custom-output-range-config");
-	if (IS_ERR(gain_child)) {
+	if (!gain_child) {
 		dev_err(dev,
 			"mandatory custom-output-range-config property missing\n");
-		return PTR_ERR(gain_child);
+		return -EINVAL;
 	}
 
 	dac->ch_data[ch].range_override = 1;
-- 
2.20.1

