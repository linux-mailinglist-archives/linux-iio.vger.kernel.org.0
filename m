Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D61637B52F
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 06:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhELE65 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 00:58:57 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:62304
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229580AbhELE64 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 00:58:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldBLejhRjxFNoWRVz/oEbutZziGXOfN76qu3EpXsQowufNpFeu9U0eLQ8lx8TFV0KT0S3vP0KUn9Daf9LSAiPtU5osV+uxKLUudiwMZOpavbQemBgObrWIyt7o/3YTYs9u5p8PslCJFPOkdaNTcUmGvOTFkXiwSxonDJbkHhjkEG5U+4GqzfhyejZi/V817AT54gyF0lhKU1ntTg5bpXue7PD6Wj1L31syBrlKVBK3p1GrADbLDCp8tnxdVHmL9jL6Orsvibj9IUHXRJsTTDalX5y8ncT7pz23TpgYMEH0hhJYpeE0fXOGr+qfitYgWjUeGVntDf18qqzAriuOS4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Nco8OYRw5mldDoyR8kmCyxqQUoSy7YYg8nGImURlXc=;
 b=DkQcYwvhajYH0ZhFO3VC4Ww2fqIglUQl+dlE/gxfWFLoWbrkAheCb3ecwA0KpQvIM9tJu6yAtYG8JLrLnIe3XWO4KdmiIiNzOAaN2qr720hAN/k5U9+49MY5/zjzHPKpOOhl097KI96RFSzeyXfPWVht/EhrfuuTEV/jKQYdIvOhCcrNvHg84pfy1a7/eK/rpCmt208H3HWuBoOQp8ZtQwTMxJvXm09sm08skOomPLiCt1OlLBVVccQKLEYzX2x9HlobwccTxPn1Uus2cpsTGeZm+K1alATBrB8v/GBNfK14cd/w7CcvufhGfAwe02j+nBo4vERaxiVkD9kjRUYMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Nco8OYRw5mldDoyR8kmCyxqQUoSy7YYg8nGImURlXc=;
 b=N1Of2LatBALO+aGBleFoUEwWxdDsJtwvVsY2Cc7Oldsg3AFUnriukFbZJ5ifssds/f72Nf3MSpDFFg7PHJhBixf5T/zw/iTbruAXNx+Mvjda579NrpCExqZTWLFcZRqFIZD4kqOqEgOVDdeqB+xMUqsitf0sQx4lV7DVvubyW5A=
Authentication-Results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=windriver.com;
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Wed, 12 May
 2021 04:57:46 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::35d1:d393:5e05:4efa]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::35d1:d393:5e05:4efa%7]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 04:57:46 +0000
