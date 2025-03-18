Return-Path: <linux-iio+bounces-17032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF6A67A5D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 18:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445A5174BE7
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8371E5B8C;
	Tue, 18 Mar 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="d2bH5ygn"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2075.outbound.protection.outlook.com [40.107.103.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1137206F30
	for <linux-iio@vger.kernel.org>; Tue, 18 Mar 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317667; cv=fail; b=l0mvW0eBqynNeUXPs+LjzfjEZQbKdb0UbKD1RuxNEgU7fagamwetQkZIToeW8yBztssgmdgFCqEGL6HzRMmmXk1e/X6v3JZkiirW7d9vZc/xGUtoJCsJ2K4p6ULBrbI2zEdKd8105Nm5A31Rzgfah950kBo4SzJhHYmrq9UOc78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317667; c=relaxed/simple;
	bh=2ZjZ5Bj4a6K2M9UVRQcnTnFt2uMrK6uWf31nVWtf22k=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RsVorpTwwsy+ymxwfjAW6U46wZ4uYmw5b52yNKWcXbmZtTY+D5+NrcYOkcCXuGeYC9OzA8g4gmPeNWJ9uOnSucHVYeMDM8g7pPRixtV9ZN8SNTJ2qBu4AbJPFQaipXaTZ/vTMS23nO8P0mAjNifYylvdvxtsvtl27ulpspwUEF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=d2bH5ygn; arc=fail smtp.client-ip=40.107.103.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGI3wvfzCemmI0TuRke0N65f3/bssiB18P/lnE9bfp+kYNkZJ1nrsKg7P/hNbTZR5TW7RsW1LpGxiM33pT/tScNcAP6g1vw83ikyoEGOoF+fKtXoKZRdn9dlZqR6mcd9s3R8VbjinhusqUdMwCnkd5xzG5Ix5S/qqOda0s2dhSLuq5jULXeL8SwEYk5pncfH3i71x7Kx6vT/HmGrZkXifFb8VU397cGb2hQmUhznoO/VUenCNf8uZe0Vnh28hGuvMJ06i0cuJAm8wxyqFAAcitZhydMyp9ikY/kmjJ1J/BaLrC1kWBhu6A7W1+DbAFLl8KuEPDV09WVzVh+/S/B8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reoosN30XZlHvLQa8fpolPFghgiG1QSZMAuuMEsWGXI=;
 b=xpGBxydrTZy5UdjEI9l8931dhhh2tBDDWQ9D1wl5yGsPSf59C7bSPXsY6DTaV1rq15KgKB1mqiQQE/cUxdbbRbQcGGAo6m7zBUhIX6a2iJQ3j7oA/SsLFHFulhj2Xd8lYFn/9idKrImZG9w5oZZA1cci7Y984zFYvfRPdA3sWgbFP1mb+5VcZAJkhFMCHgUEW3fzdGNzDL2ZCLKQnUlBWxJ/ujqD43mrlpn0cX+PKozeUIQbRMKrL+qtTIihQHZsylDVey/h2Q2n2DixeAbpq+5j8odOdrQo3CYT0RzcjFy0nwAEvn/V1O669NfGY+x1bQMjzuqPGpCm37dlQtfF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reoosN30XZlHvLQa8fpolPFghgiG1QSZMAuuMEsWGXI=;
 b=d2bH5ygnLth97oo4e/aDYElUREIpQ3+qoQxXQLzGUMOpdLyysqH5tjKRmkDdhfKjnGpRJWjLxkEe0+M5besLVB0WI+BuR3yAW4OiJa1Bi/d/PxwVlZF1q5/cSe05DYIJauaWSYTnGm4fwxYhZpLWRhA8a+olHfj93IN4iwiNNiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com (2603:10a6:10:41d::20)
 by DB9PR02MB6714.eurprd02.prod.outlook.com (2603:10a6:10:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 17:07:42 +0000
Received: from DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576]) by DU0PR02MB9585.eurprd02.prod.outlook.com
 ([fe80::b1a:32b1:13cb:e576%2]) with mapi id 15.20.8511.026; Tue, 18 Mar 2025
 17:07:42 +0000
Message-ID: <420b9f54-c250-4ad3-a050-27fb1c6aaf9c@axis.com>
Date: Tue, 18 Mar 2025 18:07:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] iio: light: opt4060: Switch to sparse friendly
 iio_device_claim/release_direct()
