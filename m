Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9861A9B650
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2019 20:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390289AbfHWSn1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Aug 2019 14:43:27 -0400
Received: from mail-eopbgr820050.outbound.protection.outlook.com ([40.107.82.50]:40112
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732321AbfHWSn1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Aug 2019 14:43:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvgA/DuYcy3xMJyrCm2kKzdn1q6EPxGUcSgM1OXAVlnCwWScW3rAfiKDjHvWy3du60n+LbaEQatDW94RaYXRN/pF+MACUS43Odoj6FFDPi8D97yxrTzCGg9GqxyVURA2BKghqCAKQUb+3Rpfmz970zJowRNZhVf5rTnvqAj7GT3uHcZkOFWVQ60Pwtwn6NQBsmaMYIc7HpMjzSzgCdTqvN82Mg5bD4FEvQF5yOdU5BTmN+DXDpG/t7eFk0i9BjuaSGfyhdrRpYqHB4m/WWUGMOwkd9JVvTfls3oYYhq0wHrF6oOBmhxXW4RNFOGjQMBfYMq6gAkLmutShnedIw5qEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWAZms+YWNCGZj+EUsl/AuG3lc5DytrdA6AFHwtbqVU=;
 b=ND2uz4jUxlMkviQ4n/KJFikRvMzGeqxKxK0V91b0w0+e1DstNQ4FnDzKLemsu2VtsL4lnYD+8p9LshQK8Mke0qNXFIrm25jrUFOabDciiNom+vf23xSl8Ptc4nOwofqX5A4WF/MbnUDkn7wuRC4dmajKW+UABAMeS+vqAqNxZl0vG0XdQTVFQ6GTjiH7rjJpty3/xgPzDsReexzEek35DwEiIzvK9QZQL008vsId9/12UL1+IS8rf4mvSR6r5QEnTk6Bi4xpiO42UoZa5CmHyFfS6XBC2thyIRb0AmIsvGv5U5bwE76lAczs5Un0B1paBRgWtJabFkOEq9Gew5MYGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teejet.com; dmarc=pass action=none header.from=teejet.com;
 dkim=pass header.d=teejet.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sprayingsystems.onmicrosoft.com;
 s=selector2-sprayingsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWAZms+YWNCGZj+EUsl/AuG3lc5DytrdA6AFHwtbqVU=;
 b=Aq5uE/ljITiZ0XsXoO9VGUzJLhWQd5lwzmhpiuDokVA0+EVvESc0gBOBTMgWLFR6fy74H7wcAFUUjh+F995XKBa1AAcoKTcS3QDWgqxXSNET7ssYEmh6sJp2gn9w9USobAgp2VHJB8JvPFxt0xrEFFyU/r0IDlC4dfJrz0qoa4k=
Received: from DM5PR19MB1657.namprd19.prod.outlook.com (10.175.225.14) by
 DM5PR19MB1546.namprd19.prod.outlook.com (10.175.225.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 18:43:25 +0000
Received: from DM5PR19MB1657.namprd19.prod.outlook.com
 ([fe80::8cc9:43a6:4ba7:95ad]) by DM5PR19MB1657.namprd19.prod.outlook.com
 ([fe80::8cc9:43a6:4ba7:95ad%8]) with mapi id 15.20.2199.015; Fri, 23 Aug 2019
 18:43:25 +0000
From:   "Grim, Dennis" <Dennis.Grim@teejet.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: buffer read
Thread-Topic: buffer read
Thread-Index: AdVZ4JwdLx/k60FyQVWzw6A5k5S4IA==
Date:   Fri, 23 Aug 2019 18:43:24 +0000
Message-ID: <DM5PR19MB1657B9E3EE28C387B09DB1889EA40@DM5PR19MB1657.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dennis.Grim@teejet.com; 
x-originating-ip: [50.200.218.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87b544b1-0aea-4630-58b9-08d727f9c7f1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR19MB1546;
x-ms-traffictypediagnostic: DM5PR19MB1546:
x-microsoft-antispam-prvs: <DM5PR19MB1546FF7873A29523612B5FCB9EA40@DM5PR19MB1546.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39850400004)(136003)(376002)(366004)(199004)(189003)(2906002)(6506007)(6916009)(74316002)(478600001)(305945005)(6436002)(7736002)(71200400001)(55016002)(71190400001)(3846002)(53936002)(256004)(9686003)(486006)(66446008)(66556008)(5640700003)(76116006)(64756008)(66476007)(81166006)(25786009)(2351001)(7696005)(66066001)(476003)(33656002)(221733001)(3480700005)(2501003)(66946007)(99286004)(316002)(86362001)(7116003)(8676002)(4744005)(52536014)(8936002)(81156014)(186003)(6116002)(14454004)(5660300002)(26005)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR19MB1546;H:DM5PR19MB1657.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teejet.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7mrZIlqSamRhn/UwYsAy00fJRvaIfq4zdXIpAldZl3JrUNZDufLnfmQupJ1c/Tw4sbYnrJjQamZMJX4MtZDdp1Fm2SoiJL+LUQYQtHmrpEEK+cSvnti0lP8Pxy7o+vrHIVDsgMuIxA2KkdRznG1TSeebFdOLmipUYYfMl9LZM5SC1I2yUdh4Tu4H+o+bL6suJtwF2fBZX0MjzRu2hciCSL+EaFHCqlPUOoF4rTSjq5IE/XD/MIdkIEpkeWDtCiCb0qZ4io8yKfVUa/Bc1if7NZPnVwVtj3ljGjuOenVujifWfszIY3VyFn5YfsGSfLPp5ohdeFtf2YvsgZAK5NhCfa7opEv5yVU0/fbN27XckGEOUvdoTOud4LW+P1tieBQ80dP/mTzN5LXc/LuCd+0lcrQpU40BdzdztlNcUiR747k=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teejet.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b544b1-0aea-4630-58b9-08d727f9c7f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 18:43:24.9897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: db000de6-d154-412a-bd1b-47cf93f41d57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zI2ydDj2wlcFbvKbuS27PfMD2Gv6VeQqvnocitrlvClvo7ENMN9GjJfbd4avuXTIc5MUd0xsDDp4R8dHqVFkHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1546
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Linux 2.6.0, the read() in the following code does not block when the bu=
ffer is empty.

char data[1026];
int fd =3D open("/dev/iio:device0", O_RDONLY);
size_t count =3D read(fd, data, 1026);

count is 0.

Data pushed to the buffer with iio_push_to_buffers() does read correctly (a=
fter a trigger).

What might I be missing?

-Dennis






=20
