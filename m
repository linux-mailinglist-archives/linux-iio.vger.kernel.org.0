Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE82348645
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2019 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfFQO6E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jun 2019 10:58:04 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:1442
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbfFQO6E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Jun 2019 10:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sprayingsystems.onmicrosoft.com;
 s=selector2-sprayingsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2zPoOXld9s7/QWaDvyr/9C7DAsUTgHy/t7nyRiN+XI=;
 b=Mz/S6bQocFGw10SGyEoigyw9UoweuwvXWIP33Rl0HuMMBkg/sBcpp1Towu+UazB1q+BFwg8a9kIc72PyW//71uPxzeKII0bQMnm47xlN1RhbQdKJxp4PGik3rTYqcKt6tgmlwuFwD3GcMGhELh3BQc7U/y4WfOpC/coeZu52yGg=
Received: from DM5PR19MB1657.namprd19.prod.outlook.com (10.175.225.14) by
 DM5PR19MB0971.namprd19.prod.outlook.com (10.168.114.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Mon, 17 Jun 2019 14:58:02 +0000
Received: from DM5PR19MB1657.namprd19.prod.outlook.com
 ([fe80::8442:56af:29e2:a524]) by DM5PR19MB1657.namprd19.prod.outlook.com
 ([fe80::8442:56af:29e2:a524%6]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 14:58:02 +0000
From:   "Grim, Dennis" <Dennis.Grim@teejet.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: 
Thread-Index: AdUlHQ8WmK1I1VzXQpWMaJRIIJfcFQ==
Date:   Mon, 17 Jun 2019 14:58:02 +0000
Message-ID: <DM5PR19MB165765D43BE979AB51A9897E9EEB0@DM5PR19MB1657.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dennis.Grim@teejet.com; 
x-originating-ip: [50.200.218.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b7e58d2-bd9b-4549-f45b-08d6f3343250
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR19MB0971;
x-ms-traffictypediagnostic: DM5PR19MB0971:
x-microsoft-antispam-prvs: <DM5PR19MB09719426875262FA1A66D0089EEB0@DM5PR19MB0971.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39850400004)(136003)(376002)(189003)(199004)(9686003)(256004)(2906002)(72206003)(86362001)(5406001)(6116002)(3846002)(5660300002)(26005)(2501003)(68736007)(71190400001)(6506007)(7696005)(316002)(99286004)(25636003)(102836004)(478600001)(186003)(52536014)(476003)(305945005)(7736002)(81156014)(81166006)(6436002)(8936002)(71200400001)(486006)(66446008)(5416005)(73956011)(14454004)(66946007)(2351001)(74316002)(6916009)(66066001)(25786009)(53936002)(33656002)(76116006)(66556008)(66476007)(64756008)(55016002)(558084003)(5640700003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR19MB0971;H:DM5PR19MB1657.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teejet.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JgzGFbDxJ7uLeE6iiH5xF+ehdWmkHbbUURgqV+ccdPpIw3EI3uht2VH3YhDEGjCQUMltwtLvbbLxc3B6ghP3WovN2duardORwBqfKDoIk0FflsQ6LP4L6c9U3gyOa51k32LSyvoEzomIPFcI8HKyJlJp1lsplL7kHGL2nOw0mvus2EKC5YXNERFyTzInf7jvCspwW8VeRXnUFy1+OqY1biZoMMUrxn5SclLbZ9fd3WflaXzEFoT+4Tvb4Kkr7s/I5OthuGZhYWz57tH3KWlnP91GgptxoofWQHBom+VZ8CxvaSfwKaSi2l/xW7f0N8ltsU9C693cJbcr9108dpHitvTg6WeZ5PdqqPtSdKMpl8pr8SDl73sAsMQYCQJTjH3+GgUyBKYaF5V8zgTtNkwEkNaYRKbxEtB0vUiHoQq0bHk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teejet.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7e58d2-bd9b-4549-f45b-08d6f3343250
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 14:58:02.6067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: db000de6-d154-412a-bd1b-47cf93f41d57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dennis.Grim@teejet.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB0971
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Is Industrial IO considered to be stable in kernel-3.6.0?
