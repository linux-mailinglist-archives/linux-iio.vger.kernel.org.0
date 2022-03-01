Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACCD4C854E
	for <lists+linux-iio@lfdr.de>; Tue,  1 Mar 2022 08:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiCAHgD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Mar 2022 02:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiCAHgC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2022 02:36:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212407E08A;
        Mon, 28 Feb 2022 23:35:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRMXTeyCtgWCRoAHCXdB0YtCPZCSJG6SzliW2Y9ZgHV7f130B60HJFswuR/akwB3cX3P5TS463R/IY9xFCmAYc8s4ZBumfVGE97iz1qZH1eZf1kyRUPpOPuJJHwDStMa2Wi+FzA2yOo1eaN+/mYIQ/cHSbJ/UUymbny5tMIo29Qkn3vZjPDKxPCIvasCVanTpfwD9X1kSH7IOpCg8J850vmp3U1W9Z76cRlUa4fU/0jhyJcnvglO2pL0ATZcPZ0yRwUPqFvwATpooIrvMQX8ed86Nnchbfg423PL+sQrtFqMaN69DwuXyL3q45TgOBWY9LX89i5ZbfGzed+uCfXXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctwdyr8iIRoRJgujIFn6rQaLx9Uur2dD5Qit6JaY6kQ=;
 b=FDmBepSW1UgJ3WhRmLi/U9ZeU0peR6Du+b/ImwKEVers1vB1aAERtd5+els2FFpsVgR38A012PRplub4Je5KNtTaH8OY/2LaLjOn7SI+VDHopfeyLLy3urss3QagD2tIr99g6WYhsMunPd+kMe76x5PNmGnDUGk8Xszv98FjclIrLR6gi869XwaC/B+Zr4xTxrapt+Ok47EtVSlM1YkTzSgs0YqMgRHKhM+Cdww59DuyLkZ3cf1fmmuFDYrt3lCq/Pdv8NpoamGZnq/IRz8ti+Z/WJYAdJPFx7IOETEECk/SsMmX2Th2NK1FXW/M2iYIrNcz5zp9nW5N3APhlouWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctwdyr8iIRoRJgujIFn6rQaLx9Uur2dD5Qit6JaY6kQ=;
 b=mukTmm2Vz7lR3Xu85H6HheMaEKjG8MYeRVOEHL+Vda7BR3h7ZjC+ZN0YE8gvIleeBztE1YF+PptJXqBZpxz38yUeVqBpU1qevLkFsAVbkMBmZMQzGAeKwlUxHZkwZWe6vA9xqzfpczA/7bw22mIsAmzARVOPRFUb2ghX1IpvUgY=
Received: from BN9PR03CA0569.namprd03.prod.outlook.com (2603:10b6:408:138::34)
 by PH0PR02MB7815.namprd02.prod.outlook.com (2603:10b6:510:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 07:35:20 +0000
Received: from BN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::92) by BN9PR03CA0569.outlook.office365.com
 (2603:10b6:408:138::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Tue, 1 Mar 2022 07:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT038.mail.protection.outlook.com (10.13.2.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 07:35:19 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 28 Feb 2022 23:35:18 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 28 Feb 2022 23:35:18 -0800
Envelope-to: jic23@kernel.org,
 robert.hancock@calian.com,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.254.241.50] (port=59556)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nOx1z-0003Ik-M9; Mon, 28 Feb 2022 23:34:47 -0800
Message-ID: <d07f4040-9479-c9bf-2505-8886613ac19d@xilinx.com>
Date:   Tue, 1 Mar 2022 08:34:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 0/4] Xilinx AMS fixes
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Robert Hancock <robert.hancock@calian.com>,
        "anand.ashok.dumbre@xilinx.com" <anand.ashok.dumbre@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220127173450.3684318-1-robert.hancock@calian.com>
 <20220130124605.6268bfc5@jic23-huawei>
 <9aeda9dd153f470ae630cff79c374e66ffbeade8.camel@calian.com>
 <20220226164552.7fed4f1d@jic23-huawei>
 <56c261b2-2bf0-16d1-8fdb-a264709cba09@xilinx.com>
 <20220228182626.12544642@jic23-huawei>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220228182626.12544642@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53607216-4d8c-4e85-e331-08d9fb5609a3
