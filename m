Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D2875E4E
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2019 07:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfGZFbM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Jul 2019 01:31:12 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:37618 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbfGZFbM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Jul 2019 01:31:12 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6Q5RRrl002881;
        Fri, 26 Jul 2019 01:30:36 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2txwrxvgtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 01:30:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr9G7FXemNihSAK41YU+fBOpLuYGM94r4CRprCwwn/8EM8C4zvpx1xnHr53VBEK4Gd7ulBkQAfPkJTHVZVWEGBviGhQu9rAMG22RWVDVrZyfY8O2rvAwHEG1Cdc1v/wMvEk9GdO8XU5kHwoCU1bLN1QPLBCs7UeY0k41rzZStXciG3z32nr2/l7/Y9zrFFbQA81KfOEGebR0O/kk/baqiCdVlcZ9U9n+VRTpniIDOKCrZTvnIabcBGSJBnCeDDTCfykDB7NDVfE+iSv0y+azpVOfOMwgXXpiT15FSion30v7GTc8uyL/hdiH4HmCNsMhIIGhSKHrbburdls03qC8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UthfyRGMjjhuCkP/cJ+WgT4XUI61ZuLHjEFjYI+L+x0=;
 b=CUFXrUKmasn6OKaxyzIo9K+iNMWCx+Nnwxh9EcryF+Mw4elcp3OcbohVSPq2KALAblIoCIVP9vFQGAzfKpOa28CgCImKvyBT5WQEz4u/WW39ahSNHGlqV/IaotgcVPJNbxyPCTi83JGHTx7NkA4FXZd/pDL4j1/BGX/G4CO39xzO/B1nGhQaja0H4HsbGoP0/QhCUjbNwneUh0qtAIkVOJS3yIgtIKPXRG2xmzCr+NJhLs0NoNksspby+R5vu5w4PCXW8LzgD4dBHrOVQ7ZQ8iDe5uFzj7VQmG//j8VHz2p0uW5jYN+S99gr6eCCGaunZfFaBoXjXbyu8PuiCCvltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=usp.br
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UthfyRGMjjhuCkP/cJ+WgT4XUI61ZuLHjEFjYI+L+x0=;
 b=7YDVbiCGJ8DKkF85ZFLt3CbjyDof7MArDgJ33wHENIYuGQyL3zLqTyZsnpEMmx1fAvqLArqMvdXfiUOhtZDIqsHsMRVynctm9cVymnYqBp/hHW+KwpjBPMmt5MVWwfHBwkJNsZR5uNm7GlfC8FcU5WtJNlmfgsO/mRCRO2ymrbo=
