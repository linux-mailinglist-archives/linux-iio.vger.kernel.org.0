Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B349064C2A3
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 04:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiLNDPQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 22:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237337AbiLNDOy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 22:14:54 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A327CE3
        for <linux-iio@vger.kernel.org>; Tue, 13 Dec 2022 19:14:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNgiSTPjvKJH4kQkYPEv4o8aJPmy2eYAnK1OU2MTyMDOEjsnagvbfAcxVErNRl/sysDW3FVarhdHJniJhl5stDYlwSla90JcPtsWHWm/ZdDud2DpiLLqGKj1k1NF3n6pCzJwAigKHPPG0+5ld99ON6oFW2c7vN7Zs2Jn68VHbj7YANS4Rrpz57piwR2nYKpGGLMJK1zcA+IXmWCfqM46azaDYBmEbmm9K7wUj5TeDCSIb2rpdBuFMas6a9qjI8S1bvKliLT3m2fUcKhmG7HUEAkZpYd6L7425PC8ZHdpA+oMp8xBE2sqhrLbb4QJz0i4SbllNXxWSaj0j937yWMNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQl/pJwbK6c0byFAT3NvQhGtea7hloLnYS+JgV2X+NY=;
 b=nXndrIDOOekLegmcMTVfUDO5aFRsOsqVbzZ/jSoOJLt9SFWhc8Q3nzSAjtF8WmE+18zPxkMCB013XU+RoVyUVH5EDOSi2uhte8cfo7p9bE1pEaiPZ0rPBrl90G9EcEgL/Xq95RxJAYHC5pYBERSLH4+7eEstgPA0Rool0xft+qq8bnXJ5HBiBiVmTCyAaSVC+2XClVZluzr12q6iiL5UUsFO+ZlCk+VhEUJ1P6tHclvmtUsCgocjP+ylV2BUTot/maVKnhZrNbeC+pezMgnhFkSAlJSu0B9DFe4R/vGSA45afa2MUV6kvWmUoXXHH8XTBw+LiVvWAodeHaCzpsqumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQl/pJwbK6c0byFAT3NvQhGtea7hloLnYS+JgV2X+NY=;
 b=V6H/Zs0HG3KAu9em16YslKDp1kZdJVozRMIaFxoGzgVX2Q1Iv8m2Hum3HMD9x39s/2uGxKFgKmbUtKgDNFD7TqXYofQjF9uFIuEukGoldgM1G4/nl0hR4u2OUCLT0jt8Lwm2i1mdiwpCu1nHUGTd6GUMIYyd0v87McPxI29tuK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM8PR04MB7761.eurprd04.prod.outlook.com (2603:10a6:20b:248::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Wed, 14 Dec
 2022 03:14:49 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 03:14:49 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 5/5] iio: imu: fxos8700: fix MAGN sensor scale and unit
