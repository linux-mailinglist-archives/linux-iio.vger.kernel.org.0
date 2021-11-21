Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DAC458418
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 15:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbhKUOeC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 09:34:02 -0500
Received: from mail-vi1eur05on2139.outbound.protection.outlook.com ([40.107.21.139]:49888
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238093AbhKUOeB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 09:34:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBJjSShtfAtDuKD9Ofn3pV7G0SzxN7Xfh4VsAnjgwJBlyD+xryTGam3/o7dbCwh7bUXngKdOpetRdzvbym0qAGCD52/PMrDUgnIlEu7T8wQdTSbSY7RUGLT+sdqzg/myTiu+7HfdHXQ3IgCFKzfaSd9J8ADf9uBJfP+Ue4V+wQ1yuk2HV/e2BdkNRBP+XaQzUnGbGWd03jxeJHvaeRcI+vVGxrGxQc2U7I+w+KzTKRReh60n2u03Wue5HCZGsQXJ52bYixiI9U04NZm8MNiXgYq5sQDIMfLMcZLXoxhrPEiH/nsPkrcTdWrdMHLlab4URuA4HZfv4Qk4V095JiTiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPbZWMoTCf711vlJhRtuRsOm2w5nM+ebzHw2uyu9Zbc=;
 b=lCKIQ6eY+kIQqjuyUzUA8hKb+JLe4luvNx39AFCwW/AgB23ZYRuvu89D0CctI61/u36yGXr991AU0+yngvHw79Cyywu6aleYD2SsOZWOn85P7TNTnLChpjwlaDvSM2e8z2mJQA9xEsPxcOzj2Y5h5aJQ7DxUH39g2uf7UaA7HaphfWf+ArSxac4maySUmXpMViQFfX7CRKcThytbi6izz2U/MvxW5bpqHbCPgVyZ+8QdDXFlLAXisHBlAhHe9+IZfOeKe3tVjz7/DWCCEjYpcs8YZQxTbk0nM+R3YLUFck+3zP7gSm8iRK/MIcwJS8t4TFzPMFzQd0la3utwh+elaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPbZWMoTCf711vlJhRtuRsOm2w5nM+ebzHw2uyu9Zbc=;
 b=MSnPdKNUm2Y58RyYjMdIGIcskiKIUZ2Lh2I0h3+Y4CMJPGx0QjFrxe6lE62+wyUW9osAdxUL/57/vCLXlkk4Y4Y63DmgzVsa7LtS8VEHkU1/ft6Uzd3kUniJJ2JkrmuyKToNCkQYGEr07twQCQwUT/VZBpjF1//iNopMXUX/3bE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (10.255.18.221) by
 DB8PR02MB5482.eurprd02.prod.outlook.com (10.255.18.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.24; Sun, 21 Nov 2021 14:30:52 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4713.024; Sun, 21 Nov 2021
 14:30:52 +0000
Message-ID: <476eef37-8d92-651b-37c6-e11b51511d0c@axentia.se>
Date:   Sun, 21 Nov 2021 15:30:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 10/14] iio: test: add basic tests for the iio-rescale
 driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        kernel test robot <lkp@intel.com>
Cc:     Liam Beguin <liambeguin@gmail.com>, lars@metafoo.de,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
References: <20211115034334.1713050-11-liambeguin@gmail.com>
 <202111172344.tSkzL3S5-lkp@intel.com> <20211121111958.3ed740dc@jic23-huawei>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211121111958.3ed740dc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0120.eurprd06.prod.outlook.com
 (2603:10a6:20b:465::18) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by AS9PR06CA0120.eurprd06.prod.outlook.com (2603:10a6:20b:465::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 14:30:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9491fc85-9930-4b86-0ac7-08d9acfb8559
X-MS-TrafficTypeDiagnostic: DB8PR02MB5482:
X-Microsoft-Antispam-PRVS: <DB8PR02MB54820BA726EB32291AA433D3BC9E9@DB8PR02MB5482.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9Ny94hRvrQq5JThhjkDNxas+y8HTX+K2BY272egtzJn0UTJz1jW7AJnMTLKRr7DzZDTgTuaD0hGfFFuvgUSxq2aZQJN8oIsLgSyENJ8ySVYfI137QCVMtg/7yMPJKA6nCqYGkA1O/9p77a56/yz67p3ccs/d5P3RsY68+MoP++d6d3o4tYPK2BKHtokYNVk7hoHi4PWLdF7NhMlDyGTVSz0/r9usoFPVo22IZkBRQ95mjrYPMuTIPu/Pwcx4IRgE26e538H9GZobjn9GXy9leUBEok8nVkOb11zPNWmcobTkJpekM5Cm0mVHSSp9Kvui5AjfFcJgNK8doktE16lBcTEBPfyPtFV0y3GVx+9QuOPu2rJcGFLY/8ZRdvbsXFsRuYNyNcxP7oB2TtK39GUkO5EXQ6eO/JOL8PBbBELzmJGDjEFTBXfpgdsJDVGhpiv2J7HSsH3U/Wbap08TM9F6GvScm9/Ut/TXEmcmNrTDkWKT7N9873QZMnr/yKlmENcZn1f9M31ck+bbm2w5b0quRWpX6SXC3B9CiGt11ZycMeO7NzFjv9aHNsrqhlvNIHyctfZPASdRKpdWiuwEs18WOBpNP3jZNsItF8ONpYrSRM5wX0hwI17O5pgxe723GYsixtBCiJ2DpFo6SILr5yw/b7QYu+GYaf88nZhslN+tAussaRkmxLNN4JQ64DT8M3W+uaMpQV5AWrw6pnMlItULblJ3Znu0y8Nr0gWDzgCMAcQBhgwEQYfGGFL3r97HdWKtxVQCXm7C83JmLAgJfndidP8rhS3JimiMTHqsVAXcgkpn2pdnfBkz0oNAlpaN+fV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39830400003)(6486002)(53546011)(5660300002)(2616005)(86362001)(4001150100001)(4326008)(66946007)(31686004)(38100700002)(8676002)(26005)(956004)(66556008)(186003)(16576012)(31696002)(316002)(2906002)(36756003)(110136005)(36916002)(966005)(508600001)(66476007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1E3MUtnMkNsNThDU3o0Q1MzRFB1WHFFVGZOOFRzUkFWMGs2WW9raFZySVJG?=
 =?utf-8?B?endyaEdPNDZPVmgwa2pBQkdEMFM1Yk5CT1BLd1dqZURndStZb3hxUThhRCs4?=
 =?utf-8?B?RnVBeG9xUFpTZG5IcGN6VUFvU0gzUkp6NGJieHV4NHc0RnBzcFFJZitFOXNF?=
 =?utf-8?B?UDNaMTRsUjc5Tm5HWW1NKzkrRStiYmo3OWxwT2RXZDdMWEZiVlk5OGFvUDhZ?=
 =?utf-8?B?UTFYOU8ySEVYcm44dXBLRGUzTnlBVkg3Q0c4eldrdHRMMHU1ZFpsdm1rQjk2?=
 =?utf-8?B?bUhtbm1JMkQ4UUVKdm1wUkgzYVRURDFPYnA3S0xhYVNHTzgwNUhZQlVaYzh5?=
 =?utf-8?B?ZjY3cFhNdzV4dGRkWG1hR3lpOXhUdXFRSTNRR0p3VWxZVlJ5c1ZDclFaRzFh?=
 =?utf-8?B?NjZNeHZKV2luUzYzTEVjRnhvamFjUnA4QVhPbnBSclIrVUVBNUhLM3FhbEtY?=
 =?utf-8?B?WDZENkVicHZQazNFVjNkd3FiV21nOE1FcG1PUE81cjhXN2RQMUNpM2NEUFh6?=
 =?utf-8?B?cXVUdytRMnhhdHpDaFkrRk9hMWM1b0lCWXRwVzdmV0tDU0dQcmVqMjNMaGhs?=
 =?utf-8?B?TDNhdE1rK1VFNEVteHV0Rnk5WTRGRFVXNWQycXRSQVl4NEoxNXg4YkdXN0Jn?=
 =?utf-8?B?ODc3NVh5QW1iM2psMFlCNlNJQ3ZaTExidTcwVWJ6THkrcEIraDVzTnJQdEcr?=
 =?utf-8?B?aXNZOFN3b0tmVDFEQTJTS05IWlg1bjZzWXFDQTFoVzcybEtRWXkzdU01bVFw?=
 =?utf-8?B?VWtkaXJFK1Y2bVp4d2krcW1PVGlUeXlvTEVGZFZnaVVqb2MvMDIzcVJhVWV6?=
 =?utf-8?B?N3p1eHIzWkIwTXFjSW93L3BqK2hjZXRyWjBEb0xGL0RPTDU3aGFsS0FXRW54?=
 =?utf-8?B?bmhmUFRmV1lJeTkyNFRSTlZZSUlCOUtaY1Jaemk2MlJ3VnBheXlsZStsMXcw?=
 =?utf-8?B?ZUR3MGxEQXpXakUrZVlhRnpzT3lnQUg5emNqVlJDdSsxcW5udHdxR0FtQnA3?=
 =?utf-8?B?TlJDUE5wbUdzRkRVV3hyWHg5emYzSTNNTTlOdzVOUk9ZOExEQ1FLQ1llVEdH?=
 =?utf-8?B?QlAvcjk3SjJjcHpwd0dmNzJaWWxqREV2a051dGJNMis5a3pMVi9pYlJoU1A2?=
 =?utf-8?B?K0t0K2k4aUVSSGs0YjMrZWFDazRrd0xIV0JMWmlrczZCUTduRDBiQ3JnMDVF?=
 =?utf-8?B?WXVDMC80ZjdmSVpmSVFUQ2xtM2I3OUxuNmw4T0cyNmt3ZlJRQk45YnVwUS9q?=
 =?utf-8?B?M0dnM0xSdHlSYWxSaWhRV2xUdkd6NlIxMVNlc0E5RzBVczkranF5OWJ5OHhL?=
 =?utf-8?B?MS9hSWlzYURRemw3d0JIdkdZM3d1UGxuazdVWUQxRGdKbWhQVCtCaFhSdmJZ?=
 =?utf-8?B?Y2VnVG9Sby8zeHh0NlRTTEFEV1RUSGVTVDA0UThpZHlxdDIwd0N6MlNlVS9j?=
 =?utf-8?B?M3hUTDV4bE1TWUU4eGZNNFVHamdXZ1ZGR2ZTMWxCSmlBbUx1V0t2WDhiaUZm?=
 =?utf-8?B?cXFRd1NRV3JRQ0xsdlhNckVRdGdmSllZS0dLR3RNSVJ4SzdZYVphNERzOWRu?=
 =?utf-8?B?bGZRdHpKRWJSdHcrd3NpWlNmcnI1QlNkZ1R5VXlpZjVhdUpUY3Y2Zkh1L21l?=
 =?utf-8?B?VzNxTzIyMTVqaUV1SE5tczg2VnV4UXRlT0xsRnM2RlBBQjFhbkxJR1NQcjdz?=
 =?utf-8?B?eG5tZW9pb1p4N2l3ZUNnN25vQ3paRDlCWkdlMi9jR3JjWmY3VjVSUEN2alRS?=
 =?utf-8?B?bWx6VGpQN0ttcVZVNUlHNTJzaW00UUpjYzY3VTZiOERsZ0NYdW1vTlFoanF6?=
 =?utf-8?B?VEVTaWNDVm5RaW01SjlDK3N2SVFTRnlyQUpYWnZkTHN4Y0UxOXZWVnc4VWc3?=
 =?utf-8?B?QVFBODZpb1R6ZThldmFMMVpzeDFnWUlNWXlaRDM3UTNLd212cTN5c3YyVFZs?=
 =?utf-8?B?K1lFNURRYktzR1RRSlVjYlRST1JwcVBCd2VKVCttQ0pqd0VNN2YzVnJ3NG5p?=
 =?utf-8?B?aklZUVVIeWVWYWc4Yzh1RzJXaXRiejZmQnprMnBaSUwwaHVnNVFKWnpyKy94?=
 =?utf-8?B?em1BOWhRSncyUGtsRGRIMjVZYVJQaEhnaCtGalhuUzY2ZzN1Sk0wWjF2KzdJ?=
 =?utf-8?Q?FdcI=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9491fc85-9930-4b86-0ac7-08d9acfb8559
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 14:30:52.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0+Sql8hNxDu2W2EQzabmVooIhODdIUWpHQemzqI1ICSZ4xV3SvJSHfRwpL856wG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5482
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-11-21 12:19, Jonathan Cameron wrote:
> On Wed, 17 Nov 2021 23:03:24 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
>> Hi Liam,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on 2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1]
>>
>> url:    https://github.com/0day-ci/linux/commits/Liam-Beguin/iio-afe-add-temperature-rescaling-support/20211115-114729
>> base:   2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1
>> config: nds32-randconfig-r003-20211115 (attached as .config)
>> compiler: nds32le-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://github.com/0day-ci/linux/commit/bef63a2e36c2ceccc6f5954ab7e7cbb178c08fd8
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review Liam-Beguin/iio-afe-add-temperature-rescaling-support/20211115-114729
>>         git checkout bef63a2e36c2ceccc6f5954ab7e7cbb178c08fd8
>>         # save the attached .config to linux build tree
>>         mkdir build_dir
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
> 
> This one has me stumped.  The new tests have a depends on KUNIT and that should result in these
> functions being built.
>  
> Anyone know what might have caused these?

I didn't grok that either. My best guess is that the arch in question
(nds32) has some other config thingy that makes kunit build in some
weird way (or maybe not at all). But that's just a very wild guess
indeed.

I'll try to get to reviewing this new version, but I'm swamped at $-job
at the moment...

Cheers,
Peter
