Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4726545B
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2019 12:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfGKKMj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Jul 2019 06:12:39 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:33106 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728192AbfGKKMj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Jul 2019 06:12:39 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 79FF3C295A;
        Thu, 11 Jul 2019 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562839958; bh=sE0KJEEESRrgADc9hzGJgD0PETWKx08CkOWHdj1A1wE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=geR0MLL/1eJyqzV1tcIN8qQKVcgeu18KaFHZAFTMLup/752BhkJCQoI8lnwQw9ECs
         E7OCNYa7aKUyaYSS252wHZBUeaKoLXeqXrWL0Ytz36R1DlGadpdcXW6Yid9CEvwYeC
         8+WCmWHrw65xRV/qY01PF7fvCslGw1STJQ/Zf87Dq51K8VhzSZZGoJ5ntnLrNd4P5C
         BafGGWNztTgVS742ZdblScy+NX53i8E0VXByFYYZCBrIkE7bjqHaCTksoeOCDm1fP0
         IbeeHqIGL2Qt6Eu4ml5FZ9UvZD7uBoT4p+Inij1A1lSh0JlKRJJzAdj3/jNVTMy1vw
         9opNivH+GG7qA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2D0B7A023C;
        Thu, 11 Jul 2019 10:12:38 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 11 Jul 2019 03:12:37 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 11 Jul 2019 03:12:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g6NFPZLaAs2vThttrp0WePOIxz/4mxtMa+d2+anrZg=;
 b=HQ1jzpvm4vcRxN0mVss+Kjk3KfNoaKUGdEMfw47h94tYfK64oDlqoSrzZd6CRTFeQvlDymflAFAnUYvy+BlL0BrH4YhqmfQLUFbK18988WP61lqcLOYIbMv1rmFAOyS/fk3Sfid7W8nZIWNYL7RptBsHWOOqQf7FwTcfFpN9Iys=
Received: from SN6PR12MB2655.namprd12.prod.outlook.com (52.135.103.20) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.107.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Thu, 11 Jul 2019 10:12:35 +0000
Received: from SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::1dbd:69dc:e782:92b6]) by SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::1dbd:69dc:e782:92b6%6]) with mapi id 15.20.2052.022; Thu, 11 Jul 2019
 10:12:35 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bbrezillon@knernel.org" <bbrezillon@knernel.org>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add i3c basic support for
 LSM6DSO and LSM6DSR
Thread-Topic: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add i3c basic support for
 LSM6DSO and LSM6DSR
Thread-Index: AQHVNy/EafU1/RkKpEi9l4c7Sgkq0qbEQUqAgADyYXA=
Date:   Thu, 11 Jul 2019 10:12:34 +0000
Message-ID: <SN6PR12MB2655AC6DF4A959A1705FC8A4AEF30@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1562767521.git.vitor.soares@synopsys.com>
 <73955529ae0c31f428221abb88031ab3b4165659.1562767521.git.vitor.soares@synopsys.com>
 <20190710194405.GA10520@lore-desk-wlan.lan>
In-Reply-To: <20190710194405.GA10520@lore-desk-wlan.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNjRiM2JhMDMtYTNjNC0xMWU5LTgyNGEtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDY0YjNiYTA1LWEzYzQtMTFlOS04MjRhLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMzk3NyIgdD0iMTMyMDczMTM1NTIwMTQ3?=
 =?us-ascii?Q?OTYyIiBoPSJNdEhsS1ZlN21VZXNpeEdkb3plaFpSM0pubDg9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUQ2?=
 =?us-ascii?Q?NlF3bjBUZlZBWGtsSFJ3NkhzbVJlU1VkSERvZXlaRU9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 5db8ea1c-e007-4ba7-8ee2-08d705e84b59
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2814;
x-ms-traffictypediagnostic: SN6PR12MB2814:
x-microsoft-antispam-prvs: <SN6PR12MB2814CB96E2D4F272B7111C12AEF30@SN6PR12MB2814.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(66946007)(64756008)(66476007)(229853002)(14444005)(9686003)(256004)(6436002)(66556008)(66446008)(26005)(76116006)(71200400001)(55016002)(53936002)(2906002)(74316002)(14454004)(6636002)(71190400001)(8936002)(6246003)(7736002)(107886003)(33656002)(316002)(186003)(6116002)(11346002)(110136005)(54906003)(81166006)(486006)(52536014)(6506007)(86362001)(68736007)(8676002)(305945005)(4326008)(446003)(66066001)(476003)(5660300002)(25786009)(76176011)(7696005)(3846002)(508600001)(102836004)(99286004)(81156014)(42413003)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2814;H:SN6PR12MB2655.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2AycSr0UuTnMC8p8WIEnFwkVaIXFlF0ChsJ8EzD1Ui0l+1l5478pDWGUn5QNL439bCad2admfNw9mDo3DGqlp2EUMwIxGQiiZdSuhewF7qr79eJDvJ1r9D48K6o09n0vaceTSwq8d8YXHTLnQDHRXgHsIRt1KMd/AZUKIkflPmjbPLX6ruY1R2DZzeMvAZFyz/m78wPG4kkLA++A0mi7XTEkZrdEyyyLIjfMo91aIko3h+4N1jzXJ1NYYq+IA41iP/pXdpT8RS0WFbUetw1UMez8ngWD17PcBtxyjxpy8cuP13XO8/TkmQe9tCFPqywu8VTg5ONaxRM21FR5mpG4DijpyjtAMDOQ2Y6qpiymcVith4Sb+ph73IThLNxQuK14UQ0puLAmiwt3EdX469NMdcL1lCsvXQ8VV16Yw5iIfho=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db8ea1c-e007-4ba7-8ee2-08d705e84b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 10:12:34.9317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soares@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
X-OriginatorOrg: synopsys.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lorenzo,

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, Jul 10, 2019 at 20:44:05

