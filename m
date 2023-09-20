Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13957A882C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Sep 2023 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjITPYB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Sep 2023 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjITPX7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Sep 2023 11:23:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BA8A3;
        Wed, 20 Sep 2023 08:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2VQeVP8Z2+BonZsuln/FjD/YRc7OLmEs439zdkYtbno+u3vBQoSSegfaII8bztdNoD4vfwojkMcR5Lld+qVXrIEE6D5096fRtQDkYcd7C8Wl3AWet2RJxFznG6hdN7eIRG+C8XNwCTULKSBTdntcxa/c7hRWeNt38/mToR71488a/OadDSw40ghnIUrewFotA6YiGXxu6Hkw0z6NTM28yt2M16u6nvbHuvhovzFTM/Qw39Jot/J7Ewv11j+x22oq0cp46Rqx4WzpdZAZiUCCo2ADpgsYhKsaRnOWOm2eeR5Z9zuajdtpndgyCZLrkoVPA9vmwEWbmSzSUvi3cL/mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGKc9pW8dbBAAk6Rp3b1nkUdVIjrth3HTrvTiVgfOf4=;
 b=hGQO51pGAwSZPp9+6ab1uH1l/0xW3iGwzxhA9UIjPWlrsWJuxg7DAzuEL5GRfhg/W3K4fC+2HSqvSwpu2/V5ttdM+637gIpz5GPTGmqlCDjTP4rNBiTDucFU6sHW9Gj2p851ctNRf0hPXe4DfpnxEFwqg5OveyK0hluIyD1w6Ma7B0GApdgmkgBuC6nKWRuAAiExhcd/gw3E5YrI/10aex94XqzWzUdgWajyEkbiutIKin5YDdWQbrTc4BwtAMICtXQmmfsgN7Lh5ERDpnOaPlmp3YmGBoz4YASpOw8e2QbOICCKtKuzxjKsuHdmFtr8FCXyHU1+bMgX5iyG2IaXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGKc9pW8dbBAAk6Rp3b1nkUdVIjrth3HTrvTiVgfOf4=;
 b=G1BWqT0giWdYswLhO3rwrnaT8UsLATYnNYYBz98+UeDwJEThBmIR57YTGMU5uWr2GVfSaCeevXNucrL2FWhCaj43AR0FYQLLy8kITGyXJ4ZefoT87hGhvSzz+i280/O1VRYlhLI5WZ0EPq28Fwifhj5HRWOHPXd9+FnnZS88VhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 15:23:47 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4bf4:b77b:2985:1344]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::4bf4:b77b:2985:1344%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 15:23:47 +0000
