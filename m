Return-Path: <linux-iio+bounces-21982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA25B10DA7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 16:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F2D166F8C
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B408D2DBF7C;
	Thu, 24 Jul 2025 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M1Z/3BAU"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C128D8EF;
	Thu, 24 Jul 2025 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367385; cv=fail; b=BhPSdbuhNCh1JhK31eFDehdWfpitzx9JlsW5BXykTmQhv5niMF6DM3Yaw4Q8S6MIjmcaKPSNoFJ9yPyYoASwP+QypC2GPJqZ6K9Lq4GtDSrkd2l8u4EzhcaAJlVXvYTnhETpUPuOpS00NCZzCEQCgKE5b1A+hT+bHKHyH/AIfDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367385; c=relaxed/simple;
	bh=XHJlxEaIxwBNgQLggkx/M/7vbBdWe1fuPHhJVfWrDfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JVeG5coiXHDe0i8o3P4cKcAbb58SedvW77DVHrSNKJOrpbNzaTRkOw2i+pPQGfQ7S60ahwOHTTtm/a3Jx87/GED593egmCxZC4PENkm4gPADnNB/qfgTFpYvZXxV8Og0Nb1rsO4RbK59CRGf5Kvf5DBt1LCOAWbSRTdI5NC/UwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M1Z/3BAU reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHyYdqh8wg/W5iioqnrIsL3H4SGk/FS5nYwYTfAYy3ErJXz79GuzsGNx0Cr8gY05xKlXw7CLM01rUinkBdE9DdQ3YtMW87BtP/58o7G5e6RbnAxCo77+rxjvZi6DeQ8X8YXHqMrKwdcK5ywl+RRu/KalymA59LtIJLyVGrTKPpXJTzV36j3HThVm1CAmq3Mm0sY7Ag5tk9ov7opNqeutQsBYob/Yj01sJUxnW21wFnc/rmJaqCQRWBhJHKr/kJ+KG2vWuFpQb2SIjqk1Y+jpHkKgSvb66sYGF+FwRCoDFbTc5gwReKpaHq3WI1303bfH5Q6cy3uLie5jA8N4Zcu5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cwk+n2LTLg4OZPGIcSH1DYEvyA/VTgfJECtZa9VzYuI=;
 b=yD4IypMqRVvCQvh9WMeeEfV/1osB+PUHeh2FBPuCnTLM5z0CS7hA0faf1DMoJZrYU/vecmsEM2XyzOCPthRCrqTd1gyK7XSw/XrHIF4bnwfcGhdWfsQuhc2u6zYQ7/QbuW6CnFyU7Rj5l75Abc+aaar5kTU30Fjr+EO6Hi8nvXrQ+w1HFZzERwYBxGK8mRuvpHPCHcU0NUOsVdHf9N2NmZoNf9X6SFWlLPGtjIfLRD9gFQ6FuoJ4zIShVOVYM1LZc5aoDbLcd2Bg/n7zO6eg5CMobjI3vbUEfPbmtcD2z8XEdWhFkNxvLIa6/KdT3Nx+sdRwyjwqkcQItgJR7KE+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cwk+n2LTLg4OZPGIcSH1DYEvyA/VTgfJECtZa9VzYuI=;
 b=M1Z/3BAUCtJYyRN1jW2vophbLFZGNITxXt224fYQYJVw/G95HnPZU43gFCP3+/YvZ/J0zUiJ2aYOamlrHOrWGqVKlxB4Ie9tlPPQw7vsqOdq+0G6P5oO71Y3OnJWMPo/PxpLHWPGzo7TbwppTVPyNihwYrBfuKiQEQRBLn4w7TyxoIBdp+jQbC5WfHdvbbyzSzE0d/c8Fas2sqk4Cim0LC4El4fecJvgEheYsXvw3nMWM/KeA4q/xwqMAUOhaXdX2GgL48S2V/xvk5LdcNyhS1q3Rq11Q9Zo/q4LSC74oaq4Rcc+uvx/c4AcNsgWg7ktjO0UUvVm5HR1AfOZYjKmFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 14:29:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 14:29:37 +0000
Date: Thu, 24 Jul 2025 10:29:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com,
	gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
	peterz@infradead.org, jstephan@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	vikash.bansal@nxp.com, priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com, carlos.song@nxp.com,
	xiaoning.wang@nxp.com, haibo.chen@nxp.com
Subject: Re: [PATCH 2/2] iio: temperature: Add driver for NXP P3T175x
 temperature sensor.
Message-ID: <aIJDSKigfxt1EmAH@lizhi-Precision-Tower-5810>
References: <20250724083951.2273717-1-lakshay.piplani@nxp.com>
 <20250724083951.2273717-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724083951.2273717-2-lakshay.piplani@nxp.com>
