Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5293FBE16B
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2019 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfIYPfP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Sep 2019 11:35:15 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:59240 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725966AbfIYPfP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2019 11:35:15 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 657E5C03C3;
        Wed, 25 Sep 2019 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1569425714; bh=JLF9KuBP45b6yHeoKOIC5xSeGpPnkrJC4gMGm2Ri1ZE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=j5ZpyQCoe37Sb2D/FqMWA2KfZw7eeeZaLzECAeQ0nCEBbqRss7OhoQJprPVXCqiAl
         vmFZ19ylgQYxCaKsXUVKzmWtbx7BLHPozbr5zkkbony5VxiUm2JHmH14D854zFPd/M
         X5QJW9MNMIbQjKw2vDIMNmhiFIcxgFQXNhteACLrYCMAB3psX9HwthU3DlaVh7tBaY
         ADOj781VVi1HhQtN9T71HbyIHD8HDJ1xItULXJ3r/0SKa6S92lRqT1G2RKIi/NK7me
         kBg35zxmbYuqS3IJXlQmYZ9HcBoP7OMM2IMsXhtoC7OyDGZ+pG+/O5H9PVn6xM9H52
         V3g5RPTBUifAA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EC6B3A005A;
        Wed, 25 Sep 2019 15:35:12 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 25 Sep 2019 08:35:12 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 25 Sep 2019 08:35:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDzM5wmrO1CK1HeZO6+wRCkTGc6Edy7xH44OUoWv5xM0bSUNysSOwfbLm1GbsLwjY6pzjzb9FMyJghqvMQtJwIaszVNok6yUvfa4SckjOUUJi6YMzbxquNwody5h+FwEcfH9z9dSfedgiEgaAA7JptqU0KE2TlonC2cR9TmhuCxjNPOhryYsy6xPQzyJ18ULgYJ/8OpudppZV/TZZmvWreP9dF5CpL4L+3goiPPTZbyP7BSTRZ6lzhlkkC02/n+p4waTmm9+wA+rmo/NFkIjLZQOxQJxLjLKafnTPXOaH44TgEwrNDRT0WHlXP3szGiLAq8cXUYaK7I/2m5oRGMHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDASZVKG/eWjaRzvDF5EXeVkEt5b91CNyyhpsWUGksQ=;
 b=dmw/7lAeUkNGCVqMvb/CxaoDiwUdRCe1oSGAkYEt9/9ErY4c+NBzbq4Hga/p4/rZ/XBtQ2fQAdIUkwSjX/9uljcOaViXVjpg9MnLMWgjKzwCD7vTtFpg/Ua6n0uNfQ/VOnNYExMUIK7gTLyZPQIAkYFVadQ26eS2PkH6qUdC60fO4cSMvRfaO6j2Ou5J7/9uHhizRXQABeKMIWk/Uwh44AqXIaQQgfdG/AdEDaqksOfrdm9B9dBJTXh7wkAnMVY2zj5kh5kufYazoxDrph5U4CC5EDrSNogipb6vEO+Q+4YEL3J43t3x9LyaNC5qE/8wBXRJ1uWHRI9qXlz0Bn31HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDASZVKG/eWjaRzvDF5EXeVkEt5b91CNyyhpsWUGksQ=;
 b=KB20nYvKx4RGcmOoNTLRx6jugUSPatKKHeJ0bJ665BiRVYEXB77A9ySKDI9xkg03Y00kBDY0GKiWAx359jTObrkPsy7h9PhgT8X5jvNdiqOdiiIlA3k86a3+VLmGPHBNPM6oi8KPakBm+BnWAhFKyI+V8aKEWvVLGwYIgjDZrPI=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (20.180.6.151) by
 CH2PR12MB3717.namprd12.prod.outlook.com (52.132.244.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 15:35:11 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::9cde:1aac:8caf:c5d4]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::9cde:1aac:8caf:c5d4%3]) with mapi id 15.20.2305.013; Wed, 25 Sep 2019
 15:35:11 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
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
Thread-Index: AQHVPjZGdWz6T7t9ZkKVb9XC8/rtK6bVU8UAgGeaouA=
Date:   Wed, 25 Sep 2019 15:35:10 +0000
Message-ID: <CH2PR12MB421658374F977C89B5A3F1B7AE870@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1563542515.git.vitor.soares@synopsys.com>
        <77c709aca8607f31f141ee7c4dc28bf89266bd23.1563542515.git.vitor.soares@synopsys.com>
 <20190721181656.236faa63@archlinux>
