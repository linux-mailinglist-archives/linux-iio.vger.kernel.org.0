Return-Path: <linux-iio+bounces-23001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B285FB2C84F
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546AE16EDD1
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 15:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F583284682;
	Tue, 19 Aug 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oT3WdKX2"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F2283FF9;
	Tue, 19 Aug 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616582; cv=fail; b=XOYKy3pGGvP9H1YWdQ9KioP5HyheUyie6M6MNTRGsjwkIX/JhYDrN9EwRvn6ochdADxEz4jeYN7OnB4Kwx/4xnFjFDUOGVU0Wis1w9jL0r8ryMFdyoPw5CbT/BxM/0NduEB1aQj+HfqdDY1lPJmjDfiH2kgnsF81qgneFomVuVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616582; c=relaxed/simple;
	bh=uT0cuwdIdE1Te5PDS6ApnQcuOq72r+ISo+18jGYTFO8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oAw4eQN5uvImu1wfrBLR06D3feo4jTjE3OwhfhCAbB75gP76BK8y+eVnY5jbYRT7dkaj+3L4ZD1UrILTdC5OgkWFTl3idq0rR7zraX39wssfTuBv3D+dS+BHls7+CpVZlJ1hpAmPcjRqe6XRm2UDARY2UOeF6V/ALUtPJw+vwPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oT3WdKX2; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqhIJcKAjQRNcC+z3YJAM0HjIrLbPh7Q4CVK8VYCH6zfgZLMYIKEILn8UmpeuDUQODP/aWK+EGWhfeDCRBAAJ+N2ErQy0HVPg5rhM6KLdMZ4YcGqoCy/9OJ4JE1eBBkDe1JJ1N8bfXhtwNtve+Tztje0K0xFK1S5YG/MhmHcS+/1zUY+An1KbfBkAYFulCnduygmZGwZioim0sbntfD0d+zmjds6z5AtbXLpeXUfaq9jJKVDqMuLnNZES/mbsLTeO6zJLEDdPxEsS8WrB2LlWJ58N1jOUuVGimviCJE8FGplgaQEvYrUWaCc0C7gaNaJvkw10gRq/1BXcygCWQZ8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cGMIchp1QJiZBvYfFVWi8AFFgoLbftSBHxQQTtlPc4=;
 b=DxNGIhXCbskdjWDXv/qRhihHwUXHtXExd+z8Fz+edHFJD6NBQYtTsbV9oZzlSu9oYsnM2ZfOB/U7Ye9aMe+g625v8ro6etDtodzhpglMsjuGdKBG12XlM8cvL2NwonHooIWtTurTC03REMyzLTCrtgLiW0IyOCFdAHOTR46FroKTp++OXitxCAGGB6oX4R4tv4xpcZr/tZaCerOa5/GVURPUx5EByscn+0QGa5GRF2sGC9XceyimlxwvnYQE9wQM4isbaoyM3xRaqCiHdAAX56nkLWTzr5WNKE4TQyS7XY9Tk8qhaPBc5Y8PKLILey5wB5RS/f2lFsFu6MSDhp3HkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cGMIchp1QJiZBvYfFVWi8AFFgoLbftSBHxQQTtlPc4=;
 b=oT3WdKX2ctNfhv0tz7puHKlUTJzbo4sibkbqRiJoWqY/LbMllwIjgD2TnmDEYOYf0urH8MEaC2u9S7qEaHa9+YOiiI8FJUf33pYnylmoALqmsFXS2n+rIzYZsncIrtcIODoo3N94PpOG0TPiUW9u4cbqnvwyTq8tNMhdvCX6t94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.14; Tue, 19 Aug 2025 15:16:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 15:16:19 +0000
