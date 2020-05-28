Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0811E691A
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405720AbgE1SLm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 14:11:42 -0400
Received: from first.geanix.com ([116.203.34.67]:48238 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391479AbgE1SLB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 May 2020 14:11:01 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 14:11:00 EDT
Received: from [192.168.100.11] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id E36842023CBB;
        Thu, 28 May 2020 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1590688916; bh=7EdpaxnXDeUUhM1sQs0qCfHs6SNelIntgHwN+4QQWEM=;
        h=To:From:Subject:Date;
        b=iv5EkDVzUfX2mG/C8kFrepHoUMW4rNqj/zNRNEo2wP3+YLI0fatWhAlBnLGXy8uCX
         yoGwHH68JJYn9yMZFneHLBMsHtmI4iG+MsJw1af+LHa3dYjlmH3RS0OHW3H2xjQ2GG
         oqNG7kJYPNZeeONfqAcrUBZAifK1MPZewRxZw3FbbtEkamjTi1tfKw/hkiHt8wYQBh
         E8B4J63BL1AqA6hdIqCQteZhqIvMvK+Ut4dO6G0V67Pp8oo3sKZLenAkg36XOsVXxX
         9l1w1dmfA9AVVxmygz2i1ktdYgUwX+t9sR49pJ80IL/uuy3th1OVn8plbfAl8S4DvV
         5rwmJSS7H6mdA==
To:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Subject: IIO timestamp get skewed when suspending (st_lsm6dsx)
Message-ID: <54cb146d-e54e-acae-e89c-075521b8e7dc@geanix.com>
Date:   Thu, 28 May 2020 20:01:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=4.0 tests=ALL_TRUSTED,BAYES_20,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on fdf6823a942a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I don't know if it's normal behavior or maybe just a problem related to 
the buffered reads in st_lsm6dsx.

But when we have the buffered reads enabled and suspending for x amount 
of time. The iio timestamps is, x amount of time is delayed. As seen here:

https://gist.github.com/sknsean/60e20c2fa3a3c6d69ef128c703ed43fc

 From your own software (but I'm able to reproduce with libiio/iio_readdev)

First col is system time,
Second timestamp is the iio timestamp

Could a solution, be to call st_lsm6dsx_reset_hw_ts() in 
st_lsm6dsx_resume() ?

/Sean
