Return-Path: <linux-iio+bounces-20758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABABBADE925
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 12:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4759D177E7D
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC71C27F177;
	Wed, 18 Jun 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Qa+s9/si"
X-Original-To: linux-iio@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFD5BA27;
	Wed, 18 Jun 2025 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243038; cv=fail; b=u+KBX2OKmJ4nEL/bwQJEpXTbuWoCwez99jXBrh7IR2XuUCwOJHheZkBb16t78VCNKUM0fJqRU53Q7vmzh/disl7SPm8HhhdkNiMNv1UPWRcmfjb6z/XQDTPcIsOXZ8aJirqMedxsj+3UGa4k5MT/Evq1/XKG8btg7rNYWRUG4uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243038; c=relaxed/simple;
	bh=HOwg0XLBkaaW073sMF2Q7R8lj3pBaUmmVjnYYsw4hmc=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YnOgz3YuUUvVZnMw/XXQtKmroIeoo1NN80lqR0LR8R2LHgsxrGgvRgG8pIdrEcFIFHBgmluBR0Nr4fo1tfR9oUatR3GA7nxJlW34CNDgheYqzUEIaNU+kc3P0v24g/rMDIKitCBwumB/8r6H1qtJind4qfTHtwVOm1SGEu5nIXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Qa+s9/si; arc=fail smtp.client-ip=52.101.84.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlHeRZN67D4e7WSPUP/CeNXQZ/zEBoGQMSAt/cRGVcW3EhhDiryt6FULx0FWUtoevGWiapjUHH0Sr/wpMwgVR1xWQDiryYtCaejJsyZVkZH5cpsrZs/RpqFvyB5aeU22etui02MoNnG6Pa5UkXYFnV1yRHPgDOuUe4D4pZEEffS8EoY7JTkGG8tLGa5jeAhiUk+0YoupvAm7V2besrCNbCDZOVxMyKb6DdGiSkueQTwKFw9l7PPemPydQ6/qyBvOLI6v8VrsT/4/MsK7SGJKdYI1t54msr84zeZj/NRwkf8uOcjNxWNotZJ2wHKDntcBf61CkbKNQ2bG9nb1/UoFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikMPal/2gFl9Ddwj8q20srfYKEvCqE2XA5zoCe9m9C4=;
 b=H02y8/g0VSzpLA33tr76ndnSlzbv7W9qdaSgGw087GJeN2MsuGUXo2s3rlNnIOAcMYB9dgOf8bcaSi2tL+g4ODcsjNwcSEBJNxZ6zl1rdr2gef8j79Z2JlwdYvgN/mnklTfn6xBXnIWmO0w1O7/k3JABznYIJ4m1mwfdUDmphYZFSXgovFnDsmejqaUS0B364pHTe3axW2BNmV2l98CWPY1ZwoqMLvs9c2hq8UFMbW3diSVV2waGqPz0+wE5KtCskeAF24uBl+z8LkVyQxUZAkmXOcyB+zg9CwZpTkgEVRoZ/E8DLN8IyhfS/HiS8CWKq1yg8FKzlyG5DXC6avko/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikMPal/2gFl9Ddwj8q20srfYKEvCqE2XA5zoCe9m9C4=;
 b=Qa+s9/siP9uNu4Xn28CiI3lMQCBV5bvqcSwdWJmk3VAjIhX0j1SrJVhqROdBAUiq3U3KsKnad4/E9aH6XMDeKjuSS0HvnrJhHNKjR/HcnwaATPEuSkN6xk/+muXaxhWxRPw0LV9rk/PhoCguPknSYzpwSLGseUhuheoYUhSsKPo=
