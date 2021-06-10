Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117BC3A2D5C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFJNrT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:47:19 -0400
Received: from mail-mw2nam12on2128.outbound.protection.outlook.com ([40.107.244.128]:45025
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231282AbhFJNrQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Jun 2021 09:47:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDWmkNzakiIuubyS5W2uGlGWv1vg9WscKGaARfVKXSEFk2YQECZfQX4M1cGcOVBbAztb5SmYfcohdk8hIGT51Xt42bp1lOHlj7Lah4KA6mxqXOgZ5AevRexASr2Wx94LBMrjZA95EAr0aT+m7NWMJwVCiYGj5OyXsv1aRZ2nUrYIG76mP/Cb+7rt6mNhTKfhODeRaMO6zkGXwt9XDEFPRzcODB3dAmL61VZMVdhzrNwVoPkJ14Jpv0dgwTI5W3y81Ca9rT0DYL2tJyicWIrFLoHzaL30VhIpEbcJ/JC/EcJwuJOtx38XuMwwCZ89lFWP57OCTKopKRKzDzzvAuUpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYBpu9dCoj1dtktAKUNHbUVtNIN/PIcpvHVKNoVv1Jo=;
 b=XXHlY4i/GSxmBuh9XpPdxFmKXYX33diGLdrUEClxL4pXFLaIDNDm9a4eefpT4YHVM8hjqun7CPIZuLAeVE0FlmBVkUPOMFeW39MNC5nssHhmfSCi7HIgkGLFtIQCznlodkCtb19E9yjLVlMvjfCasdsRgb4v9kXeso4VgbgYnlOt4JNxapLCdhxnrR4s9ERSPpiKBNtW45utyX5ryDJg8XABDKqK8/vtmbPGFEbRAVFp4Sinq+cituw3cDEMQFt5z8Dz5ecjTlBcEwI284lDMXB8CGMrXuuqRdPKiV34Bu4Uq75m+OdKDTqqDy6ZMWHRaHs4P/oOcBlLJC5XuB5P8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=licor.com; dmarc=pass action=none header.from=licor.com;
 dkim=pass header.d=licor.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=licor.onmicrosoft.com;
 s=selector2-licor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYBpu9dCoj1dtktAKUNHbUVtNIN/PIcpvHVKNoVv1Jo=;
 b=WsC0jhEbsGXoHtfprpL3uaXrlMg8UGGfa+ZH7bSpDcdNp9TXVoaGQfc6OF/j3wwNBJg+aN6r6OHcdylXjyZtUuypceGY8McRa+s7BP7G6jcUOptC/wQNw9om63bn5LJUVdJuj4Zxw5BW3wNYBIKDvJiazvX1ZDrtqztbP9gwI3M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=licor.com;
Received: from SN2PR0801MB2223.namprd08.prod.outlook.com
 (2603:10b6:804:11::21) by SA2PR08MB6570.namprd08.prod.outlook.com
 (2603:10b6:806:112::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 10 Jun
 2021 13:45:18 +0000
Received: from SN2PR0801MB2223.namprd08.prod.outlook.com
 ([fe80::2429:8693:e618:f534]) by SN2PR0801MB2223.namprd08.prod.outlook.com
 ([fe80::2429:8693:e618:f534%6]) with mapi id 15.20.4219.023; Thu, 10 Jun 2021
 13:45:18 +0000
From:   Chris Lesiak <chris.lesiak@licor.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Lesiak <chris.lesiak@licor.com>
Subject: [PATCH v2] iio: humidity: hdc100x: Add margin to the conversion time
Date:   Thu, 10 Jun 2021 08:44:32 -0500
Message-Id: <20210610134432.1752842-1-chris.lesiak@licor.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210610104136.00002e4e@Huawei.com>
References: <20210610104136.00002e4e@Huawei.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2607:da00:300:7::2]
X-ClientProxiedBy: CH0PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:610:76::23) To SN2PR0801MB2223.namprd08.prod.outlook.com
 (2603:10b6:804:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bee.local (2607:da00:300:7::2) by CH0PR04CA0018.namprd04.prod.outlook.com (2603:10b6:610:76::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 13:45:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28b24f28-c443-4ae0-c88b-08d92c15fbb5
X-MS-TrafficTypeDiagnostic: SA2PR08MB6570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR08MB65708E74F7D477848AB2F74A9A359@SA2PR08MB6570.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L65ypOXfIlVEppMxnQGbRQ0bvcUBEz95Xzm2qektKVd9T/4gP078ma6AMdRT5mEFbuYDUhKYVzitJTw5VDPxtI7d5dHKmBuLWImNbIxsTV/UOORNrmBGwSfPRbcOURe4s8Q6hsSB+zOy8sv+FCt/9FPvc4E/8VeXmkxI5Vht1T1cTFALAoeI0dogVwGHPt6Zc34WypDi8HagPSuxIvo4qAcrWloTaqP1Ue1iKvbY8UVmh1BTvO65rizUJjmapc9qmuFspobnyJn9f3XeEEKh9t48wzv9ZDR8SqDh7uQlm13MxsHaQ5+kpzSkaikyBST4RvyRIYM4dDB0GaZOQQuiyzie4QEnqpBWf4cubzP+u5EHeiNLP/M7XpOT62Xr6N2igxUsV5QiakkkXiFZ4tbF6AMbKXfU79Wd/xjjOKbsW0SN3hLbx93IW7hUCwoxl+zKitUeVgSA92cACO5LbtsTSJyWrdAhykE5tqoM+Bz1bfMlrC821VKgjgtalSiG9SW7CpcXqW4bzN2ChQkWWI2VBOIoNy3SnvA3kcKB13yo/krGB8hjVYsRPV3bET3j1C7Cxvf8O8rII/MZ8IBj9NUKGrfNqhGC3RcJ4d2pryh/scU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR0801MB2223.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(136003)(376002)(346002)(16526019)(4326008)(86362001)(6486002)(186003)(38100700002)(83380400001)(66946007)(66556008)(66476007)(2906002)(107886003)(478600001)(6512007)(1076003)(44832011)(6916009)(8936002)(52116002)(5660300002)(6666004)(8676002)(2616005)(36756003)(316002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NuVAwlIeRj03Bl83FCFJ62pO98wKhIV59OiNcXShThEE6Me/AR9XqXO44kCT?=
 =?us-ascii?Q?d7nAHf83L7HjNbYw+IWSCZKmFU/7va4vIHdK+9eXr8wVokyU9KkBS6aAv/JM?=
 =?us-ascii?Q?ZCs1JZ4ujmaDCOyvEOgTMRsDJERbqFY30g7zUfh7e1G8vqKGwUJLFxsTgkR0?=
 =?us-ascii?Q?Shn9CmIIDOZMLpzuzfQ4pUPuoQaKH7AuwAhEwQXmCY9mb8WGardb9rf419bv?=
 =?us-ascii?Q?g+1X+98w3uDP72rAVbcpDb+w3/lxYy6+OSBk/RXm6SBO9s52B7m3Jssv5gyn?=
 =?us-ascii?Q?ep4i+E+N2sbarqhqdiEOtgZ/U/j86zIRbiZAZd5A2bkjmel1hKpisthS8Av2?=
 =?us-ascii?Q?VA+pR3WotH/lod59CxXm2u6ziJkPrBlb7kp3wuwIPm8w0dXhFUhB/o+zn/E9?=
 =?us-ascii?Q?uFOZ+UGtseQIq92sCc4kcDcJHwqnzGlxA1Hejlm+/ShFLnLvUXgeU0IADmTE?=
 =?us-ascii?Q?zUFUoRZZoiTfbjulYNjDewOyCm9z7Up4TKm48xAVV31MgY3s23sn+m5HhBYk?=
 =?us-ascii?Q?0wdS7MYW9CtYjxdwoIm5GAAvRg1DOGNnVrQcqz0xErXRYcbRses16UMuUWcJ?=
 =?us-ascii?Q?EcztNnZOGsO+HtQlFW3zT5W/cIUmkw1etoWZ43K9bwPiEIQ8hWTKmQHMGjy1?=
 =?us-ascii?Q?KpDKGqTo0Skwg4MWHEpdsdbmWA+2nw2vuosbMSX5Nh0Cr3SJotoN2xFrBkQ0?=
 =?us-ascii?Q?4oPvlex9JkE8DT9YZJCCPrL7jgzmf/enatLOlPtttt3Em9RIq1uYW3fNlE0Q?=
 =?us-ascii?Q?gR07MSFuKzNuGtU56SwbyZes2nFcPjIeWOyaX1vtBXGhix40sNgJZHG57V6X?=
 =?us-ascii?Q?h6y9yGJLcTVEwChiuOXd9QIvnW0iD6zwsYqCT6Fm/M3DoQE1CxUVXSV5DYyz?=
 =?us-ascii?Q?og1ZK+Mxwyh22Sh5iu/Lp+Hvvb4ucMiQ68a8HxqAuuquF3+BOl1a9jZzo24M?=
 =?us-ascii?Q?uE2m5lA3nq8HiWZ5lcW5t/0IE02T+qa+zr7+zZ6FeNDi/ZtLDoIqxN3HurVO?=
 =?us-ascii?Q?Uv60YcaEL0L0/P7QRX/vByD0biTvZIipVwV0fFmUXGfbyUUW2O/RJ3kvyMB3?=
 =?us-ascii?Q?1i8rGyQM/IQUoOQ/S5U/jvRV72+Sbxb9ak32OB5CncK/rdRlOtBxE08TVBnI?=
 =?us-ascii?Q?j9B19QRjVwWo42YvLVnu6YrwGwatVxTkLhqlp+9vdn4gXf2WsOJj1HT4nJUT?=
 =?us-ascii?Q?1B+YNOJ/6NR+9ERq67eJ7Swlmmrnljh6kjyqSfgGTfhtbX/w+Yfl38lg/HXw?=
 =?us-ascii?Q?6t8KfXHVzeMXT4byL3gu7J9wh4lqjVoC42oDAOEyZVw+fUddaMMmerfOCBUc?=
 =?us-ascii?Q?CuKJzmpI3oD1qvuF80vhoaQI7femamn8aDotKeiP3300pA=3D=3D?=
X-OriginatorOrg: licor.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b24f28-c443-4ae0-c88b-08d92c15fbb5
X-MS-Exchange-CrossTenant-AuthSource: SN2PR0801MB2223.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 13:45:18.1384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48c70abd-da5a-4c6c-86cb-5e003ca01574
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/E7vzE+AhspeBxhfaPlf4wW+dbgAQAqpPHtk4XmCeLT6Y/GDVZNu5q7IDprt9MgY3We2qa7tySjpEbmyhZBSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6570
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The datasheets have the following note for the conversion time
specification: "This parameter is specified by design and/or
characterization and it is not tested in production."

Parts have been seen that require more time to do 14-bit conversions for
the relative humidity channel.  The result is ENXIO due to the address
phase of a transfer not getting an ACK.

Delay an additional 1 ms per conversion to allow for additional margin.

Fixes: 4839367d99e3 ("iio: humidity: add HDC100x support")
Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
---
 drivers/iio/humidity/hdc100x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 2a957f19048e..91790aa8beeb 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -166,7 +166,7 @@ static int hdc100x_get_measurement(struct hdc100x_data *data,
 				   struct iio_chan_spec const *chan)
 {
 	struct i2c_client *client = data->client;
-	int delay = data->adc_int_us[chan->address];
+	int delay = data->adc_int_us[chan->address] + 1000;
 	int ret;
 	__be16 val;
 
@@ -316,7 +316,7 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct hdc100x_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
-	int delay = data->adc_int_us[0] + data->adc_int_us[1];
+	int delay = data->adc_int_us[0] + data->adc_int_us[1] + 2000;
 	int ret;
 
 	/* dual read starts at temp register */
-- 
2.26.2

