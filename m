Return-Path: <linux-iio+bounces-14288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D55A0B90D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 15:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155D37A162D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B728623ED46;
	Mon, 13 Jan 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b="UowkJiEM"
X-Original-To: linux-iio@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021087.outbound.protection.outlook.com [40.107.192.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B692E3EB;
	Mon, 13 Jan 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777238; cv=fail; b=mRZeLOT5sz0RhtQ9EDPDmPg1FlBQ9ygb7tE6X0vdGBURzjWETkg7KbxqEiFvXtaE6F/CWAmAkwsmzanBxBBzyqJzCBVAY8jKmV7aX+73e5eQss0lZhKqUWPa2DJNsrn76Sy8A0m/mK7RfdIYSkNXycclnr5/vHQnfzbZ9hy1Xzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777238; c=relaxed/simple;
	bh=KuCuSYZJ3OhhgezfrCKUg471QHLwVakIEBD57xrmInI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VkLtLMf5L3RQlxFspLotXAqD0eao2jE2AFmKh3GPEsQhWeoMBmWpaA3MIuO+GOO1cZDoaVWs53VQiJ1m0r3G/OddexhEIMEcwC6Hz2MTDLGK+nCWcznPkZhU322BWbO+cR9xGK9QESP6SBthkmXpnAjCJQXG7j0QiONda5aqx/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com; spf=pass smtp.mailfrom=dimonoff.com; dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b=UowkJiEM; arc=fail smtp.client-ip=40.107.192.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dimonoff.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loFAgPDHXlZfVRIKuOGneKpPKJkpOvXNH0zSpBo2tYZAr4WMCrwXHMq49aLAwkMPrhsnkXE9A57XZbQXIqCau7fVqk6QTh4G4hQGhCb3pTHNxENRWZVWE1m/Cbti+CUSZQMKQ2Et+mGw06NGEGHwTsTtAcRq6jadelCB764/gHXtEXQ6yVit76NcYM0xmJ6n1j1eNVaRdEBm9hd/ieOxCPhy7h3Li3ydc3WWxzX/b66jO0WeZh1ueGbAN3msDa5NFxSQS35cmXMK1IKXUgPwtu4LA5mlAfuQI9SkWYooZQDTephdOCdVs5apLfpgXgONgalSpZia9vKIf19R9oSLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVzAH0l1//me8B9lbWliELXmJCsw3gb0stGnLNhg/aU=;
 b=jOo3qYoYU/rjnVkUIQOuxk533MS0yMbB8x0lnuvxENbM9M9NfxUx5jX+fGx/vv0YffgNMMHxqngx5WUcrVj4NGc5DfuMaPH1gU5Z+7NACBmwPQ89te9Ue1vOMPq4fUMh76wlcPGR0RtXhHRNQHkdA512nKrbQX/I9jygFKYMb60P2cJhA31Q1Eh164Q7rlZI4cqC3nc8BZ+11uLcUHt9UZdpMM17xXC8tY6sNy102eli2h4Hjltpk7YpBHy+NjM0CLRhXDPDCyQxoyCHU028heL6jGlzCiPfq6T05xV1rdS8ddIE//k/8kkCIWwqa6TRCsgGwm2QMPwCC2UUGeovew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=dimonoff.com;
 dkim=pass header.d=dimonoff.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimonoff.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVzAH0l1//me8B9lbWliELXmJCsw3gb0stGnLNhg/aU=;
 b=UowkJiEM6iuJz9pTRZdWiJzXwQaqNsuEXH9IZroaq7XVSUfPaW0kz0VdUwuAJHtmpHubp7iS1rJYpyYsd5Qj7Gu/Q3I4JgRWjIV3+CwU7CDFdzg5scW+b393r41pRgAfCqpKiQpcuw2cukAF52ZsExIEKcV1SuzWmm7SsXJNj8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dimonoff.com;
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20) by YT2PR01MB8423.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:b2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 14:07:14 +0000
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39]) by YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 14:07:14 +0000
Date: Mon, 13 Jan 2025 09:07:07 -0500
From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <Z4UeCyxgbzCUQtRz@uva.nl>
References: <20250106-apds9160-driver-v4-0-f88d9fc45d84@dimonoff.com>
 <20250106-apds9160-driver-v4-1-f88d9fc45d84@dimonoff.com>
 <20250112111059.677f8708@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112111059.677f8708@jic23-huawei>