Message-ID: <520df871-a6d1-0db3-fba1-cffd35d9cc81@amd.com>
Date:   Wed, 20 Sep 2023 20:53:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/9] Support light color temperature and chromaticity
To:     Jiri Kosina <jikos@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     benjamin.tissoires@redhat.com, jic23@kernel.org, lars@metafoo.de,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
 <nycvar.YFH.7.76.2309201612350.14216@cbobk.fhfr.pm>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <nycvar.YFH.7.76.2309201612350.14216@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ae3530-2203-47b7-3e9c-08dbb9ed9575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fk0cRiiAZZf4bSVvLdvT73/mYNKwHev0YY+LppWtJwLVO9j1n2EYZEPkJO18yCnKu9DhQajng0OdivQjRina6LysPnSoScNNYwHOtV6VsleeACjeMViKhrp5dXKjBWTPX2OadMhlBjMfLXiHHY0WdaRa165GGcKpzMpLWBiBqYY5ZU49UL+xlFuJ+65B0f6OoYjx7vJA2GgDO6qnGngRHzm1bGi+6OEKuZUjdLzMQiZFNjYL0PvLv4Ag/NDOY9OlqK89NieCx+Gc+jEdoodm3vkNsVM57U5FfJXbEo44K4TlDyeTnvYllaTor9BKaCEXhJllObWsX73+ohijc5/PaEYj2CcLT+3vJZC42gCuN1h4dd5qEdopVaUn0MyP3GMCE1XLisv3Kv5c7giaasPLp+qF5QdMMOYGPys3kmXNHTojLyAiYhK1AIsjxHBHONEIWKwZ0kBk4HGAzeR+Jb7JM/toIdCzjJZB+2dxb9SsfWBK+ESxD4fmNGaqe59tJxAUXnW+DdsRnGSIVh1pcn784JvVafmTtBKnilZ/leKw7+wOjGUPyVDFdALbX36sMB6kI1qq26IH9ey5tzn/vte7uSIUt5kCvjwqf31fcDGK01DPsum7lEogXZ+7eaURKVa4W2/0MFd9booKbGrweZebw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(186009)(1800799009)(451199024)(26005)(8936002)(2616005)(8676002)(4326008)(83380400001)(2906002)(36756003)(31696002)(5660300002)(6506007)(53546011)(6486002)(31686004)(6666004)(6636002)(478600001)(6512007)(110136005)(41300700001)(66476007)(66556008)(66946007)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0txZS9VUlBEajZ0Zk51ckZ5ampORDNkUHQ1cmVPVzg3OTg5dFlPODlSSndl?=
 =?utf-8?B?aXN5UjJpMXEwN3FjTlhvNEhzdjdUaFpJRy9tWGRXaGNqVG9kdVhCVllxMFoy?=
 =?utf-8?B?L0NEYlRwQ2ZlYXJhZE43YzJMZ283aHV3c3RTdFJYLzVjRGM0Q3AxZlJDd0Fk?=
 =?utf-8?B?UGNsT0NEV05YdStjYmZwd2VHbHF2RlFqVGxnbkJJVHhnb1JMMnI2aEY3czA0?=
 =?utf-8?B?YlBmVjc4TTlnQmsxL0ljSVMwMXdRNG5UT3VTTUs0NVlXMHlQcjFkOEZ3WkdH?=
 =?utf-8?B?N1NPVG11M3NlOFRyYURscW53TEJFR2o3SXBYeFVQZUIvVFZoc2grNHYxN1hh?=
 =?utf-8?B?Zlo0NVlBcHZmeEpsMy8zMFpOamovYzBDaE8rT0hWK2xNS2xYdmJWcFF4clFM?=
 =?utf-8?B?alpVY3UvZ1E4SVNtdms5bE85c3lCMVllNWhrMXIxVzQvM0ttVzlnanpseGk3?=
 =?utf-8?B?YnU4WGVvVlQwVEFySVorZHRQTzZQRlhjcTdleTJreU9OV1E3QmhjVVZGSkVa?=
 =?utf-8?B?eGo4cXZDSlE3ZFhpVjZKYUk4eXZsSC9jaE9nWjFjY1BOSEZSbzkrSEZ0RHRl?=
 =?utf-8?B?bFBSMUNkZHpOZndycHlGRTJIWTlIdUdTK2E3TTg2Rm5GdGhqU09TS3dJU2tE?=
 =?utf-8?B?b2ZMVUVRYVlZUDVzbGhjTDBsbkd4cmdBZnkrRlU5OWFGbTNEdlNEcVJYaVBZ?=
 =?utf-8?B?YjVSQnhKYkVqRXJwUHR4b25ZQ2V4SWJOMzJoSjNqOUFtOGYzNjZEZlc4amVr?=
 =?utf-8?B?bDJTc2UyNHlML0g5TGZvdXNZdTdjOWNJaWoyMGJLYlIvVDJKeW1hRzFkam1M?=
 =?utf-8?B?dno4bUFEUEMvVjB2dEVsN2tob1p3d2lUZDJoa1Q1L1ZIM0Fja21oa2tTQ1k5?=
 =?utf-8?B?bDVacTFZV3hmbEt4Nk80dTBFL2NhcUZJQndSWFBuNlBhTHh4eEpaTVhoYmpq?=
 =?utf-8?B?Tm1KdWx0NWJDTFpFckJrbXM4ekorbG9zWmRRV3lvVENWaVEyMisweS9YS1Jw?=
 =?utf-8?B?QTFtSFdYL1d6azNnUUpPL1FCR3hIUjlFTUJGUE1OcTZjOXNEQzdCVGNldGxC?=
 =?utf-8?B?b2pTeWM0NHMzU2ErcFlPSmdKWEFqVFlkQTRTb2dHTWRYZ0krdjVYTVFBV3J2?=
 =?utf-8?B?Sys3WUxvSjlzYmYzSG5rYWpyWlJtTzBKME42Z3ZveldmSldpNzBEdU5oN0gz?=
 =?utf-8?B?VHQ5MHlQeUtqMk9VNCtuVkR5SUtibjlvcnFIck9GY2hxOE9waXVUMURrNm92?=
 =?utf-8?B?Um5tRUthZEo2cTlVenM3aFVnQmJTWkpoZmZaY1E5bzB6ZHMvVkVObGQ0K1Vw?=
 =?utf-8?B?Z2dheFVxSnFMNnI5eThlRGRkTityWmJhQXRZL1FxdnB1dEVSMkRJcTBTOENq?=
 =?utf-8?B?cTlKN0hIZ3ZaTlhnN3lYbWFHK05qN3Z0T2ttVDBMcUZtQjJYR1Q1cHQ2d2Zz?=
 =?utf-8?B?a2xGdVVqbXRialhvUGhnLzBpNUQzeHB5eHA2MmwvSnI5dk44bi9qNE1Gbm02?=
 =?utf-8?B?MWUzVGgwSHYzaCtRTFhzUWkyUUh2QkluS0FjdFdEVnNNcDhDM3Jobm9ORVh0?=
 =?utf-8?B?Y205R2tNSjVyNWJXZUdGMm4ya202amxRcHVBNlpsV2JRT3MvWVVGZkROWldp?=
 =?utf-8?B?RW5YRnRBUDRpbUYyaHdyUFpKNlNoVWo5OFFyQUxhdWV6cDEwMVE3WG9BNHhB?=
 =?utf-8?B?cHl3OGZFdkZNNWh1UU5TTWNIcGlLTkpxS1MzSkRoM3Q2ZGhycDRXRDVVcXY0?=
 =?utf-8?B?TXl5bkRHMTJ4UnI5eUpRRGtMVHY2T25UazJSOEUwbHcxRE8vWkhzdHVyNXEx?=
 =?utf-8?B?NWkvMFhhSkw5RmlodUFkNHNwbWFSQnZXQVByWnl0RVZXendhRnFhb1ZhRitM?=
 =?utf-8?B?QXFlajMzM09JYVkydlpZSTQrb3NZZHhRQnpWQytGaXlDRXVML253TTRSTHBv?=
 =?utf-8?B?MnBRMjJ5NmZsYTBNeVN1YnFnTDlsdURDaUpFU0FWMSs2RWErSC91VlorTnZv?=
 =?utf-8?B?RC9RMU9RbzVGRDNPdWxtS1ZCNzlVT0J0ZHVId1dZc0JaTmhLYm1GTDBDYkxV?=
 =?utf-8?B?V0p3QkxDT0srTVM2OEgrcDVFSHE2SzlzbWQ3ZEFYS3djeWhhYnh5RUZRZU4x?=
 =?utf-8?Q?qKXSadlCVLB/E+Ajj8cz7HbhA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ae3530-2203-47b7-3e9c-08dbb9ed9575
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 15:23:47.8131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xc2iJ2AUO8nXw3IBwBACMK06VYaefYIQWsrdPxRn8KBbGtraVB+Jq08m6Tw0UL2EvFVv2QVYudq5fklnIlOOKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 9/20/2023 7:43 PM, Jiri Kosina wrote:
> On Tue, 19 Sep 2023, Basavaraj Natikar wrote:
>
>> This series adds support for light color temperature and chromaticity.
>>
>> v1->v2:
>> *Rename the series.
>> *Rename als_illum to als channel as it supports other channels.
>> *Update patch description to include same reading for the two existing
>>  channels to use channel index to support more hub attributes.
>> *Keep line length under 80chars in hid-sensor-als.
>> *Add new channel type IIO_COLORTEMP.
>> *Update patch description and its subject to add channel type for 
>>  chromaticity. 
>>
>> Basavaraj Natikar (9):
>>   iio: hid-sensor-als: Use channel index to support more hub attributes
>>   iio: Add channel type light color temperature
>>   iio: hid-sensor-als: Add light color temperature support
>>   HID: amd_sfh: Add support for light color temperature
>>   HID: amd_sfh: Add support for SFH1.1 light color temperature
>>   iio: Add channel type for chromaticity
>>   iio: hid-sensor-als: Add light chromaticity support
>>   HID: amd_sfh: Add light chromaticity support
>>   HID: amd_sfh: Add light chromaticity for SFH1.1
>>
>>  Documentation/ABI/testing/sysfs-bus-iio       |  15 ++
>>  .../hid_descriptor/amd_sfh_hid_desc.c         |   7 +
>>  .../hid_descriptor/amd_sfh_hid_desc.h         |   3 +
>>  .../hid_descriptor/amd_sfh_hid_report_desc.h  |  21 +++
>>  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c |   9 ++
>>  .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  15 ++
>>  drivers/iio/industrialio-core.c               |   2 +
>>  drivers/iio/light/hid-sensor-als.c            | 130 +++++++++++++++---
>>  include/linux/hid-sensor-ids.h                |   4 +
>>  include/uapi/linux/iio/types.h                |   2 +
>>  tools/iio/iio_event_monitor.c                 |   3 +
>>  11 files changed, 195 insertions(+), 16 deletions(-)
> I believe this should go through Jonathan's tree as a whole, right?

Yes, this should go through Jonathan's tree as a whole.
If you don't have concerns, can you please ack HID amd_sfh changes?

Thanks,
--
Basavaraj

