Return-Path: <linux-iio+bounces-24596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC44BADFC9
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 17:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2B11926641
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CB73081B2;
	Tue, 30 Sep 2025 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J3gGkWNb"
X-Original-To: linux-iio@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DE20E334
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247985; cv=fail; b=L9On6zeFJs9wU60ZISpwNuTcUTVyLtmrQO35jgeLpzBBfpQKfW3uZnyaXwJS+XDYh2Mjxerm31QFFiOItOLDc+6tJcEb8s7Nx4+aZXZzclLo62ps9tAz1zxAnXlCAKF46b7J4UrZ1r1LOJiYSIsI7JP8BGCLi2ufwwAZQwVgAEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247985; c=relaxed/simple;
	bh=ug/KFljGJFrNjPc0LGCAJ+fs2hNNBpAS9Ro5nB51JxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wk5GliVIW/j1ZCxoBTTHqLfce2Mb/+DFpik8UewBR232QaMLpJl+keM9zF5x6R9H3IQ6s/57QfwDd5ocTaZ7Yx+3rumIPkm67jaPbtn3Bg9dqf+pXJsh7Ir35ska4OrgN17VaLtglSfWoope9q6C3zn9Gk0PDru0j1H/B49+DvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=J3gGkWNb; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/3/Xj0ytS2Dasc0Rmy95QfFd1d8loisAT2y8nL0VQ0x+okOw8bwrUix8YRNDtfd7ZY+UJvRrj9UZ6QJl12pYxDF2oywMyhbKjBleJLNcoHFeo6uiR09kaum9LDo4i3Yyf3VFqFxQNurw7OzssGUEODDUEZHB4XvGkSoMyDMjQ3LiaiLDM2VcI2qD0L5wXdlomlJCq4G/KFFmqWPocgtTjQhW8KFJEB2qBd5ulk64XKe+MxVqg9XR+VKYHBt3M7hagRm3GCizwhHseO98rOVxPC3bdWGNgU1TyRvOqt/EqsXIJDcgxRJPvA+Y8140ztctlZXcA8AUpLF3sJcnNTUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug/KFljGJFrNjPc0LGCAJ+fs2hNNBpAS9Ro5nB51JxE=;
 b=rhhM66JNkrCV97M93WM027qt5QEx0TVUREj14pnPUQ4t84slQEnOE6YIpUUClTZ9nm2ocSJg0NTxpUW1l+qHvL/yl1xZ4zqUnn3E50SVneTXo3gkNVEun3dlo/S6782nsT0JzlXz7lv5VUXXovm3fF6yZvDGeUbgs33oK8VFHOqXnH+Db5BHPe1Gb8GAvRK/4vWgmei+OdNKFvga04PoMph4ZjRTU0O/OO3eBLx/n0cdbWWoCEKLZ72u3h67tmDITCloN8FrU3/f5k+6MOvHxl0HTPXHc+0zp6BDG74c6lPGxishr4PsW0VOg6cVjHyUCJICblF3jqSw1SPWUPhdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug/KFljGJFrNjPc0LGCAJ+fs2hNNBpAS9Ro5nB51JxE=;
 b=J3gGkWNbGJL5HyLuM/mW6k9Xtgf9s8eEcTNg6Rj9fkAPalPvjIPzccm1xRxrzPAdrMdxQuDUQA8mX7/QxYJ+vD0hQPPH0Pilk0FKPdrOw8E+KaSsQS3VlxsCAzpkNl+VsZwCpJnSYMRXg4L2o3n06A8eeYxA//XokJpIuZu3iNq+f2Bb2ol4fL+nVrJoa9YjOs0qDq/mibq/XOM62Ey/soD9E9ZfHOwV8SfodbxoxDEfVqjCZwKDgMKLZMKb3PAKNrwpuElbnbDXY5m84mXNXukAxqNawAounKXM96VDBA6w8FON20DGYxv9G/3TMuQm+kccs9tPSMd5j+827okiIw==
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by CH3PR11MB8094.namprd11.prod.outlook.com (2603:10b6:610:156::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 15:59:41 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::4f64:b0b5:4ed2:39ae]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::4f64:b0b5:4ed2:39ae%2]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 15:59:41 +0000
From: <Marius.Cristea@microchip.com>
To: <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>
CC: <dlechner@baylibre.com>, <srinivas.pandruvada@linux.intel.com>,
	<neil.armstrong@linaro.org>, <eblanc@baylibre.com>,
	<angelogioacchino.delregno@collabora.com>, <jic23@kernel.org>,
	<andy@kernel.org>, <Michael.Hennerich@analog.com>, <jbrunet@baylibre.com>,
	<khilman@baylibre.com>, <matthias.bgg@gmail.com>, <jikos@kernel.org>,
	<martin.blumenstingl@googlemail.com>, <matteomartelli3@gmail.com>
