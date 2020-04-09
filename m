Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCF31A33E2
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 14:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgDIMOn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 08:14:43 -0400
Received: from mail-gv0che01on2124.outbound.protection.outlook.com ([40.107.23.124]:54496
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbgDIMOn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 9 Apr 2020 08:14:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZP/Xn0jFYmmc/CBGoGH9QJyBuZRWyxgucrYxMyKwMixE+s01P27ERfqt2zJGPG1MpG0d7L6wJtjt/dR7EBkliXyUKLgIsI1wjvaQqepPczF/XjXX5eNfdFnS9VKqUOcM2TZV6z6lssN05S0u1x7A0rEn0hsYJQKMjKsTlNzs3oL6NUQhHaiELQiyuMHilZ+js6aaiRb+UmdjBTqMehUvmgrAnHilmVMipbA3vCZrgyLpIfmEHX6aHxUdkqWLU+fb9IU7cwuhieeMcxLu+g4wfsIdlaY6T5QjrByC7hOPeIflbKrE1WGmPQKMtRwAvCsk5nPsdZHnzFtECo2Db+jHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/oAx2cT8wwJBBYCbpaaNcurn7Ls+sQeV7nUTDyA624=;
 b=n2G824+5aLd7TaOtPX9KBiHCveslmpDufzMf3c85vmf2PpyPim/0o6uHWgLQUhBNalAUKSRk3oeSla48Nk/2xr12BNqBBmTtsJS6oKGzyCnfYwWlgQVhc1+3sm8KHL9gB+ATzF/9bUT5FoobJe3GcEzGLL0w1PwT75EMwwo5NUyLFxMTberg58lBJx+Iee1aPAGJnIYR0Y40qlnLcDIuo9pbJ3Qvc/VSWSvgXq0FoyqGTCVgdHe0s0YM5MC2YoaJ/5xMa1ePt5/l/pe8CXXcG6u7GTpA3IDEk+WDeR9SkYcLMAdF8CovK35Y+8Deb9JBLvwDsSDzai+jc88I6/XQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netmodule.com; dmarc=pass action=none
 header.from=netmodule.com; dkim=pass header.d=netmodule.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector2-netmodule-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/oAx2cT8wwJBBYCbpaaNcurn7Ls+sQeV7nUTDyA624=;
 b=HwA4UtdwG1+eTsGGQ6kxuFpnED3VsU6ox5rHIYDFQFbmpaCnbQuSwntrL4SXFflTD1jLBBJbkZQR2gPB5khRSVBbNQAP+s4ykWvYnGotYHw5VPtbI5rab9aYjACBtL9atpohjt8MVYWbkWkL3Iu75OQilFCXuxCZP4Eo92MSrOY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexandre.Bard@netmodule.com; 
Received: from GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM (10.186.181.138) by
 GV0P278MB0001.CHEP278.PROD.OUTLOOK.COM (10.186.181.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Thu, 9 Apr 2020 12:14:39 +0000
Received: from GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a945:c379:b39b:c6ea]) by GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a945:c379:b39b:c6ea%3]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 12:14:39 +0000
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix reading array out of bounds
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     lorenzo.bianconi83@gmail.com, linux-iio@vger.kernel.org
References: <20200409085818.9533-1-alexandre.bard@netmodule.com>
 <20200409110128.GA53758@gerhold.net>
 <3954c87f-ffcd-69ab-06b9-0615fbd85c71@netmodule.com>
 <20200409120918.GA54520@gerhold.net>