From:   Meng.Li@windriver.com
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        pmeerw@pmeerw.net, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        meng.li@windriver.com
Subject: [PATCH] driver: adc: ltc2497: return directly after reading the adc conversion value
Date:   Wed, 12 May 2021 12:57:25 +0800
Message-Id: <20210512045725.23390-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK2PR02CA0178.apcprd02.prod.outlook.com (2603:1096:201:21::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.28 via Frontend Transport; Wed, 12 May 2021 04:57:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5c65066-750e-4da7-729d-08d915027bcd
X-MS-TrafficTypeDiagnostic: PH0PR11MB5013:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB501392DDE92BCC1EEF76FD18F1529@PH0PR11MB5013.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypZk9uZhMRn4j8mC87orHmZyL09fUD7Gx1Yj8ZvUAwi6+8eBjl/FInjslQdVUm4NLIKuPlNXHrtZGmnEVqHXuxIYiEVDKXl8aPxLeAFAq41Tv8AZMWj4KHtkMNjo3rwzGrmKi73gVADyGnQg8VKwoMlWMWW9uc1qkDZoKN5CuKCLnJFXP7qBmTJmxSDWfc5KbQacUXJuN/Kmjm6wr0RZ+dHCInh3nUAYIhk9NeuoqsWdWEc3JZjszYNcVc191lBrjEL0km0Mms7KKCMvDjGfp32SZmgA9v2rq0HpQnRL8smEPcNeebYtE0W2DtZZYRgZ8HDEGB0EJsBfVRg+n6QcKOZvxCdjES+zs1sT9Nyz4KCTyAq+RuucszTOzRExePomjjoAPcwk5rxl4yZUNvXMaF5+LvrIITDeQgdIjiCtms7TCIMj7z6hvUzGftnvD1BUzXfpb1Tzx9cSxMPqP7Zlmr+00C5AuwjxEj6ZPlYbnO51tUZ0BJFMFnx1R/Gtt/Q0kERKqwP5itzgfvqrh4X28RHb5VagHAtduAsCzrnVL+BIHRb0LFFeBGdSJxK7KP0B352/aMZjDIBAIZB0/5HMRnIVmk6gRdrt3U4nVpW3p0x3Wx2kNLNWt91JKLxMFTyZvOnHYdjf3LsNLHZ9pQn8T3pZ90uaYYscnUT+3ZHoVhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(39850400004)(136003)(186003)(9686003)(107886003)(2616005)(36756003)(6512007)(2906002)(16526019)(956004)(4326008)(8936002)(8676002)(86362001)(1076003)(26005)(316002)(6486002)(66556008)(38100700002)(5660300002)(6506007)(38350700002)(66946007)(83380400001)(52116002)(6666004)(478600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I4+OlQBIIZ+SqMBGVOBoIjQT09IuHyuSflryuoYOI2GdPp1Qo5jg2yHx15q/?=
 =?us-ascii?Q?NffDr4Kmexr2MBtowOI+qPFkcgk/pXJ6tG1VJ5RzbA5v1NnaHiwAuGBsbSli?=
 =?us-ascii?Q?Fn3kK4gQmFZDcJAGmvnOTyvAbrG6HlXT2p5pukY+zOtUMdDcVPEvWrf3YVWr?=
 =?us-ascii?Q?MRRARa/YkqBBl7l+n2zB++kRzwZ5mRGhgMpXY4oOkPkmyxQTSBqDuWITmn3G?=
 =?us-ascii?Q?kGyo4jGV/DjZxtgxLXQl1LcpQ0sIgU3TYnZ7aqPoMuBLeoPPLwiYdCZ3wHdd?=
 =?us-ascii?Q?6LyZpNOkQ57CPGXArHrUlyt+8bKmkDjgv225Z2apBRt/XIe85oxz1i5YIuOb?=
 =?us-ascii?Q?ttEhBosgryHhRzBQxXVyVoLWuHNDeVevJyAFIiw3eTNh7Q/KI1avuPXKroZk?=
 =?us-ascii?Q?H76G5IE/I+FoKDesv3UWLwSf+RgDrQma8oeJYdobDeMC/mD4iVgXD/hOEJYE?=
 =?us-ascii?Q?kHUDT/DmysBd97J15/67lmea9ZNLhngj2RYcd8gJgzaMf6zbA7SuV7dUaAx4?=
 =?us-ascii?Q?jUhao82JiyQlqSYXIsJTaP+DDDrjYf4SpQKfMVK0G+K+MAFJYNV4RJcOzt+7?=
 =?us-ascii?Q?nVqq0i6rKRduLcqjiIHTFWrTZmvoNZx8bTKxOO4yTAEiat0nE2vbvRShCL1Z?=
 =?us-ascii?Q?vDByXKNHwKC4R/hKHoRLAgJm1cZ3G2VxzDcNwlKQSLvnhvEclAyCLumeBxXT?=
 =?us-ascii?Q?UN/KPzOeVP4Tqu2a73VwYUu/4Eg6IuoVdp7lL1MI3HvR3mRqn3Gik5SH4FeJ?=
 =?us-ascii?Q?fH5OyH+2YjbF+gNXmC8ZjzVIlHEahOi/M64FU4sI9nX/QCV3VPNEM5fo/g6k?=
 =?us-ascii?Q?L51T2YloQR5twinikc6imNaigSkZf/zEb7ZywUcL95o+K2hEeGAc2Pytk+Oy?=
 =?us-ascii?Q?NU42XNxq+tfMm/fpHS7Z9Od4NVYscOCbaeEDf/7gGYBJ0gDCXeUb5w/XFg3v?=
 =?us-ascii?Q?in0OBSIRQG07erDHcGPvizsD1guwdRAYVv80XnTAYW8jvoDAcIz/NYGoJXzQ?=
 =?us-ascii?Q?9GOowkUB4IUehz8aHBRAX/JcxEue1vGqaAxxJgXZJkZPba/nHMHU3FiWJddm?=
 =?us-ascii?Q?t1D9oaTD8lcdcB6xnZxt2jUzoR7NwfJp62hSk6VEMTP39cLklvGO0vJSRc2S?=
 =?us-ascii?Q?ykFG9nN3AYpBJJjYEaHrC2JYJS0yNtx/B0qazT1rNV7KFY/qz4JM+MWfnbXE?=
 =?us-ascii?Q?3hivKYIxP1VghTrzCMX88m+B3EKqWajNOXLv2Km5zGwV7sROlEWTokeKhCBE?=
 =?us-ascii?Q?adsMzgFFu4NakhF8YnqvEqftU2bmVmReB3He79vDHBP1ZFUepuxtAusbVXX7?=
 =?us-ascii?Q?S4ruyXHM1URWaCkhc9jv4jiy?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c65066-750e-4da7-729d-08d915027bcd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 04:57:46.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJ3wc4/dytwI1XKlhYOLjWGg/YYLObFjr06edarHPf13ZYH4ZU4yV8KM2a8aRi769s0qAVJPu9Sw38f0qtdYrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Meng Li <Meng.Li@windriver.com>

When read adc conversion value with below command:
cat /sys/.../iio:device0/in_voltage0-voltage1_raw
There is an error reported as below:
ltc2497 0-0014: i2c transfer failed: -EREMOTEIO
This i2c transfer issue is introduced by commit 69548b7c2c4f ("iio:
adc: ltc2497: split protocol independent part in a separate module").
When extract the common code into ltc2497-core.c, it change the
code logic of function ltc2497core_read(). With wrong reading
sequence, the action of enable adc channel is sent to chip again
during adc channel is in conversion status. In this way, there is
no ack from chip, and then cause i2c transfer failed.
In order to keep the code logic is the same with original ideal,
it is need to return direct after reading the adc conversion value.

Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent part in a separate module ")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/iio/adc/ltc2497.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 1adddf5a88a9..fd5a66860a47 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -41,6 +41,8 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 		}
 
 		*val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
+
+		return ret;
 	}
 
 	ret = i2c_smbus_write_byte(st->client,
-- 
2.17.1

