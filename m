Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45E719574A
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 13:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgC0MmZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 08:42:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33009 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgC0MmZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 08:42:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id d17so4534819pgo.0
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2020 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6/5YCNjZbhs7fDAqKSxswEEQ3GsJtkzaU0ERi/T9jdI=;
        b=pDJP439AKcqJEmIiiQaq6fA0FRPNI2TGoJyKDH2QWJoa10+GA1NXAGjCnejn0D8NKh
         E/2YJr5BO60dyTwRyIbQTraOWM/wHXcJQhfixsk8JHm0KHcWzWiL/+UxySN4AzlXhUyW
         5zyn2PgxvZV7jIH6E1I/tKWG45EvUpSg1LTh4KsH1/rt+A1L6Q9065rSnNeB2kcgyRi6
         /DuP99iQwPGPQi9Ne7v2Rt0ElZv6VHuD8LVRdEEOAqJZcf7cNFkYzPvIbBQFJGWflEIH
         3F8b103aJzx5Av32T33KBPtkGJSKySEJXNbx7BGsjoA0/VlCXshGENDUwJ7NdvGLnUB4
         ON0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6/5YCNjZbhs7fDAqKSxswEEQ3GsJtkzaU0ERi/T9jdI=;
        b=TU1G+vM1QrYvIqET3d4OBCPUJaXrgGBqj9elVt569twtu5JApOIwfx2t7vDsTN0Yn2
         XIrPWu1ypClBbXsmwEdtH1dx3LiamQpyfW+fJH/gz0fDk+D8+MeYpbbGFt4TZ/kWjTov
         +nBLwnzBP8ABcVWYteWPFa0yvpbpfIlSdu9ZznoSlgULkU4F9BGjQtSpW0tlxI8aCS4Z
         x+QlnNjtLFRiAd58Kzqe4diDGqHlvmKxUqHpg/A9gdgCVB5/L6V91S7PsoTkh5YvJ/15
         DasfB97solDw04v8oH9LI1HLbGWvsNVCvXcCFWDXFRtOaOOoO1peP6BzxzfGzazdrYKr
         EbuQ==
X-Gm-Message-State: ANhLgQ39DqhiLyWZ+ZeRgOOgjSxB9PLw6XSCtdDtcGlU+sQcZAeT/Fx3
        4M5T8yRg+m3tL1mprswJK96OpgkGO50=
X-Google-Smtp-Source: ADFU+vsV/F21FOaRvO15PNaCzRYH1GWTS74YJq40ErXbKs5RHRa3UictBwXBL6FXeFNsxEgqLuK1ZA==
X-Received: by 2002:a65:6910:: with SMTP id s16mr14604573pgq.426.1585312941765;
        Fri, 27 Mar 2020 05:42:21 -0700 (PDT)
Received: from SARKAR ([106.51.108.92])
        by smtp.gmail.com with ESMTPSA id e14sm4025423pfn.196.2020.03.27.05.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 05:42:21 -0700 (PDT)
Message-ID: <5e7df4ad.1c69fb81.25b38.eec8@mx.google.com>
X-Google-Original-Message-ID: <20200327124217.GA13042@rohitsarkar5398@gmail.com>
Date:   Fri, 27 Mar 2020 18:12:17 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add debugfs register r/w interface
References: <5e730c2f.1c69fb81.9eda3.5c70@mx.google.com>
 <CAHp75Vf+SA7ptRQRxvMtVfN0MzQeQ_AgzAP7fc3eaT5nmsxo_g@mail.gmail.com>
 <MN2PR12MB4422876C03060876ACBB4414C4F40@MN2PR12MB4422.namprd12.prod.outlook.com>
 <20200321183154.128d8920@archlinux>
 <CAHp75VcUtMZDMqizhW=oayvbGcMTZ9M0s=7L0TngkdXz=M49uQ@mail.gmail.com>
 <MN2PR12MB4422EA3CFA8DCFC397502B02C4CC0@MN2PR12MB4422.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR12MB4422EA3CFA8DCFC397502B02C4CC0@MN2PR12MB4422.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 27, 2020 at 10:56:33AM +0000, Jean-Baptiste Maneyrol wrote:
> Hello,
> 
> this is quite useful for me for debugging and testing. So I am in favor.
> 
> Just one comment, I think it is safer here to lock the mutex to ensure this doesn't happen in the middle of an interrupt or anything else.
Sure
> I am waiting for V2.
Will send it asap, was waiting for your ack.
> Thanks for the patch,
> JB
> 
> 
> 
> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Sent: Saturday, March 21, 2020 20:53
> 
> To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
> 
> Cc: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; Rohit Sarkar <rohitsarkar5398@gmail.com>; linux-iio <linux-iio@vger.kernel.org>
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
> On Sat, Mar 21, 2020 at 8:31 PM Jonathan Cameron
> 
> <jic23@jic23.retrosnub.co.uk> wrote:
> 
> > On Thu, 19 Mar 2020 11:08:44 +0000
> 
> > Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
> 
> 
> 
> > > iio debugfs register interface is quite handy because we can read a single register and write a value.
> 
> > >
> 
> > > regmap debugfs is only a dump of all registers, as far as I know (may have missed something).
> 
> >
> 
> > So this is something Mark has discussed before around regmap
> 
> > and more generally IIRC.  The issue is that a write
> 
> > interface does make it somewhat easy to do really nasty things
> 
> > in some drivers that use regmap (to the extent of setting boards
> 
> > on fire etc).  For IIO we are much safer - the worst you can do
> 
> > is break the IIO driver.
> 
> 
> 
> Sometimes IIO driver provides a sensor data about platform facilities,
> 
> such as temperature of the die / chip or battery voltage threshold.
> 
> 
> 
> > I've never been that fussed myself about the debugfs interfaces
> 
> > as it's easy to hack them in when needed for actual debugging, but
> 
> > have taken the view that if someone has enough of a usecase to
> 
> > want to add them to a particular driver, then it's up to them.
> 
> 
> 
> Good to know your p.o.v.!
> 
> 
> 
> -- 
> 
> With Best Regards,
> 
> Andy Shevchenko
> 
