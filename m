Return-Path: <linux-iio+bounces-17878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9933FA829C9
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 17:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E347E9A32A2
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3926FD9B;
	Wed,  9 Apr 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="MCIMNvj6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B9268FF6;
	Wed,  9 Apr 2025 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211067; cv=fail; b=VCJvcQ7/AkjBjtL4Nt5LYYjLHi59+jgNLT+CmIgreej8OgqbCtyhpwF0NgoV73Iy/6j0EAGFkBWhyfi8DOhx1gGH9ByBS6aXhiiU+S1Y60BsCRunCTS8tI4Ov08Kag1JonTJ2q4h+w+f+4wzl3iJ9qwltXouB9s+STIO3PXu974=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211067; c=relaxed/simple;
	bh=7PYQzk0L6Vwl8aKccLRretBOSB7t4BfK4noMPiQVoRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LYBOuOZG63MkJS7znzz32V9gCsHNvorjs9SfgNAw0LvKLk3uPOu7QVgx6r0ZxeWphjohxwzNqJVSO+J+tibvdQG0MBs0V+h241qmggkvSezMTXqo+6iP0KwllX5KVXgmhr1B2ZAoI1kiAM6JQtwTevt7W+CHwTxFr/GhOuCcvLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=MCIMNvj6; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539ATa1c006329;
	Wed, 9 Apr 2025 15:03:56 GMT
Received: from fr4p281cu032.outbound.protection.outlook.com (mail-germanywestcentralazlp17012050.outbound.protection.outlook.com [40.93.78.50])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 45twvmbkq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 15:03:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATExzrpkuk3DDvUmQbSUqlJVo4lFPQquj8gvICtCFWKA3RMHHXwJM/KryiUXXRyH+nsxGh9I7ezCFOPUGbTfzpwK/HDLiJOarZWrybs3SChjw/1gRJ/7iejtpM+IabWOPrmRuvBOqYci6BlmI8Qm8L52YoZGVL21yOcyQITelvLpIV1dYuKienW+tbH2R7W928zAioq889/4tx+zWphJ3F/Mit3PSRos89EovDvuf/eFaD6H685Dq7qvpNA7HcbYxxb0UnJrgDPFbPqPLW0equMVDyXhxcLTHoVfeOw+i70vwZFtpKo5sU+yWqOMLTWol9Hzh/uhr67aNctrjZQZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PYQzk0L6Vwl8aKccLRretBOSB7t4BfK4noMPiQVoRo=;
 b=JjngzXye4GrMtNziBbLI60dFLG6WJaP7iHh1Klm7uijoWV+Z6rMVe+a8qKAG5/87XOsPkk5ONPV39NuHzBNSFQo2FqFphtkkOfSNFL3a+P4nqR6v+BLtmemJR0H2WzBd8tZRBteusz7kih7ofLaz7FCN0vgiGqozBIEefjDLg+tSXgEGn8r4EcuOWuP7TKDLAwa3kECkpI4nbsmG3IEpz0yrXMU1GVIftnXrILpbQr5olZPaH+uRGZkcE/RdKksl4cFTre6tdm8SkMuNSdnWb9NqICPItwnakK4ZBNHRIzy2mqgDRON+O+bPRr4o0gnpUh3fBo/z4NOpWOvrvM8swQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PYQzk0L6Vwl8aKccLRretBOSB7t4BfK4noMPiQVoRo=;
 b=MCIMNvj6P+Z6iTw5XNRa2y3ZDH14cXZIfq7GoLc5bTnrQ1Z/KW/Zflqr5uBCwJRnaJlSclO7Wp2doMKVriYek1ml7UtHcseLp6YxCtQ5si8vwjpeUfiunBhr9cOn7P+oXbwGPdXWYRJkilHVD1eYTt5qXhMHyAWcVnamKHRNnJ268QBbfBWYqlopd99NlppvYY58ZORKFyenSGxANKQCUdla6DK51TaTNUnIBpZyKPjwfJBbW1hlsiE3yjalhJ2WCnY80TAWZ24Pkjlb/LxGJ3cGdxVfxEGOupHAWOy36dbx2c4B89464X/GkQ43sfFN/pbtBFzIe/nA/jgvndqcRg==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR2P281MB3135.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:66::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 15:03:40 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 15:03:36 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: icm42600: add interrupt
 naming support
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: imu: icm42600: add interrupt
 naming support
