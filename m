Return-Path: <linux-iio+bounces-7867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26E93B6A1
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 20:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D161F21A75
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9434E16A938;
	Wed, 24 Jul 2024 18:23:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00174802.pphosted.com (mx0a-00174802.pphosted.com [148.163.133.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04ED16A397
	for <linux-iio@vger.kernel.org>; Wed, 24 Jul 2024 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845391; cv=fail; b=hhTLloSkicVFtraPz7kIRUYPM2CgajYFEB1do3JtP5TGUIGFP9qwmUMx9wk7C7tNM8zh7evAiTs/jWcTq2bG0Lr9Ac43E+HrPFSz9qibnyFX779be8sTnVF2Lo5V6e92HiRpg746+CLN37VCAqcMTozyo1eVphzYxk/c9SGlN9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845391; c=relaxed/simple;
	bh=lB81UFdF3XOay5zHLRpTpUd6/jrmnI7Yztb84bskUNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jyQ5HQfIWfhmIGCjT/6PqPsDBaYYGkWmvJZXiivsBr1q4xIfN9OX29JSKVsIBCDs6eOZUMC+hLKL24sfTBMlz3r5mjtnD+vteqQjYRIosrddc6zYmiRqu/FgWFCaZUMmBynAKldpDhnx2jkzkoUrpL9BqbpY+ZuumfUVpXx3Ecc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=heilatech.com; spf=pass smtp.mailfrom=heilatech.com; arc=fail smtp.client-ip=148.163.133.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=heilatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heilatech.com
Received: from pps.filterd (m0172407.ppops.net [127.0.0.1])
	by mx0a-00174802.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OF4KDx019329;
	Wed, 24 Jul 2024 12:49:04 -0500
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012037.outbound.protection.outlook.com [40.93.1.37])
	by mx0a-00174802.pphosted.com (PPS) with ESMTPS id 40k2w2gw19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 12:49:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nib22dPknpAzMQ8NObL+T2I7NFio7nE/AIZ6ocpVT6LB1Z0ruwtlfSi/gq08oqff86ZAUX16MsFdcFmM2ZGuIM0kG7/h/S3Jv4iHrcljn4TJ3IAocbO3U5C3r7xYpmtQuNooYpkhgh4O4X6Zj35L1eQDtoP/flF0hdBGtsj7IQzovp7dwW2sqkECov9UKYpjQCgasJ0A/50mAtcTMOmIkvEE1xqDZiJaE38dAXEH4nwO/SWhbQsVp7uniyXx3cr4kxn3Y9rMeuOlJT/uiandHHsZgHLMfB2JmrGW/JhZ7BQEsJagCDIKygb9K/wcPmTheiW6unS4DhzgHdaexK0RvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB81UFdF3XOay5zHLRpTpUd6/jrmnI7Yztb84bskUNk=;
 b=cuUMCMmBiAc9bRXfJbxF4AJXibZcBTK7PTDx8jvxcASZU63RBHWthn3CTj7ZIMPy7Ytki5G81VhH5tbI/6u60x4oQruYImnkrMyPR5HLuwsJZO+Q06fwwmCXwTdbB5iKf+Ht9+ITe/FB+kJHiYNEt9Tc0RmDXYVeR0r3PAlPkM2eCMEC0VlqhcqvPHSOfofB/yPs5JGmKydo7iSU5fU8eBMDDYm3KH22hRnlYk/1pkn+bbInEHeqRk+Q2MrJRpAkZSqNDWO8U1DPUF5nfb7pokcE34TzXAgB291DsEHtK2XBGFYic/Dsqz6vhtbn4/1YC1xrS1wYBn1qTmkM9tv1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heilatech.com; dmarc=pass action=none
 header.from=heilatech.com; dkim=pass header.d=heilatech.com; arc=none
Received: from SA0PR01MB6170.prod.exchangelabs.com (2603:10b6:806:ec::14) by
 SN7PR01MB8092.prod.exchangelabs.com (2603:10b6:806:352::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Wed, 24 Jul 2024 17:49:00 +0000
Received: from SA0PR01MB6170.prod.exchangelabs.com
 ([fe80::560d:33aa:15dc:408d]) by SA0PR01MB6170.prod.exchangelabs.com
 ([fe80::560d:33aa:15dc:408d%7]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 17:48:59 +0000
From: Akash Borde <Akash.Borde@heilatech.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Emily Guthrie
	<Emily.Guthrie@heilatech.com>,
        Erika Silva <Erika.Silva@heilatech.com>,
        Bart
 Oegema <bart.oegema@heilatech.com>
Subject: Re: [EXT]: Re: [ti-dac5571] Checking compatibility of TI DAC with
 kernel driver
Thread-Topic: [EXT]: Re: [ti-dac5571] Checking compatibility of TI DAC with
 kernel driver
Thread-Index: AQHa3VURec03RAbWv0OAfFXOC/6ogLIF1PYAgAAAFIA=
Date: Wed, 24 Jul 2024 17:48:59 +0000
Message-ID: <55268177-FDEB-49FB-A2F5-3B3980EAD1ED@heilatech.com>
References: <1261F7BA-D202-4BED-ADB4-87EB75E2C068@heilatech.com>
 <20240724134842.00001c29@Huawei.com>
In-Reply-To: <20240724134842.00001c29@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR01MB6170:EE_|SN7PR01MB8092:EE_
x-ms-office365-filtering-correlation-id: 6e46dbe8-a312-406c-631f-08dcac08e616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmFRK3dIY0lValBBdVhsc21KZU5uaGlEbnZPNGg5T21xMFpLK0lORllVOXEy?=
 =?utf-8?B?OHdmYWxab1JadGw5RzhyRGZjeG5SMnFXemc4WElISXBCVE94R1hQTlB2NjVx?=
 =?utf-8?B?SU1tS1ZLaHRFbC9KTWIwemE4dTdDYzI1TTE5dUF4WHhMMGp5b2pMWExIZEcw?=
 =?utf-8?B?Ry96bUk3Z2hLTFZoSzVUR2gzZkpUQWg3SFphSWh6M3BuUE0xOVVBVWZtNzN4?=
 =?utf-8?B?b2JyMTVQbzRwWlhjbkpJMUgyZGFTVUYxVzJjK2puVWpjdjd0MHluYVgwRE9J?=
 =?utf-8?B?WWQyL3hGUzNlYUVhL2tqQUVnRTFiRUFRSHhSei9YZmcrV1NJQmFtUXVKMHdp?=
 =?utf-8?B?dnVDOHNhSlNBNVZyeHJDbzRkQ0k4TkZNT0xZc09RcWJEVitUMWRHWm40WDht?=
 =?utf-8?B?dnJiUHFzVllvb2lSbnU1UDRyckdUSkU3WmQ5MGZvY2R1eTZ4d0l6cmM5dzdS?=
 =?utf-8?B?NlhNbEdkcS9VcDhjWmY1NnlUcHpDNEoyRzNaa3R4REhZS1BYS29pd09jWDg4?=
 =?utf-8?B?ZXRUUERzaUR1ZEM3YUpGMVNJWXdpeWRmL1Bya2MweDhnUnFsbGVkY2s0VG1R?=
 =?utf-8?B?clVYYU1weUJ4UzJmdEg0a0ZubXh6OHhkZWdlSmlYUGgvL0QxckRCWjNXWnBR?=
 =?utf-8?B?WjcxYWwyQjhLTU9nZnF0T0FYK0tYOXJkZE44TVZaNUwyem5MRHNicnNrSHlK?=
 =?utf-8?B?YlZlYkFtQnlOQnhQZzBkczZNS1RzWnk5UEsyenhzQzJmTXgrTktnRmR2cFpL?=
 =?utf-8?B?Wmx3WDZ6S3g0YStNQkFzYVJIZkpsTTJub1pUTk9GWXNvVW1wcHdkOERyZmYw?=
 =?utf-8?B?VWVFSVdOdkY2ZXluZFRFNXpjTWFmckN0TWNYNkxadEFsTzE4OXhxaGhtckFO?=
 =?utf-8?B?ODJabnY1WnJPcnIvT3RHNUxkK0tnWTNWVVh2Q2w5S2w1eTlwVnhwNFRrVHNK?=
 =?utf-8?B?MWptcUJOYTd4QW1IMktCeFVSMy96aVFaQlFPNXVzTkIrYUJvWmY5OVlxNDY4?=
 =?utf-8?B?d2pmdGdWVUdCaGozZllMMU9HME1vK21DV3FIcVFrOU90eEhwckxPcmhlelE2?=
 =?utf-8?B?TjJveEExTFNRcFFxdEZMUW1WWjNZRk5MUHE5NEhPek04ZFlwUk4yRGVzS3Na?=
 =?utf-8?B?cllTdHlGbitKQVFiVitrK0RLcWpSNy9mUlhmK2U1STh3Q0U5U2Z6anZDZUxz?=
 =?utf-8?B?OTB5cVVnd295WmZUTDJQbE5vVFZVTVhaam5sZ3ZyZThJeHp6MnBJNUNPS2tz?=
 =?utf-8?B?bkJaQzkzZGhrRkp1NTBKZW8wZ0tEWC9kZHB6SlRob1RNMitTZ1c1cHJNYm5i?=
 =?utf-8?B?aEtnb0ZYZzNKclhHNElxMEJrNkJhU0lmbCtlZUh6SFF3a2RYZTJVRXcwSUx2?=
 =?utf-8?B?U0ExakZKajRUaGxUN2Q3cmcvc3RTUzlaSDNjQ05lWEZnLy81UHl6am01VElW?=
 =?utf-8?B?bkRYTWczS2hjUytvQXZrZ0FveTkvaGRUM2dmamh5TE5MRWl2dHdySEJzYVBn?=
 =?utf-8?B?SmxydWUxOVI0bm9HK3RMOWw4dlVwdnJITDZBSE0xbFdnWWRYWnA3ejBZZDJx?=
 =?utf-8?B?UzQyallPdXlVVXpHNUs2bWZZcjdJOU52cEUzbFJ0M3pPSEhwMmtidDlVRXkr?=
 =?utf-8?B?eHcxU0JZUGt1WENZQmZ3TEZIOHpLb0txQ0FzdHRLemJFRTVtTHlHZWI2ODVL?=
 =?utf-8?B?K0RGdGpKQy9idjcyYmpTOWd6L2p6WU56YzE1WGdvU203TWdYWHcvZmpJaDdX?=
 =?utf-8?B?NFpoWU9RUjlzMS9yQm5UMUxuWHB0ZFNXdUVaTVp1T0xWajhUdUZLb3pDd2Vj?=
 =?utf-8?Q?BtXCgQYprMUZ6U+DW9nGEJfnICfousyS5A/F8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6170.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUozWmhweEN6NmlVc2FZYUh2Uk4zZW9CQU4vaE5HbnFsR3R6T2hyNE9mek5L?=
 =?utf-8?B?WFc2S3ArSWtIUXhtR3haNzlLemxEbE5vWFVnV0h5TmJ3V01UeTVKYTBGZ0JZ?=
 =?utf-8?B?dEFTMURDUnNGaUwvVlcydCtWWk52YXpma0pqc1k4cDFYd2N2WXBHbU0zSlNx?=
 =?utf-8?B?RTYzQUxTRHdlaXBDZ3RsanppcEZzU255dW9YYTlieThDT1M1RitJN2VtZC9M?=
 =?utf-8?B?YUlQN01nQ1dOVkJ5Vmp1ZGVxamJDMkVvbS8yRklROXhWaEIyNXZERHNqWUI2?=
 =?utf-8?B?djRjWHdTZkJZVlI4MFU0K3ExWW11WHhFakozdnFaYVkwR3ZtaVdsNWdmSXJF?=
 =?utf-8?B?OE5mUTdSdGQ1SDc0Qllyd2VPN1RpSHZzMU5RL1J2R0tFUXpSUXVwQXh6c3Fi?=
 =?utf-8?B?L3dCNTR6MGF0TDZ6bDlWanNHZnRVeW5VejRNSFJjQ1QyazVJQlhRQ2YvTDVR?=
 =?utf-8?B?R05QbTVpZE83WXhMeXJkZk5tbDRuRmgxcnBHOVZaWUIxY1lzbWhkN0NHRHhB?=
 =?utf-8?B?TnFTbDJtVVVKbTBNY0RZVFNoQVdneHZTSjZEQ1gyMGlsUGVpQ0hnaW5PV1BZ?=
 =?utf-8?B?L29mTDJRNUVLeGtlSzd4bGVjQmN4WFN3enZVZFJSMXZJbUllUkhkeVQ4aVg1?=
 =?utf-8?B?cU9veFJmZXlwbWdiYkg1WG45UDI5UUZ5a2ZIWVo1TUF3L1JUYTlmOHhWZWwy?=
 =?utf-8?B?dnd4SVd4aFo4QllvZ0lPR2RSM1dtUm5zdDZ0QjhCWnhoMmg5UHBOQmdOMm9I?=
 =?utf-8?B?anQ1RHV6R0l4Q3ZBWll5K2ZJeFpkM2tETHpvekdOb0ZMaXliOFV2WklJYVNB?=
 =?utf-8?B?V1I2WGNZNTY2Zm5sZnFyNDU2R2hPelBWRFNDZlJYNzI5UnY1aWtudm12cUNy?=
 =?utf-8?B?NzQxVUhPcmRHb1RtaWZJc3dnakZWSG9Mei9Wc0Z1WXJ6a0RsTGFrUFNlVmkv?=
 =?utf-8?B?a2xKdTJYaHRpSSt4SERNSzQ0cHBjczZKVVl6a2tpUHFkTVRuVWlsaVF6Q3l5?=
 =?utf-8?B?Q0o0aWRySlJpT2FUbVNYTFAwV3crTC8xNXM2ZUFnc3RtbUtXZnF6Q05iSldH?=
 =?utf-8?B?QUlKbnljNm4wWkVJVjB4QW00V3ZGREtFdHhwODkyTTdUZk1JZHkwNVc3VE5Y?=
 =?utf-8?B?NXArZ3NDa0Z0TVJIR291clRIRysrSnJXUnoyVGpKaktpQlRScE1FSzhlaE1H?=
 =?utf-8?B?aE02QWFvaFhDaWp1QXJwOXVoUjFqc1FiL0Iva09uU1NYeUpDclg5c2dZamxM?=
 =?utf-8?B?UjVVdEZuZ2o1aVJkK2NveUxkaFczV3ZXTzJtVnEwSjlyVDJpK09PdTVEWjRB?=
 =?utf-8?B?T1gwSnFSbVVlZHd4M2EyVEFWTXhIQzZxR0R1MDA4empkK2QyS2NjMm1QSTlI?=
 =?utf-8?B?cE85VTdBOGtCZVJhMmpuL0dsRXRBL0NpRWZlU25QMXM3aVBqblBFZVd5ZlZU?=
 =?utf-8?B?bUZuVTFFa2RQUWEvSzVtOEtVNTE2NmRVUGYxVWJpeUpzT29UbU1tWVFqNnhm?=
 =?utf-8?B?YTF6SUNMVTRwWm44bXlmT3JVMHdBYThzaXR1NC9GSWUvWHFxVkdyaGcvN2ZU?=
 =?utf-8?B?eStIRE9wNlNRZU5nUCtxY2FaUm5GeTBoa2IzK1VHRVprSnEzNEJxR0w3eW80?=
 =?utf-8?B?bTcyM3dWbllXMzNiWExRREhRNFM3dUpaQk82ZWRCNzRuVkltWXNrWTFUTTJK?=
 =?utf-8?B?bTh0V09mdnFmZnNkL1Q5QzA5TVFkNTN6bXFGbmxvcVpya3J6SUVaOTJqZDlu?=
 =?utf-8?B?Nkk1N1Z1M1llZnVHbUludGY0OXlUOUFQRnZ0MWtxYUxFV1o5YzkxRi9wYlg2?=
 =?utf-8?B?YW9tbHZvMGRHM2N1VlJLNzdrZVNHcEwzaytxTmRsSjY5bCsrc1JMdEdIR1lz?=
 =?utf-8?B?N2g4Vk1nQ1haME1vUkRYblZiS2ZPYTZ4SkdwV3hkWjQvOEd1aUpJOFN4dFRP?=
 =?utf-8?B?blpGUFp3QUdyZDlwbUZ3NjYxRFBxaStPL1ZqeGQ5L2xqZFJaSHB0VnJwMUd4?=
 =?utf-8?B?dUdyVGtPVFJZWnBnNnE5ZFUyaXQrQXVCWmp5b21RTXBHcFdHcHFwVUluUDZj?=
 =?utf-8?B?RmdybkUrWW13ak1laU5iODErbGtiRXBVdWNxa1dQbCtPRGpKMHB4Um1TdnE2?=
 =?utf-8?B?UnQyeXY4emlRSkUrc05LRG9kVENZeUgvT2FQRWhFTUloaFlMTGVlc0k3N2tG?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06E980EA0BA3CF4885CD91197C907CB8@prod.exchangelabs.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: heilatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6170.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e46dbe8-a312-406c-631f-08dcac08e616
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 17:48:59.9658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d2d3f03-286e-4643-8f5b-10565608e5f8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vL1I2BOriwZiFZtEkNEjFnowDSaBsjfjJ64oOetFbN2wlDfzZRAt8Ngboed8gT76zqC7XySkjcMPZfJCB4KJi8OpPq9dWzXoH4XBXdIUqm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8092
X-Proofpoint-ORIG-GUID: 0kBvDq0KAeZYJqPlNAHPy_TpW0CxfHno
X-Authority-Analysis: v=2.4 cv=AczjHGXG c=1 sm=1 tr=0 ts=66a13e8f cx=c_pps a=Xy/G6Uf5sNtwtd22ls67ng==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=iPDCyfAhTBcA:10 a=i0EeH86SAAAA:8 a=jiqXDrDkAAAA:8
 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=0bQCu7td_Tgq1diYu3AA:9 a=QEXdDO2ut3YA:10 a=f0JD9i-elTk4OLjlH16K:22 a=aeg5Gbbo78KNqacMgKqU:22
X-Proofpoint-GUID: 0kBvDq0KAeZYJqPlNAHPy_TpW0CxfHno
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_19,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2407110000 definitions=main-2407240128

VGhhbmtzIGZvciB0aGUgcXVpY2sgcmVwbHkhIFRoaXMgaXMgcXVpdGUgaGVscGZ1bC4NCg0K77u/
T24gNy8yNC8yNCwgNzo0OSBBTSwgIkpvbmF0aGFuIENhbWVyb24iIDxKb25hdGhhbi5DYW1lcm9u
QEh1YXdlaS5jb20gPG1haWx0bzpKb25hdGhhbi5DYW1lcm9uQEh1YXdlaS5jb20+PiB3cm90ZToN
Cg0KDQpPbiBUdWUsIDIzIEp1bCAyMDI0IDIzOjA3OjE5ICswMDAwDQpBa2FzaCBCb3JkZSA8QWth
c2guQm9yZGVAaGVpbGF0ZWNoLmNvbSA8bWFpbHRvOkFrYXNoLkJvcmRlQGhlaWxhdGVjaC5jb20+
PiB3cm90ZToNCg0KDQo+IEhpLA0KPiANCj4gSSdkIGxpa2UgdG8gc2VlIGlmIHRoZSBUSSBEQUM4
NTYzIGlzIHBvdGVudGlhbGx5IGNvbXBhdGlibGUgd2l0aCB0aGlzIGV4aXN0aW5nIGRldmljZSBk
cml2ZXIgaW4gdGhlIG1haW4gYnJhbmNoIG9mIHRoZSBrZXJuZWwuDQo+IA0KPiBUaGlzIGlzIHRo
ZSBwYXJ0IEknbSBldmFsdWF0aW5nIGZvciBteSBib2FyZDogaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vd3d3LnRpLmNvbS9saXQvZHMvc3ltbGluay9kYWM4NTYzLnBkZl9fOyEh
THl3ZjB5cE5ZakUhVlJEd056cm9lT0wteVZjMklPeFZJaWFRVl9TS2FIUHJEYzhIQlVKR2FKZnBB
Q2ZSR1lCRk5CVnlnTzJRSUdGcGFtN25WNkpUOGxfYllGWWZMMGg1ZkowNlBidC1oVDQkIDxodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly93d3cudGkuY29tL2xpdC9kcy9zeW1saW5r
L2RhYzg1NjMucGRmX187ISFMeXdmMHlwTllqRSFWUkR3Tnpyb2VPTC15VmMySU94VklpYVFWX1NL
YUhQckRjOEhCVUpHYUpmcEFDZlJHWUJGTkJWeWdPMlFJR0ZwYW03blY2SlQ4bF9iWUZZZkwwaDVm
SjA2UGJ0LWhUNCQ+IA0KPiBIZXJlIGlzIHRoZSBtb3N0IHNpbWlsYXIga2VybmVsIGRyaXZlciBJ
IGNvdWxkIGZpbmQ6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdGh1Yi5j
b20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvZHJpdmVycy9paW8vZGFjL3RpLWRhYzU1NzEu
Y19fOyEhTHl3ZjB5cE5ZakUhVlJEd056cm9lT0wteVZjMklPeFZJaWFRVl9TS2FIUHJEYzhIQlVK
R2FKZnBBQ2ZSR1lCRk5CVnlnTzJRSUdGcGFtN25WNkpUOGxfYllGWWZMMGg1ZkowNklvVE1nVmck
IDxodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRz
L2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvaWlvL2RhYy90aS1kYWM1NTcxLmNfXzshIUx5d2Yw
eXBOWWpFIVZSRHdOenJvZU9MLXlWYzJJT3hWSWlhUVZfU0thSFByRGM4SEJVSkdhSmZwQUNmUkdZ
QkZOQlZ5Z08yUUlHRnBhbTduVjZKVDhsX2JZRllmTDBoNWZKMDZJb1RNZ1ZnJD4gDQo+IA0KPiBJ
IHNlZSB2ZXJ5IHNpbWlsYXIgREFDcyBpbiB0aGUgY29tcGF0aWJsZSBsaXN0IG9mIHRoaXMgZHJp
dmVyLCBidXQgbm90IHRoZSBleGFjdCBwYXJ0IG51bWJlciBmYW1pbHkgdGhhdCBJJ20gbG9va2lu
ZyBmb3IuDQo+IElzIHRoZXJlIGEgd2F5IHRvIHZlcmlmeSBhIERBQyBvciBmYW1pbHkgb2YgREFD
cycgY29tcGF0aWJpbGl0eSB3aXRoIGV4aXN0aW5nIGRyaXZlcnM/DQpTYWRseSBiZXN0IGJldCBp
cyB0byBvcGVuIHRoZSBkYXRhc2hlZXRzIHNpZGUgYnkgc2lkZSBhbmQgdmVyaWZ5IGlmIHRoZQ0K
ZGV2aWNlcyBhcmUgY29tcGF0aWJsZSBpbiBhbGwgc29mdHdhcmUgdmlzaWJsZSB3YXlzLg0KDQoN
Ckl0J3MgYSBwYWluIHRvIGRvIGJ1dCBvbmx5IHdheSB0byBrbm93IGlmIGl0IHdpbGwgY29udGlu
dWUgdG8gYmUgY29tcGF0aWJsZQ0KaW4gdGhlIGZ1dHVyZSBpZiBuZXcgZHJpdmVyIGZlYXR1cmVz
IGFyZSBhZGRlZC4NCg0KDQpKb25hdGhhbg0KDQoNCj4gDQo+IFRoYW5rcyENCj4gDQo+IEFrYXNo
IEJvcmRlIHwgRW1iZWRkZWQgU3lzdGVtcyB8IEhlaWxhIFRlY2hub2xvZ2llcw0KPiBodHRwczov
L2hlaWxhdGVjaC5jb20vIDxodHRwczovL2hlaWxhdGVjaC5jb20vPg0KPiANCg0KDQoNCg0KDQo=

