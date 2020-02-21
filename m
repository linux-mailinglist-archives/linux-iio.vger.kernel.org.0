Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B064168420
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 17:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBUQvl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 11:51:41 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:44520 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgBUQvl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2020 11:51:41 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LGo58U030697;
        Fri, 21 Feb 2020 11:51:39 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y8uduqm2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 11:51:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX7qj6/LZsKGpJVnIFT91YLJNSro/tS4LsmkBA/wV/7bTCj4nTTAiqpoW+5B/xwRQ6rIw2PEyKDSPut1KvhvFdLySGfMRWSnSlTGmqa8h2yZR9vz8I12tBhcucjMubzyMKzE44OEx3G+KnrFTLpsZc3BVa/5fALvsbeGhb+ot9cHYVmI7HtTIocbOKRhajgOy+AnJynGrz7+Wb/s0HtzlCVqYbZu906L3DGcsArQxF8RhMTxoI/UJ8TSj3ejN7l8dsfvVb0l/QoztSUHgTGqwGa6xCeOg9EPDzTWl2/5+gZkhiOr8ie1iuUg8n8FcQRqj21F86OeukhuonOlRGg50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emcLDNmJKFhggrdPlOlNcBVzJ4e2x/bUmmkOTDtPsPM=;
 b=PLmgOq9jV/B4kbI3kY/7EIsPs2Ga3KJazy72dQEzYYjbkDBnYhYvNlOUuPTW2MdbKXqlrws5GAACOv5xo9YtRfE6TnyubQpNPNN1DY5ifny+GJ4G+yxUU0d+ClhOU5JiwNa3q4pypgXPUqqmWpIWfIZ7SdR+jcc3RAvbOnVQa2VDkvybuoQUiT7WmeIVOSztfa74YE3kmD9D4rWcRG8fqP0AkSrtaJjHgq45xXRPnLeIAOqUtQ6sA2DlGRKpS12ZShiS6ya6pE/UrNkoNYAq5rnluq7CjOxwp5g2jlMq1JlWBfieDA6hLQbZyKZPlfSIe6MOhs1STCLHoF1RdLqJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emcLDNmJKFhggrdPlOlNcBVzJ4e2x/bUmmkOTDtPsPM=;
 b=xbvoEvi5S8AEKCnV52bPngSeC1KG9mEl7COpxYNwIIT0wrf1tNVuxuSs1FrQiYgaDviZhbtDU4BJHsH9Hb2PALQqMZExAuPgA4FYYN6gQE9Rj5kOHKP0h1AOQShfZAuT1lKHOBeN8ufmUhZ+txhRSD3FP3nWiSwwXViktbktzbI=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5176.namprd03.prod.outlook.com (2603:10b6:610:97::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:51:37 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:51:37 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: imu: adis: add doc-string for 'adis' struct
Thread-Topic: [PATCH 1/3] iio: imu: adis: add doc-string for 'adis' struct
Thread-Index: AQHV6Kyqh2DoHgggAUWjgbyiyGgv6Kgln5YAgAAu4gCAAAQqAIAACmAA
Date:   Fri, 21 Feb 2020 16:51:37 +0000
Message-ID: <e39d77b4115a2ce3e0483199d32f849623c3aa90.camel@analog.com>
References: <20200221114943.2056-1-alexandru.ardelean@analog.com>
         <20200221131146.2213e8e1@archlinux>
         <414d7e293b75e556ce857e0ce985a0f89fb24ffd.camel@analog.com>
         <20200221161428.188e1532@archlinux>
In-Reply-To: <20200221161428.188e1532@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1559ef3-7f09-43bc-aad1-08d7b6ee50dd
x-ms-traffictypediagnostic: CH2PR03MB5176:
x-microsoft-antispam-prvs: <CH2PR03MB5176DB97EBFBB6E62B4D1DE7F9120@CH2PR03MB5176.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(71200400001)(6486002)(81156014)(81166006)(4326008)(6512007)(478600001)(316002)(6506007)(186003)(26005)(54906003)(6916009)(66446008)(2616005)(66476007)(76116006)(91956017)(66946007)(66556008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5176;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5DcBjvHcbVuUHST9XL/2ixz6CfVi2SBcPPiE8WiNbyARc4LUx3pBFucW5cCp+xVvS6jzLB4p4griRDWP1PJHWtrrKUUZlLTLnAOLDK5L2Mn+xh1RWS563HB48FIqsrULTCDfZ0NgCxr4C1+quHvXXeL/vg9ydlSOzgFXmdASFN3QY3S7y0JGlT7BQaNamJmMtxJH62HR3ZUQx1ifECNU2zepdw+rXvSaqO/HGj72qJccXowEtlNd7CYUxNVN9y9rtvF027UnDo/gS04GRDmCyntUW9teNLppIqPJEa1IKE473iYkMiKGVJIdwTT/A9HiHFf6gQrACc1K+F9IaDnZFvZQUVDN2dwVDrm2lcg7Hv1oOXYpT8jj0PmvVE/IfcQdiV76++T+//dgVAj6dXreX/uV8ZiSwKE1LEUmGS5iyPU4yfoSRiVqaf6Tl49j6ZiK
x-ms-exchange-antispam-messagedata: kmT4D3AhoreinsYDs4/KfUeevxmEVycxsKST2zuSyq9PsItCoYJGdyM9WoPjBpKIi+1bGkRfKMbSUu4mZrkybLeCaEv2knA6L4/smInETPIS63UoZlf7yAZ9aCPRdDQHay/UsfhuqqDI8gYeNzS1ow==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B7E9291212A79409053109E99E13BE3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1559ef3-7f09-43bc-aad1-08d7b6ee50dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 16:51:37.0235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQAjyYAFDbthzijQytyX3YMxT2BHqI55esMfwnQ3yjPFETEjrJ01FzMoR6qDLiYE0bOOpMfiGNItzny/txmM4RtOzhfa9r21B0thQKnd/fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5176
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_05:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210127
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTIxIGF0IDE2OjE0ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBGcmksIDIxIEZlYiAyMDIwIDE1OjU5OjM1ICswMDAwDQo+ICJBcmRlbGVhbiwgQWxl
eGFuZHJ1IiA8YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+IHdyb3RlOg0KPiANCj4gPiBP
biBGcmksIDIwMjAtMDItMjEgYXQgMTM6MTEgKzAwMDAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6
DQo+ID4gPiBPbiBGcmksIDIxIEZlYiAyMDIwIDEzOjQ5OjQxICswMjAwDQo+ID4gPiBBbGV4YW5k
cnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPiB3cm90ZToNCj4gPiA+
ICAgDQo+ID4gPiA+IFRoaXMgY2hhbmdlIGFkZHMgYSBkb2Mtc3RyaW5nIGZvciB0aGUgJ2FkaXMn
IHN0cnVjdC4gSXQgZGV0YWlscyB0aGUNCj4gPiA+ID4gZmllbGRzDQo+ID4gPiA+IGFuZCB0aGVp
ciByb2xlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRl
bGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4g
PiAgaW5jbHVkZS9saW51eC9paW8vaW11L2FkaXMuaCB8IDE0ICsrKysrKysrKysrKysrDQo+ID4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaWlvL2ltdS9hZGlzLmggYi9pbmNsdWRlL2xpbnV4
L2lpby9pbXUvYWRpcy5oDQo+ID4gPiA+IGluZGV4IGFjN2NmZDA3MzgwNC4uMDc4N2EzYWFiZDA1
IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lpby9pbXUvYWRpcy5oDQo+ID4g
PiA+ICsrKyBiL2luY2x1ZGUvbGludXgvaWlvL2ltdS9hZGlzLmgNCj4gPiA+ID4gQEAgLTczLDYg
KzczLDIwIEBAIHN0cnVjdCBhZGlzX2RhdGEgew0KPiA+ID4gPiAgCWJvb2wgaGFzX3BhZ2luZzsN
Cj4gPiA+ID4gIH07DQo+ID4gPiA+ICANCj4gPiA+ID4gKy8qKg0KPiA+ID4gPiArICogc3RydWN0
IGFkaXMgLSBBRElTIGRldmljZSBpbnN0YW5jZSBkYXRhDQo+ID4gPiA+ICsgKiBAc3BpOiBSZWZl
cmVuY2UgdG8gU1BJIGRldmljZSB3aGljaCBvd25zIHRoaXMgQURJUyBJSU8gZGV2aWNlDQo+ID4g
PiA+ICsgKiBAdHJpZzogSUlPIHRyaWdnZXIgb2JqZWN0IGRhdGENCj4gPiA+ID4gKyAqIEBkYXRh
OiBBRElTIGNoaXAgdmFyaWFudCBzcGVjaWZpYyBkYXRhDQo+ID4gPiA+ICsgKiBAYnVyc3Q6IEFE
SVMgYnVyc3QgdHJhbnNmZXIgaW5mb3JtYXRpb24NCj4gPiA+ID4gKyAqIEBzdGF0ZV9sb2NrOiBM
b2NrIHVzZWQgYnkgdGhlIGRldmljZSB0byBwcm90ZWN0IHN0YXRlDQo+ID4gPiA+ICsgKiBAbXNn
OiBTUEkgbWVzc2FnZSBvYmplY3QNCj4gPiA+ID4gKyAqIEB4ZmVyOiBTUEkgdHJhbnNmZXIgb2Jq
ZWN0cyB0byBiZSB1c2VkIGZvciBhIEBtc2cNCj4gPiA+ID4gKyAqIEBjdXJyZW50X3BhZ2U6IFNv
bWUgQURJUyBkZXZpY2VzIGhhdmUgcmVnaXN0ZXJzLCB0aGlzIHNlbGVjdHMNCj4gPiA+ID4gY3Vy
cmVudA0KPiA+ID4gPiBwYWdlDQo+ID4gPiA+ICsgKiBAYnVmZmVyOiBEYXRhIGJ1ZmZlciBmb3Ig
aW5mb3JtYXRpb24gcmVhZCBmcm9tIHRoZSBkZXZpY2UNCj4gPiA+ID4gKyAqIEB0eDogQ2FjaGVs
aW5lIGFsaWduZWQgVFggYnVmZmVyIGZvciBTUEkgdHJhbnNmZXJzDQo+ID4gPiA+ICsgKiBAcng6
IENhY2hlbGluZSBhbGlnbmVkIFJYIGJ1ZmZlciBmb3IgU1BJIHRyYW5zZmVycyAgDQo+ID4gPiAN
Cj4gPiA+IFRoaXMgbGFzdCBvbmUgaXNuJ3QgdHJ1ZS4uICAgDQo+ID4gDQo+ID4gT2ggcmlnaHQu
DQo+ID4gSSBub3RpY2VkIHRoaXMgYXQgc29tZSBwb2ludCwgdGhlbiBmb3Jnb3QgYWJvdXQgaXQu
DQo+ID4gWyBUaGUgImpveXMiIG9mIG11bHRpLXRhc2tpbmc7IHNvcnJ5IGFib3V0IGl0IDopIF0N
Cj4gPiBJIGd1ZXNzIEkgc2hvdWxkIGFsc28gYWRkIGEgcGF0Y2ggaW4gdGhpcyBzZXJpZXMgbWFr
aW5nIGl0IGNhY2hlbGluZS0NCj4gPiBhbGlnbmVkLg0KPiA+IEkgZG9uJ3Qgc2VlIGEgcmVhc29u
IHdoeSBub3QtdG8gW3VubGVzcyBJIGFtIG1pc3VuZGVyc3Rhbmdpbmcgc29tZXRoaW5nXQ0KPiBO
by4gIFRoZSBjb2RlIGlzIGZpbmUuICBUaGUgcHVycG9zZSBvZiB0aGUgY2FjaGVsaW5lIHN0dWZm
IGlzIHRvIGVuc3VyZQ0KPiBubyBvdGhlciBkYXRhIGVuZHMgdXAgaW4gdGhlIHNhbWUgY2FjaGVs
aW5lIGFuZCBtaWdodCBiZSBjaGFuZ2VkIGluIHBhcmFsbGVsDQo+IHdpdGggdGhlIHNwaSBkbWEg
dGFraW5nIHBsYWNlLiAgIFlvdSBvbmx5IG5lZWQgdG8gZm9yY2UgaXQgZm9yIHRoZSBmaXJzdA0K
PiBlbGVtZW50IHdoZW4geW91IGhhdmUgMiBidWZmZXJzIGxpa2UgdGhpcy4NCj4gDQo+IFNvIHlv
dSBuZWVkIHRvIHVwZGF0ZSB0aGUgY29tbWVudCBpbiB0aGlzIHBhdGNoIHRvIHNheSBzb21ldGhp
bmcgbGVzcw0KPiBzcGVjaWZpYy4NCj4gUGVyaGFwcw0KPiANCj4gQHR4OiBETUEgc2FmZSBUWCBi
dWZmZXIgZm9yIFNQSSB0cmFuc2ZlcnMNCj4gQHJ4OiBETUEgc2FmZSBSWCBidWZmZXIgZm9yIFNQ
SSB0cmFuc2ZlcnMuDQo+IA0KDQpTb3VuZHMgZ29vZCB0byBtZS4NCg0KVGhhbmtzDQpBbGV4DQoN
Cj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gDQo+ID4gPiAgIA0KPiA+ID4gPiAr
ICovDQo+ID4gPiA+ICBzdHJ1Y3QgYWRpcyB7DQo+ID4gPiA+ICAJc3RydWN0IHNwaV9kZXZpY2UJ
KnNwaTsNCj4gPiA+ID4gIAlzdHJ1Y3QgaWlvX3RyaWdnZXIJKnRyaWc7ICANCg==