> > For today the st_lsm6dsx driver support LSM6DSO and LSM6DSR sensor only=
 in
> > spi and i2c mode.
> >=20
> > The LSM6DSO and LSM6DSR are also i3c capable so lets give i3c support t=
o
> > them.
>=20
> Hi Vitor,
>=20
> just few comments inline.
>=20
> Regards,
> Lorenzo
>=20
> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v3:
> >   Remove unnecessary st_lsm6dsx_i3c_data table used to hold device name
> >   Use st_lsm6dsx_probe new form
> >=20
> > Changes in v2:
> >   Add support for LSM6DSR
> >   Set pm_ops to st_lsm6dsx_pm_ops
> >=20
> >  drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
> >  drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 61 +++++++++++++++++++++=
++++++++
> >  3 files changed, 69 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> >=20
>=20
> [...]
>=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/=
imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > new file mode 100644
> > index 0000000..f683754
> > --- /dev/null
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > @@ -0,0 +1,61 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> > + *
> > + * Author: Vitor Soares <vitor.soares@synopsys.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/i3c/device.h>
> > +#include <linux/i3c/master.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "st_lsm6dsx.h"
> > +
> > +static const struct i3c_device_id st_lsm6dsx_i3c_ids[];
> > +
>=20
> why do we need this? I guess you can just move st_lsm6dsx_i3c_ids definit=
ion here
>=20
> > +static const struct regmap_config st_lsm6dsx_i3c_regmap_config =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +};
> > +
> > +static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
> > +{
> > +	const struct i3c_device_id *id =3D i3c_device_match_id(i3cdev,
> > +							    st_lsm6dsx_i3c_ids);
>=20
> i3c_device_match_id can theoretically fail so is it better to check
> return value here? (maybe I am too paranoid :))
>=20
> > +	struct regmap *regmap;
> > +	int hw_id =3D (int)id->data;
>=20
> I guess we do not need this since we use it just in st_lsm6dsx_probe(),
> we can just do:
>=20
> return st_lsm6dsx_probe(&i3cdev->dev, 0, (int)id->data, regmap);
> > +
> > +	regmap =3D devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config=
);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&i3cdev->dev, "Failed to register i3c regmap %d\n",
> > +			(int)PTR_ERR(regmap));
> > +		return PTR_ERR(regmap);
> > +	}
> > +
> > +	return st_lsm6dsx_probe(&i3cdev->dev, 0, hw_id, regmap);
> > +}
> > +
> > +static const struct i3c_device_id st_lsm6dsx_i3c_ids[] =3D {
> > +	I3C_DEVICE(0x0104, 0x006C, (void *)ST_LSM6DSO_ID),
> > +	I3C_DEVICE(0x0104, 0x006B, (void *)ST_LSM6DSR_ID),
> > +	{ /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(i3c, st_lsm6dsx_i3c_ids);
> > +
> > +static struct i3c_driver st_lsm6dsx_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "st_lsm6dsx_i3c",
> > +		.pm =3D &st_lsm6dsx_pm_ops,
> > +	},
> > +	.probe =3D st_lsm6dsx_i3c_probe,
> > +	.id_table =3D st_lsm6dsx_i3c_ids,
> > +};
> > +module_i3c_driver(st_lsm6dsx_driver);
> > +
> > +MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
> > +MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i3c driver");
> > +MODULE_LICENSE("GPL v2");
> > --=20
> > 2.7.4
> >=20

Thanks for your comments. I will address them and send a new version.

Best regards,
Vitor Soares

