Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF4478351
	for <lists+linux-iio@lfdr.de>; Fri, 17 Dec 2021 03:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhLQCot (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 21:44:49 -0500
Received: from mail-sgaapc01on2119.outbound.protection.outlook.com ([40.107.215.119]:47113
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229471AbhLQCor (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 Dec 2021 21:44:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QflHIXI3VowY+X5/83gKQK3cWMASwyIeqYeBpNWuoDWbuTcAUdYnhTTqsECt3BkofkOMso5KWwIGeeAfGxKuT+G+Q+BQuqHU+WnLbAk7wHi8/Xkt11anNHZnnis4yvWeS9U2mNaJiixdbPchjJB92L2FEwG0P7ySroRWoikZQ4PDkZaKzWbJkzF5SREN+WpA+0y9ilg7hpLqOygGhdyt/FtNDQW+NwaDdnYJKLv8BHjE6ik00pFyfHSu4cV+nD2qxPlnK7WLSu2M0YPe2wAQ0olvGE6fqZ5GDG57evA2kt+/BcLw/+2eMmHU+4fFssS9GZtOks6vrohPK8LI19vYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M52Zl0hrGQFuy2wUA01pwyobzHeuRwoHzmrnMjIc2A4=;
 b=mqkLuWM+5XBH8RNzDOFTlGSxAuBG4M+RQdjkN+NHZSz7V1JSH/AEIP0RGrs7ctYCIZxMFXUcGUGU2zvxwwye13bhmaFpxtTTaMZu23AdMCXYlJsVmj+YIMVrJC5OMn1NeExwoPVEflsGu2lS2rpwx9ZrSh4NrY8V0Wexn5HwDqyE8y9nv4rG7uZTRn5BbZ/r7ow0gfGqSWmZN31F4YLmSvKbjozsVnDPc2BP9NDfAJSJ1+YIl+EI8eRMlF8UBBh28jtvvBtFrZ2DzPGryF4h1lni9oo+tRa/78dNoxnJUmgO4wAimnCgCfcpap1abaqZ4X6lCTmFkwQh3Or4M07zGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 220.128.110.84) smtp.rcpttodomain=kernel.org smtp.mailfrom=aaeon.com.tw;
 dmarc=none action=none header.from=aaeon.com.tw; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aaeon365.onmicrosoft.com; s=selector2-aaeon365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M52Zl0hrGQFuy2wUA01pwyobzHeuRwoHzmrnMjIc2A4=;
 b=j7rayPNkKqdBfLNdLOtrH2FpFSUwTR2jpdgwIsAZi7W+6z+NmH5aEM8kq2X7FPJkOw1vKq+YzxDnOhOjVnj+q/g5uwZwCXQrEsFu1uPijH4ONALlLIG3lW2CVycaSvOqm2lh+4G3H2wEInr9UmF+q4/pyzp+u8xsKyPBrTnEdxg=
Received: from PS1PR03CA0009.apcprd03.prod.outlook.com (2603:1096:803:3d::21)
 by TY2PR02MB4384.apcprd02.prod.outlook.com (2603:1096:404:8003::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 17 Dec
 2021 02:44:37 +0000
Received: from HK2APC01FT063.eop-APC01.prod.protection.outlook.com
 (2603:1096:803:3d:cafe::cd) by PS1PR03CA0009.outlook.office365.com
 (2603:1096:803:3d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.8 via Frontend
 Transport; Fri, 17 Dec 2021 02:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 220.128.110.84) smtp.mailfrom=aaeon.com.tw; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aaeon.com.tw;
Received-SPF: PermError (protection.outlook.com: domain of aaeon.com.tw used
 an invalid SPF mechanism)
Received: from mobile.aaeon.com.tw (220.128.110.84) by
 HK2APC01FT063.mail.protection.outlook.com (10.152.249.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.16 via Frontend Transport; Fri, 17 Dec 2021 02:44:37 +0000
Received: from EXG2016.aaeon.com.tw (172.16.1.15) by EXG2016.aaeon.com.tw
 (172.16.1.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Fri, 17 Dec
 2021 10:44:36 +0800
Received: from EXG2016.aaeon.com.tw ([fe80::8857:e9e2:856a:7c34]) by
 EXG2016.aaeon.com.tw ([fe80::8857:e9e2:856a:7c34%4]) with mapi id
 15.01.1531.003; Fri, 17 Dec 2021 10:44:36 +0800
From:   <Kunyang_Fan@aaeon.com.tw>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <Jonathan.Cameron@huawei.com>,
        <andy.shevchenko@gmail.com>, <Jacob_Wu@asus.com>
Subject: RE: [PATCH v2] iio: adc: ti-adc081c: Partial revert of removal of
 ACPI IDs
Thread-Topic: [PATCH v2] iio: adc: ti-adc081c: Partial revert of removal of
 ACPI IDs
Thread-Index: AQHX6fzFBPNQ/1TCh0OM8qg40ONKj6woOAVwgAbc4oCABf7ZgIAA8NHA
Date:   Fri, 17 Dec 2021 02:44:36 +0000
Message-ID: <115ef33b76bf4fc7893c65d7aefec1dc@aaeon.com.tw>
References: <20211205172728.2826512-1-jic23@kernel.org>
        <HK0PR04MB3074C424090A590237DC4173F66F9@HK0PR04MB3074.apcprd04.prod.outlook.com>
        <20211212162153.28810ff0@jic23-huawei> <20211216115547.60d3afe8@jic23-huawei>
In-Reply-To: <20211216115547.60d3afe8@jic23-huawei>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [118.163.110.208]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b0dff9a-1c99-4665-deb0-08d9c1072a97
X-MS-TrafficTypeDiagnostic: TY2PR02MB4384:EE_
X-LD-Processed: 56a2d4be-9fe3-430e-b539-7e13a4744857,ExtAddr
X-Microsoft-Antispam-PRVS: <TY2PR02MB4384B224469BD2BDF973C3DCAB789@TY2PR02MB4384.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbmJ2Rs9oAx4+VgDN3suWJS5d7p7UXXHhrYlgz+mUPqct0J5+sgsV5Ntty0R1v3iqlOUOlLvVj0gyujCx6b+oMIGEtu52Y5/EzE5fhYFSy7lPl4n5sSXRqNqiN3NPw5OT1/dGZIG4gS1e6Ck75CzwY3Visll6lLGF7GzdcU2Feyjv+rKNEXNRUmD/sUNJ73lM9chhkiFrT+MPXDb/nZM/GwsrIve8Ig/PkZ0sSLhXEC7Az/gYzxN8d+HOzxQbeEtk+xdSwXDZgsf06s600h39j38jdHmxAlxfh1d3BCN2cC2XnC7QQfVmOTw4YdAQ5dd3ZMkC8a5oDhYHfZbA50CSGA/+GeM38WdiGGjKynvzGj/HMzN3aeE+98Zhb0u9cYr8R1itaT0bdv/Xb5FPde2H3HFdAOtePWYqJWyQG/VhwnpXAFknXW3fHxKv46szkHyqxQYc5f5DwgZnidQW8F33EhDeC2+DIt4GlgwzMgZBMO/jc23iC1jraltLD8Q0u8gIjtVp+ZJuFgu9W4wtDcvsQAM94oZUMeGMnZqrfr/TAKTuwh0xgrOmuY66GvHetAsPscG2eKOu02Lait1QEcd46daGTUbr1tiTtAbFjRfJXb3jGrip07nP+nmGWs0/dDSpqWGIeoIiP/VsUnks6GTP7G3iF1f/rd58rcPNirrLZsrSeaX0qpqFrWrH22wucf+GjJlPZqFEmjlANJ5tBuInUNtBbJzra/Vh2YpUU6okA7b5c/I+npRz/B6zeH6LAurd72bePI0ZkZ7ur5W348XDA==
X-Forefront-Antispam-Report: CIP:220.128.110.84;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mobile.aaeon.com.tw;PTR:220-128-110-84.hinet-ip.hinet.net;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(7696005)(24736004)(36860700001)(81166007)(108616005)(2906002)(186003)(8676002)(70206006)(53546011)(55236004)(86362001)(70586007)(8936002)(26005)(40460700001)(356005)(2876002)(336012)(508600001)(83380400001)(6916009)(82310400004)(426003)(4326008)(2616005)(5660300002)(36906005)(316002)(54906003)(36756003)(47076005);DIR:OUT;SFP:1102;
X-OriginatorOrg: AAEON.COM.TW
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 02:44:37.2694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0dff9a-1c99-4665-deb0-08d9c1072a97
X-MS-Exchange-CrossTenant-Id: 56a2d4be-9fe3-430e-b539-7e13a4744857
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=56a2d4be-9fe3-430e-b539-7e13a4744857;Ip=[220.128.110.84];Helo=[mobile.aaeon.com.tw]
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT063.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR02MB4384
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sIA0KDQpBZGQgb25lIGxpbmUgIiBUZXN0ZWQtYnk6IEt1bnlhbmcgRmFuIDxr
dW55bmdfZmFuQGFhZW9uLmNvbS50dz4iIGluIHRoZSBwcmV2aW91cyBjb21taXQuIA0KDQpUaGFu
a3MsIA0KDQpLdW55YW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKb25h
dGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPiANClNlbnQ6IFRodXJzZGF5LCBEZWNlbWJl
ciAxNiwgMjAyMSA3OjU2IFBNDQpUbzogIkt1bnlhbmcgPT9VVEYtOD9CP1JtRnU/PSg9P1VURi04
P0I/Nkl5RDVaMms1bythPz0pXCIgPEt1bnlhbmdfRmFuQGFzdXMuY29tPiJAVFAtRERFSS0wMS5j
b3JwbmV0LmFzdXMNCkNjOiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBKb25hdGhhbiBDYW1l
cm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+OyBLdW55YW5nIEZhbiA8S3VueWFuZ19G
YW5AYWFlb24uY29tLnR3PjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwu
Y29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gaWlvOiBhZGM6IHRpLWFkYzA4MWM6IFBhcnRp
YWwgcmV2ZXJ0IG9mIHJlbW92YWwgb2YgQUNQSSBJRHMNCg0KT24gU3VuLCAxMiBEZWMgMjAyMSAx
NjoyMjoyMSArMDAwMA0KSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAamljMjMucmV0cm9zbnViLmNv
LnVrPiB3cm90ZToNCg0KPiBPbiBXZWQsIDggRGVjIDIwMjEgMDc6MzY6MTYgKzAwMDANCj4gS3Vu
eWFuZyBGYW4o6IyD5Z2k5o+aKSA8S3VueWFuZ19GYW5AYXN1cy5jb20+IHdyb3RlOg0KPiANCj4g
PiBIaSBKb25hdGhhbiwNCj4gPiANCj4gPiBUaGlzIHBhdGNoIGlzIGxvb2tlZCBnb29kIHRvIG1l
LCBhbmQgSSB1c2VkIG91ciBwcm9kdWN0IFVQLWV4dHJlbWVpMTEgdG8gdmVyaWZ5IEFEQyBBREMw
ODFDIGZ1bmN0aW9uLiAgDQo+IA0KPiBIaSBLdW5heWFuZywNCj4gDQo+IElmIHlvdSBjb3VsZCBn
aXZlIGEgZm9ybWFsIFRlc3RlZC1ieSB0YWcgdGhhdCB3b3VsZCBiZSBncmVhdC4NCkFib3ZlIGlz
IGNsb3NlIGVub3VnaCBJIHRoaW5rIHRoYXQgSSdsbCBhZGQgb25lLg0KDQpBcyBJIGRvbid0IGhh
dmUgYW55IG90aGVyIGZpeGVzIHF1ZXVlZCB1cCBhbmQgd2UgYXJlIG5lYXIgdGhlIGVuZCBvZiB0
aGUgY3ljbGUgSSBtYXkgd2VsbCBhZGQgdGhpcyB0byBhIHB1bGwgcmVxdWVzdCB0YXJnZXR0aW5n
IHRoZSBtZXJnZSB3aW5kb3cuDQoNCkZvciBub3csIGFwcGxpZWQgdG8gdGhlIGZpeGVzLXRvZ3Jl
ZyBicmFuY2ggb2YgaWlvLmdpdCBhbmQgbWFya2VkIGZvciBzdGFibGUuDQoNClRoYW5rcywNCg0K
Sm9uYXRoYW4NCg0KPiANCj4gSSdtIHJ1bm5pbmcgYSBiaXQgc2xvdyB0aGlzIHRoaXMgd2Vla2Vu
ZCBzbyB3aWxsIHRyeSB0byBwaWNrIHVwIA0KPiBvdXRzdGFuZGluZyBwYXRjaGVzIG1pZCB3ZWVr
Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4gSm9uYXRoYW4NCj4gDQo+ID4gDQo+ID4gVGhhbmtzLA0K
PiA+IA0KPiA+IEt1bnlhbmcNCj4gPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+ID4gU2VudDog
TW9uZGF5LCBEZWNlbWJlciA2LCAyMDIxIDE6MjcgQU0NCj4gPiBUbzogbGludXgtaWlvQHZnZXIu
a2VybmVsLm9yZw0KPiA+IENjOiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1
YXdlaS5jb20+OyBLdW55YW5nIEZhbiANCj4gPiA8S3VueWFuZ19GYW5AYWFlb24uY29tLnR3Pjsg
QW5keSBTaGV2Y2hlbmtvIA0KPiA+IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiA+IFN1
YmplY3Q6IFtQQVRDSCB2Ml0gaWlvOiBhZGM6IHRpLWFkYzA4MWM6IFBhcnRpYWwgcmV2ZXJ0IG9m
IHJlbW92YWwgDQo+ID4gb2YgQUNQSSBJRHMNCj4gPiANCj4gPiBGcm9tOiBKb25hdGhhbiBDYW1l
cm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+ID4gDQo+ID4gVW5mb3J0dWFuYXRl
bHkgYSBub24gc3RhbmRhcmRzIGNvbXBsaWFudCBBQ1BJIElEIGlzIGtub3duIHRvIGJlIGluIHRo
ZSB3aWxkIG9uIHNvbWUgQUFFT04gYm9hcmRzLg0KPiA+IA0KPiA+IFBhcnRseSByZXZlcnQgdGhl
IHJlbW92YWwgb2YgdGhlc2UgSURzIHNvIHRoYXQgQURDMDgxQyB3aWxsIGFnYWluIHdvcmsgKyBh
ZGQgYSBjb21tZW50IHRvIHRoYXQgYWZmZWN0IGZvciBmdXR1cmUgcmVmZXJlbmNlLg0KPiA+IA0K
PiA+IFdoaWxzdCBoZXJlIHVzZSBnZW5lcmljIGZpcm13YXJlIHByb3BlcnRpZXMgcmF0aGVyIHRo
YW4gdGhlIEFDUEkgc3BlY2lmaWMgaGFuZGxpbmcgcHJldmlvdXNseSBmb3VuZCBpbiB0aGlzIGRy
aXZlci4NCj4gPiANCj4gPiBSZXBvcnRlZC1ieTogS3VueWFuZyBGYW4gPEt1bnlhbmdfRmFuQGFh
ZW9uLmNvbS50dz4NCj4gPiBGaXhlczogYzQ1OGI3Y2EzZmQwICgiaWlvOmFkYzp0aS1hZGMwODFj
OiBEcm9wIEFDUEkgaWRzIHRoYXQgc2VlbSANCj4gPiB2ZXJ5IHVubGlrZWx5IHRvIGJlIG9mZmlj
aWFsLiIpDQo+ID4gVGVzdGVkLWJ5OiBLdW55YW5nIEZhbiA8S3VueWFuZ19GYW5AYWFlb24uY29t
LnR3Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVy
b25AaHVhd2VpLmNvbT4NCj4gPiBDYzogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29A
Z21haWwuY29tPg0KPiA+IC0tLQ0KPiA+IA0KPiA+IExvb2tpbmcgaWRlYWxseSBmb3IgYSB0ZXN0
ZWQtYnkgZm9yIHRoaXMgZnJvbSBLdW55YW5nIEZhbi4NCj4gPiANCj4gPiB2MjogVXNlIGdlbmVy
aWMgZmlybXdhcmUgcHJvcGVydGllcyBhcyBBbmR5IFNoZXZjaGVua28gcmlnaHRseSBzdWdnZXN0
ZWQuDQo+ID4gSSB0b29rIGl0IGEgYml0IGZ1cnRoZXIgdGhhbiBzdHJpY3RseSBuZWNlc3Nhcnkg
YXMgSSBkb24ndCBsaWtlIHB1dHRpbmcgZW51bXMgaW4gdGhlIGRyaXZlcl9kYXRhIG9ubHkgdG8g
dXNlIHRoZW0gdG8gaW5kZXggYSB0YWJsZSB3aGVuIHdlIGNvdWxkIGp1c3QgdXNlIHRoZSBwb2lu
dGVycyBkaXJlY3RseS4NCj4gPiANCj4gPiBOb3RlIHRoaXMgZHJpdmVyIGRvZXMgaGF2ZSBkZXZp
Y2UgdHJlZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gYnV0IA0KPiA+IHRoYXQncyBhIGpvYiBmb3Ig
YW5vdGhlciBkYXkuICBPciBtYXliZSBsYXRlciB0b2RheSBpZiBJIGdldCByZWFsbHkgDQo+ID4g
Ym9yZWQgdGhpcyBldmVuaW5nIDopDQo+ID4gDQo+ID4gIGRyaXZlcnMvaWlvL2FkYy90aS1hZGMw
ODFjLmMgfCAyMiArKysrKysrKysrKysrKysrKy0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
NyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lpby9hZGMvdGktYWRjMDgxYy5jIA0KPiA+IGIvZHJpdmVycy9paW8vYWRjL3RpLWFk
YzA4MWMuYyBpbmRleCAxNmZjNjA4ZGIzNmEuLmJkNDhiMDczZTcyMCANCj4gPiAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvdGktYWRjMDgxYy5jDQo+ID4gKysrIGIvZHJpdmVycy9p
aW8vYWRjL3RpLWFkYzA4MWMuYw0KPiA+IEBAIC0xOSw2ICsxOSw3IEBADQo+ID4gICNpbmNsdWRl
IDxsaW51eC9pMmMuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICAjaW5j
bHVkZSA8bGludXgvbW9kX2RldmljZXRhYmxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wcm9w
ZXJ0eS5oPg0KPiA+IA0KPiA+ICAjaW5jbHVkZSA8bGludXgvaWlvL2lpby5oPg0KPiA+ICAjaW5j
bHVkZSA8bGludXgvaWlvL2J1ZmZlci5oPg0KPiA+IEBAIC0xNTYsMTMgKzE1NywxNiBAQCBzdGF0
aWMgaW50IGFkYzA4MWNfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwgIHsNCj4gPiAg
ICAgICAgIHN0cnVjdCBpaW9fZGV2ICppaW87DQo+ID4gICAgICAgICBzdHJ1Y3QgYWRjMDgxYyAq
YWRjOw0KPiA+IC0gICAgICAgc3RydWN0IGFkY3h4MWNfbW9kZWwgKm1vZGVsOw0KPiA+ICsgICAg
ICAgY29uc3Qgc3RydWN0IGFkY3h4MWNfbW9kZWwgKm1vZGVsOw0KPiA+ICAgICAgICAgaW50IGVy
cjsNCj4gPiANCj4gPiAgICAgICAgIGlmICghaTJjX2NoZWNrX2Z1bmN0aW9uYWxpdHkoY2xpZW50
LT5hZGFwdGVyLCBJMkNfRlVOQ19TTUJVU19XT1JEX0RBVEEpKQ0KPiA+ICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gDQo+ID4gLSAgICAgICBtb2RlbCA9ICZhZGN4eDFj
X21vZGVsc1tpZC0+ZHJpdmVyX2RhdGFdOw0KPiA+ICsgICAgICAgaWYgKGRldl9md25vZGUoJmNs
aWVudC0+ZGV2KSkNCj4gPiArICAgICAgICAgICAgICAgbW9kZWwgPSBkZXZpY2VfZ2V0X21hdGNo
X2RhdGEoJmNsaWVudC0+ZGV2KTsNCj4gPiArICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAg
ICAgbW9kZWwgPSAmYWRjeHgxY19tb2RlbHNbaWQtPmRyaXZlcl9kYXRhXTsNCj4gPiANCj4gPiAg
ICAgICAgIGlpbyA9IGRldm1faWlvX2RldmljZV9hbGxvYygmY2xpZW50LT5kZXYsIHNpemVvZigq
YWRjKSk7DQo+ID4gICAgICAgICBpZiAoIWlpbykNCj4gPiBAQCAtMjEwLDEwICsyMTQsMTcgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkIGFkYzA4MWNfaWRbXSANCj4gPiA9IHsg
IH07ICBNT0RVTEVfREVWSUNFX1RBQkxFKGkyYywgYWRjMDgxY19pZCk7DQo+ID4gDQo+ID4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgYWNwaV9kZXZpY2VfaWQgYWRjMDgxY19hY3BpX21hdGNoW10gPSB7
DQo+ID4gKyAgICAgICAvKiBVc2VkIG9uIHNvbWUgQUFFT04gYm9hcmRzICovDQo+ID4gKyAgICAg
ICB7ICJBREMwODFDIiwgKGtlcm5lbF91bG9uZ190KSZhZGN4eDFjX21vZGVsc1tBREMwODFDXSB9
LA0KPiA+ICsgICAgICAgeyB9DQo+ID4gK307DQo+ID4gK01PRFVMRV9ERVZJQ0VfVEFCTEUoYWNw
aSwgYWRjMDgxY19hY3BpX21hdGNoKTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkIGFkYzA4MWNfb2ZfbWF0Y2hbXSA9IHsNCj4gPiAtICAgICAgIHsgLmNvbXBh
dGlibGUgPSAidGksYWRjMDgxYyIgfSwNCj4gPiAtICAgICAgIHsgLmNvbXBhdGlibGUgPSAidGks
YWRjMTAxYyIgfSwNCj4gPiAtICAgICAgIHsgLmNvbXBhdGlibGUgPSAidGksYWRjMTIxYyIgfSwN
Cj4gPiArICAgICAgIHsgLmNvbXBhdGlibGUgPSAidGksYWRjMDgxYyIsIC5kYXRhID0gJmFkY3h4
MWNfbW9kZWxzW0FEQzA4MUNdIH0sDQo+ID4gKyAgICAgICB7IC5jb21wYXRpYmxlID0gInRpLGFk
YzEwMWMiLCAuZGF0YSA9ICZhZGN4eDFjX21vZGVsc1tBREMxMDFDXSB9LA0KPiA+ICsgICAgICAg
eyAuY29tcGF0aWJsZSA9ICJ0aSxhZGMxMjFjIiwgLmRhdGEgPSANCj4gPiArICZhZGN4eDFjX21v
ZGVsc1tBREMxMjFDXSB9LA0KPiA+ICAgICAgICAgeyB9DQo+ID4gIH07DQo+ID4gIE1PRFVMRV9E
RVZJQ0VfVEFCTEUob2YsIGFkYzA4MWNfb2ZfbWF0Y2gpOyBAQCAtMjIyLDYgKzIzMyw3IEBAIHN0
YXRpYyBzdHJ1Y3QgaTJjX2RyaXZlciBhZGMwODFjX2RyaXZlciA9IHsNCj4gPiAgICAgICAgIC5k
cml2ZXIgPSB7DQo+ID4gICAgICAgICAgICAgICAgIC5uYW1lID0gImFkYzA4MWMiLA0KPiA+ICAg
ICAgICAgICAgICAgICAub2ZfbWF0Y2hfdGFibGUgPSBhZGMwODFjX29mX21hdGNoLA0KPiA+ICsg
ICAgICAgICAgICAgICAuYWNwaV9tYXRjaF90YWJsZSA9IGFkYzA4MWNfYWNwaV9tYXRjaCwNCj4g
PiAgICAgICAgIH0sDQo+ID4gICAgICAgICAucHJvYmUgPSBhZGMwODFjX3Byb2JlLA0KPiA+ICAg
ICAgICAgLmlkX3RhYmxlID0gYWRjMDgxY19pZCwNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+IA0K
PiA+IDxwPjwvcD4NCj4gPiANCj4gPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+ID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+IFRoaXMg
ZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyB0byBpdCBjb250YWluIGNvbmZpZGVudGlhbCBpbmZv
cm1hdGlvbiBhbmQgYXJlIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIHVzZSBvZiB0aGUgaW5kaXZp
ZHVhbCB0byB3aG9tIGl0IGlzIGFkZHJlc3NlZC5JZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50IG9yIHJlY2VpdmUgaXQgYWNjaWRlbnRhbGx5LCBwbGVhc2UgaW1tZWRpYXRlbHkg
bm90aWZ5IHRoZSBzZW5kZXIgYnkgZS1tYWlsIGFuZCBkZWxldGUgdGhlIG1lc3NhZ2UgYW5kIGFu
eSBhdHRhY2htZW50cyBmcm9tIHlvdXIgY29tcHV0ZXIgc3lzdGVtLCBhbmQgZGVzdHJveSBhbGwg
aGFyZCBjb3BpZXMuIElmIGFueSwgcGxlYXNlIGJlIGFkdmlzZWQgdGhhdCBhbnkgdW5hdXRob3Jp
emVkIGRpc2Nsb3N1cmUsIGNvcHlpbmcsIGRpc3RyaWJ1dGlvbiBvciBhbnkgYWN0aW9uIHRha2Vu
IG9yIG9taXR0ZWQgaW4gcmVsaWFuY2Ugb24gdGhpcywgaXMgaWxsZWdhbCBhbmQgcHJvaGliaXRl
ZC4gRnVydGhlcm1vcmUsIGFueSB2aWV3cyBvciBvcGluaW9ucyBleHByZXNzZWQgYXJlIHNvbGVs
eSB0aG9zZSBvZiB0aGUgYXV0aG9yIGFuZCBkbyBub3QgcmVwcmVzZW50IHRob3NlIG9mIEFTVVNU
ZUsuIFRoYW5rIHlvdSBmb3IgeW91ciBjb29wZXJhdGlvbi4NCj4gPiA9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+
ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPiANCg0KPHA+PC9wPg0KDQo=
