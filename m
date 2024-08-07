Return-Path: <linux-iio+bounces-8312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEF094AE34
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 18:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFF3284574
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 16:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556C313342F;
	Wed,  7 Aug 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="eF8gZr2U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3E2209B
	for <linux-iio@vger.kernel.org>; Wed,  7 Aug 2024 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048382; cv=fail; b=a3lbwzRgzFVX+4GogI4H2YIOLGKbICJqslhqjkaHujAhhJgJ3ri+NZxVepbDSsx03kAMJSC1SpugGWbBXw3PAgqmqqjTpJvK+PVOBZ+/VIRfOzOKmkj5DjBM+dk9JCxSXSkXQvd5QaUFse28a/5aQPR35zldpqyg6VL/U1o7iy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048382; c=relaxed/simple;
	bh=3DKiWKfhs8N1c9UaipqkVKkEQd1HlRYHJBY7/v4+EUc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uXg3BEYZRFJcpYi+Poijm7O1iY3FvxoMIxoKxIFlV9bBUHKxW8QlYDzOVQNIJbB5hWDafdgTWbpHPCzkO4eGAWjk9wUtNCCzpr6FjOQmsHZ0iTRvDfBnlJNdAOOCkgpBTN71GBkWpr6KpgAeIR6pjyNdrqDgUwiTPx67mSZrMlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=eF8gZr2U; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477FlhSn007488;
	Wed, 7 Aug 2024 15:48:30 GMT
Received: from fr5p281cu006.outbound.protection.outlook.com (mail-germanywestcentralazlp17012052.outbound.protection.outlook.com [40.93.78.52])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 40sax036c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:48:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNvmZ3WokOkk1HsdA0i/BGN2UzsR7NpT37sWCBbMI17hqC3Dh+QRMzBf2o7C66uZmhdgMqDOZG5ZoV+AE+qbfMlqdNfJC+Bh2OczfYcDDNgQYVnVMvz4o6PErRdgsBbcci4jthtPaMfqH/UUuiv6j4VgZ+TzMHvTrrK9rTFfJAKhjk2KO5t7EB0vBKHfKb0NbFDfG8JveeHAftShNCWqSyzvEszd2CXeI0amwsDloQYklkURNN0zIAdAvEU+p/E7yj56fvQH5HsNK1k8b/Y5bY40ZydHnTii+4nIRHhUY0TV4fyOk2CH4o8QgAqn0DdiHD0HKQrxM5KEQj6gOMF/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoJ+Z97nFDM+lWZXkR+xfHa1LgqUP5f+fvEaR5lVhKY=;
 b=DGqIIxLWG1qNGtoWz2EnEhXz7bhqg3a3to+boq7dKOHZ0U6motCExFF0sjhsxxZshy0MmEdfWGgrNCHVOHGAD+kaqA0AHoik2eTNVPYXQC4ihFVjSWNyed+rmjCBsGPMTT1xmVHK6+9jFMcsB9N8Cz5dtmDD33ial7wsZEMqBloqTErHAqeyc60gcELHZY7XvNzOgMuNqD+1ujWnJp8DJLE2EUP9JragPy0ne1fxYFPKLwDL527M3zI7xxkQnZTR89qBylxd/tPysTSkY6rIz9CmIR88R/y5iOfLs/K8DiDdnZlvl6szNApwHhLIMuRpo9AmgwME/oWkD5JdZ8Pvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoJ+Z97nFDM+lWZXkR+xfHa1LgqUP5f+fvEaR5lVhKY=;
 b=eF8gZr2Ui1gZbgE5J89MQpPNIU5eqLwS0z+FKeElS4hhNXS3PeNdYwBg6y/XJfxcd57ZHWPuqaVB34752z0zXscxwug7tF0Cy9/xdzHxCnYmCNLnRyPH7UaZvPALc1dZR4kNhADEs3QWA040BAxRq0BirlOAuxNh1Kqd4uyg59W141xmbuvXztDYYqzxHyOlX0+hw8dGWAAL54c9zsZOhXIvAXbGpmUmqdjIr7ArRdYRo1omQf4RgBPUax+lTJb2ZQ4myhJPH2agU1VeKo/I/B/XGceILc8LyNORhqslQ7TYAyIw+eL559BBlTtNFWMacweSM+E8Zn0nslI4L5tyIw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by FRYP281MB3260.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:75::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 15:48:12 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::53a6:70d:823f:e9ac%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 15:48:12 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