Date:   Wed, 14 Dec 2022 11:15:03 +0800
Message-Id: <20221214031503.3104251-6-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214031503.3104251-1-carlos.song@nxp.com>
References: <20221214031503.3104251-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM8PR04MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: c3af92f4-fafa-45a9-0d7c-08dadd815c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsSIlkPA8KflIXMN8vb57mWgf/a0xyZRadzQQh7TIt0NSLTWzZGUSFVmmUmtv5/Y2xbDaICrjWQm53UVJ3qTD2mFPJ66lzNC0rjJd6b3W7FJ68Ys9wahgDOnniVHKBkAR0jC9q3Z/AqXVUQsMQBXvA6HFjt6fM9NqmfcAltRygSnNwWKSMKWND/9EsgvGHfwYxbmRG9CgQ3I5OWHL3lMiZ4AC0bFx9dti6SkRrSJMgQLhRzRssJ7CkzgtLjIvvk0XP8CU7wjsJgigm716wa9i/pFLuQ5PjmSR9WE4EjsJXUBY0+CsnA4GV9L2z7rjhDrEa4TuiaecfkJ9ilIjI/BmZNXYkcVkd/PmDcZz5bGGEjPxXfvHrIL/YuKAE9dxRLq0Zi79rAQHoVaUEwaq670S6xR6Du5iEcJ6PzUEnjlU3VDgzsbZAPZSFywDCjj1kJ1+WbseU31EoI1zx79AQ1U12R+KPXuCKyRpb/sl1ORLIFheLDKEBCidB+7LC2CNNspwLCoUItpGgck1sN9KsP5KI8IOG/FTUEG8imLHjpEQbXbvaUaHih+odVh7YInJNW4jXgcOmHPHrAP25QmRDqOBVFQlbECfgV+HXZJa05ubVD+ggIzxZ0dqIfdqvqwiRT1saesrOHlMfHTHvlFiA7fXkDIOFtfxdxc++LDYTpo+whh1YwHcktuwasxCzWQHXURiU0nAZSnuKE4yVT9qH6T0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(66556008)(4326008)(36756003)(66946007)(41300700001)(66476007)(8676002)(316002)(5660300002)(83380400001)(38350700002)(38100700002)(6666004)(478600001)(6486002)(6506007)(186003)(1076003)(86362001)(2616005)(26005)(9686003)(52116002)(6512007)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bB2YXZucYM9/oz5DGWdNfIbdqRepmTvynBOiDuLaJjyUozT1JblRSVRxGCQX?=
 =?us-ascii?Q?YR7acL1Ufi29L1L5uDR05ZSiTMn1uRUDH5FhzzEBCTASYAuKOh2vo6u8aHL9?=
 =?us-ascii?Q?xKs1TDDuum+axCws+r/J6a+ERrjsKDE+p0ME32QMUD4wGOLXYf2Ew9hlb8nB?=
 =?us-ascii?Q?pNR3I7hbgOOCBd5F2q9OxRjok6BfFlDmERTH41ecEcAHh90+X3/k2RJ0fCqk?=
 =?us-ascii?Q?R3UlHFh91Y9cNUUNqocFVnVfE4j6CTGoKjhufM84km6BYRWf+LLTfyxf4oxD?=
 =?us-ascii?Q?kaybLsijiRkO/09DmYkhEHDeVQvsPu9eob6ETQK+daxLZ+ejl3PauG2eLVX5?=
 =?us-ascii?Q?D9k1FEnVc0zxkfqZBs9vXQaDIlgQ1Y1L9BxfPMjRp8Qq6wLrJQlU+Dj7EUIA?=
 =?us-ascii?Q?Xkd7WXXHSR5KqKQ8iG8FXaszXhYBYsUgUHoJJ2pP+un5kMRZWhX92p8WM/l+?=
 =?us-ascii?Q?uLJNiyR0IblgbtqLm0UlSLkXQKuTmk1aTX66DrEOnlZLC1AfIp1VoBNnJ+Ff?=
 =?us-ascii?Q?z/CmKCG2ldEYieaGYe9LKodL87G80tgGJyROtkjxxuKiO1g2dDOKTaCHGeeW?=
 =?us-ascii?Q?dfF5YSYfCdhLdX7abkDIu4ugLc2AX3mvbYeKD9/AV5rqRtizExlSMqCFkRro?=
 =?us-ascii?Q?4TiIZBNFrEx7ijoRLUfhxWqy7p2IDy8tDoHaahlbEardwyTLga0hWLIvANFq?=
 =?us-ascii?Q?P3sRG4XzEU+J1EFapLTIMH8kffuzBJnMg6KdccVho1zPZSrEnb3mzLR8nOjb?=
 =?us-ascii?Q?4hLAPOO5liWSM/OZg2WU6nyJRonYlQTTygVvCMiCbzWsie4d4bCPZPgV2EkU?=
 =?us-ascii?Q?Y/c4fwfWSRDJpSaeoUOGyCQDYxh5zdcOx4HbnNkb7N9BlkEVW7mb34c62zR4?=
 =?us-ascii?Q?oRcoRYdmm6zUmiB4Mq/1dpXRUlxXAqn94EC5v7Zy05TmUJZw1ox9b7Q9VJjH?=
 =?us-ascii?Q?TG97ZDBzckF1mYx6dy8bpU1i9WvA39DjlI96hWWS0plKZI8Fp8+ZyeofbmpO?=
 =?us-ascii?Q?9s8UFW8ArJciMM/+4p+AGGD9Y4CVuKM+MLeE6QbhXwvtLtNuf8jpTOCGLdd3?=
 =?us-ascii?Q?s1UDGGdoL34FpYt6ecUunov6PnA6vldLicWkuqGbIOzSZBQaIguuyLJlPZjW?=
 =?us-ascii?Q?s72ymvJS8yL4pEhl8qdd2QHlbxnFImPfTtrZL9/AhsNpq79IoVpYOiBB9gms?=
 =?us-ascii?Q?vYeDNWgnBnHbTdVXtFOcs2bPHOqU/iX+OTHv7S5n05HQgOaNCSNHo2E4cG10?=
 =?us-ascii?Q?Q1bFDLEh1KyGZKKcl3E7ZWgnGnd+LrtMbKbZKAoQyUU3KbxZ37cjLEcZufQU?=
 =?us-ascii?Q?6VArG7aXeWPX0xxKRB9J+/921/wA4kWDK8CdFk9LvE17HIztpmNdd22O2EHG?=
 =?us-ascii?Q?r4z0gujnV/eX9+XU4OGj++atXNsQG7NfYb0B5h7uc5kyUixhGV/npmJNCrNz?=
 =?us-ascii?Q?5VLlsNEvBlatpysPfYfG+f1HJ3MP0GFMe0jWRtRhNl5gWxNbh2MP0xNCaz57?=
 =?us-ascii?Q?Q9kwhBbEFanyn377ZLK2R5dnOu447/vxpMOqyhqbv4wn1f/3nvWJsC70I/6n?=
 =?us-ascii?Q?fKoEj5QYAkiehDxXxebIWq+k6fGqZ7IavP+IdogT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3af92f4-fafa-45a9-0d7c-08dadd815c13
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:14:49.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXD2rFaSfK9+dD0IsZ5IuxKTvMx9afVOWjjowNG89g4Nj5u6/tmqt/G5n/UXejhru86gboN932PxUZAXVpkYdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7761
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Carlos Song <carlos.song@nxp.com>

