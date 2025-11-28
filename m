Return-Path: <linux-iio+bounces-26540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A128C91B39
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 11:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3663A83D8
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 10:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0590F30CD95;
	Fri, 28 Nov 2025 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="rZw2BNqq"
X-Original-To: linux-iio@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazhn15012040.outbound.protection.outlook.com [52.102.183.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE36E2D23BC;
	Fri, 28 Nov 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.183.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764326787; cv=fail; b=iYk6hT4mf26HNubSLq0KrDGloPBJoIX8r3zVNRCv0R2qHb+Zx9P0RRQdviuQx2I8wgVZfGNDCxoVagtj29olqrY4Cs1NsSs2ZoZVeBi3DjNhaPsJMoRwcR2RaHSWQ8SshiIq2WCdXqpt7HZmM855EhxDYB4IuDraQG8msOA5bWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764326787; c=relaxed/simple;
	bh=n+MeAouyxsmypDaSrQiupMltszJe9JdD7qLAtOJfER8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FeCmyijpqfwzqvtrBzvkSHHwSMQWHWqMRi8FNo1KqkSOOJfUYBw4gL/ZKt7jgOqX9GYqmlQgLs+1GxxuzfY9vzRUczJrf+IBtrGOyAktK+ZVboV03QVHMeCg88U/MHTMNEc/Llq8+6z+uLp1xcbkkRoW20NyL3IkgAqhNQtUvXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=rZw2BNqq; arc=fail smtp.client-ip=52.102.183.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cM10kCY4sm97edwrGMb5g9i+0x0/uyMD13+y7d6sfeCrqMwHSS//RJZFq/2Cii55nY2g3WIRtFvVyEOcN1yuxV2jnrceZrEbiwA4BEVj9aj3iF4edAbmdWzXrtsQvJ8xvPHSUiidkBBNbZayCDgZ1cHdFoMmIFA54qVDznU4JxjAulObm0xEBf2zZm5Mo7srAQtJGBrQ5NpJkryBEgHYLWxmJ1HKmC5WMMq/a0wLVGOuQ1EaGLkAmVLaCgyY8s0on4IU+LcM13ePhcWI3wNF/I4jpZnMrc/89KE89uupnrgPkXgbp9G2aReQgw0N2NMAarSl5bumDxrjdldPCOU7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUzhUFesaZZyjQ1LDBeRfhjwxsTF2f0w1MZ1LucBXYY=;
 b=uNDifYeHwCPzew5DyD4r0N/qVDgAA+nviBSXrtTjMSEyKzRvWDH70uR6bJ303eTrcordB2566+fGu9s6czPnwpqqE65KTGAEKWROEk8hWy7R42vl3vAMPRcvoTriMs0Fh7qT/sCsEHbqCPq690sqXCOd/DmEpsO1MlMS+cmKl7bGTPwyEoGjFMFyGRjiUe2gFzkx571prDAE+GVon8W5KZAvJV10tmS6zIjlrZ545KgPqc9XgF31ZEbGRDxiEEhz5SZzLWlFXIwow6/CPB6HhtP6pfW+wIZgAAvDjLhjdEs09fqE/fFeicmj+iXztvBCHqzpOXQWSU6STkpRSQCUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.2) smtp.rcpttodomain=analog.com smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUzhUFesaZZyjQ1LDBeRfhjwxsTF2f0w1MZ1LucBXYY=;
 b=rZw2BNqqSZPAz5oRhoQenn+/2+N2mLj6Qje97yUwNujZMKy2EhzN8WMTFaKqGvdW//59BCTVHmZwN59fAqp91iG+Lcuz9zYrN5AMpO7Fyy8BuKAky8+TUsvlIM+kEALTQPqWSyHM5h++GP+7BBtDRJcCzYjoid/Vz2nC/9kZ4LU=
