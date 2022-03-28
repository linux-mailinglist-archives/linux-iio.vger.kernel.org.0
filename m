Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC64E8B74
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 03:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiC1BKZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 21:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiC1BKW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 21:10:22 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2124EF5B
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 18:08:42 -0700 (PDT)
Subject: Re: [PATCH] iio: adc: da9150-gpadc: fix build on mips
 CONFIG_MIKROTIK_RB532=y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648429718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pR6mXLrr6C1FJKZVQgxCcZ2BszHpoAhmqjHBOY+BlmA=;
        b=IpbgPrmLXZ9TZpdCeR6EtWb+cFVeQeyzIKSbLd58UKcbMvqDLEj9phTiUYbUKYdz2MfY0G
        dv36Y6pM3+SGEZPGkS11Bb2klmNC7DdSDpQxvWz44xbqi19+yxd3Zlyo6+Kl+Am12hFSd/
        /2sxXeBaMlaITJ6KUyAAfxBGEntVuA8=
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20220324055821.3184872-1-liu.yun@linux.dev>
 <CAHp75VfEyhB92iP8sRyGn+2WLzazFtok=47xzewhCt=bo=a7Zw@mail.gmail.com>
 <20220327155718.0d00be25@jic23-huawei>
 <CAHp75VcQ5c1XviKBMr7eU-fsy5jLViVcEt=ahHoSHzqoz3JNpg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jackie Liu <liu.yun@linux.dev>
Message-ID: <c0b7514d-fa3f-b747-948a-5108ce1a33a6@linux.dev>
Date:   Mon, 28 Mar 2022 09:08:29 +0800
MIME-Version: 1.0
In-Reply-To: <CAHp75VcQ5c1XviKBMr7eU-fsy5jLViVcEt=ahHoSHzqoz3JNpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy and Jonathan.

     Hello, thank you for your replies, in fact, I also think it is not
suitable to do a workaround here, I want to directly try to modify the
definition under the MIPS/rb532 architecture, if possible.

--
Jackie Liu

在 2022/3/28 上午3:35, Andy Shevchenko 写道:
> On Sun, Mar 27, 2022 at 5:49 PM Jonathan Cameron <jic23@kernel.org> wrote:
>> On Thu, 24 Mar 2022 12:18:14 +0200
>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Thu, Mar 24, 2022 at 7:58 AM Jackie Liu <liu.yun@linux.dev> wrote:
> 
>>  From some very basic grepping I 'suspect' you could just push the defines
>> down into arch/mips/rb532/gpio.c but I may well be wrong...
> 
> It would be ideal if we may hide them in the C-file(s).
> 
