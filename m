Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5248A95F
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jan 2022 09:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiAKIal (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jan 2022 03:30:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16208 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234988AbiAKIal (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jan 2022 03:30:41 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B8St9F002705;
        Tue, 11 Jan 2022 08:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=BT6GiUqqvW8Vkq2J7aLMfTIFBk7/i0p00JIzHQmlRzo=;
 b=obGODburUjDVbUPHZ1QcCB10I19rqeFEEZVHtfUXJjgVMwbuCURp9o2eXEnqfjhQp5bc
 6kI+W9yCGi7NQEFkkKUUshwXF+Ve+ksX7GxF3Mgy6C/t9M46jDa7WuRtw8WsY2qNHo6z
 qUcNOzqxnICi45JZL5l7U3V4REVHATp1QokIKnU0PI69sc1q80pa+yhv9bHD1frMnPwk
 8Xm3A7IdB8dFFCyNySU5SJBOtU9TdA369DiaR2tKXZLK7XKdMejgd6Uk6FWcc/hr8nXY
 g3yQ2Jhzthq7Rrf9ollpOT5ZHFrmXJggIvbufZpTe7vY3OrWMKHoEA6fPNxiBe3kJjcK BA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nj8qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 08:30:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B8Fc6m143055;
        Tue, 11 Jan 2022 08:30:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3df42mbpts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 08:30:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpLQCS5q/rMAsQUxHRJyxLvdemb0QtWJp3ZChe3P/aEN4nIwh0gczr95GfzqvF7pa1+gecQRvxx3BaXS8nvg11dH5d+qNwlL20kliOf3YTmbofVJPzti58gdGFwnQ4v99SZuXgIfzd5cgOr92Q9cqHsfkZR4QbZwLLJR9xaSEtKon6/IPZlGr7mB7E08ZsHajBLtNP+gYdf5NlkBFaJn40s/2m95DQZyHEITGnsFG1e6kQbhgmlXBJ95myYxmvTEXjeQ5ELPSjjTIKHejx9jC4JaN727oIi7D4OINpSxoTGjkQOByEDIASEY+YDoKiwVBMhFAUA1Tv4Ih+sk2hGeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCMF0ix9kdWEbTDL1cCAVLpcUqR4n2t3bOKrPAEzmjY=;
 b=NASLgAcj24K9ZEjYCIzsAH30gCeq4EB8JbkSYVdU7W5v4QzyqsIFkH78jvZehlyyLoq9L6PD6185B6g6PNFEJNuH8ubm11HLLtd76CXS3SRZkpf+XXGvDjj+TXxCPE1xy1gabsW1g0mjyLGgqANiSVLZDrdPKsf9fp0zSFOzBQkiBFLsS+15vLOQQAoy8mPDu8uTcJcsyXuPJON65VsLjMZ6xeGsoDjOY2DYMaP4p1TywyjBKcO1hVJvgWYb4t3dBeDqlejSQe0MOnFxEoclu1Si7BjrxTT3iPTpODre+zV0+QYIZJmhR4W69LnnRIUox4HWrfd9yhdv+OeuocXCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCMF0ix9kdWEbTDL1cCAVLpcUqR4n2t3bOKrPAEzmjY=;
 b=LEVGLCd8vUi6SbFq72m2Qc+LnouO/holwmJOdCMG48R/eH/Vl4MA96NFriKZdn7OwAaoyy7l0fYQ2unUwsKmEN6MJBJTlNtt3resybhDZqnHiT0+RK7fzjhQcku30B3hjJgvOzL13zN1ghwbRftFgBURTSRSSj8dxHrVKPjg9XY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2399.namprd10.prod.outlook.com
 (2603:10b6:301:30::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 08:30:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 08:30:27 +0000
Date:   Tue, 11 Jan 2022 11:30:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] counter: fix an IS_ERR() vs NULL bug
Message-ID: <20220111083005.GF1978@kadam>
References: <20220111072500.GI11243@kili>
 <20220111082055.4w3arxe326cn65ht@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220111082055.4w3arxe326cn65ht@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::29)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca749840-c8dd-4396-c425-08d9d4dc9eab
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2399:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2399B96A1C5A07DB446E87E38E519@MWHPR1001MB2399.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELQo4Ulas5r2LYRhIVD3FxcLZggMMuz9MGhk5hnnfnQPThHpzm+Qhc9MPRag0Gbppu2MCveCshi0ygNYLdi5KfXR2QCnROVoOY2cMhix4D67Cw1zTtTIGN+Xekpk/HGEP3D7xu3wqcBl70gFMrInRMxutcJS69ffsGBgcDS8+tF2D/3UfFWjRKbenV7YzvVJ7Ql/nodsbnlCMRJT58wumv88R29hra2s0MDVfVd9XZH9Dx5iURyJcUrdl41KrMbeBtP+9RmZBDvakBNZzaO3gZC5nCQwLqp5ITHNT7h9RWX+HpfU3FfmyaPmtSoDxYA2FpP0X7LIAqBUocy3sSW6RBzRmG/jBeluxvXL6OYoCD6Ch6/D4ew2hGVjdqmi91cy80UPXF6GMUYqBHlxyMZQF+Urd6jC240TBZ3tojqU8VvpW6OI/ZbuvPAgP6efsKjlvzPddQDJUhXSLMWX7m3uTVF/cua8L2vVeR1ZldBt30oN8BD0tdOv80QM2fj7dUM6HQDqvQQQLwsIl7PitrI/7P+THZwuymXdvM9l/6Tv+SAXqtptsdNC8T5MYkhKp7h/CWDWgZjnRfXP8f5nJoBIr4DyfrMPVK6BJ0vtu+o96v0tKh0P6lY8pHhvkrggGMWPHNxLmVtggW9JsHaqLSKKAo0Sl1qhgV1dqlV4u6t+tjhhGpwMXravts5IxsDZczPeYB1PYPnFnhpc2ZiwDYrGsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(4744005)(66476007)(66556008)(33656002)(4326008)(316002)(1076003)(66946007)(26005)(186003)(86362001)(54906003)(52116002)(66574015)(6506007)(83380400001)(8676002)(6666004)(9686003)(6512007)(5660300002)(33716001)(8936002)(6916009)(508600001)(44832011)(38350700002)(2906002)(38100700002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rdGc+Ehz2yWor+zS91IjzSXmuQKBCeGYF5eHh54Xh5hzL4JFr6Sv3poBYy?=
 =?iso-8859-1?Q?cBqbFSo+YJuGb8d/1rh2+h8x8XV7NjMLgPzAP0cNTrvHP+1yOZRGagGxFB?=
 =?iso-8859-1?Q?QxePiLAJQsX7A57SVLZ2mBWoQR8EoIeicQXAICsGAbsGoj1K9bmyd9pPX7?=
 =?iso-8859-1?Q?ZVssy/mJrIsI/jJNEMxRupSQDSUWTARqX387/rZvVy77qjznJNE2qQ9KX1?=
 =?iso-8859-1?Q?+PwrdC+E6jvm/GJJAmOWmDdzA1yqsgP30ZRBjtwMX1VWcjWMDkJUvyAE+p?=
 =?iso-8859-1?Q?Q5XUlRczK1TsHxuoLsxXQ7nMlGlCCP2YOn1jEm1TQ9HlSkShiOX0Dga+N9?=
 =?iso-8859-1?Q?s/A72/JtpGaib5vZ+7NA4iQgTuvitnpaYuGkGx1YuMXE94IFL+kg8lryqc?=
 =?iso-8859-1?Q?c8gnmXBw4cUFK3vXHmsIbZougUL2cV4Y4oMu9qxUTx9vrGRHS4/M6Ah1Xg?=
 =?iso-8859-1?Q?t3PgpnqCPHOlSixzKROnwl/+XLzNX/id6k8363HZGLWgbpEpD9784bCkcq?=
 =?iso-8859-1?Q?N7Aa/5lAOFsTWlBlqEN5m+ue+kWhbT5QBwVm9VNv5vS+hpeiZMVouV7EM0?=
 =?iso-8859-1?Q?qxD24P94nK3qAkrgCkV67Bxaktsvs7tO6PtVi78+U8tdUxlW5m7nYvlYIe?=
 =?iso-8859-1?Q?QSuQwe+ZQXkFbeRg96m4+I5uGQiMx1KJSXOjdS0AgpZWtQ94RYTZPxGUzU?=
 =?iso-8859-1?Q?BNbuoAFYaTd2Hcge6+S4CU71l1ZZp9ifmXMDTe1gXTJYzc6ngOGvgZpz06?=
 =?iso-8859-1?Q?sYtvmnxkfEkIUCm3NXNB88IeyIXzWxExTRA6UKewerK4PwPxeQ0+4rQfbN?=
 =?iso-8859-1?Q?Gz8Wzsvzq1KEiVUsLMvPa4R0XGiCA/8niqNyxkMnAm5XjhmKC8IRjv4x1W?=
 =?iso-8859-1?Q?4qHljdPvs3IwnVA51lg4YND9wMuoPpD+c3a27vVsfGIg9XElchEUTK0D4w?=
 =?iso-8859-1?Q?OlCmQJxMxVRom7rKPfvHgpc0no94xZP8EoAHnBrhFRGn1aBzSDGUGNoYpK?=
 =?iso-8859-1?Q?0MQUxwtkYHNCk0dRYf8iTCw0isEdFe898E4E1EiLxBV1ThZJANLXbJVrHw?=
 =?iso-8859-1?Q?0w7CVm8wiFcWB7SUVVLv8/JdPhuBYPJtLO6T4vee5pX+g4jHOJCNLmR9Km?=
 =?iso-8859-1?Q?ysadMZFj5M2eTx0rSvZzbAL9MfpV56fAzJ+Gn3RY2sLyJ+UHUL3M5bzksC?=
 =?iso-8859-1?Q?3vDS/x7ttZYRV3Tisdr3u++kl1KTS0mQD8lBbQ6sZzDrkAoPvYNry+Lohf?=
 =?iso-8859-1?Q?0UFTyMYHR2rJ8asLdvxgx+y7qxtaO+RiGqyiPKyUJJbD+Z4sFR4KoHVADI?=
 =?iso-8859-1?Q?qk5zUWS2ey7fRvsRKEB1wj+gY2i8R5MhOSfMMXd4XRdimevn4xsuQpVyar?=
 =?iso-8859-1?Q?TpIfnmBiIUkOQ2AZj3t55Ock7euwMlGG/yY+ZlUjv70LkVXT2K8zQK4kc4?=
 =?iso-8859-1?Q?H/Rg2hpClVXJPr68vVTrTofAaMpXhXV+jnnLwjW3W2ToQ3gfDXRhWwoJn2?=
 =?iso-8859-1?Q?/oZUBHGzyGuyJul2FFyRW101kONznfM9MomiRL2E30M6K6p4GVZkSAlOOO?=
 =?iso-8859-1?Q?8+wnkk65JShBb6TUO+XEOzwy9KWJyWFbGPIPhmV5KSDa3vhg0x4kdbWRo3?=
 =?iso-8859-1?Q?JNct8khXP/nm2/jQMg+6gx5/TCJ3sti8T/IVREyP/SrupFAYJ0RUTGOu6S?=
 =?iso-8859-1?Q?w7E2/vtiJRFeFkz9aCnZRrpOHln1SVvYYjAfYt+9V6p1NyeS93g+kxSGbI?=
 =?iso-8859-1?Q?noILCTHn5RuoWJmJmFw/Gpm6M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca749840-c8dd-4396-c425-08d9d4dc9eab
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 08:30:27.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wl+W6VFoL68ro/yNMyNPTtzP0vfmm+vqOhDkaKtQYjPaklVtwQrZ8+onHSiryrNqEpBY5LfSMPlN8KEBAoVjcO4rCkNs053l1qo6HYlDNVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2399
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110046
X-Proofpoint-GUID: e2M9eHTuL3jxf4UtNWmVoPeU8IkjXPQg
X-Proofpoint-ORIG-GUID: e2M9eHTuL3jxf4UtNWmVoPeU8IkjXPQg
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 11, 2022 at 09:20:55AM +0100, Uwe Kleine-König wrote:
> On Tue, Jan 11, 2022 at 10:25:00AM +0300, Dan Carpenter wrote:
> > There are 8 callers for devm_counter_alloc() and they all check for NULL
> > instead of error pointers.  I think NULL is the better thing to return
> > for allocation functions so update counter_alloc() and devm_counter_alloc()
> > to return NULL instead of error pointers.
> > 
> > Fixes: c18e2760308e ("counter: Provide alternative counter registration functions")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Oh indeed. I wonder how you found that problem.

Of course from static analysis.  Each caller triggers a "this NULL
check should be an IS_ERR() check warning" followed by a "potential
error pointer dereference" warning.

regards,
dan carpenter