X-MS-TrafficTypeDiagnostic: PH0PR02MB7815:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB781512481103C73CF4F150A6C6029@PH0PR02MB7815.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rt1eO+COcxYrn8O+I+LAGzRDo4ZihOjqKH24x8j7did7UbOHkTPjJqhnVSxD5T9i0VcIPRD00U2RULaFGY18Ku4wFKcagLHPg7KL5Ksmye9b92rmAoEX3YanwOyWs2yHrLKd3A38lV6K/+Tg1Z8BYFNk/nYFav436jBLI5qpz0q0WdP8WSgoIo2YLbGj50AMmIwtrmEEFa0IMvJ4s5oApBT9AfEWWDcuOYnnfyC/gzB32igDaQIZuIWTW0z6eXqDo8M0DdkvGYuFCrszu7Qn3PE62jwFjD7NJxBfUhmX3S37G/bEQELHcBckBmlC3uQWCrdEpUjWTbbPpkcw+XEod2RrnS4UPsjhsI0bZJxu0IyX/v9IxJ8YiADep8wLUDN7wSr0n7OpiEUrWp21QUlktL3Yqh6Nj+0UJ6rq9LFntWuQdWagmK0MusMNXlhw93XVvB6kOoz8BUzq3pcFuXCck/1A8nb9yq8BcJd0prl+8+gdWBROEq32sivxEDifC6CRnRqz61Me02F5odB/5FNuOmsayXLtLKYSWrAL1I6ug7D/uqQHlNQ4WHCVsdgYBZ3xqYzUIYfOIP68F7htnVtH98kHavduLORvLqYFJCgy2iJpKDxEGc7xmuc6QfpanQOoX3Z/SMdZNNYTJQlk2liSKmvalzomUSoxfZDUKNw4kUDqEDITlmaggEUIo4JqOQTgB9+dDEN2gVY3XsDdGhXDHUHfRjz/3DlG6/wz4yusV18=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(31686004)(53546011)(44832011)(70206006)(54906003)(5660300002)(70586007)(508600001)(83380400001)(4326008)(8676002)(36756003)(31696002)(356005)(47076005)(40460700003)(2906002)(316002)(9786002)(110136005)(8936002)(26005)(186003)(336012)(7636003)(2616005)(426003)(82310400004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 07:35:19.5724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53607216-4d8c-4e85-e331-08d9fb5609a3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7815
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2/28/22 19:26, Jonathan Cameron wrote:
> On Mon, 28 Feb 2022 07:40:59 +0100
> Michal Simek <michal.simek@xilinx.com> wrote:
> 
>> On 2/26/22 17:45, Jonathan Cameron wrote:
>>> On Wed, 9 Feb 2022 19:49:27 +0000
>>> Robert Hancock <robert.hancock@calian.com> wrote:
>>>    
>>>> On Sun, 2022-01-30 at 12:46 +0000, Jonathan Cameron wrote:
>>>>> On Thu, 27 Jan 2022 11:34:46 -0600
>>>>> Robert Hancock <robert.hancock@calian.com> wrote:
>>>>>       
>>>>>> Various fixes for the Xilinx AMS driver.
>>>>>>
>>>>>> Changes since v1:
>>>>>> -drop addition to ZynqMP device tree, will be submitted elsewhere
>>>>>> -add patch to fix DT binding to add missing clock entry
>>>>>
>>>>> I'm fine with these but would like to leave them all on list a tiny
>>>>> bit longer so we can hopefully get some review, particularly on patches
>>>>> 1 and 4.
>>>>>
>>>>> Jonathan
>>>>
>>>> Hi all,
>>>>
>>>> I don't think I've gotten any feedback. Is anyone able to review/test?
>>>>   
>>> Michal,
>>>
>>> If you have a chance to take a quick look at this series that would
>>> be great.
>>
>> That series looks good to me. Please apply and feel free to add my
>>
>> Acked-by: Michal Simek <michal.simek@xilinx.com>
>>
> Applied to the fixes-togreg branch of iio.git.
> 
> I'm not certain I'll get a fixes pull request out in time to make this
> cycle so these might get dragged across to my togreg branch and
> added to a pull request for the merge window. Or, possibly Greg
> will take them for the merge window even if I do a separate pull given
> we are close to the end of the cycle.

that's fine.

Thanks,
Michal
