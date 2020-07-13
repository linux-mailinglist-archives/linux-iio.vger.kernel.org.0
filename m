Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705DD21DB51
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jul 2020 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgGMQLm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jul 2020 12:11:42 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:65498 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729027AbgGMQLm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2020 12:11:42 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DG0GOH013295;
        Mon, 13 Jul 2020 12:11:40 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0b-00128a01.pphosted.com with ESMTP id 3279p94vn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 12:11:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lykAbUC1EEw9mQJh9OFAiC5VnBwKvt219P71ETIZ51YsSjXPODPVb20JoVULkKxEDai5K8XQfAEAavHvqWLW9lIOmVmi/4c29UopkSCD0N8gbf4Y5RIEeCwvSvuizUKuN/OH8gzEmwo3nvGoOa8AtFAGMMQf40ud5i8ZcOo6xQHWg5maS0Tv+tKAN32DoCx62VKqDJNjl7RuIGUUsM87dxQAMaT+OF1Hol18JZ0qZfiszxOJxGH3QofMAo7+RWjIpfbbMorCd09JBSffeOfhWvIADPtyKS8Ccbc+egvO4Bs2FoUEGN7hSO4Cp54cpJ+wODiy2O/5mz3BPwBR3919aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiiITXVQoXuPgPSiy1bZwgjo/6eXWoMcCgxT0SuNFFU=;
 b=IczCbzmudel7OoVamOgK1I4IFfGYYKNjCMTYbQcg47ilz9HhULNGOgMxwcRiEwAtllnMLyDJr0vT62ylfk9ngiqd/hqNAFWob7wscZKEA8BcUa2L/NHJFqFT4NIjWyAFbywIIqPYoaaYr0eq5Qfv0QFJuh2Im0qkcIght92K79gu3RwUdZtXMSovx4Y4oUJHN+T/FWW5FEs6NtZYOeudOtDD8U0kxVUoBkPAzaF11IhKb10rE6hXpWRmdVu0nc8Qg/uoeSZ7jN3I5TmX4cjvumFBHebkhXVU7zEHmPOV8GxGHuYp+74DFSchnvzfIjs5wsffM4N8MGqkQd9y+pb12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiiITXVQoXuPgPSiy1bZwgjo/6eXWoMcCgxT0SuNFFU=;
 b=9c0wPwPtxe2jM/SUlZc8cgDwmdp+JUivB6ZPhSWLvY1MFdzReMd8pBtULEG6kd4EFJ6I6+I3xJa+DdBJCa8CAW9at+P888ChQ9vfRayBuJfd3ecjerYVLqtZxlDoA1N4LYzTQ0ttHEz09ZF0j3CudIta6IezhVGcnP+H1HHIbEI=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5242.namprd03.prod.outlook.com (2603:10b6:5:22a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Mon, 13 Jul
 2020 16:11:39 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c1c3:9cbb:449c:ac0a]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::c1c3:9cbb:449c:ac0a%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 16:11:39 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "Tachici, Alexandru" <Alexandru.Tachici@analog.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad7192: move ad7192_of_match table
 closer to the end of the file
Thread-Topic: [PATCH v4 2/2] iio: adc: ad7192: move ad7192_of_match table
 closer to the end of the file
Thread-Index: AQHWEuq/E/P05XmphUeU1rNfyyCc26kGOr0A
Date:   Mon, 13 Jul 2020 16:11:39 +0000
Message-ID: <191e9880ea3dd0e127b102f006c208f31d57c421.camel@analog.com>
References: <20200415055804.17971-1-alexandru.ardelean@analog.com>
         <20200415055804.17971-2-alexandru.ardelean@analog.com>
