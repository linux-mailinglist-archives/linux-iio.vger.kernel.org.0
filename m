Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41AC5BC2B7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 08:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiISGLu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 02:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiISGLt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 02:11:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22281AF27
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 23:11:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J0x4jJ006295;
        Mon, 19 Sep 2022 06:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=AMSoYraNGI59yAPo+7jVjUidcJE9Aa++G14/Ea0APxg=;
 b=yTWqeZiCgffmVtKYi4fpWhdvxNyWVhA3Kcpo0aH4rMoJGGx6efIX+F+59ZOEc7ckM08N
 h/DfWTg4rITYtYzGzC7MbkIhm/XuMXTD42EX+F36xjhsMjhqYFs4EqyztttPxt35uu1j
 ppOpyYnpQrotC6Kxxj1cP68RUziJU8okUOtAu0+9dO+2fCy4vApiWoFYI7c01V9weeDU
 Qk226piQG9tQCpifU/V7DfVjD4ELuV1co50oFtDnPXFdA5rc2xkUwL1RE+AqavQh6F6u
 EnxVvfqH3DBlyCqre6pJSn1tP/CKErlGod2W5G54gm0Tz0GX/v3O2XHHdrrCzpM+oiLR dA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kjrx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 06:11:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28J4hAIu036266;
        Mon, 19 Sep 2022 06:11:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39bxmnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 06:11:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hI1iQLh2dKYs4e8rVANtvXS/D7BN3tKZS2QgWQyzWvVozYqU9pLWDqbZNl3mBSrF5br8NeBFfPRYywxECE53ye2ZiAcNMBXya9glzRdTXDxAwWp6Zs8SYiThxtqijrZP/XFUHzVMnanS25eUDfnqdZ+Jri8mqJ4QqOVEQ3NcgN+0w2SNQdBXBo+vA2E5lBM+5lYirSqT2g4Dj2Njyew4yzkAJc4OZOb/+bHpV85DYuKhDW+qJ2rCszl+4yfzCWlxEJtjcykSfGrw9SO1Zo1LTtK+hdHE8CrsNJ2RI2e+prKllG98LhH5C6D4+Hb4by5PcwUkUb26rKLn2xB/DCxcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMSoYraNGI59yAPo+7jVjUidcJE9Aa++G14/Ea0APxg=;
 b=ip/K6m0yB5QKg1nkz0vYpITtH0658UUOD4oSitDcvB2ac0R6T38LV1nt0MveNmCaxOmYSdBxjch8sMDAaTgha6LN/s2XSSKOupJwxEZ9ODj+CdVs0nFB12z52M2HcgBRWLwUzEPMKFwd/d3RbtJFGZ3/KzpU/WysoFNmDe3tj2yw2TPY2B/RuFNypV0KmFMW7sTCg47PS5MkdA+pcD4Mw/bRN3cmqBcD7hd/P9F7stKn91Ib4qzehvIspyLneFmCM+1Hhet655oV0BnJMdnWzgCfK5tcs1DSqcbk+xn4jGmcOjJHB1Vt99mr+iMhzGVyyZhYQoaWndC+w6C979t8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMSoYraNGI59yAPo+7jVjUidcJE9Aa++G14/Ea0APxg=;
 b=fjrRzWYVq/wFRCdq5QXd/iu60mqYSdtKRTpvnDSclXvfXTj1DikHgT8QY7hIpofZQU+O9fpDS3dw6xxc5jdCRiLu71TtKLivds4tZoxe3IX/z774yLHP4Bd/V8nGlPuiflJXQiH0xikcaumyVqbqyXqThAgjGTUn9TKZDUKjjxU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4182.namprd10.prod.outlook.com
 (2603:10b6:610:7a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 06:11:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 06:11:25 +0000
Date:   Mon, 19 Sep 2022 09:10:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jagath Jog J <jagathjog1996@gmail.com>, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] iio: accel: bma400: Fix smatch warning based on use of
 unintialized value.
Message-ID: <YygH7FZ23HioBZGH@kadam>
References: <20220917131401.2815486-1-jic23@kernel.org>
 <CAM+2Eu+YCtCMKoWS9yJToEV__YB=enh=54b5thO+q4wGE80wZA@mail.gmail.com>
 <20220918184503.0db7e82a@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918184503.0db7e82a@jic23-huawei>