CC: INV Git Commit <INV.git-commit@tdk.com>,
        "lars@metafoo.de"
	<lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt handler
 for WoM events
Thread-Topic: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt handler
 for WoM events
Thread-Index: AQHac84PFGCG8mpPHkOuICLaLqjgAbIEzAWAgBaOrACAAX1Csg==
Date: Wed, 7 Aug 2024 15:48:12 +0000
Message-ID:
 <FR3P281MB175788FAFA8CEB3DDF1D9AC0CEB82@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240311160557.437337-1-inv.git-commit@tdk.com>
	<20240311160557.437337-4-inv.git-commit@tdk.com>
	<0ea167a1-75d0-469d-a79f-ff2cb5e81bdc@gmail.com>
 <20240806175324.3eea67c7@jic23-huawei>
In-Reply-To: <20240806175324.3eea67c7@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|FRYP281MB3260:EE_
x-ms-office365-filtering-correlation-id: d61e6c3f-4dae-4426-bfd4-08dcb6f85812
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?koi8-r?Q?F0YudLC74+oCNAQAVPJzHbipxE5ETMm1QcEZlpMktPHrrArpYk9Z1BGsKIQBHm?=
 =?koi8-r?Q?TTENzmRjR6viyXONW21d2Xmfk02bz3hdqhfKFxh8BvpjKIAV3kn0tDy8y6CKgU?=
 =?koi8-r?Q?wWzJBWcQOvltm38RdZ5XiMvkogy7qusObgNSWUvGtF7ywUl2z5LJL5oRqI3WLv?=
 =?koi8-r?Q?C9dqfrtOrQ+X5NfAAqPOhO9imG8TJaXS0qU43EnHq0yb4h0wQUt49o4VVxjbZ6?=
 =?koi8-r?Q?wLXTvI4ul0gwPMop8bVrHH8OMdCa1/RzQdNh3PE2QeiEaWJG6zD/nXygiOsQHD?=
 =?koi8-r?Q?XYR+4qdgCkNUgD+T4lRY/gfDUDgqYpTgUDEPUXhsvFv4QdBXgIVSb1KlZr9+Kv?=
 =?koi8-r?Q?w+3s9+FSCTxVmQpvDypyKk6LiJPSOEk2M78cHwyOJA7Wr69ClIdjaJyy6qSab8?=
 =?koi8-r?Q?OCiW0Fg0/Ak35kYnb5AVjx7YdZZJN9HuliWZapH0h2mjnxhk6NRG3mF4YhgoAT?=
 =?koi8-r?Q?DFL2tQOsuQ+WvNNuQ4BqC8C9mf9dDDCHPNgy/CeBAaJL3AnrMT0lG1rub/owGa?=
 =?koi8-r?Q?X02OIzscagQq5zzKaasykMVucEpni+2ddLhJnx9AxiZsjaoG9RrlkmXMLU+jsA?=
 =?koi8-r?Q?Ec1U/ni7ZFxU1K1/EqYPmcoBHrzNv9CzNAEKZ96Hs9XzN+dsr98lB0l1X5zCSp?=
 =?koi8-r?Q?OYZTIq6N5Fj2LHuz7T4+xq30rCrOn9xXQihTb51H8/z4AjXMrXiWKoJOBWWbeD?=
 =?koi8-r?Q?XHuFcLMemu8LMKqDx00f/pnyWsHj4EoowF3jSRs2KJa9AIsRIl/50C0KglIWhs?=
 =?koi8-r?Q?AH4osJwWcCp1Lx4bwzONbQQK5z/CZnOaG7xptOxk8iJM5FWBevofGb5L8YvYlR?=
 =?koi8-r?Q?DzSrwA8yb/rYFbh7tXvcT2GjFLNH5N2/25qcLoZFisI0N8QYKoI73FYxqtqsAE?=
 =?koi8-r?Q?DqQn6V4Sd1JNyEFvGIKW+l1UZ5Yo8qk6nuFl+ycDvuBdx/plg+AjUMupKIPGq6?=
 =?koi8-r?Q?TppQZX91XiMZWHGvJM+HVp9iK5L7r5X4qaLzlXfOAr4X/XWWvIs7BaOsmK8J0v?=
 =?koi8-r?Q?bZ0bc5ohFEHM6tPso0z45rXXdPs/KyWb6MrJfHt0VckJuby8mgBzZYZC4Kw63C?=
 =?koi8-r?Q?zeLlcPtt0NmMK8WPY86KmTpLVCLetKS3ENmmRSkIqNa0Yx/w2zmeWDEvUG3ecL?=
 =?koi8-r?Q?vJfedS0c+UGuzfw2KA7wbCDlFAYC0y8sSN4F/f7CZLdrEj5LccuxNpLEVBYlVa?=
 =?koi8-r?Q?3kx6OIcEIKaoGz+bwhKemXL2FC8ClknJnnkyWzOcGFoBpBrYqJY5hMGxldnDtg?=
 =?koi8-r?Q?7Mv5dMb95RygoioWcMA2JkRrzWKMguDWvacKhZPEQKmxnL7UamWoJ6YPAVy0uP?=
 =?koi8-r?Q?AWzdd7jX9VkZZWdHAPTSRGw05FBcyepjrDkfA/D2oQ/3sGNCNGtSK1q8cS1BPl?=
 =?koi8-r?Q?AwYaIhTFs2tiL64QA5R3qnnOk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?koi8-r?Q?wt1b07ShlEf7+gzMNTx2y7lINDtcLs4AjHzCNfBVN7XVw0Y3BL3O52HLeflF99?=
 =?koi8-r?Q?jBvOLBVSZ5thYQX8WusIzBH8i7T4CRHxdaB+Lq2UZryJj/Wip7TNTi79StLK4q?=
 =?koi8-r?Q?Q2EWluGs+uqygDm36hp6D5BGEU51wiFGUdf9q7v6VxZkVD0+OlUGMRmGqPis9q?=
 =?koi8-r?Q?MMoU3EMIhuxV3faMBY5cgt1LsX91WFQGm/l12FiX0zcDbIsq9RbR7v3iDECYH5?=
 =?koi8-r?Q?h6hnAihI1l419JPKE6EugRjNsyys8AzBlCJsnL0ppculYlCtUdP5ZloaCJwSiu?=
 =?koi8-r?Q?kYoiNTqP0hQJ90u9h25TvqCruOimaMaC8nH+XrZIauQyftVhWyw/z2ADSIb6s6?=
 =?koi8-r?Q?pVM3JH+0vVIdFmWcKd2rjFEEAp6TC/4DwJnsmgOIC9F2eoIjWlfwSKcM9vvrJI?=
 =?koi8-r?Q?uR4dhvbaGfZ66UFH87NTgSoC03KK5X3/ALWtt+ZvIPlOkckFrnAe6pXX7dDQs+?=
 =?koi8-r?Q?UrJ+WCKfZWL7ouW412Z6ck87b4YjmUlQw11qrOCYsEzIo41GjYNt+MdnK5b5sZ?=
 =?koi8-r?Q?LtnYaUwa7iFzZn3by5o6aLsekSv0L8vus/PcLQlTpmreqybwKd1/upyq6SBNWz?=
 =?koi8-r?Q?NXxarmyVJWIQncxdDkSMNcG4XcxsIn6x+KrVTEwakvg5i0Ju+NrQIfiYLegobr?=
 =?koi8-r?Q?vvJOWHJCAY7FiyAsj1ycqF2fwSVmOg97tsrLiTQjZ+ZqTynSEKD7jaHg6Ny9xa?=
 =?koi8-r?Q?5md5OfobmQjlLx3qA/X59IOJhi2d8uTuBu9tHoDGq2LgRn+Xwy7wDjWDmMMSFV?=
 =?koi8-r?Q?ZLHJPfyNRp/SvlSDhS1aa/MxVzNrY6WliZCBxgo7jOSHolcGaT4yIsbWqJyOsT?=
 =?koi8-r?Q?kJVgiVWndUN1nHKd4zxfypZG2DtR6o98ht6KwIBaTP1l3WBnsNneqQwDOXd9LJ?=
 =?koi8-r?Q?1U6JwgMLiqmIlsq9U8z54qCPX3OZOw1dOGMdw4L9bE0ett4flP1PIu89FUWk9E?=
 =?koi8-r?Q?aU/g0Qn8CIpGRVjIqvGj5sJUdN6m/l22CpWeCD66jq6kfY4k09cPz/6BtprB4k?=
 =?koi8-r?Q?5qwyX0SdyU8W7uA8aDV0xs3k8KZ0vsGOTL6dql/kxTzF4Xry4FaE5DKpLJ7GGT?=
 =?koi8-r?Q?4hfVq+RY1XlAPpLaPEkfaA7Vp59DJ0cigdqEdaizjdHCHce3/sXcWNdqhR6qzG?=
 =?koi8-r?Q?g3BGz//MyQGWoQyFrm0JHxPAXguKU29UThOMB6bl3hzOUKuRzXwT6pxgtY0Fxw?=
 =?koi8-r?Q?M7YlCv6oz4EDa6tRiK36Hbz3DkeKmMtOoqYfl9rFufnNCChPsx4xcI1hfbpYs9?=
 =?koi8-r?Q?g4QIlMeoBI3f/HqfBuNHknkLHRX21S+zUJN5mI899IeXUFjitpbTzIobPnSG2u?=
 =?koi8-r?Q?z5aOPeOBDAUALrTFnVCDqjOoHJZX4LbOw499YXZtKhEEFVD+cnIAPvaM+veZ3e?=
 =?koi8-r?Q?JS4zQ+bdgP3pQiqqf5VWVWCqG1e8/1gQWpCGYvxKRdn8Jl9ZfGKheU5qzbQhyP?=
 =?koi8-r?Q?0Z9FoS71l0eLIC8jqztMXwhrCBrmideGcNmM9AA1LbTUJeRO7/kzjYxQJJsVOh?=
 =?koi8-r?Q?oVlOjYhgJX/csy6m3gTGgZ0m/J0RBnSyc8v0vUSEaiHJDKmX2yjfoH+7Ent40D?=
 =?koi8-r?Q?wlGLhzW1IeITo36640HzylglLbU4j4rsq8dQOURGD+VNq7V+f5eOFYkOHagRCt?=
 =?koi8-r?Q?Bg78VAwGKggQ=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d61e6c3f-4dae-4426-bfd4-08dcb6f85812
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 15:48:12.5255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eq+mrqN3GFfclIszBcTkrKpcfCs5Vmimc+3EsWVcQOmvXAx5uaDcAYjW03CRvLsXAATGFaXXqDsUrAZII/7wCAgBbSUDGvqdX5nvNfM0SSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3260
X-Proofpoint-ORIG-GUID: hCNZvEMVQ9iMht2izeJ906pGbEBooiM7
X-Proofpoint-GUID: hCNZvEMVQ9iMht2izeJ906pGbEBooiM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070110

