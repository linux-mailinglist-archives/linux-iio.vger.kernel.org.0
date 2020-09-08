Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74584261737
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 19:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbgIHR2Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 13:28:25 -0400
Received: from mail-vi1eur05on2047.outbound.protection.outlook.com ([40.107.21.47]:52768
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731707AbgIHQQD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Sep 2020 12:16:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwQ34DZn6Pqp2qwL0R4TtENa0zKg0oMbpxIQIeFJvNq6dgfpwa8Z8yQS37R4oSoxEB8PDl9sR9pZzUZTdFDGrrmDUlhysaRY0jqlD51XMx60ptvLspKxWHIQxRBjUoEhDMN1+DuciK60XekhHKqXqzzrjkPlNr5FsN1H0mV7Jpe4xP4q6MrMrZgj18JFc+53voxy3RZwgrPngzQMHZHKSzzotRo/Z4x7n13cQ+UCWhwtum4j5j7FW0owRNTvFkzGqGVkSEuEh+L6ZTNhNgerHWCw2p87RwRJxacwz8GN2dADsyQc0xJWpvRr7q1YJx4Rt5tIqWfguEoQwq7cpBkh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7veYResK+xShIKxiVLM9KqFFKbdh6r6JLbY4NRkdKA=;
 b=NEbCJVcD7YDV/n3OPW5PBETQFtlG5TFrvekclkB+1H5vBNvstfJeu7EcHk61s5stJl9qiHDkU6KQ9GFqFMXeHnTQUCb0vJpyacIAniq70bqYfn0Vud6pxCzHN4Xqz3Eedh6ZSqp+m8jsS1HJibW0I0n8T38HjUrt3DRt8Rh92uZmRwgZJ/RTT1BROXs9nowfG+YfFzQncwGY8PyJXUc1T1FDD05HWQxwpTm9ndP1XS69Ff0wN4ObUpa+SnOUGx0xOrpGtYwpmVeJtLxDzwde+wxfSOR2y1ZDNIhAdK400H2P1VqZzduCIc/4MoCErNulscV+sunFJQdmwxgZX2LAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7veYResK+xShIKxiVLM9KqFFKbdh6r6JLbY4NRkdKA=;
 b=vGEXREOiMJAsNI+tdeUpX+ZlVAXEWp45Mhh/SaAP8VRvtYBPWr3ivyMM5coXKzO0gASJIa/oT8hqKW7T/3nyBLkit88zrUa2qUn47se4XVR6k1kyexsBE6GMqkNsazzyW16fEz05ECC2KNC3CFwvCg0AP1MiuXnqhPeDfddPLJk=
Received: from AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:135::13)
 by AM7PR10MB3192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 12:07:51 +0000
Received: from AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b96f:25df:bfa7:a0f7]) by AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b96f:25df:bfa7:a0f7%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 12:07:51 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH 12/20] dt-bindings:iio:adc:dlg,da9150-gpadc yaml
 conversion
Thread-Topic: [PATCH 12/20] dt-bindings:iio:adc:dlg,da9150-gpadc yaml
 conversion
Thread-Index: AQHWg6qSjGzroNEmIEG+sjrNKzEHIaleqYFA
Date:   Tue, 8 Sep 2020 12:07:51 +0000
Message-ID: <AM7PR10MB3640E12A6CC1F226063F9C4680290@AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM>
References: <20200905173004.216081-1-jic23@kernel.org>
 <20200905173004.216081-13-jic23@kernel.org>
In-Reply-To: <20200905173004.216081-13-jic23@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae9fbfc9-0d43-425c-e7b4-08d853efcfa2
x-ms-traffictypediagnostic: AM7PR10MB3192:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR10MB319226DC63EEF7688DA8F822A7290@AM7PR10MB3192.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 653qlxdlKdyzaKBh0b/5HtUWL1O6faVQJTFSbGcGTMK+v7Xu9fqfnAAzM+Li5SSuI/Z95CDUqMgko/qXiF9EGXQj31EJCYWLsS4VqfE7UHwpkSgKrZfKHNhVd/8Gy7saosdBAmrk9vuZ+Jk3laJ8Vko8r0X513V+Uc8f4Tb6n1sKYhOyl120d7/YCCoMhyXWzbSQjNFg5entEyg+5mDqoO/YLFQ+3LH8FQ2+Ulw3ETnbvAUvHp+5bXCIYGF1naBgzAMygBv7cEccGQcFw759i1zCt/fAVcx85ior0PfiMsfCF9xYl4yshDxwhZV2V4wcbtDVt39Ho8orHrfLG8cGM2o+wsWHMXDjprFfTNJQ87lHiu1co4YPiqGNsh8xRWIE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66946007)(66476007)(66446008)(5660300002)(66556008)(4326008)(76116006)(54906003)(186003)(110136005)(107886003)(55016002)(7696005)(52536014)(33656002)(9686003)(4744005)(71200400001)(55236004)(8936002)(6506007)(53546011)(2906002)(26005)(8676002)(86362001)(498600001)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bNuzfo/p3mOf3SPVzEeyHlvVNAY5IcV8h7A07t5Z1tILmSHNHOswypi0DrZ794RrNUp0xkWQgHncxSgAuvAlIShbPZn7Rs86OxGF2dkdQU88ua0puqMVqvbWPB14rPck4Yewh8ATNZBI2tcVUJCFdiBGBXQVB+JZmTAngDhrJKXReBlb+BiU0v+LrhiChkleoXvSOgwAY/BYc9lvNhcnu7zYCZTJvatG3uW2AK1OqSAPTJQ0HP1CQkPN+Q1XuJ12j/yYgcsXXFtzLsQnBa328hgIYwHrYlY8Fwsm5iSSxJCi5z7z/OfOttcRZb7UHMeHncNfI6S3Hbfq6MJThsNyXJmB7c1fDMOH/RSzxgVF/9a4NzCSORnlzFbnBkdv16LRVaHucztBgJl/ywJjKH/X/QBCuv/AEqxgj6rh/811OBaJ8W1jmdoeDmmJ4z7yTD0vbxV110psvxY8+oYiA/8Pj9FoZev553ooivlSu0MhQXcyQoOJ0JGkqBgimYPgF/szDYv36IwOzpb3X5heIKy4zYzU9qr16hxSKNjoQm53CYwpLZdXr4ixIbQjWA3G22wjxseKE5FwYjE1ZP2hYNuCrAGb2MIchBSZrMSXhx9lJvIoy3YXj6szYNkPWNOid+bU4r2EtmEfU2S9iaB0Fk3nCA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9fbfc9-0d43-425c-e7b4-08d853efcfa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 12:07:51.7330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2hybho5MiYijkbBsGBLJWUa/URTokEpxsVCuItXZ4RrMgnYxmROp494SEnMNonQENLseVKGUtKpAd/ZVHi/d+IvhK9KMjS1jDkXozvywFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3192
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 05 September 2020 18:30, Jonathan Cameron wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This is a small part of an MFD so perhaps ultimately it makes more
> sense to document it with that MFD binding rather than separately.
>=20
> In the meantime it's a straightforward conversion from txt to yaml.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
