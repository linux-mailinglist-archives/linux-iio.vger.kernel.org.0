Return-Path: <linux-iio+bounces-6531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0309890DB38
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 20:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1842DB225E4
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 18:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF50014EC4C;
	Tue, 18 Jun 2024 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l0SINZr1"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2108.outbound.protection.outlook.com [40.92.21.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDCC568A;
	Tue, 18 Jun 2024 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733769; cv=fail; b=fXp+rDF0cnhHEohx5I4qBVffPNjOp+wEho6IQsfvgCVwUMEoatGTBaqpb2sLE/k9tw18F42DFq2ocRqyyRWcn1x8hwhn8BxWUWt1fn3I4pDrhFzN/FEYi60HxCUGefLwVZeg1v11R1xRwUcyY3uhVSbwh4p4xkZWh6EFznMTh4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733769; c=relaxed/simple;
	bh=k14zx1YCRgXlQL9X9o9MDGC3VMhY130NRc9HexjZYMY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j8e+9BTu07dgV5Rh2R91oGTgrRCSBH52R4j4mXHa7izODG4M1Yxbb6w88XvNO4zzUmfDtyEwRQFjEBLAt/PYD+sUGj32BtXRFcBThGbBVg1HE6C1AmQwBxj0K0teq6Klem6lSyFwtKRNNhT6zoViZXdtOyEKwOTUzFNbrSxNFnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l0SINZr1; arc=fail smtp.client-ip=40.92.21.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wx4bZijUtpJAhTDIdDNY/KS8yKgas37vZSzTWM9huz/UBTsUt5IyavfeJXbFsy6ygaahM9JiTaezN9NG6OCnVK7g+UMUqAXfYZUUdHTSAmQJZV6Oujn3yUb8a6U6cVp7BndesVA8YqpA0DtFPrkVKR1knl4KJ/Af+O5c5qcFSz7Zx9YLXLAvHleDvubqiiCWjFvoVFHedacO8F0QXA+pLzixceKlVBoCljuQ296RFatnuT4el6dJwlD6R0EbrgpZjrZ/cxfaEVOeGuPM0EgTuiWPU3Ww1tlbdSkQwFlG5y8ipWkF7aKvF6iyJ9NmK8vIndvQrlSDAcDmhOU4AwdqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuZh5V4o4qdl2tAWlgkAfV/axYBP1Ic/4ytVCTyNvyk=;
 b=bm4oegE+TMV6cpPT03o42UPjApgX4uAzoMc38khi51qteyJjOMcsfZ6rP9zY83/JjAS5nb/YDsa0beLJGD8LSQeyZVHciEBcJFLyUyuve5Dw1AcsrjWurOxfhfckwOThzCXh7oUgg9uPNgs805QIF16BZli+D/C0QgE9bc94P3hsc5KZCJUcd8TTznGVt1qx5F5VNA3qm0yLszQssGedq/MGffH6dkB6keoWKFU2vSnuCTy0CPUkio4p4BUVQMeYLASGXozFSYjfXwqGbUl+0zxlPAG5EvCK8b/vaDnAR9yymPWqD1gGwqQxDe4RTHxhTvOLNOwEw1SFKf9t8YoZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuZh5V4o4qdl2tAWlgkAfV/axYBP1Ic/4ytVCTyNvyk=;
 b=l0SINZr1IdOWf8WrkDMbVLlyRO7xGTsRH4OfhNdSKaxtAcQYmEILdTdA1cpzZfEWMl+xfay7GY2k8K99qMY2rTgNGl7W0C5y33T5dX4U8cnePUGxYAH90+1wn1Khi8jjHXdy6C9CPr3u2t2MtVwM0kHrfeM1MX4duMMK/zMSsINDrsZ619EpkPlZlXryHV+8jT6azmXqGCQY4KBPkAAoB3u/jQAIlado12VUnA4+Z+z+ss62AIeT9CGN8HQPydvmE5kdAJS8jj8ilrOXdlk4gyDPxjxafEGovQVUPqxMnlw8fqNtB3oBJiEuWGFKwpFKjzhEswxpreQLmZzkNeIMTg==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 18:02:42 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 18:02:42 +0000
Message-ID:
 <SN7PR12MB8101EC586E5B365ECFEA3159A4CE2@SN7PR12MB8101.namprd12.prod.outlook.com>