From:   Alexandre Bard <alexandre.bard@netmodule.com>
Message-ID: <218bcfb0-e411-0e82-8f8a-7e9e9f58cd52@netmodule.com>
Date:   Thu, 9 Apr 2020 14:14:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200409120918.GA54520@gerhold.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:1d::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (185.230.117.171) by ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 12:14:39 +0000
X-Originating-IP: [185.230.117.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f372a07-3eeb-4791-1e74-08d7dc7f93ea
X-MS-TrafficTypeDiagnostic: GV0P278MB0001:
X-Microsoft-Antispam-PRVS: <GV0P278MB000114DEE2BA1C29AB29AC1E87C10@GV0P278MB0001.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(136003)(376002)(39840400004)(396003)(366004)(81156014)(66574012)(8936002)(2616005)(31686004)(5660300002)(4326008)(508600001)(956004)(8676002)(6916009)(36756003)(44832011)(86362001)(52116002)(6486002)(186003)(31696002)(26005)(16526019)(2906002)(16576012)(66946007)(81166007)(316002)(66556008)(66476007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: netmodule.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXaQBiYEhMcyhZRL50BiuSfarcTgEX2fdFHvY91cOLoVSMpA8MBusvsd+PVPFRGt/oce3k0e62MDXOH8cjvZoqCBiEQ2Gv3m/Hha0zhXtlW6BJkTSdgXknkKDu4iayyhQ9BIRIKJPGhlp9rW3PweQmlHSnMmdYeGrTljwWJQ3Wis/dkTMZaoP5vOzmXODmcC8XxPz/F5HNopWMJbxy2yXmnbJVKlaUJVmr0hDVjsE1BgPgd0jRRso8+WIrPr3Guid84ADgBzDYrb6UXp7b1YjI+psO20/5l1IIlQCanuE1a+svtLqPW0Kn4Fl7a2mqI5MSLZRZ23IZ4Scb4Q0kwhvD5v89y6y79ngDjFbOE27UtKfQ88oqt8J9oFHI2AosJIFfq4vIFeuQ5UGBOXk8Yhxa4cR5oev+I7eLUlbQiMgkaq0kmeIa6YPwEV8LKPPbdE
X-MS-Exchange-AntiSpam-MessageData: 9BJl8ENsiQMZBsYWhWlyp/iL3os5afR4DpWpdI1uxI1yX2keBXlK49GMgFdxvGGDB6Tf20WYFVJn3Lo4pNG/CjJW7t1ltyTchL92vU1QFUpQjqQm95c9fuHVUqt7HzZaYfyTTaD6icLLafaNv33Jbw==
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f372a07-3eeb-4791-1e74-08d7dc7f93ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 12:14:39.7870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xgl5HzMWHikIE7wyc2s81JsClouQrPCZJZxpafYcP6xBHqfduwarboeLltq5Oq7PliZ8pMCN2x6BKcus2/ltug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0001
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> On Thu, Apr 09, 2020 at 01:50:24PM +0200, Alexandre Bard wrote:
>> Le 09.04.20 à 13:01, Stephan Gerhold a écrit :
>>> On Thu, Apr 09, 2020 at 10:58:18AM +0200, Alexandre Bard wrote:
>>>> Former code was iterating through all possible IDs whereas only a few
>>>> per settings array are really available. Leading to several out of
>>>> bounds readings.
>>>>
>>>> Line is now longer than 80 characters. But since it is a classic for
>>>> loop I think it is better to keep it like this than splitting it.
>>>>
>>>> Signed-off-by: Alexandre Bard <alexandre.bard@netmodule.com>
>>>> ---
>>>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>>> index 84d219ae6aee..be8882ff30eb 100644
>>>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>>>> @@ -1350,7 +1350,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
>>>>  	int err, i, j, data;
>>>>  
>>>>  	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
>>>> -		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
>>>> +		for (j = 0; j < ARRAY_SIZE(st_lsm6dsx_sensor_settings[i].id); j++) {
>>> id in st_lsm6dsx_settings is declared as:
>>>
>>> 	struct {
>>> 		enum st_lsm6dsx_hw_id hw_id;
>>> 		const char *name;
>>> 	} id[ST_LSM6DSX_MAX_ID];
>>>
>>> so it's always ST_LSM6DSX_MAX_ID long
>>> (additional entries are just zero-initialized).
>>>
>>> Isn't ARRAY_SIZE(st_lsm6dsx_sensor_settings[i].id) == ST_LSM6DSX_MAX_ID
>>> in this case?
>> Yes, you are right, I missed that. But there is still a problem :
>> parsing 0-initialized fields can lead to a false positive when looking for the
>> value ST_LSM6DS3_ID which is the first element of an enum. So either the enum
>> must be patched to start at 1 or the length of valid ids in a settings must be
>> retrieved somehow.
>>
>> Or is there another way ? Or am I wrong ?
> ST_LSM6DS3_ID was indeed broken, which is why I added a .name != NULL
> check in commit fb4fbc8904e7 ("iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID").
>
> .name is only set for properly initialized IDs, so this ensures that we
> do not match any zero-initialized entries. :)

Right, I actually fell on this problem in an older version where .name did not
exist and I did not understand that it was added for this purpose when I checked
out the master branch.

Looks alright then.
Thanks for the feedback.

Best regards,
Alexandre Bard
>
>>>>  			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
>>>>  			    id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
>>>>  				break;
>>>> -- 
>>>> 2.20.1
>>>>