X-ClientProxiedBy: JN2P275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CH2PR10MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 26599120-57f4-4386-cc1d-08da9a05c866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8mNvRR/e+py16SrEvmy0vxjY6l6obr0MHPS5xhQhynxzH4/DrlFesBsE8aH7KpIIfK0Rq0JGOkj8aFJ6FPgKIRsc0pJVOYUDN/kGZ2PAtWJ397vdj22Bu8iembFr9+CjBCJS3+zoteRAl7aNpfqjFDo0mBrpdu3dllbwZBkKN6vtZJJiueqaFa7l86W9m/ImCPteLUR/PPiOHCu3LEuPTUUADTd6vIAeqzBAboMz9Elv5WbP+45dLRjsHdLAEK7IPJwKvpPe+HVIH6ZzBmi6YRolF6WMpbQwTwX5WUpK+ZUHX0pGiQxFHEK2wMLbTT+MqJ1PPc+wMD77VKrUnV6x1WPLUw7H5UtEHhW0bF/elaz2A3BUqIn2TwPlhlCFbxucZfb5M6s7+q7IrhLwlPRihOAGP4LSscg2DseV/64eQ3z4BJqyobSsUB7EzuuCgOjkOUIfIQ2Uj2ztjbT6nu2kfEN6baNGFBbifBlxUs+xgjMilFaETpkPuerU6OTtP6ZlWCnu+FYDXMHt2vTbluWFPJ9LhDLgCjxu264/Rr9yG3gsnspcRF+rng5yWyLpnO1qReih6SpKw4kRnc3lkWKY0veftLupV4Uq4X/fqCVk0KAdz1I+b64w5KxujKbPzfY6V1jM0b1yW5WR6fSodUvgVyFJuvx7l/WiIq7SD8ZdZ8XO++7sF8LHEVZMt8KwJCOLQkVApO64q6xz54nOhyqGWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199015)(5660300002)(186003)(44832011)(4744005)(316002)(33716001)(6916009)(54906003)(8936002)(86362001)(26005)(6512007)(9686003)(6486002)(38100700002)(6506007)(4326008)(2906002)(478600001)(83380400001)(66476007)(66556008)(8676002)(66946007)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HEFnf4fSIFRV7jl3j/voAKqYqJd36rUOfyRCyOxU4ZKcs3KAagVxFe/TxW+D?=
 =?us-ascii?Q?cqpzdgytxIeXHsSC5vh+ZkCVZzIOjvmSs0yqbneNPvsnkqBL2Ld6SDKZ85ov?=
 =?us-ascii?Q?OzTiEgdEp5VPejgUkcE4D32bnJYUhEkNxwaYS2oCwYiz98ThcFPBAj9NVDdM?=
 =?us-ascii?Q?XFq0yvWSkaLrdG2c+wX1qPy4AwieqxbGIUvAaKwHmVg20zlm0eITRb7Bxg8Z?=
 =?us-ascii?Q?bJVmZPE5Ci+jBkDlgNP1HchA3Ex6m4zm1bed8tM+x4JFiz2BNNLiyOKh3QEN?=
 =?us-ascii?Q?b37q6iRgAEAO3vEx8/LajvlU4liGeh4XCHSVFEl++m6dyCuOunb51aX6bIJ7?=
 =?us-ascii?Q?i8epyvTbK7kOm7WRx3uxBN7i2TnbehvnXVfs1v/AfwtZbNzkahSxtOQQcmgV?=
 =?us-ascii?Q?qfylAXJy5PmeH6qRT+r1sXXyhChE6kF/Xn5nmhQiZJ72LcWp5vdQDRx3b1Rx?=
 =?us-ascii?Q?ouuAvSqackZ7foUFJjOYN94X2EWOTmXuY+DaUq+5pFRRb3HHfiFdBPlLSb+Z?=
 =?us-ascii?Q?G1OUtQC7Wm4eYgkwUSHp0HR1F/uKu+CIpiBoiRnVUIr2ZruOzA41CDfAhLLU?=
 =?us-ascii?Q?20nRR5uH4vyCNEkLTkV8R6M3z+I4MwBEUBjLJ8cftfNuXNRHetXaIXiBmxTi?=
 =?us-ascii?Q?anzQpHH27bVv7c5EnsFtdZ9ai6Og7pm7PTzArZOdK7fVC9WQVf4VABrumMbD?=
 =?us-ascii?Q?1mqQKNl1R7X1UgKkE15RiA9OKbwncC2QN7edxlUgsKwI33lP7R8BkOYmqajd?=
 =?us-ascii?Q?flwPjdt1BdSncFnUMeMayoaekEyswAywRd+PlA4ahkEKFuhVmxfARVlMi9U9?=
 =?us-ascii?Q?IM73gp7Ua0SnLOle37LK2B9INJxC8dyFjc76anKjS5sQ8g/yYJT5MF6szPxA?=
 =?us-ascii?Q?rzjITuW1z80L3T8sacOhn/sv+UDjfBDccj3YvIhX86n/f0B2wYEjGG39xJaK?=
 =?us-ascii?Q?dEmmkiVSDbYbewp6S3aoyPoaErnP1GxWKnGivL62KhYD8gL4K2Ixebi3JV4m?=
 =?us-ascii?Q?JXiksA9s/G3oYH3ZvkGo8pDEKpadiNa3ES91YS+obJq3h4NWjUBr9p9P+tFd?=
 =?us-ascii?Q?QaPP2v91+QDV6IvOM1RC8UNPu19uqWgIq1ASxO6ag6/NUco1yBU/8Q0i6xo3?=
 =?us-ascii?Q?FtY8JsAsK5bByk3QUu6yvYRvhA32963oviBHrW+4rq25CV/b1VEr+ICt7Q3j?=
 =?us-ascii?Q?CihyuBF0mpwCTYH/BzXczJ9f8emst/G8tWDLL0u+XJwOVxmLY7do3MvGzuV7?=
 =?us-ascii?Q?wuRtE2WCc6Z8UiyAL62+C1ubLatFCuq2SkR9U/LP5tkOZzSKG2uT3LAsSv55?=
 =?us-ascii?Q?yoQLBCB7bk9Jfk+dkWUzHVSQaIzcQZFdFTDKSn47NpCX4IhDGk06CIvaSIbz?=
 =?us-ascii?Q?Tacs66QAk++fEXQI/G9f21GDQepXL2KNJCOiMsa0fn2FTh5ETrOvIP4TI0R2?=
 =?us-ascii?Q?UFm0wRi2HwLVie4taEXtt3QqyQ4W2voFjDCGSXPZM1Jmm+ZLyLfDbB2K2j68?=
 =?us-ascii?Q?FMtxk9ubKjFy28Ic1iQOJ/+cPqBlKsn0HPkCmnFW42P6Z9jrjAzsqMwIeH+Z?=
 =?us-ascii?Q?Cfj5cs1aV0khu+0KfttYg9MLuUmWMZsew8oDML34Pl57evwo0peHgFAmcKyD?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26599120-57f4-4386-cc1d-08da9a05c866
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 06:11:25.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukt487whUnEj4xXWOzvpqOcOBFibRFNeJYg8XifF9h1SKZ2F0iSj5cX+XRUnRGQjlrVPprWeamJtNS0uENMJpFYYEuXJ1Atr+8SFbwx1+zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_03,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=675
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190040
X-Proofpoint-ORIG-GUID: g7ngfzm5Wv7bQw8umMxtqY-agryaPJ2P
X-Proofpoint-GUID: g7ngfzm5Wv7bQw8umMxtqY-agryaPJ2P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 18, 2022 at 06:45:03PM +0100, Jonathan Cameron wrote:
> On Sun, 18 Sep 2022 20:05:48 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
> 
> > Hi Jonathan,
> > 
> > Thank you for sending this patch.
> > If you need a tag for this fix.
> > 
> > Fixes: 961db2da159d ("iio: accel: bma400: Add support for single and
> > double tap events")
> Good point. I'm careful about fixes tags to stuff still not upstream
> because they tend to be a little unstable. This should be fine.
> I'll see if it's valid when I rebase the tree (hopefully in a few days
> time).

If you forget to update the tags after a rebase then Stephen Rothwell
will let you know.  It's best to not make Stephen's job more difficult,
but it's some comfort to know that mistakes will get caught.

regards,
dan carpenter