X-ClientProxiedBy: YQBPR0101CA0305.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::12) To YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9181:EE_|YT2PR01MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d19335-1c3c-4786-4c83-08dd33db9487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6qQ0+pK+balhLjTyIiV7lhyENLeIamG/sjZOGE+0mOUdZnPdwr1rDqBA4Re?=
 =?us-ascii?Q?bvRCuaGjk5+81YxO7NxucRFL1zTChw2gBDL6mFWDug3wo+bNfISae8jB74/4?=
 =?us-ascii?Q?hsCQA1UgLfgE3Nc59mToQwa286nQ+bv3AdgzJnZOdxOTrjlDBjL2wLYc6koX?=
 =?us-ascii?Q?dZdnjqn/y+qrfCb4/XV+16R94xK5cYoCBlJwN1Z85SxmDbLyCYd8uQqZLUqm?=
 =?us-ascii?Q?bVjlgTXnaiKfSqU2kWh1CcJfIxlyCYEL1HLm48Kitb6QTcxYLYMi07t3ftmB?=
 =?us-ascii?Q?lXsiRmcfSxo+Terc+voiCwkIUnxSYt0y0tOYk4Aa8OYq3zdKIePAegcah+9T?=
 =?us-ascii?Q?TVdyv51GDMPWcQ7G6HCR6E1VIX0wSWQYmNsGKiHILelxIL5aSD7ah1lsPN+d?=
 =?us-ascii?Q?jqJuB4cG84DJEBdRnxaVm46HfyNjYBSHIen3w7ZxWS/B4zhwvDVuvdBkUcVZ?=
 =?us-ascii?Q?lg5yIeHvIyrnFfudv2oKQqNKTWrNkvawhVgpcpAyClJKANbAPx7Wx74T+4mh?=
 =?us-ascii?Q?ksp9w6X8ni9cZBBfOnyQa4rjoaTGRIpWrNb5od3s3iZhalPiAGy4hCbxGnlZ?=
 =?us-ascii?Q?yyqrlDuIiOwWzJwiNt9CqbGzekjtvFjIscF1sK1XHML6VVaA6C35JC/gtf1k?=
 =?us-ascii?Q?EwLqMJf0lOkKaiqGU4pftKppY56fi2y+HQVFRh8NKyIF5ob7dnK2+RIzxZZX?=
 =?us-ascii?Q?uAMv7YqwOE5x2wT5EK7XJ/iTpjl5/F8DW8M/43+1hnllYz6CrTmKb0XCj8t5?=
 =?us-ascii?Q?QobioOuTb50LHcoV8Sr1J3vJxsT9EgfiM2PqdBqFYsGltO22+PwETjC9Xi3M?=
 =?us-ascii?Q?8WKm0DJtXReb7IzQkD2ZdJ1yMSXwJ085JKZh0DK2CkFqZ9KMRc6yOusf6LX9?=
 =?us-ascii?Q?OvS7asWVQhSYA7lgIIJ8719XushdMTIUwmpRU/NPrx+j5LAG5c92w2/OylNb?=
 =?us-ascii?Q?sUYBsHHp5mFWnOL0fATGihJY+yQXuWIcSL5WvZCZOVYbHPIl07RBdHe1PtcK?=
 =?us-ascii?Q?O/+PQYqFeWzlmdM9Lk4kHNKyEFW2SeAsIYJoLfEC5I4W+8iqO2sjFMqfYIAn?=
 =?us-ascii?Q?DSbj3LUPJGr7QaV0P57TJaotuNypIA0V9H5CansWZ3ch6nzY80AnKJ6TmQiF?=
 =?us-ascii?Q?XNfcccF40p3evcjobh4i2T52d7JNIQQRC76mlqMrlmoxxwFR3ZzpjFDkA4+X?=
 =?us-ascii?Q?9e32KZzs5d6z1K4Av00Ji4e729rQoi/AXOd5U7vWlQcLCQhIRKCXrzm59U2a?=
 =?us-ascii?Q?UlauxdjmbI/hL2Rn5fuk/quBeCaVCgoRLQ/qxs6iss/J+W4950iMLvtG/zBM?=
 =?us-ascii?Q?kFG+XD7xsqmBLcop2viAsiOkvh2AfQbSeBPhpVFbPr7Bnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4IxAg8PeXPa0+A2j5a5xIqSuxZu7d54Czg/JNGLrVP8laPAjVl6ho5gHq+j2?=
 =?us-ascii?Q?yprHM+h7pUzYbZRMnmpkGjXA525B+iZYPrEII2TOQSHxhQbHyFyeN+kY6tEO?=
 =?us-ascii?Q?1BxQgT8yVVBl/0BmpGFe8YM3XSlIPZYZ91NMjo6eVylr1DP7RWooXGEuV+oC?=
 =?us-ascii?Q?2ltB6B2IcBzEy6Zkc2/tUb1GfQfJKhyta2VtANWqdpeFjuHB/aEXS4tjiMuw?=
 =?us-ascii?Q?IFa+nGah6bwh1xKRfUVDRWOl/YjEfx10Opu/QmIc4i8YJSKMj4lHRcGfs+Bu?=
 =?us-ascii?Q?wPZRnwPEYGQh32Ykihrz/l7awrLVQnBD7WETcrlivwv7Vpx09ErjpP1taCY6?=
 =?us-ascii?Q?Lsc6CjeuwiH6zigQjByH6SSgcsdiZ8PYDZ2kHGDeHyN/k9IfNKQOm6h0FW/r?=
 =?us-ascii?Q?T5w6zL/mzMuCcSx9iwV6SHMOtXv8GMD+2EbMwOKsAc4jIM8xyLHJhTukFd/6?=
 =?us-ascii?Q?7CVCj1HQS2jIjd60Q1+VzfuWTutpObrb3AeHSJjxDfNYCmtS8dT4cb5edFO2?=
 =?us-ascii?Q?2AGzEfjZUBWVdydKxiHQOWbWXW1ijtAksdkmateSYoONo6bFuU5wN6TRNjOn?=
 =?us-ascii?Q?CyxUCFDX8VDSX7QLJjaAHwrYqz0XymtVTmTl0YbJaDfXCtVyIdmBA418Jk02?=
 =?us-ascii?Q?KFEykKs0NV0JelI2uS9pAm8C9ssnAazVWqtIPapaxgMVYWlE86/qddn3pcAS?=
 =?us-ascii?Q?zqRUGrs4GZS1HGgWA4uos62ed5kmkXDN6C8BHajRiJmj2BfecALWLrj1cbS9?=
 =?us-ascii?Q?7rRocsjPUljwEv5+4XCQjQifuSEugtmqz9udhX44e3uX1dwPn5bM8xpri19m?=
 =?us-ascii?Q?/0docactx+LMfZK/CC05zyt8eMWKRsRPeGxMNK7LNnlib17rQ7j+rJ2Ag/pc?=
 =?us-ascii?Q?IrsUmx+mblNTADaFSr6yotI3/apK9RBlwj/YxB81pT8hyNgvfbfcM9r+MV8x?=
 =?us-ascii?Q?UR4BtHkrjz8lgSHkSgrxbDjjOJY/wv5LfvPz9EUCeMrGRTb0JMo5H1Ez7024?=
 =?us-ascii?Q?4gpY6Nfdye20LCn2mVgXvgQBV0eKRNCcNR/cXyQXRhaejMIGU5VpuYMAWqTb?=
 =?us-ascii?Q?k4e45K9E4xT2ZVEXRyckMPTvUW/1/0WWgyJmP/QThVpyrkApCkU3jaVGpeX4?=
 =?us-ascii?Q?TC4gfOqY52z0VNBW1SefxhnMrV7VIleLo3IBKgdAnWEjRxamSjlGqW8neXxu?=
 =?us-ascii?Q?5GiKuGQd4pbUR8WKTK6ZW9RA9eUc2yBKpqJtJtcsCfR8uQYnHGtZA1SCUc40?=
 =?us-ascii?Q?fhWmA2kXuuEhYGNQA6vvIn5qIpvxxgxvrYN7fTxXxVHczFayoqYPS06HUu7a?=
 =?us-ascii?Q?hA/S27cmB1VVspQ+V13QtDDF7BTQdiXnax/SXIGvotqvxpp1tcYQQJ32kaDp?=
 =?us-ascii?Q?9AIJEpeULEgFzWKSgja7ErLbBfZvgqDEQ5cqlbuUeADYD/LFG9l0CBldAR4R?=
 =?us-ascii?Q?xwNYY7AsTNCr8+SChnJbFsOiL350iN7yaYO6RaD8VJVAuiTmhEGdsLnZMv5h?=
 =?us-ascii?Q?JTEQ7Wq/zL1qev+0k4oXtOnAZvdnX0z72NAQEdyZqj31+FUh2835EO3X5YQ8?=
 =?us-ascii?Q?GoxJXNQ8HdmYM3K0JEH84ykpyK+QRqkRBUkodr0EO3wT/LW6mafzRJfmbiRV?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: dimonoff.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d19335-1c3c-4786-4c83-08dd33db9487
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 14:07:14.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xl6FbqZ1ivEcZGDWiq0bL3VD5gTaXO3NuLF9tGFCF7UlNUWiI5hIuX+g5x9fpZCIFjqWP59wbzOB+N80AZcQ6EnE91M35XdzEbccSKO9LbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8423

