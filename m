Return-Path: <linux-iio+bounces-18822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884CDAA085F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 12:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED31F1A8360E
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE9A225768;
	Tue, 29 Apr 2025 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="qnEPGDni"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C32746A
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745922162; cv=fail; b=RETNz1CsDY1Lt1yfP098p1b9DO/V2/vVhCuRwehVYPs2VujsOYYE4qZjSlKeGWz60XDc+24KX3/ogZ6uqY3amPq6nX/kp58AHuIvqCTPzLs8yrJJ2Jk9NXc8U1VUXGIoeWLqTHimUtjGVNGRHjKQDYmCMxZluXyuB4yTgF+mLRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745922162; c=relaxed/simple;
	bh=xvwAoV4al5td8KOzSFfi8xd5veLmR7TIxSAAXR9NMlQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lJmQ+69hN58KtguIvboAZrVya/NI6aWtDsXRQZRDAPlyChRFmPUtSFMuw6Z69yk7VSesiIh9TPMmBR0994+dYMtprHkrz367+lqdYOG47ms/NrFVz0NeRPabHhRC/A4WvRgZ4TIkkUd0aXXb90sbS4PjedGM+AwbT7cxzp9sbtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=qnEPGDni; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SLQw41028172;
	Tue, 29 Apr 2025 09:37:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 468runay3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 09:37:00 +0000 (GMT)
Received: from m0233779.ppops.net (m0233779.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53T9b0uI019810;
	Tue, 29 Apr 2025 09:37:00 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazlp17012050.outbound.protection.outlook.com [40.93.78.50])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 468runay3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 09:37:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcML0NXBrHijc2XDNbOaxeIr6P+4cQUbgdlCSLy/wbLqjQ0jSwujo6ylMRx0qfVGJ3BVx//s8iRZS0uc7GR44V1oP6jey912SXhmfOIWymBjHeKSuo85dysC+Y761nMj+bXDRc08lnQxTKdBMOOc2NP+IsN+pRwcXnfDT6EogzcIQ/+ZN0FQJ9uK7kbqA3WXenCqUfNGtPx37gVoyC5PE5wjTjlyDmZBpeyFSIGcsddoueAnv7wao1/q68r4L//IMz2M1/4plItl6XdFE4IjulPWYELITbkwzPD0oCSEN8z21Gx19v3JJE7JPnYRpXiKVv1CeDX2e/yYlsTD80a/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBEQIiEmBPHLfHp1xDFOzpQZ2qnQQlDkX3Z/wyZYXBI=;
 b=fdbZEWEcDv2thYgc/7iIDL6DCBMsCNuhBx1MAm59rRC2kpYCmg1JuZFAQQlAii+JWFw37E3s9IoBVWAFpQOALSZA7tQT+0OyhRE0mxr6VU+17UR+g5qmaqi8nYm6aTOQ5JFPgiof3uZn5KB0w8l1mqoZtxS+Le/nYERFnX1aKlfmZRdPMxQ1P0CkP1PZLyjU0nNu1u7HeVWk5hqFtjp4PMVUMzbopB2cWMHeXhgGxULBOGW/HDnRW708CFlInINeSKRI3M+9XpyOCikUNcq9d+pKVmcCgJ5MPPp5Ls8E+VPnqRyZFA641vAk+P2ub0yQLRrjQ1ZpV2RlwmUrSddYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBEQIiEmBPHLfHp1xDFOzpQZ2qnQQlDkX3Z/wyZYXBI=;
 b=qnEPGDni+neDntrp018Y+AZixYPQREwX1a7SoBH09Mr4DT64SYrDHWw/hlpciPZybCpt+9gOCnshSBdE3QUK589jj79JXCQ5U7ouZYxHX5inR/3dF64BCG/hPu4jle+rrCeKaie7k4waJVXIKn/Xh/iCUkD8vt74v8RFyHeWXA4GaD6KBfwv3zo9T/TGLF+Gh0GK3L8mAye9aG37LlNR7JskB0olAoL5NKozICVgkQ6ALeV8EyHOffsnoSxmw9khmdxUj7z61PqD3x/18Km6m0OQtTdQoDpV4NS1BSQUMF+XSE4riDqVIH8N0fTN28fCeYZPxZSIMMU5DU1bldsfcA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1PPF4907A7FC2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b18::63c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 09:36:52 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 09:36:52 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Isabella Caselli <bellacaselli20@gmail.com>,
        "jic23@kernel.org"
	<jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "rodrigo.michelassi@usp.br" <rodrigo.michelassi@usp.br>,
        "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: refactor aux read/write to use
 shared xfer logic
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: refactor aux read/write to use
 shared xfer logic
