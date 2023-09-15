Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BE47A1686
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjIOGxb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Sep 2023 02:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjIOGxa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Sep 2023 02:53:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639D52738
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 23:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6nC2KkLhJebeuRF5tu7QJ5Aj4HNDFrsV059kvzcRZuHQhtJ9B1Zs0mO4MUQv47puPxvyH9L9QmFRfVxTBayvH/+p/N7p3xPhwDfgKX/M06maalvQYBRCJ7lRR8ohXa1Ezw5cr24EzTerGh7V1ej796WadimgmT0MaDKtdn3+OifUs3mg/cQW4lEMxUmmS21ppiiOm9sK8mhlCeMDtPAbzBBeqDm8cFCmgcGyyvh0pkfqgf4D5ssHKgeYN9GdvZVNiO6+zeg9Jv0La36RNWzahHbRGb32y4BICd8D2peSj43ViRJnVpAsDd8euM1ktg2bf1ZIRhEJa1nxkB7a6zqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nMqyv1Ro3wUEd1fx23WO9L1s51X3cwaRm9z7yXf6Ns=;
 b=bhhCm8IVlpe1A0DcmMyUYMSgmI25TI2CSCRPfHx4XYcBe1whYb6v13LKT6ek4vCn9lzKmsA3ksdnSnomGa2X1E0iTZ+lErgKPiqQM5rWdb2lN/fLRPyFzvSqQzpUboIAth1lO569DLw7ikWMXrIBpwMVzsSr9y1S42l3PDJBxlFjv1D6WseocD3WdrCGltD80kgel3ZPw7BiBfmW71fnNRZ7/gWwfoZu1RORr9tpwWWhGCHrtMt/gFuRzjbOdNS7Z+YqSwhqHrBvzve0+U5VWhKmHqCJZ+TOlwDFhNElcz9dXML9408nx0b94oSr+jhlYP+wPHs9cZa+bM6YbCVoOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=calian.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nMqyv1Ro3wUEd1fx23WO9L1s51X3cwaRm9z7yXf6Ns=;
 b=Z1i7ESjuDDK7bqjIVzWR7WtpqQIDLV0WEYNTjGuC0vXciSapYl3/5MlGO+i3BXU4Y/hOPW0iM2FKXuRkqez0iMBLQYGxfzBoXB6SnYMj7k5GKKlvOymK39eb/cxuLFIqBdl0HOyYyajQdc9bFLU9KGfMBi47ggWOQNSp+k+LCMo=
Received: from CH0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:610:11a::35)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 15 Sep
 2023 06:52:57 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::23) by CH0PR03CA0344.outlook.office365.com
 (2603:10b6:610:11a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 06:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 06:52:56 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 01:52:53 -0500
Message-ID: <bae646e9-7977-4de3-927b-ffcb7a94ac48@amd.com>
Date:   Fri, 15 Sep 2023 08:52:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Xilinx XADC fixes
Content-Language: en-US
To:     Robert Hancock <robert.hancock@calian.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Conall O'Griofa <conall.ogriofa@amd.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230915001019.2862964-1-robert.hancock@calian.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230915001019.2862964-1-robert.hancock@calian.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: b127fba3-28e6-4a27-49e1-08dbb5b86465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V637tRtviNJ9zBJUXo7/YNZFH4vMdynm9jZ8zTTRjAIjiD/Dv6c4DaWu/nwTxTj5FIuYeouO0TRv7I3f6of2ZhJlH/MNOeUU1hhs7g7YYM0H/7e4Y9oW73sXhVWHJ5py3c6jOR53oAdjxJmHYwLUMJDpq3ZIVFUXPALoUhtEx8CoYie/UYlPMwPI/wOfjZbwsz21j/nBHueAjSySOF5+M9GK3w9IHzokNHFeOfVou/fteLd1QHf2Y5xGRxepBH0rzI16ldXOnYK/Bn5MKcxMaOucV/84craHu7wGPwoVjVXYsnocYc4i73iLUE5bgEX9dqUhKLIGcxqSmVd6O9BiA/3X5iN/4yh83lCdIYXbW7B4nvFR3fZQt3P0lm40gl82oIg34YoJY9k9f36wik0kspDlSNJvEKvTVFP09oSKCSKUPpLM/6c4O7hPfRUykPqW+GWbEXKbUKw6MBhfAowe2b8NMNl7jYB3sihRJ15vUS2zaWYWx/WNxRutOQAZIKGNJddEXZ4Ls8yjcFQsZ3y4pZZn3oaPdzC0oVbQLVG1c8Z0WXF8LnDE0mvLlWAZgZZBVwKg4bqmqMe8zZsQwVvXPhHs7scqLEZta1cvP7Q7ZeH87RF5XicjJiQ8gs0bUoi9aLhEOHO0ntR1MWl1gOg0j0hNKTekskVpwL3KKhA2Y+VdvrtAxjmkLsg1y0vK/gO0hG4HVOVybhbe8bLnvBaMzYoUajciJaFKUqH/Y4L8uPVDtAjZ73znKDIcqE7qGaOMBB9L8ZHQb6WbDWfJieKChSkhlnswTd+KeZK6oDDRSn08CC/WiuSIxXynC6UBsDFA
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(1800799009)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(31686004)(4744005)(2906002)(4326008)(8676002)(8936002)(44832011)(5660300002)(41300700001)(54906003)(6636002)(16576012)(316002)(70206006)(70586007)(110136005)(40460700003)(478600001)(6666004)(2616005)(47076005)(426003)(16526019)(83380400001)(81166007)(336012)(26005)(36756003)(36860700001)(40480700001)(82740400003)(53546011)(356005)(31696002)(86362001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:52:56.5245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b127fba3-28e6-4a27-49e1-08dbb5b86465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+Conall

On 9/15/23 02:10, Robert Hancock wrote:
> Fixes for a couple of issues in the Xilinx XADC driver: one where
> preconfigured temperature/voltage thresholds were being clobbered and
> potentially breaking overtemperature shutdown, and another for inaccurate
> temperature readings on UltraScale family devices.
> 
> Changed since v2: Updated to also remove disabling XADC alarm bits.
> 
> Robert Hancock (2):
>    iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature
>      thresholds
>    iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale
> 
>   drivers/iio/adc/xilinx-xadc-core.c | 39 +++++++++++-------------------
>   drivers/iio/adc/xilinx-xadc.h      |  2 ++
>   2 files changed, 16 insertions(+), 25 deletions(-)
> 

Conall: Please test and review.

Thanks,
Michal