In-Reply-To: <20190721181656.236faa63@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMGM4NzE1M2YtZGZhYS0xMWU5LTgyNWEtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDBjODcxNTQxLWRmYWEtMTFlOS04MjVhLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iNTQ3OSIgdD0iMTMyMTM4OTkzMDY5MzE5?=
 =?us-ascii?Q?NzgyIiBoPSJ3eEp4NzFIUzhmMXJyQW5mVmtBODBMclBqNVE9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUJt?=
 =?us-ascii?Q?NXQvT3RuUFZBYUZRYkxQOUxua2xvVkJzcy8wdWVTVU9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: eef4cfee-81a3-4ba1-06fd-08d741cdf3c8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR12MB3717;
x-ms-traffictypediagnostic: CH2PR12MB3717:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3717DCC41ADD5C8CA38E3AABAE870@CH2PR12MB3717.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(136003)(366004)(346002)(189003)(199004)(8936002)(6436002)(6246003)(4326008)(33656002)(66946007)(99286004)(76176011)(66556008)(6116002)(55016002)(7696005)(66446008)(54906003)(71190400001)(71200400001)(478600001)(64756008)(316002)(66476007)(76116006)(66066001)(5660300002)(14444005)(6916009)(476003)(26005)(186003)(25786009)(6506007)(102836004)(52536014)(3846002)(86362001)(2906002)(14454004)(8676002)(486006)(305945005)(256004)(446003)(74316002)(7736002)(107886003)(9686003)(81166006)(81156014)(229853002)(11346002)(42413003)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3717;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: REz2o7XF+XtCH/SIvCip+dA4vGGJqb35l6zpFSs0bETPXrKpolJHOFTLmPCmvBnp2j8ZIeufLMI/17wVJVuaaojNm/mbP06N0TaI8ChfxAgMg035H/GagY10o5aOb+oX8kKBJup7kd9Z9bUbbWgmF/IphsU/s4/WIvp8dUDD98dlgKnXhSq2z+8Kl9xERXAt5w55JvzvyTu5RfQwouMY8wjk+4PsZX5TRUn2nK48ng+DCxbqvrgCoovNvvDSmOAx70N4jhLo2t+vYya9+ZtEGZCDIp8D7Hlp4vlcs6sTC6TdwI7BSubdS9/8b62duUUxrBliX89cmd9nYYUyrHDAps+zymG6a/dAPrO6SGCGh5B5mybaGhum5+xZj3UgIZkWbjJfufQUDv7T3dy4oQ3ZnjgaDKWuxQ61BdP6eocOTdk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eef4cfee-81a3-4ba1-06fd-08d741cdf3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 15:35:10.9017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWfBKSWV6PFffoNMnMwlETUX9/GdFRO1AUgtb90Cgl/5Q/NUtVYEphdxXdNz1hYXMc3g1B/BtDsW59uVT80ZQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
X-OriginatorOrg: synopsys.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, Jul 21, 2019 at 18:16:56

> On Fri, 19 Jul 2019 15:30:55 +0200
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>=20
> > For today the st_lsm6dsx driver support LSM6DSO and LSM6DSR sensor only=
 in
> > spi and i2c mode.
> >=20
> > The LSM6DSO and LSM6DSR are also i3c capable so let's give i3c support =
to
> > them.
> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Great. I'll pick this up once Boris has that immutable branch
> available. Give me a poke if I seem to have lost it!
>=20
> Thanks,
>=20
> Jonathan