Thread-Index: AQHbuEEfgJp6VQoPakSruzQbgjRzFrO6YhNA
Date: Tue, 29 Apr 2025 09:36:51 +0000
Message-ID:
 <FR3P281MB1757D6D2DDC9CB772432E323CE802@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250428132551.176788-1-bellacaselli20@gmail.com>
In-Reply-To: <20250428132551.176788-1-bellacaselli20@gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1PPF4907A7FC2:EE_
x-ms-office365-filtering-correlation-id: 37301cd4-d3dd-4560-5450-08dd87015f4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dPWbz4Cn5BCAXfWeUH58E+ybQmPSddPf3FE95vW/c5WbkAmX1GU/uNeU93?=
 =?iso-8859-1?Q?QdNWPio8jtgHum7U0Fp7Qg9aPccdhryhPdFatOD3RDuH/iDVhfo8kl3eH4?=
 =?iso-8859-1?Q?+OF588Z79gcKOfnIFQq/hv/Gee3hVYaELofgsz4l5I3KNKY+2bR2WL3rAR?=
 =?iso-8859-1?Q?gynDhXblKn8Qt4qF+JqW3+TU/0yuQ8TWPGkdceSOHYJAB0sW3MFNBjAMFx?=
 =?iso-8859-1?Q?2Ocx3WCYYuE58LwTAxzd9rrHKTKNBQYUnfIAjbR2pFytdVZ5nB3TasqmqQ?=
 =?iso-8859-1?Q?4if/f1GppXfLjwwCUVZjLfMhBZ8IfU66ZM6Ot2BcqBiN5YDo0E/pY40GJU?=
 =?iso-8859-1?Q?+jTxr+I6h8qdWXWYefbPQgGkSsWJOrimQn8z8bzzwc30cE8TuR2Cou6Sc+?=
 =?iso-8859-1?Q?EkS7pMTOBu7AuYffb23HWEpsuwYwnETlnmhbni/h6HOcvtWjKg8A8TEZ16?=
 =?iso-8859-1?Q?Ib8FjCGP3d0rTgzQFEw9r7Mu9QUouUNqB9N74gV0gUfellUAMeh5fM2oeo?=
 =?iso-8859-1?Q?WyaCsLEDy5f6N/X2oapzbHvrTRjKqOaa/IznppDZANyztTVma20A5+Ojqz?=
 =?iso-8859-1?Q?33jgXGXZVUaOXe4REVBJK5lbfpeFC5ld5xSVUD9j98Jg3OFJUTjPk7ahbg?=
 =?iso-8859-1?Q?Bv0J+7rTuPJHnkkJhUyzurDAC53IvuaAYsAiLCF9iOrLrVD2kXH4Q7/sTh?=
 =?iso-8859-1?Q?yaEtFe1aey2ZYqPHjXEjpULdql2UIVLek+HQJKhNf8MTMrqmKf1F0lJ6Ff?=
 =?iso-8859-1?Q?rVq+10a/Zd/u455Wl/epHYMZBlOsov1AXl1SWEDoutp4/fAFy39yxoZaue?=
 =?iso-8859-1?Q?uUTky3gt1q9AmSTGoBE+LAFaD7vtpxH0YuExV2F7Yowr1IQ7teDk7w4yp1?=
 =?iso-8859-1?Q?P95tEWLRxvTjB7c0xw9UGTQAre7PpnBVbZ1yo69PT5h5KTmp95R6rUHM1w?=
 =?iso-8859-1?Q?QwabfNqvEmJ7l2i/fJ3gspDzgakp05yxGe3QDgT7/HMoZ1i//ouDCRhvhB?=
 =?iso-8859-1?Q?/j7MJRDnLBi1sVDzUu2sdI+Wkx150od8s2WLlavRYsdVT+R7kcyhzd2jl+?=
 =?iso-8859-1?Q?XpkHWIjzVLNNi+kCG9/LnpwaaUFSL+g7GIRdm2XIxH5WDeo4pXoat0Q+8p?=
 =?iso-8859-1?Q?BUW52Tw0HVoLTXuX4WCIkD5Q1m7Dzk446VVQumeYNf92k7LiZu9B8uwtu/?=
 =?iso-8859-1?Q?iZZG/3Kf1u2fxBrxH0HQ7seAA46tIKQgAmNRXxcA56nmk46Q/lpnf4ffL8?=
 =?iso-8859-1?Q?R/Ky+Qv8dXUWQNOS6x4nTsypKEZoXEOqf/41W9rxoGcVMOAg1/UQP87/Nh?=
 =?iso-8859-1?Q?LJGdroxoZaUDitYXyKgzjslSPyNiAORHncsBc7JsyLBvPR+cgIOCaq7WGI?=
 =?iso-8859-1?Q?vLfoaaIG/M1DRFYi7teJMvTldk66/02sb3flGhmUnrpzFBgF5FDg8IBzh9?=
 =?iso-8859-1?Q?PDU78iOy9PHXVAQL4MyhKig3P6xvOWaGy/3vzn2YpAV2fAyKkUrmgQ4FgN?=
 =?iso-8859-1?Q?dhN7E1xjqRrcpJsvi8ArkwVe7lZDyjVST4+loNPOCjKYUFexRw/HzleuBL?=
 =?iso-8859-1?Q?/je7n77sHSNeJFgUYtQfyAF9vAfM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ChrnyfuxVoc+fHANlRYcq2zQzgRbr4pkn6yK1NN8jhVTe38TWYvm1jWYZF?=
 =?iso-8859-1?Q?/uBVaaUcgff7hHU6DcSjPa8f1ftNkpxoGvTH1xg250IpD8RbMBG/8lm8B6?=
 =?iso-8859-1?Q?LjnkOkv3lzeg0iFLBIGf74jqDzCqJNVFp532DLBIUlrc+VLOREIrU3/KwY?=
 =?iso-8859-1?Q?IwIvo+ReFXjKzknX6/FFqsVmMJuedc1idtWpZZ6xkWoGd3mggW7WMoQoa+?=
 =?iso-8859-1?Q?FTERc1rvBYD/vpMcDvXxQ7lkGvGOPh74viN6SHlU1vJaSwRCgFHIngO0cA?=
 =?iso-8859-1?Q?TKUsGHNtAD9Rxua5KO+P5/d//Jr948hvLId1yvSFG9dpjtvvovXcnNQzp0?=
 =?iso-8859-1?Q?U6syFbbAGW2fUe5/f6RxzZMbHnt7rT4HcCYJ+Pve80oc3tFkkzQOr6y92y?=
 =?iso-8859-1?Q?AfoSHvRAYVQB8sr/7IU/Zf5K9EKpKZ3YwMbym3kFOlZO4SQAgfRRwex095?=
 =?iso-8859-1?Q?fy8kRX3JOiuA5xMUFXrI7pr+vpzT/+kS4rrfQQEmx5P0kaLhvwaJL7259Q?=
 =?iso-8859-1?Q?QotP2m7mQc7BWmos5exAnciVs3VnOAkRwAf5z6ZHhBRFjhTY+6YHqogDoz?=
 =?iso-8859-1?Q?UyqktshJsDhyVrcXZLkaQzj/SK+wIUHuK0Si1yrnar05Hn+GDvQ2/x/Ff3?=
 =?iso-8859-1?Q?GtL0euuFT8x0PspRHB33qW5tEVq6ESbjNsSk0ZVPxHf16VEsHMVEO5RBNu?=
 =?iso-8859-1?Q?Cz+YePfMTJAyoUozfpptvdB5pLKxmsYpfaQ9bWpBa5irKjd5G4hEL/fcPQ?=
 =?iso-8859-1?Q?hDnuzwG+f8QoblrPHCPzfp/blIfXdM7F/KDB74ReIirW3a79p8dtJWk3iQ?=
 =?iso-8859-1?Q?VefNjkQt7SxzRzs3UvsJsRqWd9ZFco+m7Rxl/dMj1JIy2/ujNyqlizRpaG?=
 =?iso-8859-1?Q?DOmuFEmSfvVjYJKnTKhE5tF4RrQ4NpAeW8w6ZD99xvQOrTt4JxSiRh/w6h?=
 =?iso-8859-1?Q?YcMRJIlQ+C0b9s22tum8up0cWQqvEU4G3MzK/dxIZAgcNccyQCxEClFTyE?=
 =?iso-8859-1?Q?utZn/vf7Rd+seib2tFjG+cTYOYfoZLKBLgiwKbFlOasi84jev3ixvDuvBp?=
 =?iso-8859-1?Q?2h7gtvtVFdXDyOV+0S4m4IC7HlZxzGDSnbIwlY5uvk3iWDh96T0q/3gb8V?=
 =?iso-8859-1?Q?/IhYWfdukaQ4xU4u78ESJzft0okxzRQ9jx8lOx4oj2HxBCYjglbOF0yIsq?=
 =?iso-8859-1?Q?I8ZmtIfxeKN/4E5aUL/gYJafsF141wbVOL+b+3XxwRiLanAH6yLzPSeCqK?=
 =?iso-8859-1?Q?Gr3x4QZKxsYyXi2A/NpC8ija/GLwvQOOcOVlEFnCliy9bkv61b3QnD2h5I?=
 =?iso-8859-1?Q?tGrO6AYnG89r2f94OI2HIcOCSiyi3byc9xT95cHSGfJhTPbYj5WbekGm4W?=
 =?iso-8859-1?Q?CaCLxVwEtLgIjAkCKn7zx0pfTh1nL7IF3WE5Eacn5TUbLq2mRycnUrcORj?=
 =?iso-8859-1?Q?jE1044shr0sbhEgQE6Q451uudukmSIq33SrY28OxISy4/dUPMn8Og7HUEZ?=
 =?iso-8859-1?Q?xWhZV+mnAUXLNm82PjjJOI4x3Tr3909ivZqAkdEivtw4fceswbv6Rc23Gm?=
 =?iso-8859-1?Q?eInBXioKci0iVWuvpVuWXbetZAHRbYUt0KJGNwkpNlLBGhVcXP9rbi6WOr?=
 =?iso-8859-1?Q?eigOvPV97K3MbdjH9Ynm0MflKLhAobTbrfnObVTUKy2kyDIF90XCEtXQ?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37301cd4-d3dd-4560-5450-08dd87015f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 09:36:51.9733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sUFfxN01wRnGOg5O6oAsfomYr42WljlBL79JNpkR6LcUaVbhmoSTi6vv+jqsW/Hqdc4ZIFkzz2RscTJ/+NVKBy1vgVtrc8w2d06LQCIxL3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1PPF4907A7FC2
