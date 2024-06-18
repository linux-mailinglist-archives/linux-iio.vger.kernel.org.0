Return-Path: <linux-iio+bounces-6475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11C190CB84
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A634B2951A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEF38002E;
	Tue, 18 Jun 2024 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KVm2sfvO"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2033.outbound.protection.outlook.com [40.92.23.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D92139AF;
	Tue, 18 Jun 2024 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712327; cv=fail; b=Nqxd7oKEMv55juzPwFyPbIR4MavK8MLacFneEf/izS5BMEDGiPozeJx4Qconx9SKBs4M0+OJ4HLejI5xZ2xThWbfA27O1rwgU9bxQNW5sPrDCFNa9p7t/+KI+livG0CNXz7vOip58mZH6944D4QuXY0d/vwjD7Otj4gNfXEfkV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712327; c=relaxed/simple;
	bh=AU/tAjqJbGUN2h1c7ekJ+CYla+AobS07/Hm8JIYxjlU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CNfh1b1Q1krFnpAQWVRtH/SAtJHrJeAE/DbCYcyuCHHjFQcBtC8mKvaucOzkPN4kRvZZshQyW3ry7kpdBkCrwPbnxaZHe4Z2KHVgoJyCj4mAFw18OgngVAn2yeXsHOlKztNMeD4AT10W3QeAXs8W2Oj0B31N8wgoa2VYiaJ2jX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KVm2sfvO; arc=fail smtp.client-ip=40.92.23.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQbZtpoQ+PSQn7pkwGwZkRHXFQKf6+jhh4e/51aOBwAU4fUWfWSd1V5C+9MxkzRa1LJJC32ZoJveFPPZA4l+ab1iWZcbgXdoVWuHeHfHs8HNA7K5C7aOG0U0cMkhuFPpfd6Nuepjpc0MpIRToJgKE1K4WqYwxIQpOUBh7KGqFSRZs+fHjYPACHu5h1DHoswLcDh6Zx/sf0JG9W5cthuOTN+HArpvvMtK7VcZ6y+ZrRtKymRnSr/kpLpM4iumTFN7ZpCjn/6J7doZpmfLa9B2LHCb9eUcugpIkItIkcy4TWTEzuFMWrC9gVMEQM37OX4vQcKg2ABLOBowPXHJxzXZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zXH04wzzGel1jsED1gLaXtxLrZ7HCf4x2tq0XT3oQ0=;
 b=Pl1AYCou69em+9YSq64ulQzYdNQUl8dixko3MnMPetfV5HT9V+11gCdt9XKhSXWLFKtI6BTAbE7vKCYxxNr7WLJgnU3Qhfw8cgaukw+V08ek7HEoze9ua9pSl5hzZJlNgKqeSJynYEoR3fa/UrHpsLvTVltpblQpnOZJxmXVNWYYll6yHweHbbKYR6fjR02HswGC/xs5ksLV8eP8d23S4iV60a5LUHDdrqvLCUzOt3lyFyH2h6tHsJ9tAS26AsSRis6yn4RKked31LAsBEDTbv0e++n5+GUKLNUZl6X5/lRDZCzXfiqr4JMdmK8Q5JPvxL4llqDAnS5BopceK5KEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zXH04wzzGel1jsED1gLaXtxLrZ7HCf4x2tq0XT3oQ0=;
 b=KVm2sfvO5aWfh8OR3iqCyRvZTe7oVdDmnnEYNtyu1N/k6F+l1xTfwJlVH8f+DFgg7sgeGtVI5Aa0DDQliaCeRnG+mrO9I7VM32Gc5oaAJ047KkPNti8TEqOuCY4nVMoEdZhwxXn3pICaP8gCUrpMHzs+XJ2yGqLU26l1GCblsL2xpLHQ8dwmxBxkRtefPbmgZ1ZssGoIC/xeU5h4/KMYrGiblI1vs8oscmPNNIs4Zp3DRvPwgC0lVmNfjLd157Xnqi72+BiZLCse/1kwJb70rSwE4dw2P0ojVT88jviutL2eltm1Z38TF9idCHdZ9VdmnJilghirpbUdHD1AcUfRsg==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 12:05:22 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 12:05:22 +0000
Message-ID:
 <SN7PR12MB810159A22C9814AA7FC1AB96A4CE2@SN7PR12MB8101.namprd12.prod.outlook.com>
