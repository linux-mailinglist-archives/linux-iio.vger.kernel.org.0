Return-Path: <linux-iio+bounces-5051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2348C5C45
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 22:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF00281246
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E423418133B;
	Tue, 14 May 2024 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NqubrGrG"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2047.outbound.protection.outlook.com [40.92.19.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D5180A96;
	Tue, 14 May 2024 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718368; cv=fail; b=UuJE4CS9N2XA9Wnijw2zoLU+h8YAJQlq7xKya7S+TOKr0gRHK9oW5ob4yglVIpeuICLilREnEtcf8jPwrH2Cl8lTTPcExtyJJmHPj23pLDYwwM8RVbH6tQ0xa1swrzUPZ7uRNdE8mhRSt4P7y/akorNmUrKte3rUSpQwGj7gcyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718368; c=relaxed/simple;
	bh=e/smU/HcWqJFZ10FDBDYnH4qUB/rFmvK70SDxSFDg0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=noCcmWQuX75OBNYEV7xnTrttHjppQGGWuy7raw4cZFmxyCAstZfzW18+l7SW0qK8BzoCE0usK+q8eegvFIFIC94EPfVMm9dj2Sm2vaKzP3OJGxYRxMN73mPU18QHdtiVhtQfziVEh1o6EjQKY7Zq/MKOWCp23sSa3VsELN9Il/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NqubrGrG; arc=fail smtp.client-ip=40.92.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEe/+AioJ0np9p8+m6KfpJR84815BAbBI3rB/gUv5FTMmUb3wnAtLBWgNK4XIGl6DfiTbBaK+zJZ3YyJPlHoYNAh85G4fq5tIqEWZ/h5kNv2d4KbKoTUZs3Eaz9EpqH9ACF5xv1NGJqK3JLiRBuA5dBn7jy9zSoSRJlQ47e+MaPEWdh3vcwvqARprKUtcAGyb8njSNSpAoNBi7hiuogKym/uMy9aXT/X8Ds7bcohBjrx7OzgeVL89jKOaTebJzdvKWIWClI/z9p8jV+dftf4tSHChinxDWsecIF1HPZIaWU9Vgfie5Oe6qndVWLZVaKfK0NC+jgdiFbfQmDMDqoc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8FTMCgR5bL7cCGra8j3tjswemPwridZJjjBPKPH0Ws=;
 b=gqVUVlgcAfqszVg1zcLs3sZYuJ5zC3bRaQnG+tvJQztcDJ+cfwnIJMPYMbn2KbqgGGzTOHBli9xD9ArAFxozoI2BQLZCVio3a/FYOtVBM3yv7wQQeCCU2hVaixqRtzaGwfRXPH/JeLFhbo7Z01WRCTSnTDTZEBWQUqcEftACqq534SXCHllcBKiraPULWYDmyFS5F15hvenBSZ2o10bP4JC7Fs4nWFN2p83DbZgG3cicjwiq+jERAN5vy+w1880fgkX7Yr3VflqhFu7QEEMdqPAadenw+SPlwMTB0BMf49wkm/IPXR3J0freJXiJ8xSoKMr7vy5CeDbodTD6H9nrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8FTMCgR5bL7cCGra8j3tjswemPwridZJjjBPKPH0Ws=;
 b=NqubrGrGVYXetkFZuEJhROw+pgFTzz0sxT4g8B3TNpbYq5WTKMZRLA/qkqXSW1vcAOY4ZxQid+PUq3zTvKlTPiV463OxBA6toiTBvhDieIw7SwdM0clOTrf0E5qD0snf92cLMDx1dGtqH7vwpVD/z5zTXPxA5LczswnmFKoj+q+9wdMgXKDeWY7BjtH4UbUiO9UCjlYPD8xd41ej+yXDnWo7DsqHIXjkrxPObKO2sg0XoBd3hRLcF3NDyhC7wYXHn2SHI17zpL6DhQCeOsnk2hdAJ8BA5RD/dOPvmKagxUYl/QpTPDOtY4qbKtmmQzIJrPA+6L2CDFJ/MO0a8/4NBQ==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by LV8PR12MB9135.namprd12.prod.outlook.com (2603:10b6:408:18c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 20:25:57 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 20:25:57 +0000
From: Yasin Lee <yasin.lee.x@outlook.com>
To: jic23@kernel.org
Cc: andy.shevchenko@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.a@analog.com,
	swboyd@chromium.org,
	u.kleine-koenig@pengutronix.de,
	yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: [PATCH v1 0/2] Add TYHX HX9031AS
Date: Wed, 15 May 2024 04:25:38 +0800
Message-ID:
 <SN7PR12MB81018B38CB8C737FEEBECC91A4E32@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240511170143.7ca6a410@jic23-huawei>
References: <20240511170143.7ca6a410@jic23-huawei>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [YaTVz3cqzgVK4i5W9K3wt6eDt/fIi1cNim+LvYQtx5d+UaZ/vlGc5cqf75tirV87]
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <20240514202540.341103-1-yasin.lee.x@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|LV8PR12MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: f7498974-b9d8-49b0-f966-08dc74540f92
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|3430499023|1602099003;
X-Microsoft-Antispam-Message-Info:
	m7ZwB/kJHM83nPf9h0sZsETq/B097GJw2dOvDbcTyYji3OKs7LBJQBXVC/zH741KhTLCDFAbhUC7kH+MOfEs7tvvVvMuzGS9Ul0AQN5TGxqKLT80qLgu13O9wrIWOM4LgpqFQPi/gR72LM9HjicElEZOTPxei9/4eMYkYdxjFrpS4/iU70KWtG6PWMbmF/rITlmO7kA04H4TcU7+HdBse/G+j8roR73utpUkFTUOWpOEbJSrZRfvDye1jmnAZKbegaa8XVsh7V4n5QdJP4PEfOwsKl7bVQu0dg6TtC7Mj3TIfbU/ZAEUSzzPe8DWJI4qS+OK5wq1dLY9S6hILz6taFhfgzdmosyqg8nCI79aZe4cn+wTR8MAwncnFg3o20Oqk4pNm73RKgcyT+YrVCwmgTaRWXGeU5PKSkiVXUBig+e16XT38OF5wg2cBkdowA3Oi5rF78KbhJCHO10rFkb+xDOC9IAAjS3/+dk/CGwXKkBH3w2H+fGlC9WCibalJc3zNLNfwBzSRcy5roIBssys4NbBGIfE3jqOdC/NhonYaWNQHucw8yngrF7jqSH1KZe6wQFU0KYXper5kakW/zZKCPr7VHwyYWmm6UTdGO2EKTBIZ6B4P8hDxFLl9s5iltCYFMWsrLjD704xX66hgqdU5+Prq0r5SrLIY1Pr+yCAkp4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ISDd05rlRD0UZtb6Jf81BO93W8v8gdOjBLJUJiIdcFD9qBaYF5VjIYPUPZTU?=
 =?us-ascii?Q?lnpnT/ref4SH4AUSqN1/4J4xU4+ki77oqAXiygtr36OH2hqmb0FzTM2tRWwO?=
 =?us-ascii?Q?HZ1gx337R0xcsJaeI2bSuMpXuXfKvAQrQ4yjDzw0IIgF88kkx1IKyn6OYVQe?=
 =?us-ascii?Q?Y1kZ7/OFKKUKGTvyg4ugLvidDJuSwoCIkZHB5QM+TdYcWAAP/oVMrtCOjllW?=
 =?us-ascii?Q?Fdxckd7MrLlWopoBe/OYpc+gDGn7DilVg+Q/u5AlrX3xB7vYDLUrw46flVKu?=
 =?us-ascii?Q?IXRSIqOnX5CygWkj8Daczm/c8/7NaR8JjngdWxk1goDA7AjspnYgxZ6l0jOq?=
 =?us-ascii?Q?ZQFe0tJ+8WzWy2V2/xYoDOPE3CZCegVOzE67BVRG8YbKh+Y4+fNgVAzt3VMW?=
 =?us-ascii?Q?HOehFlED6XdxomJOmBrC4dDYgIZ7izpUrdTpELC7bAKLkMkb6OI6DbsLuT41?=
 =?us-ascii?Q?SgzWRd71qGh8oXKLvmIiCWNjF9lRvZ+Uf5WcbpMgrZWzi3B3GdFwZ02OiYi/?=
 =?us-ascii?Q?C+oc+AkLpWdzrsIz4PhIS0g7mF+6J4C/P0NmTlhXqW9AOo1amUqG+xhrHeYN?=
 =?us-ascii?Q?MB5doulVmr9MhmdPQdW2Sa9iGgBs/yUOofz2v6/ejx8FqD2gdR6zrIgDHZ8C?=
 =?us-ascii?Q?amIz+L1kcCLcZWZCqyx7uO8ONwJO9DZi5tAHzKhXkg009zpbNPu/Hv8RcrRZ?=
 =?us-ascii?Q?V1lwZC00dg42EsbiRh/16CjYzyRV1LMeeVXXQeyx+fHiv6a3/BcHTmqDT4c+?=
 =?us-ascii?Q?GS7EkHLRAZcCnoXuqTxtVTMeAmsUf6D+SsNJUoJBrf4tlIoo6uiJ6je4AeNO?=
 =?us-ascii?Q?Kz9JE4BkPe7mNsBfC3jj2+8W9z/kNRfSVUL9pofnkgN97v4hecYqmweUb3Jt?=
 =?us-ascii?Q?xeYgjqYHiX/CYuFEogJBDwoW4vbTQ5+MVQ0h4jNsUMCbsUj0mdATW+qhejFk?=
 =?us-ascii?Q?0NiaguxYSZmIkQIchTYMvJ5Fkztmj2gtdxedFbtcLxd4NN3ZExOCB9SMZTQ/?=
 =?us-ascii?Q?SOTBxGxQHyq62/bghkVGuB4qtCKOnGjbcc9y7ilqNUpKFit3lAOrlMNi6Cjd?=
 =?us-ascii?Q?C0bIa0sy1rhCKNEGGjXZ3lHY2nuDVswitccWU6qaa9XJygDfxCy2TJheFnHH?=
 =?us-ascii?Q?wMU2jxm3wkVDeu8TFHUTr32TWG3qrM7ZGlVa+/AON5mSV9tY5KtIu8sjsPw/?=
 =?us-ascii?Q?tmRa78lJOj0Rd54U4s9qbs5h7zLZal6C3uGOBIKq1Bg7j/wy7YUUGe3x4aWq?=
 =?us-ascii?Q?uo2Ly72A/MpDG9fbF9lsDbFaUQ0LdvUf3kxgjzLoCgTsFKSGDQv3oUxMaoOW?=
 =?us-ascii?Q?XIwbXYoM85RK6CErEHJyKAv0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7498974-b9d8-49b0-f966-08dc74540f92
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 20:25:57.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9135

From: Yasin Lee <yasin.lee.x@gmail.com>

Hi Jonathan & Uwe,

Thank you for your careful guidance. Based on your suggestions,
I have made modifications to the code. However, due to the significant amount of changes,
I have resubmitted the code. Could you please review it again?

Here is the link to the previous submission:
https://lore.kernel.org/linux-iio/SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com/
Message-ID: SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com

Best Regards


Yasin Lee (2):
  iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor driver
  dt-bindings:iio:proximity: Add hx9031as binding

 .../ABI/testing/sysfs-bus-iio-hx9031as        |   11 +
 .../bindings/iio/proximity/tyhx,hx9031as.yaml |   60 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/iio/proximity/Kconfig                 |   12 +
 drivers/iio/proximity/Makefile                |    1 +
 drivers/iio/proximity/hx9031as.c              | 1379 +++++++++++++++++
 6 files changed, 1465 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-hx9031as
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml
 create mode 100644 drivers/iio/proximity/hx9031as.c

-- 
2.25.1


