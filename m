Return-Path: <linux-iio+bounces-12239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 124CA9C85DF
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 10:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7DB8B2B5F4
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 09:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1CD29CFB;
	Thu, 14 Nov 2024 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=l2task.onmicrosoft.com header.i=@l2task.onmicrosoft.com header.b="dIpF9piX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=l2task.onmicrosoft.com header.i=@l2task.onmicrosoft.com header.b="RVot6/zl";
	dkim=pass (2048-bit key) header.d=aerq.com header.i=@aerq.com header.b="Q1tIsWi5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx-relay05-hz2.antispameurope.com (mx-relay05-hz2.antispameurope.com [83.246.65.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5F1EBFE1
	for <linux-iio@vger.kernel.org>; Thu, 14 Nov 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=83.246.65.91
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575711; cv=fail; b=PvH3ZSb7oSiguGQXmIJjuOypnpG6uuY0i0MwhQu0O9flYpVuH3u6Gou/kl0S+P6B7Ah/qE4mftLiOkG1sETNVdV7UAOJsLQhvF/NWvzEz+FowdGBH+0AkhD5+wshLfcJlzrU2keWnY+TAor0uNL1aITAZNdIu4jq8wRac/WscXs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575711; c=relaxed/simple;
	bh=WHitiLunqmaAYTiTMlQMQq2NoD7zWwnW/W8HTAMI048=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdtTRKyFB51QxcnjqyXdhbT3rkxIVLf+sr9aGnQmcusAEKTUYwM5Iu5OdcSW3yn3KGahPVITxKPUQLW0cC+WREXZnu4YpKicWPf601farwSRZ/A4HSTKDkiuNEJ9D5R88ldRAJoTnGwIaUwKDHcNC3QtgwSWNPQFAv35LjjvzoA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerq.com; spf=pass smtp.mailfrom=aerq.com; dkim=fail (1024-bit key) header.d=l2task.onmicrosoft.com header.i=@l2task.onmicrosoft.com header.b=dIpF9piX reason="signature verification failed"; dkim=fail (1024-bit key) header.d=l2task.onmicrosoft.com header.i=@l2task.onmicrosoft.com header.b=RVot6/zl reason="signature verification failed"; dkim=pass (2048-bit key) header.d=aerq.com header.i=@aerq.com header.b=Q1tIsWi5; arc=fail smtp.client-ip=83.246.65.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerq.com
Received: from mail-am6eur05lp2111.outbound.protection.outlook.com ([104.47.18.111]) by mx-relay05-hz2.antispameurope.com;
 Thu, 14 Nov 2024 10:14:13 +0100
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=fail;
 b=E3Lk4fsOpd4On4ifp59lMkhky31h5l+xFociXtXHiCjDJe4lCGwR9uFXWZ1t+gmnAI3B5OKLhOD7J3FxfuHSiJoWMe2Php26ai742tLwCXkuYkF+ULJxVw4gf/wPQFhHBi0lmMlFWFOsAdOIAjXb2QTiiDvg938ehuntI+wHKekpov0ub6rKfiYmhUrybIC8gtR4fQKwI5oVzjQR6B9nvgtcoJEJvdQQ71caskgGVEIBtNEDeGr7ruBISFTKeBNUHRt2PpbzwxZMzE/eNQMDpNYc5kbJ0aLCWfbfMmtXoXv8bSqrl2cCX5X66OBcAwf/DKARawHEoXI2sFtj2uZCrg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nH7tTN3dzuqoCsQIiaoafGQIN6jIQfcUsFjJLpPXM5k=;
 b=ltQbLjlugGd2g2amUUIuljvXysX2C4NiV6J2/XhobVqRTyVgICV6AHkTxHGBaZfCGn+BqDE3+hnCPN4ZYEMuSfIMYIcxSeP2/5//8cCV5z7nYP4RTASPNviphVciDBLMf+LSNQ1lubf2V1FNGbc/Y9n0vLZJSeNagzpNa8688DTvKm/0c/XygUAJhw+wYBU5l3sW1m9sZmhXSmXihsb9PeeHSg/oiYTWbSzgMSaPBLHm40hYpEDSDoFzUJoZf/wS14FprPAH8HT3UnoXcTWdzYDmLq3uxl1UUeiTWEhAeFXXIguGHIZDqyZrJJZqxv8CW+WwkynRr7h/Cq6DUwgaqw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.40.229.156) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=aerq.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=aerq.com; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nH7tTN3dzuqoCsQIiaoafGQIN6jIQfcUsFjJLpPXM5k=;
 b=dIpF9piX9IM7q50Xhv+cTTN2fU2COSATrlU1q+e1jEIz7eyBjyVJqcEEGYQn54z/elrtFs+tSQnwnmh24bpCY+RDw2KDaj/RMZaqzEJHN1s23N1E8j9iV1AjVgeDt98gMNhHteKIVG0e2U4QWKHSdYw6d9LtF6WLk6TBXQ4MbQc=
