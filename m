Return-Path: <linux-iio+bounces-12049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97F59C256F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 20:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596B01F24332
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 19:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04F91AA1F2;
	Fri,  8 Nov 2024 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BOg2EZi+"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2074.outbound.protection.outlook.com [40.107.247.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67105233D80
	for <linux-iio@vger.kernel.org>; Fri,  8 Nov 2024 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093162; cv=fail; b=AdxvZHk4WbnZuPF28041zMro5I0LBgTnWGJuI/2VvfrmxqvNW8Hx2/CUKwLIl5x3q70ceql3c25Zg6P0x/AYKBEAfM/Av28DekO9jBZryNDpbq4qn/IvsBLp3jtFF0KLuFmPx7hZonvp2/QcSmAqAnPrt01tpsnwyRM5edwbdgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093162; c=relaxed/simple;
	bh=Wq8/eEj7tWHC3KHURUlbuUkKmEv/Y7pVxL67MxkFW/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lhFwc4sKyGv0KzLPB9ZcxGRdopwltf9BktVnBvVR0qL2wplNibjlQ/NwPHiEeOB1PaRImrhAhWMZpfN/y/Y1qAxYzEWdSndGEA3G/OvlEKxpIB5gRTbMILq70Go2ONv8i6qpDes5Ee0YMclnlVvZVQQZkrqSXoqBNbG1Ovn7GkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BOg2EZi+ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.247.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8EFcg94sCC/3JRXmXwX5yZ1dpEx0hepn9FWy7KBoefESuV95TG/Ba8RjyrZkPOHE+kPNSaudyjAlVgpKdzkUlwWBIT8th5hkojD93E1yYK6GHpReOl9jjSVOQfLqbL3NYwemCtV2gxhBSiVoZC0d0X3cPeKR0VSs1//tb10T7Xqe/AnyUgE3EjUDrcy3nULr26HSXXljlNBxOgS1mW88+4U4dYVuTwn5/RfnLJ3rYkXkTFDEgzesG7KhgYFqwz+HkIDtc5DFM/WsauYA2igl7wijg8pte3uCNzTyC6uCZ8xLMQjgfuWBviTnhmM8yHtxggUQYsehFqopi4cuVPvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/E1ZMmIh2gWy7Jlv9jFv/h5S4QNDX8SPsMumSfTSaI=;
 b=LldoHtmfa0wxctfeK/aaRH8bPPIMTBJmept4LFbyedkOWv8G5hq6FT+Lc27xwws1rm4zpHHpIG2ujTDasDmZ7kmQSAMUIVQXB+gDK6c5afhcORi1mHAV9PAEu03RhNYUrc3ziCf3qAS7rs4Y6zXJVXJm8CWrCSOds1Qmnrn1dkr/Au9h+ZAlXa5NJWzrsBgY3s6t1/IyDali0TMQB8uS0INouKrSaaPAJlZ7nX61V+oYFmI2jCl7nCUUpvF9wtoivkGtj1gs5erfgG1mzVGosRDNACnOlP94VhrCr3qEQYeAig3ApBa+J81CB+vRcsHrh4z5z7+dTUllXcaMbTxSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/E1ZMmIh2gWy7Jlv9jFv/h5S4QNDX8SPsMumSfTSaI=;
 b=BOg2EZi+GbB1YmqMB/+lSsPm3cjwujPMY4sI4hqRgBi7CjP1AkbZJV6Os4qR5F8NaavyzrSiHOyOwI7mmYAZASmXov8LQyyZO72NYx3GXRYUMMy8hue70I9aHTrYPDtBu1Y/oV2EPWkZDwUZMZYerab8SxC1iS6krJvebnxVZ/rJSRIgDFqPTHB1gY6jrHKj5ByqfJugRkRvFL8189W2XJhWGyGdvtqAnCIIB2T3TOMvKhsKbsSRG/OsjwVhX04otk8o7Z3coazSC8HlBLVU9OFxhWYbLia+KAUp/h9IJxZ3JLYjGqkAHl1BLWHD6LBXVY+OWsShKttOSGV+QRRsHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7918.eurprd04.prod.outlook.com (2603:10a6:102:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 19:12:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 19:12:36 +0000
Date: Fri, 8 Nov 2024 14:12:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 1/2] iio: adc: vf610_adc: use devm_* and
 dev_err_probe() to simple code
