Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A4517FF7C
	for <lists+linux-iio@lfdr.de>; Tue, 10 Mar 2020 14:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgCJNtK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Mar 2020 09:49:10 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:43802 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726390AbgCJNtJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Mar 2020 09:49:09 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7690FC0ABA;
        Tue, 10 Mar 2020 13:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583848148; bh=IpVG6ERbo7hPj0pVhiSPvQ0KkrNFf5CU/rMUl5nm6LE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=f0b9wjrQ+ereSchBCniRBiuI7oq297AXLt2ntTvSzrKpKvm1E288Vk6zvrl0Jd/VM
         Q6RONCWtn7VGKLdoLtkofA08aq62eUqLCFWL58O5xtU8hziWvPm2eKiZNIDwswDZE/
         wEfh9cTnMpfIq80R9KcossuYHr72mbTWxHgS3QZrWxZu3TwNmDhYqtKyV1AsW2VLSG
         KW+uMIN5/Rw61jx1P0NZGKdPUPEGpTLPEIrpWKNbgO8F98bWZ9V9rRH6vRBuAQ3FaA
         Q5PX8LCViTqrTtBVtXt2WCB5bvXUtihlJkA1kfp2nx9gciAnOFNBpVOhsbl7yYOGq4
         8A7ZvmJXY9zcw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 214CCA0072;
        Tue, 10 Mar 2020 13:49:01 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 06:48:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 10 Mar 2020 06:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewikwla0dGqgIwW74jSOgVtqUjX3wu2ystjPZZiTuBQVBk7WS3Z2/nXPrIpfhmAzDUG4KY0yXesuDeNCGRqSMhtEG/lc7iZ5CDJLXzeL7ZXX7bhVUX+tbAdkLSnuJipm+3YHcdKutnps+7r6KbvkFoJtOhOtbto3we4raKsLpN6FpitnnbSC+ZJpRlMF2V0/9xOWhVuPyjh8nX6oectzBunCbLs781ERzdYbDSXNccQPhfc6zXLW1dU7gW56GaYDdMtW0RuklC3P/yeffG09qf/r12pjhUD+6f9+j0TToQpfcH1hhjXejUWNmYBD23M2JW/Nt/+S2H3X+fiM9piLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J9GwqzQXGCeH67o6k/VPgF6UisCVOkb1V3wQdDiTKo=;
 b=BDky+sSHs4s7wbEfv+g1hYvVj5/GFnagXdvMHtHBxzQJ/Z1M5Px3eYSC48AJ1CIRvn/QWSwwuDPSovsNo9WBkpNQaz0PCCWCRmpujetw6xnm/ZQ0dZgYF0LiJ1DxAgGeWUNo5tF+S3Ej3PTmFdt5C2P/7Vh1FVXGuHWOKj4ubQnXvvWXhEfuwcjhN1QKpqak/8Oll5cfZE6H1/UIJs+PlpiLKacz8NKOSxVfwI4zjgCJxXs24G0yZIJxk9frvbf1pnokWJkrGIEoHH6w0cyKL25sWjea3RZ/5U1hQa3bA3ztxQPFClQm6Tp61XrcvfzNVrr4oVMv8SGMAXmdDuX3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J9GwqzQXGCeH67o6k/VPgF6UisCVOkb1V3wQdDiTKo=;
 b=e70AB4+9So17ygY8dC1L4E5NTaxCyU83q2MfdaNHvRZSEnMR0XA+TxOCAddvXSUPaDpWaPqIVPMNAZLpL4RVhiTyDC5KotEdCSiwobA/2EtWsLzCB8tC8qgNIwRKf44bF7SRbWWoxiKvyvVzC1L2UXk/xruv/AnZJROqhrJMw/4=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 by CH2PR12MB3960.namprd12.prod.outlook.com (2603:10b6:610:24::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 13:48:48 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 13:48:48 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "mario.tesi@st.com" <mario.tesi@st.com>
Subject: RE: [PATCH v2] iio: imu: st_lsm6dsx: disable I3C support during
 device reset
Thread-Topic: [PATCH v2] iio: imu: st_lsm6dsx: disable I3C support during
 device reset
Thread-Index: AQHV9N1xEgEHERgBLUy4R7RxGmU9Q6hAWUgggAAEFYCAAAEL4IAAAaGAgAAAVSCAAA9/AIABUkqw
Date:   Tue, 10 Mar 2020 13:48:48 +0000
Message-ID: <CH2PR12MB4216D86F9B6885C60E40C1CDAEFF0@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <c4591fcbbb63c9280532e43b39c4f96323f321c2.1583625699.git.lorenzo@kernel.org>
 <CH2PR12MB4216C6B0B5922780FB13B902AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309150101.GB490054@lore-desk-wlan>
 <CH2PR12MB421655D9F6A060E4199AC6CDAEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309151035.GC490054@lore-desk-wlan>
 <CH2PR12MB42164216A155A4EB5F2EC8A8AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309160714.GD490054@lore-desk-wlan>
In-Reply-To: <20200309160714.GD490054@lore-desk-wlan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZGE0NDM4YzAtNjJkNS0xMWVhLTgyOTctYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XGRhNDQzOGMxLTYyZDUtMTFlYS04Mjk3LWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMzg0NiIgdD0iMTMyMjgzMjE3MjU1NTc0?=
 =?us-ascii?Q?MDk3IiBoPSJnYjZjNlhicGZodjVqOGtIbmhLZ0ZKMWF5aFk9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUJS?=
 =?us-ascii?Q?cWtPZTR2YlZBZnJ0M1ZYNmJ6UGsrdTNkVmZwdk0rUU9BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQXNQcFJHUUFBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
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
x-ms-office365-filtering-correlation-id: a213e482-0a6d-48ef-cc28-08d7c4f9c28b
x-ms-traffictypediagnostic: CH2PR12MB3960:
x-microsoft-antispam-prvs: <CH2PR12MB39607968AE73686D1475703DAEFF0@CH2PR12MB3960.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(376002)(366004)(396003)(199004)(189003)(478600001)(5660300002)(9686003)(55016002)(76116006)(54906003)(71200400001)(2906002)(66946007)(66556008)(64756008)(66476007)(186003)(66446008)(316002)(86362001)(26005)(81156014)(6916009)(33656002)(6506007)(8936002)(8676002)(52536014)(7696005)(81166006)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3960;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9TCheD60vzB6j8zhaiqeoykJ2uTCmf0wuNIqQItrn23pEHwZOoRRz8fdvy8/QAFs+xNn0yZ68ryY70rtpZIyin4S1pmpu4JNZTmKYlGO0zGsee0FUm5UwjGC3tVXMTdB7IwQmKSOpJ5ff1L87QtQmrczq4auW6ru2hvjlgJOX4CoYeRM0eprze5/03cTeHoo1bLlPuWUso4TUO/lPPXHwDYgRj1jhbU0eRyZb9O39H7zeqTwhLM9/LGMdiPOYF4NlAF54858rSBAIVFkqp/IRb+hpD5SNpX4fwSh285gt1KJU1jqKopInrwdXHiaASKxtfqjO497Zk/deXwLsPul1Xamj9gNo+LwO2no//KD8ulsP5saownh/kfKRdr1rTTH7uH8zPjbXnAy1sJqEP6Nr5CJyaDtDc2aaW1rguNUMr02QbsKV78chCrq66eAfjh
x-ms-exchange-antispam-messagedata: 8zeN+L8Hx48hHY0fBoaYJQZczOOeJ5yzYRGtMbIdmuSJofzKyncmQR+PrcC0bTAlDBhCX3ApiWI8rr4LhEMQbZiU9vy64VUE17DrA1W1EepSrUVzuaWjWb8RFu9KURNZpcTGkqGKVLRsmBnW7fOtQw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a213e482-0a6d-48ef-cc28-08d7c4f9c28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 13:48:48.5011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mhou8PeB/1cirKvkQgq9GKI1Pv3Yz9f3nuwIWe2Q9P/nInODKfcZ1qGjQthv6RVLui2zZKs7UdzMT1M6ZB0EeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3960
X-OriginatorOrg: synopsys.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, Mar 09, 2020 at 16:07:14

> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > Date: Mon, Mar 09, 2020 at 15:10:35
> >=20
> > > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > Date: Mon, Mar 09, 2020 at 15:01:01
> > > >=20
> > > > > > Hi Lorenzo,
> > > > > >=20
> > > > > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > Date: Sun, Mar 08, 2020 at 00:06:03
> > > > > >=20
> > > > > > > Disable MIPI I3C during device reset in order to avoid
> > > > > > > possible races on interrupt line 1. If the first interrupt
> > > > > > > line is asserted during hw reset the device will work in
> > > > > > > I3C-only mode
> > > > > > >=20
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > > > +
> > > > > >=20
> > > > > > After disable the i3c interface the dynamic address is no more =
accessible=20
> > > > > > and fails the initialization.
> > > > > >=20
> > > > >=20
> > > > > Hi Vitor,
> > > > >=20
> > > > > thx for testing it. What do you mean here?
> > > > > Is int1 set to vdd in your test?
> > > > >=20
> > > > > Regards,
> > > > > Lorenzo
> > > >=20
> > > > Yes, according with figure 14 of lsm6dso datasheet.
> > >=20
> > > uhm..probably we should do this configuration if the device is not in=
 I3C-only
> > > mode. Are you able to test it without setting the int1 to vdd?
> > > Unfortunately I have no devices with an I3C controller yet.
> > >=20
> > > Regards,
> > > Lorenzo
> > >=20
> >=20
> > Yes, I can test but I suspect we will have the same issue because it lo=
st=20
> > the dynamic address. I would say to add a flag during the probe to=20
> > indicate the interface and bypass this if in I3C mode.
>=20
> I am not an i3c expert but I think the dynamic address is reset during th=
e boot
> procedure of the sensor (this is done even if you do not disable i3c).

It can't because the dynamic address assignment (1) and the sensor boot=20
(2) are made in different steps.
  1. probe of i3c master driver;
  2. probe of sensor driver;

> Re-thinking about it, we should avoid it if the device if working in i3c-=
only
> (int1 set to vdd) but I think it would be necessary in i3c-mixed (int1 se=
t 0
> gnd). Could you please test it in the latter case? Thanks.
>=20
> Regards,
> Lorenzo

I test and get the same behavior. I thought it goes back to I2C mode but=20
not and neither the I3C DA is addressable.

Best regards,
Vitor Soares

>=20
> >=20
> > This may be useful when address the In-band interrupts.
> >=20
> > Best regards,
> > Vitor Soares
> >=20
> > > >=20
> > > > Is there any way to clear the INT1 before the hw reset?
> > > >=20
> > > > Best regards,
> > > > Vitor Soares
> > > >=20
> > > > >=20
> > > > > > Best regards,
> > > > > > Vitor Soares
> > > > > >=20
> > > > > > >  	/* device sw reset */
> > > > > > >  	reg =3D &hw->settings->reset;
> > > > > > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask=
,
> > > > > > > @@ -2059,6 +2081,15 @@ static int st_lsm6dsx_init_device(stru=
ct st_lsm6dsx_hw *hw)
> > > > > > > =20
> > > > > > >  	msleep(50);
> > > > > > > =20
> > > > > > > +	/* enable MIPI I3C */
> > > > > > > +	if (hw->settings->i3c_disable.addr) {
> > > > > > > +		reg =3D &hw->settings->i3c_disable;
> > > > > > > +		err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mas=
k,
> > > > > > > +					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
> > > > > > > +		if (err < 0)
> > > > > > > +			return err;
> > > > > > > +	}
> > > > > > > +
> > > > > > >  	/* enable Block Data Update */
> > > > > > >  	reg =3D &hw->settings->bdu;
> > > > > > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask=
,
> > > > > > > --=20
> > > > > > > 2.24.1
> > > > > >=20
> > > > > >=20
> > > >=20
> > > >=20
> >=20
> >=20


