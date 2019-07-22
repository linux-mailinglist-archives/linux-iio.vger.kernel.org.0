Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B6C6FB24
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 10:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfGVIUK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 04:20:10 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20906 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726944AbfGVIUK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 04:20:10 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6M8IW7b031021;
        Mon, 22 Jul 2019 04:20:08 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tuvt85d4f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 04:20:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0VSIv/CbgfHRWEXtONAA3p2hXRPlQm3ZSOLcjfawXMmSQCVmKjgPPS1+fRPhbYLgw5+2FI+GnlgnzE3pXbXbj4M4ojL1Wkl60sJj4/EqR4JnUgvtm2KZoeiute4ly2yxZ9GbrRdT+rGme0YsKwL3ZCKZczEkbOGb+z1OB9lyMyYga8gfLsu3+KM+kpv2+v2rnrSqDMsz0N/kRH9BdiGt6htCrx0uY900uRlOuqhdGqZ4/PAJHx0T2dE9gM8at/1x/pIEp7nycp0hcVGRlau9NELgRuIJyhBaqRil35xaVSyd5nM8aDyWTbUHNjQ5i2+01/Sdxoailod4Q7RlYXHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckNNHakx5Gn4SIXYWuP7RitMfS2OOWDQEh9w+VbK5H4=;
 b=M86XiEcAKJE1+EkdJ5YvYlPoDJ8m/TQ7cYrcGfS3Iq71iIXijS/7GDqNZJ8Xp+DKpBYwG6inzfBYJeIM23qP5zkD2ktNo5ZhJFjMUASeaiiF9looiaTvKAbVvwz/4q2WHUSmrxd5Y4MG1fU78COilJ1/xTNudrSbdC6hnSmitJOnDSiwwbHOF/LP5NLviTGcsyediL1qn+A+okoZn8aFGFl4sytBOJhEHyyWsHKI+u1BLuFMB4Z2JMrN1VDmB3Vgho10WPuO5MKeAksdfoHgLhH+jno7Jz+LnPXlf05VFtj2u4Oy6NV/tGZqI13GGTWGMUXGFO51iAnbRGXWxi8wqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckNNHakx5Gn4SIXYWuP7RitMfS2OOWDQEh9w+VbK5H4=;
 b=kNHH24TzT8AARuovv0hlMoRW8FPSXxR1ZWvW70QFpKnSyFpN8yVtqYG9BIN34PN5T96YTb8OWlB/E7Yd79DQ3B5olTUDU310WZ2Yr3+iQY4odr9CVwM1SqiukDf9fDpoZzrK2Svfi+TBI1hSQFkibg5JfZcSEodiQXYtl0wJ6YU=
