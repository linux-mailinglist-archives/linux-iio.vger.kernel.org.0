Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B459967321
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2019 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGLQPZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jul 2019 12:15:25 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:38490 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbfGLQPZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2019 12:15:25 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ACD92C216D;
        Fri, 12 Jul 2019 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562948124; bh=P7341mapqEM/2PaPN+qiuIYqsp4u8llhQvF0wUm40y4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ONgB6x3KkWcDKxPYT5PB75GHsVqBrtdNmjdB/uOfN6E0t/cis+cVsWtIfzl5TCCrL
         hgLofINZAk99az0ko7Ih0dNX9h7IPVUh2p2N+bI4/xbQoULswvUdjelwZMNfQt5s9k
         ch/9zFxUrEFUa6F8DhpQzlKSei4VDRgKYROecbw/+PJkXFV++/9/RSI6RgKTCzm5/0
         C2ZKpfcbwAt3/c2mrVnc1w5D5PXXUjEUMAMq9DzDyNScm6Ez5M4gk4QcujvAgZiq5p
         Aan9SR81a5jHZ+czreZ/XeihQUdhlLNzJribhjCvMEHKirFhPhgjNLJJ8UDU6Wkokn
         uEcMuWsVV+PCA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 85B29A023B;
        Fri, 12 Jul 2019 16:15:13 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 12 Jul 2019 09:14:56 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 12 Jul 2019 09:14:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DZCbbUJWRlsEaT1FQNb7WKmjfb8RoDnR2qlj8ZAfbY=;
 b=lwT6Tzs5vrP3myPOi8NvHH+p6+B6BkAKd3BVFVgXrm1Vbm+1yx5KwZVRUWgp9rTl3sabWSPKGIkSIUukoRsEr3SvdWGfk9RjDIhXm6AU/gPE3qferVoNTWLmSaDCjiHP/rfhES+uVGVNokk+4r89zeuDj5QlAH9klL4uUN6eNWs=
Received: from SN6PR12MB2655.namprd12.prod.outlook.com (52.135.103.20) by
 SN6PR12MB2672.namprd12.prod.outlook.com (52.135.103.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Fri, 12 Jul 2019 16:14:54 +0000
Received: from SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::1dbd:69dc:e782:92b6]) by SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::1dbd:69dc:e782:92b6%6]) with mapi id 15.20.2073.012; Fri, 12 Jul 2019
 16:14:54 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH v4 1/3] regmap: add i3c bus support
Thread-Topic: [PATCH v4 1/3] regmap: add i3c bus support
Thread-Index: AQHVOKiAIa725p4WnEuCvwLFFA54lqbHJDGAgAAEDZA=
Date:   Fri, 12 Jul 2019 16:14:53 +0000
Message-ID: <SN6PR12MB26554B97ADDB5E248844E97FAEF20@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1562931742.git.vitor.soares@synopsys.com>
        <7deb1300474b68ebb6fc3ecb02577e4f657250a5.1562931742.git.vitor.soares@synopsys.com>
 <20190712175915.4c4260a9@linux.home>
In-Reply-To: <20190712175915.4c4260a9@linux.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMmM4ZjE4NDItYTRjMC0xMWU5LTgyNGItYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDJjOGYxODQ0LWE0YzAtMTFlOS04MjRiLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iNjMxOSIgdD0iMTMyMDc0MjE2OTEwMDMx?=
 =?us-ascii?Q?OTM3IiBoPSJyTzdlclN5eHlCZ3VvZ3hCdk82U0VIN2p3Yk09IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUJC?=
 =?us-ascii?Q?RE9udXpEalZBUUhCWDFkQi9OdFNBY0ZmVjBIODIxSU9BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQVZ6ZGhHZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCaEFH?=
 =?us-ascii?Q?MEFjd0IxQUc0QVp3QmZBSElBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpBRzBBYVFCakFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQWRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFkQUJ6?=
 =?us-ascii?Q?QUcwQVl3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCMUFHMEFZd0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWndCMEFITUFYd0J3QUhJQWJ3QmtBSFVBWXdCMEFGOEFk?=
 =?us-ascii?Q?QUJ5QUdFQWFRQnVBR2tBYmdCbkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?R0VBYkFCbEFITUFYd0JoQUdNQVl3QnZBSFVBYmdCMEFGOEFjQUJzQUdFQWJn?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhNQVlRQnNBR1VBY3dCZkFI?=
 =?us-ascii?Q?RUFkUUJ2QUhRQVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdV?=
 =?us-ascii?Q?QVh3QjBBR1VBY2dCdEFGOEFNUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHNEFjQUJ6QUY4QWJBQnBBR01BWlFCdUFITUFaUUJmQUhRQVpRQnlBRzBB?=
 =?us-ascii?Q?WHdCekFIUUFkUUJrQUdVQWJnQjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSFlBWndCZkFHc0FaUUI1?=
 =?us-ascii?Q?QUhjQWJ3QnlBR1FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=soares@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c6a9948-50e3-490a-1bff-08d706e4133f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2672;
