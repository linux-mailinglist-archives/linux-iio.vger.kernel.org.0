Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A1A17E348
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 16:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCIPR7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 11:17:59 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58904 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbgCIPR6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 11:17:58 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 54891C04C2;
        Mon,  9 Mar 2020 15:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583767077; bh=3h7buN2dxDI7nWUQtgRP+IThNS4nqLwXaP4/gnJD8zU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lv0UAJL0tdedebbBz4czePJqPVnhyiWonz4fXPPq+GT5LFL5kbbFM5g5BZGSGWOBe
         G+kc2djpMXBsnNl6QT08ySEAqiJ13siJ85qRBLtb9qdq1lawnZNQ3XNRMJkGuQO/hJ
         AT3oQ3tzkPPx/A/nPuGA0XtGXcL9ewAbacT5OAGu+i35gytp/YSKc5aPcsBtpAx0LC
         dtPXChtNwQUTjn9MTuCV1Vhl7V/JhTTwad/MT6qIaYxYCxfJHkFLgb4qU+YXlp7XkV
         zzIN7Ol02zh7J4Lv7o7tMMJ4lLmakqCjRLadRKUKLixz1eZEcYpvVGQsJtonYND50G
         XnaUCwihdB3/Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D710AA0067;
        Mon,  9 Mar 2020 15:17:56 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Mar 2020 08:17:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 9 Mar 2020 08:17:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Woe5iFDUs2AhPmdPV5OcNVye4Iikan4RbiNuKQYY/0uYHX61XZ3CoXPndSM8wojq3dZvMAaz/oCfO+gZFgTohgu7bLYw0lC/9e7C1O2yvlGqWaYzmDzDIUiiAGwbPyF0fziEMhIzZQSNYdbBSBoQTJVw8aU7YCoRY+SBEKN5i4HS3u0I+2xvgNwPubRHJFHxXkAu/JCAYOzoVxnwPJCWayG4Y7zmp4A8Af3gcV0OpaJaTAZhI8jQDHfFxZCD1eGvBaqy/EgXldEozfnbeY7xI3he7GOyGon8VmPYffCMANXOWn+kvMvP5APXihIXX87hIop+gdRbYtSb9258y82NTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVX5CRJtBXF+82PaHVvNdRPaD5SscvqcPMs2ypRPAzM=;
 b=BAeM60yELM9E5sssd2AIIjpw7ktxKSsSjp+IKBCcimXg4B181qaZyoVOnQjSpNDgFsZbi441qS7BklDMJqd92o4/gdTs+x+fJozWfdFRh8nRfYFNIFar051Pfj8RwyMPDO3P4lIgRsY9rDDawuAqBuN9eojnHCP3xF3RaUf85Yo/6LEG0h/oqgoqY9Vq2PJz2nToSlv04PaggOIhIrBwyHgo8JK/idgcC7uwWrWR/9IqSFze7Co09sv0IxloFPIe0WLNKSvrNM0hh87bwjX0VYEDYzYGgUgDerCeXO/chzOhokZsXH7C8P9+jm5VLoh2tfRbCL1uXooCcPEKAnH9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVX5CRJtBXF+82PaHVvNdRPaD5SscvqcPMs2ypRPAzM=;
 b=a0VGn7JvEp831bbO7di5fNuQxybVIQY9dgT/Tx9kvxRTgU9ISbliRasIryX75yx52td/2U5vKDPcwLH7Yw6K/6yNbRF6Pvsayu3F+Um+9L4dYnmhogPy8G+fvmYpdn6s6qd1f0hMBtS7Ofz/Ym/U7DdOQT4Y2mff5MJOlu5rVlU=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 by CH2PR12MB3670.namprd12.prod.outlook.com (2603:10b6:610:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 15:17:55 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 15:17:55 +0000
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
Thread-Index: AQHV9N1xEgEHERgBLUy4R7RxGmU9Q6hAWUgggAAEFYCAAAEL4IAAAaGAgAAAVSA=
Date:   Mon, 9 Mar 2020 15:17:55 +0000
Message-ID: <CH2PR12MB42164216A155A4EB5F2EC8A8AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <c4591fcbbb63c9280532e43b39c4f96323f321c2.1583625699.git.lorenzo@kernel.org>
 <CH2PR12MB4216C6B0B5922780FB13B902AEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309150101.GB490054@lore-desk-wlan>
 <CH2PR12MB421655D9F6A060E4199AC6CDAEFE0@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200309151035.GC490054@lore-desk-wlan>
In-Reply-To: <20200309151035.GC490054@lore-desk-wlan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMjM4M2NiYzEtNjIxOS0xMWVhLTgyOTQtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDIzODNjYmMzLTYyMTktMTFlYS04Mjk0LWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMjY1MyIgdD0iMTMyMjgyNDA2NzA3OTU1?=
 =?us-ascii?Q?MzE1IiBoPSIrUlh5ZEFXV0NuTmVBMktFYVFQWHUzVTVtV3M9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUJ6?=
 =?us-ascii?Q?aHR6bEpmYlZBWEhac2EwMzhhQWxjZG14clRmeG9DVU9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: c00fb105-9299-40d8-ce8a-08d7c43d0b0e
x-ms-traffictypediagnostic: CH2PR12MB3670:
x-microsoft-antispam-prvs: <CH2PR12MB36704D1BABF3F879207468F7AEFE0@CH2PR12MB3670.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39850400004)(376002)(346002)(366004)(189003)(199004)(86362001)(76116006)(478600001)(64756008)(8936002)(66446008)(66476007)(66946007)(66556008)(5660300002)(52536014)(8676002)(2906002)(81166006)(81156014)(26005)(33656002)(9686003)(6506007)(7696005)(186003)(6916009)(55016002)(4326008)(316002)(54906003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3670;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zbkPZFYJb3QQim7IOy2os4Ik65m5bQYXKhCz+eQ2z3inoMKQdvIqUfI3pYxG4e8sW8WWFtFVk5pMVOUfMFVrT1skXr8vYmMjDUy/F+QA6/lzDswme9A87URmYqQvmUXNqWXDXqF94LVJY90GnsNaKx14XQBNMz0wwYP1Mv8/oP0oFQjGMjlPL3ineIXlcPpiIb8tAg1e0u9DTlCSOaqGzOuWuGtA234Ap8dTf+gGOhdRSJ+rmY0HgI6CxWsZEWnKO0SBEzB2Bdtc70Jhd8GHlS29o7UeBtQYR5y3r0frdpn3FYtxS9tpu7H1lUqEywYD2AzZGi1lLcOdv7RAcE3cmznAk8u3/ADty39A6zo2A7DWqXE4p1se6brkJ9iN/JW19gGEEMMRTkQzC9qeesvFRIMLZJlHxR+TRPoEbKHXD57ivz/jKqxYmeYEpQ0trPJ5
x-ms-exchange-antispam-messagedata: GNngY4+M566whtM7QBWqREpDi3Pd+WQ67uQf+FQOIN1YG0ZsIJnYB87ZlafR69Wfjv2Y/0ufnjWC3F/xFMJBUylfGkKsfjUfZDJHqXwhKKs6CwrQwZlFy2FUw6jldt24dcV5x5PXaLU5DDemj5XaJg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c00fb105-9299-40d8-ce8a-08d7c43d0b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 15:17:55.3126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tf819Z2y9ypXfR5nOiZOp78CJYtlJaIQMEjpNeoAd0AAemdgV2awuwXiF5SG33hwYRFGk+UnYXDdDqPV312BDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3670
X-OriginatorOrg: synopsys.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, Mar 09, 2020 at 15:10:35

> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > Date: Mon, Mar 09, 2020 at 15:01:01
> >=20
> > > > Hi Lorenzo,
> > > >=20
> > > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > Date: Sun, Mar 08, 2020 at 00:06:03
> > > >=20
> > > > > Disable MIPI I3C during device reset in order to avoid
> > > > > possible races on interrupt line 1. If the first interrupt
> > > > > line is asserted during hw reset the device will work in
> > > > > I3C-only mode
> > > > >=20
> > >=20
> > > [...]
> > >=20
> > > > > +
> > > >=20
> > > > After disable the i3c interface the dynamic address is no more acce=
ssible=20
> > > > and fails the initialization.
> > > >=20
> > >=20
> > > Hi Vitor,
> > >=20
> > > thx for testing it. What do you mean here?
> > > Is int1 set to vdd in your test?
> > >=20
> > > Regards,
> > > Lorenzo
> >=20
> > Yes, according with figure 14 of lsm6dso datasheet.
>=20
> uhm..probably we should do this configuration if the device is not in I3C=
-only
> mode. Are you able to test it without setting the int1 to vdd?
> Unfortunately I have no devices with an I3C controller yet.
>=20
> Regards,
> Lorenzo
>=20

Yes, I can test but I suspect we will have the same issue because it lost=20
the dynamic address. I would say to add a flag during the probe to=20
indicate the interface and bypass this if in I3C mode.

This may be useful when address the In-band interrupts.

Best regards,
Vitor Soares

> >=20
> > Is there any way to clear the INT1 before the hw reset?
> >=20
> > Best regards,
> > Vitor Soares
> >=20
> > >=20
> > > > Best regards,
> > > > Vitor Soares
> > > >=20
> > > > >  	/* device sw reset */
> > > > >  	reg =3D &hw->settings->reset;
> > > > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > > @@ -2059,6 +2081,15 @@ static int st_lsm6dsx_init_device(struct s=
t_lsm6dsx_hw *hw)
> > > > > =20
> > > > >  	msleep(50);
> > > > > =20
> > > > > +	/* enable MIPI I3C */
> > > > > +	if (hw->settings->i3c_disable.addr) {
> > > > > +		reg =3D &hw->settings->i3c_disable;
> > > > > +		err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > > +					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
> > > > > +		if (err < 0)
> > > > > +			return err;
> > > > > +	}
> > > > > +
> > > > >  	/* enable Block Data Update */
> > > > >  	reg =3D &hw->settings->bdu;
> > > > >  	err =3D regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> > > > > --=20
> > > > > 2.24.1
> > > >=20
> > > >=20
> >=20
> >=20


