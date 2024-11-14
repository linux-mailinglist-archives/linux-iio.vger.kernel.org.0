Return-Path: <linux-iio+bounces-12231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D79C8357
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 07:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F34283BC9
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 06:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388A91E883C;
	Thu, 14 Nov 2024 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d0ELnHRm"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550C14AD2D;
	Thu, 14 Nov 2024 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566955; cv=fail; b=Bv9DKoeuDhvWAMtuYxjGJDLhGuRO+HN58Oh6GNL2tBigwAHKJci6vWg6dmb4VZJLPBHEUZSDLDDV825+787noUHLznLSIYQGPTTnC0/9qw0D4vhBa4uJm1NpSQnzEa6ik6pvj+X5tIBKXf1W6Vd0NWn7xwrvT89Kprey3ectU94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566955; c=relaxed/simple;
	bh=Ecx+Vy+3agCqLo5DjaEV3NnPraBzF84BhZYj9eZkmME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dq2DIIHgWpwB5d44i1gc8tqS66vLX38BJQsolzKWCapsKYaIzI+r9O9vXOyH2crJSjteL5FxF+evx1F6uz/7TLyyGrsx0RTnt/lKGLbE5oq64utM9ee3pcr2mZ3q5E8Teey43tWhjl0q0G+bSbJRWMBQPxtAco4FBuwjIFpsrLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d0ELnHRm; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roH0+8Ni6LkyW2SLlFrzA4TrBaoPiJOvRBUD+b0L1n9QCFybXkZgYCe1TgZV6cQZ4EKItEKx8v59j3Wt0UE3l0Yb9eWYP1VGD5gJKsGeTdfrT7WBOa7hkiRGokmeMzgYWqcK4SyW+rp4F8fv2nc3ez/u2kktY7rD0eHgHPW/MS0v2olkRAT8HGnlSuH+k6YGgOfIF4t5gZH8Rw6FOHfgsy3DNpAKDm6fCXrHAK4M9p6UGoUL/CuiG0CwSGKxR8yLIB6j0QQ6ovZoefF8mb+YfplELfnvyupHmeQWfSbnxhuKCqdgKaPMkuAEOv90SonOt0ngO46xpECxBmpkIH0TEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ecx+Vy+3agCqLo5DjaEV3NnPraBzF84BhZYj9eZkmME=;
 b=kfJzBqWqq2Z+HTzwbhexDANPWcNpwfRg7cyBwNhpASimJNkCnV4Wvg6T/wQh6Sw+IBRtAHxyOztzuS5/SWcX9R2f5ux8G0mlnEuU2HVBzlWNsvEEkk2+2+/kPbqswASRkDqvguLgFozArQpH99g45doFlmNDhjej8gnzxaY9KWOx7y3SbDviBmQ32wC3ketV5MxaRpnmDf7SVJ+6iEHrGnYGL9+CyW7QIeQ94G7tNWVMtchfzPK7PqwHiJsefk3jxXiiYuzYZ1MsFQS5N8z37eSiOVL8Xwmhins6m5H2/t5BwS8ScqMS2jRyvOX5M4Z3qd6z/4+E/L3Cvi8WOh5FwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ecx+Vy+3agCqLo5DjaEV3NnPraBzF84BhZYj9eZkmME=;
 b=d0ELnHRm2Lf0TETtrhLNm+KPSO2U55u5zJ56jlrF8KZYYfj5m6w9UGC8X3SU6tKMHA6B+sfQmpYJ54xOEqqkN+ej1vzLS7njByBiHO5wBTuoXGRcIoZJAaa603npMuGU3yrlhAQeuuA5C6+3cQAYq9b/rrVMjR87a39zUgHNT1WaEmpPsS2Ri/vNs8hM045TkaJiM07mvOGPQJelBgunUjcohlJJCfjmoCK9F7io1Ds0Rmc6A/U88Nydf7Dd9WK8wFl0xbu5m0gWMvd2GJHoEhE0onjY+zYV99YhnnQqcf66D3cQqUTSs2+KZEtso7fpXKtnNb2vuWLCIaNsZDR4mg==
