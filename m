Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD36D5BE5
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 09:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfJNHIW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 03:08:22 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:60420 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfJNHIV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2019 03:08:21 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: J+4SCdY1k2D8Hjvtd+33w+5EWzkwqhTQt7sZDYjS6s7Skml2wKAD69Q+hH9hlYd1vPYbfhu1sA
 jh1dQW1gKpkkYemSYXQZLT/CGeMacbMEGFZ6IMimAWVasqvnRsSzmipWl4XdpAN4Og1xNPO5zZ
 SxWL/mYu3HsZKjIplcesFCra+HY2kiDP4SOmXZ5jZFa4WQLM9/FtIVD8B7Sgu9RUicAjpLPgMu
 Y2ZFfGaQ9aVaZYlMYy4j7S83NhS2SI75ukKs1/ZPKoEonm1MCYzf9/A8wjwe8V8eQR81vCId08
 p/8=
X-IronPort-AV: E=Sophos;i="5.67,295,1566889200"; 
   d="scan'208";a="52818443"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Oct 2019 00:08:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Oct 2019 00:08:20 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 14 Oct 2019 00:08:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/ePu37spm1N/XXUgcT2yYwbvuK5ItyMlyUfc5gJUIqCqJ83XteUwGPn3sRXPc05cSCe5CuG9+grfBoZiB3X5o0l74K2+wlIHALwk4vdpGO5TkScVsIRCuU4q6sU4wQ6ZK8p3bqVlwnJps/BilxzH3Og50DJb6L29UZ7KwGuCWwQQN81mfOr+Eiep5Vi3jdKUb1o3s6ntIvMaz3nGWVres+xtNqFfubQaNU9f3bzWek5ckuYtFeQ8gNgWdTno/cdQShcRiQMTTjUY/RMUaNEHK6iV3v7kd7ucrc9ygZEC2ICkRMkF/0LnqYcdhzvJy4iA85znkAciq/5hYIXjOZgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/TLglJapcCnMfkJDPf/xlp6a68he5zkqnQyXKV50uw=;
 b=hScMd0hvGd9lipflFiiQV6Je+t6BLUJIY145YQQRwzeEFLgycyd2k9Vsov4csENEMeVkqIOVETOyAzjXyp2W9tsOXOMowQ0BcRIqhMfsjtySur9GUTwQfCi0OAQwpesOQPEdsU5TAEtKxrtbaG+Hl6j0+ChFnDnueuAWGd6CsUtYrlcTndiHBN/M6ieykE6ajrZUbz4QxijNc0NzNCd1EZ/vb4QN1jpvbjK7i8Ll1gDqgrAyKnCpncDDHh/bWq/xdEJ6wGPuC8lRjrN5/i2VsTj/+OF8u+ufu/AX123AGPVvMFo00Utf5EtVFgsWPgtYO1zOLGBOI8zoG2A1UJbcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/TLglJapcCnMfkJDPf/xlp6a68he5zkqnQyXKV50uw=;
 b=dT+7ajprYE4iUa6sHm6pbSDd8uJLLO+KuVIphNa4Q68I/TDYExzdAGSGTtCaayrqVcv10jgBDEP9wCxSpd78vJHTubm3yq/oJzXoF47JcPsNNabTcq0fgInnRTKZEMZMXr3LzVzqEetPGoOlfgCwvappzF9MAdWUJyYQhUPLnRM=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0009.namprd11.prod.outlook.com (10.164.155.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 14 Oct 2019 07:08:15 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::b125:76c1:c9b1:34f4]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::b125:76c1:c9b1:34f4%10]) with mapi id 15.20.2347.021; Mon, 14 Oct
 2019 07:08:15 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio:adc:at91-sama5d2: Replace 0 with NULL when clearing
 some pointers.
Thread-Topic: [PATCH] iio:adc:at91-sama5d2: Replace 0 with NULL when clearing
 some pointers.
Thread-Index: AQHVgaScXsuc4bhqvk+DxRwF8D6j/qdZt3MA
Date:   Mon, 14 Oct 2019 07:08:15 +0000
Message-ID: <a5c95788-25fd-1efa-2eef-9172d84242db@microchip.com>
References: <20191013085723.1366012-1-jic23@kernel.org>
In-Reply-To: <20191013085723.1366012-1-jic23@kernel.org>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0044.eurprd02.prod.outlook.com
 (2603:10a6:802:14::15) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191014100239968
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6297d23e-76f2-4557-5e6c-08d75075487c
x-ms-traffictypediagnostic: DM5PR11MB0009:
x-microsoft-antispam-prvs: <DM5PR11MB0009980EDEDBE5176C308680E8900@DM5PR11MB0009.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:47;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(6246003)(66946007)(316002)(229853002)(6486002)(8676002)(4744005)(6512007)(6436002)(2906002)(4326008)(110136005)(478600001)(5660300002)(86362001)(14454004)(31696002)(305945005)(7736002)(486006)(36756003)(66066001)(256004)(71190400001)(71200400001)(3846002)(81156014)(6116002)(14444005)(99286004)(76176011)(26005)(31686004)(386003)(6506007)(53546011)(102836004)(186003)(446003)(11346002)(476003)(2616005)(52116002)(8936002)(66556008)(81166006)(66476007)(66446008)(2501003)(64756008)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0009;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EyCD1cW5JAMZvQcH5wt8QYmdoEgDroOn4WhUXzZx7f8NflNGXdulH5EgkEPn/Jr/TP0nzRM7sC+Q4zIap/qJbIwaHfk5JxzaNg3vRCy/Z7amqWRJRoVCvHheIUTjIkufLhySh269ZaN0f4A5/a566HA9e5EmXftknpTxz2Xq1+enQZSQUVvK/cioiPr6fsCrJZPd2lJD26L6JVsLM1f53XV2krCRJz8tgkt5vNImV1PE6FtqKJS7xtr0UHhxezsqGwtC0nKNh5ph2SWf3VtI7mIi0cKE8Q9bIjvq5z8XlaoVAYiVBN494b9x0rPdlUC/ZT0NOP2aWjFatXCX5ZlduP2WB2vG2ZdHDCwzgKCL3wtNGd8PZTWQFMMujDlhEKDWmMcTnxYla22TTzptH/+xFOpI7UypxbZXLRI09S/rd+c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D1E65684993D5479609384568A724C5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6297d23e-76f2-4557-5e6c-08d75075487c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 07:08:15.6519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TGuHQ1J63StQMd9rrjo0mOfvo1IR3dSVuRKROscyVbP6KpNd7eb+a78RHLBdo0iWai6dIWwRgIElVfafA6qWa92Ut1WuFRrm60lioQ0h/SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0009
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCk9uIDEzLjEwLjIwMTkgMTE6NTcsIGppYzIzQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206
IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gDQo+IENs
ZWFucyB1cCB0aGUgc3BhcnNlIHdhcm5pbmc6DQo+IA0KPiBDSEVDSyAgIGRyaXZlcnMvaWlvL2Fk
Yy9hdDkxLXNhbWE1ZDJfYWRjLmMNCj4gZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMu
YzoxNDg2OjMxOiB3YXJuaW5nOiBVc2luZyBwbGFpbiBpbnRlZ2VyIGFzIE5VTEwgcG9pbnRlcg0K
PiBkcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jOjE1MDk6MzE6IHdhcm5pbmc6IFVz
aW5nIHBsYWluIGludGVnZXIgYXMgTlVMTCBwb2ludGVyDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBK
b25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IENjOiBFdWdl
biBIcmlzdGV2IDxldWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KDQpSZXZpZXdl
ZC1ieTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0K
