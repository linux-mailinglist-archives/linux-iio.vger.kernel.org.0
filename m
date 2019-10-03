Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7829CAD4C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2019 19:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389319AbfJCRiI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Oct 2019 13:38:08 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:32992 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389314AbfJCRiG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Oct 2019 13:38:06 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7E1C9C2B8E;
        Thu,  3 Oct 2019 17:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1570124285; bh=GU4fjpcT5qvPljcoDO3TBiv3dbZijWCb6UL6cmpwNYk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZLWpvfSTK1nrDP1hHxrm69uY14/07g4UcTDmUEPgUEWYFWu/nHLA4UjKDGgkxTydt
         JiU3aPN4X4H6PhncjKf3q51c2MzSvGP/+RN5IwxVgtdwNauYaoeUcSZMah7DUDCeii
         JRhb1rlMCP4KE4b9LEN89EK0qxKKvYGh/GxySWbCJTZqUnIu0w+5FoOeYz/RnrM8il
         TNW9HIPHwFDgjoVvumAIh27S2fG2ohxeSNpohaLZjYR+zcYY9VJ0/5IRUZzNXp5sr1
         tG0St6cyiL1jFqBoDvgu4T5segkY8mULowpmBi2a/+nqiisJNYMNVQ8MrRhL5pAtxM
         T15WuiYN+14Nw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 28DF7A0073;
        Thu,  3 Oct 2019 17:38:04 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 3 Oct 2019 10:38:04 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 3 Oct 2019 10:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI7ssUcEu/4ZSCRC4NdCb0fvpHcgH+Xqb9RRnLpu3dHjLYiKNxTz1lZ3H61Io2LYSJ7kp0ZahDl86k5SnEzJzsBS/8rIeQfiD6uqb9qij4kFtLV/4iN8QXmITNohF7b8xoiAby4mBJWkQT6nonMuGKZeJZL9mQuuRyCgYbLvWBk42v62lopy2Diux78t6CLxhUsvTZprwS7HF3riMosDQ4wZzL19phcUgCBdOZUVuuZAE4udZLQ0XG7q6LBBdK2UipPdjWTL/XQFmTocJ4UqbpkkY4b43+TJA4OAAm+TEWXKs53Y9og/gREM5rsByJuZ6IxGnGHET+6hE21AGyVjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk9ZdbGXI6bdNJTQiCsLHQBF4w4kc7MHgQvC+MDgg8A=;
 b=asQ/+A3WaTM8QbOkPUkQnqIADJz8RI4TFqY6K8hG5JJjxoIb25pew8iettr+wQ+8RVUkNKVcB5jFr6TrYdP73KRGavahyfBVXnPe9dV0tKmL65Dfdx+NIpaSYQbXNaBK9zYU/MLI4Cjc/A3QJe9SPfE+DjsOw1lkqW6u22jihrY+c6q1rYpogpd6OobXMbDOciVLURd4NTCm7/kJkhlGJ/914AOPBPw5Tt18Bjb7liE0DURBWcpY9Laeu7+rPxhWaerHLp/UTSS5EABV2+c9B0vCfcCz785OC1dzMLBWTll8Bsfsg/HE/WIGVqy3GwNgXPECrpmzyFDZgCLl6FBQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk9ZdbGXI6bdNJTQiCsLHQBF4w4kc7MHgQvC+MDgg8A=;
 b=NLJaVDqYccH/vTVOiomazPuZqP1FWi72m0svpEP2E8svVMPiki52+e2mzhnybLXRJ8d6w/DIU/e6CXAmJTzG+jVNcxaJrkbMLW7xWcnCl+6PC2gouIql5in5KJH5b2UTh4Id7RHOIE7IbDdvxEyrPGlpPjCROyAplEOFUQnCwng=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (20.180.6.151) by
 CH2PR12MB3893.namprd12.prod.outlook.com (52.132.231.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 17:38:02 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::9cde:1aac:8caf:c5d4]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::9cde:1aac:8caf:c5d4%3]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 17:38:01 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: RE: [PATCH v6 2/2] iio: imu: st_lsm6dsx: add i3c basic support for
 LSM6DSO and LSM6DSR
Thread-Topic: [PATCH v6 2/2] iio: imu: st_lsm6dsx: add i3c basic support for
 LSM6DSO and LSM6DSR
Thread-Index: AQHVPjZGdWz6T7t9ZkKVb9XC8/rtK6bVU8UAgGeaouCADFZGAIAACL9A
Date:   Thu, 3 Oct 2019 17:38:01 +0000
Message-ID: <CH2PR12MB421631797B1A1CB5CEE2A04DAE9F0@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1563542515.git.vitor.soares@synopsys.com>
        <77c709aca8607f31f141ee7c4dc28bf89266bd23.1563542515.git.vitor.soares@synopsys.com>
        <20190721181656.236faa63@archlinux>
        <CH2PR12MB421658374F977C89B5A3F1B7AE870@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20191003124902.00003547@huawei.com>
