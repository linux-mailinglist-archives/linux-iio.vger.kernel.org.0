Return-Path: <linux-iio+bounces-27081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E9CBD1C0
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 10:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EE18300F32D
	for <lists+linux-iio@lfdr.de>; Mon, 15 Dec 2025 09:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE873314A1;
	Mon, 15 Dec 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="W1VLJ2OL"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E133123A;
	Mon, 15 Dec 2025 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790072; cv=fail; b=nPgVWV8JcsCxqRODXiYgDt2KxIqXAmkW+89orMO9nKeZs5yf76ev2pfATFhjBPOhJ6W7rmtW0NGy9Vp4FIcM4wNbYv1jKBSreR8ZEs4fX+s1eIXPzJhRvVhisdhoJByfv2B8Z/RWjUr37G3gfIbNYUJw79oKxc8YpujU04q+aNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790072; c=relaxed/simple;
	bh=ayGCW7dcCbgCUicOvZtSzxOVxTpUEnsE2JkLIzJwMKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=o5T16eeJM2UvGePGWclAApvMsTIbhO6p6fbOHheO58rlWWRuEo4M4oVAQbXq7mBSacW3QXk2gnT9bdcZQJSVOuS3uB/8lYJy/Y8lgfSvfawJTUoBS4MeJ901/kOuNfAt3RVWi0WdgSp7NQaqwd6e+aqGgNuQGS0okIOQzg/37i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=W1VLJ2OL; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKCdiLuQ0vfiYZxfBrT3a4qoWRhxmewU2xAxqsWiE/BfkOt16xKkmEXFMMCjV17XXusaS4r1oG1wrX3VPoN/1ZCxUyWtmZ6do+w7Fyqa8q8WaRP0lt/jMNs+gK1gqFcrYHYK/Ut22eji+snqRL0Y8HjAE9OCbRuBvDOnkJXf/VFtf4h3NJ9gxBOnY2XCkjVEYvOsHbBF6pSpmi3C3nRVXqAoLSkalDhx4lBSHQFtodwZc1pwf613+r58AOxqcitTcAVXlR6HvyxYEA0/7bWlpnXgtrsfVfbAjtPiiwnXoqbHc33VNQPI1QqbdWub8LJpbPCSX+Gzer3wCSfwcvBZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h13xEvbJ/F3BTr0TtleL5m4mxSll79tkOfHprDxlfnc=;
 b=MV8KRlGU1zd5Z29ki3AyD4oYo3RZeHee5xivh/AqTGvaKroRxM0w+7sIgtbbdjHedKd5R8hwxrozDe+cfLu7lX5ZdYNDXTN7k0lBty0OHd692MSmdilmLgoRsfQeb9j7EDIym07QyMmxzZTd8PSxjUKRv2T2cQxt7DoSHVvzhMJiziJQlXazVHgGHDBjQO+LLe8YSOU3rH+TLNJPq5eWea66H8FQD4ncWEUJDMpjNYUpn0uDs85vl6lf4Rvp+PFTh58faVYTD0L6NcRfoaUEfyxliSCu+X/jMS2UJInHL/lNKxfKR2RydgbZbBEZRuRzF+k03h6vQFS2fKSp5soaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h13xEvbJ/F3BTr0TtleL5m4mxSll79tkOfHprDxlfnc=;
 b=W1VLJ2OLRx3Y9VaaEUXOWTdBczwIOXY/xfuT8fTkpnueyQ+Ir9XzntU8qnDv0IngoGvabICQwblU6r5KDOty885XwrNIOyrJtraycN5NJDxaF16FvpJjQWFPLifXMUBBGJZ5AsGBKOOTGdmYfzkWespliYTGr68ZoCaGZUW+nmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB7353.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 09:14:19 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 09:14:19 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>,  Guenter Roeck
 <linux@roeck-us.net>,  <linux-iio@vger.kernel.org>,
  <linux-hwmon@vger.kernel.org>
Subject: Re: lockdep splat involving iio-hwmon and iio-rescale drivers
In-Reply-To: <98101700-35EB-4D45-AEE4-6FF1E9D55505@axentia.se> (Peter Rosin's
	message of "Sun, 14 Dec 2025 05:56:14 +0100")
References: <87qzt2tnlu.fsf@prevas.dk>
	<17697c17-753e-46a4-8e57-107dc744f18d@roeck-us.net>
	<ced7efb0-02eb-f1b0-9033-e546ca302f1d@axentia.se>
	<307296eb-e5b4-705b-6851-53cecb87a69c@axentia.se>
	<87ms3nu9m7.fsf@prevas.dk> <20251213165723.762035e4@jic23-huawei>
	<98101700-35EB-4D45-AEE4-6FF1E9D55505@axentia.se>