On Sun, Jan 12, 2025 at 11:10:59AM +0000, Jonathan Cameron wrote:
> On Mon, 06 Jan 2025 17:23:01 -0500
> Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org> wrote:
> 
> > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > 
> > Add device tree bindings for APDS9160
> > Note: Using alternate email for maintainer
> > 
> > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > ---
> >  .../bindings/iio/light/brcm,apds9160.yaml          | 86 ++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..756d46c2edb171da840ee49a7339cb781fe84ad2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/light/brcm,apds9160.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom Combined Proximity & Ambient light sensor
> > +
> > +maintainers:
> > +  - Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
> > +
> > +description: |
> > +  Datasheet: https://docs.broadcom.com/docs/APDS-9160-003-DS
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - brcm,apds9160
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +
> > +  ps-cancellation-duration:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Proximity sensor cancellation pulse duration in half clock cycles.
> > +      This parameter determines a cancellation pulse duration.
> > +      The cancellation is applied in the integration phase to cancel out
> > +      unwanted reflected light from very near objects such as tempered glass
> > +      in front of the sensor.
> > +    minimum: 0
> > +    maximum: 63
> > +    default: 0
> > +
> > +  ps-cancellation-current-coarse:
> 
> I've lost track on what we've discussed previously but I'm curious as to whether
> we can end up with a cleaner binding for this.  We may well see other identical
> controls in future, so nice to have something more 'generic'.  I'm not suggesting
> we don't keep it vendor specific though as not sure it will generalize beyond
> different broadcomm parts.
> 
> It is a multiple of nA, so can we just express the combination of
> this and ps-cancellation-current-fine as a single parameter, probably in pA
> 
> The tricky bit being there seem to be holes, so the allowed list would be complex.
> 
> Even if we can't do that can we express it as two nA values rather than indexes?

Hi Jonathan,

These holes just have me puzzled on what to do. There's many of them, and the range in value is very large.
I thought about just having a single more generic parameter in pA but like you said but I found it was confusing to 
describe the allowed values and confusing as well to just round up or down since the holes are so large.

Having two values as a multiplier is more straightfoward for this chip since it's just based on what's described in the datasheet.

If you prefer to keep a more generic parameter, I'm open to the idea of going back to just a single one in pA and
log a warning in the driver if the value provided ends up in a hole and round to the nearest allowed value.

Are you confortable with this plan?

If so, there's another problem with the above. I don't see any picoamp suffix in the dt bindings property-units.yaml.
How should I handle this?

Best regards,
Mikael




