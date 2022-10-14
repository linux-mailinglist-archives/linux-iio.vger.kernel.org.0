Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB7A5FEBD4
	for <lists+linux-iio@lfdr.de>; Fri, 14 Oct 2022 11:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJNJk1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Oct 2022 05:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJNJk0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2022 05:40:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AE9C1D8E;
        Fri, 14 Oct 2022 02:40:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E9U23c009410;
        Fri, 14 Oct 2022 09:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=DbrLc+wefOXhluJ4aEeV4kjFtJGc9xNf4FTNHUIwoo8=;
 b=DkGaPiBVz+NyXmz5ANkkNoqULkJrO8gWZG9iAFT4NAwOaOlDG77TPglTq+faxrSSXLpQ
 1qZ4maS/5Gwkszr3aWmvh/Bsrge77bOEjPTTdbfbynMwKd0z3AyqY52VbDwNOgez/zSd
 iGPKqmHpcmS0hvEyKVzzlfYrcWRonAEFcoaSy929+MK0gQHuquYetgVVVrCcs33kwjCL
 Qxp8Lf6ZUbCY89K0/IA8NR8SyUpkAFKOWTxSduZjrWpcLO4lavyqvehERfb3yOpbpCg3
 vurpcKN7D9Dlw0kmEDqmMdcyegXi6XjhbvzulsoMd7+Bk4/FevZX6J5esS+89ZBYsIe1 eA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6mswj9kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 09:40:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29E85np0013567;
        Fri, 14 Oct 2022 09:40:01 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yndne08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 09:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/47a9D9/XtW1wlPqF7UxFHyRS3kfsguemgYfkBWdzQ1qsV8pNCp93bcTfB2phHH0ykiW4rALQ3KLkTY/07oi1ZU5G4E0trZePHyKXDcwRLf6Wf2lILouxFPSZaGPzhdezB+KNCG8gmcq9MS6jewJJFQaoh6XIgGHQ/jUjLTwhCyq2y24msbJiVGjvPgqYsjCoHnWHxX6JP3ZlWsIzD+8BIgT8tJy7vhNQkXPE5zS3eqxRE/15hlLZenpewMvmiZvVrq8dQbLYAIpeY8bdoueDNiJ83hhaFnOfmgP1PhXdE4MYHSByuvWU+Xqz3CBpg8n4aI1C+Af66j+6lclYrAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbrLc+wefOXhluJ4aEeV4kjFtJGc9xNf4FTNHUIwoo8=;
 b=lKcxDiMDV5IhIGOL1T7Dnx13KplTxqbgOrAy8e3PQqGQg7/krRQzZrWwm87rRkkYBFcqUlQOY5RtPkdhNUP550dEk8SeDWsvLKjESm8VQyJklJy8IKg9+ROzEjnqLJ4v7yFYtCn5IyGPAKVGCp+4L0xUSc0YjO2Cvms/9xfG4t15Fh9sp592SN6ds5Q5hsgu/qj93Y8optCmzHzoOdmk2gKdshD5h7D2XvDU6foMtzz1CW7NmP+3NBk2c7e+/P208NnzJfONuCg+TuV9M2naAQKh1a+1FPestPy4GoRsWp+lsJW/I4ziNCAxWgr8tMZpLoSbcoSV9FrIW2b48qaL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbrLc+wefOXhluJ4aEeV4kjFtJGc9xNf4FTNHUIwoo8=;
 b=iZJDNTLJ5u9hBdEtQZO/s8jBRACA8ZNXSitkbc0HIGESAcNQM/TyFuy41gtp/L+lGy8DQh5NuTXuo3pxIWsY9l+GO2o/oMXOnOo85GFCRVr57LGx90s/HIlloUAqOrgu/AqgXOPR1zU5/pbUpk/GqcT4t/rzwQuT/E7A/YJYhSU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Fri, 14 Oct
 2022 09:39:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Fri, 14 Oct 2022
 09:39:59 +0000
Date:   Fri, 14 Oct 2022 12:39:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: imu: bno055: uninitialized variable bug in
 bno055_trigger_handler()
