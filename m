Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C141A338D
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 13:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDILu2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 07:50:28 -0400
Received: from mail-zr0che01on2128.outbound.protection.outlook.com ([40.107.24.128]:14017
        "EHLO CHE01-ZR0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgDILu2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 9 Apr 2020 07:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvDse6N6SwXl4ECXZFmbidJ2Kmj21s44G20xPN9Fw5biZ6gT4Dw4HQjc5bWf6hROEU3XTYr2J5byee/yyO6mAMdcs5mNXtWCMhyP6lSUxIeOaPfiTOjYHMldmhuUwUzjKQ7SStgo/eO8NyqW52FH0H+/LFGH9eZWdAvX1cT6/JnfgIiK/kN4O+CHYtymfUMx0MFgKx8MmrkTvhFJwEJ1qiDsPKT8KlJEgc0ICotfowYBRx1biC0oAKleY2/bEFsfSKaT9ijZBB/94Y2oh3N3GnUV32hN9ULyGjf604rqHpohDIAI4M0ya3OWG+7vdFwrh1krFRoZEf66NnQJHKrqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs4KJ+B+Qs+InW/n6gi++qj5VkJpQa209DavV4Haia4=;
 b=k80u2skth0sfO6ZSJoY49mc5dhEqd2OgvJ+nf+vUCLd1z5Ha4X/v2woEMvVcxY1tnvWoDjk1fht9bIIuyR/Ia4BnFOKrdZgqzHaxFN3J/O/lulUsbihNFfPEyPL3pwEkl/PNoWJSmno4hVQGr144wQBcRI5IoElKEpwJApVs8JBSosmVC3e/nyYZ+mSqa01MddPFh3Z/PawZCpib1QwsPgTD6qLs1YxOat7nOlTUzP/OhDVN5rB5erPSKZ1sNnky4Yz2DwwfDSc3V2KsugZPikG0Bgq2WCyytiaMgKaxmchcdtSQ31jgpoAivv7QqYXQkavnhJwcL6hFDBVRWMgYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netmodule.com; dmarc=pass action=none
 header.from=netmodule.com; dkim=pass header.d=netmodule.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector2-netmodule-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs4KJ+B+Qs+InW/n6gi++qj5VkJpQa209DavV4Haia4=;
 b=IkUzf+dcENcUcwwbQoEDKvHeKaM46izDvAHiEX19BUWrYdDrIdsyaJXYo5DtU4wtQjG4jOdDK10Q9aXmow3pRoRw037F4IQahp3HbVgrbcPqGbegv1tRyB8aALT9aaq9CtO+4Q+mpv1EoV9syl6+5Yn2wuGT2ms5ub2KEg/cqo4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alexandre.Bard@netmodule.com; 
Received: from GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM (10.186.181.138) by
 GV0P278MB0052.CHEP278.PROD.OUTLOOK.COM (10.186.181.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Thu, 9 Apr 2020 11:50:25 +0000
Received: from GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a945:c379:b39b:c6ea]) by GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a945:c379:b39b:c6ea%3]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 11:50:25 +0000
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix reading array out of bounds
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     lorenzo.bianconi83@gmail.com, linux-iio@vger.kernel.org
References: <20200409085818.9533-1-alexandre.bard@netmodule.com>
 <20200409110128.GA53758@gerhold.net>
