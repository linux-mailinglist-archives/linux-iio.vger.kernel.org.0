Return-Path: <linux-iio+bounces-9751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2A1984533
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 13:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AD31F24023
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8255419B3E4;
	Tue, 24 Sep 2024 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="X8R5lBmU"
X-Original-To: linux-iio@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2088.outbound.protection.outlook.com [40.107.117.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA312A14C;
	Tue, 24 Sep 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178660; cv=fail; b=ofS3me+gVrP4CGfpSs/pPzdcjNhqL2mLQf4LE+MnD8NxvXbyv7fw3hyVT5LK41Y4wzDRle1dBGokMkDa3kI8zOSyJJ70A2KAafgLSDzduGL6CeyABcC7HEi5dQHjTiggeJA1NyKZWcpDYM05xL9RrZZqCM90uQuaEvi1VeNgCTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178660; c=relaxed/simple;
	bh=GMtDNDnIFL12VaSgkBSOMP8B0Kf9+bGUIdw8u3JW2LY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Jvq4s4vEoJ5jUKJ4I1ZYAlp2QwBaInQd06H71bC+cPntytyRPmbowsi2mq3ULmkrqxZ/GLxUZo22F7dF/2RwjDwMp8TMnaOJP8x0LKLdd/C1/5QH5pIibli6xFA0aJ5cJzWhq3tiwCFcZUXkBkg3OKMZl/Y5udP0i5CddafELzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=X8R5lBmU; arc=fail smtp.client-ip=40.107.117.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWxjZo2zUAAhtg8gYVFPFrPm25KKYO5uJQ28XD2awYsoq9aaSgJOxrW6nwt+u2gwAvxBXVmrJwDIlLHb4AmiQ3JJbbEMMFsWrJvGibj7QR2Pys3AxBeO4XfhiMdDwSOLbxE+hG3VDyuPVqu02a3HsG3SMcJr4j2VNO4P0XdtdgLS6FONnSsywoLTaw5wVlrhU1DF5pi94GvCiCgMEszuNLcWv83H43jWWX9vQFbOWmv9Mz0c9lwW4ib1pRzED4LwZiNEZJcn9lqf2o/p1hdsEEW4YNSpZjQ9mJ9ORximZyURZwMs6e6dWiLKwLuboZLYiBCHZiFAHMl4MIMToqMYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6HcX+ZwQjCnDfPoRwcGkcjBOc4XTFzWA8VebOTo1Mo=;
 b=WJSqO08i9VWEDGUUYLs//bL0DbSrx5QDwVSRcjH20HA3Fu06gYJGg6aVUDht6i20oyaXg6yAD0OMKOtTjc9Pom6ESgyqY28KG1qEv8xOdXzf7kkjN6MRdOhxdrKQjNdSdOr03Y857LvqtIPj/MevlKwN4+5urdtkf9c2kWZIaoI5nsDMo0d42pXmV7yywRZj1+GE3qdJ6OAl+7yze7CXXHFlokaoJpEvQeEIL1TVY5axJOrTUwMW+JjdN1lciXgw9KJh7AmeuNOyGYRh/NBZGidRAlpA2vfXdZhheKUeNIfDOUcozkol4Ru+aUlPq8iFRGqraXj7sD4ZNPTY+zLzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6HcX+ZwQjCnDfPoRwcGkcjBOc4XTFzWA8VebOTo1Mo=;
 b=X8R5lBmUtF9o6q3PZJLKkpom4wAng27QF4nPm5k6Q3895UOU53NkRDMjAWwXVY5yV9HJucVa77FD9/tPZB4sPNwbXX/P7QkZuwCC2innSYi/NHvkcmjxf0Zyp2iKnSgwHt9GAee45iP4aPgkk+p99ATwaCDylrM5YPpvWq/2cjNwdI7j+84bq6Ld1LlH6hR7wE1jVPNQ+VlXQKa9RUnFCVwWFrJP2IRUBFQQVcL9mVaAwLFV9aq87sFn+dUWIYN9za0vfkhe8ErwmB9/uwfL+psFhIxY9zFdjyQCYdUpXfkNYKmDsPiHHt0FsVt88e9R8Uf0r3bFynUiFQnnKZXmbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by TYSPR06MB6471.apcprd06.prod.outlook.com (2603:1096:400:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Tue, 24 Sep
 2024 11:50:54 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 11:50:53 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	bonbons@linux-vserver.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: lains@riseup.net,
	hadess@hadess.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-usb@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] HID: Fix typo in the comment
Date: Tue, 24 Sep 2024 19:50:05 +0800
Message-Id: <20240924115005.3130997-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::17) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|TYSPR06MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: a88883c5-d201-4b26-05cf-08dcdc8f2486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KL70a3MpL5kZcgHIUjnxckeiILjsGcFpnxf5QEgutMT/XBhLZcOJYYf9tVYE?=
 =?us-ascii?Q?p2BaIRrUiP3FMiCpu7GMwfKOsDl/ZJ4UBbysMp1MIRGWgQsl0Ka6n1qXB3/6?=
 =?us-ascii?Q?BVJ4rjhwlY4YryYm7fH1ky5fAbRs8VDlj+9DfftGmAjNSEiJcn3A1igCKRoc?=
 =?us-ascii?Q?j5SJwrJssILYw8xP81NKCBerCp9xkY8kT3OuM+BVha7uCI3ZybqmUxydMDxg?=
 =?us-ascii?Q?ky1wKD5Fh8/Ldvdt5qzPHfnWiEI9JMv6e2DP4S4SeBd0bpQSCZWLTmZ/VDwt?=
 =?us-ascii?Q?vZs8z2F+QFv5M4yTDtfG/rI7HN8oquD1RgCciQIQF9nrr5yX9a9gOKbN0keF?=
 =?us-ascii?Q?0XwuXbBHSXayIyo6QcWjsYqZOL5JdYD476c/j3hNCTNruY7gp69wthgfN5lg?=
 =?us-ascii?Q?2SylVfSr5befO+JJlc4xaRO71/RJriHxVtndgzmA/ZgJ6ZUdgQP/GFEEeH9O?=
 =?us-ascii?Q?Iycw0NKIgJ5HfmzCUTLonDZllTjpHEe7vpgvCthEzEQJ6YWOT0obo0VDq5o9?=
 =?us-ascii?Q?s/C6bRUVdrafOnACnpaEkDtmeiuLJDsOQOKDjYnYz6n+TAiv2Tp0ekzf0RD2?=
 =?us-ascii?Q?p5ms+6YAnd0RDh9ybsTeeZ80UwDsoSvsVfpkVjCJnrpC9S69sM2CV/c2S2qc?=
 =?us-ascii?Q?9EjjoASeWIv6HX8scXYgJrQqd7WVvD3ITLFkBgO7H8xbxQslBCaawZuvhwqs?=
 =?us-ascii?Q?mCggMARBNj3mHU+/LQoZ9jBJpB37YRtm2QqrAxUVNkYH0F/2C6K7SoHNOlMM?=
 =?us-ascii?Q?dAYtNMp1Y10nVX+0tuIcTskQ1FmK5daLYwgRmM71D2VY9v9HOOlZbm7PW+pL?=
 =?us-ascii?Q?qc/z3hVnTSa9qjrhvkkzPwky1jSbtKlFhHExQFPhhhZUtMG34/WkAEDeZige?=
 =?us-ascii?Q?breQu0Rywo33LWt7mMYKOY/m1b4KaLKInF0uhkDfDoaqUAgof7f58IptN/sP?=
 =?us-ascii?Q?eypxKyxDbp0YiK4xXoMuU4g9y0eozkwFXJFmcgHf04JJKSXSGAlpCsOOJQkX?=
 =?us-ascii?Q?IVqHq02PNXWU3sBybdZezGuAspGInQ6ORi5VMupfYpzuaWOiQmwUA5BSbO0t?=
 =?us-ascii?Q?6NI9eSvDMo9rBy5d7r6rl4XxhiHDGpTJwcrRX4uteN+DrL3LqZGkoF5bI55w?=
 =?us-ascii?Q?Q98zlBCllw/exQZxzFfVl3iH5MNHLowmZOgddkNRBB3nxgoNwYj4SFQeJ/yh?=
 =?us-ascii?Q?UmmLEFxyQfxGzlq5oOXpYqL8x57TYERSHt6c/mIP9YasPmF58ghQ3GDYHC3j?=
 =?us-ascii?Q?imb1pY5m2EgMJ1z/+qhjo7cvFswoCBisx+7ZH3MasFXIYwY43O3uwyjvFcS4?=
 =?us-ascii?Q?JFZsRIbJZlsQCpB1RIbF76/SvxsRM6TsWa8KsRJ4iwf6lQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g8dFz7Jb0aB98kN7ZHxf6LWYwOSidI3STBrRSf1HSURA0JauCdf2WDfwyfZS?=
 =?us-ascii?Q?JPBwFdE4LxcRhRHX4k1gxWtjmKXbHa2EmvdsyS84T0B6/fQUtsHCbQbIwo3a?=
 =?us-ascii?Q?AdX+OeNHWwLBs5+31HC+PbYNAcFYakjDEu8Bsd9U78iFZXlo9AxmHY0DZOPm?=
 =?us-ascii?Q?RhxmZLV4y2miciFXrYY6pgGdMfjL2HOMggD8B4gUkU4yCp1X6VZuqhKOBh9N?=
 =?us-ascii?Q?QLZpQaLB6U8QWm0uCQlyfZElXDutskAVCXc1eEUsXD4n7k+HNmNZuz0lK+q5?=
 =?us-ascii?Q?geGiNu7kwcAqqZERIeTUb252cnz8199ZGcwxzaq37NYnsP2EyZDrZ5v3xsmP?=
 =?us-ascii?Q?AFvQWb08f/mlY7hI11a0Dn4kIU7CQE3SJQ9zB0Q86p4XQesYCGNs9CIvFXWb?=
 =?us-ascii?Q?7tz9x+TOUVuJ5r+fJZBi8Oi4AoB1WFBoU+h6O6muEZMkgmWktIKp4iAiihIT?=
 =?us-ascii?Q?ARWqpCdH2lyO0gU5JVKGmqeg1TjEDUQZUBeSYGOApA/na/jIPGz8Zc5u/up6?=
 =?us-ascii?Q?J84ENRHzIvnsJUa8JIUUo/w3z7YqrnqblnJX9h44hjyYESvKIWEp/NIvE8xY?=
 =?us-ascii?Q?TVe6DdPomgLNpzoJkxhjcDkzu5aXdsWSKkSF+pnp9AtKgJxvvyUKS9LleRrQ?=
 =?us-ascii?Q?wiogxermQDOf5qjqlXHxJsZTJg7iau8XuLNIoCGIdBzk+/xk7obLeHBmibJG?=
 =?us-ascii?Q?Ea0ZNZgccd9tMKqsKrjXJ5iYmTJqfTL7p5psLgfWnEF6Lkd9H5RedYqjaqIw?=
 =?us-ascii?Q?faw/J7N4OyuEQYLEVOaCchndkKJo5X8ldN7uY3NXe7rmrwVucojhAsWP5FIG?=
 =?us-ascii?Q?fM8a/dmsTGg++rufR7itvS1PxY2bvtwls+WqHU9Kgu7wNrUaYwU9bEk2D4lv?=
 =?us-ascii?Q?HXqnUKYLRWvuXV9uHNOi8kWDbcd2qKfCJxoms1HZfRXVfgimIbe1tPolShoX?=
 =?us-ascii?Q?RpuETmYcewc/0C9RsQ6/XhCuGQN2Y6D4f7WbPgo9bWQocn+NyISahSM89Zyx?=
 =?us-ascii?Q?wdh+N0Elchhi5b3q7xRsYqBAwJZOgrUwJs/Xj8idfyDPVxG3izD9hxVF5QIP?=
 =?us-ascii?Q?GlEfdQy+kUKS5yDjaaZWQ9iM8p+RrdO1N4xykSaKE2svmIczJ10DQLY6sIih?=
 =?us-ascii?Q?94PLK6x/cMgKrzfXCM634vLfxmXqcyKLUBE3I7a0bx66YiKrutQeaCKINAtz?=
 =?us-ascii?Q?jHQimIbo+XWfr5vvy1MRbVFOh2JzXzKot7ZQie+4UQ3zFTEcOXg1NKg/K8lg?=
 =?us-ascii?Q?OjWdzGMQa4yJE1+p069YOHcYfgrhH4OlLnnFW88ZLf1GyOaIJufBzBzRLYey?=
 =?us-ascii?Q?Jgz9AQSOYKqxZdxqOfeX8Edf9p9gVhLweIph/ZiVfVaaUJNH/nDIuUFhgGsf?=
 =?us-ascii?Q?u/eS8zJyriW9G6qlCI2b381auyybBhRvfkZxvUjYucmwskoKmzT6Qn4+axmg?=
 =?us-ascii?Q?TYAG3OzcJsTt/i2eDz9MbGTz+6kJWot0Ws6qFHbZ+knGow0SoddHqbryFUT0?=
 =?us-ascii?Q?fyjHInJivqpxtsR8SjrxAykemxZ+c11IMsrLsOxAGwsQa/hdB7p1F29iyyeF?=
 =?us-ascii?Q?ybfdFqMsgWtwSef7IhOLdN5uBP299ZjLvUJuEpOt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88883c5-d201-4b26-05cf-08dcdc8f2486
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 11:50:53.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKzizgV6SHUIstiI/SffoyA1Vb2+QA5JbMEGmbljt2ZwXJ+FHpAvo+y3ciZdsK5v8xw6q7d6QmeSYOIjXVQ7+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6471