X-Proofpoint-GUID: NL2Aqprw72_Mayh1Ul6j9OnQFIMUeFrI
X-Authority-Analysis: v=2.4 cv=doLbC0g4 c=1 sm=1 tr=0 ts=68109dbc cx=c_pps a=KQRipQceup3wOVCr+5RoVQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=Uwzcpa5oeQwA:10 a=pGLkceISAAAA:8 a=In8RU02eAAAA:8 a=VwQbUJbxAAAA:8 a=8Fn0_6ixZAHOCXHqxRcA:9 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-ORIG-GUID: soTecnAl-VVq1KOUvX3jnXHFlNjGpYad
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA3MSBTYWx0ZWRfX3NEncJhqnUjl ojUHsZr1HgqQP3hF3b1CWnTAGdDOqK6uCiB/uj/Bw557eqJR5JiryIKQ1edeoU1LoAmWqq3cWLJ BJCQnSWu+xjsDW4vkwlzs/4yY1fE9iN7AqisvTBQPFb83/u9ZUhbFTIboVnkVcFCb7VTXhkb0sr
 VVL8QkdvFxwDt6QwY9VXDvIn2lp2squAGVUDy7b8AFb1uKG5Y5f0+bDs3qD6ksup56VT9CUgnhG IQbsyCuh1qJ5Be7h3mT820yBBCXWY0dR4OYh828KzYoiAn0YzGlkTHng7bLd/TjZvwr4QK+fynZ sk+Q5LsfGQuOmW4WOBCXAafqP1EePcVv5DVAGsgSiXKvTZvG6DFMdou3urdxgm/jZF2LtLPpK8F
 MCBAC5C6KZlHPSLjY5AVsovVKJkoUBV4uTdp5ECB91ceqkL8wELDRkS7nZkKd/EeMjFaP51J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290071