Date: Mon, 15 Dec 2025 10:14:15 +0100
Message-ID: <87ike8t8d4.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0099.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::12) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 850b353e-77d5-4afd-875e-08de3bba53b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IdoSFDSlJUqzyNB2K4mXwKIYDgPo5WvbNs/9FkvnAUSaK0wG4NmRAak7h/jr?=
 =?us-ascii?Q?FsvBP/ZXuez9mATOB5yVd7FEEyqoGM2nRNsv+kAmjxIxqHa1ZEjKggWmK6k4?=
 =?us-ascii?Q?ZCK83P6wWB4vOTcONFMFC0oWupUGeUW9b/45XGxZF3l+Ej/xzpTkVbjDHA5/?=
 =?us-ascii?Q?TfoaFj5ZBk5kx376vmKCUCqYZYRlnJSg7toE0IgsFD2LHgHTQAG8dpBNBi3q?=
 =?us-ascii?Q?XIJs0aaefkw3QZVtEZgOT9lEvGl8KLu9VVP7FfxwOy0yZt3qGjZZNQ0DX+JS?=
 =?us-ascii?Q?c9Gm/4IWrHRKQBMQdF8te3G6rdYS06ieC2GbIu97AETYKto5kl6F5MSHHJEi?=
 =?us-ascii?Q?8DNBmaLrjJbrd8hBvV7KxcLjehmiicbq5H8yxAG2rctVOJWrN5dlf+K2kb77?=
 =?us-ascii?Q?burvtJOmnauQqQc3+vVHac27IlGAkkTy/7IR+d+1CmMSQlYhbjmd3lwGr6Cd?=
 =?us-ascii?Q?6JDpfpa3B//+GkXlqYZEcuI7IS1XPqJZ/oFdwTXl0T7A+3U8opwxtaYpv4ay?=
 =?us-ascii?Q?afdw1OJaGfIK4PQX4PkUV3UIfjEJBGGk56ZJnSDeVFzwzBaLmK3etL6ZtWWK?=
 =?us-ascii?Q?zU9j+5sCPDMCvdqp9pnZwSBBTsk1QMkWvoCHASnBqEpPvE9xsZ7SPQgv2zZ7?=
 =?us-ascii?Q?f9hQIRZKZENXjbgaMsNly76o0vFV0Y/Ae/LFAniFPOSiLFUZ1PEN+xLo0rAG?=
 =?us-ascii?Q?TdWSWb1ZID+1206YC1iP1Ug7NlF7PW/oxAHMRmw2bImNiL8jb+gIFiqLNa4R?=
 =?us-ascii?Q?zJAfzKsqrWLDNpOC18/ALqlfdRWboho+q7NaOhJC0BUNRPBffYrMqF7Qj4TR?=
 =?us-ascii?Q?t1RRPKOWRUQQQUKTSfjR0p3mT/mDJ2JihkOYYdl2W7KpCWXkp+tTKrISt8sm?=
 =?us-ascii?Q?5EqvWImEC3zRMc6gri2nXWbSLtu8zRgiWCYbrdCdUNkVLHYr3v9ehl2pDGIn?=
 =?us-ascii?Q?q3vCEvRPcyCsZHxRllzm5ejT1Z39FvWGUKV1x7SysD4E8NrlNTLe1xComaL7?=
 =?us-ascii?Q?QXwfGrS9KhWRuzGpsrmGkdWDoNW4Zqzax9jNFtDLeSL0u0jQPRc0MA8t1Ytn?=
 =?us-ascii?Q?phpqP3BYZeIiC413pP/WKkzzexeEGRn9YLv05R6kCu73qrArViBaGR3PipSp?=
 =?us-ascii?Q?c3PFyTBxvwQ93zw2COhLf+sTp5IqBYJJDeXq4fUcOqiE+8tl20c2mmli0J3U?=
 =?us-ascii?Q?Kpy/tqBw9/956OqQLUoCmThIzWsKc4COGyGhlzEP95tw8ecEMaEk6PCzB7jE?=
 =?us-ascii?Q?1gq59zzJkR8Fnr/TTB5N37308CIsVO8bNYoF44N2gdLOiZcb6aSHSdGECoXD?=
 =?us-ascii?Q?br1QSTuUATl5gOdRFHkVHPBUPqB9hzOfTJZSfKo63829Fu4r+qGDXZgJnis9?=
 =?us-ascii?Q?xDwgl/KLRccU2hwdKwGmwqWCXnR33Khyds5FrAKRBZOaMQM/8lqDnKg2CoCv?=
 =?us-ascii?Q?f+hFgrVJcCI9QQpy6u4+GzfgwtqXTW8SZD7OCyQYZJNDBwm6z5tcgh8Md/7E?=
 =?us-ascii?Q?J18gaAIVCYfJfaggLFXra7d9oqmu8zDZVZDh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?soikbRnoD0pKo1OsuQcJgLwgVIvR4GH5bKhSGg8cg5OJ5Um7knjANRyOkahU?=
 =?us-ascii?Q?hkMa48f/wwlPA/NXUr0TGSa5ER86mI5lngOCWDE3ifZxSGyla3SdA3dvkhte?=
 =?us-ascii?Q?TbP29gUjOUN07GEYFs3DctsLZsrEu2ysrH2DOKpxUjbRy0rIXzSY51kjvMKv?=
 =?us-ascii?Q?vVvC6P9WxcSI3BOVoRdoC7z1asaNyGzHY7LCdqV5iPm0BHiwZcPYg5ObrTZa?=
 =?us-ascii?Q?Rq05Ln6oHeN4loC9pI1SmpN7utTiXBQMCaKTK2g1i4dWEyc/jTsqOOJ4z6Xh?=
 =?us-ascii?Q?gUqI18pJ7ZjQ5HC0+uRbuUj2d8TqIO9xjlsKW0OtDEvUSVfBVq2lHWo6IqPX?=
 =?us-ascii?Q?HwudrGHLoBc6dfhnqiBe9YGJWOmRVHTq1/pumHkDXpqE5hE9UitNTSk981NL?=
 =?us-ascii?Q?hVt4ZsR40KKIu9/wlLAoM+JE67eFgj3uqZcvhz1563/VBCL12Id0/Q1sn4zz?=
 =?us-ascii?Q?rFg9/y3gH1dJ01t4tRGy2qWi+kW2F3LH7qmhisHl0wxeknwTatmHbcU4oFAU?=
 =?us-ascii?Q?gtLzsrSOlMgMBlxom4+8xZ9QyxKDWOYQnvh4DzV5J+5iyeN7Nr4PHSTqGT5p?=
 =?us-ascii?Q?uDRI0HzwmacmLOYkn8K+q+vuQTtlCGANNtuAkXUsttdrfl8XCLiAJUxX1rBE?=
 =?us-ascii?Q?G3mKnybitEXtU3vUskNR/+yqCqRu2Ye3uMoJe6f3Scw41IohW9ZFy0xtrrGm?=
 =?us-ascii?Q?1xgy3nK/mchwa9M9SizgO3ZjeKOD/USWfqZrqeUI9iW6Y/aL9PX3xMqRMF4y?=
 =?us-ascii?Q?0a1iRBHvQPiPX9CDhQ+mvB+aYzUg+qqUOvtKDlnZCDfbnzXBn1NXDvYbf/KX?=
 =?us-ascii?Q?g43rBhzVPxqFMYpxVAOciOhThTkP8EBsRr24teGE5g+8VE9qFviIXtRLHwQ7?=
 =?us-ascii?Q?v5HIK4LNWfYqKP/6CbLM3c/2ZJ3sMaEfmgeGPx2etQ3EivWobxXnHYX2ghNy?=
 =?us-ascii?Q?cJ92vNDfHmNZ83WZiGYBi6SlmzlJWU76kju4JmBbK91QQUDhgt1vJgt/c6yb?=
 =?us-ascii?Q?5h8EzL2cbNpjovVAynQUN3IRNQvGY7w4i9DXSNc2fN35VMJUgq4CY+vvDbQg?=
 =?us-ascii?Q?ZhjicXdqHTem1bx6sjAmC7ycRZMw04STXWeCMzLonT3REvW/5rSXAgq5f/TX?=
 =?us-ascii?Q?AfURZ2jknn4EPyX8dHK8Fd8i+5Ytn0/RkrTFP173UdfaVWVnL+cslekyYSOB?=
 =?us-ascii?Q?mk0WrcOfN1dIWkSDnWvM36MhsHDO3tPba7MQ3Y48nMuiS6CCW4n99dS3DTGa?=
 =?us-ascii?Q?vu05iq++2c7Wyn0yLta0iwAx08WL5KoP0oVesUibiVoDQSbPQmTC1miRCMdi?=
 =?us-ascii?Q?u5jI6COgmgWLWDONRbDx9BCTFOBFognocE4PHrB6npUiXzt1CAcFQavw3OL4?=
 =?us-ascii?Q?sZgR+FSzzH/Zgf5cvVoO7OOZ8NRKH3puCvqNN7kmmbH+FLv3DZHcsmzeZx4c?=
 =?us-ascii?Q?mtBEjlNWY21IjKZxQMOjL7lkN4n7zpe0pvc2f0gFOjDvrWBF+YGPpgFaJ4WN?=
 =?us-ascii?Q?+v6yu0B792Mvg9naL1uO2eb/wMvFHFsC+H/2uSqyquP5TtXK4zWNpWgz6ygD?=
 =?us-ascii?Q?diPe8zzQ607bso/nCSzWJcyTYSpvDAE714CwdNdLJnkS5QeSEJyeh/nRTJA9?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 850b353e-77d5-4afd-875e-08de3bba53b3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 09:14:18.9266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbb8YnA349F49zwzjwrVgZKCT8r5yKLOdRfi+vSfA2/6qXPkerfEmUr7Etxe8568xjBovkZ91QvDXC6kKG8IfWUYbrT7iNr0HVuWO1xhHa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7353

