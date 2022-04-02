Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509244F0550
	for <lists+linux-iio@lfdr.de>; Sat,  2 Apr 2022 19:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiDBR7P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Apr 2022 13:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiDBR7O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Apr 2022 13:59:14 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D8013F8F4
        for <linux-iio@vger.kernel.org>; Sat,  2 Apr 2022 10:57:22 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 339BA833EF;
        Sat,  2 Apr 2022 19:57:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1648922241;
        bh=mHsN1Snc6PzvBnJRBwJEPxzWRWP7ZiEHmGeIvkzIA5o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Yr0ZJUNR0YLZ99yVO33fJ1C+qG0gVdiAUbteDezT343L0HYQrlN78gcSrIprxF0yz
         J3roWq7sNXLosGSLp7fqDFIWb8hhxf/eGMaQrbO9kyaFg/Qt89mSPFPi+kHyFQRSYe
         c7mRaL6RghC+qngi2mib7yGF9cFPToXzAaTbowX8BvB7f5l9enYFeip4XeMOE7IEoW
         +pX/imlD7BsYNEVLS5VGxd/Us+/Wive0Pgz3FZI2+68/HBHbiL5PLlpyZH/0QCN9SW
         CrJ0UghoFABccDDHvGVo/+MhNnoDykwkhjcIdljXK4YQ3ErVO73424eGqv+3hh2IDh
         O3rc0F/Dc2bJg==
Message-ID: <a5a9f88d-a235-ba15-aaf8-1ed01cb942ee@denx.de>
Date:   Sat, 2 Apr 2022 19:57:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 10/10] iio: adc: ti-ads1015: Switch to read_avail
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220328194725.149150-1-marex@denx.de>
 <20220328194725.149150-10-marex@denx.de>
 <YkRuxHllZ4+zmk4r@smile.fi.intel.com> <20220402180522.3467dd2f@jic23-huawei>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220402180522.3467dd2f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/2/22 19:05, Jonathan Cameron wrote:
> On Wed, 30 Mar 2022 17:52:52 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
>> On Mon, Mar 28, 2022 at 09:47:25PM +0200, Marek Vasut wrote:
>>> Replace sysfs attributes with read_avail() callback. This also permits
>>> removal of ads1115_info, since the scale attribute tables are now part
>>> of chip data.
>>
>> For the entire series,
>> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> That reminds me... Marek, please use a cover letter for multi-patch
> series.  If nothing else it provides a convenient place for people to
> reply like Andy has done here that will get picked up when I use b4 to
> grab the patch series.
> 
> Saves me a bit of time.
> 
> Anyhow, applied to the togreg branch of iio.git and pushed out as
> testing for 0-day to take a look. Note I'll be rebasing on rc1 when
> available before exposing this to linux-next.

Will do wrt cover letter.

Thanks