From: Per-Daniel Olsson <perdaniel.olsson@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309170633.1347476-1-jic23@kernel.org>
 <20250309170633.1347476-10-jic23@kernel.org>
 <6366e065-d49d-46d1-9f69-edf7d0966da4@axis.com>
Content-Language: en-US
In-Reply-To: <6366e065-d49d-46d1-9f69-edf7d0966da4@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0117.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::32) To DU0PR02MB9585.eurprd02.prod.outlook.com
 (2603:10a6:10:41d::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9585:EE_|DB9PR02MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: eddcd435-e31a-4d87-f5f2-08dd663f64e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWIyR1A5S0Jpc2p5M3h3alAwNzNXTWVaR3Y3YU0rRDNROUlqcGtyZUdEd0VW?=
 =?utf-8?B?aE9lait4SVZIYitYSk0ycFFYZW5mTHJHT0VraUhSejlLdjhyUzIwMnN4QXBG?=
 =?utf-8?B?ZHR0OXhJMzlxQ1VIaDY0MTNncXE1aDhVcFVJRlB2aVI0NkNzMmg1aGNjOGNF?=
 =?utf-8?B?RlFPcHFhYWRVWVBNcVgvVDFRclordHZ6UWhZZGdCMGdnMmxibGUrdmlBb1VF?=
 =?utf-8?B?NjkreGpUWW15UzJVV2pPeHdybGxmZjhKRTMzUDhZNERINHo1QzVrWkRKbzRK?=
 =?utf-8?B?TUxtTGRhVGpvaHdNTjBNcldjdnNpNDQxdENzdElHTDJlSVp1dFFTMjFxeTJn?=
 =?utf-8?B?d28rdWEyRnNDY1BOVWtTc2JlczhxL1VYeTJuY2JZTUtGLzJBTVFGYzFTOEhV?=
 =?utf-8?B?WUZWZVNnUEtCb29xVWp5WCtrcHgrUDF3U0lwYVhUck0wbTlLSElhN3pLVUpT?=
 =?utf-8?B?RnZ0Y0dwSzRVWkRrMWJVdTVnVytsQThhY2h2ZExPUG9ZYkExTnBYKzNsMXlU?=
 =?utf-8?B?M3pBdzRRS0FENElqWGQ3TTQ5bmJNRTAwNGIyRTYyMWlDK2ZXYjVBSkpYdm45?=
 =?utf-8?B?RUdWVkNoa3g5aTRhRUZFbGdjQ21LQ2F0TkpIbWlvcy96a1VWYnhZbmZNY1F1?=
 =?utf-8?B?STZuZFdkUW5GbG8rUGluYmZVQSt3ejdRQ01IWkFQWDRtTTZvSnZLMmFObWZ1?=
 =?utf-8?B?MW1Uem9xUW9sdW0vVDg3RFU5U1VaN0orZlhKSlllL25iQVFRSjhka0N5SUdo?=
 =?utf-8?B?MmZaRkFHTWxBYlNPYzNMTmFFa3lyamt3Q2VKbEZvYTNGcyt2WHN6RTV3Yyty?=
 =?utf-8?B?L0kzOW8xbVJSdks1V05BR3FCMkh5MzVidzJHVlIyRTN2ZUVVUjlKd29lK0c0?=
 =?utf-8?B?Q29kY1JaNVc3Q0k5a3VGaFhKOUVVRjBuUDB3MzZPVjZ5YWZzRmJkZnZ2eHlJ?=
 =?utf-8?B?N2s4L0hVd2hnOVd5K0hqMXJtNjBXMHVKK1d0bVk0VFZHL0hvUDcyM0owWXB0?=
 =?utf-8?B?d01pUnJWRVJ0eWhvWlhnTHBMaVpQL25nQm9lRisxSGtGMU9kOHZRT1Fma3dz?=
 =?utf-8?B?N2UyWWUwMVV1cFRPNmxqazlwdkhBQ3V2V1BMMkhYaDBEREU3OElLWXJjUnBR?=
 =?utf-8?B?Sk43eE1SSHVNbHc4TEp5UkNybk1qaUs4ZGplRGloSk9GSmkwb1hKVXdNMUY5?=
 =?utf-8?B?L1NsdUhGdVQvZ0JuK2N3b1kyRVVZU1oyRzZQaFllR0c0bGI2WkZ2TzVTaGZK?=
 =?utf-8?B?NUFXTnIzUWZuOEVwRXBqZSsxRm16eVlWaFpCSHk5b1dONGpoUFhFaVp3MTcz?=
 =?utf-8?B?K2F1NkJMdjBpKzltZDhGVGhMaHlWd1NRYnZubFNaRWxObloxVy81bzNyTEVO?=
 =?utf-8?B?cmE0TU5OR1lJOTlieGw0TjIxbGFVOHk0b3J0MlBTT3V1WUJUUmFRcG9DWEdD?=
 =?utf-8?B?OExadHFwWFZ5TVNQbjY1WVorOCtjbXFXRHl3S0kzUU5ETFd6dHU3VEhpZHJL?=
 =?utf-8?B?R05LQUxBY0JJMGhoNkJLcTZDakNuMWY4YjhudllOYVBlV2ZSR0ZndGNkOW9Z?=
 =?utf-8?B?Zkhja1lpN3FuSGlCRnJQQzNjN005cEdOSXZMU3hzVnkrTzQxUE9uRWV5QnVv?=
 =?utf-8?B?RFNCMTg3NDNXbjRPZEd6dVViL292NnRlRG1jMkc2TERmQjNwV0E3RmlTZGQz?=
 =?utf-8?B?OGt5YXpQekQxa3NVS29pYm81UGx1MlNMWk8zdWt6OTd2NVdtVmwwbmxJSTds?=
 =?utf-8?B?SktTQ2FZdUxBd1JwMHpMTVFiQkIvV0pTak92OW5SeUZFeld2eWZsUk9PWXRY?=
 =?utf-8?B?MXBXL0ZYbmx5V3BzWGZCcVIyNDlhaERqc1U5alhSb0lEdGMxeGYvT1c1d1Q5?=
 =?utf-8?Q?pa5Uha4zYcOnI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9585.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU1sN1hhZVRlT1VhMUtWRHEyUGNQWXVzT1hOTVJ2ZzlCVnp6amY5TXg3cEk4?=
 =?utf-8?B?dU1EcUhPRXFSQVZIc3NaRWlVU2gyRVBtN1Q5S1NZbUxDYXZXU0wvUWRkeWg0?=
 =?utf-8?B?bER0V3Qxck5EYUNwZ3BWcytHbXRabUdYYVcrMGFBMSt1YjZuTEpkcC9RMEp6?=
 =?utf-8?B?K1o5MVkza0Q3TTNBZi9pRXltOWh6dHV4dVBrL0trWVVBOXlsdXl4NXR0dXV4?=
 =?utf-8?B?TXJ0dGhZUWJYdU9jMlVIUW1Sd25EQ1NXR2tLQm5ReXBtSDFXTjIyL1RHbU9H?=
 =?utf-8?B?eEdxcmhUUnBpc1ArM21sZEFpNGlYZnZjM3ZHWUZnV0FFY0hoUE9ZdWdLeTJr?=
 =?utf-8?B?LzBnOGtGS3hOcjlvM3NFd2k1cExIRVZOcUlOSU9pdElwaEJCN2R1SkRvK1F6?=
 =?utf-8?B?bWFIRDA2dUlCcmJrQWdOZ0E4TmhlY1Z5THhLS003eWlTSFNrNkRwbEZjdis4?=
 =?utf-8?B?akhZWUxsaTlEL2gyR1lxQ3N4QTBYdFZ3TEp3TTR0M2ZxUkRVK2pGdUFxN2NE?=
 =?utf-8?B?bWZVUGoyaVhpZVBLdU16RmNLMGVBNmlIN3NNcVdoVFU4aTRiMjMwd29NWDAw?=
 =?utf-8?B?Z2JydjBOalF1dmhIS2VaOGZKZGlvb2RlRWgra09YYmVhRkFPb0pRNnI0TFFl?=
 =?utf-8?B?amJRZTBPZVhIRDExc01IQ2xtcGlud3AwbDFuT0U4cWE4QkZEYjNPeGdYd3Fj?=
 =?utf-8?B?alFPZFRQQ1h5dkhSMEhnMEJpU01Ybk1aSVpHN2RaNDc4cnJBUHpkdlFBWENs?=
 =?utf-8?B?azVFRWJCZGswL3d2bG5hTXprTUt1STluUjQzdVVNTXhFYmR3c1NDYTdiYjRi?=
 =?utf-8?B?VnJEam5UYTJ4U2RqVEIrRkdlT0xiMElGS2hGSEhrVnF1Q0NzeDhRajFML0Mx?=
 =?utf-8?B?NkpnUmhLUGpVTjhKSzk5TGlQKzZaR2NHOXZRREplMDRpTlZRY3VSa3dpMmli?=
 =?utf-8?B?Rnh4NGY2bkdXazFqNnY1NXVXbXJaMnRML1gyLy9seWRqRVNrQUZVZVN0TDhB?=
 =?utf-8?B?Y3BGMGk3SUJtRzk1Znloc1A0YThKTnpEcUJ6SHNKZ204V0FLangzRXVqTVQ0?=
 =?utf-8?B?ZUZCaG04M0VlakQxbEF5bkVPYTRNM24rR1ZnTUVWSDZXbUl5OFk2Tjdpd2Uw?=
 =?utf-8?B?Mjhxbm9XNGdDdS9IbnFGcGhRTUJzNmcyUUQ0RzE5K1REZnNlemZ0SVVOY1U1?=
 =?utf-8?B?dnU0UFJHRFZSK2dEdTJFbmszaTlsUEdncWdLcjV3QWFXdUNpYXpHSjFMWFJ4?=
 =?utf-8?B?aGtlSHdBUU9veVVnVHRQWmdZQ1BENEFlSEVPajlLZGZvU04rRjJCNlBjb05J?=
 =?utf-8?B?M3p0STVPcU5SM0tTL0loOXdIYVB1RXE1N01UTVVYbCtOQzJUb0JFSGV4Vjlm?=
 =?utf-8?B?KzRwUW5VS01ncjdUMnMrbWFNUUV0R0pzR2lxdFlPSUdFVzlsZE1QeHU4ZlZV?=
 =?utf-8?B?WHpPb3NmOWVQM0l0dmxXZjYwa2R0SzBBeHEraGZ3azFXL3FiNFNObEczQkNN?=
 =?utf-8?B?VGttd3pxQUV2MEM2clYwL0ZoUzR4Vy9ISHdCeFdHYnRIQkRxTWJ3NjRINWli?=
 =?utf-8?B?S3NzSlJJbnVTUmNIdlVEeTR0clUxYTEyaFp4SmswakRZa1JGK1BjVnh5enZ6?=
 =?utf-8?B?OUY5Q1d3K0g0cHVtYUNwMVlGS1hiUVRFUXE3V1ZXaHJkdGVyN0FBM2JIUHdn?=
 =?utf-8?B?RElvc1V5QUorNHVuVjdyYkZ2eVhsZXRybFNjeUw1Vk5zTS9XN1JqU2VZQzVt?=
 =?utf-8?B?bHJHUFBYSi9EZlVBdEVEMDFRVkludVV0cFNKbmRyaTlaS0U0NllMUTRQSWlV?=
 =?utf-8?B?OVJPNTNvS0J4aHZrREpQTFppYU9nYnJ5N3dlcER2cm5rZ1NFMmQ2bGRNMHN1?=
 =?utf-8?B?MlRLVlMwa09mcEVwNEtjMWlMUUExTitYQU5RMmMxUGxmSDNJd2VPMDl3M2NM?=
 =?utf-8?B?Sy9ZZGZmOG1XdWZBWmQzY3Q1SG90bllKTkNPMWNiZFFGTE5mRVJuY2syQjJn?=
 =?utf-8?B?Z1ZnaTFubUVWUDkvQnB4S0x4MGE0czRja0NjRW5UWDBRa09IK28xRnBORW82?=
 =?utf-8?B?U1lVcHYzd3U1Wmp1cDBjc1kvUC9uRCtrRVJ6enVKbWIxaFlCVkVFblZWUnV6?=
 =?utf-8?Q?+4WA=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddcd435-e31a-4d87-f5f2-08dd663f64e0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9585.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 17:07:41.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMMKKX4jbu4UIRK69JOJVrELt9YqZpLhelhdY7JHiSrQ0ShjJL8dToRd5ML5JSbH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6714

On 3/18/25 09:10, Per-Daniel Olsson wrote:
> On 3/9/25 18:06, Jonathan Cameron wrote:
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> These new functions allow sparse to find failures to release
>> direct mode reducing chances of bugs over the claim_direct_mode()
>> functions that are deprecated.  This is a case where the code
>> is pinning down the mode so also has a claim on buffered mode.
>> A follow up set may move those calls over to a sparse friendly
>> form as well.
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Per-Daniel Olsson <perdaniel.olsson@axis.com>
> 
> Acked-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
> 
> Best regards / P-D

I have tested the patch and reviewed it, maybe these tags are more accurate
than just Acked-by.

Tested-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Reviewed-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>

Best regards / P-D