X-ClientProxiedBy: AS4P192CA0038.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 370f0b9e-2cd0-435e-2db8-08ddcabe848f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?gJ9+Vf4jmxNYlE29bgm6QX6YJ6pgnhgtmkqFOfEL80uATIvqjdyWUXdGx4?=
 =?iso-8859-1?Q?X8Vmbbo/oOTBS2qTHpqmVsmpB0YO0zV37QUDSv6KsiGvNH7SKsYItJBH5+?=
 =?iso-8859-1?Q?nJSL3QtNNuu1dQ8Rt5cpytOJ9fZHIiceYONNjsUNfwezP+JAFy2NPmJeCf?=
 =?iso-8859-1?Q?ex3LSQAXk3E0IpsFqo1rCEYjg62E6hWC8v0jxyN0d/fXZh0ZbGwg+EtMht?=
 =?iso-8859-1?Q?15ox1k7io4mROYVSMrGbrWp44ih7wKeeGvUAFtdHBX8rUwOD51kUM0nR+4?=
 =?iso-8859-1?Q?u2nFPnDA8RBIMU2MOU9sJfAyeLPA0ly21nEsRvlWPbtippiXQJlg+LobWX?=
 =?iso-8859-1?Q?YJ+LvD2M3eUR4yi+bVRQYMX+ftFDXfcTbFYGLfXuQjGr5IYQeIiRUsHr9D?=
 =?iso-8859-1?Q?Us0OKERH56axXxZPmyF5kStWXDue2zDAMuakSDhsbxyQky0lFk8KBt7jVH?=
 =?iso-8859-1?Q?wJVTbIkdWaZotojFO28CQnYnGg0XTqO4Thtnb6/WzRAY8RKaOHGNBGBLXI?=
 =?iso-8859-1?Q?0uttX8U4iyGWHRTQO4YAo32+ImCtuHhLDDovIV1btBpFOBSMRIS/JNpRNg?=
 =?iso-8859-1?Q?8vSxgNQ12kPwwM9JHnG1IQzGkGtTxdBoTxITMV5d4R+MTEgPJiTAfpz8Lk?=
 =?iso-8859-1?Q?aQHKYEonwBtF5BDBJVTfSXukxnRBaU7HJvAkg0L+rEpqOxblPPHiQLG1B5?=
 =?iso-8859-1?Q?i2RDDIr/qMsE8bdRV/XrNC+wyWHSmKlH1EoHqHOg1HrJlMERw2Eggn1Xpj?=
 =?iso-8859-1?Q?NRVJ6DmSxQ3xoLXTuF7FOXT7Id+tmq1y/DF3+3JV323c1zqq27ESj/w8NB?=
 =?iso-8859-1?Q?m1tZnOkvjarP26ZQMGWw3QqNmyxEyLCaL0Xlm69ayXNf6Dm8xk6ZUML3Nn?=
 =?iso-8859-1?Q?ETNGRJ/HMY8xbxOXXOh37GqoW7tvc0qIOXgVy4VE0w0Z5WnO4mBK9faE19?=
 =?iso-8859-1?Q?P05z20kDyS7YQTxCf/9Hnu7fsqwCPHxI3m782HyuBROHfLLrxvc3o+c1hP?=
 =?iso-8859-1?Q?LMM7ZFR6aRBTrEzE8wWIGUn/DOWlDzGSRF3p+9d3PTQ8Yk8N+mFeKJINjA?=
 =?iso-8859-1?Q?TRjOvQfIzdW2+GdZuQ/lfpvJwTHBnQlwSO86OCLQP67Qnt3dkD1yAmgTfb?=
 =?iso-8859-1?Q?DRDUtRr/Il4AVBZuN1hws3FpqluHl/LzTy78MFGi4I+wfJ8n8EoSLU0T4N?=
 =?iso-8859-1?Q?0zIasC+j3IgCksv7Afv4G8Qp6+WKhNg49fRBKzSSMOC+KBWIfNzc3Vl8yo?=
 =?iso-8859-1?Q?A9oExQFK/Tm1kFngWgZackBMMnGB/gopWaeRzCPKGxnWYTZSWVnOnW3TT0?=
 =?iso-8859-1?Q?M7EjnzxXeKqsn8jWF31AzMCSw07akWIL6Cz1UV16n8B1Ssn8Ve8F0+Lv4j?=
 =?iso-8859-1?Q?gJVBiW5WiiFe8jcBAqwSxGIuuf3BslRG1UntePZMbPwC3lZxcGv2v9+VIM?=
 =?iso-8859-1?Q?My4m+riwCC0kwBYTqCgCigVZEwNilCQdNAVz5mhZQKA3feJC8KshyBP8mU?=
 =?iso-8859-1?Q?5FkICkeaT6rUaNVk1eojRI/gfd/5/iTIlCwZf2gsQsW4tMBjJd0/iMZv9M?=
 =?iso-8859-1?Q?KhcQGto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?XP3aADm81fjnYmxz8wS3aS7RTl9cOemEuaFwW+SJXFOc0Xzlb1Qm6bkjoY?=
 =?iso-8859-1?Q?rbOblQuJBGPFH6Ffzd415mIpXAkRPVSER0suduXprmozF6OK0OAxJAKavm?=
 =?iso-8859-1?Q?K5QM5HuWYpg6JqNk1vWjQmUEtn+g94M70WNtn/KFAoV7CaG8mf3gM3m5oi?=
 =?iso-8859-1?Q?u3psGll88fRaFhKrDpzQvbAh8ztqgZCMIFqjF9jB4cKhexRdPZ39NtDg24?=
 =?iso-8859-1?Q?yAaDgrKv4pRDXFVnmFnwaZz+ZMVnWFPMWxHD+17gAIKhsuxDex0rA5mdKY?=
 =?iso-8859-1?Q?3yDfV7u01Sp6z1mLWQ+1RyY3n82IyilwRzOGAutINcEE14spyfQgHaFJE5?=
 =?iso-8859-1?Q?VqRKgQ0na6K7mGUn7o/XERLcXuBJd1pL3zLQ11VbEtYXAoDpAyu1+AdFd2?=
 =?iso-8859-1?Q?wVGrpYHHgytqYI8OCiWSkB9gFXP+NG6MC7Sp/DfZ+8xPHQJuPIDY/bqVdE?=
 =?iso-8859-1?Q?IGyuMgOPwnkIHT2RKPFYxOQ+fcPYoukm+0U4OpNa5QspX9x6976oYiljqP?=
 =?iso-8859-1?Q?PFX1K8qBBEw/A6lLakPEnGkS+e1Pd2lxuEnp8pwUOeMFokicOdHHF5NyXp?=
 =?iso-8859-1?Q?idNSiPrKjcXVmxn+xG26wdAVPvNM0BvwkA1GUrRwJU+THbtIVcDuQJ5HJG?=
 =?iso-8859-1?Q?UEGwMTo2b8mwRgzcSBiBr0rds2WkpNIZSPgN5RNe357JowHPSahsp2Xa5U?=
 =?iso-8859-1?Q?ijIQ0/l0lsYWLnMQIU/AEnBCC3iairMD2V0O3Ul4Wse3zuNghR3ku+TUYk?=
 =?iso-8859-1?Q?IMryqZwaHorz5Oy86RCcxO12JIVLWTvef6SaA6iJb1IGW3h8ug6m8D7lEW?=
 =?iso-8859-1?Q?+NLApebJWrT6Bbo85QhTAp+1hKg5FKJRIGfisuVs2CNGb8n943fVkxGkYS?=
 =?iso-8859-1?Q?JmtqtXztlHizoAKlEftJYfeehs1qEgom/nuOIntujwYr6Kjb/aEG+nH4KO?=
 =?iso-8859-1?Q?X0p/qqU2BDTrDcuvktFlDcz2Ybes61aK7jHjW7bWZI4lKH2JzeJ4IMk671?=
 =?iso-8859-1?Q?Vp/+8WS3XeIy+llUiXdAXQzPN8mKlJYf4v5h/0e9bznq1H8awgVMJdw2S8?=
 =?iso-8859-1?Q?9NSagVB5LhOYYLAlSsItQs1HXjqSXOfVymrJkpdQMLUyrnxa0w15xGPBHR?=
 =?iso-8859-1?Q?T744nmvBRl5cgBa4H1LIP0wVtsAIovt8GUR8ekAVCGSK3nAQb4ujp93DDE?=
 =?iso-8859-1?Q?2ryiB+owd23AB5XZezomkYl94gdQE3xG1bcTGk80HCU4366B0Jmo1Cwonp?=
 =?iso-8859-1?Q?TvvZwrI769hPW/WraXfZQdn26pGyXGBNu6iEcZw/Z7DWikpcCnH/zGmIMP?=
 =?iso-8859-1?Q?klXjX1NWQ03kczWX/qlMvNSpzwc6cJva2JxvyQ/csScMqoN4BvfITGd+Ro?=
 =?iso-8859-1?Q?9kxPtDfVe9ipJs+WjBCW7f0jmAoAITc2q5k5qOcms9sZAURd9lHoATDvjg?=
 =?iso-8859-1?Q?uCR4ynud7RzBdltLUBW0mi4RvmNOFyt62IUZMZE/HWWAoA0mglzFL+B/Ta?=
 =?iso-8859-1?Q?+m87XD/NsA9TpfEZIOMPiGyMZvIA4x5L4/xgaF/1Hs+YbE+CzFcdyGB07a?=
 =?iso-8859-1?Q?h0nlHhbeXhSmC0XLpojUQvZ8eekFmelmZCrBE3rvoc4JpLwCQB1XSKnibD?=
 =?iso-8859-1?Q?XqK4KrQx675hF2yrLyLuAhzWmHVKm19jl1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 370f0b9e-2cd0-435e-2db8-08ddcabe848f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 14:29:37.6496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJsu0KCOJ014v8QdjI5gJgFB5cSjGJ1iJgRCu1KS4lVOKC6vH1b0/oUjnKwoMzNkTrLFgoAqkd9Cg5mEB0Wcdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8603