Date: Wed, 19 Jun 2024 02:02:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy.shevchenko@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
References: <20240607114138.390272-1-yasin.lee.x@outlook.com>
 <SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
 <20240608181331.46cd4ae7@jic23-huawei>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@outlook.com>
In-Reply-To: <20240608181331.46cd4ae7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [4lSm1GlTTOMMegsL/1PhOkMvpx9CvaSaLyau08v2eqe00p1VQfvEimqmhVyZf/eU]
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <9800dfba-9346-458d-bf5c-75001fc87dad@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 388cf68b-8a88-4687-1199-08dc8fc0d962
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|3412199022|440099025;
X-Microsoft-Antispam-Message-Info:
	+xYDmwOoexni7rzgPRBYIi0QVNMvZuF2qEN/BfrspPeHBvFJYFyJ0q4GhnmmEDAQW7R4+XzVQD12yCCVv+n6k8fPA5mUW9ylWu1iipcJ/9ODHUhAWmpcql5Z7d3yryyKIVGDsB1mC2FG2+IxaWi+CwGdnibHCmozNN/aApUqVIc9C96eicfEtP5pXDjULfZGwub9dgkOug6nCCLXfcuI2fQv4eWNkGWcLdscz4iLas+R3q2RvqoHjgFQWR13hzen77ifOG4ktS7Qkmv4zJ+ylzC6yV+MaIjQVvZjhiavlmq6TgsBxV8ETeh5DjXwDPi4jkE8wYDevFotvDdY7h/vEpjk1j/zmaB4HxEtva3WvslMnk8310zpZYb+ODs+av79bb3ldK2MXqss1EcBrg5KB087WkemnpvLCyYFbLE2fyIuMc2ld+dA6oRX8r1apCXMA+yFikgL9sz0ziGE+roMdAcZE+Sp5zWjiycgWKKOuHf8G/ETf7I7MCsdDQIAX+D3+kE0LpxtMBnPR8wmNv3KGOjEiFHc/2GjpHv6vb3tw/dbFOlJ13BNNAYeNzd73aqI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzVoNVZtY2l4YmNQV0tuSEpFZ1Y5Y0dpYzY0ckJIYTY4WUcwUFNBY2RtVFF5?=
 =?utf-8?B?Z3BVUTZBWkM3NTlsSWlYemtsUmZnU2VQbnpZcnhxTGNYZkxvMUJjZFFJV1VS?=
 =?utf-8?B?c1dNWUZBRkhXa1YxSFRvNmVjVTNFdHQ4THBlM1JucElMQVU3Y1JONG1iYkhU?=
 =?utf-8?B?NUt6ZmVyU3lNL1RNWGFmUmZVUzNiVlhpZmRjMWVpUEQzS3pOalI0ZUpaVG5l?=
 =?utf-8?B?NTZ2WHJ5cTBaMnBlSlJ0ZTgySXFsN3lqb1B1TFhibVlKblpEcFdTcGxOWHRY?=
 =?utf-8?B?Nk9QbTRxRUduZHp1MXMvSDhnVGVJV3JiOWZVN2tUNXdiU2ZTdHozY1hybVVQ?=
 =?utf-8?B?Tlk5bWFDNWlNSm1DMUhKNitUTDF2NEtHdXMraUROaTVtQWdoM3lDR1FRREhQ?=
 =?utf-8?B?SGtkMFUxTHUrTlhGcEV2YVBBVWdtRlBNTUFKWXNGcVFlZkJHSnpvSGJNdUFy?=
 =?utf-8?B?eDQxMEp3SERxaGtvOExZN3A0N0lrb2V6eHlsY2svVTFpVHBWWStJYUVrcCtX?=
 =?utf-8?B?QnZudGdyK29ITmluenp4RnN6MGtzOGVXdGYrdExnTWtBTWxlbzEvSWxyMGI2?=
 =?utf-8?B?cjhPdUExTFVJSHRPS1B1VHVwK1k4dVpaRDVhYmxWMktEUFRuWW1CR3NucFov?=
 =?utf-8?B?MXlSWXoySHN4L0lQYmJCYkFOMVZCY3NSazJZSWNIVUhTL0VtaU43Tnl3TWdS?=
 =?utf-8?B?SmxRb0xHUWdrVkJ4V0VzdzdQMUxTQWNTU05WV2JTbVdzRGpyMjFRNjFBZzM4?=
 =?utf-8?B?WFlmaDArODNWc2p2bS9IcVdrVWtZVGlaZnV1LzVmYUZyV3R0NWppdzVjZ1lr?=
 =?utf-8?B?ajdKTG9KaFN0d3cwT2wvQ05VRWR3czBjSXhLcmxGNm5mT294VnhJQ3pXSXZQ?=
 =?utf-8?B?b0hBdmE1dCtkcmRwck1sOS8wa25QZWxBSlVMcTZRcENIcVh1b2NxNmRKWVNE?=
 =?utf-8?B?RUc3cVdNanRjSEIxM1FFMVhUd1c3RVJDbldlbmNyNVRDVEkyLzRZbXh0TU9x?=
 =?utf-8?B?akk1Q0lIM2h1N1g0K3lSQTRGOUtWRlR6U003eVMya29sRE50ZjB4YVdLd3U2?=
 =?utf-8?B?MEJWcTg5S2U1TStwT0V1RkFRUFJNS2dBVXQ1YU1UNVlycE9ybXhGekxYM1FR?=
 =?utf-8?B?cmtxemZrZEp1VEMyQ1lzVGZkeW5PaHhSM2ZVaXA0TFFSbi90QXRGUnJRKzVi?=
 =?utf-8?B?THZWL2hQWjg2NVdqZ1JUdzRnV3lkSXlWNXpIU0RzenNMVXBiSEpKL0FRZ3dT?=
 =?utf-8?B?VUVGRExMbkk5UzNmQ1JuKytPZzNlVytZUkZ6MU0rcWRDbGpJWHFaeWE1emIv?=
 =?utf-8?B?VDZ3MTVKSGpYcHpuMVpodkVQQXQ3d0QrOHZOU1dOWENWWkxJNGUwSko2RkJ4?=
 =?utf-8?B?VGpQcUsvYUI1UlZ6OUZaZC9kQmFJNVIwZENOQ3VlNGF2THBqVDU1LzgyMDJk?=
 =?utf-8?B?c2EzdG1rVEhoR3VBRVdBWTFGWFA2Y054SXVYS2xCWFJoNUpVM2VHNXM3Wk5C?=
 =?utf-8?B?dEVqNkx3c3EyK01VZlJPVHlHUlZ3U1ZMRlZWUWd2NHlyWUR1Ymp2TTVzUEFo?=
 =?utf-8?B?VGVNY0k0Z1dNZ3BvZUg3Q0hkQktwV0JReGtSUk5sdmpPczdoWk80SFJrR1Nk?=
 =?utf-8?B?K2p6dEUwVTkvclF2cTBYMm5JZzl4elo1dWFhd2N2WUJYN3BYRXNQWFcrbTB6?=
 =?utf-8?B?RFJHeVZtWlZjZmVOOEFmWGYzbDV1c3NNVFFzb3B0eTN2djVHbkFidHB6STVP?=
 =?utf-8?Q?jCrinh1AcGdn8c0M8RMHERHUT5pjhKxBki34Xf7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388cf68b-8a88-4687-1199-08dc8fc0d962
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 18:02:42.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491


