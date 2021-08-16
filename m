Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F193EDD3C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhHPSlB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Aug 2021 14:41:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36186 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231258AbhHPSlA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Aug 2021 14:41:00 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GIZfUW022314;
        Mon, 16 Aug 2021 18:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=vyaebLh8zMkfVWvIKDVWodQecum3RSbMWGMvk9Lq/CU=;
 b=FuJqRF5F3Z+OXSvEAvG+aChKh9b/dYtdVhVSz/FF4Lgrfo+inw4KqQGF0e2JmokR7ETK
 hf8ErfzNdLtzkfJjZ8InQJ+tWXvzJcH9PsC3pKD88e5enEYkoOG7wVrJ07R20gULeW8O
 wDXOPn3H+39sq68ZwXc5C6705AZtn8mJ9CvPdthkZpnOnxbFh3dKEo2PEWdZ1vDXft7k
 YdX0IUmWzKYNeVoFkqB77q/CeWj4fOP7B7IUPVXhj0Y1OP+WeK9JiTEqdXw5bt6L0EiC
 uSZwrPcmipOaHrG1tEL0r2s8iJ3/B1u48JuNONmYUQabpiLNA9ltyFeDPuUP0WetPcbz LQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=vyaebLh8zMkfVWvIKDVWodQecum3RSbMWGMvk9Lq/CU=;
 b=GVFS//mUgr383MtTVUgfuuaPUmO6rzjtQrzs7UO3tSDjCvvhZ4vV5D90C3Y0DSMnDMhJ
 tua4kbKftaXBV0V21G7GytIFyYRM6b1tW2J2sALKpBmZXG5hKy9Z8xc0/8xcrUDVfF2r
 znKQFvTXqjxoVz1xOdtYIxn8VRUgRuNfgfD73+GJt1HTPa09SH157YPIjU48pkRhLZs2
 H3nsGUwIoMDSGRoC4Ckh7xQ4t2YsYopXNSHzoVqIzYGnWT2ZLaK/YxAxy0xuVat8F7C7
 Qd89LOjgsrx3RHaRNBUJH7grt8zn/MM+BjV6fy9S506j+qTjk7BV42J89TNRhz/AP8Ky IA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpghwcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 18:40:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GIYtYs169078;
        Mon, 16 Aug 2021 18:40:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3020.oracle.com with ESMTP id 3aeqksnrvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 18:40:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHjAM3LieQH/PM+UOkyCpI1fsmF7qI/aERupPDWsHcFfes0wB/T8q9sRrFjoYGrDTRVXdSV9VCYOeWXtTee+lM+4pHK7vWnpCCu8VcCLZXz9QKlVIWz4PNHJCpCBluKlpWR6uMkOGeyZQkjtAJiizbL+1Chk0I7syE6DrWNFp7mr4AwpBLg5EKpMkmlFBF0bxK+c38xBH9K7aMd8hS8nUjEx/Nt3w47XprpxDaS5c7f3KTu481y7YePX9zf/x1MBAlqwPHEHvZ4fTcbA1SdVJopIupPXlqZ+Po6Yx8QYBq95/dVi8MbLdYqaBtTWRuPLTgesDch7nXtCyIITybz9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyaebLh8zMkfVWvIKDVWodQecum3RSbMWGMvk9Lq/CU=;
 b=kTcAjKJy4S/BHThIDUa1RhPcoCeAXA3dhKOU50xskt1Pyhma22s4HB7Y3BxN02by6bURxdWgr/pgsiu76WXhBagFwQNJIZogH5gs6Gz5MvZGKSp+q/ys518JbnZM3crmfLLMzIBUpzD4OQdene6jewpXKqNSY9+WunGIA490/E7yK+9pTlvvMDPMUXpcNFPf0LgWt9Yro1Oy7I56pbaV/WMP00xdo+ObX3yOEIfuF7D0l9ll8REW14lEf/VCbPTW7oR4emzbvfFJbNt+/+20C0y2MawAuWGGaUIcZrQgVzoT9zkSMgioQc+Q5cHhzIFn6u7qLJoHXfYVC9gmhObhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyaebLh8zMkfVWvIKDVWodQecum3RSbMWGMvk9Lq/CU=;
 b=QDk1YKUp3+yoztLq4vVKyz8QR4RD7Psz2cCw49N4xfZJ94lD2n9zlSniB8EajPhAcBoNUiuSqgScslvayaGNTsMUUenwfedB1hK5/MYdoOhyhWZtuDBZmU58CzIDx7wFVXRnrRRZr5C/dzyJY+mZuBu7tA97SThZIscokONP6Fs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2160.namprd10.prod.outlook.com
 (2603:10b6:301:36::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Mon, 16 Aug
 2021 18:40:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 18:40:07 +0000
Date:   Mon, 16 Aug 2021 21:39:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: dac: fix an error code in probe()
Message-ID: <20210816183954.GB2068@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0126.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0126.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Mon, 16 Aug 2021 18:40:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88543a68-8de7-4119-9019-08d960e54551
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB216035DC9D9B74589C4A9D1C8EFD9@MWHPR1001MB2160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5IZk1dbV0QnnZuNu3upWM+lOT0G5v9iQVIfhT2DBkwXdQUUNKo5mEAyacnYhhGWscsugDGqxMJ6fJ2eItyNU5FFyYUH8f41OPNItaKbLRY0hu3F/t5CzuV/4s5D55kg6xtQ+sFLrxysdLo4nEoJq5WMSw4aL7+kxv0offnsB1rIJyjRTYwN1RnJQGS+Rq2zSzia6apDixrWtOPoUF+JtTs2qL7cN1zvi//jWh9K2f3SOSVfxo4gyrxfflTPUNVNuoGgJUDVKa714mncHmIl+MeKPbD13B2ltb6YHlqpWGG4qmTdk+NTrPSuD7fKiRK1gQdo2t2SoZpNE3gz7fQSQpytnW+Kp6W5N71AoMNPbIHbvZwLscQDgpS0Sq6CMrk/qMCO7eGne3dVReXycXMvtDbeYbMy223O+7wrZuC3iX0Bi/BEZeJoF1MaHP58rvSjpG0bbt6+hNQuerDfP0jbPpVWWVwfD7YxgwMmH8ElJB/fo1wnJn3YVlgGjO2scrNm8oD99hFCefUAHaJtiGuQ+w+6ocgswaSVF36k9X++3FEwqDtwQyGUC+W/z7hOLKeDRAqG/4xwXxyuq7mjH2JHA2/lOn7ehTCNXEPP/cHZH+XrKVEDQi2Q4TneU4ydil3bFpshaM2X5MQ32hyg03L9do3Q+VmpCvW8lcI/EXgI2f6EZeQRzc6O+D6ndBipV4a1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(136003)(396003)(38350700002)(186003)(9576002)(38100700002)(26005)(4326008)(8936002)(86362001)(8676002)(33656002)(2906002)(6666004)(33716001)(54906003)(110136005)(66946007)(52116002)(1076003)(55016002)(4744005)(66556008)(66476007)(956004)(44832011)(9686003)(5660300002)(478600001)(316002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fEVIr1SAe+7dCug3IjvvhRg8GouJ7lj9gjd8w4yW00yOf4CZEZY14vsvNg0x?=
 =?us-ascii?Q?4Kf1k1M9AH6r8gEeBKkvQyJZP8HkidsJoh9pAb6o861ozdXgOwMfUQed5e6c?=
 =?us-ascii?Q?oDf3bYyTmUwl2o6ncNpFwHW5k0FQAWGVCppn+UMHoCaJ76zJQr8iT+4wTddz?=
 =?us-ascii?Q?ioYp271uHdPDcFoXcznjclE9+oJCR+uCWrs2cx7Gl/biUymlXw7mR2TS3evl?=
 =?us-ascii?Q?qZYP9wXf+lLCUWUCLGKB57MlyJwDCUsUGwNeMBdNwYoEVghJyhSKM20PKjzs?=
 =?us-ascii?Q?4xSJeIt/iwMKrmqI0TMFIwCIDFURQmUcUOdtAwh6mhDF1SUJIN7IOme2xQSh?=
 =?us-ascii?Q?kdjvbfnczW+6vggF6wYxKF1M8DigHYuQJ5qCYzeA7vLoXDpyNfj3l1HiYSqS?=
 =?us-ascii?Q?zWEF/fIKRCJWG5z7yIPy9GQLAVF/yF8d3uNhyfiZUdJF+GyqIejBTC04gi92?=
 =?us-ascii?Q?Soz9ZLGYH0pVhlQbaeTq5wFKGJli1/JNQV0wJyN74Lf6+ug5n9+7xNz4vui3?=
 =?us-ascii?Q?udNcBZ4BuhDfCRElgxOYxfou/4L1RU7YKHd4Za8fIp0DIu5+792JqtDfmufI?=
 =?us-ascii?Q?cOFKEMWGVXm7g+Jyg1bhgguSvwPH9QnNa4VqiNJu3pO0u4XIeBx7AU/AMPyz?=
 =?us-ascii?Q?32gwbuvL1Y3AxFyVpBONoVANClYq7njypLiFSQD9rXNx5b5iHHTbiV5+b7wD?=
 =?us-ascii?Q?+1NgnWgUO6hFCv2mDoYNE/kjqrw6H6YhQlgbpO5/bbrFtdFLGQ5Zmn7Yp8M2?=
 =?us-ascii?Q?S5RLdj8FueeNiDTPVM/Y/vethKjmXovZi1i6tZPIduvH+SiOOUj9q04jDTwM?=
 =?us-ascii?Q?rjhGN/mboZdfwRwK9IRvX3ENh9SqcT725ihon8l9dFLKws+LibtqZAgszFmV?=
 =?us-ascii?Q?/GhhUdKsSsHW4lGonsvLYdRSnjuraMtQkZK+VNV3UwM5F77FcE7KI5btIwoF?=
 =?us-ascii?Q?aLAYitnkCdcEvrobkopjCPZyrEJ+2TaYRSt1Xbp2MyvWcmEVRuiuvqSusqpw?=
 =?us-ascii?Q?UXFzbbcRrroXDpzZCFCj+LMVOLJj3TzM9nM3+hdnFF2uYSGLrxScXAkPPCDr?=
 =?us-ascii?Q?hnafuGHbgElYyC/MRYbe77xgh3a5cWMCIu0P8SjTfNNtP++QVJNWZwk0WJuS?=
 =?us-ascii?Q?I/xb6SkE16xIa+Op82pxHGodcnx/iMi0t219+VugcGc6Gxt1UbAEf4qUkC+7?=
 =?us-ascii?Q?O56IJ/K14u2BKsyuJxEu/Ht8EVrQ1E5YN3UyJG9zFW5edayIwFLolCSoCZoV?=
 =?us-ascii?Q?ZQFjuaQIUFyHPMexLjurnm+aQO03Ui4ccRoe3wd90bBibWvN8YdV0NP3iJSm?=
 =?us-ascii?Q?WFb8gXunE68yKXQcH2s4utzr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88543a68-8de7-4119-9019-08d960e54551
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 18:40:07.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXFe7f+H6GnMik0cOWs0GysY9PSh5rCoyAASRoqPKm1NSMEGx3wwihZZRkUViWA/gg86hgODpTqC26KXZAZguiixgLDIsIGIxhrvub3uJ6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2160
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160117
X-Proofpoint-GUID: qr_xRNvW5u0XlnMGq8QpBOveFbd4XP4Y
X-Proofpoint-ORIG-GUID: qr_xRNvW5u0XlnMGq8QpBOveFbd4XP4Y
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If we have an unexpected number of channels then return -EINVAL instead
of returning success.

Fixes: df38a4a72a3b ("iio: dac: add TI DAC5571 family support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/dac/ti-dac5571.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index 2a5ba1b08a1d..546a4cf6c5ef 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -350,6 +350,7 @@ static int dac5571_probe(struct i2c_client *client,
 		data->dac5571_pwrdwn = dac5571_pwrdwn_quad;
 		break;
 	default:
+		ret = -EINVAL;
 		goto err;
 	}
 
-- 
2.20.1