Message-ID: <Y0kuaO9PQkSQja+A@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0060.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CO1PR10MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: ddda4ebb-4171-46f7-47d4-08daadc80f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ja5Ppm1Cp2ZuRL7X0+MDIc+7ChCvS64zMfWjggrsW1/Gyl16YN87htT01I3kE2SbrU0aio4uhTXNkWKQuXpO/DKRUNqG7mR5MkVUYjkKcB90VKlmovvBdmJkzvy5aoUHaxIcVso0bNCR72tpTeeJHq/o28Kykx+7PpdHIXlHmYmW+ekjQ31VdiZWN3m5QzzgqoOxJ97VjbuyfcIDdMoP+IUV0a1hhhhGp6JyPZ8GktMGXJ4txB5fX6L65KbUCaC3wl9Tbo/2oxYLma9ZseXBGSdioYgw0PAdySwzgSc5sAJc3Sy7P03njDJblvZkrHotlE0ygyXjRhUNOIjDVQFH3VCZyKEMKKIn2UyPBl1DYcB5qm1JSHip447DfYyOKwSlcB6Km7IiKRVEAX2uTIBvdyLXRuJz33ny8KZYsm49HWESfxjWIHOdavnqAChXlkXdsM00/BRAhGkPPE936JzOXIWHKJsKxNjNoeGzmaWjtNXSiDd9aFTjBEpW6mjn2LM2tevM6gioEQLnNucHKrle9khxIuWSQWThHtOpJ/R0OxJnsMs0DPEfa45PCy9OsGwcMAwSBMsMebHo3QojIv0YX5ktK03soM+8fohwvypnfqPD/pV/pX7YrdVdYEddh5lfnqfV7QABGVWYYzgUJxC57XDT+YQY9v6c3K0heM21nrMNSIBVEpRVjmDtHpZkSc6wPpZIz9+cIujWZGypml1h4aSSahWc9rCBJbYHY8Hc33V07/xqp4oM2aqQNxpbesKQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199015)(86362001)(2906002)(4744005)(38100700002)(5660300002)(186003)(9686003)(478600001)(66476007)(66946007)(33716001)(66556008)(316002)(26005)(6666004)(8676002)(8936002)(44832011)(6512007)(41300700001)(4326008)(6486002)(110136005)(6506007)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?It3E1I2ZQTUeVjiIxPrQf6MeH4dXW/+PBVmGgYJC0u4ti8/LsYxH7BKwtQvJ?=
 =?us-ascii?Q?C9HY0EVMw8v6mjtYtlRWNayXzzH/pw1oQ5sjTCWUuMQ6MMJB+H887Tyfgu0N?=
 =?us-ascii?Q?mhZzZuX5gOodeNWTWFp003WbUbIGe4JBhbNZcJ6y69IZviaZtvsp97UergjA?=
 =?us-ascii?Q?sTJOcVeoWVdHag28SwBn558Sn+0+kLXaUxInrOa3ZPV+5XkSZzLb2MKuLV4l?=
 =?us-ascii?Q?dVBtOoAE4XsQKedQojzJTVX9Z7a8B6dvPTh5/8igy/bI/scKg11r2X6BT6LI?=
 =?us-ascii?Q?BYd4qb15J/VHYmh/dL6UoX75ADLiCgp0tNifKLDD9EOEukHe2qpKz7WgFsNp?=
 =?us-ascii?Q?VR66koQ6Rh1ol1ltZD78ASCrg3A8RRG9bx64VZ0x9joYJBEIzHAMSLEp6X0d?=
 =?us-ascii?Q?7THB8A0uL1aido4Yv/Mj8HIgqWpH5iu1s7LdwCsE4Uuqc0PO47xma+DNvM8Y?=
 =?us-ascii?Q?L5i8BWkAW1XMtTcLqf18Wz0TeZiT3UZV5HV0z8c+6PGo8gB0xC4BPfF33tcv?=
 =?us-ascii?Q?DVkyxHVK19nMut++vZ2NDJSQ8tkYXX30Ipf2/xwChju/sLnP7SYYNUOUj9Cu?=
 =?us-ascii?Q?lEzb+pKngHFrcN3z9ItPUWVaef/veNo2mRwjAjOHDoWBy4n9rN0LfN5x+3uY?=
 =?us-ascii?Q?X7OqVUvZtUXYJ7PNsFRvdSoeSnpX+8r8BBm1jccNGtifmXTsAVrqZbuXIsLC?=
 =?us-ascii?Q?QgslSEE7jT0VlA5i8SV+pRR3mif4b+MQLB4lAvURc/QIu6WUvTciLJQn184p?=
 =?us-ascii?Q?kPdlzOnu8Co9VwWqWHFN9oVTZZYDseaumfOrP/j+MkwxbNFQcQwOqH1M1Xtl?=
 =?us-ascii?Q?lxDUObRncKJ3oxxDpduwrBVS/svyhr/fu6GqUV/i0kU/L/4dSFXPNKQRzgdU?=
 =?us-ascii?Q?m0rq8T1zheoX3JYKvGQbUaekMMiVClMbrEkWjzAqxRimPR/CMWZNcYrqbb0B?=
 =?us-ascii?Q?2z9xL3fAiWK9lYPy+tGt3naVCvUajO88PmN19i9zrOvm6A+UvV6288gRyboi?=
 =?us-ascii?Q?u7bjPmftFyPKu0wxvccit9MBmiI2gdQBFzwBWe69ZSAic4TO9crLt+LChXsV?=
 =?us-ascii?Q?yJDqOC/7jScqzrGr6VVRd0zYmRErZmIO1in2nySuIaZmtwcp7cPX5QOMsNPO?=
 =?us-ascii?Q?g1la8A1txdTP4SKkPePhgcQ7CPkuL8V75ECQschMmrSKooPPVtSnPmIjE+Tw?=
 =?us-ascii?Q?uCEXhTwaHL+8lTVlMTyGqs9j1z2ECLvGf4SZfSrEv1qr+cRU4thrBp7qyltY?=
 =?us-ascii?Q?KhJXN9vQxAhz5Gt5LiU31mLALf/8yYCWetS3XBEWs2746jQ14yFyKSeOPpni?=
 =?us-ascii?Q?PPPODEexst2XO6AFJSe5pEEwYr9l+Ho3jDHfkKuqNPRTpnVk2olRG8ARC7bt?=
 =?us-ascii?Q?MOcXKAiYtQWfKRDSxWtKw3zpOVTR7R597HV+nSgZoRew/JkQfISq8h94hRxe?=
 =?us-ascii?Q?ZXP1dKOK00yCSGLmDmNDIW+uBSNnFKsTlpqEFMPAev0MPoeaAjB0WiEaiNl4?=
 =?us-ascii?Q?uyPw/FWMMa0rld4HqtieM+B+hYZfRsJICgqDlJDZluk6B/h8AeoQ9aWwWLhB?=
 =?us-ascii?Q?mv2BYEdhbrYOot67PoPVFuwYT5PyPSePGu6WWj0MM22/gRzWQJ3Nkm3jXqKD?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddda4ebb-4171-46f7-47d4-08daadc80f36
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 09:39:59.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpeRHBxAo+FcwCPRSrikiHvyiyq0eZ6/7o5UKISlUTZYDCW8BbzqmbhQIfLDqIcZoKOHeJStCcGEhYX5tS9VginyxT5bLIxcmjkfac5YKXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_05,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140055
X-Proofpoint-ORIG-GUID: zENKAqVMuaCfQj_P8V6UG9JJwLlITxnJ
X-Proofpoint-GUID: zENKAqVMuaCfQj_P8V6UG9JJwLlITxnJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This bug is basically harmless, although it will trigger a runtime warning
if you use KMSan.  On the first iteration through the loop, the
"best_delta" variable is uninitialized so re-order the condition to
prevent reading uninitialized memory.

Fixes: 4aefe1c2bd0c ("iio: imu: add Bosch Sensortec BNO055 core driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/imu/bno055/bno055.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 307557a609e3..52744dd98e65 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -632,7 +632,7 @@ static int bno055_set_regmask(struct bno055_priv *priv, int val, int val2,
 			return -EINVAL;
 		}
 		delta = abs(tbl_val - req_val);
-		if (delta < best_delta || first) {
+		if (first || delta < best_delta) {
 			best_delta = delta;
 			hwval = i;
 			first = false;
-- 
2.35.1