on 2024/6/9 01:13, Jonathan Cameron wrote:
> On Fri,  7 Jun 2024 19:41:38 +0800
> Yasin Lee <yasin.lee.x@outlook.com> wrote:
>
>> From: Yasin Lee <yasin.lee.x@gmail.com>
>>
>> A SAR sensor from NanjingTianyihexin Electronics Ltd.
>>
>> The device has the following entry points:
>>
>> Usual frequency:
>> - sampling_frequency
>>
>> Instant reading of current values for different sensors:
>> - in_proximity0_raw
>> - in_proximity1_raw
>> - in_proximity2_raw
>> - in_proximity3_raw
>> - in_proximity4_raw
>> and associated events in events/
>>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> As Andy already did a detailed review, I only took a fairly quick look.
> A few comments inline
>
> Jonathan
>
Hi Jonathan,

Thanks for your reply, the  details inline below.

Yasin Lee


>> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
>> new file mode 100644
>> index 000000000000..b4a583105e03
>> --- /dev/null
>> +++ b/drivers/iio/proximity/hx9023s.c
>> @@ -0,0 +1,1162 @@
>> +
>> +static int hx9023s_data_lock(struct hx9023s_data *data, bool locked)
>> +{
>> +	int ret;
>> +
>> +	if (locked)
>> +		ret = regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
>> +					HX9023S_DATA_LOCK_MASK, HX9023S_DATA_LOCK_MASK);
>> +	else
>> +		ret = regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1, GENMASK(4, 3), 0);
> Odd to write one bit and clear 2.  If really the case, add some documentation
> comments.
>