From:   Alexandre Bard <alexandre.bard@netmodule.com>
Message-ID: <3954c87f-ffcd-69ab-06b9-0615fbd85c71@netmodule.com>
Date:   Thu, 9 Apr 2020 13:50:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200409110128.GA53758@gerhold.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
X-ClientProxiedBy: GVAP278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::24) To GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:1d::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (185.230.117.171) by GVAP278CA0014.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 11:50:25 +0000
X-Originating-IP: [185.230.117.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c0b70d-7bdb-4ec9-3cdc-08d7dc7c3101
X-MS-TrafficTypeDiagnostic: GV0P278MB0052:
X-Microsoft-Antispam-PRVS: <GV0P278MB0052EEA15515CF570D7CC83A87C10@GV0P278MB0052.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0083.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(136003)(39840400004)(346002)(396003)(366004)(316002)(4326008)(2906002)(86362001)(16576012)(52116002)(26005)(5660300002)(6916009)(31696002)(66574012)(8676002)(66476007)(66556008)(66946007)(16526019)(508600001)(956004)(8936002)(36756003)(81156014)(44832011)(6486002)(2616005)(31686004)(81166007)(186003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: netmodule.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZTaZohK2zIi445UcZrTquTNl6WppMywT3Pcmm6jNTZuKjYDCE0CyglgtWCCo85qcodMmn8cDczM2+QW0Z9EEmsgEG7F8muNeV/Py1mk20JGEsEPiOKT6msKMDCmu1x5xZ+S6grrEu8X0fqXh6ATqCgmVjVNRQHwuIE3SfnTgifS2cdfMMmwuS7jDQz9SNWeajkY2Unu/yuqLiiuyrO35xp7BiKQPHwno973nc39cFhxmtrOiU6mNFpDck98ORPv45TLk3dotfPJ+SmE078dEJ6W0gbF22idT3vLBQejX0VnYGcWo0vrf0VwIAFjff2uQuzB3jEoYLxZBEoQtDaBmj0lUm4G6fnGDr4LLAIwjLFMTz2ve0BWVDeDQ94uKJqcNdTCmdFxvTQu2dvTP1b1m5EfYCC0FQA5MXQhFqpBZqgjL4+CFadip1TC4cnQAU3C
X-MS-Exchange-AntiSpam-MessageData: bxyv3PIM1rvXNJhEFo2vyABjHrfIGvrCbk2awvsiXznx+k+f+0ADg0v+4ACZdqDApngFY1UraClrZo+YH/6Nva1sbkD2jLfhPEgCvzJEZ0R8oIxJcIpe+Dvcgz8xRG/dq7XsrWpo3c7ilYpdAsk7lA==
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c0b70d-7bdb-4ec9-3cdc-08d7dc7c3101
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 11:50:25.3728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/cRqvauSACgC4o/JDfzpQT/44vZ9LGBVFgTr/22nAM6A6A6VeS1NNKuFpVrxaENgb3SbRN5o3E0EbY9jN5gcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0052
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le 09.04.20 à 13:01, Stephan Gerhold a écrit :
> On Thu, Apr 09, 2020 at 10:58:18AM +0200, Alexandre Bard wrote:
>> Former code was iterating through all possible IDs whereas only a few
>> per settings array are really available. Leading to several out of
>> bounds readings.
>>
>> Line is now longer than 80 characters. But since it is a classic for
>> loop I think it is better to keep it like this than splitting it.
>>
>> Signed-off-by: Alexandre Bard <alexandre.bard@netmodule.com>
>> ---
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> index 84d219ae6aee..be8882ff30eb 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> @@ -1350,7 +1350,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
>>  	int err, i, j, data;
>>  
>>  	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
>> -		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
>> +		for (j = 0; j < ARRAY_SIZE(st_lsm6dsx_sensor_settings[i].id); j++) {
> id in st_lsm6dsx_settings is declared as:
>
> 	struct {
> 		enum st_lsm6dsx_hw_id hw_id;
> 		const char *name;
> 	} id[ST_LSM6DSX_MAX_ID];
>
> so it's always ST_LSM6DSX_MAX_ID long
> (additional entries are just zero-initialized).
>
> Isn't ARRAY_SIZE(st_lsm6dsx_sensor_settings[i].id) == ST_LSM6DSX_MAX_ID
> in this case?
Yes, you are right, I missed that. But there is still a problem :
parsing 0-initialized fields can lead to a false positive when looking for the
value ST_LSM6DS3_ID which is the first element of an enum. So either the enum
must be patched to start at 1 or the length of valid ids in a settings must be
retrieved somehow.

Or is there another way ? Or am I wrong ?
>
>>  			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
>>  			    id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
>>  				break;
>> -- 
>> 2.20.1
>>
