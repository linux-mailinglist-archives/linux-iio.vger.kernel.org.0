Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6FF3BC777
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 09:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhGFHwo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 03:52:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5306 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230223AbhGFHwo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 03:52:44 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1667g9Hd024193;
        Tue, 6 Jul 2021 07:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=yP17vUQylY4Jc2xw2JOOCUQVi03Fxona9JGDFVkdjLE=;
 b=b3MEQIoLl6pXi7Eqass1jpyj0HmFGOK+/PSCPuX5gXXpxh0q9oFtXD5GixpvkQicAxEj
 Guo2PnmhPsrdzCBU8QoKOGsZMsnM35GoDsHEirVuVaB3/OlWeEJeuxU1gGjijTaim7Gl
 MMtaZNhYzQoqCDufNH8ftsHhVHXv6HktK2YmrmT1aO27U+B1WiGXmYb4RG0UQrpqEHov
 HTyRt8nKgmxAzbf4tTSN/xgxJjPDt/yD/GsFYYkWMtabCvzkwpMXmcozohx267Ztew84
 ssH6zbQ8cOMUlMXvcUUhrk+eBzZxuuxs9QfEVleMSaZ0A344Y4KhmQ2+bEn5x8myvdoy ZA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m27h97m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jul 2021 07:48:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1667eGFF094159;
        Tue, 6 Jul 2021 07:48:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 39jfq84ke9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jul 2021 07:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVuK7CnuCUyVQjjeSj+oSFbO/RZeFR1TraPEu0ObFYhdys07sC2LlK1UKaEjl5WCJC2Jv7S293/pWjzK+z+zMF1uoHTRcI9RWVe1BGhtpanGByzgsUcjJWlATZ96zvEnQs4AzT275zGUnugMyrtheUtNDhlEyPk1CoL9PRH4EQ5Ioz6IsSsSY7c1EXPk5cASisy9oarSJGVEfdWtWGXLPuCFvKk3mShxwTqGCDg8ezFD4sh4II6Z07tio1aXf9S0GbT59PlfameejThrL0J6YSjdXcdy84dl5FJSAFUdHKKNTchQJJbkDOQnq13E824VKKO+kVD0X2qxs1899c8orA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP17vUQylY4Jc2xw2JOOCUQVi03Fxona9JGDFVkdjLE=;
 b=kOxxNdt2OfN1udL9nvR5KWVLcQDkyW7qUSeR1gWa32A79YGqoIpRCW34YEbjClKYeBKMf8zZAzrNXoMAKdoqdd7W3HpfeK+RCY5p/ZhoNgkaVVRe79ePqeos8tA8lVOU6wuLWaWfnf651UnkLkCO1kIr7r+kPbQ3gY+yoOcoXckBZiTHe2Gw/Nudt08Tcq+U0D1gUnSeU9Pl9pY/Tr5xi1xvcxmdejP9jzkOTPvwnXbVLkWSwcTwy60QYogA5ftpr+rvIhYAEwj4rjzlk44shiHUSR/WoDZ11HBqc0O8Umf+0eaRdOgSLbXXODX1HLADrRRH9Il8lZ4kCimJMu3/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP17vUQylY4Jc2xw2JOOCUQVi03Fxona9JGDFVkdjLE=;
 b=i1Jgp5i+LyDBrQvP1prMcTXvRnHwdzF8qGDOHJwmnXKNCS29FpZIqbw3D+hrLZzy6ncnp86W1lYLxykPa9e6Jj0cL5eg4lv5T091/zKNqNf7+D7xRJeFkYtFhIUTeaMEJr7tIwO7v0G/EmK/hhY9h/4sLUXoVwQFWIwW5QhCGFA=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4578.namprd10.prod.outlook.com
 (2603:10b6:303:9e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Tue, 6 Jul
 2021 07:48:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 07:48:55 +0000
Date:   Tue, 6 Jul 2021 10:48:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        jic23@kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 15/17] counter: Implement events_queue_size sysfs
 attribute
