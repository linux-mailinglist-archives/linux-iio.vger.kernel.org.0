Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9CFD17E318
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 16:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgCIPHx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 11:07:53 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58410 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726676AbgCIPHx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 11:07:53 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 58142C04C3;
        Mon,  9 Mar 2020 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583766472; bh=RF7RTOwv+rmvfofWvKr6fGa/lgO2q+hQONOrU084Q1c=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GNFZBV/JSbMSITCxqEFK9C5HHg55Ek+e3ozcvcjvCUB2repnL7pH9Uflcaj+xEm6E
         /gRgGJjgqewg/XLe4lAxpKnoh//qi0H49hkXt8Rc2KUto+AMMJ0J0RnrceO124lkgj
         JalpxYlNLszdsP1C+ePLLlDOQ9yT0cUWGPnB7NJkSKJVG9jSl89LpXnT6e1WCdJJWX
         LI3hPq1bh6bFy/62UmWIjf1DoMu2oHtBxqPGKVhWeRaXoZdaHuTiD6evp+9HuEug/G
         INRHOn6r1XGI3B3yoK47D/cWAcXuPxGo+BVlysvIbz63qaka3LagTjwV/MIlMeXlKM
         XikSxWCvd/H5Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id AE5B6A006E;
        Mon,  9 Mar 2020 15:07:51 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Mar 2020 08:07:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 9 Mar 2020 08:07:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXRqUksBLevut7u3NItskmGqeeKBcWyvqbVqB6xMGVXaKtqAZpZgv6bgV+rNEQ7bhOZUg/5ti5R8RsbG33ERNZ1+miO3GO0fNBx3mUn8C+Or6SZGf8b4I5PpLKp69p36AyX3Mt98k9mu8DunV/7a0IQ2epQuujvmHDitmc7zG6EM7qJRzYGJk322FxJyN1bSGh6f3ZgC82ra1cN107HQvBLsNRVE40m1pQaAL+BP/Tb+WralSEvpj627cFKBuo/tgCysleewClp8PO0VC6CDrqHP3tFOmilY+F+dCp79mBS4YyMiNhIcjuNShvlXntSqsy+d7GwS2X6PGxnWVFKMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bnw0DiY9wOULhHRLVN6sbq6nCep9HF9jxKrjd7xX3RU=;
 b=NRaUkJ6zqR9rLnn1DaV/bG5E907iWaeqdCxCrvsIaC/yWao9SLP3vOYSJcL614hQg0Ml0wTzNJRrm1tnCss4bB897Egnnd1MVQQZkbeM0ef6zrmo8wfn6/7VCKpgbsDmfq5qPXCxGi/r7E85Ld2t8SRZRH0fUNY6qK/hh0M7ZLOa7h0ccGsKt5aRh/Z/rzSJCWOxE/wTA/zPRzWcBY6hsmHherAYNCXSPnT9AF2t6an7GicTkEIOznmJicBEAUJ9eR5cIDSPstGn2JLj/zY0fvdmR9Ne3y85noLA3nLxwDfBc50c7SYjn2wREofBNArTKvXjO9DqBpg9106hKp/JZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bnw0DiY9wOULhHRLVN6sbq6nCep9HF9jxKrjd7xX3RU=;
 b=kRkkwaO9/uGlxeAPzyjTxkRiq9UtME1lTTtmQATeZf3pHH+A9BCXuX+9iYYjdoUEZCtmFNLl8z6v3ILcQG0betZoXrhjdh+jfTTvWp5N/XR01Axyv8iHEwKKlNBRB+iw3ZzEu26X8Xb76hcsdas8+efX/R9ey6uuywjqUBaDCYQ=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 by CH2PR12MB3782.namprd12.prod.outlook.com (2603:10b6:610:23::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 15:07:49 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 15:07:49 +0000
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
Thread-Index: AQHV9N1xEgEHERgBLUy4R7RxGmU9Q6hAWUgggAAEFYCAAAEL4A==
Date:   Mon, 9 Mar 2020 15:07:49 +0000
Message-ID: <CH2PR12MB421655D9F6A060E4199AC6CDAEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <c4591fcbbb63c9280532e43b39c4f96323f321c2.1583625699.git.lorenzo@kernel.org>
 <CH2PR12MB4216C6B0B5922780FB13B902AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309150101.GB490054@lore-desk-wlan>
In-Reply-To: <20200309150101.GB490054@lore-desk-wlan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYmI4MWNhMWYtNjIxNy0xMWVhLTgyOTQtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XGJiODFjYTIxLTYyMTctMTFlYS04Mjk0LWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMTc2NCIgdD0iMTMyMjgyNDAwNjY4MTM1?=
 =?us-ascii?Q?NzIyIiBoPSJmWmE4QnVyRitFbW5UandWbkF2RUdsNldSYTQ9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUFx?=
 =?us-ascii?Q?TWR4OUpQYlZBVjNjOVQ5UURidnVYZHoxUDFBTnUrNE9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: f774c3dd-5810-4f16-430a-08d7c43ba220
x-ms-traffictypediagnostic: CH2PR12MB3782:
x-microsoft-antispam-prvs: <CH2PR12MB3782BF5AC10A8B2475E1A650AEFE0@CH2PR12MB3782.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(396003)(39850400004)(366004)(189003)(199004)(52536014)(86362001)(186003)(54906003)(66446008)(316002)(2906002)(9686003)(66946007)(64756008)(66476007)(66556008)(4326008)(76116006)(55016002)(5660300002)(33656002)(26005)(71200400001)(81166006)(81156014)(478600001)(6916009)(7696005)(8936002)(6506007)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3782;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jNAsY75DzXMQ1bDoegxVN4k1F49YTyuMhYrZo3kPRyflmpckJSO9qzl+/qSO2Kgnyhg2NLW9tEcrFBFStXzCiOl5VUaFIDkRaiktU49zci/VSSUZQFfZpHpGjo6yindl48iam/rnFD+9X+6/86MULyTrQXRs2UibVz8Fpp++IZZZxYm0jnFOaEkQp5netvS6h7loL8f/5Yp1Bkh3VYBYUce8paVjkTGXaXEPw4IIUMQ0QZoJuzCmRko9AIG5lpFOcrRi/Jb/HfevgDgwQNXuGJQ1034W2V94cWIeoI9+dOHpyHFjZeyU1ns8n9/5PWCFfJg6khmjxXZcygTUTGqadhLup5phuXzapDIZVvSNnL12o25sd7ln4On/+SRQAjqngdU1vMr2+rWWS5UXC+9I2S6TLDw9rxGvHnL/bCnhY89CPFOoTuooQcLGuad8JBtg
x-ms-exchange-antispam-messagedata: 3GtaVfUwdo3mfaG2sf5AHSJsgbzGjJyDx+djwznfw6ckFrVhbmCV1LmPVlLLFJ8qEM7v2g0tuNBmzhXoBMFUKe7qgJBg4WRS0tDKkHohPu59vhJ/PluZ0DNAT8EWfd0AqO6K7z2/lgTtrTt+y/e4jQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f774c3dd-5810-4f16-430a-08d7c43ba220
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 15:07:49.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUcr3Wsj9iIhH1Ni64DND41RlWb2KPE6XkNEfZpt6lci29e/6efDqQgjHxOd+2ppKlgr2qDhm5N8TaoV8T6XqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3782
X-OriginatorOrg: synopsys.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, Mar 09, 2020 at 15:01:01

> > Hi Lorenzo,
> >=20
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > Date: Sun, Mar 08, 2020 at 00:06:03
> >=20
> > > Disable MIPI I3C during device reset in order to avoid
> > > possible races on interrupt line 1. If the first interrupt
> > > line is asserted during hw reset the device will work in
> > > I3C-only mode
> > >=20
>=20
> [...]
>=20
> > > +
> >=20
> > After disable the i3c interface the dynamic address is no more accessib=
le=20
> > and fails the initialization.
> >=20
>=20
> Hi Vitor,
>=20
> thx for testing it. What do you mean here?
> Is int1 set to vdd in your test?
>=20
> Regards,
> Lorenzo

Yes, according with figure 14 of lsm6dso datasheet.

Is there any way to clear the INT1 before the hw reset?

Best regards,
Vitor Soares

>=20
> > Best regards,
> > Vitor Soares
> >=20
> > >  	/* device sw reset */
> > >  	reg =3D &hw->settings->reset;
> > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > @@ -2059,6 +2081,15 @@ static int st_lsm6dsx_init_device(struct st_ls=
m6dsx_hw *hw)
> > > =20
> > >  	msleep(50);
> > > =20
> > > +	/* enable MIPI I3C */
> > > +	if (hw->settings->i3c_disable.addr) {
> > > +		reg =3D &hw->settings->i3c_disable;
> > > +		err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > +					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
> > > +		if (err < 0)
> > > +			return err;
> > > +	}
> > > +
> > >  	/* enable Block Data Update */
> > >  	reg =3D &hw->settings->bdu;
> > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > --=20
> > > 2.24.1
> >=20
> >=20


