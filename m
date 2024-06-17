Return-Path: <linux-iio+bounces-6397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040CE90B420
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 17:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181D21C2217D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 15:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115016CD38;
	Mon, 17 Jun 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DXYmHQlb"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2084.outbound.protection.outlook.com [40.92.18.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABC16A949;
	Mon, 17 Jun 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635891; cv=fail; b=F6dN8TuPcL4PNV1Ihk2BrydkLfA+VIlMjHx35RXIrcHWPvefx/wRQSttOZF7BVpLugckRuSbD6GBkuChH1kMNFSzOGOGHm2z5kGnpInllHOuKjuqASJHPOp3fdW4w3IKDc35tOShWRWbGILyJzhnQm68n1vIJ9wVJvbqqkJHF9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635891; c=relaxed/simple;
	bh=zwi23Ia2InTWcLuu9y1rJNXtK/Fv9VEyhLu74Cxl8CU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VvJ+clNlqJTTuSusxQohlhloGMJnuDU+xyTB8NDo22Y2I8FydCJM7xnw1g2c0TWI1biNRAnCVn4fMUmJ09jAxrPS7yIUPiS/rvbCIbLstBCe9ZmFtf86/uRvT/gvWenp5LeBWlGrTmtq2Dl22SuBR8Cpz5JoQR5jGZbjNj6MTHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DXYmHQlb; arc=fail smtp.client-ip=40.92.18.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge3z4nKtQxCxJr4RqOsHIcKi2r7T1t7UhMiQ5C5z7n5nT8NRPWWzFiu/TgYHsGeh0/QdWII0skJRW6030OHWIfdcYCIhEFidR7uM1V9Q4rutt1zxcQM9lVrr6YbhjNe9dc2n9n3Ro96Ox7jn/FysNjyN7I3MBTHPQMcble9P2iQE1/aEVkNZDM2c/M2xdx4+k5YLQ21v6t8Qy0Fz1931wA9pj29ULFZ+skQDYU6CDBr6tgDi1OQrG52gxTCtRsMgu9GtJaAgzqEb8iTWp7c1SrDOf3zEiJeEdyj2SN01CWXA9ucZbPs2BFVpsCtlSPgOMXMiRKNtLuJRlk9crvRViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqtTvcu1qIuSRcUuBZEeacU4mPUNp32BtzmIVNsR3qI=;
 b=mYg+IIXqSfu9zzTTPhVLG2z5GxJvNXzXWNEfbD9Wv+EK7j6O/xmRi5yNwKm/fU6SqcLdpC54nihHrR4raWCQV9NOoH//semILPetpXs/H5ZZ3S5JBsh9Ue6ngKgJ5PvCrmvE3c55hx715SSlpjTeVsXToTxuV9p+t6HtTeS0Sf1tZf6dbSrOAUTMkBljrt9RgcQ4MVx6yPxp/77TVAe3jUiS57BpdHOuvURTMEEjp55F2iuIqQx2vGmHgV/Omgp9D5yRWTlBSSDX4KWBqkAolhCAAShf+Bj5cOf0ViVF24sc2rc4meRIVQlF8ZdZ1HdKSh9Ff2U4kZwlgwCOjGhpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqtTvcu1qIuSRcUuBZEeacU4mPUNp32BtzmIVNsR3qI=;
 b=DXYmHQlbPH7sI3UivKAqajRi/N5nZh/ZnaHAMj7q4U5+OV/KaCO8D/n3dj8JBVqPVZ3mqfvv5hbkvmvR70MX6UhGrLDQFsb/6ZOPuzHOMLsvD/AQ4diPPF7NE2I17EGKZphdaOFt8eeYwR3TIO9RI72xoEimH3lTOmfRK6qtE2roc+gNoESlI6cs0JkLbfRqNVYHDJqVf5EdnN0omyLWtk3+qgsdVUrf6kSs5W4AWfrK7dPrtabuyyjJdurykF/JUKE1aowjTtr/4VqBJKHhASnWKuCsTOZLkogQeVK9jOZxRrVbISbpNDT7/5nIoXDbkWdGO84Xz0z4EhWRIxusig==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Mon, 17 Jun
 2024 14:51:27 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:51:27 +0000
Message-ID:
 <SN7PR12MB8101DCB6B19647BE3AB86DDBA4CD2@SN7PR12MB8101.namprd12.prod.outlook.com>
Date: Mon, 17 Jun 2024 22:51:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings:iio:proximity: Add hx9023s binding
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
References: <20240616-add-tyhx-hx9023s-sensor-driver-v5-0-ebaf280bbf0e@outlook.com>
 <SN7PR12MB810142C58543160AB45D07B3A4CC2@SN7PR12MB8101.namprd12.prod.outlook.com>
 <171852720871.881703.5121305765787069941.robh@kernel.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@outlook.com>