Message-ID: <Zy5inVdA4xy1qyrT@lizhi-Precision-Tower-5810>
References: <20241107191842.3002319-1-Frank.Li@nxp.com>
 <4bd12695-075d-474c-b720-d295cc6028ce@wanadoo.fr>
 <Zy0Z3wIsgX+O4DEw@lizhi-Precision-Tower-5810>
 <8e52cc9a-0da0-4393-af66-6dac092148ef@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e52cc9a-0da0-4393-af66-6dac092148ef@wanadoo.fr>
X-ClientProxiedBy: SA9PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:20::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ca1235-7ea1-4f8e-1742-08dd00294df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?VbzUADOimo6GMGuEMHPtnKW6JSY96MpRHHBdqiqeFwPtTguYZdZHy7OiNS?=
 =?iso-8859-1?Q?q6J4+U9ScTZVqUOL/51nVP77ZVljbkarztrASdh5yqdSUyqd9TUKdrN8So?=
 =?iso-8859-1?Q?ekdjPQ8EIskhaQH3LDKkz8hQdatWnpfmDCYl5qzlCPXjUTvnfhrqOgQgCS?=
 =?iso-8859-1?Q?5l4i/pyLjOreQXkb84yaXuVV9ev/kVwKECDlLrHRTvf8NhoQx7dKbWA60i?=
 =?iso-8859-1?Q?nLGpDeWWkllIhfmZ+uNm7gquvsxGUiSxxk1C7C3BgyNvaOYZFPmLG6hls9?=
 =?iso-8859-1?Q?LMjus2eQf8A3ITSxsx/vrV5D3yklqSD0Yw0DfzBg3kZ24MVK1EwEIwUbTJ?=
 =?iso-8859-1?Q?v3Q4IcBpex4UYB8O1DK1DflbOvGg+dQfGPjNc/5vgw9mlMXqTK76jWM5Se?=
 =?iso-8859-1?Q?Pm9PMvxf9KfHCSqVWLne2AfjWyvZlB9I2VKX/ECEWnnn47jQRie3IQyaJ/?=
 =?iso-8859-1?Q?232B+z71b2p37k2c1dBjqi/iHlU3OJhXAiVQ4l7Oa2WubFiWkGZVU0GYHv?=
 =?iso-8859-1?Q?/A7t8CsStnGsfsStjkzTlDgtbNHoaaetWi/z0d+plKrtrGiXX/ZI2GD/Ys?=
 =?iso-8859-1?Q?PLRaD4ehzjkuRCZJYXIPPkRraQgZE/A/1tpRleJrccLNnuDnnn4TrYBUVM?=
 =?iso-8859-1?Q?pkMfa7Xy5pjMXYb8RN7Gkr/0hO7u+xu/SuGbETg9yqB/PyyysxndAN1+DV?=
 =?iso-8859-1?Q?pZIOWv0Ux1bJtSRhRZcm3Ea5/x8ouTgBoLhZ8Lrq9VYLDwakhZXJ8r0w3G?=
 =?iso-8859-1?Q?cex7FRE63VOhCpAlOhht/Abvrhils0vtywTlkMjTkqQKcBhkGR6FOlROuY?=
 =?iso-8859-1?Q?tBtVMpbZfB9W3sSxtVtvzJtrJK9O8fWgQB5UXRopDmumBfZTNoWd4Nkkb8?=
 =?iso-8859-1?Q?wI6rZ6FuI4nYD0oY7i8QoYfHoy2jvWUxGhajg3tzq8R8ITZPpBSAblOUlg?=
 =?iso-8859-1?Q?/1mxhKiMnRQ7fSYBIyjxbcUTBisE4XLyI7FbtIVd3urMP2+7iR2JBe/X/n?=
 =?iso-8859-1?Q?rgZ1NOA6NhoprRzr1U6mJauLEWZ/M8Gfbfc3NGutfeIKLOlFHq1Fuw45zi?=
 =?iso-8859-1?Q?nCcxN/hN2eEVz6n4QtgebEHwY93uYPPSacLbnDHkQLEjUcwCq5W/BXotLL?=
 =?iso-8859-1?Q?13Q+kxNmAw2luSrYmuxxAWgHUYvnhlEiPLxkZrjZiIFaweOkaxhd/4icm1?=
 =?iso-8859-1?Q?2EhtowdAfByhgk3fptDh5cjdNVBibqqP4IwvAjdMVrM8k37fc7giz5eVky?=
 =?iso-8859-1?Q?TnFO//VsJW1ssH/OxK0i9Zm3QAxqG09vCl77KiSoFY50gmlIlCWjurNn5a?=
 =?iso-8859-1?Q?67+uPf4lWjreQ/UrPe1leS07fuY3TwK9GaWu4vpKvMnI6LmmWWur6QRK7X?=
 =?iso-8859-1?Q?awYv4YBnYQJ8eIEwwT3c7+db/WAcgDn2Y6rhEEtp5J5m7OzPBt1/I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?5GqvjXRhYOri0A13xufbs3QaYGpu40t1wXhLjAGP9Zi4eYmRG5/wQHcanZ?=
 =?iso-8859-1?Q?KvYp28DSMevCSg/tgJyod1ZgO5TTgClxRORZF/ORgaMrrSs3qNpm418HrX?=
 =?iso-8859-1?Q?308ne8aUf1XTc+QeSmusUL12fMiqApM4806Ljja9uN3k3SXJr6rc7HQZEG?=
 =?iso-8859-1?Q?//kxTRRmYYhGOZKWT0vqu1ARxV8Oj56ezAsWKaNRq1pSZI+AgtzE4V7lFF?=
 =?iso-8859-1?Q?i92igvAn/gUyNK//5Qis/vUfVGLoh+pwU1VysaHiVKNvIrA0CcIeZpVY3r?=
 =?iso-8859-1?Q?ObmfIu2UPnHm4bL2BzK6UoSUJHOt9LershJRQZtvCDVFKDQmEDOIzujqbf?=
 =?iso-8859-1?Q?LD14vZBId0YYthTqE1K/kTH8ysMUiKNJWitHIlwo9aKGCmZ0jqcB8BG9go?=
 =?iso-8859-1?Q?x8u6srWYDhELwdmBN+qsQy8tAqz6AnFt9z31zZrTMMT7h8Hw9fHPesDbi1?=
 =?iso-8859-1?Q?n78EVJUpdHe1GHxFOA79rNclPBwCMktfYqn+JCDZCWzUgU9D2FaAE6Bd5o?=
 =?iso-8859-1?Q?8eusxYPTLl9ds5Hxa4xCjKimv0KjCl0oSexifb95FrlmeUJKcqenOi2Lzl?=
 =?iso-8859-1?Q?Cnk0OX//LNa9dXnB04fkYRW8QcdS+y7aQ7ABKraxga2U8Uh4jIPknOibS2?=
 =?iso-8859-1?Q?/imIIUq9feYZvjZdUV5czeLYZlX3sz9jx6InDO6JcWFNB+V2cA9QqMOt0a?=
 =?iso-8859-1?Q?MNK7zKMEeyamfU6ECmy++CrLg0OhyZEhMoWPqRV9k+8oQnBW++yyo+92sS?=
 =?iso-8859-1?Q?WXtA/hSQdjRC7YKQyTrFnvuG62z00rZrYIUsQHypn4eVIqSJdGzLJw5FUv?=
 =?iso-8859-1?Q?vqngWXYBhdrWnEt1JsNN9RghN+jnCKMl/P/Pvudbg91Btg8FmO94EtyLkp?=
 =?iso-8859-1?Q?lnpa6Wq7S/0BE5uAECzzRMrdLluDTYfnXLqi5TVL8rA12vWLc9PctXkC1m?=
 =?iso-8859-1?Q?bkf9gUzdVfRMa+wdArrmgbmSgx5wP+y5Wavliwy664n6pALWShBsx92jJG?=
 =?iso-8859-1?Q?sqOmHhrxWJWS86Hp9dvgEDergRy+/q1nq2QLsS3h3QYODtWgXbK/NxdjMv?=
 =?iso-8859-1?Q?/xnkwIx3JKuXvE5r6Xd6ueyL6tjZDLccIMYoE1GShUmAOJ5U8cwMJrjpbx?=
 =?iso-8859-1?Q?WgoPnwqcNW7hvjCUi+/6oriNpM2wGchuExfS0Qu5rsrbIj9cbDeg3OPZKc?=
 =?iso-8859-1?Q?BRp84vEgrW7xHW2moa7/Terr8VsjCxIlhITpB098WNotMFOX+aw9lNP9sP?=
 =?iso-8859-1?Q?7CuQ3VF5BA4x61Q5mgKY63pZHojaM5wkwvrx15U44SyDNC77tH84NJGiuM?=
 =?iso-8859-1?Q?9LMde8lQ0b4Kqng7ynJUbaVoYgUMKMNVj+48T0UKmOBy8EvFcf2WWmNT25?=
 =?iso-8859-1?Q?BMB8X1qSkK7qU+SHJwgw9ubR6KH63o5sCiV7jFaDxBk9OK9AWColJm1KjN?=
 =?iso-8859-1?Q?IIMrUsqAvvfY90F022JxuPDYf3d9cAxOogYCueLL3m8/Pvd9Y4CLwwC0eI?=
 =?iso-8859-1?Q?0MjYGlxvxjemhWi+fRrbgqbHFp4vHr+GIDHuMnW8oNdzfGX69sYV49yWgM?=
 =?iso-8859-1?Q?WetDA9VLQsuhinynbm0LA+FhFQ+7SHqQ82flRcapH8teg0Us4pFlBTK9T4?=
 =?iso-8859-1?Q?lxfkNK5WTJmL5O7N3+bEFBtUsmXhxWUlgC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ca1235-7ea1-4f8e-1742-08dd00294df7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:12:35.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeS9LU8VQfAZSqnOf2fMz6KZokFU6bWgh9K72LxOPlnkb8V4TwxQ5IgnR0OEvs9sm/T59I3JDxFFjP6eOBWmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7918