Received: from AS4P195CA0054.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::14)
 by ZR0P278MB1075.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:54::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 10:46:23 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::8a) by AS4P195CA0054.outlook.office365.com
 (2603:10a6:20b:65a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 10:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.2)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.2 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.2; helo=ZRAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver01.de.seppmail.cloud (162.55.72.219) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Fri, 28 Nov 2025 10:46:22 +0000
Received: from hz-glue03.de.seppmail.cloud (unknown [10.11.0.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4dHqj94g1Gz4wmd;
	Fri, 28 Nov 2025 11:46:21 +0100 (CET)
Received: from hz-glue03.de.seppmail.cloud (unknown [172.18.0.3])
	by hz-glue03.de.seppmail.cloud (Postfix) with SMTP id 4dHqj942Rwz1xb2;
	Fri, 28 Nov 2025 11:46:21 +0100 (CET)
X-SEPP-Suspect: 33c37a5f5ef24a70821895a0c6030c57
Received: from hz-scan01.de.seppmail.cloud (unknown [10.11.0.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue03.de.seppmail.cloud (Postfix) with ESMTPS id 4dHqj93Fqyz1xXs;
	Fri, 28 Nov 2025 11:46:21 +0100 (CET)
Received: from hz-scan01 (localhost [127.0.0.1])
	by hz-scan01.de.seppmail.cloud (Postfix) with SMTP id 4dHqj92WFpz4HhM;
	Fri, 28 Nov 2025 11:46:21 +0100 (CET)
Received: from hz-m365gate03.de.seppmail.cloud (unknown [10.11.0.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan01.de.seppmail.cloud (Postfix) with ESMTPS;
	Fri, 28 Nov 2025 11:46:19 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010002.outbound.protection.outlook.com [40.93.85.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate03.de.seppmail.cloud (Postfix) with ESMTPS id 4dHqj42sNqz1w0b;
	Fri, 28 Nov 2025 11:46:16 +0100 (CET)
Received: from DUZPR01CA0270.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::22) by ZR3P278MB1240.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:73::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 10:46:12 +0000
Received: from DB5PEPF00014B91.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::8f) by DUZPR01CA0270.outlook.office365.com
 (2603:10a6:10:4b9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 10:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB5PEPF00014B91.mail.protection.outlook.com (10.167.8.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 10:46:11 +0000
Received: from GVAP278CU002.outbound.protection.outlook.com (40.93.86.5) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 28 Nov 2025 10:46:11 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR4P278MB1769.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Fri, 28 Nov 2025 10:46:07 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 10:46:07 +0000
Date: Fri, 28 Nov 2025 11:46:04 +0100
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: linus.walleij@linaro.org, brgl@kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	morbidrsa@gmail.com, jth@kernel.org, wim@linux-watchdog.org,
	linux@roeck-us.net, nathan@kernel.org, nsc@kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 0/2] mcb: Add modpost support for processing
 MODULE_DEVICE_TABLE
Message-ID: <aSl9bN2Yv5rib_-O@MNI-190>
References: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com>
 <CAHp75VdvJUFwFBRKT+iqwQXiK-toah3gZq6pX9Omcp6d2R7g+A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHp75VdvJUFwFBRKT+iqwQXiK-toah3gZq6pX9Omcp6d2R7g+A@mail.gmail.com>
X-ClientProxiedBy: MA2P292CA0030.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::7)
 To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|ZR4P278MB1769:EE_|DB5PEPF00014B91:EE_|ZR3P278MB1240:EE_|AM4PEPF00027A60:EE_|ZR0P278MB1075:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb9cde8-58ee-493b-07d1-08de2e6b5eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Tjl6dUxCMlNTcDVNWHpsT09xTDdZYXcvK3dQSXh2YnJIN1EzZHQvTVhPMW9x?=
 =?utf-8?B?cmNmSEo2L1NDSWltS3Vna3dYbzg5dFh0UjZ3V09uQm5xd1lzck1QQzkxSUM3?=
 =?utf-8?B?RHZkZUF3ejZKY05ZaCtRU1NCVXY4Q1Z2VG15MThvYWRhOGhYYUtOYStzckRm?=
 =?utf-8?B?RThhRVpkdnFZQ0lEVjc0TzByOTlsNmdQdkJVQm51aVF0QnRvOTNnSGVRUTNZ?=
 =?utf-8?B?TVBTK3h2aUhzN2ViTlVobGM3YnBaZEJzcmp1VmJWYjkzaThNNnM2L01MenFw?=
 =?utf-8?B?SmpaZ3VlYXRydjdRbGtMYVNOeGlLUUJUQzk4OFZZRHVtY0ZieVVzSGEzTFcr?=
 =?utf-8?B?RU9hbXNKcUlqM2Z1RWtGWnNuSGxpbmVUS25VZ2NiRnFVcFNJNnF4WkVSbEJp?=
 =?utf-8?B?OTBrSEE0RVB2Q2lzM2JKNDNiNGhOWEw3eUp3T0VNNU0xRlZJald1WUFTaHBz?=
 =?utf-8?B?MkFWYU1XNklDTGtHdHkyamViancwUitvZEJjdzFLVU9rMjI1am9rSHJYVURo?=
 =?utf-8?B?d1lBYm41enYvanpYdk00Mm0yREppVS8zek9rTC9zczRONk91QjlyWFNkQm43?=
 =?utf-8?B?TUd6ek9MbXYwdVpjYjdGNFJJRFpJSERQT3J1bitXWG9RVTU5c3M0M25XVXli?=
 =?utf-8?B?cmhrc1htc0tHS0EyZmV6VmtnNVhJMkVLV2ZBSXNON2tHenFyd28raE01VjVN?=
 =?utf-8?B?S05JUTFzRXcwWkNqVHVPSzhtcWRPUnNpK1JmZWdpUEsyUFFLbENoSnZqcWZo?=
 =?utf-8?B?akg4M0NReFZVcloyN3dhOTZIZXdpbkU0NEtQdkdxdk5DUjlFd2Y4U3NobEdU?=
 =?utf-8?B?eTJzY3MyR2NZSzZkb1ZuRWxVM09lOGU2RmpwVEIwMGtubCt4cEhqNzEzcTdY?=
 =?utf-8?B?UFNEWkp3bXgrNE95NHd5c2lEZGdveng1aHBCZHVSZUdRZDQ5bkJDK0h1ZHBH?=
 =?utf-8?B?eHEvL3RUL2JubXRsNTJUbE5yWWVxVjNkS0F2RG9PZ1hCRi9kcWRLRktiOWIz?=
 =?utf-8?B?djUzOEwzeCtqR0trdUl1dk1kdHUzc3RMUUZoQ0RTSk51ZWVWZHJJb3c4aXBW?=
 =?utf-8?B?MkV6dENCaGdEeFBaOXV6ZnFFK0M5ZDFlQmZvcHN1ZVFRd0RHMWwyL0x2VzJi?=
 =?utf-8?B?ZU5OV2ZUeE0rL2J2b2JpNlhTMnhqYi9sczMvZ3FtSjErbkVnWGxRRFlmUGoy?=
 =?utf-8?B?a0REMVVPcU5NQjI1emtFRTlKWVMyZHYyNnlqVXBhOG5hM1Zvai9sbXBMaUhl?=
 =?utf-8?B?ZHM0UEdNQk1kL2ZuUm9hYzkrTlhBU2Y5V3hsaFplYlVxZDEyNzJ4WS9rcGp4?=
 =?utf-8?B?VFl1ZUVXNkVMd0svUlIxZkdUZ1FmblAzRlYwMllkUVhCeWxnVWViczlndWxX?=
 =?utf-8?B?eHJWUGhqQTZHREVublBTWTEzQldqZFhRSm1EU3B0QjZjSVpUdVlBY1NkUTFr?=
 =?utf-8?B?QS8zWkthRDJBSnJ4SFpjUUJySkxLM0Y3S1JFdGhjNHhZSU9ETCtaanhRaHF5?=
 =?utf-8?B?aUpISjRDU2FnalZ3N3pNSmF0WTJQSFNSTDQza1gxazQ1aHpwZHZWMGZzQzNk?=
 =?utf-8?B?cVBWWU91U09Gc3dDalR5dENWeTdRRHY1WUtpSjBFU0o2Y2RzSFhMNUQ5L2ts?=
 =?utf-8?B?VTZOM1pHd2p0WU1jRnhJTlJUbE1OVktCRjByL1doc3ArRnRiYU83SEVzUnpP?=
 =?utf-8?B?YXVibWxiczN2MFN3eVBJVE5EMmRGa251SWpvZ3g0WjJSelpCZWlWQmdrbURL?=
 =?utf-8?B?TGNkc3FJaElSSlkwUmkrcW1rbTJjRGZJR1FpUjlMNzl0UU9qWG82SzRxLzZp?=
 =?utf-8?B?YytPUTMxY1F2Um45dVlBWGNRSjUvbmlOaE1sdzZXRFAyRVprWkM3MlhINWNI?=
 =?utf-8?B?ZkJkbmpOQkpMRnBQd1kyeWhkRkJhQWdUVU11MVNaamlpQnhhcmhpWG5rV0th?=
 =?utf-8?B?Q0tYN0pSTFpnQi9rdzJyV2cxNkJFTjlGdmliNjNuWXc4MGhLRFlNZWJTSjV4?=
 =?utf-8?B?UHFIVnJWQVZuKyszeEQvbkdhRm0rQnhqaTcyd2VsMFNPKzU0Uk04U1J3VzB2?=
 =?utf-8?Q?uJbazY?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1769
X-CodeTwo-MessageID: 8d596f40-1c92-45b4-a8b6-2636a7b0730c.20251128104611@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B91.eurprd02.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 cb40d7dc-50c1-4bf3-17cf-08de2e6b55be
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|14060799003|82310400026|36860700013|7416014|376014|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RWdyaXNKZGJPV1RBOTVoTkpkdEhqUW9SMW5DNHNtT09tbkNaSkhiM2FGSldD?=
 =?utf-8?B?NzYyd0NFbnBNZGFPUi92TnR5M1l4YVQ2S2lJdHVHSEhscUt3eE5IT29sM0x3?=
 =?utf-8?B?YWsxSEZJY1ZSR2JsS1BHdGk2MVpmOXFtTFEwNHNJa2JCNERlSnFsL3pzVy81?=
 =?utf-8?B?NDZveUZPdlNoU1dQWHQwZ0xGQ0Vlc3BCWmU1MkZNVytGL3JqTVlHTnl1Q3pw?=
 =?utf-8?B?ZWViLzEvVTJrN0JBQktoWU9QaWdXRUlVY3NxZlZLUktSMzFjVnpaYW1WNWoy?=
 =?utf-8?B?eUIzV2NDclR6RFJ1YysrWGg3YkpnN25RUXhOSVAxZWVwY214eC8rN2I5QmNa?=
 =?utf-8?B?STB4Yng5Y01aaXpRaXNJZS92Wk9jbm1pTVZnMCs1NFFUNWhPSUFON1BrejRZ?=
 =?utf-8?B?a1p5TlJ5OUlpOFJJN00vc1Awbm9UVkJ5VktWcVdlNWl6eURFM0hJRUdVQlZB?=
 =?utf-8?B?WjgyL2VLTjNCaVI3UWFJUWY2WnNJVnNOTCtDRkwwOGpPVHpWV0QxNGJOQis5?=
 =?utf-8?B?cmNrUDJiOGgvTExsQ08wb1VKSHI3cjBBT1QvWFFQYWVhOU9SMkZkVGZFaUhp?=
 =?utf-8?B?UkU5NlBPNU41YkM2U1FNTjhiSHV4RXJNd2pIYnlya3FzdFNEWWloME9hSllw?=
 =?utf-8?B?SzZtSXBERndGTjZ6NzYrTm5QdGFEdm5mK2ZvTjc3WVN3OVRvWWJyVlRUL2lS?=
 =?utf-8?B?alBhSkpyMnp3a1JQc25UZk05UTlXc0RCeDhHRll4TjE1L0wrcHdxZU9JZ3Bo?=
 =?utf-8?B?Yy9WWTZJbkVYWk55RmxiQUZsVjBVMFhveWhGUjJCTnFZSWpvTUFaTWQ0ZzAz?=
 =?utf-8?B?NlorS3BLZ1UybDZMTHB3VnViRGx5M2xkRFF2TDF5SURwRFhHSCtvS0dEOTcv?=
 =?utf-8?B?SEFmTE5hSFptR3RaOGo2ejRVTmxNN1ZCWDRFR0VGWERMaG4venJTaXcrN3Bk?=
 =?utf-8?B?aCtzMXRNaFlzSFY4S2JLTGdVU2c0VU12bVBtVTZIa1RRaHJrNVF1cHczVXl1?=
 =?utf-8?B?NGVmZy9zb2JHRnBCVlVrZzZDbTNmdFFXdTE5N3RpSmFxa2dGRmI0OVBJTFZO?=
 =?utf-8?B?TUhybDUzMDEzclFZNkJabU1uWndSdEFwUFFlVmtyZEhKVTZDYVl4aFlrNk8x?=
 =?utf-8?B?Mm14eEV5b3BWUWZnMlU4Q3c5RlJRR2tNM090emFLZjFTeTB3YWcwTlg5RUdv?=
 =?utf-8?B?RE9aMW9odkI4RXdrWHVzV3F1bFJ2UUZvdEF1a0Y3NVJMcWc5eUhMSzlRWDFO?=
 =?utf-8?B?cURDMXFlQ1owdy9zTmd6dEI5OHRnRzlULzRnSjhsNmgwaG1ENEZ0V1dWOUJo?=
 =?utf-8?B?MmM5TTBIaUNrbXFuQjZubzVhN2VzRVc3NFVJRWUrSTRIbExLZ3RHSDBlbWZL?=
 =?utf-8?B?TzFMcjBFWFVvL1RBcVcrQU41cDQ4WUI2ZTZGVmVaY29CK2sydmRxdzdEYmx3?=
 =?utf-8?B?WHB6aUdaT0NuOWJ5a0dmV3dwWHo5QUZlUkNVcm1DSXdKaDAvSFpPWkZLb0tq?=
 =?utf-8?B?V1Q2aDhQVWdnaEt2QkRoT2M5ejB1MTRiaDA2ZUdteFJpTWlXaXUzL3NCRDJ6?=
 =?utf-8?B?c2V3aWV2c2VlajdkMjRKTFQ0a1BmWjl4VkRjV0xTdy95RDNRNzlEMUIvaFBP?=
 =?utf-8?B?THBVdks3WXZkVDZoeUdDMVc2a25WRitwaTkzQXhCTk1DcDdvYVIxZTg5Y0E3?=
 =?utf-8?B?WmtZTGNGblVlZS9aRTNaV21Rc2dyc0hXKzl3UHR0V3JnSU0zYWVXd1dkV0dI?=
 =?utf-8?B?dHJhV2I1T3JJUEU5WFhqUHlDM1pMUjlhanZad1BVYzFiQ2ZWdkhOcTcvOTgv?=
 =?utf-8?B?QWxBT2hvUXhjU2tlRGFCQmJwb09DN1FKZldyUDlkRzZKeUZFT1VHem8zZzJS?=
 =?utf-8?B?Q3NpNzRqbkNUL211QVQxVCtoeDJwVHRmQmNGVUlnenB6Wkh3VkRGYklBWkN0?=
 =?utf-8?B?MFpVeDJwSGNhUFpubVJuS1grdU5ITU9kcnRzQlFOWHo0ejRWanM5dklaeUZQ?=
 =?utf-8?B?Ni9ONjJpODdhN1JUYmJHUHowbnp5WDJ5Z2VFUkxmVmt2M3cvNU00Qm5hMGF5?=
 =?utf-8?B?eEk5R2M0YXZEcFV0Nk93dFp0dmo0Ym9KMi9RdmdHczBaUXFvcGZDQXE3bnlk?=
 =?utf-8?Q?cZo8=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(36860700013)(7416014)(376014)(1800799024)(35042699022);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1240
X-SEPP-CCCVersion: 2025-11-05T14:36:24+01:00 6c313bee
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.2];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.2];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b5ff5826-9b3b-46c1-441d-08de2e6b590c
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|34020700016|156008|36860700013|376014|7416014|82310400026|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHdrWFRNeHFZY3RDQVlsS0U0a25IWmtZYlMzOHRrRjRyWW5LWGlsR01jOUJE?=
 =?utf-8?B?MDNPNTNDVlBITU41UU5YK2t0M2RpVVJyWGp4ckJVS0hSeTQydDRBY2ZYb1gv?=
 =?utf-8?B?NzVXbGI4UkZDYzFFbnR6VmdOVERyOHRLVW5ocXV1UHRTQUxNOHBDTnZZekll?=
 =?utf-8?B?NjRTc0dkNHc0TzVzN3hycGZteXpDbkUzWXkzemtYT2tsYm1XYUU3V3YwVnJl?=
 =?utf-8?B?NHN5WUtKWE9hMFVJRStZazJBVU1YWUlDVzVzdDRJOEVkWXJSblVBRGpDK3hl?=
 =?utf-8?B?WThLZFZuRjJvQzFIaUxQbjBKNmNHQTRLN2NnMXNxMXRPTXc2bXhjMVNHY202?=
 =?utf-8?B?a2ZUaGd3eis3R24wR2lyZ0VKaUczVWtEQm1KaFJTNVFsTk5ISmF3YWhld3da?=
 =?utf-8?B?QUtnVDJJdzh4M21BK0g5c1g2UjgvU2dpMUhtZTlQaWwvYU9vSUU1Z3FLY0k1?=
 =?utf-8?B?V2ZMTnV4cFFDdFdaTVNCS3d4NjlGTGxqWmtybS9Lenl2YmpiZzc2QWF4dkpG?=
 =?utf-8?B?ZUlXZlh1MHByNXd0amlVWDVCWFByNFlHV0lTdDRTS0dzVjJJd1N5ZmZaSjdl?=
 =?utf-8?B?ZHVxdVlTaTdKaHBGSlV5T2Q0eWQ5dFhVQi9sWG1POS9Hamw4VVFNWWpSWUxP?=
 =?utf-8?B?YmlNSWJHbG04d0x5U2FMZWFRQnZZYkszei9VdHFrQUcyU0FPWXJVbHNnWXFB?=
 =?utf-8?B?YXkzd2tzY2c0R2Mya1VyYUFUTjF1UXVMSU94czRnT29VZmFyMnJ6V1FtNnh3?=
 =?utf-8?B?U0o2UDZwMUZIOXJmU05PRWtEUVZNUDgyclRDTWlVamNSZkp1QlFZTXhoQmli?=
 =?utf-8?B?elhFeThPRUExTldSWEFqb1ZEVXJkR0QydThJd1dVM0VFVEswL1BzV0pwSk9W?=
 =?utf-8?B?czVqeVVPbXdmcE5YZjFKQzV1K2kxTU8vOG5wVHQ0bkZqWVZVREFiTzRkMk5F?=
 =?utf-8?B?NXd4ci9pa0pWN24zYVZ1ZEZ1b0phTVlOcytUYWF0SENDcm11d05MY1Qxaml4?=
 =?utf-8?B?c3FHOEdIWXd0SFB5bDRiZWorelhqRTdjYmpKNXJ5dS9XcUxMTnBtQlhrbytu?=
 =?utf-8?B?STkvQmpUejhwNXdQYVorSGJZYkd6dXN1MERra0RCU3dkdG8rMmNtZlVYVmZF?=
 =?utf-8?B?dC81bFZUQkpld2xua25WMlhNRWxUZG80ZEU0VTdBNXJ3RzVSaDUwL25MQmJF?=
 =?utf-8?B?OWVURzhyczJjWDh0bGhPRkNidk04bVlQemtQOUJRZHgxQ296ZW9McUptRXAr?=
 =?utf-8?B?NzFaZGNReHZkR1RNNXdUZ2JBd2RPNTZpL1FvVXJ3bDlwZ1ZSY3ZPWTd5bHR2?=
 =?utf-8?B?cHY4UnFBV3ljUXVocS9FRDB6Y2dCN2lwYkhPRm94VVp2RWVsV2h2QTlFUVY2?=
 =?utf-8?B?U2xhaEJ4emhSZS9DOGZFa0h6OTB4VEMvSFMzWlp6N1J2ZWRRMmR3d1Bmdndh?=
 =?utf-8?B?QWU5eFFxWjdxeDBkbDd3YWdjYjdYd3Vka1RjNyt5WlNTR05FTlAwZWVwaGlQ?=
 =?utf-8?Q?elWKJi6b6fwrq7EIkzj1AHLAaW/?=
X-Forefront-Antispam-Report:
	CIP:162.55.72.219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17010002.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(34020700016)(156008)(36860700013)(376014)(7416014)(82310400026)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 10:46:22.1532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb9cde8-58ee-493b-07d1-08de2e6b5eef
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[162.55.72.219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1075

On Thu, Nov 27, 2025 at 06:16:03PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 27, 2025 at 5:56=E2=80=AFPM Jose Javier Rodriguez Barbarin
> <dev-josejavier.rodriguez@duagon.com> wrote:
> >
> > During the process of update of one of the device drivers that are part=
 of
> > mcb bus (gpio-menz127.c),
>=20
> > one maintainer of the GPIO subsystem
>=20
> Krzysztof? Did I miss something and he is now a (co)maintainer here?
>=20

I'm sorry, it's my fault, I confused the person who answered me the first t=
ime=20
with one of the maintainers. Krzysztof and Linus both answered me.

> > asked me
> > why I was adding new MODULE_ALIAS when I also added the same new
> > information on MODULE_DEVICE_TABLE.
> >
> > You can find the messages here:
> >
> > https://lore.kernel.org/linux-gpio/80a20b13-7c6a-4483-9741-568424f957ef=
@kernel.org/
> >
> > After a deeper analysis, I came across that the mcb_table_id defined in=
side
> > MODULE_DEVICE_TABLE on all device drivers was being ignored as modpost =
was
> > not processing the mcb MODULE_DEVICE_TABLE entries. For this reason, fo=
rmer
> > contributors were using MODULE_ALIAS for enabling mcb to autoload the
> > device drivers.
> >
> > My proposal with these changes is to complete the mcb bus by adding
> > modpost support for processing mcb MODULE_DEVICE_TABLE and removing
> > MODULE_ALIAS from all device drivers as they are no longer needed.
> >
> > Jose Javier Rodriguez Barbarin (2):
> >   mcb: Add missing modpost build support
> >   mcb: Remove MODULE_ALIAS from all mcb client drivers
> >
> >  drivers/gpio/gpio-menz127.c            | 1 -
> >  drivers/iio/adc/men_z188_adc.c         | 1 -
> >  drivers/tty/serial/8250/8250_men_mcb.c | 3 ---
> >  drivers/tty/serial/men_z135_uart.c     | 1 -
> >  drivers/watchdog/menz69_wdt.c          | 1 -
> >  scripts/mod/devicetable-offsets.c      | 3 +++
> >  scripts/mod/file2alias.c               | 9 +++++++++
> >  7 files changed, 12 insertions(+), 7 deletions(-)
> >
> > --
> > 2.51.1
>=20
>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

Thanks for you review, I will send a V2 following your suggestions.

Regards,

Javier Rodriguez.

