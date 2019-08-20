Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3BB96C6B
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 00:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfHTWeJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Aug 2019 18:34:09 -0400
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:9728
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730886AbfHTWeI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Aug 2019 18:34:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKodO17jhXPGrJcVp6PU+RuHfJL9OLl8pT8QL5/W61r5laNV76G5dFd6Ee2/iDgqrYyXRdxKC2kUl1cWEUbhKkVnxTPD2J6ZQ9FSNIGdOiD4uU4by2Z7cJaxKg8ktQ8RnM+3v6vu4Yo+YOLXjeUmFkWwzIewftnAXhjv1OLWoKG6M5475f8EvfWcpT2jQQqaG9kWUgWtgIvSxycPtam3T5/aFzEyvZEy4CpXByfndK5Imvb3DBYrU7NZusfljdeNuTU15huhdayJKws5VQ4k0LKCEs4MatKK0amLDZnnBAN5RP1ZQ81OINSziHW4u/XsnPLy24Fp4xy3gaE1fum+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhdPs/vDnu2MZBay/iPG7/82yGXj0L34DlmjrnL251g=;
 b=j2I4RZzuL/jtZBgIBmdFRCTiXux/NlRqtPhelb8gLK0Usjml3KU8P8MvtwQMITdYbRW07jLqLJY7cWhVWykSPjmw8UkRznhHTTeq6pkC7XZsu9M0+DASyuu67QXg+zk64sOtMsft0MB+4kHmvzmUEiGX3FJLrxHKgsSSHIADvCzPYYMMkuofeBbCns9BfZTOpXHrU1IfRlOpagWa8siekG/0iKewbkGCFq8q7STDblZ+nTMEcqJiVn0piMWZzTcdk1tx9V1qsLGO2zpro9nku0nG/fn+R8CJGCCAKeeQ3aKJK7bWo6J+JiGI5S9myv+/Y24XDKQa3ZQ5eWSTybMrvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teejet.com; dmarc=pass action=none header.from=teejet.com;
 dkim=pass header.d=teejet.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sprayingsystems.onmicrosoft.com;
 s=selector2-sprayingsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhdPs/vDnu2MZBay/iPG7/82yGXj0L34DlmjrnL251g=;
 b=BLbafC5pH7Z2ynroy5eKpvd2ffQ8clo5s318EWZ8MnGC/gBlSZF5yEFCTkJNeDw+j8AEOGjP1YkH+jhFJwI7xqyxnWbZYbgeJu4XNdPiqnFC7ySSsGn/VRSyk55dKzKnjxG/P8ttUzQUdLEZAQmPrUeXRcff3dRer5H8DfDukTk=
Received: from DM5PR19MB1657.namprd19.prod.outlook.com (10.175.225.14) by
 DM5PR19MB1065.namprd19.prod.outlook.com (10.168.120.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 22:34:05 +0000
Received: from DM5PR19MB1657.namprd19.prod.outlook.com
 ([fe80::b418:cadc:dd34:a026]) by DM5PR19MB1657.namprd19.prod.outlook.com
 ([fe80::b418:cadc:dd34:a026%9]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 22:34:05 +0000
From:   "Grim, Dennis" <Dennis.Grim@teejet.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: read buffer
Thread-Topic: read buffer
Thread-Index: AdVXpTomRlJNGd+iRMKoPosSxhi+NQ==
Date:   Tue, 20 Aug 2019 22:34:05 +0000
Message-ID: <DM5PR19MB1657A46C8631408A8D0989049EAB0@DM5PR19MB1657.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dennis.Grim@teejet.com; 
x-originating-ip: [50.200.218.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53a64919-0200-4916-fb42-08d725be8262
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR19MB1065;
x-ms-traffictypediagnostic: DM5PR19MB1065:
x-microsoft-antispam-prvs: <DM5PR19MB1065478582FDEBF80CA413839EAB0@DM5PR19MB1065.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(396003)(376002)(39850400004)(199004)(189003)(6436002)(76116006)(66556008)(64756008)(66476007)(9686003)(66446008)(5640700003)(558084003)(66946007)(74316002)(316002)(476003)(6116002)(486006)(2906002)(305945005)(55016002)(14454004)(7736002)(6506007)(25786009)(2351001)(7116003)(3846002)(478600001)(2501003)(7696005)(221733001)(3480700005)(256004)(186003)(81156014)(81166006)(8676002)(6916009)(102836004)(8936002)(33656002)(99286004)(53936002)(71200400001)(71190400001)(26005)(52536014)(66066001)(86362001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR19MB1065;H:DM5PR19MB1657.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teejet.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7PDJn/MlY9Qlox+Nd12z+4A2sdwNlsYXpAqwGvZg3161vvUARd7SmvEYzGp3X8aCE392oh+IDQi6in08ZzBIW7h29316hjZg4VJc12O/YKSp50P67dZo0dZYaL/lTrv3BuUmvAaEkz5L6Eqa/GVRWz1nrD2BTP25Q5LZw1Gh1dxE2nvacbUW+1nHLTb6sBZTcFLeJBw4LsJ0zAQnZ7cM3xK+jlc9jjq//M3UciWboPQVQupS3AE1vK8QquPfDHAnXmaNgJB6toxpJftjojaxRDA2EVRXV582z/o9j4UrO+93jlM6Jw11iwMkuPgxzUE+pqtJRKyRlCneJYwAFjDcNjfHtOaIVdEb48UpOSIuJZqqphM7UBoq/G7+SskBgHvHEUQMj13WSIUdknTZsidpAnOKdWo6s2fp0mpGT6B1HuQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teejet.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a64919-0200-4916-fb42-08d725be8262
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 22:34:05.5744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: db000de6-d154-412a-bd1b-47cf93f41d57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: waMZZyu6zokBM5Urb6tvYX5ZUs3zkTDSJuak+Adr6fiZz5Qlli3q2ySQXsoGzfyIVMAXSkcoNbFdpeTdPDc8ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1065
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In user space, how is it known that data is available in a buffer (i.e. /de=
v/iio:device0)?  The buffer trigger happens on a separate thread.  I would =
like to do this without polling.  I have tried select() but it does not see=
m to see new data from iio_push_to_buffers.
