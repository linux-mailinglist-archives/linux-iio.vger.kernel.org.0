Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469171B78C3
	for <lists+linux-iio@lfdr.de>; Fri, 24 Apr 2020 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgDXPCN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Apr 2020 11:02:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47940 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726890AbgDXPCM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Apr 2020 11:02:12 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03OEuvh7028071;
        Fri, 24 Apr 2020 11:01:52 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-00128a01.pphosted.com with ESMTP id 30fxf6eg1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 11:01:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHDtQ4yoSnmnll7cQwMCvNiC22e0X7yZOcOPENnEMcPgSEROV4tnlGLTPOzRJLaaMwin3y9XuTNAJ5Nghcb1WFJPos/1qefiknnmAIhletAcXXbcHL7HrOM9IZf8t/Ckf7gsTIlSg4YhJsFUQH1GgZWhPA6vW9QZ/Wh6+1WwnYHVggEsSgRNzKR+wKp6lyAQGMfQeDZF12Mj2R9nAYmiARYA9lEQNR4KeSjxmGsxZMvBmYjK/UzjHgr3m9CE3mW5FWxXcG63pU1IggB/+kPvJ9yhv3ZJ3Rr1yT/7dxvjwcj3QzGCcooOB4dTkA08jToVRm7Utcq5y8sSDJV8SPsRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCZbX2IomzgzvKyrCS43JV4KoOkOASN3ZpBMyGBfOY4=;
 b=LYuKvGII/aLWtIq7FWLmYoNI3TQhSoKtw2Dcqh6S9rGC2r6GrZtuo3Mmoo2yFZS1OcOU8BQ0qsuACU04RBoNg6GA8epMq1PlWcH+0TjyzKIAkn+cS31OV15f/s+DOGwb6pke8+ruxmQ1THlmXpLi78HEH68hByMfqdQP2o1aWj3jWGwwzJ484nneL3BVNpuNuJLm7vOgVMyi3LqQ4W//BMD99bR0i2YGCvtgieQDQpr6F7jsVs4sEUnH1t0w7SGlX5sdSubi+87eN+b9YjA+CWYAD6W12UjUZ/WM8pu3vC30RG0q6V+FfqC4DNU1F6H5vkK6mepOzKLWXswPUOZ+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCZbX2IomzgzvKyrCS43JV4KoOkOASN3ZpBMyGBfOY4=;
 b=81ayRhTcPc2/hoJ6kkrnWseeDRXmG31TWd1jUGAEohBTiZvFOFoQwPjbdeqTIThyVPrHahOMEXBjSKOkACcYrTT1oe8ldxSjJYvFq9xBHAGSi7Q/2oUKk3kGx8pz2OgzbKnF8+YyLX9viZMlV+u1jyIDz60GZAP8ShwfwNqzATE=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5178.namprd03.prod.outlook.com (2603:10b6:5:240::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 15:01:26 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c47f:ceee:cfda:6a7f%3]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 15:01:26 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] iio: adc: ad7476: remove redundant null check on an
 array
Thread-Topic: [PATCH][next] iio: adc: ad7476: remove redundant null check on
 an array
