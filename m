Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF0570F151
	for <lists+linux-iio@lfdr.de>; Wed, 24 May 2023 10:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjEXIpu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 May 2023 04:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjEXIpt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 May 2023 04:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D020A18B
        for <linux-iio@vger.kernel.org>; Wed, 24 May 2023 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684917903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPjNnsilisJpU1pieN0XK+ygIXwy0O0sWum8P6BGIYA=;
        b=NWQCOqXzTCwXAmCJxm1NKx94T/+RT+wQvZkWYkpGlpir2l9gzDoykGVahXzzQ2JX0F5zvy
        5ipvrdjX8diltUNX+O4QqFbbEeHigsG7SwZfRru9hT0lMtBGM7AnbTYE67AemO+LqXfnIn
        dvJOKg/0Sg2S5odetMBr/AorVCZxiZY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-eVGEO85PPCSsD633r68ZFw-1; Wed, 24 May 2023 04:45:01 -0400
X-MC-Unique: eVGEO85PPCSsD633r68ZFw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9715654ab36so62088166b.0
        for <linux-iio@vger.kernel.org>; Wed, 24 May 2023 01:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684917900; x=1687509900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPjNnsilisJpU1pieN0XK+ygIXwy0O0sWum8P6BGIYA=;
        b=PO9TL15NhbCdRKHFUntLl2xEn36vnudBoAnwKpgL+j3XVfK1V7I7j+j86c5i9iXVIf
         /m8tl31Zrf246gS1hV2WGjT3tDhlTD6+S+QzY7vAkqB3mkPM25GxgobTLwDh45JxvgXz
         85pql5vzplV0IQV6Q0zHe6yWjrz/58Q0j6IrX7l9DBhpeS3C2w0bkPPbKnJWbxRcnHqq
         K1KQMn7xuMgP1oCrKPRdRH+jivsO+BqXfnksuAF3+sb/Nq5j5HrlyiBLFYNayXnhW2ws
         yvf9ugTLqYEixT0ukpRJGixTHtfFtwYzQF641b8ikUDTF6CWM090h8sFYqFUvvtDu/F7
         5ZjA==
X-Gm-Message-State: AC+VfDx2R9rTKRs9QQWzZrvOuN0Rlf40XENtLU6g9Y8dwvwxpBanh8zM
        xxGhhaYqVDs98aSDIQHLNJqnaAaMCDiyj8V/00bolipqavYOH/79uoudKdPYQ7iSii705NawCzp
        ZoNKcc7+ntkXObeBXn+hS
X-Received: by 2002:a17:907:268e:b0:969:f677:11b9 with SMTP id bn14-20020a170907268e00b00969f67711b9mr16410169ejc.54.1684917900393;
        Wed, 24 May 2023 01:45:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pfcMobEA+3q24rkthAiEr346uOcv7B+ftBoawjPmSRKFqwnlDDi2urafqqQrZpSgY4J+Hww==
X-Received: by 2002:a17:907:268e:b0:969:f677:11b9 with SMTP id bn14-20020a170907268e00b00969f67711b9mr16410152ejc.54.1684917900013;
        Wed, 24 May 2023 01:45:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f25-20020a05640214d900b0050dab547fc6sm4871400edx.74.2023.05.24.01.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 01:44:59 -0700 (PDT)
Message-ID: <2bdacc5a-8d8a-159a-780b-5038325ce62f@redhat.com>
Date:   Wed, 24 May 2023 10:44:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] staging: Switch i2c drivers back to use .probe()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org,
        Tom Rix <trix@redhat.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Jean Delvare <jdelvare@suse.de>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Haowen Bai <baihaowen@meizu.com>,
        Jens Frederich <jfrederich@gmail.com>,
        linux-staging@lists.linux.dev,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        linux-media@vger.kernel.org,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kalle Valo <kvalo@kernel.org>,
        Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        kernel@pengutronix.de, Wolfram Sang <wsa@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@kernel.org>
References: <20230523200036.465180-1-u.kleine-koenig@pengutronix.de>
 <b9954a28-1ab2-468d-beb5-2fa2e0f2c069@redhat.com>
 <20230524060104.wljjqi2ep2ag2245@pengutronix.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230524060104.wljjqi2ep2ag2245@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/24/23 08:01, Uwe Kleine-König wrote:
> Hello Hans,
> 
> On Tue, May 23, 2023 at 10:40:43PM +0200, Hans de Goede wrote:
>> On 5/23/23 22:00, Uwe Kleine-König wrote:
>>> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
>>> call-back type"), all drivers being converted to .probe_new() and then
>>> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
>>> back to (the new) .probe() to be able to eventually drop .probe_new() from
>>> struct i2c_driver.
>>>
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>> ---
>>> Hello,
>>>
>>> this patch was generated using coccinelle.
>>>
>>> I chose to convert all drivers below drivers/staging in a single
>>> patch, but if you prefer I can split by driver.
>>
>> I'm currently doing a lot of cleanup work on the atomisp code
>> including the sensor drivers. Specifically I'm working on
>> removing drivers which are duplicate with the standard v4l2
>> sensor drivers under drivers/media/i2c . So this patch is
>> likely to cause conflicts.
>>
>> I have my own branch for my atomisp work from which I send
>> pull-reqs directly to Mauro Chehab:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp
>>
>> As such I think for the atomisp drivers it would be best if I directly
>> apply the atomisp bits of this patch (no need for a resend) to my
>> media-atomisp branch, is that ok with you ?
> 
> For me that would be fine, it's mostly Greg who has to cope. As Jonathan
> also suggested to split, I suggest I do this. Then everyone can pickup
> the usual bits without too much conflicts.

That makes sense. I'll wait for your split up version then and
then I'll merge the atomisp bits of that version.

Regards,

Hans