Date: Tue, 18 Jun 2024 20:05:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
To: Jonathan Cameron <jic23@kernel.org>, kernel test robot <lkp@intel.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 Yasin Lee <yasin.lee.x@gmail.com>
References: <SN7PR12MB8101D4BC788B5954608D677DA4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>
 <202406171946.qe83Tde0-lkp@intel.com> <20240617202248.35994484@jic23-huawei>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@outlook.com>
In-Reply-To: <20240617202248.35994484@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [tcurI1lzZRfz6zIKdzWFDEGMHflUqkMuVVIe2J5drZ//L7lZ+pe4fzNxfOIQz6bk]
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <bc4fd213-78b3-4bf8-bfb6-b31b60965d54@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 9745ef0e-8e92-4f7d-507c-08dc8f8eee39
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|4302099010|440099025|1602099009;
X-Microsoft-Antispam-Message-Info:
	EehFTZ7jyWP/io5+d5iZiGotlGlekvmai0POcnxv70mAM44daEWROvVXWHPgiyBB0IwuXJniPIrrqAIeARLx4viSYFMFVb4g0NhuXHAu8L5ytJL0ezZyC6HSKg5fHV9Yc8CHCnw4dKrs2oWoshxNBQqKUAckiSWWlX+j1ASch0LlTNf0ZgVRnBdxoRWNimA81p9xjOMVkVRQjc2G3iPWqjcRNDxQxrbCMJPxmrYQyzWfYEj2ZoX6du/ANIZtS/iuwHnP4o4mtg1D9V+i6J76D6TM2snu2lPSiidCFrOCz34o+uydq/HRQT83VfGzyj1IqY81SAiQQNrzPSprpkW9fHvEzBoUpNZ+3jdoEu3vzWfPxb5+Yzw2s4ShuochH293KVmzMy7asoQ1aLoRTFTSAa85za3DUTMvRrdg8/rruDysbMqdKZKCYe+xf70RVNmH5r79PKh/Cf8uXWNBYxXMI6SRtXfK/WG9mfGzlpglNREg6J3hGz+lF/DBCzqW1/ZwnHX8vGBngoo7r1wEoNmto3mXNUXT3QbFp703BhTvcKBJGyOrJe/b/rC5USCSUJcPt2ZiTKShI+uVL4cj0bOAOQWsGSIgKfVwL6UJ6LWLIG8sxoiAt7KAfDiacsCbSywZTd42F53hk8ugWUCONPSpoJL6CPodfVRM8YXViknpoNhacvzQ3RurV9fePG5IIhr0IpfZ+XY+IQOFUX3YwJv/FQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEZSeFQwSm15VGpkWFhQMnd0dW5PZk1mNGpJaGNZSVNubkN5VW53eWV1Nzcv?=
 =?utf-8?B?ZDI0S0xiRlNHZWVIT3B3MlVyQnMwV1F1MGhleDZEYVY3VGwySE5rbU1kckcy?=
 =?utf-8?B?WURISXhjeWxuWUxZZkZXekxFSC9ZMlp4TEp4c1dORFZnOVBxWXpvOVM4eXo2?=
 =?utf-8?B?eFFTUWxuaUJCQTU5d25YNGNnaEx5eWZlaXJPV292MFd2bGdUaVFoc3BqNnFn?=
 =?utf-8?B?eHJaTmF3VGxFZXZHZmp4SzBsdlFRVUdwaDZqUDNmSXMxenlwNGkrQTM4WXZT?=
 =?utf-8?B?djV1VkRjclQ0eU54V1d2bFZ4aWFqLzc0dWlDNG1qM1J5aXh1SGNxOGJZSHdL?=
 =?utf-8?B?T2pMTzczY0E4bGJqMDNWMkt1ZmJ3Vm0yV05KaHpiekxWMjVYbDIzaEpnRXJv?=
 =?utf-8?B?Mk4vdkVmaEpsbVBIRU1KREUrVnhGdHhzakZyUUlua0pMQ1RnOGk3WWFRd3hU?=
 =?utf-8?B?d1VkK0d6UWE2bnhBcEZRaUcvT1QzWjhQMVNPeS8wbU5TYWFocWNuY25BTUtP?=
 =?utf-8?B?ZXNhTnhwdW1rSUdaVWFESC9qd0w0WHBOWVMvcVA4bGpuRlZpUmpRdlRvbVJk?=
 =?utf-8?B?c0pBVVZLNERIdEtoUmtJNS8yYW1pdVVZWUZxQ3hTM3lkZWYyS2pxV0p4OE00?=
 =?utf-8?B?NG4zRmZINEJUNjhuR2hxTHJCT1FHOWdRR3Y0eFovNDdxSk5LMnpWYTRzZ2NB?=
 =?utf-8?B?YVJHYXFPWEVTano3TTFxamNUM3pKbFBCY0xmSVV2aWtMVEJaZjlqYmh2RHRz?=
 =?utf-8?B?Z2YxeHFwMy8xYS9GcFBnRkU2a1JxUlRrQ1JDL01XaTBvTFU3SEUyZTBtaDha?=
 =?utf-8?B?eXBleFR0NVI0Q0ZLWm1iQ0VmbFF3RjI0VWFqSXpKeEdSSzU2dkgzcGZNeUs5?=
 =?utf-8?B?VjZzYmNqNi9wbjhQTExIVzlZaFZEMU56aHdyUkZJd2FnN2hTbzlWdnFaS2Zx?=
 =?utf-8?B?ZDQvczN1SjJad2RXR3NhVS9DNGJEN3h3Vnc5V1lBbU5Yc2pvVjlNNGRHamRW?=
 =?utf-8?B?TXBUTk1FNVB0TUtMWE1DWlNqcnN1YjFKaEFncWdJOE5tYytFNll3Vk1YZUpV?=
 =?utf-8?B?Rk1iSzE2cG5kUUtNUllXVllRemV1M1k5NXlIZHdIbnUyeFpXTkZVMEExREk2?=
 =?utf-8?B?K0Nkc1FjZkx1US9QZGhVZnEraWNLNjFGUnd2ejJkU1lwVXljbk9QRU9XQk9Y?=
 =?utf-8?B?SXU5UllyTmNpMzBkM2NKNEw5THZ0U05BQW40WVlRVVlpd01LUnNleUlWaWRt?=
 =?utf-8?B?czBGTmJFT0xXSGkyU1JERUowMVU0Q2J2d3h6azhwS0dqSDBJUnljUDJOOWl3?=
 =?utf-8?B?MlFidm10K010RFk3bEpOR1JlNk80YkNRZlRiWTZSbDVxUytjSmZCSjFSbzBN?=
 =?utf-8?B?RkFWZkJxbUVRSDlNTlk2UVMraG1wemdHRjJiTFVwdkxxNURmZ1dNak1QR3o5?=
 =?utf-8?B?RktuZGhvSnUzSFZ3QlJCTGtSS0E5QTJUL0tiYm5wUDFabUVOQmsxc3Mvc2t6?=
 =?utf-8?B?MUxnV0RzNGVBY2l1enNxNGZvaHJMZldWd1RXckNVeUhFb3B5aFNFL0dHR2Yv?=
 =?utf-8?B?QjkrSGoyL2xzUml6QVZmTklWY1FXdnpueHBjMmdGMzRmelZiNDlqQkE2TUl2?=
 =?utf-8?B?OCtMazVNRU5pS2JnY0VYZm5UVDlid29rMTdrbDQ4U2dtZ2RKY2ZkRlBpZ0FE?=
 =?utf-8?B?azR4Q0NDN0VwYnp2VXpyaGpMWVpMcndhRFZjcTlEKzlKaC91MGZ1bysvVnJt?=
 =?utf-8?Q?qHTN92AWwGxelc3gCWWjrENlbosiIEPOARxsQkz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9745ef0e-8e92-4f7d-507c-08dc8f8eee39
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 12:05:22.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660


On 2024/6/18 03:22, Jonathan Cameron wrote:
> On Mon, 17 Jun 2024 19:34:30 +0800
> kernel test robot <lkp@intel.com> wrote:
>
>> Hi Yasin,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on jic23-iio/togreg]
>> [also build test WARNING on robh/for-next linus/master v6.10-rc4 next-20240613]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/dt-bindings-iio-proximity-Add-hx9023s-binding/20240616-154122
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
>> patch link:    https://lore.kernel.org/r/SN7PR12MB8101D4BC788B5954608D677DA4CC2%40SN7PR12MB8101.namprd12.prod.outlook.com
>> patch subject: [PATCH v5 3/3] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
>> config: arm64-randconfig-r132-20240617 (https://download.01.org/0day-ci/archive/20240617/202406171946.qe83Tde0-lkp@intel.com/config)
>> compiler: aarch64-linux-gcc (GCC) 13.2.0
>> reproduce: (https://download.01.org/0day-ci/archive/20240617/202406171946.qe83Tde0-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202406171946.qe83Tde0-lkp@intel.com/
>>
>> sparse warnings: (new ones prefixed by >>)
>>>> drivers/iio/proximity/hx9023s.c:955:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 @@     got int diff @@
>>     drivers/iio/proximity/hx9023s.c:955:44: sparse:     expected restricted __be16
>>     drivers/iio/proximity/hx9023s.c:955:44: sparse:     got int diff
>>
>> vim +955 drivers/iio/proximity/hx9023s.c
>>
>>     931	
>>     932	static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
>>     933	{
>>     934		struct iio_poll_func *pf = private;
>>     935		struct iio_dev *indio_dev = pf->indio_dev;
>>     936		struct hx9023s_data *data = iio_priv(indio_dev);
>>     937		struct device *dev = regmap_get_device(data->regmap);
>>     938		int ret;
>>     939		unsigned int bit, i = 0;
>>     940	
>>     941		guard(mutex)(&data->mutex);
>>     942		ret = hx9023s_sample(data);
>>     943		if (ret) {
>>     944			dev_warn(dev, "sampling failed\n");
>>     945			goto out;
>>     946		}
>>     947	
>>     948		ret = hx9023s_get_prox_state(data);
>>     949		if (ret) {
>>     950			dev_warn(dev, "get prox failed\n");
>>     951			goto out;
>>     952		}
>>     953	
>>     954		for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
>>   > 955			data->buffer.channels[i++] = data->ch_data[indio_dev->channels[bit].channel].diff;
>>     956	
> This looks very odd.  Diff is an int filled with get_unaligned_le16()
> which you then write to a __be16 here.
>
> It should remain little endian, if that is appropriate, throughout.
>
> Also, very long line. Use a local variable for
> indio_dev->channels[bit].channel.
Hi Jonathan,

I reviewed the code and saw that data->buffer.channels[i] needs to be 
filled with the MSB and LSB of the diff data register. I can read the 
two bytes of diff data using regmap_bulk_read and fill 
data->buffer.channels[i]. However, the diff data register in this chip 
is multiplexed with the low pass data register. Thus, in some cases, 
diff data can't be directly read and must be calculated as the 
difference between low pass data and baseline data. Therefore, I can't 
directly store the register value in data->buffer.channels[i]. I plan to 
make the following changes to the code. Do you think this is feasible?

@@ -141,7 +141,7 @@ struct hx9023s_data {
         bool trigger_enabled;

         struct {
-               __be16 channels[HX9023S_CH_NUM];
+               __le16 channels[HX9023S_CH_NUM];
                 s64 ts __aligned(8);
         } buffer;

@@ -936,7 +936,7 @@ static irqreturn_t hx9023s_trigger_handler(int irq, 
void *private)
         struct hx9023s_data *data = iio_priv(indio_dev);
         struct device *dev = regmap_get_device(data->regmap);
         int ret;
-       unsigned int bit, i = 0;
+       unsigned int bit, index, i = 0;

         guard(mutex)(&data->mutex);
         ret = hx9023s_sample(data);
@@ -951,8 +951,10 @@ static irqreturn_t hx9023s_trigger_handler(int irq, 
void *private)
                 goto out;
         }

-       for_each_set_bit(bit, indio_dev->active_scan_mask, 
indio_dev->masklength)
-               data->buffer.channels[i++] = 
data->ch_data[indio_dev->channels[bit].channel].diff;
+       for_each_set_bit(bit, indio_dev->active_scan_mask, 
indio_dev->masklength) {
+               index = indio_dev->channels[bit].channel;
+               data->buffer.channels[i++] = 
cpu_to_le16(data->ch_data[index].diff);
+       }

         iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, 
pf->timestamp);

Best regards,
Yasin Lee
>>     957		iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
>>     958	
>>     959	out:
>>     960		iio_trigger_notify_done(indio_dev->trig);
>>     961	
>>     962		return IRQ_HANDLED;
>>     963	}
>>     964	
>>

