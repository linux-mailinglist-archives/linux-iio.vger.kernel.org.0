Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9642B8EAEB
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2019 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfHOMAS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Aug 2019 08:00:18 -0400
Received: from www381.your-server.de ([78.46.137.84]:59664 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbfHOMAS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Aug 2019 08:00:18 -0400
X-Greylist: delayed 1174 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Aug 2019 08:00:17 EDT
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1hyE7Q-0004qd-Ce; Thu, 15 Aug 2019 13:40:36 +0200
Received: from [93.104.111.225] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1hyE7Q-000IFI-3p; Thu, 15 Aug 2019 13:40:36 +0200
Subject: Re: static analysis bug report in drivers/staging/iio/dac/ad5380.c
To:     Colin Ian King <colin.king@canonical.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.ne>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        linux-iio@vger.kernel.org,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <dd9e8ad0-31c8-a06f-be6b-e665e9b2c1c2@canonical.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1f73a6d5-9e77-6f2f-8fcf-ec87f5ffa54d@metafoo.de>
Date:   Thu, 15 Aug 2019 13:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dd9e8ad0-31c8-a06f-be6b-e665e9b2c1c2@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25542/Thu Aug 15 10:25:56 2019)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/15/19 12:21 PM, Colin Ian King wrote:
> Hi,
> 
> Static analysis with Coverity Scan has detected a potential assignment
> bug in ad5380.c:
> 
> 217        case IIO_CHAN_INFO_CALIBBIAS:
> 218                ret = regmap_read(st->regmap,
> AD5380_REG_OFFSET(chan->address),
> 219                                        val);
> 220                if (ret)
> 221                        return ret;
> 222                *val >>= chan->scan_type.shift;
> 
> CID 43178 (#1 of 1): Unused value (UNUSED_VALUE)assigned_pointer:
> Assigning value from val - (1 << chan->scan_type.realbits) / 2 to val
> here, but that stored value is not used.
> 
> 223                val -= (1 << chan->scan_type.realbits) / 2;
> 224                return IIO_VAL_INT;
> 
> val is a pointer and so updating it before a return is probably not the
> intention.  I suspect the intention was probably:
> 
> 		   *val -= (1 << chan->scan_type.realbits) / 2;
> 
> However, I'm not confident about this as the following case has:
> 
> 225        case IIO_CHAN_INFO_SCALE:
> 226                *val = 2 * st->vref;
> 227                *val2 = chan->scan_type.realbits;
> 228                return IIO_VAL_FRACTIONAL_LOG2;
> 
> which may imply the update maybe to *val2 instead, e.g.:
> 
> 		*val2 -= (1 << chan->scan_type.realbits) / 2;
> 
> Any ideas?

Updating changing val to *val is the right fix in this case.
