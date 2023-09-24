Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0E7AC9F4
	for <lists+linux-iio@lfdr.de>; Sun, 24 Sep 2023 16:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjIXOUa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Sep 2023 10:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIXOU3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Sep 2023 10:20:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA107D3;
        Sun, 24 Sep 2023 07:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bap3ph6qORQUwhLBxNA/2l7IxeophjR2AQKqY+/LiEQyvJCk/9YYdviPA946yW1ccvqyTxDsjzVFQIcUcc8f0iYAxYTfmzkj2ZaxYZ0Fzlkm5jAxGuRXe5rQaqkC/26AaV9LJTwEnRyWHvHxTziZemwpSgqhPTHnusgQtQ2bM1MRwwcduyUVPKHhcTZabxHWq6lAN2zsLn4izdzfCoTwg5dDmiPaNh1dq8cP609QwtDBCfqPvXZSIiLtoQgPZLJvz/qxMfXUA5z6mpsk43Pv+pXqGb6DZGmCEWwNnJ7fAOQkwZ1ayQXiqNvYYVk/Jt6nunk1fqA3wYpaH7t+ET4ZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRLO3OYOO9OmGUc5L+OPihhFNd4vh+478t1bQlKOEoo=;
 b=FtCbhkd0EupVn4HeBLwonh76stD6W6vpVY4BKPI8kA0DfcACYWNLOm1y1UNpbldChYMCwivyhdt8wRxFGYLaB3GvDXOIablRXFUjc9xWISsnDjj3PbolDtdo5JaQqf7EgrHbtpgsTIFQbE9yFVIq6lSNYrrH/rjD+tbwILiynIIiT9D1zJveW9MisOCyWDrn8/zp9exygvmilQ/+qtp7HgOPcpYpTAT2O43+w+7CLqn9PwY7TB9WrCPuiK005jQM2oLS6/mvhhfDAMoY5wQcbCmvWKYwzBos0SubvJ+6pWe3/bq3F2sogWFJ52vYqwZsR9Mx3lTneZcj/T+Yyku75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRLO3OYOO9OmGUc5L+OPihhFNd4vh+478t1bQlKOEoo=;
 b=SNRlsEGEKPxVpVBc1+0JJVj5AefVS8HjbS9ianhE031i6VCMAiP63uvd55oIknYHpCN8V9Hu/eQeQcs96TCRYUovqEsP7Yv3nPHnS4fIdi+Kmn8jckfNA4JZS+0VmFNjeHuTI9n8F5Dn1KpB0sVu3nJ+GsGh5PKz37gh8tvd4ys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5033.namprd12.prod.outlook.com (2603:10b6:408:132::14)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Sun, 24 Sep
 2023 14:20:18 +0000
Received: from BN9PR12MB5033.namprd12.prod.outlook.com
 ([fe80::c301:75fa:c6ec:d2fc]) by BN9PR12MB5033.namprd12.prod.outlook.com
 ([fe80::c301:75fa:c6ec:d2fc%5]) with mapi id 15.20.6813.017; Sun, 24 Sep 2023
 14:20:17 +0000