Hello Jonathan and Svyatoslav,=0A=
=0A=
this is really strange because it is an I2C transaction error happening.=0A=
The chip is obviously on, otherwise it would not be able to send interrupt =
and have sensors running.=0A=
=0A=
For investigating the issue, we need to know what is the chip used inside t=
his device. The driver is supporting a lot of chips that may have some spec=
ific behaviors.=0A=
=0A=
Svyatoslav,=0A=
can you give us the name of the chip in this LG device or the whoami value =
read by the driver?=0A=
=0A=
Thanks a lot for your help.=0A=
JB=0A=
=0A=
________________________________________=0A=
From:=9AJonathan Cameron <jic23@kernel.org>=0A=
Sent:=9ATuesday, August 6, 2024 18:53=0A=
To:=9ASvyatoslav Ryhel <clamor95@gmail.com>=0A=
Cc:=9AINV Git Commit <INV.git-commit@tdk.com>; lars@metafoo.de <lars@metafo=
o.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; Jean-Baptiste=
 Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Subject:=9ARe: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt hand=
ler for WoM events=0A=
=9A=0A=
This Message Is From an External Sender=0A=
This message came from outside your organization.=0A=
=9A=0A=
On Tue, 23 Jul 2024 11:25:03 +0300=0A=
Svyatoslav Ryhel <clamor95@gmail.com> wrote:=0A=
=0A=
> 11.03.24 6:05 =D0=D0, inv.git-commit@tdk.com:=0A=
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
> >=0A=
> > Add new interrupt handler for generating WoM event from int status regi=
ster=0A=
> > bits. Launch from interrupt the trigger poll function for data buffer.=
=0A=
> >=0A=
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=
=0A=
=0A=
Jean-Baptiste,=0A=
=0A=
Please take a look at this report.  I'd rather not revert the series=0A=
if we can figure out what is wrong and get a fix on top in reasonably=0A=
quickly.=0A=
=0A=
I'd guess a power problem so we are getting interrupts when device is power=
ed down?=0A=
Hence the reads fail.=0A=
=0A=
Jonathan=0A=
=0A=
> > ---=0A=
> >   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +=0A=
> >   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 11 ---=0A=
> >   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 69 +++++++++++++++++-=
-=0A=
> >   3 files changed, 66 insertions(+), 16 deletions(-)=0A=
> >=0A=
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_iio.h=0A=
> > index d5b0465d1f74..ca5f7d45a6d4 100644=0A=
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
> > @@ -185,6 +185,7 @@ struct inv_mpu6050_hw {=0A=
> >    *  @magn_orient:       magnetometer sensor chip orientation if avail=
able.=0A=
> >    *  @suspended_sensors:	sensors mask of sensors turned off for suspen=
d=0A=
> >    *  @data:		read buffer used for bulk reads.=0A=
> > + *  @it_timestamp:	interrupt timestamp.=0A=
> >    */=0A=
> >   struct inv_mpu6050_state {=0A=
> >   	struct mutex lock;=0A=
> > @@ -210,6 +211,7 @@ struct inv_mpu6050_state {=0A=
> >   	unsigned int suspended_sensors;=0A=
> >   	bool level_shifter;=0A=
> >   	u8 *data;=0A=
> > +	s64 it_timestamp;=0A=
> >   };=0A=
> >   =0A=
> >   /*register and associated bit definition*/=0A=
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_ring.c=0A=
> > index 13da6f523ca2..e282378ee2ca 100644=0A=
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
> > @@ -51,21 +51,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
> >   	u32 fifo_period;=0A=
> >   	s64 timestamp;=0A=
> >   	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];=0A=
> > -	int int_status;=0A=
> >   	size_t i, nb;=0A=
> >   =0A=
> >   	mutex_lock(&st->lock);=0A=
> >   =0A=
> > -	/* ack interrupt and check status */=0A=
> > -	result =3D regmap_read(st->map, st->reg->int_status, &int_status);=0A=
> > -	if (result) {=0A=
> > -		dev_err(regmap_get_device(st->map),=0A=
> > -			"failed to ack interrupt\n");=0A=
> > -		goto flush_fifo;=0A=
> > -	}=0A=
> > -	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))=0A=
> > -		goto end_session;=0A=
> > -=0A=
> >   	if (!(st->chip_config.accl_fifo_enable |=0A=
> >   		st->chip_config.gyro_fifo_enable |=0A=
> >   		st->chip_config.magn_fifo_enable))=0A=
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/ii=
o/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
> > index ec2398a87f45..2514966f6495 100644=0A=
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=0A=
> > @@ -6,6 +6,7 @@=0A=
> >   #include <linux/pm_runtime.h>=0A=
> >   =0A=
> >   #include <linux/iio/common/inv_sensors_timestamp.h>=0A=
> > +#include <linux/iio/events.h>=0A=
> >   =0A=
> >   #include "inv_mpu_iio.h"=0A=
> >   =0A=
> > @@ -223,6 +224,65 @@ static const struct iio_trigger_ops inv_mpu_trigge=
r_ops =3D {=0A=
> >   	.set_trigger_state =3D &inv_mpu_data_rdy_trigger_set_state,=0A=
> >   };=0A=
> >   =0A=
> > +static irqreturn_t inv_mpu6050_interrupt_timestamp(int irq, void *p)=
=0A=
> > +{=0A=
> > +	struct iio_dev *indio_dev =3D p;=0A=
> > +	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
> > +=0A=
> > +	st->it_timestamp =3D iio_get_time_ns(indio_dev);=0A=
> > +=0A=
> > +	return IRQ_WAKE_THREAD;=0A=
> > +}=0A=
> > +=0A=
> > +static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)=0A=
> > +{=0A=
> > +	struct iio_dev *indio_dev =3D p;=0A=
> > +	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=0A=
> > +	unsigned int int_status, wom_bits;=0A=
> > +	u64 ev_code;=0A=
> > +	int result;=0A=
> > +=0A=
> > +	switch (st->chip_type) {=0A=
> > +	case INV_MPU6050:=0A=
> > +	case INV_MPU6500:=0A=
> > +	case INV_MPU6515:=0A=
> > +	case INV_MPU6880:=0A=
> > +	case INV_MPU6000:=0A=
> > +	case INV_MPU9150:=0A=
> > +	case INV_MPU9250:=0A=
> > +	case INV_MPU9255:=0A=
> > +		wom_bits =3D INV_MPU6500_BIT_WOM_INT;=0A=
> > +		break;=0A=
> > +	default:=0A=
> > +		wom_bits =3D INV_ICM20608_BIT_WOM_INT;=0A=
> > +		break;=0A=
> > +	}=0A=
> > +=0A=
> > +	scoped_guard(mutex, &st->lock) {=0A=
> > +		/* ack interrupt and check status */=0A=
> > +		result =3D regmap_read(st->map, st->reg->int_status, &int_status);=
=0A=
> > +		if (result) {=0A=
> > +			dev_err(regmap_get_device(st->map), "failed to ack interrupt\n");=
=0A=
> > +			return IRQ_HANDLED;=0A=
> > +		}=0A=
> > +=0A=
> > +		/* handle WoM event */=0A=
> > +		if (st->chip_config.wom_en && (int_status & wom_bits)) {=0A=
> > +			ev_code =3D IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,=
=0A=
> > +						     IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING);=0A=
> > +			iio_push_event(indio_dev, ev_code, st->it_timestamp);=0A=
> > +		}=0A=
> > +	}=0A=
> > +=0A=
> > +	/* handle raw data interrupt */=0A=
> > +	if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {=0A=
> > +		indio_dev->pollfunc->timestamp =3D st->it_timestamp;=0A=
> > +		iio_trigger_poll_nested(st->trig);=0A=
> > +	}=0A=
> > +=0A=
> > +	return IRQ_HANDLED;=0A=
> > +}=0A=
> > +=0A=
> >   int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type=
)=0A=
> >   {=0A=
> >   	int ret;=0A=
> > @@ -235,11 +295,10 @@ int inv_mpu6050_probe_trigger(struct iio_dev *ind=
io_dev, int irq_type)=0A=
> >   	if (!st->trig)=0A=
> >   		return -ENOMEM;=0A=
> >   =0A=
> > -	ret =3D devm_request_irq(&indio_dev->dev, st->irq,=0A=
> > -			       &iio_trigger_generic_data_rdy_poll,=0A=
> > -			       irq_type,=0A=
> > -			       "inv_mpu",=0A=
> > -			       st->trig);=0A=
> > +	ret =3D devm_request_threaded_irq(&indio_dev->dev, st->irq,=0A=
> > +					&inv_mpu6050_interrupt_timestamp,=0A=
> > +					&inv_mpu6050_interrupt_handle,=0A=
> > +					irq_type, "inv_mpu", indio_dev);=0A=
> >   	if (ret)=0A=
> >   		return ret;=0A=
> >     =0A=
> =0A=
> Greetings!=0A=
> =0A=
> After this patch was applied to Linux kernel I faced a regression on my =
=0A=
> devices LG P895/P880.=0A=
> =0A=
> Dmesg is flooded with=0A=
> =0A=
> [ 50.035018] inv-mpu6050-i2c 0-0068: failed to ack interrupt -121=0A=
> =0A=
> and mpu6050 used on this device refuses to work. It did not occur before =
=0A=
> WoM patches were=0A=
> =0A=
> applied and reverting patches restores normal work of mpu6050.=0A=
> =0A=
> =0A=
> Best regards,=0A=
> =0A=
> Svyatoslav R.=0A=
> =0A=
=0A=

