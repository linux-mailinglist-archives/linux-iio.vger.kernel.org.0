Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5705E9D03
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 11:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbiIZJLV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 05:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiIZJLU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 05:11:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06304399C4;
        Mon, 26 Sep 2022 02:11:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q8n3tS013339;
        Mon, 26 Sep 2022 09:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=jaxVGyTeIo/ESPLqdCrGlhQkFz9wQRSCvVLV4ofTu4M=;
 b=ddTK8xgAD6yCbdB0p0e5vbnESDxp6hlec2pHbQubAp1NuIj6nbAqMT8qFLLkJkNZNoAq
 M6vy5FsWFsdKy+Rvn/G0tSe614WJiP3fMdVGZpis/SYK8/njDfUnQekHdoqyv29OE5eP
 mkLw5V8anI1rEuEQHRl09m/c5Cljngq+Gx0ANGZERG81oKqt0Necd5VeaNkgFcWOGDF9
 0tZCZJxqjCacLv+ijTaCjgbwD5Vbk0EhkVL752g7u5mLLAc7NpLXDDKYxVqM5499qO5g
 zkyP7mJgBsypqtihsCLS62vIjYsuzK2yNDmK/+DrdCOMhTxmWfrLE+SUci4TpUJq6El6 7g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jst0kjydn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 09:10:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28Q90C3s027932;
        Mon, 26 Sep 2022 09:10:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtps41ex6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 09:10:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifWftDrArxrEAMIcXop1SCJAmnzxHSa4DJJwfFqJmAHrPMjTnRBPNUXS9MDykK10xxuldEpcqaWxXzyOqAgsOGaVx2wxmZNWwQsabCsWQI2ACRUAD2hUzCLWF1nWeCz1q/ts0IRuOVIgQl3HLIRhLxRj8KHcwLtfpsIVVj6Abu83U95v+UJF0JGgVbc56gE6xxRL+caRkW8Zac5CJizO9uTUrrP+fGmNoLgUWv5xYdw0Pd0OD5yb9szQf0NikZ/q0BsJ1PebGeJct0Hvqj2hnz6AsFda8/gCFFk2Uj9n3AptiAcBUNOX45iPiq+ck7fRPUgQycKKD/W46FUF+HWOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaxVGyTeIo/ESPLqdCrGlhQkFz9wQRSCvVLV4ofTu4M=;
 b=Dk5et4VzjbKMbpOORoxZw513HEsF7NigKe8XPmcvNY/A8NIn6VypJoFsLZkNj+4mnUEhdnMkrVYH5MldT1kQv7QpnFUOYGOq21KXRLXW7ii29xYRNlgmkUljX1AVIdejTXbLa0SGUYXtD3r9TpDsM+orU5vwm/pQs1haUh+m4cYHnPJWtAVMIPWW5y3J5SEKPMiOKpxa061hR2eYK+p1Q2HG6SmSGH+SeeX5GE8td160NupiYalhEHjB6Pi0j0T6uR6ll2jIDJZgGkSwCGDfkGw/d/tuZtsf7L4ZO9PKTA/JqS0Hs6uZf6L9mQwFHu0gjeg7bu2gkXy825vJaOwYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaxVGyTeIo/ESPLqdCrGlhQkFz9wQRSCvVLV4ofTu4M=;
 b=tdK1oxXXmYtrkGQwuRMok0092RGToAGNwBJft1GagYlLI0OXocPr5RklN0bXNA3bCMndxWUjCfI7V7+paANsPfM63XELmuHsyYZUOtQ/uqWZKY7iCTpg3mj8JJRG/VoFYQDJzOMYQiYQZzu97RyCg9pFJWzOwIlpLEN5CKfoCZk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4928.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 09:10:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 09:10:48 +0000
