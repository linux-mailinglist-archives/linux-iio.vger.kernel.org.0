Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728354C633F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Feb 2022 07:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiB1Glp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Feb 2022 01:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiB1Glp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Feb 2022 01:41:45 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5902866FA6;
        Sun, 27 Feb 2022 22:41:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLmwNOAfTXUoshb3EgqdWDY1HnJXT5GyZzK2yEvTV3cwoHY0LKDnHmqOZ19Sf97ZA6BpqJYQ95pnuEBbnJkfAFZyuHMeNk8wCovCeolkOXRIa9c8KJaMEswnkwjLFW8f7Yeqyo4xFGRLMwt/swMiqdqCX/FxovMKuAM6heOeSVAeDLaUyz4yu2FQ4gEx8YLs0bmSvbHl6K/P0v89Y1ciRdf+wxXseGCribH/1cmAh5q0R6JoXQBcXCtzHrai1Dwh2gZ/e1zD+60sOZB1r2i1UafwmWoXC4NfuJb2lzpokjVxL5ncRI2XfeJNP9IicTR9Snp+rTppz7rrPrfWEUYCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLJbZk1eva20oGfOXw+dWib+ofYKTFuDHm2NDjja3SM=;
 b=g9jgK1QrMYIKatmaG/xYp8kMV8GHb9gSM3deSsz5qimrMvMlsOrufZ5JiLU+OrIeq0SbLEnbPNY7rcBiJEvbepSVwGAzbNgOmbJGEo10DjnyCIFr/iKLnpDF6Cq+tgBPXRnecSeHsHOoD5fwcxy/U27hdpX9rxr2TWBD4t45n8+xVEMnWgWsnN3nmFoMMo7CTVp27vHAnvSkIT1ePxZ1RUvbrJRJMNhwVQoqUhM+C0XZA1jnzGYaYPjJzl4Ctf16Kpuk9qP8gdRh1bKK90oSr3dgO1P1Bn6VUsuIl3Pe7OFTqUEfBWLatSerAYF9sm14XBJZu9CeBV4ox8N62Yl9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLJbZk1eva20oGfOXw+dWib+ofYKTFuDHm2NDjja3SM=;
 b=KOs6SCvrP7ztfDuiy8y3mFHUxAI9ingwA7aeKWDw2dh76chpREuBEirZCilTEsRzfloWq6WsOXc4sqOFgH42DcsPPBNliapW+eNnHFRZSol1o3oboCMmts71YC3enU2hNLHEsWnQrkcjbm632+28d9HVH14t8xb9NJRl8e7B+P8=
Received: from BN0PR04CA0099.namprd04.prod.outlook.com (2603:10b6:408:ec::14)
 by SN4PR0201MB8742.namprd02.prod.outlook.com (2603:10b6:806:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 06:41:05 +0000
Received: from BN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::bb) by BN0PR04CA0099.outlook.office365.com
 (2603:10b6:408:ec::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 06:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT051.mail.protection.outlook.com (10.13.2.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 06:41:05 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 27 Feb 2022 22:41:02 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 27 Feb 2022 22:41:02 -0800
Envelope-to: jic23@kernel.org,
 robert.hancock@calian.com,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.254.241.50] (port=34028)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nOZiQ-000C7i-Gd; Sun, 27 Feb 2022 22:41:02 -0800
Message-ID: <56c261b2-2bf0-16d1-8fdb-a264709cba09@xilinx.com>
Date:   Mon, 28 Feb 2022 07:40:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 0/4] Xilinx AMS fixes
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>
CC:     "anand.ashok.dumbre@xilinx.com" <anand.ashok.dumbre@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220127173450.3684318-1-robert.hancock@calian.com>
 <20220130124605.6268bfc5@jic23-huawei>
 <9aeda9dd153f470ae630cff79c374e66ffbeade8.camel@calian.com>
 <20220226164552.7fed4f1d@jic23-huawei>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220226164552.7fed4f1d@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59bad0e0-03f5-4a7b-cd24-08d9fa854b75
X-MS-TrafficTypeDiagnostic: SN4PR0201MB8742:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB87427A01379EFA44AFB63DEDC6019@SN4PR0201MB8742.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dudUsvjjfZKG5GchcUrEN2wDdoKDwBNAKUTD7BKXdV/vF//OMZ+jw8C/4TF1u9sMasdA5wKn0gqju07j81eXl0Lqn7zq8NbEQz7SThBYNDhGAVckBDdIiY5KNvfACnT3kYbLAvI2EK8gsu7JB0jPaPslmtiTjmweWcz/SrDA72ev5I8LRl51UaSBwGM+GNHyZUnoycQSOaNJUHMb/E/EF7FEeg2bsanTcpDHUznTMMMdbD3UICCwNinPf7eYKtEkp363Qx4YpSr0c5M4fc8nRoYoktPJIfstHCNWqc/vXK1q65I3PWLgifq1heWWwv+34V4gvA8nDFheE8ncoaGy5o+gMi6/bBMBkrROaW537CI3JZEI0if5gpLwH9vm5yJBx+IbpmYiIHT2lGUdUgtFPYYHMO/uvrKVlmVhMcMmYb5TESH/7iOd97JzUJKPh5s1Wok+WeMFszjb7netWtc4DqnkpdNVskRXN/seaWn5RahhdqyNVDhra3Yld7vEVttvk+neNyiw1VYPmz2XbQG+tpzfKN3BpCnFe0nffRVwufhw8IVPDn+fTZFDWcgus5tA3dxY6T8U1FJpD+7CYz7GFDQUGdiXvjgPD8ICKDRhbg7uatQeInRB/KsTs/zbEx02FAl0EnNuQkAqGvF4L89+xEZuHF1alju4A+gm78Efn8cl29ToWGwJT8M979ZDqrfAr8sMaXByxGnEUK5x0d29rA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(44832011)(31686004)(2906002)(356005)(7636003)(36860700001)(82310400004)(426003)(336012)(4326008)(8676002)(36756003)(186003)(53546011)(26005)(2616005)(70586007)(70206006)(6666004)(9786002)(4744005)(8936002)(31696002)(47076005)(54906003)(83380400001)(316002)(508600001)(110136005)(5660300002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 06:41:05.1991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bad0e0-03f5-4a7b-cd24-08d9fa854b75
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8742
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2/26/22 17:45, Jonathan Cameron wrote:
> On Wed, 9 Feb 2022 19:49:27 +0000
> Robert Hancock <robert.hancock@calian.com> wrote:
> 
>> On Sun, 2022-01-30 at 12:46 +0000, Jonathan Cameron wrote:
>>> On Thu, 27 Jan 2022 11:34:46 -0600
>>> Robert Hancock <robert.hancock@calian.com> wrote:
>>>    
>>>> Various fixes for the Xilinx AMS driver.
>>>>
>>>> Changes since v1:
>>>> -drop addition to ZynqMP device tree, will be submitted elsewhere
>>>> -add patch to fix DT binding to add missing clock entry
>>>
>>> I'm fine with these but would like to leave them all on list a tiny
>>> bit longer so we can hopefully get some review, particularly on patches
>>> 1 and 4.
>>>
>>> Jonathan
>>
>> Hi all,
>>
>> I don't think I've gotten any feedback. Is anyone able to review/test?
>>
> Michal,
> 
> If you have a chance to take a quick look at this series that would
> be great.

That series looks good to me. Please apply and feel free to add my

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