Message-ID: <28aff697-531f-497b-874c-72e12c4af488@amd.com>
Date:   Sun, 24 Sep 2023 19:50:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/9] Support light color temperature and chromaticity
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        benjamin.tissoires@redhat.com, lars@metafoo.de,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
 <nycvar.YFH.7.76.2309201612350.14216@cbobk.fhfr.pm>
 <520df871-a6d1-0db3-fba1-cffd35d9cc81@amd.com>
 <20230924134224.64e54daa@jic23-huawei>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20230924134224.64e54daa@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::20) To BN9PR12MB5033.namprd12.prod.outlook.com
 (2603:10b6:408:132::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5033:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f1110d-a95e-4b80-d437-08dbbd096046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNKaPQqqaqg1wM6lcUA+FtUkRDIwryLM2ubc9r6Es6QEyDYwg2Gsx1vmEWiWx6XJsFI8ud4nzPnjqqr8E4EcT529EkV5m9tVS2IXdYUfYV2ZHYM3MRKnU/wbDrFvl5pxMdrdtiLzAzBqt/9f7wMVXxqQe15NyXVV/WBklVrFHkStvq1KuN9/naPUemjLF/4rhrmoKmNsDJNZefKNJm7UxkyuiNN7QpmqzskFfSjdUarUe+iwx0FbDCSBUMG00X/Jk3j9BaJeGRuO4iPzVLa3imrnh8x4omRYQ2O9KW4yDUjbuQzSLRJ0ytZunE1nnn08liWesX7ktqVBGkbeZ8AK4VznEZj6YTB9kgnh8dYaR68B+BPcHebWrWeo9XRpwh9GPm4uYuoJODNjULc6V56hFTJPb5BZqEUyvBXoz8pQIc6m8Vh2WnRx7BCiIMXQsSF3AsNjXj5dcs+P/XMCQi6i6sCxHF3ZrSgZzlEeYWRzZpmzNrH3QYt5P565V/J7czK6PObjX+T53+A0UQUFMGX3eXlNo+ydWP1qTNdZ1MMMELEs+WxcXKxYZMsnsyPv7iMJydKR8t5Q+32UUeCoAcz61dxTTXJQm7CWzcaACbeBoRgSyWOT5OYFORE5a15cGDQNdxPP59O2xUmt9cNR+YiOyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5033.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(83380400001)(8676002)(2616005)(4326008)(5660300002)(8936002)(26005)(6486002)(6506007)(53546011)(41300700001)(6512007)(31686004)(6666004)(478600001)(31696002)(66946007)(54906003)(66476007)(6916009)(38100700002)(66556008)(36756003)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHpWNGRxZEhFajIrN3c2VHVmQmZXaEk0V21vMmdPd1lPZ3NzYWNhMUNHYkdD?=
 =?utf-8?B?QUJBVko1RCt0b0d4U0JHRU5IcG1EY2hPOU14MHVXaG9pdFFuWmRCU2o1OXBj?=
 =?utf-8?B?NmYzeU5RSURlR0hIcitHSkFQRTZ3WkdHMitUWEtUejcxWjFONGVKZlNGZk1J?=
 =?utf-8?B?RFJFemQ0SkMxZHlXMWtYNlVnU2R3b3c3cjF4b3BDdHF2V1pOcC85a3RIenJo?=
 =?utf-8?B?MEl4b01BaDE5aUtOblhMTThSSXN0QW4xWUVhclVITWYvMU1wZ0tuNHpWZ0hM?=
 =?utf-8?B?Vzk4UE10QUNUNEpnZkd0WTNTK2IzSGcwT1NRU0RuT0xPbUhqQWtFS3QvM1RJ?=
 =?utf-8?B?dUVzRGxRZ3lpNnUwUk9vQ1QvUW5yUFRId1JQYUF4dlZnb25BVXRzWkV3eDNk?=
 =?utf-8?B?b0d0bUlVb2NYQ1JBUHlUT0hsY3FQWHhkdXVrSDY5OWw3WndCZDZxbXE2TVlX?=
 =?utf-8?B?eXBOTWlDbGZCbEdwQmZmZCtnLzV3ZFQ5ZHEyc0JGOS9tVnc2SW45NUtsdHF1?=
 =?utf-8?B?WmpjWlRSTDZ3NmNwbEwrQTNpMGpQTmlhd0MxZkw0VllrdTZTZkI3Qjk5U1cv?=
 =?utf-8?B?Skk3c1Nlb3lrTnpNd1hKSkVveWNHNWNkRzJ5L0ZvQVRlam80K3BCZjNvRzRz?=
 =?utf-8?B?Qkp6c0w4aXFGbmVPUTVLTFJ1MVBiM3ZkOXYzUFV5ZU1vTXFsZ1hWSC8wajRx?=
 =?utf-8?B?N1B0MDRRdDZVMUVyY1pDTkZ0MjRrQVB2OVZNQXlMNmwxSEtsQzhIYmVWalpL?=
 =?utf-8?B?RDdOajJIQms1Yk5LTEsvZXN0SVBXUksyT09rdER3Q0duMTdtMitLYTdqdjRY?=
 =?utf-8?B?eDlkTHR5dmQ0RDlXR2xUdTJ4NDZiVDg0czVWVXd0VGRubjZFUHo1UGV3NzR1?=
 =?utf-8?B?bUhSY3VxZGFyNXVlT0gyUFR3bVQrM24waElROTFnMmRtaldYK3N1MWt3MDIx?=
 =?utf-8?B?VHh4N1pQcGlEVStGOEdtZ29YRjRtKzRSSDEvUy9VMEJ6Z2ttNVdYVnZGcGty?=
 =?utf-8?B?VS9GZWdDSE83cDdtdDdPMzY0eXZZTmhwS3oyNGxlWHE3THVnb1dwYUpBWWV1?=
 =?utf-8?B?S0NCZXBzc0hkb0ZWVFRvSWRjdW1udEJGMlhYdytNM2ZtaWNveEE5ZXN2Wnov?=
 =?utf-8?B?N2Y1MVhqUlRFRVJUNG1PeEc1bHRuNFp5VDRJNzlTMkZDVGdob0g1bFJsYUpq?=
 =?utf-8?B?dG9TSTBrTjdkRFFxL0ZNd2FUcUdiY0hwd3pVeDRxMnZrNFE5L2FtekVuVGdR?=
 =?utf-8?B?V05IbDIvcGx6Y1pQZnhkQlRoSnhyR0diMTFwUnNQU1V4bGhMM2o0TFJmMGRY?=
 =?utf-8?B?NTFteHl0NTVadERNSzBObXFNTGszOWxjRDJ5SEtqSm9rUVFEcmdRbEo0azdO?=
 =?utf-8?B?RDFwRkFlSmtBVU55SDVHeXFFNWI5M3dUUklRN0hnY3ZWRkR3dGZuU1I1RWx5?=
 =?utf-8?B?MTA2UC9ySTBlN1FTeEFSdHdzdkpPNXh3RXZQSUEyT0N3b0VnSDJTOVl6cjZw?=
 =?utf-8?B?aE15dm8zeTdoeGFwOVhBL0pIRmZVRmdJZStuWVRyQVcyOW0xdU5IMUlBUVRG?=
 =?utf-8?B?eVU5SEp0VlZIVm5JMWw1d2NrTEtUSzFmNFBGL1pzdndwWEtvd0FMaGptcXVy?=
 =?utf-8?B?YkI4MmxiVTFaZUhZK2xqL3ZVTDRuMkVSUDY4VjQwQXM2SlZmUFBRK3ZkcStU?=
 =?utf-8?B?REdMR3hOV2kxbXNHejhPbVRWdm96Vkl3Z1lnSmhHdlZVSjRsYW1ObVZNZUwr?=
 =?utf-8?B?K0Q4ZFJGejhlWTd4aGE4dDF2T2NuQzlvODZtaEowekh4czEvcjM0TnJwaUQ2?=
 =?utf-8?B?QnlYSHlCQlpTeTlQc1ZNdkdZOG05UmdBUERTeXhZY2s0ZS9LWGdqWFcvMWlO?=
 =?utf-8?B?dUxMWU5MUWtnUit3RjBUNkhqMzFBV01mWkp0R1NxMlpnb28wRkpQdlpIYnEz?=
 =?utf-8?B?eGJOcHE4aW9ET2cxSVdXZnQralpib3FmSGdkVmhhZmpWbGZVUTAxSEpJeVRX?=
 =?utf-8?B?MXovejN1czdkYnNFaWswdFNzREJkcDFvMFBEWVFma29rNW5SVDJaVm5XQTFI?=
 =?utf-8?B?WnBrcFlBQnhuNFAwaEdXL2xGakIrRGRFR0tuR0hTUi9CbzN2SWhXSC9ITGth?=
 =?utf-8?Q?B25kkkUw3o8NvdEUr1byvnc1x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f1110d-a95e-4b80-d437-08dbbd096046
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5033.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2023 14:20:17.4133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxH1d8tng0PoQcEdK7LVRu7XQC5W4etZJHaJTB1wOc9YMDU36Q5e27664GlnDu9Q2GFxFloeLCW4eFsDyYFv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 9/24/2023 6:12 PM, Jonathan Cameron wrote:
> On Wed, 20 Sep 2023 20:53:33 +0530
> Basavaraj Natikar <bnatikar@amd.com> wrote:
>
>> On 9/20/2023 7:43 PM, Jiri Kosina wrote:
>>> On Tue, 19 Sep 2023, Basavaraj Natikar wrote:
>>>  
>>>> This series adds support for light color temperature and chromaticity.
>>>>
>>>> v1->v2:
>>>> *Rename the series.
>>>> *Rename als_illum to als channel as it supports other channels.
>>>> *Update patch description to include same reading for the two existing
>>>>  channels to use channel index to support more hub attributes.
>>>> *Keep line length under 80chars in hid-sensor-als.
>>>> *Add new channel type IIO_COLORTEMP.
>>>> *Update patch description and its subject to add channel type for 
>>>>  chromaticity. 
>>>>
>>>> Basavaraj Natikar (9):
>>>>   iio: hid-sensor-als: Use channel index to support more hub attributes
>>>>   iio: Add channel type light color temperature
>>>>   iio: hid-sensor-als: Add light color temperature support
>>>>   HID: amd_sfh: Add support for light color temperature
>>>>   HID: amd_sfh: Add support for SFH1.1 light color temperature
>>>>   iio: Add channel type for chromaticity
>>>>   iio: hid-sensor-als: Add light chromaticity support
>>>>   HID: amd_sfh: Add light chromaticity support
>>>>   HID: amd_sfh: Add light chromaticity for SFH1.1
>>>>
>>>>  Documentation/ABI/testing/sysfs-bus-iio       |  15 ++
>>>>  .../hid_descriptor/amd_sfh_hid_desc.c         |   7 +
>>>>  .../hid_descriptor/amd_sfh_hid_desc.h         |   3 +
>>>>  .../hid_descriptor/amd_sfh_hid_report_desc.h  |  21 +++
>>>>  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c |   9 ++
>>>>  .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  15 ++
>>>>  drivers/iio/industrialio-core.c               |   2 +
>>>>  drivers/iio/light/hid-sensor-als.c            | 130 +++++++++++++++---
>>>>  include/linux/hid-sensor-ids.h                |   4 +
>>>>  include/uapi/linux/iio/types.h                |   2 +
>>>>  tools/iio/iio_event_monitor.c                 |   3 +
>>>>  11 files changed, 195 insertions(+), 16 deletions(-)  
>>> I believe this should go through Jonathan's tree as a whole, right?  
>> Yes, this should go through Jonathan's tree as a whole.
>> If you don't have concerns, can you please ack HID amd_sfh changes?
> I'll do an immutable branch in case this needs pulling into the hid tree
> later in the cycle.
>
> In short that means I'll create a branch with just this series on top of v6.6-rc1
> and push that out as ib-iio-hid-sensors-v6.6-rc1.
> I'll then merge that into the IIO tree before I do a pull request.
> The advantage of this being that it can be pulled into other trees as necessary
> and keep the same git IDs etc so that git can cleanly unwind the splitting and
> merging of the history to cover the different paths.
>
> However, note this will be messy as the merge into IIO isn't clean. I'll fix it
> up but please take a quick look at the testing branch of iio.git on kernel.org
> where the results of that merge will be.  Some other channel types were added
> recently. So the fix was obvious.
>
> So applied to the branch ib-iio-hid-sensors-6.6-rc1.  I'll merge that into the
> IIO tree. That will get pushed out as testing for the build bots to see if they can
> find anything we missed before I push this out as togreg which is what
> linux-next picks up.
>
> Note the IB branch might be rebased if any test issues show up.

Sure I will check testing branch, Thank you Jonathan.

Thanks,
--
Basavaraj


