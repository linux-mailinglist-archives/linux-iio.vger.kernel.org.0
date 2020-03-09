Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E73017E606
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 18:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgCIRt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 13:49:27 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:52052 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgCIRt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 13:49:27 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DB3F0403F7;
        Mon,  9 Mar 2020 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583776165; bh=YIKPKx7divtHWnX707oKbkUpkca9xPwtBbUvX6owcBc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Jz2L4S5pbIgnUK7x63vKguyFDo/Eoo6Xh3PhC/wxIrXrZulP3GCd5W190eKR916yj
         /23Ci7zzMLKmQ5tiL0KJ3ENB7fqWuk9smmytj1o4Gan4FD5Wr8CzaR/dDJgc9xROJo
         5Q+fdXZWlsphcLfT6iZBs0qeCBGFOVsXGwgg4qyUWtohDrPdnHNvvekxRwp0jcWM04
         hg0wGOncffsvmCAUqAG0aFygxPtuLAsfCen2CT8fzegbVs4cThNgUPWVQ7eFh9Mg7V
         ByULtr/Vr7yruxIt2wiBk7Gh2ywjUch2PL0JjXzPgJfzXr2kMMlveLw5cE6mKcD4Pv
         1/FG9yFJJWBLw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A6FB4A022B;
        Mon,  9 Mar 2020 17:49:25 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Mar 2020 10:49:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 9 Mar 2020 10:43:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCN+4tmtoGVFUS09GT4mhkdtNLmG6BDXbt7UdTsLtTBq+Z4Dbtu/QX8F9ZbSI/nKAnVgLEJYAw6KwFKvfMxitIZqfkY0tY7c+QHbCp0Q0I/KLcFB3j/BwBGNr8sTKJWZVg1hJJ59xJg9Hf1S3A03yhAt7ETezuBlqNUf2q/Pwu9SOCLkMnfmvZrdsHkCMgspn6v2JML0EHEw5D9Oj6HXTb81ssA2IZo4yZcLc+2HiontnGQD+AhPzuEFI2ky2DRJRwIeQNXd/WYupCXqNMvZ5lwuBpJgH4oQzCALIFEaudFSec/Em300aZVu3h11UQGtAWmrKe/e56QEqakZlSHSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W53tTkXATxKl0uVor4LLVLlNQ4xsI8QDeDypgQGPZSU=;
 b=GWf/eYonJQI6vptMX080HZuDJop+ZiXSmSejNgaEvDoW2pvOgqGOV69Tq8OnkNMSk1vlbjFu6AIm4z4f5jCSm6aoNpA1mM/YojFtE8jbI7j+6kwDSrYYp47RFfXpGLzDmsbl2VUnkedU/Qd7TEsTGrSIai5KqdiOUONu3suvpxIXa1/TDJkQDlGqwVnCQYJuCvjAfZvuC5Z18EN6GxnTLYupCOoZh4AROl28QiqGphw4ubATWNVGpQf26f1NnsNwl/bJqOGP8IsTEtCQicqlalJ8Rpzw1GgoSIQY4LrqGpYuNItKa9tqT4cwMbVYiQPhCjRDtPR4zJ1RNi80Qv9PFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W53tTkXATxKl0uVor4LLVLlNQ4xsI8QDeDypgQGPZSU=;
 b=D6Q+ypbj2Tdm5DtE8ONS/AeAqyREStvxBG+r102UwLj7D6dceZsZo1v4yD4F0061u1VbbeihfCyM9dhWgrWL+1KsNfHy89Lv+LjO6JEhnYmaQcCTnqMEtb1kwU+OP1Y6PTvXrUxSTz720ePoXPetRbpGENj0hDZ8GmQY56+d/0w=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 17:43:44 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 17:43:44 +0000
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
Thread-Index: AQHV9N1xEgEHERgBLUy4R7RxGmU9Q6hAWUgggAAEFYCAAAEL4IAAAaGAgAAAVSCAAA9/AIAAGqUQ
Date:   Mon, 9 Mar 2020 17:43:44 +0000
Message-ID: <CH2PR12MB42166BDB9D59C078412792B3AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
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
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctODI5YmY0ZjEtNjIyZC0xMWVhLTgyOTYtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDgyOWJmNGYzLTYyMmQtMTFlYS04Mjk2LWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMzU5MiIgdD0iMTMyMjgyNDk0MjAyNjkw?=
 =?us-ascii?Q?MTkzIiBoPSJkVjhKSHh2bnIzbW5kb1JKeTdUUm51MHkxQXM9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUNS?=
 =?us-ascii?Q?T3ZSRU92YlZBYzJxTHVERnBWcjN6YW91NE1XbFd2Y09BQUFBQUFBQUFBQUFB?=
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
x-originating-ip: [2.82.68.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69c09fbf-b02e-4a6a-15ac-08d7c45169fc
x-ms-traffictypediagnostic: CH2PR12MB4279:
x-microsoft-antispam-prvs: <CH2PR12MB4279A2293E1DEF4195EFE4D8AEFE0@CH2PR12MB4279.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(136003)(346002)(189003)(199004)(33656002)(52536014)(6916009)(7696005)(6506007)(8936002)(4326008)(8676002)(81166006)(81156014)(66946007)(86362001)(76116006)(54906003)(9686003)(55016002)(2906002)(5660300002)(478600001)(66556008)(71200400001)(26005)(316002)(66446008)(64756008)(186003)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB4279;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U1vV/awsR2kQNQtLGRPIv1S1cdt/jHkSvB+XoGn7ub8/hA9rWT9esnAX4x+HZymalEakNVCobjUVc3Gq88O5FiCUYwWISVfzcJW/uw5+Rz/vtRRwjL0bfPjLV9/OaqHvjGwng1qFiezbNyWlu4zRSo18ql3PbNBWZbSu8pcIDsefhSkjt/Ti0MWpAB8bDADZ25lf7uj3EHSYcP3Sc2sswBzfrVlWbPVK9ZljJNZpyJluYYA+MjEgqYCpzwmSALxsSnyHp1xwFX2TA/u8MG7K8k+JQtc94R41EupW9VPnc3YwC4Qm69CUiN3FrceaDce8uzN0+UCzO9l1LiJlHwOI9wt/1Ccz1b3hEqMsE5qc0aN4i/So1k5TivpRj+iNPo+tp0lzEyCF7EqsY76EvOcLHpL6wTpdqE3dRUirEq91jrb3WiJdsxbL5VdDLaHnKP7/
x-ms-exchange-antispam-messagedata: 7A20zBnifATlUJm/P7TTEXo5YZJO4Xqf7G+mg/2jEIie0ZicYaJTw/PSuvGxIT2qhKhmhKVZfcpXFM3iJM0n46KNoHRiSt4stREXJX/z3cIUPr/FvUl1zSdy69Mrh3vdClL7xrm7xGLfFFMgmphggg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c09fbf-b02e-4a6a-15ac-08d7c45169fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 17:43:44.4443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: an9rUSZAjlfyZxDg2GM1lFbgsFaan7P5VzdsJfzqtpjQAH1DAl0IlncRBdZ31c4tpKTkAAXV7k0yYQKRZKmPnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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
> Re-thinking about it, we should avoid it if the device if working in i3c-=
only
> (int1 set to vdd) but I think it would be necessary in i3c-mixed (int1 se=
t 0
> gnd). Could you please test it in the latter case? Thanks.
>=20
> Regards,
> Lorenzo

Sure, I will test it and let you know.=20

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


