Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8FA97D777
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 10:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfHAIX7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 04:23:59 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25526 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbfHAIX6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 04:23:58 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x718NSSD010161;
        Thu, 1 Aug 2019 04:23:54 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u3hrnhf2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 04:23:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P52erDd1mnOGLldzwL12BChjMS179m0OWdAoeH1mPDhNs9jHhythMV4RQBz/lqzsNH2TMrNZJkkgee1cMghx6OgQ/9VgkfuhAvqdH0TjNyysdUgemeTlo85Kuu9HYSLpQuYCNLkxQ2gqBv6p3F869ZC2VwVq6OqeD30tukDePWDAhZh0BJFOuL6Fd/0ZEfBO8aR9hO+RIGsaE+jRXTipVxBwbF3PeskdPU/qwVVq7qs+IUQenYVBxecWSnI1w2iDwK4gDmrFW0cRizNofsLbWMx9dsLrjyZ6GKotHIEPW4c4ae5ZtkZfX4vEd+oWgAq80Sl33/qZydOD4BwmqW3zWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9yyYJgFSmAthWKFHPim2sNFdIrEJRIpXGNCgR+JvU4=;
 b=a8EYdJbR10/JngSmL0YfFj+mExfDb9WPwqtSxslzoItV/Q6HwgY7r38q3KJv0I5foVjCr9NOgYKI4OY09P72660DLS0LfBZ58Ep/uJ4F3Jh9WxVJ5yAMBkm8LpBzLwzkCUca7FKySyZaMh4HXtrnURElsdYKS9yLXSNC0BPeQo+ks9bx6b/vkeIoKCaeHcybjFNgqvJ7QEg+5O6TwyeKprv4J+qf44XqnYl/CFhBCny5qOfLMrPEZVbNPw2lrI5pgK0Fwo/AJVW0Tu6WbHhHEUM/TclbBXB89ZU3tkaok6U9C7fHIbuOzYJMC7WabbMHUmZ7pbU7DSJk+RKOg5+N7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9yyYJgFSmAthWKFHPim2sNFdIrEJRIpXGNCgR+JvU4=;
 b=OLAOjIZ1h7qKNdhcOXvC+Bfsx5V+Ykro1HolKTz8RYFIL17ZP4TZux3UNL5svk/h5CWOkv6AsHDQazDyiUCO/LkI2aKV/dLV30Nn5C1qfNhYs3g4bZA/grhZXk7vY+ynj1bsxT52mdvUREb4m+IqGaDm/diLIJr1BiyyXmlk/S8=
