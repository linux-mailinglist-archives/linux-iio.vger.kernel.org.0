Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBE742093B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Oct 2021 12:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhJDKTF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Oct 2021 06:19:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10398 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229760AbhJDKTE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2021 06:19:04 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1948uFES018669;
        Mon, 4 Oct 2021 10:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=8RtK4kXjiZN25IvsGnfKRiq0NhC+EijEZB23XmV7Ta0=;
 b=ZoY4ji1xBfBHe8wQQIORIaidP4kSQM1ec84tIL+C9FS6G610D5p4fdmHoQomsHBBdS12
 YzKMotJ8SHpwWdFmMFM+77IJanjD0aZ9QuYcSgRwBh6oZWP8oZ10bcmbWtCLc/ZRRcmH
 VzipDyTuYsUb06tVEw8SKpyz22iK2WuEWZy1x7nsy/1GMJpZKt23uuN/FzQyxVfZyP8f
 5Uqp5g1giqE4LnD0h8u3uCm4clMAS4sDrpcXB2Ipj/nL1bUZfNDPOs06tsAD1Cnvtok9
 eARLQ+cVTPEMtrvJ9bKb58ynB3ml4FnG4peJNubGJRzDLQJz+2B3GfU1URViqL1KCMKL 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bf9m03adv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 10:17:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194AFsfa135654;
        Mon, 4 Oct 2021 10:17:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3030.oracle.com with ESMTP id 3bev7rfbe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 10:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUm0UTJTybi4hCsDAbybvRe0YOMEFz2nHFteAG38KcyX+y3IiUdezbkEkaQT/7tWzPOsBRE/LIRcTG9uUj2t+thq5sZdOaRYzlaTkoMCqgR/Cs8Edg2yaffeLY6QvQYZeJ7SsOSo3w891QdLBE8m27QL5gA9dM/sV1YDI9fTTnfe4kbVtllcP5tKvHoubb8e9W5ckpn0OSY6VaM27guZdGgISaIVD3jrjuH/7CHHxmgVay4H0BWFOM6igOfTPF37rW3YsFFAB6PeiQB9ounRTzSm46ATvC7OTeKWo1v7Ff/QepW+1fybBIMia54PNtczmPU4FoSGYhRNye7ARjJZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RtK4kXjiZN25IvsGnfKRiq0NhC+EijEZB23XmV7Ta0=;
 b=fjRbazeXjneMzG7Cp19bFot53Kg1fokyhxGHSCoggdUz13GCjRWOg2fgWItu8pfjaTz8/9wSdvNOGzRQ0o5e6h6UtkOkvA9Jn9yHyI6hcCQXrvNN47BBNxmll4lQ4FfYsuaQJ3WuXaBCvMkeANXN6Db4h658MH1XLV/6BMEzksnIHjAiohnJXyqEM4rhl9cnUWTNQnBLUnSZ/TAXW+8uat/cRaC3LADRG4Zwg4QF8C3rdV+Yri6waR/knj7AfT3c4flg8e8yxR50Tllr5dOKQ9hGoTI1Egy9iTimxA+a/laFtTbzItzC3xSuO9ZDrPPrfWaIJj4Nz7489QsK5fR7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RtK4kXjiZN25IvsGnfKRiq0NhC+EijEZB23XmV7Ta0=;
 b=L708fxkBDaU7jRfbZHDGHQsJeeAklNy1fhVrSBdYj9xTUt199+bcqeAMMXuLXQNZg/kK8PssaNUDgbp8qDkiRl7K7O/k1WBlkbTNgOECKM0Sl1JAH93qRWLAaQb3iGL26ouDHrHuo6idEDUf8bKkuvLU6/M9qKrntxjCPz/GTZk=
Authentication-Results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4642.namprd10.prod.outlook.com
 (2603:10b6:303:6f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Mon, 4 Oct
 2021 10:17:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 10:17:11 +0000
Date:   Mon, 4 Oct 2021 13:17:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     miquel.raynal@bootlin.com
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] iio: adc: max1027: Use the EOC IRQ when populated for
 single reads