Received: from CWLP265CA0306.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5d::30)
 by DU4PR02MB11310.eurprd02.prod.outlook.com (2603:10a6:10:5d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 10:37:13 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:401:5d:cafe::80) by CWLP265CA0306.outlook.office365.com
 (2603:10a6:401:5d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.30 via Frontend Transport; Wed,
 18 Jun 2025 10:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 10:37:12 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 18 Jun
 2025 12:37:11 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: proximity: Add Nicera
 D3-323-AA PIR sensor
In-Reply-To: <20250617-vagabond-fulmar-of-penetration-dbe048@kuoka> (Krzysztof
	Kozlowski's message of "Tue, 17 Jun 2025 11:06:08 +0200")
References: <cover.1749938844.git.waqar.hameed@axis.com>
	<e2b1b56fbee07047f3fb549f17257dc3764af395.1749938844.git.waqar.hameed@axis.com>
	<20250617-vagabond-fulmar-of-penetration-dbe048@kuoka>
User-Agent: a.out
Date: Wed, 18 Jun 2025 12:37:11 +0200
Message-ID: <pndjz59l4iw.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|DU4PR02MB11310:EE_
X-MS-Office365-Filtering-Correlation-Id: ed68a6d1-cb36-458a-0ecf-08ddae54163a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PwmvuF8hF/9+Vcj8SX/zHwHNYzGIzUQw0UPzTf7HF1uSPrqpi5mH3fGy/svD?=
 =?us-ascii?Q?SSlQyKAw0tcXnEHFHnnwzYX6aRCEeIrd7Y6e29nauM5if0dv90ya5rzZ+iS7?=
 =?us-ascii?Q?W5H2C3qguV3wwRBfOal9cCTmwCCiJ26kIbnCvvjkt2TgL183KxldB1yXUgHl?=
 =?us-ascii?Q?aFFBKqBKzlnTARBL3ZiZ2ui3gNcafakxB8GH/HLXSIGH0aTrmEobDjiw2yXj?=
 =?us-ascii?Q?M4fCmCJtg54QpEqxHvXVVVo/9iEGqX5J4G62tDzUT+STBcP8rdYWft3s1aVS?=
 =?us-ascii?Q?WBsrTETAg3Pcf6rnsC/azMeZ42P693b7eSakuPOFGoo9T7ROLmAbvb8Hd8tn?=
 =?us-ascii?Q?RAKfojkcD1RTK9DZDf0vq+FPFks8Mzawmr0ra3HDYxB4Kahr68mx+S3WdcQo?=
 =?us-ascii?Q?E+Qv/m9BfbCrYPuUC9HQfWVBQ5D0Ijd6rg3XvST7uAKbi8vvNwYPwJekRJvE?=
 =?us-ascii?Q?+GaRF/QmFNRP2OF9hDXMHUA8rbUCRLpXaouxrKI+x4J9MtE4D352T+wJkzJC?=
 =?us-ascii?Q?WYJ7ONoiVKltvjTUI/i6XhfXJw1aWY+d10htLoQpXB4JIIXoWlcTma+2Lleb?=
 =?us-ascii?Q?PT7d14U256fOmiAvYv8Hrc5PfPVpd+v11W/7xUGMSkHquC56hX6/cr7tS+3n?=
 =?us-ascii?Q?crUQu9UySdKkrY7uWjrSiS6U8Wkk4ztlyvENyBU907w4aBEMIQTy4XHpSWF3?=
 =?us-ascii?Q?1PrMd4OW0LTleqFpSFXeWYZTOXvUT2T0Zfg0Zh+cpRmGo6r8IW0mbcHQC5Mn?=
 =?us-ascii?Q?IKIAvrGX15nWSu0YhqYwTPxIQunT8C22dKpPBXSKDl4GKIoRYnJTDr/0MS8T?=
 =?us-ascii?Q?4pbFaWGfl3HjyBVK+kYM/gzoLVRTKJUfR73c4Cg+eV3zPdzxs238LoJUARzE?=
 =?us-ascii?Q?zaP2zFqwFuKGc5Q25A1bE7dxxlsakdKLhuXaWh7yyHWX68nPY383ae+5GGdO?=
 =?us-ascii?Q?yq7rpINytMF3n+j2N9+XSNMZf8Q52u/MKQx0FTqJhbs6/4oTAWY4+0wXS6Vi?=
 =?us-ascii?Q?yk4hcWzpaJEerWmU/0b0lQrdkRRw6CYC1Oh9SwZJzq9lL6JxnFWJ9bizP7OD?=
 =?us-ascii?Q?Wy6vJSfnfHKz4+4ChzgF7z3zWbuDrvMdJXrJDPdXxfi+0s9XoVry0vvQPJ3B?=
 =?us-ascii?Q?+h+8GIOP6AASl3zr4RkGuNOlQ9V3Rsfe9o/QK/5LNJ8OVeAG+7MKzE1q1ttt?=
 =?us-ascii?Q?IIePpi6PG8mRZG7CCzmsxL78X/XrmCNB7bGJp9ljBY5Y+0xdQz6MrwvEehjW?=
 =?us-ascii?Q?H30WzHFQfgLKGvpmrQuM5hrLzfSgykwShlhXujYUsqZv4ssfe3ogGfNzF9AI?=
 =?us-ascii?Q?laGKNneGgp4ZMnVm0shi/BD+413rGRrp+6AU/MCX97Jwdz1PYKoKFSqdIyRI?=
 =?us-ascii?Q?wdkXKh+jLf1D9ofA7zHaxicBFSjbX99dgFNhikYSBBHVnrf0AWg+qTR0K4mc?=
 =?us-ascii?Q?e6UQHwUc90UT+qURktUUQY5CP30DhauXqKtdnql1mNzUagkedBAVLwneprUY?=
 =?us-ascii?Q?TJTvlRigpMG3aXVQx9c8C64izCGCtpNtUwxa?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 10:37:12.9432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed68a6d1-cb36-458a-0ecf-08ddae54163a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR02MB11310

On Tue, Jun 17, 2025 at 11:06 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Sun, Jun 15, 2025 at 12:14:02AM GMT, Waqar Hameed wrote:
>> +examples:
>> +  - |
>> +    proximity {
>> +        compatible = "nicera,d3323aa";
>> +        vdd-supply = <&regulator_3v3>;
>> +        vout-clk-gpios = <&gpio 78 0>;
>> +        data-gpios = <&gpio 76 0>;
>
> Same comment as before.

I removed the include header thinking that would be fine, since there
were already a bunch of other examples just using `0` as the GPIO flag
(without the include). I'll re-add the include header in next version
then and use `GPIO_ACTIVE_HIGH` on both `-gpios`.