Message-ID: <202107060033.5eN2wc37-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e298043c880b350a42bdc40452376a3708bf533b.1625471640.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JN2P275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Tue, 6 Jul 2021 07:48:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4601b340-18b7-4163-d3a5-08d940528157
X-MS-TrafficTypeDiagnostic: CO1PR10MB4578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB45787DAC43C18311DB84BD508E1B9@CO1PR10MB4578.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tGkjMJbwHBrVnGLLkVuCKRQxoaARNIiwEGYNfy9td+ObQy8YkhwgQ/GOY/e4EwtiJMSfZc535Fi3GoovOS5MAZA2pPT0iJ/CalZFy+IJIrk25Ky7RPBMfKW2PmvQ/lYClFSek4ePSHjXeUh26Mx1Ms1q7WPnkaoJEU8SIC5lHEmjOHX1OSKkkuC/2S373rimNXOxaT/tkWC2xu1pWxuTDFVYj3a/UlfrlhJmlE9fBFcIuX1KN0CT9imQgfCHQ54jjtZ213zVYGX2cebcpUixNSHteCtQEIJTO+9hw9Kc+3A0lxBxM8DDqi7CE6Mvr3hAeu3mYDaoNRYNvqNnzMui0oGdUYiJp2jqrZzJPSR7IB9CVSUBgLR7oNscCIMif5JHVpx2Y9WhrUn2n0asm/Jpfw3qSy6ajjXyaGTD6TeLqtX0mELaO0gnKd6jdHjUdDUSCxTcR5I+EzdqCHwSQmzIqI3WIIUkW9DdvU2TSc1mukb6vr74hjHlArDOKMab8qBLPtbsNG1g1BT+cicJiQ5F7nc5EROTG6NFxonFNRu1yfH5RmQVPAirZAzOK+T0zSMrcLqQHyIyojhb754uUGkME9EglQUPVkr9v/thZ6jnmwtJDVqRjU40mABDl+xSJmvew6Orwl28oBil9f3J69wIaoMpLlYVIUz6NN6WLkz1cXVnCB92UNemPrWURY+cIlWx4PY8betrm8V4TKeQnK7A/1TxMPEZVAOQiNjabacKKnPlyeHJo2sP9esJuQO2MD5Vi4qvCAxpxwR52aQZQg71czM5jseOVkiuVR2J973JeRWGHF9ICMaiqBMOW/SSWCh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(376002)(136003)(39860400002)(5660300002)(186003)(6486002)(36756003)(16526019)(66476007)(478600001)(316002)(9686003)(66556008)(66946007)(4326008)(26005)(8676002)(44832011)(52116002)(6496006)(86362001)(6666004)(38350700002)(38100700002)(7416002)(956004)(966005)(2906002)(83380400001)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MfSrsqCaeC6glBVSfxanvekMW4l2qeUCZfK618Ng77X+184VTloKJ3O3NbhJ?=
 =?us-ascii?Q?JUidgRqofV9pE+Juk38JdWHw/fB7nXBBAN21722v9si/06e2PJae280QO/V/?=
 =?us-ascii?Q?X/Pjez2MqsH3PysE5IJozbMAKLCHuXg1IghB1so5emDU9Trqqe4uPCgxYSdS?=
 =?us-ascii?Q?BtEZ5r8J9U/tSTe5SSUrMfWWkVhF3o004AjoA/Duf7ft68dT2Qp5GTiytDFs?=
 =?us-ascii?Q?aLh5eGblCStFWMWm9GvB25tW/p9eXzXLpd3vqaBfSZ213Bd+2nTiKgso8Osf?=
 =?us-ascii?Q?Rw7S/2fJbGAIPsgj+DNl9Il992b3Dbkf+TAS3gjF+Kch+6eyHrOxFNZyhf7x?=
 =?us-ascii?Q?UHXLqbhd2Z+sS3g9sSUbZ06f+R5DPfzpI6Dq4s3EGtruQQJi7AEOSpUpgBuo?=
 =?us-ascii?Q?AeOnfaZ2FUR0+/5zVolH95Oc9H/ejokk+AFwBdvUel1o0NGtAKRnGTH1/Yuy?=
 =?us-ascii?Q?UxVE9BRPscVD/nCGSCp1yM7S1l+knBQCM7Sjfl6Tdq5qHq1G1/pkV0+cABq+?=
 =?us-ascii?Q?Q6/4HILccwmoFsJoDyKbVheZ0hWkFOpMaxsh0lfdjaBk7+md074ICnWqsx9h?=
 =?us-ascii?Q?67ePODIKQmLKJvWgd23RI1RSlz073g0UFs5AtNaM7qZ5qyTLBtVSjIaqRenk?=
 =?us-ascii?Q?oiyz/F38d2QsY0cJSgtq+zpcL0HFuvQNsjuXELAj/ImtN/RDu7Vj270sBDJj?=
 =?us-ascii?Q?LS/ECyVszGwdlt1RmdtxfZYjsmXA74IXK9CDD17xg9RkLd2Z16jZKr2cs65e?=
 =?us-ascii?Q?Mzx9j5VqOo+s4m5W5lcGAGceLJ4qUQpmM2G7GKiG0QcPG76GAWFOkVpne+3L?=
 =?us-ascii?Q?OU7ioyPG2mUjlkFrxCBeT5TNKvRAQvn8lwzPplHR3/QzSK+6D7/8r6S1Ga9n?=
 =?us-ascii?Q?rH7S3vGTnKelSWG216CXF6gE45w4c8QS90u8VELzPlnJmtlz2Vv5/P2mZvll?=
 =?us-ascii?Q?xEtCEuT5aHvZfR7amWZyrArOv0CuUmD4OY4UUVANNWmxPouSA8/6jsf+0boQ?=
 =?us-ascii?Q?3RIBodHPrTwAczfBf1kNOOmvK1ruQvCylMuh/SjM3pfUGygGfBzDVQZpIb7d?=
 =?us-ascii?Q?gzzL6kT5TbPJi+6YzQFWA0pO25GirnYLJrI8VxOc/3Npt+oHsWLlJQx2zqkC?=
 =?us-ascii?Q?uzYiLc+N4vTFMjthW77+Gg5k6UNHZa/iqtmoxbhcnRU8qYYaZrla6iTRf7tg?=
 =?us-ascii?Q?uaFP8oSi84E0Es/Coj0yw7D1ResAoYyWgk1bUhvYZDuYPhezY447H94m4YSF?=
 =?us-ascii?Q?CwId7LfIlG6Dumrq8z6KlaGsNZrRAGRCmYPos4/asNRa6A0xUtaDhLaq6L5n?=
 =?us-ascii?Q?3TB1l+O/pNJNrDUnUAtQTxgw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4601b340-18b7-4163-d3a5-08d940528157
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 07:48:55.7564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gr7tnaKPFmv1XL8stlowOIops/XxC3jflP92zn+bH7bEyquCsW07uN+p7yv2/zR404i2RcVNos2156vGyDi6CKokR/2OAqcoKkySY2JOyaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4578
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10036 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107060038
X-Proofpoint-ORIG-GUID: mdB0GZWlh2c6_hG7JUIPUTyZt-AOrPAs
X-Proofpoint-GUID: mdB0GZWlh2c6_hG7JUIPUTyZt-AOrPAs
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi William,

