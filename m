Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E9E39A5D5
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 18:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFCQip (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 12:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhFCQip (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 12:38:45 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D16860FE4;
        Thu,  3 Jun 2021 16:36:59 +0000 (UTC)
Date:   Thu, 3 Jun 2021 17:38:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     jic23@cam.ac.uk, linux-iio@vger.kernel.org
Subject: Re: [bug report] staging:iio:sca3000 extract old event handling and
 move to poll for events from buffer
Message-ID: <20210603173842.5d2b1004@jic23-huawei>
In-Reply-To: <YLDbdN688C0xBgMn@mwanda>
References: <YLDbdN688C0xBgMn@mwanda>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 May 2021 15:00:52 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Hello Jonathan Cameron,
> 
> The patch 25888dc51163: "staging:iio:sca3000 extract old event
> handling and move to poll for events from buffer" from May 18, 2011,
> leads to the following static checker warning:
> 
> 	drivers/iio/accel/sca3000.c:734 sca3000_read_raw()
> 	warn: no-op. '((*val) << 19) >> 19'
> 
> drivers/iio/accel/sca3000.c
>    709  static int sca3000_read_raw(struct iio_dev *indio_dev,
>    710                              struct iio_chan_spec const *chan,
>    711                              int *val,
>    712                              int *val2,
>    713                              long mask)
>    714  {
>    715          struct sca3000_state *st = iio_priv(indio_dev);
>    716          int ret;
>    717          u8 address;
>    718  
>    719          switch (mask) {
>    720          case IIO_CHAN_INFO_RAW:
>    721                  mutex_lock(&st->lock);
>    722                  if (chan->type == IIO_ACCEL) {
>    723                          if (st->mo_det_use_count) {
>    724                                  mutex_unlock(&st->lock);
>    725                                  return -EBUSY;
>    726                          }
>    727                          address = sca3000_addresses[chan->address][0];
>    728                          ret = sca3000_read_data_short(st, address, 2);
>    729                          if (ret < 0) {
>    730                                  mutex_unlock(&st->lock);
>    731                                  return ret;
>    732                          }
>    733                          *val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
>    734                          *val = ((*val) << (sizeof(*val) * 8 - 13)) >>
>                                                   ^^^^^^^^^^^^^^^^^^^^^^^
>    735                                  (sizeof(*val) * 8 - 13);
>                                         ^^^^^^^^^^^^^^^^^^^^^^^
> 
> This code works, but it relies on undefined behavior of left shift
> overflow and it's very unsatisfying.  Pretty sure there is a UBSan
> warning for this at runtime.

Thanks Dan.  Looks like a slightly odd variant on open coded sign_extend32()
Should be fine to replace with

*val = sign_extend32(*val, 13);

What can I say, I wrote this a long time ago when I was young and stupid :)

Anyhow, I'll roll a patch to do that shortly.

Jonathan


> 
>    736                  } else {
>    737                          /* get the temperature when available */
>    738                          ret = sca3000_read_data_short(st,
>    739                                                        SCA3000_REG_TEMP_MSB_ADDR,
>    740                                                        2);
>    741                          if (ret < 0) {
>    742                                  mutex_unlock(&st->lock);
>    743                                  return ret;
>    744                          }
>    745                          *val = ((st->rx[0] & 0x3F) << 3) |
>    746                                 ((st->rx[1] & 0xE0) >> 5);
>    747                  }
>    748                  mutex_unlock(&st->lock);
>    749                  return IIO_VAL_INT;
> 
> regards,
> dan carpenter

