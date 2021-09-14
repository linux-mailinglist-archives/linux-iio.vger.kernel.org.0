Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688DF40AC0E
	for <lists+linux-iio@lfdr.de>; Tue, 14 Sep 2021 12:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhINKzR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Sep 2021 06:55:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6428 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231931AbhINKzQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Sep 2021 06:55:16 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E9ccX0014578;
        Tue, 14 Sep 2021 10:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+wGOcs/7tHdQh535vS+X5WgLoS8lIUBt6pe/vtsgOvg=;
 b=M/thEnrRipY8JY3WmkApoIk0xD4FKO/OTQO/Mq8UHsuuulAOuIv8vtdveXyTZe0uftmU
 uTmke7PyqpIZ0VZZWhvFKVo5N+kiaaX0RzKGFA+9U3SKanriKP3seft2EGbmxxvlyyCv
 cM9BIwzQngWECF/FTXxB+6Lx4vmVSwPmi2DEk9QwNhXBaH9/BUe3NZiQD2t9/8jULaMc
 kSkY87P54/9gohapOyCjHQUHiQk89MCJNRylJzueOzCUiNNdE4QqTqh/vHrQwmrF7dee
 mdlaWDax7AO64TvF7RyjcqQsDsKzzJIySD2oSqNgAHtTabz+OTtrwSmPNsGO/8p2jCGm xQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=+wGOcs/7tHdQh535vS+X5WgLoS8lIUBt6pe/vtsgOvg=;
 b=ir3jFjYB5oAXR8FE84KELIRZS8uzyuUw5yq43qg0ijqy2dAmrkbXSriDVbBYFDBG63cp
 tFuh7RIMf0VwK5yvB3toywYLOES1QN6GD6meeocTRzTMsWZdp3o6b7IWzMqT0RfLEq/p
 luZ5cQ6sWIvCUCUKJa7MHCmOxzmehFXr7IzTSruDI9/QoxhE+DNqb60FdbSUnrX3mqO7
 Cb676E63bqU6m+8k2BnLxWieL7AqoGIJSDTafBwD2l6svpVtDBeuVCDDHEOvmnFiXLpx
 9pCdJI2/4iiv/IxiLDokoB8RyuCp4+QtW4vV0nzpudiSD0JXJTLA7xzBDO/bLcHDE+Rb Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p8t8xnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 10:53:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18EAkNng164416;
        Tue, 14 Sep 2021 10:53:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by aserp3020.oracle.com with ESMTP id 3b0m964qv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 10:53:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XegUcfsPI7YhHvObs12MOoLy/XwF8Di4Mw6N8BKY7eTKxakp05piHA1RK3VN4Toq6KzY6uD9cNFbK+ZEOA8MSOrpk1P29UP+h0wHoQN0vnD645QRE7sbeHD0m+slneAV9uzAIijGr6y66rraQSBL/MfhnLAtsm3BzFQKcZF2ATMAethBDxhcpcq5AGZWBzgxtci3RerrAHgo6Fvvjdp5Bxwq0pw/g2J4eknsJmZBe0Ddz7uyRjmvnigRVg+i8Z01JhrM1xF5q6Bno/PTkJhoYYIcc3DQTdy4tKQAcstTBkhF6U2bg/QYET+ZlNhwZdCRB8uttIAnoSsn874X3TKHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+wGOcs/7tHdQh535vS+X5WgLoS8lIUBt6pe/vtsgOvg=;
 b=lsxKXpGh/jJ2dvWbZ1+WRKpCIJalzT6Db5q1+US6ABlYuYxYtg2RNYJeDDtsasKOUAXLTF7bDSluPIsWAft4MLLNnKO6liD/Gh1kT2bp3SGfHxbXGVSvs3PeOvjyPQR7zwVyiBzDQ6P97VEV3HdMFoONNxtH7O3fQSkRac+LH469j8XE4kmEIdfxJYMPK3P22/KStuVvowwyDLcu9w9cFWOpdgZ/qpRzOJhtCa9nLLFTaePKP/M3bUFfash3IhYOcZrAJlcJA9I6UXrc68MSnCXdjQNvlM9xouWdsp/F5Fjtbe+f7d3rDCoHyEveiXUJWZwZIbii3FiMOmWWV0ozLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wGOcs/7tHdQh535vS+X5WgLoS8lIUBt6pe/vtsgOvg=;
 b=CqpuT50t0qJf59V5vd0J0dwxWvd7mtl6HtPksdFCmb/RjwoxTkuD4atJga7V10VVhVu4TM5Kyvd9IMVcznrsKwqtevQAP7DTNkhUyuoSnUBtm5g0DA2XwCBACtsGSb0MgVy29o0wwYBJSpBgvhjXMeBgVUzgCvq8TbsubeB9vt8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2399.namprd10.prod.outlook.com
 (2603:10b6:301:30::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 14 Sep
 2021 10:53:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 10:53:45 +0000
Date:   Tue, 14 Sep 2021 13:53:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: ssp_sensors: fix error code in ssp_print_mcu_debug()
Message-ID: <20210914105333.GA11657@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0090.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:22::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 10:53:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58d58703-f774-4d23-335e-08d9776dec2f
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2399EAF1723919CDB3F13BDA8EDA9@MWHPR1001MB2399.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvxuqyknLkivkQvWJ6gYLSahvknzorFBm2XlPGSC5IHGZEWZYNJuSN2yAxRmHNZCRXdUCHQXxmvR3/9Tnl7D5EKRm9lqrmY6pnv+sqxENY17S6kWoD2X7l+ps90bl4OQWR3zKQRFvVr0zkT+XQ/TMmXYQSNyohsRh4x+9TlhzU3UpCcTWiN/2YuvEYp8PvxlgS43V90bwkk9YdpIBgcrb2trFDDH+ucGjQTspkbHp8p7RtSlWjSs0TJoIB1cBfuB+Rc1f+XfnPklVn7B3JzmkmHHCxML9DB5WOnp1+Q+Co/tvBM11uO5I6O+K2y8tHYIQ9vnH938bUKWeRpPIIUh9Oh0BUhKme4HaK5tu9WHkgm3ifIyc3mSZKRt+YWg3ukut6n7/xFPtFGE1cQg9ORpcVLF7t+KAsewox5MpXbB28TBSsq13WQ+9DwgoI6d0CO2Q1Uxmhs6KyYy26eW3l2UFVxUoiHaPseypVIGWn++u2HvQrbTx61qqPf5h0rmfebuGnG8LQqK3weo6g5P2XpirkOF6YENvqgQC4lI5BuESjXVO6LB7oLDGabVExnSc0LW30ePIQG1QXyk4isL9Pwnw81cQ2yo7kXZevOsrvrGq4LH0jC/qJ4+F4Q/03X+9Qnvr2f7thqa7eeJMMVq8uGUhQ3G2SwjlxHd1COR0fqgB1u7BpgOrLFiqFIvVLtD/CgKFomB3RIWHaeBkxMWG//IVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(136003)(366004)(346002)(26005)(8936002)(2906002)(316002)(6666004)(478600001)(55016002)(86362001)(1076003)(33656002)(186003)(6916009)(33716001)(38350700002)(38100700002)(9576002)(66556008)(4326008)(5660300002)(66476007)(44832011)(6496006)(52116002)(83380400001)(8676002)(66946007)(956004)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MJt7q6e0rqYN2SMJE2AJesGpONiy6PllyAwqZBzewvdULZ+eJYeuUC4Dh5KH?=
 =?us-ascii?Q?jw6oiqj3eHwPtTp5c297C7CMkZtquFbodOGGKDnfUTsHFo52uIeLBgz6dzHa?=
 =?us-ascii?Q?AcPmNU//QBbv8xW4DDBs4N0wkKM1ZCeE3Npa5hSk5Pk/CUIzvWu8gEUzYRir?=
 =?us-ascii?Q?lPqc5LRQaycIrwVxkgTRE+qMC099rYF3qQn92yZf/WAmiRBreTCqdKV1/K/3?=
 =?us-ascii?Q?Qeudddpcco8I0vJf5rUEvkeZ/rFLGYVGrqFFJrNAtfPO5UlOGKhs1w75+cfI?=
 =?us-ascii?Q?hgzcb1M5GWcZ3wdMEMj+RVV7X4Ewbr73vYCJ096bAWSND0sh3qbY2g+oRp3z?=
 =?us-ascii?Q?UHd7x7A76RTcB/qqF8Uf5onnaPxZM4eGADH5ttSxc2+3FRAnzgIyG9LgkpjJ?=
 =?us-ascii?Q?IyY+tFLftTOapjfn6OOvL6wfCGfbyqZ48U9s/147EX4KyEjIZMbQIdHqNoPa?=
 =?us-ascii?Q?Zr+X6HtY371DMvz1so1ZsZLorvWT0kDglkTPmK1Uf1WHmp9CTvqH5NdYsSwe?=
 =?us-ascii?Q?ckqSSSTUkUJ2579hm2y0ZxW+7i9Yq3tP9xD4aF58wk16phZ/YHnu6cQ8AT+r?=
 =?us-ascii?Q?i4kxFk1MNYfeACHS/5Qz4XZ5AAQWdEfmXMeGHNmbOHbOtG6AX3Ih20svLPfX?=
 =?us-ascii?Q?Lo9SWn5Ip5M4nNDh1UCRyMCzqmXCfEjaodsUkoEeAbhvr1zx5tzDSTjSRYUB?=
 =?us-ascii?Q?WAHp8LSEjh1D6Omg5H/fviPl57vukqFtBXeN/FpYzYcKvT+Dat4WA2cLTWpM?=
 =?us-ascii?Q?+Tr16b3YBAIxxA3M+4F6oUHJf6H6kWdT4h8wZVTNQBaxyuQfvd/UIjq92OJt?=
 =?us-ascii?Q?OdORhITD4g+bci9Fvf1WtOC1PzRArmwkdW/nZWpJVTfzW/XHqgkmWB5q/0Eb?=
 =?us-ascii?Q?8L50ha2nQ9pRoJjf3sS/wlew6GEtvxpiW9n3xkxveiU9gw3A7OGKA2dU0g8Y?=
 =?us-ascii?Q?weDNhbCPpz/haCifY78FTrVz1A0Z3HFhXuu1+ZrpD3EYJYMGAnNeK+QkejqF?=
 =?us-ascii?Q?W2vabcHnOD+rIZEThD5eNrn4wDrKcM53+snWfxrufJlBhmNOWUZGLW8iVliJ?=
 =?us-ascii?Q?dgMBsWsh6amdBE53HDQEZQ1J4tjTHzFvxcV/GS3RRSzus3TcyHEOmC8Gx62U?=
 =?us-ascii?Q?GQOxMH3flMaqINepenokTdC1jfHYu9z1FvcglXOmqDVlJyQNDoAc+fnmKrjh?=
 =?us-ascii?Q?ekgssGowYnQTsb/kn5B3dD7SsUue6fda7RGcr4vnFZZ3CORcbnGnNhoSyOJR?=
 =?us-ascii?Q?j55OQZFm00jt6677ps5ucXJv+tEFdejzz52+SvhZ2c1+1rczsSIl3UREymDs?=
 =?us-ascii?Q?e886QoHf2Vm3Rsk6DJ5M8VzU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d58703-f774-4d23-335e-08d9776dec2f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 10:53:45.0301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqhVYJf+m/zM7ufRq2SU0OXiOqkw+M5ehnb1RY7lSeqAJC00PFSdNNKGUn/gJ85InX2t7NBB0Nsd7rtIxmYxBOuSw0Kjj1tiY2ajD/DcHcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2399
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140066
X-Proofpoint-GUID: n7HWBKCHR6QPjLwZnEByaC5azLoNjNvc
X-Proofpoint-ORIG-GUID: n7HWBKCHR6QPjLwZnEByaC5azLoNjNvc
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ssp_print_mcu_debug() function should return negative error codes on
error.  Returning "length" is meaningless.  This change does not affect
runtime because the callers only care about zero/non-zero.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/common/ssp_sensors/ssp_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 4864c38b8d1c..77449b4f3df5 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -137,7 +137,7 @@ static int ssp_print_mcu_debug(char *data_frame, int *data_index,
 	if (length > received_len - *data_index || length <= 0) {
 		ssp_dbg("[SSP]: MSG From MCU-invalid debug length(%d/%d)\n",
 			length, received_len);
-		return length ? length : -EPROTO;
+		return -EPROTO;
 	}
 
 	ssp_dbg("[SSP]: MSG From MCU - %s\n", &data_frame[*data_index]);
-- 
2.20.1

