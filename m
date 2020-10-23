Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71D6296BB4
	for <lists+linux-iio@lfdr.de>; Fri, 23 Oct 2020 11:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461056AbgJWJD7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Oct 2020 05:03:59 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:60768
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S460998AbgJWJD6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Oct 2020 05:03:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu1RjGbEPEwP88eOPKTRNoSeFrpT4e/Z83Y3ZBcCfCNNfhLqMtCJ3+PbOfrogouPVP8rIxy22hp7sOEZ2Wn0L2Y3AcirL2oBUDbI/n2HM6y6HkXyQrlznpzWDKgHmgVqSXTiz3RCU5hi6uZug8sF27odeM1YoZ7ZRBh3N60Z5wg6qTfTo/EZo48L7GCK1WxaEWPykDzEnS18quFpdvP9dBkLB7uiBE1rggMz0Ln3dCnkpdOtFoF12GtY24qSVglUWWsGflaGUNn35cR3Wd6R+Jedeazz1ReaNuCNiQixdoiNsDkzX5LIzmVgOL5MNHu0s63xIxTd3ZKJ+RdVqq5ouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjyQ9znOlii07HPz9JzRGKhjvO56Q9XH8U3pIET2ZUA=;
 b=D1c2qt94jeLRyOjpv0zwOmatxgdJwub3RQ0QkHiKChecLpHNHU+iOpa7Q/Nj+gqertuVuJekUUkRWfxlxsa9yCJt10QWw7/tTxQzRt69/vyvF00iRDFJd7GnUPn+IT1tCYrbHDz6fPgpc0sIgAu8qPvTSrpl0N1m09j018ms7nSHxyYoODqJb0FWEROwkZa/Hej1gKz9BrCBnP8K3zhgFIUtI6w5zaygnLydfj4t+c9nZwqEQxU+tOJ6efG3bYnJXjIpHzIYWAOJny8zdRTGKXgQlzLKI4R7KWS0h8RND+qT3GVgUA/CrCmqvh299TLXFpd+Nd2CmetJVueVeV8rXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjyQ9znOlii07HPz9JzRGKhjvO56Q9XH8U3pIET2ZUA=;
 b=YmKzkba63Hqvnvg8x79HKKXUPD+UsTh24fBqKQCKlFW0rA2wi8LsybZ9UR5HUrOoM85Ee2TXy7eY4xaJetwz5gwHQnHrJE4gJZdohokBHgR9oLNFEeaLpNZ0fNVGCSeHKeOMy0JxQKEioD0DaCt7Oq9Zvt7Y/niPlb02FPPB0Tg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8)
 by BYAPR12MB2902.namprd12.prod.outlook.com (2603:10b6:a03:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 23 Oct
 2020 09:03:56 +0000
Received: from BY5PR12MB4098.namprd12.prod.outlook.com
 ([fe80::e1a3:69b7:a02d:a74d]) by BY5PR12MB4098.namprd12.prod.outlook.com
 ([fe80::e1a3:69b7:a02d:a74d%5]) with mapi id 15.20.3477.029; Fri, 23 Oct 2020
 09:03:56 +0000
Subject: Re: [PATCH v8 0/4] SFH: Add Support for AMD Sensor Fusion Hub
To:     Jiri Kosina <jikos@kernel.org>,
        Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org, Shyam-sundar.S-k@amd.com
References: <20201009200138.1847317-1-Sandeep.Singh@amd.com>
 <nycvar.YFH.7.76.2010221205110.18859@cbobk.fhfr.pm>
From:   "Singh, Sandeep" <ssingh1@amd.com>
Message-ID: <13209fef-bdaf-92e4-371c-83da12c756e0@amd.com>
Date:   Fri, 23 Oct 2020 14:33:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <nycvar.YFH.7.76.2010221205110.18859@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BM1PR0101CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::31) To BY5PR12MB4098.namprd12.prod.outlook.com
 (2603:10b6:a03:205::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.223] (165.204.159.242) by BM1PR0101CA0069.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Fri, 23 Oct 2020 09:03:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe6189c4-4c39-4932-9fa3-08d877329237
