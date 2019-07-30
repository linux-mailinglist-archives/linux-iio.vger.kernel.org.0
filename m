Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336E87A39E
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2019 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfG3JEE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jul 2019 05:04:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7176 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726557AbfG3JEE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jul 2019 05:04:04 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6U92VCB023541;
        Tue, 30 Jul 2019 05:04:00 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2052.outbound.protection.outlook.com [104.47.36.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u1nh6vmtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 05:03:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aks6vh4fvkIZw09gH/L07TQgeL2LVn8CP6rcqcECjHtRg1XZg54c5IKkI8Q2kYo9SlOVMigd5KsGLM8S5I9QkJZa+GZym+iS+cu3YOQOML/mFaX+rOWR8eisBZ+w8Kk6xSHbF/3xnGtzWfxNmK9cIjmixZw/7fvWcKdXrL8LuiuiuHiA0MBVzcFWOYCx9JUzl7pisYs5lKcY5IuYBPfJ1VUC/dJl3mObesR2LwIJacslZq34SRgpKZhUUP9sIlnQoqFb55/Va2LmgV/tMKlia3O/5z2gKv3hkesxAuvf5eKm27+0YEcW20M7ELGVIWpjdNWRXdI+YY5C/fHue6lP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZL6mHYD+rmbWNhnjZIZ9FrrqL0OX2FBaQJrdelKHZkc=;
 b=CuMDnAu6618C46bJ7pAFwpmgM1GG0AFZknFCz3++h+JBjOWiAlejZ17AZ5N7xOXTnBr7rEVXzUtr30Zt0Qni2sGaKvXCRglgmiUUN8tS8QZuzhhoggf1hf6Uyx6022JGpGR99YBK6vQU3Ulh7yyaAj34htjGlXR5qEZOlhQE3ub9WrZEIdMakqhqua1AMGcmqiBAASRlM3QxGmpJQuicqk3gdv1Z6U75UAwcrBQf7e1JdeFJ1yk+kzvEkgpjIK5h+UZC1zD90YIaA3r0FGjJcjcrRi97+kupTfSFPo+qC9Y0HP1x5KRKc9jwY+V9T3Hy+vx6m+O2p6uAm1tyr1geoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZL6mHYD+rmbWNhnjZIZ9FrrqL0OX2FBaQJrdelKHZkc=;
 b=w8PbAJRjctNZxdpAJRtp3LR8gfx3ZHAPTJtciI5nFM7OdbdGT76yCfm3X4CtkYBJ1M+6eR1mKz6FzS91xhbKfMZ8vD6TWsK5WZ7SSToAv9o5kFZu+rr7uo9i0lKVWhvcYapl+cMLOu6E6u1387YthcJHAfcoKjiHWvk9WOz+/dk=
Received: from BN6PR03CA0091.namprd03.prod.outlook.com (2603:10b6:405:6f::29)
 by MWHPR03MB2830.namprd03.prod.outlook.com (2603:10b6:300:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.15; Tue, 30 Jul
 2019 09:03:57 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN6PR03CA0091.outlook.office365.com
 (2603:10b6:405:6f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.15 via Frontend
 Transport; Tue, 30 Jul 2019 09:03:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2115.10
 via Frontend Transport; Tue, 30 Jul 2019 09:03:57 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6U93uVt024951
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 30 Jul 2019 02:03:56 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Tue, 30 Jul 2019 05:03:56 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/4] preenable/postenable/predisable fixup for ST drivers
Thread-Topic: [PATCH 0/4] preenable/postenable/predisable fixup for ST
 drivers
Thread-Index: AQHVRmtJamqrRiFL/UWPIiPeZPhSoqbjU+4A
Date:   Tue, 30 Jul 2019 09:03:56 +0000
Message-ID: <4c0520dca0749ef9cd753e89ff59df7a20e4e413.camel@analog.com>
References: <20190730000305.30958-1-denis.ciocca@st.com>
In-Reply-To: <20190730000305.30958-1-denis.ciocca@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.107]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3CDD25444239A418A5DB1C7A97F9BD6@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(346002)(2980300002)(199004)(189003)(106002)(26005)(476003)(2906002)(305945005)(76176011)(102836004)(186003)(47776003)(316002)(229853002)(23676004)(110136005)(7696005)(3846002)(6116002)(2486003)(446003)(86362001)(36756003)(2201001)(118296001)(8676002)(478600001)(70206006)(6246003)(70586007)(336012)(426003)(246002)(356004)(436003)(7736002)(4744005)(11346002)(5660300002)(2616005)(14454004)(126002)(8936002)(50466002)(486006)(2501003)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2830;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d165710f-2eb1-41b8-6db8-08d714ccdad0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:MWHPR03MB2830;
X-MS-TrafficTypeDiagnostic: MWHPR03MB2830:
X-Microsoft-Antispam-PRVS: <MWHPR03MB28301DCCF7A757FFB3412D05F9DC0@MWHPR03MB2830.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0114FF88F6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4HgkAd3Zf9bGz7Q3xzVsJphmf7alFSXap+HZPZxJr1wsuX5mNNqZvfut9JFyyKrV7mRwU0dCdRmfHcRmNKjGnYlzV9qN2ggDbM1lQY8caYN0euRW50xiC588Svok5DHBoUKi37qoWxJRCA5ZEWh74juxJp1IlvM15/sscUglojdPIWkhk2QGn4P25N8eWOVhfCB9ObS/MDTJyDlBAGNeWD8IziG55JMYwS8qwy0NWFp9wwsjm9WzWlQ6LAdAmReSSkK0KqfnWG4EiobInmp6KntwwF0hGouGZH/Qb8cvbbl1RfWJQki6Y/xq5akZGcbEJSa2jhSzTtiuIouT5Wwk/C/++SRLUwSwz+sLo+qLsqKMtW9VeLUV4i3yd/7XXVSARRjmbvS+sKS7Aavpl2aAmc9As6wxbkdX+Dl7RB8RJnI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2019 09:03:57.0699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d165710f-2eb1-41b8-6db8-08d714ccdad0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=944 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300098
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE5LTA3LTI5IGF0IDE3OjAzIC0wNzAwLCBEZW5pcyBDaW9jY2Egd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IFRoaXMgc2VyaWVzIGlzIG1lYW50IHRvIGZpeCBmb3IgZ29vZCB0
aGUgZnVuY3Rpb25zIGxpc3RlZCBpbiBzdWJqZWN0Lg0KPiBJbiBhIHdheSwgaXMgY29udGludWlu
ZyB0aGUgdGFzayBzdGFydGVkIGJ5IEFsZXhhbmRydSBmb3IgYWNjZWwuDQo+IA0KDQpNYW55IHRo
YW5rcyBmb3IgdGhpcyBzZXJpZXMuDQpJdCdzIG5vdyBmZXdlciBkcml2ZXJzIEkgbmVlZCB0byBu
b3Qgd29ycnkgYWJvdXQuDQoNCkFsZXgNCg0KPiANCj4gRGVuaXMgQ2lvY2NhICg0KToNCj4gICBp
aW86YWNjZWw6IHByZWVuYWJsZS9wb3N0ZW5hYmxlL3ByZWRpc2FibGUgZml4dXAgZm9yIFNUIGFj
Y2VsIGJ1ZmZlcg0KPiAgIGlpbzpneXJvOiBwcmVlbmFibGUvcG9zdGVuYWJsZS9wcmVkaXNhYmxl
IGZpeHVwIGZvciBTVCBneXJvIGJ1ZmZlcg0KPiAgIGlpbzptYWduOiBwcmVlbmFibGUvcG9zdGVu
YWJsZS9wcmVkaXNhYmxlIGZpeHVwIGZvciBTVCBtYWduIGJ1ZmZlcg0KPiAgIGlpbzpwcmVzc3Vy
ZTogcHJlZW5hYmxlL3Bvc3RlbmFibGUvcHJlZGlzYWJsZSBmaXh1cCBmb3IgU1QgcHJlc3MNCj4g
ICAgIGJ1ZmZlcg0KPiANCj4gIGRyaXZlcnMvaWlvL2FjY2VsL3N0X2FjY2VsX2J1ZmZlci5jICAg
ICAgIHwgMzcgKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVycy9paW8vZ3lyby9zdF9neXJv
X2J1ZmZlci5jICAgICAgICAgfCA0NSArKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVy
cy9paW8vbWFnbmV0b21ldGVyL3N0X21hZ25fYnVmZmVyLmMgfCAyMiArKysrKy0tLS0tLQ0KPiAg
ZHJpdmVycy9paW8vcHJlc3N1cmUvc3RfcHJlc3N1cmVfYnVmZmVyLmMgfCAzMiArKysrKystLS0t
LS0tLS0tDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDg0IGRlbGV0aW9u
cygtKQ0KPiANCg==