Date:   Mon, 26 Sep 2022 12:10:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: mcp3911: fix sizeof() vs ARRAY_SIZE() bug
Message-ID: <YzFsjY3xLHUQMjVr@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR2P278CA0035.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DS7PR10MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acbf055-6d8b-41c3-551d-08da9f9f002f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnz2TGbpiafpaSkvjhEf4ZiEvD1cgdUqU/60sdAppFrXytq7/IbpOyPW7zWToh9arrL/V6YyTj0G+0xPywlC+vQ8PYjE1UJ6dqh4iUBFxjqKF8ElqVxezUsZNoJ5DJaEsXnExA+iOfobp9AoVa/wYexX+hx5D4xp8wssB+1CyFGorjqvxI6Jm74rHhpjV1Ntn1DfSfuq8cc5mBJIHC+JPY6NYN+S/yTQOHRLiF27taCbO8j7LlBrUbPJyqRx3sZuT+QOWc+x3/9Mb8zMd7gN/E6v9pFdt2CTKFmn6+GgSsOzJMZ64DXyEcCXzOcSmOH+XFKJsv3UoMIwFJ5lrTlGBYLYUS2n1p3tJVPUWFsEgmExdSldPF1BQr4+lgMJHP545PMwp3hVgUtB2fvZYulwKGnxp4x/pfBvsFSgYcjfCBxAdCGr5kI22xtlL4riPTUgGQ/EXoL4ZwzQPKkf2LLnIPWnUgVgithPp/YIb7DZJynCYifew085rOTYHqCicCW1iAq17RzoOvdoEfhCBQphKjU0Eq983B64K5GhTrhjigl9AY9m23KIV1iTzbo3Wdm7vQFlIMWULAu5kojUPySmLpm7QCSh4/eJmTNCD2QrOR82FYM154PdKlGetk1SxHztKB0wnR1UGetm6PINrSTpYbqN9wwARs8CN+TLc6GJFFeGsczC9sL3iLKJyokGOq1dTGGgBpjjZiAbH0/n058sDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(41300700001)(33716001)(66556008)(66476007)(6512007)(8676002)(4326008)(66946007)(26005)(9686003)(2906002)(44832011)(86362001)(186003)(4744005)(8936002)(5660300002)(478600001)(6666004)(6486002)(38100700002)(83380400001)(316002)(6506007)(6916009)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZjRtTXWMb4chR09qkV+yBPwG1rzLWm26KwSjveYtCmvcT5XWlV5/oeCzdZdz?=
 =?us-ascii?Q?6aMc4TnaZ71HfHUnGgfu4ECmdKY1vc3HpgMAKApkDD+ITihqU+doFvFTGidf?=
 =?us-ascii?Q?F8LlUBXqW0L/mwXW6pEUZls7ZoYSmpbsuDJEXDWBbiwTcGfkHEUyEhdgkVBx?=
 =?us-ascii?Q?U5ct5ORTrYqNUPIjUai7DVk+D4yGYRYD5KpXzdmSYwow3IGn4UG2ZDDZR835?=
 =?us-ascii?Q?fPXzWXLLlDD9OFGEzKDgEFHxYJioqcYEiWnAbD+snb5wrsvvQ2A7mBMoxo35?=
 =?us-ascii?Q?GyWJGwa7x8jVUbtczF/66LClDFMXkSePiR3uhlcqyZJTO1zhqP6SNhbIHptk?=
 =?us-ascii?Q?1LlrnhHKmcMiYJHjS2jvG0WRxR+KbSycyiseCEnZnucU+zXqLfPuqBNMnFg0?=
 =?us-ascii?Q?L1q17xkX80DOIpqYOVjfgmyeXzmohWIJkUdG1UJ2egboTe3HFKTul4hnw0mt?=
 =?us-ascii?Q?+s7ZUMthK+uBSSpKWXuGkXP3bqIveBlCTeZUzOUE5QBfUvC1BPFIjWAqjtFP?=
 =?us-ascii?Q?yRqy0iOXg1pbrrIl9RI85w+Db7mBcrVAgvKgsS5rn1Sf85R2CBec5K+WGR12?=
 =?us-ascii?Q?V0hfvgZrXq9BW2SaltcNg35NcLP2eGiNc+IMe1qmylHjDy0AS9vcQxavWTZZ?=
 =?us-ascii?Q?x2qTcZ7pvzLoZOYF5XyqH4qptEM3xhplR/aNCSQsEw3D1ENWbFaJebzHvtGm?=
 =?us-ascii?Q?eREpIkJXTHllwUysfF+t8u+raqb23txiKyLHEzJK8uhp9YdWjz34CHxgpQIN?=
 =?us-ascii?Q?gnqnSGSPLd44UDeSFDpl81AUkwQhaFemO5Klk3h5hhHDkPlKFUVBJ8BjauE6?=
 =?us-ascii?Q?A1U8VD8U0l52tD79CYh/RpmHOwT3E+PgUXzWsXEiNDXt3QhaBsNTXKJ/umPb?=
 =?us-ascii?Q?3flXZBkN8roENSweSE+NDYSxoly372B0VHhDJSSQTKl7itqI1Dwn6y/zwGiW?=
 =?us-ascii?Q?0h9Clnq+uNz3llvu4ZUFmiXgJLshrG9tU/yXDztTyazn/LVPtXh08lpxVXpg?=
 =?us-ascii?Q?x36SZUzLW4968RaomwovZSeemMpelWdk2R22zZDrKGfy7eFb/nJrqW9frIMj?=
 =?us-ascii?Q?O4+nH9Qhrt+ACZrd5vSlto7p5YwtZ3W0iyI0LPTRr2TJ7yioHLRIIF23/RvZ?=
 =?us-ascii?Q?TsPBB4+GB60ODo6bDVbLRQNLBQnXBFfl7IbQv9tU1pFVR9/5quFeZpIzFyqK?=
 =?us-ascii?Q?N0cKaPF/jdwW5hwlzj+NMOj8LDgNDqB7IDSyMs+HSdeavOtsgMoCbCoOJxCs?=
 =?us-ascii?Q?pVIaJN0wJAVANqUH3IGGMP0Eu3OpVb9eHNJhZ3+++ygtj3zxYlHAbQl0uLkc?=
 =?us-ascii?Q?jbzhXwDNw0jEn9v/PNKU5bdNCWNkMiKslrGrzExf5fPP8aolszqNYdOR7wdF?=
 =?us-ascii?Q?21Ss72sBVLs28pzWWYC2syXnJkIWLFDAGJczDR9FObSUNyefIGng4lWWBSz2?=
 =?us-ascii?Q?THMCwGfb/Y8KvmbmG4y9MYqSpFuSBpHYWL4Hdzsd9GRV53eXzC1jAxY2XW6w?=
 =?us-ascii?Q?ZX8FmH+cS5f0jwsKhVf8v5A2Q1qOXTWuLV0MlpXFz1rJiNBvLaCMLsKdgvJe?=
 =?us-ascii?Q?BezOnkJiDL7xCuq9zsmgTg0jxhwgTMgKgQ0QCBzC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acbf055-6d8b-41c3-551d-08da9f9f002f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:10:47.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNBjFSsq6oAvmw3hUsUaW8LPCtgvBfh7zZFUsmrzaTkmqYyZ15R9FSXl4RF0d2xcHHDGjooGzF5WbPZUpTUpCSdK2LNQhHRUXRTF47zPnOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_06,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209260058
X-Proofpoint-GUID: 96bqwmjXSobpUllJEX4HL6ZrjmfG9B3O
X-Proofpoint-ORIG-GUID: 96bqwmjXSobpUllJEX4HL6ZrjmfG9B3O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This code uses sizeof() instead of ARRAY_SIZE() so it reads beyond the
end of the mcp3911_osr_table[] array.

Fixes: 6d965885f4ea ("iio: adc: mcp3911: add support for oversampling ratio")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/adc/mcp3911.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index b35fd2c9c3c0..015a9ffdb26a 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -248,7 +248,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		for (int i = 0; i < sizeof(mcp3911_osr_table); i++) {
+		for (int i = 0; i < ARRAY_SIZE(mcp3911_osr_table); i++) {
 			if (val == mcp3911_osr_table[i]) {
 				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
 				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
-- 
2.35.1

