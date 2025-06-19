Return-Path: <linux-iio+bounces-20780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD14AADFE97
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 09:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A04516A666
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B7824EA90;
	Thu, 19 Jun 2025 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pUBRPM1J"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB5158DAC;
	Thu, 19 Jun 2025 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750317775; cv=fail; b=SrFksR+X6CpyTkV14kkYURMGm2N2CAfX3CoONqN7xaprDCH/T1IdFJI6QIuo7tm6la13tRxAr1btfwFx30Xwc334phMW9nb0Bn2Gr2vMNLSFFcjU+Whx99ebcTHoP3rwmJaTJAbTXyJ9SKJtXRUOOiWtx+AJXrJWli4/72jduL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750317775; c=relaxed/simple;
	bh=NJvrzuXuwCyi79emXxLs5ClPRk5yLPLu1kRTsb8Q3jM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=enA80gu56re1IV2azQiDfJNAO6areT+3peFeS2VnJGHaTAnm5IddosNOFeKEIDpIH5Y7teh/+7cdlTda77+ojfyoG0FRufTbDx/HysPD6TTKEIfEltySIAuKY8l2YbhOL9VHsyPQtFLeKeP6Mj5K2fcp0r10ErpUis0iom5HRFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pUBRPM1J; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9H50tM1Uep2MYrAMwUkfpGroSFo1d7jXs7t9jtx0Y+MN+Fh3/20aLQpsENDduhbCV1+JjKNnjepOXAJ/c0g5VQm87Cxkhx1q901kjYEmOjOG9EaY7VwMVIdp6cUAYCQSsybIHktgRVLnVhWiSSzSdYOpA6WsF8MYBPBKC2lcoMBCA9t2tvYGVYHWAKIQEVkDHAWct5G/XqDbErBhJexyd/89LlZd5ILNE8uvkmCxZr8D5qsssYOHq6SP2zjXHcygXY8hFC5i4tF6CFkHAlWroSQCmtD+nwHbHXXmwpReNNyMo8mmXQMR8le+1RC/FDrEsw4N1xGI03XrFR3RH9uRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJvrzuXuwCyi79emXxLs5ClPRk5yLPLu1kRTsb8Q3jM=;
 b=d02IddC6y8QczwEGB1E/H8/JxXfBJ1mG1oRS/axVYhSMMy6p8S4Zhx1cjgcDvfGLvWZ6O9ngIi+2M3oCGxWRYHigHYlL2OXSXuipMdZFlyosaN7XxQjFaAn3ogYPNbaXeh4+sVqsFzBnJz/t8UKPiCvaEVKe73vwXch2TI6MUGccGWUAeLAqmEwVp2tnXxi93UcF5VPILOUMdUVt98NrauAeMNVvSGAlPxTFvEe3vdp3eLSYURgeIht8vmvyFplLl0UFJSBEszHmtjEDuEEt7KPWGBHT+oOhMgtNCvi81tL4t4sZfvz3KTIu4aP12OaK6jpYnK2Y0qFS7tLOxDw7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJvrzuXuwCyi79emXxLs5ClPRk5yLPLu1kRTsb8Q3jM=;
 b=pUBRPM1J1b0iac4jzeciCqpqqhd8Oet+Z97JlNekOddj14hO50H20/c1k3eytnFV4L9tkoL45YpmdrEuapW1uPeA/Y/iDnfaloD2+CMus5ZG+LR4pZ2V2544WPZZVDAUb9gzVNgWA7vPUh+9TRnRSdDI4ul8mSgxXpZIS9oxvgoCo1OGV8zUYghBEdzRbrASqlvcE4r8x9tlQflwE8vDhh9QDCVjEylFjtvCNbZ6+haTMIvD8Qa6ECeLJpO78XudoPoPH4dwveouf9+DtwIOwl5X6Dvf8KdGFuT1eLSFpdX0a/d20ocVaEbQKppFQlFDLjzGvqTcRuWHfqqak4XWzg==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by DS0PR11MB7407.namprd11.prod.outlook.com (2603:10b6:8:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 19 Jun
 2025 07:22:50 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%7]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 07:22:50 +0000
