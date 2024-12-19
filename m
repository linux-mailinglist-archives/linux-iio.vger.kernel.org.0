Return-Path: <linux-iio+bounces-13685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31389F8410
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 20:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828EF189241C
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 19:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FAE1AA78C;
	Thu, 19 Dec 2024 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b="L4K6eUnq"
X-Original-To: linux-iio@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020081.outbound.protection.outlook.com [52.101.189.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA1D19E985;
	Thu, 19 Dec 2024 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636161; cv=fail; b=tB7Z27s1EcY+H1IJf/wrBxNm+/OOaW107/8LQwKXzEf3VLgSRwt/LefVSUyeRdFU1yCv0DJvvgV8Kr1NfJmvO1zzSZ+wjcYYm2MqikCHww7T7f3F0GDjYB4i0+I8MPP4JkBB1H3KN/ytXtiSwULILAysbd9uvgdl+g291RNKM5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636161; c=relaxed/simple;
	bh=TMAbHoSC02nGeKZCZdtzMnKUs+nx9EywfyapJFRMej8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xi5SAdNHMLa2lCww/jnXahkZmA0p5t76y1NATrxSfzXS65w23ushpO6A7QgD7Qul2g007i1AEPFO+PcpO6ylE7AnOP5KG4+huNcETSL8F+s2hjBmS/cxCqvHcf9OOomdiGg6dbMv7ABz1bHOISDVuiGk5YJEZwcGcrjLwg9GjNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com; spf=pass smtp.mailfrom=dimonoff.com; dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b=L4K6eUnq; arc=fail smtp.client-ip=52.101.189.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dimonoff.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEvALUWekvw+4MoLqLQbpzk7nzTNtcS5VIYwqXD2iFjv/wXdo7P/AMy7h5g2YuY+pYMiwSW/HFHsHPFSlOO/bR8Avo64zfZT3C9C47SoHGoLXDNQYPM+f4AphZXnEIDOTkUXYqlzZBV8HwhNbyjWIcBXlb1CALCv0k5U/QmlkkD2ulbNihcwUHu6+Gra/S4TNBRgRUCiq6SBH2lSfYjr5nhBknMClkBbmsmzot3dcMO/A4ZZlOqUiod2wySEgZ+ynblfBOshNhhi8KamrsRGv5+coAOSuYTIQNqGKc/4NJPaFFd/8GlzGArbP+f4KHRMIehzUW3JtSSr2IC5yikncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQJY5MdU9/3Uvh180k+XcjUDafJf/rCQwDdrAgrevwY=;
 b=sP2JuNHDd61HOBvRGN7223198L3l/Zx1Ib1Z8buYAj+cfM/MmTOMJYzzvs7t0coT8cnB8tjyhv5aklUTpATxncMGgNN1hycZbwdCJpraVEla7gUGeahWN/a6ALm/feMyrns2pfI87DztxMU7grpbpcRS+gqSuz4fLmUnbNytCgRTpsqbTbo2KNCHL8V4YaTera0hwAoTpN6DrWCvO1we4/TAekSeggRgKynnnZs5SeoeYmwET/S0/vQHa9VaOQWa9XumUHySBGwfsz4JOvr/xLXY84cWg2UItqYRjvXm/X5DnDIIbhkdpwRImkuZkBjzzIpfk6u+/C0uH6EB0/8Uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=dimonoff.com;
 dkim=pass header.d=dimonoff.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimonoff.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQJY5MdU9/3Uvh180k+XcjUDafJf/rCQwDdrAgrevwY=;
 b=L4K6eUnqbNrYZbvYpfix4GZSSAQYxnUFlQT5B8N4SJAffy5idPlD9zHKtSMc75wWcTsuqWhPkvwZz+ikNKEdm3ACvhFaX53pJX5/5c3dg1YX9xt/0aOCpkilxRdrPF3HmfJ5nCN0uW/juQFczlvXn/gJBs0vKSJS0LpDDQb5Fcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dimonoff.com;
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20) by YQBPR0101MB8238.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:51::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 19:22:35 +0000
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39]) by YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39%4]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 19:22:35 +0000
Date: Thu, 19 Dec 2024 14:22:28 -0500
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
Subject: Re: [PATCH v3 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <Z2RydCiREUYQPLtz@uva.nl>
References: <20241216-apds9160-driver-v3-0-c29f6c670bdb@dimonoff.com>
 <20241216-apds9160-driver-v3-2-c29f6c670bdb@dimonoff.com>
 <20241219163454.09daa116@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219163454.09daa116@jic23-huawei>
X-ClientProxiedBy: YT4PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::18) To YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9181:EE_|YQBPR0101MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1e2517-a7c3-42db-8d6a-08dd20627e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EP7TBeDd6eDZIbqgdSyqz4vU2UPBTToiSvTHBAX/h19o4Eq0FKNc9HpwJpNG?=
 =?us-ascii?Q?iaZQZjajAljl2mtDynHO51jBnqWvgW+Np+tuygqWeb4W9lBhMAE9C7565Msh?=
 =?us-ascii?Q?6SXhBovuiylnSWDqJw7h+iA07kXzc569GDztiNhZXceffw8yRtGRZzZhGxB8?=
 =?us-ascii?Q?q1l/Ix4WlmuGcoGDB/6dhhR2rcyZDDIS7tG5woAnLH5QLZLV+PpD112zR4AC?=
 =?us-ascii?Q?B8tkeqOcj11hhviPRl+NsD4yMcYy7VAreefXYtNi3yfoNvpg/yJWx6y7ZY6a?=
 =?us-ascii?Q?BQGAYWipXYoVp3jPWbd0RCLBYYKg1zE0FfxlTiHraDZH1+Y5KIqvrqvL0nN5?=
 =?us-ascii?Q?epA1tgmgX8k9Tz864PVVdROJBIWrWEBV4aWsKYN2qrJOqyWoQjIhzsFbrWci?=
 =?us-ascii?Q?S+sDNHeuMaCIsJ9zfqm48eXRq4nxpn5o59q0YurdHRvQ6YGhm4bTP5f13cXQ?=
 =?us-ascii?Q?BMHqTRKVu+eMPzlmBjE33SXXcU3VPIbP+6yi/a2Mgv4Ne9IlBixGLYZJLDVI?=
 =?us-ascii?Q?kwPGtSIExFweJLY4Ah0MyAhS7THeT8aWAxAFJ+bP+w2cV5qtWt1c/+ro6zyL?=
 =?us-ascii?Q?qQv0UY5tcPIB9ABqsMR2ZZD/O2rfxjbUs3MlRq+OR5yStYrHDBql3TG8L0Qu?=
 =?us-ascii?Q?5Zzapd583enZwFwa2VBH9ZwtBtnVD6h8LOWhoPBLJL5nHW1BDkHEYB/8Oz6B?=
 =?us-ascii?Q?U/WzA7ppPwOg2wSCSyLdvam9ekWuKIIMH0moN+ZLd86RExi0NJdQ56dwzl4s?=
 =?us-ascii?Q?fFTyhAvfLaQB3VrS0R2kji8d3byhYXP/3ihJrtJxkTsG7Pm+O0Y+YONMvIib?=
 =?us-ascii?Q?8qZaXckdspKIIjQcwC6jYLbBKz6uhcQHD3e596v3LvK22xvwsnq/Y2jbJYOG?=
 =?us-ascii?Q?R8P5GezxKChFX8e3ytQTv+qYP6SWIwS2M11wVRw/UXzfklUXH4yN2Gkl26WG?=
 =?us-ascii?Q?bt5ItmCT9jhPgxCNjRVq4OSZCBQHcw5b+XClNNU88WQrBMd/cLgw0JZrYfkE?=
 =?us-ascii?Q?2gjyucX/CF69kd/4L5rkQmr+gq0NL8AahPc/+CrghQt+ZmZhw0Pr3p42cGIX?=
 =?us-ascii?Q?TUUj4Ym8ld+NNQGTSLdtDMitQtYCTiEgjOySIVTGV3vNZNyPvTuptrha5R3D?=
 =?us-ascii?Q?X0l/13KszTwmhHkzWCB+6Ewry7QbcwL/4rgcVo8I5r5PSFpH5RbCSlKdt39q?=
 =?us-ascii?Q?emEqvhYRnOj/flzMUntHtA+XSiOfeoRW2HdAKpK7N2NXKjGB0cwrDdagijB1?=
 =?us-ascii?Q?uZwy682kXQnySrdOcHhn7AtPu7PWfef3wGwYB+DFpksN5busMehaVImXXL82?=
 =?us-ascii?Q?9A9pzXfCPAuIESx8wDkcHybcE89zimgdytmBYzx/ZEOEatfmlhB5C0bum+C7?=
 =?us-ascii?Q?oxdJR4qfIS9Rm0pygdhTtrmDMvr2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/TymQlX00k2xaPFAPStxSGALmQ/RSsPkFoGMevEmWNBJXyRhuPoWx8DCXDuW?=
 =?us-ascii?Q?ZLxMgHvkOu6LhZKs0tHoUVpLzpadXP2hTgnoJmkhboF/S3zyTR5TeQHyV57k?=
 =?us-ascii?Q?rHXwaK6SzOrotiTVgtyPvQTyTjmiGU76RX5prQ+dyVqcxc8Ws3zrWOQsfYP1?=
 =?us-ascii?Q?qILHQ2WyXzvy1gq6RDjSBT/cliEaUVUkdKHYOR2mm2sAvAhCf68mh5NlCVzv?=
 =?us-ascii?Q?Iap6WuOZ/ZRhb3a+1OsJIVxYR21e0O7Zh7bFtJaKtfAMWIx80m1nSGaD4H0f?=
 =?us-ascii?Q?fwLQ1wzdR7gjht8HMmAk97LdpTw1HdKu50+WfRGxZm8dqcKCCCxIbR78FMMg?=
 =?us-ascii?Q?idYq7V6JijIWeD/iWy0avQJBboO0NBpNKfdjq4u/z57ZWaM/BlOMPXfQyKFT?=
 =?us-ascii?Q?pWw68Wl6/Kh89QoAyTp20zs0xSWbVc5/rdagndkGqjtegGiwPyZ+hqkYuuuO?=
 =?us-ascii?Q?NUF1XcjW1fz1NdyO/HzJmokdwdKbkh94RJnI4hoUxMQ33vfrD4ZfiOBIaEg1?=
 =?us-ascii?Q?R/27OW+kdoK5Rp0SNtHfDpU3bRChVAjNDQJxF517U4qpXHA9AKxkVO/kWWe0?=
 =?us-ascii?Q?NJfGFH7Fc2I2M4MAbVP64r6X6RK093GuqnXb+ZvyvcORJOpDW5+yLO6mGc1x?=
 =?us-ascii?Q?0QiM3EEzXav7hInWbdwDq+ekR72EMFpgwW6z/Uuopv5NNc6/sQG5p5cOLykZ?=
 =?us-ascii?Q?OnMS1SByaTaVGbm2dfZ2X0V9keckywpaq/hHdkc82aqjQHLtYuRAbB6slPqW?=
 =?us-ascii?Q?JKmRGUmoisQFkYOiVWrFwfl0HLXQGiH1qKy6KIwuIeJhkVCvMh3YssGEC7f/?=
 =?us-ascii?Q?xOsQYl7gqRRTCQUG0zmeiYb0ai8+9TujymS8ja08Y67HJoniBJK4UzZBAxSL?=
 =?us-ascii?Q?wHJzG5YYdT+qEO1kqnPzyZ0VwYbRyGe8mR67qRLiBTSzzBCN7FCkYWaLQky8?=
 =?us-ascii?Q?w1GqFLTMN0xAn3y6sC2OXaUO0ig9/vcrUuq1SEH8bSe4TwPsfErXP62AE49w?=
 =?us-ascii?Q?3/95wopHIw68UaVveXPQ1Vd6dZgIpEXk6N0LIc7Gpl/bzCmGWt/fgdszf8KJ?=
 =?us-ascii?Q?aBdhfJXeNzDKWn74GJeHYRRCgiUbXjnxqe+a76YZKPSrf3lLNaV4g8qJZKF9?=
 =?us-ascii?Q?F9aHeBgtJ03R5EziJhufpDzzMXYlhWB21mJVuNElEgkJJswR0BwDG3hK4to+?=
 =?us-ascii?Q?jOShAwxC4YlkBs3Gl63ZNP9oQpZ5mBxsS8XInk7E1ihY7rviyYGUaWV7ddeU?=
 =?us-ascii?Q?BcUGHNdqcdLQGg4GVSyehTdgsz29xuVuv3FEJlsXKPtb1o987Z+Xyp4wvzLA?=
 =?us-ascii?Q?yainU44XtzZDLlzxG36h+F2BocPoq5RdVxjWtJmJ5emS/E1Xd4cIyBSQq/4g?=
 =?us-ascii?Q?JOOzpNSrvDPm3UiTPimxeTWzg5Q1pU5peIQ4K6RlbYXPJbUMQ/iT/tNYZQkA?=
 =?us-ascii?Q?EFiuDsZueU8VNJdiYoNzY8EPhGwNtva/aUroNSXKL/NQgkkzjK3EqFL5pfvO?=
 =?us-ascii?Q?ScRTRojotpIGcRmXSplBDqu4rXUyIpHJ29ITNEpfjmaH5srYEZ0MPR3205kJ?=
 =?us-ascii?Q?RWyXaY5ZasayS10dGsNt8eEP2YLfS1bAj1aBAUON8WKPGheG8sBHfxHWjIN7?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: dimonoff.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1e2517-a7c3-42db-8d6a-08dd20627e6b
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 19:22:35.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVZHLwCV+qmnXJxoxO2TEwldiWuVxM/QmzS6D0/zEJ3exddr01BJKim6DsxutaHM13m62PErJzqf9G9cwpo5/Akwc22UwdpGr6J/87vF+UE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8238

