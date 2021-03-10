Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0736333F59
	for <lists+linux-iio@lfdr.de>; Wed, 10 Mar 2021 14:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhCJNeg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 08:34:36 -0500
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:2881
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232845AbhCJNeT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Mar 2021 08:34:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxF2frHPIukNoMDGiSagXLV7OJhUpmx5GFvn1DFYOdivllbiJyIpz3ya1X+gUvp5YLEqtitGzM7SsT3GiyND4rvcXJafxF9hWO5RqKVq0HFgvWpbiMv2IqKAQzVCPqEEIgmQPrQJD6SqF08rUppFCNwGFUHmJZBO2yUW05KY0qz/5YVqGJDdmuEIU6JsxgowsVQl6BCtNHYzeWiF0b95fF249txUzgzFUEXppzF2nFyPD/3S32jWSq8cUpH/k21l2D1EK9E4NZcQ9qtnTmH0S1Gqb1mDzE15+IcUeUI26UOAVscumyEHBzIlSVNMJ1rpy4PUqaeP5kSGGDS4qRbxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwjeOxKAgroAFTl+5DIj8vUm2WX3mVcDcjhjodJI3n0=;
 b=THzRNeOCemodmPtjqgRL0hohThq82YPXAlWtjZheFV7bdd4DjLs6WdPNxBdDUY83QrEleiW0RvnZ1/T45inGCvkFcPy3MCUYEzbP3tbEE4D+2u2IvOF+s+j+bMzMOLUFfni7CE9O2Z+j8WZaNi/3cO+MlfBqZ6DBPYPIqgwNA8YofYnNohUagVZOP6POwuDPIePOJGzaV682nqtlf4A36WF+JmSIpBLvAMql83+D07nUVwRhVC4z+6ZJJEF7dAoTa47ehIfbdEigxEGwT7A7z3GPw7isbNyEZubuZeo2kZjCXV52c91or+CXJDHIgtBi5meWxlFI7kekPD7PrJ/AWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwjeOxKAgroAFTl+5DIj8vUm2WX3mVcDcjhjodJI3n0=;
 b=3R0TzpRkBH3TjrFSgSZ6/vMunq+eBPNfmXv0LVFiMkiA8ybVf1A+xlJMJib/q4dD2C9i1p7gpbcFuHJmBIAIVB3bhwzP6aoAqD89K0NXnNhHfvSKQDoZYink5XYeLMOmiTmM9nX5hykRtz+ktj/C9x7YBhc/Ym0IbhiKEA9LtHy7Wf0RNMR0v/N1GFw22dAwahtXnobUqkCK17J+hfEI9TRM0ArzQtk60JuT1S0jS8Jbg8gB/qI4rM1oenK7lTDPpLUGm/JblAyWQFuKkyFx7C4Osz9HkJozOkZb5nQPaQMfq01lAI0rFtn4bcSoQZF/kgl1/q5+Ez9/OuYjTPFbZQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VE1PR06MB6270.eurprd06.prod.outlook.com
 (2603:10a6:803:121::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 13:34:16 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 13:34:16 +0000
Subject: Re: shared access to gpio pin
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     linux-iio@vger.kernel.org
References: <d1de620f-b2f5-11ab-5451-962150518f3a@vaisala.com>
Message-ID: <ab4c5bb9-6060-7f2f-b1da-cd7e1f17d453@vaisala.com>
Date:   Wed, 10 Mar 2021 15:34:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <d1de620f-b2f5-11ab-5451-962150518f3a@vaisala.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.156.166.133]
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [85.156.166.133] (85.156.166.133) by AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 13:34:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdcad999-750e-41c2-d25e-08d8e3c9332b
X-MS-TrafficTypeDiagnostic: VE1PR06MB6270:
X-Microsoft-Antispam-PRVS: <VE1PR06MB6270AF971EB6656DD7D998D6FD919@VE1PR06MB6270.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8w0CbU7lu1hB0sgL8FZ3SN3cT3cbzBXZMXxt0jfx0cPVvd0xs/bBCnSAjJ7q7uW9I/xDzskjEMlgrbXXY1D+hpvn08wxphRb+314XnV7ZvZShaDvchAPv3UMJ0ada1ideOrL0sgMKkssLAyHMMFJqLVQLTB5HF/yf+SOrMT8j0HTm6MLilYVXD3W7Cu0tdJvJH68ajqogBTCszU8jQXEtzbgg6vk/B2I076mA7JOj/9XXOtHQ+ylD7eLtkORg/qeeQTSqcoZgaeMy9P0PDxBXDmuEAf3Tn4iyC5WAQHF1si9XSxqwdpCjGxvcgMKz473PwvlRzn4skUPTPZ6qygIXu5ZCuleJBmwZN9U3paFYuLM7yWlKTX18KfIjIgoBYM+g9dQWhi8dQTvFw+N3iBtBuC+5rgO3GuD9MJO/xywk7hvkZb/uPeehzByJTamvG5ecLcJfYsuTRez9dHLDHyrnFFFmbnohrde9wYPtIC9LKaWbj2Mjw4Al+UiRnFY7cveBugJqYjkEA72fr4A3/R4nfyeUvqyDl7H1l9oV1DKXOq/IBaZg/RA8MEjjb9THon3YmS4sQekHm4A+5Sgy4dYcbD/+y4XzJFMKIZt1gE26FoGtclYp47GIQ8N30pkkzM1P4gx1bvqED1Tk53JiOeL0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39850400004)(66476007)(4744005)(16576012)(186003)(316002)(52116002)(8936002)(6486002)(36756003)(44832011)(31696002)(16526019)(5660300002)(66556008)(83380400001)(26005)(53546011)(86362001)(6706004)(31686004)(8676002)(6916009)(956004)(2616005)(2906002)(66946007)(478600001)(3940600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZUowR3dUR01JK3VUK0I0UnRXRW5Zb2hVSjV5VWd1aHdDR05OdHVoaHpDaXZH?=
 =?utf-8?B?Y3N2MHFETzBFWFdSNXFnemdtL3lDN1hQTEZIN24yb3ZvNjQ1ZTNjZmpOUnZt?=
 =?utf-8?B?MXE4MWJ2K0NXU290K1lQVFJuRkYzeDVLalZKejNzYmVPdEcyUDMxWGUyS2g0?=
 =?utf-8?B?TCtXSGZtS0RWVldyODdCc21JR1M5UmpYV1k0WTNXcjdVcTRoZHRQYVB0aW85?=
 =?utf-8?B?a0xQNEVSYm02VmRTNVRKWEZZN29KTWcrMys5bGR6RncweE9tMVQzTXRCdG96?=
 =?utf-8?B?WFhSRHVJRWdJUG4yci9WeG1BN1BVVG8xMGtISlovNFhmMVpncER3TnpHOFB5?=
 =?utf-8?B?UEUxUGlCc25zdFEzZm84ZW9OL1NvMXc2d2ZhRnlUVmFxc2R2VlR1SlZUS0J1?=
 =?utf-8?B?bS9aVTJ2ZjVQV08zQXEyZ0JzZzByQ1pJNUxxaDVjQXlyc0pUZWFxZ0JEK3Ez?=
 =?utf-8?B?QkZVbGdMUUQxL3RBdE9IbFU4VHhwTFRTbklLR1BMR0V1Uk45YmpvKzIvVkZk?=
 =?utf-8?B?bmRSN0xMK05xWWgzM3ZFSC9BWXZsVmFteG11eFNEZXdLK3pSRnZPY3c3M25m?=
 =?utf-8?B?TkZmMDJnTy9pQWdoN2VRNU1XOGM1THowbi9zQ1hVQUtyR2xSSzR4M3ZJQUVG?=
 =?utf-8?B?M2JNd3RmcFgxdHU2alpPUTFxVGg3YkE3R04zZ1dyUy9TVDE4YXlzSkx5T0xp?=
 =?utf-8?B?V0lsdmNOQWF3RThFQjNHYkZvSnBUendNY09KR2NVY0VWYXlLV2dMRFNsSTFl?=
 =?utf-8?B?SFFIVzhnbWRSQVE0cDMrSHVSRjU2V1lQN2swTVA3UkNhc2NxRTlHcjF4YnI0?=
 =?utf-8?B?ZkU2clRUVVFlblBtZElzQWZqeksvWmJlMlRHTC9sakpvejczNkt6eU1PVDEr?=
 =?utf-8?B?QUVodmZNYVRrbllCZXhXVW50R2pVbDlNK1F3ODhOUWkyS3NZeklBeFJZTE9t?=
 =?utf-8?B?dExnWDhiSi9aaWpZWmx0a2NUbCtvNExSYWdweWRzUklGQktLa0hPSmUzRGxr?=
 =?utf-8?B?Mk5jMkRYNFJRdVdKNWRSYURVQlJJYVRQU1dvU2k1b0syZGdvMzN0dFVEVmVp?=
 =?utf-8?B?YXg3WER0WVpCM1p4dkNSNjVsN1NnV0tQdndXN0JENnpVeEtKSk8rQlUxQmhO?=
 =?utf-8?B?dzdtY01MdWlGUmd3dS9RbE5sKzZnMnZ4cTVRTUVBZVhyZmZDVDRTQnNwMEdT?=
 =?utf-8?B?bXNDWERUeVF2RVljQms4SzlYZGw2Tlo4WkNzZmZIbzM5MjIwR2VZNTYreFBE?=
 =?utf-8?B?TGhIUnI0Kyt6dnN4a1BXMk9XZE9rMzREQVpFeEFPOVFIWG1LajJFUko0TXBJ?=
 =?utf-8?B?c1NMVDFLUUg4WWYvZHJJc2tXb3YwbFpIWHhjYnFmSmtOU0hOZnJXeTYxTmw4?=
 =?utf-8?B?VkRYeGdPOWR6K3FXUEFlUGZEL2tmM2U3bEF5OXhha0xaRGI3R3pncEkvYnp5?=
 =?utf-8?B?eEl0SEF2TWlkaFpxSlhkRXpTUWRKNGZzUGxlUjFlL2E0WlBLYmQ4MGt0S2s4?=
 =?utf-8?B?NURKeE1NamdFa09qMUFNUzZmVEd6OW80UUdIRDFMMnZjS1o4T3BqSzFyU0Zz?=
 =?utf-8?B?a29XZ1NkamdUMG5mYjMvVjQ1a0h3QjhVNDRRTHFYaXRJaC9qMUNwS2FhVTlu?=
 =?utf-8?B?K1Y4WnJySmNlT1pzcW5KQlhFLzB6amdEL0xWYU5YTERST2pGdFdhYy9ldmxF?=
 =?utf-8?B?Qjl2WmlYK2pNWUV3Umk1MXVFOWczZDVpU3dVMEgvVUxnSXpMVFJ4Rjl2L3FS?=
 =?utf-8?Q?bUF/0jyYW1lh4rhhyO1yTjMzYsGxZSqObCWxWh5?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcad999-750e-41c2-d25e-08d8e3c9332b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 13:34:16.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xC6/rNEBi3O0ACMZwhBKJonrM3krBMpP2Wc0eB9STMm1blDpMWr0+gXCp5aWcWNLivgfZoVMwpTWn5ZIrYhnCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6270
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sorry for noise, meant for linux-gpio

Tomas

On 3/10/21 3:31 PM, Tomas Melin wrote:
> Hello,
>
> Is there a preferred way of providing shared access to a gpio pin?
>
> Use case is such that there is one application which only monitors the 
> state of gpio pins, while another
>
> actually controls those pins. It would be enough if the monitoring 
> application could read the state of those pins regularly.
>
> With the old sysfs approach, it was rather easy to share read/writes 
> to a certain pin, but is there a
>
> way to provide similar functionality with gpio character devices?
>
>
> Tomas
>
>
>