Message-ID: <3ea7da5d-192b-4cd4-bc06-150ce68a3845@amd.com>
Date: Tue, 19 Aug 2025 17:16:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update xilinx-ams driver maintainers
To: Salih Erim <salih.erim@amd.com>, conall.ogriofa@amd.com, jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250819150448.1979170-1-salih.erim@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250819150448.1979170-1-salih.erim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a96db4a-1d09-4785-baa6-08dddf33592a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZURZTFczOWRjVENvTGNNa0dMMWFCKy9wV3h3U0ozNGZGcDNhaUw0WSt2YkZR?=
 =?utf-8?B?TlY0eEhQTmZ5NkpDS01rejcxbE5meWdVWncyb3B2SlkrYldMZG9FTVFDcTJi?=
 =?utf-8?B?K0prWW1HUDNBWlJ0ZTdlbnRWZXNuWW1PRnJkQUZzVnBkZ0dUcFZyQUtpYy9E?=
 =?utf-8?B?U0w0ak5rRitadWl3cE1odjllRTVjSW9XNm1NSVNRWUJkRFl0cWNMSmg2b252?=
 =?utf-8?B?NzF6Wm9laGprbGFmVHdVNk5adEcyYzVhSHNZYk9weDRZekZ5UjVqM3pjNDZo?=
 =?utf-8?B?ZzVNRFlWVDF1RWtGdnFWb3BWczQwWVM1MHZJNXBxYzc0RnlsNWhML1F6OHd6?=
 =?utf-8?B?dHJDN1MyS0NuR1JZbEhxeWFiamozY21YSGI5Q3hTSk5sTGEvZjJwREdCUjJk?=
 =?utf-8?B?Q0VDWHNOT2lCNVJhdkRzZDMvb0NSS2ZLQVh6SVBUNDNlLzVkZktscWprSWE1?=
 =?utf-8?B?WlVIaEtlNXc3UVYvZEZYT0Q2dWZLTXhlTUZ6VTVRbmxwYVd0aFU2QllIMmM1?=
 =?utf-8?B?SHZLY0N4cDF2N3JGWEIrVVBEeHlYR0FRSTBiL3pOWk9RNkFZN1p4U2NDVlJo?=
 =?utf-8?B?eUdwWUlVNHVwOFF6UXE4YlNXN0hVSnRPSnBLcytRYW5VTjFJeWtUR1hJakh5?=
 =?utf-8?B?UW5rV1JpMEJiTHJXTlQ2RVBjTlIxQzZFaGQzaFcwNzhmbloweFJwZFFpOFJW?=
 =?utf-8?B?QjM0VVdZTlBYSk5aYUUxYTVEUE02Z2FuVEg3N3BSWHFBQXZWZTQxL094Q1V3?=
 =?utf-8?B?Vlg1MXlTOVZ0a2hLdS9GbmtWM2dPYTJjSXhSZ01Wakl5d25pNUpORzBRcnI0?=
 =?utf-8?B?M1ltMWQ5cTFDOUVCSGlET2VNUE1vbzk0Y1dtTDIxZVhBR3lkWkxlVzgxZVds?=
 =?utf-8?B?Yk5PdkIwUmZERTRGcFVQczF2T3pkbW9kY29FdFk3ZC8wcFo3YTdXTEdVTzJr?=
 =?utf-8?B?eHU1b3FpZGo5NEhKOTdGaGtIRUlYUWN0VjdoeXArNHAvTUV4WThFUkM1aXky?=
 =?utf-8?B?aWRoQTZ1WFFobGM5Ti9tL0RpN2p1Y1NMTXIwTzFZcTY1WVM5K0daT0dqNGJP?=
 =?utf-8?B?a3JCOCtLN0ZpTHdzTHoxWGIvSHgvWTliZy9NZGhVaHBheUdHSENLMFVta2Rh?=
 =?utf-8?B?Um82ay9MclFzUk1rdlROM3pOWHJZUU9yeHE3dVB6Sm01eFF2YXB3Z1RBZ1M1?=
 =?utf-8?B?ck5KS0NsWHBYcjdvbEprVDBWS0lsc1VFdlhoTGs2Q2pvbHdKR0Q5K0pvL01K?=
 =?utf-8?B?QVB6eDR0dmNTQWQvaXd0c0J0RVgzUHByZ0FxOWlzM1N5emRMUnJjYjVROVpq?=
 =?utf-8?B?dHpvUGIwc0RTOVRiNXgxWEdkSll1UHpCb2NORU93Y2ZtRXM5Q3gvdmtPbU5j?=
 =?utf-8?B?cjdMamp2bUlROU9Nb0hLQXlXaUw5ZXRRSU9mK1FzQkUyZ2lWQXZHamNXV1NU?=
 =?utf-8?B?OG92M3RVZjRXeDZPb2ZTSnVIcjVEOEN4Q3dCRW96M1RGQTZvUURnT0hsKzVk?=
 =?utf-8?B?NWdnRDhEbUhOdXZxWUdlcFhCYnE3dW5YdzNkcG9PZ3N1MDBSaU9yTGFORGs4?=
 =?utf-8?B?cFpOVlRIUkppY1pwbURVYmJxTlhOd1cyaXdyTlRPdzIxcVpDVU5tZG4vaUdP?=
 =?utf-8?B?cVluRkVrbXV0WmxXVE9jenhIVnJzOTVHQmxsM09QcnFRTlQzNG1jeFo4R3ZR?=
 =?utf-8?B?aTVKNERPeENETkxYdk9lYzdhalovWEY5UXo1VytWeVIvN1gzVWlhaWplanJR?=
 =?utf-8?B?Z2FMaThBT0g1VVZwbTUxQitnKzRBQTUwc1V4MGpHMEVOMmFpajdGb3FjU0xY?=
 =?utf-8?Q?/Tpx5tdg9zuqvGbJ07txEVxegC28OY2AfQyAw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXN0OHl0VjN6a0hUMXRNeFA3ZHJpR0x5eEVoaXd4NXRoVzFRVEcyTXRJS3Uv?=
 =?utf-8?B?YjN5aUFtTlJtT0VzS2duV0o4Rk9tclBXVUd6b25kcmpWMVFLZlQ5YjZna2hn?=
 =?utf-8?B?dnZXZi92cDBrMjlJb3R3OUZ6am5aY2thOXkxc0J6THl3OEQyQkZDMXRsOXpY?=
 =?utf-8?B?TEhHZUNjTE9PZ3FOb3QzQ1J2d3lvenpNRHpuVERSN3FmMFdwZ3JwNHdMWGc1?=
 =?utf-8?B?K3JMd2RNL1VFVTAwN0pJN2U0bytHOVlua1N5aEh0djNxdzJlbzVwUlZVazFx?=
 =?utf-8?B?S2lBOXU3QmZPS0ZETXdvZHNJTkJWWTY2WmNYbWNSN2d0Y2dPbWdja2hpWGpK?=
 =?utf-8?B?RHozdkNoeXRvdGdoVXVQM0FWZFdpQ3Fud0RaVVlCRVVxNTB4MkJzTTRSbnh0?=
 =?utf-8?B?WHZYS3JJS3pPT2xHYWFZekd4Z3BQQnhTaXlOUFNrTUpqNEQ3c0lxRXZNdlRZ?=
 =?utf-8?B?U3ZKUmFCOW9wdlg4YzhhdXR2alg5UkpCL29SL290bXJBQ0s1eDhaejlWemNy?=
 =?utf-8?B?VlYwb0Y1ZkFScjQxYmRQSDFjZ01MQ24zbHh5MlRoU1JxYUdRRDNWRlZLcUdJ?=
 =?utf-8?B?OGtTdEVlUDlNWDJ4WFhEWHBkdm5xNlJWYzA3em9OL2VDRXdYTkVMdmhqVU00?=
 =?utf-8?B?emFIZmJ6WFM0T3FsUmxGSCtia0lDZmpkLy9ISVZxQWVwMlU5Rmtab0poaVJL?=
 =?utf-8?B?aTdWOWZDZkhBYTQxbVQwc3RWVEpCdTE2ZGpxWGwwcXhVQUpqRTlCZTliSE9i?=
 =?utf-8?B?T0NyaFRBbWYzK0VEQkZOWGdINVYrTEo5aUhBQldkb3lOQW5TQW9ZTnJhZDA4?=
 =?utf-8?B?eUh3RGIwYWJ6U2VNZGJsNHp4dmNCcXVuaGFxT1lkaGswTEsrVHdpVjVMaVNP?=
 =?utf-8?B?NkZPUkovQVZaQjZQd3pjWkJaUk1URW5zbGNOZUdmbkV3TVZYUnNyMXk3eFpl?=
 =?utf-8?B?SDVtNEJYRlh3Q1MxaitHTHZPL3lCNUEyVS9RV0U1cTUvekxDWmZCdnNPNUFK?=
 =?utf-8?B?VmRGYXZpaEc2a1RqZlU1N1NUL3dQMlEybjRzTUQ0ZXF5ZDI5dCt4eHppdHU4?=
 =?utf-8?B?RE9qWE1IMDRpZUlQSnRmaUc4dTRZQmNVV0xaMHR0ZzJNSUR1MXNtNThCNWU5?=
 =?utf-8?B?dWJMem5PWnNwQzZEMEhmMDFhOE5FZWhXMDFUTkljSmgrcW1LYkpxZHVpTkkr?=
 =?utf-8?B?bzZsZFJQNEJPZlU2V3VhUWhFaG14S1U0bU9wVGVrZ1BUeWhzSEdocGVFeDBl?=
 =?utf-8?B?L3d6ck9qUHoweTVyTitXeTBuTjRrTHc3SWlxd2wrSEZ5bldYY1o1ZVN6dThT?=
 =?utf-8?B?SUw1eHZGTHVrSmJ6NWtsK2xVV3BiQWpHWkhYSC92OHVqbkR0SzQrNlZtRjdk?=
 =?utf-8?B?SmV5UHlDOGNmbnFuNUttS1VRRjVIYjF1MXVXMkpaTTVvWWp5TGhERTFVU3ZK?=
 =?utf-8?B?WkxXS3RlMGZFSG44YTNyVThFNzF2THV6anREWGM5R0Y0WnA1TzFaRUlqeHo0?=
 =?utf-8?B?bVNHdUxxNERHb0piSG45RUZ1SVFVTjhkaUtSZHBpRk16M1dXdnA3ZEpBeEJ0?=
 =?utf-8?B?Q3A0UzhlS3NtWUZKcURvOEcwKzhrbFNURWprSjlqMkp1eGlqYm45bWt3ZjRL?=
 =?utf-8?B?N3htTmxmS0w4Uy8xVndtK2NOYXZMVGxydUNaN0k0elhHVUYxRS9UcTdRT1VL?=
 =?utf-8?B?K2tOR3FvZFJoNHphUkxqVDZyL1F2MTlSbWUxNC9aczZtVmFUZmpYQUI1NWJh?=
 =?utf-8?B?Zldya2xwRmpEQjdzZ05GaUdEVExGSWhoVWF6eHlzbTduMG9YbzBUcmUybXFV?=
 =?utf-8?B?Mis0TitnMUlCQ2o0SlBuN05SUXI3eWNKVGZxeDhKK2lhMUlreTFSK3BjcEg4?=
 =?utf-8?B?SHRYVy9sSVFqcGJML29VVFE4Wnd1Rk9EZi9RS3BOTUV5aTdOMkZ3VE8xcWI5?=
 =?utf-8?B?VUNTNUFRTjBha1ZGL3pXYVlJQjdNZEZLR0xaWTkzNnZRUU1YWTQzdkRpUThJ?=
 =?utf-8?B?ZlFhaHk1RHEzeWFqV00xM3ptcWZ5b1lKVHFyOXFQT2Rkc1FPbnF0VjEvOGRK?=
 =?utf-8?B?YU5qRmVRVkMvK3V0blFpRythUENJSHhhZVNCZXRUbFgzUytzRmp6dFlySklw?=
 =?utf-8?Q?/QDpB9Ae1+HM0qXZazkaaoA1K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a96db4a-1d09-4785-baa6-08dddf33592a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:16:19.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFW51AVzd7MTfz5kZCRB0VAPQ6F6TUqrLF94+1PHox/++9XQC3+KfEqFDhuVTek7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312