This is indeed an error, modified to only set HX9023S_DATA_LOCK_MASK.

>> +
>> +	return ret;
>> +}
>> +
>> +static int hx9023s_ch_cfg(struct hx9023s_data *data)
>> +{
>> +	int ret;
>> +	int i;
>> +	u16 reg;
>> +	u8 reg_list[HX9023S_CH_NUM * 2];
>> +	u8 ch_pos[HX9023S_CH_NUM];
>> +	u8 ch_neg[HX9023S_CH_NUM];
>> +
>> +	data->ch_data[0].cs_position = 0;
>> +	data->ch_data[1].cs_position = 2;
>> +	data->ch_data[2].cs_position = 4;
>> +	data->ch_data[3].cs_position = 6;
>> +	data->ch_data[4].cs_position = 8;
>> +
>> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +		if (data->ch_data[i].channel_positive == 255)
>> +			ch_pos[i] = 16;
>> +		else
>> +			ch_pos[i] = data->ch_data[data->ch_data[i].channel_positive].cs_position;
>> +		if (data->ch_data[i].channel_negative == 255)
>> +			ch_neg[i] = 16;
>> +		else
>> +			ch_neg[i] = data->ch_data[data->ch_data[i].channel_negative].cs_position;
>> +	}
>> +
>> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
>> +		reg = (u16)((0x03 << ch_pos[i]) | (0x02 << ch_neg[i]));
>> +		reg_list[i * 2] = (u8)(reg);
>> +		reg_list[i * 2 + 1] = (u8)(reg >> 8);
> Looks like an odd form of endian manipulation. Try to set reg_list directly or use
> an appropriate put_unaligned_*
>

Modified to put_unaligned_le16.