url:    https://github.com/0day-ci/linux/commits/William-Breathitt-Gray/Introduce-the-Counter-character-device-interface/20210705-162324
base:   6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
config: parisc-randconfig-m031-20210705 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/counter/counter-sysfs.c:815 counter_events_queue_size_write() warn: inconsistent returns '&counter->chrdev_lock'.

vim +815 drivers/counter/counter-sysfs.c

d95f8a2e83a813 William Breathitt Gray 2021-07-05  794  static int counter_events_queue_size_write(struct counter_device *counter,
d95f8a2e83a813 William Breathitt Gray 2021-07-05  795  					   u64 val)
d95f8a2e83a813 William Breathitt Gray 2021-07-05  796  {
d95f8a2e83a813 William Breathitt Gray 2021-07-05  797  	int err;
d95f8a2e83a813 William Breathitt Gray 2021-07-05  798  	DECLARE_KFIFO_PTR(events, struct counter_event);
d95f8a2e83a813 William Breathitt Gray 2021-07-05  799  
d95f8a2e83a813 William Breathitt Gray 2021-07-05  800  	/* Verify chrdev is not currently being used */
d95f8a2e83a813 William Breathitt Gray 2021-07-05  801  	if (!mutex_trylock(&counter->chrdev_lock))
d95f8a2e83a813 William Breathitt Gray 2021-07-05  802  		return -EBUSY;
d95f8a2e83a813 William Breathitt Gray 2021-07-05  803  
d95f8a2e83a813 William Breathitt Gray 2021-07-05  804  	/* Allocate new events queue */
d95f8a2e83a813 William Breathitt Gray 2021-07-05  805  	err = kfifo_alloc(&events, val, GFP_ATOMIC);
d95f8a2e83a813 William Breathitt Gray 2021-07-05  806  	if (err)
d95f8a2e83a813 William Breathitt Gray 2021-07-05  807  		return err;

Drop the lock.  With a mutex the alloc() doesn't necessarily have to
ATOMIC by the way.

d95f8a2e83a813 William Breathitt Gray 2021-07-05  808  
d95f8a2e83a813 William Breathitt Gray 2021-07-05  809  	/* Swap in new events queue */
d95f8a2e83a813 William Breathitt Gray 2021-07-05  810  	kfifo_free(&counter->events);
d95f8a2e83a813 William Breathitt Gray 2021-07-05  811  	counter->events.kfifo = events.kfifo;
d95f8a2e83a813 William Breathitt Gray 2021-07-05  812  
d95f8a2e83a813 William Breathitt Gray 2021-07-05  813  	mutex_unlock(&counter->chrdev_lock);
d95f8a2e83a813 William Breathitt Gray 2021-07-05  814  
d95f8a2e83a813 William Breathitt Gray 2021-07-05 @815  	return 0;
d95f8a2e83a813 William Breathitt Gray 2021-07-05  816  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