On 8/19/25 17:04, Salih Erim wrote:
> Removes Anand Ashok from maintainers and adds Salih
> and Conall as new maintainers.
> 
> Signed-off-by: Salih Erim <salih.erim@amd.com>
> ---
>   Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml | 3 ++-
>   MAINTAINERS                                                    | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> index a403392fb263..3ae1a0bab38f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Xilinx Zynq Ultrascale AMS controller
> 
>   maintainers:
> -  - Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> +  - Salih Erim <salih.erim@amd.com>
> +  - Conall O'Griofa <conall.ogriofa@amd.com>
> 
>   description: |
>     The AMS (Analog Monitoring System) includes an ADC as well as on-chip sensors
> diff --git a/MAINTAINERS b/MAINTAINERS
> index daf520a13bdf..b4b27a31a782 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27537,7 +27537,8 @@ F:	include/uapi/linux/dqblk_xfs.h
>   F:	include/uapi/linux/fsmap.h
> 
>   XILINX AMS DRIVER
> -M:	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> +M:	Salih Erim <salih.erim@amd.com>
> +M:	Conall O'Griofa <conall.ogriofa@amd.com>
>   L:	linux-iio@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> --
> 2.34.1
> 

Acked-by: Michal Simek <michal.simek@amd.com>

FYI: Anand left AMD some time ago

Thanks,
Michal