Correctly spelled comments make it easier for the reader to understand
the code.

Fix typos:
'mninum' -> 'minimum',
'destoyed' -> 'destroyed',
'thridparty' -> 'thirdparty',
'lowcase' -> 'lowercase',
'idenitifiers' -> 'identifiers',
'exeuction' -> 'execution',
'fregments' -> 'fragments',
'devides' -> 'devices'.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/hid/hid-asus.c                      | 2 +-
 drivers/hid/hid-logitech-hidpp.c            | 2 +-
 drivers/hid/hid-picolcd_fb.c                | 2 +-
 drivers/hid/hid-sensor-custom.c             | 2 +-
 drivers/hid/hid-steam.c                     | 2 +-
 drivers/hid/intel-ish-hid/ishtp-fw-loader.c | 2 +-
 drivers/hid/intel-ish-hid/ishtp/client.c    | 2 +-
 drivers/hid/usbhid/hid-core.c               | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index a4b47319ad8e..506c6f377e7d 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1183,7 +1183,7 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
 	if (drvdata->quirks & QUIRK_G752_KEYBOARD &&
 		 *rsize == 75 && rdesc[61] == 0x15 && rdesc[62] == 0x00) {
-		/* report is missing usage mninum and maximum */
+		/* report is missing usage minimum and maximum */
 		__u8 *new_rdesc;
 		size_t new_size = *rsize + sizeof(asus_g752_fixed_rdesc);
 
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0e33fa0eb8db..d6d066c89c0b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2522,7 +2522,7 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 			/* regular effect destroyed */
 			data->effect_ids[wd->params[0]-1] = -1;
 		else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
-			/* autocenter spring destoyed */
+			/* autocenter spring destroyed */
 			data->slot_autocenter = 0;
 		break;
 	case HIDPP_FF_SET_GLOBAL_GAINS:
diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
index 83e3409d170c..f8b16a82faef 100644
--- a/drivers/hid/hid-picolcd_fb.c
+++ b/drivers/hid/hid-picolcd_fb.c
@@ -296,7 +296,7 @@ static void picolcd_fb_destroy(struct fb_info *info)
 	/* make sure no work is deferred */
 	fb_deferred_io_cleanup(info);
 
-	/* No thridparty should ever unregister our framebuffer! */
+	/* No thirdparty should ever unregister our framebuffer! */
 	WARN_ON(fbdata->picolcd != NULL);
 
 	vfree((u8 *)info->fix.smem_start);
diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 66f0675df24b..617ae240396d 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -946,7 +946,7 @@ hid_sensor_register_platform_device(struct platform_device *pdev,
 
 	memcpy(real_usage, match->luid, 4);
 
-	/* usage id are all lowcase */
+	/* usage id are all lowercase */
 	for (c = real_usage; *c != '\0'; c++)
 		*c = tolower(*c);
 
diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index bf8b633114be..6439913372a8 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -253,7 +253,7 @@ enum
 	ID_CONTROLLER_DECK_STATE = 9
 };
 
-/* String attribute idenitifiers */
+/* String attribute identifiers */
 enum {
 	ATTRIB_STR_BOARD_SERIAL,
 	ATTRIB_STR_UNIT_SERIAL,
diff --git a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
index e157863a8b25..750bfdd26ddb 100644
--- a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
+++ b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
@@ -793,7 +793,7 @@ static int load_fw_from_host(struct ishtp_cl_data *client_data)
 	if (rv < 0)
 		goto end_err_fw_release;
 
-	/* Step 3: Start ISH main firmware exeuction */
+	/* Step 3: Start ISH main firmware execution */
 
 	rv = ish_fw_start(client_data);
 	if (rv < 0)
diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
index 8a7f2f6a4f86..e61b01e9902e 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client.c
@@ -863,7 +863,7 @@ static void ipc_tx_send(void *prm)
 			/* Send ipc fragment */
 			ishtp_hdr.length = dev->mtu;
 			ishtp_hdr.msg_complete = 0;
-			/* All fregments submitted to IPC queue with no callback */
+			/* All fragments submitted to IPC queue with no callback */
 			ishtp_write_message(dev, &ishtp_hdr, pmsg);
 			cl->tx_offs += dev->mtu;
 			rem = cl_msg->send_buf.size - cl->tx_offs;
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index cb687ea7325c..956b86737b07 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1100,7 +1100,7 @@ static int usbhid_start(struct hid_device *hid)
 
 		interval = endpoint->bInterval;
 
-		/* Some vendors give fullspeed interval on highspeed devides */
+		/* Some vendors give fullspeed interval on highspeed devices */
 		if (hid->quirks & HID_QUIRK_FULLSPEED_INTERVAL &&
 		    dev->speed == USB_SPEED_HIGH) {
 			interval = fls(endpoint->bInterval*8);
-- 
2.34.1


