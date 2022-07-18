Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77770578C01
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 22:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiGRUpg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 16:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiGRUpg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 16:45:36 -0400
X-Greylist: delayed 586 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 13:45:34 PDT
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F4C2ED6E
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2022 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Reply-To:Content-ID:Content-Description;
        bh=1i5wBjYk4JUpEetOutRLZhKxP+2yBdqQx6Mj0ImvN6c=; b=DSqL/fW/vev/vbsNvLnPyUb7Fw
        6HugH+gmwudWUXnZtiEJvDSdNhd8KiI9mVdNMInidK0ypiOL95EzoAj7k0YvcVUyjByBHb1I61I2Q
        H3IC2m7Fkc2faj6rrURO2yNC8lDF1Cpoqsq+9RBKcA8lG1B6xdBOTNfBr1DVFuEl80t0bQUQjtQIT
        dKwVbSiBCkp8hN+XbyEo803g/k+mVjYo+P9Pxyb4LjfDsEvEf5dQa86LQRRmpyEhpKNLAi7itjNag
        AA5ZrPrSQMEc/mzIPZscZsSZ/IFbpwoLyiOgjx9ve8/RthzyYOZgOe+cOuUn7j6vZkbqC/M3RRB4A
        zST8/o9Q==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.94.2)
        (envelope-from <ukleinek@debian.org>)
        id 1oDXSm-008w3F-On; Mon, 18 Jul 2022 20:35:32 +0000
Message-ID: <3a819437-7041-f2bd-fe92-c67b040e3e4b@debian.org>
Date:   Mon, 18 Jul 2022 22:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] iio: humidity: dht11: Emit error messages for
 probe failures
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Yves-Alexis Perez <corsac@debian.org>
References: <20220718194258.181738-1-ukleinek@debian.org>
 <20220718194258.181738-2-ukleinek@debian.org>
 <CAHp75VfauFGXHuOGt0WkCmxK-cZRpAhC8yfckGzxB1d3fxK6dA@mail.gmail.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <ukleinek@debian.org>
In-Reply-To: <CAHp75VfauFGXHuOGt0WkCmxK-cZRpAhC8yfckGzxB1d3fxK6dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Debian-User: ukleinek
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Andy,

On 7/18/22 22:27, Andy Shevchenko wrote:
> On Mon, Jul 18, 2022 at 9:50 PM Uwe Kleine-König <ukleinek@debian.org> wrote:
>>
>> There are two exit points in the driver's probe function that fail
>> silently. From a user perspective this is unsatisfactory because the
>> device is unusable but there is no hint in the kernel log about the
>> actual problem which makes it unnecessarily hard to fix the problem.
>>
>> Make use of dev_err_probe() to emit a problem indication which also does
>> the right thing if requesting the gpio return -EPROBE_DEFER.
> 
> ...
> 
>> +       ret = devm_iio_device_register(dev, iio);
>> +       if (ret < 0)
> 
> Do we really need this ' < 0' part?

Not sure, I stumbled about that when I split the patch, too. 
devm_iio_device_register only returns a value <= 0 and I don't expect 
dev_err_probe to behave when the error is >= 0. So adding the check at 
least documents the expectations. But I don't have hard feelings and 
dropping " < 0" would be fine for me, too.

>> +               return dev_err_probe(dev, ret, "Failed to register iio device\n");

Best regards
Uwe
