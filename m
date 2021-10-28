Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DAB43E558
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 17:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhJ1Pow (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 11:44:52 -0400
Received: from mail-eopbgr1320104.outbound.protection.outlook.com ([40.107.132.104]:29376
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229946AbhJ1Pow (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 11:44:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlLlvLtvTrtGCPK5pOe3nXxU1nZFDgJNJ5QHk24d+yXb453b+/XkOOQtUIfUHsji66ABWnz1ED05KCT+2aTxK7MB3knsvuUV2/8nfmyO1JPMpRznWCzQlcXzdb7uJk2VXk3ohufEk8GYwyuOBBQqV0eyVZsAwWysl49V8AIL/V4+qXSnl3UY3Ub44a/vJCA5F65CAZdDhx7o3+tfJVroWbceSZ4iKejtAar9diN8m4tMoLbQG9ajLdUlaEw13CmgANxaYrEdqgjyBIYOMzbr26xqGC3+epnxEie1sDtaDDhKFhbRGHfcObDyOkzB0m1LiVVRbQm4aDvuVAS0raU+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=of38BwWiT/6jKZKXKn4e/Q+BawMAmSflf/autN+zpcE=;
 b=HDM9HHpe/5Z8jETQVkA8xsjChfzB4bNC+iPJrY4v1mtmXbXQmyO+0kkkrOv6UKKLlO5NNTn/HgRW/VZat1oGJFzBkhFwGr170DDeR2j7J1idD8BHS8Pdb1HYNjtwDr85wTlyV111vLJPjxDLZowj0M23C4Ja1Q5JgTILD0yQk3/nOtCchkxPGEN50kq8hs0Kn+EPvL5wS36Z9IwHruTnULm3JnrWVtSoaSFk3cxkFk9t4ia1vWnu5pVEBlgnRsac6gXFVASKNYHBNS8miMxa7n6K/uZMGWPGDol8FwZVD/6bv9Tl3Bs5ZOosXXMiaMb7BEUjZThzb3PcQVLIwNsxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of38BwWiT/6jKZKXKn4e/Q+BawMAmSflf/autN+zpcE=;
 b=ms9DbvJ/pRWz4C2EmmJN2i8Hk0zyxSF+nUAW0x4iFWtfBCmpOn4lrLpaP/NH8cch4NGBBfpFwlhrM9AOggxWbth8qgGb6UWpR3pbteIxDN5qU5UTStUoeZXOyry67VJlm/U+ZU8cUxgpP88axQfdFrQBPuXKY/4i/6LWeUBtQAY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB2857.apcprd06.prod.outlook.com (2603:1096:4:1a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Thu, 28 Oct 2021 15:42:19 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 15:42:19 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>, Xu Wang <vulab@iscas.ac.cn>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com
Subject: [PATCH v3] iio: adc: stm32-adc: Fix of_node_put() issue in stm32-adc
Date:   Thu, 28 Oct 2021 23:42:02 +0800
Message-Id: <20211028154204.1263861-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from myhostname.localdomain (180.110.127.20) by HK2PR02CA0193.apcprd02.prod.outlook.com (2603:1096:201:21::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 15:42:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcb21e28-c318-46be-c50b-08d99a298636
X-MS-TrafficTypeDiagnostic: SG2PR06MB2857:
X-Microsoft-Antispam-PRVS: <SG2PR06MB285774FE9565D5BB8DDC8575AB869@SG2PR06MB2857.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUSpd5KvuuoEwHGCoNougtyeQlO5zWZ+IxbN+Nv8oecv69x4gfygDaYBsQlrCm2rjyfcY13IMOVgaQDt7mCObE5g2Q5mjfyeAz6knMSct8Zwm/tz/XaKjUdOrSlbJSRDd8C/4/mxQmZZBR1He8ifGMHjp2A23nmblmyNh58cmupEpkRNOV843v+DLCzqZlmQ+b8qPZANpz6mj3428CadToG1nYaEfUTjjjXXleqX85uN4Kc0uemRw3JdL4envBsv2j3AZGpxjP3JrpJCiBz9gI8rXUyCZxKMHM++ek2q7zqd/f3cK4xM7t77RZQ2l6L4+TjTODSc2LSI8MZ6Jra5ppbq9FM5Pkw71pLD4Jbl3FteLjEYwIrxgD+JdpYivZKiE3uU7J8IDr/Br4WKFx+BXFDD+dEsT2GODFEGpyRKp91x7qDLVH5Xj6lhVoSVc1ZmDQFefXI43BLxUfPTOZD87esXGJdDl/wupDHV9La9Fci1NJf4c+++uiF5gLMMZrM2QHEIGrHXOpg60YcXTabX21nm5TgsKLJQx2g2RVHmNCqmeu6QWyKij5OrCo2n4QZ7nG4BTLNNwkzrMg4Q9EtL6kFQEKZvgcxyhetxKY3EC7iUvOLkxcHejY/gDtqXdrNvMkdSFqyA3wPDPveqV1GOJ3qGQaqQBHakdPFopUVHD9BgwWZfLFWhxMWtLfhVfnGeurWJt/qPdQCp6FaNXQXdOx30TnzpLRQPawA1bH17pRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(8936002)(110136005)(66556008)(83380400001)(2616005)(6486002)(5660300002)(8676002)(186003)(36756003)(6512007)(66476007)(38350700002)(38100700002)(52116002)(7416002)(956004)(4326008)(921005)(316002)(2906002)(6666004)(6506007)(86362001)(508600001)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yOzpt6Zw5/0Wl3j35cn3cAed4QS/HMcvoegzWAli668BEExpJMINuIq3iPFC?=
 =?us-ascii?Q?IDGeBxFL0xkB7cxwnAlAN5EvB26VOPOWizEWD/JYZTMhU3zg8m8qPtBkdmV5?=
 =?us-ascii?Q?w7AKJ/nUSuWOz8d5GW371EPCER8+XuqDjCkQnHMLAUbj+bDhpipIVbUePOE1?=
 =?us-ascii?Q?YVWGllIqwCZ+U9pulYfREBYY0TNxCN8Huy3XDveMbM2JvWNd7kNaTY3dFJ+y?=
 =?us-ascii?Q?p1NsVcn48n5G+FfunhNHLghYPJA3/H73F89eVs54sqorfy466TWE9a2seJax?=
 =?us-ascii?Q?hMbmlOrdB4uakSCK6ZZDvLEFnM2HAxAC9S5AlRDcQU3yPKGzh7a8mluHkVlg?=
 =?us-ascii?Q?GcGG2U/ZeAbOL+CwzTUAlErda+BPotBEX/O0AopO+wpOLETliY8VqRgOGKF+?=
 =?us-ascii?Q?0M2eTJuSTOQpAr/zjSBNxdcs7FcP0QzMgjbD3u8S0h/mPrNtSYFsKZtiwW04?=
 =?us-ascii?Q?vRClk2fxQqKhVbajNhklQ8di3ej3B0LqsZ9t7Pm9KyE4QOKNhmmMclvjy7Hh?=
 =?us-ascii?Q?ml5DNUnpWEoPxJqwe23Rp2QFysvQnxc3vB8sOMxjslsiT9o6Vwcq2YjtxVFC?=
 =?us-ascii?Q?2z6vh+10mWVjDU9cOkLN4EqViw5UFYZ4KLNcnWS+Wbj18hegmjXUOdLgvKqR?=
 =?us-ascii?Q?QX+Q/lZ2fLTxYpRKIRKUwe6jvctjHvLu/vwwlgM5jnOH9Qh1sRJebcVa3/Gx?=
 =?us-ascii?Q?tfEO87nVrg9P41oCVakbtdr52FlVOgrk+wFzMM4KoRjKIDxWma2LsBOrKfhV?=
 =?us-ascii?Q?nfu5i/UojZJGx5P7v9457G27upJFLZaCBVzuWVg+WH8Nl0cIkYFBLrOcrYea?=
 =?us-ascii?Q?XGCAkgwkVWf5hT7JnuJauw6P8T0lVYQMMD8F3hQg+O1jinpuysKkjyUFsP1I?=
 =?us-ascii?Q?X1XwUYhsvzXObNUfzlFMfwfQx+Z+oZWz5WuBcKx5d63eL8J1v3oYGqqtVbLZ?=
 =?us-ascii?Q?K51uJym8QScoayCksivsgMbGmGLkRTWsUhfhhQBq7SjKRysihufWNb1lT70B?=
 =?us-ascii?Q?2Uyykfmsd+rD3WGd7KoWRqyTbK7w2ikzTUTlryD8g3W2oOlEZNW0ByV+dCPY?=
 =?us-ascii?Q?86YOvCOmReFgJIkLges+zmrfuL+J3g9gQ314TvLtB6G2l541echGKDUytMzQ?=
 =?us-ascii?Q?yq87MnJs7DPU9uMEnQy1iWtVcHUbXreTzzReI/30RPO3jaRf2wVAObj2kRFE?=
 =?us-ascii?Q?bjtrqaCQOfETNhPznWe9nMZXXdsD7Es5BaMTZOzIOesSIToROZtYr8jOiIbM?=
 =?us-ascii?Q?uwNeVMKzsgvlxrbypsYZQbuEe4V88/PLN0jCMNIRmfhaiukJxA4C9+/jkkJm?=
 =?us-ascii?Q?ON3tGNRnNjTVDbMHsroXnPAwjCzLAu0PPNq6ZAdtmZvTny70b2k8eGzWiPyU?=
 =?us-ascii?Q?X2ds6l3JOq8Bj2AqormsCwTA5DLDu8a3yoHm3wfPaHyuEIlcOTvr6XZOTK01?=
 =?us-ascii?Q?jYbZk9m4wLGbzz+y308Fr9Ink+G0FVPOAP5fIfsHP/q+5Nmatq99uc6d7NUl?=
 =?us-ascii?Q?813aHB4dla1GtSqb41yYGtNJao9Yjo5ELs9TqZgcPBHA+Nm90Q73mOfA0u7/?=
 =?us-ascii?Q?5z/j3RI748dZhxAvZoGrhBQPYNDCJ+YMx1bEJQp0v9DCOzqTtn9jc7N9pDCG?=
 =?us-ascii?Q?iJp7ylBVvjnrolavzt5iVDk=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb21e28-c318-46be-c50b-08d99a298636
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 15:42:18.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Npyl5/foiDQkrRfU/naCHolrJTqKJO08o7UvTCm59pyiojbzLMUgfdOpGelCX5DAvbeNbdR462ugLNxOho49sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2857
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix following coccicheck warning:
./drivers/iio/adc/stm32-adc.c:2014:1-33: WARNING: Function
for_each_available_child_of_node should have of_node_put() before return.

Early exits from for_each_available_child_of_node should decrement the
node reference counter. Replace return by goto here.

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Fix typo and add reviewed-by.
v3:
- Fix typo.
---
 drivers/iio/adc/stm32-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 6245434f8377..7f1fb36c747c 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2024,7 +2024,8 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 			if (strlen(name) >= STM32_ADC_CH_SZ) {
 				dev_err(&indio_dev->dev, "Label %s exceeds %d characters\n",
 					name, STM32_ADC_CH_SZ);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err;
 			}
 			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
 			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
-- 
2.33.1

