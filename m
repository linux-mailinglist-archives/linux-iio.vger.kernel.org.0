Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C214FE6E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 18:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgBBRFH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 12:05:07 -0500
Received: from mail-eopbgr70130.outbound.protection.outlook.com ([40.107.7.130]:55491
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbgBBRFH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 12:05:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9BzZ7uBzHzs+UtkVnnF/F1qSakVYPfIouUtWy17hgin5EyemJmuh5G93MUt+vIFIOWBL+4h4ownjZGEL6JnESOlsRHQSsFsUFFfFNcuuLFyRNygBB42R7YcbysPY8qnf+zcWOa2lR4CNTPRyKf9UVL3m8p/noml1WlLakqpi5r0rOgflW1xXus86hfY8hcXjBAltyZVyFlNDpOaPOWGuv7nPmViZPJS2BONFWTKvvtaDzlS/LqwWVkfVX+4l0o8Eartks0uTr86WUGvmnWK6bMbSejYS+Ww0XxT0GVj56EQA3+WDzhffxzxFLVtAKo3ynnZjY3zrqu1+a7JMMGlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYGiclrOoMzwvlO1n8OV4LA7Z76BNgY6k8Uk2KQ2+ds=;
 b=WlgTVuktkuZnQh9TpO4sH/lPR/kQTj+SS3fy/Fl23gPXsOkx7dg7DwU9x9umIpsLlsJN5uPh1+4jdIU7NtyTcTdBJkLStmCduFUZB25w9EnOrgx61GeZFd4BvNRLax7cbt00O/gW7vq9g2eZxLXH9P/4VlK0rv/7dv/Fv9pRkSDYxQ6xF3IZIRt9GwCchBceRalxeJNbgjd0SjD+uoCmDvXcTYcjZYfdORu0xyr8o1qgE3jABy8eJPeMP2aiJDATVUKjio/rzSZAXg+tVZb5+Lk37FApkMebrccgo5GNPj4d3tLyrrpo2KrdBApLvxzDIdHbSt8Dc4hNmV6QUEiXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=norphonic.com; dmarc=pass action=none
 header.from=norphonic.com; dkim=pass header.d=norphonic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trafsysas.onmicrosoft.com; s=selector2-trafsysas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYGiclrOoMzwvlO1n8OV4LA7Z76BNgY6k8Uk2KQ2+ds=;
 b=XcgSsnREIYEbIUIWH0oQL0QqomVknmNqHTDjXoyoT7gsRXJhnQC8lM4miHEUZhc7KmgkWdROdbrSQIeWqYGlVMoO07Sqtj0RoNKvc8mW2xi+xxYEvr2rVFGRlmbhvD/eMQvW2CcNfsl7FSI4eKAFoQPQU5QPqBKJh9Bfed70I6E=
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com (10.170.210.140) by
 DB6PR06MB3160.eurprd06.prod.outlook.com (10.170.215.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Sun, 2 Feb 2020 17:05:02 +0000
Received: from DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::d9df:8743:dbc9:e247]) by DB6PR06MB3048.eurprd06.prod.outlook.com
 ([fe80::d9df:8743:dbc9:e247%3]) with mapi id 15.20.2686.031; Sun, 2 Feb 2020
 17:05:02 +0000
From:   Eugene Zalkonnikov <ez@norphonic.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Thread-Topic: [PATCH v4 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Thread-Index: AQHV0jI26mO3EgqsO0utHrTw2eFhP6gIGj+AgAAWOPE=
Date:   Sun, 2 Feb 2020 17:05:02 +0000
Message-ID: <DB6PR06MB3048FDB25F41B31D6A0FC4BFCA010@DB6PR06MB3048.eurprd06.prod.outlook.com>
References: <101D4944-A6B0-4CF7-AF6E-A6196619E3CF@norphonic.com>,<20200202154205.66df20a0@archlinux>
In-Reply-To: <20200202154205.66df20a0@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ez@norphonic.com; 
x-originating-ip: [62.92.112.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1095ba13-b78c-46c7-b4c2-08d7a8020b34
x-ms-traffictypediagnostic: DB6PR06MB3160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR06MB31607C30868D1D74FE6890C3CA010@DB6PR06MB3160.eurprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:551;
x-forefront-prvs: 0301360BF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39830400003)(189003)(199004)(81166006)(81156014)(86362001)(33656002)(52536014)(9686003)(6916009)(316002)(55016002)(26005)(6506007)(508600001)(8676002)(5660300002)(2906002)(4326008)(7696005)(8936002)(66446008)(66946007)(66556008)(64756008)(66476007)(54906003)(76116006)(558084003)(186003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR06MB3160;H:DB6PR06MB3048.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: norphonic.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JMnN3vu09CYTL/qbLZBglAc6w3VYW++K74JDdk8HkXDmTCJF4AEv8hIuGXxm0UF5O3wXZizUbRW8RBu77ASpsIhLjaL3jkSo2NGY/od6hjggmd4a8p/Eu75+2Sxp2Vmoryint0TJ/s/T1Efdr24UVD7X3cOA9YSv8AOHV2oFMmLdRWq3OFJOCKynr/2lLUd8pyioBL9n1XQJ5szGGPm3RbEFGR3XOxMuiRGT6D9bcGxfFtMhr93PF6xwbqI7bAI0/DBeqjWFkMcBAkGr3PfdGSEh2jBdjZj5CueohuMMHFtG/1+MoVHv7z6/pr7FWrizkRZgibL0KKde938V0xzVyVqKtRYgh3klsSm+lu5rtKXu5O2RdbHK0uGsH/zj4vRXfK0esUTVSXTJd9969lIZTKal0WiOQWD8yQAo5g9adXC3cJ3Q+13IgjKV8R04xJAK
x-ms-exchange-antispam-messagedata: 3YEg+R/DqRoMolXjQiJ1ypjtTN+DgKuNE/VHkRvNRD4zUDgImE6PeGBH/HoT5rvn+U4XjXLd7eaQXYGDRceBp117nuLmjR90hPTiO7CQt/DtLudVQucxA5qTF+AmKyznG0HHFSvuofNRzbvdqxsQog==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: norphonic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1095ba13-b78c-46c7-b4c2-08d7a8020b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2020 17:05:02.6799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cbf3f496-45ad-415e-97cb-4e62d6cd974f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19nic1ABnMnb6MjYarSpzeBBRld55Vb8xLJOiwFb5OH0vburFJzyf9qw08kheXo934oTSxVTT/FMYX/x/TzvIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR06MB3160
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
=0A=
You mention some pending issue with dt-bindings on this but I have nothing =
in my inbox so far.=0A=
=0A=
--=0A=
  Eugene.=
