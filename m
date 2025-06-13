Return-Path: <linux-iio+bounces-20613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE4CAD9399
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 19:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B59189B88E
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5604223316;
	Fri, 13 Jun 2025 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="mz2vMSRc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882D2222BB;
	Fri, 13 Jun 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834881; cv=fail; b=P9Hg4WKPZDUMAAk3BF2wTc3y4B/UgmTX+Wj62MUEtvaVp3UoWA4APFAIRfj+dBw4RBWzP8tGw0G3kg7HN/qdslFfXm7WEYv+UjhN++7xCG5ZFtS60Qn9jLA7hQ1tiMyrYIVAF4rTTdz7Pp7kftmRGxRqiXXoIMbQuJX2prueZ/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834881; c=relaxed/simple;
	bh=MCI5TP4k/N0Mow4akfRIx/ZPr3jtG1m1vWunKsMoR5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uoJlBsS0Cr1Hny1Yp7IqbHhb+q6vTQs6pvphBIcDTU9nW8JHbUkBMxdtDdzYY/sE/vIOeQVQlRNDDcZ3MigIfdedIiXnB63RK1JEe3ixIo55FryJoMRrAozvAkxbx2wkTiywyd//ARiH42uE/NhbzkbvjuehVSYKYnIP2Sp5zbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=mz2vMSRc; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DHDe1B032062;
	Fri, 13 Jun 2025 17:14:19 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazon11012009.outbound.protection.outlook.com [40.107.149.9])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 474bt3523k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 17:14:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mh1f0soXwvTtxmSiB9P4OojTR/aSYitg2fZzEepcQBu1IdHWM0TCBaDt/EpFEIhh1/21CCrHaH0pGoXw8IhpLYxy9f+nfXwTOQQ68Cgeuz0h2ti5DQOTEuOYToss2Y5Ox0xR6BnxzjrB+jzkqtOTgB01OoEeuIICFaiMqxw1EJbxGHA9Ohhu2QC8iEp9CCXtfw+O1FQ9/AIcDq2x4EGXy1Dk1/4+xEgnHqX7Iljv5WYRMSuYxG5XZe4Qy/rJgjHVyRUM4OxdLEBW4mD1zTHXRhZWq9lB3QXE0h9LFHl0Jpjee+69/SJ66DFwmDDkXCWqqW3Vw+5jx0f68QGcUBz8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0UtzflNAsbXNcm4ljiwXJT27UItPhP/F/PLf09E4E0=;
 b=xct/liqCEVVKw5yMz2HiUPm6K59ozhh4AaVPVUfgrlAdm9Lq5Poa6YWKZ1qCvei5TTpLwKPVHGISCyRMxOVK9GY4l27H4hsKz7+QpD0BIW0z/0tg55AYlCnYJD5MNGyfkwFIv5VG8Y6HuBIgXMDdIWxuQ8El77hxK4XVe7Fmm0RgGUmM3mgN2PkkRrIHh5IGvQ0bwfPrhQI3lk5HvtQA0GChlTF3GOGRaLSFfo5qpGCND5ZES56pAT4Po9CDbLdrmytBWds4p/+weRrQaG5yeWuJBCaWHLEmOxCa6NbBtpSOaP65Egs+C2DaIIESD6xk78MVNpHHBUNnYUCiOpSkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0UtzflNAsbXNcm4ljiwXJT27UItPhP/F/PLf09E4E0=;
 b=mz2vMSRcs8nOoyCVn4Il67/7KV0idhBtctin3pEn9FB2iwpcHjIiX5tjOeDzTg6ta3zooWNZ3uPSU7qi5cqRhuOPo4ZSXBN+EggTrtxLkBCUaELPeSsM6kYtTSex/zzLeYqWhJ8kxBFnIgh3msx+lE8tjVcnuwBLZOnTA5K/OBFVAMeB2kTg7meqeGWX0aVOL2Ssv1AU9xAFGP/sMadg/3CDzUl9koxhNmVYw6m8QX+Fuw/4KpsVfe6iBdT0HgJVRJj6kDeQ5/CT+l85l/g8lSgTZJGqKbIyQp0M0Ck057eABBKaPmLjWpJxTnUrR0/nvGxjFT2mH4h2CXiv4yw0HQ==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE3P281MB5084.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Fri, 13 Jun
 2025 17:14:11 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 17:14:10 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        David Lechner <dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Topic: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Thread-Index:
 AQHb3DWiaJg6fqmsLkOWVuHD5p4+yLQAwiAAgAA2IOiAABOvAIAAADkAgAAI6aqAABUXgIAABaCAgAAjco4=
