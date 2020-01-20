Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE76F14242D
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 08:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgATHYz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 02:24:55 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:2446 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgATHYy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 02:24:54 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: hAV2Qb2TyZ1EON0HQxIJ5jdjp4pPbFR//j0uhz01lLmmNCfrDVa1eL4tMXEA/L60eo1VK8On9o
 aSk6FI6FaDveW7DAy2KyI5VElB5uqkhDR+e7TAnclz4h8JjH75xasDBrLykt0xMRnWj5V6Vo+5
 CK5fcA8lBVR/4jpusl94AdeTUkMPx55KAR/u8jo8OmQIC+mQd4OIXHWKGfae9ktpb6V+QT6USc
 ePOZXnSzLxYUR2H5vmelqeRRaljGTmR0ck11hihao0Vf7dTrzzDpTA0ZtO35tbjOAh4vOylxTz
 Gd0=
X-IronPort-AV: E=Sophos;i="5.70,341,1574146800"; 
   d="scan'208";a="61551494"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2020 00:24:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jan 2020 00:24:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 20 Jan 2020 00:24:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpLZ0JF+ItHsgJ2A1FLhIs60GUj4TfZ6A5sG3g9aDraoGxnKULTcbo8ztfdbL/vFPdlULJz3YonNLMS2aB5fqy70g0JG5jl/q7n+EC2w0XQQf2PShazmXD5YZNWsgsVSrr6aCziZqDId3UhZ/qWDyjKf8ym0gUZn2pPeu+euUjbZfP318Q6q5+iRCfQn2ZLGbIL9VPxAs6wPqAdtKG0jF/tYiGpNPpNP1DFbn6dMvwulvGQEXGCT7AEZEEHXXpT4ItdRC+1JQktlDEI7VpNhN44BKi5LreetLKXWDVLIpvglFh1KE/5Y6IOnDvk+DRCeep75oX30pNRhrzxesbRsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzW1hfTvD/mQZ3CIT+BZvGODJgbswQL8Mv1XaeWj4hY=;
 b=FyfYUtrh0tyzHiJkqCDWadZESAuU2+bXqQ86RoDNZtLQquGvYN+Mzn46joADYW4ERc3ckMg8BSMMGWIZj5BDXnqedLklywXLb8qgFmtoslC/wh6v0jt6IjlYdaFVvYB2j4o9ctK1J9O/8HCGP+UULNxDU0tiLXHzqxPd65gB8B8UN7F/S/uBakn/LAFisxdb/d5HhnPJ7bp3nNnJ94PjP6Isf9qR9audt9pykLyEU0caDCJglZjfk0QfJYoF7nxPxR9+hXhgRsGtZ44QC/2d6R5y5W0VbfoOezsAp5XpoDTrAEum14I8rz1lst4UPIPdgjI3DTh0wG4YRH8sklLvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzW1hfTvD/mQZ3CIT+BZvGODJgbswQL8Mv1XaeWj4hY=;
 b=ZWFEfb5BAk4ECoKPtLE3h9cBv0ZHg5WyUOpN19NhLduaJSvguPq9CFjo1vAJ7+Lx2vA5jKFuxH7CFJrnrluUYzT2fidlGlWG1+ygt0cz3EGvtDhfuvqJgf3EVYU2ENdj4Wtue8pktybpajK1m5cvkQEbgPxw/nfeGBw/Z7LavXA=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0010.namprd11.prod.outlook.com (10.164.155.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Mon, 20 Jan 2020 07:24:51 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e5f6:d07d:d7de:ce79%6]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 07:24:51 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Jonathan.Cameron@Huawei.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v2 3/3] iio: adc: at91-sama5d2_adc: update for other
 trigger usage
Thread-Topic: [PATCH v2 3/3] iio: adc: at91-sama5d2_adc: update for other
 trigger usage
Thread-Index: AQHVygn7rEZ0ai+1ZkerXwetHJ8ZDqfvJv2AgAQKGgA=
Date:   Mon, 20 Jan 2020 07:24:50 +0000
Message-ID: <feaf0731-331d-6aaf-fe34-4b60e2ef24ba@microchip.com>
References: <1578917098-9674-1-git-send-email-eugen.hristev@microchip.com>
 <1578917098-9674-4-git-send-email-eugen.hristev@microchip.com>
 <20200117174249.000011af@Huawei.com>