Hi Jonathan,

Regarding calibration attributes, while I did include them and made sure that what's exposed by the driver 
is actually being correctly set in the registers and that it has an impact on the input data, 
I do not have a real life use case for them right now and that's probably the case for almost everyone using the same chip.
It's there as a provision in case something comes up and I end up needing them.

I'm also not sure on how it should be used and in which scenario.
From what I understand, depending on the type of material in front of the sensor (tempered glass in my case),
it's there to cancel out unwanted light reflection of what you don't want to detect.
It does so by emitting another, very short, light pulse and takes the reflected light ADC count from that and substracts it.
There's also another digital substraction parameter to always substract a value if you know what's the value to cancel out.

The 3 parameters in question in the datasheet:
- PS_CAN_DIG : This is just a digital substraction
- PS_CAN_ANA_DURATION: The duration of the short cancellation light pulse
- PS_CAN_ANA_CURRENT: The light pulse current used

I used a standard calibration attribute name for all of those, respectively:
- in_proximity_calibscale
- in_proxmiity_calibbias
- out_current_calibbias

I don't know if this is a correct use or not.

See my other comments inline.

Thank you,
Mikael

On Thu, Dec 19, 2024 at 04:34:54PM +0000, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 17:55:41 -0500
> Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org> wrote:
> 
> > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > 
> > APDS9160 is a combination of ALS and proximity sensors.
> > 
> > This patch add supports for:
> >     - Intensity clear data and illuminance data
> >     - Proximity data
> >     - Gain control, rate control
> >     - Event thresholds
> > 
> > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> 
> Hi Mikael,
> 
> A couple of questions on the calib* parts. I hadn't looked closely those
> before and the datasheet is not very helpful!
> 
> Jonathan
> 
> 
> > diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..0c93ab847d9a36aac7aa6a1893bba0fe819d9e28
> > --- /dev/null
> > +++ b/drivers/iio/light/apds9160.c
> 
> > +
> > +/*
> > + * The PS intelligent cancellation level register allows
> > + * for an on-chip substraction of the ADC count caused by
> > + * unwanted reflected light from PS ADC output.
> As it's subtraction, why calibscale? Sounds more suitable to make this to calibbias.
> > + */
> > +static int apds9160_set_ps_cancellation_level(struct apds9160_chip *data,
> > +					      int val)
> > +{
> > +	int ret;
> > +	__le16 buf;
> > +
> > +	if (val < 0 || val > 0xFFFF)
> > +		return -EINVAL;
> > +
> > +	buf = cpu_to_le16(val);
> > +	ret = regmap_bulk_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_DIG_LSB,
> > +				&buf, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->ps_cancellation_level = val;
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * This parameter determines the cancellation pulse duration
> > + * in each of the PWM pulse. The cancellation is applied during the
> > + * integration phase of the PS measurement.
> > + * Duration is programmed in half clock cycles
> > + * A duration value of 0 or 1 will not generate any cancellation pulse
> 
> Perhaps add some details on why this is a calibbias type control?
> 
> Whilst I can sort of grasp it might have a similar affect to a conventional
> calibration bias by removing some offset, it's not totally obvious.
> 

After looking at all possible types for a proxmity channel this is what I though was the most sensible choice.
Is it possible to use a custom attribute type here if nothing fits?
Or maybe we should drop this entirely since it will probably be rarely used.

> > + */
> > +static int apds9160_set_ps_analog_cancellation(struct apds9160_chip *data,
> > +					       int val)
> > +{
> > +	int ret;
> > +
> > +	if (val < 0 || val > 0x7F)
> > +		return -EINVAL;
> > +
> > +	ret = regmap_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_ANA_DUR,
> > +			   val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->ps_cancellation_analog = val;
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * This parameter works in conjunction with the cancellation pulse duration
> > + * The value determines the current used for crosstalk cancellation
> > + * B4-B5: The coarse value defines cancellation current in steps of 60nA
> > + * B0-B3: The fine value adjusts the cancellation current in steps of 2.4nA
> 
> Whilst I'm failing to actually understand what this is doing and maybe never will
> we can make the interface more intuitive by not using the encoded value.
> Just use a value in nA with both the val and val2 parts.
> 
> it is rather odd given 15 * 2.4 is only 36 so there are holes..  PRobably a case
> for getting as close as you can to the requested value.
> 
> Calibration parameters aren't guaranteed to have a simple interpretation but
> this current case is worse that it needs to be.
>

Ok, noted I will make this change for v4 if it's best to keep this.
This works in conjunction with the cancellation duration.
 
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		if (val2 != 0)
> > +			return -EINVAL;
> > +		switch (chan->type) {
> > +		case IIO_PROXIMITY:
> > +			return apds9160_set_ps_cancellation_level(data, val);
> > +		case IIO_CURRENT:
> > +			return apds9160_set_ps_cancellation_current(data, val);
> 
> I can't figure out what this one actually is.
> 

This is the current used by the cancellation light pulse (PS_CAN_ANA_CURRENT).
I might not be using the correct type name here, since it's so specific to this chip
I just don't know which one to use.

