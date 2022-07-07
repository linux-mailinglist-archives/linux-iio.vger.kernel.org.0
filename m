Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A85756A654
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jul 2022 16:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbiGGO46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Jul 2022 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbiGGO4h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jul 2022 10:56:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA275C966;
        Thu,  7 Jul 2022 07:55:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267C9Puq003276;
        Thu, 7 Jul 2022 14:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=pCGKSdp8Ww0GdvzCVCUyNzqHqDZpoIFpdBkx8IxHqpE=;
 b=KQh9c07nUSNEosfn+n8+Nfo92aq2pCvG4AA1BpOGw1N6y9KKbwYLWE4ONopJ02sZi/Pd
 MySTVuZLeQAVjZLWPcfwNK0shCt7sv3NXlR8QTqBe+5WAMBeuFI9+2XLNVj1okimDrz5
 EaDPFnWUHbUxqJGfkFyxjvsWiDorHwU5mCYJQTX1FdeReVAS/cbEV2xwKIbzU5B2VaSx
 oVV8JXTM7Z69oqrnHgZEgZT84iJSi72V6AuQObEUUViJaIcjErDzwLdQ1TSYCpLkihSr
 PpIjy3SrsgdYor3L0HJRVOET5go9Io5aLiPKcJxRVdpCn0dtzwdRdzw9gwVMDJWhQdAb 8A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyd6e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 14:55:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 267EjuNN000981;
        Thu, 7 Jul 2022 14:54:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4udfh5e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jul 2022 14:54:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8dTZ7Q2Lw0McFVwxbla3cjTn2vBSc69sectvEuWRZrhpHx28f/F51a00CJlNcP+u5/fHhk7oEb5CCq2yNpSXIvvGYhHNhWRxbS2jQOcW3qcuj+Uc/QLNt+WB/BtvIX9B3eO0udPqYxkVpNvWBpZCx2J1BgHMfPfhsmpvmMQEUEDgaMpjiNIcpsliwAPIv5TJwoZQFvatX1ok9B4o3D2Ri4QfXRfHuvbQX6yROPM4q50miAqd5IZIxoHcL3Iuh7vV4Z5o3kJlyvXP8Q6EJNBMea8VnupcTuCC3C905YhZfrENlwng3u+4fTirdPa/3Vl69YomgCGSoZTekI40v/5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCGKSdp8Ww0GdvzCVCUyNzqHqDZpoIFpdBkx8IxHqpE=;
 b=Nif7R4gYtI9/q+Fd1VTKFgA9tzUG+mKL/yX1FBSDS7I7aXTyCbvy0pcrIkGJMeFxkUpyM9KXHvvf+CXjtcBWMvFPLnIql7n5pkgpTnK9gw3LGGKAxQaczAlSOeXkyuLzneKBWjAtVzSbm8aO0kPNIfNh7ApWXz/g5O10box38zuYrIUkr3UIeOX9290HIiCsAzsrG6U4dWZQhruqv1RoSSc9IFAUWy8SuQiibj54vB0ALyGNrVea9gE4XV5blkFq8u6Q6M67mBqAxlEYnnK2rXxjxDNfTKaSmJBL51evW4bvTUYmAEN9DIEkTDWmlHKY4lLYJyESJV4WLCjk+H68Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCGKSdp8Ww0GdvzCVCUyNzqHqDZpoIFpdBkx8IxHqpE=;
 b=D2Z88WmMGonCblCWLUAPsHxpFXLGvXPIW93yIlynKhXDDcwsBEQDchwe1fOt+EstsuNYz2cS4xQa5+OxP+H61xAKslXPLYwos90NPtGl1+I29UkKH6QStk5g4XpfCBmNh6G3InMfMN0NJaUbPkAMYXvHtjhCrf2R/xmyuuDOkec=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB6100.namprd10.prod.outlook.com
 (2603:10b6:208:3ab::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 14:54:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 14:54:57 +0000
Date:   Thu, 7 Jul 2022 17:54:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: adc: max1027: unlock on error path in
 max1027_read_single_value()
Message-ID: <YsbztVuAXnau2cIZ@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6456ff9b-21b1-41ef-b9c9-08da6028a893
X-MS-TrafficTypeDiagnostic: IA1PR10MB6100:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iVgnIhojM0/21LmRbYO6tGk9o471xfYnvncHWywGqGwYsxA69DIL/ZDXtQpQVgnNCiQLjeNla9TCZGHg5PG+WZ/vFPTmRAj8iyT7gf2R0p0fCvyFvaPvO6Ld66l/0TZLgm/3Pnqaoy/D6zQLaFia378cPiAA2WaR7BToFGO1gb3WMNZ//1ArCUPYOi0CUV/xhxpuQos8hJoIS/lXB95tSOSBI1N3eJGCjYRtUlOh7QCOnupMop7soQihbUQU7My7lSMGQzeaLbBiRistXeb8dm1QJrn8Maw8w5mUIENt91QTppr67sFi3XnmN0IH4/E3u+fz007c8eeX/Mr/KURyMFjbxDcr5+l+e47lpQja6ok0ZV1BQKXrNFpJtV/FeqmV0xb0eSnw04TYldmanDF5/0OiuHlzxeNyKW43snjAIrpTjsZygR4ZrnGzTGdjy+C1RKOFKBnQ8OVJ77sg308ilShPLvtW7VsHJ8Ywu97RQw6lRg24kId4okVVpZenCyKdML8D735YmWEYYcfaJqSfgZyXAkWqsPM9qbpDJlliXDFxSzrIDxTmFFfMpXAP/wsXnRdhcZKA1tTZAd82DHmcNfcja07XwqdGgTuwAXEOn3NBOQU8HoHK91zDKkmJQJkG8WTofcOXTGQH94prkKePkcJWJnW6nKY4aPT4HLw3Ka4rL8Bi0QyBvcsil6sUbRlDnThJS/I41XTgrqF3b3P8ANMqa6mTf6oW3/npxtmfSpX+zcluq6BClihyCoSnC9P3iuvbTkbbOWUt00r+cPRb4mV9ugcRIDt7NaHwQRkka3sbx3RF02iJLu+R0zS+Ucu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(4326008)(66946007)(66476007)(8936002)(83380400001)(66556008)(8676002)(6486002)(9686003)(478600001)(44832011)(33716001)(26005)(54906003)(316002)(5660300002)(6512007)(38350700002)(6506007)(2906002)(110136005)(38100700002)(41300700001)(186003)(86362001)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1oVyG4p74hCYTDYSvX2ARlAj8tsZHoXyXqGttdswFqf/3gHZMAPmNEK86bue?=
 =?us-ascii?Q?LarEKZ0k86j1UAEpH+NbAk1q7Z5KrEkXKFfjDpow5wbSBFi9H0OeN5GajvgT?=
 =?us-ascii?Q?sOK4IpvF08unE4j9PM5mob8J0UgKp+ab8X+H7OHqNlwFC4pLGQ2jfyxJlIjL?=
 =?us-ascii?Q?QMFZ1rapqIhfvxm8zdZk2MEgg4nHZrJwWWVaqZzggxoz+TTtJd02OSLRs6wQ?=
 =?us-ascii?Q?pytOJ/lzM8/u5gGC7JJrmYApdYZEw/W8a7PxnVhg+17gzZL/rFdYukqMs3X2?=
 =?us-ascii?Q?W71kLnud0ouAqVW1eYSHxn6V2cpJOZZ0UZkL7+OV1I5sI/ALpJ4JABXwbNmr?=
 =?us-ascii?Q?uHsqSrc+xTbyKKulJnpPU3bbT/6otQREj2nQWEj4ppc7GaALB5LVswDAye0z?=
 =?us-ascii?Q?UTdA4MvPWC/5VOs1BtefQWv0Edifa4dy1ugal5JITY606QyxtSpB6tRiTRQ/?=
 =?us-ascii?Q?zPWSSKQw+kT/4VJqgeb8BQXldcnAuESHGdgG7IcSqiekOS2MFM9wFZyP213w?=
 =?us-ascii?Q?g6qDUVNj25QqRKGFqabvQ+ZOwqI/90hrXW2u8YHjRqKIQoIGgObm5xwEB7Na?=
 =?us-ascii?Q?lee4qlJftq8Z1ZYVESlpxedk4FX0EkXywdAGg4HHHC1M5Wvfmfqzk/rX2iz6?=
 =?us-ascii?Q?/BfYfiJb1yLF/H/K6tY25/jwjeHgh8Qb3N2ggaMdqqurSzgx9j5HGH7lYHQh?=
 =?us-ascii?Q?lFr9OxufSSfim8QiMVmkVpdbhNAeIzZe1qPQtzAUU/8lSpcIIDltEmkPlSU1?=
 =?us-ascii?Q?V4n9uT+q60fM8NXB76/0LaMKL65BSQQq2POpvZYXL4foiyasdffsY+deCzqA?=
 =?us-ascii?Q?NB8I+MZprzw5rQmb26MHbZzpLvR/5SqXX/GUXoVd/1F1CaKAnIUDrgRij+O2?=
 =?us-ascii?Q?auxqflmK6ZhSazMBLVVAhaICH1L4PMiX7tNypD/Q7voNM0jNyt4n2Jd8ItPk?=
 =?us-ascii?Q?8MJaff4uX1z5Xt5rVfc0jky+Gkr4ojEfMc4yWCHebH+bgAFRuPEPRWD1b6+4?=
 =?us-ascii?Q?ISeFYJFmGo8UGxnD6s3ac6ixNXz1kM2NkfblShXKolouPy3HdDnPrJ5XBr9z?=
 =?us-ascii?Q?UdHjUEzyHnHvjaPEl8aIJtCArA92vNm0epQATx8lsUslrYgIgRaVNk8V6Ao+?=
 =?us-ascii?Q?QDxSCcVdcsflefOpeKgpH2HxyoPaCQDY1tCIaveAlqacTAULQ4RUBwYvPnVm?=
 =?us-ascii?Q?gi4bpA2/73thn5PMMD+Gqe7f8KIcamF2lEm9+dTuEtVk3szP38GBmOxECkpD?=
 =?us-ascii?Q?LHIgs+/VWyzzcJ0fp30zMypQIpA04nJ6ZOwqd92tcsGY0h4RIDI7nXJbOh3Q?=
 =?us-ascii?Q?7CSqIcSJHibQub38VO5r4PIg/87KSYltdvaLORC8OBcCHi65tzkWRBqkuHOe?=
 =?us-ascii?Q?Hhtzt0YlQiu3fk+mWgcdFWpBJrOEvgijskomPe8Tu4uwF2bZSz6eSgJytBUl?=
 =?us-ascii?Q?x+WmkL2JVdR81AlA2hg9XsrZEA1CZlr5N78PqQeMU8xcTaSKt2s9y6Z9xpTp?=
 =?us-ascii?Q?hsjdGbXExOVCFWGN6//K7B/hCsM0J4vUsBRZ4+/192C3RBbn7HdSsENf1MW/?=
 =?us-ascii?Q?U4kXYEFIW/HklVr+OmI3bCPaVx4s0ShRe0DP45cxKRFsxciQyD8e4CaqfUpc?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6456ff9b-21b1-41ef-b9c9-08da6028a893
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 14:54:57.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFZfNMTt/ffWcL43tw9tewOqn9M1PNaCjJ611S+cdaengblAdB3waIMGZCzHEqDsnWIKf7WFJom6xU4XGroexv9LYtK7JwUEb73vUqNS9yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6100
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-07_12:2022-06-28,2022-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207070058
X-Proofpoint-GUID: lR7hnKX9VHgULIAdYfAbJLOLnf60i0SL
X-Proofpoint-ORIG-GUID: lR7hnKX9VHgULIAdYfAbJLOLnf60i0SL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If max1027_wait_eoc() fails then call iio_device_release_direct_mode()
before returning.

Fixes: a0e831653ef9 ("iio: adc: max1027: Introduce an end of conversion helper")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/adc/max1027.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index b725d012625c..136fcf753837 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -349,8 +349,7 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 	if (ret < 0) {
 		dev_err(&indio_dev->dev,
 			"Failed to configure conversion register\n");
-		iio_device_release_direct_mode(indio_dev);
-		return ret;
+		goto release;
 	}
 
 	/*
@@ -360,11 +359,12 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 	 */
 	ret = max1027_wait_eoc(indio_dev);
 	if (ret)
-		return ret;
+		goto release;
 
 	/* Read result */
 	ret = spi_read(st->spi, st->buffer, (chan->type == IIO_TEMP) ? 4 : 2);
 
+release:
 	iio_device_release_direct_mode(indio_dev);
 
 	if (ret < 0)
-- 
2.35.1