x-ms-traffictypediagnostic: SN6PR12MB2672:
x-microsoft-antispam-prvs: <SN6PR12MB26721B3CB0804713ED6056DDAEF20@SN6PR12MB2672.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(74316002)(3846002)(6116002)(33656002)(8936002)(81156014)(86362001)(6506007)(26005)(229853002)(305945005)(54906003)(81166006)(110136005)(8676002)(7736002)(478600001)(102836004)(99286004)(316002)(186003)(2906002)(7696005)(4326008)(25786009)(71190400001)(476003)(76176011)(6436002)(256004)(14444005)(6246003)(107886003)(9686003)(53936002)(55016002)(71200400001)(446003)(486006)(11346002)(76116006)(52536014)(5660300002)(66066001)(64756008)(66556008)(66476007)(66946007)(68736007)(66446008)(6636002)(14454004)(5024004)(42413003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2672;H:SN6PR12MB2655.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /8mXkWo8v97S9ZqqMAKBpo8RjWYs2xr7sbzO7/3EvvdvjYbmh3RS5p6AL6JuqC8Q3sYGL8vPwlyL+382LNFFlaxCdqznyBkEQIj1Gj+YgghLpylHIwOwRv3GG17ONmr7MWp3iCoMM0qMZiqTPPMAKqWozUGyRaC29Si+rtCsMHtxczNESPVIj4c8l4Qzvqpgc5RjEs4xtLCX8RnrEFReDERvi9Hxs2MXoQDJmnsAEph9UxDqBtv7Y9WK2fSHXe/cvR8//pVxPopCnBlIgbGRPukjzlG4qnzDvLzn04lK7LkhjhhyRhPOK1NWzQQUUxqHpsKH4UXesbA7bNtMk7Dbz1RItaiIQgF5HEffQ37uQWh3ztrD1JfkaMaOZaJ8YNpfLCmaLfH1TjjCv1FHScWlcBCkiMUz69tQ5r0IbIcrrVw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6a9948-50e3-490a-1bff-08d706e4133f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 16:14:53.9918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soares@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2672
X-OriginatorOrg: synopsys.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Boris,

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Fri, Jul 12, 2019 at 16:59:15

> On Fri, 12 Jul 2019 13:53:28 +0200
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>=20
> > Add basic support for i3c bus.
> > This is a simple implementation that only give support
> > for SDR Read and Write commands.
> >=20
>=20
> This patch has been applied by Mark already. Please make sure to drop
> already applied patches when submitting a new version.

I mention that in the cover letter and I kept it for reference.

Next time I will drop it.

>=20
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > ---
> >  drivers/base/regmap/Kconfig      |  6 +++-
> >  drivers/base/regmap/Makefile     |  1 +
> >  drivers/base/regmap/regmap-i3c.c | 60 ++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/regmap.h           | 20 ++++++++++++++
> >  4 files changed, 86 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/base/regmap/regmap-i3c.c
> >=20
> > diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> > index 6ad5ef4..c8bbf53 100644
> > --- a/drivers/base/regmap/Kconfig
> > +++ b/drivers/base/regmap/Kconfig
> > @@ -4,7 +4,7 @@
> >  # subsystems should select the appropriate symbols.
> > =20
> >  config REGMAP
> > -	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 ||=
 REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ)
> > +	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 ||=
 REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_I3C)