In-Reply-To: <20200415055804.17971-2-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72040b77-6f93-4875-8bd2-08d827476cdc
x-ms-traffictypediagnostic: DM6PR03MB5242:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5242A4C3701DFCE26E9F2D6DF9600@DM6PR03MB5242.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZTxFglsL6GxikF6xDHBu+8PBfp3WV8GzNlQ7IJZMU89ni42pKgUjReXh7lzH/k+xmTjFklCR5YOPCj2NrGS2MzJYOmiFyg7SArq4yy55g/E2pE6zsvGcyBEqnYAW738vg8CwHhg10YDSwZwwMsnCPKoZ6uowq2C54QEgP0oXs79yrodrRkFLUfRUnP0sBF8d3XofFN3m8T/jaFSCOFVB21d9/Jp88gAxubNDZFG9zCf3lm2CVynPSIN4gpdSJqFCTGlA+q6gqxNC8tAC1rxyuIEHw3STsAScV9FBYwt5vJaXGKIZyE/4LRqaX7O9wAeyEQUmXwHPdxhEGosK0M4Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(366004)(136003)(39860400002)(376002)(5660300002)(86362001)(36756003)(66946007)(66476007)(66556008)(66446008)(64756008)(91956017)(76116006)(186003)(6486002)(26005)(2616005)(83380400001)(107886003)(450100002)(71200400001)(2906002)(4326008)(478600001)(8676002)(6506007)(8936002)(6512007)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /MPiYE49weu+FGqYcegk5jpIOZAyYXgBD2JT372hQBsKwinQe9I5iVc9Xw69uCu2ia10wYUFbFqpFIR+PsC7tRsw6ph9ZPunRrTvuCUedbBZS23DVfns2i/8MMx+XEzorNPSUdRCGctQwo2NDaPqIeSx7C0kV+1gctGlQi2znqVuh+kamaP0dhic3NSQE6HvIZR4Me0LPCXRiQ+zY6mR/GJ3OuxZOhfcJ5f4E9M4nrM0ADujq/Ar9tw4EiEhbWm+J26dZwJhpIkxhazyv/U5hwOG2lG936EjWFRGJbxVUTWZ5/+WVgGAzSDjqWRI5w8XO0iTdHFT+aQu+BR2jiTcH43NL/7KfFjZG/1NSNPFYTVyQgH8RGAmxVuf1qDRqcTRMak9hCPjOg+E36mgCL1ojfUy0G0txCoLMfduCcEfwyKdwfkAzNL4VRLKjLeKT4mNEJJ6z8EY5HXhEJ/33uEu4sa6hIEr6YZqAd5CKaPNB6A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC9957F91CAE224EB711555AD86F4A26@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72040b77-6f93-4875-8bd2-08d827476cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 16:11:39.4290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /BQdueZzBhjcenDQtd6bU3sWEX/1KQXwAVZCjPkYN5BVlnt+264bok74w1srcub5AiRM2qIdH1PZyCDnSy4ktLpC0Iqfxl83Oi6bauZuucg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5242
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_15:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gV2VkLCAyMDIwLTA0LTE1IGF0IDA4OjU4ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFRoZSBjaGFuZ2UgaXMgbW9yZSBjb3NtZXRpYy4gVGhlcmUgaXMgbm8gbmVlZCB0byBy
ZWZlcmVuY2UgdGhpcyB0YWJsZSBpbg0KPiB0aGUgcHJvYmUgZnVuY3Rpb24gc2luY2UgJ29mX2Rl
dmljZV9nZXRfbWF0Y2hfZGF0YScgaXMgdXNlZCwgd2hpY2gNCj4gb2J0YWlucw0KPiB0aGlzIGlu
Zm9ybWF0aW9uIGZyb20gdGhlIGRyaXZlciBvYmplY3QuDQoNClRoaXMgbG9va3MgbGlrZSBpdCBj
b3VsZCBiZSBhcHBsaWVkIG5vdy4NClRoZSBpaW8vdGVzdGluZyBicmFuY2ggc2VlbXMgdG8gaGF2
ZSBwYXRjaCBbMS8yXS4NCg0KVGhhbmtzDQpBbGV4DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9paW8vYWRjL2FkNzE5Mi5jIHwgMTggKysrKysrKysrLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIuYyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcx
OTIuYw0KPiBpbmRleCAxNDMxZjU1NWRhYTYuLmZkODlhNTExNWM1NSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9paW8vYWRjL2FkNzE5Mi5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hZDcxOTIu
Yw0KPiBAQCAtOTA4LDE1ICs5MDgsNiBAQCBzdGF0aWMgaW50IGFkNzE5Ml9jaGFubmVsc19jb25m
aWcoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldikNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4g
IA0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYWQ3MTkyX29mX21hdGNoW10g
PSB7DQo+IC0JeyAuY29tcGF0aWJsZSA9ICJhZGksYWQ3MTkwIiwgLmRhdGEgPQ0KPiAmYWQ3MTky
X2NoaXBfaW5mb190YmxbSURfQUQ3MTkwXSB9LA0KPiAtCXsgLmNvbXBhdGlibGUgPSAiYWRpLGFk
NzE5MiIsIC5kYXRhID0NCj4gJmFkNzE5Ml9jaGlwX2luZm9fdGJsW0lEX0FENzE5Ml0gfSwNCj4g
LQl7IC5jb21wYXRpYmxlID0gImFkaSxhZDcxOTMiLCAuZGF0YSA9DQo+ICZhZDcxOTJfY2hpcF9p
bmZvX3RibFtJRF9BRDcxOTNdIH0sDQo+IC0JeyAuY29tcGF0aWJsZSA9ICJhZGksYWQ3MTk1Iiwg
LmRhdGEgPQ0KPiAmYWQ3MTkyX2NoaXBfaW5mb190YmxbSURfQUQ3MTk1XSB9LA0KPiAtCXt9DQo+
IC19Ow0KPiAtTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYWQ3MTkyX29mX21hdGNoKTsNCj4gLQ0K
PiAgc3RhdGljIGludCBhZDcxOTJfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gIHsN
Cj4gIAlzdHJ1Y3QgYWQ3MTkyX3N0YXRlICpzdDsNCj4gQEAgLTEwNTAsNiArMTA0MSwxNSBAQCBz
dGF0aWMgaW50IGFkNzE5Ml9yZW1vdmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gIAlyZXR1
cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYWQ3
MTkyX29mX21hdGNoW10gPSB7DQo+ICsJeyAuY29tcGF0aWJsZSA9ICJhZGksYWQ3MTkwIiwgLmRh
dGEgPQ0KPiAmYWQ3MTkyX2NoaXBfaW5mb190YmxbSURfQUQ3MTkwXSB9LA0KPiArCXsgLmNvbXBh
dGlibGUgPSAiYWRpLGFkNzE5MiIsIC5kYXRhID0NCj4gJmFkNzE5Ml9jaGlwX2luZm9fdGJsW0lE
X0FENzE5Ml0gfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gImFkaSxhZDcxOTMiLCAuZGF0YSA9DQo+
ICZhZDcxOTJfY2hpcF9pbmZvX3RibFtJRF9BRDcxOTNdIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9
ICJhZGksYWQ3MTk1IiwgLmRhdGEgPQ0KPiAmYWQ3MTkyX2NoaXBfaW5mb190YmxbSURfQUQ3MTk1
XSB9LA0KPiArCXt9DQo+ICt9Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYWQ3MTkyX29m
X21hdGNoKTsNCj4gKw0KPiAgc3RhdGljIHN0cnVjdCBzcGlfZHJpdmVyIGFkNzE5Ml9kcml2ZXIg
PSB7DQo+ICAJLmRyaXZlciA9IHsNCj4gIAkJLm5hbWUJPSAiYWQ3MTkyIiwNCg==