Received: from DU2PR04CA0223.eurprd04.prod.outlook.com (2603:10a6:10:2b1::18)
 by DB9PR10MB5355.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:337::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 09:13:57 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::83) by DU2PR04CA0223.outlook.office365.com
 (2603:10a6:10:2b1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Thu, 14 Nov 2024 09:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.40.229.156) smtp.mailfrom=aerq.com; dkim=fail (body hash did not verify)
 header.d=l2task.onmicrosoft.com;dmarc=fail action=quarantine
 header.from=aerq.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 aerq.com discourages use of 104.40.229.156 as permitted sender)
Received: from eu1.smtp.exclaimer.net (104.40.229.156) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 09:13:56 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
	 (::ffff:104.47.17.111) by eu1.smtp.exclaimer.net (104.40.229.156) with
	 Exclaimer Signature Manager ESMTP Proxy eu1.smtp.exclaimer.net
	 (tlsversion=TLS12, tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Thu, 14
	 Nov 2024 09:13:56 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 5352337
X-ExclaimerImprintLatency: 602823
X-ExclaimerImprintAction: 30785a606d2244cc9bdaa18a19959d06
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Orfgb9bQLYM/KWY5Ffm9IrMOYA4pmyFdNNbleQ+Xxs6/AwELCxnwte/I2AmE71XclBONf2+qSaZFoBZWCM5xS6lFE/Jo623YMP6LxvBxvyBfEfFI4vphwVgZ6Na4tleusYMoZotaksOa8DJKoDhZr1ORO7bln6ktUssq21JU3aiRBUwZ6HKx1/mPih841XZjtVU7Ted4v5dAtncOD/opQEJF4NmwA26Fbb4vHjLDoN4SuHn+ev2gTlimwwMtKqm2hJUhQiDyqNlDE5mYh0lZtbCuhwQjrmr+sfjk0XjV+/93Fr8JdQPyW1B7zul4mhiac+99QCmk4uu71aYgGpE+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1wqXWLVUrncwLbTQVq4BGpJG+4BhDAmgYFnRAMOzn4=;
 b=Fq8myZvaXb3ksw+JJdREYaAqTPA27hE4wold0H7YefuKtu6Y+pmzmKSFrB8hV3BiyJu02gklJjREoB8ve7+GPcTriPqfOq3A9kbtGuP1CeeXS4WT44nw3z9n/++sVMPaDBc49288CO33E358tYBAGMtZd15pqztIhck6JJUsMz4hkVDYKDouyjqrU8laaKNdI2nfYIfzudBkMiuYQRX71AU1rL/R6hVQooffHnIchI+EjJ2PyM2Gbuf2Xbodi3CJvwLSZPSDmK6IL+MysgvvnlU95CR2M2iPJOIoLUIIcLJ28nTv9DgbYOifKs42G+bozj2z/ZbvqsoehnO/vC8VNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1wqXWLVUrncwLbTQVq4BGpJG+4BhDAmgYFnRAMOzn4=;
 b=RVot6/zli6FvV6uvhAV5/d0e/n0o+xkmsKv38VU1xjVa7zwThyC8kwNp5qfKVMYuGVrnJ2WvtO8Y2Al/r4PpXdxSYac1jiPLVXa9piZZUaUDME1CRUk4FfIltPHlF2olMugc2d0wvaHDA7FNTh1SvyXRVxvrrvP/PYb0AJaWLiI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aerq.com;
Received: from DB9PR10MB7291.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45d::9)
 by PA2PR10MB8602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 09:13:52 +0000