Subject: Re: [PATCH 3/9] iio: adc: mcp3564: replace sprintf() with
 sysfs_emit()
Thread-Topic: [PATCH 3/9] iio: adc: mcp3564: replace sprintf() with
 sysfs_emit()
Thread-Index: AQHcMh98SWh7QgvHs063RWaq05wtjrSr4jeA
Date: Tue, 30 Sep 2025 15:59:40 +0000
Message-ID: <61a9ae408469a0cd91fe04be1c7aa69ab90caca3.camel@microchip.com>
References: <20250930-dev-sprintf-cleanup-v1-0-5d65d096a952@analog.com>
	 <20250930-dev-sprintf-cleanup-v1-3-5d65d096a952@analog.com>
In-Reply-To: <20250930-dev-sprintf-cleanup-v1-3-5d65d096a952@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6005:EE_|CH3PR11MB8094:EE_
x-ms-office365-filtering-correlation-id: 1d091d11-c28e-407e-1618-08de003a5d78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WjJSYzh4QnlGblBtZFFLeGtQQzJQRGRuaXBVcndBdzJLbkFhTUlyejFYTTlU?=
 =?utf-8?B?TTBlYUg0cFNONXpYSjlzTzVpb0ZwODBNOTVacXlsU3pQSmIxUGdkc083UXZY?=
 =?utf-8?B?dXgvWldBNW1KWGZPMzlRK0wyUWJkRExZZGk4Y3BQaW93emwvT2dmelo4dVE0?=
 =?utf-8?B?UEplRnZRVEFwN0pQWmY0eFJOK0EvTXIxZXpWMS92ZXNCNzBWSmw2YkpTM0VC?=
 =?utf-8?B?VkdKSm8zeXZET2xNcW5OL0g5VVptMkgzZGJoakdsaFUxT3pVSW14SjVUS2Mr?=
 =?utf-8?B?bUZUM0VRVXJlQ2xSL1pMaDBDdkJpdHZqbnAvTnAwNDRKQlVXWnRvTlJLSzBt?=
 =?utf-8?B?VFM3aUxtQnhkKzRvV0hteHlwTHVaUnlWWmVjY2swakFlb1pyRTdTZTdZdXZK?=
 =?utf-8?B?RU0vOElsUFlKVTRCNlJHbHc1NnkxS1N0WXM0UjM2aEo5SG13dXdFaUxFSTdU?=
 =?utf-8?B?WFlkR0R6dGlxN0JkSDZPb2xSYWwxcEJjNE5tU29qZjQxaW5QWDBneXhjRkd2?=
 =?utf-8?B?VFdyZ21tb0RNWlJuQ2Y0MDJRMlBpaG9GR1dvdjBDN1ZKRHBhRVJVRnY4WENN?=
 =?utf-8?B?UE9uK21KdzRUdGxBZ2t4YXFnb0I4UzdqVnZ3UlpjUG8za0ovRStwWWI3cTZH?=
 =?utf-8?B?ejVHdm5Bc3JwQW1EZFFWbGluc0t2QWgxZk1GMk1TNHczMTUwWEhLOEUvZHhD?=
 =?utf-8?B?Rktid1pNS1JtMUtCMXJUMXAyNVpERkJMQmpCdnljUWt3d2szMjhoUklubjM5?=
 =?utf-8?B?cFBPTmlhOGgzN0xFZzBTSDk5ZVlha0wrK0hsaWZKdW9WTENyQXZ1TkJuT3lL?=
 =?utf-8?B?ZVRDNERBNkRoSE03NlRETkI4ZTZOWWxKWDFIZ2UrcFB1YlNuZVpHK0hQdjB4?=
 =?utf-8?B?Zk5GUWlueStHbFVQY0psNHpETXdpeWg0RERxRDJRTmY4RDFrN2RFK3BLem5N?=
 =?utf-8?B?TW5rOEdBNEtTNkZ3OTBtMTI1SE5Xczc5bFJVZzRGUk8zbTQycDNab0tqUUg4?=
 =?utf-8?B?dFlQVkdNT2JVb2VMR0szMUtXZmVvN1lNNlQ3SHJJL2NHckpyVVY3L1JIWjE4?=
 =?utf-8?B?YkxUMWVleGNhaFpncmZRYjBhWmRqSkNZT3NkTTlkdi9hTVFLbzI4RzJOYnBy?=
 =?utf-8?B?dDVmK3hvYUQybTllb1BiV1lpaXZCOXlaVUI1cDRibktIR0RrUlM5T0NDZzRy?=
 =?utf-8?B?a1B2TEFZai9KWm5QTHBHUURZZTdxMWRRYkJhSlJMZzE4NVhiall2Z2gyS3dO?=
 =?utf-8?B?YVhNaXhIUjEzRDRlcU5BSnh1V2ovVWhWUlE5Y1NBRkVtUHJnSzZNRlByNFhV?=
 =?utf-8?B?L1p3bmVSdXRDNkswalBOclBOaklkSEF3SnhlY2cwVHk2eU5LYU5Ec1hTelRq?=
 =?utf-8?B?OVp5SDVBWlVDUzBvaWxPR3VRZ0RHVUpNK29jWFZBWDNPTVl6Yko5Mm5SVW83?=
 =?utf-8?B?WkRxYU5pc1hWZTllMFZoaEdidVlkTE81UTgva0c4MUx4STFvbmV0Ui85ZjFw?=
 =?utf-8?B?ME9rU2tlVGJwaEdSd3l0TGh6cVR0Z01tQzZjazZxNjc0ejA4ZXRpb1g3YXpH?=
 =?utf-8?B?ampibEhUUndXOENxd2JJdFhSYUpKVmpTdkFIVHp6cXpPNnpNVkYzYmh1RSt4?=
 =?utf-8?B?bWlOTUY2aThVak5MbnFQcXl5WkxRMjBMVUpuZFFPcEZEc0lTT2tJaFJRV0ZE?=
 =?utf-8?B?SFpHUFF4ZzVUZ0h2VzQxTDBXSzRpWWpUYlR6MHMrU3dRWUs2VjZaZDBmQzhv?=
 =?utf-8?B?WHZKK0p3c01hRGRtRU1PSWM4NWpvSjNUNTk2WG5yaFU1ZG1xbytJWVdyN09S?=
 =?utf-8?B?czIwa2EySHJPalJXMGtNL0duRGdrT2w3NTErSVpkN2FDVENlb3F2a0dkekhO?=
 =?utf-8?B?bDJVUDAyTFhTSVhsZUU4OC9XRUJxdTNkbjdsU3ltZEU5b3VjS0tiWGhRLzhN?=
 =?utf-8?B?TE1rT014RmlXOElyUFhweU5scnVZRTBpWmNMTXZZSVhBMmJZQVZ6MlRvR2li?=
 =?utf-8?B?cW5oL0haOGhjZ2QrdEIrSEthTTU4T1dVd0tUMVd4WVRJSFoyb3JOQ0VhMGtP?=
 =?utf-8?Q?H1x+BX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3R5M0NvUlNRd0ozcGRodU9YMUF6N0VtT25DUkpDcEp2QW9UdW12QUZ3UHhL?=
 =?utf-8?B?NzNjdFBaQWtITEIxU2ozY1kxNmhMdDNGbzZpakovc2w1VWgxaERPQ1RnLytt?=
 =?utf-8?B?TCtJSHNXVFUzU0RuSWVRRHRuWkRxK3drS3FMZFJFODJ4SklxanpKaDBEZGhx?=
 =?utf-8?B?d3ZPNUN2VGpRSzEzdGJSZnB2VzhzNEFTS0pWSE9hbE1wRWJWdUNpYmkrVXlV?=
 =?utf-8?B?aDhVY1V0eWU3Nm1pYVlaZGFNbm5SU2NLZG9QQmdobkJGNkxmL2d3YkFaS1gx?=
 =?utf-8?B?VnRra2Y0QzBOS1F5and3VStNSlVBVWpyaUMwUzhreVVvWHQybG5kREkyNEZC?=
 =?utf-8?B?elRrRXI1b3AreE8yRk5qNW9QN2FXSE5zaWw3ZmdLL09TUTNIN2ppaTZLWmlI?=
 =?utf-8?B?aFkxcGJXazJsYS9nWTBYT3pmZVUyeTBIZ0VFVVRTQlNqYmdoQ2NRZ2JocEtK?=
 =?utf-8?B?RHpqUEk2OVVhaEVubk1zcytDamhacDVlbCtWWUFNNWdNbEtzSFpGNVB6YWdr?=
 =?utf-8?B?QU9uNlM5RGs5cU5NUWdVZEhLUEVVY2Z6cmVLNFIzUnhvaFdTZEFjRGpza1lK?=
 =?utf-8?B?V3F2bmNkd2tycHdYOWRwbzQwVkgvbTlQYVhmU0tsWXA1bDFTY0pGMzV4cVVP?=
 =?utf-8?B?N0xJeUxJOWpYVnNHbEp3TmxyVEp3cVNtbE1HeWg5MGRrWXVZMk1uQVp0L3hD?=
 =?utf-8?B?SVFnbFZ0NDZsSWZOc2R4TzhwckRDOUluRkxFYklqUWtkY2cxM1o1Q3pvY1g0?=
 =?utf-8?B?R3RtQnBwT2dDVVBCNW1iTWZGMEl2SGJiUXAvS2NkcTYycDllMzJXSDByOEdT?=
 =?utf-8?B?SnJVSUtudVM1WTFYbjhrT1B4V3VVUy9NYXVpMDk4c2hhM0RMbGE5dDdVdVph?=
 =?utf-8?B?VUpUUVZDQ2NtUnluU1JuWnFudytmWWJkRG9YcXl5UFhBUDNLclZLQlozd2o4?=
 =?utf-8?B?aytMdFJ4SzlKekZ4Q21NQk93UkFjbXowSzZCemQzRG1EbHQ3SjRGUnoyYTVl?=
 =?utf-8?B?b1VIRDFXMWw0c0pEbU40UUFCUU12U2Y1SDhXU3NGRHBCNmJKK0U0QUUyWTNL?=
 =?utf-8?B?UE04OS9BdU8vblRLVWpZOFFReHpvZ0d0aTFkVTRidUhwb1ErSGJUYkZiV05E?=
 =?utf-8?B?S2xTcStJakJUSVBTMHh1V2ZvUW9aUktaS0k2MEJCTW40bitwcml6eURQRkFq?=
 =?utf-8?B?RlQ2dE5IQjhWYkVVdzBQa0VPSGVCYnM1V1pVSzlmTnVBZk41L3RkNGZyVmta?=
 =?utf-8?B?VE9jeFgydTZ5MHdoR0RmV1J5WFZibkxZd2pnakhmQkZLelVrblVUNFhuVWZz?=
 =?utf-8?B?eHF5Z2VhQ2F0NVRRZVFURVdqTzB2ZGxjak1vZEh3NkhQL2VqOEdQREcwMFlL?=
 =?utf-8?B?c1JsNVVYeWFoNXY5THdJZVJLVnUxemNGWU9xeEZqbHdIYy9HYWJXM054Zm9v?=
 =?utf-8?B?YXFkYzlzTGovN0FHbGdneXpMaG5vcXVpTi90ZWgxS3ZXd2xRcUJtTVZ4eDc0?=
 =?utf-8?B?MWxWMmlVM3U2c3F6d2MxRElxOUxsRUZTS2VFRTdzaDlCdG5jNEZLQ0ovR0JI?=
 =?utf-8?B?ZDdFajFXRllGWkJvVUY3dVFla2dST3E1T2ptbWlzaGwvS2g2T1EzZEc5QXow?=
 =?utf-8?B?OVBVMUliR3N2aXQzN0ttK1V1eklKVEx4d0tqK2I2LzBJQkg4MGh4dWxuUTNh?=
 =?utf-8?B?ZDFaY256SXMvV3kvUnUzdlYrcGVHQURLUXhjcjBnQjQ2YnV1WStMTmRrNk1U?=
 =?utf-8?B?b01wck83SGR2QURjY2Q0dFZxeVduTllPK3A0WEtaWFpZOEROeWoyYzFuVnJ0?=
 =?utf-8?B?c1NWUGprcFNuNmNHRnoxVktoUEpCWEV4N3JZRm5VdGh3eFBqWDlsQUQ0TzhL?=
 =?utf-8?B?S0ZnM3ZZVXg3RDBBWnRrSjNuTXVMU0Q5TmV2QVpTYWdWWDFDSE5SWGpkRGlW?=
 =?utf-8?B?NHZlUjA0cDFJbXdmYUVBeFJaTGh1Y2lOVE93RzhjQW1JUTRZcXJkcEt1RHJX?=
 =?utf-8?B?SG1sZnUrVzRFSDh5UVBKZlJQVFZVQ0dJTnBFVm5DRG04QzlEZURPbGk2UXlh?=
 =?utf-8?B?Nzh2d055NVk1M2svVUJaVGdpaG51elNaWHpYZjhkdkRXTEFldWNRMExneHJa?=
 =?utf-8?B?ZFhaaGZvR002S2Z6a0w1ZnZOVkJSMmRLKzRWSUZOZWJzS2k3YS8xMm1MNm1q?=
 =?utf-8?Q?ffqssSfF5+MujdWYsAKpACg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <621D0E4C8A3E1D458132DB9E79789540@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d091d11-c28e-407e-1618-08de003a5d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 15:59:40.8601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QuekStxqDOY+kU4/XE6J8zO7SfzZB1057+uTu+t7rBSpZOzeccCvKoQiowShyvqBzII/fcPpJLMN6RgcgvzXgxzqou6MISPFR1i9/SIfJn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8094

