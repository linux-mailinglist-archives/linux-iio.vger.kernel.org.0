Return-Path: <linux-iio+bounces-8656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C099695A5B7
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 22:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D89284692
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 20:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3316F16F0E7;
	Wed, 21 Aug 2024 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="MpPHg0ds"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2087.outbound.protection.outlook.com [40.92.19.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6763728DCB;
	Wed, 21 Aug 2024 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271324; cv=fail; b=NRe3qePe39cgSiqjdjMKeHv9fwRQboqmRtqloRCpCHva4H7fh1/PQojwPhXBg/NFqqr0RxWYKWtxlQ+8oSpsHJiftaMUV+xxxUM73KVxFd9kbjJGVlp80k0fv835TlAc9/7j0Jku2F/6OwDTtgTmx94ecjbvhQsjMhQThhC6WMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271324; c=relaxed/simple;
	bh=MNf92Dk6VNPQWtCAbdV/5DZ30teagPvWAw0IgOfTlLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gNo0LcFwA38zTjdDChnjCEUzg2liF9CPuX6e+p5lLetJGkob6D3T71I088tNPs18c9+5nf8OAiTO2oZuij0bKYeovRernwcnOdS2yTirG3lTjb4Pjp+DVk33bk0vMQTZX3df2s+5s/bgkfcSv8ub0R1xX2JA7TzYAvmUB5iJBmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=MpPHg0ds; arc=fail smtp.client-ip=40.92.19.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXfg4bZ7fvoA/PiylmVRAffWc+TxlgzRV65VrEQjW3UEvY7qcPUa+cWz9i4uJsLQuY5EMwJYNXRuOWat6v36P97e3CUlqeQg3W2T3+QfbxVKKUGNEUHWYKOhYz3mNdEyXzwwYWLGF6J7TCRnQVCTuXxz9hc2IrBCgVMZZZpFyzuZJkwlzVp7njZcH2bXL0/Muun3lU/K65AV6Bga3Q38Wy60EMgZLMOj7gfApizS2hUG+vFbNiuLZkkFcQrMOsxrxSRX4nY1qwEdjlfQTeoDSNM5ziO3VgQ6PJHNscFgDgj2DTViC6osgHuTkf3KiXujXDLk+Q6wo1dYQVmhz3KU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZsRUALnr/M4Ow4bxJlQoVB0IJwEz1bcmU1OZoWZvS0=;
 b=hNVVrNTdO9BgkUGgYcA82CjuYk/KTHe9Oe9mIEwrfwFy9AzEpKSal24azBh5ACdHDoAJE9/tgR4d7j3uRp4N6NLX/0b1BAk5xflO/oLY4kcz+14RaDhZJopB0Q8Elywb7wYgR66n7kgwaDMvmM7+PhNxsA7FkCawogC2SezH4xb7+uwnVKJ72mEmJAcGNZYDaMUTGpLM1DqDZuJLKj2Ls6JBoLGuC6xTUFRg2fZP1727j1EOaomwf5YqLx/89YV7bUDAP262KWbC+IhlncQtEAt3ZI839yUi7Co59mX5XNyaxjVneT+bArzeYx/kEoegVXiZwDHrqanx+bz4wT82HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZsRUALnr/M4Ow4bxJlQoVB0IJwEz1bcmU1OZoWZvS0=;
 b=MpPHg0dsbW+Z+6HG2KIwIB4TlBMW6U6Fwq2QU87v7MBJ9wVk5Y23HRmBlEcSXEtJwkYoAiXkBT3REPhLusMlH/vyukfUY1Dz6cve4r9w1lM9ix75Hn+21dgV5G27xgeUbmfQlrrJkuAVcypiSm1CQ7Zjk1v1wLYhDFbaH1+1skkSrQuHMVO0LL+V036g63FU0DxMPtKTDTi/j76I3nabNCkDb54ZFOP47rXFZQaMEtzCzo2Shfvr6p9NCXJl6awJKItDECZHgRPTTrv7d0PJA1+CHoIZ2vORWMm6jc2gsovBtHEj1GUD37S4docH+bVws5NitFdX6iNikcn9OOYsDw==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by CH3PR16MB5351.namprd16.prod.outlook.com (2603:10b6:610:15f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 20:15:20 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%4]) with mapi id 15.20.7849.019; Wed, 21 Aug 2024
 20:15:20 +0000
Date: Wed, 21 Aug 2024 15:15:15 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com, mripard@kernel.org,
	tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org,
	jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	lars@metafoo.de, jic23@kernel.org, jonathan.cameron@huawei.com
Subject: Re: [PATCH V3 05/15] dt-bindings: power: supply: axp20x: Add
 input-current-limit-microamp
