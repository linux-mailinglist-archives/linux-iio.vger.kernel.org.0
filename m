Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4B2654D8
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2019 13:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfGKLAj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Jul 2019 07:00:39 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:53594 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727865AbfGKLAj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Jul 2019 07:00:39 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 56AECC1222;
        Thu, 11 Jul 2019 11:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562842838; bh=9VXeoZFAFdkzjTLb8OQbkD3NulzNVI84TdmACMjG7wI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NiBZ4vRS0j9o8lESy+4JL17wZ414V3n0ndXA1l6f23N+n24x792nNmxIMKPUA606z
         eJnsL6hJMJrIBvCT8hH9X2SIZTy5+PdE1agDQHI8ukh2CiLC+iKTe4YdbMy5URh0lC
         SEPMPph2yvjtkqkHtxg9YD/Mz3goFs8lfgo53S/VFeBJRjO9whjkJBRaTz/+VZhBuv
         39MRjjgwtfhcfvuVXqDYPS/AckRJpSwFc2+4Lk7VuXTc3m/oCHsHyBsK0qbx+2YmM5
         4tUl8lJ4cOnVzZuu5X8YwwG+TzYpm1svUJ5a8zx8rE6QPz00XcXvyYf/OZK/0gsiR/
         1Fspo1oAH4hpA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 94271A009B;
        Thu, 11 Jul 2019 11:00:35 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 11 Jul 2019 04:00:29 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 11 Jul 2019 04:00:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtzfoRFKy2OTkEitm2SUYyQTnF0EAsIQRxFUZcUQLqI=;
 b=RnnfghpkA8pdIanE+ULdFmv3JIllW0IKT0rQEq1UBrEHSVbonPre1eH++jBu6487pqpPREKkA5bN+1VvLsanUOVQpVsazT9AbDjn5CTfkJtySos0vDMkPjdxoUOh3p70KWo2oyLwwylaPGVha/zsnDJ0h30vfPUTrrKe/DY/uFs=
Received: from SN6PR12MB2655.namprd12.prod.outlook.com (52.135.103.20) by
 SN6PR12MB2733.namprd12.prod.outlook.com (52.135.107.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 11 Jul 2019 11:00:28 +0000
Received: from SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::1dbd:69dc:e782:92b6]) by SN6PR12MB2655.namprd12.prod.outlook.com
 ([fe80::1dbd:69dc:e782:92b6%6]) with mapi id 15.20.2052.022; Thu, 11 Jul 2019
 11:00:27 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
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
Thread-Index: AQHVNy/EafU1/RkKpEi9l4c7Sgkq0qbEQUqAgADyYXCAAAvq8A==
Date:   Thu, 11 Jul 2019 11:00:27 +0000
Message-ID: <SN6PR12MB2655939CB14D0EF848B4F4A8AEF30@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1562767521.git.vitor.soares@synopsys.com>
 <73955529ae0c31f428221abb88031ab3b4165659.1562767521.git.vitor.soares@synopsys.com>
 <20190710194405.GA10520@lore-desk-wlan.lan>
 <SN6PR12MB2655AC6DF4A959A1705FC8A4AEF30@SN6PR12MB2655.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB2655AC6DF4A959A1705FC8A4AEF30@SN6PR12MB2655.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMTUwZGNmMzQtYTNjYi0xMWU5LTgyNGEtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDE1MGRjZjM2LWEzY2ItMTFlOS04MjRhLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMjAxNCIgdD0iMTMyMDczMTY0MjQ4NTgy?=
 =?us-ascii?Q?MTY0IiBoPSJhN1dhQWZkSDhwWThxSURLZ0E3c1krTHFSNms9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUFV?=
 =?us-ascii?Q?Q0diWDF6ZlZBVTBjanpYZXVicHBUUnlQTmQ2NXVta09BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 217b56e8-ee16-4a22-a58c-08d705eefbbb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2733;
