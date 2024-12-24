Return-Path: <linux-iio+bounces-13787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1A09FC12C
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CB3164323
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719E1FF7AC;
	Tue, 24 Dec 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="MiJrjIyW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507591BC9FF
	for <linux-iio@vger.kernel.org>; Tue, 24 Dec 2024 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735063827; cv=fail; b=OXd212en5azaWeSxm1GiUWCeYUOC23f/CPusY6JNhozBeMkPE+dU3Zm4qYz1HgqJU0/Kynt3496tVeVNAovWm1UpsqzEtkL1VDXcFglbzylrRBRtaFzLbpVXxPEGXLEllHggWM5k4M5IibGUSZ3qdx0hGjKZOB1VrQyFKMPNdRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735063827; c=relaxed/simple;
	bh=jq8+gr8ea8RGh88FXhwj7NJ3m2x62Mtg/ztobt/IWtI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EafQRmBUMaZL5HDrzQJgmXsUgoJNEpIxQQZ0IIbKFY/Uw48zEgax/uIL0vv6cYmouSwQfX38CgN9fDOtHINe47pN7AgqZhtg8JjsRmj06Rg+v4FUNIuzSRh1FzECtJGBECPsBVJLzFFE4NrQEMaFukzFdtvR0jCUCwybqsDNRpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=MiJrjIyW; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOGj2w6001452;
	Tue, 24 Dec 2024 16:57:43 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazlp17010005.outbound.protection.outlook.com [40.93.77.5])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 43nm1ya6m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 16:57:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPcGdWfH/LjuL/6jKCGA/OyiVY2KYB5TgXj9a+mPMW43mBAQFv64w4AVTg82hUP96aYQysCGtIKaXKk082mO3Szqz+2blL9GrsqDaA5bRzqEkg4LmNRTWkk7MmwI9S32MltoVrlwPCU3fzcG3ERTm44swoiOVOx1SdIF7kFa23HOBrzCJ9ncAgkieHEL3TfCoBACnRfEPINkSCqdVjs+iCxX79BGNnWitu9/i+QBg+WJZn0xAcuUYA6EWq1TllI+V/KzCNrvCJ60wiZaXWmFmKWBmKF6MzU4i+h7my9WIuYVF5ibvPLXyHm/H7p7FI2DUFERtJTpVggiIZ3bdxR/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq8+gr8ea8RGh88FXhwj7NJ3m2x62Mtg/ztobt/IWtI=;
 b=wOm7Hslxi5X6qyshiTsBGEJMT0RdYUjsQJhfppKKvhI1LPVy/fGPzYMA7pYvmxBhv1EUTcwQb3pKEFRewEc4mc7PWC6KnTvK0s9rb2l8Hhki2pl/1S6Q4YEbe3nslyRpod9PZ56Ni0E/E+RYDvPiUNfFfpad76EANtZUJLdo8j0PYWj3Y+IxGIQNJpIyolYRxz/4ZuPX86QyyhJN/p0QQKA/aWlijk4rqWeLkaTDBXjzEOR/EOsTfk42Vi4tayDiir7FTllvvrig2WL3OQTt9EQiZ9jd1m1EGIUNQt8lgtZagRA68PNy/ZyTAHtNXy+ZaeyxRyFULlT7qTXT+BzmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq8+gr8ea8RGh88FXhwj7NJ3m2x62Mtg/ztobt/IWtI=;
 b=MiJrjIyWyYmqLphvnDXXOnlrWuBTK0gqUMKHRSrwJPzY3HgXisZ6njBHfzRYPHEPO6e70Z0z/615eqmC9/njyDVEr7a9C0+zUTGCraOkn4oLr2LP4tdwdymLi7v6fRztw26kRHXOs6zXNZLNI5R5/++937r8IDRiH6YHwp49m4ZYmb/J0RJB4Afm+aO3XWvKT3V10DrSJjys3EC9dFeouAmtHdxjnV6b9n0PelLPPOkozg8aMt3YWMMNPOXVrnsvcBT8ksuRiRtvGHkn6ikebBXf5pYxeiwmewXckCnc2tCGL/X0EJSCYQE581aIUJGjHYtFGdQgYawihoEPyfzd+Q==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FR4P281MB4807.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.22; Tue, 24 Dec
 2024 16:57:34 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%7]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 16:57:33 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Merge of fixes-togreg inside testing?
