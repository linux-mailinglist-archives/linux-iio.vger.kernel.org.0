Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E017E2C9
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 15:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgCIOzM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 10:55:12 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42060 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726774AbgCIOzL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 10:55:11 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CDCF1403BD;
        Mon,  9 Mar 2020 14:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583765710; bh=+dvJYqPXNvkRS6pTQoXDHJyghzDOaBh3Y/TqVPXNsn8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZspLBrVhAQWVt6mcdgU0104nXB/x4Rcm4NS9VPaWIhT9cKnBHiYFGblBawa5sKeZj
         tbQjPXCgL9aLJ5HRmQr/c0GKSGRxPJoxt35KIHRienHiOwl+SYeGR1+5JG/jXI+vtk
         n1BvA33oHXypHChgKoLotBLNKWJxARCZw+dQUIqJuilKD2/27XGFt2GIQUjeZWXW5+
         Vwa3ZqYOZpeTNwMvjGr5W2c0HrsPFmZi76xTDDG+dTFEoqiqOQO6Rr2uR1gBNaFmRQ
         tRzVGRGAfOBYajqwj70SVE3ME6pauBZEjlgAnqOFIPjpp8NfWer1SXDyg5XtUu/iUi
         V8oHgwIL8GTTA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9105FA008A;
        Mon,  9 Mar 2020 14:55:10 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Mar 2020 07:55:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 9 Mar 2020 07:55:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APx8CpBiwcSCj6Box/rtyOhr5yTJ7lHxvcr++ddS5lCRdhmm2zDKlvwjloXmQhpzteK7ZaxxXrWpNzkGidN4Txk5RC2yRlX5jlqbaczvBJHmCKGjunFdrQxDsX2GQn10i8TlqcrJfmViZIqeh9GxOI0FqjpR+RsKrIflTqRfVwCCDF7t4Ub1JYH0Wq8R/csLkpScK59+Ea36R7+VJpjsg2hZDAd/qSdDQdNGsQAvMvYwLwpmsAqGWFxBKA4A+4UG9m+9Qgm59ZdT6fEmjykLFT0Vjgh3Z5OpwG20dxK+bQ3GewpPto/b8JJGh+cXwrsdTLG7IrC0LiDOlFbLxvat4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJLUphmyRZjAJvDUp2hxC0y7PTkFRpMjPww/cMccves=;
 b=dxqgynK6bn/uC4SgvuDxyqK0Fqikld+pGt42CfdLCs7oh8P+vQg45MTbyssQUAx9gnGy9rRmbhZH8skhUhfhQrCX5yviH8/jlgedHHUPwbTUPo0KvTd4iiZPGwKjc7yK6AHAqKpopm69a7FE6vTGfvocv0InvHt63BcAipCEHf4hg2OXRUVK+5hhzqLMvdcLDQJP4i/mn/KQ8SJpKQWhoIubCENfXaq9h2ezKpMl6rvvC7KK5gVOtwgZA4Jwe1xDotIa/NcUJ/okPXlmNLXGXYYiSW3AEzQokSNHOF/DTPKHZ8B611rguVnhFFbJrPSoMarDHhnacoCwnuioFS9/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJLUphmyRZjAJvDUp2hxC0y7PTkFRpMjPww/cMccves=;
 b=EMzUx943G43jn5OXSOlHX5B/+m+/+4BuqcIYZrejUjxfqyLyNtnGDE3fGwhXJkYQec1pwYSCPIa88BoOG1y14YuoQQuteFf4ckWDP46ofsPSjpBqpSyfv4vjiLJlpTrDZXhY066jDs+o4EPEiZc+a1UP89vx2Fro/ZVpdfq/emA=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 by CH2PR12MB3768.namprd12.prod.outlook.com (2603:10b6:610:22::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 14:55:08 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 14:55:08 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "mario.tesi@st.com" <mario.tesi@st.com>
Subject: RE: [PATCH v2] iio: imu: st_lsm6dsx: disable I3C support during
 device reset
Thread-Topic: [PATCH v2] iio: imu: st_lsm6dsx: disable I3C support during
 device reset
Thread-Index: AQHV9N1xEgEHERgBLUy4R7RxGmU9Q6hAWUgg
Date:   Mon, 9 Mar 2020 14:55:08 +0000
Message-ID: <CH2PR12MB4216C6B0B5922780FB13B902AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <c4591fcbbb63c9280532e43b39c4f96323f321c2.1583625699.git.lorenzo@kernel.org>
In-Reply-To: <c4591fcbbb63c9280532e43b39c4f96323f321c2.1583625699.git.lorenzo@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZjQxN2M3MTMtNjIxNS0xMWVhLTgyOTQtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XGY0MTdjNzE0LTYyMTUtMTFlYS04Mjk0LWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iNDAzMyIgdD0iMTMyMjgyMzkzMDUyMzEz?=
 =?us-ascii?Q?NjYxIiBoPSJ3S0RySjVjUG9zVnl3Uy9NQUZ1QnZjNTl4WGc9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUE5?=
 =?us-ascii?Q?K091M0l2YlZBV1R1UjN0RE9iVGlaTzVIZTBNNXRPSU9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: e17ad4f3-6943-4681-5641-08d7c439dc5d
x-ms-traffictypediagnostic: CH2PR12MB3768:
x-microsoft-antispam-prvs: <CH2PR12MB3768FFD0E65B97FC6A28C350AEFE0@CH2PR12MB3768.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(366004)(136003)(396003)(189003)(199004)(9686003)(4326008)(478600001)(2906002)(86362001)(66946007)(64756008)(76116006)(66446008)(8676002)(66476007)(66556008)(6506007)(71200400001)(7696005)(186003)(55016002)(54906003)(33656002)(52536014)(110136005)(26005)(316002)(81166006)(5660300002)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3768;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ju/A5VWy+DCINrsfvhflGF3Ji+e+tbkbD6xph9MiY9URcP10EJiDj3IACb7DWRdqcJPzN7XHBDbU7ffnDqMPPr/NDrv4dP31JwYSZQkmE9vhh9QauA7mfgm3d75romcxiAI8pNK2G/7Jk0kNEqMAO9UVS4j+Eh1Slc+tVu/E7N6ph/DxZdJnjVFZa3v7zAjBWkQ+B782Te4ed1gZi1YD7wwHW6zZJLz+DsoIMsQlgWIsENmG0SslGc5d4H5NLb7GqftPzhSGJhemuIK/wdclWQQXWbr/ojdA+CUFwCTXvQPlLhPFo/77KhXrAvoyTjy03sdfF7+OeCVNlucrIVquhuXOeTu7U+O43Qz9Emu17P4z6ZBgNjW7zsp3FaGo25J1+q/Rz64GRkldLxyKxfpPtITvXq8tLZwSOwt4yYLq1zdVJKLqO6boJp6s3pMwHpZ5
x-ms-exchange-antispam-messagedata: NwnWtFdAvBgxKWvPj/vHLme9VZiA0kFyqbzv/IF9gLlczGzml/z8GQ281AHnSR6DC2prh4yVKOHDSrfluu03clo5eL/CcrEoi+oAFG73rdfB+GLGrO9J/ofkZ+oguJBfFG8SLyzMxp8XnBsQ3m+jLQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e17ad4f3-6943-4681-5641-08d7c439dc5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 14:55:08.4254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cS9xW8XMW3Sfakme8UqdqQHKibaObTVCJjxLtag7j3j6TlxScsHKYssWuF3hL7X93JD64rHLNwqCkC17KTuySQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3768
X-OriginatorOrg: synopsys.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lorenzo,

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, Mar 08, 2020 at 00:06:03

> Disable MIPI I3C during device reset in order to avoid
> possible races on interrupt line 1. If the first interrupt
> line is asserted during hw reset the device will work in
> I3C-only mode
>=20
> Reported-by: Mario Tesi <mario.tesi@st.com>
> Fixes: 2660b0080bb2 ("iio: imu: st_lsm6dsx: add i3c basic support for LSM=
6DSO and LSM6DSR")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v1:
> - fix comment syntax
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 31 ++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index f2113a63721a..dfcbe7c42493 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -266,6 +266,7 @@ struct st_lsm6dsx_ext_dev_settings {
>   * @wai: Sensor WhoAmI default value.
>   * @reset: register address for reset.
>   * @boot: register address for boot.
> + * @i3c_disable:  register address for enabling/disabling I3C (addr + ma=
sk).
>   * @bdu: register address for Block Data Update.
>   * @max_fifo_size: Sensor max fifo length in FIFO words.
>   * @id: List of hw id/device name supported by the driver configuration.
> @@ -284,6 +285,7 @@ struct st_lsm6dsx_settings {
>  	u8 wai;
>  	struct st_lsm6dsx_reg reset;
>  	struct st_lsm6dsx_reg boot;
> +	struct st_lsm6dsx_reg i3c_disable;
>  	struct st_lsm6dsx_reg bdu;
>  	u16 max_fifo_size;
>  	struct {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 84d219ae6aee..a2e775d6eaa0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -751,6 +751,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  			.addr =3D 0x12,
>  			.mask =3D BIT(7),
>  		},
> +		.i3c_disable =3D {
> +			.addr =3D 0x18,
> +			.mask =3D BIT(1),
> +		},
>  		.bdu =3D {
>  			.addr =3D 0x12,
>  			.mask =3D BIT(6),
> @@ -1128,6 +1132,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
>  			.addr =3D 0x12,
>  			.mask =3D BIT(7),
>  		},
> +		.i3c_disable =3D {
> +			.addr =3D 0x18,
> +			.mask =3D BIT(1),
> +		},
>  		.bdu =3D {
>  			.addr =3D 0x12,
>  			.mask =3D BIT(6),
> @@ -2041,6 +2049,20 @@ static int st_lsm6dsx_init_device(struct st_lsm6ds=
x_hw *hw)
>  	const struct st_lsm6dsx_reg *reg;
>  	int err;
> =20
> +	/*
> +	 * disable MIPI I3C during device reset in order to avoid
> +	 * possible races on interrupt line 1. If the first interrupt
> +	 * line is asserted during hw reset the device will work in
> +	 * I3C-only mode
> +	 */
> +	if (hw->settings->i3c_disable.addr) {
> +		reg =3D &hw->settings->i3c_disable;
> +		err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +					 ST_LSM6DSX_SHIFT_VAL(1, reg->mask));
> +		if (err < 0)
> +			return err;
> +	}
> +

After disable the i3c interface the dynamic address is no more accessible=20
and fails the initialization.

Best regards,
Vitor Soares

>  	/* device sw reset */
>  	reg =3D &hw->settings->reset;
>  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> @@ -2059,6 +2081,15 @@ static int st_lsm6dsx_init_device(struct st_lsm6ds=
x_hw *hw)
> =20
>  	msleep(50);
> =20
> +	/* enable MIPI I3C */
> +	if (hw->settings->i3c_disable.addr) {
> +		reg =3D &hw->settings->i3c_disable;
> +		err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	/* enable Block Data Update */
>  	reg =3D &hw->settings->bdu;
>  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> --=20
> 2.24.1


