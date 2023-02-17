Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D769B376
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 21:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBQUEf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 15:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQUEe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 15:04:34 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CAB5F263
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 12:04:33 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bi36so2839031lfb.6
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNe/6RtjnIqNBvb/+e7bnLoljPPbwRbLvk6KdCsdqLY=;
        b=c+9HtUxW5qx2tQCLDLzUpBv5bEasejAi6WlXWKzQVMRSthXQsA8LlepiHyjIsf4CxD
         yAtOEmKyNGmAszxA/AGDNCXL8LZEL7tilKwirvX+ekhTiSYMVffOk3w9jCgjZH4ueA7P
         9jX6lWBE3b1bzHj0q7k1apl1WbkY7yumWKYvI60Dh7/XosZ13wHBNjeabBBb+UqTyeJd
         hjmwg9/AbKT+axluGZxaKUv1BgOuTT4u68/OCVjREp6EsSBcwvkDKazMcEDp2h30KXdR
         VFFgm8htwkYZ05wILEigBxpjg6bpBqDkdi/7K6z70HgB4pSxhxR2puOqhgAmKIE3z2wv
         RJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNe/6RtjnIqNBvb/+e7bnLoljPPbwRbLvk6KdCsdqLY=;
        b=Z9l74bWRy3duCBt5WEA3ydfUJkuVpLd2gf1aVXqhkgfWLE/iVJ4ue4fEhoNAVlXlav
         ywAcLC14ErdFseW4Duxr4hd83bUqQEStIdJrc6KGlj8KzvOxuSJFdoAd1cczlhqPXxUT
         YZYVk1OOeNln7r0WJ08fihAA2JcrsLjaT2+lKAB6s9seNnKvkE8Iwe0VlyMp1rylZ8xQ
         hHnGV6FvWukqaGwj0/X1cMffcAScKP4hmWC/0gf0v7P7PCGuORTWCyZGmxqPXF0ecksG
         omYlIG/ueGKxoht1H3b+fP9NwghGrL+oHpgFXvNe75J/QU8Fz+HSTEcF9zEW0et3smR+
         LH6Q==
X-Gm-Message-State: AO0yUKV2mMHZdP/SN5XJS2H89RQNN5WPsa+RXmto7YhTAoDiYUiwwv7/
        Ew/FLeWd6/DfaMF8oGsXHpQ=
X-Google-Smtp-Source: AK7set/tL1JUp5scM5TBxROIl/FGs+4d205amL/IGqTX4KSc5Moe1qa6MbJH30Uaz6OoFHZdGDK6uw==
X-Received: by 2002:ac2:4c97:0:b0:4db:2021:a3e1 with SMTP id d23-20020ac24c97000000b004db2021a3e1mr832873lfl.43.1676664271355;
        Fri, 17 Feb 2023 12:04:31 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id w7-20020a05651203c700b004a764f9d653sm769981lfp.242.2023.02.17.12.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 12:04:30 -0800 (PST)
Message-ID: <44a866e5-61ae-3373-10f5-c21efeec7f53@gmail.com>
Date:   Fri, 17 Feb 2023 22:04:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de
References: <cover.1676661174.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 0/1] iio: accel: kionix-kx022a: Timestamp minor fix
In-Reply-To: <cover.1676661174.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks again Mehdi. It's great to have this fixed :)

On 2/17/23 21:19, Mehdi Djait wrote:
> As discussed in [1] here is a patch to get the timestamp in the
> trigger handler from the driver's private data
> 
> [1] https://lore.kernel.org/linux-iio/Y+%2FLpcc0Wa2VGsGO@carbian/T/#mec923c14d1324ffabfa88dde225eeb227005b48f
> 

By the way, I don't think a cover-letter is required for single patches. 
You can usually put the relevant information in the commit message. 
Additionally, if there is some questions, suggestions or other relevant 
bits you wish to say - but don't want to include in commit logs - you 
can usually place them in the patch mail directly after the first
"---"

Eg:

<commit message>
<Signed-off-by and other tags>

---

Here we can add a note / request if required.

  drivers/iio/accel/kionix-kx022a.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c 
b/drivers/iio/accel/kionix-kx022a.c
index f866859855cd..1c3a72380fb8 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c

> Mehdi Djait (1):
>    iio: accel: kionix-kx022a: Get the timestamp from the driver's private
>      data in the trigger_handler
> 
>   drivers/iio/accel/kionix-kx022a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