Received: from BN3PR03CA0082.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::42) by MN2PR03MB4718.namprd03.prod.outlook.com
 (2603:10b6:208:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.12; Mon, 22 Jul
 2019 08:20:05 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN3PR03CA0082.outlook.office365.com
 (2a01:111:e400:7a4d::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.12 via Frontend
 Transport; Mon, 22 Jul 2019 08:20:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Mon, 22 Jul 2019 08:20:05 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x6M8K24t014389
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 22 Jul 2019 01:20:02 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Mon, 22 Jul 2019 04:20:04 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kartik.koolks@gmail.com" <kartik.koolks@gmail.com>
Subject: Re: problem with driver with driver name and version
Thread-Topic: problem with driver with driver name and version
Thread-Index: AQHVPnOkcl8KYTpGPECMBvOPuyWQRqbWkqeA
Date:   Mon, 22 Jul 2019 08:20:03 +0000
Message-ID: <e90e62aac3db9cb1d9a9da473976f20f40ad49ee.camel@analog.com>
References: <CAMz8oh3q9OsyZN5F5SxWFttCgGfjW2jaszT1EN8TTtO-NHuO1w@mail.gmail.com>
In-Reply-To: <CAMz8oh3q9OsyZN5F5SxWFttCgGfjW2jaszT1EN8TTtO-NHuO1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.145]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <93B10321AB85D741BFE3F084D03CE1B0@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(199004)(189003)(486006)(118296001)(229853002)(3846002)(6116002)(6246003)(7696005)(336012)(14454004)(50466002)(76176011)(102836004)(23676004)(2486003)(436003)(426003)(36756003)(2906002)(126002)(476003)(446003)(2616005)(26005)(11346002)(86362001)(186003)(8936002)(70206006)(70586007)(106002)(110136005)(246002)(7636002)(8676002)(5660300002)(316002)(7736002)(305945005)(356004)(2501003)(478600001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4718;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43d3fed1-3b0c-4fed-6911-08d70e7d66b3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:MN2PR03MB4718;
X-MS-TrafficTypeDiagnostic: MN2PR03MB4718:
X-Microsoft-Antispam-PRVS: <MN2PR03MB47181AD8B13C37CA8020FB64F9C40@MN2PR03MB4718.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01068D0A20
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: GBUdK3gCv9gBzFx+carkzw+nfV8rMJd4Wp5sDOcjUzehLdxR6mPklN1RPdybXTyYMsFtdA7sFrVLSo6HpBd6Ef0GXAUuG2rtDMMOa1okxOr++zNjuEouLh1txVqagjf/RN8+WE4GpAMxh6N7KN5stpPzTkPTTln4VavMnfjJAFJbb/PxeyXbn4q/Zfpf2biShBTQGfMA/ZFu+Zr3niLsPqFqjQlYehAjKCEOgcnCQ5GG4ZwYxVOdMNMwrD++nNbSFyHEPhCxQ7uTouWtk+B9Y3ccCAm9oYuQiKEoatJWMU862RWzOzrnU0DCQweDY9fG/5KUjnpQsA4HT+cLViQwbabbkCVCgnPOx0PQW3+pUcnZssiYBvKgDOXEe1RFQ8vxXKAYCmdCmkapmdrengkWNVgwoJxY+1Cmwuen7o6xozk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2019 08:20:05.0617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d3fed1-3b0c-4fed-6911-08d70e7d66b3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4718
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907220100
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE5LTA3LTIwIGF0IDAyOjIwICswNTMwLCBLYXJ0aWsgS3Vsa2Fybmkgd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IEhlbGxvIHRoZXJlLA0KPiBJIHdhbnRlZCB0byBwYXRjaCB0
aGUgZHJpdmVyIGZvciAgYWQ3MjgwYSAgZm91bmQgYXQNCj4gL29wdC9saW51eC1rZXJuZWwtZGV2
L2lpby9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYyBhbmQgZm91bmQgYSBmZXcNCj4gYW5vbWFsaWVz
IHdoaWNoIEkgZmVsdCBuZWVkZWQgdG8gYmUgYXNrZWQgYmVmb3JlIHRoZSBwYXRjaCB3YXMNCj4g
c3VibWl0dGVkLg0KPiANCj4gMS4NCj4gYGBgDQo+IHRhdGljIHN0cnVjdCBzcGlfZHJpdmVyIGFk
NzI4MF9kcml2ZXIgPSB7DQo+ICAgICAgICAgLmRyaXZlciA9IHsNCj4gICAgICAgICAgICAgICAg
IC5uYW1lICAgPSAiYWQ3MjgwIiwNCg0KTWFrZXMgc2Vuc2UgdG8gcmVuYW1lIHRoaXMgdG8gImFk
NzI4MGEiLCBzbyBmZWVsIGZyZWUgdG8gc2VuZCBhIHBhdGNoIGp1c3QgZm9yIHRoaXMuDQoNCj4g
DQo+IC4uLg0KPiANCj4gYGBgDQo+IHRoZSBwYXJ0IG9mIHRoZSBkZXZpY2UgaWQgc2F5cyBhZDcy
ODAgaW5zdGVhZCBvZiBhZDcyODBhIHdoaWNoIGlzIHRoZQ0KPiBuYW1lIG9mIHRoZSBkcml2ZXIg
ZmlsZSBhbmQgbG9va2luZyBhdCB0aGUgRGF0YXNoZWV0IHRoZXJlJ3MgZGlmZmVyZW50DQo+IGRh
dGFzaGVldCBmb3IgYWQ3MjgwIGFuZCBhZDcyODBBIGFuZCBkb2VzIG5vdCBtZW50aW9uIGNvbXBh
dGliaWxpdHkNCj4gd2l0aCBlYWNoIG90aGVyLihJIG1pZ2h0IGJlIHdyb25nIGJ1dCBvbmUgaGFk
IHNwaSBpbnRlcmZhY2UgZm9yIDQ4DQo+IGNoYW5uZWxzIGFuZCB0aGUgb3RoZXIgaGFzIHNwaSBp
bnRlcmZhY2UgZm9yIDMwMCBjaGFubmVscyBzbyBJIHRoaW5rDQo+IGl0IG1pZ2h0IG5vdCBiZSBj
b21wYXRpYmxlKQ0KPiANCj4gTm90ZTogVGhlIHNwaSBkZXZpY2UgaWQgY29udGFpbnMgImFkNzI4
MGEiIGFuZCBub3QgImFkNzI4MCINCj4gUVVFU1RJT046DQo+IFNob3VsZCBJIHNlbmQgYSBwYXRj
aCB0byBjb3JyZWN0IHRoZSAuY29tcGF0aWJsZSB3aXRoIGFkNzI4MGEgaW5zdGVhZD8NCj4gYXMg
YSBkaWZmZXJlbnQgcGF0Y2ggYW5kIHNlbmQgYW5vdGhlciBwYXRjaCB3aGljaCBJIGFtIHdvcmtp
bmcgb24NCj4gKGFib3V0IG9mX21hdGNoIHdoaWNoIGlzIG5vdCBwcmVzZW50KSBhbmQgYWRkIHRo
ZSBvZl9tYXRjaF9hcnJheSB0bw0KPiBjb250YWluIHRoZSBkZXZpY2UgImFkNzI4MGEiDQoNClRo
ZSBgb2ZfbWF0Y2hfdGFibGVgIHBhdGNoIHNob3VsZCBiZSBpdCdzIG93biBwYXRjaC4NCklmIHlv
dSB3YW50IGEgc2VuZCBhIHBhdGNoIGZvciB0aGlzLCB0aGUgLmNvbXBhdGlibGUgc3RyaW5nIHNo
b3VsZCBiZSAiYWRpLGFkNzI4MGEiLg0KVGhlIGBhZDcyODBfaWRgIHRhYmxlIGlzIGNvcnJlY3Qu
DQoNCj4gDQo+IG9yIGlzIHRoZSBmaWxlIGNvcnJlY3QgYW5kIEkganVzdCBzZW5kIGEgcGF0Y2gg
YWJvdXQgb2ZfbWF0Y2hfZGV2aWNlcw0KPiB3aXRoICJhZDcyODAiDQo+IA0KPiBSZWdhcmRzLA0K
PiBLYXJ0aWsgS3Vsa2FybmkNCg==