In-Reply-To: <171852720871.881703.5121305765787069941.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [fpF/t8DshmkMtdX7p6ANHUZfNF21pGc+PXorSb84rRkALUtSkbr2ewlk4MXWKiFo]
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <806289f5-b377-4d14-a292-a174fc1284f4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cd5b03-2198-4dab-d1bf-08dc8edcf71b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|1602099009|4302099010|440099025;
X-Microsoft-Antispam-Message-Info:
	IaU43SCv7G5OkQRWZOiEdQ/Hfe0muj8zmku0mclyG4+msqSX+xvoAN+lir1FEp68oF0Jzl3lYI54u54zhMSNQaYLvUcMwJeuozsj3GARRa/8rakwsoh6L2TwIYptmKkGx0SVPjosciJM+4pDSAsIs+h+GYrdW8xnCsnJ3adFxH+o1avIcW2zebdUI1fk8rFIQF0gP3trYtngsoGOELVwC43t2oYS0K8G0Og4No1od7JboFaQFnj5J9QoSzOGZTCn75ax+d6O7vFw796zrb5/Ojha+WE5WDwDeu5eaHQUr+MDeuNmbJkOT6bHCXHJTc5a80alIVMnaAe6Deci4Stfc3LhNQTepUcvQwWVlzlnT51LT60whw5CiwCK92Xvzwejto8uA6ncxJtR3TqbjO1k/FUXXE1CGx2che5rVosvUd92C4bZgCCYUbN8oKObCuDKYcy+0BIqYyfUhTtNTaiD71OIRPikn1YI4kZlfAUuIJg1qHvT0s4mub/fihWQFfSna0cvZ434jMoiNMc08IzFR/5ZuoYaFHK//f7iYgdG+8mQmR0Kxn5DN/tTV9IDAXMC0g69xJwdsrvpEUCY4zgat7wG1Hb/sSVZAehw7MBH0dxHl0sOZr331ZhdYj8AWGcXAnXPX/xssDB/RFrzKyKHyy2hFxoWEH+bFDybXANlqugsaA4/jODpkfFAnBJF/edMJvrEl8bxA+lH7nN5Lq0LAA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0MvN2dxRjJqdll2V1RMVm51d01jMUFkSHNDOCs3Nm53WEpZVld4S2E5NmJk?=
 =?utf-8?B?WktEdDUzSWNrU3BCV0lTRFg2MXoza2VkU0hlSVZTN0srUmVZNG5NYlRqU3Zp?=
 =?utf-8?B?YWRVZmljcExvUjFQOGZzMmFiTzhFT3F0bnRQUHp0YVFFOElid3FpQiswUWND?=
 =?utf-8?B?OFh5NS9nNmJiaW0xSzFHQWhnM2hjNVlSb2ZOTnJxM1ZDajRYakpaeGQyZUx3?=
 =?utf-8?B?ZVBSMlprL1Q0b1NmUEVmSlM1cVp3cjVqc0U1dTEwQzkxZGV0Z25BTjg0d0Q5?=
 =?utf-8?B?RUt1VmxONDJtcTdFejR2QjNLVVZWUmpSem5vTkw0UFNYYlpyM1VTbjB1dm5n?=
 =?utf-8?B?QjUwSXRJT3pjZmEweXc3MElQak5oaEFwTHFTMXVuTXFMUXhhWlhCWWh0NWN5?=
 =?utf-8?B?Mis5Q25WOVRoK2s4RHYzVDh4TzJMM2tVTFl4N0c4VzNldlZwSHpZak9lNnk2?=
 =?utf-8?B?cUxnRXV3bFpyVXJvWTZwWk9qc00wVFlHcktha0I2Tk9aSXlGaDNUNVBkTmY0?=
 =?utf-8?B?K0lHWUNiQTNDeGN0cXZmR2VVUkZEb2tja3BNK0o0M2NVc3FDOWxwcVBZNEZ0?=
 =?utf-8?B?cXpIa0Q3bGRHWEIwVWltVVM4YVdhbUR2OFUvUVhrbDI3S3BWSmFLU1VlbkdL?=
 =?utf-8?B?RnErbGVJRlVHMytrV0pmU3RRZFJKbzBHSTZDWUtURnJoT1EvaWwwbFRFbVpM?=
 =?utf-8?B?cGJWRExhdXN6UlJRRk82NXF6R0RJSlYzZzVNVTBEK1BsVUEyR3kzWUtGeHJD?=
 =?utf-8?B?YlV6OXJPeE1iSEs0UjkrNWV0cWRFTEhPT1N6clBYbjR4TnpXK2lHRk1GVFMv?=
 =?utf-8?B?WUJUVmtwY2tYWG1hdE5HRnhhVVo4aTJDYVBwQU5rbENlanVzNjU0MzJvN3pH?=
 =?utf-8?B?d1NpWXJCV1hRTUFFVk5Na1RyOWwzTnRKRUc2MEV2dHlLWnhHUGtzVnM2c1ZV?=
 =?utf-8?B?cE9kQUpMU3JqV1RRQjNtblcrUmJkQnpkQytZY1V1RkRSYS9oNFRZOU13YXpj?=
 =?utf-8?B?KzlBRUZQN1kwdW5PcFZLWkw4c29aSHRpNTY1Ym5xMXdnakFpLzJKaVZnWHZH?=
 =?utf-8?B?NDV4Z2NqQ1dmczY1cnJzRVZidnJKekJ2elJYS25Pa1lIYmFhUUZkNHMvTnBv?=
 =?utf-8?B?WWZNbGlKUFNLckhkTVFtVVJtUEJZYjN0c1RxWjJSc3Zvc3RCaHFDa0FESWUz?=
 =?utf-8?B?SEFSRkFNbVVwZUFEOVN3bWFjS3ViTE03UWQreXE2RXozSHZrQjN0WjNJVUMr?=
 =?utf-8?B?Q1Y2RlA5c0FoWlY5T3FMQlpVSDMveXhrT2wxNnI3cWNYZWMwWHdlTnJhVEZp?=
 =?utf-8?B?emRqeU1DNVBIeWgzWGgxaHR4YlBEMEpEVVVHdjVMMk1IY1lMZGJWc2hzK1JE?=
 =?utf-8?B?TUpLZjNRZkFDRUxvbFFSbXRockdOYWtaQVNQbUZuOENEWHI2dUsraGdybUFv?=
 =?utf-8?B?MzdYU1c4b0tSMXFnakFXZ25KalBCSmpTYUlETnROSTVlQTNlUTQyaERZbVgy?=
 =?utf-8?B?TDM1bm04b29hWXg5eGpGT2RKK28vYVdWK3VxUW5QSnRvUnkzVGVGTVg4TXNU?=
 =?utf-8?B?Unc4VEtPYTVtL0o1VFA1VGp5OHc1RlZtdXhsbC91ODRLeFZvaVNLTjNrWDRU?=
 =?utf-8?B?VFo2T2pYLy9JdFhkYXNOQUluTElFVGFPRHFBNGRsY0pKMDA4cWd6TUxQNkhI?=
 =?utf-8?B?eVJaOHBoN2svcnpJdGhwVEtkUkwwUHBMMXFKMlpLWGFyMFVkZkl0ZFEyTG9n?=
 =?utf-8?Q?v8Cwoo9hFNyidi7MEYsSX119b5H1vZQXhi0hJMB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cd5b03-2198-4dab-d1bf-08dc8edcf71b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:51:27.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836