Received: from DB9PR10MB7291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8c9c:7279:978a:f67d]) by DB9PR10MB7291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8c9c:7279:978a:f67d%5]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 09:13:51 +0000
From: Cibil Pankiras <cibil.pankiras@aerq.com>
To: linux-iio@vger.kernel.org
CC: Cibil Pankiras <cibil.pankiras@aerq.com>,
	Kevin Tsai <ktsai@capellamicro.com>
Subject: [PATCH] iio: light: cm3232: Reset before reading HW ID
Date: Thu, 14 Nov 2024 10:13:23 +0100
Message-ID: <20241114091323.7415-1-cibil.pankiras@aerq.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To DB9PR10MB7291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45d::9)
X-MS-TrafficTypeDiagnostic: 
	DB9PR10MB7291:EE_|PA2PR10MB8602:EE_|DB1PEPF000509EF:EE_|DB9PR10MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6f3ee4-fd6f-4d46-3c6f-08dd048cab09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original: 
 =?us-ascii?Q?bVRNCLzX5Y+qI+hLn24HVLqXV3KoV16aScucZeL3wu/pqe1Rwu2wwN4cxPjJ?=
 =?us-ascii?Q?+DeGPQTmFahEqvl03Eoyo0Qz0eaBf+mR9ZF37lrWoFIJ4eeZaKwpYDVDgK5T?=
 =?us-ascii?Q?9JBeT9BPg9GMii7Rr8LE+UypJXyR5+c0xPRJUpUaXRTbXWMih+1Dg7XetfSi?=
 =?us-ascii?Q?SCkSKQHQ7dpEGX+K3z1Khxb835QEBea9hvLeNW8aK+QN4Rp5K0bcNX9SON13?=
 =?us-ascii?Q?FMYcj1bq/5ovgadQww/2LlRL5Xh2hanUOSGHXg3sdlXbKzBY0EcyF6nmU9eo?=
 =?us-ascii?Q?HCiQ+XCJLlrfgJxKdsBNEcMjGcx0pA+4CnWoPC4aqbv7uLT3VvvIpjTGrB9c?=
 =?us-ascii?Q?XTKjm73dxPFBEkake842FW3ZT2owkm911OQR8qlILROktm4NYSvPdvgRPG8V?=
 =?us-ascii?Q?7Fb+iwXqmWd6HS3p+wD8Z0y2dvUOWmfb/DSK3ZgWMbpB7ye3auQYc5PufCn+?=
 =?us-ascii?Q?i0aXkGkgLrTXijMnLBeWAk25CsFGSpnwmrICzoK+Zntf1PSqk8xyOrpj2v+y?=
 =?us-ascii?Q?X7g662nIxGWIBcV6IW4b9/rzidgVZwmXRsdaAJujdGGcFwQUMlvoCQkhYxZo?=
 =?us-ascii?Q?9gXqZTCXIx7K1V3UC7TbO3BIGRI3fTr07F9Wy6ST+74IOIsAWQ8R5SUhIZeG?=
 =?us-ascii?Q?PSk9BGpVvpSv9IlHMDs7M07PqJ/8EUf2F2jqQJj7TcLECQQY+FrpOOaqTfVB?=
 =?us-ascii?Q?0XzhJwnNtnpvyOb7T3gtJ1lbM91CvAL7VZTOSJXpSqWAakJ1h7TT7lTxYd35?=
 =?us-ascii?Q?SrP5uhQzAWJLB71FHlB9VbepTELm6ggiEtoQJIA2FMcKWTfY7ukBBvIS0UVR?=
 =?us-ascii?Q?LIHsvszL1ab+byf9b6s7I1A6AelJ6esHTp86ZAVpsVr7ZEooLSbYCegaI5BG?=
 =?us-ascii?Q?w8uljTaEUpZJkDasxF3V6NzFzHGxfRPxg01eMZ5SeRUsU1LRaqHmBJjc19rw?=
 =?us-ascii?Q?nXMTn3sVY3HZJBca+y02tQsg6AqAQU1Xe5jq05Z3QwJf+2u/lxQTks4RfLcU?=
 =?us-ascii?Q?mVufq0jrW1EU2JtafLLxWZXeRfnDK0MjhpwRRkUA52We3cHAN/FvwvdB2CHk?=
 =?us-ascii?Q?Ry6R46cGjPZAPKWaScmehLImI6TkVTqr1iFI9O+GpQwzk6JP8VFy9NunlCvX?=
 =?us-ascii?Q?ghin4pEjaGFEn2h29H9RVqwUEvNDNNHhF1Fo6gYcQdnp/A4jiWBdNky46X8E?=
 =?us-ascii?Q?kzpHg5WEXLx7npzniKCNrlEgSLknt1e7bFmwT6SPvVz7xI1IFsCV/JGLw2Tw?=
 =?us-ascii?Q?0t5gsHRTcsPFJVgOPLXjRkv0E9NGcGqTJzznCnnj+etLanf64Z17l8hueHbS?=
 =?us-ascii?Q?7xUJHYIx888IpFWaLXi6RxYUmTnif6gmvxJFjU/mS9/jQNZx1lrAOSER0SKD?=
 =?us-ascii?Q?ZW0rcls=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8602
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	c2e069d3-ba9e-46e7-b772-08dd048ca7cd
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|14060799003|35042699022|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?I3rjVCCRXzfqTFRUKTASnON9Iw5PeyfeHjnXQOxK0supclpudkIyARzNy2Ef?=
 =?us-ascii?Q?hu8hRY8EYAyElO//ciideajWAZ4VaTvUzpa6om8DH2ZbKUqAQ38DmRRhxrr4?=
 =?us-ascii?Q?kAO7vyNKbi/zMfie1dOQrbMd528JSYtn711TgjYlYnpgrszaHZrwXNlEAs8d?=
 =?us-ascii?Q?EZwRWmt1wMf60OYrBgTntyhUeVKXUZgR02J0g4rOVgPfEpCMVO9bTFzzIroW?=
 =?us-ascii?Q?2lPrFVmKhWD3Wl7dtQ8Mj4AZ7sEXJNM//ys/xabZ40H3pwOSB2xEgKqQcVi5?=
 =?us-ascii?Q?cdpeUmIBUWqMigS+Y/loLl0znRb23y3wwprMp1gQQ+C0FRWVa3/72ET1QL+N?=
 =?us-ascii?Q?GYnH39AIM3fcliFYaP+VvPAmnRQ9RGDov3F5tasXKeOWweiMcAyrUNnLvo76?=
 =?us-ascii?Q?baNorV33xAzy7FQKrpbZJiIP+y7/oYdBnQqZz5i2wFxYgINqBYNGb7FOnYZQ?=
 =?us-ascii?Q?4GsreBG9a6SAEPIx+19LAtuSrV/WaVlsGFC57Xv5rPvswt56Blsg7lG+MIJm?=
 =?us-ascii?Q?i6p1cAIirkpg5IY0feYaVrHsuoOJ9+wCULOiA8x7WHrPkh+Yv3IBeXDJoQyz?=
 =?us-ascii?Q?GwMQiGzFz0SzAvXfVKQdh8fQtO8BEm3KVV5s63C3sOCbpvf1wojIsXSxHaYY?=
 =?us-ascii?Q?LBJjEauIbseajRvNbx/LZlqIiM0en0p5U/FAzQgde3QLM9+QBq9lgfCWSqvw?=
 =?us-ascii?Q?2oB33vAJ6JaS0lwBHQPgs7GUYurTRsl1U72AKy6V+cgjPbxAL1H70IsDLHNs?=
 =?us-ascii?Q?1fKEtO7Z5gCt4YszbPW4ZdKXUlXoNP4JxtDiJR3mJvkQ2+O5pFj0vMqIkf1o?=
 =?us-ascii?Q?vb48mVUhLRY6txIn0G+XFTXTq/vM7QIuRgRjFlfBwmWatMFOOBJaI36h941X?=
 =?us-ascii?Q?kztS973WTzFFx5Zm4xiVi2L9SWd2GsAasSPmqCTusENTgBNBJSoYf/34qYNt?=
 =?us-ascii?Q?8fPRt2P4lCMydcvxiYy5HRvvv9StUhTKbHDiSe6iPYXP8FOP+Yo8dqwG5n+I?=
 =?us-ascii?Q?cvm2nCKTzuo0hIfpE4OtgZ25SucAu4tBrNii3nExiDV0HbPcWS/b0fej8U9b?=
 =?us-ascii?Q?jIPl//Ci3QHYjtWPgxrHZ6iMLgLSPDtQXY2KnuDVv7AM8BXhibDT+Wu/ASm1?=
 =?us-ascii?Q?HbL7zpiaAN3QwQRO7ZHDlemlr7CMmhOs65tFNvEK16/NMRy981lKs7OVPccE?=
 =?us-ascii?Q?oZkXN8NMq9Zs/3PgmUJsFXOVOA/XY5Uu4YtvmfEMD3Dx4FwV9ctXWtyeD/Gc?=
 =?us-ascii?Q?hZwGpMhsCKH71ua/pfY2eO0MnVRLTGJOw2hZSO/3MGlAV/X5YWuKCaGg6Ij3?=
 =?us-ascii?Q?b89mU6rQabvsBXn4UmJxM8mSjyJezRdeNUVbevM8hKZj+MTUZeon77SLRu3S?=
 =?us-ascii?Q?2HG1QhXRyMymxMf4lZaWX67nw1vvQ8QCvVTZljs7Mec4Vtx29w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:104.40.229.156;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu1.smtp.exclaimer.net;PTR:eu1.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 09:13:56.6201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6f3ee4-fd6f-4d46-3c6f-08dd048cab09
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[104.40.229.156];Helo=[eu1.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5355
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----3DC3AB178CE4A5BE3C94A3B77B5C26F0"
X-cloud-security-sender:cibil.pankiras@aerq.com
X-cloud-security-recipient:linux-iio@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: cibil.pankiras@aerq.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay05-hz2.antispameurope.com with 4XpvbX3t53z1LJgx
X-cloud-security-connect: mail-am6eur05lp2111.outbound.protection.outlook.com[104.47.18.111], TLS=1, IP=104.47.18.111
X-cloud-security-Digest:10456cff531a692551c9ff408f97c3d7
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:2.741
DKIM-Signature: a=rsa-sha256;
 bh=bNsMuKnkBVZSVcMH3IVnVUiFRrm6p1iw1t5ZBXEFmyo=; c=relaxed/relaxed;
 d=aerq.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1731575652; v=1;
 b=Q1tIsWi5IqjNVC+5IgYNwDZrNYfZhJ8hwd9QT00sqkijRQXMxvRSGLdczRUfDYT5R9seUOpy
 Yp57DX1VfEs3ovQBzi83LnbACbKLk3dMuOulX16RnG5+F13dl0S2VfpomkUUgT/6uC71ed8JQat
 gFxHMhOE5CQcAiG4TCkcYIb/SqM6h0iBAcwnhWvHANYpmJSzSn+FzhlX+KAGH+Nig40JUJqwXm1
 SdT+Z02VLZFDNOroPl4XNYp2ge7OzDTVt0BDsLqSjS0gAlk24WlOqSK+pRwyUiMnbklq+Oojh5S
 9mwATrGZRU9fFbBOxjoXnmmRMcGa3/0aEUIRo3Unj+l3g==

This is an S/MIME signed message

------3DC3AB178CE4A5BE3C94A3B77B5C26F0
To: linux-iio@vger.kernel.org
CC: Cibil Pankiras <cibil.pankiras@aerq.com>,
	Kevin Tsai <ktsai@capellamicro.com>
Subject: [PATCH] iio: light: cm3232: Reset before reading HW ID
Date: Thu, 14 Nov 2024 10:13:23 +0100
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
MIME-Version: 1.0

According to the datasheet, the chip requires a reset before any data
can be read. This commit moves the device identification logic to
occur after the reset to ensure proper initialization.

Cc: Kevin Tsai <ktsai@capellamicro.com>
Signed-off-by: Cibil Pankiras <cibil.pankiras@aerq.com>
---
 drivers/iio/light/cm3232.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index b6288dd25bbf..5b00ad2a014e 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -89,6 +89,15 @@ static int cm3232_reg_init(struct cm3232_chip *chip)
=20
 	chip->als_info =3D &cm3232_als_info_default;
=20
+	/* Disable and reset device */
+	chip->regs_cmd =3D CM3232_CMD_ALS_DISABLE | CM3232_CMD_ALS_RESET;
+	ret =3D i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
+					chip->regs_cmd);
+	if (ret < 0) {
+		dev_err(&chip->client->dev, "Error writing reg_cmd\n");
+		return ret;
+	}
+
 	/* Identify device */
 	ret =3D i2c_smbus_read_word_data(client, CM3232_REG_ADDR_ID);
 	if (ret < 0) {
@@ -99,15 +108,6 @@ static int cm3232_reg_init(struct cm3232_chip *chip)
 	if ((ret & 0xFF) !=3D chip->als_info->hw_id)
 		return -ENODEV;
=20
-	/* Disable and reset device */
-	chip->regs_cmd =3D CM3232_CMD_ALS_DISABLE | CM3232_CMD_ALS_RESET;
-	ret =3D i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
-					chip->regs_cmd);
-	if (ret < 0) {
-		dev_err(&chip->client->dev, "Error writing reg_cmd\n");
-		return ret;
-	}
-
 	/* Register default value */
 	chip->regs_cmd =3D chip->als_info->regs_cmd_default;