On Sun, Dec 14 2025, Peter Rosin <peda@axentia.se> wrote:

> On December 13, 2025 5:57:23 PM GMT+01:00, Jonathan Cameron <jic23@kernel.org> wrote:
>> I'm a bit curious we haven't seen many reports of this one. Whilst
>> there are relatively few IIO drivers that consume other IIO driver
>> provided channels it's also not a particularly new thing.
>
> I suspect the reason is that plain old iio_read_channel_raw does not
> grab the info_exist_lock, so it seems that you need two levels of
> iio_read_channel_processed[_scale] (or something like that). Which
> is rarer still.

As Jonathan pointed out, that function does grab the
info_exist_lock. However, when reading the attributes via the
/sys/bus/iio/..., that seems to go through iio_read_channel_info() which
does not.

So when reading the value of a "rescale" device via /sys/bus/iio/, the
info_exist_lock of the outer device is not taken, only of the underlying
voltage channel. But the splat can be obtained without involving the
hwmon bridge, if one chains "rescale" devices (this doesn't necessarily
describe any existing hardware or even make sense, just for demonstration)

 	foo: foo {
 		compatible = "voltage-divider";
 		io-channels = <&am335x_adc 0>;
 		#io-channel-cells = <1>;
 		output-ohms = <10000>;
 		full-ohms = <110000>;
 	};
 	bar: bar {
 		compatible = "voltage-divider";
 		io-channels = <&foo 0>;
 		#io-channel-cells = <1>;
 		output-ohms = <1234>;
 		full-ohms = <2345>;
 	};