>> +	}
>> +
>> +	ret = regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
>> +
>> +	return ret;
>> +}
>>
>> +
>> +static int hx9023s_ch_en(struct hx9023s_data *data, u8 ch_id, bool en)
>> +{
>> +	int ret;
>> +	unsigned int buf;
>> +
>> +	ret = regmap_read(data->regmap, HX9023S_CH_NUM_CFG, &buf);
>> +	if (ret)
>> +		return ret;
>> +
>> +	data->ch_en_stat = buf;
>> +
>> +	if (en) {
>> +		if (data->ch_en_stat == 0)
>> +			data->prox_state_reg = 0;
>> +		set_bit(ch_id, &data->ch_en_stat);
>> +		ret = regmap_bulk_write(data->regmap, HX9023S_CH_NUM_CFG, &data->ch_en_stat, 1);
>> +		if (ret)
>> +			return ret;
>> +		data->ch_data[ch_id].enable = true;
>> +	} else {
>> +		clear_bit(ch_id, &data->ch_en_stat);
>> +		ret = regmap_bulk_write(data->regmap, HX9023S_CH_NUM_CFG, &data->ch_en_stat, 1);
> regmap_write() it's length 1 so not bulk!
> Make sure to fix all other cases of this.
>

OK, I will fix all such issues.


> ...
>
>
>> +
>> +static int hx9023s_get_proximity(struct hx9023s_data *data,
>> +				const struct iio_chan_spec *chan,
>> +				int *val)
>> +{
>> +	hx9023s_sample(data);
> handle errors and return them to userspace.
>

Fixed


>> +	hx9023s_get_prox_state(data);
> handle errors etc.
>

Fixed


>> +	*val = data->ch_data[chan->channel].diff;
>> +	return IIO_VAL_INT;
>> +}
>> +
>>
>> +
>> +static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int val2)
>> +{
>> +	int i;
>> +	int ret;
>> +	int period_ms;
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +
>> +	period_ms = div_u64(1000000000ULL, (val * 1000000ULL + val2));
>> +
>> +	for (i = 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
>> +		if (period_ms == hx9023s_samp_freq_table[i])
>> +			break;
>> +	}
>> +	if (i == ARRAY_SIZE(hx9023s_samp_freq_table)) {
>> +		dev_err(dev, "Period:%dms NOT found!\n", period_ms);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = regmap_bulk_write(data->regmap, HX9023S_PRF_CFG, &i, 1);
>> +
>> +	return ret;
> return regmap_bulk_write()


Fixed


>> +}
>
>> +static int hx9023s_set_trigger_state(struct iio_trigger *trig, bool state)
>> +{
>> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>> +	struct hx9023s_data *data = iio_priv(indio_dev);
>> +
>> +	guard(mutex)(&data->mutex);
>> +	if (state)
>> +		hx9023s_interrupt_enable(data);
>> +	else if (!data->chan_read)
>> +		hx9023s_interrupt_disable(data);
>> +	data->trigger_enabled = state;
> Ah. So you store this but you also need to use it in resume
> along with checking if events are enabled or not.
>

Add     if (data->trigger_enabled) in resume Function

>> +
>> +	return 0;
>> +}
>> +
>> +static const struct iio_trigger_ops hx9023s_trigger_ops = {
>> +	.set_trigger_state = hx9023s_set_trigger_state,
>> +};
>> +
>> +static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
>> +{
>> +	struct iio_poll_func *pf = private;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct hx9023s_data *data = iio_priv(indio_dev);
>> +	int bit;
>> +	int i;
>> +
>> +	guard(mutex)(&data->mutex);
>> +	hx9023s_sample(data);
>> +	hx9023s_get_prox_state(data);
> No error handling?  If these failed we don't want to provide bad data to
> userspace.  Normally we just skip on to iio_trigger_notify_done()
> with a warning print to indicate something went wrong.


OK, I added the following error handling logic here:

     ret = hx9023s_sample(data);
     if (ret) {
         dev_warn(dev, "sampling failed\n");
         goto out;
     }

     ret = hx9023s_get_prox_state(data);
     if (ret) {
         dev_warn(dev, "get prox failed\n");
         goto out;
     }

>> +
>> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
>> +		data->buffer.channels[i++] =
>> +			cpu_to_be16(data->ch_data[indio_dev->channels[bit].channel].diff);
> In IIO, for the buffered interface, we general prefer to leave data in the endian
> ordering we get from the bus and describe that to userspace.  The basic
> philosophy is that userspace has better knowledge on what it is doing with the data
> so we provide it the information to process it rather than doing the work in kernel.


Yes, I described the reason for using |cpu_to_*| here in another response.


>> +
>> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
>> +
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>>
>> +
>> +static const struct iio_buffer_setup_ops hx9023s_buffer_setup_ops = {
>> +	.preenable = hx9023s_buffer_preenable,
>> +	.postdisable = hx9023s_buffer_postdisable,
>> +};
>> +
>> +static int hx9023s_probe(struct i2c_client *client)
>> +{
>> +	int ret;
>> +	unsigned int id;
>> +	struct device *dev = &client->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct hx9023s_data *data;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
>> +	if (!indio_dev)
>> +		return dev_err_probe(dev, -ENOMEM, "device alloc failed\n");
>> +
>> +	data = iio_priv(indio_dev);
>> +	mutex_init(&data->mutex);
>> +
>> +	data->regmap = devm_regmap_init_i2c(client, &hx9023s_regmap_config);
>> +	if (IS_ERR(data->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap init failed\n");
>> +
>> +	ret = hx9023s_property_get(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "dts phase failed\n");
>> +
>> +	ret = devm_regulator_get_enable(dev, "vdd");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "regulator get failed\n");
>> +
>> +	fsleep(1000);
> If possible, add a specification reference for why that time.
> If not add a comment saying that it has been found to work by experimentation.
> That can be useful information if it turns out to be a bit short for someone else.


I confirmed with the IC design team to drop the delay.


>> +
>> +	ret = regmap_read(data->regmap, HX9023S_DEVICE_ID, &id);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "id check failed\n");
> Having read the ID, normally we'd compare it with expected and print a
> warning if it doesn't match, then carry on anyway (to allow for fallback compatibles
> being used for future devices that are backwards compatible for this one but
> have a different ID).
>

Added the id_check function to implement the above functionality.


>> +
>> +	indio_dev->channels = hx9023s_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(hx9023s_channels);
>> +	indio_dev->info = &hx9023s_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->name = "hx9023s";
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	ret = hx9023s_reg_init(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "device init failed\n");
>> +
>> +	ret = hx9023s_ch_cfg(data);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "channel config failed\n");
>> +
>> +	ret = regcache_sync(data->regmap);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "regcache sync failed\n");
>> +
>> +	if (client->irq) {
>> +		ret = devm_request_threaded_irq(dev, client->irq, hx9023s_irq_handler,
>> +						hx9023s_irq_thread_handler, IRQF_ONESHOT,
>> +						"hx9023s_event", indio_dev);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret, "irq request failed\n");
>> +
>> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
>> +						iio_device_id(indio_dev));
>> +		if (!data->trig)
>> +			return dev_err_probe(dev, -ENOMEM,
>> +					"iio trigger alloc failed\n");
>> +
>> +		data->trig->ops = &hx9023s_trigger_ops;
>> +		iio_trigger_set_drvdata(data->trig, indio_dev);
>> +
>> +		ret = devm_iio_trigger_register(dev, data->trig);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					"iio trigger register failed\n");
>> +	}
>> +
>> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollfunc_store_time,
>> +					hx9023s_trigger_handler, &hx9023s_buffer_setup_ops);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				"iio triggered buffer setup failed\n");
>> +
>> +	ret = devm_iio_device_register(dev, indio_dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "iio device register failed\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static int hx9023s_suspend(struct device *dev)
>> +{
>> +	struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));
>> +
>> +	hx9023s_interrupt_disable(data);
> You call these even if the trigger isn't enabled.  The disable is fine, but
> you then enable the interrupt on resume even if it wasn't previously enabled.
> This needs some state tracking so you restore to previous state.
>

