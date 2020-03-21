Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2667918E3A9
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 19:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCUSb7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 21 Mar 2020 14:31:59 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:60720 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgCUSb7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 14:31:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id DEEA79E77F2;
        Sat, 21 Mar 2020 18:31:56 +0000 (GMT)
Date:   Sat, 21 Mar 2020 18:31:54 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add debugfs register r/w
 interface
Message-ID: <20200321183154.128d8920@archlinux>
In-Reply-To: <MN2PR12MB4422876C03060876ACBB4414C4F40@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <5e730c2f.1c69fb81.9eda3.5c70@mx.google.com>
        <CAHp75Vf+SA7ptRQRxvMtVfN0MzQeQ_AgzAP7fc3eaT5nmsxo_g@mail.gmail.com>
        <MN2PR12MB4422876C03060876ACBB4414C4F40@MN2PR12MB4422.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Mar 2020 11:08:44 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hello,
> 
> iio debugfs register interface is quite handy because we can read a single register and write a value.
> 
> regmap debugfs is only a dump of all registers, as far as I know (may have missed something).

So this is something Mark has discussed before around regmap
and more generally IIRC.  The issue is that a write
interface does make it somewhat easy to do really nasty things
in some drivers that use regmap (to the extent of setting boards
on fire etc).  For IIO we are much safer - the worst you can do
is break the IIO driver.

I've never been that fussed myself about the debugfs interfaces
as it's easy to hack them in when needed for actual debugging, but
have taken the view that if someone has enough of a usecase to
want to add them to a particular driver, then it's up to them.

Jonathan

> 
> Thanks.
> JB
> 
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Sent: Thursday, March 19, 2020 11:24
> 
> To: Rohit Sarkar <rohitsarkar5398@gmail.com>
> 
> Cc: linux-iio <linux-iio@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>;
>  Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Linus Walleij <linus.walleij@linaro.org>
> 
> Subject: Re: [PATCH] iio: imu: inv_mpu6050: add debugfs register r/w interface
> 
>  
> 
> 
>  CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> 
> On Thu, Mar 19, 2020 at 8:10 AM Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> 
> >  
> 
> > The iio debugfs interface provides direct access to read and write device  
> 
> > registers if debugfs is enabled.  
> 
> 
> 
> But regmap API provides at least reading facility. Isn't it enough?
> 
> 
> 
> ...
> 
> 
> 
> >  static const struct iio_info mpu_info = {  
> 
> >         .read_raw = &inv_mpu6050_read_raw,  
> 
> >         .write_raw = &inv_mpu6050_write_raw,  
> 
> >         .write_raw_get_fmt = &inv_write_raw_get_fmt,  
> 
> >         .attrs = &inv_attribute_group,  
> 
> >         .validate_trigger = inv_mpu6050_validate_trigger,  
> 
> 
> 
> > +       .debugfs_reg_access = &inv_mpu6050_reg_access  
> 
> 
> 
> Leaving comma is helpful for future development.
> 
> 
> 
> >  };  
> 
> 
> 
> 
> 