Message-ID:
 <MN2PR16MB29412D4E9E7DE7C060319D45A58E2@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240819164619.556309-1-macroalpha82@gmail.com>
 <20240819164619.556309-6-macroalpha82@gmail.com>
 <ro43ccn3w2qsvcnjej7appuasuqphtf54vkyrsex6ypr4dlwhh@vi2jg4nemkvl>
 <MN2PR16MB2941EF5AF5C003640B20CDFFA58D2@MN2PR16MB2941.namprd16.prod.outlook.com>
 <6b9e528f-e9fc-453c-a024-1cf812cffd0d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b9e528f-e9fc-453c-a024-1cf812cffd0d@kernel.org>
X-TMN: [jSDfxA4qU/FcZz6qCH2szcklr4HMljfkqCDXq+FosKm4tswbnxb4URFlRJMC5tUL]
X-ClientProxiedBy: SA0PR11CA0183.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::8) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZsZK06zCrbH12S8m@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|CH3PR16MB5351:EE_
X-MS-Office365-Filtering-Correlation-Id: 90edd6fd-c4ba-4ee9-6728-08dcc21dfad7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799003|8060799006|19110799003|5072599009|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	UavLk/LyLqY2twL57nq6WAjkncriJayVk/+LF5Ri50rwJ+DfSKUTnG8jefSk+xGtMuqusTrNt8OxHpz7XpN8AV9kF9Ff61GAtzbJIdcUSCKVQXU5XxDGBWvuLEPpZQiukVO1VPZdpitAABpW3WunLkSv2smzwfdwsvQDzL20yUrGCRTMRqLkM2+rGvVuA5x0hJ/eDAjOMkwI6rkRniAaKevor2IRmMZiKtaMuc0AIBlXO9RHr2smdT1mUdP11Ri0FUwqnZ9/UG+W/e/cm/VkKzj7F2eVetavElE6ErBByCg/sBv/pUo4zGVJK1uU+vBdcR52I0Iuwpm5X6uiHIPbw73/HKI8aJ3WYI7BcJB23xlIldn9CVzWiibbSDl974nlJoaWhfc2oxWRlimXqYbEaX3viJjra15zbwl/Xf3ySNwE1YQ5ufUOxroMCFwNYDJV5F9S9ACh/8wjc7knch3YCx9M/v9kf51UMNvDzg73+qYyI4eSziNU6ttANbfFMNYPCS0+QjIWDdVVVJEy1mnkjhFepW4UpVJ3ILKRCKwE76BvqjF03tzNl51prJ0dxQwZENAnkk6iMWmtstoxHbvzBlFkAmbPkYfjihQgehzuncfaNPBV/prAO6zPU6dLyk5qCljzVUho9Q1PzQdMYmFfIEwy8wFk1L7+XkMsESmqSuyQ8VNGrv5Tg1hWveLkKdId3P6StZnVulZh1WnL3xn3Ow==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZeuBHkvG1GrI6xG1CDkLRtwqJoG1fKQe2j2JV0iDTStv1H7HTuLU0vZPSHwZ?=
 =?us-ascii?Q?NHjCyD9bLtGXVowky9ioREuiuMxPNcfUxZn/CZy9DdJBVNsMJjWUjkqDLNkl?=
 =?us-ascii?Q?cRTKEBLmKfUVcOt0rGr5cNgQksDe0nRMCFg5osG2Gp3FO8zbwycqxSOSyPWz?=
 =?us-ascii?Q?g78vzYvtIP2elSm8CbzBvxgx1qPoW4BPak0WK2wMWI0gcAIxnVm9iq1/5gYX?=
 =?us-ascii?Q?rVwR3RbDAocgLHVSfxCC+M4ugua2Ifq6/pxZMuw0UfQAEHj1In1Htm1UVDKq?=
 =?us-ascii?Q?J/HUrVN+REsAPSX6B8+LliNw+YbgHQzf1pgwtQA/0BVBi5Qmh1OlqdbPJnzs?=
 =?us-ascii?Q?WgDWrpeaeTKGwS07Mt6ZTf5sUfc2n9ZkemXu1sEe4OToQ8eYg33bvQhHD3a5?=
 =?us-ascii?Q?n+GZNO6A+q62JoXXvu4IJsqGRWDXNmDETwrIzkaqiyexw4b0Z5zUZ28dk3kV?=
 =?us-ascii?Q?oiXf+/4OG/ZDNQe8LvymwO0UEdNqfUFFzKEfR7OjHi3d3NaBR1shifMfiY4P?=
 =?us-ascii?Q?UB+Tb31JC6LyPkKOP0deyNUMN5520NqzYLzYewDlMY3O7JdL+ZtkboEGtJZE?=
 =?us-ascii?Q?Ib1U7cQSvNFbp6K+1dY7+WRUM+zKlwSuu3qC0AdYzZajlZ7H5OLYp3iuxP8r?=
 =?us-ascii?Q?5DI7AjrzM4JuG2RyoPdTfa/afRijoKPAOKbT7MSdqSaAjsRqsTgkktUO+qny?=
 =?us-ascii?Q?0dZ/zPgZ5/4U8/7rN2tToGpyV+8tl2GeXxn+C+we1SFuFrmdX4QWtt/1/ZtD?=
 =?us-ascii?Q?slpij2CCG8nOMfl1peWTyC0Eoe2T0g1uTQ4KJY1LSupTx5ZG7H856mr22uOi?=
 =?us-ascii?Q?/IVi5uMNKbvWzsYQGTbiHAeaBeqm7yNWW+EX5MHUEBJGDDzY8YXUrqfeUChR?=
 =?us-ascii?Q?JpxdZmwfRC0Blc7zTi3VLoBzeHdTSPprl+2ghZ6SaP1bWwzi1GE9zQc0/UXp?=
 =?us-ascii?Q?ief1r8q1dMyXF7U//OyR1DtFWPfCi+7qCFctKNwqFITUgKd/3Ds6G7QHFerv?=
 =?us-ascii?Q?EGnaU2DkOnkPZxTD/JXyiMqeoAAzIgv0G30ojP8EFLfS0E4fXFCdl51Y/ZUY?=
 =?us-ascii?Q?rKzGi0U+x4f3yZImMHQPl29deYa9JEL8hzUs2kh8AjvR52g+UR2Ky5SJmvle?=
 =?us-ascii?Q?g/97Cu1es2c6M8Mdv5T/TKXyuPu/PJHJV316tU3rxvJ4IqSw19tF5WH/0EQM?=
 =?us-ascii?Q?0NEj9wWoGYqq7J44blmgfbCHIjTyg8acpuGGT87g8cgmEBHKq93ituwL8Bwz?=
 =?us-ascii?Q?9jfvGGkXbecchhwEzR0jba8FL/1Rd9ekJ10zn+/OA/HT8UJsE/CqbUtaMxe2?=
 =?us-ascii?Q?g+l34Y4wvfH0U6/q7ZHzwUdS?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 90edd6fd-c4ba-4ee9-6728-08dcc21dfad7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 20:15:20.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB5351