Thread-Index: AQHbp/dQdwg1kp2+qESMRwhOdbScprOZ9UuAgAF7BWs=
Date: Wed, 9 Apr 2025 15:03:35 +0000
Message-ID:
 <FR3P281MB17579A390A57E867139B119DCEB42@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References:
 <20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-0-c278acf587b2@tdk.com>
 <20250407-iio-imu-inv-icm42600-rework-interrupt-using-names-v2-1-c278acf587b2@tdk.com>
 <20250408-dandy-rental-c76bcb4a5788@spud>
In-Reply-To: <20250408-dandy-rental-c76bcb4a5788@spud>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR2P281MB3135:EE_
x-ms-office365-filtering-correlation-id: 7fa4e357-f4e5-4d93-a1b5-08dd7777b388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QetWOn+4dHGGIJrTgvinMqLt56CL+ynNdpiFNPj8yOpRINP/zFHLFv0mKH?=
 =?iso-8859-1?Q?YMtLonn4KKM1WlMX31gdaFoEjDvkg49nbe6jdZ56gbcb/7DR+3utAA0k+1?=
 =?iso-8859-1?Q?BVzxF2hjAL7mMoFVmCio5nZobdz3UOFgTe/uJskYcDom9Qz+JMenn00Hs4?=
 =?iso-8859-1?Q?sQIAB5JLK36/jVOXRHFx74jEvzUpbu7uOndOZZlXGzUFbVxYV+ksHZ85Bg?=
 =?iso-8859-1?Q?1N7HogA8Rl/Im1w0eMW1FFhhfKQJGrMEukaaRqGmetm6cTOOhhekWyYpmu?=
 =?iso-8859-1?Q?6VOZ+5u8QxvOjlPY+ul8PfewRAm9rYLEPTsBIwNu6BVU+xmT0JgXvO3r8A?=
 =?iso-8859-1?Q?u2EwQ394wiUnF9yYHwpG1WSSyC14JvrqcZmSZHMiL1CCarDwNFKp/NJ/oG?=
 =?iso-8859-1?Q?Ks6Qp107lIDztZ8vv/4L7u4uxByNRNyK6h5DKtTojp4qT6+eaNeF87UuQT?=
 =?iso-8859-1?Q?xak+jecVkIf72ZvqZ+KWlaj/YNgG4cPgCq9doD90qYssImZAbhmTkzrt2+?=
 =?iso-8859-1?Q?Jn5kEl9rdeWuy1aYuF3ZKK8UVrL29M89zfN7gtsmJ4fPNrG65u43eAsVVy?=
 =?iso-8859-1?Q?hCg3itTqfX8s95NTH7Iq5JaiTlHXzBKSUdqgGW8ZFBYOGzxhh6gB54KwxO?=
 =?iso-8859-1?Q?UQblpHnfnBySYj3DSRN/+QATChWVzfxsgdtNXqEWnuH1t+oz2Wzy5Ki2Rk?=
 =?iso-8859-1?Q?ogu5x2IemK3djayiamd8Yb7o5pAdly8+sEXNUjyDoXI2zzjdElzDIg+gvg?=
 =?iso-8859-1?Q?1M3NX4Dw+aEA8gGOgNZ/8N1rMLwWsryR0GS1xC3v99gU7nj7NX+Ui+MWFr?=
 =?iso-8859-1?Q?5/Xhz20QGrbcVr7d4IL//hT3hv78zhCA1qCIhuTkgG7X0l84FSw5wjdx/w?=
 =?iso-8859-1?Q?Zhv3xqeHsk8wcgmWOkBpi2cZM15NbAMnA2NXX/zgygpq+WXOo5GRBel1Fo?=
 =?iso-8859-1?Q?ZVgxtreFvVb/FKibZrK9QdkIVxzP+81KDZaklZ/+an/DkMqiKy1rhP/ALj?=
 =?iso-8859-1?Q?hrghK2oQveFYZ7looHHGYWdpWcFZ4c6Rl0N3FIqKEIcQyL9GKQwePwUDTp?=
 =?iso-8859-1?Q?ZvQej2ndn0f+mXmdrtlb17kBYBYRPKIdGW1TA7CjYbyDOJF5rhduflF0dp?=
 =?iso-8859-1?Q?UXjYQaAve1heMzhYZm68UfM/bVpYjGFA+fLkOiwzTx/h587Aax+vb3Ot98?=
 =?iso-8859-1?Q?1ClqTLfT2oQirse9v56ZJOUx3O6SbvnHUKxEb9WcQvAvdyWL4qDvIxRyWD?=
 =?iso-8859-1?Q?kGZmREHt3ua2G0Fd5WX+V4EXN0UJZMybfZ3dwVXhXZpTty1Mac1qhdxCfu?=
 =?iso-8859-1?Q?6qtCRPcMY3odiHPyLw9CgGeLuvO2bFF2/ZmfwZSUy6StYp6sDed4ZqTzlR?=
 =?iso-8859-1?Q?oNkn6fwKSu1uSXqt/yxREr+yob0XcGRL4JO1jBhl30angQA2Ft16b9zsf6?=
 =?iso-8859-1?Q?cDsr0Y1NyKbxVXHOkpc3kvQa+W5qCJsed2aI6V9Yve8puzCVTBGBoUK2cl?=
 =?iso-8859-1?Q?/PzR3lQCtwDFQLBDuPhyiwm3CFOXifalJBkgw18Fqmnc9ua9YoIBoFjlmz?=
 =?iso-8859-1?Q?woUo9e4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GyLdinS4r77+qTv6Swwk6p0iMatwhR7rMgHYS/4ysLbDjnTxanvIGpTLkK?=
 =?iso-8859-1?Q?nOlOgn/UusfhHB/O2tZcQpsqxfS2O/uw/9/ztcLo+JyX9pOwBquhE0kuWW?=
 =?iso-8859-1?Q?arUlUg+/R4vwkgkojGxQ7pGSOB1xmnkLcGGjWildgy9EPcC3mSqH/8un34?=
 =?iso-8859-1?Q?YBzMPuJwO46Fqnv/Ars0p0T3DCF1R+/SqamAyRjTICA2La6+uPL7p/fiVt?=
 =?iso-8859-1?Q?wa4zeiJfXNxG+IfBtVvJxwbSp6lfoP9ilb0U/rPh1RlKEF5wLO4FpMiQuH?=
 =?iso-8859-1?Q?8j4fsAoem0e/iVIGcRoU3/zHvTvFn59nLa2Ybkz6ysfQ2i33+QV8g0Jupm?=
 =?iso-8859-1?Q?E8wxlPc1kL864PdILVTHm9H10jVYaYvuSocLgMeZ5Xb046yg85DxLqWRZQ?=
 =?iso-8859-1?Q?C67MxKgiWi7KZC7nx1Nz/EaPAiNdi1nOqYu8NzdTnjotMsLd8tvdnkGqEW?=
 =?iso-8859-1?Q?Kq2XzdyBbNTbcz1w/XFEW8OcGAlKfeehcWkGLxwhaV8hTnDZW1Nbd1uXjv?=
 =?iso-8859-1?Q?A+l+JhFtZ7QPD9Y9NFZCOxEbea1sjr/dpFXTyzRfM9hw9AjOWo38082UPX?=
 =?iso-8859-1?Q?9d8HyZjGTK68QoOXfFndEZe6UQ3vrISINcTBBlWkLFqPE0zvxceM4lwTQB?=
 =?iso-8859-1?Q?4t/8ri4qxVOME2gH10XoMXJ6/T2LmSFe60PPVM/iVumptYCjZkiQcedp2D?=
 =?iso-8859-1?Q?1C4BfsDzGrbsaK/R7mn7PHkiOBb0/o4m6B/ngM36n9UqoRjB91nb4b2FuK?=
 =?iso-8859-1?Q?3kuhp48Y+mZrMPZOMm7BQQXPa60IiDYciNOZ10+MPaT6FAhYbD1AUODdFz?=
 =?iso-8859-1?Q?AV/DS9efWDJMkDO+lzJZLGZadTyrejjvMLSA2Czgf+eQmobOMfr1At5eno?=
 =?iso-8859-1?Q?1S2erasBN9K8cwmswV65T/irJzkCA9c+ByRr77ONXuclDamy//SMZ8nMOl?=
 =?iso-8859-1?Q?+I4aBIwJCrQEW+JMaRBHlS8F1ZubIQzavHzdelmmz2RUJdtPqoC3FSmGiq?=
 =?iso-8859-1?Q?/sQLmpTOFUIkbdyKVqDAFHSOlvAg2f54bkYDJtwNiIKUWXjRMtMweRgx+b?=
 =?iso-8859-1?Q?ZwUGn7qYN/EovlkY46uHbYn+cEQeDXGBHVnLBx/Gdthp2SNKG55Dlhlws8?=
 =?iso-8859-1?Q?+AckOfyYgGrWsct5vmpLwlwxPc6gM+DWoljiI1lFPnwu3uvfxxhwHzKYo4?=
 =?iso-8859-1?Q?0PJSoYKycIqq0L0ebQYbJlUWEBKfAFdwFXTePTOModoPCP1l9FAWIZGx4u?=
 =?iso-8859-1?Q?NMCZ+TaAz6lPVpCJ6xDJ7aBdaOSh8bOs2iNGVKtGrad10KgN0q+K/SZqNl?=
 =?iso-8859-1?Q?WaODw2J0bzHtmjrCL4BtRbFOj+pcFsAiUU5CWgf80pEakC4KTFY3k9N38j?=
 =?iso-8859-1?Q?de0lba7LA0wmAohqntdCJ+ZCfbv0IgcyCTwGi3j63gOV3D+21Mg8X8LPGx?=
 =?iso-8859-1?Q?ZaNpzMlljwpm2CPlTYy4RzobY9JksWs+1vnJ/btOHNInC8NNEg7yPWmyHR?=
 =?iso-8859-1?Q?l68kZ7RKitBKLd9HU6dreTgj1WLlzvMUgSabExE9UxdT306D2e2S79w19I?=
 =?iso-8859-1?Q?4fwaWiRMLJgyxnd71yIFVlu5sV5gWo2+rhRHI4MBvPaXtvN5PvqPtVN7Iz?=
 =?iso-8859-1?Q?7t6JOQDxO432roNfYeDq7ooOm19OmCvsGQqx2xxKSSEj83zEnU9AfYr514?=
 =?iso-8859-1?Q?KjNGYSGmha0AxJrfT6n45vs/50nz3FmTa3VAvLRjmT15xq4/ZT+/QcsbnR?=
 =?iso-8859-1?Q?BhaA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa4e357-f4e5-4d93-a1b5-08dd7777b388
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 15:03:35.2826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icmmbir7pTwzB1cErK3KYWKqamqo33uFDHa7BXWJ8HNAg69D0sL6jOa4BFMsIP5vTxiLYTmDUOp/EOtHkBP/njxB1qI/RaeoBLQpeFfWVCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB3135
X-Authority-Analysis: v=2.4 cv=eOsTjGp1 c=1 sm=1 tr=0 ts=67f68c5b cx=c_pps a=KQRipQceup3wOVCr+5RoVQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=Uwzcpa5oeQwA:10 a=VwQbUJbxAAAA:8 a=In8RU02eAAAA:8 a=cwzXS38RDoAiYJ8WnfQA:9 a=wPNLvfGTeEIA:10 a=EFfWL0t1EGez1ldKSZgj:22
X-Proofpoint-GUID: 7CFYRlZinRHj98D-c30dLqVik1MPpdYz
X-Proofpoint-ORIG-GUID: 7CFYRlZinRHj98D-c30dLqVik1MPpdYz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 phishscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090095