Message-ID: <20211004101701.GA22161@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AS9PR06CA0404.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::24) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by AS9PR06CA0404.eurprd06.prod.outlook.com (2603:10a6:20b:461::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend Transport; Mon, 4 Oct 2021 10:17:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 357e4ac2-a258-46cd-2b13-08d9872020c5
X-MS-TrafficTypeDiagnostic: CO1PR10MB4642:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46429FFF3BE78BB2ACE0E9B68EAE9@CO1PR10MB4642.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3lW+BN09Li9SnRknHmHXqItOa/Jisaq642EfnuEqgrTRWKOVB9JsK/156t9tMzde8cKlsV9zSUbA5InJpzAv2zzefkSLlWmwxuivewKSLc1XmvoLTNGZisUHIiWkHZptxCYNwpLUjR367vIDCgI91l5sffD4L8ve0S/3k3og+v8vag7G2gr4aYCVI+j7tZ/QR1omzrEG4pqoeaUnpOe9ExXS8j5WJBWZIKgJm+5FtqFVvCWV6/Bi5s+xvvy+8zJmEWY8HG2fKOy0A7/T+BdPL19a9vVtpRNAdP+UCH/dWVAyNvRPBuoZw2bPJ79Mofjj5ZGOu0c5RZqx8LPFI4kK06KllGF7vHCaDR7aNJvIxQv3gIcBOB3ke5dJF/7mRg+rcMquwfJzIpkxw1y6zq3DZNk8dyHs+yL9hahPuHy96jpkS4Dz0YX6G/OCGsLOJ1/yDK+74cdzgW56l4O8AgseGKpRnrUZc4yLq8V5eQkLShUCJi1r+YKLrO9LgqHAPVMfILquEVRJVZO1jZGCr+zZ8RhNGZ556o96He4hlxmwWEKG0F+eZWls6XTdvyfoo9oNCTlUuBrhJV0JoyfTJRcOjSmZ2mioY0psn8yxuSrdv+NQLXr30JCFL72fMBRxvPZbFQ7HudHhGlzBwL7nNewvUsDPeYae+p5kAaTeNXH+LehB9nZXvHLV65+UMMnHyagfRXSrxhVqfOMKQn2xkAqJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9576002)(6916009)(8936002)(186003)(508600001)(66946007)(66476007)(66556008)(83380400001)(2906002)(26005)(9686003)(4326008)(956004)(55016002)(33656002)(86362001)(5660300002)(8676002)(52116002)(38350700002)(6496006)(33716001)(1076003)(316002)(6666004)(44832011)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hw0SK3/yhmAZx6SS/affWyj2N4OywYfQjqzebTSd8FwmJRy3bwCfo1qbbKPT?=
 =?us-ascii?Q?MEXFdV5ZBMRXPcoPnXZlz99bEFClp3lUjsfGKVutrmK/ApV0Q0Giaruy5P9g?=
 =?us-ascii?Q?sCp8GmP2HMgIKrTBP+cYa3XF0Y6zFzmH6eliyJB3BvcqiInO1ucPeO4B62Ml?=
 =?us-ascii?Q?qqaUCEDieKonHt70vRx+czJ4N4G9xcOhXyytLc94Eo72/YE088VApXHXhVwJ?=
 =?us-ascii?Q?lKUDGEG52YjqlJ/wQK1RT2EQJ7AaIh0Gt8D1k9BMiRYPmymBerXU9jFCGV8d?=
 =?us-ascii?Q?8TO9MAf8v3QMDvjrISSpDvURo0Jeo9IxznYeMVyXvFWZMJvIFtsMhBUqc3HK?=
 =?us-ascii?Q?lGI9N5ZgfBew/M/ZXhepcSrrNDyu1KlEoXPajKad/xi2Fla1LpXOVEvJk+i6?=
 =?us-ascii?Q?4bMAyVaCrnvrkVgonR1ePdHen3fNKZKt4Sok2+t/t0mMT98fdDL/rfdoA/dN?=
 =?us-ascii?Q?Ng4uGDp73PkW0MvlliNzYt4OBoKBnmdZoF3R0KGuNh4lCzioV1ItrgnVfErh?=
 =?us-ascii?Q?6OLCf3W4d00YQgStPFGson4tVZpHB318tksVx2FTon5wN6dTwV/FbiMnU16m?=
 =?us-ascii?Q?qdj7+rZo9f34NTbCb+LCDZCxIdwS0GfigQQ16uBlmdf2+4B97FTArp4G1Dkj?=
 =?us-ascii?Q?jOkV1bKbWmy9UKYJ82cZCNzB3Zw0FusSkOcryE29mqJ3igG5wSth27aEdrzQ?=
 =?us-ascii?Q?oChe9q8JFYhPZcpweJ8Ppjqo6Wk/jhCH1/4pkhmh+36DppDplm9vr578a1a4?=
 =?us-ascii?Q?R21GDSxk1UGThgK+7TsDmoqAAb35W5OJcV7a/AEfelEbMah8WgotUI6xsKui?=
 =?us-ascii?Q?rwNQpvntzKDQhfMRenWA1/sDcXDnrTtnbl5N7A02G7MisVkINXEVcXzuBlDb?=
 =?us-ascii?Q?uoiQRpi5FROSS20sT4aUlzf24gdCjvOBQ5HTrlcOPKYrWNNArrbeA0wUmafe?=
 =?us-ascii?Q?8lc62XanosRMHTiqxnu8egMkTpbRVwTV86s58CXbitm8kqZmv3FX5Tz5cEy/?=
 =?us-ascii?Q?rcQFizSgBh8eDv6bZQzsXHiFtaQil48BVOK4/Psm5IzynPYZbzKisr3DRimD?=
 =?us-ascii?Q?344ChrsNMlN5sZSYqiIBV8W7ij/PJf/Ly5mx9Tk0ywUKrIJKsslA6i+laE2m?=
 =?us-ascii?Q?8IT83KPE5YLnI3H+0y+sPsWxGnEBZ/1pzT3KxPi5TOu8Sdd1MwmgiNnCzUOL?=
 =?us-ascii?Q?Q78v5WFS0hmbeDG3qSXtNJYuTG5KnxrzQUt/GP+h5wtX+GruwBzJ9xGJ24Kv?=
 =?us-ascii?Q?TkhO1BIdd+i8knFps15ZuDv9nrauD9HygcC0w3aBm72jzqAxfAdjArBMkn1/?=
 =?us-ascii?Q?xlNoSYpblGKL6rrQK+CK2Jk6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357e4ac2-a258-46cd-2b13-08d9872020c5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 10:17:11.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyICSNng7dl/RBstNeV0DIJFJm6GKeO94Vf/FuxwKplOIu5gvcu7HMtPZVwTlOv8OWHQXf1PVPC0gh5cAo4rX5XiTqLvUswCtTVMRPb0z7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10126 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040071