On Thu, Jul 24, 2025 at 02:09:51PM +0530, Lakshay Piplani wrote:
> Add support for the NXP P3T175x (P3T1755/P3T1750)
> family of temperature sensor devices. These devices
> communicates via both I2C or I3C interfaces.
>
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> ---
>  drivers/iio/temperature/p3t/Kconfig        |  89 ++++
>  drivers/iio/temperature/p3t/Makefile       |   5 +
>  drivers/iio/temperature/p3t/p3t1755.h      |  60 +++
>  drivers/iio/temperature/p3t/p3t1755_core.c | 513 +++++++++++++++++++++
>  drivers/iio/temperature/p3t/p3t1755_i2c.c  | 142 ++++++
>  drivers/iio/temperature/p3t/p3t1755_i3c.c  | 147 ++++++
>  6 files changed, 956 insertions(+)
>  create mode 100644 drivers/iio/temperature/p3t/Kconfig
>  create mode 100644 drivers/iio/temperature/p3t/Makefile
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755.h
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755_core.c
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755_i2c.c
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755_i3c.c

use module_i3c_i2c_driver(p3t1085_driver, &tmp108_driver) to register
both i2c and i3c device. Only file should be enough

See:

 https://lore.kernel.org/imx/20241112-p3t1085-v4-2-a1334314b1e6@nxp.com/

Does p3t1755 similar with p3t1085?

Frank Li