On 2024/6/16 16:40, Rob Herring (Arm) wrote:
> On Sun, 16 Jun 2024 15:36:48 +0800, Yasin Lee wrote:
>> From: Yasin Lee <yasin.lee.x@gmail.com>
>>
>> A capacitive proximity sensor
>>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>> ---
>>   .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 98 ++++++++++++++++++++++
>>   1 file changed, 98 insertions(+)
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml:
> Error in referenced schema matching $id: http://devicetree.org/schemas/iio/proximity/adc.yaml
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:35.15-25: Warning (reg_format): /example-0/i2c/proximity@2a/channel@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:39.15-25: Warning (reg_format): /example-0/i2c/proximity@2a/channel@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:43.15-25: Warning (reg_format): /example-0/i2c/proximity@2a/channel@2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:47.15-25: Warning (reg_format): /example-0/i2c/proximity@2a/channel@3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:51.15-25: Warning (reg_format): /example-0/i2c/proximity@2a/channel@4:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:34.23-37.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@0: Relying on default #address-cells value
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:34.23-37.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@0: Relying on default #size-cells value
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:38.23-41.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@1: Relying on default #address-cells value
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:38.23-41.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@1: Relying on default #size-cells value
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:42.23-45.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@2: Relying on default #address-cells value
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:42.23-45.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@2: Relying on default #size-cells value
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:46.23-49.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@3: Relying on default #address-cells value
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:46.23-49.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@3: Relying on default #size-cells value
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:50.23-53.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@4: Relying on default #address-cells value
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dts:50.23-53.15: Warning (avoid_default_addr_size): /example-0/i2c/proximity@2a/channel@4: Relying on default #size-cells value
> Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@0: False schema does not allow {'reg': [[0]], 'input-channel': [[0]]}
> 	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@1: False schema does not allow {'reg': [[1]], 'input-channel': [[1]]}
> 	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@2: False schema does not allow {'reg': [[2]], 'input-channel': [[2]]}
> 	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@3: False schema does not allow {'reg': [[3]], 'diff-channels': [[1, 0]]}
> 	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.example.dtb: proximity@2a: channel@4: False schema does not allow {'reg': [[4]], 'diff-channels': [[2, 0]]}
> 	from schema $id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/SN7PR12MB810142C58543160AB45D07B3A4CC2@SN7PR12MB8101.namprd12.prod.outlook.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>
Thank you for your reply. I have corrected the errors according to your 
suggestions and will include the updates in version 6.

Yasin


