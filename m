Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591921B0CEA
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 15:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgDTNjc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 09:39:32 -0400
Received: from mail-bn8nam11on2072.outbound.protection.outlook.com ([40.107.236.72]:6143
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726498AbgDTNjc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 09:39:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRaLJ+uaHxt/zhDzXinAEYD6KqhHQwon54iZRrdDkm7l2RdUbvqti+2PNInkI3R5O+ChDw7O4WnQy9LyZAFh+kU/lPzcD1ymCmmvZf7z/TRlFrlluFoIn/E7ZUhosdTgHmw3SCtPfn4LNavHM2ie/wyzmrmXjRjDqqxVPzsV+dAfxryNyU6tRvJNucPlqNz5DdxFq6BoZIuPiJhUlxgncKXNxfbuiw6TjIuOZrdzNvnEkVKqXzS0S5nrBNvForJbsYYvYasElQRtG1ig5EgUWoNKcv8nXku//7X0qfYxBPI8QHfmlCOQuSPRT8HhU8dJgaez9GN4EBhdixJ4d3HO3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olS6C+rJ8BotxfvPqoqhhCev/p3N71jcqfPVfxg7DTo=;
 b=Ost9HoopDBWucDTVsfaZ+TLttX4ieju2shelNOsoMuwNva+YOl8+jg5fkFI4rciZWtvzrAh5JwJTTyvgO6NivAD4Nf3JM2N1+axJWGaGxZjH8VvHL7aoGDtKqwfOCBfU5/UfVXPl84ypTukxfNDYWlOkQCY2g0c6FRB+Dwdkshnsuu4YraQWOaCqjtHpiRsKsVNJy5t2NoBR8GOv7xv4X9LJl8cvjKgLO2+CoQE6H76VACNtF7MB3d54llOjfWQZdx1VM10mDROFOjrcyUgN97ZsP65GNuRJTaenIOeOMM8KdTKfOUCrkJ2epYc3gQigjaXGECMd+9YfEDnl1oS/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olS6C+rJ8BotxfvPqoqhhCev/p3N71jcqfPVfxg7DTo=;
 b=dgoS8GlfyM2qTejTnDB5jtxMppiJ+AIHO1mNwBjebgLWlLCNp5Vb+vUB2+GjqLBOf8CK4ksFwNz0ail7hGncFLN9hAL9b6tmnkF2qKOW5uB86UiMaAglJZMH4ygypvwGrmFJuUvVlTfSfWgR5Olh50Be/7wB0XFW8ZgEN5RrMMs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
 by BN6PR1201MB0244.namprd12.prod.outlook.com (2603:10b6:405:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 13:39:29 +0000
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759]) by BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::8daf:74d4:cbe4:759%12]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 13:39:29 +0000
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Subject: ucsi and DRD controller interaction
Message-ID: <26823688-3b9c-5869-bcb6-4d6e5dcd77bc@amd.com>
Date:   Mon, 20 Apr 2020 19:09:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BM1PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::12) To BN6PR1201MB2467.namprd12.prod.outlook.com
 (2603:10b6:404:a7::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.102] (202.62.82.154) by BM1PR01CA0072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 13:39:28 +0000
X-Originating-IP: [202.62.82.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7e21ec7-8d3f-48f6-7730-08d7e530402e
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0244:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0244DEE41A3B2F3523ADE8BCA0D40@BN6PR1201MB0244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB2467.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(6666004)(31686004)(36756003)(186003)(6486002)(4326008)(86362001)(558084003)(8936002)(6916009)(16576012)(81156014)(8676002)(66556008)(66476007)(5660300002)(16526019)(478600001)(316002)(52116002)(2906002)(31696002)(26005)(55236004)(2616005)(956004)(66946007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAj1R1LZIBsXR1cpHcah0WuNhglKuAIfbbwtzW0IwY2Ywyy5v1CyVUyq7jv7JTL9MeWCYlJunUSOkb0jVVsSBb+mwbyeivxvMzQkrvNHHFs8N8r4geu0CXJUAYYnJ+/6/XNgh+UKdf15T7dyZM9EyzZDL2kLYW3j9KZgvIFrhwGY+h79uKpFr6v22MjL13XUfaHU4JAGStRzsWWSnYrNeTsfNMGU6aAXXxL2MFxNMfWTw6zNdtbuLBGlPtS+Xfbpbk+IQUDdMAsEKPQwd3tCUXZ9fdfRo3J9FkWSO7CgH/Ylr/eI1obobj8lzg1999RsSM9rlXN7joN5RB6asAK5Lz70OTRFJ6sQfdBlbbUR7dtsbpyZroAONTY92uF5cFNRq5SjUmFtx1aOfhejTJ4y3sTF25Ijc6K9n8mofJfViQUhU1abqAA402/sS/usGIwu
X-MS-Exchange-AntiSpam-MessageData: Ox4C/RGLRXDxZylYDq5dErQKq5fOir0P4LaLnAtMCIMh9OOfr33ZASflBmpRbBgaRp+24DMbJUfCHn3OnwKo6us/ulmZDkHbJgp9bJpwEkFYWaJ4NOyBFYKcRGRebgx4wdky7N+CgIMlqtKwIEtN5Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e21ec7-8d3f-48f6-7730-08d7e530402e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 13:39:29.7161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gb5Ex8ME9SyKXjvehOSbmAfanRF1fPmJWmu9tJm/kIuCecokRJKPLN4DDX7Dg6mU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0244
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Heikki ,

I need some pointer from you, so in a system where I have UCSI driver for DRD Controller, then how call stack will be?

I am unable to comprehend the flow from UCSI infrastructure to DRD controller code base.

 
Thanks

Nehal Shah