Hello Conor,=0A=
=0A=
the chips have 2 interrupts pins and it is possible to configure each event=
 (data ready, FIFO watermark, ...) to trigger the interrupt pin we want. Bu=
t the driver is supporting only INT1 interrupt pin.=0A=
=0A=
I will modify the binding to report the 2 interrupts with the 2 names and d=
elete the description that was really needed only for the driver limitation=
.=0A=
=0A=
Thanks for your feedback,=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=A0Conor Dooley=0A=
Sent:=A0Tuesday, April 08, 2025 18:23=0A=
To:=A0Jean-Baptiste Maneyrol=0A=
Cc:=A0Jonathan Cameron; Lars-Peter Clausen; Rob Herring; Krzysztof Kozlowsk=
i; Conor Dooley; linux-iio@vger.kernel.org; devicetree@vger.kernel.org; lin=
ux-kernel@vger.kernel.org=0A=
Subject:=A0Re: [PATCH v2 1/2] dt-bindings: iio: imu: icm42600: add interrup=
t naming support=0A=
=0A=
=0A=
On Mon, Apr 07, 2025 at 09:57:16PM +0200, Jean-Baptiste Maneyrol via B4 Rel=
ay wrote:=0A=
=0A=
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
>=0A=
=0A=
> Add interrupt-names field for specifying interrupt used. Only INT1=0A=
=0A=
> is supported by the driver currently.=0A=
=0A=
>=0A=
=0A=
> Add minItems 1 for interrupts since interrupt is mandatory for the driver=
.=0A=
=0A=
>=0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
> ---=0A=
=0A=
>=A0 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml=A0=A0=A0 | 13=
 +++++++++++++=0A=