Thread-Topic: Merge of fixes-togreg inside testing?
Thread-Index: AQHbViQWlQ3i43FRPESH/gx6YirM1Q==
Date: Tue, 24 Dec 2024 16:57:33 +0000
Message-ID:
 <FR3P281MB1757F070DE7F29786C13412ECE032@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FR4P281MB4807:EE_
x-ms-office365-filtering-correlation-id: 39ac32f1-679e-458e-16a1-08dd243c0fc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4YBlhp5cHDTJurga/8JlFPLuq3FdKLRcqjA6m3g71nyeosD0W3UF7cajuP?=
 =?iso-8859-1?Q?hvVQGOs2iTVq+uLCF7uT5oCWADt0hCtLf+qlUq6Ug5vp8rCoz0xuWFEVLk?=
 =?iso-8859-1?Q?TMCC36/yxqFWQ6Q7Qn0P7/gDc9isqbBgiKQv906T7rhOtxVkZMxZgdOPLt?=
 =?iso-8859-1?Q?Del4xteZ7lerlQxjbjvHg8qliV4CGrL50n1UxYHo4Q7IakfVYoXueo1G49?=
 =?iso-8859-1?Q?TkI24YMhQl5lcg5xnzo6sDSunbAhWHcSF0tz6++2XXM90/Z+3Lcc1NAVwB?=
 =?iso-8859-1?Q?Hr1Ychb6z+j5QrE5Hd+XB3jZceqUVSxIWb7imhgyphFB3QMFt2WhIP0+o8?=
 =?iso-8859-1?Q?mWNa6in/IdukDS1l39Q5IUfBy7BqcGanouJarWuYVA4h+CAbDbQ5vf5ntY?=
 =?iso-8859-1?Q?pZw/llMgCs7Mc2xJW2VbGnXqZaRulh57JBfIVuLfIJULq6R8h1DxNMWohe?=
 =?iso-8859-1?Q?u0ZYTEMuruS7YnrYM83GVmJPWWjPaR1LESJHs10UogGuLYCQeMgvXWpSEH?=
 =?iso-8859-1?Q?7orBVy36nVq1eLdG3Aqfrn13GdTKKPS3gViyQTTvZ3hH5iuicWf4ihjhXG?=
 =?iso-8859-1?Q?swi8hfibfucQVuxxV97rVm3Gjr1O6EZcX5pxeJ1UL5VE7h8R403NUOOHD1?=
 =?iso-8859-1?Q?BhIRvdALAWag3fy6nztWZ5SevtgdR27ZlJUMuizlQ3+KCocz4L9Pg4liXI?=
 =?iso-8859-1?Q?w0obRBjw0PIDWOinW5tmenZZw8RXee+eS/mxbJ3r4/d4dNxEIDa44xed3L?=
 =?iso-8859-1?Q?+87AhAktxaD1kzW3yNsN9yv5ZboeFpjl1AUFgtaodRNZLDnV0YckxxR52B?=
 =?iso-8859-1?Q?PNJoLZ8lmBBL6w5wovj+9WAB55ArADitX3x31ufPM25Y37UC9tdyPkMakJ?=
 =?iso-8859-1?Q?h0MCKBKtlBoSSU/a8EfzdIBtv44kdPxa+9syyinRi2Og0zWLi+pEkZQSxz?=
 =?iso-8859-1?Q?S2yduDsTw1aZb/kDmqVhc0NPpO3oL0JigBhUZqEGGdj/2HnkfA97BxBZEh?=
 =?iso-8859-1?Q?dseRlP0cc/0WCbwFEDjzLSjcJcrF0g1AuWbkzJ6Vg/8huI/FHVORNhA0mj?=
 =?iso-8859-1?Q?glGpiSsknnR+IscoPDksoRGAEeNUlNJn0eBQRRsJQ10lce9Na8bVzunOI5?=
 =?iso-8859-1?Q?IWdn6W1b5On8VuFOjHlWhvZ+Qd0DiIatWNiRVrAMVq1w+e1yW8ZVlE3YSW?=
 =?iso-8859-1?Q?n+VDg9sIFv6Zpzgwf+Tyr7FFIOqQtfDzYNX7tBKsnxGSLctHh/KSKG2I8Z?=
 =?iso-8859-1?Q?QG0MmEfvZemnWOrxwu0IxVpyPWIEQuTh53IXJsa8OyF6+nA1dNiLfpbxpD?=
 =?iso-8859-1?Q?UeX3gwhj8b8SP8jRzfGEzhoHesWvo6zzLFh+RlzJDBKffDhn3v9eIjSZfB?=
 =?iso-8859-1?Q?sIqxqbn5gBxHD1yUxr62+Kd47B3H/HX4ydDZpJmM7DZ89a9M/i3lIjZHDi?=
 =?iso-8859-1?Q?iq/EeXQ5HBA5CaWUIljwT7/aVQYmYcXzaNbzogcxYXiN/mCZUASjY+GdaJ?=
 =?iso-8859-1?Q?Q5/0aR7eo6WohDhrQM3d+h?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xpBOLegci5AcXC88nOKtkTTbaoK72dQ9g6YILvb7z6PEHNns9hMoh6wBq/?=
 =?iso-8859-1?Q?hr/pZUFfQ66BTqvyTFnF1OwdE86xC0wdsN3bcpKj3GiY53Eg8mLfV8hqB8?=
 =?iso-8859-1?Q?xu9KmvyDaVgOw4AdXuWFCBJbfMDIy5JdT8SMRHNEqDenNWZOAOJ4eT3Q+R?=
 =?iso-8859-1?Q?8w5vDiZ7iY+1erNzurTbgU/7XOdDGWJPw9dmSBiV63kYHWXO7yf5+1eGG3?=
 =?iso-8859-1?Q?AoyfeOKJP/yRCk19cIysp7o3n+wFVGYi4dhTLkjzyj8+3JTQZmmO4xDtmN?=
 =?iso-8859-1?Q?+wQSQbUXm+wCRpCGpiIcgpt7CdmbaPhmUaL3u3MAl2Q5QiolVveCRuW97m?=
 =?iso-8859-1?Q?JkuH3+W7FvwlFSBrYBxUF9tYjHvdmW4rqYDswpcGPhMMbjR/1WEj3aHTeU?=
 =?iso-8859-1?Q?wMYNx3zQryKBM4aFBhb9E5uPBnorjJ0mGRNBXzwBbBZnmU3aSwoHAw9PC4?=
 =?iso-8859-1?Q?+ib6GlySGHgpZAbZRY9jAkY60PjdkzxFz1Nps9m9/ae4fx25LtrYf0Mh4v?=
 =?iso-8859-1?Q?oRKfhBDRXEV31EF93m7lAvdK3ibO7xdIeu4CmO0vGLpO/VTbn1mGc+CI/8?=
 =?iso-8859-1?Q?s5gnHJgYnywXqMpLNzmsEmvVFlaYkcguzHzBh5yJJHn4N36FN9/m+enWIW?=
 =?iso-8859-1?Q?HR3fU7GwrWdHrHTxz/N3PdrqQiV5kqPZqJLgN7/GDjlniQS1yLXLQk3GDm?=
 =?iso-8859-1?Q?Dkk27WbzrOqlt7Rclkp20g0ZDbaUwgAqVUFQtwAO/I8kjCIgrgY7KcT+Kf?=
 =?iso-8859-1?Q?5VK37UphHPFfLvPIeG0CxLZ3gbK71KAeF9aRefoFpoj6Qzsf6pygeimKO+?=
 =?iso-8859-1?Q?A+j1IXlxbvN0h4HjPZrvKa+v2ObtZQlwX98TnmnS7vQlu+tcnA7JlaXIzP?=
 =?iso-8859-1?Q?ZS4E33dR5IQoPD45QhW0+Fs6vMg9Xz+WP1U4AsqxkP9q7O+rMm+30YzCkt?=
 =?iso-8859-1?Q?NzVMjBOoAR+j1ilFfk0JUOuHxOiS4e5pLVf54XBWKXX/J4U89mWZjDCTVA?=
 =?iso-8859-1?Q?t+tW7nnxH21nsAQ8aeJuZkBt31kow0OlFmL8krMR7nwX3x9HkWV7OJipJK?=
 =?iso-8859-1?Q?O0g7oQx1SxOIfsbeUp49AMWsmJzWA/cNqCJl6m+1XkzuEoeWlvJH6gnv+U?=
 =?iso-8859-1?Q?7bJITtwwHUpCVk4sbeo7pXoH9w3H1NS8Q4Kp7EPuAe0SRo1RniAZKrZwim?=
 =?iso-8859-1?Q?xIIPacHhGIrkk/SIEUrF5+N4sTov292pAOsYHrCDY+5dak0rnTkrShRQ9p?=
 =?iso-8859-1?Q?x4Hw0GO5fI/xZ+6F3G2vBwVBrhHw/Lvr5WTKKNCRMNMki2pxzB/B5sFltr?=
 =?iso-8859-1?Q?a4O7ptUR6AlgF95NSKSJXhe+N10R51MHzaKlzfGizqK1wfxFpmOSNkxymn?=
 =?iso-8859-1?Q?1O/IoIlqZBR1bc0pttVxyK9PoRXPZBz3BVdytLp8rn/qpK16i7zllxOqcV?=
 =?iso-8859-1?Q?mn5rU15yixT88DIK5nQia/QTwslBeUnCAEGxVrsT8YsCA4jEFcl7k/trrB?=
 =?iso-8859-1?Q?uaF9Ytf+0pKTWegD5tdGVOVAKHjH2TRw++YVhK8HtfgDOyDEzo31YeaGRZ?=
 =?iso-8859-1?Q?EXxOajXA2gPg95qZQby9ShxIdSeLuqrATtgXbr0DPdckq6sq6JF9kulcMf?=
 =?iso-8859-1?Q?SGDU1PwG7ei3UTfHMne6mcAeBHsSXeVLPCDQ9kI2oQ+9mbfA7zmxnTV/sJ?=
 =?iso-8859-1?Q?EWsUsVOaOQHc/1G5+NUaIyvtob1PYGJv/gvekILONSatJrQvD3tkgTjx0C?=
 =?iso-8859-1?Q?zISQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ac32f1-679e-458e-16a1-08dd243c0fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 16:57:33.7393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28tV+Yy/FA2gekKpElXRNX7tg9k15fy7SIx/A8Fi1JNM7SWlPuANgon+IF8eTXwWkOqQWTWm23L9DO0c/HPEmWx1R0NxdXtvhXsCo9rI8Y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4807
X-Proofpoint-GUID: co6Aoz_1EMWHbehiY4OpbCMtZRmThMfh
X-Proofpoint-ORIG-GUID: co6Aoz_1EMWHbehiY4OpbCMtZRmThMfh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=410
 adultscore=0 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240147

Hello Jonathan,=0A=
=0A=
I currently have 2 patches inside fixes-togreg branch for driver inv_icm426=
00 that have not been merged inside testing branch (c0f866de4ce4 and 65a60a=
590142). I've been waiting for them to be merged to send a new feature patc=
h that is based on them.=0A=
=0A=
Can you tell me when you plan to merge these fixes inside testing branch?=
=0A=
=0A=
Thanks a lot,=0A=
JB=