>
> diff --git a/drivers/iio/temperature/p3t/Kconfig b/drivers/iio/temperature/p3t/Kconfig
> new file mode 100644
> index 000000000000..258ff77a0b2d
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/Kconfig
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menuconfig IIO_P3T1755
> +	tristate "NXP P3T1755 temperature sensor support"
> +	help
> +	  Enable support for the NXP P3T1755 digital temperature sensor family.
> +
> +	  The P3T1755 is a high-accuracy temperature sensor with programmable
> +	  alert limits and fault queue settings. It supports both I2C and I3C
> +	  interfaces for communication and can be used in a variety of embedded
> +	  and industrial applications where precise thermal monitoring is required.
> +
> +	  This option enables common functionality shared across all supported
> +	  variants and interfaces. You must also select the appropriate interface
> +	  (I2C or I3C) and corresponding driver to enable full support
> +
> +
> +if IIO_P3T1755
> +
> +choice
> +	prompt "Interface for P3T1755"
> +	help
> +	  Select the hardware interface used to communicate with the NXP P3T1755
> +	  temperature sensor.
> +
> +	  The P3T1755 supports both I2C and I3C interfaces. Choose the interface
> +	  that matches your hardware configuration. Only one interface can be
> +	  selected at a time. You must also enable the corresponding driver option
> +	  to build support for the selected interface
> +
> +
> +config IIO_P3T1755_I2C
> +	bool "Use I2C interface"
> +	depends on I2C
> +	help
> +	  Select this option if the P3T1755 temperature sensor is connected via
> +	  the I2C bus.
> +
> +	  This enables support for configuring and communicating with the sensor
> +	  over the I2C interface. You must also enable the corresponding I2C driver
> +	  (IIO_P3T1755_I2C_DRIVER) to build full support for this interface.
> +
> +
> +config IIO_P3T1755_I3C
> +	bool "Use I3C interface"
> +	depends on I3C
> +	help
> +	  Select this option if the P3T1755 temperature sensor is connected via
> +	  the I3C bus.
> +
> +	  This enables support for configuring and communicating with the sensor
> +	  over the I3C interface. I3C offers improved performance and lower power
> +	  consumption compared to I2C, making it suitable for advanced applications.
> +
> +	  You must also enable the corresponding I3C driver (IIO_P3T1755_I3C_DRIVER)
> +	  to build full support for this interface.
> +
> +endchoice
> +
> +config IIO_P3T1755_I2C_DRIVER
> +	tristate "Build I2C driver"
> +	depends on IIO_P3T1755_I2C
> +	select REGMAP_I2C
> +	help
> +	  Enable this option to build the I2C driver for the NXP P3T1755 temperature sensor.
> +
> +	  This driver provides support for communication with the P3T1755 sensor
> +	  over the I2C bus, allowing temperature data to be read and configuration
> +	  registers to be accessed via the Industrial I/O (IIO) subsystem.
> +
> +	  Select this if your hardware connects the sensor using I2C and you want
> +	  to include the driver either built-in or as a loadable module.
> +
> +
> +config IIO_P3T1755_I3C_DRIVER
> +	tristate "Build I3C driver"
> +	depends on IIO_P3T1755_I3C
> +	select REGMAP_I3C
> +	help
> +	  Enable this option to build the I3C driver for the NXP P3T1755 temperature sensor.
> +
> +	  This driver provides support for communication with the P3T1755 sensor
> +	  over the I3C bus, allowing temperature readings and configuration access
> +	  through the Industrial I/O (IIO) subsystem.
> +
> +	  Select this if your hardware connects the sensor using I3C and you want
> +	  to include the driver either built-in or as a loadable module
> +
> +endif
> diff --git a/drivers/iio/temperature/p3t/Makefile b/drivers/iio/temperature/p3t/Makefile
> new file mode 100644
> index 000000000000..7d33b507f1f1
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_IIO_P3T1755) += p3t1755_core.o
> +obj-$(CONFIG_IIO_P3T1755_I2C) += p3t1755_i2c.o
> +obj-$(CONFIG_IIO_P3T1755_I3C) += p3t1755_i3c.o
> diff --git a/drivers/iio/temperature/p3t/p3t1755.h b/drivers/iio/temperature/p3t/p3t1755.h
> new file mode 100644
> index 000000000000..d71a78460239
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * NXP P3T175x Temperature Sensor Driver
> + *
> + * Copyright 2025 NXP
> + */
> +#ifndef P3T1755_H
> +#define P3T1755_H
> +
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +
> +#define P3T1755_REG_TEMP		0x0
> +#define P3T1755_REG_CFGR		0x1
> +#define P3T1755_REG_LOW_LIM		0x2
> +#define P3T1755_REG_HIGH_LIM		0x3
> +
> +#define P3T1755_SHUTDOWN_BIT		BIT(0)
> +#define P3T1755_TM_BIT			BIT(1)
> +#define P3T1755_POL_BIT			BIT(2)
> +#define P3T1755_R0_BIT			BIT(5)
> +#define P3T1755_R1_BIT			BIT(6)
> +#define P3T1755_ONE_SHOT_BIT		BIT(7)
> +
> +#define P3T1755_FAULT_QUEUE_SHIFT	3
> +#define P3T1755_FAULT_QUEUE_MASK	GENMASK(4, 3)
> +
> +#define P3T1755_RESOLUTION_10UC		62500
> +
> +extern const struct p3t17xx_info p3t1755_channels_info;
> +extern const struct p3t17xx_info p3t1750_channels_info;
> +extern const struct p3t17xx_info p3t175x_channels_info;
> +
> +enum p3t1755_hw_id {
> +	P3T1755_ID = 0,
> +	P3T1750_ID,
> +};
> +
> +struct p3t17xx_info {
> +	const char *name;
> +	const struct iio_chan_spec *channels;
> +	int num_channels;
> +};
> +
> +/* Device-specific data structure */
> +struct p3t1755_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	bool tm_mode;
> +	bool alert_active_high;
> +};
> +
> +int p3t1755_fault_queue_to_bits(int val);
> +int p3t1755_probe(struct device *dev, const struct p3t17xx_info *chip,
> +		  struct regmap *regmap, bool tm_mode, bool alert_active_high, int fq_bits);
> +int p3t1755_get_temp_and_limits(struct p3t1755_data *data,
> +				int *temp_mc, int *thigh_mc, int *tlow_mc);
> +void p3t1755_push_thresh_event(struct iio_dev *indio_dev);
> +
> +#endif /* P3T1755_H */
> diff --git a/drivers/iio/temperature/p3t/p3t1755_core.c b/drivers/iio/temperature/p3t/p3t1755_core.c
> new file mode 100644
> index 000000000000..8ffa7bb09ca5
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755_core.c
> @@ -0,0 +1,513 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NXP P3T175x Temperature Sensor Driver
> + *
> + * Copyright 2025 NXP
> + */
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/regmap.h>
> +#include <linux/device.h>
> +#include <linux/limits.h>
> +#include <linux/iio/events.h>
> +
> +#include "p3t1755.h"
> +
> +// Internal attribute enum for custom sysfs handlers
> +enum p3t1755_attr_index {
> +	P3T1755_ATTR_THERMOSTAT_MODE,
> +	P3T1755_ATTR_TRIGGER_ONE_SHOT,
> +	P3T1755_ATTR_FAULT_QUEUE_LENGTH,
> +};
> +
> +// Conversion rate table: maps bits to sampling frequency
> +static const struct {
> +	u8 bits;
> +	int freq_hz;
> +} p3t1755_samp_freqs[] = {
> +	{ 0x00, 36 }, // 27.5 ms
> +	{ 0x01, 18 }, // 55 ms (default)
> +	{ 0x02, 9 }, // 110 ms
> +	{ 0x03, 4 }, // 220 ms
> +};
> +
> +// Fault Queue values supported by hardware
> +static const int p3t1755_fault_queue_values[] = { 1, 2, 4, 6 };
> +
> +int p3t1755_fault_queue_to_bits(int val)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(p3t1755_fault_queue_values); i++)
> +		if (p3t1755_fault_queue_values[i] == val)
> +			return i;
> +	return -EINVAL;
> +}
> +
> +int p3t1755_get_temp_and_limits(struct p3t1755_data *data,
> +				int *temp_mc, int *thigh_mc, int *tlow_mc)
> +{
> +	u8 buf[2];
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, buf, 2);
> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to read TEMP register: %d\n", ret);
> +		return ret;
> +	}
> +	*temp_mc = (((buf[0] << 8) | buf[1]) >> 4) * P3T1755_RESOLUTION_10UC / 1000;
> +	dev_dbg(data->dev, "TEMP raw: 0x%02x%02x, temp_mc: %d\n",
> +		buf[0], buf[1], *temp_mc);
> +
> +	ret = regmap_bulk_read(data->regmap, P3T1755_REG_HIGH_LIM, buf, 2);
> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to read HIGH_LIM register: %d\n", ret);
> +		return ret;
> +	}
> +	*thigh_mc = (((buf[0] << 8) | buf[1]) >> 4) * P3T1755_RESOLUTION_10UC / 1000;
> +	dev_dbg(data->dev, "HIGH_LIM raw: 0x%02x%02x, thigh_mc: %d\n",
> +		buf[0], buf[1], *thigh_mc);
> +
> +	ret = regmap_bulk_read(data->regmap, P3T1755_REG_LOW_LIM, buf, 2);
> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to read LOW_LIM register: %d\n", ret);
> +		return ret;
> +	}
> +	*tlow_mc = (((buf[0] << 8) | buf[1]) >> 4) * P3T1755_RESOLUTION_10UC / 1000;
> +	dev_dbg(data->dev, "LOW_LIM raw: 0x%02x%02x, tlow_mc: %d\n",
> +		buf[0], buf[1], *tlow_mc);
> +
> +	dev_dbg(data->dev, "Successfully read all temperature values\n");
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(p3t1755_get_temp_and_limits, IIO_P3T1755);
> +
> +void p3t1755_push_thresh_event(struct iio_dev *indio_dev)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	enum iio_event_direction dir;
> +	int ret, temp, thigh, tlow;
> +	unsigned int cfgr;
> +
> +	/* Read CFGR register to both check device mode
> +	 * and implicitly clear the ALERT latch.
> +	 * As per Datasheet: "Any register read will
> +	 * clear the interrupt"
> +	 */
> +	ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr);
> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to read CFGR register: %d\n", ret);
> +		return;
> +	}
> +
> +	if (cfgr & P3T1755_SHUTDOWN_BIT) {
> +		dev_dbg(data->dev, "Device is in shutdown mode, skipping event push\n");
> +		return;
> +	}
> +
> +	ret = p3t1755_get_temp_and_limits(data, &temp, &thigh, &tlow);
> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to get temperature and limits: %d\n", ret);
> +		return;
> +	}
> +
> +	// Determine event direction based on threshold crossing
> +	if (temp >= thigh) {
> +		dir = IIO_EV_DIR_RISING;
> +	} else if (temp <= tlow) {
> +		dir = IIO_EV_DIR_FALLING;
> +	} else {
> +		dev_dbg(data->dev, "Temperature within limits: no event triggered (T=%d, TH=%d, TL=%d)\n",
> +			temp, thigh, tlow);
> +		return;
> +		}
> +
> +	dev_dbg(data->dev, "Threshold event: %s (T=%d, TH=%d, TL=%d)\n",
> +		dir == IIO_EV_DIR_RISING ? "RISING" : "FALLING",
> +		temp, thigh, tlow);
> +
> +	iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_TEMP, 0, IIO_NO_MOD,
> +						     IIO_EV_TYPE_THRESH, dir),
> +		       iio_get_time_ns(indio_dev));
> +}
> +EXPORT_SYMBOL_NS_GPL(p3t1755_push_thresh_event, IIO_P3T1755);
> +
> +static int p3t1755_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	u8 buf[2];
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		// Read raw 12-bit temperature register (two bytes)
> +		ret = regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, buf, 2);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read temperature register\n");
> +			return ret;
> +		}
> +		*val = ((buf[0] << 8) | buf[1]) >> 4;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_ENABLE:
> +		// Read configuration register to check shutdown bit
> +		ret = regmap_read(data->regmap, P3T1755_REG_CFGR, val);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read configuration register\n");
> +			return ret;
> +		}
> +		dev_dbg(data->dev, "Read CONFIG: 0x%02x\n", *val);
> +		*val = !(*val & P3T1755_SHUTDOWN_BIT); // Return 1 if enabled, 0 if shutdown
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		// Read temperature and convert to celsius using resolution
> +		ret = regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, buf, 2);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read temperature register\n");
> +			return ret;
> +		}
> +		*val = (((buf[0] << 8) | buf[1]) >> 4) *
> +		       P3T1755_RESOLUTION_10UC / 1000;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		unsigned int cfgr;
> +		int ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr);
> +
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read configuration register\n");
> +			return ret;
> +		}
> +
> +		u8 sel = (cfgr >> 5) & 0x03; // Extract R1:R0 sampling rate bits
> +
> +		if (sel >= ARRAY_SIZE(p3t1755_samp_freqs))
> +			return -EINVAL;
> +
> +		*val = p3t1755_samp_freqs[sel].freq_hz;
> +		return IIO_VAL_INT;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int p3t1755_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		// Toggle shutdown bit to enable/disable sensor
> +		ret = regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +					 P3T1755_SHUTDOWN_BIT,
> +					 val == 0 ? P3T1755_SHUTDOWN_BIT : 0);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to update SHUTDOWN bit\n");
> +			return ret;
> +		}
> +		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		u8 sel = 0xFF;
> +
> +		// Match desired frequency with supported values
> +		for (int i = 0; i < ARRAY_SIZE(p3t1755_samp_freqs); i++) {
> +			if (p3t1755_samp_freqs[i].freq_hz == val) {
> +				sel = i;
> +				break;
> +			}
> +		}
> +		if (sel == 0xFF)
> +			return -EINVAL;
> +
> +		// Update conversion rate bits R1:R0 in CFGR register
> +		return regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +					  P3T1755_R0_BIT | P3T1755_R1_BIT,
> +					  sel << 5);
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int p3t1755_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int *val,
> +				    int *val2)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	unsigned int reg;
> +	u8 buf[2];
> +	int ret;
> +
> +	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	/* Select high or low limit register based on direction */
> +	reg = (dir == IIO_EV_DIR_RISING) ? P3T1755_REG_HIGH_LIM :
> +					   P3T1755_REG_LOW_LIM;
> +
> +	/* Convert raw register value to temperature in milli°C */
> +	ret = regmap_bulk_read(data->regmap, reg, buf, 2);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Failed to read Thigh or Tlow register\n");
> +		return ret;
> +	}
> +	*val = (((buf[0] << 8) | buf[1]) >> 4) * P3T1755_RESOLUTION_10UC / 1000;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int p3t1755_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info, int val,
> +				     int val2)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	unsigned int reg;
> +	u8 buf[2];
> +	int regval;
> +
> +	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	/* Select high or low limit register based on direction */
> +	reg = (dir == IIO_EV_DIR_RISING) ? P3T1755_REG_HIGH_LIM :
> +					   P3T1755_REG_LOW_LIM;
> +
> +	/* Convert temperature in milli°C to register format */
> +	regval = DIV_ROUND_CLOSEST(val * 1000, P3T1755_RESOLUTION_10UC) << 4;
> +	buf[0] = regval >> 8;
> +	buf[1] = regval & 0xff;
> +
> +	return regmap_bulk_write(data->regmap, reg, buf, 2);
> +}
> +
> +static int p3t1755_trigger_one_shot(struct p3t1755_data *data)
> +{
> +	unsigned int config;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &config);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Failed to read configuration register\n");
> +		return ret;
> +	}
> +
> +	/* One-shot mode is only allowed when the device is in shutdown mode */
> +	if (!(config & P3T1755_SHUTDOWN_BIT))
> +		return -EBUSY;
> +	/* Set the one-shot bit to trigger a single temperature conversion */
> +	config |= P3T1755_ONE_SHOT_BIT;
> +
> +	return regmap_write(data->regmap, P3T1755_REG_CFGR, config);
> +}
> +
> +static ssize_t p3t1755_attr_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	switch (iattr->address) {
> +	case P3T1755_ATTR_THERMOSTAT_MODE:
> +		/* Read TM bit from configuration register */
> +		ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &val);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read configuration register\n");
> +			return ret;
> +		}
> +		return sysfs_emit(buf, "%d\n", !!(val & P3T1755_TM_BIT));
> +	case P3T1755_ATTR_FAULT_QUEUE_LENGTH:
> +		/* Read fault queue length bits and map to user-visible value */
> +		ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &val);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Failed to read configuration register\n");
> +			return ret;
> +		}
> +		val = (val & P3T1755_FAULT_QUEUE_MASK) >> P3T1755_FAULT_QUEUE_SHIFT;
> +		if (val > 3)
> +			return -EINVAL;
> +		return sysfs_emit(buf, "%d\n", p3t1755_fault_queue_values[val]);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t p3t1755_attr_store(struct device *dev, struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	int ret, val;
> +	bool enable;
> +
> +	switch (iattr->address) {
> +	case P3T1755_ATTR_TRIGGER_ONE_SHOT:
> +		/* Trigger a one-shot conversion if input is '1' */
> +		ret = kstrtobool(buf, &enable);
> +		if (ret || !enable)
> +			return ret ? ret : -EINVAL;
> +		ret = p3t1755_trigger_one_shot(data);
> +		return ret ?: count;
> +	case P3T1755_ATTR_FAULT_QUEUE_LENGTH:
> +		/* Set fault queue length if input matches supported values */
> +		ret = kstrtoint(buf, 10, &val);
> +		if (ret)
> +			return ret;
> +		for (int i = 0; i < ARRAY_SIZE(p3t1755_fault_queue_values); i++) {
> +			if (val == p3t1755_fault_queue_values[i]) {
> +				ret = regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +							 P3T1755_FAULT_QUEUE_MASK,
> +							 i << P3T1755_FAULT_QUEUE_SHIFT);
> +				return ret ?: count;
> +			}
> +		}
> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +		}
> +	}
> +
> +static IIO_DEVICE_ATTR(thermostat_mode, 0444, p3t1755_attr_show,
> +		NULL, P3T1755_ATTR_THERMOSTAT_MODE);
> +
> +static IIO_DEVICE_ATTR(trigger_one_shot, 0200, NULL, p3t1755_attr_store,
> +		P3T1755_ATTR_TRIGGER_ONE_SHOT);
> +
> +static IIO_DEVICE_ATTR(fault_queue_length, 0664, p3t1755_attr_show,
> +		p3t1755_attr_store, P3T1755_ATTR_FAULT_QUEUE_LENGTH);
> +
> +static const struct iio_event_spec p3t1755_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE)
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE)
> +	},
> +};
> +
> +static const struct iio_chan_spec p3t175x_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_ENABLE) |
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.event_spec = p3t1755_events,
> +		.num_event_specs = ARRAY_SIZE(p3t1755_events),
> +	},
> +};
> +
> +const struct p3t17xx_info p3t1755_channels_info = {
> +	.name = "p3t1755",
> +	.channels = p3t175x_channels,
> +	.num_channels = ARRAY_SIZE(p3t175x_channels)
> +};
> +EXPORT_SYMBOL_NS(p3t1755_channels_info, IIO_P3T1755);
> +
> +const struct p3t17xx_info p3t1750_channels_info = {
> +	.name = "p3t1750",
> +	.channels = p3t175x_channels,
> +	.num_channels = ARRAY_SIZE(p3t175x_channels)
> +};
> +EXPORT_SYMBOL_NS(p3t1750_channels_info, IIO_P3T1755);
> +
> +const struct p3t17xx_info p3t175x_channels_info = {
> +	.name = "p3t175x",
> +	.channels = p3t175x_channels,
> +	.num_channels = ARRAY_SIZE(p3t175x_channels)
> +};
> +EXPORT_SYMBOL_NS(p3t175x_channels_info, IIO_P3T1755);
> +
> +static struct attribute *p3t1755_attributes[] = {
> +	&iio_dev_attr_thermostat_mode.dev_attr.attr,
> +	&iio_dev_attr_trigger_one_shot.dev_attr.attr,
> +	&iio_dev_attr_fault_queue_length.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group p3t1755_attr_group = {
> +	.attrs = p3t1755_attributes,
> +};
> +
> +static const struct iio_info p3t1755_info = {
> +	.read_raw = p3t1755_read_raw,
> +	.write_raw = p3t1755_write_raw,
> +	.read_event_value = p3t1755_read_event_value,
> +	.write_event_value = p3t1755_write_event_value,
> +	.attrs = &p3t1755_attr_group,
> +};
> +
> +int p3t1755_probe(struct device *dev, const struct p3t17xx_info *chip,
> +		  struct regmap *regmap, bool tm_mode, bool alert_active_high, int fq_bits)
> +{
> +	struct p3t1755_data *data;
> +	struct iio_dev *iio_dev;
> +	int ret;
> +
> +	iio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio_dev);
> +	data->dev = dev;
> +	data->regmap = regmap;
> +	data->tm_mode = tm_mode;
> +	data->alert_active_high = alert_active_high;
> +
> +	iio_dev->name = chip->name;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->info = &p3t1755_info;
> +	iio_dev->channels = chip->channels;
> +	iio_dev->num_channels = chip->num_channels;
> +
> +	dev_set_drvdata(dev, iio_dev);
> +
> +	/* Configure thermostat mode and alert polarity and (optional) fault queue */
> +	ret = regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +				 P3T1755_TM_BIT | P3T1755_POL_BIT,
> +				(tm_mode ? P3T1755_TM_BIT : 0) |
> +				(alert_active_high ? P3T1755_POL_BIT : 0));
> +	if (ret) {
> +		dev_err_probe(data->dev, ret, "Failed to update TM and POL bits\n");
> +		return ret;
> +	}
> +
> +	if (fq_bits >= 0) /* -1 means "leave reset default" */
> +		regmap_update_bits(data->regmap, P3T1755_REG_CFGR, P3T1755_FAULT_QUEUE_MASK,
> +				   fq_bits << P3T1755_FAULT_QUEUE_SHIFT);
> +
> +	ret = devm_iio_device_register(dev, iio_dev);
> +	if (ret)
> +		dev_info(dev, "Temperature sensor failed to register: %d\n", ret);
> +	else
> +		dev_info(dev, "Temperature sensor registered successfully\n");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS(p3t1755_probe, IIO_P3T1755);
> +
> +MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
> +MODULE_DESCRIPTION("NXP P3T175x Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/temperature/p3t/p3t1755_i2c.c b/drivers/iio/temperature/p3t/p3t1755_i2c.c
> new file mode 100644
> index 000000000000..3be8bc8b5e2d
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755_i2c.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NXP P3T175x Temperature Sensor Driver
> + *
> + * Copyright 2025 NXP
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
> +
> +#include "p3t1755.h"
> +
> +static const struct regmap_config p3t1755_i2c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static irqreturn_t p3t1755_irq_handler(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +
> +	dev_dbg(&indio_dev->dev, "IRQ triggered, processing threshold event\n");
> +
> +	// Handle threshold event via helper
> +	p3t1755_push_thresh_event(indio_dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct of_device_id p3t1755_i2c_of_match[] = {
> +	{ .compatible = "nxp,p3t1755", .data = &p3t1755_channels_info },
> +	{ .compatible = "nxp,p3t1750", .data = &p3t1750_channels_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, p3t1755_i2c_of_match);
> +
> +static const struct i2c_device_id p3t1755_i2c_id_table[] = {
> +	{ "p3t1755", (kernel_ulong_t)&p3t1755_channels_info },
> +	{ "p3t1750", (kernel_ulong_t)&p3t1750_channels_info},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, p3t1755_i2c_id_table);
> +
> +static int p3t1755_i2c_probe(struct i2c_client *client)
> +{
> +	struct device_node *np = client->dev.of_node;
> +	bool alert_active_high = false;
> +	const struct p3t17xx_info *chip;
> +	struct p3t1755_data *data;
> +	struct iio_dev *iio_dev;
> +	unsigned long irq_flags;
> +	struct regmap *regmap;
> +	bool tm_mode = false;
> +	int fq_bits = -1;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(client, &p3t1755_i2c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err_probe(&client->dev, PTR_ERR(regmap),
> +			      "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	/* Parse optional device tree property for alert polarity */
> +	alert_active_high = of_property_read_bool(np, "nxp,alert-active-high");
> +
> +	/* Parse optional device tree property for thermostat mode */
> +	tm_mode = of_property_read_bool(np, "nxp,interrupt-mode");
> +
> +	/* Optional fault queue length */
> +	if (np) {
> +		u32 fq;
> +
> +		if (!of_property_read_u32(np, "nxp,fault-queue", &fq)) {
> +			fq_bits = p3t1755_fault_queue_to_bits(fq);
> +			if (fq_bits < 0) {
> +				dev_err_probe(&client->dev, fq_bits,
> +					      "invalid nxp,fault-queue %u (1/2/4/6)\n", fq);
> +				return fq_bits;
> +			}
> +		}
> +	}
> +
> +	dev_info(&client->dev, "Using TM mode: %s\n",
> +		 tm_mode ? "Interrupt" : "Comparator");
> +	dev_info(&client->dev, "Alert polarity: %s\n",
> +		 alert_active_high ? "Active-High" : "Active-Low");
> +
> +	chip = device_get_match_data(&client->dev);
> +	if (!chip)
> +		chip = (const struct p3t17xx_info *)i2c_match_id(p3t1755_i2c_id_table,
> +			client)->driver_data;
> +
> +	dev_info(&client->dev, "Registering p3t175x temperature sensor");
> +
> +	ret = p3t1755_probe(&client->dev, chip, regmap,
> +			    tm_mode, alert_active_high, fq_bits);
> +
> +	if (ret) {
> +		dev_err_probe(&client->dev, ret, "p3t175x probe failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Setup IRQ if available */
> +	if (client->irq > 0) {
> +		iio_dev = dev_get_drvdata(&client->dev);
> +		data = iio_priv(iio_dev);
> +
> +		if (tm_mode)
> +			irq_flags = alert_active_high ? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
> +		else
> +			irq_flags = (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING);
> +
> +		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +						p3t1755_irq_handler, irq_flags | IRQF_ONESHOT,
> +						"p3t175x", iio_dev);
> +		if (ret)
> +			dev_err_probe(&client->dev, ret, "Failed to request IRQ: %d\n", ret);
> +		}
> +
> +		return ret;
> +}
> +
> +static struct i2c_driver p3t1755_driver = {
> +	.driver = {
> +		.name = "p3t175x_i2c",
> +		.of_match_table = p3t1755_i2c_of_match,
> +	},
> +	.probe = p3t1755_i2c_probe,
> +	.id_table = p3t1755_i2c_id_table,
> +};
> +module_i2c_driver(p3t1755_driver);
> +
> +MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
> +MODULE_DESCRIPTION("NXP P3T175x I2C Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_P3T1755);
> diff --git a/drivers/iio/temperature/p3t/p3t1755_i3c.c b/drivers/iio/temperature/p3t/p3t1755_i3c.c
> new file mode 100644
> index 000000000000..37e782241c9a
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755_i3c.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NXP P3T175x Temperature Sensor Driver
> + *
> + * Copyright 2025 NXP
> + */
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
> +
> +#include "p3t1755.h"
> +
> +static void p3t1755_ibi_handler(struct i3c_device *dev,
> +				const struct i3c_ibi_payload *payload)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(&dev->dev);
> +
> +	dev_dbg(&dev->dev, "IBI received, handling threshold event\n");
> +
> +	// Handle threshold event via helper
> +	p3t1755_push_thresh_event(indio_dev);
> +}
> +
> +/*
> + * Both P3T1755 and P3T1750 share the same I3C
> + * PID (0x011B:0x152A), making runtime differentiation
> + * impossible, so a common "p3t175x" name in sysfs
> + * and IIO for I3C based instances.
> + */
> +static const struct i3c_device_id p3t1755_i3c_ids[] = {
> +	I3C_DEVICE(0x011B, 0x152A, (void *)&p3t175x_channels_info),
> +	{ /* sentinel */ },
> +};
> +
> +MODULE_DEVICE_TABLE(i3c, p3t1755_i3c_ids);
> +
> +static int p3t1755_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	const struct regmap_config p3t1755_i3c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	};
> +
> +	const struct i3c_device_id *id = i3c_device_match_id(i3cdev, p3t1755_i3c_ids);
> +	const struct p3t17xx_info *chip = &p3t175x_channels_info;
> +	struct device_node *np = i3cdev->dev.of_node;
> +	bool alert_active_high = false;
> +	struct i3c_ibi_setup ibi_setup;
> +	struct regmap *regmap;
> +	bool tm_mode = false;
> +	int fq_bits = -1;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &p3t1755_i3c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err_probe(&i3cdev->dev, PTR_ERR(regmap),
> +			      "Failed to register I3C regmap %ld\n", PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	/* Parse optional device tree property for alert polarity */
> +	alert_active_high = of_property_read_bool(np, "nxp,alert-active-high");
> +
> +	/* Parse optional device tree property for thermostat mode */
> +	tm_mode = of_property_read_bool(np, "nxp,interrupt-mode");
> +
> +	/* Optional fault queue length */
> +	if (np) {
> +		u32 fq;
> +
> +		if (!of_property_read_u32(np, "nxp,fault-queue", &fq)) {
> +			fq_bits = p3t1755_fault_queue_to_bits(fq);
> +			if (fq_bits < 0) {
> +				dev_err_probe(&i3cdev->dev, fq_bits,
> +					      "invalid nxp,fault-queue %u (1/2/4/6)\n", fq);
> +				return fq_bits;
> +			}
> +		}
> +	}
> +
> +	dev_info(&i3cdev->dev, "Using TM mode: %s\n", tm_mode ? "Interrupt" : "Comparator");
> +	dev_info(&i3cdev->dev, "Alert polarity: %s\n",
> +		 alert_active_high ? "Active-High" : "Active-Low");
> +
> +	if (id && id->data)
> +		chip = (const struct p3t17xx_info *)id->data;
> +
> +	ret = p3t1755_probe(&i3cdev->dev, chip, regmap, tm_mode, alert_active_high, fq_bits);
> +	if (ret) {
> +		dev_err_probe(&i3cdev->dev, ret, "p3t175x probe failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!tm_mode) {
> +		dev_warn(&i3cdev->dev, "IBI not supported in comparator mode, skipping IBI registration\n");
> +		return 0;
> +	}
> +
> +	ibi_setup.handler = p3t1755_ibi_handler;
> +	ibi_setup.num_slots = 4;
> +	ibi_setup.max_payload_len = 0;
> +
> +	ret = i3c_device_request_ibi(i3cdev, &ibi_setup);
> +	if (ret) {
> +		dev_err_probe(&i3cdev->dev, ret, "Failed to request IBI: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = i3c_device_enable_ibi(i3cdev);
> +	if (ret) {
> +		dev_err_probe(&i3cdev->dev, ret, "Failed to enable IBI: %d\n", ret);
> +		i3c_device_free_ibi(i3cdev);
> +		return ret;
> +	}
> +
> +	dev_info(&i3cdev->dev, "IBI successfully registered\n");
> +	return 0;
> +}
> +
> +static void p3t1755_i3c_remove(struct i3c_device *i3cdev)
> +{
> +	/* Unwind IBI registration to ensure clean shutdown */
> +	i3c_device_disable_ibi(i3cdev);
> +	i3c_device_free_ibi(i3cdev);
> +}
> +
> +static struct i3c_driver p3t1755_driver = {
> +	.driver = {
> +		.name = "p3t175x_i3c",
> +	},
> +	.probe = p3t1755_i3c_probe,
> +	.remove = p3t1755_i3c_remove,
> +	.id_table = p3t1755_i3c_ids,
> +};
> +module_i3c_driver(p3t1755_driver);
> +
> +MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
> +MODULE_DESCRIPTION("NXP P3T175x I3C Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_P3T1755);
> --
> 2.25.1
>