From: <Victor.Duicu@microchip.com>
To: <andy.shevchenko@gmail.com>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<jic23@kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <Marius.Cristea@microchip.com>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] iio: temperature: add support for MCP998X
Thread-Topic: [PATCH v3 2/2] iio: temperature: add support for MCP998X
Thread-Index: AQHb3GNu3PJF/o38e06N5yLd4yRAp7QBoXsAgAh7qYA=
Date: Thu, 19 Jun 2025 07:22:50 +0000
Message-ID: <f980b3c1a4fbd60f70dda9670648479a38313439.camel@microchip.com>
References: <20250613130207.8560-1-victor.duicu@microchip.com>
		 <20250613130207.8560-3-victor.duicu@microchip.com>
	 <CAHp75VdRisP+trez2Ysgrhan_zXMWsmawB3XeW+_ePsbNC4RzQ@mail.gmail.com>
In-Reply-To:
 <CAHp75VdRisP+trez2Ysgrhan_zXMWsmawB3XeW+_ePsbNC4RzQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|DS0PR11MB7407:EE_
x-ms-office365-filtering-correlation-id: d8bf6b19-c5cb-4d28-d440-08ddaf021943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzdLKzhaWkFPNjZBSEdaSmJGYmZzSGsxcTR1SXZ1SHR3RURhb2gyKzkyT0ZU?=
 =?utf-8?B?bVA3MHBwVEg1eUtFZk9GVUxUbmQyRGZTallqaTVpUVVYdWxhS3ord21BdDFn?=
 =?utf-8?B?enJlL1Q1WTArU3REQ3B2WGIxSitpL2xMYnpVTkZrV2lXTWw2ZlFHdzZVMFRE?=
 =?utf-8?B?SVBMNElvbkdpcmFuQnNzY3ZHMy9Jd2gxd0RpOHFCUmdYRmRqVFlHQk53ZkxN?=
 =?utf-8?B?QndxeUlkQjBWMG5pUVN3RTBUT04xS3ZmeEhRNmlzSy9TdmlPcmlTcHFJYTVC?=
 =?utf-8?B?ZitaM2RVSGhPaDJ2QWtqYmlPRm5BL3VqdHdRbXo4NkEyLzF0c0VjcCtLQlBQ?=
 =?utf-8?B?bmZWSWdSd2hmNlM2OUh0eEl3YStZakFTMzdDYWl6ZHovbHhBMHllWXBrbG1G?=
 =?utf-8?B?SG9vR0NhL2tzVkxEL0tTVE1FNTZYTCtxT1RhUXJ4aGVUdjd2WUlIK2M3b1dz?=
 =?utf-8?B?YWJSMzkxZk5MTkVMak12MXdOdXErMzZ2dmdRVkxaVWYwUit4enJlaU5yOVNZ?=
 =?utf-8?B?UGtlTUlpWWhENmJWQ0VCRENTQjl0aDM4YWt0ZkdqaVRVWURqelNOLzIyVXVv?=
 =?utf-8?B?bnJ6UXZLZGJ3eHNTaXpQdmJ1ZkI2U0dHSEYvM2Zud0ZGRjNSTzZXUlFST2J5?=
 =?utf-8?B?OFNleTZWb0h3blJOTGRXV0JDSG1mNWZLT1ppYlF3TWhNRkVRZFZpK3pZZEUz?=
 =?utf-8?B?SjlmRkNiNFBXR1lHZ3UxbHdCYWtacE50cUV3bEdnY0kzdlUwaExOMVhYaUtN?=
 =?utf-8?B?VEF4UjBPNUM1TGxPOUY5V01ZL3NLb0pKbjRTVFprbkh6dGVCYUlzNzQxSStC?=
 =?utf-8?B?Y29kVWFLSTRzKzE3aC96YWxHUU9GRFZ6UFZaR09PKzJEZHFpOTRjTFhnKzc0?=
 =?utf-8?B?cXVFR1RFZkNTWVZmZEo3MExxTDFiUzJhcklCbHJpcm5NUE05S25vSFN0c0pC?=
 =?utf-8?B?aUJEbGpBME9WMWRmK2pCcm1qQURFaTZIR04xNVV0elVOdktrQnFkMlhndlR1?=
 =?utf-8?B?dWpyRVo3cjB5bVQ0MThZUzdobzZRNUlTMHM4alI4ZzZrV2VQVVlBYzc1NUhH?=
 =?utf-8?B?bERlOFg3b2htNFJndUZqUzZwZWpFOW1YbGFEOEFta1crVnJvVzg1L0xGandv?=
 =?utf-8?B?MkhsbllaMGMyUXoydjlIQW5RTS9mNG8xaWZjbFNVNTVLTk5lSHczbWJDQTB5?=
 =?utf-8?B?bFpjT1lQSlZUOEptUjUxUEZ3bUpEaFh2bjkyTEVtOFhiRmpSalBSNjZqRElj?=
 =?utf-8?B?UC9XYXZVR0F1S08vOVZzb1RkNW5EWk1lZnBPRHh2cnphamdoYzE0RDIyczlM?=
 =?utf-8?B?elRXYTQzMDRCWmIrSm1TMlZiOEZFaFhaUWx0ajlNQ2JsaHBvSHpiZnVtSXA0?=
 =?utf-8?B?bmJ1RTlicEdwckJuRncxNkhrM0JDcUIwRWVmeGJBT2lub290ajFucmZmeXVt?=
 =?utf-8?B?eWtWeFlLT3lOQVVHd1VRNSs3dmxRSTcxaHJWa0lFR0Q4MFl4WUZrb2RxWHJu?=
 =?utf-8?B?R29NSU54dTU5aEJFdnhJL1lhbXptMGlvaGMraitnYzhrOTYrdm8wWUlLdC80?=
 =?utf-8?B?MndwM0JzVVpHdGVLSlRobVRDa0ozR0NNR1k4VnB6T2lONjVjVkkzTjkwUmtw?=
 =?utf-8?B?Tk01WVVKSkRDbE80bFRlbWNpSHZOck1aY3lpYUdSTGRBVGlKUi94eTRjUXNT?=
 =?utf-8?B?ZEhZMGJBRS9iLytUWWo0RVM2aEpFWlRJNnRlS000MmtFVkEzRFcyUThGbnFD?=
 =?utf-8?B?Tk5oQitUYzRLWlN4ZWRFZ3ZzWWFYcjlyRGc4aEptRmxNTDdNNzdYcjVEZW16?=
 =?utf-8?B?ek5IdnQyQVo2M0xianJqYW0zYkxlQWdwNCtYeEdONERXWEhXbnlnYzVkTWxE?=
 =?utf-8?B?QkZFZW5OWDVscGp1eTVQeGNzL2llRkFUak1Kb2RvOGQ4M2F3VnI4bUlWd0k5?=
 =?utf-8?B?SFNCc2REdnFHNjhTSDg0UDdRRVpldlZ5alc5cmZBZnU2TjBFa3R4V1pGUHp1?=
 =?utf-8?Q?2bmDuxBV4jFRtjbmJABVUf7/WAxSwA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFVUVE1zYnZaUkthL0tjZ3J4YmhUSkplbTB0L2w3WE05S2pZRE1sOGZpdnc2?=
 =?utf-8?B?Z0RMUGkydnRJSXI4UHpndVZQSGEzQVNXYmNLdjJOa1RocVgzZnJhYjB5TjJy?=
 =?utf-8?B?TjV1SXJrR1cxdjhEYlFtZVVtZHBrSUN0ai9QZWlCUUFTZGFhTitxeS9SS255?=
 =?utf-8?B?bWUway9LOHM5Vk51bW1LVHZVekV6emgvSHJYanhTdFYxenZmRjQ1RE9kRDFM?=
 =?utf-8?B?V3JCMWhVSmRyVWp0YmpJQXQrUldweTJjN3NWOUIzNHJaaEJ2Z2dJeUZyeUs0?=
 =?utf-8?B?ZW5PM1VWY0ExWTZwUUdZbG9GeG5hYmRKZHlScTBFUTJEMld5U0d6WGRJZVlv?=
 =?utf-8?B?UEl2Rmp2aUtQRVUrbjJMWXROUSt2UkxvZ0NMZklzbEtHTUJYYmVLNVFlYmhp?=
 =?utf-8?B?UkZFMk9uWWFtc284SUx0em1mM01pOE90eWwwVkdVeFc0L3NvQlNWTlR6Nkoz?=
 =?utf-8?B?TlBkQXMxdVNYK0pQbnRXYi9teGdtMEc5K3hjZXE4QjhRaHVXNDZZYXhiR1FZ?=
 =?utf-8?B?blcrazcvN0x6M1V5TngzYWxERXA1UzhPVjI1d1M2bjZZNXRoQVcrZE8ybEQ5?=
 =?utf-8?B?dS83ak9oTk5QZ2dLMHlqSlFzeHgvREt3M1czaGlVTGg0WDFoZzk1VzVVRmQz?=
 =?utf-8?B?OWxISThZcm5yK0tZYVIvR0ZZd1grRUJpKys5ZXluUFhtbWJJQ3M2cklVaG5S?=
 =?utf-8?B?S0plWW50bFRIRTdmWkdFNWM4Nmg2ZlFjaVhOWHFpV2w4d0hiRnNNTkNMMUlH?=
 =?utf-8?B?bTNkVktxUno3VllWT0tYS0dYZDhERXd6MUVqM0M4amsxS1BIekVuTkl2M1V5?=
 =?utf-8?B?bGduVE5rbk9kdDhtZFlPU3N5NzBSV0hZWGdCR0tOMDJWR0xMbWpiVVNDcjNx?=
 =?utf-8?B?T3RMSjcwa1IwS2ZXelZtdWhGblpmWXZwbWlSYUF0Y253aHBUdTFzbEJETFNy?=
 =?utf-8?B?cWs4M1JkR0FFMDFBVnNtcVdEaGJFYjM4UXVqazZPYldWdGN5RUYyNWpIcldk?=
 =?utf-8?B?NWxmTnFDcTM1aERrSCs2cktsQTdaYk15dkQ0WXJWVlU2ZlVmaGwyMnpUWjRm?=
 =?utf-8?B?dEd5NzhIb0taNzVHOXVzdzlDVXpvUStTN1hVMmVEbE1yNjFOYUpyTUcxVDYv?=
 =?utf-8?B?YXZCYi9uM0FiZlFieFVFM2dIUEpPM2o3ZUo3c0I5QXFpak50RlY1SlRzQUdK?=
 =?utf-8?B?RWlvb25uZFNZM2l3cnZtQitXdmhDcDJMOUJHb2pEdmdtdG03QWszdzhQanE1?=
 =?utf-8?B?TnlIcmpkamN0bGJVYUxqRzFMSDRubVZPdk0yWGFScGNvNjhJUWlRdzNtOUV3?=
 =?utf-8?B?N2IraU9TM1pNODdPRG9tOC9KMHR4M3pGOWoya1lxSDVJcmR6ZGVOU1hIaWgv?=
 =?utf-8?B?UmRxTVp5UWRDNGFyb3poVXNNNVhzaW5aazdCa1dRK2gvdDczZnBQdEx2S3Zk?=
 =?utf-8?B?eW1FSTltcXJmREJENzRhV0J6M09GaGx3VXo1NHZ1SWJhWVVmVmFSSy95L1E5?=
 =?utf-8?B?YnJEOHRNajBtRmliK2tkYjcyNWFFMjh0YmdCeGowSm9rNjZMZThWeUo2RW4x?=
 =?utf-8?B?Z2JWYnFLaFkydkM4ZklUcVYzUVFyTFNhZEZROVdPb0laV3JuaHZlQ2ZEaDYx?=
 =?utf-8?B?MjVSQUVER25Cek1qa2s4SFk1cUhtOUJvaHEyTnl6TFBpVXBMQVJvWi9pVmh6?=
 =?utf-8?B?TWROMUVaNzcySVB6bGhHdG5WNnhEQU4rdzhLbUhhWnBOM2JVUGE1ZkpyS2N6?=
 =?utf-8?B?ZDQ5LzQwU21hckJyVnQ1dTZpazdUdDVSbjhtUlVtR0JvejBwZUczNHFxdUpi?=
 =?utf-8?B?VnZielJSYWN6RVV4N1hkNlVoclYwbmNIY2hmUHN6dmZPYWVtQjBnNVJHTXNP?=
 =?utf-8?B?emNLR2N5cWZDWENidEl5YUJReXB3MW56K3VTRmlubmJHK0w1Skh6UkRGU0FD?=
 =?utf-8?B?cEtUTGwzLzgwVHhGRzhxYnBOWE1FYVN0b2NxM3JDVUNWS01JckJ3a09xNHF2?=
 =?utf-8?B?dUhybGdxWHhkK1lKWE9kbmR2QnBOai9Xcy91d1BOOWRrSGR1YjJ6ZmlMTXB3?=
 =?utf-8?B?NlZvMEJEV3hFOTZidDBCNk5NbTgrdXVTeVRjdS9pV1FGUWU4RzZCNDlzMlFN?=
 =?utf-8?B?K29aUC9aTVdobTk5aXArNXp3L0tlTEk5bkpyT29KYUh4UUNQSmhLampac3RV?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1485984BD76FB4CB3FBB5B26EC5BA9B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7589.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bf6b19-c5cb-4d28-d440-08ddaf021943
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 07:22:50.5114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PJ40yUshy9xE+ZvOp49EQYTHoxBKKFlVAaMSoQoc8qYodafKHq2/qsqYslUM9ByKxa4ljqz6b069P82zqdzXXXKQZ4IkOaTJsuJmYI+EH4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7407