DQpSZXZpZXdlZC1ieTogTWFyaXVzIENyaXN0ZWEgPG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5j
b20+DQoNCk9uIFR1ZSwgMjAyNS0wOS0zMCBhdCAxNjozMyArMDEwMCwgTnVubyBTw6EgdmlhIEI0
IFJlbGF5IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4g
DQo+IEZyb206IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+DQo+IA0KPiBVcGRhdGUgdGhl
IG1jcDM1NjRfcmVhZF9sYWJlbCgpIGZ1bmN0aW9uIHRvIHVzZSBzeXNmc19lbWl0KCkgZm9yDQo+
IGdlbmVyYXRpbmcgbGFiZWxzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTnVubyBTw6EgPG51bm8u
c2FAYW5hbG9nLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYyB8IDIg
Ky0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvbWNwMzU2NC5jIGIvZHJpdmVycy9paW8v
YWRjL21jcDM1NjQuYw0KPiBpbmRleA0KPiBjZDY3OWZmMTBhOTdjNGJlMTljYTQ2MTEyNmJkZmFl
MmZhODQzMWYyLi5mY2RmMTNmNDljNDhmMzFiYTNhMGE5MDc5NjgNCj4gNmQyYjgxYTc5Mjc0NCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYw0KPiArKysgYi9kcml2ZXJz
L2lpby9hZGMvbWNwMzU2NC5jDQo+IEBAIC05ODcsNyArOTg3LDcgQEAgc3RhdGljIGludCBtY3Az
NTY0X3JlYWRfbGFiZWwoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldiwNCj4gwqB7DQo+IMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBtY3AzNTY0X3N0YXRlICphZGMgPSBpaW9fcHJpdihpbmRpb19k
ZXYpOw0KPiANCj4gLcKgwqDCoMKgwqDCoCByZXR1cm4gc3ByaW50ZihsYWJlbCwgIiVzXG4iLCBh
ZGMtPmxhYmVsc1tjaGFuLT5zY2FuX2luZGV4XSk7DQo+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIHN5
c2ZzX2VtaXQobGFiZWwsICIlc1xuIiwgYWRjLT5sYWJlbHNbY2hhbi0NCj4gPnNjYW5faW5kZXhd
KTsNCj4gwqB9DQo+IA0KPiDCoHN0YXRpYyBpbnQgbWNwMzU2NF9wYXJzZV9md19jaGlsZHJlbihz
dHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0KPiANCj4gLS0NCj4gMi41MS4wDQo+IA0K