=20
--=20
2.34.1

------3DC3AB178CE4A5BE3C94A3B77B5C26F0
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQLwYJKoZIhvcNAQcCoIIQIDCCEBwCAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw0MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYcMIIFBKADAgECAhEA
9Gd2dWqooci+mODZrEp3jjANBgkqhkiG9w0BAQsFADCBljELMAkGA1UEBhMCR0Ix
GzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEY
MBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBD
bGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0yMjEy
MDUwMDAwMDBaFw0yNTEyMDQyMzU5NTlaMCgxJjAkBgkqhkiG9w0BCQEWF2NpYmls
LnBhbmtpcmFzQGFlcnEuY29tMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKC
AgEA3KjVoDjwt7dzo2kYHmDSJF56s8Qic8T678jVaiU59HU6HTd82J1O/fVSgvcC
MEtfME/o9DnBrSo9gekpSu6xzPQ9J5BzcHARX8q8jSckqGmRuB8BiBXt/37/86wJ
KFiBxwpYmvndg34Yy6nJ5ZFSIbORUuCqLvxOgFCpuhTl61h78hXQiDzt8j7J01tG
dVlXxuD8aRfx9TBEAWIpDZZAKwyc52G9OwSGloMs9XTS80YBsodR9IFHbnun2ehi
12Ckxjn2kkeIaYO1Ho2XpJefNG19cgBKxvvunlxRWS9Cfe5NprKM5ET2ZNXfGQRD
Vn23XHd+j+1QXphy506Pq7fzaRytAKwRFp/rqTyDL6636CH+j/1dl2G85a3CLefI
FL1XUQBQrQEgFKg2A+MzGspG3FUCHgm5KAZ07HMJUQ9mH75ICezyzJZmqPlPl+dK
sdCCWj4aLLs3IpM59oO50EcPu1/vao5SnVIeKZFriMPkvSqb5+YO2YnSm1O2xuQs
m/BudFjdyRVDytv+kJYpQtBboFUsAtZYctvHMcCLjw2aW62vFx9u0MhYbEYCQMcy
Axz6/UMUQd248D9oDpaH2KK360i7MJXLLN/EPPhkQoBKFLAC2JuqpKORH/iPkKL7
5DRVVJyJPL5qxSmnIT08Od9/nB+e+iRuVY7PLDr5V3Ic7MkCAwEAAaOCAdAwggHM
MB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBQcj6s6
KDLo2jTzIh9RYgJhxClrejAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAd
BgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1BgwrBgEE
AbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMw
WgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdv
UlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBigYI
KwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28uY29t
L1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0Eu
Y3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAiBgNVHREE
GzAZgRdjaWJpbC5wYW5raXJhc0BhZXJxLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEA
Ey4wNfZFPxgodEZLXjkWw5S0iqqnhkPcYYvGaovLdu9F4sviuMGlFYrWNRiGPh4m
gNPaRziZkQm3y64c9FAqLLLBF4zc0Tex1Em2Sj/zkbDWfmu3rzpY0pKVI9KsxmWo
Z11GTnLlZCDXuHGOmDH6pqf0iH6oVtJH72rh+/7BC7SmhwcaWLHaoL3If1YbrZME
jIB6SBxqKawe3fRum1KCeShTgrzhvQWAJQ5kLjOz/S6EqzxfEicTJok2Tdr8ITZE
6tfXDqUzu1XPu/d8UiuiT11Rt56HnDpMMsLejku5Fkxs2/0TkD3fL/wCpN8qMfbP
PGftGM+v58FTSBlbWrOObDGCA78wggO7AgEBMIGsMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA9Gd2dWqo
oci+mODZrEp3jjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDExMTQwOTE0MDlaMC8GCSqGSIb3DQEJ
BDEiBCD3o0VaIleoCEYb96ta0SiI55u4dVtQZEHbw4gQTABcUTB5BgkqhkiG9w0B
CQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoG
CCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMC
BzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgC9RBCdGc8XxN4Hug2m
AmWsjBqYf+oQoTaVVtWQsVtbQeONS0YwPx2exnwOzXXLy3yBhxMJrpQi/M932TIi
H2exRKkrofEpj1N66nD3H8AbIQCMh0j8+POzDM5kxmTNpE9bdnzbTYTTOtlmjq8n
pJ2flK0yyontvRDrh9VmR5rVAV+PZurX4cRYPcsgY3Y53krA8m7SkORTPh1fcye/
I9TMElUfKmPBMjuPABSh+Pmt+gZw8Jv9KyzdZKYXDVERmECBSMyKNngMvLzL2any
HmhcBAb0whGDbOT4QXi6t4dYXR+zO/v9QXs8VG/bbiPE9PgvlfNPDVm9DPQ6+JFT
KTBCUpDEA/tCER7Jvyd8sZcW6Y8QQcRGoLOCcCCDgMOeyqhVHHHUrSwkArQZHy2T
/vN3p4ZIc95ffCqzKMeA1NQ+FaB99PpBnNDdgI6V+CV+VsDIoqqY6FeAjWux30zI
0VvbtNdmEhIzTXgNs22pWnLP6qjlpHc2noszYOaMOLkADyAMMgMIm7oF36034LBB
R2Sgk2/D7SmkJi7NnTjB2ffDGSVKxpdmmor4iAq8qzGjmPWztiEBCz1apTh2e6rG
2mcsEHKRt/nAbj/ztDHsZB6DgS+b4Z+EA7+/vSAV5ILTDEWiJYwfX5XO0bMOfJN7
fSrfdC+zsblphIHHjrYbthU6Tg==

------3DC3AB178CE4A5BE3C94A3B77B5C26F0--