On Wed, Aug 21, 2024 at 08:37:59AM +0200, Krzysztof Kozlowski wrote:
> On 20/08/2024 22:15, Chris Morgan wrote:
> > On Tue, Aug 20, 2024 at 09:42:06AM +0200, Krzysztof Kozlowski wrote:
> >> On Mon, Aug 19, 2024 at 11:46:09AM -0500, Chris Morgan wrote:
> >>> From: Chris Morgan <macromorgan@hotmail.com>
> >>>
> >>> Allow specifying a hard limit of the maximum input current. Some PMICs
> >>> such as the AXP717 can pull up to 3.25A, so allow a value to be
> >>> specified that clamps this in the event the hardware is not designed
> >>> for it.
> >>>
> >>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> >>> ---
> >>>  .../x-powers,axp20x-usb-power-supply.yaml     | 69 ++++++++++++++++++-
> >>>  1 file changed, 66 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> >>> index 34b7959d6772..9cc300e78f60 100644
> >>> --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> >>> +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> >>> @@ -15,9 +15,6 @@ maintainers:
> >>>    - Chen-Yu Tsai <wens@csie.org>
> >>>    - Sebastian Reichel <sre@kernel.org>
> >>>  
> >>> -allOf:
> >>> -  - $ref: power-supply.yaml#
> >>> -
> >>>  properties:
> >>>    compatible:
> >>>      oneOf:
> >>> @@ -31,8 +28,74 @@ properties:
> >>>            - const: x-powers,axp803-usb-power-supply
> >>>            - const: x-powers,axp813-usb-power-supply
> >>>  
> >>> +  input-current-limit-microamp:
> >>> +    description:
> >>> +      Optional value to clamp the maximum input current limit to for
> >>> +      the device. If omitted, the programmed value from the EFUSE will
> >>> +      be used.
> >>
> >> minimum: 100000
> >> maximum: 4000000
> >> (or whatever the values are)
> > 
> > It varies based on the compatible string. I've added all of the
> > restrictions below. Basically all but the axp717 have a table
> > of values available (as an enum), and the axp717 which is added
> > in a subsequent commit gets added as a minimum/maximum with a
> > description noting that steps are in values of 50000.
> 
> And you still need widest constraints here, because there is no final
> "else" for all not-matched ifs, right?
> 
> Best regards,
> Krzysztof
> 

That makes sense, thank you.
Chris