On Fri, Nov 08, 2024 at 07:13:20AM +0100, Christophe JAILLET wrote:
> Le 07/11/2024 à 20:49, Frank Li a écrit :
> > On Thu, Nov 07, 2024 at 08:38:20PM +0100, Christophe JAILLET wrote:
> > > Le 07/11/2024 à 20:18, Frank Li a écrit :
> > > > Use devm_* and dev_err_probe() simplify probe function and remove
> > > > vf610_adc_remove(). Change type of 'vref_uv' to int because
> > > > regulator_get_voltage() return type is int.
> > > >
> > > > Reviewed-by: Haibo Chen <haibo.chen-3arQi8VN3Tc-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> > > > Signed-off-by: Frank Li <Frank.Li-3arQi8VN3Tc-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> > > > ---
>
> ...
>
> > >
> > > >    	info->vref = devm_regulator_get(&pdev->dev, "vref");
> > >
> > > With the change to devm_regulator_get_enable_read_voltage(), is it still
> > > needed?
> >
> > Suspend function need vref to disable regulator.
>
> Ok.
>
> But why switch to devm_regulator_get_enable_read_voltage() then?
> Shouldn't keeping regulator_get_voltage() be enough and simpler?

Avoid goto err after devm_regulator_get_enable_read_voltage(), if use
regulator_enable(), it needs regulator_disable() in err handle branch after
it.

Frank

>
> CJ
>
> >
> > >
> > > CJ
> > >
> > > >    	if (IS_ERR(info->vref))
> > > >    		return PTR_ERR(info->vref);
> > > > -	ret = regulator_enable(info->vref);
> > > > -	if (ret)
> > > > -		return ret;
> > > > -
> > > > -	info->vref_uv = regulator_get_voltage(info->vref);
> > > > +	info->vref_uv = devm_regulator_get_enable_read_voltage(&pdev->dev, "vref");
> > > > +	if (info->vref_uv < 0)
> > > > +		return info->vref_uv;
> > > >    	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
> > >
> > > ...
> > >
> >
> >
>