Received: from BN6PR03CA0068.namprd03.prod.outlook.com (2603:10b6:404:4c::30)
 by DM5PR03MB2761.namprd03.prod.outlook.com (2603:10b6:3:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Thu, 1 Aug 2019 08:23:52 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN6PR03CA0068.outlook.office365.com
 (2603:10b6:404:4c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.14 via Frontend
 Transport; Thu, 1 Aug 2019 08:23:52 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Thu, 1 Aug 2019 08:23:51 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x718Np2N018787
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 1 Aug 2019 01:23:51 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Thu, 1 Aug 2019 04:23:51 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/5] move buffer allocation into st_sensors_buffer
Thread-Topic: [PATCH 0/5] move buffer allocation into st_sensors_buffer
Thread-Index: AQHVR+pR5XuYofvPFUuKam1N5Ffu96bmamgA
Date:   Thu, 1 Aug 2019 08:23:50 +0000
Message-ID: <caa578445e0442c75f1c55aff656aa6e2dfd89e6.camel@analog.com>
References: <20190731215250.16403-1-denis.ciocca@st.com>
In-Reply-To: <20190731215250.16403-1-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.109]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBC36C7A37A8AC48AF9320C05F94AD30@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(2980300002)(199004)(189003)(2501003)(8676002)(5660300002)(186003)(50466002)(26005)(426003)(436003)(118296001)(8936002)(476003)(336012)(2906002)(36756003)(23676004)(7696005)(102836004)(2486003)(316002)(446003)(86362001)(305945005)(7736002)(7636002)(76176011)(6116002)(3846002)(356004)(2201001)(106002)(110136005)(246002)(70206006)(126002)(486006)(70586007)(478600001)(11346002)(6246003)(2616005)(14454004)(47776003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2761;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51145d01-cb04-4450-8804-08d716599618
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DM5PR03MB2761;
X-MS-TrafficTypeDiagnostic: DM5PR03MB2761:
X-Microsoft-Antispam-PRVS: <DM5PR03MB276100D5D810E254405AA39DF9DE0@DM5PR03MB2761.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 01165471DB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PdKeHTfZ8vR+UF55zDHAOhP+5oGSKccbax3FSFVGMM6zC8scJF6t6GGNeyrnKnsC/v+lFwFgRJ481jthNIw+sVtjtNUolkRjEn+aaTVaHHWevZFeEZgQ+OdL9c4NjD8nRhjcK+W59rbFFcKCtuWjPgbu9FJcbdn7lYpC02zU6LRCd1TBdoFGBGX8SrCRcIDNtAV1nyyOtd3x5HyZfAg3vsChdjvG21jYE40s2hmi5yO8a5Cwa0rvAlZznn3SMtFkES5BJeFuX5UAtWTWOIoKC9IIl0xRX34LJu7rMpneWVI0EWs9Ep2WsEwPKagrOtE4xgwXGXSDgkjCcPQwuWxawYwaOjscS3eR6gD1zKwvcADXm0/IzLCAc1NM0FY8JmNPmEkX12fb0tZbenDd2v0qxbe+tb8QAfCUiSFTf9qIoqk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2019 08:23:51.9232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51145d01-cb04-4450-8804-08d716599618
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2761
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=966 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010086
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTMxIGF0IDE0OjUyIC0wNzAwLCBEZW5pcyBDaW9jY2Egd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IEFzIHByb3Bvc2VkIGJ5IEFsZXhhbmRydSwgbWVtb3J5IGFsbG9j
YXRpb24gYW5kIGRlLWFsbG9jYXRpb24gY2FuIGJlDQo+IHBlcmZvcm1lZCBpbiBhIG1vcmUgbmVh
dCB3YXkgaW4gc3Rfc2Vuc29yc19idWZmZXIuDQo+IA0KDQpUaGFuayB5b3UgZm9yIHRoaXMgc2Vy
aWVzIGFzIHdlbGwuDQpBcyBhIG5vdGU6IEkgdGhpbmsgdGhpcyBkZXBlbmRzIG9uIHRoZSBwcmV2
aW91cyBzZXJpZXM6ICJbUEFUQ0ggdjIgMC80XSBwcmVlbmFibGUvcG9zdGVuYWJsZS9wcmVkaXNh
YmxlIGZpeHVwIGZvciBTVA0KZHJpdmVycyINCg0KVGhlIGNoYW5nZXNldCBsb29rcyBuZWF0Lg0K
DQpBbGV4DQoNCj4gRGVuaXMgQ2lvY2NhICg1KToNCj4gICBpaW86Y29tbW9uOiBpbnRyb2R1Y2Ug
c3Rfc2Vuc29yc19idWZmZXJfcHJlZW5hYmxlL3ByZWRpc2FibGUgZnVuY3Rpb25zDQo+ICAgaWlv
OmFjY2VsOiBkbyBub3QgYWxsb2NhdGUvZGUtYWxsb2NhdGUgYnVmZmVyIGhlcmUgYnV0IGxpbmsg
c2V0dXBfb3BzDQo+ICAgICB0byBzdF9zZW5zb3JzX2J1ZmZlcg0KPiAgIGlpbzpneXJvOiBkbyBu
b3QgYWxsb2NhdGUvZGUtYWxsb2NhdGUgYnVmZmVyIGhlcmUgYnV0IGxpbmsgc2V0dXBfb3BzDQo+
ICAgICB0byBzdF9zZW5zb3JzX2J1ZmZlcg0KPiAgIGlpbzptYWduOiBkbyBub3QgYWxsb2NhdGUv
ZGUtYWxsb2NhdGUgYnVmZmVyIGhlcmUgYnV0IGxpbmsgc2V0dXBfb3BzDQo+ICAgICB0byBzdF9z
ZW5zb3JzX2J1ZmZlcg0KPiAgIGlpbzpwcmVzc3VyZTogZG8gbm90IGFsbG9jYXRlL2RlLWFsbG9j
YXRlIGJ1ZmZlciBoZXJlIGJ1dCBsaW5rDQo+ICAgICBzZXR1cF9vcHMgdG8gc3Rfc2Vuc29yc19i
dWZmZXINCj4gDQo+ICBkcml2ZXJzL2lpby9hY2NlbC9zdF9hY2NlbF9idWZmZXIuYyAgICAgICAg
ICAgfCAxNCArKystLS0tLS0tLS0NCj4gIC4uLi9paW8vY29tbW9uL3N0X3NlbnNvcnMvc3Rfc2Vu
c29yc19idWZmZXIuYyB8IDIyICsrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvaWlvL2d5
cm8vc3RfZ3lyb19idWZmZXIuYyAgICAgICAgICAgICB8IDE0ICsrKy0tLS0tLS0tLQ0KPiAgZHJp
dmVycy9paW8vbWFnbmV0b21ldGVyL3N0X21hZ25fYnVmZmVyLmMgICAgIHwgMTQgKysrLS0tLS0t
LS0tDQo+ICBkcml2ZXJzL2lpby9wcmVzc3VyZS9zdF9wcmVzc3VyZV9idWZmZXIuYyAgICAgfCAx
NCArKystLS0tLS0tLS0NCj4gIGluY2x1ZGUvbGludXgvaWlvL2NvbW1vbi9zdF9zZW5zb3JzLmgg
ICAgICAgICB8ICAyICsrDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDQ0
IGRlbGV0aW9ucygtKQ0KPiANCg==
