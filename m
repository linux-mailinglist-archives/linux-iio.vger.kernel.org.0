Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE1E67331
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2019 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfGLQWL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jul 2019 12:22:11 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:56912 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbfGLQWL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2019 12:22:11 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4D7C9C1337;
        Fri, 12 Jul 2019 16:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562948530; bh=5a/YE8tdHn4NCbwEfNZ2xDJgbwDwdr5bQeSpkqW6nKQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GBtTCpEHwHIbVCXxdgOSH+9V8OJlG0Q6vOL68XGr3DrFgMAKb2FxWYW57p24Xv4gn
         vRVe87jfLlf7MFX3ZD5Nau2h0nPGwl/QO5Dz2NeUiE2l1bdp3fybsHOzC8OBvH0jKL
         ouaEjGwflVfgA6t6tdR7l+p8ONgJBdv4u8zBnRTNpSNbEP88sf3AbNaCkPqXFu9r7d
         cTTUSpQW+qUhxtcVwKjEnxQaeUpODw2c/MX4jJxE1C4WnUZ9K5c3WADYnNU7J0KqyA
         xm/EjeiDLAKif3ZosNk+L52GUb6hOO6NdFoPG1ognrF5H75k376L3Pe9dIFpcY1QqL
         wMDtat8N1QviA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 278C1A006E;
        Fri, 12 Jul 2019 16:22:09 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 12 Jul 2019 09:21:51 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 12 Jul 2019 09:21:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4IoBpPgCU7rrWEjFGb9BuU+lUp4CoSLdsL6sGWdinE=;
 b=Tg8t8bwZ4QubjCS+LbJ4zp2FFcWkUaCnTV6BrVWr4qS4/pZAK1Ytuo7clZIWu18mA43LTo0nipliw+uATlaSi6s0ypttINSn0sZ6XEOaAMEngTd58GlpEAKYPX3tUC1dzwyWLUTcogfZWpzJtHvInxG9S7Mnet1oFyF7ig99eFI=
Received: from SN6PR12MB2655.namprd12.prod.outlook.com (52.135.103.20) by
 SN6PR12MB2783.namprd12.prod.outlook.com (52.135.107.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Fri, 12 Jul 2019 16:21:49 +0000
Received: from SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::1dbd:69dc:e782:92b6]) by SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::1dbd:69dc:e782:92b6%6]) with mapi id 15.20.2073.012; Fri, 12 Jul 2019
 16:21:49 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>
CC:     "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
Subject: RE: [PATCH v4 2/3] i3c: move i3c_device_match_id to device.c and
 export it
Thread-Topic: [PATCH v4 2/3] i3c: move i3c_device_match_id to device.c and
 export it
Thread-Index: AQHVOKiA/+5eA36w/E2qczEnNoiqQ6bHJWoAgAADN2A=
Date:   Fri, 12 Jul 2019 16:21:49 +0000
Message-ID: <SN6PR12MB265549866115B706616C2081AEF20@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1562931742.git.vitor.soares@synopsys.com>
 <debadccffef84c541601a97162ac656cd7c58478.1562931742.git.vitor.soares@synopsys.com>
 <20190712180338.47b50e9f@linux.home>
In-Reply-To: <20190712180338.47b50e9f@linux.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMjNlNjYzOTMtYTRjMS0xMWU5LTgyNGItYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDIzZTY2Mzk1LWE0YzEtMTFlOS04MjRiLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iNjE3NiIgdD0iMTMyMDc0MjIxMDU5NzE0?=
 =?us-ascii?Q?ODAwIiBoPSJGT1FxNG5JYlpIRmNGVFRPVW9keHZQQ1AzYk09IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUR3?=
 =?us-ascii?Q?TGtEbXpUalZBZW5JelE3eENLM0Q2Y2pORHZFSXJjTU9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 6a04609e-becc-4de1-2dbb-08d706e50adc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR12MB2783;