> >  	select IRQ_DOMAIN if REGMAP_IRQ
> >  	bool
> > =20
> > @@ -49,3 +49,7 @@ config REGMAP_SOUNDWIRE
> >  config REGMAP_SCCB
> >  	tristate
> >  	depends on I2C
> > +
> > +config REGMAP_I3C
> > +	tristate
> > +	depends on I3C
> > diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefil=
e
> > index f5b4e88..ff6c7d8 100644
> > --- a/drivers/base/regmap/Makefile
> > +++ b/drivers/base/regmap/Makefile
> > @@ -16,3 +16,4 @@ obj-$(CONFIG_REGMAP_IRQ) +=3D regmap-irq.o
> >  obj-$(CONFIG_REGMAP_W1) +=3D regmap-w1.o
> >  obj-$(CONFIG_REGMAP_SOUNDWIRE) +=3D regmap-sdw.o
> >  obj-$(CONFIG_REGMAP_SCCB) +=3D regmap-sccb.o
> > +obj-$(CONFIG_REGMAP_I3C) +=3D regmap-i3c.o
> > diff --git a/drivers/base/regmap/regmap-i3c.c b/drivers/base/regmap/reg=
map-i3c.c
> > new file mode 100644
> > index 0000000..1578fb5
> > --- /dev/null
> > +++ b/drivers/base/regmap/regmap-i3c.c
> > @@ -0,0 +1,60 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> > +
> > +#include <linux/regmap.h>
> > +#include <linux/i3c/device.h>
> > +#include <linux/i3c/master.h>
> > +#include <linux/module.h>
> > +
> > +static int regmap_i3c_write(void *context, const void *data, size_t co=
unt)
> > +{
> > +	struct device *dev =3D context;
> > +	struct i3c_device *i3c =3D dev_to_i3cdev(dev);
> > +	struct i3c_priv_xfer xfers[] =3D {
> > +		{
> > +			.rnw =3D false,
> > +			.len =3D count,
> > +			.data.out =3D data,
> > +		},
> > +	};
> > +
> > +	return i3c_device_do_priv_xfers(i3c, xfers, 1);
> > +}
> > +
> > +static int regmap_i3c_read(void *context,
> > +			   const void *reg, size_t reg_size,
> > +			   void *val, size_t val_size)
> > +{
> > +	struct device *dev =3D context;
> > +	struct i3c_device *i3c =3D dev_to_i3cdev(dev);
> > +	struct i3c_priv_xfer xfers[2];
> > +
> > +	xfers[0].rnw =3D false;
> > +	xfers[0].len =3D reg_size;
> > +	xfers[0].data.out =3D reg;
> > +
> > +	xfers[1].rnw =3D true;
> > +	xfers[1].len =3D val_size;
> > +	xfers[1].data.in =3D val;
> > +
> > +	return i3c_device_do_priv_xfers(i3c, xfers, 2);
> > +}
> > +
> > +static struct regmap_bus regmap_i3c =3D {
> > +	.write =3D regmap_i3c_write,
> > +	.read =3D regmap_i3c_read,
> > +};
> > +
> > +struct regmap *__devm_regmap_init_i3c(struct i3c_device *i3c,
> > +				      const struct regmap_config *config,
> > +				      struct lock_class_key *lock_key,
> > +				      const char *lock_name)
> > +{
> > +	return __devm_regmap_init(&i3c->dev, &regmap_i3c, &i3c->dev, config,
> > +				  lock_key, lock_name);
> > +}
> > +EXPORT_SYMBOL_GPL(__devm_regmap_init_i3c);
> > +
> > +MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
> > +MODULE_DESCRIPTION("Regmap I3C Module");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> > index daeec7d..f65984d 100644
> > --- a/include/linux/regmap.h
> > +++ b/include/linux/regmap.h
> > @@ -25,6 +25,7 @@ struct module;
> >  struct clk;
> >  struct device;
> >  struct i2c_client;
> > +struct i3c_device;
> >  struct irq_domain;
> >  struct slim_device;
> >  struct spi_device;
> > @@ -624,6 +625,10 @@ struct regmap *__devm_regmap_init_slimbus(struct s=
lim_device *slimbus,
> >  				 const struct regmap_config *config,
> >  				 struct lock_class_key *lock_key,
> >  				 const char *lock_name);
> > +struct regmap *__devm_regmap_init_i3c(struct i3c_device *i3c,
> > +				 const struct regmap_config *config,
> > +				 struct lock_class_key *lock_key,
> > +				 const char *lock_name);
> >  /*
> >   * Wrapper for regmap_init macros to include a unique lockdep key and =
name
> >   * for each call. No-op if CONFIG_LOCKDEP is not set.
> > @@ -982,6 +987,21 @@ bool regmap_ac97_default_volatile(struct device *d=
ev, unsigned int reg);
> >  #define devm_regmap_init_slimbus(slimbus, config)			\
> >  	__regmap_lockdep_wrapper(__devm_regmap_init_slimbus, #config,	\
> >  				slimbus, config)
> > +
> > +/**
> > + * devm_regmap_init_i3c() - Initialise managed register map
> > + *
> > + * @i3c: Device that will be interacted with
> > + * @config: Configuration for register map
> > + *
> > + * The return value will be an ERR_PTR() on error or a valid pointer
> > + * to a struct regmap.  The regmap will be automatically freed by the
> > + * device management code.
> > + */
> > +#define devm_regmap_init_i3c(i3c, config)				\
> > +	__regmap_lockdep_wrapper(__devm_regmap_init_i3c, #config,	\
> > +				i3c, config)
> > +
> >  int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk);
> >  void regmap_mmio_detach_clk(struct regmap *map);
> >  void regmap_exit(struct regmap *map);