In-Reply-To: <20200117174249.000011af@Huawei.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c5a91b8-8d7e-4952-c951-08d79d79d698
x-ms-traffictypediagnostic: DM5PR11MB0010:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB00102E5FD075967B4702BA63E8320@DM5PR11MB0010.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(478600001)(2906002)(36756003)(54906003)(2616005)(64756008)(66446008)(76116006)(91956017)(31686004)(8676002)(6916009)(6506007)(4326008)(53546011)(5660300002)(71200400001)(31696002)(6512007)(66946007)(86362001)(26005)(186003)(66556008)(66476007)(8936002)(6486002)(316002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0010;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0OQh/R6efW0KeYu72jDw360/b+ejGJ9VhL4OSuAXrtY6MW9SKQWYi1RdKKzHBc1a1omIHYXs1HIE6wVpDMMDABHhYBb/mOUXjKp/Vu+B0OXpMkl9JhZGwIH5GEql2OcAXPq6fHBi+7BmqKapS9omzOWTarl9O2O2OH93WdWU991b7btqATZFn2D5mtpi98/GdsoDsJJUu0t8fXRSk/ijTtWHwpx9cP9O4WQWJ8Yy1JrOvgbLiv99k83PyTM0mQsb2KbjH5Ius/2uqq9qayuiFA2SM80M4zUB/PQewCi86xN15XBLx+uGDvdBoTAH1ZHxLuOLe26AStRHXkkCvnwvs1LD3+hGSC6XeraChFxM/CvtCXkp+imdqePSD7cobBQfeYtLtfOy0EdLL8UHNUouOUo8KcDKJqONaVaUnhUGjM+nJSzDczPwCyyvMBzRtLNz
Content-Type: text/plain; charset="utf-8"
Content-ID: <80D85FE49E55E24CAD0610C48B9A2629@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5a91b8-8d7e-4952-c951-08d79d79d698
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 07:24:51.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3FtrMRU+pwqDs2nevNPAhp/oghuuxeoRYkrxcnVEsBf39Qclf88vongYHjS1KiWtm0CTtIMLNKMZ8xB9pPJYg+JrrbMmH1L9LKpalm0D3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0010
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCk9uIDE3LjAxLjIwMjAgMTk6NDIsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQoNCj4gT24g
TW9uLCAxMyBKYW4gMjAyMCAxMjowNzoxMCArMDAwMA0KPiA8RXVnZW4uSHJpc3RldkBtaWNyb2No
aXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBFdWdlbiBIcmlzdGV2IDxldWdlbi5ocmlzdGV2
QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhpcyBjaGFuZ2Ugd2lsbCBhbGxvdyB0aGUgYXQ5MS1z
YW1hNWQyX2FkYyBkcml2ZXIgdG8gdXNlIG90aGVyIHRyaWdnZXJzDQo+PiB0aGFuIGl0J3Mgb3du
Lg0KPj4gSW4gcGFydGljdWxhciwgdGVzdGVkIHdpdGggdGhlIHN5c2ZzIHRyaWdnZXIuDQo+PiBU
byBiZSBhYmxlIHRvIGFjaGlldmUgdGhpcyBmdW5jdGlvbmFsaXR5LCBzb21lIGNoYW5nZXMgd2Vy
ZSByZXF1aXJlZDoNCj4+IDEpIERvIG5vdCBlbmFibGUvZGlzYWJsZSBjaGFubmVscyB3aGVuIGVu
YWJsaW5nL2Rpc2FibGluZyB0aGUgdHJpZ2dlci4NCj4+IFRoaXMgaXMgYmVjYXVzZSB0aGUgdHJp
Z2dlciBpcyBlbmFibGVkL2Rpc2FibGVkIG9ubHkgZm9yIG91ciB0cmlnZ2VyDQo+PiAob2J2aW91
c2x5KS4gV2UgbmVlZCBjaGFubmVscyBlbmFibGVkL2Rpc2FibGVkIHJlZ2FyZGxlc3Mgb2Ygd2hh
dCB0cmlnZ2VyIGlzDQo+PiBiZWluZyB1c2VkLg0KPj4gMikgQ29wZSB3aXRoIERNQSA6IERNQSBj
YW5ub3QgYmUgdXNlZCB3aGVuIHVzaW5nIGFub3RoZXIgdHlwZSBvZiB0cmlnZ2VyLg0KPj4gT3Ro
ZXIgdHJpZ2dlcnMgd29yayB0aHJvdWdoIHBvbGxmdW5jLCBzbyB3ZSBnZXQgcG9sbGVkIGFueXdh
eSBvbiBldmVyeSB0cmlnZ2VyLg0KPj4gVGh1cyB3ZSBoYXZlIHRvIG9idGFpbiBkYXRhIGF0IGV2
ZXJ5IHRyaWdnZXIuDQo+PiAzKSBXaGVuIHRvIHN0YXJ0IGNvbnZlcnNpb24/IFRoZSB1c3VhbCBw
b2xsZnVuYyAoc3RvcmUgdGltZSBmcm9tIHN1YnN5c3RlbSkNCj4+IHdvdWxkIGJlIGluIGhhcmQg
aXJxIGFuZCB0aGlzIHdvdWxkIGJlIGEgZ29vZCB3YXksIGJ1dCBjdXJyZW50IGlpbyBzdWJzeXN0
ZW0NCj4+IHJlY29tbWVuZHMgdG8gaGF2ZSBpdCBpbiB0aGUgdGhyZWFkZWQgaXJxLiBUaHVzIGFk
ZGluZyBzb2Z0d2FyZSBzdGFydA0KPj4gY29kZSBpbiB0aGlzIGhhbmRsZXIuDQo+PiA0KSBCdWZm
ZXIgY29uZmlnOiB3ZSBuZWVkIHRvIHNldHVwIGJ1ZmZlciByZWdhcmRsZXNzIG9mIG91ciBvd24g
ZGV2aWNlJ3MNCj4+IHRyaWdnZXIuIFdlIG1heSBnZXQgb25lIGF0dGFjaGVkIGxhdGVyLg0KPj4g
NSkgSVJRIGhhbmRsaW5nOiB3ZSB1c2Ugb3VyIG93biBkZXZpY2UgSVJRIG9ubHkgaWYgaXQncyBv
dXIgb3duIHRyaWdnZXINCj4+IGFuZCB3ZSBkbyBub3QgdXNlIERNQSAuIElmIHdlIHVzZSBETUEs
IHdlIHVzZSB0aGUgRE1BIGNvbnRyb2xsZXIncyBJUlEuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
RXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPiANCj4gK0NDIEFs
ZXhhbmRydSBhcyBoZSdzIGRvaW5nIGEgbG90IG9mIGNsZWFudXAgYXJvdW5kIHRoZSBidWZmZXIg
ZnVuY3Rpb25zLg0KPiBJJ2QgbGlrZSBBbGV4IHRvIHRha2UgYSBsb29rIGF0IHRoaXMuDQo+IA0K
PiBBIGZldyBjb21tZW50cyBpbmxpbmUgZnJvbSBtZS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEpv
bmF0aGFuDQo+IA0KPiANCj4gDQo+PiAtLS0NCj4+IENoYW5nZXMgaW4gdjI6DQo+PiAtIGFkYXB0
IHRvIHRoZSBzaXR1YXRpb24gb2YgaGF2aW5nIHRoZSBwcmV2aW91cyB0d28gcGF0Y2hlcyBhaGVh
ZCBpbiB0aGUgc2VyaWVzDQo+Pg0KPj4gICBkcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2Fk
Yy5jIHwgMTQwICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKyksIDY3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIGIvZHJpdmVycy9p
aW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYw0KPj4gaW5kZXggNDU0YTQ5My4uMzRkZjA0MyAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMNCj4+ICsrKyBi
L2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMNCj4+IEBAIC03MjgsNyArNzI4LDYg
QEAgc3RhdGljIGludCBhdDkxX2FkY19jb25maWd1cmVfdHJpZ2dlcihzdHJ1Y3QgaWlvX3RyaWdn
ZXIgKnRyaWcsIGJvb2wgc3RhdGUpDQo+PiAgICAgICAgc3RydWN0IGlpb19kZXYgKmluZGlvID0g
aWlvX3RyaWdnZXJfZ2V0X2RydmRhdGEodHJpZyk7DQo+PiAgICAgICAgc3RydWN0IGF0OTFfYWRj
X3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvKTsNCj4+ICAgICAgICB1MzIgc3RhdHVzID0gYXQ5
MV9hZGNfcmVhZGwoc3QsIEFUOTFfU0FNQTVEMl9UUkdSKTsNCj4+IC0gICAgIHU4IGJpdDsNCj4+
DQo+PiAgICAgICAgLyogY2xlYXIgVFJHTU9EICovDQo+PiAgICAgICAgc3RhdHVzICY9IH5BVDkx
X1NBTUE1RDJfVFJHUl9UUkdNT0RfTUFTSzsNCj4+IEBAIC03MzksNDUgKzczOCw2IEBAIHN0YXRp
YyBpbnQgYXQ5MV9hZGNfY29uZmlndXJlX3RyaWdnZXIoc3RydWN0IGlpb190cmlnZ2VyICp0cmln
LCBib29sIHN0YXRlKQ0KPj4gICAgICAgIC8qIHNldC91bnNldCBodyB0cmlnZ2VyICovDQo+PiAg
ICAgICAgYXQ5MV9hZGNfd3JpdGVsKHN0LCBBVDkxX1NBTUE1RDJfVFJHUiwgc3RhdHVzKTsNCj4+
DQo+PiAtICAgICBmb3JfZWFjaF9zZXRfYml0KGJpdCwgaW5kaW8tPmFjdGl2ZV9zY2FuX21hc2ss
IGluZGlvLT5udW1fY2hhbm5lbHMpIHsNCj4+IC0gICAgICAgICAgICAgc3RydWN0IGlpb19jaGFu
X3NwZWMgY29uc3QgKmNoYW4gPSBhdDkxX2FkY19jaGFuX2dldChpbmRpbywgYml0KTsNCj4+IC0g
ICAgICAgICAgICAgdTMyIGNvcjsNCj4+IC0NCj4+IC0gICAgICAgICAgICAgaWYgKCFjaGFuKQ0K
Pj4gLSAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gLSAgICAgICAgICAgICAvKiB0
aGVzZSBjaGFubmVsIHR5cGVzIGNhbm5vdCBiZSBoYW5kbGVkIGJ5IHRoaXMgdHJpZ2dlciAqLw0K
Pj4gLSAgICAgICAgICAgICBpZiAoY2hhbi0+dHlwZSA9PSBJSU9fUE9TSVRJT05SRUxBVElWRSB8
fA0KPj4gLSAgICAgICAgICAgICAgICAgY2hhbi0+dHlwZSA9PSBJSU9fUFJFU1NVUkUpDQo+PiAt
ICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+PiAtDQo+PiAtICAgICAgICAgICAgIGlm
IChzdGF0ZSkgew0KPj4gLSAgICAgICAgICAgICAgICAgICAgIGNvciA9IGF0OTFfYWRjX3JlYWRs
KHN0LCBBVDkxX1NBTUE1RDJfQ09SKTsNCj4+IC0NCj4+IC0gICAgICAgICAgICAgICAgICAgICBp
ZiAoY2hhbi0+ZGlmZmVyZW50aWFsKQ0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y29yIHw9IChCSVQoY2hhbi0+Y2hhbm5lbCkgfA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBCSVQoY2hhbi0+Y2hhbm5lbDIpKSA8PA0KPj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBBVDkxX1NBTUE1RDJfQ09SX0RJRkZfT0ZGU0VUOw0KPj4g
LSAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvciAmPSB+KEJJVChjaGFuLT5jaGFubmVsKSA8PA0KPj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEFUOTFfU0FNQTVEMl9DT1JfRElGRl9PRkZTRVQpOw0KPj4gLQ0K
Pj4gLSAgICAgICAgICAgICAgICAgICAgIGF0OTFfYWRjX3dyaXRlbChzdCwgQVQ5MV9TQU1BNUQy
X0NPUiwgY29yKTsNCj4+IC0gICAgICAgICAgICAgfQ0KPj4gLQ0KPj4gLSAgICAgICAgICAgICBp
ZiAoc3RhdGUpDQo+PiAtICAgICAgICAgICAgICAgICAgICAgYXQ5MV9hZGNfd3JpdGVsKHN0LCBB
VDkxX1NBTUE1RDJfQ0hFUiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgQklUKGNoYW4tPmNoYW5uZWwpKTsNCj4+IC0gICAgICAgICAgICAgZWxzZQ0KPj4gLSAgICAg
ICAgICAgICAgICAgICAgIGF0OTFfYWRjX3dyaXRlbChzdCwgQVQ5MV9TQU1BNUQyX0NIRFIsDQo+
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVChjaGFuLT5jaGFubmVs
KSk7DQo+PiAtICAgICB9DQo+PiAtICAgICAvKiBlbmFibGUgaXJxIG9ubHkgaWYgbm90IHVzaW5n
IERNQSAqLw0KPj4gLSAgICAgaWYgKHN0YXRlICYmICFzdC0+ZG1hX3N0LmRtYV9jaGFuKQ0KPj4g
LSAgICAgICAgICAgICBhdDkxX2FkY193cml0ZWwoc3QsIEFUOTFfU0FNQTVEMl9JRVIsIEFUOTFf
U0FNQTVEMl9JRVJfRFJEWSk7DQo+PiAtICAgICAvKiBkaXNhYmxlIGlycSBvbmx5IGlmIG5vdCB1
c2luZyBETUEgKi8NCj4+IC0gICAgIGlmICghc3RhdGUgJiYgIXN0LT5kbWFfc3QuZG1hX2NoYW4p
DQo+PiAtICAgICAgICAgICAgIGF0OTFfYWRjX3dyaXRlbChzdCwgQVQ5MV9TQU1BNUQyX0lEUiwg
QVQ5MV9TQU1BNUQyX0lFUl9EUkRZKTsNCj4+IC0NCj4+ICAgICAgICByZXR1cm4gMDsNCj4+ICAg
fQ0KPj4NCj4+IEBAIC05MDEsOSArODYxLDIyIEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfZG1hX3N0
YXJ0KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+PiAgICAgICAgcmV0dXJuIDA7DQo+PiAg
IH0NCj4+DQo+PiArc3RhdGljIGJvb2wgYXQ5MV9hZGNfYnVmZmVyX2NoZWNrX3VzZV9pcnEoc3Ry
dWN0IGlpb19kZXYgKmluZGlvLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBhdDkxX2FkY19zdGF0ZSAqc3QpDQo+PiArew0KPj4gKyAgICAgLyogaWYg
dXNpbmcgRE1BLCB3ZSBkbyBub3QgdXNlIG91ciBvd24gSVJRICh3ZSB1c2UgRE1BLWNvbnRyb2xs
ZXIpICovDQo+PiArICAgICBpZiAoc3QtPmRtYV9zdC5kbWFfY2hhbikNCj4+ICsgICAgICAgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICAgLyogaWYgdGhlIHRyaWdnZXIgaXMgbm90IG91cnMs
IHRoZW4gaXQgaGFzIGl0cyBvd24gSVJRICovDQo+PiArICAgICBpZiAoaWlvX3RyaWdnZXJfdmFs
aWRhdGVfb3duX2RldmljZShpbmRpby0+dHJpZywgaW5kaW8pKQ0KPj4gKyAgICAgICAgICAgICBy
ZXR1cm4gZmFsc2U7DQo+PiArICAgICByZXR1cm4gdHJ1ZTsNCj4+ICt9DQo+PiArDQo+PiAgIHN0
YXRpYyBpbnQgYXQ5MV9hZGNfYnVmZmVyX3Bvc3RlbmFibGUoc3RydWN0IGlpb19kZXYgKmluZGlv
X2RldikNCj4+ICAgew0KPj4gICAgICAgIGludCByZXQ7DQo+PiArICAgICB1OCBiaXQ7DQo+PiAg
ICAgICAgc3RydWN0IGF0OTFfYWRjX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+
Pg0KPj4gICAgICAgIC8qIGNoZWNrIGlmIHdlIGFyZSBlbmFibGluZyB0cmlnZ2VyZWQgYnVmZmVy
IG9yIHRoZSB0b3VjaHNjcmVlbiAqLw0KPj4gQEAgLTkyMSw5ICs4OTQsNDAgQEAgc3RhdGljIGlu
dCBhdDkxX2FkY19idWZmZXJfcG9zdGVuYWJsZShzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2KQ0K
Pj4gICAgICAgIHJldCA9IGF0OTFfYWRjX2RtYV9zdGFydChpbmRpb19kZXYpOw0KPj4gICAgICAg
IGlmIChyZXQpIHsNCj4+ICAgICAgICAgICAgICAgIGRldl9lcnIoJmluZGlvX2Rldi0+ZGV2LCAi
YnVmZmVyIHBvc3RlbmFibGUgZmFpbGVkXG4iKTsNCj4+ICsgICAgICAgICAgICAgaWlvX3RyaWdn
ZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0KPiANCj4gVGhpcyBzZWVtcyBvZGQg
Z2l2ZW4geW91IGhhdmUgY2FsbGVkIHRoZSBpaW9fdHJpZ2dlcmVkX2J1ZmZlcl9wb3N0ZW5hYmxl
IHlldC4uDQo+IFRoYXQgaXMgYmVsb3cuDQoNCkhpIEpvbmF0aGFuLA0KDQpZb3UgYXJlIHJpZ2h0
LCBJIHdpbGwgcmVtb3ZlIHRoaXMuDQoNCj4gDQo+PiAgICAgICAgICAgICAgICByZXR1cm4gcmV0
Ow0KPj4gICAgICAgIH0NCj4+DQo+PiArICAgICBmb3JfZWFjaF9zZXRfYml0KGJpdCwgaW5kaW9f
ZGV2LT5hY3RpdmVfc2Nhbl9tYXNrLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICBpbmRpb19k
ZXYtPm51bV9jaGFubmVscykgew0KPj4gKyAgICAgICAgICAgICBzdHJ1Y3QgaWlvX2NoYW5fc3Bl
YyBjb25zdCAqY2hhbiA9DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGF0OTFfYWRjX2NoYW5fZ2V0KGluZGlvX2RldiwgYml0KTsNCj4+ICsgICAgICAgICAgICAgdTMy
IGNvcjsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgaWYgKCFjaGFuKQ0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgIGNvbnRpbnVlOw0KPj4gKyAgICAgICAgICAgICAvKiB0aGVzZSBjaGFubmVsIHR5
cGVzIGNhbm5vdCBiZSBoYW5kbGVkIGJ5IHRoaXMgdHJpZ2dlciAqLw0KPj4gKyAgICAgICAgICAg
ICBpZiAoY2hhbi0+dHlwZSA9PSBJSU9fUE9TSVRJT05SRUxBVElWRSB8fA0KPj4gKyAgICAgICAg
ICAgICAgICAgY2hhbi0+dHlwZSA9PSBJSU9fUFJFU1NVUkUpDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+PiArDQo+PiArICAgICAgICAgICAgIGNvciA9IGF0OTFfYWRjX3Jl
YWRsKHN0LCBBVDkxX1NBTUE1RDJfQ09SKTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgaWYgKGNo
YW4tPmRpZmZlcmVudGlhbCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICBjb3IgfD0gKEJJVChj
aGFuLT5jaGFubmVsKSB8IEJJVChjaGFuLT5jaGFubmVsMikpIDw8DQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBBVDkxX1NBTUE1RDJfQ09SX0RJRkZfT0ZGU0VUOw0KPj4gKyAgICAg
ICAgICAgICBlbHNlDQo+PiArICAgICAgICAgICAgICAgICAgICAgY29yICY9IH4oQklUKGNoYW4t
PmNoYW5uZWwpIDw8DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFUOTFfU0FNQTVE
Ml9DT1JfRElGRl9PRkZTRVQpOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICBhdDkxX2FkY193cml0
ZWwoc3QsIEFUOTFfU0FNQTVEMl9DT1IsIGNvcik7DQo+PiArDQo+PiArICAgICAgICAgICAgIGF0
OTFfYWRjX3dyaXRlbChzdCwgQVQ5MV9TQU1BNUQyX0NIRVIsIEJJVChjaGFuLT5jaGFubmVsKSk7
DQo+PiArICAgICB9DQo+PiArDQo+PiArICAgICBpZiAoYXQ5MV9hZGNfYnVmZmVyX2NoZWNrX3Vz
ZV9pcnEoaW5kaW9fZGV2LCBzdCkpDQo+PiArICAgICAgICAgICAgIGF0OTFfYWRjX3dyaXRlbChz
dCwgQVQ5MV9TQU1BNUQyX0lFUiwgQVQ5MV9TQU1BNUQyX0lFUl9EUkRZKTsNCj4+ICsNCj4+ICAg
ICAgICByZXR1cm4gaWlvX3RyaWdnZXJlZF9idWZmZXJfcG9zdGVuYWJsZShpbmRpb19kZXYpOw0K
Pj4gICB9DQo+Pg0KPj4gQEAgLTk0NCwyMSArOTQ4LDExIEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNf
YnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4+ICAgICAgICBp
ZiAoIShpbmRpb19kZXYtPmN1cnJlbnRtb2RlICYgSU5ESU9fQUxMX1RSSUdHRVJFRF9NT0RFUykp
DQo+PiAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+DQo+PiAtICAgICAvKiBjb250
aW51ZSB3aXRoIHRoZSB0cmlnZ2VyZWQgYnVmZmVyICovDQo+PiAtICAgICByZXQgPSBpaW9fdHJp
Z2dlcmVkX2J1ZmZlcl9wcmVkaXNhYmxlKGluZGlvX2Rldik7DQo+PiAtICAgICBpZiAocmV0IDwg
MCkNCj4+IC0gICAgICAgICAgICAgZGV2X2VycigmaW5kaW9fZGV2LT5kZXYsICJidWZmZXIgcHJl
ZGlzYWJsZSBmYWlsZWRcbiIpOw0KPj4gLQ0KPj4gLSAgICAgaWYgKCFzdC0+ZG1hX3N0LmRtYV9j
aGFuKQ0KPj4gLSAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gLQ0KPj4gLSAgICAgLyogaWYg
d2UgYXJlIHVzaW5nIERNQSB3ZSBtdXN0IGNsZWFyIHJlZ2lzdGVycyBhbmQgZW5kIERNQSAqLw0K
Pj4gLSAgICAgZG1hZW5naW5lX3Rlcm1pbmF0ZV9zeW5jKHN0LT5kbWFfc3QuZG1hX2NoYW4pOw0K
Pj4gLQ0KPj4gICAgICAgIC8qDQo+PiAtICAgICAgKiBGb3IgZWFjaCBlbmFibGVkIGNoYW5uZWwg
d2UgbXVzdCByZWFkIHRoZSBsYXN0IGNvbnZlcnRlZCB2YWx1ZQ0KPj4gKyAgICAgICogRm9yIGVh
Y2ggZW5hYmxlIGNoYW5uZWwgd2UgbXVzdCBkaXNhYmxlIGl0IGluIGhhcmR3YXJlLg0KPj4gKyAg
ICAgICogSW4gdGhlIGNhc2Ugb2YgRE1BLCB3ZSBtdXN0IHJlYWQgdGhlIGxhc3QgY29udmVydGVk
IHZhbHVlDQo+PiAgICAgICAgICogdG8gY2xlYXIgRU9DIHN0YXR1cyBhbmQgbm90IGdldCBhIHBv
c3NpYmxlIGludGVycnVwdCBsYXRlci4NCj4+IC0gICAgICAqIFRoaXMgdmFsdWUgaXMgYmVpbmcg
cmVhZCBieSBETUEgZnJvbSBMQ0RSIGFueXdheQ0KPj4gKyAgICAgICogVGhpcyB2YWx1ZSBpcyBi
ZWluZyByZWFkIGJ5IERNQSBmcm9tIExDRFIgYW55d2F5LCBzbyBpdCdzIG5vdCBsb3N0Lg0KPj4g
ICAgICAgICAqLw0KPj4gICAgICAgIGZvcl9lYWNoX3NldF9iaXQoYml0LCBpbmRpb19kZXYtPmFj
dGl2ZV9zY2FuX21hc2ssDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICBpbmRpb19kZXYtPm51
bV9jaGFubmVscykgew0KPj4gQEAgLTk3MSwxMiArOTY1LDI4IEBAIHN0YXRpYyBpbnQgYXQ5MV9h
ZGNfYnVmZmVyX3ByZWRpc2FibGUoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldikNCj4+ICAgICAg
ICAgICAgICAgIGlmIChjaGFuLT50eXBlID09IElJT19QT1NJVElPTlJFTEFUSVZFIHx8DQo+PiAg
ICAgICAgICAgICAgICAgICAgY2hhbi0+dHlwZSA9PSBJSU9fUFJFU1NVUkUpDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICBhdDkxX2Fk
Y193cml0ZWwoc3QsIEFUOTFfU0FNQTVEMl9DSERSLCBCSVQoY2hhbi0+Y2hhbm5lbCkpOw0KPj4g
Kw0KPj4gICAgICAgICAgICAgICAgaWYgKHN0LT5kbWFfc3QuZG1hX2NoYW4pDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgIGF0OTFfYWRjX3JlYWRsKHN0LCBjaGFuLT5hZGRyZXNzKTsNCj4+ICAg
ICAgICB9DQo+Pg0KPj4gKyAgICAgaWYgKGF0OTFfYWRjX2J1ZmZlcl9jaGVja191c2VfaXJxKGlu
ZGlvX2Rldiwgc3QpKQ0KPj4gKyAgICAgICAgICAgICBhdDkxX2FkY193cml0ZWwoc3QsIEFUOTFf
U0FNQTVEMl9JRFIsIEFUOTFfU0FNQTVEMl9JRVJfRFJEWSk7DQo+PiArDQo+PiAgICAgICAgLyog
cmVhZCBvdmVyZmxvdyByZWdpc3RlciB0byBjbGVhciBwb3NzaWJsZSBvdmVyZmxvdyBzdGF0dXMg
Ki8NCj4+ICAgICAgICBhdDkxX2FkY19yZWFkbChzdCwgQVQ5MV9TQU1BNUQyX09WRVIpOw0KPj4g
Kw0KPj4gKyAgICAgLyogY29udGludWUgd2l0aCB0aGUgdHJpZ2dlcmVkIGJ1ZmZlciAqLw0KPj4g
KyAgICAgcmV0ID0gaWlvX3RyaWdnZXJlZF9idWZmZXJfcHJlZGlzYWJsZShpbmRpb19kZXYpOw0K
Pj4gKyAgICAgaWYgKHJldCA8IDApDQo+PiArICAgICAgICAgICAgIGRldl9lcnIoJmluZGlvX2Rl
di0+ZGV2LCAiYnVmZmVyIHByZWRpc2FibGUgZmFpbGVkXG4iKTsNCj4+ICsNCj4+ICsgICAgIC8q
IGlmIHdlIGFyZSB1c2luZyBETUEgd2UgbXVzdCBjbGVhciByZWdpc3RlcnMgYW5kIGVuZCBETUEg
Ki8NCj4+ICsgICAgIGlmIChzdC0+ZG1hX3N0LmRtYV9jaGFuKQ0KPj4gKyAgICAgICAgICAgICBk
bWFlbmdpbmVfdGVybWluYXRlX3N5bmMoc3QtPmRtYV9zdC5kbWFfY2hhbik7DQo+IA0KPiBUaGlz
IG9yZGVyaW5nIGlzIGdvaW5nIHRvIHN0b3AgQWxleCBkb2luZyBoaXMgcmV3b3JrIHRvIHJlbW92
ZSB0aGUgbmVlZA0KPiB0byBtYW51YWxseSBjYWxsIGlpb190cmlnZ2VyZWRfYnVmZmVyX3ByZWRp
c2FibGUuICBXaHkgZG9lcyBpdCBtYWtlDQo+IHNlbnNlIHRvIGRvIHRoZSBkbWEgc3R1ZmYgYWZ0
ZXIgdGhhdD8NCj4gDQo+IEFoIEkgc2VlIGl0IGFsd2F5cyBkaWQgYW5kIHRoZSBwb3N0ZW5hYmxl
IGlzIHRoZSBvcHBvc2l0ZSBvZiB3aGF0IEFsZXgNCj4gaGFzIGJlZW4gbW92aW5nIHRvIGFzIHdl
bGwuDQoNCk9rLCBzbyBrZWVwIGl0IGxpa2UgdGhpcyA/DQoNCj4gDQo+PiArDQo+PiAgICAgICAg
cmV0dXJuIHJldDsNCj4+ICAgfQ0KPj4NCj4+IEBAIC0xMTMxLDYgKzExNDEsMTMgQEAgc3RhdGlj
IGlycXJldHVybl90IGF0OTFfYWRjX3RyaWdnZXJfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpwKQ0K
Pj4gICAgICAgIHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBwZi0+aW5kaW9fZGV2Ow0KPj4g
ICAgICAgIHN0cnVjdCBhdDkxX2FkY19zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0K
Pj4NCj4+ICsgICAgIC8qDQo+PiArICAgICAgKiBJZiBpdCdzIG5vdCBvdXIgdHJpZ2dlciwgc3Rh
cnQgYSBjb252ZXJzaW9uIG5vdywgYXMgd2UgYXJlDQo+PiArICAgICAgKiBhY3R1YWxseSBwb2xs
aW5nIHRoZSB0cmlnZ2VyIG5vdy4NCj4+ICsgICAgICAqLw0KPj4gKyAgICAgaWYgKGlpb190cmln
Z2VyX3ZhbGlkYXRlX293bl9kZXZpY2UoaW5kaW9fZGV2LT50cmlnLCBpbmRpb19kZXYpKQ0KPj4g
KyAgICAgICAgICAgICBhdDkxX2FkY193cml0ZWwoc3QsIEFUOTFfU0FNQTVEMl9DUiwgQVQ5MV9T
QU1BNUQyX0NSX1NUQVJUKTsNCj4+ICsNCj4+ICAgICAgICBpZiAoc3QtPmRtYV9zdC5kbWFfY2hh
bikNCj4+ICAgICAgICAgICAgICAgIGF0OTFfYWRjX3RyaWdnZXJfaGFuZGxlcl9kbWEoaW5kaW9f
ZGV2KTsNCj4+ICAgICAgICBlbHNlDQo+PiBAQCAtMTE0MywyMCArMTE2MCw5IEBAIHN0YXRpYyBp
cnFyZXR1cm5fdCBhdDkxX2FkY190cmlnZ2VyX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqcCkNCj4+
DQo+PiAgIHN0YXRpYyBpbnQgYXQ5MV9hZGNfYnVmZmVyX2luaXQoc3RydWN0IGlpb19kZXYgKmlu
ZGlvKQ0KPj4gICB7DQo+PiAtICAgICBzdHJ1Y3QgYXQ5MV9hZGNfc3RhdGUgKnN0ID0gaWlvX3By
aXYoaW5kaW8pOw0KPj4gLQ0KPj4gLSAgICAgaWYgKHN0LT5zZWxlY3RlZF90cmlnLT5od190cmln
KSB7DQo+PiAtICAgICAgICAgICAgIHJldHVybiBkZXZtX2lpb190cmlnZ2VyZWRfYnVmZmVyX3Nl
dHVwKCZpbmRpby0+ZGV2LCBpbmRpbywNCj4+IC0gICAgICAgICAgICAgICAgICAgICAmaWlvX3Bv
bGxmdW5jX3N0b3JlX3RpbWUsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgJmF0OTFfYWRjX3Ry
aWdnZXJfaGFuZGxlciwgJmF0OTFfYnVmZmVyX3NldHVwX29wcyk7DQo+PiAtICAgICB9DQo+PiAt
ICAgICAvKg0KPj4gLSAgICAgICogd2UgbmVlZCB0byBwcmVwYXJlIHRoZSBidWZmZXIgb3BzIGlu
IGNhc2Ugd2Ugd2lsbCBnZXQNCj4+IC0gICAgICAqIGFub3RoZXIgYnVmZmVyIGF0dGFjaGVkIChs
aWtlIGEgY2FsbGJhY2sgYnVmZmVyIGZvciB0aGUgdG91Y2hzY3JlZW4pDQo+PiAtICAgICAgKi8N
Cj4+IC0gICAgIGluZGlvLT5zZXR1cF9vcHMgPSAmYXQ5MV9idWZmZXJfc2V0dXBfb3BzOw0KPj4g
LQ0KPj4gLSAgICAgcmV0dXJuIDA7DQo+PiArICAgICByZXR1cm4gZGV2bV9paW9fdHJpZ2dlcmVk
X2J1ZmZlcl9zZXR1cCgmaW5kaW8tPmRldiwgaW5kaW8sDQo+PiArICAgICAgICAgICAgICZpaW9f
cG9sbGZ1bmNfc3RvcmVfdGltZSwNCj4+ICsgICAgICAgICAgICAgJmF0OTFfYWRjX3RyaWdnZXJf
aGFuZGxlciwgJmF0OTFfYnVmZmVyX3NldHVwX29wcyk7DQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRp
YyB1bnNpZ25lZCBhdDkxX2FkY19zdGFydHVwX3RpbWUodW5zaWduZWQgc3RhcnR1cF90aW1lX21p
biwNCj4gDQo+IA0KPiA=