x-ms-traffictypediagnostic: SN6PR12MB2733:
x-microsoft-antispam-prvs: <SN6PR12MB273364EFDF7B121E7F8C1560AEF30@SN6PR12MB2733.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(366004)(136003)(189003)(199004)(76176011)(33656002)(102836004)(25786009)(6506007)(66066001)(99286004)(3846002)(6116002)(7696005)(508600001)(6636002)(2940100002)(110136005)(316002)(54906003)(14454004)(68736007)(4326008)(2906002)(229853002)(6436002)(446003)(53936002)(71200400001)(71190400001)(74316002)(305945005)(107886003)(7736002)(6246003)(26005)(76116006)(256004)(14444005)(64756008)(66446008)(66556008)(66946007)(8936002)(66476007)(86362001)(476003)(486006)(5660300002)(11346002)(186003)(52536014)(81156014)(9686003)(8676002)(55016002)(81166006)(42413003)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2733;H:SN6PR12MB2655.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L61Xsjriazzu7fnhyIkL0xBIjyFz9+oKcs/kjkrhfejh/+r0o5ZxFpp5gfrU6Q/CcQW2s3HWiR0Lca1aDeUOf7C1YuXz/OwIYYizjkajZVrXQ0Y2DJox4vx5f0Swabp2abi2k4do1AhkgsmzI2UdOWikBrzl/fN1ruvhQNfz/glAPWKDykhcpX+SjJUmhLHI3Qidm4pMYZVYh8MguOZQtNrBYuUfNfslx/wVugCyZ1M/O+XVDIz6PiIU40P3VV6xXqW8K8XO7+l8pvHrw8/PzG6YOF1KxOyZ8zl4QsKrYgKGPkzEdTafIWSbijccYDUR+BYyjedeGTgTMJHS7Ja2dq0z70z/FWcafBLb9f79i7PTUOHxZZkMCoc4MSXWeY/nBMlYEIluc05jHq0ZvNdBvwSAwaeeD/u20kQAxPyYgOc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 217b56e8-ee16-4a22-a58c-08d705eefbbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 11:00:27.8789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soares@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2733
X-OriginatorOrg: synopsys.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Vitor Soares <soares@synopsys.com>
Date: Thu, Jul 11, 2019 at 11:12:34

> Hi Lorenzo,
>=20
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Wed, Jul 10, 2019 at 20:44:05
>=20
> > > For today the st_lsm6dsx driver support LSM6DSO and LSM6DSR sensor on=
ly in
> > > spi and i2c mode.
> > >=20
> > > The LSM6DSO and LSM6DSR are also i3c capable so lets give i3c support=
 to
> > > them.
> >=20
> > Hi Vitor,
> >=20
> > just few comments inline.
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > > Changes in v3:
> > >   Remove unnecessary st_lsm6dsx_i3c_data table used to hold device na=
me
> > >   Use st_lsm6dsx_probe new form
> > >=20
> > > Changes in v2:
> > >   Add support for LSM6DSR
> > >   Set pm_ops to st_lsm6dsx_pm_ops
> > >=20
> > >  drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
> > >  drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 61 +++++++++++++++++++=
++++++++++
> > >  3 files changed, 69 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > >=20
> >=20
> > [...]
> > > +static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
> > > +{
> > > +	const struct i3c_device_id *id =3D i3c_device_match_id(i3cdev,
> > > +							    st_lsm6dsx_i3c_ids);
> >=20
> > i3c_device_match_id can theoretically fail so is it better to check
> > return value here? (maybe I am too paranoid :))

I was preparing the patch and if the i3c_device_match_id() fail it return=20
NULL so the st_lsm6dsx_probe() will fail automatically.
Checking the spi_get_device_id(), the drivers don't test the return value=20
too.

Do you think it is really necessary to test it before the=20
st_lsm6dsx_probe() function?

Best regards,
Vitor Soares