I didn't see the i3c support for st_lsm6dsx driver in pull request, could=20
you please check it?

Best regards,
Vitor Soares

> > ---
> > Changes in v6:
> >   none
> >=20
> > Changes in v5:
> >   Move regmap_config declaration inside st_lsm6dsx_i3c_probe()
> >   Fix warning [-Wint-to-void-pointer-cast] when compiling in 64-bit arc=
h
> >=20
> > Changes in v4:
> >   Remove hw_id variable
> >=20
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
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 57 +++++++++++++++++++++=
++++++++
> >  3 files changed, 65 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_ls=
m6dsx/Kconfig
> > index 9e59297..6b5a73c 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> > +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> > @@ -1,11 +1,12 @@
> > =20
> >  config IIO_ST_LSM6DSX
> >  	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors"
> > -	depends on (I2C || SPI)
> > +	depends on (I2C || SPI || I3C)
> >  	select IIO_BUFFER
> >  	select IIO_KFIFO_BUF
> >  	select IIO_ST_LSM6DSX_I2C if (I2C)
> >  	select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
> > +	select IIO_ST_LSM6DSX_I3C if (I3C)
> >  	help
> >  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
> >  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> > @@ -23,3 +24,8 @@ config IIO_ST_LSM6DSX_SPI
> >  	tristate
> >  	depends on IIO_ST_LSM6DSX
> >  	select REGMAP_SPI
> > +
> > +config IIO_ST_LSM6DSX_I3C
> > +	tristate
> > +	depends on IIO_ST_LSM6DSX
> > +	select REGMAP_I3C
> > diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_l=
sm6dsx/Makefile
> > index e5f733c..c676965 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/Makefile
> > +++ b/drivers/iio/imu/st_lsm6dsx/Makefile
> > @@ -4,3 +4,4 @@ st_lsm6dsx-y :=3D st_lsm6dsx_core.o st_lsm6dsx_buffer.o=
 \
> >  obj-$(CONFIG_IIO_ST_LSM6DSX) +=3D st_lsm6dsx.o
> >  obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) +=3D st_lsm6dsx_i2c.o
> >  obj-$(CONFIG_IIO_ST_LSM6DSX_SPI) +=3D st_lsm6dsx_spi.o
> > +obj-$(CONFIG_IIO_ST_LSM6DSX_I3C) +=3D st_lsm6dsx_i3c.o
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/=
imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > new file mode 100644
> > index 0000000..57e6331
> > --- /dev/null
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> > @@ -0,0 +1,57 @@
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
> > +static const struct i3c_device_id st_lsm6dsx_i3c_ids[] =3D {
> > +	I3C_DEVICE(0x0104, 0x006C, (void *)ST_LSM6DSO_ID),
> > +	I3C_DEVICE(0x0104, 0x006B, (void *)ST_LSM6DSR_ID),
> > +	{ /* sentinel */ },
> > +};
> > +MODULE_DEVICE_TABLE(i3c, st_lsm6dsx_i3c_ids);
> > +
> > +static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
> > +{
> > +	struct regmap_config st_lsm6dsx_i3c_regmap_config =3D {
> > +		.reg_bits =3D 8,
> > +		.val_bits =3D 8,
> > +	};
> > +	const struct i3c_device_id *id =3D i3c_device_match_id(i3cdev,
> > +							    st_lsm6dsx_i3c_ids);
> > +	struct regmap *regmap;
> > +
> > +	regmap =3D devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config=
);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&i3cdev->dev, "Failed to register i3c regmap %d\n",
> > +			(int)PTR_ERR(regmap));
> > +		return PTR_ERR(regmap);
> > +	}
> > +
> > +	return st_lsm6dsx_probe(&i3cdev->dev, 0, (uintptr_t)id->data, regmap)=
;
> > +}
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


