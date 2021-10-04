Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D8342108D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Oct 2021 15:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbhJDNrQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Oct 2021 09:47:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26994 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236446AbhJDNrN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2021 09:47:13 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194CuEbA026334;
        Mon, 4 Oct 2021 13:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=aDaTUvFUOTbB36HJnmn1SsoEKN7NwVF9ZNP5PSW2Pw8=;
 b=xxQS5LYo6VMQPPdTiOzSTDgb3YjMQbP5Eh6eBnWiDqljezhcL5nHS+0d5ZEd2tkKhSKd
 wP4VgXtf4WvWQ27jaqU0x9cuIpCtg9Ussws6ZUGHstDqxyWRSt5akxYwNgwmlfAcdUMq
 URsNfoIQZY7E96v/58zH62Gj3eaO4i0+q6w8fpNkJpfC3/TJVJ3MAkGcpZb3x6lmXlsP
 Pmur/VvxIAl/uUDqTEFJYFjLgXdr0btJdNKA9hvVlkBES1b1VQrmHH8N30AH81D9/69R
 1ixsG63xO+xzegt4bJ3BJw25kl3BNz6dqyy4fjKcfW9MISiqXblKzNNhtNYY3mnnl7UW uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bfbb144jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 13:45:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194DebFm107838;
        Mon, 4 Oct 2021 13:45:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3030.oracle.com with ESMTP id 3bf0s4w4xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 13:45:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnNYNvQ0TP8lkqDhZWysupnrNnrFrzjx5yAwjAWmmD9JKkmcLnScB7ddeUTx5Bkeod1YhLJtf1j9Wz1k1uQwnt2/UJycPjOArvArX/OM7e49SR3PwK7vY6dbtD8fGDCP6nG9IjeuHsw6mDls717ZgznEM1lYfur2UzaRqm88cvIU3ml/7hGmGjjSMBTE2emTDRgcRDp6brhZBxmfXK0yNW9WUn+Gy3Ozo78gzydmgs1dctANZ/q7VAaZx8CAECr38VCuJXkLoZS5RuNGDBtNpHcMvWmlEwDOzMvE+ZwrnxN6sWqvZZQbihtotw9r8cHUPpt/pJWQLMSoUkan7TSg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDaTUvFUOTbB36HJnmn1SsoEKN7NwVF9ZNP5PSW2Pw8=;
 b=YzowbVEYIVnOySpD0yTSfPldIX4WtAc4qQ1NAUk3WlIV8fjvjiaO+xHUbc6BOi/EmMi7Fvp4pfLioIP6LhNJkmT6uMumrXBfM1VW/qjTSAasUd9e3QgpniS6oF4CRtozERGHxx4GDKDTsHvjfjlWmBPd97rq2NAJB/b8YPrcwHAnlYSbohx5+K8zvBXWXLxacWZIZZslyB5hov4jDfJv4He4OwQBMaSAgyBFqsrhC29/jDQOfVTzquXCOjF51sVbmtFXiRakGk7N9ovqkB0XQHVwFcc4f+rgW+prrNa/Rsu6ELUjis9N3KHXzlrnRnLn4URWHSFw6D7Mhhtb5roTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDaTUvFUOTbB36HJnmn1SsoEKN7NwVF9ZNP5PSW2Pw8=;
 b=dVJQFVDbvxK9UoIuBFSpgoulluMHh2kCn9j3z4b45yRMROIOEmcDHS5075fLuy/RwMg/0Ff2gB1sd6ZVErNRbIAkPpWEtXyQkESlr8GLDrUjzSxK+C8dmr7AK/0z6SXDR8nGlFNsy9+g0PR/pfvxnMCX8v/oBVYWskt0qQbYZWU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1552.namprd10.prod.outlook.com
 (2603:10b6:300:24::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 13:45:05 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 13:45:05 +0000
Date:   Mon, 4 Oct 2021 16:44:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: max1027: fix error code in max1027_wait_eoc()
Message-ID: <20211004134454.GA11689@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO4P123CA0367.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by LO4P123CA0367.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21 via Frontend Transport; Mon, 4 Oct 2021 13:45:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e4fb0ed-7c18-45ce-c973-08d9873d2bd3
X-MS-TrafficTypeDiagnostic: MWHPR10MB1552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1552F2DF14DA4E39F0EFBB238EAE9@MWHPR10MB1552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mb1Se2UxIwMXOSrnH8a1gdiPz6L7ut+/FNKpCUnoFM4vbqX5k82hSEpM0iJaIwz8o0ZsoFFuPeJXRwmhVmAu+Sd8wvutZssYg17IX+XwBCYzx8MZHrmME6pG2Ef97E3+KaHgGMdgjdopGep74ZVdUbnWl8zvbHy5P6GfHtbiLKISkz7HipuLBLkrNavXVK5YxsyLa8W2Lc3zTMG1WdswFUKSt3NaZcZaia+Me+qt4FvwQVSt0pat4k/FH8IC78oLsju9LtMD+wzwgjeRNfvep+PVcwGX3WG/Sp0MSJblJUzdKIvhaUhz8C8NOVf2QcNgCmEE3tGSUNYZGTNgt1X+3utNSNT97qWwl+0lcKUAsGUYgfiDYU5XBvSCmD+JI9dQW6dXIX7RQtkUwZOyLQEH0E7YmVKuygFSe2qXMuX/Y90rqVU407VeRtUozbD0vEgmwuOPOZr3LzxWJ3vDgPM7r1a11BRHWoCMOoA7jZ0VoaRw2/M1ekHHDJTB4S9Fh9kAc8LReLgGw038XejbXobGaJyNQTTlgO3fnjtLTBfj37J/C/XWEUBCQgaMfHInHpX4FYC3hiWnfX4zAL4GifKSVfb5ImlG8p5wl+QPjI1k+nlOnlWOprtDEeKF2OQrE4E8v4FheaVSiJ1vVuFPmC0qjGv6H33AAjMHfYKbmm3FD/Arjyw/LzSrIM2qR9eimswD3u1YpJiVswM8C7TuNeY5+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(5660300002)(316002)(8676002)(44832011)(508600001)(66946007)(54906003)(110136005)(52116002)(33716001)(33656002)(6496006)(956004)(38100700002)(66556008)(55016002)(4744005)(38350700002)(66476007)(9686003)(83380400001)(2906002)(1076003)(8936002)(4326008)(86362001)(9576002)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bto0IO8+bkhdupvXx8W31NkZiSO0U2Un9wuY9Df28wy7nVvWxpjj+9hsjro+?=
 =?us-ascii?Q?oSElv9qKDNjEfAQkkXCUiLy6/l3Il3Cz6Rh8Xuxyo6L4D1IdJOTiS+Ly7ePU?=
 =?us-ascii?Q?okhY4agdxwYfekNZ21Hl2CQhiCYeHwtlm8sztMwa62ZwdIfNT8WZzMmg61R2?=
 =?us-ascii?Q?+v+ePTUzkGSByYmGIB9Ebb1rC2iefZfrB9G71lCIjCN8yyoYQVLNfOZ31XHq?=
 =?us-ascii?Q?ZWv98heKtjibIpTKgBPN1r23qZAi0gyefN4bJoydCDy7adCSsrrV9kxvq8hh?=
 =?us-ascii?Q?1ks76cKFvJfJ2PL73xQU29sQOm0UNXf8kczOeXFTL5/33FQ2bqZQ9zNfbUrW?=
 =?us-ascii?Q?gcBOxR84PHPWUx5k5EvbPiAPqypSSsmQPb7UGSsNaYPtueSisLb3FLJvp452?=
 =?us-ascii?Q?ynjEqd3Ut62/pk/6whQFJmRNnHaCV0OsMMqmlblemzkB8+IVpFU/fFW4evoT?=
 =?us-ascii?Q?U2IEIbRjXjf3DPD8akZk/0tF37pvTVMRr5oxgF2c5XBix30vhA6B+J26zdjc?=
 =?us-ascii?Q?fr8tNQ7d7kLkcCmAhUsgK/Cyh2TTRe9jmE0bZrtBjPLPioxwEI74LihYU9PG?=
 =?us-ascii?Q?45VtA+Xoq8K5zZsGmF30cIa+G2WpN2CdnpAnzwMcBrGh9UDQn8I371hHUD+4?=
 =?us-ascii?Q?s9mGtz42zi1GUQ5LMEg0q5VeEtABJYiWo5ee+R8T8JPCu4gMs2n5s0a4AAu7?=
 =?us-ascii?Q?zsLqWhlTcO+LKDLaNycvG3prqB2Du8AC7Np+h6wWAURs50Wh11fB2dzbVeeT?=
 =?us-ascii?Q?/tvJ0Tny/cr8rrfZfTSF7IgiPd3wY8V6KVz6BRk9KTbax5+NAt3PFncsBTK7?=
 =?us-ascii?Q?iYl5HOVcwhsC8ogl7pSUKYJfzm9fyy7RfjjrK4T1aY7FuBim27AKrWAPWg5R?=
 =?us-ascii?Q?KLS6OYAOkXVuIkUnAtFG3LYt9J51IOkDV8WUFESPbh25j0yj7Je2G+FHHv6h?=
 =?us-ascii?Q?74wwUdK+EjHcd3xVeytqMNhpNfmcqCCWL8FPZyxavTEKdFHgZiwVZ0pPXDNc?=
 =?us-ascii?Q?kZnNCHTWzcRnpxwrTpfeb/J9I6TNmmUVwdBZkFmJFsio0zERTbgd2nukBO1b?=
 =?us-ascii?Q?qtt7yx7h8/9bKw6FJB9LSVohd0TNY1QLKlAVFvWGpRfA5ErQIijqeG4tYTRX?=
 =?us-ascii?Q?Ay0Maze9IK5QRU/xDCXsNWqdeV/Z1IY2dxCQLVFRWy5TwE5mVmq2jsPJXvOM?=
 =?us-ascii?Q?ryRqp8dk/U4HM12E+nQeM2p+tBUNmDS60wOyGcxfAhrzMC8dvoWI848wAbHo?=
 =?us-ascii?Q?2YDlyaLN31D9v9EPsz1NsIr/f0iOAgWwVgfz4YCKbzfiv8pF1V6l4zIXSKQK?=
 =?us-ascii?Q?tVEonWwlzwKlUKI1hfeJEezB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4fb0ed-7c18-45ce-c973-08d9873d2bd3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 13:45:04.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyjoG3keA0X46rsF9ta0s54ctTxrE/38XrMRdHhOakGKFuhL6goKd7wLdHecI7oOQ5+UUVGonhdb5qmGLaz9W4aWUOnDWSqyC5qAZUuYJSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10126 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040094
X-Proofpoint-GUID: lFKD82HRnBkNNtfjrr1Mxshj85rZifUw
X-Proofpoint-ORIG-GUID: lFKD82HRnBkNNtfjrr1Mxshj85rZifUw
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Return -ETIMEDOUT on timeout instead of success.

Fixes: 54f14be01e17 ("iio: adc: max1027: Use the EOC IRQ when populated for single reads")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/adc/max1027.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 45dc8a625fa3..4daf1d576c4e 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -286,7 +286,7 @@ static int max1027_wait_eoc(struct iio_dev *indio_dev)
 						  msecs_to_jiffies(1000));
 		reinit_completion(&st->complete);
 		if (!ret)
-			return ret;
+			return -ETIMEDOUT;
 	} else {
 		if (indio_dev->active_scan_mask)
 			conversion_time *= hweight32(*indio_dev->active_scan_mask);
-- 
2.20.1