Date: Fri, 13 Jun 2025 17:14:10 +0000
Message-ID:
 <FR3P281MB175722266C119B719FCE9E6CCE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
 <aEvhZiXHLLIRe41-@smile.fi.intel.com>
 <FR3P281MB17578B82AC67F49552E24EB3CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <aEwfUMgLTnQxOh_k@smile.fi.intel.com> <aEwfgP3tiio52Rj-@smile.fi.intel.com>
 <FR3P281MB1757AEF932A3CE2AB9637046CE77A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <aEw4q3p12q1iI7vC@smile.fi.intel.com> <aEw9Yxhodwhh8BT6@smile.fi.intel.com>
In-Reply-To: <aEw9Yxhodwhh8BT6@smile.fi.intel.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE3P281MB5084:EE_
x-ms-office365-filtering-correlation-id: 5b7f016d-3a37-43a8-42d9-08ddaa9db69c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1UsNQPjbebooW3AAvrVH0UAiOP2pSHbrY0pSMMmFyf09v0gGKxsntHKxSF?=
 =?iso-8859-1?Q?+odLj7tmP2F3uCuyTCbuG0dPEEPaMN5CRiaSfzI5dLCUb70WiHi1kHMzqB?=
 =?iso-8859-1?Q?Arp3MOiJ4XZoPxX0hn1vUohmC7TFwi5rly5EXAskoIkD7oJlLCXPsm3+j1?=
 =?iso-8859-1?Q?MBMkinaoLdlm6d/IgbKH54gmJmM/7acxW8TCaH7wSQMRPxqdKN2fZ8/Agz?=
 =?iso-8859-1?Q?niiHYN9ThqXTb6pZheiOkEob7QrgwQJG8qPRxbbSR9zcWtFCM16dp8Q7ry?=
 =?iso-8859-1?Q?TXJmAYwpch0w1ApGRlCH088jMraLDn/m9UHgGbgZZmOUvVpIg+u3kt5kr4?=
 =?iso-8859-1?Q?Uc9TIbGOl7bLNs4Gnj09zJAdWB71yliMkd97zJD7xlFR8yj5N9FSCxNNzO?=
 =?iso-8859-1?Q?8RhknPBP3SCzZuC8ahv64zuIyTJEuyS5LePz4wLwSRRG6x1lEy/OYHjHEE?=
 =?iso-8859-1?Q?2XkHJWd7RuTrhYg0CUcYNlvNSqsLRs/krBAm3A0dDdlc9+kGLTa4ujDmxK?=
 =?iso-8859-1?Q?totMFwcFuAtZlKbYaMeILC7ePBke2iagLXQq/IsSbrrrh2vBH/rawTVqmN?=
 =?iso-8859-1?Q?wDkogl0+136xvWh54hnlD9jhvdX3t1JguoogitJjBjJnecMIlkhbQF7H7P?=
 =?iso-8859-1?Q?hZfHWDwjG7nEbjpNHrB7pZaul0/PGAVPNcfOugTv+R1lqV1ObbyGwHpB/C?=
 =?iso-8859-1?Q?3OijZC64ZuJ7NWgvYMeTBf1/8SzO/z9vyQKe8fakKQaPkzI7l0IDHgkA1T?=
 =?iso-8859-1?Q?4DkjKT1S9JG+UoOd8cc+tvIaakr95Fh1L+qI5ZBUZa5HrbpcEKMhmF8AIF?=
 =?iso-8859-1?Q?T7K9wD5+8T9/MsnD3eUiF/xhPqWvxf3FuDGYqiuYePx+AcLCVChtCVcWQA?=
 =?iso-8859-1?Q?D6KIlle4TusJM/k699ZqTo7KXzTW/2/0GOPHxXHWPP0qgCaubTBh62aVCc?=
 =?iso-8859-1?Q?HzoFDCgrDdbW1VpeSYmHxqTReCccX9A/HZAE1KBrSeR1iGfGdoroznkgye?=
 =?iso-8859-1?Q?2GUlBUMVRwsNqOtXtCGwJPVHz3y8cpsVt4DpfPrBDKNQUXZHK4zDTw8C6m?=
 =?iso-8859-1?Q?1R8mYSWF3nF2X5QJVUT7AJjK3ECj6HiN96unExEfHIIbaGWv7svKQzeP6G?=
 =?iso-8859-1?Q?ynELIqgKyzdEXbI/WvkUe2avQ2rnx2RUsGnMN6xThzf1pnevqt8YLNB6m6?=
 =?iso-8859-1?Q?iIUFDm9nR9qnUkxh/Abz5wke216Zd7MQKmUcuFfE5zDe5UJ+XcOrYFugd2?=
 =?iso-8859-1?Q?u8afjGHNhS9D0bmYXu0NV7RkawIDjjyqCIgDvK/pwdIf1/9hY8K2jupQ9B?=
 =?iso-8859-1?Q?q4TF1xmtiFGwbhsZYUhRxReaRwfyTuBkPkQsEf9kr/tx6BOaXyc3zLiH02?=
 =?iso-8859-1?Q?5Sd9EVaSWIWbCMhLj8D9+hGeVZ63bxSMaA1vazrwrVPEs9R8FBB5OwfkwD?=
 =?iso-8859-1?Q?fSQO+VSuoCdNZSwbdKlcPoCyAOsKD6lcCsEYz1PCcBJyQjkffwxWVT/G1N?=
 =?iso-8859-1?Q?IQ3b4rPSE3ftxVXicV0YhYSfvwkp4ASEN2WVoec3rp7gRhIoTvgaZMoXqz?=
 =?iso-8859-1?Q?gafOd7pvZuK+YtIIzIzBnR048/GK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018)(3613699012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tUqhp9Gmwc1Hb/NKaVZ+zT4178uL4nwhesZTNPOxLuH4AT5IN3IrNTZ67z?=
 =?iso-8859-1?Q?E4wfVGUVBiTM4/mYwFnpPYIrh5aZ3t1A4EzsWfclDy+l9Z+FirVzHqsjzz?=
 =?iso-8859-1?Q?NcHyFqN6y8rTmx6VNNJA4/GBUeXvkuF3qhVtOPUOoZaDVgPO0OuoFvWO4N?=
 =?iso-8859-1?Q?ihhPWXWyD4IuWv42S0vrUh401+qsQvl9qPCOyL5KMUs2pZEHhjgYs3iggL?=
 =?iso-8859-1?Q?7P7JzFHCZ88EQsYxuhRl7xsJThy6cG6DChA3PdXLSr7gm4bfe6FbNxXdV1?=
 =?iso-8859-1?Q?D30k4PJMA8Cxp2WmggBxh44FGEzkQVctod1twEheUm071dSfFt9d5QNb6y?=
 =?iso-8859-1?Q?LvS0f/cBTexETq/ee1D7XjxuPh8qiCaPtUnOSxqsWMOb7YqXDmi7LvrtTm?=
 =?iso-8859-1?Q?M5Bop1/VbsCmEGAMf9l0doN0AB1g2f//jZfBHuDXLkxQ5XsA596DDLJF9E?=
 =?iso-8859-1?Q?quzrF0JlBrYi2IYsPWljSFoP8LTNvXl9WHScgr79deyRBXuWv8UlQaEkgj?=
 =?iso-8859-1?Q?CovjtpmYVFYCEdrky+0vh/MfMlam2DAOL/AH1i40v4+r2NmrRIgUcdYWTl?=
 =?iso-8859-1?Q?fOtuK1xrGTxk74rwmEKUusWlYzazzY1VehzyvCa29b25SYzFIsO3w1R8sk?=
 =?iso-8859-1?Q?pUFLDwCgcu90M/svXICzcWhw9OvlTRpn1XIaJjSS2oVIVSUs+17nwRKUrl?=
 =?iso-8859-1?Q?se7GrayIuLe+u30Wf4wi2qcJ5c0A4YoqbaLS3KUHeYR3Z8V/sgF2JhRhc3?=
 =?iso-8859-1?Q?NbI8vE1wtVCG1hgurnSRTf0AEF6V2tNmdwOg8QfU0ax8E6bCaIEO2Kn2WC?=
 =?iso-8859-1?Q?my0dpdw6lvu7QMnB1bHSpjosQF+rwzz3gVHtzIV4/qVOqPTVBNDnTpS4Up?=
 =?iso-8859-1?Q?PT2IwhvwHahduNL8LNllXSTtlFdszKM6X5qwsYw4X/npCEYs4JHTPz/yEr?=
 =?iso-8859-1?Q?efah5lfbH2X+6hpCqsxD89n0LqHgLRpUgE49wMvsR87f4UF7JR2OWiEcbB?=
 =?iso-8859-1?Q?/nl14rOZ6Ix817m/j5ZTuLeC1fywi3ipwZqLEXRsd4+DyWWq6FEfTovvQN?=
 =?iso-8859-1?Q?GwG2mH6Qsk/sZPvPIqSBH3UDDvOpMSAZEDNa6Z26VXz5DtYepU98qBL4jo?=
 =?iso-8859-1?Q?x12H0W4ZRkbzDQtV/cRj25xNh0il95WLnRpGt0s3hRs5/9dD6r/rn8WoZ4?=
 =?iso-8859-1?Q?6zkUe+gSIYxxBoBjx6fCxsZtM7eHZ3B+4qXIHFC6nc3riC0sJ2+mPgUZBt?=
 =?iso-8859-1?Q?+8l1Pe54aA9cTllZatS6tFgEzVO6F88Yv5QE6tyA+ae9S/4iqnG7icMRJn?=
 =?iso-8859-1?Q?3mKolRH7QXirMcfs4RNk831Uic2qmfvxo1RbrA9RDGR6psfw6R/JcKnWVb?=
 =?iso-8859-1?Q?eQ8FBe15vc0Kp29LVIR8jPSnd7fEHADO/p5mCJpmbeDt/AJt5iMDQNLr74?=
 =?iso-8859-1?Q?InATyFR87upMr6aRdad8BwEkhFqxpf9tkXaAG/768qXzsqtWeFzAYU8f/w?=
 =?iso-8859-1?Q?V8fm3CDhX6XS1zZeWud9ljDNYzhKG6wqnKZ4MLViHUoRAH4kHXa5rRVW6w?=
 =?iso-8859-1?Q?watEOfNLMEY13dKTNgBWu8NvTDRNf03qiAjSpbM/dHbQaj1+9TO8c0Pe94?=
 =?iso-8859-1?Q?Hpe3GalNpSVjF+0PpNqZJaBHwvZphRwxIac0l4Hcnx/B+zP7WaKXA59tGa?=
 =?iso-8859-1?Q?6YhE3hj/Ii8Fv/MCZUrmhydr7xFBkQpB4pCrtFWoC+4ZfZiLDCPtbhhsjD?=
 =?iso-8859-1?Q?oF1A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7f016d-3a37-43a8-42d9-08ddaa9db69c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 17:14:10.6203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSlE8M7BYs43W+3mA/Rn0EkAfQtPf67kCenSnzmDZqItuM2eZrYU+0ayn9y7BzWT95sAX5Cz2KDUassgexQnLlp5c9aB3aDu/r0MmL4EaGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE3P281MB5084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDEyMiBTYWx0ZWRfX22R1OkoE8ETS
 AJTFWYeLkYvGESvdja93L1mohz0IOI5rg20UytwxN6246haQ11CEyktl5MXnD9FRqaqz6jg5W0D
 lE2zZynBPvsFuG6VYgFzK5oNOTnzpy18xaKsvLynwKvvuorJVr7x76Ret2YGInl9rs96LJFXVdI
 +exICZIwkJ+uqLTrSFS0B6UBvs/wzMM4/yvgjs1fDwXh7T501jAY/if7M7n/olMhOb5pw9QnEB3
 P6VlfCwdMxzjwpiOo/ODtQo9zOWxIx2rGHURalH0/h5WHZwf/D6RFa365JSb7JmyLz1Dq9EJ0hw
 Flkfs0u8SUqSU6XHRDwX3ZObI0IOh3EJltzwGF7maDzpL8u2ZrvV9JLonQdmQ/CgdHG44iHjriT
 NuILsdcMcpFW3Mgx8oT+11wlZlgdKRylnikLIX0YJHBgaAiDh+vT1ckYwCDkqgwzO7FIy3Z8
X-Proofpoint-GUID: YjlklEcIvq8JrQvdy-lqZPMhm_ZC84zQ
X-Authority-Analysis: v=2.4 cv=Fas3xI+6 c=1 sm=1 tr=0 ts=684c5c6a cx=c_pps
 a=4OB+H0HCVjXWlc2wGFs6/g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=Uwzcpa5oeQwA:10
 a=VwQbUJbxAAAA:8 a=DqPDx8CTAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
 a=In8RU02eAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=5oJRwxC-VJ8zwEdryuYA:9
 a=wPNLvfGTeEIA:10 a=RW2m95XzjaX0ZN13pgZm:22 a=EFfWL0t1EGez1ldKSZgj:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: YjlklEcIvq8JrQvdy-lqZPMhm_ZC84zQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130122

>=0A=
>=0A=
>________________________________________=0A=
>From:=A0Andy Shevchenko <andriy.shevchenko@intel.com>=0A=
>Sent:=A0Friday, June 13, 2025 17:01=0A=
>To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
>Cc:=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafo=
o.de>; David Lechner <dlechner@baylibre.com>; Nuno S=E1 <nuno.sa@analog.com=
>; Andy Shevchenko <andy@kernel.org>; linux-iio@vger.kernel.org <linux-iio@=
vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.or=
g>=0A=
>Subject:=A0Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support=0A=
>=A0=0A=
>This Message Is From an External Sender=0A=
>This message came from outside your organization.=0A=
>=A0=0A=
>On Fri, Jun 13, 2025 at 05:41:47PM +0300, Andy Shevchenko wrote:=0A=
>> On Fri, Jun 13, 2025 at 01:43:58PM +0000, Jean-Baptiste Maneyrol wrote:=
=0A=
>> > >From:=A0Andy Shevchenko <andriy.shevchenko@intel.com>=0A=
>> > >Sent:=A0Friday, June 13, 2025 14:54=0A=
>> > >On Fri, Jun 13, 2025 at 03:53:36PM +0300, Andy Shevchenko wrote:=0A=
>> > >> On Fri, Jun 13, 2025 at 12:46:46PM +0000, Jean-Baptiste Maneyrol wr=
ote:=0A=
>> > >> > >From:=A0Andy Shevchenko <andriy.shevchenko@intel.com>=0A=
>> > >> > >Sent:=A0Friday, June 13, 2025 10:29=0A=
>> > >> > >On Fri, Jun 13, 2025 at 09:34:26AM +0200, Jean-Baptiste Maneyrol=
 via B4 Relay wrote:=0A=
>=0A=
>...=0A=
>=0A=
>> > >> > >Overall, looking to this patch again, I think it would be better=
 to prepend it=0A=
>> > >> > >by replacing *int*_t types by the respective uXX ones. Because i=
n this patch=0A=
>> > >> > >we add dozens of new ones which increases an unneeded churn in t=
he future.=0A=
>> > >> > >=0A=
>> > >> > In my opinion, to respect the rule don't mix *int*_t and uXX type=
s, it is better=0A=
>> > >> > to keep *int*_t types. If it need to be changed, we can change af=
terward the=0A=
>> > >> > whole driver types with a replace tool and send it in a separate =
patch.=0A=
>> > >> =0A=
>> > >> It will be never ending story, sorry. We need someone to solve this=
 tech debt.=0A=
>> > >> And since this patch adds more than 3 new users of it, I think it's=
 a candidate=0A=
>> > >> to embrace the burden.=0A=
>> > >=0A=
>> > >For your convenience I can mock-up a change...=0A=
>> > =0A=
>> > It looks like there's something I don't understand in the kernel Docum=
entation about=0A=
>> > types then.=0A=
>> > Quoting Documentation/process/coding-style.rst, section 5.d:=0A=
>> > ---=0A=
>> > New types which are identical to standard C99 types, in certain except=
ional circumstances.=0A=
>> > =0A=
>> > Although it would only take a short amount of time for the eyes and br=
ain to become accustomed=0A=
>> > to the standard types like uint32_t, some people object to their use a=
nyway.=0A=
>> > =0A=
>> > Therefore, the Linux-specific u8/u16/u32/u64 types and their signed eq=
uivalents which are=0A=
>> > identical to standard types are permitted -- although they are not man=
datory in new code=0A=
>> > of your own.=0A=
>> > =0A=
>> > When editing existing code which already uses one or the other set of =
types, you should=0A=
>> > conform to the existing choices in that code.=0A=
>> > ---=0A=
>> > =0A=
>> > My understanding is that uXX are not mandatory for new code. You can u=
se types like *int*_t.=0A=
>> > But you need to conform afterward to the existing choice. That's why t=
his driver was=0A=
>> > done initially with *int*_t types, and that patches are conforming to =
this choice.=0A=
>> =0A=
>> This part of the documentation has a lot of room for different interpret=
ations.=0A=
>> One [1] may consider this as uXX superior, another, like you, that it's =
okay=0A=
>> to use.  In any case Greg KH prefers uXX over uintXX_t. And he is also i=
n=0A=
>> the chain of maintainers here. Feel free to amend the Documentation. But=
=0A=
>> be sure all stakeholders will see your proposal (like Greg KH and other=
=0A=
>> key maintainers).=0A=
>> =0A=
>> > By looking at all Linux drivers, there are plenty of them using *int*_=
t, even=0A=
>> > inside iio:=0A=
>> =0A=
>> $ git grep -l 'u\?int[0-9][0-9]\?_t' -- drivers/iio/ | wc -l=0A=
>> 59=0A=
>> =0A=
>> $ git ls-files drivers/iio*.c | wc -l=0A=
>> 640=0A=
>> =0A=
>> Less than 10%.=0A=
>> =0A=
>> > Then, why it is mandatory to change this driver to use uXX instead?=0A=
>> =0A=
>> TO be consistent. With the above wording in the documentation I may argu=
e that=0A=
>> entire subsystem should be consistent and at least in IIO we have tons o=
f patch=0A=
>> series that are against the whole subsystem to do one style change or an=
other=0A=
>> (look at the recent memset() vs. {} for initialisation).=0A=
>> =0A=
>> [1] https://urldefense.com/v3/__https://lore.kernel.org/all/202504091809=
53.398686-1-matchstick@neverthere.org/__;!!FtrhtPsWDhZ6tw!DVTvkgDsymM7132dB=
-wjei-s0JxYiivZxtzEHfWjsrn_6toqTXA__hm2nPUh7jmectCXcP9Z3OAh0hMm-WD6eQAHOtdi=
GbYQqsw$[lore[.]kernel[.]org]=0A=
>=0A=
>Oh, this [2] is golden!=0A=
>YUou may found support for your arguments and for mine in that thread, but=
 the=0A=
>bottom line is: what do maintainers of IIO prefer? (Taking into account th=
at it=0A=
>goes via Greg KH)=0A=
>=0A=
>=0A=
>[2]: https://urldefense.com/v3/__https://lore.kernel.org/all/2021042323060=
9.13519-1-alx.manpages@gmail.com/__;!!FtrhtPsWDhZ6tw!DVTvkgDsymM7132dB-wjei=
-s0JxYiivZxtzEHfWjsrn_6toqTXA__hm2nPUh7jmectCXcP9Z3OAh0hMm-WD6eQAHOtdiuFc54=
eI$[lore[.]kernel[.]org]=0A=
>=0A=
=0A=
If this is required, I can do it. I would just want to know if this is mand=
atory=0A=
since we already have a couple of drivers merged using standard types and=
=0A=
other drivers planned to be merged.=0A=
=0A=
Can I do it in the same series or should it be in a separate patch before t=
his=0A=
series?=0A=
=0A=
=0A=
>-- =0A=
>With Best Regards,=0A=
>Andy Shevchenko=0A=
>=0A=
>=0A=
=0A=
Thanks,=0A=
JB=

