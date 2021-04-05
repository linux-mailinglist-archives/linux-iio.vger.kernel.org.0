Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73EF354524
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 18:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbhDEQ1g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 12:27:36 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:49124 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbhDEQ1g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Apr 2021 12:27:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id F394C9E00EC;
        Mon,  5 Apr 2021 17:27:28 +0100 (BST)
Date:   Mon, 5 Apr 2021 17:27:47 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gwendal@chromium.org, linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: hrtimer: Allow sub Hz granularity
Message-ID: <20210405172747.1c9913ec@jic23-huawei>
In-Reply-To: <YGSMPTIRAEQRyMWb@mwanda>
References: <YGSMPTIRAEQRyMWb@mwanda>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 31 Mar 2021 17:50:37 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Hello Gwendal Grignou,
> 
> The patch dafcf4ed8392: "iio: hrtimer: Allow sub Hz granularity" from
> Feb 25, 2021, leads to the following static checker warning:
> 
> 	drivers/iio/trigger/iio-trig-hrtimer.c:68 iio_hrtimer_store_sampling_frequency()
> 	warn: assigned value is less than 'u32max'
Coverity + Gustavo spotted this one as well. I've just queued up a fix
based on 1000ULL to ensure the maths is done at appropriate precision.

Thanks,

Jonathan

> 
> drivers/iio/trigger/iio-trig-hrtimer.c
>     49  static
>     50  ssize_t iio_hrtimer_store_sampling_frequency(struct device *dev,
>     51                                               struct device_attribute *attr,
>     52                                               const char *buf, size_t len)
>     53  {
>     54          struct iio_trigger *trig = to_iio_trigger(dev);
>     55          struct iio_hrtimer_info *info = iio_trigger_get_drvdata(trig);
>     56          unsigned long long val;
>     57          u64 period;
>     58          int integer, fract, ret;
>     59  
>     60          ret = iio_str_to_fixpoint(buf, 100, &integer, &fract);
>     61          if (ret)
>     62                  return ret;
>     63          if (integer < 0 || fract < 0)
>     64                  return -ERANGE;
>     65  
>     66          val = fract + 1000 * integer;  /* mHz */
>                       ^^^^^^^^^^^^^^^^^^^^^^
> "fract" and "integer" are integers so the arithmatic will wrap instead
> of going above UINT_MAX
> 
>     67  
>     68          if (!val || val > UINT_MAX)
>                             ^^^^^^^^^^^^^^
> Unpossible!
> 
>     69                  return -EINVAL;
>     70  
>     71          info->sampling_frequency[0] = integer;  /* Hz */
>     72          info->sampling_frequency[1] = fract * 1000;  /* uHz */
>     73          period = PSEC_PER_SEC;
>     74          do_div(period, val);
>     75          info->period = period;  /* nS */
>     76  
>     77          return len;
>     78  }
> 
> regards,
> dan carpenter

