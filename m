Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4496105B3F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2019 21:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfKUUjs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Nov 2019 15:39:48 -0500
Received: from mail-eopbgr740095.outbound.protection.outlook.com ([40.107.74.95]:23452
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbfKUUjs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Nov 2019 15:39:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNUZXffy7IumjmUFM7I00rqKa2quaIofdfZVr6pKWQ4YRMg4STUxztH6yyzvmMQMWBjgrWysAggKTNq3gLCUYaNAITcs6ksXGL4E3GftvmzKMDCcqJiOtTdimG72YN9decxhkLDF90QV5Jv3VUNXRnywY15x59enQp4/v912IQg0clBm5hsmnTEX7DP7pGnZkXy9m3gxAsa6oeXb212Sq/fUsCIHTZJ5JBkFk7ArznXw8XmIzu3MO3+ikuhHuArfTDQFNH1d2yjV6/mqEor7mMimSg3Bu8RXocIdZjXlkDgaOc5Ynrck2htUcFWEHoGqZ6AsbQnU2ZXmRTm/7oWbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaYaGRC24jAO6w0z9E0KfXR3F+Z63XvgvkLt3FBPsE0=;
 b=YYvLGCM+5QoD2c50PGMVAIWR37iJP8hVL5tJYbel68W0UNQLdQ85G94tJ6HACrWd2Koww4NBWfmp1dt0HixDWzsI2J50yeXTcaV782bOSjgDeKE5ydpJieX/FWpA2jVGC5Mtt3Hjgkm1jQRzz5+c0WZYZIMT7tJIdd3Oc6sWH8wxQadsa+QJeQu8vib83H8YyGEDR8w9ntooP7PeLdARcKpVRIRFjM4bdefc6nvxkcSTFHHJ64S3V4WkkO+LGgKYgJXyOqghwB0rretoFV5+i+cx7yRWInWxXboDIq3ewhRXpAqv5w6BCAge869lpBxJEZzjnRbydg1dbjYZWMLxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=licor.com; dmarc=pass action=none header.from=licor.com;
 dkim=pass header.d=licor.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=licor.onmicrosoft.com;
 s=selector2-licor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaYaGRC24jAO6w0z9E0KfXR3F+Z63XvgvkLt3FBPsE0=;
 b=EwCSUfBgxo7bV/BuKDdyzqGfSmGfKHAVyl5jyZZfWNy27C4JA0Ye9BPySnF/s1EdzIOV+B6kkpdmQGKs7uZ+l8osbeHZtttMWDgZMGevD5lZ9wXXc9cfllQgCHqlnWMK17T8595HorVnEhAP/z/rJXZ2pvnleY85+YbfSc3JEls=
Received: from SN6PR08MB4768.namprd08.prod.outlook.com (52.135.102.13) by
 SN6PR08MB3933.namprd08.prod.outlook.com (52.132.127.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 20:39:42 +0000
Received: from SN6PR08MB4768.namprd08.prod.outlook.com
 ([fe80::21af:88a:148d:b2d2]) by SN6PR08MB4768.namprd08.prod.outlook.com
 ([fe80::21af:88a:148d:b2d2%7]) with mapi id 15.20.2474.018; Thu, 21 Nov 2019
 20:39:42 +0000
From:   Chris Lesiak <chris.lesiak@licor.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Matt Ranostay <mranostay@gmail.com>
CC:     Chris Lesiak <chris.lesiak@licor.com>
Subject: [PATCH] iio: humidity: hdc100x: fix IIO_HUMIDITYRELATIVE channel
 reporting
Thread-Topic: [PATCH] iio: humidity: hdc100x: fix IIO_HUMIDITYRELATIVE channel
 reporting
Thread-Index: AQHVoKvNhSpV1Ujz/UWh3pIZuD3RkA==
Date:   Thu, 21 Nov 2019 20:39:42 +0000
Message-ID: <20191121203932.17249-1-chris.lesiak@licor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2607:da00:300:7::2]
x-clientproxiedby: CH2PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:610:53::29) To SN6PR08MB4768.namprd08.prod.outlook.com
 (2603:10b6:805:6d::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chris.lesiak@licor.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6e61c5b-7a5f-452b-956e-08d76ec2f001
x-ms-traffictypediagnostic: SN6PR08MB3933:|SN6PR08MB3933:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB39338C728DFEED08C0A96B539A4E0@SN6PR08MB3933.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(376002)(39850400004)(346002)(136003)(199004)(189003)(386003)(186003)(86362001)(6116002)(36756003)(46003)(478600001)(6506007)(5660300002)(305945005)(2616005)(7736002)(14444005)(52116002)(4326008)(44832011)(256004)(8676002)(6512007)(107886003)(81166006)(81156014)(66556008)(64756008)(8936002)(66946007)(14454004)(66446008)(6486002)(66476007)(2906002)(4744005)(99286004)(25786009)(316002)(71190400001)(71200400001)(102836004)(6436002)(2501003)(1076003)(50226002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB3933;H:SN6PR08MB4768.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: licor.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7UeoxvEGk8WSHz5/I1tHmP3IdRbzwxiVWk69YEyxiHCLDPmCEi47xbUJgZyePOtrzFIKtZ/OcIfDBA5nIyCrbFj2f9JWssI71vZn0Vv2XRvsSmABkP9rTrgFty/BTcznsQPfDZGUvXWiha8BsC4iaxFPfk//kcqO/oYrpov9yAAe8LV8EI2AjzY/FoepjUesRVMEDK4iLLXhFdy/KocM3pB2nKwmNsuvpo/L3OnNJkBPvkVF2FBB4MqHXbFn2umpwqga6jokGJcuObN+dP+tvj+iI1gIANCrxHEuEaQgiULTv3SetVX6MGcem2h6O3k9r3AbHC/doBTdx8IRzToPGDFaSZkkFCV+3Rot+PAYOp2lXxLGNgY4Q1nSVUxlvqcXSSjh8tVcHktZ1hDJhk9w57xfriFBqz/+K/YfIuZhhtkM1oUVBn02HQA8vhohyZNj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: licor.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e61c5b-7a5f-452b-956e-08d76ec2f001
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 20:39:42.7719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 48c70abd-da5a-4c6c-86cb-5e003ca01574
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCYb8wIK/bJ5Gz5qU4rNKHcq4DHfK0tKZiuEMkLjAAY2h1ASEYwgo3OtBDCxaPUKetOGMA0YbPhWatLNUaUPQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB3933
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO_HUMIDITYRELATIVE channel was being incorrectly reported back
as percent when it should have been milli percent. This is via an
incorrect scale value being returned to userspace.

Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
---
 drivers/iio/humidity/hdc100x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.=
c
index 066e05f92081..ff6666ac5d68 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -229,7 +229,7 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
 			*val2 =3D 65536;
 			return IIO_VAL_FRACTIONAL;
 		} else {
-			*val =3D 100;
+			*val =3D 100000;
 			*val2 =3D 65536;
 			return IIO_VAL_FRACTIONAL;
 		}
--=20
2.21.0