x-ms-traffictypediagnostic: SN6PR12MB2783:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2783FCB63392EF162BA1A6EBAEF20@SN6PR12MB2783.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(5660300002)(966005)(53936002)(14454004)(6306002)(55016002)(3846002)(478600001)(6246003)(229853002)(66946007)(9686003)(6116002)(86362001)(66066001)(76116006)(52536014)(6436002)(99286004)(6636002)(305945005)(476003)(81166006)(102836004)(2906002)(446003)(26005)(71200400001)(11346002)(81156014)(25786009)(8676002)(186003)(74316002)(486006)(8936002)(71190400001)(7736002)(316002)(110136005)(54906003)(64756008)(66556008)(66476007)(66446008)(4326008)(6506007)(33656002)(76176011)(256004)(7696005)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2783;H:SN6PR12MB2655.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Tg0WMInpThvaxYaoA9oMc8ygU8Lr6cA0eGFuwkv0APkii3pMj7dhT4ZMSfZFZHbIQcdTbuPubnJXrIHaYRh+dUtYDvsiWUTpx2kemS53ciV5p5HEqETW+UVJ3D5zGV9hJT/T0geRY/4+ntz322c7fOeRT4y4gdWTOJw3aYAMEx9skQN8wCdAkY6AY9qZABag/VffA9U6PmO3fetR8viUX+O+hMyWi2XE5iA1zPo9ojF/z/ofW//7GrUgxOzNfMs6FsvF5L767gLne+fQxZOHW0eB+eWRwBynLb4ZRiixQ3V3/qenFdk18zLE/D78wnXNThPccGF1fTievQzvgwb2bp5Qu3i9izbQbuZiFIi0lKqlfM7xIYADHcH/uxMCgwiUTFACk2yY+DRX5A+QmXGOLwURCrGXVKMwJJOCwycbEw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a04609e-becc-4de1-2dbb-08d706e50adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 16:21:49.4814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soares@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
X-OriginatorOrg: synopsys.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Boris,

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Fri, Jul 12, 2019 at 17:03:38

> On Fri, 12 Jul 2019 13:53:29 +0200
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>=20
> > The i3c device driver needs the i3c_device_id table.
>=20
> "Some I3C device drivers need to know which entry matches the
> i3c_device object passed to the probe function"=20
>=20
> > Lets move  to device.c and export it to be used.
>=20
> "Let's move i3c_device_match_id() to device.c and export it so it can be
> used by drivers."
>=20

Fix in next drop.

> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > ---
> > Changes in v4:
> >   None
> >=20
> > Changes in v3:
> >   Remove i3c_get_device_id
> >   Move i3c_device_match_id from drivers/i3c/master.c to drivers/i3c/dev=
ice.c
> >   Export i3c_device_match_id
> >=20
> > Changes in v2:
> >   move this function to drivers/i3c/device.c
> >=20
> >  drivers/i3c/device.c       | 46 ++++++++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/i3c/master.c       | 45 --------------------------------------=
-------
> >  include/linux/i3c/device.h |  4 ++++
> >  3 files changed, 50 insertions(+), 45 deletions(-)
> >=20
> > diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> > index 69cc040..383df3b 100644
> > --- a/drivers/i3c/device.c
> > +++ b/drivers/i3c/device.c
> > @@ -200,6 +200,52 @@ struct i3c_device *dev_to_i3cdev(struct device *de=
v)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_to_i3cdev);
> > =20
>=20
> You're missing a kerneldoc here.

I will do that. Can you clarify why we need that?