Hello,=0A=
=0A=
I don't really see the point in this patch.=0A=
=0A=
We already have a common function inv_mpu_i2c_master_xfer() for handling ma=
ster I2C transfer, and there is no need to create a new external function i=
nv_mpu_aux_exec_xfer() that is never called outside the inv_mpu_aux.c file.=
=0A=
=0A=
If you want to factorize the I2C transfer status check, better add it to th=
e inv_mpu_i2c_master_xfer function. This way it would make sense. But you n=
eed to warn that only SLV0 slot has to be used for transfer if we are enfor=
cing SLV0 transfer check.=0A=
=0A=
In the actual implementation we're free to use the slave slot we want, sinc=
e all SLV(x) calls are done in the same function. It is easier to understan=
d like this, I think.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Isabella Caselli <bellacaselli20@gmail.com>=0A=
Sent:=A0Monday, April 28, 2025 15:25=0A=
To:=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; jic23@kernel=
.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.=
kernel.org <linux-iio@vger.kernel.org>=0A=
Cc:=A0rodrigo.michelassi@usp.br <rodrigo.michelassi@usp.br>; marcelo.schmit=
t1@gmail.com <marcelo.schmitt1@gmail.com>; Isabella Caselli <bellacaselli20=
@gmail.com>=0A=
Subject:=A0[PATCH] iio: imu: inv_mpu6050: refactor aux read/write to use sh=
ared xfer logic=0A=
=A0=0A=
This Message Is From an Untrusted Sender=0A=
You have not previously corresponded with this sender.=0A=
=A0=0A=
Extract common transfer logic from inv_mpu_aux_read() and=0A=
inv_mpu_aux_write() into a new helper function,=0A=
inv_mpu_aux_exec_xfer(), which performs the I2C transfer.=0A=
=0A=
This refactoring removes code duplication and improves maintainability.=0A=
No functional changes are intended.=0A=
=0A=
Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>=0A=
Co-developed-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>=0A=
Signed-off-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>=0A=
---=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c | 41 +++++++++++------------=0A=
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h |  2 ++=0A=
 2 files changed, 21 insertions(+), 22 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_aux.c=0A=
