Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933F77A6FBB
	for <lists+linux-iio@lfdr.de>; Wed, 20 Sep 2023 02:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjITAB0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Sep 2023 20:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjITAB0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Sep 2023 20:01:26 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01on2099.outbound.protection.outlook.com [40.107.108.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DC795
        for <linux-iio@vger.kernel.org>; Tue, 19 Sep 2023 17:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkKoV858wyLTI567LZVPlHRX88CunV9Tch67hoIeUbZiyYcKv7mEPH/SO0m6qx5HT3U0EAexRAT8tYsr+v8mcd6wSWKuQngLUVnIqmExWUNrVkp2mL/LPoikeh2MDUvPd/Jpnxhp2JGeKhUtzwsLAPeT368/QeVej8qUb9uRvbp3t++XhvBmtoJkEq1fEVeBD78BL0qQWBe97Kh8MqQNy0kA5patYL3GHJKq8pTlVFctlaJOZ2oDTwluDMEBRXFasf53+N4W1rARa1BdEB/ZMO6EF6osAzvSu2uzof66zdqoO64RVaVZ1bb8pRZh5fHm5XoYE90f6zLWUbbZ+yOG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niKFC+t+THSxAbtDuTykJu4Ij2v0ORV7NpFwrnHjkyM=;
 b=AX/U8Uyf9Nq09WaaAzy0MRu2jBInDpzan8b65W6o0OEL2PrsLHu3a6gtsRGewqLa1XLnRQ2ZtFq8JmR+2tz/X1P4UWbLstvE/XHmujc7pSe+b0YHb2fIMkSjKYVzVK2UyehVWrXkv6UNzg1a1vstKZjDm1IdDLm0xlwKa6gJuf6/fZ+ODjFGje/L9AmSjZrg1luqp+F+yLmKfLcFwo+jyVOy+NlxeUH+zgzqEhdr/txwVbvTplnMHTYfzKdZpncqnGyU4/XfqUVWwf1Ih+5wQyNFkjJmzUtyc4jQBT0d/F/dhOFnlW5Zt2etQmKY8E08YoyFezASY2PkUVKsvwoMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=breathe-safe.com; dmarc=pass action=none
 header.from=breathe-safe.com; dkim=pass header.d=breathe-safe.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breathe-safe.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niKFC+t+THSxAbtDuTykJu4Ij2v0ORV7NpFwrnHjkyM=;
 b=hD8oGvt9lGcIfEDimCBkbBF41Hdr/5ZddKFXsDxy71ANVJSolQlu1M9rkqAr/PFX0mHUDuC16kERJ81QZ+kbIDk8TIsT60vcEsYQ3clscEnoGuEhUVtKPt3PBSFFaJeTDi4NSmXFRiGfXNg7jOxnl72NVadNL3Hsy7phciwDaUEvn/DWfYtq+xfCIRdzjAmGyXjYh91Onx5Ya06p8BnaMbTZnPOIO/OWGT2bvYOaXKM9YW4Xd9hHFKqpBBSYWeF88CzYkCTdwsAMB7CgK14lGFiDQ9/9Xe6BQlrytqs6mBn9ylw9zUOKZkzuHqS4BTwauWqNgYxpZ41VjSKGddMj9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=breathe-safe.com;
Received: from ME3P282MB0996.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:8::7) by
 SYBP282MB2738.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:151::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Wed, 20 Sep 2023 00:01:12 +0000