>=20
> > +const struct i3c_device_id *
> > +i3c_device_match_id(struct i3c_device *i3cdev,
> > +		    const struct i3c_device_id *id_table)
> > +{
> > +	struct i3c_device_info devinfo;
> > +	const struct i3c_device_id *id;
> > +
> > +	i3c_device_get_info(i3cdev, &devinfo);
> > +
> > +	/*
> > +	 * The lower 32bits of the provisional ID is just filled with a rando=
m
> > +	 * value, try to match using DCR info.
> > +	 */
> > +	if (!I3C_PID_RND_LOWER_32BITS(devinfo.pid)) {
> > +		u16 manuf =3D I3C_PID_MANUF_ID(devinfo.pid);
> > +		u16 part =3D I3C_PID_PART_ID(devinfo.pid);
> > +		u16 ext_info =3D I3C_PID_EXTRA_INFO(devinfo.pid);
> > +
> > +		/* First try to match by manufacturer/part ID. */
> > +		for (id =3D id_table; id->match_flags !=3D 0; id++) {
> > +			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=3D
> > +			    I3C_MATCH_MANUF_AND_PART)
> > +				continue;
> > +
> > +			if (manuf !=3D id->manuf_id || part !=3D id->part_id)
> > +				continue;
> > +
> > +			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
> > +			    ext_info !=3D id->extra_info)
> > +				continue;
> > +
> > +			return id;
> > +		}
> > +	}
> > +
> > +	/* Fallback to DCR match. */
> > +	for (id =3D id_table; id->match_flags !=3D 0; id++) {
> > +		if ((id->match_flags & I3C_MATCH_DCR) &&
> > +		    id->dcr =3D=3D devinfo.dcr)
> > +			return id;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(i3c_device_match_id);
> > +
> >  /**
> >   * i3c_driver_register_with_owner() - register an I3C device driver
> >   *
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index 5f4bd52..7667f84 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -270,51 +270,6 @@ static const struct device_type i3c_device_type =
=3D {
> >  	.uevent =3D i3c_device_uevent,
> >  };
> > =20
> > -static const struct i3c_device_id *
> > -i3c_device_match_id(struct i3c_device *i3cdev,
> > -		    const struct i3c_device_id *id_table)
> > -{
> > -	struct i3c_device_info devinfo;
> > -	const struct i3c_device_id *id;
> > -
> > -	i3c_device_get_info(i3cdev, &devinfo);
> > -
> > -	/*
> > -	 * The lower 32bits of the provisional ID is just filled with a rando=
m
> > -	 * value, try to match using DCR info.
> > -	 */
> > -	if (!I3C_PID_RND_LOWER_32BITS(devinfo.pid)) {
> > -		u16 manuf =3D I3C_PID_MANUF_ID(devinfo.pid);
> > -		u16 part =3D I3C_PID_PART_ID(devinfo.pid);
> > -		u16 ext_info =3D I3C_PID_EXTRA_INFO(devinfo.pid);
> > -
> > -		/* First try to match by manufacturer/part ID. */
> > -		for (id =3D id_table; id->match_flags !=3D 0; id++) {
> > -			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=3D
> > -			    I3C_MATCH_MANUF_AND_PART)
> > -				continue;
> > -
> > -			if (manuf !=3D id->manuf_id || part !=3D id->part_id)
> > -				continue;
> > -
> > -			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
> > -			    ext_info !=3D id->extra_info)
> > -				continue;
> > -
> > -			return id;
> > -		}
> > -	}
> > -
> > -	/* Fallback to DCR match. */
> > -	for (id =3D id_table; id->match_flags !=3D 0; id++) {
> > -		if ((id->match_flags & I3C_MATCH_DCR) &&
> > -		    id->dcr =3D=3D devinfo.dcr)
> > -			return id;
> > -	}
> > -
> > -	return NULL;
> > -}
> > -
> >  static int i3c_device_match(struct device *dev, struct device_driver *=
drv)
> >  {
> >  	struct i3c_device *i3cdev;
> > diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> > index 5ecb055..de102e4 100644
> > --- a/include/linux/i3c/device.h
> > +++ b/include/linux/i3c/device.h
> > @@ -188,6 +188,10 @@ static inline struct i3c_driver *drv_to_i3cdrv(str=
uct device_driver *drv)
> >  struct device *i3cdev_to_dev(struct i3c_device *i3cdev);
> >  struct i3c_device *dev_to_i3cdev(struct device *dev);
> > =20
> > +const struct i3c_device_id *
> > +i3c_device_match_id(struct i3c_device *i3cdev,
> > +		    const struct i3c_device_id *id_table);
> > +
> >  static inline void i3cdev_set_drvdata(struct i3c_device *i3cdev,
> >  				      void *data)
> >  {
>=20
>=20
> _______________________________________________
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.org=
_mailman_listinfo_linux-2Di3c&d=3DDwICAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DqVu=
U64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=3D3BEF5uxfJXeA-aip7adilYENAWYp6x=
NoJXvidZZZpY4&s=3DJcBzwEcWAIoOCufxAYFd4YjCZppBQDA2-nVqfV1Cj5g&e=3D=20

Thanks for your comments.

Best regards,
Vitor Soares