Received: from SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 06:49:11 +0000
Received: from SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34]) by SN7PR11MB7589.namprd11.prod.outlook.com
 ([fe80::df51:5691:df7d:9a34%5]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 06:49:10 +0000
From: <Victor.Duicu@microchip.com>
To: <andy.shevchenko@gmail.com>
CC: <Marius.Cristea@microchip.com>, <jic23@kernel.org>,
	<matteomartelli3@gmail.com>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Thread-Topic: [PATCH v10] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Thread-Index: AQHbNcHWzuc98kQuJUqbYUrDmCDIX7K1o2GAgACzt4A=
Date: Thu, 14 Nov 2024 06:49:10 +0000
Message-ID: <5b9d87b1d6406ff0df6311e9be299985d182b713.camel@microchip.com>
References: <20241113114654.8203-1-victor.duicu@microchip.com>
	 <CAHp75Vcj=vX2GNQRGPfB2rGod2VrWby942tpdws4GkObba+1GQ@mail.gmail.com>
In-Reply-To:
 <CAHp75Vcj=vX2GNQRGPfB2rGod2VrWby942tpdws4GkObba+1GQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7589:EE_|SJ0PR11MB5053:EE_
x-ms-office365-filtering-correlation-id: d4f4cef4-1c41-43df-5b69-08dd047871cd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7589.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWZDanlMa0JnQTNhN1VyMENyWER2WHdxUGhpM3d3S0xlQVdpaE8rUEp4T1ND?=
 =?utf-8?B?K2ZXS2RqRGEzRFRFMHhLdDNtWFJlYVZ3S1dWWU9RcjhWVjhHZ2RxRW54NlA4?=
 =?utf-8?B?TXB4d1F6SWJ4RHoyY3g4b1gwNzZWMGtDRmQrVDdJY3FLNzFkQVk0RG5JSnVV?=
 =?utf-8?B?RUIyQWwzOHdBSmtlS1lWOTcvSmFydTZUTjlYUERYUmxHNUZPTFdLUk42WnJv?=
 =?utf-8?B?MEFWQmFzazJMcjRHd0YybnptZ3J1Smw2WEFmWWd1MldlM2ZYRzhMOHJaQmVO?=
 =?utf-8?B?SDM2SW5Uai9hME9ncVFueVNJeHZ4RXV4bHdJN2dTT2p6VTRjMlFXM2NSb21h?=
 =?utf-8?B?TTI3dkE3c3Fmb1N6VGxyL3NHQldTYlNOeEhtWGd0OEhSaGRyWEE3NkphTU1C?=
 =?utf-8?B?QlovTWgxcmxLTHo0TTU1ZEJRTlNlSElFV3pzWitEUmJDN0lMRjJXSHNwenUy?=
 =?utf-8?B?d0h0K3ZwK2dDZFBwZ0VOejRQaC82WUI0ay8wZ1JUeWNHblF6UHVjUEFUZk1T?=
 =?utf-8?B?MnAxQUhTazBzaFpMY0tNeE9MOXJ4cEkvZkVKWHF5VWN3OXpyeEpGQU45azBy?=
 =?utf-8?B?a3RRektMUk5EbDVWdzZXUzAwZFNjcTVIM3Rhdmp3T3ROT0VQM0FWSWY5U1F6?=
 =?utf-8?B?dXl5KzQxRFlia2p3akVwRmZRNEs4aVIvYWM2VmszZklIenNHb2pvM1dQcmpX?=
 =?utf-8?B?WnhyUVNXSGFsQXVXUUpYV2YzNmNpRGUzdlpZaHl4dXBSd1pyVVV2NVd1S0U1?=
 =?utf-8?B?MDFocVgwdFJzK3FQRXluclNlZVJzOXFKSXdJcHQramxCWG5zM2NNUWlyNDRz?=
 =?utf-8?B?TGsrb25GV3FrZjMxRzRRbWxKbWtjYlFLOUJQM3hwZWNMYTljOEQ3YVU2bDA5?=
 =?utf-8?B?ZDNxRDdUL3dsU2FvT3lwc0tubXVkazhFUFNXMjNDQkhCbWRBd3d2NEFiNXVV?=
 =?utf-8?B?TUpkNExBUjhCdWU0cklLbjd4MVBaU09qTitYRnRuMWhvOGtVazhpR1dKa3R0?=
 =?utf-8?B?RU04bENaQmFsT2sxWVZWakZpQ1F3RlR1Ym9IZ2Q0QTdFUkhFT3hBbzRMczhn?=
 =?utf-8?B?RVo4VVFaU0hEck1DdXdURjJUdFpUOGk0Ni9pTmJDdCtmN2FPWFQrajBLYjll?=
 =?utf-8?B?SEd6SStKNVB4VndKL1FWNGt6MGpMOHVJQ281RU9JczI1NHpwM08veEdFWUs2?=
 =?utf-8?B?MFJsektVL0dDLzlueVBnUGRiQTA2b1BUY21BcXlrYmRXem1GdFdpNERGN01G?=
 =?utf-8?B?bU5jM25qRi85bFAvbXRKbEIxWUdaQ2tnSHZFQWxyWlJMVzBwYU9EYU9pTlJk?=
 =?utf-8?B?cXBaSGN0eFhsb0RHbkdQYmZpTXdNWjhqTlZmMzFxY28vcnFxcTVIYUpwRy9K?=
 =?utf-8?B?TVNxZFk0SzYvTjlKakxUYWxSSkExaEI0MDc3N29EYVlHZm5PaVlSYkVzQ2I1?=
 =?utf-8?B?MkNQVnpPUnh5VW92a0hvM2Q1ZnNQNU9XMWZLZnYrYWFicjJZWWsxekVpYWJ5?=
 =?utf-8?B?TmhBSVlOT3ZVRjBuc3IzWFBtVnVGeFlicjVMd3AyZGZGUDJiL09uZnRnUFpu?=
 =?utf-8?B?azE0UUpyUlpqQlZLWGNOQk5JUEgwT1IzbTV3QkRCZFc5ajV2ZmFuU0FOSHBI?=
 =?utf-8?B?eGU1dmpheE9pTWJjVnpuWk5iSUNReFpINldCM3NpVUF0aXJ0UjdvbEc1b01r?=
 =?utf-8?B?VExZVThhb3FGaHhLUksydEkvUVZKZ2RnQ0tBTUdNbGllSmhhK1FyeHl2ZzB0?=
 =?utf-8?B?K0pkUFVyZksrZ3VmZEdxdDg1dW00bHRNSnVUUmluaUNnSVRyN0o5T0NuMnJP?=
 =?utf-8?Q?W0QLkX2GRk97V1GtJ+lSAPlmiuM8GPwgBqKmc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjRNeHBCcENtMEdocUoxUldSWFBURDlzNmRTVGo4aXJ0bXFPckZGN3NIeStZ?=
 =?utf-8?B?endJZHcyaVMzOHkxUWJyZ1hYSGJXQ1FoSmYrZUhzTjRHdXlmSVN1UnRoYS8z?=
 =?utf-8?B?UDJMQzBGV21aQ083aWxiNTkyUnNQT2lvek0yUmVzeHVSZlNHaWFRMDBuQVRw?=
 =?utf-8?B?NHlEeTYvVko2bEJsMHdWamVmSEt5QzJXZXJiU2R6QytINVlJZEVzc21KSE80?=
 =?utf-8?B?NVdBQUFQaUhUZ1lvWlpXSXdualZMZW55R2lXZ0drODhGQXZkQU5DelJmZ095?=
 =?utf-8?B?TFBpOU1FMG9Qdnd4N2xzaDVqUDVZSi9SSmhNRUJzRmJGWWhteWdpcFNTNG8y?=
 =?utf-8?B?QlVVeWpiNFVBNzYvbkZXTmYvZy9reExkUSsyWDA4Mi9nVmRwTGFpRmRZV2lv?=
 =?utf-8?B?TURDKzMyTW1NdDA3QTBXQWFURzJ6S010OU53QVIwQ1NGUkNoTW45YjZzVUll?=
 =?utf-8?B?NFNxTnk5TVhGNXRVYXEzYTBWY0wvemptY0ZiUTBqaXFEM1ZkaEN4VE5nRlg1?=
 =?utf-8?B?c0NFS0NGUGJySkl0ZG9jREppalhYR20yOGNEdXduOWI1U3JZT0cyUXdSaDBU?=
 =?utf-8?B?Zis3Qi84RWZRVHNwcW5WbXFoVmJuUkhqTUNtbWNXQmM2RGZweDNraXdldFps?=
 =?utf-8?B?Wk5nSTlqd0pseDVzcDQya3V2QWttYnkwUGVWVi8vLzVKY3VvYUNDZUtLVEIy?=
 =?utf-8?B?RUNWSkEzVlpIRU1KVXhhTHEzazRSNkZPbEdIdlRPKzdlbVpNQWxwVE1nMjVN?=
 =?utf-8?B?cDY5ckV1Q0NNenJrRENzTUNsbmZUSWJucmp2ZnBIclJIeEkwU3I5dVpobzI0?=
 =?utf-8?B?RmVzOGN2cGFkclc2a0FZYzRXRnhCK2szUjFjS3NLYTBZd0RYNE1zUHVtUHdp?=
 =?utf-8?B?UURJRStmZzFlVWpYTXZsRUtHcVl5WjluTWNGS1dlTGxGdTh3aVVJa2xHUEJS?=
 =?utf-8?B?QU1GYVJTeEZvYlcwaFdZbHlzTmNiMW0wcmFOS1lhQWNSRVRjTUVRcWxLb0Nk?=
 =?utf-8?B?dVA3WmJBUXYxY0l5cm9MSVhVSEsrTHlySEplM3VRWkY1eGV2TDNMQU5qTU5k?=
 =?utf-8?B?QisyclZXZ3JCWktBZTB1TVEzVUZDbzhXY3lpclQyZGF6YVg1QXVLaE9Yd0Jt?=
 =?utf-8?B?ZUFsNWJKN1o3c2tmblNnMUE4ZFZ4WnFIWHBCOXdPblpCVkk1SFExMVFia0xO?=
 =?utf-8?B?MDNwd0tNd3k2NTl2QkxpNVN4SmdQQmFRZGtsb3lWZjRkTzJoNXBXYmVXenlN?=
 =?utf-8?B?NjMrck5xOXNWUUl6cm40cTYwSlZwUmkxdGs4d3NUMkRLNU5xRUYwWGtkQ0pC?=
 =?utf-8?B?QVJOOUtlTnhVZXkzS1BaeFozTEZvUFE5RG15aEZpeWhxTjlzZmRvZXdRQVJp?=
 =?utf-8?B?dDJtK0MvYk9ubUVWK3FzVmxhOENiM2EzSktXSERLeU9nTFlsaFdPRjBFSDFS?=
 =?utf-8?B?dDE5aE4wL0ZsOC9Od3ZCZWNBTHljSmRTRnQ4NURKc0J6bTdRUGEwSHJhcXdp?=
 =?utf-8?B?L0NWZVhvYVAyYlNEeWdTOHhRMk80dUZhNE5mREQvOTN6RDF3eW95ZFpjc0h6?=
 =?utf-8?B?eHFPS1FlUlNDSHlrVWdTbTdYblFqWlJsS01ob1krUytGcTRNZjNycC9LWDdw?=
 =?utf-8?B?cHphN0VFV3BvcUV1clExODgyV1h1RmRleU9ETG84MmR0Y0NmaDRKTnJRSHBn?=
 =?utf-8?B?empyRXlNUnU2OUw0My9EaFNLMjROY3hYZitJbWFyTittV0F0VDBQTXY3RVZY?=
 =?utf-8?B?dVBLOW1QQlE3YWJPRzg4cmh4OGtKVVgvdHdQTDBYa01QTnVmZUl5NEFKOWRm?=
 =?utf-8?B?dkhJQzAzMW5sREtmUWVTczAxSjNLSmxiTE9vL3pON1NPRGlDcVk4VUw5QWNG?=
 =?utf-8?B?R2VSOXdrc0dJWW54SUwxdmJLZUR6cldzWkl2VTVWRy8rQkorWGZ3dVk3eURW?=
 =?utf-8?B?blVGTnljOXBhRWxtbzl0cG1SQUJ0SGp3cXdsNS8wL09vaUhHRDc4THl4Wmtn?=
 =?utf-8?B?QTYreEFzc1Z4SzIvVGhNU29OeS8wbk1zZE9hdU0vQ0M1MXBrbWRnbEZXN3h5?=
 =?utf-8?B?MFkweWJIVHBmRzBhNERZU1Yzd2VGV3o0YWhiNmlhSDR2aFZKVXpLeGNoaWR3?=
 =?utf-8?B?WFlmTmF3SVVIWU85ME44RkY1WEF3TUkyT1ZVZXJtOERXd3ByVzBSRmNiWVZv?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BDCF747836AE74DB2C995B6C4B2DA0B@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f4cef4-1c41-43df-5b69-08dd047871cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 06:49:10.7874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TMcHQPp3WekIbdWRqBVNPN2iUVMOhgNyWnAHlF+d0Y5QpeKyUMEHHDhD8DB7cHlajDDQ6PaS2bGkGlJ6CUMskw78EtsVYLrCkLTAogkNwh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053

T24gV2VkLCAyMDI0LTExLTEzIGF0IDIyOjA1ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gV2VkLCBO
b3YgMTMsIDIwMjQgYXQgMTo0OOKAr1BNIDx2aWN0b3IuZHVpY3VAbWljcm9jaGlwLmNvbT4gd3Jv
dGU6DQo+ID4gDQo+ID4gRnJvbTogVmljdG9yIER1aWN1IDx2aWN0b3IuZHVpY3VAbWljcm9jaGlw
LmNvbT4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgQUNQSSBzdXBwb3J0IHRvIE1p
Y3JvY2hpcCBwYWMxOTIxLg0KPiA+IFRoZSBkcml2ZXIgY2FuIHJlYWQgdGhlIHNodW50IHJlc2lz
dG9yIHZhbHVlIGFuZCBsYWJlbCBmcm9tIHRoZQ0KPiA+IEFDUEkgdGFibGUuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogVmljdG9yIER1aWN1IDx2aWN0b3IuZHVpY3VAbWljcm9jaGlwLmNvbT4N
Cj4gDQoNCkhpIEFuZHksDQoNCj4gLi4uDQo+IA0KPiA+IERpZmZlcmVuY2VzIHJlbGF0ZWQgdG8g
cHJldmlvdXMgdmVyc2lvbnM6DQo+ID4gdjEwOg0KPiA+IC0gZml4IGNvZGluZyBzdHlsZSBtaXN0
YWtlcy4NCj4gPiAtIGFkZCBVTCB0byBQQUMxOTIxX01BWF9TSFVOVF9WQUxVRV91T0hNUy4NCj4g
PiAtIGVkaXQgY29tbWVudCBpbiBwYWMxOTIxX3dyaXRlX3NodW50X3Jlc2lzdG9yLg0KPiA+IC0g
aW4gcGFjMTkyMV9wcm9iZSB1c2UgaXNfYWNwaV9kZXZpY2Vfbm9kZSBpbnN0ZWFkIG9mDQo+ID4g
wqAgQUNQSV9IQU5ETEUuDQo+IA0KPiBBbnkgZXhwbGFuYXRpb24gd2h5IG15IHRhZyB3YXMgbm90
IGluY2x1ZGVkPyBIYXZlbid0IHlvdSBhZGRyZXNzZWQNCj4gYWxsDQo+IHRoZSB0aGluZ3MgSSBw
b2ludGVkIG91dD8gSWYgbm90LCBjYXJlIHRvIGVsYWJvcmF0ZSB3aHk/DQo+IA0KDQpNeSBzaW5j
ZXJlIGFwb2xvZ2llcywgSSBoYXZlbid0IHJlYWxpc2VkIHRoYXQgeW91IGhhdmUgZ2l2ZW4geW91
cg0KcmV2aWV3LWJ5IHRhZyBpbiB0aGUgbGFzdCByZXBseS4gSSB3aWxsIHNlbmQgdGhlIHBhdGNo
IGFnYWluLg0KDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28N
Cg0KV2l0aCBCZXN0IFJlZ2FyZHMsDQpEdWljdSBWaWN0b3INCg==