index 8a7f29119..de013e034 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c=0A=
@@ -117,7 +117,6 @@ int inv_mpu_aux_init(const struct inv_mpu6050_state *st=
)=0A=
 int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,=0A=
 		     uint8_t reg, uint8_t *val, size_t size)=0A=
 {=0A=
-	unsigned int status;=0A=
 	int ret;=0A=
 =0A=
 	if (size > 0x0F)=0A=
@@ -136,30 +135,13 @@ int inv_mpu_aux_read(const struct inv_mpu6050_state *=
st, uint8_t addr,=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
-	/* do i2c xfer */=0A=
-	ret =3D inv_mpu_i2c_master_xfer(st);=0A=
-	if (ret)=0A=
-		goto error_disable_i2c;=0A=
-=0A=
-	/* disable i2c slave */=0A=
-	ret =3D regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);=0A=
-	if (ret)=0A=
-		goto error_disable_i2c;=0A=
-=0A=
-	/* check i2c status */=0A=
-	ret =3D regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);=0A=
+	ret =3D inv_mpu_aux_exec_xfer(st);=0A=
 	if (ret)=0A=
 		return ret;=0A=
-	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK)=0A=
-		return -EIO;=0A=
 =0A=
 	/* read data in registers */=0A=
 	return regmap_bulk_read(st->map, INV_MPU6050_REG_EXT_SENS_DATA,=0A=
 				val, size);=0A=
-=0A=
-error_disable_i2c:=0A=
-	regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);=0A=
-	return ret;=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -174,7 +156,6 @@ int inv_mpu_aux_read(const struct inv_mpu6050_state *st=
, uint8_t addr,=0A=
 int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,=0A=
 		      uint8_t reg, uint8_t val)=0A=
 {=0A=
-	unsigned int status;=0A=
 	int ret;=0A=
 =0A=
 	/* setup i2c SLV0 control: i2c addr, register, value, enable + size */=0A=
@@ -192,6 +173,24 @@ int inv_mpu_aux_write(const struct inv_mpu6050_state *=
st, uint8_t addr,=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
+	ret =3D inv_mpu_aux_exec_xfer(st);=0A=
+	if (ret)=0A=
+	return ret;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/**=0A=
+ * inv_mpu_aux_exec_xfer() - executes i2c auxiliary transfer and checks st=
atus=0A=
+ * @st: driver internal state.=0A=
+ *=0A=
+ *  Returns 0 on success, a negative error code otherwise.=0A=
+ */=0A=
+int inv_mpu_aux_exec_xfer(const struct inv_mpu6050_state *st)=0A=
+{=0A=
+	int ret;=0A=
+	unsigned int status;=0A=
+=0A=
 	/* do i2c xfer */=0A=
 	ret =3D inv_mpu_i2c_master_xfer(st);=0A=
 	if (ret)=0A=
@@ -209,8 +208,6 @@ int inv_mpu_aux_write(const struct inv_mpu6050_state *s=
t, uint8_t addr,=0A=
 	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK)=0A=
 		return -EIO;=0A=
 =0A=
-	return 0;=0A=
-=0A=
 error_disable_i2c:=0A=
 	regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);=0A=
 	return ret;=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_aux.h=0A=
index b66997545..0353103aa 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h=0A=
@@ -16,4 +16,6 @@ int inv_mpu_aux_read(const struct inv_mpu6050_state *st, =
uint8_t addr,=0A=
 int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,=0A=
 		      uint8_t reg, uint8_t val);=0A=
 =0A=
+int inv_mpu_aux_exec_xfer(const struct inv_mpu6050_state *st);=0A=
+=0A=
 #endif		/* INV_MPU_AUX_H_ */=0A=
-- =0A=
2.43.0=0A=
=0A=

