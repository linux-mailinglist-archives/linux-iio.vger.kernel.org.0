Return-Path: <linux-iio+bounces-20202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B0ACDEC5
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 15:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D2E3A7171
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C451928F94E;
	Wed,  4 Jun 2025 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="p2YsOZn1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DE328F50C;
	Wed,  4 Jun 2025 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042910; cv=fail; b=qAiNasFIemRJFp28/tmKQQswXlnwgm2AdbZtI6v4CIEJ2u8tSJz51zArofgm53yO2UTvthuwkxKgWjMp4ByOoU3PIIMwvkoms6x/hm6uSssBpTyVdpC3u5NrjGeqRvNSADxlJPpl7iHnHT3189PTHkbE4Ys41te4VAJ/7AWopmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042910; c=relaxed/simple;
	bh=RbF1rEaXfl8PLXoL0wJ26jnVVnyN9Dl2odLEQvaix8I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=llA2e9d1ECD4ZSQGQvjLngJwKQwfdNlUvEE0E+0zeEe5dKOpI8fjb4KoOB9LE9RaZocdHRFD+pwMWXnUE6pT7XyuElew4IIe+NrOe8FFNbwq69x/ASfUdbfeMsSeKfjtY+YHc19t+Xqg4XFrdGXjBAVTlxjKYyAJ15oSCZrudxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=p2YsOZn1; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554B44qv031622;
	Wed, 4 Jun 2025 09:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RbF1r
	EaXfl8PLXoL0wJ26jnVVnyN9Dl2odLEQvaix8I=; b=p2YsOZn1wKEKI9pqScKtn
	Avtwdc5ehQx3/TLURn5K6OWqFXUBOxDxcNeWEGZo25hbV6tE2V6ERyTpJXuFgPgR
	bOQyhRSwThWsSdqPN8ZKwSJnunDM01taxINF0uIHYFEW58n5nzHLBnmCLCPCaIXR
	Rh6xhptCqiBmDsgbc8FwHij8VZ1ewGFuWTx21fBJTX/U36tW8kcvlA/MeiOzXz3Q
	Jthp+3vdGYXbg1CEjZjgzo2xL8voy016c7MAL5zDSArGAqKdx66vxyGC8S2PNJM+
	IewYOoa+pinngMkdqI7qpOGtLoUFSJImy8bBQnWURy4shbTGnqxu1bVe8OQ7vyU5
	w==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 471g9r8uyk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:05:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMZ4r1P0dWxxbc4BKVkbZ9U33lGGQjb/Hns/SjV6x9gxJkpGhv/xG1xwz+zALLnSQ8vvleNSdshSHUSCxoNbnwKmGp4GGNxQwgXouSU0o39MNyBO/Gkeg6aqUrDq0A926908TMUSOG20vsZ5RSysoeUyQk7F9/WlFPCm87XR4+hZ5UMOiFdlEmx1ALN9/YO7Gvp2uaA82pbeN8+JhZM/+wfmR3LM9m56rnSV2LLT98CBUfO19tNErCPsPUu2QGuCOWHy50gYcW/5sQ9UgU6/0iS/cm2P0dj2LKtXVcATREeeZKHCdmxjon5CstyrRpC28MAVhf2GiSubBl+5cTmdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbF1rEaXfl8PLXoL0wJ26jnVVnyN9Dl2odLEQvaix8I=;
 b=aM62MbCMWX3DBRzuuqUCcJxEdDDGGTYqbRVG2Y3wjxqoVeWscpulNl/KAA5MA9JEwK+NujAgpPED9Z5N6/Z8F6he6DmPHykERbyjaERpawGo2LkUegt9Xl3eLNAowR6YooWos4ns0WLtq2JrpPRn4WZaF6eD9LnVQPPbIq2NG/4cdG5jnryuNYAuwW3p/RU/Pr3Nv2Yu8wxUvcYE0bB3wWetXfUqIuV8Gw3buLHLaGjKsodLErtJU4y1Wrg87sDj9Cw462qriNhA2/lmbj1JMnrudb571BrWXvzTVUr/ryxKoaxD+clzEmnixm9V6nkMeaLFuBGQmXgEXWhXAC125Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6335.namprd03.prod.outlook.com (2603:10b6:510:aa::13)
 by BL4PR03MB8074.namprd03.prod.outlook.com (2603:10b6:208:590::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 13:05:33 +0000
Received: from PH0PR03MB6335.namprd03.prod.outlook.com
 ([fe80::6e6d:c16e:3cc5:93ad]) by PH0PR03MB6335.namprd03.prod.outlook.com
 ([fe80::6e6d:c16e:3cc5:93ad%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 13:05:32 +0000
From: "Ioan-daniel, Pop" <Pop.Ioan-daniel@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        "Cuciurean, Sergiu"
	<Sergiu.Cuciurean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Trevor
 Gamblin <tgamblin@baylibre.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 4/5] dt-bindings: iio: adc: add ad7405
Thread-Topic: [PATCH v5 4/5] dt-bindings: iio: adc: add ad7405
Thread-Index: AQHb08Sa8JGCAWgm+0+1karYLiEOdbPv51wAgAMOrqA=
Date: Wed, 4 Jun 2025 13:05:32 +0000
Message-ID:
 <PH0PR03MB6335ECFCD0C0DEF0230E25B6D16CA@PH0PR03MB6335.namprd03.prod.outlook.com>
References: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
 <20250602134349.1930891-5-pop.ioan-daniel@analog.com>
 <c69e4bc3-c665-46ef-8452-b399aa76b815@kernel.org>
In-Reply-To: <c69e4bc3-c665-46ef-8452-b399aa76b815@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6335:EE_|BL4PR03MB8074:EE_
x-ms-office365-filtering-correlation-id: 41128abd-c798-4ff1-68d9-08dda3687cf8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OExDdVFUOTlvQndscDBHY2x2OUFWUndrbTJBbXRiYVNxTjUrWURXdGsvQVhq?=
 =?utf-8?B?cTFzVitTU0FpdnU4NUsvMjFPMGFFZ1ZyWU9sZ3Q3YW5FenBnYnB4UnI3NXRP?=
 =?utf-8?B?OURjWkRDM1VEM1cvTDUrelRGV3BPd3lOWGNqWXVCVFI1M1JoN3JhenBvMG5W?=
 =?utf-8?B?ZVRIejNuS0NtN283RjllUVFVdkF3S1ROdHo3dFhhblBFK0MrZGlpT1hSMWRi?=
 =?utf-8?B?YlVwTXdEZjFRS0JETm0wQW51RStSTHA2VlVITE16a0pCQkhJZXpjSWZ5UHQy?=
 =?utf-8?B?MlV3cXN4WUdqOTdSK3RGazU1ZTB0RHRKZjBZQU9wVVcxZVd1NWsyWVFuR1pD?=
 =?utf-8?B?OUhMMXJMVXFQa1R1ZGl1MkVpdmRwZzNJWXRUTzd6OTBoNjFQY3BnWC9aUEJT?=
 =?utf-8?B?UE9sMGNTNmVPT2Myd2pIdnB6RGNSZEFkNmlERXEwV2Q1S2tNMnNJTXhuWEJK?=
 =?utf-8?B?WGFHenlYQmdhbWRROTlJbjZuZmNpam5hM1h3MENXL0xoL1E3cUlrb2JqSEJU?=
 =?utf-8?B?Ni95ZzJLNHpMdHpjNitPU2F0OCtzazA4SlZOcTRWcmdUeDlzR2hRdzJxOVp3?=
 =?utf-8?B?UFZZdlNYZGVBQ2QrRDNELzQrdjZyYWZkVnk3RFdqZ0F3QjhNeGR1YVA5NmJV?=
 =?utf-8?B?eUtqY0wwOTZKR3VPRUdnK0VoOHBwN0k2UEZsVUZKMFdTQW5JYy9iUU1OdlV6?=
 =?utf-8?B?TW9FSWQ1RkNua1dlamV1c2w2Zncwb2t2OW1jUkx0OC9FcHhxMGh6Z2tCbm4r?=
 =?utf-8?B?NGkycVdEWitGRE1jSi92UXRkR2FIeHJsTDRrOU16bUp6SEtLcVhLMEhjT2Fq?=
 =?utf-8?B?aTZQQW9vMXVBaTd2a3NCOU1GM3V2bGZqZk8zenNOMlc1MFRYNWNKNUNTZUI1?=
 =?utf-8?B?WFE3bzI2WFBMUkRORHJScEJMY1k3dmx4UDFyKzRrOUlySjMxbHV2M3Zlc1Vk?=
 =?utf-8?B?VTVaTEc2S29Kb2FwUElRL0pzNzFGUTRDMFdrY0dRYlBMYk5iRFlzUytzMHlZ?=
 =?utf-8?B?d1RHaGtuYmJDVzdMdE92cllTaFN0azZKVFRFaEorK29Qd1FEMUtxeXRLckJW?=
 =?utf-8?B?MmFJdTljMmZEVXBzaGtuWW9ONzQ5NVNva2RnaFBweklxbk9VSkxoTnZCdnhK?=
 =?utf-8?B?d2FnL0d6ZWxyU2Jnd1dVdGVxYUd6NHFUd3ZIaUJYOUQrSHF3NGozdmFVejZT?=
 =?utf-8?B?QXFEaTd0Qk1JNWw2Zm8wTU1vUlorb21lSGNwWlVNeDl1VjZPWkhLN2ZVZit3?=
 =?utf-8?B?TjNEQlhYdTZZa0s2Y3ZFWXZ0alpXYjNPM3BzSjNDWVdpeTUrNjJmYUhPOVpB?=
 =?utf-8?B?UDk1cjhvVTVjbW1qUEkzZkVZbmZRZEZCbUwvYjR3Y0lSbUtEUTQ2MDZTT1Jq?=
 =?utf-8?B?SHM2d3lWK0N1VDc4OExjQllDaGZFM3VQa05KWlFvekR5Tkxlc1JVajBxbUlR?=
 =?utf-8?B?SWloc0J4cFdSa3diQWx6bnhnNFNRSHV4WnZ0MnZWQTcxemV0WmFLcmFRL0o0?=
 =?utf-8?B?MUVsZ0dSUjRNN1JTeWRQSmcxZG9HaElqMGFiRXdQeEgxV0NBMzltVTRRL2pp?=
 =?utf-8?B?NGQ1a0JKaHJlR1FjdEZmMEt4M3c2MGxDNnZNcFZvRXNnK2JKMDhmcUhrM29r?=
 =?utf-8?B?cm15WU00ejFBSUIzUklZelMzcldnQzQvNEVCN2ZHcXRPbHJ2cFlxR3pCbE1X?=
 =?utf-8?B?L3gzY3RHemFvdytZNXRTb2lIQmo4Wnk3TlpHTEpRYVord0Y3OTZrZ2lmY1M4?=
 =?utf-8?B?ajgwRnNmYSt6SEpsNXBONXZDc2dldUxOWkxPZHpvSXhvZHZOZlVpcXBUZDVq?=
 =?utf-8?B?UlBwRHZKbWN1YlpaMjZQSG5SLzhncFhxYUtGcnd6MXE5UlNzL0t5TDY5Wmhh?=
 =?utf-8?B?UlFEYU12RnhudEdBOWEyQWF5UDBsZ0dlZFRlSkFKZ0NEaDZNWDNDdjl3KzFi?=
 =?utf-8?B?WU56MmhsTWZXWXluSEhIUDBnYUxKMmUxWXpQdzRmVUFzd3NnQUpmRnpZNXJh?=
 =?utf-8?Q?+3kvCcWD0rtl611TNqPxTnzbGB4t78=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6335.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGVZbTAyRi9iTXlUNGVrNGF3b0NaWU52UFlPYmUzNnAzSndmS0oyeTJYaVhu?=
 =?utf-8?B?bnZDM3JwZHdUWDNpYlFvc1I3VzgvRUtXUnYzRyttc0tEUkJHVVZIWjBNenJN?=
 =?utf-8?B?ZFJ0TEhQVmk0QTRITnFWWUpkYVB0enNjS21pZkM5Szd3azFTL0pjRmx5RFRM?=
 =?utf-8?B?VzlhTHlLcTRXM2Jldm5sQi9HZEZaZHk1MjF5T3FBMzZTTUZtUG1FNmM4Nklj?=
 =?utf-8?B?OVc1VWtBdGdRckxjaDlpcjE3WmZuMnF3M1oyWUd4RTRFUVpoVzNWWUZzSzhE?=
 =?utf-8?B?TFZjVTluN0FoZ09MdzVXcEhQY1piSGo1S3VmeENGeWI3Z1BadTk2TXFrMGJy?=
 =?utf-8?B?c25kWklnTEtSV3pzK3ZMVjZLZUZDRVdRWlNPZ2JKK1FQdUtYWjlMaU85QjdY?=
 =?utf-8?B?VnhCRXlwT3RqeFZINkJhYjdkWVBtSlMraUhGNE01ejBjRGVrRUpQUVVSakIr?=
 =?utf-8?B?NjBDKzRGS0ZTV3h2WkU0NWMwNVRiYWUrckVyYzg5TWNFMVpPckl1d2NXZnBs?=
 =?utf-8?B?aGtpZUJHM2ZNRGM3d2lMRGQvc2xNNTNLcytLdzRKYmtTd2ZQU1BxQnJiOTFx?=
 =?utf-8?B?UCtRVzRJeERxNUdwWnRqdUpXMDM3OW04Z0txS0hzcUNPQml6NkZGVFFtR0JJ?=
 =?utf-8?B?ckZFTjczU2cxYklha08vM1ZqOXBQbERmY3RqeTFIejM0aWR4eTVKWjBBdDVy?=
 =?utf-8?B?V2ZNelFRSlJpSFgwU1k4ditUNDNaUnptZ1VRQ2hsTm5veXQrcStxeTVIL2dj?=
 =?utf-8?B?QkV4ZHlxRTZwTGNxaWJYU3ZhZjhzUUM5SGtkK0QxTExQTVoxR3hhR29pS0Qr?=
 =?utf-8?B?cmdkU2kyNXlWYzhwcWJxZUhBOWV2Y1R6OGwvVFRCWGYvWHVSMEpVbm8yT0NB?=
 =?utf-8?B?ei90YjJtWTlha1ZHejJDVC9DaXFtemtMM0xyRzFiUUcyMTZSQjh1cklvZXB3?=
 =?utf-8?B?SDFKVnUvYTNTbHcvUWxWSlNna0JIbjNYVEUzcTNkSHJiQm9kZFJXMzBPckpH?=
 =?utf-8?B?MCsvS2h2Z2V1QkFvMHZGYnZ4UE1MNFRDdnhCc280MHd6ZnRCVVdyRldZUzFn?=
 =?utf-8?B?SGtMRnlrL1p3SC9uZmhCWE0wQ1BhNllsNXAxQTNZOGwxZ3BJc0l1OGl5Z1NE?=
 =?utf-8?B?ZjNPc1ZvNUZkT3NZZjcydThMdEVPM3VWYzJPaHdnNm5VRTVSTUNYZXB5ZUJH?=
 =?utf-8?B?dEtBQ21kcDBPUHZsd3hXUi9ZTXJJenBUVS8wWHBqN2ZVRUNGSVF6Y3BabEUx?=
 =?utf-8?B?ekRPaWdzUTk0Zm10Smt3L2tXdEF4bElidWZRNmEzd3V3dFFNOHJEYmZ4b3Q4?=
 =?utf-8?B?YllORkNmRzJ6c2JWdDRwU1IzZE53TGpIYkFDMnk1RkNNV3hTRTNoZEIwY0d5?=
 =?utf-8?B?UWQ2OXRnTHRtUlhDUzJqdWEzV3dxSGl1R2lzaHRDT3RsSnh6U3U3TGtiRG5D?=
 =?utf-8?B?aU5pVFEwNXNRdmtiYk9zd2NXZzZMUkc3YmY3SzdsSU1TSlBXS3JudW1tL1Vo?=
 =?utf-8?B?OVRMMW1HTGJqUkpMZXNKMG1tWUJGaEcyYXZDMWhpN1dhMlY5QTI1U2NKNHZt?=
 =?utf-8?B?WXVDZ1JzWXFpUGN2dndZTHNwaUpiL2hzeFVkMGUwZ1ZlSVFnbm5ZRFhqVnhu?=
 =?utf-8?B?T2xqYllZWjhrSi93b0dJTXdERGUyUmV0N0NxYk5nbUR5bE9ORlRFREx4MGhz?=
 =?utf-8?B?ZjhJSmxNS3lPZWxyQ3BINGtGRERyby9PeVBnOHo0U0g3ZGtic1BleHNMeklP?=
 =?utf-8?B?bEpEaFhSUDczZ05wZi91Z09lSlBTRHJZd1JHQXN3V0NETG5YeGJNdTJ6b1lN?=
 =?utf-8?B?dDk5SGpUUUthVG5lUUgrNVRzK0p6bTNYbURHSEF4ZFlmWU83ZFYydEQzRU1t?=
 =?utf-8?B?WXBUUTVrbVpMbU03cWdlY1V4R2ZyckcxWFZaVHNTTzEzNTRkT1JFRDdrOHBW?=
 =?utf-8?B?bU54NUtqamc2WnNHQ2s2b0J6WjdVeWExN0xPM2J6NWlxS0JSUitxVmMxRlpD?=
 =?utf-8?B?UjRpQUVMUVIySWpieWNEZmhsejNyTjNYVnFZQWo4T1hhYmw0c1NSRkcxS2h2?=
 =?utf-8?B?ZFFGaE5VdlZOcUE4d1lzWHhYaHNZRXR6QkJ0N2lRUUN3SURoaGxOSlBLeHFu?=
 =?utf-8?Q?qIu4AvZJlQbUyjBjiiLFxX0HD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6335.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41128abd-c798-4ff1-68d9-08dda3687cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 13:05:32.4651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJEUTH8iGnxPIA+dbkCXc4UVHVnLUBBoNzJz0Xu0I230LKEjugxqEGUsMA+2TJKYhox8ZlNvpUj57HseTtiI0bvET0owUdNa8DpcEEgDO+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8074
X-Proofpoint-GUID: 28Ri9USV0_aMwJWj6iKSjuiRNomY7tHz
X-Proofpoint-ORIG-GUID: 28Ri9USV0_aMwJWj6iKSjuiRNomY7tHz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA5OSBTYWx0ZWRfX0IMcdqIQpgiM
 49iI9zwPmuM7BKTjRgzCHBfcL5/sqa32lCpjMr/Um4Ap7bDQtcCiHQ63mCYCBkAEWkhCWW4Ykap
 vHFT70Ix0Q0/F8rODtBeYUgpqqQqEMwRBOCj/9MpYiWbIhwynRDiMkrnd3cATLlSBshN6Hcc9ec
 tEYpT4RlUq4RAeAFv++W00k/AaVhi7EbC//ErkNBxbuRnc3ynxL64gBtk+9Bj8j47lyH0psdBnR
 j4TeQtmSjvhwm5pZar2x965rXxSCFilZKSQ1X+dO0QEMCi9xSNCYSFN1E+S1PDmo7nm1T5+nP6k
 iTZMwU/X+5z0jL8Tl3JYjFvu0DAkzI5QYTK1FIzJiIWycDY0qA3/uYxhdhzVT3Phgz4h8iDRfpi
 him6ueC/NKZPe0QzNeFleXHVFC/aulqSCR9N1pGmPRPejC4uChcUM+GFKTeGHSeZrPgqKo1J
X-Authority-Analysis: v=2.4 cv=Qctmvtbv c=1 sm=1 tr=0 ts=684044a2 cx=c_pps
 a=kMUYKDuqtyQCWRFVbRQLEg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8
 a=jNvmfRW1W1G9Riod54oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=656 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 phishscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040099

Pg0KPiBPbiAwMi8wNi8yMDI1IDE1OjQzLCBQb3AgSW9hbiBEYW5pZWwgd3JvdGU6DQo+ID4gQWRk
IGRldmljZXRyZWUgYmluZGluZ3MgZm9yIGFkNzQwNS9hZHVtNzcweCBmYW1pbHkuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBQb3AgSW9hbiBEYW5pZWwgPHBvcC5pb2FuLWRhbmllbEBhbmFsb2cu
Y29tPg0KPiA+IC0tLQ0KPiA+IGNoYW5nZXMgaW4gdjU6DQo+ID4gIC0gY3JlYXRlIGFuIGV4YW1w
bGUgYmFzZWQgb24gYWRpLGFkNzYyNS55YW1sIHRoYXQgaXMgdmVyeSBzaW1pbGFyIHRvIHRoaXMN
Cj4gcGFydA0KPiA+ICAtIGRvIG5vdCBhZGQgUmV2aWV3ZWQtYnkgdGFnIGR1ZSB0byB0aGUgY2hh
bmdlIHRoYXQgSSd2ZSBtYWRlLg0KPiANCj4gV2hpY2ggY2hhbmdlPyBJIHNlZSBaRVJPIGRpZmZl
cmVuY2VzIGFnYWluc3QgdmVyc2lvbiB3aGljaCB3YXMgcmV2aWV3ZWQuDQoNCkhpISBUaGUgZGlm
ZmVyZW5jZSBpcyBpbiB0aGUgaW8tYmFja2VuZHMgYXNzaWdubWVudDoNCmV4YW1wbGVzOg0KKyAg
LSB8DQorICAgIGFkYyB7DQorICAgICAgICBjb21wYXRpYmxlID0gImFkaSxhZDc0MDUiOw0KKyAg
ICAgICAgY2xvY2tzID0gPCZheGlfY2xrX2dlbiAwPjsNCisgICAgICAgIHZkZDEtc3VwcGx5ID0g
PCZ2ZGQxPjsNCisgICAgICAgIHZkZDItc3VwcGx5ID0gPCZ2ZGQyPjsNCisgICAgICAgIGlvLWJh
Y2tlbmRzID0gPCZheGlfYWRjPjsNCisgICAgfTsNCisuLi4NCg==

