Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403B54B4E1C
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 12:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351183AbiBNLYx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Feb 2022 06:24:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350656AbiBNLYB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 06:24:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CB6C6A000
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 03:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644836399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2JNdyz94e3YQM9h6YpZU/fd0cyjhyn+wzFBEAaPWYc=;
        b=Rwzgi5y+o3KUidj3RKhzSR9l5l6fxZI/yN19v2aBo8B5BoGyTI7LJ86HGoY2BGesuwA+gs
        oo+P5nq8QfF/lT6q8ee0ISh88u7TuLgoM+ssu0b4aG+0fpF0aglqWzMCh1j1tD+K8qVxk6
        3eAPspCaXFMDLIBW6xw00aLFeu2M63c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-zJbXHF5tMw-d-aRl62jHMg-1; Mon, 14 Feb 2022 05:59:54 -0500
X-MC-Unique: zJbXHF5tMw-d-aRl62jHMg-1
Received: by mail-ej1-f71.google.com with SMTP id v2-20020a170906292200b006a94a27f903so5698484ejd.8
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 02:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X2JNdyz94e3YQM9h6YpZU/fd0cyjhyn+wzFBEAaPWYc=;
        b=puwUDf8xQWP5YA5IQ8PfyigjNZwBq9rmoXg71Kw20wY4G0ikKD0TdzGXMzQgcz0R6H
         Q+lOxxdAwqaU+jCUqywblhIf6rNLg9wE3s7zjV1udfg79a6vupwiIzqg4wSRLtKd5p1r
         WPhnOTNYXD8sq/hZvm4xaowemwBkHa/i/+ImewPlIGMGtj2cGZZJNGX+3aZka9yffRRg
         3VwydyBqqubEfCgP0qrL2IDU/e9wlfTpHOxBI/mvdr91z8ZPq+6Sd1T1E1XwODm77dBH
         pFDY4kwvsS/9s3B3+MvAshHD0nPN/nKP3vdgJa02DQ2yog61Osp0Ce9kAkRlqYBiT/Fp
         76Yg==
X-Gm-Message-State: AOAM532f1yhbfioIYer36MopVxy5w6nEmvNZFLSKsxxYDOTpzgWmdj6G
        X+mImQI7S2t2OaX2Vb7JXbg2uMhdZOmOa2AeRelJjeS6QUTweg72ZzikD6GubuLWwhRomza2nZK
        p7Ja7OnHoacqdcpIspGaI
X-Received: by 2002:a05:6402:27cc:: with SMTP id c12mr14794303ede.87.1644836393550;
        Mon, 14 Feb 2022 02:59:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTpxqshyIDFqSwNT5JDFvembS6IjVX6Gb8+F+uV2sbfhVDJLaLRLipdt2EtKA2RnIZKo4O4g==
X-Received: by 2002:a05:6402:27cc:: with SMTP id c12mr14794282ede.87.1644836393348;
        Mon, 14 Feb 2022 02:59:53 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id v23sm10713028ejy.177.2022.02.14.02.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 02:59:52 -0800 (PST)
Message-ID: <b4482ee4-2e8e-e8e4-b1f8-29fb37973780@redhat.com>
Date:   Mon, 14 Feb 2022 11:59:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] iio: mma8452: Fix 'mma8452_dt_ids' defined but not used
 compiler warning
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220214091850.44139-1-hdegoede@redhat.com>
 <20220214105456.00002177@Huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220214105456.00002177@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2/14/22 11:54, Jonathan Cameron wrote:
> On Mon, 14 Feb 2022 10:18:50 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Commit 90adc57bd55a ("iio: mma8452: Fix probe failing when an
>> i2c_device_id is used") introduces a new: "'mma8452_dt_ids' defined
>> but not used" compiler warning.
>>
>> This is caused by the switch from of_match_device() (which takes a
>> pointer to this) to device_get_match_data(), combined with the use of
>> of_match_ptr() when setting of_match_table.
>>
>> We actually want mma8452_dt_ids to get optmized away when CONFIG_OF is
>> not set, so mark it as __maybe_unused to silence the warning.
>>
>> Fixes: 90adc57bd55a ("iio: mma8452: Fix probe failing when an i2c_device_id is used")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> For this I'd rather drop the of_match_ptr() protection.

Ok, that is fine with me.

> We will need to do that anyway shortly as part of converting this
> to fully device properties and allowing ACPI PRP0001 which uses
> the of_match_table from ACPI.
> 
> We can now easily make that transition as (via Andy)
> https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/commit/?h=i2c/alert-for-acpi&id=ca0acb511c21738b32386ce0f85c284b351d919e
> 
> Anyhow, I can just fix it up on the original patch once I'm on the
> right computer.

Great thank you.

> I might also post patches to get rid
> of the of dependency completely if no one else gets there
> before me.

Regards,

Hans


>> ---
>> Note the 90adc57bd55a hash is from the jic23/iio.git testing branch, not
>> sure of it is stable. It is probably best to just squash this into the
>> original commit.
>> ---
>>  drivers/iio/accel/mma8452.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> index 590d9431e1bd..1324bd515377 100644
>> --- a/drivers/iio/accel/mma8452.c
>> +++ b/drivers/iio/accel/mma8452.c
>> @@ -1529,7 +1529,7 @@ static int mma8452_reset(struct i2c_client *client)
>>  	return -ETIMEDOUT;
>>  }
>>  
>> -static const struct of_device_id mma8452_dt_ids[] = {
>> +static const struct of_device_id __maybe_unused mma8452_dt_ids[] = {
>>  	{ .compatible = "fsl,mma8451", .data = &mma_chip_info_table[mma8451] },
>>  	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
>>  	{ .compatible = "fsl,mma8453", .data = &mma_chip_info_table[mma8453] },
> 

