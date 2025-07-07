Return-Path: <linux-iio+bounces-21417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6CDAFAEDC
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 10:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D6A7AAFF7
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 08:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFA0218E99;
	Mon,  7 Jul 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Llvtnv1L"
X-Original-To: linux-iio@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012064.outbound.protection.outlook.com [52.101.71.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0062E3712;
	Mon,  7 Jul 2025 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751877977; cv=fail; b=DZwQLQRE8e8h9oD8dSd7Sq6bs9jhlMecm3+I+PkCrvbhNZRRt4b5280L2L0k3jlLPLOVxvaOKJjpH9s+A691lu02+alF1cehhguI5nFxRBx5foDyN9syAIw1w7ZauwNXpBdxrsZssOpZat9UK6OsVKOl3e4M88V4nEsl+C9wpDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751877977; c=relaxed/simple;
	bh=x5JStnarftLAv7EoN3mAeNlJDIpo89J60q9IHmnXq2I=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AgJiJGv3YsEmqP6vNEtu6rg2e342GeUsOnGVttzp0wnap7C4EQQbW9QdSnBPwc8lNRP1Yzh6E8kRjPvKU/PKsOaU1BG5UIVpu1aTdNW97VTU51Ou92F2nvpz9a941c9NHxoquZfDMGG5s7M94YZoUde6NUpjAbwHmKr7/mlZ2kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Llvtnv1L; arc=fail smtp.client-ip=52.101.71.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMG1orpR1gVFwvZtHhIs9nIru9vpJkM5n1gjqdubwtEZWmWdh5la9qqbO1eq2S0uJSvy+NcBJnZBHzT9pEbpL4A5i/Z6xNreH5q2rChvLJrTjv68ngTFWBCb82Ah6vqZKj17z9CqZirxIfhIbCFbOAJnfyoCRlT0+EboRSCOzwZzbJEifKm3IUB9X7MAm2Yskp/UHBjiq2lSJsdMoA9+NS0vmQmkEjMiHb22p3cPXbIWGV6dL8+RwtF+18YMxCSUAk8j6NXXiuLGRIKdJtXdTHhxhZ7hBYFnPm2pl9Pp1LuLebCtWA5nbVIdNgOn7GIeaseR7TdWKcHy3ATTBIKf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrdEzJCioHAM65msepWhnI/lzM0cMIi43hbtfcqTSxs=;
 b=WzPRBTSQPfszB/g7GRRu+TFTvqhs+PHeyPy7kHo+z7w12oVqLCYv2iq87PnKUeM984RL/zIekc20QMM2Gd3twFkeMQ41Aq4YCilvcg06vpMzn+dtCI9UOQrBeRu6z7DLd6nrxePvUqsidiSqBm39nhHRylf0DbN40CCbd4cXhjU5p5EzHSnYS7JBnHethPAAaT0yR1Edq/M9+tsAlbnXwjsWmBJktO8jnxQ+ZVmSd1n6StkQEnabgqdnxi+ejVixJUfupF/E4v6uc5e2Hws27F5OTXXUDjYI5ogw5PZDfTbiC1BMmW0ErUUS8j9/Rb2vIE+KjWNOpYrIf0ot6csZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrdEzJCioHAM65msepWhnI/lzM0cMIi43hbtfcqTSxs=;
 b=Llvtnv1Luxpc29mixd+GKo5oYiqsInrQWmbOoHVUYt8QLBSVZN1w34K3nNJASyJ4KKVJNymB1k+SFgazredh/Z4Rc2LBe+spiAXCucp3FUSZWhiVKkeR7HNMKk/4sggAfZHyYiXQJb38iex16ohEnnG1iX3M6mmVRNg1PiYQbnE=
Received: from DB7PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:10:36::32)
 by AS8PR02MB9935.eurprd02.prod.outlook.com (2603:10a6:20b:618::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 08:46:12 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::3d) by DB7PR05CA0019.outlook.office365.com
 (2603:10a6:10:36::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 08:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 08:46:11 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 7 Jul
 2025 10:46:09 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?Q?S=C3=A1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
In-Reply-To: <20250706121117.75665bb0@jic23-huawei> (Jonathan Cameron's
	message of "Sun, 6 Jul 2025 12:11:17 +0100")
References: <cover.1751636734.git.waqar.hameed@axis.com>
	<29f84da1431f4a3f17fdeef27297a4ab14455404.1751636734.git.waqar.hameed@axis.com>
	<20250706121117.75665bb0@jic23-huawei>
User-Agent: a.out
Date: Mon, 7 Jul 2025 10:46:09 +0200
Message-ID: <pnd7c0ks81a.fsf@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8D:EE_|AS8PR02MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c7eed9-ddc1-4a83-a1ed-08ddbd32b995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0emH2Svxx3oVkGDjolESdcgDA3g9HzS+4X2N0ay29cUyXrfpdJtcD311tomK?=
 =?us-ascii?Q?OjvXq/muoghYsrfa9cN7AhO7mlgJXJohdWlAtSHVhy5TqXgg6R4me2Duhp38?=
 =?us-ascii?Q?bw7zosDohRSBqC8V9pc4IPaZjI5RX9oy64+zxpx/WysXCHjhwlSakG3tXxfb?=
 =?us-ascii?Q?KMMY00usIXQbvbtLqwoSWQKXden9YxmLL31bxwkgV8R0GTi4i+WoeQ32yfXs?=
 =?us-ascii?Q?r6Ogx12IlpezOWsYugMzP0AhAeXvPsYc4fZJInJU7Y8MJOQ+PcZ1Tn2hC3hF?=
 =?us-ascii?Q?sCUYh/P+2sLKZNjsWwbuTAy6mTAfDuAFJCQOgkJCB1KZYiST0qnyxSgRAaga?=
 =?us-ascii?Q?DJZa/q5W1/Wo7O6U8WE5KHPawCJyG6w4SXUTidg34FSAWr3ujZhxxlo4A23s?=
 =?us-ascii?Q?uCOB8PdZPGOm96z55Tj9g7sBIRIewp3pZ0mpu1Ohs9FEY9NDg3T5KbITFrQ2?=
 =?us-ascii?Q?Ef5TiK1YqFMlSXyXNSW8TMKx/KmW6ZlY6J3tn9DB6tN333xRU027oyBxKwVh?=
 =?us-ascii?Q?EIPknWf+j+fDPbni/kECsLDC+5XjCSgW6Qq/MUCnbILFOj5gv/TS0XHIc3/n?=
 =?us-ascii?Q?5roo2/4Fds20XKMknwCrgz/G83nVSIUKZofWIyNI6Ncx+cg8S7pW4eANUVNv?=
 =?us-ascii?Q?1Ub/b0Zy+eHbb59Z/14gYADovnF5FpCMqyi49tq0T9iKIjhh16VnVbDQsnll?=
 =?us-ascii?Q?zeXM2Rcl5Bj2zZns7gcRvZWSIZ48AcV176Qux5drT8+kojLcnn3VavZYvCkt?=
 =?us-ascii?Q?g7e/I7TADXhl2Tq530JcvPM75Lh4cYTpXteS/BK9sPLReDuJDHI/sWWgfasN?=
 =?us-ascii?Q?rTvGxo+3ccIHE5vaMmhGvRsB+aodrLw8ZlNXVOizi9aOP3hfrK3ZE9BSgIUa?=
 =?us-ascii?Q?6GQOyrVFptoij9WUf+521dHycMndH7PRG5/aEv8eYj/c3arm8kBKr1v6xl4W?=
 =?us-ascii?Q?ux/PQfxwDQcxkGzMWP5nDmEKhHBLYDfSWhdIfOU5AGTEArbuKKxaBkh/Ekiy?=
 =?us-ascii?Q?SgIARoMwsLZOxDpKc+lMQSiCkziM1LcRtiM/EsdXUyFVD8i34jQdzb4fX/t8?=
 =?us-ascii?Q?4t/Q2A2BdRdaf8Z9qJ8Zx1aocudIe6RzrYS3EBjjoC+v6aMIVPADaifasDRN?=
 =?us-ascii?Q?bfh20nADKTk5+2KG+CimyUTfKTAH+q32aYId21i0GgBppOGaxvUCGmdlbPp+?=
 =?us-ascii?Q?p7WYMUzOv6HqSR4BJfjYNVv4KBGGObmTXd4/nWLb/6VDitqGYM5Zb2cmhTjt?=
 =?us-ascii?Q?c9e+dmLEjfKrNeJzdx3Y0hWWBvzg7mK0sG8ROBTTmFWFP8dgmlMr4LCjNGGl?=
 =?us-ascii?Q?tJHQ25gn775Lms6bvD2K3G/RtMnA43a6UyK2FBtXTvg7KCZ2Frwb2005A+lX?=
 =?us-ascii?Q?CzFwwoBU9/QrCnUK5o0I+4LnUi3o5bywHfnYWOzLPdYWezhhXFy8MPhcfO7+?=
 =?us-ascii?Q?dZUFufik8b/S1h7PNRUJiy30cMwdmENawto+EeBpl5WgzIH/anZdZLyE9zn/?=
 =?us-ascii?Q?1lRfy3+vjLS2YSVbEg0LjRoyqHDR1T9dEuLF?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:46:11.5552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c7eed9-ddc1-4a83-a1ed-08ddbd32b995
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9935

On Sun, Jul 06, 2025 at 12:11 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

[...]

> One suggestion inline on providing more information on the 'why' behind
> the regulator handling.
>
> I want to leave this on list anyway to give more time for other reviews,
> but if nothing else comes up and you are happy with my description I can
> tweak this whilst applying.

Sure, we can let it breathe for a bit. I'm fine with you editing it
while applying it (maybe also the minor format comment in the
dt-bindings patch then?). Either way, if there is anything else you want
me to do do, just tell! Thanks again Jonathan!

>
> Jonathan
>
>> ---
>>  drivers/iio/proximity/Kconfig   |   9 +
>>  drivers/iio/proximity/Makefile  |   1 +
>>  drivers/iio/proximity/d3323aa.c | 814 ++++++++++++++++++++++++++++++++
>>  3 files changed, 824 insertions(+)
>>  create mode 100644 drivers/iio/proximity/d3323aa.c
>> 
>> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
>> index a562a78b7d0d..6070974c2c85 100644
>> --- a/drivers/iio/proximity/Kconfig
>> +++ b/drivers/iio/proximity/Kconfig
>> @@ -32,6 +32,15 @@ config CROS_EC_MKBP_PROXIMITY
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called cros_ec_mkbp_proximity.
>>  
>> +config D3323AA
>> +	tristate "Nicera (Nippon Ceramic Co.) D3-323-AA PIR sensor"
>> +	depends on GPIOLIB
>> +	help
>> +	  Say Y here to build a driver for the Nicera D3-323-AA PIR sensor.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called d3323aa.
>> +
>>  config HX9023S
>>  	tristate "TYHX HX9023S SAR sensor"
>>  	select IIO_BUFFER
>> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
>> index c5e76995764a..152034d38c49 100644
>> --- a/drivers/iio/proximity/Makefile
>> +++ b/drivers/iio/proximity/Makefile
>> @@ -6,6 +6,7 @@
>>  # When adding new entries keep the list in alphabetical order
>>  obj-$(CONFIG_AS3935)		+= as3935.o
>>  obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
>> +obj-$(CONFIG_D3323AA)		+= d3323aa.o
>>  obj-$(CONFIG_HX9023S)		+= hx9023s.o
>>  obj-$(CONFIG_IRSD200)		+= irsd200.o
>>  obj-$(CONFIG_ISL29501)		+= isl29501.o
>> diff --git a/drivers/iio/proximity/d3323aa.c b/drivers/iio/proximity/d3323aa.c
>> new file mode 100644
>> index 000000000000..b1bc3204c0c0
>> --- /dev/null
>> +++ b/drivers/iio/proximity/d3323aa.c
>> @@ -0,0 +1,814 @@
>
>
>> +static void d3323aa_disable_regulator(void *indata)
>> +{
>> +	struct d3323aa_data *data = indata;
>> +	int ret;
>> +
>> +	/*
>> +	 * During probe() the regulator may be disabled. It is enabled during
>> +	 * device setup (in d3323aa_reset(), where it is also briefly disabled).
>> +	 * The check is therefore needed in order to have balanced
>> +	 * regulator_enable/disable() calls.
>> +	 */
>> +	if (!regulator_is_enabled(data->regulator_vdd))
>> +		return;
>> +
>> +	ret = regulator_disable(data->regulator_vdd);
>> +	if (ret)
>> +		dev_err(data->dev, "Could not disable regulator (%d)\n", ret);
>> +}
>> +
>> +static int d3323aa_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct d3323aa_data *data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return dev_err_probe(dev, -ENOMEM,
>> +				     "Could not allocate iio device\n");
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->dev = dev;
>> +
>> +	init_completion(&data->reset_completion);
>> +
>> +	ret = devm_mutex_init(dev, &data->statevar_lock);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Could not initialize mutex\n");
>> +
>> +	data->regulator_vdd = devm_regulator_get_exclusive(dev, "vdd");
>> +	if (IS_ERR(data->regulator_vdd))
>> +		return dev_err_probe(dev, PTR_ERR(data->regulator_vdd),
>> +				     "Could not get regulator\n");
>> +
>> +	/*
>> +	 * The regulator will be enabled during the device setup below (in
>> +	 * d3323aa_reset()). Note that d3323aa_disable_regulator() also checks
>> +	 * for the regulator state.
>
> This comment doesn't explain why you do this here as opposed to after
> reset.  Key is that there are complex paths in which the regulator is disabled
> that are unrelated to probe()/remove()  Talk about those rather than why
> this 'works'.  It's the why that matters in a comment more than the how.
>
> If nothing else comes up in review, I can chagne this to something like
>
> 	* The regulator will be enabled for the first time during the
> 	* device setup below (in d3323aa_reset()). However parameter changes
> 	* from userspace can require a temporary disable of the regulator.
> 	* To avoid complex handling of state, use a callback that will disable
> 	* the regulator if it happens to be enabled at time of devm unwind.
> 	*/

Ah, I see that I misunderstood you the first time! The comment looks
fine to me.

>
>> +	ret = d3323aa_setup(indio_dev, D3323AA_LP_FILTER_FREQ_DEFAULT_IDX,
>> +			    D3323AA_FILTER_GAIN_DEFAULT_IDX,
>> +			    D3323AA_THRESH_DEFAULT_VAL);
>> +	if (ret)
>> +		return ret;