+/-1200uT is a MAGN sensor full measurement range. Magnetometer scale
is the magnetic sensitivity parameter. It is referenced as 0.1uT
according to datasheet and magnetometer channel unit is Gauss in
sysfs-bus-iio documentation. Gauss and uTesla unit conversion
relationship as follows: 0.1uT = 0.001Gs.

Set magnetometer scale and available magnetometer scale as fixed 0.001Gs.

Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Signed-off-by: Carlos Song <carlos.song@nxp.com>

Changes for V2:
- Modify the magnetometer sensitivity unit to be consistent with the
  documentation as 0.001g
- Rework commit log
Changes for V3:
- Modify the magnetometer sensitivity unit "g" to standard unit "Gs"
- Check and confirm uscale value is correct. The readback of
  MAGN scale is 0.001 Gs
- Rework commit log

diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 7b370bd643a1..8320a3b6f942 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -351,7 +351,7 @@ static int fxos8700_set_scale(struct fxos8700_data *data,
 	struct device *dev = regmap_get_device(data->regmap);
 
 	if (t == FXOS8700_MAGN) {
-		dev_err(dev, "Magnetometer scale is locked at 1200uT\n");
+		dev_err(dev, "Magnetometer scale is locked at 0.001Gs\n");
 		return -EINVAL;
 	}
 
@@ -396,7 +396,7 @@ static int fxos8700_get_scale(struct fxos8700_data *data,
 	static const int scale_num = ARRAY_SIZE(fxos8700_accel_scale);
 
 	if (t == FXOS8700_MAGN) {
-		*uscale = 1200; /* Magnetometer is locked at 1200uT */
+		*uscale = 1000; /* Magnetometer is locked at 0.001Gs */
 		return 0;
 	}
 
@@ -587,7 +587,7 @@ static IIO_CONST_ATTR(in_accel_sampling_frequency_available,
 static IIO_CONST_ATTR(in_magn_sampling_frequency_available,
 		      "1.5625 6.25 12.5 50 100 200 400 800");
 static IIO_CONST_ATTR(in_accel_scale_available, "0.000244 0.000488 0.000976");
-static IIO_CONST_ATTR(in_magn_scale_available, "0.000001200");
+static IIO_CONST_ATTR(in_magn_scale_available, "0.001000");
 
 static struct attribute *fxos8700_attrs[] = {
 	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,
-- 
2.34.1

