Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C561F2FE6F3
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 11:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbhAUKAn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 05:00:43 -0500
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:1504
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729040AbhAUKA0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Jan 2021 05:00:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmuD460o8xYAX6XvdYRgAoeCUe+kGKsbKMK25SLxbPX5iBqdcDfeeHb9GWWHJzfvMXz3B+X9+ysdUw4owJceQKbxPabGsWz3w0cdHh0n4eLIqkqW708iyC7x3gYPptD5kPERLxCvfPnEhm/ap0ZawXsiGHiC/C6gObOfLSRswcDOV5P5BVF0URvWo8QuBsQFrXerQCg794eNtIjDlOhagfn2JPL6oA6BJQawNWc3uw2ChAbaGi7MZvV6AL6totH4s/YVUx14ngt6yW0mND38Vi8Nvzvlz6vhbT9ZWLgBLQlR00khU8Ku6qNKbeSQTvnAzZ8mODrzT+Erztn3aGupVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2ZjwhQx52T5+4NaCn+NHr92htOVOjBW5Y7LSzT3Yt0=;
 b=KRdtXwhVyO1DXbYoU4KEFzeF5e07HGhmJo1VDHFq6D6RfBZJ7fRZw67wcZXsCWrzXR16PcRkoBkyq5AMKGKCJDIfV+wRmIIDPhd8YXjVCPo3VYbJSEvoiv8bTAnS3fauK69ATsmqaKsG+IiMLTDKMeMk7NVt2AdakjNxLy2T38W1ivJZNh4Kpc+cHy90y1y2MhM0YYiHTnVu9T+eJTGJS2XlbiOBgppE+aHbYSzMwk9hQeqPgq1ulwmKYdehtq4wbbVKXZuDO28tDekOLt3+cyAkRb7f3bmj7LCYvw5uu0+dDQ2oDGj+8JufQf1lEscO6uU65fI7zrU6oY6bH44T6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2ZjwhQx52T5+4NaCn+NHr92htOVOjBW5Y7LSzT3Yt0=;
 b=GCqvF+tB1yq36o/dM8PJl68gGLvydwKaQqYUMGGoTrPxzG2iLYWzDFpy0h4oTjB3u2yjSOFzjHiIJLGsZyt1Fa6DoAibFMQzNJZDOkpiY3ExL1gsTZqS2F9YqqaQ03hwqKH2Aub9ithM+roaYlh6iijCODGO9psQZoJMYkzsRfg=
Received: from SA9PR13CA0167.namprd13.prod.outlook.com (2603:10b6:806:28::22)
 by CH2PR02MB6885.namprd02.prod.outlook.com (2603:10b6:610:89::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 09:59:34 +0000
Received: from SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:28:cafe::78) by SA9PR13CA0167.outlook.office365.com
 (2603:10b6:806:28::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.7 via Frontend
 Transport; Thu, 21 Jan 2021 09:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT044.mail.protection.outlook.com (10.152.72.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 09:59:33 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 21 Jan 2021 01:59:33 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 21 Jan 2021 01:59:33 -0800
Envelope-to: michal.simek@xilinx.com,
 manish.narani@xilinx.com,
 linux-iio@vger.kernel.org,
 pthomas8589@gmail.com
Received: from [172.30.17.109] (port=44900)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l2WkX-0000pN-0e; Thu, 21 Jan 2021 01:59:33 -0800
Subject: Re: xilinx ams
To:     Paul Thomas <pthomas8589@gmail.com>, <linux-iio@vger.kernel.org>,
        "Manish Narani" <manish.narani@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <CAD56B7equnodXB4jKnA+fcU9XqdWXiO+SnbmfPw2vDKNqUFzdw@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <6c742a18-101b-c29a-7cfc-009dcba578cd@xilinx.com>
Date:   Thu, 21 Jan 2021 10:59:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAD56B7equnodXB4jKnA+fcU9XqdWXiO+SnbmfPw2vDKNqUFzdw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80f5f00b-179e-4052-2ba2-08d8bdf34113
X-MS-TrafficTypeDiagnostic: CH2PR02MB6885:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6885CBC7B4029CF43E1EB860C6A10@CH2PR02MB6885.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4X5OM7vJ5fANMiQ7V+d9scl+n99d+NdNw/lf0Qmqx5VGTnTcBOojIMbbyWj792/Vml7rLxO3Y3YMXSYcyAXp9Bg8VlHZaHPwrYUtIxZ9fF7/4pwUmbxmgmLfFuKgLOc2RHhtSNtthIzxQJTFHPnt8FBn8Pejo0EfGrI7bx5+rplhDGosPxCodrQeO+Eqkc82aL2YHQCuXk1Op8UPzBIeONmQDZzKwtcFkwkpAOCydbvNfndUpXyzC06kZcbcU6uXcP9KQXfbkaTH8Xh2K8OWrQwmACOPQU28jl0/4kfryD8k/5dGUIKFL7Xp72Ue7CMYtebOJU7AYtcEDYsjhWypuzWZ5tt9L/9g+VyNiOZ7tC9MKv/P7KBiKVpxjhVzV11oSBCYr2guv4g8tFcn1PlBV++X2WcypeAQXsdKtSqrHQApY5JMfdQ7V5GJAYfSGoCahVliO2CUmf6ToNKTaQfnOo7OwPb2O2A4pOVu0hJfOWEeyBKf5CKjBcMxedb4BnNPJFWwWAevhwvtRp+l8Jmp1Aj4jc3Fis7rX9YC6GsgfFE/xTbU8JeH/kDkG4mum1QipAaik/+cPQ6oUWMMwyZwocq+wyJFYSAROBL80ts/kbU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(478600001)(8676002)(5660300002)(44832011)(70206006)(356005)(3480700007)(7636003)(31696002)(26005)(2906002)(31686004)(7116003)(2616005)(70586007)(966005)(53546011)(8936002)(36756003)(82310400003)(4744005)(316002)(47076005)(336012)(110136005)(82740400003)(426003)(186003)(9786002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 09:59:33.8593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f5f00b-179e-4052-2ba2-08d8bdf34113
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6885
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Manish

On 1/18/21 6:56 PM, Paul Thomas wrote:
> Hi All,
> 
> We're still using v4 of the xilinx ams driver patch set (as of kernel 5.10.4):
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/1555943870-15353-1-git-send-email-manish.narani@xilinx.com/
> 
> And it's still working for us. We did have a fix to remove usage of
> iio_priv_to_dev(), (I can send this if anyone is interested) but other
> than that it's been fine.
> 
> I'm just going through the commit set we carry to see if I can nudge
> anything along.
> 
> -Paul
> 

Can you please comment this?

Thanks,
Michal