In-Reply-To: <20191003124902.00003547@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctOGExYzg2Y2EtZTYwNC0xMWU5LTgyNWUtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDhhMWM4NmNiLWU2MDQtMTFlOS04MjVlLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMTg0MyIgdD0iMTMyMTQ1OTc4ODAwMzc4?=
 =?us-ascii?Q?ODkyIiBoPSJzMHQrS1dLUGxVTjd6K0xrM2NibG1QY0dwMW89IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUFN?=
 =?us-ascii?Q?bE9STUVYclZBZmlzYThtU0orWTIrS3hyeVpJbjVqWU9BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQWt4V29sUUFBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
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
x-ms-office365-filtering-correlation-id: 493a6487-b836-4361-5c07-08d748287077
x-ms-traffictypediagnostic: CH2PR12MB3893:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB38935E838F211BD27921AAA3AE9F0@CH2PR12MB3893.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(199004)(189003)(6116002)(6306002)(4326008)(102836004)(9686003)(81156014)(8676002)(81166006)(8936002)(229853002)(33656002)(6506007)(6436002)(14454004)(99286004)(256004)(14444005)(52536014)(6636002)(86362001)(76176011)(498600001)(11346002)(110136005)(966005)(486006)(5660300002)(476003)(446003)(54906003)(7696005)(305945005)(55016002)(186003)(6246003)(107886003)(7736002)(2906002)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(71200400001)(71190400001)(66066001)(74316002)(3846002)(26005)(25786009)(42413003)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3893;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9X+rQCAYM6OGI0BRXKQ1dzH2E9MCs+PzI66Dpcfuu5OfjZMVYogh2ewbeA8HUVFiNrFGeJ9PXBRCYaNthpmiqSIygh4Zy8SUIE1g6EuDsktBSuFzoXxBT861WNFp3y4Sxi8acUQKmOLnzwaymFEJN6aQNDZqsE4PAV7QTHYRRLTQ+lZBd7XBjSv6DlpfxsTrM5FIRlYh83WbEle2memG8sm4uwmO5eNicPf4+9uhf16m+sBQv62t6Rto34zjmaYMrp2q/DY9Urg0xJkQ9+F8QsLYaeF0AyNkJyWpPJ9QUdiEam9Vy0XmRnwB17FkMWvW1iP3iYUZL2r/W86U48Qeev7PeBiW0MrKzn+W286/5GluJmyH8sHfmWgwQPhJdI9MoL2WId8Kf2XOo02vt3cOvfkwD/qQyMOMi6e6v+teZSto3eoQOSQjAPmSUmtlwlLK0GYVxUl+gdoZyWJ/Hi3WYQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 493a6487-b836-4361-5c07-08d748287077
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 17:38:01.6885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Mf+mNa5+sYJZTNZ6BDJa6ciiUarDtZ8UwHwtW4HIO9y6VKD3gXXIbst1Rj+wyiqnbN3NMOEb8R9u2q9kG4wqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3893
X-OriginatorOrg: synopsys.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

From: Jonathan Cameron <jonathan.cameron@huawei.com>
Date: Thu, Oct 03,=20
2019 at 12:49:02

> On Wed, 25 Sep 2019 15:35:10 +0000
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>=20
> > Hi Jonathan,
> >=20
> > From: Jonathan Cameron <jic23@kernel.org>
> > Date: Sun, Jul 21, 2019 at 18:16:56
> >=20
> > > On Fri, 19 Jul 2019 15:30:55 +0200
> > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > >  =20
> > > > For today the st_lsm6dsx driver support LSM6DSO and LSM6DSR sensor =
only in
> > > > spi and i2c mode.
> > > >=20
> > > > The LSM6DSO and LSM6DSR are also i3c capable so let's give i3c supp=
ort to
> > > > them.
> > > >=20
> > > > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > > > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com> =20
> > > Great. I'll pick this up once Boris has that immutable branch
> > > available. Give me a poke if I seem to have lost it!
> > >=20
> > > Thanks,
> > >=20
> > > Jonathan =20
> >=20
> > I didn't see the i3c support for st_lsm6dsx driver in pull request, cou=
ld=20
> > you please check it?
> Seems to have made it
>=20
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pub=
_scm_linux_kernel_git_torvalds_linux.git_tree_drivers_iio_imu_st-5Flsm6dsx_=
st-5Flsm6dsx-5Fi3c.c-3Fh-3Dv5.4-2Drc1&d=3DDwICAg&c=3DDPL6_X_6JkXFx7AXWqB0tg=
&r=3DqVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=3DRaUb9HXBdF5dxPWn5sdO7g=
qqaQzqY7UFd8Rcv0ioTx0&s=3D-Xs5gaN2wau8fXfg5hryTStGMVD8WFA66mX0hCMsmXg&e=3D=
=20
>=20
> I checked back. Was in the first pull request back on the 12th of August.
>=20
> Jonathan

I confirm that is there. I'm already using it.
Thanks a lot.

Best regards,
Vitor Soares