T24gU2F0LCAyMDI1LTA2LTE0IGF0IDAwOjUwICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UKPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUKPiAKPiBPbiBGcmksIEp1biAx
MywgMjAyNSBhdCA0OjAy4oCvUE0gPHZpY3Rvci5kdWljdUBtaWNyb2NoaXAuY29tPiB3cm90ZToK
PiA+IAo+ID4gRnJvbTogVmljdG9yIER1aWN1IDx2aWN0b3IuZHVpY3VAbWljcm9jaGlwLmNvbT4K
PiA+IAo+ID4gVGhpcyBpcyB0aGUgZHJpdmVyIGZvciBNaWNyb2NoaXAgTUNQOTk4WC8zMyBhbmQg
TUNQOTk4WEQvMzNECj4gPiBNdWx0aWNoYW5uZWwgQXV0b21vdGl2ZSBUZW1wZXJhdHVyZSBNb25p
dG9yIEZhbWlseS4KPiAKPiAuLi4KCkhpIEFuZHksCgo+IAo+ID4gK01JQ1JPQ0hJUCBNQ1A5OTgy
IFRFTVBFUkFUVVJFIERSSVZFUgo+ID4gK006wqDCoMKgwqAgVmljdG9yIER1aWN1IDx2aWN0b3Iu
ZHVpY3VAbWljcm9jaGlwLmNvbT4KPiA+ICtMOsKgwqDCoMKgIGxpbnV4LWlpb0B2Z2VyLmtlcm5l
bC5vcmcKPiA+ICtTOsKgwqDCoMKgIFN1cHBvcnRlZAo+ID4gK0Y6wqDCoMKgwqAKPiA+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vdGVtcGVyYXR1cmUvbWljcm9jaGlwLG1j
cDk5ODIKPiA+IC55YW1sCj4gPiArRjrCoMKgwqDCoCBkcml2ZXJzL2lpby90ZW1wZXJhdHVyZS9t
Y3A5OTgyLmMKPiAKPiBTbywgd2l0aCB0aGUgZmlyc3QgcGF0Y2ggb25seSB0aGUgZGFuZ2xpbmcg
ZmlsZSB3aWxsIGJlIHByZXNlbnQKPiB3aXRob3V0IHJlY29yZCBpbiBNQUlOVEFJTkVSUy4gUGxl
YXNlLCBtYWtlIHN1cmUgdGhhdCB5b3VyIERUIHNjaGVtYQo+IGZpbGUgaXMgaW4gTUFJTlRBSU5F
UlMuCj4gCgpBcmUgeW91IHJlZmVycmluZyBoZXJlIHRvIHRoZSBmaWxlIHN5c2ZzLWJ1cy1paW8t
dGVtcGVyYXR1cmUtbWNwOTk4Mj8KVGhpcyBmaWxlIHdhcyBpbiB2MiB3aGVyZSB0aGVyZSB3ZXJl
IGEgZmV3IGN1c3RvbSBhdHRyaWJ1dGVzLiBJbiB2MwpJIHJlbW92ZWQgdGhlbSwgc28gdGhlIGRy
aXZlciBjdXJyZW50bHkgZG9lc24ndCBoYXZlIGN1c3RvbSBhdHRyaWJ1dGVzLgpTaG91bGQgSSBo
YWQgYWRkZWQgaXQgdG8gdGhlIGZpbGVzIGluIE1BSU5UQUlORVJTPwoKSXNuJ3QgdGhlIHlhbWwg
ZmlsZSBzdWZmaWNpZW50IHRvIGRlc2NyaWJlIHRoZSBkZXZpY2V0cmVlPyBTaG91bGQgSQphbHNv
IGFkZCBhIGR0cyBmaWxlPwouLi4KPiAKPiAKPiA+ICsjZGVmaW5lIE1DUDk5ODJfQ0hBTihpbmRl
eCwgc2ksIF9fYWRkcmVzcykKPiA+ICh7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiAr
wqDCoMKgwqDCoMKgIHN0cnVjdCBpaW9fY2hhbl9zcGVjIF9fY2hhbiA9Cj4gPiB7wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiAKPiBXaHkgbm90IGNvbXBvdW5kIGxp
dGVyYWw/Cj4gCkluIHYyIEkgdXNlZCBjb21wb3VuZCBsaXRlcmFsLCBidXQgSm9uYXRoYW4gc3Vn
Z2VzdGVkIHRvIGFkZAp0aGUgc3RydWN0IGluIHRoZSBtYWNyby4gQWZ0ZXIgZGVzY3JpYmluZyB0
aGUgcmVhc29uaW5nLCB3ZQphZ3JlZWQgdG8gY29kZSBpdCBsaWtlIHRoaXMuCgpbMV06aHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaWlvLzIwMjUwNjA3MTgyODEzLjY0MjMwMTcxQGppYzIz
LWh1YXdlaS8KCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAudHlwZSA9Cj4gPiBJ
SU9fVEVNUCzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmluZm9fbWFza19zZXBhcmF0
ZSA9Cj4gPiBCSVQoSUlPX0NIQU5fSU5GT19SQVcpLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLmluZm9fbWFza19zaGFyZWRfYnlfYWxsX2F2YWlsYWJsZSA9Cj4gPiBCSVQoSUlPX0NI
QU5fSU5GT19TQU1QX0ZSRVEpIHzCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBCSVQoSUlPX0NIQU5fSU5GT19MT1dfUEFTU19GSUxURVJfM0RCX0ZSRVFVRU5DWSkK
PiA+IHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IEJJVChJSU9fQ0hBTl9JTkZPX09GRlNFVCks
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gwqDCoMKgwqAgXAo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLmluZm9fbWFza19zaGFyZWRfYnlfYWxsID0KPiA+IEJJVChJSU9f
Q0hBTl9JTkZPX1NBTVBfRlJFUSkgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKElJT19DSEFOX0lORk9fTE9XX1BBU1Nf
RklMVEVSXzNEQl9GUkVRVUVOQ1kpCj4gPiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVChJSU9f
Q0hBTl9JTkZPX0hZU1RFUkVTSVMpCj4gPiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IEJJVChJSU9fQ0hBTl9JTkZPX09GRlNF
VCkswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gwqDCoMKgwqAgXAo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLmNoYW5uZWwgPQo+ID4gaW5kZXgswqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC5hZGRyZXNzID0KPiA+IF9fYWRkcmVzcyzCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC5zY2FuX2luZGV4ID0KPiA+IHNpLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAuc2Nhbl90eXBlID0KPiA+IHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC5zaWduID0KPiA+ICd1JyzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC5yZWFsYml0cyA9Cj4gPiA4LMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAuc3RvcmFnZWJpdHMgPQo+ID4gOCzCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gfSzC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgCj4gPiDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAuaW5kZXhlZCA9Cj4gPiAxLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDCoMKgwqAKPiA+IH07wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+ICvCoMKgwqDC
oMKgwqAKPiA+IF9fY2hhbjvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4g
PiArfSkKPiAKPiAKCldpdGggQmVzdCBSZWdhcmRzLApWaWN0b3IgRHVpY3UKCj4gLS0KPiBXaXRo
IEJlc3QgUmVnYXJkcywKPiBBbmR5IFNoZXZjaGVua28K