results in

        CPU0
        ----
   lock(&iio_dev_opaque->info_exist_lock);
   lock(&iio_dev_opaque->info_exist_lock);
 
  *** DEADLOCK ***
 
  May be due to missing lock nesting notation
 
 4 locks held by cat/478:
  #0: c3721b5c (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x44/0x4e4
  #1: c4d1e284 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x1c/0xac
  #2: c2805a18 (kn->active#32){.+.+}-{0:0}, at: kernfs_seq_start+0x30/0xac
  #3: c1d96b68 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_read_channel_raw+0x20/0x6c
 
 stack backtrace:
 CPU: 0 UID: 0 PID: 478 Comm: cat Not tainted 6.17.11 #6 NONE 
 Hardware name: Generic AM33XX (Flattened Device Tree)
 Call trace: 
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x44/0x60
  dump_stack_lvl from print_deadlock_bug+0x2b8/0x334
  print_deadlock_bug from __lock_acquire+0x13a4/0x2ab0
  __lock_acquire from lock_acquire+0xd0/0x2c0
  lock_acquire from __mutex_lock+0xa0/0xe8c
  __mutex_lock from mutex_lock_nested+0x1c/0x24
  mutex_lock_nested from iio_read_channel_raw+0x20/0x6c
  iio_read_channel_raw from rescale_read_raw+0x128/0x1c4
  rescale_read_raw from iio_channel_read+0xe4/0xf4
  iio_channel_read from iio_read_channel_raw+0x44/0x6c
  iio_read_channel_raw from rescale_read_raw+0x128/0x1c4
  rescale_read_raw from iio_read_channel_info+0xfc/0x11c
  iio_read_channel_info from dev_attr_show+0x18/0x48
  dev_attr_show from sysfs_kf_seq_show+0x80/0x110
  sysfs_kf_seq_show from seq_read_iter+0xdc/0x4e4
  seq_read_iter from copy_splice_read+0x180/0x300
  copy_splice_read from splice_direct_to_actor+0xb4/0x2b8
  splice_direct_to_actor from do_splice_direct+0x7c/0xc8
  do_splice_direct from do_sendfile+0x314/0x3ac
  do_sendfile from sys_sendfile64+0x130/0x14c
  sys_sendfile64 from ret_fast_syscall+0x0/0x1c

I'll try to add that separate lockdep class. It should be fairly
mechanical (famous last words).

Rasmus