Received: from ME3P282MB0996.AUSP282.PROD.OUTLOOK.COM
 ([fe80::cf3b:e4f2:4933:19a4]) by ME3P282MB0996.AUSP282.PROD.OUTLOOK.COM
 ([fe80::cf3b:e4f2:4933:19a4%7]) with mapi id 15.20.6792.021; Wed, 20 Sep 2023
 00:01:12 +0000
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v1] iio: pressure: ms5611: ms5611_prom_is_valid false negative bug
In-reply-to: <20230918120513.00002032@Huawei.com>
References: <922-1694994740.375607@iEuc.VJY0.oC_q> <20230918120513.00002032@Huawei.com>
From:   Alexander Zangerl <az@breathe-safe.com>
Cc:     linux-iio@vger.kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Content-Type: text/plain
Date:   Wed, 20 Sep 2023 10:01:10 +1000
Message-ID: <2535-1695168070.831792@Ze3y.dhYT.s3fx>
X-ClientProxiedBy: SYCP282CA0021.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::33) To ME3P282MB0996.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB0996:EE_|SYBP282MB2738:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcf3765-2d44-4575-0486-08dbb96cb34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DkLAqtE82Jp8JPjHdXnY0FtAYLpc7zutypg/Q2Zprwahow2ylWqJGiwpeYOb0D85gbg1x2RztrI0bFMvLunmTtvNHukJmoUi34O4l/sEoA+NqK5Ekq9VLE88Zn5rCglmKrRZqCC3fWIO5qeCqm4WXhZNF6Ws5hh7E4vEiEEAAofkTMqi3FduAH4yVG9SHqx7+0b5OuHv3pj/lgTSgOUJnGTPXb4mSPY+CB4FgssqlftD4p1kKyh673Z3+jdKhU/6CoUCKNFnST6E5gj2qrdKmNVoieUe0YAbNL5FpbJ4fZDssnS445lWrIF/e4ezR/dwm+I4G/ZE8pTfm4PBdyTrATWbGQJ/hhqwPHhuZSDj2JYAPmJ4Ft5eKv7bdzhHxc5Dc2ELd268clz8FNE1jFMKljl7RxmeDfhz8WGeYQlkN57IAN1ENmRCeuFaQHA6SHeu5I32lTywhhpRJZTzoYPVLuYkwc7LhHKPBms0+b+AyMoXFuWXJ972DOS7DsXjkh1HX7dfCigBbRaGoZzxa9oxSE7xJzJ17rd+8BT1EJ4J0IbacPDFEHoxiMJvVAjVLfeNTEaaqdIV7spDYDUEMPSmq4G4lxX35szHIV56SH1BFlizbN/McGmnpAMmgaEtwYbCP5eVvD+QE4yXHAcv+dTjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME3P282MB0996.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39840400004)(376002)(396003)(366004)(451199024)(1800799009)(186009)(66899024)(38100700002)(6486002)(52116002)(6512007)(6506007)(9686003)(38350700002)(86362001)(316002)(2906002)(478600001)(83380400001)(4326008)(26005)(110136005)(8936002)(41300700001)(8676002)(5660300002)(66476007)(66946007)(66556008)(62816006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y+/u4NPorlLAOo/ozaBW0DEz9G2RqphdPA1TZb8A2yIIewSDSdTlVmx90GEE?=
 =?us-ascii?Q?ncdeio4CHUOq0P+QCJwnAl3wc90SANTXyyUH3sPP7ootid22Vs0GiHD4Kr/F?=
 =?us-ascii?Q?BmQBvzSjiEmhLrvHEpOxxvg1xewZqIXxlCG4RkBo+xmmTPkDdCrurkTEd9NT?=
 =?us-ascii?Q?lPhCf71hmcI7jMMfjjPv9j7OxygMyUboVy1wvCQdrLLneCIlc3q82ImAKHZA?=
 =?us-ascii?Q?HOqx5SShXWzz37oBBbNSamZZAIYr2hRscbiXW1AdivA2gVR7RrduHVfqcfE7?=
 =?us-ascii?Q?5yq73bFwd0LBMhk6rjH9ehVKRYMXntao/S7w8/TpemvulAbLbU97ufuNGlch?=
 =?us-ascii?Q?TMhu+265z8jtG7Y+7mW0zBFAcP+UIsIjWI11sb6oqwrGQ/pK7qE0Z+0YQ9Xy?=
 =?us-ascii?Q?34sW/v/H6oSLZTfZmY12eKa465xPgPbMIynAx/t+dHfmjdBKxqhogYRrTcbc?=
 =?us-ascii?Q?rdiAu71lGSkepn06+V8BK7T9vxYFOtZ56DEcfUkNNkn4oIcHzLBIRDrrb7/d?=
 =?us-ascii?Q?9/0nsHfJPXVr+fyadiEipcuj1SxbUIUMsb4zPMbAOB1Qny9VeoOA/5vZIOn1?=
 =?us-ascii?Q?5ukR04Tmx3xKJkhq7R5gSpw5Zf5aimtgxrpin+kLzNlB0fkyejz2jIMUghl+?=
 =?us-ascii?Q?6fRdN39XOQOPsXoX9VxcykwjWdqnLzamLC1CLej4vkp8mKLHScNCaV5u1Htl?=
 =?us-ascii?Q?5fckQkNZmAYW/3jk1U82jifI7keV5m1z4PQDEk3jR07g1YIE7WvMa9GKODGS?=
 =?us-ascii?Q?hGhP91RnFx5BnqhL0cFZdHqj0CvN8DQ9DnVzAu2yCp8vbJhlLFG1wK2zIOBA?=
 =?us-ascii?Q?1uSytEg8H4YJxt4Zw8swPe5c8rW/XcBX+v2TERLJO22PrTbmZbRIbF3MyIuj?=
 =?us-ascii?Q?FXA8rEr+2Bj8furH4Qd2jh2wXltUIxR1AsoqeemeSIGvYb5aHFbyrKJOtF4H?=
 =?us-ascii?Q?YpLOGx7NRmT3xTPSwAdIemeFE6eS4ZAEX1Nivfm83yLOFrDzgLyUE/UBtiLG?=
 =?us-ascii?Q?k8XdfGxVv00GyzJfHNUEiQX/zVvf7gOXP2A4iTFG/D+Pys+rx0zSdGZyTLUd?=
 =?us-ascii?Q?2Lz3vBFHk7QO76wA0YdXV+3XrbLMADR+POQA5RmHQbqUKvw4rOqTH6HsoyXF?=
 =?us-ascii?Q?9fcsUfyOY+u3ZiXPezGF15IMz2tvh0AM7SMMYRANAnMK75dbiFP9WLQgyac4?=
 =?us-ascii?Q?IyV94r2fHeT+rjoAUcra5j3XxE64O5AgmrVCjn0rwVm0PgtT6cehKNJZnXA0?=
 =?us-ascii?Q?UBU+q2+79UqtR0cJb6GgErF74g3jZsUX07cZmuhZUgJQZgTnSNkiEbNGl9oM?=
 =?us-ascii?Q?DzqVQsum/slwRQ+Zb4Iw/PmsahyuK9FWclFNgfUGgA7hAm5LAPGFD/VPvuAT?=
 =?us-ascii?Q?Y9Za15nhjpiK1wpdrc2yOeOXxDGzmrQqXxS6KCpuIbK552PLmwieRr561jlQ?=
 =?us-ascii?Q?pNtlZ4RZ2SFtbnLbQYjnza8INz9h57v1dzJm4MXcEd/lzZkPu6YqstIlaaHr?=
 =?us-ascii?Q?n5NhlNCCOmPwz/mebpOuATqUDN6gOkWm+z7cKR+vO4vrliNUisA3JvgGd/Vd?=
 =?us-ascii?Q?/EkuaO6MBJ2RCBvJq9tQil9wmKUxaXnwzjRdGO5d?=
X-OriginatorOrg: breathe-safe.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcf3765-2d44-4575-0486-08dbb96cb34c
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB0996.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 00:01:11.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6631c47-0922-4559-8cf6-3bd141897089
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pa+vC/TunXbwn7n47lP+0PATAsk8WObd3ipdQeZAnkc0X1QbGKOK01C0Ybj554QHREGnTMsJ7+WF08rMxH6cxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB2738
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

the ms5611 driver falsely rejects lots of MS5607-02BA03-50 chips
with "PROM integrity check failed" because it doesn't accept a prom crc
value of zero as legitimate.

according to the datasheet for this chip (and the manufacturer's
application note about the prom crc), none of the possible
values for the crc are excluded - but the current code
in ms5611_prom_is_valid() ends with

return crc_orig != 0x0000 && crc == crc_orig

i've discussed this with the original author of the driver (tomasz
duszynski) and he indicated that at that time (2015) he was dealing with
some faulty chip samples which returned blank data under some
circumstances and/or followed example code which indicated crc zero
being bad (i can't find any traces of any such online, however).

as far as i can tell this exception should not be applied anymore; we've
got a few hundred custom boards here with this chip where large numbers
of the prom have a legitimate crc value 0, and do work fine, but which the
current driver code wrongly rejects.

Signed-off-by: Alexander Zangerl <az@breathe-safe.com>
Fixes: c0644160a8b5 ("iio: pressure: add support for MS5611 pressure and temperature sensor")
---
 drivers/iio/pressure/ms5611_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 5c7a734ede54..9980c6f3335e 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -79,7 +79,7 @@ static bool ms5611_prom_is_valid(u16 *prom, size_t len)
 
 	crc = (crc >> 12) & 0x000F;
 
-	return crc_orig != 0x0000 && crc == crc_orig;
+	return crc == crc_orig;
 }
 
 static int ms5611_read_prom(struct iio_dev *indio_dev)
-- 
2.30.2


