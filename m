Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE54977C2
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 13:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfHULLY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Aug 2019 07:11:24 -0400
Received: from first.geanix.com ([116.203.34.67]:54578 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfHULLY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Aug 2019 07:11:24 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 3159428B;
        Wed, 21 Aug 2019 11:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566385873; bh=LAGc1X0K3lso435hB5StiaA1bSF9jhorG+LPnCkJeko=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dZWWPXvUsAGR0F2AekxIvFCiJylEnzlYC0yEqPnCU41bmbEjGBQjYGZrXXpHxny89
         EOUgeJIVul4x6sOxvsUSNZwDYDWghLo3BmUMIxrbEuc6TiOpP0mBmYtvWkrsASpk8T
         Bd1NTuCSSHCtinvoIrqrd2zskMHY5mddzoFzgFYXolWICPF+STmgmHMDsOBuaiEf1I
         JVbEhQpNj+oKBor9dbM1FAGevCT4Ut4ZM7iDbKU902UinQIDvZxXREcxyhIAcv4SNm
         S2+zTSQjuDmTLv+0rmgYZoQEuTRl2NTncYZ2euBmA1pqT6D97qiLv1nxmtPGZD6DCx
         Kx3XXYR3v/uSQ==
Subject: Re: [PATCH v2 3/6] iio: imu: st_lsm6dsx: add motion events
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com
References: <20190715081514.81129-1-sean@geanix.com>
 <20190715081514.81129-3-sean@geanix.com>
 <20190716082927.GB13440@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <2d8adf1f-4a8e-978b-dd48-2724c3c0b566@geanix.com>
Date:   Wed, 21 Aug 2019 13:11:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716082927.GB13440@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 16/07/2019 10.29, Lorenzo Bianconi wrote:

>> +#define ST_LSM6DSX_CHANNEL_ACC(chan_type, addr, mod, scan_idx)		\
>> +{									\
>> +	.type = chan_type,						\
>> +	.address = addr,						\
>> +	.modified = 1,							\
>> +	.channel2 = mod,						\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
>> +			      BIT(IIO_CHAN_INFO_SCALE),			\
>> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>> +	.scan_index = scan_idx,						\
>> +	.scan_type = {							\
>> +		.sign = 's',						\
>> +		.realbits = 16,						\
>> +		.storagebits = 16,					\
>> +		.endianness = IIO_LE,					\
>> +	},								\
>> +	.event_spec = &st_lsm6dsx_event,				\
>> +	.num_event_specs = 1,						\
>> +}
> 
> I would prefer to extend existing macros
> 
>> +
>>   #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
>>   {									\
>>   	.type = chan_type,						\
>> @@ -297,6 +318,8 @@ struct st_lsm6dsx_hw {
>>   	u8 enable_mask;
>>   	u8 ts_sip;
>>   	u8 sip;
>> +	u8 event_threshold;
>> +	bool enable_event;
>>   	int drdy_pin;
>>   
>>   	u8 *buff;
>> @@ -306,6 +329,13 @@ struct st_lsm6dsx_hw {
>>   	const struct st_lsm6dsx_settings *settings;
>>   };
>>   

How would I do that when we have the `event_spec` for the accelerometer?

/Sean