X-MS-TrafficTypeDiagnostic: BYAPR12MB2902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29021F10608472CA8B5E6338E01A0@BYAPR12MB2902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /L8uOhVHUa5HGivOgkWEvrfWB+Fjf81jD+B02FtVVzpTD2KDSJIX7Pu9aaUAzSh17Ohju5IJWhWtCTlTcpgqMdKpM7SIaDqqSUivViFz4/a2miGhv+ztsQf898Gp5qIO/BEWu9IDWhaDqEUDbujI0ysl6zVEcO1Kp1GNAxXSclCeE+AK1xSK7JiWEbkjiSEzvZjbhECW74Iwe92XGWn6vFNoZVRpjxAmijuSN6UMpysfeMMCfbQI70JefOikyawag28hgZ/m19vv3+XGp/xt9u/vSj2SbkFaKnwVvNjJyF4oa5Ey7SL0/6F8IfoQLs93QUwj1RnYOgBzB3pjFfRWrd+o27fX9c9o9D47kmkHEzut4OKaNjhrvaGWzMA4Qil4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4098.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(110136005)(6486002)(16576012)(66946007)(316002)(53546011)(31686004)(26005)(2616005)(478600001)(956004)(4326008)(16526019)(8936002)(4744005)(31696002)(186003)(6636002)(7416002)(36756003)(8676002)(2906002)(66476007)(52116002)(66556008)(5660300002)(83380400001)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9orSOA9bIP61rX+IlCkY2RVn0K28mY00dMDx1d9iUIx4qkY9OAZF1PEGqX4J8meuryQ2+HqGaYi53ukFAlhXEUavbZcKMu4j0plZk619/aytSJPAroX+C6QlsWYpfTI5roC/eJ30z4J+ptVcenkOfBErcNRq2wvPeY/z3cu2ptPE8nwL2DyZgY0q/xPMO701EREspb3UM7VFXnSyXQ4g94u3DCMHwU0wNs41LFGbJ1SUUdPNStbbR7IL5YPHFjuawhSB+l7CSGHQFpcxJInR3AcbjyZVSKSHe/Iq69vbgnXSGpPnMi0XueNji4YUxIi+/15+Ut4CV/r+wLvScRn0YJq3XdaHNiZOTwVjC48ZhebIy29yiG4sA9O+MyQGtH10TeQyftLnlCxeqYh+xGdpF34HiUg4Q0NnGqgURoYykylUHuMJHQy1ob8G9CI88I5ZP3Zke0emr2pDIEaYVIrOKbBMxptOeL+2XEbmg2kKdGPH/aRLZejoGBCmiJ/NmMLuMvPSG9m1mljcnhfph1605cIjsUNF1R+n7qRYAyyBX5qWeN7RumhK3JUjUqK3+sJmo3uSNvDxJ1jAVzbdXnEMVvRiiF55qKmI+vuXwclnKc2QNowUdsW+6dL1DlCX5FPxFAbLZnYzJgjRtDc+6dYa7w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6189c4-4c39-4932-9fa3-08d877329237
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4098.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 09:03:55.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lf3btd+zkYh4s4z4kDiBtqxEy0JSLwudxnQ2P/yuwfKBWyAu85B5WLL4Lni5t1+C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2902
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/22/2020 3:35 PM, Jiri Kosina wrote:
> [snipped text]

> I have now applied the series to hid.git#for-5.11/amd-sfh-hid. Thanks for
> all the efforts in tidying this up,

Thank you Jiri and all the community folks for improving this series 
with your feedback. I have sent a  minor fix which was reported recently 
on top of

your branch hid.git#for-5.11/amd-sfh-hid. Can you please review and 
apply it?

>
> --
> Jiri Kosina
> SUSE Labs

Thanks

Sandeep