Thread-Index: AQHWGjj1ltw2ltqHgkeNW0t7wHv4TaiIXgEA
Date:   Fri, 24 Apr 2020 15:01:26 +0000
Message-ID: <f2c6d3f3f8f884e87f1c9895fe99b77e8f4c1e3e.camel@analog.com>
References: <20200424130419.22940-1-colin.king@canonical.com>
In-Reply-To: <20200424130419.22940-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.27.130.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7acce796-223d-4ac6-9ec8-08d7e8605cde
x-ms-traffictypediagnostic: DM6PR03MB5178:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB51783A13740F1E576AD85681F9D00@DM6PR03MB5178.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(366004)(86362001)(8936002)(186003)(110136005)(36756003)(66946007)(6506007)(76116006)(26005)(91956017)(2906002)(66476007)(6486002)(4326008)(478600001)(81156014)(8676002)(4744005)(71200400001)(2616005)(6512007)(316002)(66446008)(64756008)(54906003)(5660300002)(66556008)(921003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M9PPFfZHVujVQ3t4XOPI5Mv096EAIIykmB08lo1fxqOcxRQOOpQfMWcxY9mQ96SnzjpLM3mAxYSPSN24CfB18txz7X9nWjX/+oQpmLr9rR/LvUqpapnPEb/wZIy82DDpKJkVgcUPzhQm/2jeScQQFnDcBtGuJNDmKvskzBbQ0bZs5G92fqgTShvzWDWWoxK2srIwYkxWEMxM/+dVQaD6LAqyiyf4FnHX3Kk2xB5/W5q+uHZDJMFphkks3RrbkZ6OjlWbVAvgtenV8+Am3XPGa0rKenA8P8htd9OipN+9PGa+jc6NVMwRRVJZXHk8R5PP8RYB5aDhCPoIcqQF5F6xQS/wKbUCNb6It7W+ir/TFaCB229vXyHzhAPWRmb+oeOAHnX1S93ROWtQ8y6il8jP8ZYivRRMs5DCbU9i26gNZjzniXYNjnUTsBPxuuriduB/TCzJ5LjrbI8IhAa0hREbKS8JtiTN+0BODD8i45pexCs=
x-ms-exchange-antispam-messagedata: 8P8T2uVB6DrHOsxkgjEQl5cRvPXt1HHIVo7iWPxKQVyQAtviW1ZIxgzuetaRtDOtZByaATwIcqgsX+QF2Y5V1A6SoY12A4pgswfT6t8ToMjvWpnzdx+yBZtaUX4JUyCRDT91xcyhQXWeosCct0tE1Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E12146849D61B489196F3E4EF262CB0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acce796-223d-4ac6-9ec8-08d7e8605cde
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 15:01:26.7563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhcqSPFSBsDffIVTo/3Fy9jNQgK5OEiYfom+4TjD59UvT70tkbSJ277dNP8f2qV/9ktize709edwlQqS4XNIP+0bV2K18RG7fNiw1uQ8wkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5178
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-24_08:2020-04-24,2020-04-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240120
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTI0IGF0IDE0OjA0ICswMTAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBG
cm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gVGhl
IG51bGwgY2hlY2sgb24gc3QtPmNoaXBfaW5mby0+Y29udnN0X2NoYW5uZWwgaXMgcmVkdW5kYW50
IGJlY2F1c2UNCj4gY29udnN0X2NoYW5uZWwgaXMgYSAyIGVsZW1lbnQgYXJyYXkgb2Ygc3RydWN0
IGlpb19jaGFuX3NwZWMgb2JqZWN0cw0KPiBhbmQgdGhpcyBjYW4gbmV2ZXIgYmUgbnVsbC4gRml4
IHRoaXMgYnkgcmVtb3ZpbmcgdGhlIG51bGwgY2hlY2suDQo+IA0KDQpSZXZpZXdlZC1ieTogQWxl
eGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KPiBBZGRy
ZXNzZXMtQ292ZXJpdHk6ICgiQXJyYXkgY29tcGFyZWQgYWdhaW5zdCAwIikNCj4gU2lnbmVkLW9m
Zi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2lpby9hZGMvYWQ3NDc2LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lp
by9hZGMvYWQ3NDc2LmMgYi9kcml2ZXJzL2lpby9hZGMvYWQ3NDc2LmMNCj4gaW5kZXggZTk5ODRh
MzhmYzRjLi40ZTgxNmQ3MTRhZDIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hZDc0
NzYuYw0KPiArKysgYi9kcml2ZXJzL2lpby9hZGMvYWQ3NDc2LmMNCj4gQEAgLTMwOSw3ICszMDks
NyBAQCBzdGF0aWMgaW50IGFkNzQ3Nl9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAg
CWluZGlvX2Rldi0+bnVtX2NoYW5uZWxzID0gMjsNCj4gIAlpbmRpb19kZXYtPmluZm8gPSAmYWQ3
NDc2X2luZm87DQo+ICANCj4gLQlpZiAoc3QtPmNvbnZzdF9ncGlvICYmIHN0LT5jaGlwX2luZm8t
PmNvbnZzdF9jaGFubmVsKQ0KPiArCWlmIChzdC0+Y29udnN0X2dwaW8pDQo+ICAJCWluZGlvX2Rl
di0+Y2hhbm5lbHMgPSBzdC0+Y2hpcF9pbmZvLT5jb252c3RfY2hhbm5lbDsNCj4gIAkvKiBTZXR1
cCBkZWZhdWx0IG1lc3NhZ2UgKi8NCj4gIA0K