Received: from MWHPR03CA0017.namprd03.prod.outlook.com (2603:10b6:300:117::27)
 by CY4PR03MB2949.namprd03.prod.outlook.com (2603:10b6:903:12f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Fri, 26 Jul
 2019 05:30:34 +0000
Received: from BL2NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR03CA0017.outlook.office365.com
 (2603:10b6:300:117::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10 via Frontend
 Transport; Fri, 26 Jul 2019 05:30:34 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT045.mail.protection.outlook.com (10.152.77.16) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2115.10
 via Frontend Transport; Fri, 26 Jul 2019 05:30:29 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6Q5UPGr023878
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 25 Jul 2019 22:30:25 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Fri, 26 Jul 2019 01:30:27 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "kartik.koolks@gmail.com" <kartik.koolks@gmail.com>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "matheus.bernardino@usp.br" <matheus.bernardino@usp.br>
Subject: Re: [PATCH] staging:iio:adc:ad7280a: add of_match_table entry
Thread-Topic: [PATCH] staging:iio:adc:ad7280a: add of_match_table entry
Thread-Index: AQHVQyS+86BK7s52fU+n6TMvYYCpcabcozOA
Date:   Fri, 26 Jul 2019 05:30:27 +0000
Message-ID: <0e273486f1c4fb6249896225837cdf2da0fd2415.camel@analog.com>
References: <20190725200817.31277-1-kartik.koolks@gmail.com>
In-Reply-To: <20190725200817.31277-1-kartik.koolks@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.145]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7D36C623BFDDE4C91223E58A4241AF8@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(189003)(199004)(305945005)(8676002)(2906002)(47776003)(6246003)(7416002)(436003)(426003)(23676004)(2486003)(336012)(106002)(11346002)(356004)(446003)(76176011)(7696005)(86362001)(2201001)(3846002)(486006)(2616005)(246002)(118296001)(126002)(478600001)(36756003)(476003)(229853002)(2501003)(14454004)(5660300002)(102836004)(70586007)(4326008)(70206006)(50466002)(186003)(110136005)(7636002)(316002)(7736002)(26005)(8936002)(54906003)(6116002)(14444005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2949;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 210f9662-902c-4563-32b5-08d7118a618c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:CY4PR03MB2949;
X-MS-TrafficTypeDiagnostic: CY4PR03MB2949:
X-Microsoft-Antispam-PRVS: <CY4PR03MB29497082C0A3128F373F80EEF9C00@CY4PR03MB2949.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 01106E96F6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kSZYpEN5Zez8231iKq0Cb7UILGuZZeF8Z3c8ybNW0x1q05uFdQsOAveEisiM+UFX4zBtVkfdrwzCnxoN7Dpmu4aU1Nz1u0C5SrBjNEyJfMZcivafygFwXGMk2UlSaPvl0I2rn7LXwyvbxtaImGGD9nkmK1+c5Y+luOA3DaMi8L8dapKegaH8Wun5vrPkmh4tkGSZcq4UjatrG7gYYJuCapcMpvK9hVvUFJjbOmvazWrPQ502TTcCI/ArAADWBXl6cLnwfS2pUyyK0ObqX/hDV9j/T7xx39bwjvPCsQFaQgzR/6kHzy4b8PxplhXDWISChLGhEr11CXivnCSycaV+e8VKe2nrw2stPSM3iTNjByW4qRh4Cr7GzHqJ17YIcdsqr4vzfudp66QzI5u7OBmobHbAhnvi3P9muyVMoIMWNWM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2019 05:30:29.5961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 210f9662-902c-4563-32b5-08d7118a618c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2949
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260073
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDE5LTA3LTI2IGF0IDAxOjM4ICswNTMwLCBLYXJ0aWsgS3Vsa2Fybmkgd3JvdGU6
DQo+IEFkZCB0aGUgb2ZfZGV2aWNlX2lkIHN0cnVjdCBhbmQgdGhlIHJlc3BlY3RpdmUNCj4gb2Zf
bWF0Y2hfZGV2aWNlIGVudHJ5IHRvIGNvbXBsZXRlIGRldmljZSB0cmVlIHN1cHBvcnQuDQo+IA0K
DQpUaGlzIHdvdWxkIGJlIGEgW1YyXSBJIHN1cHBvc2UuDQoNClRoaXMgY2hhbmdlIGFsc28gZG9l
cyB0aGUgcmVuYW1lIG9mIHRoZSBkcml2ZXIgbmFtZSBpbiBhIHNpbmdsZSBnby4NClNpbmNlIGl0
J3MgYSB0cml2aWFsIGNoYW5nZSwgaXQncyBmaW5lIGZyb20gbXkgc2lkZS4NCg0KUmV2aWV3ZWQt
Ynk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQoN
Cg0KPiBTaWduZWQtb2ZmLWJ5OiBLYXJ0aWsgS3Vsa2FybmkgPGthcnRpay5rb29sa3NAZ21haWwu
Y29tPg0KPiBSZXZpZXdlZC1ieTogTWF0aGV1cyBUYXZhcmVzIDxtYXRoZXVzLmJlcm5hcmRpbm9A
dXNwLmJyPg0KPiAtLS0NCj4gIGRyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzI4MGEuYyB8IDkg
KysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3MjgwYS5j
IGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3MjgwYS5jDQo+IGluZGV4IDE5YTVmMjQ0ZGNh
ZS4uZGVkMGJhMDkzYTI4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9h
ZDcyODBhLmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3MjgwYS5jDQo+IEBA
IC0xMDI3LDkgKzEwMjcsMTYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIGFk
NzI4MF9pZFtdID0gew0KPiAgfTsNCj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUoc3BpLCBhZDcyODBf
aWQpOw0KPiAgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhZDcyODBfb2Zf
bWF0Y2hbXSA9IHsNCj4gKwl7IC5jb21wYXRpYmxlID0gImFkaSxhZDcyODBhIiwgfSwNCj4gKwl7
IH0NCj4gK307DQo+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBhZDcyODBfb2ZfbWF0Y2gpOw0K
PiArDQo+ICBzdGF0aWMgc3RydWN0IHNwaV9kcml2ZXIgYWQ3MjgwX2RyaXZlciA9IHsNCj4gIAku
ZHJpdmVyID0gew0KPiAtCQkubmFtZQk9ICJhZDcyODAiLA0KPiArCQkubmFtZQk9ICJhZDcyODBh
IiwNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gYWQ3MjgwX29mX21hdGNoLA0KPiAgCX0sDQo+ICAJ
LnByb2JlCQk9IGFkNzI4MF9wcm9iZSwNCj4gIAkuaWRfdGFibGUJPSBhZDcyODBfaWQsDQo=