>> +
>> +	return 0;
>> +}
>> +


Modified in resume

static int hx9023s_resume(struct device *dev)
{
     struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));

     if (data->trigger_enabled)
         hx9023s_interrupt_enable(data);

     return 0;
}



>> +static int hx9023s_resume(struct device *dev)
>> +{
>> +	struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));
>> +
>> +	hx9023s_interrupt_enable(data);
>> +
>> +	return 0;
>> +}
>> +
>> +static DEFINE_SIMPLE_DEV_PM_OPS(hx9023s_pm_ops, hx9023s_suspend, hx9023s_resume);
>> +
>> +static const struct acpi_device_id hx9023s_acpi_match[] = {
>> +	{ "TYHX9023" },
>> +	{}
> As Andy mentioned, drop this or add a comment on what device uses it.


Drop this


>> +};
>> +MODULE_DEVICE_TABLE(acpi, hx9023s_acpi_match);
>> +
>> +static const struct of_device_id hx9023s_of_match[] = {
>> +	{ .compatible = "tyhx,hx9023s" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, hx9023s_of_match);
>> +
>> +static const struct i2c_device_id hx9023s_id[] = {
>> +	{ "hx9023s" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, hx9023s_id);
>> +
>> +static struct i2c_driver hx9023s_driver = {
>> +	.driver = {
>> +		.name = "hx9023s",
>> +		.acpi_match_table = hx9023s_acpi_match,
>> +		.of_match_table = hx9023s_of_match,
>> +		.pm = &hx9023s_pm_ops,
>> +
>> +		/*
>> +		 * The I2C operations in hx9023s_reg_init() and hx9023s_ch_cfg()
>> +		 * are time-consuming. prefer async so we don't delay boot
> Prefer (capital P as new sentence)


Fixed


>
>> +		 * if we're builtin to the kernel.
>> +		 */
>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +	},
>> +	.probe = hx9023s_probe,
>> +	.id_table = hx9023s_id,
>> +};
>> +module_i2c_driver(hx9023s_driver);
>> +
>> +MODULE_AUTHOR("Yasin Lee <yasin.lee.x@gmail.com>");
>> +MODULE_DESCRIPTION("Driver for TYHX HX9023S SAR sensor");
>> +MODULE_LICENSE("GPL");