=0A=
>=A0 1 file changed, 13 insertions(+)=0A=
=0A=
>=0A=
=0A=
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm4260=
0.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml=
=0A=
=0A=
> index 7e4492bbd0278a336587dc5ac04da7153453da29..707f2169ce9a3ca41d81560be=
d15786fe010109e 100644=0A=
=0A=
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml=
=0A=
=0A=
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml=
=0A=
=0A=
> @@ -41,6 +41,17 @@ properties:=0A=
=0A=
>=A0=A0=A0 interrupts:=0A=
=0A=
>=A0=A0=A0=A0=A0 maxItems: 1=0A=
=0A=
>=A0=0A=
=0A=
> +=A0 interrupt-names:=0A=
=0A=
> +=A0=A0=A0 minItems: 1=0A=
=0A=
> +=A0=A0=A0 maxItems: 1=0A=
=0A=
> +=A0=A0=A0 items:=0A=
=0A=
> +=A0=A0=A0=A0=A0 enum:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0 - INT1=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0 - INT2=0A=
=0A=
=0A=
=0A=
I might be misremembering from looking up the datasheet, but it gave the=0A=
=0A=
impression that either all interrupts can be wired to int1 or int1 and=0A=
=0A=
int2 are usable. How come maxItems is set to one here, not two? Surely=0A=
=0A=
someone could wire them both up, even if the driver only ever uses the=0A=
=0A=
former.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0 description: |=0A=
=0A=
> +=A0=A0=A0=A0=A0 choose chip interrupt pin to be used as interrupt input,=
 beware that the=0A=
=0A=
> +=A0=A0=A0=A0=A0 only support interrupt pin is INT1 for the moment.=0A=
=0A=
=0A=
=0A=
What linux supports should not be part of the hardware description.=0A=
=0A=
=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0 drive-open-drain:=0A=
=0A=
>=A0=A0=A0=A0=A0 type: boolean=0A=
=0A=
>=A0=0A=
=0A=
> @@ -76,6 +87,7 @@ examples:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D <0x68>;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupt-parent =3D <&gpio2>;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupts =3D <7 IRQ_TYPE_EDGE_FA=
LLING>;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupt-names =3D "INT1";=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vdd-supply =3D <&vdd>;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vddio-supply =3D <&vddio>;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
=0A=
> @@ -95,6 +107,7 @@ examples:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spi-cpol;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupt-parent =3D <&gpio1>;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupts =3D <2 IRQ_TYPE_EDGE_FA=
LLING>;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupt-names =3D "INT1";=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vdd-supply =3D <&vdd>;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vddio-supply =3D <&vddio>;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0 };=0A=
=0A=
>=0A=
=0A=
> --=0A=
=0A=
> 2.49.0=0A=
=0A=
>=0A=
=0A=
>=0A=
=0A=

