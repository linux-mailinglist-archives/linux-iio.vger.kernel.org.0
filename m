Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B1981F88
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 16:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfHEOwx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 10:52:53 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:52946 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728824AbfHEOww (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2019 10:52:52 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75ElHcp026173;
        Mon, 5 Aug 2019 10:52:49 -0400
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2053.outbound.protection.outlook.com [104.47.48.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u6kb20kdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 10:52:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTT0JdA61mT/thRqqaDjoLfToHZqXWKwR/U3xa0Vc9+JHT33s61XyDDw3rwrfa0NGJ9vRpqPcnIGLhENKgNy5xfZvn5Zd8Y2UyeEUO2SUr/yro9EkODeaBozIDYRsJP+1qwp5lUny0dzi41PRInRT/KCelj3QeNvnXwX5850ODbpUOVQ/46dcInnxyqpvPUGlcsHUtbtLjLu6myjYoie5kuqgdV05hDsTv9Nmv0Ua17RrJb+1rXR01MmrrJ3rYNQb2dCbndsYq4m/0Bp73PAe6bSnal0mQr5RCQiLWBdBndr+W+bDlAccOaORMuGZk5Cdh++x4XPUrJb2IfjZV2YyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chXGJHAbFYIMb71Fx0k3N9MZem9b4KMh0QUarKy0jhA=;
 b=Le+iqsvmcAmFijcm02hQAZ/E5sImhfGCtrb6ljVoqNQEBJYFjK81gp2JQoSkLHoa1ZJmKD70sWYOMIUQM3D0B2KNBw/sbUe324l9jzpyE4z5lOJan//lxdXLHoW9r8F/ECn0n6jW6R+JdRYlFSaj1lQtgkpDW97VKqHDOYhF5dPgGIbioAXvJshsgOiY3BU+gVSd9DoDFfeEsDALMcStszwM2CT8Q8GV2F4W25gbOnGaJhgFtxLOe5N9bTUldTp/RH1DX0R9CF6vr5WCvSu+1s25AoiXzo+1WMfvBwrhVNuZttDMeSEnR3F3dGjN9yTZ/ni7B7YndkIs3GUugspZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chXGJHAbFYIMb71Fx0k3N9MZem9b4KMh0QUarKy0jhA=;
 b=QJ0WtTMGxxbmodR/uDNawQT3m7TOn+hiLTV22IPR1RYKqwQL3LWSQZJCc3j3cEKv+QKGKeIMr0KRNcE87J6cglPt1QyIxY+blI6E68eQdI5M29uleIgdV5B9T8LMYGvqRW5wlG2K9sVk88tQb3tbmRzHPrHy09swQi0Rs3bKKL4=
Received: from DM6PR03CA0035.namprd03.prod.outlook.com (2603:10b6:5:40::48) by
 CY4SPR00MB251.namprd03.prod.outlook.com (2603:10b6:903:13c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.16; Mon, 5 Aug
 2019 14:52:47 +0000
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM6PR03CA0035.outlook.office365.com
 (2603:10b6:5:40::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.15 via Frontend
 Transport; Mon, 5 Aug 2019 14:52:47 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT008.mail.protection.outlook.com (10.152.75.59) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Mon, 5 Aug 2019 14:52:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x75Eqgte000756
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 5 Aug 2019 07:52:42 -0700
Received: from NWD2MBX5.ad.analog.com ([fe80::49e:7a9f:284e:1a49]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Mon, 5 Aug 2019 10:52:45 -0400
From:   "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: frequency: adf4371: Fix output frequency setting
Thread-Topic: [PATCH] iio: frequency: adf4371: Fix output frequency setting
Thread-Index: AQHVS5LcXfSgbwGu40GwApLAGhGBTKbs5seA
Date:   Mon, 5 Aug 2019 14:52:44 +0000
Message-ID: <1565016763.13789.4.camel@analog.com>
References: <20190805133716.7808-1-nuno.sa@analog.com>
In-Reply-To: <20190805133716.7808-1-nuno.sa@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.226.41]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2A289EB9FC3A049A4B7E73788D20519@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(376002)(2980300002)(199004)(189003)(2616005)(229853002)(7636002)(8936002)(102836004)(76176011)(36756003)(186003)(26005)(103116003)(336012)(11346002)(246002)(8676002)(426003)(436003)(486006)(446003)(4744005)(126002)(47776003)(6636002)(7736002)(110136005)(23676004)(305945005)(356004)(14454004)(54906003)(476003)(106002)(86362001)(316002)(7696005)(2906002)(70206006)(70586007)(5660300002)(2486003)(50466002)(478600001)(4326008)(107886003)(6116002)(3846002)(6246003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4SPR00MB251;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d21ea87f-7532-4fe0-0657-08d719b49487
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:CY4SPR00MB251;
X-MS-TrafficTypeDiagnostic: CY4SPR00MB251:
X-Microsoft-Antispam-PRVS: <CY4SPR00MB25193291786B4E838DA6C2B9DDA0@CY4SPR00MB251.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 01208B1E18
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: LbjYQsj0rn8Jkmv4Y2gt9N0MiTFmWISJC53q+q4tfqU/s0Ut3kinLjZjFRBxXbPU0xvmqdSsS56BB28YMY5bU/1Xl8whxCkCGd/TmDz5Guwz8BPkevrz5WYcxeD3Nl6TP8bAYT+8JEEdnlKyMS+J5lNAzjX6onWiZ4YkOB26oquL/HjelpDUIFsBYZbW4VckPSk69m4jgrmQzxPun61X3tFMAsDLS+XuBkKaA3CD6/oR+7sqQcsiXeuOdYV9VLIR8biDfBg7ITvbPPYICJVDtgmw97MhmK4OCxhTEncbkJpuA0D4qUp3y0r0BPtz9nvBzNAHCfjY1mfAieTzPWr6idiGGyCH+B0799Meg5t+wDpyggetAalq+/EdiamKz0mr4We5JM3GCTR7Wd3YvKUBt4vojsrHHjJHcTqi+dsrlPA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2019 14:52:47.0417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d21ea87f-7532-4fe0-0657-08d719b49487
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4SPR00MB251
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=920 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050165
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQo+IFRoZSBmcmFjdDEgd29yZCB3YXMgbm90IGJlaW5nIHByb3Blcmx5IHByb2dyYW1tZWQgb24g
dGhlIGRldmljZSBsZWFkaW5nDQo+IHRvIHdyb25nIG91dHB1dCBmcmVxdWVuY2llcy4NCj4gDQo+
IEZpeGVzOiA3ZjY5OWJkMTQ5MTMgKGlpbzogZnJlcXVlbmN5OiBhZGY0MzcxOiBBZGQgc3VwcG9y
dCBmb3IgQURGNDM3MQ0KPiBQTEwpDQo+IFNpZ25lZC1vZmYtYnk6IE51bm8gU8OhIDxudW5vLnNh
QGFuYWxvZy5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvaWlvL2ZyZXF1ZW5jeS9hZGY0MzcxLmMg
fCA4ICsrKystLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCg0KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBQb3BhIDxzdGVmYW4ucG9wYUBhbmFsb2cu
Y29tPg0KDQo=