X-Proofpoint-ORIG-GUID: PYU8_JyLjTziaH3EO4WGt_Kkmei_ym-I
X-Proofpoint-GUID: PYU8_JyLjTziaH3EO4WGt_Kkmei_ym-I
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Miquel Raynal,

The patch 54f14be01e17: "iio: adc: max1027: Use the EOC IRQ when
populated for single reads" from Sep 21, 2021, leads to the following
Smatch static checker warning:

	drivers/iio/adc/max1027.c:289 max1027_wait_eoc()
	info: return a literal instead of 'ret'

drivers/iio/adc/max1027.c
    278 static int max1027_wait_eoc(struct iio_dev *indio_dev)
    279 {
    280         struct max1027_state *st = iio_priv(indio_dev);
    281         unsigned int conversion_time = MAX1027_CONVERSION_UDELAY;
    282         int ret;
    283 
    284         if (st->spi->irq) {
    285                 ret = wait_for_completion_timeout(&st->complete,
    286                                                   msecs_to_jiffies(1000));
    287                 reinit_completion(&st->complete);
    288                 if (!ret)
--> 289                         return ret;

wait_for_completion_timeout() returns zero if it times out.  Should this
be return an error code?  Otherwise we could just delete the "ret"
variable and return 0 below.

    290         } else {
    291                 if (indio_dev->active_scan_mask)
    292                         conversion_time *= hweight32(*indio_dev->active_scan_mask);
    293 
    294                 usleep_range(conversion_time, conversion_time * 2);
    295         }
    296 
    297         return 0;
    298 }

regards,
dan carpenter
